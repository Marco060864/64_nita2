forward
global type w_sintetica_ff from window
end type
type dw_1 from u_dw_ext_main within w_sintetica_ff
end type
type cb_2 from commandbutton within w_sintetica_ff
end type
type cb_1 from commandbutton within w_sintetica_ff
end type
end forward

global type w_sintetica_ff from window
integer x = 832
integer y = 360
integer width = 2235
integer height = 628
boolean titlebar = true
string title = "Stampa Dettagliata Cespite"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 78748035
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_sintetica_ff w_sintetica_ff

event open;dw_1.insertrow(1)
date ld_data_fine
string ls_data
integer li_anno
li_anno=year(today()) - 1
ls_data='31/12/'+string(li_anno)
ld_data_fine=date(ls_data)
dw_1.setitem(1,"data_fine",ld_data_fine)

end event

on w_sintetica_ff.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_sintetica_ff.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_1 from u_dw_ext_main within w_sintetica_ff
integer x = 23
integer y = 140
integer width = 2135
integer height = 360
integer taborder = 10
string dataobject = "d_sintetica_ff"
end type

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_cod", "da_cod_des"
		uf_set_colval("da_cod", is_ricpar.s_main_value)
		uf_set_colval("da_cod_des", is_ricpar.s_ausil_value[1])
		if  isnull(this.getitemstring(1,'a_cod'))	or this.getitemstring(1,'a_cod')='' then
			uf_set_colval("a_cod", is_ricpar.s_main_value)
			uf_set_colval("a_cod_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "a_cod", "a_cod_des"
		uf_set_colval("a_cod", is_ricpar.s_main_value)
		uf_set_colval("a_cod_des", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cod","a_cod"
		is_search_window = "w_cat_int_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "cat_int_cespite_codice"
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "da_cod_des", "a_cod_des"
		is_search_window = "w_cat_int_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "cat_int_cespite_descrizione"
		is_ricpar.b_imm_retrieve  = TRUE
END CHOOSE
end event

event itemchanged;string   	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long 		 	ll_ok

ls_sql_cond = ""

CHOOSE CASE string(dwo.name)

CASE 'da_cod'

		ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "da_cod_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (ll_ok > 0) THEN
			if  isnull(this.getitemstring(1,'a_cod'))	or this.getitemstring(1,'a_cod')='' then
			this.setitem(1,'a_cod',data)
			this.setitem(1,'a_cod_des',this.getitemstring(1,'da_cod_des'))
		end if
			RETURN 2
		END IF	
	
	CASE 'da_cod_des'

		ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "da_cod_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)								
										
		IF (ll_ok > 0) THEN
			if  isnull(this.getitemstring(1,'a_cod'))	or this.getitemstring(1,'a_cod')='' then
			this.setitem(1,'a_cod_des',data)
			this.setitem(1,'a_cod',this.getitemstring(1,'da_cod'))
		end if
			RETURN 2
		END IF	
	
	CASE 'a_cod'

		ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "a_cod_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	
	CASE 'a_cod_des'

		ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "a_cod_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	
	
END CHOOSE

end event

type cb_2 from commandbutton within w_sintetica_ff
integer x = 23
integer y = 20
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_sintetica_ff
integer x = 1911
integer y = 20
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;s_sintetica passaggio
passaggio.da_cod=dw_1.getitemstring(1,"da_cod")
passaggio.a_cod=dw_1.getitemstring(1,"a_cod")
passaggio.stato=dw_1.getitemstring(1,"stato")

openwithparm(w_stampa_sintetica_ff,passaggio)
end event

