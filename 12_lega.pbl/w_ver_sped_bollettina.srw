forward
global type w_ver_sped_bollettina from w_base
end type
type st_1 from statictext within w_ver_sped_bollettina
end type
type st_ricerca from statictext within w_ver_sped_bollettina
end type
type sle_ricerca from singlelineedit within w_ver_sped_bollettina
end type
type dw_3 from udw_000 within w_ver_sped_bollettina
end type
type cb_carica_xls from commandbutton within w_ver_sped_bollettina
end type
type cb_aggiorna from commandbutton within w_ver_sped_bollettina
end type
type dw_2 from udw_001 within w_ver_sped_bollettina
end type
type cb_ricerca from uo_commandbutton within w_ver_sped_bollettina
end type
type cb_salva from uo_commandbutton within w_ver_sped_bollettina
end type
type cb_ok from uo_commandbutton within w_ver_sped_bollettina
end type
type cb_annulla from uo_commandbutton within w_ver_sped_bollettina
end type
type cb_stampa from uo_commandbutton within w_ver_sped_bollettina
end type
type cb_cancella from uo_commandbutton within w_ver_sped_bollettina
end type
type cb_inserisci from uo_commandbutton within w_ver_sped_bollettina
end type
type dw_1 from udw_001 within w_ver_sped_bollettina
end type
end forward

global type w_ver_sped_bollettina from w_base
integer width = 6702
integer height = 2548
st_1 st_1
st_ricerca st_ricerca
sle_ricerca sle_ricerca
dw_3 dw_3
cb_carica_xls cb_carica_xls
cb_aggiorna cb_aggiorna
dw_2 dw_2
cb_ricerca cb_ricerca
cb_salva cb_salva
cb_ok cb_ok
cb_annulla cb_annulla
cb_stampa cb_stampa
cb_cancella cb_cancella
cb_inserisci cb_inserisci
dw_1 dw_1
end type
global w_ver_sped_bollettina w_ver_sped_bollettina

forward prototypes
public subroutine wf_carica_spedizione ()
public subroutine wf_carica_dati_richiesta (string as_num_bol, long al_riga_dw_1)
public subroutine wf_carica_dw_1 ()
public subroutine wf_carica_per (string as_campo, string as_asc_desc)
public subroutine wf_completa_riga (long al_riga, string ls_num_bol, string as_tipo)
end prototypes

public subroutine wf_carica_spedizione ();long ll_righe, ll_riga_inserita ,ll_id_riga_bol
string ls_num_bollettina, ls_oggi_5, ls_filtro, ls_num_bol_prec, ls_tipo
integer i	
date ldt_data_spedizione, ldt_da_data


ll_righe=dw_2.retrieve()

dw_1.reset()
dw_1.setfilter("")
dw_1.filter()

for i= 1 to ll_righe
	ls_tipo='A'
	ldt_data_spedizione=dw_2.object.data[i, 2] //dw_2.getitemdate(i, "data_spedizione")
	ls_num_bollettina=dw_2.object.data[i, 3]  //dw_2.getitemstring(i, "num_bollettina")
	if i>1 then
		if ls_num_bol_prec=ls_num_bollettina then //20250428 abbiamo il caso in cui la stessa bol è richiesta 2 volte...
			ls_tipo='B'
		end if
	end if
	ls_num_bol_prec=ls_num_bollettina
	ll_id_riga_bol=f_trova_id_riga_bol_da_numero(ls_num_bollettina)
//	if ldt_data_spedizione<date(today()) then
//		//20231124 trovo se la bol è derivata in rbol
//		
////		if dw_2.object.data[i, 2]
//		//ll_id_riga_bol=f_trova_derivato(ll_id_riga_bol)
//		if ll_id_riga_bol=1 then continue  //se è così salto il pezzo qui sotto
//	end if
	ll_riga_inserita=dw_1.RETRIEVE(ll_id_riga_bol)
	//ll_riga_inserita=dw_1.insertrow(0)
	dw_1.object.data[i, 2]= ls_num_bollettina //dw_1.setitem(ll_riga_inserita, "num_bollettina", ls_num_bollettina)
	
	wf_completa_riga(ll_riga_inserita, ls_num_bollettina, ls_tipo)
	//dw_1.trigger event itemchanged(ll_riga_inserita, dw_1.object.num_bollettina, ls_num_bollettina)
next
ldt_da_data=today()
ls_oggi_5=string(relativedate(today(), -5), "dd/mm/yyyy")
 //20241010 inserito filtro per prendere solo inserimento del giorno e NON spedite fino a 5 gg prima
ls_filtro="(c_data_inserimento>= date('"+ls_oggi_5+"') and articolo_codice='NON SPEDITA!'  ) or (c_data_inserimento= date('"+string(ldt_da_data)+"'))" 
dw_1.setfilter(ls_filtro)
dw_1.filter()
end subroutine

public subroutine wf_carica_dati_richiesta (string as_num_bol, long al_riga_dw_1);integer i
string ls_num_bollettina, ls_des,ls_data_richiesta

long ll_riga_trovata

ls_num_bollettina=as_num_bol


ll_riga_trovata=dw_3.find("bollettina='"+ls_num_bollettina+"'", 1, 900000)
if ll_riga_trovata>0 then
	ls_data_richiesta=dw_3.getitemstring(ll_riga_trovata, "data_richiesta")
	ls_des=dw_3.getitemstring(ll_riga_trovata, "descrizione")
//	if ls_data_richiesta="01/01/1900" then
	dw_1.setitem(al_riga_dw_1, "c_data_richiesta", ls_data_richiesta)
	dw_1.setitem(al_riga_dw_1, "c_descrizione", ls_des)
	
	
else
	dw_1.setitem(al_riga_dw_1, "c_descrizione", "------------")
end if

end subroutine

public subroutine wf_carica_dw_1 ();long ll_riga_inserita, ll_riga_ins_2, ll_riga_trovata
string ls_num_bol, ls_data_richiesta, ls_des, ls_cliente
integer i
date ldt_data_scadenza_bol, ldt_data_urge

dw_1.reset()
for i=1 to dw_3.rowcount()
	ls_num_bol=dw_3.getitemstring(i, "bollettina")
	if ls_num_bol>"0" then
		ls_des=dw_3.getitemstring(i, "descrizione")
		ls_data_richiesta=dw_3.getitemstring(i, "data_richiesta")
		ldt_data_urge=dw_3.getitemdate(i, "data_urgenza")
		ls_cliente=dw_3.getitemstring(i, "cliente")
		ll_riga_trovata=dw_2.find("num_bollettina='"+ls_num_bol+"'", 1, 9999999)
		if ll_riga_trovata>0 then 
			ll_riga_ins_2=ll_riga_trovata
		else
			ll_riga_ins_2=dw_2.insertrow(0)
		end if 
		dw_2.setitem(ll_riga_ins_2, "num_bollettina", ls_num_bol)
		//select data_scadenza into :ldt_data_scadenza_bol from dba.bollettine_excel where cod_barre=:ls_num_bol; //20231122 no! questa è la data del giorno in cui si lavora la bollettina/e
		dw_2.setitem(ll_riga_ins_2, "data_spedizione", today() )
		dw_2.setitem(ll_riga_ins_2, "descrizione", ls_des )
		dw_2.setitem(ll_riga_ins_2, "data_richiesta", date(ls_data_richiesta) )
		dw_2.setitem(ll_riga_ins_2, "data_urgenza", ldt_data_urge) 
		dw_2.setitem(ll_riga_ins_2, "cliente", ls_cliente) 
		
		ll_riga_inserita=dw_1.insertrow(0)
		dw_1.trigger event itemchanged(ll_riga_inserita, dw_1.object.num_bollettina, ls_num_bol)
		//ll_riga_inserita=dw_1.rowcount()
		dw_1.setitem(ll_riga_inserita, "num_bollettina", ls_num_bol)
		dw_1.setitem(ll_riga_inserita, "c_data_richiesta", ls_data_richiesta)
		dw_1.setitem(ll_riga_inserita, "c_descrizione", ls_des)
		dw_1.setitem(ll_riga_inserita, "data_urgenza", ldt_data_urge) 
		dw_1.setitem(ll_riga_inserita,  "pd_cliente", ls_cliente) 
//		ll_riga_trovata=dw_2.find("num_bollettina='"+ls_num_bol+"'", 1, 9999999)
//		if ll_riga_trovata>0 then 
//			ll_riga_ins_2=ll_riga_trovata
//		else
//			ll_riga_ins_2=dw_2.insertrow(0)
//		end if
		
		
	end if 
next
end subroutine

public subroutine wf_carica_per (string as_campo, string as_asc_desc);string ls_sort
ls_sort=as_campo+" "+as_asc_desc+","
dw_1.setsort(ls_sort)
dw_1.sort()
end subroutine

public subroutine wf_completa_riga (long al_riga, string ls_num_bol, string as_tipo);long ll_id_riga, ll_id_rbol, ll_riga_inserita,ll_riga_trovata
string ls_des, ls_data_richiesta, ls_g_rientro_silver,ls_test
date ldt_data_ric, ldt_data_urge, ldt_data_ins

//20231122 manca data richiesta la descrizione e la dataurgenza.... mettiamola
select id_riga_documento into :ll_id_riga from dba.documento d, dba.riga_documento r 	
	where r.id_documento=d.id_documento and num_documento like '%'+:ls_num_bol+'%';
	IF ll_id_riga>0 then
	//20231122 carico anche i nuovi campi
		ll_riga_trovata=dw_2.find("num_bollettina='"+ls_num_bol+"'", 1, 9999999)
		if ll_riga_trovata>0 then
			ls_des=dw_2.getitemstring(ll_riga_trovata, "descrizione" )
			ldt_data_ric=dw_2.getitemdate(ll_riga_trovata, "data_richiesta")
			if isnull(ldt_data_ric) or ldt_data_ric=date("1900/01/01") then //controllo 20240325
				ls_data_richiesta="01/01/1901"
			else
				ls_data_richiesta=string(ldt_data_ric)
			end if
			ldt_data_urge=dw_2.getitemdate(ll_riga_trovata, "data_urgenza") 
			if isnull(ldt_data_ric) or ldt_data_ric=date("1900/01/01") then  //controllo 20240325
				ldt_data_urge=date("01/01/1901")
			end if
			//20250428 metto anche il tipo 
			
			if ll_id_riga>0 then
				ls_test=dw_2.getitemstring(ll_riga_trovata, "provenienza" ) //20241002 inserisco la provenienza (se viene da cerca_bol_articolo è gialla ovvero =1)
				select id_riga_documento into :ll_id_rbol from dba.riga_documento
				where id_riga_doc_provenienza=:ll_id_riga;
				if ll_id_rbol>0 then
					ls_g_rientro_silver=dw_1.getitemstring(al_riga, "giorno_rientro_silver")
					dw_1.deleterow(al_riga)
					ll_riga_inserita=dw_1.retrieve(ll_id_rbol)
					dw_1.setitem(ll_riga_inserita, "tipo", as_tipo) //20250428 tipo
					dw_1.setitem(ll_riga_inserita, "giorno_rientro_silver",ls_g_rientro_silver )
					dw_1.setitem(ll_riga_inserita, "num_bollettina", ls_num_bol)
					dw_1.setitem(ll_riga_inserita, "c_descrizione", ls_des )
					dw_1.setitem(ll_riga_inserita, "c_data_richiesta", ls_data_richiesta )
					dw_1.setitem(ll_riga_inserita, "data_urgenza", ldt_data_urge )
					dw_1.setitem(ll_riga_inserita, "c_provenienza", ls_test ) //20241002 inserisco la provenienza (se viene da cerca_bol_articolo è gialla ovvero =1)
				else
					dw_1.setitem(al_riga, "tipo", as_tipo) //20250428 tipo
					dw_1.setitem(al_riga, "articolo_codice", "NON SPEDITA!" )
					dw_1.setitem(al_riga, "c_descrizione", ls_des )
					dw_1.setitem(al_riga, "c_data_richiesta", ls_data_richiesta )
					dw_1.setitem(al_riga, "data_urgenza", ldt_data_urge )
					dw_1.setitem(al_riga, "c_provenienza", ls_test )  //20241002 inserisco la provenienza (se viene da cerca_bol_articolo è gialla ovvero =1)
					//messagebox("Attenzione!", "Bollettina "+ls_num_bol+" NON spedita!!")
				end if
				ldt_data_ins=dw_2.getitemdate(ll_riga_trovata, "data_inserimento" )
				dw_1.setitem(al_riga, "c_data_inserimento", ldt_data_ins )
			else
				messagebox("Attenzione!", "Bollettina "+ls_num_bol+" NON trovata!!")
				dw_1.setitem(al_riga, "num_bollettina", "")
			end if
		else
			dw_1.setitem(al_riga, "articolo_codice", "NON SPEDITA!" )
			dw_1.setitem(al_riga, "c_descrizione", ls_des )
			ls_data_richiesta="01/01/1901"
			dw_1.setitem(al_riga, "c_data_richiesta", ls_data_richiesta )
			ldt_data_urge=date("01/01/1901")
			dw_1.setitem(al_riga, "data_urgenza", ldt_data_urge )
			//messagebox("Attenzione!", "Bollettina in dw2 "+ls_num_bol+" NON trovata!!")
		end if
	ELSE
		messagebox("Attenzione!", "Bollettina "+ls_num_bol+" NON c'è nelle bollettine caricate!!")
	end if
end subroutine

on w_ver_sped_bollettina.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_ricerca=create st_ricerca
this.sle_ricerca=create sle_ricerca
this.dw_3=create dw_3
this.cb_carica_xls=create cb_carica_xls
this.cb_aggiorna=create cb_aggiorna
this.dw_2=create dw_2
this.cb_ricerca=create cb_ricerca
this.cb_salva=create cb_salva
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_ricerca
this.Control[iCurrent+3]=this.sle_ricerca
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_carica_xls
this.Control[iCurrent+6]=this.cb_aggiorna
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.cb_ricerca
this.Control[iCurrent+9]=this.cb_salva
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.cb_annulla
this.Control[iCurrent+12]=this.cb_stampa
this.Control[iCurrent+13]=this.cb_cancella
this.Control[iCurrent+14]=this.cb_inserisci
this.Control[iCurrent+15]=this.dw_1
end on

on w_ver_sped_bollettina.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_ricerca)
destroy(this.sle_ricerca)
destroy(this.dw_3)
destroy(this.cb_carica_xls)
destroy(this.cb_aggiorna)
destroy(this.dw_2)
destroy(this.cb_ricerca)
destroy(this.cb_salva)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.dw_1)
end on

event open;call super::open;

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)



end event

event resize;call super::resize;dw_1.width=newwidth - 105
dw_1.height=newheight - 292

cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285

cb_stampa.x=cb_cancella.x + 285
cb_stampa.y=cb_salva.y




cb_ok.y=newheight - 224
cb_ok.x=dw_1.x+dw_1.width - cb_ok.width
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ok.x - 285
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_annulla.x - 285

cb_aggiorna.x=cb_stampa.x+50+cb_stampa.width
cb_aggiorna.y=cb_stampa.y

cb_carica_xls.y=cb_stampa.y
cb_carica_xls.x=cb_aggiorna.x+50+cb_carica_xls.width


st_ricerca.y=cb_inserisci.y
sle_ricerca.x=cb_ricerca.x - cb_ricerca.width - 250
sle_ricerca.y=cb_inserisci.y
st_ricerca.x=sle_ricerca.x - sle_ricerca.width  - 10

st_1.x=2500
st_1.y=cb_ricerca.y

end event

event ue_postopen;call super::ue_postopen;long ll_righe, ll_riga_inserita
integer i
string ls_num_bollettina
date ldt_oggi

ldt_oggi=date(today())
//dw_2.is_sql=" where data_spedizione =  "+string(ldt_oggi, "yyyymmdd")
setredraw(false)
wf_carica_spedizione()
setredraw(true)
ll_riga_inserita=dw_1.insertrow(0)	
dw_1.scrolltorow(ll_riga_inserita)
dw_1.setcolumn("num_bollettina")
post setfocus(dw_1)
dw_1.trigger event getfocus()
end event

type st_1 from statictext within w_ver_sped_bollettina
integer x = 2034
integer y = 1280
integer width = 1006
integer height = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "PER STAMPARE selezionare (~"Sì~") le righe: se selezioni/deselezioni la prima riga ti propone di selezionarle/deselezionarle tutte!"
boolean focusrectangle = false
end type

type st_ricerca from statictext within w_ver_sped_bollettina
integer x = 4142
integer y = 1288
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cerca BOL:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_ricerca from singlelineedit within w_ver_sped_bollettina
integer x = 4549
integer y = 1260
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_bol
long ll_riga_trovata

if len(text)=7 then
	ls_bol=text
	ll_riga_trovata=dw_1.find("num_bollettina='"+ls_bol+"'", 1, dw_1.rowcount())
	if ll_riga_trovata>0 then
		dw_1.scrolltorow(ll_riga_trovata)
	end if
	
end if
end event

type dw_3 from udw_000 within w_ver_sped_bollettina
boolean visible = false
integer x = 192
integer y = 1868
integer width = 4823
integer height = 608
integer taborder = 60
boolean titlebar = true
string dataobject = "d_imp_richiesta_k"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_carica_xls from commandbutton within w_ver_sped_bollettina
integer x = 2053
integer y = 1296
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica XLS"
end type

event clicked;integer li_rtn  //20231113 vediamo se fuznioina
string ls_path, ls_file
oleobject lole_excel, lole_workbook, lole_worksheet, lole_range

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc") //20230519 xls diventa xlsx .... proviamo ma anche no....
if  not(trim(ls_file)="" or isnull(ls_file)) then
	
	lole_excel = create oleobject
	li_rtn = lole_excel.ConnectToNewObject("excel.application")
	if li_rtn <> 0 then
			MessageBox( "Error", 'Error running MS Excel api.')
			destroy lole_Excel
	else
	 	 lole_excel.WorkBooks.Open(ls_path) 
	  	lole_workbook = lole_excel.application.workbooks(1)
	 	lole_worksheet = lole_workbook.worksheets(1)
		 ls_file=left(ls_path, len(ls_path) - 3)+"txt"
		if fileexists(ls_file) then FileDelete(ls_file)
		lole_workbook.saveas(ls_file, 21)
		dw_3.importfile(text!,ls_file, 2)
		lole_excel.DisplayAlerts = False 
		lole_excel.application.quit()
		lole_excel.DisconnectObject()
		
	end if	 
end if



destroy lole_Excel
wf_carica_dw_1()


  
  
end event

type cb_aggiorna from commandbutton within w_ver_sped_bollettina
integer x = 736
integer y = 1360
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
end type

event clicked;cb_salva.triggerevent("clicked")
dw_2.reset()  //devo ricaricare solo le bollettine del giorno e quelle dei gg precedenti NON SPEDITE!!! Quindi lascio e faccio filtro sul caricamento
dw_1.reset()
wf_carica_spedizione()
end event

type dw_2 from udw_001 within w_ver_sped_bollettina
boolean visible = false
integer x = 78
integer y = 1464
integer width = 4887
integer height = 580
integer taborder = 20
boolean titlebar = true
string dataobject = "d_salva_ver_sped_bollettina"
boolean vscrollbar = true
boolean resizable = true
end type

type cb_ricerca from uo_commandbutton within w_ver_sped_bollettina
integer x = 2784
integer y = 1564
integer width = 261
integer height = 96
integer taborder = 60
integer textsize = -8
string text = "Ricerca"
end type

event clicked;long ll_id, ll_riga

if text='Ricerca' then
	dw_1.modify("datawindow.querymode=yes")
	text='Trova'
else
	text='Ricerca'
	dw_1.accepttext()
	dw_1.Modify("DataWindow.QueryMode=no")
	ll_riga=dw_1.retrieve()
end if

end event

type cb_salva from uo_commandbutton within w_ver_sped_bollettina
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 1664
integer y = 1348
integer width = 261
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;//dw_1.trigger event ue_update() 
integer i
string ls_num_bollettina, ls_data_richiesta, ls_des
long ll_riga_inserita, ll_id_riga, ll_riga_trovata
dw_1.accepttext()
for i  =1 to dw_1.rowcount()  //da togliere fino al next???? 20231122
	ls_num_bollettina=dw_1.getitemstring(i, "num_bollettina")	
	if dw_2.find("num_bollettina='"+ls_num_bollettina+"'", 1 , 999999)<=0 then  //la bollettina non c'è la inserisco
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_inserita, "num_bollettina", ls_num_bollettina)  //20230613 sostituisco con id_riga_doc
		dw_2.setitem(ll_riga_inserita, "data_spedizione", date(today()) )
		ls_des=dw_1.getitemstring(i, "c_descrizione")
		dw_2.setitem(ll_riga_inserita, "descrizione", ls_des )
		dw_2.setitem(ll_riga_inserita, "id_utenti", u_freddie.s_utenti.i_idutente ) //20250331 agg id_utente
	end if
next
if dw_2.update()=1 then
	commit;
	messagebox("Bene!", "SALVATAGGIO OK!")
else
	rollback;
	messagebox("Attenzione!", "Bollettina "+ls_num_bollettina+" NON salvata!")
end if
end event

type cb_ok from uo_commandbutton within w_ver_sped_bollettina
string tag = "Chiude salvando le modifiche."
integer x = 2633
integer y = 1248
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string text = "Ok"
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	dw_1.trigger event ue_update()
end if
close(parent)
end event

type cb_annulla from uo_commandbutton within w_ver_sped_bollettina
string tag = "Chiude senza salvare nulla."
integer x = 2926
integer y = 1248
integer width = 261
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_stampa from uo_commandbutton within w_ver_sped_bollettina
integer x = 1202
integer y = 1280
integer width = 261
integer height = 96
integer taborder = 40
integer textsize = -8
string text = "Stampa"
end type

event clicked;call super::clicked;string ls_data, ls_num_doc

ls_num_doc=parent.classname()
		
ls_data=string(today(), "dd-mm-yy")
ls_num_doc+="_"+ls_data
	
dw_1.setfilter("c_scelto='S'")
dw_1.filter()
dw_1.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
dw_1.print(true, true)
dw_1.setfilter("")
dw_1.filter()
end event

type cb_cancella from uo_commandbutton within w_ver_sped_bollettina
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 379
integer y = 1328
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare, ll_riga_trovata
string ls_num_bol

ll_riga_da_cancellare=dw_1.getrow()
ls_num_bol=dw_1.getitemstring(ll_riga_da_cancellare, "num_bollettina")
ll_riga_trovata=dw_2.find("num_bollettina='"+ls_num_bol+"'", 1, 99999999)
if ll_riga_trovata>0 then 
	dw_2.deleterow(ll_riga_trovata)
	dw_1.trigger event ue_delete(ll_riga_da_cancellare)		
else //non l'ha trovata???????
	messagebox("Attenzione!", "Riga NON trovata!!!")
end if


end event

event rbuttondown;integer li_ret

if messagebox("Attenzione!", "TUTTE LE RIGHE verranno CANCELLATE! Vuoi continuare?")=1 then
	li_ret=dw_2.RowsMove(1, dw_2.rowcount(), Primary!,  dw_2, 1, Delete!)
	if li_ret=1 then
		if dw_2.update()=1 then
			commit;
		else
			rollback;
			messagebox("attenzione!", "Righe NON cancellate!")
		end if
		dw_1.reset()
	else
		messagebox("attenzione!", "Righe NON cancellate!")
	end if
end if
end event

type cb_inserisci from uo_commandbutton within w_ver_sped_bollettina
string tag = "Inserisce una nuova riga nella finestra che ha il fuoco."
integer x = 78
integer y = 1320
integer width = 261
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_1.trigger event ue_insert(0)

end event

type dw_1 from udw_001 within w_ver_sped_bollettina
integer x = 46
integer y = 44
integer width = 6569
integer height = 1188
integer taborder = 10
string dataobject = "d_ver_sped_bollettina"
end type

event itemchanged;call super::itemchanged;string ls_num_bol
long ll_id_riga, ll_id_rbol, ll_riga_inserita,ll_riga_trovata

if dwo.name='num_bollettina' then
	ls_num_bol=data
		//ll_riga_inserita=insertrow(0)
		wf_completa_riga(row, ls_num_bol, "A")
		wf_carica_dati_richiesta( data, row)
		//post scrolltorow(ll_riga_inserita)
		//post setcolumn("num_bollettina")
		//post setfocus(dw_1)
elseif dwo.name='c_descrizione' then
	ls_num_bol=dw_1.getitemstring(row, "num_bollettina")
	ll_riga_trovata=dw_1.find("num_bollettina='"+ls_num_bol+"'", 1 , 999999)
	if ll_riga_trovata>0 then 
		ll_riga_inserita=dw_2.find("num_bollettina='"+ls_num_bol+"'", 1 , 999999)
		dw_2.setitem(ll_riga_inserita, "descrizione", data )
	end if
end if
end event

event retrievestart;call super::retrievestart;return 2
end event

event rbuttondown;


choose case dwo.name
	case "articolo_codice" 
	
end choose
end event

event clicked;call super::clicked;integer i
string ls_messaggio, ls_ret

if dwo.name="c_scelto" and row=1 then
	if dw_1.getitemstring(row, "c_scelto")="S" then 
		ls_messaggio="Vuoi deselezionare TUTTE le righe?"
		ls_ret="N"
	else
		ls_messaggio="Vuoi selezionare TUTTE le righe?"
		ls_ret="S"
	end if
	if messagebox("Attenzione!", ls_messaggio, stopsign!, yesno!)=1 then
		for i= 2 to rowcount()
			setitem(i, "c_scelto", ls_ret)
		next
	end if
end if
end event

