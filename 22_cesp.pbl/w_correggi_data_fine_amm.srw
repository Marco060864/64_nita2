forward
global type w_correggi_data_fine_amm from w_np_single_data
end type
type cb_1 from commandbutton within w_correggi_data_fine_amm
end type
end forward

global type w_correggi_data_fine_amm from w_np_single_data
integer height = 1012
cb_1 cb_1
end type
global w_correggi_data_fine_amm w_correggi_data_fine_amm

on w_correggi_data_fine_amm.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_correggi_data_fine_amm.destroy
call super::destroy
destroy(this.cb_1)
end on

type p_msg_log from w_np_single_data`p_msg_log within w_correggi_data_fine_amm
end type

type p_crescente from w_np_single_data`p_crescente within w_correggi_data_fine_amm
end type

type p_decrescente from w_np_single_data`p_decrescente within w_correggi_data_fine_amm
end type

type dw_single from w_np_single_data`dw_single within w_correggi_data_fine_amm
string dataobject = "d_trova_data_errata_gd"
end type

type cb_1 from commandbutton within w_correggi_data_fine_amm
integer x = 219
integer y = 780
integer width = 1280
integer height = 100
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copia data Ultimo Movimento in Data Fine Ammortamento"
end type

event clicked;integer i
date ldt_data

for i= 1 to dw_single.rowcount()
	ldt_data=dw_single.getitemdate(i, "C_DATA_OK")
	dw_single.setitem(i, "DATA_FINE_AMM", ldt_data)
next


end event

