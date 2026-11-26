forward
global type w_orafo_variante_gd from window
end type
type dw_orafo_variante from datawindow within w_orafo_variante_gd
end type
end forward

global type w_orafo_variante_gd from window
integer x = 832
integer y = 360
integer width = 3456
integer height = 820
boolean titlebar = true
string title = "Varianti dell~'articolo corrente"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
dw_orafo_variante dw_orafo_variante
end type
global w_orafo_variante_gd w_orafo_variante_gd

on w_orafo_variante_gd.create
this.dw_orafo_variante=create dw_orafo_variante
this.Control[]={this.dw_orafo_variante}
end on

on w_orafo_variante_gd.destroy
destroy(this.dw_orafo_variante)
end on

event open;string ls_codice
ls_codice=message.stringparm

ls_codice=ls_codice+"%"
dw_orafo_variante.settransobject(sqlca)
dw_orafo_variante.retrieve(ls_codice)
end event

type dw_orafo_variante from datawindow within w_orafo_variante_gd
integer x = 23
integer y = 20
integer width = 3342
integer height = 680
integer taborder = 1
string dataobject = "d_orafo_articolo_variante_gd"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;
long ll_id_articolo
ll_id_articolo=dw_orafo_variante.getitemnumber(row, "id_articolo")

closewithreturn(parent, ll_id_articolo)
end event

