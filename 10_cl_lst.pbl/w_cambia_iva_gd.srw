forward
global type w_cambia_iva_gd from w_pop
end type
type cb_ok from commandbutton within w_cambia_iva_gd
end type
end forward

global type w_cambia_iva_gd from w_pop
integer width = 1934
integer height = 1344
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
end type
global w_cambia_iva_gd w_cambia_iva_gd

on w_cambia_iva_gd.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
end on

on w_cambia_iva_gd.destroy
call super::destroy
destroy(this.cb_ok)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from w_pop`dw_1 within w_cambia_iva_gd
integer width = 1687
integer height = 780
string dataobject = "d_tab_iva_cod_sl"
end type

type cb_ok from commandbutton within w_cambia_iva_gd
integer x = 1275
integer y = 936
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type

event clicked;long ll_row, ll_id_tab_iva

ll_row=dw_1.getrow()
if ll_row> 0 then
	ll_id_tab_iva=dw_1.getitemnumber(ll_row, "id_tab_iva")
	closewithreturn(parent, ll_id_tab_iva)
	
end if
end event

