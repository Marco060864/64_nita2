forward
global type w_stampa_documenti_ff from window
end type
type cb_ordini_txt from commandbutton within w_stampa_documenti_ff
end type
type cb_annulla from commandbutton within w_stampa_documenti_ff
end type
type cb_stampa from commandbutton within w_stampa_documenti_ff
end type
type dw_1 from u_dw_ext_main within w_stampa_documenti_ff
end type
end forward

global type w_stampa_documenti_ff from window
integer x = 834
integer y = 362
integer width = 2373
integer height = 1811
boolean titlebar = true
string title = "Stampa dei Documenti"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cb_ordini_txt cb_ordini_txt
cb_annulla cb_annulla
cb_stampa cb_stampa
dw_1 dw_1
end type
global w_stampa_documenti_ff w_stampa_documenti_ff

forward prototypes
public function string wf_cerca_indirizzo_mail (long as_id_doc)
public subroutine wf_invia_mail (string as_allegato, string as_indirizzo, string as_oggetto, string as_testo)
public subroutine wf_carica_testo_e_oggetto (ref string as_oggetto, ref string as_testo, date as_data, string as_num_fat)
end prototypes

public function string wf_cerca_indirizzo_mail (long as_id_doc);//trova l'indirizzo mail nell'anagrafica del documento passato come argomento
long ll_id_conto
string ls_indirizzo

select t.num_riferimento
into :ls_indirizzo
from dba.documento d, dba.anagrafica a, dba.sog_commerciale s, telefono t
where id_documento=:as_id_doc
and s.id_sog_commerciale=d.id_sog_commerciale
and s.id_anagrafica=t.id_anagrafica
and t.tipo='E'
;

return ls_indirizzo

end function

public subroutine wf_invia_mail (string as_allegato, string as_indirizzo, string as_oggetto, string as_testo);

mailsession lms_sess
mailmessage lm_mess
mailrecipient lm_recipient
mailFileDescription lmf_file
mailreturncode lmc_rc


lmf_file.FileType = mailAttach!
lmf_file.FileName = "FATTURA.PDF"
lmf_file.PathName = as_allegato

lm_mess.NoteText = as_testo
lm_mess.Subject = as_oggetto

lm_mess.Attachmentfile[1] = lmf_file

lm_recipient.Address = as_indirizzo
lm_recipient.Name = as_indirizzo
lm_recipient.RecipientType = mailTo!
lm_mess.Recipient[1] = lm_recipient

lms_sess = create mailsession
lmc_rc = lms_Sess.mailLogon()


lmc_rc = lms_Sess.mailSend(lm_mess)
IF lmc_rc <> mailReturnSuccess! THEN
   MessageBox("Error", "Error on Send")
END IF

lmc_rc = lms_sess.mailLogoff()
IF lmc_rc <> mailReturnSuccess! THEN
   MessageBox("Error", "Error on Close")
END IF
DESTROY lms_sess
 
 
 
end subroutine

public subroutine wf_carica_testo_e_oggetto (ref string as_oggetto, ref string as_testo, date as_data, string as_num_fat);date lt_data_fat
string ls_num_fat

as_oggetto="Invio Fattura n° "+as_num_fat+ " del "+ string(as_data)

as_testo="Spettabile Cliente,~r~n"+&
"in allegato trasmettiamo la fattura in oggetto in formato PDF.~r~n"+ &
"Come da precedenti accordi, e nel rispetto delle disposizioni di Legge,~r~nnon verrà spedita alcuna copia cartacea.~r~n"+&
"La fattura allegata va stampata e conservata per tutti i necessari adempimenti di Legge,~r~ncome disposto dal DPR 633/72 "+&
"(succ. modifiche) e dalla risoluzione del~r~nMinistero delle Finanze PROT.450217 del 30 Luglio 1990.~r~n"+&
"Per visualizzare l'allegato è necessario utilizzare Acrobat Reader~r~n(gratuitamente scaricabile presso "+&
"questo indirizzo:~r~nhttp://www.adobe.it/products/acrobat/readstep2.html).~r~n"+&
"Porgendo distinti saluti e ringraziando per la fiducia accordata,~r~nrestiamo a completa "+&
"disposizione per ogni ulteriore informazione.~r~n"+&
"~r~n"+&
"Mail generata in automatico: non utilizzare l'indirizzo mittente,~r~nesso è deputato soltanto all'invio di questa mail!"
end subroutine

on w_stampa_documenti_ff.create
this.cb_ordini_txt=create cb_ordini_txt
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
this.Control[]={this.cb_ordini_txt,&
this.cb_annulla,&
this.cb_stampa,&
this.dw_1}
end on

on w_stampa_documenti_ff.destroy
destroy(this.cb_ordini_txt)
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.dw_1)
end on

event open;dw_1.insertrow(1)

datawindowchild ldw_da_tipo_registro,  ldw_a_tipo_registro, ldw_id_sog


dw_1.GetChild("id_sog_commerciale", ldw_id_sog)

dw_1.GetChild("da_tipo_registro", ldw_da_tipo_registro)

dw_1.GetChild("a_tipo_registro", ldw_a_tipo_registro)

ldw_da_tipo_registro.SetTransObject(SQLCA)
ldw_da_tipo_registro.Retrieve()

ldw_a_tipo_registro.SetTransObject(SQLCA)
ldw_a_tipo_registro.Retrieve()

ldw_id_sog.SetTransObject(SQLCA)
ldw_id_sog.Retrieve()

datawindowchild ldw_da_cod_gruppo_agente_1,  ldw_da_des_gruppo_agente_1
datawindowchild ldw_a_cod_gruppo_agente_1,  ldw_a_des_gruppo_agente_1

dw_1.getchild("da_cod_gruppo_agente_1", ldw_da_cod_gruppo_agente_1)
dw_1.getchild("da_des_gruppo_agente_1", ldw_da_des_gruppo_agente_1)
dw_1.getchild("a_cod_gruppo_agente_1", ldw_a_cod_gruppo_agente_1)
dw_1.getchild("a_des_gruppo_agente_1", ldw_a_des_gruppo_agente_1)

ldw_da_cod_gruppo_agente_1.SetTransObject(SQLCA)
ldw_da_cod_gruppo_agente_1.Retrieve()

ldw_da_des_gruppo_agente_1.SetTransObject(SQLCA)
ldw_da_des_gruppo_agente_1.Retrieve()

ldw_a_cod_gruppo_agente_1.SetTransObject(SQLCA)
ldw_a_cod_gruppo_agente_1.Retrieve()

ldw_a_des_gruppo_agente_1.SetTransObject(SQLCA)
ldw_a_des_gruppo_agente_1.Retrieve()


end event

type cb_ordini_txt from commandbutton within w_stampa_documenti_ff
integer x = 59
integer y = 32
integer width = 260
integer height = 83
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordini txt"
end type

event clicked;
string ls_da_doc,ls_a_doc,ls_da_codice,ls_a_codice,ls_da_tipo,ls_a_tipo,ls_filtro,ls_nome_report,ls_ordine,ls_dir,ls_selection_formula
long ll_da_prot,ll_a_prot,ll_num_documenti,ll_row,ll_id_documento,li_outdev,ret
date ld_da_data,ld_a_data

string ls_select, ls_where		
string ls_da_cod_gruppo_agente_1, ls_a_cod_gruppo_agente_1 
long	 ll_intervallo 
long ll_id_doc
datastore ds_documenti, ds_righe_ordine

string ls_num_doc, ls_dir_export, ls_file_export,  ls_export, ls_appoggio
integer i,li_file, a, li_righe, li_conta

dw_1.accepttext()
select path_file_export
into :ls_dir_export
from par_ordine;
if ls_dir_export="" or isnull(ls_dir_export) then
	messagebox("Stampa TXT Ordini","Path file export non trovato: sarà utilizzato 'C:\export.txt'")
	ls_dir_export="c:\exp_ordini.txt"
end if
ls_da_codice=dw_1.getitemstring(1,"codice")
ls_a_codice=dw_1.getitemstring(1,"codice2")
ls_da_tipo=dw_1.getitemstring(1,"da_tipo_registro")
ls_a_tipo=dw_1.getitemstring(1,"a_tipo_registro")
ll_da_prot=dw_1.getitemnumber(1,"da_protocollo")
ll_a_prot=dw_1.getitemnumber(1,"a_protocollo")
ld_da_data=dw_1.getitemdate(1,"da_data_reg")
ld_a_data=dw_1.getitemdate(1,"a_data_reg")
ls_ordine=dw_1.getitemstring(1,"ordine")
ls_da_doc=dw_1.getitemstring(1,"da_documento")
ls_a_doc=dw_1.getitemstring(1,"a_documento")

ls_da_cod_gruppo_agente_1=dw_1.getitemstring(1,"da_cod_gruppo_agente_1")
ls_a_cod_gruppo_agente_1=dw_1.getitemstring(1,"a_cod_gruppo_agente_1")

ds_documenti=create datastore
ds_documenti.dataobject='d_datastore_documenti'
ds_documenti.settransobject(sqlca)

if ls_da_codice>ls_a_codice then
	messagebox("Stampa documenti","Il codice del profilo iniziale è maggiore di quello finale",exclamation!)
end if
if ls_da_tipo>ls_a_tipo then
	messagebox("Stampa documenti","Il tipo di registro iniziale è maggiore di quello finale",exclamation!)
end if
if ll_da_prot>ll_a_prot then
	messagebox("Stampa documenti","Il numero del protocollo iniziale è maggiore di quello finale",exclamation!)
end if
if ld_da_data>ld_a_data then
	messagebox("Stampa documenti","La data registrazione iniziale è maggiore di quello finale",exclamation!)
end if
if ls_da_doc>ls_a_doc then
	messagebox("Stampa documenti","Il numero del documento iniziale è maggiore di quello finale",exclamation!)
end if

 
if (ls_da_codice <> '') then ls_where = ' AND prof_documento.codice >= '+"'"+string(ls_da_codice)+"'"
if (ls_a_codice <> '') then ls_where = ls_where + ' AND prof_documento.codice <= '+"'"+ls_a_codice+"'"

if not isnull(ls_da_tipo) then	ls_where = ls_where + ' AND registro.tipo_registro >= '+"'"+ls_da_tipo+"'"
if not isnull(ls_da_tipo) then	ls_where = ls_where + ' AND registro.tipo_registro <= '+"'"+ls_da_tipo+"'"

if (ll_da_prot<>0) then ls_where = ls_where + ' AND documento.num_progressivo >= '+string(ll_da_prot)	
if (ll_a_prot<>0) then ls_where = ls_where + ' AND documento.num_progressivo <= '+string(ll_a_prot)	

if (ls_da_doc<>'') then ls_where = ls_where + ' AND documento.num_documento >= '+"'"+string(ls_da_doc)+"'"
if (ls_a_doc<>'') then ls_where = ls_where + ' AND documento.num_documento <= '+"'"+ls_a_doc+"'"

if not isnull(ld_da_data) then ls_where = ls_where + " AND data_registrazione >= " + "'" + String(ld_da_data, 'yyyy/mm/dd') + "'"
if not isnull(ld_da_data) then ls_where = ls_where + " AND data_registrazione <= " + "'" + String(ld_a_data, 'yyyy/mm/dd') + "'"

if (ls_da_cod_gruppo_agente_1 <> '') then ls_where = ls_where + ' AND gruppo_agenti.codice >= ' + "'" + ls_da_cod_gruppo_agente_1 + "'"
if (ls_a_cod_gruppo_agente_1 <> '') then ls_where = ls_where + ' AND gruppo_agenti.codice <= ' + "'" + ls_a_cod_gruppo_agente_1 + "'"

if (ls_ordine='C') then
	ls_where = ls_where + ' ORDER BY sog_commerciale_gen.rag_soc_1'
else
	ls_where = ls_where + ' ORDER BY documento.num_progressivo'
end if

ls_select = ds_documenti.GetSQLSelect()

if (not isnull(ls_where)) then ls_select = ls_select + ls_where
ds_documenti.SetSQLSelect(ls_select)
ds_documenti.retrieve()


ll_num_documenti=ds_documenti.rowcount()

ret=messagebox("Stampa Documenti","Sono stato individuati "+string(ll_num_documenti)+" ordini da stamparein TXT,vuoi continuare?",question!,yesno!)
if ret=1 then
	
	ds_righe_ordine=create datastore
	ds_righe_ordine.dataobject="d_export_ordini_gd"
	ds_righe_ordine.settransobject(sqlca)
	
	
	select path_file_export
	into :ls_file_export
	from par_ordine
	;
	if ls_file_export<="" or isnull(ls_file_export) then
		ls_file_export="c:\export.txt"
	end if
	
	li_file=fileopen(ls_file_export,linemode!,write!, lockwrite!,replace!)
	for i = 1 to ll_num_documenti
		ll_id_doc=ds_documenti.getitemnumber(i, "id_documento")
		li_righe=ds_righe_ordine.retrieve(ll_id_doc)
			for a=1 to li_righe
				ls_appoggio=string(ds_righe_ordine.getitemnumber(a, "anno"))+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export=ls_appoggio
				
				ls_appoggio=ds_righe_ordine.getitemstring(a, "prof_doc_fornitore")+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				ls_appoggio=ds_righe_ordine.getitemstring(a, "num_doc_fornitore")+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
								
				ls_appoggio=string(ds_righe_ordine.getitemnumber(a, "num_riga_fornitore"))+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				ls_appoggio=string(ds_righe_ordine.getitemdecimal(a, "prezzo_manifattura"))+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				ls_appoggio=string(ds_righe_ordine.getitemdecimal(a, "pezzi"))+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				ls_appoggio=string(ds_righe_ordine.getitemdecimal(a, "peso_totale"))+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				ls_appoggio=ds_righe_ordine.getitemstring(a, "descrizione")+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				ls_appoggio=ds_righe_ordine.getitemstring(a, "num_doc_ddt")+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				ls_appoggio=string(ds_righe_ordine.getitemdate(a, "data_doc_ddt"))+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
								
				ls_appoggio=ds_righe_ordine.getitemstring(a, "prof_doc_ddt")+";"
				if isnull(ls_appoggio) then ls_appoggio=";"
				ls_export+=ls_appoggio
				
				filewrite(li_file, ls_export)
				li_conta++
	
			next
			
			
	next
	fileclose(li_file)
	destroy ds_documenti
	destroy ds_righe_ordine
	messagebox("Righe Scritte: "+string(li_conta)+".","Ho Finito!")
end if
end event

type cb_annulla from commandbutton within w_stampa_documenti_ff
integer x = 2048
integer y = 32
integer width = 260
integer height = 83
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Esci"
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_stampa_documenti_ff
integer x = 1755
integer y = 32
integer width = 260
integer height = 83
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stam&pa"
end type

event clicked;
string ls_da_doc,ls_a_doc,ls_da_codice,ls_a_codice,ls_da_tipo,ls_a_tipo,ls_filtro,ls_nome_report,ls_ordine,ls_dir,ls_selection_formula
long ll_da_prot,ll_a_prot,ll_num_documenti,ll_row,ll_id_documento,li_outdev,ret
date ld_da_data,ld_a_data, ldt_data_doc
string ls_nome1, ls_indirizzo, ls_mail
string ls_select, ls_where	, ls_testo, ls_oggetto	
string ls_da_cod_gruppo_agente_1, ls_a_cod_gruppo_agente_1 
long	 ll_intervallo 

datastore ds_documenti
datastore ds_stampa
long ll_id_conf_oggetti, ll_job, ll_id_soggetto
string ls_nome_report_precedente, ls_cod_profilo, ls_ret,ls_nome_file
string ls_num_doc, ls_pdf,ls_dir_export, ls_path_libreria, dwsyntax
integer li_ret, li_copie

dw_1.accepttext()

select "par_sistema"."dir_report" , dir_export
into :ls_dir, :ls_dir_export
from   "dba"."par_sistema"
where  "par_sistema"."id_azienda"=1
using sqlca;

if ls_dir_export="" or isnull(ls_dir_export) then
	ls_dir_export="c:\"
else
	if right(ls_dir_export, 1)<>"\" then
		ls_dir_export+="\"
	end if
end if

ls_mail=dw_1.getitemstring(1,"mail")
ls_pdf=dw_1.getitemstring(1,"pdf")
ls_da_codice=dw_1.getitemstring(1,"codice")
ls_a_codice=dw_1.getitemstring(1,"codice2")
ls_da_tipo=dw_1.getitemstring(1,"da_tipo_registro")
ls_a_tipo=dw_1.getitemstring(1,"a_tipo_registro")
ll_da_prot=dw_1.getitemnumber(1,"da_protocollo")
ll_a_prot=dw_1.getitemnumber(1,"a_protocollo")
ld_da_data=dw_1.getitemdate(1,"da_data_reg")
ld_a_data=dw_1.getitemdate(1,"a_data_reg")
ls_ordine=dw_1.getitemstring(1,"ordine")
ls_da_doc=dw_1.getitemstring(1,"da_documento")
ls_a_doc=dw_1.getitemstring(1,"a_documento")

ls_da_cod_gruppo_agente_1=dw_1.getitemstring(1,"da_cod_gruppo_agente_1")
ls_a_cod_gruppo_agente_1=dw_1.getitemstring(1,"a_cod_gruppo_agente_1")

ll_id_soggetto=dw_1.getitemnumber(1,"id_sog_commerciale")

ds_documenti=create datastore
ds_documenti.dataobject='d_datastore_documenti'
ds_documenti.settransobject(sqlca)

if ls_da_codice>ls_a_codice then
	messagebox("Stampa documenti","Il codice del profilo iniziale è maggiore di quello finale",exclamation!)
end if
if ls_da_tipo>ls_a_tipo then
	messagebox("Stampa documenti","Il tipo di registro iniziale è maggiore di quello finale",exclamation!)
end if
if ll_da_prot>ll_a_prot then
	messagebox("Stampa documenti","Il numero del protocollo iniziale è maggiore di quello finale",exclamation!)
end if
if ld_da_data>ld_a_data then
	messagebox("Stampa documenti","La data registrazione iniziale è maggiore di quello finale",exclamation!)
end if
if ls_da_doc>ls_a_doc then
	messagebox("Stampa documenti","Il numero del documento iniziale è maggiore di quello finale",exclamation!)
end if

 
if (ls_da_codice <> '') then ls_where = ' AND prof_documento.codice >= '+"'"+string(ls_da_codice)+"'"
if (ls_a_codice <> '') then ls_where = ls_where + ' AND prof_documento.codice <= '+"'"+ls_a_codice+"'"

if not isnull(ls_da_tipo) then	ls_where = ls_where + ' AND registro.tipo_registro >= '+"'"+ls_da_tipo+"'"
if not isnull(ls_da_tipo) then	ls_where = ls_where + ' AND registro.tipo_registro <= '+"'"+ls_da_tipo+"'"

if (ll_da_prot<>0) then ls_where = ls_where + ' AND documento.num_progressivo >= '+string(ll_da_prot)	
if (ll_a_prot<>0) then ls_where = ls_where + ' AND documento.num_progressivo <= '+string(ll_a_prot)	

if (ls_da_doc<>'') then ls_where = ls_where + ' AND documento.num_documento >= '+"'"+string(ls_da_doc)+"'"
if (ls_a_doc<>'') then ls_where = ls_where + ' AND documento.num_documento <= '+"'"+ls_a_doc+"'"

if not isnull(ld_da_data) then ls_where = ls_where + " AND data_registrazione >= " + "'" + String(ld_da_data, 'yyyy/mm/dd') + "'"
if not isnull(ld_da_data) then ls_where = ls_where + " AND data_registrazione <= " + "'" + String(ld_a_data, 'yyyy/mm/dd') + "'"

if (ls_da_cod_gruppo_agente_1 <> '') then ls_where = ls_where + ' AND gruppo_agenti.codice >= ' + "'" + ls_da_cod_gruppo_agente_1 + "'"
if (ls_a_cod_gruppo_agente_1 <> '') then ls_where = ls_where + ' AND gruppo_agenti.codice <= ' + "'" + ls_a_cod_gruppo_agente_1 + "'"

if (ll_id_soggetto>0) then ls_where = ls_where + " AND documento.id_sog_commerciale = "+string(ll_id_soggetto)



if (ls_ordine='C') then
	ls_where = ls_where + ' ORDER BY sog_commerciale_gen.rag_soc_1'
else
	ls_where = ls_where + ' ORDER BY documento.num_progressivo'
end if

ls_select = ds_documenti.GetSQLSelect()

if (not isnull(ls_where)) then ls_select = ls_select + ls_where
ds_documenti.SetSQLSelect(ls_select)
ll_num_documenti=ds_documenti.retrieve()


//ll_num_documenti=ds_documenti.rowcount()



if (isnull(ls_dir)) then
	messagebox("stampa documenti","directory dei report non recuperata!")
end if

ret=messagebox("Stampa Documenti","Sono stato individuati "+string(ll_num_documenti)+" documenti da stampare,vuoi continuare?",question!,yesno!)
if ret=1 then
	//correzione marco 130212 Stampa dei pdf (eventulamente da allegare alla mail)
	//if ls_pdf='S' then
		printsetup()
		ll_job=printopen()
		
		ds_stampa=create datastore
		ll_id_conf_oggetti=0
		open(w_attesa)
		
		for ll_row=1 to ll_num_documenti
			ll_id_documento=ds_documenti.getitemnumber(ll_row,"id_documento")
			ls_nome_report=ds_documenti.getitemstring(ll_row,"prof_documento_nome_report")
			select id_conf_oggetti, libreria
			into :ll_id_conf_oggetti, :ls_path_libreria
			from conf_oggetti
			where codice=:ls_nome_report;
			if ll_id_conf_oggetti>0 then
				if ls_nome_report_precedente<>ls_nome_report then
					dwsyntax = LibraryExport(ls_path_libreria, ls_nome_report, ExportDataWindow!)
					IF dwsyntax>"" THEN
						ds_stampa.create(dwsyntax)
						ds_stampa.settransobject(sqlca)
					else
						messagebox("Errore!", "libreria o report non trovati: "+ls_path_libreria +"-"+ls_nome_report)
						exit
					end if
				end if
				ds_stampa.retrieve(ll_id_documento)
				ds_stampa.Modify("DataWindow.Print.copies = "+string(li_copie))
				ls_nome_report_precedente=ls_nome_report
					ls_cod_profilo=ds_documenti.getitemstring(ll_row,"prof_documento_codice")
					ls_num_doc=ds_documenti.getitemstring(ll_row,"documento_num_documento")
					ldt_data_doc=ds_documenti.getitemdate(ll_row,"documento_data_documento")
					ls_nome_file=ls_dir_export+ls_cod_profilo+ls_num_doc+".pdf"
				if ls_pdf='S' then //se è pdf stampo nella directory dei pdf con nome = estremi documento+8 lettere rag_soc
					ds_stampa.Modify ('DataWindow.Printer="Sybase DataWindow PS" ')
					ds_stampa.Modify("Export.PDF.Method = Distill!")
					ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
					ds_stampa.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
					li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
					if ls_mail='S' then 
						ls_indirizzo=wf_cerca_indirizzo_mail(ll_id_documento)
						if ls_indirizzo>" " then
							//carico oggetto e testo dell'eventuale mail
							wf_carica_testo_e_oggetto(ls_oggetto, ls_testo, ldt_data_doc, ls_num_doc)
							wf_invia_mail(ls_nome_file, ls_indirizzo, ls_oggetto, ls_testo)	
							f_sposta_in_mail(ls_nome_file, ldt_data_doc)
						end if
					end if
				else //altrimenti stampo sulla stampante
					//ma prima controllo il flag "mail"
					
					if ls_mail='S' then 
						ls_indirizzo=wf_cerca_indirizzo_mail(ll_id_documento)
						if ls_indirizzo>" " then
							//carico oggetto e testo dell'eventuale mail
							wf_carica_testo_e_oggetto(ls_oggetto, ls_testo, ldt_data_doc, ls_num_doc)
							wf_invia_mail(ls_nome_file, ls_indirizzo, ls_oggetto, ls_testo)
							f_sposta_in_mail(ls_nome_file,ldt_data_doc )
						else
							ls_ret=ds_stampa.Modify("DataWindow.Print.documentName = '"+&
							ls_dir+ls_cod_profilo+"_"+ls_num_doc+".pdf'")
							if ls_ret<>"" then 
								messagebox("Errore!", "Documento non stampato!")
								exit
							end if
							printdatawindow(ll_job, ds_stampa)
						end if
					else
						ls_ret=ds_stampa.Modify("DataWindow.Print.documentName = '"+&
						ls_dir+ls_cod_profilo+"_"+ls_num_doc+".pdf'")
						if ls_ret<>"" then 
							messagebox("Errore!", "Documento non stampato!")
							exit
						end if
						printdatawindow(ll_job, ds_stampa)
					end if
				end if
			else //se è un report vecchio in crystal report mi adatto a questo ...
				// 170314		u_freddie.iuo_stampa.of_setup_printer()	
					
//					ll_id_documento=ds_documenti.getitemnumber(ll_row,"id_documento")
//					ls_nome_report=ds_documenti.getitemstring(ll_row,"prof_documento_nome_report")
					ls_nome1 = upper(ls_nome_report)
					select numero_copie
					into :li_copie
					from profilo_stampa
					where upper(nome_report) = :ls_nome1;
					if (li_copie = 0) or isnull(li_copie) then li_copie = 1
					
			
					ls_selection_formula="{documento.id_documento}="+string(ll_id_documento)
					li_outdev=2
					
//					u_freddie.iuo_stampa.is_nome_report=ls_nome_report
//					u_freddie.iuo_stampa.of_set_selection_formula(ls_selection_formula)
					
//					u_freddie.iuo_stampa.of_set_title("titolo")
//					u_freddie.iuo_stampa.of_set_view(u_freddie.iuo_stampa.maximize_view)
					
//					u_freddie.iuo_stampa.of_stampa(0,li_outdev,0,0,li_copie,ls_dir,ls_nome_report)		
			END IF
			
		NEXT
		PRINTCLOSE(ll_job)
		destroy ds_stampa
		CLOSE(W_ATTESA)
end if
destroy ds_documenti


end event

type dw_1 from u_dw_ext_main within w_stampa_documenti_ff
integer x = 37
integer y = 128
integer width = 2271
integer height = 1514
integer taborder = 30
string dataobject = "d_stampa_documenti_ff"
end type

event ue_set_search;choose case as_nomecol
	case "codice"
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"
	case "descrizione" 
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
	case "codice2"
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"	
	case "descrizione2" 
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
		
	
	
		
		
		
	
		
		
		
		
		
		
		
	
		
		
		
END CHOOSE		

end event

event ue_use_search;choose case as_nomecol
	case "codice"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("descrizione",is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1,"codice2")) or this.getitemstring(1,"codice2")='' then
		  uf_set_colval("codice2",is_ricpar.s_main_value)
		  uf_set_colval("descrizione2",is_ricpar.s_ausil_value[1])
	   end if
	case "descrizione"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice",is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1,"codice2")) or this.getitemstring(1,"codice2")='' then
		  uf_set_colval("descrizione2",is_ricpar.s_main_value)
		  uf_set_colval("codice2",is_ricpar.s_ausil_value[1])
	   end if
	case "codice2"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("descrizione2",is_ricpar.s_ausil_value[1])
	case "descrizione2"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice2",is_ricpar.s_ausil_value[1])
		
	
		
		
	
		
		
		
		
		
		
		
	
		
		
		
end choose
end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

choose case dwo.name
	case "codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc) 

		IF (li_ok > 0) THEN
			IF isnull(this.getitemstring(1,"codice2")) or this.getitemstring(1,"codice2")='' then	
		       This.SetItem(1, "codice2", upper(Data))	
	          This.SetItem(1, "descrizione2", this.getitemstring(1,"descrizione"))
	      End if 
			RETURN 2
		END IF
		
	case "descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)  

		IF (li_ok > 0) THEN
			IF isnull(this.getitemstring(1,"codice2")) or this.getitemstring(1,"codice2")='' then
		     This.SetItem(1, "codice2", upper(this.getitemstring(1,"codice")))	
	        This.SetItem(1, "descrizione2", data)
		   End If	
			RETURN 2
		END IF
		
	case "codice2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "codice2"
		ls_dwc[2] = "descrizione2"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "descrizione2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "codice2"
		ls_dwc[2] = "descrizione2"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	
case "mail"
	if data='S' then
		setitem(1, "pdf", "S")
	end if
		
	
		
		
	
		

		
	 end choose

end event

event clicked;call super::clicked;//
//string ls_testo, ls_oggetto
//
//ls_oggetto="Invio Fattura Elettronica"
//ls_testo="Spettabile ....., "+&
//"in allegato trasmettiamo nostra fattura nr. .... del ../../2011 in formato PDF."+ &
//"Come da precedenti accordi, e nel rispetto delle disposizioni di Legge, non verrà spedita alcuna copia cartacea."+&
//"La fattura allegata va stampata e conservata per tutti i necessari adempimenti di Legge, come disposto dal DPR 633/72 "+&
//"(succ. modifiche) e dalla risoluzione del Ministero delle Finanze PROT.450217 del 30 Luglio 1990."+&
//"Per visualizzare l'allegato è necessario utilizzare Acrobat Reader (gratuitamente scaricabile presso "+&
//"questo indirizzo: http://www.adobe.it/products/acrobat/readstep2.html)."+&
//"Porgendo distinti saluti e ringraziando per la fiducia accordata, restiamo a completa "+&
//"disposizione per ogni ulteriore informazione."
//	
//if dwo.name="mail" then
//	setitem(row, "testo_mail", ls_testo)
//	setitem(row, "oggetto_mail" , ls_oggetto)
//end if


end event

