forward
global type w_variante_gd from window
end type
type cb_ok from commandbutton within w_variante_gd
end type
type cb_annulla from commandbutton within w_variante_gd
end type
type dw_orafo_variante from datawindow within w_variante_gd
end type
end forward

global type w_variante_gd from window
integer x = 5
integer y = 316
integer width = 3278
integer height = 948
boolean titlebar = true
string title = "Varianti dell~'articolo corrente"
windowtype windowtype = response!
long backcolor = 79741120
cb_ok cb_ok
cb_annulla cb_annulla
dw_orafo_variante dw_orafo_variante
end type
global w_variante_gd w_variante_gd

on w_variante_gd.create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_orafo_variante=create dw_orafo_variante
this.Control[]={this.cb_ok,&
this.cb_annulla,&
this.dw_orafo_variante}
end on

on w_variante_gd.destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_orafo_variante)
end on

event open;string ls_codice,ls_sql
long ll_sog,ret,ll_id_art
integer li_pos
string ls_parametri
ls_parametri=message.stringparm
li_pos=pos(ls_parametri,'?')
ls_codice=left(ls_parametri,li_pos -1)
ls_codice=ls_codice+"%"
ls_parametri=right(ls_parametri,len(ls_parametri) -li_pos)
li_pos=pos(ls_parametri,'?')
ll_sog=long(left(ls_parametri,li_pos -1))
ll_id_art=long(right(ls_parametri,len(ls_parametri) -li_pos))
//if pos(upper(u_freddie.istr_database.name),'ORAFO')>0 then
	//dw_orafo_variante.DataObject="d_orafo_articolo_variante_gd"
//else
	//dw_orafo_variante.DataObject="d_articolo_variante_gd"
//end if
if ll_sog>0 then 
	
	
	ls_parametri="id_sog_comm_variante="+string(ll_sog)+ " or id_articolo="+string(ll_id_art)
	dw_orafo_variante.setfilter(ls_parametri)
	li_pos=dw_orafo_variante.filter()
	if li_pos<>1 then messagebox("Errore", "Filtro non apllicato")
end if
	
dw_orafo_variante.settransobject(sqlca)
ll_sog=dw_orafo_variante.retrieve(ls_codice)
if ll_sog<=1 then 
	closewithreturn(this, "")
end if



end event

type cb_ok from commandbutton within w_variante_gd
integer x = 32
integer y = 736
integer width = 247
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;string ls_articolo
long row
row=dw_orafo_variante.getrow()
if row>0 then
	ls_articolo=dw_orafo_variante.getitemstring(row, "articolo_codice")
end if

closewithreturn(parent, ls_articolo)
end event

type cb_annulla from commandbutton within w_variante_gd
integer x = 297
integer y = 736
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;closewithreturn(parent, "")
end event

type dw_orafo_variante from datawindow within w_variante_gd
integer x = 23
integer y = 28
integer width = 3191
integer height = 684
integer taborder = 10
string dataobject = "d_articolo_variante_gd"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;
string ls_articolo
ls_articolo=dw_orafo_variante.getitemstring(row, "articolo_codice")

closewithreturn(parent, ls_articolo)
end event

