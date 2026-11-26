forward
global type w_art_fornitore_gd from w_semplice_gd
end type
type cbx_solo_senza_fo from checkbox within w_art_fornitore_gd
end type
end forward

global type w_art_fornitore_gd from w_semplice_gd
integer x = 1056
integer y = 484
integer width = 3160
integer height = 1776
cbx_solo_senza_fo cbx_solo_senza_fo
end type
global w_art_fornitore_gd w_art_fornitore_gd

on w_art_fornitore_gd.create
int iCurrent
call super::create
this.cbx_solo_senza_fo=create cbx_solo_senza_fo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_solo_senza_fo
end on

on w_art_fornitore_gd.destroy
call super::destroy
destroy(this.cbx_solo_senza_fo)
end on

event resize;call super::resize;cbx_solo_senza_fo.y=newheight - 224
cbx_solo_senza_fo.x=cb_ricerca.x - 600
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_art_fornitore_gd
integer y = 1523
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_fornitore_gd
integer y = 1523
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_fornitore_gd
integer y = 1392
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_fornitore_gd
integer y = 1392
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_fornitore_gd
integer y = 1392
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_fornitore_gd
integer y = 1392
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_fornitore_gd
integer width = 3039
integer height = 1306
string dataobject = "d_articolo_fornitore_gd"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_fornitore_gd
integer y = 1376
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_fornitore_gd
integer y = 1376
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_fornitore_gd
integer y = 1376
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_fornitore_gd
integer y = 1379
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_fornitore_gd
integer y = 1379
end type

type cbx_solo_senza_fo from checkbox within w_art_fornitore_gd
integer x = 998
integer y = 1386
integer width = 567
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Senza Fornitore"
end type

event clicked;if checked then
	dw_1.setfilter("isnull(id_sog_commerciale)")
else
	dw_1.setfilter("")
end if
dw_1.filter()
end event

