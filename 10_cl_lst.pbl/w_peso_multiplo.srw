forward
global type w_peso_multiplo from w_pop
end type
type cb_ok from commandbutton within w_peso_multiplo
end type
type cb_annulla from commandbutton within w_peso_multiplo
end type
end forward

global type w_peso_multiplo from w_pop
integer width = 1326
integer height = 880
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_peso_multiplo w_peso_multiplo

on w_peso_multiplo.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
end on

on w_peso_multiplo.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;dw_1.insertrow(1)
end event

type dw_1 from w_pop`dw_1 within w_peso_multiplo
integer width = 1152
integer height = 512
string dataobject = "d_peso_multiplo"
end type

event dw_1::clicked;call super::clicked;decimal ld_peso_netto
w_bilancia w_bil
if pos(string(dwo.name), "peso_")>0 then

	open(w_bil)
	
	ld_peso_netto=w_bil.f_rendi_peso()
	if ld_peso_netto>0 then
		setitem(row, string(dwo.name), ld_peso_netto)
	else
		messagebox("Attenzione!", "Peso NON recuperato!")
	end if
	close(w_bil)
end if


/*
DWObject my_dwo
decimal ld_peso_netto
long	ll_row, ll_id_articolo
string ls_metallo

w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
if ld_peso_netto>0 then
	ll_id_articolo=idw_riga.getitemnumber(idw_riga.getrow(), "riga_documento_id_articolo")
		select m.codice
		into :ls_metallo
		from articolo a, orafo_titolo t, orafo_metallo m
		where a.id_titolo=t.id_titolo and t.id_metallo=m.id_metallo
		and a.id_articolo=:ll_id_articolo
		;
		if ls_metallo<>"AU" then
			ld_peso_netto=round(ld_peso_netto, 1)
		end if
	
	ll_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
				
	my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_peso_netto",ld_peso_netto)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
end if
close(w_bil)
*/
end event

type cb_ok from commandbutton within w_peso_multiplo
integer x = 832
integer y = 596
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type

event clicked;decimal{2} ld_peso_1, ld_peso_2
dw_1.accepttext()
ld_peso_1=dw_1.getitemdecimal(1, "peso_1")
ld_peso_2=dw_1.getitemdecimal(1, "peso_2")
if isnull(ld_peso_1) or ld_peso_1=0 then
	messagebox("Attenzione!", "Peso 1 NON inserito")
	return
end if
if isnull(ld_peso_2) or ld_peso_2=0 then
	messagebox("Attenzione!", "Peso 1 NON inserito")
	return
end if
ld_peso_1+=ld_peso_2
closewithreturn(parent, ld_peso_1)
end event

type cb_annulla from commandbutton within w_peso_multiplo
integer x = 82
integer y = 596
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

