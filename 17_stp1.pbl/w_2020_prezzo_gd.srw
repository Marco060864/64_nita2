forward
global type w_2020_prezzo_gd from w_selezione_stampa
end type
type dw_2 from udw_001 within w_2020_prezzo_gd
end type
type dw_3 from udw_001 within w_2020_prezzo_gd
end type
type dw_4 from udw_001 within w_2020_prezzo_gd
end type
type rr_1 from roundrectangle within w_2020_prezzo_gd
end type
end forward

global type w_2020_prezzo_gd from w_selezione_stampa
integer width = 2213
integer height = 1244
boolean maxbox = false
boolean resizable = false
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
rr_1 rr_1
end type
global w_2020_prezzo_gd w_2020_prezzo_gd

event open;datawindowchild ldw_sog_comm, ldw_metallo, ldw_cat_codifica
string ls_cod
date ld_data
long ll_righe

dw_1.getchild("id_variazione", ldw_sog_comm)
ldw_sog_comm.settransobject(sqlca)
ll_righe=ldw_sog_comm.retrieve()

dw_1.getchild("cat_commerciale", ldw_metallo)
ldw_metallo.settransobject(sqlca)
ll_righe=ldw_metallo.retrieve()

dw_1.getchild("id_cat_codifica", ldw_cat_codifica)
ldw_cat_codifica.settransobject(sqlca)
ll_righe=ldw_cat_codifica.retrieve()

dw_1.insertrow(1)
dw_3.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_4.settransobject(sqlca)

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
end event

on w_2020_prezzo_gd.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.rr_1
end on

on w_2020_prezzo_gd.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.rr_1)
end on

event ue_postopen;//
end event

type cb_1 from w_selezione_stampa`cb_1 within w_2020_prezzo_gd
integer x = 1486
integer y = 384
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_2020_prezzo_gd
integer x = 1486
integer y = 64
end type

event cb_stampa::clicked;call super::clicked;date ld_da_data,ld_a_data
s_new_scheda_mag s_new_mag
long ll_id_sog
dw_1.accepttext()
string ls_parametri
integer i

//ld_da_data=dw_1.getitemdate(1,"da_data")
//ld_a_data=dw_1.getitemdate(1,"a_data")
//if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
//if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "
//


//If ld_da_data > ld_a_data then
//	MessageBox("Stampa Fatturato","La data iniziale è maggiore di quella finale",exclamation!)
//	Return
//End If


//s_new_mag.da_data=ld_da_data
//s_new_mag.a_data=ld_a_data
s_new_mag.id_sog_commerciale=dw_1.getitemnumber(1, "id_variazione")
s_new_mag.tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
//s_new_mag.tipo_sog=dw_1.getitemstring(1, "tipo_sog")
//str_param.coef_calo=dw_1.getitemdecimal(1, "aliquota_ritenuta")
s_new_mag.sel_causali=dw_1.getitemstring(1, "solo_con_prezzo")
for i=1 to dw_2.rowcount()
	s_new_mag.id_caus_magazzino[i]=dw_2.getitemnumber(i, "id_cat_com")
next
for i=1 to dw_3.rowcount()
	s_new_mag.id_vettore[i]=dw_3.getitemnumber(i, "id_cat_codifica")
next
for i=1 to dw_4.rowcount()
	s_new_mag.id_vettore2[i]=dw_4.getitemnumber(i, "id_cat_codifica")
next
//s_new_mag.id_caus_magazzino[1]=dw_1.getitemnumber(1, "cat_commerciale")
//s_new_mag.id_caus_magazzino[2]=dw_1.getitemnumber(1, "id_cat_codifica")
//if isnull(s_new_mag.metallo) or s_new_mag.metallo<=" " then
//	MessageBox("Stampa Magazzino","Devi obbligatoriamente scegliere un metallo!",exclamation!)
//	return
//end if

//s_new_mag.filtro=ls_parametri
OpenWithParm(w_2020_prezzo_rpt, s_new_mag)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_2020_prezzo_gd
integer x = 46
integer width = 1413
integer height = 492
string dataobject = "d_2020_prezzo"
end type

event dw_1::doubleclicked;//
end event

event dw_1::itemfocuschanged;//
end event

event dw_1::losefocus;//
end event

event dw_1::rowfocuschanged;//
end event

type dw_2 from udw_001 within w_2020_prezzo_gd
integer x = 709
integer y = 576
integer width = 645
integer height = 496
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ext_2020_comm"
end type

type dw_3 from udw_001 within w_2020_prezzo_gd
integer x = 41
integer y = 576
integer width = 645
integer height = 496
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ext_2020_codifica"
end type

type dw_4 from udw_001 within w_2020_prezzo_gd
integer x = 1477
integer y = 560
integer width = 667
integer height = 548
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Tutte meno queste"
string dataobject = "d_ext_2020_codifica"
boolean maxbox = false
end type

type rr_1 from roundrectangle within w_2020_prezzo_gd
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 5
integer y = 556
integer width = 1403
integer height = 552
integer cornerheight = 40
integer cornerwidth = 46
end type

