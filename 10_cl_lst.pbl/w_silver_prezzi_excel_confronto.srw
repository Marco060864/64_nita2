forward
global type w_silver_prezzi_excel_confronto from w_001
end type
type dw_2 from udw_base within w_silver_prezzi_excel_confronto
end type
type cb_carica_prezzi from commandbutton within w_silver_prezzi_excel_confronto
end type
type dw_3 from u_dw_ext_main within w_silver_prezzi_excel_confronto
end type
type cb_salva from commandbutton within w_silver_prezzi_excel_confronto
end type
type st_2 from statictext within w_silver_prezzi_excel_confronto
end type
type em_data from editmask within w_silver_prezzi_excel_confronto
end type
type dw_1 from udw_base within w_silver_prezzi_excel_confronto
end type
type cb_togli_filtro from commandbutton within w_silver_prezzi_excel_confronto
end type
type sle_path from singlelineedit within w_silver_prezzi_excel_confronto
end type
type st_3 from statictext within w_silver_prezzi_excel_confronto
end type
type ddlb_1 from dropdownlistbox within w_silver_prezzi_excel_confronto
end type
type dw_6 from udw_000 within w_silver_prezzi_excel_confronto
end type
type st_4 from statictext within w_silver_prezzi_excel_confronto
end type
type cbx_vedi_foto from checkbox within w_silver_prezzi_excel_confronto
end type
type cb_stampa from commandbutton within w_silver_prezzi_excel_confronto
end type
type dw_5 from u_dw_ext_main within w_silver_prezzi_excel_confronto
end type
type cb_1 from commandbutton within w_silver_prezzi_excel_confronto
end type
type cb_2 from commandbutton within w_silver_prezzi_excel_confronto
end type
type dw_7 from udw_000 within w_silver_prezzi_excel_confronto
end type
type cb_vedi_lav_k from commandbutton within w_silver_prezzi_excel_confronto
end type
type cb_controlla_prezzo from commandbutton within w_silver_prezzi_excel_confronto
end type
end forward

global type w_silver_prezzi_excel_confronto from w_001
integer x = 1057
integer y = 483
integer width = 6505
integer height = 2632
string title = "w_silver_prezzi_excel_da_doc"
boolean minbox = true
windowtype windowtype = popup!
dw_2 dw_2
cb_carica_prezzi cb_carica_prezzi
dw_3 dw_3
cb_salva cb_salva
st_2 st_2
em_data em_data
dw_1 dw_1
cb_togli_filtro cb_togli_filtro
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
end type
global w_silver_prezzi_excel_confronto w_silver_prezzi_excel_confronto

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
//arrotondo al terzo decimale perché così fa la Samy 
ldc_valore=round(ldc_valore, 3)
return ldc_valore
end function

on w_silver_prezzi_excel_confronto.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_carica_prezzi=create cb_carica_prezzi
this.dw_3=create dw_3
this.cb_salva=create cb_salva
this.st_2=create st_2
this.em_data=create em_data
this.dw_1=create dw_1
this.cb_togli_filtro=create cb_togli_filtro
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_carica_prezzi
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_data
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_togli_filtro
this.Control[iCurrent+9]=this.sle_path
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.ddlb_1
this.Control[iCurrent+12]=this.dw_6
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.cbx_vedi_foto
this.Control[iCurrent+15]=this.cb_stampa
this.Control[iCurrent+16]=this.dw_5
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.cb_2
this.Control[iCurrent+19]=this.dw_7
this.Control[iCurrent+20]=this.cb_vedi_lav_k
this.Control[iCurrent+21]=this.cb_controlla_prezzo
end on

on w_silver_prezzi_excel_confronto.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_carica_prezzi)
destroy(this.dw_3)
destroy(this.cb_salva)
destroy(this.st_2)
destroy(this.em_data)
destroy(this.dw_1)
destroy(this.cb_togli_filtro)
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
end on

event open;call super::open;string ls_data, ls_cod_articolo, ls_des_articolo,ls_des_2, ls_des_2_old
date ldt_data
datawindowchild dwc_variazione
integer rtncode, i, li_controllato, a, b, li_upperbound

long ll_id_uc, ll_id_art,ll_id_var,ll_test, ll_id_doc,ll_id_var_k, ll_lista_id_art[]
date ldt_data_Doc
decimal 	ldc_prezzo,ldc_prezzo_man, ldc_prezzo_gia_in_listino, ldc_prezzo_K
boolean lb_continue

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


dw_3.insertrow(1)
dw_1.insertrow(1)
//ddlb_1.SelectItem(1)
dw_6.insertrow(1)
dw_5.insertrow(1)


end event

event resize;call super::resize;dw_2.width=width - 100
dw_2.height=height - 400
end event

event ue_postopen;call super::ue_postopen;string ls_data, ls_cod_articolo, ls_des_articolo,ls_des_2, ls_des_2_old
date ldt_data

integer rtncode, i, li_controllato, a, b, li_upperbound, li_test, li_prima

long ll_id_uc, ll_id_art,ll_id_var,ll_test, ll_id_doc,ll_id_var_k, ll_lista_id_art[]
date ldt_data_Doc
decimal 	ldc_prezzo,ldc_prezzo_man, ldc_prezzo_gia_in_listino, ldc_prezzo_K
boolean lb_continue


end event

type st_1 from w_001`st_1 within w_silver_prezzi_excel_confronto
end type

type dw_2 from udw_base within w_silver_prezzi_excel_confronto
integer x = 32
integer y = 280
integer width = 6382
integer height = 2224
boolean bringtotop = true
string dataobject = "d_ges_listino_silver_confronto"
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

event itemchanged;call super::itemchanged;
choose case dwo.name
	case "prezzo_confermato",  "prezzo_prezzo" , "prezzo_prezzo_manifattura"
		if dwo.name= "prezzo_confermato" then
			if data='N' then
				open(w_password_pop)
				if message.doubleparm=1 then
					
				else
					return 2
				end if
			end if
		end if
	setitem(row, "prezzo_ultima_modifica", today())
	
		
	
	
end choose
end event

event clicked;call super::clicked;integer i, li_seleziona
string ls_setta
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
elseif dwo.name='prezzo_confermato' then
	ls_setta=GETITEMSTRING(row, "prezzo_des_1")
	if isnull(ls_setta) then ls_setta=""
	if  pos(ls_setta, "AUTO")<=0 then setitem(row, "prezzo_des_1", "AUTO PAN - "+ls_setta)
	
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

event retrievestart;call super::retrievestart;//return 2
end event

event ue_update;integer li_ret, i
string ls_filtro
datastore ds_update
dwitemstatus dstatus

ls_filtro="prezzo_confermato='C'"
setfilter(ls_filtro)
filter()

ds_update=create datastore
ds_update.dataobject="d_ges_listino_silver_da_doc"
ds_update.settransobject(sqlca)
for i=1 to dw_2.rowcount()
	dstatus=dw_2.getitemstatus(i, 0, primary!)
	dw_2.rowscopy(i,i, Primary!, ds_update, i, Primary!) 
	ds_update.setitemstatus(i, 0, primary!, dstatus)
	
next
li_ret=ds_update.update()
if li_ret=1 then
	commit;
else
	rollback;
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if

destroy(ds_update)

//li_ret=update()
//if li_ret=1 then
//	commit;
//else
//	rollback;
//	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
//end if
	
setfilter("")
filter()
	
return li_ret
end event

type cb_carica_prezzi from commandbutton within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 5842
integer y = 48
integer width = 407
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

type dw_3 from u_dw_ext_main within w_silver_prezzi_excel_confronto
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

type cb_salva from commandbutton within w_silver_prezzi_excel_confronto
integer x = 2679
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

li_ret=dw_2.update()
if li_ret=1 then
	commit;
else
	rollback;
	messagebox("", li_ret)
end if


//li_ret=dw_2.trigger event ue_update()

end event

type st_2 from statictext within w_silver_prezzi_excel_confronto
integer x = 73
integer y = 12
integer width = 2144
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
string text = "Procedura PRENDE prezzi dal documento"
boolean focusrectangle = false
boolean disabledlook = true
end type

type em_data from editmask within w_silver_prezzi_excel_confronto
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

type dw_1 from udw_base within w_silver_prezzi_excel_confronto
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

type cb_togli_filtro from commandbutton within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 2391
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
end event

type sle_path from singlelineedit within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 5586
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
string text = "\\server2017\foto"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 5623
integer y = 40
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

type ddlb_1 from dropdownlistbox within w_silver_prezzi_excel_confronto
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

type dw_6 from udw_000 within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 2912
integer y = 88
integer width = 2441
integer height = 176
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_des_filtro"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string ls_filtro
date ldt_data
choose case dwo.name
	case "des_1"
		if data="S" then
			dw_2.setfilter("prezzo_des_1 >' '")
			dw_2.filter()
		elseif data="N" then
			dw_2.setfilter("isnull(prezzo_des_1) or prezzo_des_1='' ")
			dw_2.filter()
		elseif data="A" then
			dw_2.setfilter("prezzo_des_1 like 'AUTO%COR%'")
			dw_2.filter()
		elseif data="X" then
			dw_2.setfilter("prezzo_des_1 like 'AUTO%XLS%'")
			dw_2.filter()
		else
			dw_2.setfilter("")
			dw_2.filter()
		end if
	case "des_2"
			if data="S" then
			dw_2.setfilter("prezzo_des_2 >' '")
			dw_2.filter()
		elseif data="N" then
			dw_2.setfilter("isnull(prezzo_des_2) or prezzo_des_2='' ")
			dw_2.filter()
		else
			dw_2.setfilter("")
			dw_2.filter()
		end if
	case "des_3"
		if data="S" then
			dw_2.setfilter("prezzo_des_3 >' '")
			dw_2.filter()
		elseif data="N" then
			dw_2.setfilter("isnull(prezzo_des_3)  or prezzo_des_3=''")
			dw_2.filter()
		else
			dw_2.setfilter("")
			dw_2.filter()
		end if
	case "controllato"
	if data="T" then
		dw_2.setfilter("")
		dw_2.filter()
	elseif data="C" then
		dw_2.setfilter("prezzo_confermato ='C'")
		dw_2.filter()
	
	Else
		dw_2.setfilter("prezzo_confermato <> 'C' or isnull(prezzo_confermato)")
		dw_2.filter()
	end if
case "des_1_data"
		ldt_data=date(data)  // prezzo_des_1 like '%13/03/20%'
		ls_filtro="prezzo_des_1 like  '%"+string(ldt_data, "dd_mm_yy")+"%'"
		dw_2.setfilter(ls_filtro)
		dw_2.filter()
		
end choose
end event

event rowfocuschanged;//
end event

type st_4 from statictext within w_silver_prezzi_excel_confronto
boolean visible = false
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

type cbx_vedi_foto from checkbox within w_silver_prezzi_excel_confronto
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

type cb_stampa from commandbutton within w_silver_prezzi_excel_confronto
integer x = 2679
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

event clicked;printsetup()
//dw_1.modify("prezzo_ult_modifica.visible=0")
//dw_1.modify("prezzo_ult_modifica_t.visible=0")
dw_2.modify("c_scelto.visible=0")
dw_2.print()
dw_2.modify("c_scelto.visible=1")
//dw_1.modify("prezzo_ult_modifica.visible=1")
//dw_1.modify("prezzo_ult_modifica_t.visible=1")
end event

type dw_5 from u_dw_ext_main within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 5829
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

type cb_1 from commandbutton within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 6258
integer y = 48
integer width = 375
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

type cb_2 from commandbutton within w_silver_prezzi_excel_confronto
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

type dw_7 from udw_000 within w_silver_prezzi_excel_confronto
boolean visible = false
integer x = 539
integer y = 1988
integer width = 3863
integer height = 664
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_crea_xls"
boolean vscrollbar = true
end type

type cb_vedi_lav_k from commandbutton within w_silver_prezzi_excel_confronto
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

type cb_controlla_prezzo from commandbutton within w_silver_prezzi_excel_confronto
integer x = 2391
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
		do while li_test>=0  //manca il controllo del seegno "x"
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
		if ldc_tot> 0 then dw_2.setitem(i, "c_controllato_k", ldc_tot)
	end if
next	
end event

