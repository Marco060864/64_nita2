forward
global type w_stile_testo from w_001
end type
type dw_1 from udw_base within w_stile_testo
end type
type cb_ok from uo_cb within w_stile_testo
end type
type cb_1 from uo_cb within w_stile_testo
end type
type ole_1 from olecustomcontrol within w_stile_testo
end type
end forward

global type w_stile_testo from w_001
integer width = 1600
integer height = 1012
string title = "Attributi Testo"
windowtype windowtype = response!
dw_1 dw_1
cb_ok cb_ok
cb_1 cb_1
ole_1 ole_1
end type
global w_stile_testo w_stile_testo

on w_stile_testo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_1=create cb_1
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.ole_1
end on

on w_stile_testo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_1)
destroy(this.ole_1)
end on

event open;call super::open;

s_attrib_testo s_attrib

s_attrib=message.powerobjectparm
dw_1.insertrow(1)
dw_1.setitem(1, "stile", s_attrib.li_stile)
dw_1.setitem(1, "corpo", s_attrib.li_corpo)
dw_1.setitem(1, "paragrafo", s_attrib.li_paragrafo)
dw_1.setitem(1, "autosize", s_attrib.ls_autosize)
dw_1.setitem(1, "formato", s_attrib.ls_formato)
dw_1.setitem(1, "carattere", s_attrib.ls_carattere)
dw_1.setitem(1, "corsivo", s_attrib.ls_corsivo)
dw_1.setitem(1, "barrato", s_attrib.ls_barrato)
dw_1.setitem(1, "sottolineato", s_attrib.ls_sottolineato)
dw_1.setitem(1, "visibile", s_attrib.ls_visibile)
dw_1.setitem(1, "ometti_se_zero", s_attrib.ls_ometti_se_zero)

end event

type st_1 from w_001`st_1 within w_stile_testo
end type

type dw_1 from udw_base within w_stile_testo
integer x = 27
integer y = 24
integer width = 1504
integer height = 772
boolean bringtotop = true
string dataobject = "d_stili_ff"
end type

event clicked;string ls_carattere 
integer li_corpo

if dwo.name='p_font' then
	ole_1.object.showfont
	ls_carattere=ole_1.object.fontname
	li_corpo=ole_1.object.fontsize
	dw_1.setitem(1, "carattere", ls_carattere)
	dw_1.setitem(1, "corpo", li_corpo)
	if 	ole_1.object.FontBold then 
		dw_1.setitem(1, "stile", 700)
	end if
	if 	ole_1.object.FontItalic then 
		dw_1.setitem(1, "corsivo", "yes")
	end if
	if 	ole_1.object.FontStrikethru then 
		dw_1.setitem(1, "barrato", "yes")
	end if
	if 	ole_1.object.FontUnderline then 
		dw_1.setitem(1, "sottolineato", "yes")
	end if

	
end if
end event

type cb_ok from uo_cb within w_stile_testo
integer x = 1248
integer y = 808
integer taborder = 20
boolean bringtotop = true
string text = "OK"
end type

event clicked;s_attrib_testo s_attrib
dw_1.accepttext()
s_attrib.li_corpo=dw_1.getitemnumber(1, "corpo")
s_attrib.li_paragrafo=dw_1.getitemnumber(1, "paragrafo")
s_attrib.li_stile=dw_1.getitemnumber(1, "stile")
s_attrib.ls_autosize=dw_1.getitemstring(1, "autosize")
s_attrib.ls_formato=dw_1.getitemstring(1, "formato")
s_attrib.ls_barrato=dw_1.getitemstring(1, "barrato")
s_attrib.ls_sottolineato=dw_1.getitemstring(1, "sottolineato")
s_attrib.ls_carattere=dw_1.getitemstring(1, "carattere")
s_attrib.ls_corsivo=dw_1.getitemstring(1, "corsivo")
s_attrib.ls_visibile=dw_1.getitemstring(1, "visibile")
s_attrib.ls_ometti_se_zero=dw_1.getitemstring(1, "ometti_se_zero")

closewithreturn(parent, s_attrib)
end event

type cb_1 from uo_cb within w_stile_testo
integer x = 978
integer y = 808
integer taborder = 30
boolean bringtotop = true
string text = "Annulla"
end type

event clicked;close(parent)
end event

type ole_1 from olecustomcontrol within w_stile_testo
integer x = 361
integer y = 804
integer width = 146
integer height = 128
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_stile_testo.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

