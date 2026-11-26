forward
global type w_ric_bolle_carico_st from w_001
end type
type cb_annulla from commandbutton within w_ric_bolle_carico_st
end type
type cb_stampa from commandbutton within w_ric_bolle_carico_st
end type
type dw_1 from u_dw_ext_main within w_ric_bolle_carico_st
end type
end forward

global type w_ric_bolle_carico_st from w_001
integer width = 1815
integer height = 696
string title = "Stampa Dati Contabili"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
cb_annulla cb_annulla
cb_stampa cb_stampa
dw_1 dw_1
end type
global w_ric_bolle_carico_st w_ric_bolle_carico_st

on w_ric_bolle_carico_st.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.dw_1
end on

on w_ric_bolle_carico_st.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.dw_1)
end on

event open;

dw_1.settransobject(sqlca)
dw_1.insertrow(1)



dw_1.setitem(1, "data_doc", today())


end event

type st_1 from w_001`st_1 within w_ric_bolle_carico_st
end type

type cb_annulla from commandbutton within w_ric_bolle_carico_st
integer x = 18
integer y = 20
integer width = 247
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_ric_bolle_carico_st
integer x = 1477
integer y = 20
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//ll_magazzino sta per id_prof_documento
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_profilo")
s_par.da_data=dw_1.getitemdate(1, "data_doc")

s_par.tipo_stampa=dw_1.getitemstring(1, "num_doc")


openwithparm(w_ric_bolle_carico_rpt, s_par)
end event

type dw_1 from u_dw_ext_main within w_ric_bolle_carico_st
integer x = 18
integer y = 156
integer width = 1723
integer height = 352
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_carichi_da_scarico_st"
end type

event itemchanged;call super::itemchanged;string ls_id_conto

choose case string(dwo.name)
	case "da_conto"
		ls_id_conto=getitemstring(row, "a_conto")
		if isnull(ls_id_conto) then
			setitem(row, "a_conto", data)
		end if
		
end choose
end event

