forward
global type w_reg_pd_mn_pn_ff from w_wiz_main
end type
type cb_annulla from commandbutton within w_reg_pd_mn_pn_ff
end type
type cb_ok from commandbutton within w_reg_pd_mn_pn_ff
end type
type dw_reg_pd_mn_pn_ff from u_dw_ext_main within w_reg_pd_mn_pn_ff
end type
end forward

global type w_reg_pd_mn_pn_ff from w_wiz_main
int X=833
int Y=361
int Width=2350
int Height=829
WindowType WindowType=response!
boolean TitleBar=true
string Title="Contabilizzazione Registrazioni Manageriali"
event ue_feed_structure ( boolean ab_feed )
cb_annulla cb_annulla
cb_ok cb_ok
dw_reg_pd_mn_pn_ff dw_reg_pd_mn_pn_ff
end type
global w_reg_pd_mn_pn_ff w_reg_pd_mn_pn_ff

type variables
s_contabilizzazione is_parm
end variables

event ue_feed_structure;

long ll_CurrRow

ll_CurrRow = dw_reg_pd_mn_pn_ff.GetRow()

IF ab_feed = TRUE AND ll_CurrRow > 0 THEN

	is_parm.l_id_prof_registrazione = dw_reg_pd_mn_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
	is_parm.l_id_registro           = dw_reg_pd_mn_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")
	is_parm.d_data_registrazione    = dw_reg_pd_mn_pn_ff.GetItemDate(ll_CurrRow, "data_registrazione")
	is_parm.d_data_competenza       = dw_reg_pd_mn_pn_ff.GetItemDate(ll_CurrRow, "data_competenza")	
ELSE
	is_parm.l_id_prof_registrazione = u_freddie.gl_NULL
	is_parm.l_id_registro           = u_freddie.gl_NULL
	is_parm.d_data_registrazione    = u_freddie.gd_NULL
	is_parm.d_data_competenza       = u_freddie.gd_NULL
END IF
end event

on w_reg_pd_mn_pn_ff.create
int iCurrent
call w_wiz_main::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_reg_pd_mn_pn_ff=create dw_reg_pd_mn_pn_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_annulla
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=dw_reg_pd_mn_pn_ff
end on

on w_reg_pd_mn_pn_ff.destroy
call w_wiz_main::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_reg_pd_mn_pn_ff)
end on

event closequery;Message.PowerObjectParm = is_parm
end event

event open;call super::open;il_HelpTopic = 29
dw_reg_pd_mn_pn_ff.TriggerEvent("ue_post_open")
end event

type cb_annulla from commandbutton within w_reg_pd_mn_pn_ff
int X=366
int Y=41
int Width=261
int Height=85
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Parent.Event ue_feed_structure(FALSE)
CloseWithReturn(Parent, is_parm)
end event

type cb_ok from commandbutton within w_reg_pd_mn_pn_ff
event clicked pbm_bnclicked
int X=46
int Y=41
int Width=275
int Height=85
boolean BringToTop=true
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Parent.Event ue_feed_structure(TRUE)

Close(Parent)


end event

type dw_reg_pd_mn_pn_ff from u_dw_ext_main within w_reg_pd_mn_pn_ff
int X=46
int Y=161
int Width=2263
int Height=541
int TabOrder=30
string DataObject="d_reg_pd_mn_pn_ff"
end type

event ue_set_search;call super::ue_set_search;

long ll_IDProf_Registrazione
string ls_tipo_registrazione

CHOOSE CASE as_nomecol
	CASE "prof_registrazione_cod", "prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw"

		IF as_nomecol = "prof_registrazione_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "prof_registrazione_des" THEN
			is_ricpar.s_filter_value = uf_get_colval("prof_registrazione_des")
			is_ricpar.s_filter_name = "descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE

		is_ricpar.s_SQL_cond = "tipo_registrazione ='P'"
	CASE "des_registro"
		is_search_window = "w_registro_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "registro_descrizione"
		is_ricpar.b_imm_retrieve  = TRUE
		
		ll_IDProf_Registrazione = THIS.GetItemNumber(THIS.GetRow(), "id_prof_registrazione")
		SELECT "dba"."prof_registrazione"."tipo_registrazione"
			INTO :ls_tipo_registrazione
			FROM "dba"."prof_registrazione"
			WHERE "dba"."prof_registrazione"."id_prof_registrazione" = :ll_IDProf_Registrazione;
		
		IF SQLCA.SQLCode < 0 THEN 
			MessageBox("Errore sul Database", "dw_reg_pd_mn_pn_ff / ue_set_search / 1")
			RETURN
		END IF
		
		is_ricpar.s_SQL_cond = "tipo_registro = 'PN'"
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;

long ll_CurrRow_Reg_PD
dwItemStatus l_status

ll_CurrRow_Reg_PD = THIS.GetRow()
l_status = THIS.GetItemStatus(ll_CurrRow_Reg_PD, 0, Primary!)

CHOOSE CASE as_nomecol
	CASE "prof_registrazione_cod"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])		
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_des", is_ricpar.s_ausil_value[1])

		
		
		IF l_status = New! OR l_status = NewModified! THEN
			uf_Set_ColVal("des_registro", u_freddie.gs_Null)
			uf_Set_ColVal("id_registro", u_freddie.gs_Null)			
			uf_Set_ColVal("cinfo_registro", u_freddie.gs_Null)						
			
			uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
			uf_Set_ColVal("data_competenza", u_freddie.gs_Null)			
		END IF

	CASE "prof_registrazione_des"		
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				

		uf_set_colval(as_nomecol, is_ricpar.s_main_value)		
		uf_set_colval("prof_registrazione_cod", is_ricpar.s_ausil_value[1])		

		
		
		IF l_status = New! OR l_status = NewModified! THEN
			uf_Set_ColVal("des_registro", u_freddie.gs_Null)
			uf_Set_ColVal("id_registro", u_freddie.gs_Null)			
			uf_Set_ColVal("cinfo_registro", u_freddie.gs_Null)						
			
			uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
			uf_Set_ColVal("data_competenza", u_freddie.gs_Null)			
		END IF
		
	CASE "des_registro"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		
		uf_set_colval("cinfo_registro", "Esercizio: " + string(is_ricpar.s_ausil_value[1]) + " - " + &
												  "Tipo: " + string(is_ricpar.s_ausil_value[2]) + " - " + &
												  "Num.: " + string(is_ricpar.s_ausil_value[3]))

		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		
		
		
		IF l_status = New! OR l_status = NewModified! THEN
			
			uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
			uf_Set_ColVal("data_competenza", u_freddie.gs_Null)			
		END IF
END CHOOSE
end event

event getfocus;call super::getfocus;

long LL_ID_AZIENDA, ll_id_esercizio, ll_CurrRow
dwItemStatus l_status
LL_ID_AZIENDA = 1


IF NOT THIS.GetRow() > 0 THEN 
	THIS.InsertRow(0)
	ll_CurrRow = THIS.GetRow()
	
	SELECT "dba"."azienda"."id_esercizio"  
		INTO :ll_id_esercizio  
		FROM "dba"."azienda"  
		WHERE "dba"."azienda"."id_azienda" = :LL_ID_AZIENDA   ;
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			IF IsNull(ll_id_esercizio) OR ll_id_esercizio = 0 THEN
				MessageBox("Contabilizzazione Registrazioni Manageriali", "Attenzione: Non è stato impostato l'esercizio contabile~rper l'azienda corrente.")
				RETURN 0
			ELSE
				dw_reg_pd_mn_pn_ff.SetItem(ll_CurrRow, "id_esercizio", ll_id_esercizio)
			END IF
		CASE -1
			MessageBox("Errore sul DataBase","dw_reg_pd_mn_pn_ff / getfocus / 1")
	END CHOOSE
	
END IF
end event

event itemfocuschanged;call super::itemfocuschanged;

long ll_IDRegistro, ll_ID_Prof_Reg, ll_min_num_registro, ll_CurrRow, ll_Cur_IDRegistro
string ls_descrizione_registro, ls_par_menu, ls_cod_esercizio, ls_cur_des_registro,ls_prog_scritture
date ld_cur_data_registrazione

ll_CurrRow = dw_reg_pd_mn_pn_ff.GetRow()
ll_ID_Prof_Reg = dw_reg_pd_mn_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
ll_Cur_IDRegistro = dw_reg_pd_mn_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")
SELECT "esercizio"."prog_scritture"  
INTO :ls_prog_scritture  
FROM "esercizio",   
	  "registro"  
WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
		( ( "registro"."id_registro" = :ll_Cur_IDRegistro ) )   ;

CHOOSE CASE string(dwo.name)
	CASE "des_registro"
		ls_cur_des_registro = dw_reg_pd_mn_pn_ff.GetItemString(ll_CurrRow, "des_registro")
		IF IsNull(ls_cur_des_registro) THEN
			ll_IDRegistro = f_proponi_registro(ll_ID_Prof_Reg, u_freddie.gl_NULL)
			IF ll_IDRegistro > 0 THEN
				
				  SELECT "registro"."descrizione",   
							"registro"."tipo_registro",   
							"registro"."numero",   
							"esercizio"."codice"  
					 INTO :ls_descrizione_registro,   
							:ls_par_menu,   
							:ll_min_num_registro,   
							:ls_cod_esercizio  
					 FROM "esercizio",   
							"registro"  
					WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
							( ( "registro"."id_registro" = :ll_IDRegistro ) )   ;
	
				
				dw_reg_pd_mn_pn_ff.SetItem(ll_CurrRow, "id_registro", ll_IDRegistro)			
				dw_reg_pd_mn_pn_ff.SetItem(ll_CurrRow, "des_registro", ls_descrizione_registro)
	
				
				
	

				uf_set_colval("cinfo_registro", "Tipo: " + ls_Par_Menu + " - " + &
														  "Numero: " + string(ll_Min_Num_Registro))			
	
			ELSE
				MessageBox("Contabilizzazione Registrazioni Manageriali", "Attenzione: il registro impostato nel profilo~rnon esiste per l'esercizio selezionato.")
			END IF
														  
		END IF
	CASE "data_registrazione"
		ld_cur_data_registrazione = dw_reg_pd_mn_pn_ff.GetItemDate(ll_CurrRow, "data_registrazione")
		IF IsNull(ld_cur_data_registrazione) THEN
			dw_reg_pd_mn_pn_ff.SetItem(ll_CurrRow, "data_registrazione", f_proponi_data_reg_pd(ll_Cur_IDRegistro,ls_prog_scritture))
			dw_reg_pd_mn_pn_ff.SetItem(ll_CurrRow, "data_competenza", f_proponi_data_reg_pd(ll_Cur_IDRegistro,ls_prog_scritture))
		END IF
END CHOOSE
end event

event doubleclicked;call super::doubleclicked;

CHOOSE CASE dwo.name
	CASE "id_esercizio"
		THIS.Object.id_esercizio.Protect = 0
		THIS.SetColumn("id_esercizio")				
END CHOOSE

end event

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_esercizio"
end event

