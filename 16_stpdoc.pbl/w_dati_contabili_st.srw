forward
global type w_dati_contabili_st from w_001
end type
type cb_annulla from commandbutton within w_dati_contabili_st
end type
type cb_stampa from commandbutton within w_dati_contabili_st
end type
type dw_1 from u_dw_ext_main within w_dati_contabili_st
end type
end forward

global type w_dati_contabili_st from w_001
integer width = 1697
integer height = 739
string title = "Stampa Dati Contabili"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
cb_annulla cb_annulla
cb_stampa cb_stampa
dw_1 dw_1
end type
global w_dati_contabili_st w_dati_contabili_st

on w_dati_contabili_st.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.dw_1
end on

on w_dati_contabili_st.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.dw_1)
end on

event open;long ll_id_ese
date ldt_data_inizio

dw_1.settransobject(sqlca)
dw_1.insertrow(1)

select id_esercizio_proposto
into :ll_id_ese
from azienda
;
dw_1.setitem(1, "id_esercizio", ll_id_ese)

select data_inizio
into :ldt_data_inizio
from dba.esercizio
where id_esercizio=:ll_id_ese
;
dw_1.setitem(1, "da_data", ldt_data_inizio)

dw_1.setitem(1, "tipo_stampa", "d_dati_contabili_rpt")


end event

type st_1 from w_001`st_1 within w_dati_contabili_st
end type

type cb_annulla from commandbutton within w_dati_contabili_st
integer x = 18
integer y = 19
integer width = 249
integer height = 109
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_dati_contabili_st
integer x = 1375
integer y = 19
integer width = 249
integer height = 109
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

s_par.ll_magazzino=dw_1.getitemnumber(1, "id_esercizio")

select codice
into :ls_cod_esercizio
from esercizio
where id_esercizio=:s_par.ll_magazzino;

s_par.da_sog_comm=dw_1.getitemstring(1, "da_conto")
s_par.a_sog_comm=dw_1.getitemstring(1, "a_conto")

s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")

s_par.tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")

s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - da Conto: "+s_par.da_sog_comm
end if
if s_par.a_sog_comm>"" then
	s_par.filtro+= " - a Conto: "+s_par.a_sog_comm
end if

openwithparm(w_dati_contabili_rpt, s_par)
end event

type dw_1 from u_dw_ext_main within w_dati_contabili_st
integer x = 18
integer y = 157
integer width = 1602
integer height = 435
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dati_contabili_st"
end type

event itemchanged;call super::itemchanged;string ls_id_conto

choose case string(dwo.name)
	case "da_conto"
		ls_id_conto=getitemstring(row, "a_conto")
		if isnull(ls_id_conto) then
			setitem(row, "a_conto", data)
		end if
		
end choose
end event

