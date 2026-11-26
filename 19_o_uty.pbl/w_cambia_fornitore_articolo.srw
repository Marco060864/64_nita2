forward
global type w_cambia_fornitore_articolo from w_001
end type
type dw_1 from udw_base within w_cambia_fornitore_articolo
end type
type cb_seleziona from commandbutton within w_cambia_fornitore_articolo
end type
type cb_stampa from commandbutton within w_cambia_fornitore_articolo
end type
type cb_salva from commandbutton within w_cambia_fornitore_articolo
end type
type cb_inserisci from commandbutton within w_cambia_fornitore_articolo
end type
type cb_cancella from commandbutton within w_cambia_fornitore_articolo
end type
type cb_ricopia from commandbutton within w_cambia_fornitore_articolo
end type
type cb_pulisci from commandbutton within w_cambia_fornitore_articolo
end type
type cb_ricopia_prod from commandbutton within w_cambia_fornitore_articolo
end type
type cb_sel_tutto from commandbutton within w_cambia_fornitore_articolo
end type
type cb_1 from commandbutton within w_cambia_fornitore_articolo
end type
end forward

global type w_cambia_fornitore_articolo from w_001
integer width = 3438
integer height = 2028
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
cb_seleziona cb_seleziona
cb_stampa cb_stampa
cb_salva cb_salva
cb_inserisci cb_inserisci
cb_cancella cb_cancella
cb_ricopia cb_ricopia
cb_pulisci cb_pulisci
cb_ricopia_prod cb_ricopia_prod
cb_sel_tutto cb_sel_tutto
cb_1 cb_1
end type
global w_cambia_fornitore_articolo w_cambia_fornitore_articolo

type variables
udw_base idw
end variables

on w_cambia_fornitore_articolo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_seleziona=create cb_seleziona
this.cb_stampa=create cb_stampa
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.cb_ricopia=create cb_ricopia
this.cb_pulisci=create cb_pulisci
this.cb_ricopia_prod=create cb_ricopia_prod
this.cb_sel_tutto=create cb_sel_tutto
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_seleziona
this.Control[iCurrent+3]=this.cb_stampa
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_ricopia
this.Control[iCurrent+8]=this.cb_pulisci
this.Control[iCurrent+9]=this.cb_ricopia_prod
this.Control[iCurrent+10]=this.cb_sel_tutto
this.Control[iCurrent+11]=this.cb_1
end on

on w_cambia_fornitore_articolo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_seleziona)
destroy(this.cb_stampa)
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.cb_ricopia)
destroy(this.cb_pulisci)
destroy(this.cb_ricopia_prod)
destroy(this.cb_sel_tutto)
destroy(this.cb_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
//dw_2.settransobject(sqlca)
//dw_2.insertrow(1)

end event

type st_1 from w_001`st_1 within w_cambia_fornitore_articolo
end type

type dw_1 from udw_base within w_cambia_fornitore_articolo
integer x = 46
integer y = 20
integer width = 3282
integer height = 1464
boolean bringtotop = true
boolean titlebar = true
string title = "Articoli da modificare"
string dataobject = "d_cambia_fornitore_articolo_gd"
end type

event itemchanged;call super::itemchanged;long ll_id_art, ll_id_cat_cod, ll_id_cat_com
string ls_des, ls_intr, ls_stato
datetime ldt_data_ora

if dwo.name='codice' then
	select id_articolo, descrizione, cod_intrastat, data_ora_ult_cambiamento,
	id_cat_codifica, id_cat_com_articolo, stato
	into :ll_id_art, :ls_des, :ls_intr, :ldt_data_ora, 
	:ll_id_cat_cod, :ll_id_cat_com, :ls_stato
	
	from articolo
	where codice=:data
	;
	setitem(row, "descrizione", ls_des)
	setitem(row, "cod_intrastat", ls_intr)
	setitem(row, "id_articolo", ll_id_art)
	setitem(row, "data_ora_ult_cambiamento", ldt_data_ora)
	setitem(row, "id_cat_codifica", ll_id_cat_cod)
	setitem(row, "id_cat_com_articolo", ll_id_cat_com)
	setitem(row, "stato", ls_stato)
end if
end event

event retrievestart;call super::retrievestart;return 2
end event

event getfocus;call super::getfocus;idw=this
end event

type cb_seleziona from commandbutton within w_cambia_fornitore_articolo
integer x = 64
integer y = 1732
integer width = 416
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona"
end type

event clicked;s_dw_ritorna st_p
integer li_righe, i, ll_riga
long ll_id_lista, ll_id_art
string ls_cod_art

li_righe=dw_1.getrow()

openwithparm(w_auto_aggiunta_cx, ll_id_lista)


st_p=message.powerobjectparm

if isvalid(st_p) then
	for i=1 to st_p.ds.rowcount()
		//ls_cod_art=st_p.ds.getitemstring(i, "articolo_codice")
		ll_id_art=st_p.ds.getitemnumber(i, "id_articolo")
		dw_1.retrieve(ll_id_art)
//		ll_riga=dw_1.trigger event ue_insert(0)
//		dw_1.setitem(ll_riga, "codice", ls_cod_art)
//		dw_1.trigger event itemchanged(ll_riga, dw_1.object.codice, ls_cod_art)
		
		
	next
//		st_p.ds.rowscopy(1, st_p.ds.rowcount(), primary!, dw_2, li_righe, primary!)
end if


	
end event

type cb_stampa from commandbutton within w_cambia_fornitore_articolo
integer x = 2843
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;
printsetup()
idw.print()

end event

type cb_salva from commandbutton within w_cambia_fornitore_articolo
integer x = 576
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_1.triggerevent("ue_update")
end event

type cb_inserisci from commandbutton within w_cambia_fornitore_articolo
integer x = 942
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;dw_1.trigger event ue_insert(0)
end event

type cb_cancella from commandbutton within w_cambia_fornitore_articolo
integer x = 1307
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;dw_1.trigger event ue_delete(dw_1.getrow())
end event

type cb_ricopia from commandbutton within w_cambia_fornitore_articolo
integer x = 1696
integer y = 1728
integer width = 544
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricopia Fornitore Sotto"
end type

event clicked;long ll_id_sog
integer i, a
dw_1.accepttext()
a=dw_1.getrow()
ll_id_sog=dw_1.getitemnumber(a, "id_sog_commerciale")
dw_1.setfilter("scegli='1'")
dw_1.filter()
for i= 1 to dw_1.rowcount()
	dw_1.setitem(i, "id_sog_commerciale", ll_id_sog)
next
dw_1.setfilter("")
dw_1.filter()
end event

type cb_pulisci from commandbutton within w_cambia_fornitore_articolo
integer x = 64
integer y = 1512
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci DW"
end type

event clicked;



if messagebox("Attenzione!", "Si sta per effettuare la pulizia della DW qui sopra! Continuare?",&
stopsign!, yesno!)=1 then
	dw_1.reset()
	if dw_1.title="Articoli non cancellati" then
		dw_1.title="Articoli da modificare"
	end if
end if
end event

type cb_ricopia_prod from commandbutton within w_cambia_fornitore_articolo
integer x = 2267
integer y = 1724
integer width = 544
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricopia Prod. Int. Sotto"
end type

event clicked;string ls_prod
integer i, a
a=dw_1.getrow()
ls_prod=dw_1.getitemstring(a, "prod_interna")
dw_1.setfilter("scegli='1'")
dw_1.filter()
for i= 1 to dw_1.rowcount()
	dw_1.setitem(i, "prod_interna", ls_prod)
next
dw_1.setfilter("")
dw_1.filter()

end event

type cb_sel_tutto from commandbutton within w_cambia_fornitore_articolo
integer x = 1710
integer y = 1580
integer width = 544
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scegli tutto"
end type

event clicked;
integer i

for i= 1 to dw_1.rowcount()
	dw_1.setitem(i, "scegli", '1')
next

end event

type cb_1 from commandbutton within w_cambia_fornitore_articolo
integer x = 2281
integer y = 1580
integer width = 544
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Azzera Scelta"
end type

event clicked;
integer i

for i= 1 to dw_1.rowcount()
	dw_1.setitem(i, "scegli", '0')
next

end event

