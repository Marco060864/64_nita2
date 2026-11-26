forward
global type w_conto_ff from w_p_data
end type
type cb_3 from commandbutton within w_conto_ff
end type
type cb_1 from commandbutton within w_conto_ff
end type
type cb_2 from commandbutton within w_conto_ff
end type
type cb_sog_commerciale from commandbutton within w_conto_ff
end type
type dw_conto_ff from u_dw_master_main within w_conto_ff
end type
end forward

global type w_conto_ff from w_p_data
int Width=2281
int Height=860
boolean TitleBar=true
string Title="Conto"
cb_3 cb_3
cb_1 cb_1
cb_2 cb_2
cb_sog_commerciale cb_sog_commerciale
dw_conto_ff dw_conto_ff
end type
global w_conto_ff w_conto_ff

type variables
u_dw_main pippo

end variables

forward prototypes
public function long uf_calcola_codice (integer la_id_mastro, integer la_id_sottomastro)
end prototypes

public function long uf_calcola_codice (integer la_id_mastro, integer la_id_sottomastro);

DataWindowChild ldwc_id_mastro, ldwc_id_sottomastro
long ll_Curr_Row, ll_num_codice, ll_conto_codice, ll_id_mastro, ll_id_sottomastro
string ls_cod_mastro, ls_cod_sottomastro, ls_cod_ms, ls_conto_codice, ls_num_codice, ls_dddw_name1, ls_dddw_name2

ll_Curr_Row = dw_conto_ff.GetRow()
 if not (IsNull(la_id_mastro) OR IsNull(la_id_sottomastro)) then
	 SELECT "mastro"."codice",   
				"sottomastro"."codice"  
		 INTO :ls_cod_mastro,   
				:ls_cod_sottomastro  
		 FROM "mastro",   
				"sottomastro"  
		WHERE ( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
			
				( "sottomastro"."id_sottomastro" = :la_id_sottomastro )    ;
	
	IF (ls_cod_mastro <> "" AND ls_cod_sottomastro <> "") THEN
		ls_cod_ms = (ls_cod_mastro + ls_cod_sottomastro)
		SELECT Max(Convert(Numeric, Right("dba"."conto"."codice", 4)))
			INTO :ll_conto_codice
			FROM "dba"."conto"
			WHERE Left("dba"."conto"."codice", 4) = :ls_cod_ms;
			
			if isnull(ll_conto_codice) then ll_conto_codice=0
			
			ll_conto_codice = ll_conto_codice + 1
			ls_num_codice = f_LPad(string(ll_conto_codice), "0", 4)
	else
		ls_num_codice=""
	END IF
else
	ls_num_codice=""
END IF
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			dw_conto_ff.SetItem(ll_Curr_Row, "c_codice", ls_num_codice)
			dw_conto_ff.SetItem(ll_Curr_Row, "conto_codice",ls_cod_mastro + ls_cod_sottomastro + ls_num_codice)
	END CHOOSE

return 0

end function

on w_conto_ff.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_sog_commerciale=create cb_sog_commerciale
this.dw_conto_ff=create dw_conto_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_sog_commerciale
this.Control[iCurrent+5]=this.dw_conto_ff
end on

on w_conto_ff.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_sog_commerciale)
destroy(this.dw_conto_ff)
end on

event open;call super::open;
il_HelpTopic = 597

idw_master = dw_conto_ff
idw_master.is_list = Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "conto.id_conto"
	idw_master.is_list.s_modo = modo_inserisci	
	ib_nonmodale=true
END IF



idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "conto.id_conto"
end event

type p_crescente from w_p_data`p_crescente within w_conto_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_conto_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_conto_ff
boolean BringToTop=true
end type

event cb_ok::clicked;call super::clicked;
end event

type cb_annulla from w_p_data`cb_annulla within w_conto_ff
int X=366
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_conto_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_conto_ff
int TabOrder=60
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_conto_ff
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_conto_ff
int X=1943
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_conto_ff
int X=1829
int Y=1180
int Width=549
int Height=300
int TabOrder=40
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=512
int Height=180
end type

type cb_ricerca from w_p_data`cb_ricerca within w_conto_ff
boolean BringToTop=true
end type

event cb_ricerca::clicked;	s_ric_param controllo
	boolean lb_inizializza
	long ll_prova
	string ls_filtro,ls_codice
	
	w_search_main lw_sm
	ls_codice=""
	idw_master.is_ricpar.s_filter_value=ls_codice
	idw_master.is_ricpar.s_filter_name="conto_codice"
	controllo=idw_master.is_ricpar
	openwithparm(lw_sm,idw_master.is_ricpar,"w_conto_sw")
	idw_master.is_ricpar=message.powerobjectparm
	if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
		ll_prova=long(idw_master.is_ricpar.s_id_seg_value[1])
		idw_master.is_list.s_modo=modo_modifica
		idw_master.is_list.s_identifica[1]="conto_id_conto"
		idw_master.is_list.l_identifica[1]=ll_prova
		idw_master.event ue_retrieve(0,0)
		idw_master.setfocus()
	end if
end event

type cb_3 from commandbutton within w_conto_ff
int X=1623
int Y=44
int Width=261
int Height=84
int TabOrder=70
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_conto_ff.deleterow(0)
ib_askforsave=false
cb_salva.triggerevent(clicked!)
dw_conto_ff.insertrow(0)
end event

type cb_1 from commandbutton within w_conto_ff
int X=1970
int Y=204
int Width=201
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Nuovo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window aw_window
s_list_main ls_mia,ls_app
OpenSheetWithParm(aw_window, ls_mia, "w_pdc_lt", w_app_frame, 0, Original!)

end event

type cb_2 from commandbutton within w_conto_ff
int X=1970
int Y=308
int Width=201
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Nuovo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window aw_window
s_list_main ls_mia,ls_app
OpenSheetWithParm(aw_window, ls_mia, "w_pdc_lt", w_app_frame, 0, Original!)

end event

type cb_sog_commerciale from commandbutton within w_conto_ff
int X=1573
int Y=508
int Width=590
int Height=84
boolean Visible=false
boolean BringToTop=true
string Text="&Soggetto Commerciale"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_CurrRow, ll_IDConto, ll_IDSog_Commerciale
dwItemStatus l_status

s_list_main lstr_list


ll_CurrRow = dw_conto_ff.GetRow()
l_status = dw_conto_ff.GetItemStatus(ll_CurrRow, 0, Primary!)

IF l_status <> New! AND l_status <> NewModified! THEN
	ll_IDConto = dw_conto_ff.GetItemNumber(ll_CurrRow, "conto_id_conto")
	SELECT "dba"."sog_commerciale"."id_sog_commerciale"
		INTO :ll_IDSog_Commerciale
		FROM "dba"."sog_commerciale"
		WHERE "dba"."sog_commerciale"."id_conto" = :ll_IDConto;
	
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			lstr_list.s_modo = modo_modifica
			lstr_list.s_identifica[1] = "id_sog_commerciale"
			lstr_list.l_identifica[1] = ll_IDSog_Commerciale

			OpenWithParm(w_sog_commerciale_cx, lstr_list)
		CASE 100
			MessageBox("Conto","Il conto non è associato ad alcun Soggetto Commerciale")
		CASE -1
			MessageBox("","Errore di lettura sul DataBase")
	END CHOOSE
	dw_conto_ff.SetFocus()
END IF


end event

type dw_conto_ff from u_dw_master_main within w_conto_ff
int X=69
int Y=180
int Width=2126
int Height=564
int TabOrder=10
string DataObject="d_conto_ff"
end type

event ue_init;call super::ue_init;is_title = "Conto"
is_list.s_identifica[1]="conto_id_conto"
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_gruppo_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_gruppo_gd"
		is_ricpar.s_titolo_finestra = "Gruppi di Conti"
		is_ricpar.s_ausil_value[1] = "id_gruppo_des"
		is_ricpar.i_width = 3000
		is_ricpar.i_height = 900
	CASE "id_gruppo_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_gruppo_gd"
		is_ricpar.s_titolo_finestra = "Gruppi di Conti"
		is_ricpar.s_ausil_value[1] = "id_gruppo_cod"
		is_ricpar.i_width = 3000
		is_ricpar.i_height = 900
		
	CASE "bilancio_cee_riferimento"
		is_search_window = "w_bilancio_cee_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "riferimento"
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE

end event

event itemfocuschanged;call super::itemfocuschanged;

datawindowchild ldwc_sottomastro_cod, ldwc_sottomastro_des
long ll_Curr_Row, ll_id
string ls_filter

ll_Curr_Row = THIS.GetRow()

THIS.GetChild("id_sottomastro_cod", ldwc_sottomastro_cod)
THIS.GetChild("id_sottomastro_des", ldwc_sottomastro_des)

CHOOSE CASE dwo.name
	CASE "id_sottomastro_cod", "id_sottomastro_des"
		IF ll_Curr_Row > 0 THEN
			ll_id = THIS.GetItemNumber(ll_Curr_Row, "id_mastro_cod")
			IF NOT IsNull(ll_id) THEN
				ls_filter = "sottomastro_id_mastro = " + string(ll_id)
				ldwc_sottomastro_cod.SetFilter(ls_filter)
				ldwc_sottomastro_cod.Filter()
				ldwc_sottomastro_des.SetFilter(ls_filter)
				ldwc_sottomastro_des.Filter()
			ELSE
				ls_filter = ""
				ldwc_sottomastro_cod.SetFilter(ls_filter)
				ldwc_sottomastro_cod.Filter()
				ldwc_sottomastro_des.SetFilter(ls_filter)
				ldwc_sottomastro_des.Filter()
			
			END IF
		END IF
		
END CHOOSE

end event

event ue_keystop;

RETURN 0
end event

event ue_default;call super::ue_default;

DataWindowChild ldwc_id_mastro, ldwc_id_sottomastro
long ll_Curr_Row, ll_num_codice, ll_conto_codice, ll_id_mastro, ll_id_sottomastro
string ls_cod_mastro, ls_cod_sottomastro, ls_cod_ms, ls_conto_codice, ls_num_codice, ls_dddw_name1, ls_dddw_name2

ll_Curr_Row = THIS.GetRow()

CHOOSE CASE adwo_current.name
	CASE "c_codice"
		ll_id_mastro=GetItemNumber(ll_Curr_Row, "id_mastro_des")
		ll_id_sottomastro=GetItemNumber(ll_Curr_Row, "id_sottomastro_des")
		uf_calcola_codice(ll_id_mastro, ll_id_sottomastro)
	
END CHOOSE
end event

event itemchanged;if dwo.name='id_mastro_cod' then
	long ll_id_mastro
	string ls_cod,ls_c1,ls_c2,ls_c3,ls_c4,ls_c5
	u_dw_master_main luo_master
	luo_master= create u_dw_master_main
	ll_id_mastro=long(data)
	select codice
	into :ls_cod
	from mastro
	where id_mastro=:ll_id_mastro;
	if sqlca.sqlcode=0 then
		select pref_cod_cliente,pref_cod_fornitore,pref_cod_agente,pref_cod_vettore,pref_cod_cliente_potenziale
		into :ls_c1,:ls_c2,:ls_c3,:ls_c4,:ls_c5
		from par_sistema;
		CHOOSE CASE ls_cod
			CASE ls_c1
				luo_master.is_list.s_win_parametri='C'
				
				
				OpenWithParm(w_anag_2_cx,luo_master.is_list)
				
				destroy luo_master
				dw_conto_ff.deleterow(row)
				dw_conto_ff.postevent("ue_insert")	
				close(parent)
				return 0
			CASE ls_c2
				luo_master.is_list.s_win_parametri='F'
				
				
				OpenWithParm(w_anag_2_cx,luo_master.is_list)
				
				destroy luo_master
				dw_conto_ff.deleterow(row)
				dw_conto_ff.postevent("ue_insert")	
				close(parent)
				return 0
			CASE ls_c3
				luo_master.is_list.s_win_parametri='A'
				OpenWithParm(w_sog_commerciale_cx,luo_master.is_list)
				destroy luo_master
				dw_conto_ff.deleterow(row)
				dw_conto_ff.postevent("ue_insert")	
				close(parent)
				return 0
			CASE ls_c4
				luo_master.is_list.s_win_parametri='V'
				OpenWithParm(w_sog_commerciale_cx,luo_master.is_list)
				destroy luo_master
				dw_conto_ff.deleterow(row)
				dw_conto_ff.postevent("ue_insert")	
				close(parent)
				return 0
			CASE ls_c5
				luo_master.is_list.s_win_parametri='P'
				OpenWithParm(w_sog_commerciale_cx,luo_master.is_list)		
				destroy luo_master
				dw_conto_ff.deleterow(row)
				dw_conto_ff.postevent("ue_insert")	
				close(parent)
				return 0
		END CHOOSE
	end if
end if




long ll_mastro, ll_sottomastro
string ls_filter, ls_codice
datawindowchild ldwc_sottomastro_cod, ldwc_sottomastro_des
THIS.GetChild("id_sottomastro_cod", ldwc_sottomastro_cod)
THIS.GetChild("id_sottomastro_des", ldwc_sottomastro_des)
CHOOSE CASE dwo.name
	CASE "id_sottomastro_cod", "id_sottomastro_des"
			SetNull(ll_mastro)
			uf_set_colval("id_mastro_des", String(ll_mastro))
			ll_sottomastro= Long(data)
			If not (IsNull(ll_sottomastro) OR ll_sottomastro=0 ) then
				  SELECT "sottomastro"."id_mastro"  
					 INTO :ll_mastro  
					 FROM "sottomastro"  
					WHERE "sottomastro"."id_sottomastro" = :ll_sottomastro   ;
					uf_set_colval("id_mastro_des", String(ll_mastro))
					ls_filter = "sottomastro_id_mastro = " + string(ll_mastro)
					
					uf_calcola_codice(ll_mastro,ll_sottomastro)
			end if
	CASE "id_mastro_cod", "id_mastro_des"
		SetNull(ll_sottomastro)
		uf_set_colval("id_sottomastro_des", String(ll_sottomastro))
		if IsNull(data) then
			ldwc_sottomastro_cod.SetFilter("")
			ldwc_sottomastro_cod.Filter()
			ldwc_sottomastro_des.SetFilter("")
			ldwc_sottomastro_des.Filter()
			uf_calcola_codice(Long(data), ll_sottomastro)
		end if
	CASE "c_codice"
		ls_codice= uf_get_colval("conto_codice")
		ls_codice= Mid(ls_codice, 1, 4) + f_LPad(string(data), "0", 4)
		uf_set_colval("conto_codice", ls_codice)
		
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "bilancio_cee_riferimento"
		uf_set_colval("conto_id_bilancio_cee", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
END CHOOSE
end event

