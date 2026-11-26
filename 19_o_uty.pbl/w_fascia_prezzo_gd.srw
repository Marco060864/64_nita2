forward
global type w_fascia_prezzo_gd from w_001
end type
type dw_1 from udw_base within w_fascia_prezzo_gd
end type
type cb_cancella from commandbutton within w_fascia_prezzo_gd
end type
type cb_inserisci from commandbutton within w_fascia_prezzo_gd
end type
type cb_salva from commandbutton within w_fascia_prezzo_gd
end type
type cb_esci from commandbutton within w_fascia_prezzo_gd
end type
type st_2 from statictext within w_fascia_prezzo_gd
end type
type st_3 from statictext within w_fascia_prezzo_gd
end type
type dw_2 from udw_base within w_fascia_prezzo_gd
end type
type dw_3 from udw_base within w_fascia_prezzo_gd
end type
type cb_stampa from commandbutton within w_fascia_prezzo_gd
end type
type dw_4 from udw_base within w_fascia_prezzo_gd
end type
type cb_1 from commandbutton within w_fascia_prezzo_gd
end type
type cb_2 from commandbutton within w_fascia_prezzo_gd
end type
type cb_3 from commandbutton within w_fascia_prezzo_gd
end type
type cb_4 from commandbutton within w_fascia_prezzo_gd
end type
type dw_5 from udw_base within w_fascia_prezzo_gd
end type
type st_4 from statictext within w_fascia_prezzo_gd
end type
type cb_crea from commandbutton within w_fascia_prezzo_gd
end type
type cbx_1 from checkbox within w_fascia_prezzo_gd
end type
type st_5 from statictext within w_fascia_prezzo_gd
end type
type cb_aggiorna from commandbutton within w_fascia_prezzo_gd
end type
type cbx_2 from checkbox within w_fascia_prezzo_gd
end type
type sle_1 from singlelineedit within w_fascia_prezzo_gd
end type
type st_6 from statictext within w_fascia_prezzo_gd
end type
type ln_1 from line within w_fascia_prezzo_gd
end type
end forward

global type w_fascia_prezzo_gd from w_001
integer width = 3035
integer height = 2688
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
cb_cancella cb_cancella
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_esci cb_esci
st_2 st_2
st_3 st_3
dw_2 dw_2
dw_3 dw_3
cb_stampa cb_stampa
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
dw_5 dw_5
st_4 st_4
cb_crea cb_crea
cbx_1 cbx_1
st_5 st_5
cb_aggiorna cb_aggiorna
cbx_2 cbx_2
sle_1 sle_1
st_6 st_6
ln_1 ln_1
end type
global w_fascia_prezzo_gd w_fascia_prezzo_gd

event open;call super::open;//dw_8.settransobject(sqlca)
//dw_7.settransobject(sqlca)
//dw_6.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_2.insertrow(1)
dw_3.insertrow(1)
dw_4.retrieve()
dw_5.insertrow(1)
//dw_6.insertrow(1)
//dw_7.insertrow(1)
//dw_8.insertrow(1)
//dw_9.insertrow(1)
end event

on w_fascia_prezzo_gd.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_esci=create cb_esci
this.st_2=create st_2
this.st_3=create st_3
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_stampa=create cb_stampa
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_5=create dw_5
this.st_4=create st_4
this.cb_crea=create cb_crea
this.cbx_1=create cbx_1
this.st_5=create st_5
this.cb_aggiorna=create cb_aggiorna
this.cbx_2=create cbx_2
this.sle_1=create sle_1
this.st_6=create st_6
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancella
this.Control[iCurrent+3]=this.cb_inserisci
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_esci
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.cb_stampa
this.Control[iCurrent+11]=this.dw_4
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.cb_4
this.Control[iCurrent+16]=this.dw_5
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.cb_crea
this.Control[iCurrent+19]=this.cbx_1
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.cb_aggiorna
this.Control[iCurrent+22]=this.cbx_2
this.Control[iCurrent+23]=this.sle_1
this.Control[iCurrent+24]=this.st_6
this.Control[iCurrent+25]=this.ln_1
end on

on w_fascia_prezzo_gd.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_esci)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_stampa)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_5)
destroy(this.st_4)
destroy(this.cb_crea)
destroy(this.cbx_1)
destroy(this.st_5)
destroy(this.cb_aggiorna)
destroy(this.cbx_2)
destroy(this.sle_1)
destroy(this.st_6)
destroy(this.ln_1)
end on

type st_1 from w_001`st_1 within w_fascia_prezzo_gd
end type

type dw_1 from udw_base within w_fascia_prezzo_gd
integer x = 37
integer y = 12
integer width = 2354
integer height = 1292
boolean bringtotop = true
string dataobject = "d_fascia_prezzo_gd"
end type

event ue_key;call super::ue_key;choose case key	
case Keyadd!
		if (keyFlags=2) then
				triggerevent("ue_insert")
		end if
	
	case KeySubtract!
		if (keyFlags=2) then
						triggerevent("ue_delete")
		end if

	case KeyS!
		if (keyFlags=2) then
			triggerevent("ue_update")
		end if
end choose
end event

type cb_cancella from commandbutton within w_fascia_prezzo_gd
integer x = 2423
integer y = 400
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
string text = "Cancella"
end type

event clicked;long ll_riga

ll_riga=dw_1.getrow()
if ll_riga>0 then
	dw_1.trigger event ue_delete(ll_riga)
end if
end event

type cb_inserisci from commandbutton within w_fascia_prezzo_gd
integer x = 2423
integer y = 272
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
string text = "Inserisci"
end type

event clicked;dw_1.trigger event ue_insert(0)
end event

type cb_salva from commandbutton within w_fascia_prezzo_gd
integer x = 2423
integer y = 144
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
string text = "Salva"
end type

event clicked;dw_1.trigger event ue_update()
end event

type cb_esci from commandbutton within w_fascia_prezzo_gd
integer x = 2423
integer y = 16
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
string text = "Esci"
end type

event clicked;close(parent)
end event

type st_2 from statictext within w_fascia_prezzo_gd
integer x = 2446
integer y = 644
integer width = 466
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi solo Fascia"
boolean focusrectangle = false
end type

type st_3 from statictext within w_fascia_prezzo_gd
integer x = 2432
integer y = 832
integer width = 466
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi solo Listino "
boolean focusrectangle = false
end type

type dw_2 from udw_base within w_fascia_prezzo_gd
integer x = 2432
integer y = 720
integer height = 112
integer taborder = 20
boolean bringtotop = true
string dataobject = "D_LISTA_FASCIa_PREZZO_GD"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;STRING LS_FILTRO
if data>" " then
	LS_FILTRO="fascia='"+data+"'"
	dw_1.setfilter(LS_FILTRO)
	dw_1.filter()
else
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type dw_3 from udw_base within w_fascia_prezzo_gd
integer x = 2427
integer y = 896
integer height = 124
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_scegli_listino_gd"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;STRING LS_FILTRO
if data>" " then
	LS_FILTRO="id_listino= "+data
	dw_1.setfilter(LS_FILTRO)
	dw_1.filter()
else
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type cb_stampa from commandbutton within w_fascia_prezzo_gd
integer x = 2423
integer y = 528
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
string text = "Stampa"
end type

event clicked;dw_1.print()
end event

type dw_4 from udw_base within w_fascia_prezzo_gd
integer x = 37
integer y = 1360
integer width = 2354
integer height = 1004
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_fascia_agg_prezzo_gd"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_1 from commandbutton within w_fascia_prezzo_gd
integer x = 2427
integer y = 1808
integer width = 343
integer height = 100
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

event clicked;dw_4.trigger event ue_update()
end event

type cb_2 from commandbutton within w_fascia_prezzo_gd
integer x = 2427
integer y = 1932
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
string text = "Inserisci"
end type

event clicked;dw_4.trigger event ue_insert(0)
end event

type cb_3 from commandbutton within w_fascia_prezzo_gd
integer x = 2427
integer y = 2056
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
string text = "Cancella"
end type

event clicked;long ll_riga

ll_riga=dw_4.getrow()
if ll_riga>0 then
	dw_4.trigger event ue_delete(ll_riga)
end if
end event

type cb_4 from commandbutton within w_fascia_prezzo_gd
integer x = 2427
integer y = 2180
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
string text = "Stampa"
end type

event clicked;dw_1.print()
end event

type dw_5 from udw_base within w_fascia_prezzo_gd
integer x = 2414
integer y = 1440
integer height = 112
integer taborder = 30
boolean bringtotop = true
string dataobject = "D_LISTA_FASCIa_PREZZO_GD"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;STRING LS_FILTRO
if data>" " then
	LS_FILTRO="fascia='"+data+"'"
	dw_4.setfilter(LS_FILTRO)
	dw_4.filter()
else
	dw_4.setfilter("")
	dw_4.filter()
end if
end event

type st_4 from statictext within w_fascia_prezzo_gd
integer x = 2427
integer y = 1364
integer width = 466
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi solo Fascia"
boolean focusrectangle = false
end type

type cb_crea from commandbutton within w_fascia_prezzo_gd
integer x = 2427
integer y = 1676
integer width = 343
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea"
end type

event clicked;//si va a guardare nella tabella fascia_prezzo, se la fascia esiste con il listino di arrivo
//allora si aggiorna solo il prezzo calcolato, altrimenti si inserisce

string ls_fascia, ls_find, ls_segno
decimal ldc_prezzo, ldc_valore
long ll_id_listino_arrivo, ll_riga_trovata,ll_righe_fascia, ll_id_list_partenza
integer i

dw_4.setfilter("c_scegli=1")
dw_4.filter()
dw_1.setfilter("")
dw_1.filter()
ll_righe_fascia=dw_1.rowcount()
for i= 1 to dw_4.rowcount()
	ll_id_listino_arrivo=dw_4.getitemnumber(i, "id_listino_arrivo")
	ls_fascia=dw_4.getitemstring(i, "FASCIA")
	ll_id_list_partenza=dw_4.getitemnumber(i, "id_listino_partenza")
	//il prezzo viene dal prezzo della fascia/listino partenza per il segno per il valore
	ls_segno=dw_4.getitemstring(i, "segno")
	ldc_valore=dw_4.getitemdecimal(i, "valore")
	if ls_segno="=" then
		ldc_prezzo=ldc_valore
	else
		ls_find="id_listino="+string(ll_id_list_partenza)+ " and fascia='"+ls_fascia+"'"
		ll_riga_trovata=dw_1.find(ls_find, 1, ll_righe_fascia)
		ldc_prezzo=dw_1.getitemdecimal(ll_riga_trovata, "prezzo")
		choose case ls_segno
			case "+"
				ldc_prezzo= ldc_prezzo + ldc_valore
			case "-"
				ldc_prezzo= ldc_prezzo - ldc_valore
			case "*"
				ldc_prezzo= ldc_prezzo * ldc_valore
			case "/"
				ldc_prezzo= ldc_prezzo / ldc_valore
			case "%"
				ldc_prezzo+= ldc_prezzo * ldc_valore /100
		end choose
	end if
	
	
	
	ls_find="id_listino="+string(ll_id_listino_arrivo)+ " and fascia='"+ls_fascia+"'"
	ll_riga_trovata=dw_1.find(ls_find, 1, ll_righe_fascia)
	if ll_riga_trovata>0 then
		dw_1.setitem(ll_riga_trovata, "prezzo", ldc_prezzo)
	else
		ll_riga_trovata=dw_1.insertrow(0)
		dw_1.setitem(ll_riga_trovata, "prezzo", ldc_prezzo)
		dw_1.setitem(ll_riga_trovata, "fascia", ls_fascia)
		dw_1.setitem(ll_riga_trovata, "id_listino", ll_id_listino_arrivo)
	end if
next
dw_4.setfilter("")
dw_4.filter()
end event

type cbx_1 from checkbox within w_fascia_prezzo_gd
integer x = 2418
integer y = 1576
integer width = 443
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona tutto"
end type

event clicked;long i
integer li_valore
if checked then
	li_valore=1
else
	li_valore=0
end if
for i= 1 to dw_4.ROWCOUNT()
	dw_4.setitem(i, "c_scegli", li_valore)
	
NEXT

end event

type st_5 from statictext within w_fascia_prezzo_gd
integer x = 32
integer y = 2380
integer width = 2725
integer height = 160
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inserisci le fasce nella finestra superiore solo per i listini che non possono essere calcolati. Poi riempi la finestra inferiore, salvala e crea le fasce per gli altri listini."
boolean focusrectangle = false
end type

type cb_aggiorna from commandbutton within w_fascia_prezzo_gd
integer x = 2427
integer y = 1212
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
end type

event clicked;string ls_fascia
long ll_id_listino, ll_art_in_fascia, ll_id_var, ll_test, ll_id_uc
integer i, a
decimal ldc_prezzo
datastore ds_trova_art_per_fascia

ds_trova_art_per_fascia=create datastore
ds_trova_art_per_fascia.dataobject="d_trova_art_per_fascia_gd"
ds_trova_art_per_fascia.settransobject(sqlca)


dw_1.setfilter("c_scegli=1")
dw_1.filter()
for i= 1 to dw_1.rowcount()
	ls_fascia=dw_1.getitemstring(i, "fascia")
	//devo prendere il prezzo e il listino dove riportare tale prezzo
	ldc_prezzo=dw_1.getitemdecimal(i, "prezzo")
	
	ll_id_listino=dw_1.getitemnumber(i, "id_listino")
	//poi trovare la variazione valida del listino in questione
	select id_variazione
	into :ll_id_var
	from dba.variazione
	where id_listino=:ll_id_listino
	and data_inizio<= today() and (data_fine is null or data_fine>=today())
	;
	//per ogni fascia devo trovare tutti gli articoli della fascia
	ll_art_in_fascia=ds_trova_art_per_fascia.retrieve(ls_fascia)
	//girare per inserirli/aggiornarli nel listino scelto
	for a= 1 to ll_art_in_fascia
		//prima di tutto l'id_unita-confezione dell'articolo
		ll_id_uc=ds_trova_art_per_fascia.getitemnumber(a, "id_unita_confezione")
		//controllare se l'articolo esiste già nel listino/variazione
		select id_unita_confezione
		into :ll_test
		from dba.prezzo
		where id_variazione=:ll_id_var
		and id_unita_confezione=:ll_id_uc
		;
		if ll_test>0 then
			//se sì update (aggiorno prezzo)
			update dba.prezzo
			set prezzo=:ldc_prezzo
			where id_variazione=:ll_id_var
			and id_unita_confezione=:ll_id_uc;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo non aggiornato!")
			end if
		else
			//se no insert (inserisco articolo ex novo in listino
			insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo)
			values (:ll_id_uc, :ll_id_var, :ldc_prezzo)
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo non inserito!")
			end if
		end if
	next
		
	
next
destroy ds_trova_art_per_fascia
end event

type cbx_2 from checkbox within w_fascia_prezzo_gd
integer x = 2432
integer y = 1044
integer width = 471
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona tutto"
end type

event clicked;long i
integer li_valore
if checked then
	li_valore=1
else
	li_valore=0
end if
for i= 1 to dw_1.ROWCOUNT()
	dw_1.setitem(i, "id_azienda", li_valore)
	
NEXT

end event

type sle_1 from singlelineedit within w_fascia_prezzo_gd
integer x = 2766
integer y = 1116
integer width = 142
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "6"
borderstyle borderstyle = stylelowered!
end type

event modified;integer i
decimal ldc_prezzo

if integer(text)>0 then
	dw_1.setfilter("c_scegli=1")
	dw_1.filter()
	for i= 1 to dw_1.rowcount()
		ldc_prezzo=dw_1.getitemdecimal(i, "prezzo")
		ldc_prezzo=round(ldc_prezzo, integer(text))
		dw_1.setitem(i, "prezzo", ldc_prezzo)
	next
end if
		
end event

type st_6 from statictext within w_fascia_prezzo_gd
integer x = 2409
integer y = 1132
integer width = 357
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Num. Decimali:"
boolean focusrectangle = false
end type

type ln_1 from line within w_fascia_prezzo_gd
integer linethickness = 6
integer beginx = 27
integer beginy = 1344
integer endx = 2939
integer endy = 1344
end type

