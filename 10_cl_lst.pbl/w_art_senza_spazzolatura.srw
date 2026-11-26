forward
global type w_art_senza_spazzolatura from w_semplice_gd
end type
type cbx_1 from checkbox within w_art_senza_spazzolatura
end type
type cbx_2 from checkbox within w_art_senza_spazzolatura
end type
end forward

global type w_art_senza_spazzolatura from w_semplice_gd
integer width = 5147
integer height = 2376
boolean maxbox = false
windowtype windowtype = popup!
cbx_1 cbx_1
cbx_2 cbx_2
end type
global w_art_senza_spazzolatura w_art_senza_spazzolatura

type variables
string is_filtro_originale
end variables

on w_art_senza_spazzolatura.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
end on

on w_art_senza_spazzolatura.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

event open;call super::open;string ls_tipo, ls_color

ls_tipo=message.stringparm
if ls_tipo="E" or ls_tipo="S" then 
	is_filtro_originale =" (tipo='E' or tipo='S') "
else
	is_filtro_originale="tipo='"+ls_tipo+"'"
end if
dw_1.setfilter(is_filtro_originale)
dw_1.filter()

if ls_tipo="L" then dw_1.modify("DataWindow.Detail.color=8388352")

if ls_tipo="S" or ls_tipo="E" then dw_1.modify("DataWindow.Detail.color=65535")



end event

event resize;call super::resize;cbx_1.y =cb_stampa.y
cbx_1.x=cb_stampa.x + cb_stampa.width+30

cbx_2.x=cbx_1.x + cbx_1.width+30
cbx_2.y=cbx_1.y
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_art_senza_spazzolatura
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_senza_spazzolatura
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_senza_spazzolatura
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_senza_spazzolatura
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_senza_spazzolatura
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_senza_spazzolatura
integer x = 1111
integer y = 996
integer width = 366
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_senza_spazzolatura
integer width = 5001
string dataobject = "d_art_senza_spazzolatura"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_senza_spazzolatura
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_senza_spazzolatura
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_senza_spazzolatura
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_senza_spazzolatura
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_senza_spazzolatura
end type

type cbx_1 from checkbox within w_art_senza_spazzolatura
integer x = 974
integer y = 992
integer width = 663
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Da Correggere"
end type

event clicked;string ls_filtro

if checked then
	//messagebox("W", ls_filtro)
	dw_1.setfilter(is_filtro_originale +" and (corretto ='N' or isnull(corretto))")
	text="TUTTI"
else
	dw_1.setfilter(is_filtro_originale)
	text="Da Correggere"
end if
dw_1.filter()
end event

type cbx_2 from checkbox within w_art_senza_spazzolatura
integer x = 2469
integer y = 992
integer width = 549
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Cod. Articolo"
end type

event clicked;if checked then
	dw_1.modify("articolo_codice.visible=1")
else
	dw_1.modify("articolo_codice.visible=0")
end if
end event

