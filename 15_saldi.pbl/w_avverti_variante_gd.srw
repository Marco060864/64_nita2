forward
global type w_avverti_variante_gd from w_np_single_data
end type
type cbx_vedi_tutto from checkbox within w_avverti_variante_gd
end type
end forward

global type w_avverti_variante_gd from w_np_single_data
integer width = 2787
integer height = 2288
cbx_vedi_tutto cbx_vedi_tutto
end type
global w_avverti_variante_gd w_avverti_variante_gd

on w_avverti_variante_gd.create
int iCurrent
call super::create
this.cbx_vedi_tutto=create cbx_vedi_tutto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_vedi_tutto
end on

on w_avverti_variante_gd.destroy
call super::destroy
destroy(this.cbx_vedi_tutto)
end on

type p_msg_log from w_np_single_data`p_msg_log within w_avverti_variante_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_avverti_variante_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_avverti_variante_gd
end type

type dw_single from w_np_single_data`dw_single within w_avverti_variante_gd
integer x = 29
integer y = 26
integer width = 2311
integer height = 2074
string dataobject = "d_avverti_variante_gd"
end type

event dw_single::sqlpreview;call super::sqlpreview;string ls_sql

if cbx_vedi_tutto.checked then
	ls_sql=SQLSYNTAX
	ls_sql+= " or articolo.ges_matricole='N' or articolo.ges_matricole is null "
	setsqlpreview(ls_sql)

end if
end event

type cbx_vedi_tutto from checkbox within w_avverti_variante_gd
integer x = 2399
integer y = 51
integer width = 325
integer height = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi tutto"
boolean checked = true
end type

event clicked;dw_single.post retrieve()
end event

