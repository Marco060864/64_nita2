forward
global type w_ricrea_scadenze_passive from w_001
end type
type dw_1 from udw_base within w_ricrea_scadenze_passive
end type
type cb_ricrea from commandbutton within w_ricrea_scadenze_passive
end type
type dw_2 from udw_base within w_ricrea_scadenze_passive
end type
end forward

global type w_ricrea_scadenze_passive from w_001
integer width = 4155
integer height = 2262
dw_1 dw_1
cb_ricrea cb_ricrea
dw_2 dw_2
end type
global w_ricrea_scadenze_passive w_ricrea_scadenze_passive

on w_ricrea_scadenze_passive.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ricrea=create cb_ricrea
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ricrea
this.Control[iCurrent+3]=this.dw_2
end on

on w_ricrea_scadenze_passive.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ricrea)
destroy(this.dw_2)
end on

event open;call super::open;DW_1.SETtransobject(sqlca)
dw_1.retrieve()
end event

type st_1 from w_001`st_1 within w_ricrea_scadenze_passive
end type

type dw_1 from udw_base within w_ricrea_scadenze_passive
integer y = 26
integer width = 4096
integer height = 1536
boolean bringtotop = true
string dataobject = "d_ricrea_scadenze"
end type

type cb_ricrea from commandbutton within w_ricrea_scadenze_passive
integer x = 117
integer y = 1613
integer width = 322
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricrea"
end type

event clicked;string ls_tipo_scadenza
long ll_id_sog_commerciale, ll_id_con_pagamento
integer i

ls_tipo_scadenza="P"
ll_id_sog_commerciale=dw_1.getitemnumber(i, "id_sog_commerciale")
ll_id_con_pagamento=dw_1.getitemnumber(i, "id_con_pagamento")


end event

type dw_2 from udw_base within w_ricrea_scadenze_passive
integer y = 1741
integer width = 4096
integer height = 410
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_scad_per_ricrea_scadenze"
end type

