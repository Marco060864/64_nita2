forward
global type w_ratei_lt from w_np_single_data
end type
type cb_ratei from commandbutton within w_ratei_lt
end type
type cb_2 from commandbutton within w_ratei_lt
end type
type cb_3 from commandbutton within w_ratei_lt
end type
type cb_4 from commandbutton within w_ratei_lt
end type
type cb_1 from commandbutton within w_ratei_lt
end type
end forward

global type w_ratei_lt from w_np_single_data
int X=590
int Y=828
int Width=3086
int Height=1028
boolean TitleBar=true
string Title="Lista Ratei"
cb_ratei cb_ratei
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_1 cb_1
end type
global w_ratei_lt w_ratei_lt

on w_ratei_lt.create
int iCurrent
call super::create
this.cb_ratei=create cb_ratei
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ratei
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_1
end on

on w_ratei_lt.destroy
call super::destroy
destroy(this.cb_ratei)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_1)
end on

event resize;
end event

event ue_insert;
end event

event open;call super::open;dw_single.retrieve()
end event

type p_crescente from w_np_single_data`p_crescente within w_ratei_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_ratei_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_ratei_lt
int X=50
int Y=44
int Width=2967
int TabOrder=10
string DataObject="d_ratei_lt"
end type

event dw_single::doubleclicked;call super::doubleclicked;long ll_riga, ll_num

ll_riga = dw_single.getrow()
ll_num = dw_single.getitemnumber (ll_riga, 'num_progressivo')

messagebox ('recupera', ll_num)

end event

event dw_single::ue_insert;

end event

event dw_single::ue_set_search;

CHOOSE CASE as_nomecol
		CASE "conto_a_codice"
			is_search_window = "w_conto_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
			is_ricpar.s_sql_cond = ""
			
			is_ricpar.b_imm_retrieve = TRUE
		CASE "conto_a_descrizione"
			is_search_window = "w_conto_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
			is_ricpar.s_sql_cond = ""
			is_ricpar.b_imm_retrieve = TRUE
			CASE "conto_b_codice"
			is_search_window = "w_conto_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
	is_ricpar.s_sql_cond = ""
	
			is_ricpar.b_imm_retrieve = TRUE
		CASE "conto_b_descrizione"
			is_search_window = "w_conto_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
			is_ricpar.s_sql_cond = ""
			
			is_ricpar.b_imm_retrieve = TRUE
	END CHOOSE
	
	
	

end event

event dw_single::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "conto_a_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rif_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_a_descrizione", is_ricpar.s_ausil_value[1])

	CASE "conto_a_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rif_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_a_codice", is_ricpar.s_ausil_value[1])
		
	CASE "conto_b_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rif_intestatario", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_b_descrizione", is_ricpar.s_ausil_value[1])

	CASE "conto_b_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rif_intestatario", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_b_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event dw_single::itemchanged;

long ll_riga, ll_id_ges_ratei_risconti
decimal ld_flag_rat_ris

IF dwo.name="flag_rat_ris" THEN
        ll_riga=this.getrow()
		  ll_id_ges_ratei_risconti=this.getitemnumber(ll_riga,"id_ges_ratei_risconti")
		  this.setitem(ll_riga,"quota_bloc",'S')
		  if not isnull(ll_id_ges_ratei_risconti) then
			  
			  ld_flag_rat_ris=dec(data)
			  UPDATE ges_ratei_risconti
				  SET quota_bloc='S',
						flag_rat_ris=:ld_flag_rat_ris
				WHERE id_ges_ratei_risconti=:ll_id_ges_ratei_risconti;
				this.retrieve()
				this.ScrollToRow (ll_riga)
				THIS.SetColumn ( "flag_rat_ris" )
		  end if
END IF


string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""  
CHOOSE CASE dwo.name
	CASE 'conto_b_codice'
		ls_sql_cond = ""  
		ls_dbc[1]  = "codice"
		ls_dwc[1]  = "conto_b_codice"
		ls_dbc[2]  = "descrizione"
		ls_dwc[2]  = "conto_b_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

   CASE 'conto_b_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1]  = "codice"
		ls_dwc[1]  = "conto_b_codice"
		ls_dbc[2]  = "descrizione"
		ls_dwc[2]  = "conto_b_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'conto_a_codice'
		ls_sql_cond = ""  
		ls_dbc[1]  = "codice"
		ls_dwc[1]  = "conto_a_codice"
		ls_dbc[2]  = "descrizione"
		ls_dwc[2]  = "conto_a_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

   CASE 'conto_a_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1]  = "codice"
		ls_dwc[1]  = "conto_a_codice"
		ls_dbc[2]  = "descrizione"
		ls_dwc[2]  = "conto_a_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
end choose		
end event

type cb_ratei from commandbutton within w_ratei_lt
int X=64
int Y=772
int Width=503
int Height=96
int TabOrder=20
boolean BringToTop=true
string Text="Calcola Ratei"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_id_rateo
decimal ld_importo_doc, ld_giorni1, ld_giorni2, ld_rateo
date ld_data_in_comp, ld_data_fin_comp, ld_data_mezzo


 DECLARE ratei_risconti_cur CURSOR FOR  
  SELECT "ges_ratei_risconti"."id_ges_ratei_risconti",
  			"ges_ratei_risconti"."importo_doc",   
         "ges_ratei_risconti"."data_in_comp",   
         "ges_ratei_risconti"."data_fin_comp"  
    FROM "ges_ratei_risconti"  
   WHERE "ges_ratei_risconti"."quota_bloc" = 'N' AND
			"ges_ratei_risconti"."tipo_record" = 'T';

OPEN ratei_risconti_cur;

FETCH ratei_risconti_cur INTO :ll_id_rateo,:ld_importo_doc,:ld_data_in_comp, :ld_data_fin_comp;

DO WHILE SQLCA.SQLCODE=0 
	
	ld_giorni1=DaysAfter(ld_data_in_comp,ld_data_fin_comp)
	
	
	
	ld_data_mezzo=date("31/12/"+string(integer(year(ld_data_in_comp))))
	ld_giorni2=DaysAfter(ld_data_in_comp,ld_data_mezzo)
	
	
	
	ld_rateo=ld_importo_doc*ld_giorni2/ld_giorni1
	
	
	 UPDATE "ges_ratei_risconti"  
       SET "flag_rat_ris" = :ld_rateo 
     WHERE "ges_ratei_risconti"."id_ges_ratei_risconti" = :ll_id_rateo  ;

	
   FETCH ratei_risconti_cur INTO :ll_id_rateo,:ld_importo_doc,:ld_data_in_comp, :ld_data_fin_comp;
LOOP

CLOSE ratei_risconti_cur;
dw_single.retrieve()


end event

type cb_2 from commandbutton within w_ratei_lt
int X=645
int Y=772
int Width=503
int Height=96
int TabOrder=50
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_newrow

ll_newrow = dw_single.InsertRow(0) 
dw_single.ScrollToRow(ll_newrow)
dw_single.SetColumn ( "conto_b_codice" )
dw_single.setitem(ll_newrow,"tipo_record",'T')


end event

type cb_3 from commandbutton within w_ratei_lt
int X=1920
int Y=772
int Width=503
int Height=96
int TabOrder=40
boolean BringToTop=true
string Text="Genera Scritture "
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


OpenWithParm(w_risconto_ff,"Rateo")

dw_single.retrieve()
end event

type cb_4 from commandbutton within w_ratei_lt
int X=2510
int Y=772
int Width=503
int Height=96
int TabOrder=30
boolean BringToTop=true
string Text="Genera Storno"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


OpenWithParm(w_risconto_ff,"Storno Rateo")

dw_single.retrieve()
end event

type cb_1 from commandbutton within w_ratei_lt
int X=1239
int Y=772
int Width=503
int Height=96
int TabOrder=51
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;INTEGER LI_RET	
li_ret=dw_single.update()

if li_ret<>1 then messagebox("Errore", "Salvataggio non riuscito!")

end event

