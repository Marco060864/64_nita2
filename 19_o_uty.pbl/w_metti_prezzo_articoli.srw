forward
global type w_metti_prezzo_articoli from w_001
end type
type dw_1 from udw_base within w_metti_prezzo_articoli
end type
type dw_2 from udw_base within w_metti_prezzo_articoli
end type
type cb_1 from commandbutton within w_metti_prezzo_articoli
end type
type cb_salva from commandbutton within w_metti_prezzo_articoli
end type
type cb_retrieve from commandbutton within w_metti_prezzo_articoli
end type
type cb_2 from commandbutton within w_metti_prezzo_articoli
end type
type dw_3 from udw_base within w_metti_prezzo_articoli
end type
end forward

global type w_metti_prezzo_articoli from w_001
integer width = 4073
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
cb_salva cb_salva
cb_retrieve cb_retrieve
cb_2 cb_2
dw_3 dw_3
end type
global w_metti_prezzo_articoli w_metti_prezzo_articoli

event open;call super::open;DataWindowChild dwc_dati
integer rtncode

dw_1.SETTRANSOBJECT(SQLCA)
dw_3.settransobject(sqlca)

rtncode = dw_1.GetChild('variazione', dwc_dati)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


DW_1.INSERTROW(1)

dw_2.SETTRANSOBJECT(SQLCA)
DW_2.RETRIEVE()

end event

on w_metti_prezzo_articoli.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_salva=create cb_salva
this.cb_retrieve=create cb_retrieve
this.cb_2=create cb_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_retrieve
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.dw_3
end on

on w_metti_prezzo_articoli.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_salva)
destroy(this.cb_retrieve)
destroy(this.cb_2)
destroy(this.dw_3)
end on

type st_1 from w_001`st_1 within w_metti_prezzo_articoli
end type

type dw_1 from udw_base within w_metti_prezzo_articoli
integer x = 2432
integer y = 8
integer width = 1449
integer height = 212
boolean bringtotop = true
string dataobject = "d_rec_var_e_prezzo"
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_2 from udw_base within w_metti_prezzo_articoli
integer x = 64
integer y = 576
integer width = 3950
integer height = 836
boolean bringtotop = true
string dataobject = "d_art_senza_prezzo"
end type

type cb_1 from commandbutton within w_metti_prezzo_articoli
integer x = 3557
integer y = 268
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
string text = "OK"
end type

event clicked;close(paRENT)
end event

type cb_salva from commandbutton within w_metti_prezzo_articoli
integer x = 2405
integer y = 268
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SALVA"
end type

event clicked;

if DW_3.TRIGGER EVENT ue_update()=1 then
	messagebox("OK!", "Salvataggio riuscito!")
else
	messagebox("AHI!", "Salvataggio NON riuscito!")
end if
end event

type cb_retrieve from commandbutton within w_metti_prezzo_articoli
integer x = 3173
integer y = 268
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RICARICA"
end type

event clicked;DW_2.RETRIEVE()
end event

type cb_2 from commandbutton within w_metti_prezzo_articoli
integer x = 2789
integer y = 268
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Metti Prezzi"
end type

event clicked;integer i, li_pos
long ll_id_var, ll_id_uc, ll_riga_inserita
decimal ldc_prezzo
string ls_inizio_codice, ls_cod_art

DW_3.RESET()
DW_1.ACCEPTTEXT()

ls_inizio_codice=upper(dw_1.getitemstring(1, "ini_codice"))
ll_id_var=dw_1.getitemnumber(1, "variazione")
ldc_prezzo=dw_1.getitemdecimal(1, "prezzo")

if ldc_prezzo> 0 and ll_id_var>0 and ls_inizio_codice> " " then

	for i =1 to dw_2.rowcount()
		ls_cod_art=upper(dw_2.getitemstring(i, "articolo_codice"))
		li_pos=pos(ls_cod_art, ls_inizio_codice, 1)
		if li_pos>0 then
			ll_riga_inserita=dw_3.insertrow(0)
			dw_3.setitem(ll_riga_inserita, "id_variazione", ll_id_var)
			ll_id_uc=dw_2.getitemnumber(i, "unita_confezione_id_unita_confezione")
			dw_3.setitem(ll_riga_inserita, "id_unita_confezione", ll_id_uc)
			dw_3.setitem(ll_riga_inserita, "prezzo", ldc_prezzo)
		end if
	next
end if
end event

type dw_3 from udw_base within w_metti_prezzo_articoli
integer x = 82
integer y = 12
integer width = 2304
integer height = 540
boolean bringtotop = true
string dataobject = "d_salva_prezzo"
boolean vscrollbar = false
boolean livescroll = false
end type

