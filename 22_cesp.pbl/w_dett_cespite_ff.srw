forward
global type w_dett_cespite_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_dett_cespite_ff
end type
type cb_annulla from commandbutton within w_dett_cespite_ff
end type
type dw_1 from u_dw_ext_main within w_dett_cespite_ff
end type
end forward

global type w_dett_cespite_ff from w_wiz_main
integer y = 437
integer width = 2336
integer height = 836
string title = "Dettaglio Cespite"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 78748035
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_dett_cespite_ff w_dett_cespite_ff

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
boolean lb_ges_periodo
long ll_valuta
end variables

on w_dett_cespite_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_dett_cespite_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;


dw_1.settransobject(sqlca)
dw_1.insertrow(1)

dw_1.setitem(1, 'a_data', today())	


end event

event closequery;
end event

type cb_ok from commandbutton within w_dett_cespite_ff
event clicked pbm_bnclicked
integer x = 27
integer y = 36
integer width = 270
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean cancel = true
end type

event clicked;s_cespiti str_parametri  

string   ls_cat, ls_cat2
integer li_d_day, li_d_fine , i
date ld_data


dw_1.accepttext()
ls_cat=dw_1.getitemstring(1, 'da_cod_cat') 
if isnull(ls_cat) then ls_cat=' '

ls_cat2=dw_1.getitemstring(1, 'a_cod_cat') 
if isnull(ls_cat2) then ls_cat2='ZZZZZZZZZZZZZ'

ld_data=dw_1.getitemdate(1, 'a_data') 
//if isnull(ld_data) then messagebox('Attenzione','Inserire una data valida!')
//
//
IF ls_cat > ls_cat2 THEN
	messagebox ('Attenzione', 'La categoria iniziale è maggiore del conto finale')
	return
end if	
str_parametri.s_id_cespite=dw_1.getitemnumber(1, "id_esercizio")
if isnull(str_parametri.s_id_cespite) then 
	messagebox('Attenzione','Inserire Esercizio!')
	return
end if
str_parametri.da_cat=ls_cat
str_parametri.a_cat=ls_cat2
str_parametri.a_data=ld_data


str_parametri.s_tipo_movimento=dw_1.getitemstring(1, "da_des")
if str_parametri.s_tipo_movimento="d_stp_registro_cesp_bro_rpt" then
	if isnull(str_parametri.a_data) then
		messagebox("Occhio!", "Manca la data per il calcolo degli ammortamenti!")
		return
	end if
end if


openwithparm(w_stp_dett_cespite_rpt, str_parametri)




end event

type cb_annulla from commandbutton within w_dett_cespite_ff
integer x = 315
integer y = 36
integer width = 256
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_dett_cespite_ff
integer x = 27
integer y = 152
integer width = 2258
integer height = 560
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_det_cespite_ff"
end type

event itemchanged;string ls_filtro, ls_colonna
integer li_ok
long ll_es
date ld_d1, ld_d2
string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

setnull(ls_null)

CHOOSE CASE dwo.name
		
		
	CASE "da_cod_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
       	  This.SetItem(1, "a_cod_cat", Data)			
           This.SetItem(1, "a_des_cat", This.GetItemString(1, "da_des_cat"))
         end if
			RETURN 2
		END IF
		
		
	case "da_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
       	  This.SetItem(1, "a_des_cat", Data)			
           This.SetItem(1, "a_cod_cat", This.GetItemString(1, "da_cod_cat"))
         end if
			RETURN 2
		END IF

	case "a_cod_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose

end event

event ue_set_search;string ls_cond

CHOOSE CASE as_nomecol
	
	CASE "a_cod_cat", "a_des_cat"
		is_search_window = "w_cat_int_cespite_sw"

		IF as_nomecol = "a_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_codice"
		ELSEIF as_nomecol = "a_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_descrizione"
		END IF

	CASE "da_cod_cat", "da_des_cat"
		is_search_window = "w_cat_int_cespite_sw"

		IF as_nomecol = "da_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_codice"
		ELSEIF as_nomecol = "da_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_descrizione"
		END IF

END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol
	
	CASE "a_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])

	CASE "a_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])
	
	CASE "da_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_des_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
        uf_set_colval('a_cod_cat', is_ricpar.s_main_value)
        uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])
	   end if
	
	CASE "da_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
        uf_set_colval('a_des_cat', is_ricpar.s_main_value)
        uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])
	   end if		

END CHOOSE








end event

