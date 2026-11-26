forward
global type w_tot_magazzino_st from w_001
end type
type dw_2 from udw_base within w_tot_magazzino_st
end type
type cb_salva_dw from commandbutton within w_tot_magazzino_st
end type
type cb_inserisci_dw from commandbutton within w_tot_magazzino_st
end type
type cb_cancella_dw from commandbutton within w_tot_magazzino_st
end type
type cb_pulisci from commandbutton within w_tot_magazzino_st
end type
type cb_stampa from commandbutton within w_tot_magazzino_st
end type
type dw_1 from u_dw_ext_main within w_tot_magazzino_st
end type
type dw_3 from udw_base within w_tot_magazzino_st
end type
type ddplb_tipo_stampa from dropdownpicturelistbox within w_tot_magazzino_st
end type
end forward

global type w_tot_magazzino_st from w_001
integer width = 3433
integer height = 1328
dw_2 dw_2
cb_salva_dw cb_salva_dw
cb_inserisci_dw cb_inserisci_dw
cb_cancella_dw cb_cancella_dw
cb_pulisci cb_pulisci
cb_stampa cb_stampa
dw_1 dw_1
dw_3 dw_3
ddplb_tipo_stampa ddplb_tipo_stampa
end type
global w_tot_magazzino_st w_tot_magazzino_st

type variables
udw_base i_udw
end variables

on w_tot_magazzino_st.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_salva_dw=create cb_salva_dw
this.cb_inserisci_dw=create cb_inserisci_dw
this.cb_cancella_dw=create cb_cancella_dw
this.cb_pulisci=create cb_pulisci
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
this.dw_3=create dw_3
this.ddplb_tipo_stampa=create ddplb_tipo_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_salva_dw
this.Control[iCurrent+3]=this.cb_inserisci_dw
this.Control[iCurrent+4]=this.cb_cancella_dw
this.Control[iCurrent+5]=this.cb_pulisci
this.Control[iCurrent+6]=this.cb_stampa
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.ddplb_tipo_stampa
end on

on w_tot_magazzino_st.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_salva_dw)
destroy(this.cb_inserisci_dw)
destroy(this.cb_cancella_dw)
destroy(this.cb_pulisci)
destroy(this.cb_stampa)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.ddplb_tipo_stampa)
end on

event open;call super::open;date ld_data, ldt_da_data
dw_1.settransobject(sqlca)
dw_1.insertrow(1)
dw_2.settransobject(sqlca)
dw_2.retrieve()
dw_3.settransobject(sqlca)
dw_3.retrieve()
ld_data=today()
select data_inizio
into :ldt_da_data
from esercizio
where data_inizio<= :ld_data
and data_fine>=:ld_data
;


dw_1.setitem(1, "da_data", ldt_da_data)
dw_1.setitem(1, "a_data", ld_data)
end event

type st_1 from w_001`st_1 within w_tot_magazzino_st
end type

type dw_2 from udw_base within w_tot_magazzino_st
integer x = 1906
integer y = 152
integer width = 1518
integer height = 1044
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_tot_magazzino_gd"
end type

event getfocus;call super::getfocus;i_udw=this
end event

event ue_key;choose case key
	case keydelete!
		cb_cancella_dw.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci_dw.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella_dw.triggerevent(clicked!)
		end if			
     case KeyS!
		if (keyFlags=2) then
			cb_salva_dw.triggerevent(clicked!)		
		end if
	case KeyF12!
		cb_salva_dw.triggerevent(clicked!)		
	
end choose
end event

event ue_insert;call super::ue_insert;long  ll_cod
if ancestorreturnvalue>1 then
	ll_cod=getitemnumber(ancestorreturnvalue - 1, "id_tot_magazzino")
	setitem(ancestorreturnvalue, "id_tot_magazzino", ll_cod)
	setcolumn("id_tot_magazzino")
end if
return ancestorreturnvalue
end event

type cb_salva_dw from commandbutton within w_tot_magazzino_st
integer x = 1381
integer y = 16
integer width = 247
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_2.accepttext()
dw_3.accepttext()
if isvalid(i_udw) then
i_udw.triggerevent("ue_update")
end if
end event

type cb_inserisci_dw from commandbutton within w_tot_magazzino_st
integer x = 1051
integer y = 16
integer width = 247
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;if isvalid(i_udw) then
	i_udw.trigger event ue_insert(0)
	
end if
end event

type cb_cancella_dw from commandbutton within w_tot_magazzino_st
integer x = 1710
integer y = 16
integer width = 247
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga
if isvalid(i_udw) then
ll_riga=i_udw.getrow()
if ll_riga>0 then
	i_udw.trigger event ue_delete(ll_riga)
end if
end if
end event

type cb_pulisci from commandbutton within w_tot_magazzino_st
integer x = 2039
integer y = 16
integer width = 357
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella Tutto"
end type

event clicked;if isvalid(i_udw) then
	i_udw.trigger event ue_delete(0)
end if
end event

type cb_stampa from commandbutton within w_tot_magazzino_st
integer x = 2478
integer y = 16
integer width = 247
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;dw_1.accepttext()
dw_2.accepttext()
dw_3.accepttext()
dw_3.triggerevent("ue_update")
dw_2.triggerevent("ue_update")
s_param_articoli s_par

s_par.da_data=dw_1.getitemdate(1, "da_data")
s_par.a_data=dw_1.getitemdate(1, "a_data")
if s_par.da_data>s_par.a_data then
	messagebox("Attenzione!", "Date Incongruenti!")
	return
end if
if isnull(s_par.da_data) or isnull(s_par.a_data) then
	messagebox("Attenzione!", "Le Date devono essere specificate!")
	return
end if
s_par.solo_preziosi=dw_3.getitemstring(1, "solo_preziosi")
s_par.tipo_stampa=ddplb_tipo_stampa.text
openwithparm(w_tot_magazzino_rpt, s_par)
end event

type dw_1 from u_dw_ext_main within w_tot_magazzino_st
integer x = 23
integer y = 24
integer width = 1024
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_tot_mag_data_tb"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event getfocus;
end event

type dw_3 from udw_base within w_tot_magazzino_st
integer x = 14
integer y = 152
integer width = 1874
integer height = 1044
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_tot_mag_configurazione_gd"
end type

event getfocus;call super::getfocus;i_udw=this
end event

event ue_key;choose case key
	case keydelete!
		cb_cancella_dw.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci_dw.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella_dw.triggerevent(clicked!)
		end if			
     case KeyS!
		if (keyFlags=2) then
			cb_salva_dw.triggerevent(clicked!)		
		end if
	case KeyF12!
		cb_salva_dw.triggerevent(clicked!)		
	
end choose
end event

event ue_insert;call super::ue_insert;string ls_cod
if ancestorreturnvalue>0 then
	
	setitem(ancestorreturnvalue, "ordine",ancestorreturnvalue )
	setcolumn("descrizione")
end if
return ancestorreturnvalue
end event

type ddplb_tipo_stampa from dropdownpicturelistbox within w_tot_magazzino_st
integer x = 2761
integer y = 16
integer width = 590
integer height = 352
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {"d_dett_tot_mag_tb"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1}
long picturemaskcolor = 536870912
end type

