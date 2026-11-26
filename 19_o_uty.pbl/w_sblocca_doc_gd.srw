forward
global type w_sblocca_doc_gd from w_np_single_data
end type
type dw_1 from udw_base within w_sblocca_doc_gd
end type
type cb_cerca from commandbutton within w_sblocca_doc_gd
end type
type cb_vedi_tutti from commandbutton within w_sblocca_doc_gd
end type
end forward

global type w_sblocca_doc_gd from w_np_single_data
integer width = 3240
dw_1 dw_1
cb_cerca cb_cerca
cb_vedi_tutti cb_vedi_tutti
end type
global w_sblocca_doc_gd w_sblocca_doc_gd

on w_sblocca_doc_gd.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cerca=create cb_cerca
this.cb_vedi_tutti=create cb_vedi_tutti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cerca
this.Control[iCurrent+3]=this.cb_vedi_tutti
end on

on w_sblocca_doc_gd.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cerca)
destroy(this.cb_vedi_tutti)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)
end event

type p_msg_log from w_np_single_data`p_msg_log within w_sblocca_doc_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_sblocca_doc_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_sblocca_doc_gd
end type

type dw_single from w_np_single_data`dw_single within w_sblocca_doc_gd
integer x = 29
integer y = 26
integer width = 2662
integer height = 691
string dataobject = "d_sblocca_doc_gd"
end type

type dw_1 from udw_base within w_sblocca_doc_gd
integer x = 2721
integer y = 26
integer width = 435
integer height = 157
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_cerca_num_prog"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type cb_cerca from commandbutton within w_sblocca_doc_gd
integer x = 2721
integer y = 179
integer width = 322
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtra"
end type

event clicked;long ll_num_prog, ll_riga_trovata

ll_num_prog=dw_1.getitemnumber(1, "num_prog")
dw_1.accepttext()
if ll_num_prog>0 then
	dw_single.setfilter("num_progressivo="+string(ll_num_prog))
	dw_single.filter()
//	ll_riga_trovata=dw_single.find("num_progressivo="+string(ll_num_prog), 1, dw_single.rowcount())
//	if ll_riga_trovata>0 then
//		dw_single.scrolltorow(ll_riga_trovata)
//	end if
end if
end event

type cb_vedi_tutti from commandbutton within w_sblocca_doc_gd
integer x = 2721
integer y = 307
integer width = 322
integer height = 90
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vedi Tutti"
end type

event clicked;dw_single.setfilter("")
	dw_single.filter()
end event

