forward
global type w_new_scheda_magazzino_b from w_selezione_stampa
end type
end forward

global type w_new_scheda_magazzino_b from w_selezione_stampa
integer width = 1545
integer height = 1088
boolean maxbox = false
boolean resizable = false
end type
global w_new_scheda_magazzino_b w_new_scheda_magazzino_b

event open;call super::open;datawindowchild ldw_sog_comm, ldw_metallo, ldw_magazzino, ldw_articolo

string ls_cod
date ld_data
long ll_righe

dw_1.getchild("id_sog_comm", ldw_sog_comm)
ldw_sog_comm.settransobject(sqlca)
ll_righe=ldw_sog_comm.retrieve()

dw_1.getchild("metallo", ldw_metallo)
ldw_metallo.settransobject(sqlca)
ll_righe=ldw_metallo.retrieve()

dw_1.getchild("id_locazione", ldw_magazzino)
ldw_magazzino.settransobject(sqlca)
ll_righe=ldw_magazzino.retrieve()

dw_1.getchild("id_articolo", ldw_articolo)
ldw_articolo.settransobject(sqlca)
ll_righe=ldw_articolo.retrieve()



dw_1.insertrow(1)


ld_data=today()
dw_1.setitem(1, "a_data", ld_data)
select data_inizio
into :ld_data
from esercizio 
where data_inizio<=:ld_data
and data_fine>=:ld_data
;
if sqlca.sqlcode=0 then
	dw_1.setitem(1, "solo_preziosi",ls_cod)
	dw_1.setitem(1, "da_data", ld_data)
else
	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio corrente in dati azienda")
end if
dw_1.setitem(1, "tipo_stampa", "d_new_scheda_mag_per_articolo_b")
end event

on w_new_scheda_magazzino_b.create
call super::create
end on

on w_new_scheda_magazzino_b.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;datawindowchild ldw_dest
long ll_righe, ll_id_sog

dw_1.getchild("destinazione", ldw_dest)
ldw_dest.settransobject(sqlca)
ll_id_sog=dw_1.getitemnumber(1, "id_sog_comm")
if ll_id_sog>0 then
	ll_righe=ldw_dest.retrieve(ll_id_sog)
end if
end event

type cb_1 from w_selezione_stampa`cb_1 within w_new_scheda_magazzino_b
integer x = 64
integer y = 812
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_new_scheda_magazzino_b
integer x = 997
integer y = 812
end type

event cb_stampa::clicked;call super::clicked;date ld_da_data,ld_a_data
s_new_scheda_mag s_new_mag
long ll_id_sog
dw_1.accepttext()
string ls_parametri, ls_mag, ls_rag_soc

ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "
If ld_da_data > ld_a_data then
	MessageBox("Stampa Fatturato","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If
s_new_mag.da_data=ld_da_data
s_new_mag.a_data=ld_a_data
s_new_mag.id_sog_commerciale=dw_1.getitemnumber(1, "id_sog_comm")
Select rag_soc_1 into :ls_rag_soc from dba.sog_commerciale_gen where id_sog_commerciale=:s_new_mag.id_sog_commerciale;
if ls_rag_soc> " " then ls_parametri+=" - Per: "+left(ls_rag_soc, 10)
s_new_mag.tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
s_new_mag.id_destinazione=dw_1.getitemnumber(1, "id_locazione")
//str_param.coef_calo=dw_1.getitemdecimal(1, "aliquota_ritenuta")
s_new_mag.sel_causali=dw_1.getitemstring(1, "sel_causali")
s_new_mag.metallo=dw_1.getitemstring(1, "metallo")
s_new_mag.id_articolo=dw_1.getitemnumber(1, "id_articolo")
//if isnull(s_new_mag.metallo) or s_new_mag.metallo<=" " then
//	MessageBox("Stampa Magazzino","Devi obbligatoriamente scegliere un metallo!",exclamation!)
//	return
//end if
if s_new_mag.metallo> " " then ls_parametri+=" - Metallo: "+s_new_mag.metallo
if s_new_mag.id_destinazione>0 then //è il magazzino
	select m.codice into :ls_mag from dba.magazzino m, dba.locazione l 
	where m.id_magazzino=l.id_magazzino
	and id_locazione=:s_new_mag.id_destinazione
	;
//	if isnull(ls_rag_destinazione) then ls_rag_destinazione=""
	ls_parametri+=" - Magazzino: "+ls_mag
end if
s_new_mag.filtro=ls_parametri
s_new_mag.fiscale=dw_1.getitemnumber(1, "fiscale")
OpenWithParm(w_new_scheda_magazzino_b_rpt, s_new_mag)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_new_scheda_magazzino_b
integer width = 1330
integer height = 736
string dataobject = "d_new_scheda_mag_b_st"
end type

event dw_1::doubleclicked;//
end event

event dw_1::itemfocuschanged;//
end event

event dw_1::losefocus;//
end event

event dw_1::rowfocuschanged;//
end event

event dw_1::itemchanged;call super::itemchanged;datawindowchild ldw_dest
long ll_righe

if dwo.name="id_sog_comm" then
	dw_1.getchild("destinazione", ldw_dest)
	ldw_dest.settransobject(sqlca)
	ll_righe=ldw_dest.retrieve(long(data))
end if
end event

