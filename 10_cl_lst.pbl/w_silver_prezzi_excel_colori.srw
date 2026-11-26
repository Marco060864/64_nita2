forward
global type w_silver_prezzi_excel_colori from w_001
end type
type dw_4 from datawindow within w_silver_prezzi_excel_colori
end type
type ole_1 from olecontrol within w_silver_prezzi_excel_colori
end type
type cb_carica from commandbutton within w_silver_prezzi_excel_colori
end type
type dw_2 from udw_base within w_silver_prezzi_excel_colori
end type
type cb_carica_prezzi from commandbutton within w_silver_prezzi_excel_colori
end type
type dw_3 from u_dw_ext_main within w_silver_prezzi_excel_colori
end type
type cb_salva from commandbutton within w_silver_prezzi_excel_colori
end type
type st_2 from statictext within w_silver_prezzi_excel_colori
end type
type em_data from editmask within w_silver_prezzi_excel_colori
end type
type dw_1 from udw_base within w_silver_prezzi_excel_colori
end type
type cb_togli_filtro from commandbutton within w_silver_prezzi_excel_colori
end type
type cb_ins_art_mancanti from commandbutton within w_silver_prezzi_excel_colori
end type
type cb_aggiorna from commandbutton within w_silver_prezzi_excel_colori
end type
type sle_path from singlelineedit within w_silver_prezzi_excel_colori
end type
type st_3 from statictext within w_silver_prezzi_excel_colori
end type
type ddlb_1 from dropdownlistbox within w_silver_prezzi_excel_colori
end type
type dw_6 from udw_000 within w_silver_prezzi_excel_colori
end type
type st_4 from statictext within w_silver_prezzi_excel_colori
end type
type cbx_vedi_foto from checkbox within w_silver_prezzi_excel_colori
end type
type cb_stampa from commandbutton within w_silver_prezzi_excel_colori
end type
type dw_5 from u_dw_ext_main within w_silver_prezzi_excel_colori
end type
type cb_1 from commandbutton within w_silver_prezzi_excel_colori
end type
type cb_2 from commandbutton within w_silver_prezzi_excel_colori
end type
type dw_7 from udw_000 within w_silver_prezzi_excel_colori
end type
type cb_vedi_lav_k from commandbutton within w_silver_prezzi_excel_colori
end type
type cb_controlla_prezzo from commandbutton within w_silver_prezzi_excel_colori
end type
type cb_3 from commandbutton within w_silver_prezzi_excel_colori
end type
end forward

global type w_silver_prezzi_excel_colori from w_001
integer width = 6519
integer height = 2212
string title = "w_silver_prezzi_excel"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_4 dw_4
ole_1 ole_1
cb_carica cb_carica
dw_2 dw_2
cb_carica_prezzi cb_carica_prezzi
dw_3 dw_3
cb_salva cb_salva
st_2 st_2
em_data em_data
dw_1 dw_1
cb_togli_filtro cb_togli_filtro
cb_ins_art_mancanti cb_ins_art_mancanti
cb_aggiorna cb_aggiorna
sle_path sle_path
st_3 st_3
ddlb_1 ddlb_1
dw_6 dw_6
st_4 st_4
cbx_vedi_foto cbx_vedi_foto
cb_stampa cb_stampa
dw_5 dw_5
cb_1 cb_1
cb_2 cb_2
dw_7 dw_7
cb_vedi_lav_k cb_vedi_lav_k
cb_controlla_prezzo cb_controlla_prezzo
cb_3 cb_3
end type
global w_silver_prezzi_excel_colori w_silver_prezzi_excel_colori

type variables


end variables

forward prototypes
public function decimal wf_trova_valore (string as_k)
end prototypes

public function decimal wf_trova_valore (string as_k);decimal ldc_valore

select pr_pz
into :ldc_valore
from dba.lav_k
where lavorazione=:as_k
;
//arrotondo al terzo decimale perché così fa la Samy NO!!! ARROTONDO SOLO IL TOTALE DI LA'
//ldc_valore=round(ldc_valore, 3)
return ldc_valore
end function

on w_silver_prezzi_excel_colori.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.ole_1=create ole_1
this.cb_carica=create cb_carica
this.dw_2=create dw_2
this.cb_carica_prezzi=create cb_carica_prezzi
this.dw_3=create dw_3
this.cb_salva=create cb_salva
this.st_2=create st_2
this.em_data=create em_data
this.dw_1=create dw_1
this.cb_togli_filtro=create cb_togli_filtro
this.cb_ins_art_mancanti=create cb_ins_art_mancanti
this.cb_aggiorna=create cb_aggiorna
this.sle_path=create sle_path
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.dw_6=create dw_6
this.st_4=create st_4
this.cbx_vedi_foto=create cbx_vedi_foto
this.cb_stampa=create cb_stampa
this.dw_5=create dw_5
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_7=create dw_7
this.cb_vedi_lav_k=create cb_vedi_lav_k
this.cb_controlla_prezzo=create cb_controlla_prezzo
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.cb_carica
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_carica_prezzi
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.cb_salva
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.em_data
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.cb_togli_filtro
this.Control[iCurrent+12]=this.cb_ins_art_mancanti
this.Control[iCurrent+13]=this.cb_aggiorna
this.Control[iCurrent+14]=this.sle_path
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.ddlb_1
this.Control[iCurrent+17]=this.dw_6
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.cbx_vedi_foto
this.Control[iCurrent+20]=this.cb_stampa
this.Control[iCurrent+21]=this.dw_5
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.cb_2
this.Control[iCurrent+24]=this.dw_7
this.Control[iCurrent+25]=this.cb_vedi_lav_k
this.Control[iCurrent+26]=this.cb_controlla_prezzo
this.Control[iCurrent+27]=this.cb_3
end on

on w_silver_prezzi_excel_colori.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.ole_1)
destroy(this.cb_carica)
destroy(this.dw_2)
destroy(this.cb_carica_prezzi)
destroy(this.dw_3)
destroy(this.cb_salva)
destroy(this.st_2)
destroy(this.em_data)
destroy(this.dw_1)
destroy(this.cb_togli_filtro)
destroy(this.cb_ins_art_mancanti)
destroy(this.cb_aggiorna)
destroy(this.sle_path)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.dw_6)
destroy(this.st_4)
destroy(this.cbx_vedi_foto)
destroy(this.cb_stampa)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_7)
destroy(this.cb_vedi_lav_k)
destroy(this.cb_controlla_prezzo)
destroy(this.cb_3)
end on

event open;call super::open;string ls_data
date ldt_data
datawindowchild dwc_variazione
integer rtncode

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_5.settransobject(sqlca)

rtncode = dw_3.getchild("id_variazione", dwc_variazione)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_variazione.SetTransObject(SQLCA)

// Populate with values for eastern states
ldt_data=today()

ls_data=string(ldt_data, "dd/mm/yyyy")
em_data.text=ls_data


dwc_variazione.setfilter( "variazione_data_inizio <= date('"+ls_data+"')  and  variazione_data_fine >= date('"+ls_data+"')")
dwc_variazione.filter()

dwc_variazione.Retrieve()

// Set transaction object for main DW and retrieve




dw_3.insertrow(1)
dw_3.trigger event itemchanged(1, dw_3.object.id_variazione, "15")
dw_3.setitem(1, "id_variazione", 15)
dw_1.insertrow(1)
//ddlb_1.SelectItem(1)
dw_6.insertrow(1)
dw_5.insertrow(1)
end event

event resize;call super::resize;dw_2.width=width - 100
dw_2.height=height - 400
end event

type st_1 from w_001`st_1 within w_silver_prezzi_excel_colori
end type

type dw_4 from datawindow within w_silver_prezzi_excel_colori
integer x = 50
integer y = 1088
integer width = 2958
integer height = 896
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_imp_prezzi_excel_ext"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event clicked;drag(begin!)
end event

type ole_1 from olecontrol within w_silver_prezzi_excel_colori
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
integer x = 2789
integer y = 808
integer width = 201
integer height = 188
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean isdragtarget = true
string binarykey = "w_silver_prezzi_excel_colori.win"
string displayname = "Prova"
boolean resizable = true
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayasactivexdocument!
omcontentsallowed contentsallowed = containsany!
end type

type cb_carica from commandbutton within w_silver_prezzi_excel_colori
boolean visible = false
integer x = 2459
integer y = 1004
integer width = 416
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Carica File Excel"
end type

event clicked;
integer li_ret
string ls_path, ls_file, ls_name
long ll_rigains, ll_max
	
getfileopenname("Cerca report", ls_path, ls_name)
if  not(trim(ls_name)="" or isnull(ls_name)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+".txt"
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_4.reset()
	dw_4.importfile(Text!,ls_file)
	parent.height=2450
	ole_1.object.close(False)
//	messagebox("Attenzione!", "Creo un nuovo insieme di prezzi.")
//
//	ll_rigains=dw_1.insertrow(0)
//	
//	dw_1.setitem(ll_rigains, "codice", "EXC_"+left(ls_name, 12))
//	dw_1.setitem(ll_rigains, "descrizione", "EXC_"+left(ls_path, 36))
//	dw_1.scrolltorow(ll_rigains)
//	if dw_2.rowcount()<1 then 
//		i_dw_corrente=2
//		cb_inserisci.triggerevent("clicked")
//	end if
//	messagebox("Attenzione!", "Prima di recuperare i dati riempire correttamente la testata con codice: "+"EXC_"+left(ls_name, 12))
end if	 

//cb_cancella_righe_vuote.triggerevent(clicked!)



end event

type dw_2 from udw_base within w_silver_prezzi_excel_colori
integer x = 27
integer y = 264
integer width = 6382
integer height = 1744
boolean bringtotop = true
string dataobject = "d_ges_listino_silver_colori"
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_imm
setrowfocusindicator(hand!)

if currentrow>0 and cbx_vedi_foto.checked then
	ls_imm=getitemstring(currentrow, "articolo_codice")
	select immagine
	into :ls_imm
	from articolo
	where codice=:ls_imm;
	if ls_imm>"" then
		if isvalid(w_mostra_imm_ocx) then
			w_mostra_imm_ocx.wf_mostra(ls_imm)
		else
			openwithparm(w_mostra_imm_ocx, ls_imm, "w_mostra_imm_ocx", parent)
		end if
	end if
end if
end event

event ue_key;call super::ue_key;choose case key
	
	
     case KeyS!
		if (keyFlags=2) then
			cb_salva.triggerevent(clicked!)		
		end if
	case KeyF12!
		cb_salva.triggerevent(clicked!)		
	
end choose
end event

event getfocus;//
end event

event losefocus;//
end event

event sqlpreview;call super::sqlpreview;//string ls_sql
//integer i
//
//ls_sql=sqlsyntax
//
//if is_id_articolo>"0" then
//	ls_sql+=" and (articolo.id_articolo ="+is_id_articolo+") "
//end if
//i=SetSQLPreview(ls_sql)
//if i<>1 then
//	messagebox("Errore!", "Filtro non applicato!")
//end if
	

end event

event doubleclicked;call super::doubleclicked;long ll_articolo, ll_temp
nvo_file_list sl_lista_file
integer li_ret
string ls_file_trovato, ls_path

if dwo.name="id_articolo" then
	ll_articolo=getitemnumber(row, "id_articolo")
	if ll_articolo>0 then
		ls_path=trim(sle_path.text)
		sl_lista_file=f_leggi_files(ls_path, false)
	end if
	FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
		 li_ret=pos(sl_lista_file.as_file[ll_temp], "@"+string(ll_articolo))
		 if li_ret>0 then
			ls_file_trovato=sl_lista_file.as_file[ll_temp]
			openwithparm(w_mostra_foto, ls_file_trovato)
			exit
			//l'ho trovato ora lo mostro
		end if
	 NEXT
end if

//
end event

event itemchanged;call super::itemchanged;	integer li_ret
choose case dwo.name
	case "prezzo_confermato",  "prezzo_prezzo" , "prezzo_prezzo_manifattura"
		setitem(row, "prezzo_ultima_modifica", today())
		if dwo.name= "prezzo_confermato" then
			if data='N' then
				open(w_password_pop)
				if message.doubleparm=1 then
					
				else
					return 2
				end if
			end if
			li_ret=dw_2.trigger event ue_update()
		end if
		
end choose
end event

event clicked;call super::clicked;integer i, li_seleziona, li_pos
string ls_setta, ls_cod
long ll_id_var
s_array s_dati
if dwo.name='b_selezione' then
	If dwo.text="S" then
			li_seleziona=1
			dwo.text="D"
		else
			li_seleziona=0
			dwo.text="S"
		end if
	for i=1 to rowcount()
		setitem(i, "c_scelto", li_seleziona)
	next
end if
if dwo.name='articolo_codice' then
	ls_cod=getitemstring(row, "articolo_codice")
	li_pos=pos(ls_cod, "-")
	if li_pos>0 then
		ll_id_var=getitemnumber(row, "prezzo_id_variazione")
		s_dati.as_string[1]=left(ls_cod, li_pos - 1)
		s_dati.as_string[2]=string(ll_id_var)
		openwithparm(w_art_famiglia, s_dati)
	end if
end if
	
	
end event

event rbuttondown;call super::rbuttondown;s_dw_ritorna s_ds

s_ds.ds=create datastore
s_ds.ds.dataobject="d_ges_listino_silver"
s_ds.ds.settransobject(sqlca)

if row>0 then
	rowscopy(row, row, primary!,  s_ds.ds, 1, Primary!)
	
	openwithparm(w_duplica_art_listino_cx, s_ds)
	
end if



end event

type cb_carica_prezzi from commandbutton within w_silver_prezzi_excel_colori
integer x = 5134
integer y = 48
integer width = 379
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica  in listino"
end type

event clicked;long ll_id_var, ll_id_uc
decimal ldc_prezzo, ldc_pr_manifattura, ldc_sconto
string   ls_confermato, ls_confermato2, ls_des_3
datastore ds_agg_prezzo

integer i, li_righe, li_riga_trovata

if messagebox("Attenzione!", "Vuoi davvero salvare i prezzi CONFERMATI nel listino di destinazione?",  stopsign!, yesno!)<> 1 then return
 
ll_id_var=dw_5.getitemnumber(1, "id_variazione")
if ll_id_var>0 then
	ds_agg_prezzo=create datastore
	ds_agg_prezzo.dataobject="ds_agg_prezzo"
	ds_agg_prezzo.settransobject(sqlca)
	li_righe=ds_agg_prezzo.retrieve(ll_id_var)
	for i= 1 to dw_2.rowcount()
		ls_confermato=dw_2.getitemstring(i, "prezzo_confermato")
		if ls_confermato='C' then
			ls_des_3=dw_2.getitemstring(i, "prezzo_des_3")
			
			ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_prezzo")
			ldc_pr_manifattura=dw_2.getitemdecimal(i, "prezzo_prezzo_manifattura")
			ll_id_uc=dw_2.getitemnumber(i, "prezzo_id_unita_confezione")
			ls_des_3=dw_2.getitemstring(i, "prezzo_des_3")
			
	//		messagebox("id uc", string(ll_id_uc))
	//		messagebox("prezzo", string(ldc_prezzo))
			li_riga_trovata=ds_agg_prezzo.find("id_unita_confezione="+string(ll_id_uc),1, li_righe)
	//		messagebox("riga trovata aggiornare", li_riga_trovata)
			if li_riga_trovata<=0 then 
				li_riga_trovata=ds_agg_prezzo.insertrow(0)
				ds_agg_prezzo.setitem(li_riga_trovata, "id_variazione", ll_id_var)
				ds_agg_prezzo.setitem(li_riga_trovata,"id_unita_confezione", ll_id_uc)
			else
				//se il prezzo è già confermato NON posso aggiornarlo (ma siamo sicuri??????)
				ls_confermato2=ds_agg_prezzo.getitemstring(li_riga_trovata, "confermato")
				if ls_confermato2='C' then continue
			end if
			//devo aggiiungere la conferma e, forse, le des 1 2 3 e poi occorre aggiungere lo sconto del 50% su entrambi io prezzi o il non aggiornamento se nella des sono
			//presenti: 
			ldc_sconto=0.5  //questo poi potrei prenderlo da un campo ...
			if pos(upper(ls_des_3), "SPAZ")>0 or pos(upper(ls_des_3), "IMB")>0 or pos(upper(ls_des_3), "TUBI")>0 or pos(upper(ls_des_3), "LASER")>0 or pos(upper(ls_des_3), "SMER")>0&
			or pos(upper(ls_des_3), "ANN")>0 	or pos(upper(ls_des_3), "C14")>0 or pos(upper(ls_des_3), "C21")>0 then 
				ldc_sconto=0  //metto i prezzi a 0 come mi ha chiesto samy per quelle lavorazioni
			end if
			ds_agg_prezzo.setitem(li_riga_trovata, "prezzo", ldc_prezzo*ldc_sconto)
			ds_agg_prezzo.setitem(li_riga_trovata, "prezzo_manifattura", ldc_pr_manifattura*ldc_sconto)	
			ds_agg_prezzo.setitem(li_riga_trovata, "ins_automatico", "S")
			ds_agg_prezzo.setitem(li_riga_trovata, "des_3", ls_des_3)
			
			ds_agg_prezzo.setitem(li_riga_trovata, "ultima_modifica", today())
		end if
	next
	if ds_agg_prezzo.update()=1 then
		commit;
		messagebox("OK!", "Prezzi salvati correttamente!")
	else
		rollback;
		messagebox("Errore!", "Il salvataggio dei dati non è andato a buon fine!")
	end if
	
	destroy ds_agg_prezzo
	
else
	messagebox("Attenzione!", "Per aggiungere i prezzi occorre indicare un listino!")
end if
end event

type dw_3 from u_dw_ext_main within w_silver_prezzi_excel_colori
integer x = 37
integer y = 76
integer width = 873
integer height = 180
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_id_var_ext"
boolean border = false
end type

event getfocus;//
end event

event losefocus;//
end event

event itemchanged;call super::itemchanged;long ll_id_variazione
integer li_ret

ll_id_variazione=long(data)
if ll_id_variazione> 0 then
	if dw_2.rowcount()>0 then
		li_ret=messagebox("Attenzione!", "Vuoi salvare i dati prima di caricare quelli del listino richiesto?", stopsign!, YesNoCancel!)
		if  li_ret=1 then
			cb_salva.triggerevent(clicked!)
		elseif li_ret=3 then
			return 1
		end if
	end if
	dw_2.retrieve(ll_id_variazione)
end if
end event

type cb_salva from commandbutton within w_silver_prezzi_excel_colori
integer x = 2469
integer y = 164
integer width = 219
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret

li_ret=dw_2.trigger event ue_update()
end event

type st_2 from statictext within w_silver_prezzi_excel_colori
integer x = 73
integer y = 12
integer width = 1998
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Procedura aggiorna prezzi con 3 descrizioni e  data dell~'ultima modifica"
boolean focusrectangle = false
boolean disabledlook = true
end type

type em_data from editmask within w_silver_prezzi_excel_colori
integer x = 905
integer y = 152
integer width = 283
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
end type

event modified;string ls_data
integer rtncode, li_ret
datawindowchild dwc_variazione
date ldt_data

if messagebox("Attenzione!", "Salvare le modifiche prima di cambiare la data di selezione delle variazioni?", stopsign!, yesno!)=1 then
	li_ret=dw_2.trigger event ue_update()
end if
	
ls_data=em_data.text
ldt_data=date(ls_data)
ls_data=string(ldt_data, "yyyy/mm/dd")

rtncode = dw_3.getchild("id_variazione", dwc_variazione)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_variazione.SetTransObject(SQLCA)

// Populate with values for eastern states

dwc_variazione.setfilter( "variazione_data_inizio <= date('"+ls_data+"')  and  variazione_data_fine >= date('"+ls_data+"')")
dwc_variazione.filter()

dwc_variazione.Retrieve()
dw_2.reset()


end event

type dw_1 from udw_base within w_silver_prezzi_excel_colori
integer x = 1211
integer y = 76
integer width = 608
integer height = 180
integer taborder = 41
boolean bringtotop = true
string dataobject = "d_id_art_ext"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;long ll_id_var


if long(data)>0 then
	ll_id_var=dw_3.getitemnumber(1, "id_variazione")
	if ll_id_var>0 then
//		if	messagebox("Attenzione!", "Se ci sono state modifiche DEVONO essere salvate! Ci sono state modifiche?", stopsign!, yesno!)=1 then
//			li_ret=dw_2.trigger event ue_update()
//		end if
		dw_2.setfilter("id_articolo= "+data)
		dw_2.filter()
	else
		messagebox("Attenzione!", "Manca la variazione entro la quale cercare!")
	end if
end if
end event

type cb_togli_filtro from commandbutton within w_silver_prezzi_excel_colori
integer x = 2181
integer y = 160
integer width = 274
integer height = 92
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Togli Filtro"
end type

event clicked;dw_2.setfilter("")
dw_2.filter()
dw_6.reset()
dw_6.insertrow(1)
end event

type cb_ins_art_mancanti from commandbutton within w_silver_prezzi_excel_colori
boolean visible = false
integer x = 5102
integer y = 1864
integer width = 795
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisce in variazione base art. mancanti"
end type

event clicked;long ll_id_var, i, ll_righe, ll_id_uc

//dw_5.settransobject(sqlca)

ll_id_var=dw_3.getitemnumber(1, "id_variazione")
if ll_id_var>0 then
//	ll_righe=dw_5.retrieve(ll_id_var)
	for i= 1 to ll_righe
		//ll_id_uc=dw_5.getitemnumber(i, "id_unita_confezione")
		insert into prezzo (id_unita_confezione, id_variazione, des_3)
		values (:ll_id_uc, :ll_id_var, 'Inserita Automaticamente')
		;
		if sqlca.sqlcode= -1 then
			messagebox("Attenzione!", "Errore nell'inserimento id_UC="+string(ll_id_uc))
			rollback;
		else
			commit;
		end if
		
	next
end if

end event

type cb_aggiorna from commandbutton within w_silver_prezzi_excel_colori
boolean visible = false
integer x = 4727
integer y = 1864
integer width = 320
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Aggiorna"
end type

event clicked;long ll_id_variazione, ll_riga

ll_riga=dw_3.getrow()
if ll_riga>0 then

	ll_id_variazione=dw_3.getitemnumber(ll_riga, "id_variazione")
	dw_2.retrieve(ll_id_variazione)
end if
end event

type sle_path from singlelineedit within w_silver_prezzi_excel_colori
integer x = 6025
integer y = 160
integer width = 361
integer height = 76
integer taborder = 100
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "\\server2019\foto"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_silver_prezzi_excel_colori
integer x = 6057
integer y = 28
integer width = 315
integer height = 108
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Percorso Files FOTO"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_silver_prezzi_excel_colori
boolean visible = false
integer x = 3360
integer y = 160
integer width = 654
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
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Tutti","Controllati","Non Controllati"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case index
	case 1
		dw_2.setfilter("")
		dw_2.filter()
	case 2
		dw_2.setfilter("prezzo_confermato ='C'")
		dw_2.filter()
	case 3
		dw_2.setfilter("prezzo_confermato <> 'C' or isnull(prezzo_confermato)")
		dw_2.filter()

		
end choose
end event

type dw_6 from udw_000 within w_silver_prezzi_excel_colori
integer x = 2706
integer y = 88
integer width = 2409
integer height = 176
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_des_filtro"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string ls_filtro, ls_filtro_originale
date ldt_data

ls_filtro = dw_2.describe("datawindow.table.filter")
if ls_filtro='?' then ls_filtro="("

ls_filtro_originale=ls_filtro
if ls_filtro> "(" then ls_filtro+= " and ("
choose case dwo.name
	case "des_1"
		if data="S" then
			ls_filtro+="prezzo_des_1 >' '"
		elseif data="N" then
			ls_filtro+="isnull(prezzo_des_1) or prezzo_des_1='' "
		elseif data="A" then
			ls_filtro+="prezzo_des_1 like 'AUTO%COR%'"
		elseif data="X" then
			ls_filtro+="prezzo_des_1 like 'AUTO%XLS%'"
		else
			ls_filtro=ls_filtro_originale
		end if
	case "des_2"
		if data="S" then
			ls_filtro+="prezzo_des_2 >' '"
		elseif data="N" then
			ls_filtro+="isnull(prezzo_des_2) or prezzo_des_2='' "
		elseif data="B" then	
			ls_filtro+="prezzo_des_2 like '%+b%'"
		else
			ls_filtro=ls_filtro_originale
		end if
	case "des_3"
		if data="S" then
			ls_filtro+="prezzo_des_3 >' '"
		elseif data="N" then
			ls_filtro+="isnull(prezzo_des_3)  or prezzo_des_3=''"
		else
			ls_filtro=ls_filtro_originale
		end if
	case "controllato"
		if data="T" then
			ls_filtro=ls_filtro_originale
		elseif data="C" then
			ls_filtro+="prezzo_confermato ='C'"		
		Else
			ls_filtro+="prezzo_confermato <> 'C' or isnull(prezzo_confermato)"
		end if
	case "des_1_data"
		ldt_data=date(data)  // prezzo_des_1 like '%13/03/20%'
		ls_filtro+="prezzo_des_1 like  '%"+string(ldt_data, "dd_mm_yy")+"%'"
	case "libero_des2"
		ls_filtro+="prezzo_des_2 like  '%"+data+"%'"
	case "ordina"
		dw_2.setsort(data)
		dw_2.sort()
end choose
ls_filtro+=")"
if right(ls_filtro, 2)="()" then
	ls_filtro=left(ls_filtro, len(ls_filtro) - 7)
end if
dw_2.setfilter(ls_filtro)
dw_2.filter()

//choose case dwo.name
//	case "des_1"
//		if data="S" then
//			ls_filtro+=" and "prezzo_des_1 >' '"
//			//dw_2.setfilter("prezzo_des_1 >' '")
//			dw_2.setfilter(ls_filtro)
//			dw_2.filter()
//		elseif data="N" then
//			dw_2.setfilter("isnull(prezzo_des_1) or prezzo_des_1='' ")
//			dw_2.filter()
//		elseif data="A" then
//			dw_2.setfilter("prezzo_des_1 like 'AUTO%COR%'")
//			dw_2.filter()
//		elseif data="X" then
//			dw_2.setfilter("prezzo_des_1 like 'AUTO%XLS%'")
//			dw_2.filter()
//		else
//			dw_2.setfilter("")
//			dw_2.filter()
//		end if
//	case "des_2"
//			if data="S" then
//			dw_2.setfilter("prezzo_des_2 >' '")
//			dw_2.filter()
//		elseif data="N" then
//			dw_2.setfilter("isnull(prezzo_des_2) or prezzo_des_2='' ")
//			dw_2.filter()
//		elseif data="B" then	
//			dw_2.setfilter("prezzo_des_2 like '%+b%'")
//			dw_2.filter()			
//		else
//			dw_2.setfilter("")
//			dw_2.filter()
//		end if
//	case "des_3"
//		if data="S" then
//			dw_2.setfilter("prezzo_des_3 >' '")
//			dw_2.filter()
//		elseif data="N" then
//			dw_2.setfilter("isnull(prezzo_des_3)  or prezzo_des_3=''")
//			dw_2.filter()
//		else
//			dw_2.setfilter("")
//			dw_2.filter()
//		end if
//	case "controllato"
//		if data="T" then
//			dw_2.setfilter("")
//			dw_2.filter()
//		elseif data="C" then
//			dw_2.setfilter("prezzo_confermato ='C'")
//			dw_2.filter()
//		Else
//			dw_2.setfilter("prezzo_confermato <> 'C' or isnull(prezzo_confermato)")
//			dw_2.filter()
//		end if
//	case "des_1_data"
//		ldt_data=date(data)  // prezzo_des_1 like '%13/03/20%'
//		ls_filtro="prezzo_des_1 like  '%"+string(ldt_data, "dd_mm_yy")+"%'"
//		dw_2.setfilter(ls_filtro)
//		dw_2.filter()
//	case "libero_des2"
//		ls_filtro="prezzo_des_2 like  '%"+data+"%'"
//		dw_2.setfilter(ls_filtro)
//		dw_2.filter()
//		
//end choose
end event

event rowfocuschanged;//
end event

type st_4 from statictext within w_silver_prezzi_excel_colori
integer x = 2862
integer y = 24
integer width = 1600
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "FILTRI"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_vedi_foto from checkbox within w_silver_prezzi_excel_colori
integer x = 914
integer y = 64
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Foto"
boolean lefttext = true
end type

type cb_stampa from commandbutton within w_silver_prezzi_excel_colori
integer x = 2469
integer y = 44
integer width = 219
integer height = 92
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

event clicked;datastore ds_stampa

ds_stampa=create datastore
ds_stampa.dataobject="d_silver_prezzi_stampa"
ds_stampa.settransobject(sqlca)


dw_2.rowscopy(1,   dw_2.RowCount(), Primary!, ds_stampa, 1, Primary!)

//
//printsetup()

//dw_2.modify("prezzo_prezzo_manifattura.visible=0")
//dw_2.modify("prezzo_cliente.visible=0")
//dw_2.modify("articolo_descrizione.visible=0")
//dw_2.modify("c_scelto.visible=0")
//dw_2.print()
ds_stampa.print(true, true)
//dw_2.modify("c_scelto.visible=1")
//dw_2.modify("prezzo_prezzo_manifattura.visible=1")
//dw_2.modify("prezzo_cliente.visible=1")
//dw_2.modify("articolo_descrizione.visible=1")


destroy ds_stampa

end event

type dw_5 from u_dw_ext_main within w_silver_prezzi_excel_colori
integer x = 5120
integer y = 72
integer width = 873
integer height = 180
integer taborder = 31
string dataobject = "d_id_var_ext"
boolean border = false
end type

event getfocus;//
end event

event losefocus;//
end event

type cb_1 from commandbutton within w_silver_prezzi_excel_colori
integer x = 5577
integer y = 48
integer width = 370
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica Solo Sel."
end type

event clicked;long ll_id_var, ll_id_uc
decimal ldc_prezzo, ldc_pr_manifattura, ldc_sconto
string   ls_confermato, ls_confermato2, ls_des_3
datastore ds_agg_prezzo


integer i, li_righe, li_riga_trovata, li_scelto

if messagebox("Attenzione!", "Vuoi davvero salvare i prezzi CONFERMATI E SELEZIONATI nel listino di destinazione?",  stopsign!, yesno!)<> 1 then return
ll_id_var=dw_5.getitemnumber(1, "id_variazione")
if ll_id_var>0 then
	ds_agg_prezzo=create datastore
	ds_agg_prezzo.dataobject="ds_agg_prezzo"
	ds_agg_prezzo.settransobject(sqlca)
	li_righe=ds_agg_prezzo.retrieve(ll_id_var)
	for i= 1 to dw_2.rowcount()
		li_scelto=dw_2.getitemnumber(i, "c_scelto")
		if li_scelto=1 then
			ls_confermato=dw_2.getitemstring(i, "prezzo_confermato")
			if ls_confermato='C' then
				ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_prezzo")
				ldc_pr_manifattura=dw_2.getitemdecimal(i, "prezzo_prezzo_manifattura")
				ll_id_uc=dw_2.getitemnumber(i, "prezzo_id_unita_confezione")
				ls_des_3=dw_2.getitemstring(i, "prezzo_des_3")
		//		messagebox("id uc", string(ll_id_uc))
		//		messagebox("prezzo", string(ldc_prezzo))
				li_riga_trovata=ds_agg_prezzo.find("id_unita_confezione="+string(ll_id_uc),1, li_righe)
		//		messagebox("riga trovata aggiornare", li_riga_trovata)
				if li_riga_trovata<=0 then 
					li_riga_trovata=ds_agg_prezzo.insertrow(0)
					ds_agg_prezzo.setitem(li_riga_trovata, "id_variazione", ll_id_var)
					ds_agg_prezzo.setitem(li_riga_trovata,"id_unita_confezione", ll_id_uc)
				else
					//se il prezzo è già confermato NON posso aggiornarlo (ma siamo sicuri??????)
					ls_confermato2=ds_agg_prezzo.getitemstring(li_riga_trovata, "confermato")
					if ls_confermato2='C' then continue
				end if
				//devo aggiiungere la conferma e, forse, le des 1 2 3 e poi occorre aggiungere lo sconto del 50% su entrambi io prezzi o il non aggiornamento se nella des sono
				//presenti: 
				ldc_sconto=0.5
					if pos(upper(ls_des_3), "SPAZ")>0 or pos(upper(ls_des_3), "IMB")>0 or pos(upper(ls_des_3), "TUBI")>0 or pos(upper(ls_des_3), "LASER")>0 or pos(upper(ls_des_3), "SMER")>0&
			or pos(upper(ls_des_3), "ANN")>0 	or pos(upper(ls_des_3), "C14")>0 or pos(upper(ls_des_3), "C21")>0 then 
					ldc_sconto=0  //metto i prezzi a 0 come mi ha chiesto samy per quelle lavorazioni
				end if
				ds_agg_prezzo.setitem(li_riga_trovata, "prezzo", ldc_prezzo*ldc_sconto)
				ds_agg_prezzo.setitem(li_riga_trovata, "prezzo_manifattura", ldc_pr_manifattura*ldc_sconto)	
				ds_agg_prezzo.setitem(li_riga_trovata, "ins_automatico", "S")
				ds_agg_prezzo.setitem(li_riga_trovata, "des_3", ls_des_3)
				ds_agg_prezzo.setitem(li_riga_trovata, "ultima_modifica", today())
			end if
		END IF
	next
	if ds_agg_prezzo.update()=1 then
		commit;
		messagebox("OK!", "Prezzi salvati correttamente!")
	else
		rollback;
		messagebox("Errore!", "Il salvataggio dei dati non è andato a buon fine!")
	end if
	
	destroy ds_agg_prezzo
	
else
	messagebox("Attenzione!", "Per aggiungere i prezzi occorre indicare un listino!")
end if
end event

type cb_2 from commandbutton within w_silver_prezzi_excel_colori
integer x = 1865
integer y = 136
integer width = 302
integer height = 112
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Crea XLS"
end type

event clicked;INTEGER I
decimal ldc_pr_pz, ldc_pr_man, ldc_verifica_prezzo
string ls_cliente,ls_cod_art, ls_des_prezzo, ls_filtro,ls_filename, ls_des_1
long ll_riga_inserita, LL_ID_ART
integer li_righe


ls_filtro= dw_2.describe("datawindow.table.filter")

DW_2.SETFILTER(" c_scelto=1 and "+ls_filtro)
dw_2.filter()
li_righe=dw_2.rowcount()
if li_righe<=0 then 
	messagebox("Attenzione!", "Non hai selezionato alcuna riga")
	return
end if
cb_controlla_prezzo.triggerevent("rbuttondown")
dw_7.reset()
for i=1 to li_righe
	ls_cod_art=""
	ls_cliente=""
	ldc_pr_pz=0
	ldc_pr_man=0
	ls_des_prezzo=""
	ls_des_1=""
	ldc_verifica_prezzo=0
	LL_ID_ART=0
	ls_cod_art=dw_2.getitemstring(i, "articolo_codice")
	ls_cliente=dw_2.getitemstring(i,"prezzo_cliente")
	ldc_pr_pz=dw_2.getitemdecimal(i,"prezzo_prezzo")
	ldc_pr_man=dw_2.getitemdecimal(i,"prezzo_prezzo_manifattura")
	ls_des_prezzo=dw_2.getitemstring(i,"prezzo_des_2")
	ls_des_1=dw_2.getitemstring(i,"prezzo_des_1")
	LL_ID_ART=dw_2.getitemnumber(i,"id_articolo")
	ldc_verifica_prezzo=dw_2.getitemdecimal(i,"c_controllato_k")
	if ldc_verifica_prezzo<=0.00002 then ldc_verifica_prezzo=0
	ll_riga_inserita=dw_7.insertrow(0)
	dw_7.setitem(ll_riga_inserita, "cod_articolo", ls_cod_art)
	dw_7.setitem(ll_riga_inserita, "cliente", ls_cliente)
	dw_7.setitem(ll_riga_inserita, "pr_pz", ldc_pr_pz)
	dw_7.setitem(ll_riga_inserita, "pr_man", ldc_pr_man)
	dw_7.setitem(ll_riga_inserita, "descrizione_prezzo", ls_des_prezzo)
	dw_7.setitem(ll_riga_inserita, "des_1", ls_des_1)
	dw_7.setitem(ll_riga_inserita, "id_articolo", LL_ID_ART)	
	dw_7.setitem(ll_riga_inserita, "controllato_k", ldc_verifica_prezzo)	
	//controllato_k
next
ls_filename=""
dw_7.saveas(ls_filename, Excel!, true)      // il true vuol dire con intestazione

DW_2.SETFILTER(ls_filtro)
dw_2.filter()

//Yes, use OLE automation.
//Do whatever you want, using Excel commands.
//
//Partial example:
//..... declare objects and connect.....
//ole_excel.Application.Workbooks.Open(ls_path)
//xlsub = ole_excel.Application.ActiveWorkbook.Worksheets[1]
//// Center column 1:
//xlsub.Columns(1).HorizontalAlignment = -4108
///// Where xlCenter = -4108 (Get from Excel)
//
//HTH
end event

type dw_7 from udw_000 within w_silver_prezzi_excel_colori
boolean visible = false
integer x = 878
integer y = 2064
integer width = 3863
integer height = 664
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_crea_xls"
boolean vscrollbar = true
end type

type cb_vedi_lav_k from commandbutton within w_silver_prezzi_excel_colori
integer x = 1865
integer y = 16
integer width = 297
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vedi Lav. K"
end type

event clicked;open(w_lav_k)
end event

type cb_controlla_prezzo from commandbutton within w_silver_prezzi_excel_colori
integer x = 2181
integer y = 48
integer width = 274
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Controlla"
end type

event clicked;string ls_des_2, ls_lettera, ls_espressione,ls_lettera_dopo
integer i, li_test, li_lunghezza, a, li_pos, b, li_pos_x
decimal ldc_tot, ldc_valore, l

l=2
dw_2.accepttext()
for i= 1 to dw_2.rowcount()
	li_test=dw_2.getitemnumber(i, "c_scelto")
	if li_test=1 then
		ls_des_2=dw_2.getitemstring(i, "prezzo_des_2")
		ls_des_2=trim(ls_des_2)
		li_lunghezza=len(ls_des_2)
		b=0
		li_pos=0
		ldc_tot=0
		ldc_valore=0
		do while li_test>=0 
			b=li_pos+1
			li_pos=pos(ls_des_2, "+", b)
			if li_pos<=0 then 
				li_pos=li_lunghezza+1
				li_test= -1
			end if
			ls_lettera=mid(ls_des_2, b, li_pos - b)
			//controllo se c'è il x la che devo trovare i due valori e moltiplicarli
			li_pos_x=pos(ls_lettera, "x")
			if li_pos_x>0 then
				ldc_valore=wf_trova_valore(left(ls_lettera, li_pos_x - 1))
				ldc_valore=round(ldc_valore, 5)
				ldc_valore*=integer(mid(ls_lettera, li_pos_x + 1, len(ls_lettera) - li_pos_x))
			else
				ldc_valore=wf_trova_valore(ls_lettera)
			end if
			ldc_valore=round(ldc_valore, 4)
			if ldc_valore<>0 then
				ldc_tot+=ldc_valore
			end if		
		loop
		ldc_tot=round(ldc_tot, 3) //samy vuole il prezzo totale arrotondato al terzo dec (20200702)
		dw_2.setitem(i, "c_controllato_k", ldc_tot)
		
//		ldc_valore=dw_2.getitemdecimal(i, "prezzo_prezzo")
//		if ldc_valore<>ldc_tot then
//			dw_2.setitem(i, "c_controllato_k", 1)
//			
//			//dw_2.modify("prezzo_prezzo.background.mode=0")
//			//dw_2.modify("prezzo_prezzo.background.color='65280~tIf(getrow()=~~'string(i)~~',255,65280)")
//		end if
	end if
	
next	
//"~tif(yes_or_no=~~'Y~~'," &
//"salary.Color='0~tIf(salary>90000,255,65280)'")


end event

event rbuttondown;string ls_des_2, ls_lettera, ls_espressione,ls_lettera_dopo
integer i, li_test, li_lunghezza, a, li_pos, b, li_pos_x
decimal ldc_tot, ldc_valore

for i= 1 to dw_2.rowcount()
	ls_des_2=upper(dw_2.getitemstring(i, "prezzo_des_2"))
	if pos(ls_des_2, "K")>0 then
		ls_des_2=trim(ls_des_2)
		li_lunghezza=len(ls_des_2)
		b=0
		li_pos=0
		ldc_tot=0
		ldc_valore=0
		li_test=1
		do while li_test>=0  
			b=li_pos+1
			li_pos=pos(ls_des_2, "+", b)
			if li_pos<=0 then 
				li_pos=li_lunghezza+1
				li_test= -1
			end if
			ls_lettera=mid(ls_des_2, b, li_pos - b)
			//controllo se c'è il x la che devo trovare i due valori e moltiplicarli
			li_pos_x=pos(ls_lettera, "X")
			if li_pos_x>0 then
				ldc_valore=wf_trova_valore(left(ls_lettera, li_pos_x - 1))
				ldc_valore=round(ldc_valore, 5)
				ldc_valore*=integer(mid(ls_lettera, li_pos_x + 1, len(ls_lettera) - li_pos_x))
			else
				ldc_valore=wf_trova_valore(ls_lettera)
			end if
			ldc_valore=round(ldc_valore, 4)
			if ldc_valore<>0 then
				ldc_tot+=ldc_valore
			end if		
		loop
		//arrotondo al terzo decimale perché così fa la Samy 
		ldc_tot=round(ldc_tot, 3)
		if ldc_tot> 0 then dw_2.setitem(i, "c_controllato_k", ldc_tot)
	end if
next	
end event

type cb_3 from commandbutton within w_silver_prezzi_excel_colori
integer x = 4393
integer y = 372
integer width = 475
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ricopia in basso"
end type

event clicked;string  ls_des_2
integer i
dw_2.accepttext()
ls_des_2=dw_2.getitemstring(1, "prezzo_des_2")
if ls_des_2> " " then
	for i= 2 to dw_2.rowcount()
		dw_2.setitem(i, "prezzo_des_2",ls_des_2)
	next
end if
end event

