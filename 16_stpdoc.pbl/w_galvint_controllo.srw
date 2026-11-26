forward
global type w_galvint_controllo from w_001
end type
type cb_annulla from commandbutton within w_galvint_controllo
end type
type cb_stampa from commandbutton within w_galvint_controllo
end type
type dw_1 from u_dw_ext_main within w_galvint_controllo
end type
end forward

global type w_galvint_controllo from w_001
integer x = 1057
integer y = 483
integer width = 1815
integer height = 564
string title = "CONTROLLO GALVINT"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
cb_annulla cb_annulla
cb_stampa cb_stampa
dw_1 dw_1
end type
global w_galvint_controllo w_galvint_controllo

on w_galvint_controllo.create
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

on w_galvint_controllo.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.dw_1)
end on

event open;

dw_1.settransobject(sqlca)
dw_1.insertrow(1)



dw_1.setitem(1, "a_data", today())
dw_1.setitem(1, "id_profilo", 170)


end event

type st_1 from w_001`st_1 within w_galvint_controllo
end type

type cb_annulla from commandbutton within w_galvint_controllo
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

type cb_stampa from commandbutton within w_galvint_controllo
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
s_par.a_data=dw_1.getitemdate(1, "a_data")

//s_par.tipo_stampa=dw_1.getitemstring(1, "num_doc")


openwithparm(w_galvint_controllo_rpt, s_par)
end event

type dw_1 from u_dw_ext_main within w_galvint_controllo
integer x = 18
integer y = 156
integer width = 1723
integer height = 252
integer taborder = 10
boolean bringtotop = true
string title = "CONTROLLO GALVINT"
string dataobject = "d_galvint_tara_controllo_st"
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

