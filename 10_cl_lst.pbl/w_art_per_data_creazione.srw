forward
global type w_art_per_data_creazione from w_semplice_gd
end type
type dw_2 from udw_000 within w_art_per_data_creazione
end type
end forward

global type w_art_per_data_creazione from w_semplice_gd
integer width = 3835
integer height = 1808
string title = "Ultimi Articoli Inseriti"
dw_2 dw_2
end type
global w_art_per_data_creazione w_art_per_data_creazione

event open;dw_2.insertrow(1)

dw_1.settransobject(sqlca)

post event ue_postopen()


end event

on w_art_per_data_creazione.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_art_per_data_creazione.destroy
call super::destroy
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;date ldt_da_data, ldt_a_data
string ls_a_data, ls_da_data, ls_filtro

ldt_da_data=relativedate(today(), -30)
dw_2.setitem(1, "da_data",ldt_da_data )

ldt_a_data=dw_2.getitemdate(1, "a_data")

ls_a_data=string(relativedate(ldt_a_data, 1), "yyyy/mm/dd") 
ls_da_data=string(ldt_da_data, "yyyy/mm/dd") 

ls_filtro="data_ora_creazione <= date('"+ls_a_data+"') and data_ora_creazione >= date('"+ls_da_data+"')"
dw_1.setfilter(ls_filtro)
dw_1.filter()
dw_1.retrieve()
ls_a_data=string(ldt_a_data, "dd/mm/yyyy") 
ls_da_data=string(ldt_da_data, "dd/mm/yyyy") 
dw_1.modify("t_1.text='Articoli Inseriti dal "+ls_da_data+" al "+ls_a_data+"'")
end event

event resize;call super::resize;dw_2.y=newheight - 224
dw_2.x=cb_stampa.x - 300
cb_stampa.x=cb_inserisci.x
cb_stampa.y=cb_inserisci.y
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_art_per_data_creazione
integer y = 1600
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_per_data_creazione
integer y = 1600
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_per_data_creazione
integer y = 1468
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_per_data_creazione
integer y = 1468
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_per_data_creazione
integer y = 1468
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_per_data_creazione
integer y = 1468
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_per_data_creazione
integer width = 3671
integer height = 1388
string title = ""
string dataobject = "d_art_per_data_creazione"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_per_data_creazione
boolean visible = false
integer y = 1452
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_per_data_creazione
boolean visible = false
integer y = 1452
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_per_data_creazione
boolean visible = false
integer y = 1452
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_per_data_creazione
integer y = 1456
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_per_data_creazione
integer y = 1456
end type

type dw_2 from udw_000 within w_art_per_data_creazione
integer x = 1673
integer y = 1436
integer width = 882
integer height = 204
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_da_data_a_Data_bol2"
end type

event itemchanged;call super::itemchanged;date ldt_da_data, ldt_a_data
string ls_a_data, ls_filtro,ls_da_data

if dwo.name="da_data" then
	ldt_da_data=date(data)
	ldt_a_data=dw_2.getitemdate(1, "a_data")
else
	ldt_a_data=date(data)
	ldt_da_data=dw_2.getitemdate(1, "da_data")
end if

ls_a_data=string(relativedate(ldt_a_data, 1), "yyyy/mm/dd") 
//ls_da_data=string(relativedate(ldt_da_data, -1), "yyyy/mm/dd") 
ls_da_data=string(ldt_da_data, "yyyy/mm/dd") 
ls_filtro="data_ora_creazione <= date('"+ls_a_data+"') and data_ora_creazione >= datetime('"+ls_da_data+ "')"
dw_1.setfilter(ls_filtro)
dw_1.filter()
dw_1.retrieve()
ls_a_data=string(ldt_a_data, "dd/mm/yyyy") 
ls_da_data=string(ldt_da_data, "dd/mm/yyyy") 
dw_1.modify("t_1.text='Articoli Inseriti dal "+ls_da_data+" al "+ls_a_data+"'")
end event

