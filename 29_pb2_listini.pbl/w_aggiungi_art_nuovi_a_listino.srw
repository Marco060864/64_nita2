forward
global type w_aggiungi_art_nuovi_a_listino from w_semplice_gd
end type
type dw_2 from udw_000 within w_aggiungi_art_nuovi_a_listino
end type
type cb_riporta_prezzi from commandbutton within w_aggiungi_art_nuovi_a_listino
end type
end forward

global type w_aggiungi_art_nuovi_a_listino from w_semplice_gd
integer width = 3598
dw_2 dw_2
cb_riporta_prezzi cb_riporta_prezzi
end type
global w_aggiungi_art_nuovi_a_listino w_aggiungi_art_nuovi_a_listino

on w_aggiungi_art_nuovi_a_listino.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_riporta_prezzi=create cb_riporta_prezzi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_riporta_prezzi
end on

on w_aggiungi_art_nuovi_a_listino.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_riporta_prezzi)
end on

event open;dw_2.settransobject(sqlca)
dw_2.insertrow(1)

dw_1.settransobject(sqlca)

post event ue_postopen()
end event

event ue_postopen;call super::ue_postopen;date ldt_da_data, ldt_a_data
long ll_id_variazione, ll_id_var_partenza

ldt_da_data=relativedate(today(), -30)
dw_2.setitem(1, "da_data",ldt_da_data )

ldt_a_data=dw_2.getitemdate(1, "a_data")

ll_id_variazione=dw_2.getitemnumber(1, "id_variazione")

ll_id_var_partenza=dw_2.getitemnumber(1, "id_variazione_2")
dw_1.retrieve(ldt_da_data, ldt_a_data, ll_id_var_partenza , ll_id_variazione)

dw_1.modify("t_1.text='Articoli Inseriti dal "+string(ldt_da_data, "dd/mm/yyyy")+" al "+string(ldt_a_data, "dd/mm/yyyy")+"'")
end event

event resize;call super::resize;dw_1.height=newheight - 292 - 220

cb_riporta_prezzi.x=cb_stampa.x + cb_stampa.width + 50
cb_riporta_prezzi.y=cb_stampa.y 
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_aggiungi_art_nuovi_a_listino
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_aggiungi_art_nuovi_a_listino
end type

type cb_primo from w_semplice_gd`cb_primo within w_aggiungi_art_nuovi_a_listino
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_aggiungi_art_nuovi_a_listino
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_aggiungi_art_nuovi_a_listino
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_aggiungi_art_nuovi_a_listino
end type

type dw_1 from w_semplice_gd`dw_1 within w_aggiungi_art_nuovi_a_listino
integer y = 276
string title = "Aggiungi Articoli a Listino"
string dataobject = "d_articoli_nuovi_non_in_listino"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_aggiungi_art_nuovi_a_listino
end type

type cb_salva from w_semplice_gd`cb_salva within w_aggiungi_art_nuovi_a_listino
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_aggiungi_art_nuovi_a_listino
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_aggiungi_art_nuovi_a_listino
end type

type cb_ok from w_semplice_gd`cb_ok within w_aggiungi_art_nuovi_a_listino
end type

type dw_2 from udw_000 within w_aggiungi_art_nuovi_a_listino
integer x = 27
integer y = 20
integer width = 3497
integer height = 244
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_filtri_data_variazione"
boolean resizable = true
end type

event itemchanged;call super::itemchanged;date ldt_da_data, ldt_a_data
long ll_id_variazione,ll_id_var_partenza

if dwo.name="da_data" then
	ldt_da_data=date(data)
	ldt_a_data=dw_2.getitemdate(1, "a_data")
else
	ldt_a_data=date(data)
	ldt_da_data=dw_2.getitemdate(1, "da_data")
end if

ll_id_variazione=dw_2.getitemnumber(1, "id_variazione")

ll_id_var_partenza=dw_2.getitemnumber(1, "id_variazione_2")
dw_1.retrieve(ldt_da_data, ldt_a_data, ll_id_var_partenza, ll_id_variazione )

dw_1.modify("t_1.text='Articoli Inseriti dal "+string(ldt_da_data, "dd/mm/yyyy")+" al "+string(ldt_a_data, "dd/mm/yyyy")+"'")
end event

type cb_riporta_prezzi from commandbutton within w_aggiungi_art_nuovi_a_listino
integer x = 1207
integer y = 1132
integer width = 416
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Riporta Prezzi"
end type

event clicked;long ll_id_variazione, ll_id_unita_confezione
integer i, a=0
decimal ldc_prezzo, ldc_percentuale, ldc_coef, ldc_ok
string ls_test, ls_agisci_su



ll_id_variazione=dw_2.getitemnumber(1, "id_variazione_2")
ls_agisci_su=dw_2.getitemstring(1, "agisci_su")
ldc_percentuale=dw_2.getitemdecimal(1, "varia_percentuale")
if ldc_percentuale<>0 then
	ldc_coef=ldc_percentuale
	ls_test="%"
else
	ldc_coef=dw_2.getitemdecimal(1, "varia_importo")
	ls_test="I"
end if
messagebox("Attenzione!", "Se l'articolo NON ha prezzo nel listino di partenza sarà INSERITO nel listino di destinazione con PREZZO = 0!")
for i = 1 to dw_1.rowcount()
	ldc_prezzo=dw_1.getitemdecimal(i, "c_prezzo_partenza")
	//if ldc_prezzo>0 then
	if isnull(ldc_prezzo) then ldc_prezzo=0
		if ls_test="%" then
			ldc_ok=ldc_prezzo*ldc_coef/100
		else
			ldc_ok=ldc_prezzo + ldc_coef
		end if
		
		ll_id_unita_confezione=dw_1.getitemnumber(i, "id_unita_confezione")
		
		if ls_agisci_su='N' or  ls_agisci_su='E' then //prezzo al pezzo
			insert dba.prezzo (id_unita_confezione, id_variazione, prezzo)
			values (:ll_id_unita_confezione, :ll_id_variazione, :ldc_ok)
			;
		end if
		if ls_agisci_su='G' or  ls_agisci_su='E' then//prezzo al grammo
			insert dba.prezzo (id_unita_confezione, id_variazione, prezzo_manifattura)
			values (:ll_id_unita_confezione, :ll_id_variazione, :ldc_ok)
			;
		end if
		if sqlca.sqlcode=0 then
			commit;
			dw_1.setitem(i, "c_prezzo_destinazione", ldc_ok)
		else
			rollback;
			messagebox("Attenzione!", "AHI")
		end if
//	else
//		if a=0 then messagebox("Attenzione!", "Se l'articolo NON ha prezzo nel listino di partenza NON potrà essere inserito nel listino di destinazione!")
//		a=1
//	end if
next
end event

