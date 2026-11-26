forward
global type w_orafo_formato_stampa_etichette from window
end type
type ole_1 from olecustomcontrol within w_orafo_formato_stampa_etichette
end type
type mle_dati_par from multilineedit within w_orafo_formato_stampa_etichette
end type
type st_20 from statictext within w_orafo_formato_stampa_etichette
end type
type st_8 from statictext within w_orafo_formato_stampa_etichette
end type
type cb_2 from commandbutton within w_orafo_formato_stampa_etichette
end type
type cb_3 from commandbutton within w_orafo_formato_stampa_etichette
end type
type cb_salva from commandbutton within w_orafo_formato_stampa_etichette
end type
type cb_1 from commandbutton within w_orafo_formato_stampa_etichette
end type
type dw_1 from datawindow within w_orafo_formato_stampa_etichette
end type
end forward

global type w_orafo_formato_stampa_etichette from window
integer x = 46
integer y = 16
integer width = 3301
integer height = 1516
boolean titlebar = true
string title = "Formato Etichette"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 77633680
ole_1 ole_1
mle_dati_par mle_dati_par
st_20 st_20
st_8 st_8
cb_2 cb_2
cb_3 cb_3
cb_salva cb_salva
cb_1 cb_1
dw_1 dw_1
end type
global w_orafo_formato_stampa_etichette w_orafo_formato_stampa_etichette

type variables
boolean bl_modified
string is_conf
end variables

on w_orafo_formato_stampa_etichette.create
this.ole_1=create ole_1
this.mle_dati_par=create mle_dati_par
this.st_20=create st_20
this.st_8=create st_8
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_salva=create cb_salva
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.ole_1,&
this.mle_dati_par,&
this.st_20,&
this.st_8,&
this.cb_2,&
this.cb_3,&
this.cb_salva,&
this.cb_1,&
this.dw_1}
end on

on w_orafo_formato_stampa_etichette.destroy
destroy(this.ole_1)
destroy(this.mle_dati_par)
destroy(this.st_20)
destroy(this.st_8)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_salva)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long ll_found
string query, ls_objects, ls_oldstr, ls_nome_campo
integer ll_start_pos, ll_pos_ini, i

query = message.StringParm	
is_conf = query
if isnull(is_conf) or is_conf = '' then is_conf = 'default'

dw_1.setTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_1.retrieve(query)

bl_modified = FALSE

ls_objects = w_orafo_stampa_etichette_rpt.dw_1.Object.DataWindow.Objects	
mle_dati_par.text=ls_objects

if dw_1.rowcount()<=0 then
	ls_oldstr = "~t"
	ll_start_pos = Pos(ls_objects, ls_oldstr)
	DO while ll_start_pos > 0
		i++
		ls_nome_campo=mid(ls_objects, ll_pos_ini+1, (ll_start_pos - 1) - (ll_pos_ini) )
		dw_1.insertrow(0)
		dw_1.setitem(i, "nome_formato", ls_nome_campo)
		
		ll_pos_ini=ll_start_pos
		ll_start_pos = Pos(ls_objects, ls_oldstr, ll_pos_ini+1)
	LOOP 
	if len(ls_objects) > ll_pos_ini then
		ls_nome_campo=mid(ls_objects, ll_pos_ini+1, len(ls_objects) - (ll_pos_ini) )
		dw_1.insertrow(0)
		dw_1.setitem(i+1, "nome_formato", ls_nome_campo)
	end if
end if

end event

event close;if bl_modified then
		integer Res
		
		
		Res = MessageBox("Alert", "Vuoi salvare le modifiche?", Exclamation!, OKCancel!, 2)
		IF Res = 1 THEN
		
			cb_salva.triggerEvent(Clicked!)
		END IF
			
	
	
	
end if

end event

type ole_1 from olecustomcontrol within w_orafo_formato_stampa_etichette
integer x = 2939
integer y = 1264
integer width = 146
integer height = 128
integer taborder = 50
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_orafo_formato_stampa_etichette.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type mle_dati_par from multilineedit within w_orafo_formato_stampa_etichette
integer x = 27
integer y = 968
integer width = 1486
integer height = 416
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_20 from statictext within w_orafo_formato_stampa_etichette
integer x = 1829
integer y = 1128
integer width = 928
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Le misure sono espresse in 1/10 di mm."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_orafo_formato_stampa_etichette
integer x = 1541
integer y = 1312
integer width = 640
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80659129
boolean enabled = false
string text = "<<<< Dati Parametrizzabili"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_orafo_formato_stampa_etichette
integer x = 1545
integer y = 1108
integer width = 274
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_orafo_formato_stampa_etichette
integer x = 1541
integer y = 972
integer width = 297
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_row
ll_row = dw_1.getRow()
string config
config = dw_1.GetItemString(ll_row,"nome_formato")

	LONG LL_RIS
	ll_ris = dw_1.DeleteRow(ll_row)
	ll_ris = dw_1.Update(TRUE)
	if ll_ris<>1 then
		messagebox("Alert","Cancellazione fallita!")
	else
		messagebox("Alert","Cancellazione eseguita!")
		
	end if


end event

type cb_salva from commandbutton within w_orafo_formato_stampa_etichette
integer x = 2171
integer y = 972
integer width = 297
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;LONG LL_RIS, ll_row
integer i

ll_row = dw_1.rowcount()
FOR i=1 TO ll_row
   dw_1.setitem(i,"nome_configurazione",is_conf)
NEXT


ll_ris = dw_1.update(true)
if ll_ris<>1 then
	messagebox("Alert","Salvataggio fallito!")
else
	messagebox("Alert","Salvataggio eseguito!")
	bl_modified = FALSE
end if

end event

type cb_1 from commandbutton within w_orafo_formato_stampa_etichette
integer x = 1856
integer y = 972
integer width = 297
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_newRow
ll_newRow = dw_1.insertRow(0)
dw_1.SetRow(ll_newRow)
end event

type dw_1 from datawindow within w_orafo_formato_stampa_etichette
integer x = 27
integer y = 72
integer width = 3237
integer height = 884
integer taborder = 10
string dataobject = "d_formato_stampa_etichette"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;bl_modified = TRUE
end event

event losefocus;this.acceptText()
end event

event clicked;string ls_carattere 
integer li_corpo

if dwo.name='p_font' then
	ole_1.object.showfont
	ls_carattere=ole_1.object.fontname
	li_corpo=ole_1.object.fontsize
	dw_1.setitem(row, "font", ls_carattere)
	//dw_1.setitem(row, "corpo", li_corpo)
	if 	ole_1.object.FontBold then 
		//dw_1.setitem(row, "stile", 700)
	end if
	if 	ole_1.object.FontItalic then 
		//dw_1.setitem(row, "corsivo", "yes")
	end if
	if 	ole_1.object.FontStrikethru then 
		//dw_1.setitem(row, "barrato", "yes")
	end if
	if 	ole_1.object.FontUnderline then 
		//dw_1.setitem(row, "sottolineato", "yes")
	end if

	
end if
end event

