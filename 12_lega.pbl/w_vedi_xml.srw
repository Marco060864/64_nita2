forward
global type w_vedi_xml from w_base
end type
type dw_5 from udw_001 within w_vedi_xml
end type
type cb_3 from commandbutton within w_vedi_xml
end type
type cb_p7m from commandbutton within w_vedi_xml
end type
type cb_vai from commandbutton within w_vedi_xml
end type
type cb_trova from commandbutton within w_vedi_xml
end type
type dw_4 from udw_001 within w_vedi_xml
end type
type cb_ricerca from commandbutton within w_vedi_xml
end type
type cb_cancella from commandbutton within w_vedi_xml
end type
type cb_salva from commandbutton within w_vedi_xml
end type
type cb_inserisci from commandbutton within w_vedi_xml
end type
type cb_1 from commandbutton within w_vedi_xml
end type
type cb_stampa from commandbutton within w_vedi_xml
end type
type cb_confronto from commandbutton within w_vedi_xml
end type
type cb_preview from commandbutton within w_vedi_xml
end type
type cb_2 from commandbutton within w_vedi_xml
end type
type cb_carica_xml from commandbutton within w_vedi_xml
end type
type cb_carica from commandbutton within w_vedi_xml
end type
type dw_2 from udw_001 within w_vedi_xml
end type
type dw_3 from udw_001 within w_vedi_xml
end type
type dw_1 from udw_001 within w_vedi_xml
end type
end forward

global type w_vedi_xml from w_base
integer width = 5957
integer height = 2972
dw_5 dw_5
cb_3 cb_3
cb_p7m cb_p7m
cb_vai cb_vai
cb_trova cb_trova
dw_4 dw_4
cb_ricerca cb_ricerca
cb_cancella cb_cancella
cb_salva cb_salva
cb_inserisci cb_inserisci
cb_1 cb_1
cb_stampa cb_stampa
cb_confronto cb_confronto
cb_preview cb_preview
cb_2 cb_2
cb_carica_xml cb_carica_xml
cb_carica cb_carica
dw_2 dw_2
dw_3 dw_3
dw_1 dw_1
end type
global w_vedi_xml w_vedi_xml

type variables
 
end variables

forward prototypes
public function string f_cambia_punto_in_virgola (string as_val)
public function integer wf_controlla_gia_trovato (string as_nome_file, nvo_file_list asl_file_trovati)
end prototypes

public function string f_cambia_punto_in_virgola (string as_val);integer li_pos

li_pos=pos(as_val, ".")
if li_pos>0 then
	as_val=left(as_val, li_pos - 1)+","+right(as_val, len(as_val) - li_pos)
end if
return as_val
end function

public function integer wf_controlla_gia_trovato (string as_nome_file, nvo_file_list asl_file_trovati);integer i, li_return=0

for i=1 to upperbound(asl_file_trovati.as_file)
	if as_nome_file=asl_file_trovati.as_file[i] then
		li_return=1
		exit
	end if
next

return li_return
end function

on w_vedi_xml.create
int iCurrent
call super::create
this.dw_5=create dw_5
this.cb_3=create cb_3
this.cb_p7m=create cb_p7m
this.cb_vai=create cb_vai
this.cb_trova=create cb_trova
this.dw_4=create dw_4
this.cb_ricerca=create cb_ricerca
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.cb_1=create cb_1
this.cb_stampa=create cb_stampa
this.cb_confronto=create cb_confronto
this.cb_preview=create cb_preview
this.cb_2=create cb_2
this.cb_carica_xml=create cb_carica_xml
this.cb_carica=create cb_carica
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_p7m
this.Control[iCurrent+4]=this.cb_vai
this.Control[iCurrent+5]=this.cb_trova
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.cb_ricerca
this.Control[iCurrent+8]=this.cb_cancella
this.Control[iCurrent+9]=this.cb_salva
this.Control[iCurrent+10]=this.cb_inserisci
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.cb_stampa
this.Control[iCurrent+13]=this.cb_confronto
this.Control[iCurrent+14]=this.cb_preview
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.cb_carica_xml
this.Control[iCurrent+17]=this.cb_carica
this.Control[iCurrent+18]=this.dw_2
this.Control[iCurrent+19]=this.dw_3
this.Control[iCurrent+20]=this.dw_1
end on

on w_vedi_xml.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.cb_3)
destroy(this.cb_p7m)
destroy(this.cb_vai)
destroy(this.cb_trova)
destroy(this.dw_4)
destroy(this.cb_ricerca)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.cb_1)
destroy(this.cb_stampa)
destroy(this.cb_confronto)
destroy(this.cb_preview)
destroy(this.cb_2)
destroy(this.cb_carica_xml)
destroy(this.cb_carica)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_1)
end on

event open;call super::open;

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
dw_4.settransobject(sqlca)
dw_4.insertrow(1)

dw_5.settransobject(sqlca)


end event

type dw_5 from udw_001 within w_vedi_xml
integer x = 18
integer y = 2540
integer width = 3451
integer height = 300
integer taborder = 40
string dataobject = "d_lista_mail"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;//
end event

event itemfocuschanged;//
end event

event losefocus;//
end event

event rbuttondown;call super::rbuttondown;string ls_file_collegato, ls_id_sdi

if row>0 then
	ls_file_collegato=dw_1.getitemstring(row,  "file_collegato")
	if ls_file_collegato> " " then
		dw_3.setitem(1, "path_xml", ls_file_collegato)
		ls_id_sdi=dw_1.getitemstring(row,  "num_sdi")
		dw_3.setitem(1, "id_sdi", ls_id_sdi)
		cb_carica_xml.triggerevent(clicked!)
		
	end if
	
end if
end event

event rowfocuschanged;//
end event

type cb_3 from commandbutton within w_vedi_xml
integer x = 5349
integer y = 224
integer width = 462
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rec Mail"
end type

event clicked;mailSession mSes
mailReturnCode mRet
mailMessage msg
long n, c_row, i
string ls_mittente, ls_file
 mailFileDescription ls_attach[]
// Create a mail session
mSes = create mailSession

// Log on to the session
//mRet = mSes.mailLogon(mailNewSession!)
mRet = mSes.mailLogon()
//mRet = mSes.mailLogon("marco.mozzorecchi@libero.it", "pippone01")
IF mRet <> mailReturnSuccess! THEN 
	MessageBox("Mail", 'Logon failed.') 
	DESTROY mSes
	RETURN
END IF

mSes.mailGetMessages()
FOR n = 1 to UpperBound(mSes.MessageID[])
    mSes.mailReadMessage(mSes.MessageID[n],  msg, mailEntireMessage!, FALSE)
    c_row = dw_5.InsertRow(0)
    dw_5.SetItem(c_row, "msgid", mSes.MessageID[n])
    dw_5.SetItem(c_row, "msgdate", msg.DateReceived)
    // Truncate subject to fit defined column size
    dw_5.SetItem(c_row, "msgsubject", Left(msg.Subject, 60))
	ls_mittente= msg.Recipient[1].name
	dw_5.SetItem(c_row, "mittente", ls_mittente)
	ls_attach=msg.AttachmentFile

	for i=1 to upperbound(msg.AttachmentFile)
		ls_file+=msg.AttachmentFile[i].filename+";"
	next
	dw_5.SetItem(c_row, "attach", ls_file)
NEXT

mSes.mailLogoff()

DESTROY mSes
end event

type cb_p7m from commandbutton within w_vedi_xml
integer x = 3598
integer y = 360
integer width = 178
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "P7M"
end type

event clicked;integer li_FileNum, li_pos
string  ls_Emp, ls_2
blob Emp
long ll_bytes, ll_FLength
boolean lb_trovato_inizio=false, lb_trovata_fine=false

ll_FLength = FileLength64("c:\nita\xlm_fe\IT02355260981_0o03Q.xml.p7m")

li_FileNum =fileopen("c:\nita\xlm_fe\IT02355260981_0o03Q.xml.p7m", linemode!, Read!, Shared!)


FileReadEx(li_FileNum, ls_Emp)
do while ls_emp> " "
	
	if lb_trovato_inizio=false then
		li_pos=pos(ls_emp, "<?xml")
		if li_pos>0 then
			lb_trovato_inizio=true
			ls_emp=right(ls_emp, len(ls_emp) - li_pos +1)
			ls_2+=ls_Emp
		end if
	else
		if lb_trovata_fine=false then
			li_pos=pos(ls_emp, "</FatturaElettronica>")
			if li_pos> 0 then
				ls_emp=left(ls_emp, li_pos +21)
				ls_2+=ls_emp
				exit
			else
				ls_2+=ls_emp
			end if
		end if
	end if
	//ls_2+=ls_Emp
	FileReadEx(li_FileNum, ls_Emp)
loop
//ll_bytes=FileReadEx(li_FileNum, Emp)

fileclose(li_FileNum)
//ls_Emp = String(Emp, EncodingANSI!)   //EncodingUTF8
//ls_2=String(Emp, EncodingUTF8!)
messagebox("W", ls_Emp)

messagebox("V", ls_2)


end event

type cb_vai from commandbutton within w_vedi_xml
integer x = 5061
integer y = 2608
integer width = 343
integer height = 188
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vai"
end type

event clicked;string ls_numero, ls_cerca="", ls_data
date ldt_data
long ll_riga
dw_4.accepttext()

ls_numero=dw_4.getitemstring(1, "num_fattura")
ldt_data=dw_4.getitemdate(1, "data_fattura")
if ls_numero> " " then
	ls_cerca="num_fattura='"+ls_numero+"'"
end if
if ldt_data> date("1900-01-01") then
	ls_data=string(ldt_data, "yyyy/mm/dd")
	if ls_cerca> " " then ls_cerca+=" and "
	ls_cerca+=" data_emissione= date('"+ls_data+"')"
end if
if ls_cerca> " " then 
	ll_riga=dw_1.find(ls_cerca, 1, dw_1.rowcount())
	if ll_riga> 0 then
		
		dw_1.setfocus()
		dw_1.scrolltorow(ll_riga)
		
	end if
end if
end event

type cb_trova from commandbutton within w_vedi_xml
integer x = 4686
integer y = 2608
integer width = 343
integer height = 188
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TROVA"
end type

event clicked;string ls_numero, ls_cerca="", ls_data
date ldt_data

dw_4.accepttext()
if cb_trova.text="TUTTI" then
	dw_1.setfilter("")
	dw_1.filter()
	cb_trova.text="TROVA"
	dw_1.setsort("data_emissione, num_fattura")
	dw_1.sort()
else
	ls_numero=dw_4.getitemstring(1, "num_fattura")
	ldt_data=dw_4.getitemdate(1, "data_fattura")
	if ls_numero> " " then
		ls_cerca="num_fattura='"+ls_numero+"'"
	end if
	if ldt_data> date("1900-01-01") then
		ls_data=string(ldt_data, "yyyy/mm/dd")
		if ls_cerca> " " then ls_cerca+=" and "
		ls_cerca+=" data_emissione= date('"+ls_data+"')"
	end if
	if ls_cerca> " " then 
		dw_1.setfilter(ls_cerca)
		dw_1.filter()
		cb_trova.text="TUTTI"
	end if
end if
end event

type dw_4 from udw_001 within w_vedi_xml
integer x = 3493
integer y = 2612
integer width = 1184
integer height = 188
integer taborder = 10
boolean bringtotop = true
string title = "Parametri"
string dataobject = "d_cerca_num_data_fattura"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_ricerca from commandbutton within w_vedi_xml
integer x = 4553
integer y = 368
integer width = 256
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
end type

event clicked;long ll_id_testa
s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_contr_fat_ric_testa'
s_ric.titolo_finestra="Ricerca Lista Controllo Fat. Ricevute"

openwithparm(w_ric_sw, s_ric)

if isvalid(message) then 
	ll_id_testa=message.doubleparm
	dw_1.dataobject="d_controllo_fat_ricevute_ra"
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ll_id_testa)
end if
end event

type cb_cancella from commandbutton within w_vedi_xml
integer x = 5175
integer y = 368
integer width = 251
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_1.getrow()
dw_1.trigger event ue_delete(ll_riga_da_cancellare)	
end event

type cb_salva from commandbutton within w_vedi_xml
integer x = 5463
integer y = 368
integer width = 251
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;date ldt_da_data, ldt_a_data
long ll_id_controllo
integer i

if dw_1.dataobject="d_controllo_fat_ricevute" then
	dw_3.accepttext()
	ldt_da_data=dw_3.getitemdate(1, "da_data")
	if ldt_da_data> date("1900-01-01") then
		select id_controllo_fat_ricevute
		into :ll_id_controllo
		from dba.contr_fat_ric_testa
		where da_data=:ldt_da_data
		;
		if ll_id_controllo>0 then
			messagebox("Attenzione!", "Lista Controllo già Salvata!, Vuoi modificarla con i dati attuali ?")
		else
			//prma salvo la testa, poi prendo l'id testa e lo metto sulle righe, poi salvo le righe
			ldt_a_data=dw_3.getitemdate(1, "a_data")
			if isnull(ldt_a_data) then
				messagebox("Attenzione!", "Data fine controllo NON inserita: inserirla e riprovare")
				return
			end if
			insert into dba.contr_fat_ric_testa ("da_data", "a_data")
			values(:ldt_da_data, :ldt_a_data)
			;
			if sqlca.sqlcode=0 then
				commit;
				select @@identity
				into :ll_id_controllo
				from dba.contr_fat_ric_testa
				;
				for i=1 to dw_1.rowcount()
					dw_1.setitem(i, "id_controllo_fat_ricevute",ll_id_controllo )
				next
				dw_1.trigger event ue_update()
			else
				rollback;
				messagebox("Attenzione!", "Salvataggio testa Non riuscito!")
			end if	
		end if
	else
		messagebox("Attenzione!", "Data inizio controllo NON inserita: inserirla e riprovare")
	end if
else
	//è una lista che viene dalla ricerca, è già stata salvata occorre stabilire cosa si vul fare
end if
end event

type cb_inserisci from commandbutton within w_vedi_xml
integer x = 4887
integer y = 368
integer width = 251
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_1.trigger event ue_insert(0)
end event

type cb_1 from commandbutton within w_vedi_xml
boolean visible = false
integer x = 5106
integer y = 2156
integer width = 197
integer height = 56
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;PBDOM_BUILDER pbdombuilder_new
PBDOM_DOCUMENT pbdom_doc
PBDOM_OBJECT pbdom_dati_xml[], pbdom_dati_xml2[], pbdom_AZZERA_xml[]
PBDOM_ELEMENT pbdom_elem[],pbdom_elem2[]
PBDOM_TEXT pbdom_txt[]
PBDOM_ATTRIBUTE ldom_tipo_doc

integer li_ret, li_file, i, li_index, a, b, c, d
string ls_path, ls_file_xml, ls_errori[], ls_message, ls_cod_destinatario, ls_appoggio, ls_id_fiscale
boolean lb_parse=false
long ll_count, ll_riga_inserita
string ls_paese, ls_titolo=""

ls_path=dw_3.getitemstring(1, "path_xml")
if pos(upper(left(ls_path, len(ls_path) - 4)), ".XML")>0 then 
	MessageBox ("Errore nel nome del file XML", "Il file scelto NON è nel formato corretto! Potrebbe essere un file tipo 'Metadati'")
	return
else
	ls_titolo="Id_SDI:"+dw_3.getitemstring(1, "id_sdi")
end if
if upper(right(ls_path, 4))<>".XML" then
	getfileopenname("Cerca DOCasci_", ls_path, ls_file_xml, "xml", "testo, *.*", ls_path)
end if

pbdombuilder_new = Create PBDOM_BUILDER

pbdom_doc = pbdombuilder_new.BuildFromfile(ls_path)
lb_parse=pbdombuilder_new.GetParseErrors(ls_errori)
if lb_parse then
	for i=1 to upperbound(ls_errori)
		messagebox("E", ls_errori[i])
	next
end if
//MessageBox ("PBDOM_DOC Name", pbdom_doc.getname())
pbdom_doc.GetRootElement()//.GetContent( ref pbdom_dati_xml )
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName()) 
pbdom_doc.GetElementsByTagName ( "FatturaElettronicaHeader", pbdom_elem[] )
//pbdom_doc.SetRootElement(pbdom_elem[])
//pbdom_doc.GetElementsByTagName ( "IdTrasmittente", pbdom_elem2[] )
ll_count = UpperBound( pbdom_elem)
//MessageBox ("PBDOM_DOC Root Element Name",pbdom_elem[1].GetName())
pbdom_elem[1].GetChildElement ("DatiTrasmissione").GetContent(pbdom_dati_xml[]) 
//
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
//cancello report precedente
dw_2.reset()

ll_riga_inserita=dw_2.insertrow(0)
for a = 1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].GetName()  = 'CodiceDestinatario' then
		ls_cod_destinatario=pbdom_dati_xml[a].GetText()
		dw_2.setitem(ll_riga_inserita, "cod_destinatario", ls_cod_destinatario)	
	end if
	if pbdom_dati_xml[a].GetName()  = 'PECDestinatario' then
		ls_appoggio=pbdom_dati_xml[a].GetText()
		dw_2.setitem(ll_riga_inserita, "pec_destinatario", ls_appoggio)
	end if
//	MessageBox ("dati",  pbdom_dati_xml[a].GetName())
next
	pbdom_doc.GetElementsByTagName ( "DatiTrasmissione", pbdom_elem2[] )
	pbdom_elem2[1].GetChildElement ("IdTrasmittente").GetContent(pbdom_dati_xml2[]) 
//	pbdom_elem2[1].GetContent(pbdom_dati_xml2[]) 
for a=1 to UpperBound(pbdom_dati_xml2)   
	if pbdom_dati_xml2[a].getname()="Id_Codice" then
		ls_appoggio=pbdom_dati_xml2[a].gettext()
		dw_2.setitem(ll_riga_inserita, "id_cedente", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "CedentePrestatore", pbdom_elem[] )
pbdom_elem[1].GetChildElement ("Sede").GetContent(pbdom_dati_xml[]) 
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Indirizzo" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_indirizzo", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="CAP" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_cap", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Comune" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_comune", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Provincia" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_provincia", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Nazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_nazione", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "CedentePrestatore", pbdom_elem[] )
pbdom_elem[2]=pbdom_elem[1].GetChildElement ("DatiAnagrafici")
pbdom_elem[2].GetChildElement ("Anagrafica").GetContent(pbdom_dati_xml[]) 
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Denominazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	
			dw_2.setitem(ll_riga_inserita, "f_rag_sociale", ls_appoggio)	
			ls_titolo+=" - "+ls_appoggio
		end if
	end if
	if pbdom_dati_xml[a].getname()="Nome" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
	end if
	if pbdom_dati_xml[a].getname()="Cognome" then
		ls_appoggio+=" "+pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	
			dw_2.setitem(ll_riga_inserita, "f_rag_sociale", ls_appoggio)	
			ls_titolo+=" - "+ls_appoggio
		end if
	end if
next
pbdom_elem[2].GetChildElement ("IdFiscaleIVA").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="IdCodice" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "id_cedente", ls_appoggio)	
	end if
next

for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="CodiceFiscale" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "c_cod_fiscale", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "CessionarioCommittente", pbdom_elem[] )
pbdom_elem[1].GetChildElement ("Sede").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Indirizzo" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_indirizzo", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="CAP" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_cap", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Comune" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_comune", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Provincia" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_provincia", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Nazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_nazione", ls_appoggio)	
	end if
next

//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
pbdom_doc.GetElementsByTagName ( "FatturaElettronicaHeader", pbdom_elem[] )
pbdom_elem[2]=pbdom_elem[1].GetChildElement ("CessionarioCommittente")
pbdom_elem[3]=pbdom_elem[2].GetChildElement ("DatiAnagrafici")
//	MessageBox ("PBDOM_D",  pbdom_elem[1].getname())
//		MessageBox ("PBDOM_D",  pbdom_elem[2].getname())
//	MessageBox ("PBDOM_D",  pbdom_elem[3].getname())
//pbdom_doc.SetRootElement(pbdom_elem[1])
//
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())

pbdom_elem[3].GetChildElement ("IdFiscaleIVA").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="IdCodice" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "id_committente", ls_appoggio)	
	end if
next

pbdom_elem[3].GetChildElement ("Anagrafica").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Denominazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "c_rag_sociale", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Nome" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
	end if
	if pbdom_dati_xml[a].getname()="Cognome" then
		ls_appoggio+=" "+pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "c_rag_sociale", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "FatturaElettronicaBody", pbdom_elem[] )
pbdom_elem[2]=pbdom_elem[1].GetChildElement ("DatiGenerali")
pbdom_elem[2].GetChildElement ("DatiGeneraliDocumento").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="TipoDocumento" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "tipo_documento", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Data" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "Data_documento", date(ls_appoggio))	
	end if
	if pbdom_dati_xml[a].getname()="Numero" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "num_documento", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="ImportoTotaleDocumento" then
		ls_appoggio=" "+pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "Imp_con_iva", dec(f_cambia_punto_in_virgola(ls_appoggio)))	
	end if
	if pbdom_dati_xml[a].getname()="Causale" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "Causale", ls_appoggio)	
	end if
next
pbdom_elem[3]=pbdom_elem[2].GetChildElement ("DatiGeneraliDocumento")
//pbdom_elem[3].GetChildElement ("DatiBollo").GetContent(pbdom_dati_xml[]) 
pbdom_elem[2].GetChildElement ("DatiGeneraliDocumento").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)
	if pbdom_dati_xml[a].getname()="DatiBollo" then
		pbdom_elem[3].GetChildElement ("DatiBollo").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="BolloVirtuale" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "bollo", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="ImportoBollo" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				dw_2.setitem(ll_riga_inserita, "spese_bollo", ls_appoggio)	
			end if
		next
	end if
	if pbdom_dati_xml[a].getname()="DatiDDT" then
		pbdom_elem[3].GetChildElement ("DatiDDT").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="NumeroDDT" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				//if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "bollo", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="DataDDT" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				//dw_2.setitem(ll_riga_inserita, "spese_bollo", date(ls_appoggio))	
			end if
			if pbdom_dati_xml2[a].getname()="RiferimentoNumeroLinea" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				//if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "RiferimentoNumeroLinea", ls_appoggio)	
			end if
		next
	end if
	if pbdom_dati_xml[a].getname()="DatiTrasporto" then
		pbdom_elem[3].GetChildElement ("DatiTrasporto").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="CausaleTrasporto" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "bollo", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="NumeroColli" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "bollo", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="Descrizione" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "bollo", ls_appoggio)	
			end if
		next	
		pbdom_elem[4]=pbdom_elem[3].GetChildElement ("DatiTrasporto")
		pbdom_elem[5]=pbdom_elem[4].GetChildElement ("DatiAnagraficiVettore")
		pbdom_elem[5].GetChildElement ("IdFiscaleIVA").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="IdCodice" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "p_iva_vettore", ls_appoggio)	
			end if
		next
		pbdom_elem[5].GetChildElement ("Anagrafica").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="Denominazione" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "rag_soc_vettore", ls_appoggio)	
			end if
		next
	end if
next
//pbdom_elem[5].GetChildElement ("CodiceFiscale").GetContent(pbdom_dati_xml[]
//for a=1 to UpperBound(pbdom_dati_xml)
//if pbdom_dati_xml[a].getname()="CodiceFiscale" then
//		ls_appoggio=pbdom_dati_xml[a].gettext()
//		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "p_iva_vettore", ls_appoggio)	
//	end if
//next

pbdom_elem[6]=pbdom_elem[1].GetChildElement ("DatiBeniServizi")
//pbdom_elem[6].GetChildElement ("DettaglioLinee").GetContent(pbdom_dati_xml[]) 
//pbdom_elem[1].GetChildElements ("DatiBeniServizi",pbdom_elem2 )
pbdom_elem[6].GetChildElements ("DettaglioLinee", pbdom_elem2 )
//pbdom_elem[1].GetChildElement ("DatiBeniServizi").GetContent(pbdom_dati_xml2[]) 
for d=1 to UpperBound(pbdom_elem2)
//	pbdom_elem2[d].getname()
//NEXT
//
//	if pbdom_elem2[d].getname()="DettaglioLinee" then
	//MESSAGEBOX("NOME", pbdom_elem2[d].getname())
//	pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("DatiBeniServizi")
//	pbdom_elem[7].GetChildElement ("DettaglioLinee").GetContent(pbdom_dati_xml[]) 
		//pbdom_dati_xml[]=pbdom_AZZERA_xml[]
		//pbdom_elem2[d].GetContent(pbdom_dati_xml) 
		c++
		if c>1 then ll_riga_inserita=dw_2.insertrow(0)
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("NumeroLinea")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "num_riga", ls_appoggio)
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("TipoCessionePrestazione")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("TipoCessionePrestazione")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "tipo_ces_prestazione", ls_appoggio)
		end if
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Descrizione")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "des_riga", ls_appoggio)
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("Quantita")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Quantita")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "tipo_ces_prestazione", ls_appoggio)
		end if
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("UnitaMisura")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("UnitaMisura")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "um", ls_appoggio)
		end if
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("PrezzoUnitario")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "prezzo_unitario", dec(f_cambia_punto_in_virgola(ls_appoggio)))
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("PrezzoTotale")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "prezzo_totale", dec(f_cambia_punto_in_virgola(ls_appoggio)))
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("AliquotaIVA")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "al_iva", dec(f_cambia_punto_in_virgola(ls_appoggio)))
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("Natura")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Natura")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "natura", ls_appoggio)
		end if
		//MESSAGEBOX("w", pbdom_elem[7].GETTEXT())
	
//		for a=1 to UpperBound(pbdom_dati_xml)
//		
//			if pbdom_dati_xml[a].getname()="NumeroLinea" then
//				c++
//				if c>1 then ll_riga_inserita=dw_2.insertrow(0)
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "num_riga", ls_appoggio)	
//			end if
//			if pbdom_dati_xml[a].getname()="TipoCessionePrestazione" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()	
//			end if
//			if pbdom_dati_xml[a].getname()="Descrizione" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "des_riga", ls_appoggio)	
//			end if
//			if pbdom_dati_xml[a].getname()="Quantita" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "qta_riga", dec(f_cambia_punto_in_virgola(ls_appoggio))	)
//			end if
//			if pbdom_dati_xml[a].getname()="UnitaMisura" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "um", ls_appoggio)	
//			end if
//			
//			if pbdom_dati_xml[a].getname()="PrezzoUnitario" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "prezzo_unitario", dec(f_cambia_punto_in_virgola(ls_appoggio)))	
//			end if
//			if pbdom_dati_xml[a].getname()="PrezzoTotale" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "prezzo_totale", dec(f_cambia_punto_in_virgola(ls_appoggio)))
//			end if
//			if pbdom_dati_xml[a].getname()="AliquotaIVA" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "al_iva", dec( f_cambia_punto_in_virgola(ls_appoggio))	)
//			end if
//			if pbdom_dati_xml[a].getname()="Natura" then
//				ls_appoggio=pbdom_dati_xml[a].gettext()
//				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "natura", ls_appoggio)	
//			end if
//		next
//	end if
next
pbdom_elem[6].GetChildElement ("DatiRiepilogo").GetContent(pbdom_dati_xml[])
for a=1 to UpperBound(pbdom_dati_xml)
	
	if pbdom_dati_xml[a].getname()="AliquotaIVA" then
		b++
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(1, "al_iva_riep_"+string(b), dec( f_cambia_punto_in_virgola(ls_appoggio)))	
	end if
	if pbdom_dati_xml[a].getname()="Natura" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(1, "nat_"+string(b), ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="SpeseAccessorie" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(1, "spese_accessorie_"+string(b), dec(f_cambia_punto_in_virgola(ls_appoggio)))
	end if
	if pbdom_dati_xml[a].getname()="ImponibileImporto" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(1, "imponibile_"+string(b), dec(f_cambia_punto_in_virgola(ls_appoggio)))
	end if
	if pbdom_dati_xml[a].getname()="Imposta" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(1, "imposta_"+string(b), dec(f_cambia_punto_in_virgola(ls_appoggio)))
	end if
	if pbdom_dati_xml[a].getname()="RiferimentoNormativo" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(1, "rif_normativo_"+string(b), ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "FatturaElettronicaBody", pbdom_elem2[] )
pbdom_elem2[1].getcontent(pbdom_dati_xml[])
for a=1 to UpperBound(pbdom_dati_xml)
	if pbdom_dati_xml[a].getname()="DatiPagamento" then
		pbdom_elem[7]=pbdom_elem2[1].GetChildElement ("DatiPagamento")
		pbdom_elem[7].GetChildElement ("DettaglioPagamento").GetContent(pbdom_dati_xml2[])
		b=0
		for a=1 to UpperBound(pbdom_dati_xml2)
			
			if pbdom_dati_xml2[a].getname()="DataScadenzaPagamento" then
				b++
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(1, "data_scad_pagamento_"+string(b), date(ls_appoggio)	)
			end if
			if pbdom_dati_xml2[a].getname()="ImportoPagamento" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if b=0 then b++
				if ls_appoggio> "  " then 	dw_2.setitem(1, "imp_scadenza_"+string(b), dec(f_cambia_punto_in_virgola(ls_appoggio)))
			end if
		next
	end if
next
dw_2.modify("t_titolo.text='"+ls_titolo+"'")
destroy pbdombuilder_new
end event

type cb_stampa from commandbutton within w_vedi_xml
integer x = 3602
integer y = 244
integer width = 343
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;if dw_2.rowcount()>0 then
	dw_2.print(true, true)
end if
end event

type cb_confronto from commandbutton within w_vedi_xml
integer x = 4169
integer y = 368
integer width = 288
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Confronta"
end type

event clicked;date ldt_data, ldt_data_xml
string ls_numero, ls_iva, ls_path, ls_numero_xml, ls_iva_xml, ls_errori[], ls_intestatario, ls_tipo_doc, ls_tipo_doc_xml
integer i, a, b, li_trovato
nvo_file_list sl_lista_file, sl_lista_gia_trovati
long ll_temp
boolean  lb_parse
PBDOM_BUILDER pbdombuilder_new
PBDOM_DOCUMENT pbdom_doc
PBDOM_OBJECT pbdom_dati_xml[]
PBDOM_ELEMENT pbdom_elem[], pbdom_elem2[]

pbdombuilder_new = Create PBDOM_BUILDER

ls_path=dw_3.getitemstring(1, "path_xml")

sl_lista_file=f_leggi_files(ls_path, false)
FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
	//if pos(upper(left(sl_lista_file.as_file[ll_temp], len(sl_lista_file.as_file[ll_temp]) - 4)), ".XML")>0 then continue
	if b> 0 then 	li_trovato=wf_controlla_gia_trovato( sl_lista_file.as_file[ll_temp], sl_lista_gia_trovati) 
	if li_trovato=0 then
		if upper(right(sl_lista_file.as_file[ll_temp], 3))='XML' or upper(right(sl_lista_file.as_file[ll_temp], 3))='P7M' then
			
			pbdom_doc = pbdombuilder_new.BuildFromfile( sl_lista_file.as_file[ll_temp])
	
			lb_parse=pbdombuilder_new.GetParseErrors(ls_errori)
			if lb_parse then
				for i=1 to upperbound(ls_errori)
					messagebox("E", ls_errori[i])
				next
			end if
			pbdom_doc.GetRootElement()
			pbdom_doc.GetElementsByTagName ( "DatiGenerali", pbdom_elem[] )
			pbdom_elem[2]=pbdom_elem[1].GetChildElement ("DatiGeneraliDocumento")
			pbdom_elem[3]=pbdom_elem[2].GetChildElement ("TipoDocumento")
			pbdom_elem[4]=pbdom_elem[2].GetChildElement ("Numero")
			pbdom_doc.GetRootElement()
			pbdom_doc.GetElementsByTagName ( "CedentePrestatore", pbdom_elem2[] )
			pbdom_elem2[2]=pbdom_elem2[1].GetChildElement ("DatiAnagrafici")
			pbdom_elem2[3]=pbdom_elem2[2].GetChildElement ("IdFiscaleIVA")
			pbdom_elem2[4]=pbdom_elem2[3].GetChildElement ("IdCodice")
			ls_iva_xml=pbdom_elem2[4].gettext()
		//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
			//ldt_data_xml=date(pbdom_elem[3].gettext())
			ls_tipo_doc_xml=""
			ls_tipo_doc_xml=pbdom_elem[3].gettext()
			ls_numero_xml=pbdom_elem[4].gettext()
			for i= 1 to dw_1.rowcount()
				ls_numero=dw_1.getitemstring(i, "Num_fattura")
				ls_tipo_doc=dw_1.getitemstring(i, "tipo_documento")
				//ldt_data=dw_1.getitemdate(i, "data_emissione")
				choose case  ls_tipo_doc
					case "Fattura"
						ls_tipo_doc="TD01"
					case "Nota di credito"
						ls_tipo_doc="TD04"
					case"Nota di debito"
						ls_tipo_doc="TD05"
				end choose
						
				ls_iva=dw_1.getitemstring(i, "p_iva_fornitore")
				if left(ls_iva, 1)="'" then ls_iva=right(ls_iva, len(ls_iva) - 1)
				if right(ls_iva, 1)="'" then ls_iva=left(ls_iva, len(ls_iva) - 1)
				if ls_tipo_doc_xml=ls_tipo_doc and ls_numero=ls_numero_xml and ls_iva=ls_iva_xml  then
					b++
					ls_intestatario=""
					dw_1.setitem(i, "file_collegato",sl_lista_file.as_file[ll_temp])
					pbdom_doc.GetElementsByTagName ( "CedentePrestatore", pbdom_elem2[] )
					pbdom_elem[5]=pbdom_elem2[1].GetChildElement ("DatiAnagrafici")
					pbdom_elem[6]=pbdom_elem[5].GetChildElement ("Anagrafica")
					
					if isvalid(pbdom_elem[6].GetChildElement ("Denominazione")) then 
						pbdom_elem[7]=pbdom_elem[6].GetChildElement ("Denominazione")
						ls_intestatario=pbdom_elem[7].gettext()
					else
						pbdom_elem[7]=pbdom_elem[6].GetChildElement ("Nome")
						pbdom_elem[8]=pbdom_elem[6].GetChildElement ("Cognome")
						ls_intestatario=pbdom_elem[7].gettext()+" "+pbdom_elem[7].gettext()						
					end if
					dw_1.setitem(i, "intestatario",ls_intestatario)
					sl_lista_gia_trovati.as_file[b]=sl_lista_file.as_file[ll_temp]
					exit
				end if
			next
		end if
	end if
next

destroy PBDOM_BUILDER



end event

type cb_preview from commandbutton within w_vedi_xml
integer x = 3602
integer y = 128
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Preview"
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_2.object.datawindow.print.preview='yes'
	dw_2.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_2.object.datawindow.print.preview='No'
	dw_2.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_2 from commandbutton within w_vedi_xml
boolean visible = false
integer x = 5280
integer y = 2160
integer width = 151
integer height = 68
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;
//pbdom_doc.GetElementsByTagName ( "IdTrasmittente", pbdom_elem[] )
//pbdom_elem[1].GetChildElement ("DatiTrasmissione").GetContent(pbdom_dati_xml[]) 
//	if pbdom_dati_xml[a].GetName()  = 'IdTrasmittente' then
//		pbdom_elem[2]=pbdom_dati_xml[a]
//		pbdom_elem[1].GetChildElement ("IdCodice").GetContent(pbdom_dati_xml2[]) 
//		ls_id_fiscale=pbdom_dati_xml2[2].GetText()
//		dw_2.setitem(ll_riga_inserita, "id_cedente", ls_id_fiscale)
//	end if
//	
//next
//
//pbdom_elem[1].GetChildElement ("CedentePrestatore").GetContent(pbdom_dati_xml)
//for a = 1 to UpperBound(pbdom_dati_xml)   
//	//if pbdom_dati_xml[a].GetName()  = 'DatiAnagrafici' then
//		MessageBox ("Child Object " + string(a) + " Class",  pbdom_dati_xml[a].GetObjectClassString())    
//		MessageBox ("Child Object " + string(a) + " Name",  pbdom_dati_xml[a].GetName())    
//		MessageBox ("Child Object " + string(a) + " Text",  pbdom_dati_xml[a].GetText())  
////		ldom_tipo_doc=pbdom_dati_xml[a].getattribute( "IdCodice" )
////		pbdom_dati_xml[a].GetChild ("IdFiscale").GetContent(pbdom_dati_xml2)
////		ls_appoggio=pbdom_dati_xml[a].GetText()
////		MessageBox ("Cod_destinatario", ls_appoggio)
//	//end if
//next
//
//
//
//
//      //    ldom_tipo_doc = pbdom_elem[li_index].getattribute( "IdCodice" )
////          ldom_expdate = ldom_childelements[li_index].getattribute( "ExpireDate" )
////          base = ldom_childelements[li_index].getchildelement( "Base" )
////          ldom_aftertax = base.getattribute( "AmountAfterTax" )
////          ldom_currency = base.getattribute( "CurrencyCode" )
//			//ls_message=ldom_tipo_doc.gettext( )
//        //  ls_message += "From " + ldom_effdate.gettext( ) + " to " + ldom_expdate.gettext() + " the rate is " + ldom_aftertax.gettext() + " " + ldom_currency.gettext() + "~r~n"
//  
//destroy PBDOM_Builder
////ll_count = UpperBound( pbdom_dati_xml )
////
////
////
//////pbdom_dati_xml[1].gettext()
////FOR i = 1 TO ll_count
////	//pbdom_doc.GetElementsByTagName("DatiRiepilogo", pbdom_elem)
////	pbdom_txt[i]=pbdom_dati_xml[i]
////	mle_1.text += pbdom_txt[i].gettext() + "~r~n"
////		
////NEXT 
//
///*Examples
//Suppose the file c:\pbdom_doc_1.xml contains the following XML string:
//
//<!DOCTYPE abc [<!ENTITY text "Some Text" >]>
//<abc>
//	<data>    
//		<child_data>Child Data Text</child_data>    
//		<child_data An_Attribute="Some Attribute Value"/>    &text;    <!--Comment String-->    <![CDATA[Some CDATA String]]>  
//	</data>
//</abc>
//The file contains a Document Type Declaration that indicates that <abc> is the root element, and a declaration for the text entity that expands to "Some Text":
//The root element abc contains a child element data, 
//which contains five child PBDOM_OBJECTs: two PBDOM_ELEMENT objects, and PBDOM_TEXT, PBDOM_COMMENT, and PBDOM_CDATA objects.
//
//The first child_data element contains a PBDOM_TEXT with the string "Child Data Text". 
//The second child_data element contains no child PBDOM_OBJECTs but it does contain a PBDOM_ATTRIBUTE, An_Attribute, that contains the value "Some Attribute Value".
//
//This example creates a PBDOM_DOCUMENT called pbdom_doc from c:\pbdom_doc_1.xml, tests the content of pbdom_doc, 
//then saves the DOM tree contained within pbdom_doc into a separate file, c:\pbdom_doc_2.xml. The input and output files should be identical.
//
//PBDOM_Builder    pbdom_bldr
//PBDOM_Document    pbdom_doc
//PBDOM_Object      pbdom_obj_array[]
//PBDOM_Element     pbdom_elem
//integer i, FileNum1
//long a = 0
//// Create a PBDOM_DOCUMENT from the XML file  
//pbdom_bldr = Create PBDOM_Builder  
//pbdom_doc = pbdom_bldr.BuildFromFile ("c:\pbdom_doc_1.xml") 
//// Test the contents of the PBDOM_DOCUMENT
//// First test the PBDOM_DOCTYPE in the document  
//MessageBox ("PBDOM_DOCTYPE GetName()",     pbdom_doc.GetDocType().GetName()) 
//MessageBox ("PBDOM_DOCTYPE GetInternalSubset()",  pbdom_doc.GetDocType().GetInternalSubset()) 
//// Test the root element  
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName()) 
//// test the root element's child element 
//MessageBox ("PBDOM_DOC <data> Element Name",   pbdom_doc.GetRootElement().GetChildElement ("data").GetName()) 
//// Collect all the child PBDOM_OBJECTs of the// <data> element 
//pbdom_doc.GetRootElement().GetChildElement ("data").GetContent(pbdom_obj_array) 
//// Display the class name, the name and the text contained// within each PBDOM_OBJECT array item  
//for a = 1 to UpperBound(pbdom_obj_array)    
//	MessageBox ("Child Object " + string(l) + " Class",  pbdom_obj_array[l].GetObjectClassString())    
//	MessageBox ("Child Object " + string(l) + " Name",  pbdom_obj_array[l].GetName())    
//	MessageBox ("Child Object " + string(l) + " Text",  pbdom_obj_array[l].GetText())  
//next 
//// Retrieve and display the name and text value of the
//// "An_Attribute" attribute from the <child_data> element    
//pbdom_elem = pbdom_obj_array[2]  
//MessageBox ("child_data Attribute name", pbdom_elem.GetAttribute("An_Attribute").GetName())  
//MessageBox ("child_data Attribute value", pbdom_elem.GetAttribute("An_Attribute").GetText()) 
//// save the DOM Tree contained within pbdom_doc into a separate file "c:\pbdom_doc_2.xml"  
//pbdom_doc.SaveDocument ("c:\pbdom_doc_2.xml")  
//Destroy pbdom_bldr 
//CATCH (PBDOM_Exception except)  
//	MessageBox ("Exception Occurred", except.Text)
//END TRY
//
//
//*/
//
//





///*Examples
//Suppose the file c:\pbdom_doc_1.xml contains the following XML string:
//
//<!DOCTYPE abc [<!ENTITY text "Some Text" >]>
//<abc>
//	<data>    
//		<child_data>Child Data Text</child_data>    
//		<child_data An_Attribute="Some Attribute Value"/>    &text;    <!--Comment String-->    <![CDATA[Some CDATA String]]>  
//	</data>
//</abc>
//The file contains a Document Type Declaration that indicates that <abc> is the root element, and a declaration for the text entity that expands to "Some Text":
//The root element abc contains a child element data, 
//which contains five child PBDOM_OBJECTs: two PBDOM_ELEMENT objects, and PBDOM_TEXT, PBDOM_COMMENT, and PBDOM_CDATA objects.
//
//The first child_data element contains a PBDOM_TEXT with the string "Child Data Text". 
//The second child_data element contains no child PBDOM_OBJECTs but it does contain a PBDOM_ATTRIBUTE, An_Attribute, that contains the value "Some Attribute Value".
//
//This example creates a PBDOM_DOCUMENT called pbdom_doc from c:\pbdom_doc_1.xml, tests the content of pbdom_doc, 
//then saves the DOM tree contained within pbdom_doc into a separate file, c:\pbdom_doc_2.xml. The input and output files should be identical.
//*/
//PBDOM_Builder    pbdom_bldr
//PBDOM_Document    pbdom_doc
//PBDOM_Object      pbdom_obj_array[]
//PBDOM_Element     pbdom_elem, pbdom_ele2,  pbdom_ele3[]
//PBDOM_Exception except
//integer iFileNum1
//long l = 0
//// Create a PBDOM_DOCUMENT from the XML file  
//integer li_ret, li_file, i, li_index
//string ls_path, ls_file_xml, ls_errori[], ls_message
//boolean lb_parse=false
//long ll_count
//	
//getfileopenname("Cerca DOCasci_", ls_path, ls_file_xml, "xml", "testo, *.*", "C:\nita\xml_fe")
//
//pbdom_bldr = Create PBDOM_Builder  
//pbdom_doc = pbdom_bldr.BuildFromFile(ls_path) // ("c:\nita\pbdom_doc_1.xml") 
//pbdom_ele2=pbdom_doc.GetRootElement().GetChildElement ("FatturaElettronicaBody")
//pbdom_ele3=pbdom_ele2.getchildelements(pbdom_ele3)
//// Test the contents of the PBDOM_DOCUMENT
//// First test the PBDOM_DOCTYPE in the document  
////MessageBox ("PBDOM_DOCTYPE GetName()",     pbdom_doc.GetDocType().GetName()) 
////MessageBox ("PBDOM_DOCTYPE GetInternalSubset()",  pbdom_doc.GetDocType().GetInternalSubset()) 
//// Test the root element  
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName()) 
//// test the root element's child element 
//MessageBox ("PBDOM_DOC <data> Element Name",   pbdom_doc.GetRootElement().GetChildElement ("FatturaElettronicaBody").GetName()) 
//// Collect all the child PBDOM_OBJECTs of the// <data> element 
//pbdom_doc.GetRootElement().GetChildElement ("FatturaElettronicaBody").GetContent(pbdom_obj_array) 
//// Display the class name, the name and the text contained// within each PBDOM_OBJECT array item  
//for l = 1 to UpperBound(pbdom_obj_array)    
//	MessageBox ("Child Object " + string(l) + " Class",  pbdom_obj_array[l].GetObjectClassString())    
//	MessageBox ("Child Object " + string(l) + " Name",  pbdom_obj_array[l].GetName())    
//	MessageBox ("Child Object " + string(l) + " Text",  pbdom_obj_array[l].GetText())  
//next 
//// Retrieve and display the name and text value of the
//// "An_Attribute" attribute from the <child_data> element    
//pbdom_elem = pbdom_obj_array[2]  
////MessageBox ("child_data Attribute name", pbdom_elem.GetAttribute("An_Attribute").GetName())  
////MessageBox ("child_data Attribute value", pbdom_elem.GetAttribute("An_Attribute").GetText()) 
//// save the DOM Tree contained within pbdom_doc into a separate file "c:\pbdom_doc_2.xml"  
//pbdom_doc.SaveDocument ("c:\nita\xml_fe\pbdom_doc_2.xml")  
//Destroy pbdom_bldr 
////CATCH (except)  
////	MessageBox ("Exception Occurred", except.Text)
////END TRY
//
//
//
//
end event

type cb_carica_xml from commandbutton within w_vedi_xml
integer x = 3602
integer y = 12
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CARICA XML"
end type

event clicked;PBDOM_BUILDER pbdombuilder_new
PBDOM_DOCUMENT pbdom_doc
PBDOM_OBJECT pbdom_dati_xml[], pbdom_dati_xml2[], pbdom_AZZERA_xml[]
PBDOM_ELEMENT pbdom_elem[],pbdom_elem2[], pbdom_elem3[], pbdom_elem0[]
PBDOM_TEXT pbdom_txt[]
PBDOM_ATTRIBUTE ldom_tipo_doc

integer li_ret, li_file, i, li_index, a, b, c, d
string ls_path, ls_file_xml, ls_errori[], ls_message, ls_cod_destinatario, ls_appoggio, ls_id_fiscale
boolean lb_parse=false
long ll_count, ll_riga_inserita
string ls_paese, ls_titolo=""
datawindowchild dwc_riepilogo
long ll_riga_riepilogo

ls_path=dw_3.getitemstring(1, "path_xml")
if pos(upper(left(ls_path, len(ls_path) - 4)), ".XML")>0 then 
	MessageBox ("Errore nel nome del file XML", "Il file scelto NON è nel formato corretto! Potrebbe essere un file tipo 'Metadati'")
	return
else
	ls_titolo="Id_SDI: "+dw_3.getitemstring(1, "id_sdi")
end if
if upper(right(ls_path, 4))<>".XML" then
	getfileopenname("Cerca DOCasci_", ls_path, ls_file_xml, "xml", "testo, *.*", ls_path)
end if

pbdombuilder_new = Create PBDOM_BUILDER

pbdom_doc = pbdombuilder_new.BuildFromfile(ls_path)
lb_parse=pbdombuilder_new.GetParseErrors(ls_errori)
if lb_parse then
	for i=1 to upperbound(ls_errori)
		messagebox("E", ls_errori[i])
	next
end if
//MessageBox ("PBDOM_DOC Name", pbdom_doc.getname())
pbdom_doc.GetRootElement()//.GetContent( ref pbdom_dati_xml )
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName()) 
pbdom_doc.GetElementsByTagName ( "FatturaElettronicaHeader", pbdom_elem[] )
//pbdom_doc.SetRootElement(pbdom_elem[])
//pbdom_doc.GetElementsByTagName ( "IdTrasmittente", pbdom_elem2[] )
ll_count = UpperBound( pbdom_elem)
//MessageBox ("PBDOM_DOC Root Element Name",pbdom_elem[1].GetName())
pbdom_elem[1].GetChildElement ("DatiTrasmissione").GetContent(pbdom_dati_xml[]) 
//
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
//cancello report precedente
dw_2.reset()

ll_riga_inserita=dw_2.insertrow(0)
for a = 1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].GetName()  = 'CodiceDestinatario' then
		ls_cod_destinatario=pbdom_dati_xml[a].GetText()
		dw_2.setitem(ll_riga_inserita, "cod_destinatario", ls_cod_destinatario)	
	end if
	if pbdom_dati_xml[a].GetName()  = 'PECDestinatario' then
		ls_appoggio=pbdom_dati_xml[a].GetText()
		dw_2.setitem(ll_riga_inserita, "pec_destinatario", ls_appoggio)
	end if
//	MessageBox ("dati",  pbdom_dati_xml[a].GetName())
next
	pbdom_doc.GetElementsByTagName ( "DatiTrasmissione", pbdom_elem2[] )
	pbdom_elem2[1].GetChildElement ("IdTrasmittente").GetContent(pbdom_dati_xml2[]) 
//	pbdom_elem2[1].GetContent(pbdom_dati_xml2[]) 
for a=1 to UpperBound(pbdom_dati_xml2)   
	if pbdom_dati_xml2[a].getname()="Id_Codice" then
		ls_appoggio=pbdom_dati_xml2[a].gettext()
		dw_2.setitem(ll_riga_inserita, "id_cedente", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "CedentePrestatore", pbdom_elem[] )
pbdom_elem[1].GetChildElement ("Sede").GetContent(pbdom_dati_xml[]) 
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Indirizzo" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_indirizzo", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="CAP" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_cap", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Comune" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_comune", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Provincia" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_provincia", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Nazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "f_nazione", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "CedentePrestatore", pbdom_elem[] )
pbdom_elem[2]=pbdom_elem[1].GetChildElement ("DatiAnagrafici")
pbdom_elem[2].GetChildElement ("Anagrafica").GetContent(pbdom_dati_xml[]) 
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Denominazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	
			dw_2.setitem(ll_riga_inserita, "f_rag_sociale", ls_appoggio)	
			ls_titolo+=" - "+ls_appoggio
		end if
	end if
	if pbdom_dati_xml[a].getname()="Nome" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
	end if
	if pbdom_dati_xml[a].getname()="Cognome" then
		ls_appoggio+=" "+pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	
			dw_2.setitem(ll_riga_inserita, "f_rag_sociale", ls_appoggio)	
			ls_titolo+=" - "+ls_appoggio
		end if
	end if
next
pbdom_elem[2].GetChildElement ("IdFiscaleIVA").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="IdCodice" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "id_cedente", ls_appoggio)	
	end if
next

for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="CodiceFiscale" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "c_cod_fiscale", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "CessionarioCommittente", pbdom_elem[] )
pbdom_elem[1].GetChildElement ("Sede").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Indirizzo" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_indirizzo", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="CAP" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_cap", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Comune" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_comune", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Provincia" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_provincia", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Nazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "c_nazione", ls_appoggio)	
	end if
next

//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())
pbdom_doc.GetElementsByTagName ( "FatturaElettronicaHeader", pbdom_elem[] )
pbdom_elem[2]=pbdom_elem[1].GetChildElement ("CessionarioCommittente")
pbdom_elem[3]=pbdom_elem[2].GetChildElement ("DatiAnagrafici")
//	MessageBox ("PBDOM_D",  pbdom_elem[1].getname())
//		MessageBox ("PBDOM_D",  pbdom_elem[2].getname())
//	MessageBox ("PBDOM_D",  pbdom_elem[3].getname())
//pbdom_doc.SetRootElement(pbdom_elem[1])
//
//MessageBox ("PBDOM_DOC Root Element Name", pbdom_doc.GetRootElement().GetName())

pbdom_elem[3].GetChildElement ("IdFiscaleIVA").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="IdCodice" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "id_committente", ls_appoggio)	
	end if
next

pbdom_elem[3].GetChildElement ("Anagrafica").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="Denominazione" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "c_rag_sociale", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Nome" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
	end if
	if pbdom_dati_xml[a].getname()="Cognome" then
		ls_appoggio+=" "+pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "c_rag_sociale", ls_appoggio)	
	end if
next
pbdom_doc.GetElementsByTagName ( "FatturaElettronicaBody", pbdom_elem[] )
pbdom_elem[2]=pbdom_elem[1].GetChildElement ("DatiGenerali")
pbdom_elem[2].GetChildElement ("DatiGeneraliDocumento").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)   
	if pbdom_dati_xml[a].getname()="TipoDocumento" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "tipo_documento", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="Data" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "Data_documento", date(ls_appoggio))	
	end if
	if pbdom_dati_xml[a].getname()="Numero" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "num_documento", ls_appoggio)	
	end if
	if pbdom_dati_xml[a].getname()="ImportoTotaleDocumento" then
		ls_appoggio=" "+pbdom_dati_xml[a].gettext()
		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "imp_con_iva", dec(f_cambia_punto_in_virgola(ls_appoggio)))	
	end if
	if pbdom_dati_xml[a].getname()="Causale" then
		ls_appoggio=pbdom_dati_xml[a].gettext()
		dw_2.setitem(ll_riga_inserita, "Causale", ls_appoggio)	
	end if
next
pbdom_elem[3]=pbdom_elem[2].GetChildElement ("DatiGeneraliDocumento")
//pbdom_elem[3].GetChildElement ("DatiBollo").GetContent(pbdom_dati_xml[]) 
pbdom_elem[2].GetChildElement ("DatiGeneraliDocumento").GetContent(pbdom_dati_xml[]) 
for a=1 to UpperBound(pbdom_dati_xml)
	if pbdom_dati_xml[a].getname()="DatiBollo" then
		pbdom_elem[3].GetChildElement ("DatiBollo").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="BolloVirtuale" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "bollo", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="ImportoBollo" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				dw_2.setitem(ll_riga_inserita, "spese_bollo", ls_appoggio)	
			end if
		next
	end if
	if pbdom_dati_xml[a].getname()="DatiDDT" then
		pbdom_elem[3].GetChildElement ("DatiDDT").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="NumeroDDT" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "num_ddt", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="DataDDT" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				dw_2.setitem(ll_riga_inserita, "data_ddt", date(ls_appoggio))	
			end if
			if pbdom_dati_xml2[a].getname()="RiferimentoNumeroLinea" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "num_riga_ddt", ls_appoggio)	
			end if
		next
	end if
	if pbdom_dati_xml[a].getname()="DatiTrasporto" then
		pbdom_elem[3].GetChildElement ("DatiTrasporto").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="CausaleTrasporto" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "caus_trasporto", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="NumeroColli" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "num_colli", ls_appoggio)	
			end if
			if pbdom_dati_xml2[a].getname()="Descrizione" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "caus_descrizione", ls_appoggio)	
			end if
		next	
		pbdom_elem[4]=pbdom_elem[3].GetChildElement ("DatiTrasporto")
		pbdom_elem[5]=pbdom_elem[4].GetChildElement ("DatiAnagraficiVettore")
		pbdom_elem[5].GetChildElement ("IdFiscaleIVA").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="IdCodice" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "p_iva_vettore", ls_appoggio)	
			end if
		next
		pbdom_elem[5].GetChildElement ("Anagrafica").GetContent(pbdom_dati_xml2[]) 
		for a=1 to UpperBound(pbdom_dati_xml2)
			if pbdom_dati_xml2[a].getname()="Denominazione" then
				ls_appoggio=pbdom_dati_xml2[a].gettext()
				if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "rag_soc_vettore", ls_appoggio)	
			end if
		next
	end if
next
//pbdom_elem[5].GetChildElement ("CodiceFiscale").GetContent(pbdom_dati_xml[]
//for a=1 to UpperBound(pbdom_dati_xml)
//if pbdom_dati_xml[a].getname()="CodiceFiscale" then
//		ls_appoggio=pbdom_dati_xml[a].gettext()
//		if ls_appoggio> "  " then 	dw_2.setitem(ll_riga_inserita, "p_iva_vettore", ls_appoggio)	
//	end if
//next

pbdom_elem[6]=pbdom_elem[1].GetChildElement ("DatiBeniServizi")
//pbdom_elem[6].GetChildElement ("DettaglioLinee").GetContent(pbdom_dati_xml[]) 
//pbdom_elem[1].GetChildElements ("DatiBeniServizi",pbdom_elem2 )
pbdom_elem[6].GetChildElements ("DettaglioLinee", pbdom_elem2 )
//pbdom_elem[1].GetChildElement ("DatiBeniServizi").GetContent(pbdom_dati_xml2[]) 
for d=1 to UpperBound(pbdom_elem2)
		c++
		if c>1 then ll_riga_inserita=dw_2.insertrow(0)
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("NumeroLinea")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "num_riga", ls_appoggio)
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("TipoCessionePrestazione")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("TipoCessionePrestazione")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "tipo_ces_prestazione", ls_appoggio)
		end if
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Descrizione")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "des_riga", ls_appoggio)
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("Quantita")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Quantita")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "qta", ls_appoggio)
		end if
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("UnitaMisura")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("UnitaMisura")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "um", ls_appoggio)
		end if
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("PrezzoUnitario")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "prezzo_unitario", dec(f_cambia_punto_in_virgola(ls_appoggio)))
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("PrezzoTotale")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "prezzo_totale", dec(f_cambia_punto_in_virgola(ls_appoggio)))
		
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("AliquotaIVA")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "al_iva", dec(f_cambia_punto_in_virgola(ls_appoggio)))
		
		if ISVALID(pbdom_elem2[d].GetChildElement ("Natura")) then 
			pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Natura")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "natura", ls_appoggio)
		end if
		//MESSAGEBOX("w", pbdom_elem[7].GETTEXT())
next



dw_2.getchild("dw_riepilogo", dwc_riepilogo)
dwc_riepilogo.settransobject(sqlca)

//pbdom_elem[6].GetChildElement ("DatiRiepilogo").GetContent(pbdom_dati_xml[])
pbdom_elem2=pbdom_elem0
pbdom_elem[6].GetChildElements ("DatiRiepilogo",pbdom_elem2 )
for d=1 to UpperBound(pbdom_elem2)
	b++
//	if b> 2 then
//		messagebox("Attenzione!", "Ci sono più di 2 aliquote IVA diverse!")
//		exit
//	end if
	ll_riga_riepilogo=dwc_riepilogo.insertrow(0)
	pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("AliquotaIVA")
	ls_appoggio=pbdom_elem[7].GETTEXT()
	dwc_riepilogo.setitem(ll_riga_riepilogo, "al_iva", dec(f_cambia_punto_in_virgola(ls_appoggio)))
	
	pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("ImponibileImporto")
	ls_appoggio=pbdom_elem[7].GETTEXT()
	dwc_riepilogo.setitem(ll_riga_riepilogo, "imponibile", dec(f_cambia_punto_in_virgola(ls_appoggio)))
	
	pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Imposta")
	ls_appoggio=pbdom_elem[7].GETTEXT()
	dwc_riepilogo.setitem(ll_riga_riepilogo, "imposta", dec(f_cambia_punto_in_virgola(ls_appoggio)))
	
	if ISVALID(pbdom_elem2[d].GetChildElement ("Natura")) then 
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("Natura")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dwc_riepilogo.setitem(ll_riga_riepilogo, "natura", ls_appoggio)
	end if
	
	if ISVALID(pbdom_elem2[d].GetChildElement ("SpeseAccessorie")) then 
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("SpeseAccessorie")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dwc_riepilogo.setitem(1, "spese_accessorie", dec(f_cambia_punto_in_virgola(ls_appoggio)))
	end if
	
	if ISVALID(pbdom_elem2[d].GetChildElement ("RiferimentoNormativo")) then 
		pbdom_elem[7]=pbdom_elem2[d].GetChildElement ("RiferimentoNormativo")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dwc_riepilogo.setitem(1, "rif_normativo", ls_appoggio)
	end if
next

pbdom_elem[1].GetChildElements ("DatiPagamento", pbdom_elem2 )
b=0
for d=1 to UpperBound(pbdom_elem2)
	pbdom_elem3=pbdom_elem0
	pbdom_elem2[d].GetChildElements ("DettaglioPagamento", pbdom_elem3 )
	for a=1 to UpperBound(pbdom_elem3)
		b++
		pbdom_elem[7]=pbdom_elem3[a].GetChildElement ("ImportoPagamento")
		ls_appoggio=pbdom_elem[7].GETTEXT()
		dw_2.setitem(ll_riga_inserita, "imp_scadenza_"+string(b), dec(f_cambia_punto_in_virgola(ls_appoggio)))
		
		if ISVALID(pbdom_elem3[a].GetChildElement ("DataScadenzaPagamento")) then 
			pbdom_elem[7]=pbdom_elem3[a].GetChildElement ("DataScadenzaPagamento")
			ls_appoggio=pbdom_elem[7].GETTEXT()
			dw_2.setitem(ll_riga_inserita, "data_scad_pagamento_"+string(b), date(ls_appoggio))
		end if
	next
next

dw_2.modify("t_titolo.text='"+ls_titolo+"'")
destroy pbdombuilder_new
end event

type cb_carica from commandbutton within w_vedi_xml
integer x = 3822
integer y = 368
integer width = 329
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica Lista"
end type

event clicked;integer li_ret
string ls_path, ls_file


if dw_1.dataobject="d_controllo_fat_ricevute_ra" then
	if messagebox("Attenzione!", "Vuoi abbandonare la ricerca e caricare una nuova lista? La lista ricercata NON sarà salvata!", stopsign!, yesno!) =1 then
		dw_1.dataobject="d_controllo_fat_ricevute"
		dw_1.settransobject(sqlca)
	else
		return
	end if
end if
getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.*", "C:\nita\xml_fe")
li_ret=dw_1.importfile(DBase3!, ls_file, 2, 999999, 1, 99999, 2)
if li_ret=1 then
		dw_1.setsort("data_emissione, num_fattura")
		dw_1.sort()
end if

end event

type dw_2 from udw_001 within w_vedi_xml
integer x = 18
integer y = 20
integer width = 3561
integer height = 2508
integer taborder = 10
string dataobject = "d_vedi_xmlok"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_3 from udw_001 within w_vedi_xml
integer x = 3959
integer y = 20
integer width = 1947
integer height = 320
integer taborder = 10
boolean titlebar = true
string title = "Parametri"
string dataobject = "d_dati_rec_xml_fo"
end type

type dw_1 from udw_001 within w_vedi_xml
integer x = 3611
integer y = 500
integer width = 2281
integer height = 2120
integer taborder = 50
string dataobject = "D_CONTROLLO_FAT_RICEVUTE"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rbuttondown;call super::rbuttondown;string ls_file_collegato, ls_id_sdi

if row>0 then
	ls_file_collegato=dw_1.getitemstring(row,  "file_collegato")
	if ls_file_collegato> " " then
		dw_3.setitem(1, "path_xml", ls_file_collegato)
		ls_id_sdi=dw_1.getitemstring(row,  "num_sdi")
		dw_3.setitem(1, "id_sdi", ls_id_sdi)
		cb_carica_xml.triggerevent(clicked!)
		
	end if
	
end if
end event

event losefocus;//
end event

event getfocus;//
end event

event itemfocuschanged;//
end event

event rowfocuschanged;//
end event

