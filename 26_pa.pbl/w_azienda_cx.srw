forward
global type w_azienda_cx from w_p_data
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_2 from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_3 from userobject within tab_1
end type
type dw_4 from u_dw_master_main within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_4 from userobject within tab_1
end type
type dw_5 from u_dw_master_main within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_5 dw_5
end type
end forward

global type w_azienda_cx from w_p_data
integer width = 3584
integer height = 2308
string title = "Gestione Azienda"
end type
global w_azienda_cx w_azienda_cx

type variables
string is_title_modifica
end variables

on w_azienda_cx.create
int iCurrent
call super::create
end on

on w_azienda_cx.destroy
call super::destroy
end on

event open;call super::open;
il_HelpTopic = 71

idw_master = tab_1.tabpage_1.dw_1
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "azienda.id_azienda"

u_debug.uf_log_open ("c:\tmp\w_azienda.log",1,false)
u_debug.uf_log_msg (1,"")
u_debug.uf_log_msg (1,"_____________________________________________________")
u_debug.uf_log_msg (1,"Inizio sessione...")
u_debug.uf_log_msg (1,"")

end event

event close;call super::close;u_debug.uf_log_close(1)

end event

type p_msg_log from w_p_data`p_msg_log within w_azienda_cx
end type

type p_crescente from w_p_data`p_crescente within w_azienda_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_azienda_cx
end type

type cb_ok from w_p_data`cb_ok within w_azienda_cx
end type

type cb_annulla from w_p_data`cb_annulla within w_azienda_cx
end type

type cb_nuovo from w_p_data`cb_nuovo within w_azienda_cx
end type

type cb_inserisci from w_p_data`cb_inserisci within w_azienda_cx
integer x = 2057
end type

type cb_cancella from w_p_data`cb_cancella within w_azienda_cx
integer x = 2354
end type

type cb_salva from w_p_data`cb_salva within w_azienda_cx
integer x = 2647
end type

type tab_1 from w_p_data`tab_1 within w_azienda_cx
integer x = 27
integer y = 148
integer width = 3511
integer height = 2020
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 3474
integer height = 1900
long backcolor = 79741120
string text = "Generale"
long tabbackcolor = 79741120
dw_1 dw_1
dw_2 dw_2
end type

on tabpage_1.create
this.dw_1=create dw_1
this.dw_2=create dw_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_azienda_cx
end type

type dw_1 from u_dw_master_main within tabpage_1
integer x = 5
integer y = 36
integer width = 3442
integer height = 1332
integer taborder = 3
string dataobject = "d_azienda_generale_ff"
end type

event ue_init;call super::ue_init;window 	lw_parent
tab    	lw_tab

is_list.s_identifica[1] = "id_azienda"
iudw_children[1] = tab_1.tabpage_1.dw_2
iudw_children[2] = tab_1.tabpage_2.dw_3
iudw_children[3] = tab_1.tabpage_3.dw_4
iudw_children[4] = tab_1.tabpage_4.dw_5
lw_tab = Parent.GetParent()
lw_parent = lw_tab.GetParent()
is_title_modifica = lw_parent.Title

end event

event itemchanged;call super::itemchanged;long ll_CurrRow
string ls_Nazione, ls_CF, ls_PI, ls_title, ls_space, ls_minus,  ls_codice, ls_rag_soc_1, ls_pdc_c
window lw_parent
tab    lw_tab

ls_Nazione = "IT"
ll_CurrRow = GetRow()
ls_space = " "
ls_minus = " - "
ls_title = "Azienda:"
CHOOSE CASE dwo.name
	CASE "cod_fiscale"
		if data <> "" AND not IsNull(data) then
			IF f_controlla_codice_fiscale(data, ls_Nazione) = 0 THEN
					RETURN 0
				ELSE
					IF f_controlla_partita_iva(data, ls_Nazione) = 0 THEN
						RETURN 0
					ELSE
						MessageBox(is_title, "Codice Fiscale non valido.", Exclamation!)
					END IF
			end if
		END IF
	CASE "par_iva"
		if data <> "" AND not IsNull(data) then
			IF f_controlla_partita_iva(data, ls_Nazione) = 0 THEN
				RETURN 0
			ELSE
				MessageBox(is_title, "Partita IVA non valida.", Exclamation!)
			END IF
		END IF
	CASE "codice"
		ls_codice = This.GetText()
		ls_rag_soc_1 = GetItemString(ll_CurrRow, "rag_soc_1")
		ls_title = ls_codice + ls_minus + ls_rag_soc_1
		lw_tab = Parent.GetParent()
		lw_parent = lw_tab.GetParent()
		lw_parent.Title = is_title_modifica + ls_space + ls_title
	CASE "rag_soc_1"
		ls_rag_soc_1 = This.GetText()
		ls_codice = GetItemString(ll_CurrRow, "codice")
		ls_title = ls_codice + ls_minus + ls_rag_soc_1
		IF IsNull(ls_title) THEN
			ls_title = ls_space
		END IF	
		lw_tab = Parent.GetParent()
		lw_parent = lw_tab.GetParent()
		lw_parent.Title = is_title_modifica + ls_space + ls_title
		

END CHOOSE



end event

event ue_default;call super::ue_default;string ls_cod_fiscale
CHOOSE CASE adwo_current.name
	CASE "par_iva"
		ls_cod_fiscale = GetItemString( al_row,"cod_fiscale")
		IF f_controlla_partita_iva(ls_cod_fiscale, "IT") = 0 THEN
			SetItem(al_row, "par_iva", ls_cod_fiscale)
		END IF
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;
		

end event

event rowfocuschanged;call super::rowfocuschanged;long 		ll_CurrRow
string 	ls_title, ls_space, ls_minus,  ls_codice, ls_rag_soc_1
window 	lw_parent
tab    	lw_tab

ll_CurrRow = GetRow()
ls_space = " "
ls_minus = " - "
IF (ll_CurrRow > 0) THEN
	ls_codice = GetItemString(ll_CurrRow, "codice")
	ls_rag_soc_1 = GetItemString(ll_CurrRow, "rag_soc_1")
	ls_title = ls_codice + ls_minus + ls_rag_soc_1
	IF IsNull(ls_title) THEN
			ls_title = ls_space
	END IF	
	lw_tab = Parent.GetParent()
	lw_parent = lw_tab.GetParent()
	lw_parent.Title = is_title_modifica + ls_space + ls_title
END IF
end event

event itemfocuschanged;call super::itemfocuschanged;
end event

type dw_2 from u_dw_master_main within tabpage_1
integer y = 1396
integer width = 2907
integer height = 484
integer taborder = 3
string dataobject = "d_attivita_gd"
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_azienda"

is_list.s_win_chiave[1] = "id_attivita"
is_list.s_win_zoom = "w_riep_iva_att_cx"

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_tab_attivita_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tab_attivita_gd"
		is_ricpar.s_titolo_finestra = "Tabella Attività"
		is_ricpar.s_ausil_value[1] ="id_tab_attivita_des"
		is_ricpar.i_width = 2972
		is_ricpar.i_height = 873
	CASE "id_tab_attivita_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tab_attivita_gd"
		is_ricpar.s_titolo_finestra = "Tabella Attività"
		is_ricpar.s_ausil_value[1] ="id_tab_attivita_cod"
		is_ricpar.i_width = 2972
		is_ricpar.i_height = 873
		
END CHOOSE

end event

event itemchanged;call super::itemchanged;
long		ll_row,ll_id_tab_attivita
string	ls_descr1,ls_descr2,ls_col_name

ls_col_name = dwo.name

CHOOSE CASE ls_col_name
	case 'id_tab_attivita_des','id_tab_attivita_cod'
		if row > 0 then
			ls_descr1	= this.GetItemString(row,"descrizione")
			if ls_descr1 ="" or isNull(ls_descr1) then				
				ll_id_tab_attivita = long(data)				
				SELECT "tab_attivita"."descrizione"
					INTO :ls_descr2
					FROM "dba"."tab_attivita"
					WHERE "tab_attivita"."id_tab_attivita" = :ll_id_tab_attivita
					USING SQLCA;
				
				if SQLCA.SQLCode = 0 then	
					this.SetItem(row,"descrizione",ls_descr2)			
				else
					if SQLCA.SQLCode = -1 then	
						MessageBox( "Database Error","Errore " + SQLCA.SQLErrText,StopSign! )
					end if
				end if
				
			end if
		end if	
	
end choose	

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3474
integer height = 1900
long backcolor = 79741120
string text = "Soggetti Aziendali"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw_master_main within tabpage_2
integer x = 50
integer y = 36
integer width = 2830
integer height = 1788
integer taborder = 3
string dataobject = "d_socio_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_azienda"
is_resp_window = "w_socio_ff"
is_list.s_win_chiave[1] = "id_socio"
is_list.s_par_name[1] = "id_azienda"

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3474
integer height = 1900
long backcolor = 79741120
string text = "Sedi"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_3.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_3.destroy
destroy(this.dw_4)
end on

type dw_4 from u_dw_master_main within tabpage_3
integer x = 50
integer y = 36
integer width = 3374
integer height = 1812
integer taborder = 4
string dataobject = "d_sede_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_azienda"
is_resp_window = "w_sede_ff"
is_list.s_win_chiave[1] = "id_sede"
is_list.s_par_name[1] = "id_azienda"

end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3474
integer height = 1900
long backcolor = 79741120
string text = "Altro"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_4.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_4.destroy
destroy(this.dw_5)
end on

type dw_5 from u_dw_master_main within tabpage_4
event ue_setta_password ( )
integer x = 37
integer y = 36
integer width = 2839
integer height = 1788
integer taborder = 3
string dataobject = "d_azienda_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_ten_scr_contabili"

end event

event ue_set_search;call super::ue_set_search;
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "esercizio_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_esercizio", is_ricpar.s_id_seg_value[1])
END CHOOSE
end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, ls_cripted
long      ll_ok

ls_sql_cond = ""
CHOOSE CASE dwo.name
		
	CASE "cc_pas_sosp"
		ls_cripted= f_cripting(string(data))
		uf_set_colval("azienda_pas_sosp_doc", ls_cripted)
	CASE "cc_pas_blocco"
		ls_cripted= f_cripting(string(data))
		uf_set_colval("azienda_pas_blocco_doc", ls_cripted)

END CHOOSE
end event

