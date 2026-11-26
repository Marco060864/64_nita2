forward
global type uo_mail from nonvisualobject
end type
end forward

global type uo_mail from nonvisualobject autoinstantiate
end type

type variables
s_e_mail is_mail
n_smtp gn_smtp
n_application  n_app
end variables

forward prototypes
public subroutine of_prepara_campi_mail (long al_id_doc)
public function string of_controlla_nome_file (string as_nome_file)
public function string of_rec_dati_server (string as_cod_riga, string as_dato_richiesto)
public function string of_replace_all (string as_oldstring, string as_findstr, string as_replace)
public subroutine of_invia_mail (string as_cod_riga, string as_html, boolean ab_crea_log, boolean ab_debug)
public subroutine of_allega_files (long al_id_doc, string as_mostra_prezzi)
public subroutine of_send_mail (string as_cod_riga, string as_html, boolean ab_crea_log, boolean ab_debug)
public function string of_crea_pdf (long al_id_doc, string as_vedi_prezzo, string as_ordina)
public subroutine of_new_mailsender (string as_cod_riga, string as_html, boolean ab_crea_log, boolean ab_debug)
end prototypes

public subroutine of_prepara_campi_mail (long al_id_doc);string ls_des_prof, ls_destinatario, ls_azienda,ls_cod_prof, ls_num_doc, ls_nome_report, ls_indirizzo_e_mail
long ll_id_ana, ll_id_sog_com, ll_id_prof_doc
date ldt_data_doc

integer li_pos, li_pos_2
select p.descrizione, a.rag_soc_1, az.rag_soc_1, a.id_anagrafica, p.codice,
 d.num_documento, d.data_documento, p.id_prof_documento, d.id_sog_commerciale, p.nome_report

into :ls_des_prof, :ls_destinatario, :ls_azienda, :ll_id_ana, 
:ls_cod_prof, :ls_num_doc, :ldt_data_doc, :ll_id_prof_doc, :ll_id_sog_com, :ls_nome_report
from prof_documento p, documento d, sog_commerciale s, anagrafica a, azienda az
where a.id_anagrafica=s.id_anagrafica
and s.id_sog_commerciale=d.id_sog_commerciale
and p.id_prof_documento=d.id_prof_documento
and d.id_documento=:al_id_doc
and az.id_azienda=d.id_azienda;

//is_mail.s_testo="Spettabile "+ls_destinatario+",~r~n"+&
//"in allegato trasmettiamo "+ ls_des_prof+" in oggetto in formato PDF.~r~n"+ &
//"QUESTA STAMPA È PRIVA DI VALENZA GIURIDICO-FISCALE AI SENSI DELL’ARTICOLO 21 DPR 633/72.~r~n"+&
//"Per visualizzare l'allegato è necessario utilizzare Acrobat Reader (gratuitamente scaricabile presso "+&
//"questo indirizzo:~r~nhttp://www.adobe.it/products/acrobat/readstep2.html).~r~n"+&
//"Porgendo distinti saluti e ringraziando per la fiducia accordata, restiamo a completa "+&
//"disposizione per ogni ulteriore informazione.~r~n~r~n"+&
//ls_azienda+"~r~n"+&
//"~r~n"+&
//"~r~n"+&
//"~r~n"+&
//"Informativa Privacy: Ai sensi del D.Lgs n. 196/2003 (Codice Privacy)~r~n"+&
//"si precisa che le informazioni contenute in questo messaggio~r~n"+&
//"sono riservate e ad uso esclusivo del destinatario. ~r~n"+&
//"Qualora il messaggio in parola Le fosse pervenuto per errore, ~r~n"+&
//"La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,~r~n"+&
//"dandocene gentilmente comunicazione. ~r~n"+&
//"Grazie."


if isnull(is_mail.s_email_1) or is_mail.s_email_1="" then
	select num_riferimento
	into :ls_indirizzo_e_mail
	from telefono
	where tipo='E'
	and id_anagrafica=:ll_id_ana;
	if pos( ls_indirizzo_e_mail, "@")> 0 then
		//300713 per ora gestisco solo 3 indirizzi: il primo in To e il secondo e il terzo in CC e cc_2
		//s_mail.s_email_1, s_mail.s_email_2, s_mail.s_email_3
		//300713 per ora gestisco solo 3 indirizzi: il primo in To e il secondo e il terzo in CC e cc_2
		li_pos=pos(ls_indirizzo_e_mail, ";")
		li_pos_2=pos(ls_indirizzo_e_mail, ";",li_pos+1 )
		if li_pos_2>0 then //ci sono 3 indirizzi
			//su s_mail.s_email_3 ci metto il terzo
			is_mail.s_email_3=right(ls_indirizzo_e_mail, len(ls_indirizzo_e_mail) - li_pos_2)
			//tolgo l'indirizzo cc_2
			ls_indirizzo_e_mail=left(ls_indirizzo_e_mail, li_pos_2 -1)
		end if
		if li_pos>0 then
			is_mail.s_email_2=right(ls_indirizzo_e_mail, len(ls_indirizzo_e_mail) - li_pos)
			is_mail.s_email_1=left(ls_indirizzo_e_mail, li_pos -1)
		else
			is_mail.s_email_1=ls_indirizzo_e_mail
		end if
	else
		messagebox("Attenzione!", "Inserire un indirizzo mail corretto! Operazione annullata.")
	end if
END IF
is_mail.s_oggetto=ls_cod_prof+" n. "+ls_num_doc+" del "+string(ldt_data_doc, "dd/mm/yyyy")
//20261126 come nella 64_2025: serve a of_new_mailsender per sapere se e' una fattura
is_mail.l_id_doc=al_id_doc

	
	
end subroutine

public function string of_controlla_nome_file (string as_nome_file);integer i


i=pos(as_nome_file, "/")

do while i>0 
	as_nome_file=Replace ( as_nome_file, i, 1, "-") 
	i=pos(as_nome_file, "/")
loop

return as_nome_file
end function

public function string of_rec_dati_server (string as_cod_riga, string as_dato_richiesto);string ls_return
long ll_riga_corrente
datastore ds_dati_mail
integer li_righe

ds_dati_mail=create datastore
ds_dati_mail.dataobject="d_dati_mail"
ds_dati_mail.settransobject(sqlca)
li_righe=ds_dati_mail.retrieve()
ll_riga_corrente=ds_dati_mail.find( "codice='"+as_cod_riga+"'", 1, li_righe)
if ll_riga_corrente>0 then
	//20261126 colonna che in questo database non c'e' (es. rispondi_a sul db di Labella): vuoto, non errore
	if ds_dati_mail.describe(as_dato_richiesto+".coltype")="!" then
		ls_return=""
	else
		ls_return=ds_dati_mail.getitemstring(ll_riga_corrente, as_dato_richiesto)
	end if
	
else
	ls_return=""
end if
destroy ds_dati_mail
return ls_return
end function

public function string of_replace_all (string as_oldstring, string as_findstr, string as_replace);String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring
end function

public subroutine of_invia_mail (string as_cod_riga, string as_html, boolean ab_crea_log, boolean ab_debug);String  ls_server, ls_uid, ls_pwd, ls_invia_mail, ls_campo_mail, ls_testo, ls_7zip_path, ls_allegatiM_path
String ls_filename, ls_port, ls_encrypt, ls_errormsg,ls_destinatario, ls_rag_azienda
Integer li_max, i, li_pos, a, b, li_pos_2, li_destinatari_selezionati,li_test
Boolean lb_html, lb_Return
UInt lui_port
datetime ldt_data_ora_invio
string ls_send_email, ls_send_nome, ls_mittente, ls_nome_mittente, ls_allegati,ls_base_path,ls_alt_path
long ll_riga_testa, ll_riga_mail, ll_id_invio
SetPointer(HourGlass!)
datastore ds_dati_invio
ds_dati_invio=create datastore
ds_dati_invio.dataobject="d_invio"
ds_dati_invio.settransobject(sqlca)

//dw_1.accepttext()
ls_mittente=of_rec_dati_server(as_cod_riga, "mittente")
if messagebox("Attenzione!", ls_mittente+ " invierà la mail e i suoi allegati agli indirizzi selezionati: "+is_mail.s_email_1+", va bene?", Stopsign!, yesno!)=1 then

	ls_server=of_rec_dati_server(as_cod_riga, "smtp")
	If ls_server = "" Then
		MessageBox("Edit Error", &
			"You must specify Server on the Settings tab first!", StopSign!)
		Return
	End If
	
	//is_mail.s_oggetto=dw_1.getitemstring(1, "oggetto")
	
	If is_mail.s_oggetto= "" or isnull(is_mail.s_oggetto) Then
		MessageBox("Edit Error", &
		"Il campo Oggetto non può essere vuoto!", StopSign!)
		Return
	End If
	if left(is_mail.s_tipo_ae, 2)<> "TD" then
		
		If is_mail.s_testo = "" or isnull(is_mail.s_testo) Then
			MessageBox("Edit Error", "Il testo è richiesto!", StopSign!)
			Return
		End If
	
	end if
	
	//ls_indirizzo_mittente=wf_rec_dati_server("user_id")
	ls_nome_mittente=of_rec_dati_server(as_cod_riga,"nome_mittente")
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
		//sle_from_email.SetFocus()
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		Return
	End If
	
	
	If as_html='S' Then
//		is_mail.s_testo  = "<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
//		is_mail.s_testo += of_replace_all(is_mail.s_testo, "~r~n", "<br>") + "</h2>"
//		is_mail.s_testo += "</body></html>"
		ls_testo="<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
		ls_testo += of_replace_all(is_mail.s_testo, "~r~n", "<br>") + "</h2>"
	     ls_testo += "</body></html>"
		 is_mail.s_testo=ls_testo
		lb_html = True
	Else
		lb_html = False
	End If

	lui_port= long(of_rec_dati_server(as_cod_riga, "porta"))
	
	// *** set email properties *********************
	gn_smtp.of_ResetAll()
	gn_smtp.of_SetPort(lui_port)
	gn_smtp.of_SetServer(ls_server)
	gn_smtp.of_SetLogFile(ab_crea_log, "smtp_logfile8.txt")
	gn_smtp.of_SetDebugViewer(ab_debug)
	gn_smtp.of_SetSubject(is_mail.s_oggetto)
	gn_smtp.of_SetBody(is_mail.s_testo, lb_html)
	gn_smtp.of_SetFrom(ls_mittente, ls_nome_mittente)
	
	//mando la copia a me stesso per verifica
	//20230508 silverstelle non la vuole.... 
	select rag_soc_1 into :ls_rag_azienda from azienda;
	if pos(upper(ls_rag_azienda),"SILVERSTELLE")<=0 then 
		gn_smtp.of_AddAddress(ls_mittente, ls_nome_mittente)
		If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
			//sle_send_email.SetFocus()
			MessageBox("Edit Error", ls_errormsg, StopSign!)
			Return
		End If
	end if
	if is_mail.s_tipo_ae> "TD" then //è un fat elettronica il destinatario è da recuperare in azienda, HUB_ae
		select hub_ae
		into :is_mail.s_email_1
		from dba.azienda
		;
		if isnull(is_mail.s_email_1) or is_mail.s_email_1<" " then
			messagebox("Attenzione!", "Non è specificato a quale HUB inviare la Fat-elettronica. Campo HUB_ae tabella AZIENDA! Invio interrotto!")
			return
		end if
	end if
	//aggiungo testa alla dw che memorizza i dati invio
	ll_riga_testa=ds_dati_invio.insertrow(0)
	ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_mittente)
	ds_dati_invio.setitem(ll_riga_testa, "data_ora", today())
	//ls_condominio=ds_dati_invio.getitemstring(ds_dati_invio.getrow(), "condominio")

	ds_dati_invio.setitem(ll_riga_testa, "destinatario", is_mail.s_email_1)
	if ds_dati_invio.update()= 1 then
		commit;
		ll_id_invio=ds_dati_invio.getitemnumber(ll_riga_testa, "id_invio")
		if ll_id_invio>0 then
				ls_send_email=""
				ls_send_nome=""
				ls_send_nome=is_mail.s_email_1
				ls_send_email=is_mail.s_email_1
				//li_pos=pos(ls_mittente, ";")  //20210928 credo sia un errore: gli indirizzi cui inviare vanno cercati in ls_send_email!
				li_pos=pos(ls_send_email, ";")
				if li_pos>0 then //ci sono più indirizzi mail indicati nel campo mail: devo dividerli
					a=1
					do while li_pos>0
						ls_invia_mail=mid(ls_send_email, a, li_pos  - a)
						gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
						If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
							//sle_send_email.SetFocus()
							MessageBox("Edit Error", ls_errormsg, StopSign!)
							Return
						End If
						//memorizzo mail, nome, data_ora per il report ricevuta
						ll_riga_mail=ds_dati_invio.insertrow(0)
						ds_dati_invio.setitem(ll_riga_testa, "id_invio", ll_id_invio)
						//credo sia sbagliato anche questo (errore metodico!???) 20210928
//						ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_invia_mail)
//						ds_dati_invio.setitem(ll_riga_testa, "destinatario", ls_send_nome)
						ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_mittente)
						ds_dati_invio.setitem(ll_riga_testa, "destinatario", ls_invia_mail)
						//ds_dati_invio.setitem(ll_riga_testa,"avviso", is_mail.s_testo)
						a=li_pos+1
						li_pos=pos(ls_send_email, ";", a)
						
						if li_pos<=0 then
							li_pos_2=pos(ls_send_email, "@", a)
							if li_pos_2>0 then  //c'è un altro indirizzo, recuperiamolo
								ls_invia_mail=mid(ls_send_email, a, len(ls_send_email) - a +1)
								gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
								If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
									//sle_send_email.SetFocus()
									MessageBox("Edit Error", ls_errormsg, StopSign!)
									Return
								End If
								ll_riga_mail=ds_dati_invio.insertrow(0)
								ds_dati_invio.setitem(ll_riga_testa, "id_invio", ll_id_invio)
								//ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_invia_mail)
								ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_mittente)
								ds_dati_invio.setitem(ll_riga_testa, "destinatario", ls_send_nome)
								//ds_dati_invio.setitem(ll_riga_testa,"avviso", is_mail.s_testo)
							end if
						end if
					loop
					
				else
					//gn_smtp.of_AddAddress(sle_send_email.text, sle_send_name.text)
					gn_smtp.of_AddAddress(ls_send_email, ls_send_nome)
					If Not gn_smtp.of_ValidEmail(ls_send_email, ls_errormsg) Then
						//sle_send_email.SetFocus()
						MessageBox("Edit Error", ls_errormsg, StopSign!)
						Return
					End If
					//ll_riga_mail=ds_dati_invio.insertrow(0)
					ds_dati_invio.setitem(ll_riga_testa, "id_invio", ll_id_invio)
					ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_send_email)
					ds_dati_invio.setitem(ll_riga_testa, "destinatario", ls_send_nome)
					//ds_dati_invio.setitem(ll_riga_testa,"avviso", is_mail.s_testo)
				end if
				
		
			if ds_dati_invio.update()<>1 then
				MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA LISTA'. Contattare l'assistenza!")
				rollback;
			else
				commit;
			end if
	
	//	dw_1.setfilter("")
	//	dw_1.filter()
		//fine 2016-05-11
		
			// *** set Userid/Password if required **********
			//If of_getreg("Auth", "N") = "Y" Then
			if of_rec_dati_server(as_cod_riga, "auth")= "Y" then
				ls_uid = of_rec_dati_server(as_cod_riga, "user_id")//of_getreg("Userid", "")
				ls_pwd =of_rec_dati_server(as_cod_riga, "password")// of_getreg("Password", "")
				gn_smtp.of_SetLogin(ls_uid, ls_pwd)
			End If
			
			// *** aggiunge gli allegati **********************
	//		alternativa da verificare prima di cambiare 20250918
			li_max = upperbound(is_mail.s_allegato)
			li_test=0
			for i= 1 to li_max
				if pos(upper(is_mail.s_allegato[i]), 'TXT')>0 and pos(upper(is_mail.s_allegato[i]), 'DOC')>=0 then
					li_test=1
					exit
				end if
			next
				
			if left(is_mail.s_tipo_ae, 2) <> "TD" and li_test=1 then
			    // 20250915: zippo i file txt per evitare CRLF aggiunti dal client di posta
			    ls_7zip_path = "C:\Programmi\7-Zip\7z.exe"
			    ls_base_path = "c:\nita\exp_doc\"
			    ls_alt_path = "c:\start\pdf\"
			
			    // Verifica se il file è già nel percorso previsto
			    if pos(is_mail.s_allegato[1], ls_base_path) > 0 then
			        li_pos = len(ls_base_path)
			    else
			        li_pos = len(ls_alt_path)
			    end if
			
			    // Costruzione del nome file zip
			    ls_filename = mid(is_mail.s_allegato[1], li_pos + 1, len(is_mail.s_allegato[1]) - li_pos - 3)
			    ls_allegatiM_path = ls_base_path + ls_filename + ".zip"
			
			    // Compressione e allegato
			    f_zip_files(ls_allegatiM_path, ls_7zip_path, is_mail.s_allegato)
			    gn_smtp.of_AddAttachment(ls_allegatiM_path)
			else
			    // Allego direttamente i file
			    For i = 1 To li_max
			        gn_smtp.of_AddAttachment(is_mail.s_allegato[i])
			    Next
			end if
//20250918			
						
			
//			li_max = upperbound(is_mail.s_allegato)
//			//20250915 cambio e zippo i files txt senno il clent di posta mi aggiunge cRLF qua e là
//			ls_7zip_path="C:\Programmi\7-Zip\7z.exe"
//			ls_allegatiM_path="c:\nita\exp_doc\allegati.zip"
//			f_zip_files(ls_allegatiM_path, ls_7zip_path, is_mail.s_allegato)
//			
//			//For i = 1 To li_max		 //20250915 vedi sopra
//				//gn_smtp.of_AddAttachment(is_mail.s_allegato[i])    //20250915 vedi sopra
//				gn_smtp.of_AddAttachment(ls_allegatiM_path)
//		//		ls_filename = lb_attachments.Text(i)
//		//		gn_smtp.of_AddAttachment(ls_filename)
//		//		ls_allegati+=ls_filename+";"
//			//Next //20250915 vedi sopra
			
			
			
			ds_dati_invio.setitem(ll_riga_testa,"allegati", ls_allegati)
			// *** send the message *************************
			ls_encrypt = n_app.of_getreg("Encrypt", "None")
			ls_encrypt=of_rec_dati_server(as_cod_riga, "ssl")
			//guardo se la fat è già stata inviata
			if is_mail.s_tipo_ae> "TD" then
				select data_ora_invio
				into :ldt_data_ora_invio
				from dba.FE_invio
				where id_documento=:is_mail.l_id_doc
				;
				if string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")> string(datetime("2018-12-01"),"yyyy-mm-dd hh:mm")   then
					if messagebox("Attenzione!", "Il documento è stato già inviato una volta ("+ string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")+"). Vuoi inviarlo ancora lo stesso?", stopsign!, yesno!)=2 then
						return
					end if
				end if
			end if
			//fien controllo
			choose case ls_encrypt
				case "SSL"
					lb_Return = gn_smtp.of_SendSSLMail()
				case "TLS"
					lb_Return = gn_smtp.of_SendTLSMail()
				case else
					lb_Return = gn_smtp.of_SendMail()
			end choose
			
			If lb_Return Then
				MessageBox("SendMail", "Mail successfully sent!")
				ds_dati_invio.setitem(ll_riga_testa, "invio_ok", "S")
				//memorizzo oggetto e testo per riproporli la prossima volta
				//SetProfileString ( "ermes.ini", "Ultima_Mail", "Oggetto", is_mail.s_oggetto)
				//SetProfileString ( "ermes.ini", "Ultima_Mail", "Testo", is_mail.s_testo )
				//SE è una Fat. elettronica aggiorno il cntatore e salvo i dati nella FE_invio
				if is_mail.s_tipo_ae> "TD" then
					f_salva_invio(is_mail.l_id_doc, ls_allegati)
					post close(parent)
				END IF
			Else
				MessageBox("SendMail Error", gn_smtp.of_GetLastError())
				ds_dati_invio.setitem(ll_riga_testa, "invio_ok", "N")
			End If
			if ds_dati_invio.update()<>1 then
				MessageBox("Attenzione!", "Errore nel salvataggio ESITO INVIO. Contattare l'assistenza!")
				rollback;
			else
				commit;
			end if
		end if
	else
		rollback;
		MessageBox("Attenzione!", "Errore nel salvataggio del report di invio. Contattare l'assistenza!")
	end if
//else
//	//MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA'. Contattare l'assistenza!")
end if
end subroutine

public subroutine of_allega_files (long al_id_doc, string as_mostra_prezzi);integer li_ret, i, li_righe
long ll_id_riga_doc_provenienza, ll_id_uc
decimal  ldc_titolo
string ls_doc, ls_numero, ls_allegati, ls_num_doc, ls_metallo, ls_des, ls_um, ls_path, ls_azienda
date ldt_data
integer li_max, li_pos
long ll_id_art,ll_id_riga,ll_id_prof_doc

select rag_soc_1 into :ls_azienda
from dba.azienda;
ls_azienda=upper(ls_azienda)

ls_path="c:\nita\exp_doc"
If not(DirectoryExists ( ls_path)) Then
	createdirectory(ls_path)
end if

select data_documento, num_documento
into :ldt_data, :ls_numero
from dba.documento
where id_documento=:al_id_doc
;

li_pos=pos(ls_numero, "/")
if li_pos>0 then
	ls_numero=left(ls_numero, li_pos -1) +"-"+right(ls_numero, len(ls_numero) - li_pos)
end if
ls_doc="n_"+ls_numero+"_del_"+string(ldt_data, "dd-mm-yy")
//20220928 Samy vuole che se il prof_doc è laser allora il numero doc sia "xx/L" se è ripara "xx/R
select id_prof_documento into :ll_id_prof_doc from dba.documento where id_documento=:al_id_doc;
//20220928 fine per ora
datastore ds_doc, ds_righe, ds_articolo_2016, ds_unita_confezione_2016, ds_articolo_2016_2, ds_unita_confezione_2016_2

ds_doc=create datastore
ds_doc.dataobject="ds_documento_2016"
ds_doc.settransobject(sqlca)
li_ret=ds_doc.retrieve(al_id_doc)
if li_ret>0 then
	//20220928 Samy vuole che se il prof_doc è laser allora il numero doc sia "xx/L" se è ripara "xx/R
	if pos(upper(ls_azienda), "SILVER DR")>0 then
		if ll_id_prof_doc=204 then  //ripara
			ds_doc.setitem(1, "num_documento", ls_numero+ "/R")
		elseif ll_id_prof_doc=196 then  //TLaser
			ds_doc.setitem(1, "num_documento", ls_numero+ "/L")
		end if
	end if
	//fine 20220928
	li_ret=ds_doc.saveasascii("c:\nita\exp_doc\Doc_"+ls_doc+".txt")
	li_max=upperbound(is_mail.s_allegato)
	if isnull(li_max) then li_max=0
	li_max++
	is_mail.s_allegato[li_max]="c:\nita\exp_doc\Doc_"+ls_doc+".txt"
else
	messagebox("Attenzione!", "Doc non trovato!")
end if

ds_righe=create datastore
ds_righe.dataobject="ds_riga_documento_2016"
ds_righe.settransobject(sqlca)
li_righe=ds_righe.retrieve(al_id_doc)
if li_righe>0 then
	for i=1 to li_righe
		if pos(upper(ls_azienda), "SILVER DR")> 0 then
			ll_id_riga=ds_righe.getitemnumber(i, "id_riga_documento")
			//20210219 per poter ritrovare nel documetno di ritorno il doc di andata
			ds_righe.setitem(i, "id_riga_doc_provenienza", ll_id_riga)
			ll_id_riga_doc_provenienza=ds_righe.getitemnumber(i, "provv_imp_subage_2")
	//		if ll_id_riga_doc_provenienza>0 then
	//			select num_documento
	//			into :ls_num_doc
	//			from dba.riga_documento r, dba.documento d
	//			where d.id_documento=r.id_documento
	//			and r.id_riga_documento=:ll_id_riga_doc_provenienza
	//			;
	//			ds_righe.setitem(i, "provv_imp_carea_2", dec(right(ls_num_doc, 5)))
	//		end if
			if ll_id_riga_doc_provenienza>0 then
				select num_documento
				into :ls_num_doc
				from dba.riga_documento r, dba.documento d
				where d.id_documento=r.id_documento
				and r.id_riga_documento=:ll_id_riga_doc_provenienza
				;
				//ds_righe.setitem(i, "provv_imp_carea_2", dec(right(ls_num_doc, 5))) //20251016 !!!!!!!!!! cambio metto 7 caratteri tutta la bollettina e cambio campo: "provv_imp_carea"
				ds_righe.setitem(i, "provv_imp_carea", dec(right(ls_num_doc, 7)))
			else
				ll_id_riga=ds_righe.getitemnumber(i, "id_riga_documento")
				select first(id_riga_documento) into :ll_id_riga_doc_provenienza
				from dba.produzione_2011 p, dba.riga_documento r where p.id_doc_produzione=:ll_id_riga
				and r.id_documento=p.id_bollettina;
				if ll_id_riga_doc_provenienza<0 or isnull(ll_id_riga_doc_provenienza) then
					messagebox("Attenzione!", "Bollettina non legata a questa riga: "+string(i))
				end if
				//
			end if
			//20220921samy vuole che col profilo ripara (204) parta solo l'articolo (id_articolo) 281 
			if ll_id_prof_doc=204 and pos(upper(ls_azienda), "SILVER DR")>0 then
				ll_id_art=281
				ds_righe.setitem(i, "id_articolo",ll_id_art)
			else
				ll_id_art=ds_righe.getitemnumber(i, "id_articolo")
			end if
			//20220921 fine
			//prendo titolo e metallo e li aggiungo alla descrizione riga
			if ll_id_art>0 then
				select m.codice, t.titolo
				into :ls_metallo, :ldc_titolo
				from dba.orafo_metallo m, orafo_titolo t, articolo a
				where a.id_titolo=t.id_titolo
				and m.id_metallo=t.id_metallo
				and a.id_articolo=:ll_id_art
				;
			end if
			if ldc_titolo>=0 then
				ls_des=ds_righe.getitemstring(i, "descrizione")
				ls_des+="::"+ls_metallo+string(ldc_titolo, "#,0.00")
				ll_id_uc=ds_righe.getitemnumber(i, "id_unita_confezione")
				select u.simbolo
				into :ls_um
				from dba.unita_misura u, dba.unita_confezione uc
				where uc.id_unita_misura=u.id_unita_misura
				and uc.id_unita_confezione=:ll_id_uc
				;
				if ls_um> " " then
					ls_des+=";;"+ls_um
				end if
				ds_righe.setitem(i, "descrizione", ls_des)
			end if
		end if
	next
	
	li_ret=ds_righe.saveasascii("c:\nita\exp_doc\Riga_"+ls_doc+".txt")

	li_max++
	is_mail.s_allegato[li_max]="c:\nita\exp_doc\Riga_"+ls_doc+".txt"
else
	messagebox("Attenzione!", "RIGA non trovata!")
end if
ds_articolo_2016=create datastore
ds_articolo_2016.dataobject="ds_articolo_2016"
ds_articolo_2016.settransobject(sqlca)
ds_articolo_2016_2=create datastore
ds_articolo_2016_2.dataobject="ds_articolo_2016"
ds_articolo_2016_2.settransobject(sqlca)

ds_unita_confezione_2016=create datastore
ds_unita_confezione_2016.dataobject="ds_unita_confezione_2016"
ds_unita_confezione_2016.settransobject(sqlca)
ds_unita_confezione_2016_2=create datastore
ds_unita_confezione_2016_2.dataobject="ds_unita_confezione_2016"
ds_unita_confezione_2016_2.settransobject(sqlca)
//recupera articoli e uc
for i= 1 to li_righe
	ll_id_art=0
	ll_id_art=ds_righe.getitemnumber(i, "id_articolo")
	if ll_id_art>0 then
		ds_articolo_2016.retrieve(ll_id_art)
		ds_articolo_2016.rowscopy(1,1, primary!, ds_articolo_2016_2, 100000, primary!)
		ds_unita_confezione_2016.retrieve(ll_id_art)
		ds_unita_confezione_2016.rowscopy(1,1, primary!, ds_unita_confezione_2016_2, 100000, primary!)
	end if
next

li_ret=ds_articolo_2016_2.saveasascii("c:\nita\exp_doc\Art_"+ls_doc+".txt")
li_max++
is_mail.s_allegato[li_max]="c:\nita\exp_doc\Art_"+ls_doc+".txt"
li_ret=ds_unita_confezione_2016_2.saveasascii("c:\nita\exp_doc\Uc_"+ls_doc+".txt")
li_max++
is_mail.s_allegato[li_max]="c:\nita\exp_doc\Uc_"+ls_doc+".txt"

destroy ds_doc
destroy ds_righe
destroy ds_articolo_2016
destroy ds_unita_confezione_2016
destroy ds_articolo_2016_2
destroy ds_unita_confezione_2016_2

//datastore ds_doc, ds_righe,ds_articolo_2016, ds_unita_confezione_2016
//ds_articolo_2016=create datastore
//ds_articolo_2016.dataobject="ds_articolo_2016"
//ds_articolo_2016.settransobject(sqlca)
//
//ds_unita_confezione_2016=create datastore
//ds_unita_confezione_2016.dataobject="ds_unita_confezione_2016"
//ds_unita_confezione_2016.settransobject(sqlca)
//
//ds_doc=create datastore
//ds_doc.dataobject="ds_documento_2016"
//ds_doc.settransobject(sqlca)
//
//
//ds_doc=create datastore
//ds_doc.dataobject="ds_documento_2016"
//ds_doc.settransobject(sqlca)
//li_ret=ds_doc.retrieve(al_id_doc)
//if li_ret>0 then
//	li_ret=ds_doc.saveasascii("c:\nita\exp_doc\Doc_"+ls_doc+".txt")
//	li_max=upperbound(is_mail.s_allegato)
//	if isnull(li_max) then li_max=0
//	li_max++
//	is_mail.s_allegato[li_max]="c:\nita\exp_doc\Doc_"+ls_doc+".txt"
//else
//	messagebox("Attenzione!", "Doc non trovato!")
//end if
//
//ds_righe=create datastore
//ds_righe.dataobject="ds_riga_documento_2016"
//ds_righe.settransobject(sqlca)
//li_righe=ds_righe.retrieve(al_id_doc)
//if li_righe>0 then
//	for i=1 to li_righe
//		ll_id_riga_doc_provenienza=ds_righe.getitemnumber(i, "provv_imp_subage_2")
//		if ll_id_riga_doc_provenienza>0 then
//			select num_documento
//			into :ls_num_doc
//			from dba.riga_documento r, dba.documento d
//			where d.id_documento=r.id_documento
//			and r.id_riga_documento=:ll_id_riga_doc_provenienza
//			;
//			ds_righe.setitem(i, "provv_imp_carea_2", dec(right(ls_num_doc, 5)))
//		end if
//		//prendo titolo e metallo e li aggiungo ala descrizione riga
//		ll_id_art=ds_righe.getitemnumber(i, "id_articolo")
//		if ll_id_art>0 then
//			select m.codice, t.titolo
//			into :ls_metallo, :ldc_titolo
//			from dba.orafo_metallo m, orafo_titolo t, articolo a
//			where a.id_titolo=t.id_titolo
//			and m.id_metallo=t.id_metallo
//			and a.id_articolo=:ll_id_art
//			;
//		end if
//		if ldc_titolo>=0 then
//			ls_des=ds_righe.getitemstring(i, "descrizione")
//			ls_des+="::"+ls_metallo+string(ldc_titolo, "#,0.00")
//			ll_id_uc=ds_righe.getitemnumber(i, "id_unita_confezione")
//			select u.simbolo
//			into :ls_um
//			from dba.unita_misura u, dba.unita_confezione uc
//			where uc.id_unita_misura=u.id_unita_misura
//			and uc.id_unita_confezione=:ll_id_uc
//			;
//			if ls_um> " " then
//				ls_des+=";;"+ls_um
//			end if
//			ds_righe.setitem(i, "descrizione", ls_des)
//		end if
//		//se mostra prezzi='N' tolgo i prezzi delle righe bolla
//		if as_mostra_prezzi='N' then
//			ds_righe.setitem(i, "prezzo_manifattura", 0)
//			ds_righe.setitem(i, "prezzo", 0)
//			ds_righe.setitem(i, "prezzo_complessivo", 0)
//			ds_righe.setitem(i, "tot_riga_val_doc", 0)
//			ds_righe.setitem(i, "tot_riga_val_az", 0)
//			ds_righe.setitem(i, "tot_riga_val_riga", 0)
//			ds_righe.setitem(i, "importo_manifattura", 0)
//			ds_righe.setitem(i, "importo_manifattura_val", 0)
//		end if
//	next
//	
//	li_ret=ds_righe.saveasascii("c:\nita\exp_doc\Riga_"+ls_doc+".txt")
//	li_max++
//	is_mail.s_allegato[li_max]="c:\nita\exp_doc\Riga_"+ls_doc+".txt"
//	
//else
//	messagebox("Attenzione!", "RIGA non trovata!")	
//end if
////recupera articoli e uc
//for i= 1 to li_righe
//	ll_id_art=ds_righe.getitemnumber(i, "id_articolo")
//	ds_articolo_2016.retrieve(ll_id_art)
//	ds_unita_confezione_2016.retrieve(ll_id_art)
//next
//li_ret=ds_articolo_2016.saveasascii("c:\nita\exp_doc\Art_"+ls_doc+".txt")
//li_max++
//is_mail.s_allegato[li_max]="c:\nita\exp_doc\Art_"+ls_doc+".txt"
//li_ret=ds_unita_confezione_2016.saveasascii("c:\nita\exp_doc\Uc_"+ls_doc+".txt")
//li_max++
//is_mail.s_allegato[li_max]="c:\nita\exp_doc\Uc_"+ls_doc+".txt"
//
//destroy ds_doc
//destroy ds_righe
//destroy ds_articolo_2016
//destroy ds_unita_confezione_2016
//
end subroutine

public subroutine of_send_mail (string as_cod_riga, string as_html, boolean ab_crea_log, boolean ab_debug);String  ls_server, ls_uid, ls_pwd, ls_invia_mail, ls_campo_mail,  ls_string_invio, ls_auth, ls_from_to, ls_allegati2
String ls_filename, ls_port, ls_encrypt, ls_errormsg,ls_destinatario, ls_testo
Integer li_max, i, li_pos, a, b, li_pos_2, li_destinatari_selezionati, li_FileNum
Boolean lb_html, lb_Return, lb_esiste_file
UInt lui_port
datetime ldt_data_ora_invio
string ls_send_email, ls_send_nome, ls_mittente, ls_nome_mittente, ls_allegati, ls_file_log, ls_contenuto_file
long ll_riga_testa, ll_riga_mail, ll_id_invio
SetPointer(HourGlass!)
datastore ds_dati_invio
ds_dati_invio=create datastore
ds_dati_invio.dataobject="d_invio"
ds_dati_invio.settransobject(sqlca)

//dw_1.accepttext()
ls_mittente=of_rec_dati_server(as_cod_riga, "mittente")
if messagebox("Attenzione!", ls_mittente+ " invierà la mail e i suoi allegati agli indirizzi selezionati: "+is_mail.s_email_1+", va bene?", Stopsign!, yesno!)=1 then

	ls_server=of_rec_dati_server(as_cod_riga, "smtp")
	If ls_server = "" Then
		MessageBox("Edit Error", &
			"You must specify Server on the Settings tab first!", StopSign!)
		Return
	End If
	
	//is_mail.s_oggetto=dw_1.getitemstring(1, "oggetto")
	
	If is_mail.s_oggetto= "" or isnull(is_mail.s_oggetto) Then
		MessageBox("Edit Error", &
		"Il campo Oggetto non può essere vuoto!", StopSign!)
		Return
	End If
	if left(is_mail.s_tipo_ae, 2)<> "TD" then
		
		If is_mail.s_testo = "" or isnull(is_mail.s_testo) Then
			MessageBox("Edit Error", "Il testo è richiesto!", StopSign!)
			Return
		End If
	
	end if
	
	//ls_indirizzo_mittente=wf_rec_dati_server("user_id")
	ls_nome_mittente=of_rec_dati_server(as_cod_riga,"nome_mittente")
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
		//sle_from_email.SetFocus()
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		Return
	End If
	
	
	If as_html='S' Then
//	//		is_mail.s_testo  = "<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
//		is_mail.s_testo += of_replace_all(is_mail.s_testo, "~r~n", "<br>") + "</h2>"
//		is_mail.s_testo += "</body></html>"
		ls_testo="<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
		ls_testo += of_replace_all(is_mail.s_testo, "~r~n", "<br>") + "</h2>"
	     ls_testo += "</body></html>"
		 is_mail.s_testo=ls_testo
		lb_html = True
	Else
		is_mail.s_testo = is_mail.s_testo
		lb_html = False
	End If
	
	lui_port= long(of_rec_dati_server(as_cod_riga, "porta"))
	
	// *** set email properties *********************
	gn_smtp.of_ResetAll()
	gn_smtp.of_SetPort(lui_port)
	gn_smtp.of_SetServer(ls_server)
	gn_smtp.of_SetLogFile(ab_crea_log, "smtp_logfile8.txt")
	gn_smtp.of_SetDebugViewer(ab_debug)
	gn_smtp.of_SetSubject(is_mail.s_oggetto)
	gn_smtp.of_SetBody(is_mail.s_testo, lb_html)
	gn_smtp.of_SetFrom(ls_mittente, ls_nome_mittente)
	
	//mando la copia a me stesso per verifica
	gn_smtp.of_AddAddress(ls_mittente, ls_nome_mittente)
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
		//sle_send_email.SetFocus()
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		Return
	End If

	if is_mail.s_tipo_ae> "TD" then //è un fat elettronica il destinatario è da recuperare in azienda, HUB_ae
		select hub_ae
		into :is_mail.s_email_1
		from dba.azienda
		;
		if isnull(is_mail.s_email_1) or is_mail.s_email_1<" " then
			messagebox("Attenzione!", "Non è specificato a quale HUB inviare la Fat-elettronica. Campo HUB_ae tabella AZIENDA! Invio interrotto!")
			return
		end if
	end if
	//aggiungo testa alla dw che memorizza i dati invio
	ll_riga_testa=ds_dati_invio.insertrow(0)
	ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_mittente)
	ds_dati_invio.setitem(ll_riga_testa, "data_ora", today())
	//ls_condominio=ds_dati_invio.getitemstring(ds_dati_invio.getrow(), "condominio")

	ds_dati_invio.setitem(ll_riga_testa, "destinatario", is_mail.s_email_1)
	if ds_dati_invio.update()= 1 then
		commit;
		ll_id_invio=ds_dati_invio.getitemnumber(ll_riga_testa, "id_invio")
		if ll_id_invio>0 then
				ls_send_email=""
				ls_send_nome=""
				ls_send_nome=is_mail.s_email_1
				ls_send_email=is_mail.s_email_1
				li_pos=pos(ls_mittente, ";")
				if li_pos>0 then //ci sono più indirizzi mail indicati nel campo mail: devo dividerli
					a=1
					do while li_pos>0
						ls_invia_mail=mid(ls_send_email, a, li_pos  - a)
						gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
						If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
							//sle_send_email.SetFocus()
							MessageBox("Edit Error", ls_errormsg, StopSign!)
							Return
						End If
						//memorizzo mail, nome, data_ora per il report ricevuta
						ll_riga_mail=ds_dati_invio.insertrow(0)
						ds_dati_invio.setitem(ll_riga_testa, "id_invio", ll_id_invio)
						ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_invia_mail)
						ds_dati_invio.setitem(ll_riga_testa, "destinatario", ls_send_nome)
						//ds_dati_invio.setitem(ll_riga_testa,"avviso", is_mail.s_testo)
						a=li_pos+1
						li_pos=pos(ls_send_email, ";", a)
						if li_pos<=0 then
							li_pos_2=pos(ls_send_email, "@", a)
							if li_pos_2>0 then  //c'è un altro indirizzo, recuperiamolo
								ls_invia_mail=mid(ls_send_email, a, len(ls_send_email) - a +1)
								gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
								If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
									//sle_send_email.SetFocus()
									MessageBox("Edit Error", ls_errormsg, StopSign!)
									Return
								End If
								ll_riga_mail=ds_dati_invio.insertrow(0)
								ds_dati_invio.setitem(ll_riga_testa, "id_invio", ll_id_invio)
								ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_invia_mail)
								ds_dati_invio.setitem(ll_riga_testa, "destinatario", ls_send_nome)
								//ds_dati_invio.setitem(ll_riga_testa,"avviso", is_mail.s_testo)
							end if
						end if
					loop
					
				else
					//gn_smtp.of_AddAddress(sle_send_email.text, sle_send_name.text)
					gn_smtp.of_AddAddress(ls_send_email, ls_send_nome)
					If Not gn_smtp.of_ValidEmail(ls_send_email, ls_errormsg) Then
						//sle_send_email.SetFocus()
						MessageBox("Edit Error", ls_errormsg, StopSign!)
						Return
					End If
					//ll_riga_mail=ds_dati_invio.insertrow(0)
					ds_dati_invio.setitem(ll_riga_testa, "id_invio", ll_id_invio)
					ds_dati_invio.setitem(ll_riga_testa, "mittente", ls_send_email)
					ds_dati_invio.setitem(ll_riga_testa, "destinatario", ls_send_nome)
					//ds_dati_invio.setitem(ll_riga_testa,"avviso", is_mail.s_testo)
				end if
				
		
			if ds_dati_invio.update()<>1 then
				MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA LISTA'. Contattare l'assistenza!")
				rollback;
			else
				commit;
			end if
	
	//	dw_1.setfilter("")
	//	dw_1.filter()
		//fine 2016-05-11
		
			// *** set Userid/Password if required **********
			//If of_getreg("Auth", "N") = "Y" Then
			if of_rec_dati_server(as_cod_riga, "auth")= "Y" then
				ls_uid = of_rec_dati_server(as_cod_riga, "user_id")//of_getreg("Userid", "")
				ls_pwd =of_rec_dati_server(as_cod_riga, "password")// of_getreg("Password", "")
				gn_smtp.of_SetLogin(ls_uid, ls_pwd)
			End If
			
			// *** aggiunge gli allegati **********************
			li_max = upperbound(is_mail.s_allegato)
			For i = 1 To li_max	
				ls_allegati2+= " -attach "+ is_mail.s_allegato[i]
				gn_smtp.of_AddAttachment(is_mail.s_allegato[i])
		//		ls_filename = lb_attachments.Text(i)
		//		gn_smtp.of_AddAttachment(ls_filename)
		//		ls_allegati+=ls_filename+";"
			Next
			ds_dati_invio.setitem(ll_riga_testa,"allegati", ls_allegati)
			// *** send the message *************************
			ls_encrypt = n_app.of_getreg("Encrypt", "None")
			ls_encrypt=of_rec_dati_server(as_cod_riga, "ssl")
			//guardo se la fat è già stata inviata
			if is_mail.s_tipo_ae> "TD" then
				select data_ora_invio
				into :ldt_data_ora_invio
				from dba.FE_invio
				where id_documento=:is_mail.l_id_doc
				;
				if string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")> string(datetime("2018-12-01"),"yyyy-mm-dd hh:mm")   then
					if messagebox("Attenzione!", "Il documento è stato già inviato una volta ("+ string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")+"). Vuoi inviarlo ancora lo stesso?", stopsign!, yesno!)=2 then
						return
					end if
				end if
			end if
			//fien controllo
			choose case ls_encrypt
				case "SSL"
					//lb_Return = gn_smtp.of_SendSSLMail()
					ls_auth= " -ssl "
			//lb_Return = gn_smtp.of_SendSSLMail()
				case "TLS"
					ls_auth= " -starttsl "
			
					//lb_Return = gn_smtp.of_SendTLSMail()
				case else
					//lb_Return = gn_smtp.of_SendMail()
			end choose
			ls_auth+= " -port "+string(lui_port)
			ls_auth+=  " -smtp "+ls_server
			if  of_rec_dati_server(as_cod_riga, "auth")= "Y" then ls_auth+=  " -auth "
			ls_auth+= " -user "+ls_uid+' -pass "'+ls_pwd+'"'
			ls_from_to=" -f "+ls_mittente+" -t "+is_mail.s_email_1
			
			//ls_allegati2=lower(ls_allegati2)  //valutare se tenerlo o meno ...
			//ls_string_invio="mailsend.exe -v "+ls_auth+ " -sub "+ls_oggetto +ls_from_to+ls_allegati2
			ls_file_log="c:\nita\log\logmail.log"
			 filedelete(ls_file_log)     //=false then MessageBox("Attenzione!", "File di log parziale NON cancellato!")
			if directoryexists("c:\nita\log") = false then
				CreateDirectory ( "c:\nita\log") 
			end if
			
			ls_string_invio="mailsend.exe -v "+ls_auth+ ' -sub "'+ is_mail.s_oggetto + '"' + ls_from_to + ls_allegati2 +" -log " + ls_file_log
			run(ls_string_invio, Minimized!)
			sleep(1)
			do while li_FileNum<=0
				li_FileNum = FileOpen("c:\nita\log\logmail.log", TextMode!)
				a++
				if a>100000 then 
					MessageBox("Attenzione!", "c:\nita\log\logmail.log NON trovato! Impossibile conoscere esito dell'invio della mail!")
					exit
				end if
			loop
			filereadex(li_FileNum, ls_contenuto_file)
			fileclose(li_FileNum)

			//lb_esiste_file=fileexists("c:\nita\tuttologmail.log")
			//if lb_esiste_file then
				li_FileNum=FileOpen("c:\nita\log\tuttologmail.log", TextMode!, Write!, LockWrite!, Append!)
				filewriteex(li_FileNum, ls_contenuto_file)
				fileclose(li_FileNum)
				
//			else
//				
//			end if
			
			if pos(ls_contenuto_file, "Mail sent successfully")>0 then
				lb_Return=true
			else
				lb_Return=false
			end if
			
			
			If lb_Return Then
				MessageBox("SendMail", "Mail successfully sent!")
				ds_dati_invio.setitem(ll_riga_testa, "invio_ok", "S")
				//memorizzo oggetto e testo per riproporli la prossima volta
				//SetProfileString ( "ermes.ini", "Ultima_Mail", "Oggetto", is_mail.s_oggetto)
				//SetProfileString ( "ermes.ini", "Ultima_Mail", "Testo", is_mail.s_testo )
				//SE è una Fat. elettronica aggiorno il cntatore e salvo i dati nella FE_invio
				if is_mail.s_tipo_ae> "TD" then
					f_salva_invio(is_mail.l_id_doc, ls_allegati)
					post close(parent)
				END IF
			Else
				MessageBox("SendMail Error", "Vedi file c:\nita\logmail.log")
				ds_dati_invio.setitem(ll_riga_testa, "invio_ok", "N")
			End If
			if ds_dati_invio.update()<>1 then
				MessageBox("Attenzione!", "Errore nel salvataggio ESITO INVIO. Contattare l'assistenza!")
				rollback;
			else
				commit;
			end if
		end if
	else
		rollback;
		MessageBox("Attenzione!", "Errore nel salvataggio del report di invio. Contattare l'assistenza!")
	end if
//else
//	//MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA'. Contattare l'assistenza!")
end if
end subroutine

public function string of_crea_pdf (long al_id_doc, string as_vedi_prezzo, string as_ordina);string ls_test, ls_path_libreria, ls_nome_report, ls_cod_prof, ls_num_doc, ls_oggetto, ls_art_mancanti
string dwsyntax, ls_path, ls_nome_file, ls_tipo_reg, ls_dich_intento
long ll_id_sog_com, ll_id_prof_doc, ll_id_ana
date ldt_data_doc
datastore ds_stampa
integer li_num_righe, li_ret, li_max

select p.codice, d.num_documento, d.data_documento, d.id_sog_commerciale, d.id_prof_documento, p.nome_report
	into :ls_cod_prof, :ls_num_doc, :ldt_data_doc, :ll_id_sog_com, :ll_id_prof_doc, :ls_nome_report
	from prof_documento p, documento d
	where d.id_prof_documento=p.id_prof_documento
	and d.id_documento=:al_id_doc;
	
	//se è karizia e rbol e > 31-12-2018  16-7-2018 devo cambiare report da cambiare la data con quella per partire
	ls_nome_report=f_scegli_report(al_id_doc, ls_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc)
//

select codice, libreria
into :ls_test, :ls_path_libreria
from conf_oggetti
where codice= :ls_nome_report;

if ls_path_libreria> " " then
	ls_oggetto=ls_cod_prof+" n. "+ls_num_doc+" del "+string(ldt_data_doc, "dd/mm/yyyy")
	dwsyntax = LibraryExport(ls_path_libreria, ls_nome_report, ExportDataWindow!)
	IF dwsyntax>"" THEN
		ds_stampa=create datastore
		ds_stampa.create(dwsyntax)
		ds_stampa.settransobject(sqlca)
		li_num_righe=ds_stampa.retrieve(al_id_doc)
		
		//090712 per samy: inserisco eventuali articoli mancanti al completamento del pronto
		ls_art_mancanti=f_controlla_pronto(al_id_doc)
		if ls_art_mancanti>" " then
			ds_stampa.modify("t_art_mancanti.text='"+ls_art_mancanti+"'")
		end if
		//fine 090712 per samy
	else
		messagebox("Errore!", "Dw di stampa "+ls_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE'")
//		return -1	
	end if
	select dir_output
	into :ls_path
	from orafo_par_sistema;
	if isnull(ls_path) or ls_path="" then
		messagebox("Attenzione!", "Specificare la directory di output nei parametri di sistema!")
//		return -1
	end if
	if right(ls_path, 1)<>"\" then ls_path+="\"
	ls_nome_file=ls_path+ls_cod_prof+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf"
	ls_nome_file=of_controlla_nome_file(ls_nome_file)
	//ls_test=ds_stampa.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
	select tipo_registro
	into :ls_tipo_reg
	from dba.registro r, dba.documento d
	where id_documento=:al_id_doc
	and r.id_registro=d.id_registro
	;
	if as_vedi_prezzo='S' then
		//16-03-2016 se  è una bolla (DV) e è stato attivato il flag "senza prezzo" rendo invisibile prezzo e importo
		if ls_tipo_reg='DV' then
			ds_stampa.Modify("c_prezzo.visible =1")
			ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=1")
		end if
	else
		ds_stampa.Modify("c_prezzo.visible =0")
		ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
	end if
	//dichiarazione intento nuova 2017-04-19
	If ls_tipo_reg='IV' then
		ll_id_ana=ds_stampa.getitemnumber(1, "id_anagrafica")
	//	ldt_data_doc=ds_stampa.getitemdate(1, "documento_data_documento")
		ls_dich_intento="Operazione non imponibile ai sensi dello Art. 8 2° C. D.P.R. 633 del 26/10/72 e modifiche successive  come  da Vs. dichiarazione di intento N. "&
		+f_dich_intento_2017(ll_id_ana, ldt_data_doc, "", al_id_doc)
		ds_stampa.modify("t_dich_intento.text='"+ls_dich_intento+"'") 
	end if
	 //fine 2017-04-19
	ds_stampa.Modify("Export.PDF.Method = Distill!")
	ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	ds_stampa.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
//ordino secondo il flag impostato nella finestra 13/10/2021 richiesta Samy per Karizia
	if as_ordina = "C" then
		ds_stampa.setsort("c_ordina_per_cliente")
		ds_stampa.sort()
	end if		
	li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		//ds_stampa.Modify("DataWindow.Print.printername = 'Acrobat PDFWriter'")
		//ds_stampa.print()
		//wf_crea_mail(ls_nome_file, ls_oggetto)
		messagebox("Errore!", "File PDF non generato!")	
	end if
	destroy(ds_stampa)
	li_max=upperbound(is_mail.s_allegato)
	if isnull(li_max) then li_max=0
	li_max++
	is_mail.s_allegato[li_max]=ls_nome_file
	return ls_nome_file
else
	messagebox("Errore!", "Dw di stampa "+ls_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE' ")
	return ""
end if
end function

public subroutine of_new_mailsender (string as_cod_riga, string as_html, boolean ab_crea_log, boolean ab_debug);//202608 si invia con smtp di powerbuilder (ora ce l'ha)
string ls_logfile, ls_mittente, ls_server, ls_errormsg, ls_testo, ls_encrypt, ls_uid, ls_pwd, ls_auth, ls_allegati, ls_destinatari_mail, ls_reply, ls_array_mail[], ls_array_null[]
string ls_cod_azienda, ls_gia_presente, ls_tmp_mail
long ll_dest_ok, ll_dest_scartati
s_split sl_split, sl_split_vuoto
integer li_rc, lui_port, I, li_idx, li_upperbound
SMTPClient lnv_smtp
lnv_smtp = CREATE SMTPClient


ls_mittente=of_rec_dati_server(as_cod_riga, "mittente")
if messagebox("Attenzione!", ls_mittente+ " invierà la mail e i suoi allegati agli indirizzi selezionati: "+is_mail.s_email_1+", va bene?", Stopsign!, yesno!)=1 then
	ls_server=of_rec_dati_server(as_cod_riga, "smtp")
	If ls_server = "" Then
		MessageBox("Edit Error", "You must specify Server on the Settings tab first!", StopSign!)
		DESTROY lnv_smtp
		Return
	End If
	//20260505 aggiungo l'invio a me stesso al mittente come ricevuta di spedizione.
//	if pos(is_mail.s_email_1, ls_mittente) = 0 then
//	    lnv_smtp.Message.AddBcc(ls_mittente)
//	end if
	
	

	If is_mail.s_oggetto= "" or isnull(is_mail.s_oggetto) Then
		MessageBox("Edit Error", "Il campo Oggetto non può essere vuoto!", StopSign!)
		DESTROY lnv_smtp
		Return
	End If
	
	select tipo_documento_ae into :is_mail.s_tipo_ae from dba.prof_documento p, dba.documento d
	where p.id_prof_documento=d.id_prof_documento and d.id_documento=:is_mail.l_id_doc;
	if left(is_mail.s_tipo_ae, 2)<> "TD" or isnull(is_mail.s_tipo_ae) then  //se NON è una fattura
		If is_mail.s_testo = "" or isnull(is_mail.s_testo) Then
			MessageBox("Edit Error", "Il testo è richiesto!", StopSign!)
			DESTROY lnv_smtp
			Return
		End If
	end if
	
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		DESTROY lnv_smtp
		Return
	End If
	lui_port= long(of_rec_dati_server(as_cod_riga, "porta"))
	ls_encrypt=of_rec_dati_server(as_cod_riga, "ssl")
	ls_uid = of_rec_dati_server(as_cod_riga, "user_id")
	ls_pwd =of_rec_dati_server(as_cod_riga, "password")
	ls_auth=of_rec_dati_server(as_cod_riga, "auth")
	
	If as_html='S' Then
		ls_testo="<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
		ls_testo += of_replace_all(is_mail.s_testo, "~r~n", "<br>") + "</h2>"
	     ls_testo += "</body></html>"
		 is_mail.s_testo=ls_testo
		lnv_smtp.Message.HTMLBody = ls_testo
	else
			ls_testo = is_mail.s_testo
	End If
	// Recupero gli indirizzi separati da ;
	// Split automatico
	li_idx=f_Split(is_mail.s_email_1, ";", ls_array_mail)
	FOR i = 1 TO upperbound(ls_array_mail)
		ls_array_mail[i] = trim(ls_array_mail[i])   //via spazi prima/dopo il ;
		if isnull(ls_array_mail[i]) or ls_array_mail[i]="" then continue
     // Aggiungo destinatario
	  if f_validemail(ls_array_mail[i], ls_errormsg) then  //20260322: questo da riportare in ogni indirizzo trovato... anche sotto su cc e poi su bcc..
    		lnv_smtp.message.addrecipient(ls_array_mail[i])
			ll_dest_ok = ll_dest_ok + 1                //20260905 conto quelli buoni
	  else
		  messagebox("Attenzione!", "Destinatario "+ls_errormsg)
			ll_dest_scartati = ll_dest_scartati + 1    //20260905 e quelli scartati
	  end if
	NEXT
	//CC
	ls_array_mail=ls_array_null  //20260707per ora annullo, poi provvedo ad integrare...
	li_idx=f_Split(is_mail.s_email_2, ";", ls_array_mail)
//	li_upperbound=upperbound(ls_array_mail)  //continuo domani
//	ls_array_mail[li_upperbound+1]="info@silverdreams.it"
	FOR i = 1 TO upperbound(ls_array_mail)
		ls_array_mail[i] = trim(ls_array_mail[i])   //via spazi prima/dopo il ;
		if isnull(ls_array_mail[i]) or ls_array_mail[i]="" then continue
	     // Aggiungo CC
		if f_validemail(ls_array_mail[i], ls_errormsg) then  //20260322: questo da riportare in ogni indirizzo trovato... anche sotto su cc e poi su bcc..
    		lnv_smtp.message.addcc(ls_array_mail[i])
		else
			messagebox("Attenzione!", "CC "+ls_errormsg)
	  end if
	NEXT
	//20260905 NIENTE DESTINATARIO = NIENTE INVIO.
	//Senza questo controllo si arrivava a Send() con zero destinatari e la funzione
	//diceva comunque "Inviata!". Due strade ci portavano: il campo indirizzi vuoto
	//(il FOR non gira nemmeno una volta) oppure tutti gli indirizzi scartati da
	//f_validemail, il cui errore veniva mostrato ma poi ignorato.
	//Sta qui, PRIMA del blocco BCC, apposta: cosi' la copia nascosta non viene nemmeno
	//aggiunta e non puo' partire una mail diretta soltanto a lei.
	if ll_dest_ok = 0 then
		if ll_dest_scartati > 0 then
			messagebox("Attenzione!", "La mail NON e' stata inviata."+&
				"~r~n~r~nNessuno dei "+string(ll_dest_scartati)+" indirizzi indicati e' valido:"+&
				"~r~n"+is_mail.s_email_1)
		else
			messagebox("Attenzione!", "La mail NON e' stata inviata: manca il destinatario."+&
				"~r~n~r~nIndicare almeno un indirizzo prima di inviare.")
		end if
		DESTROY lnv_smtp
		return
	end if
	//20260905 fine
	//BCC
	//....
	//20260905 COPIA NASCOSTA a info@silverdreams.it quando l'azienda e' Silver Dreams.
	//E' un BCC: il destinatario non la vede.
	//Il controllo e' sulla ragione sociale della tabella azienda (una riga sola),
	//come fa gia' of_invia_mail per escludere SILVERSTELLE.
	//Due forme perche' "SILVERDR" tutto attaccato NON si trova dentro
	//"SILVER DREAMS S.R.L.", che e' quello che c'e' scritto in tabella.
	ls_cod_azienda = ""
	select codice
	into   :ls_cod_azienda
	from   dba.azienda;
	if sqlca.sqlcode <> 0 or isnull(ls_cod_azienda) then ls_cod_azienda = ""
	//20260911 MAI in PEC: la PEC non ammette la copia nascosta. Aruba respinge il messaggio
	//("forward path non corrispondente a To e Cc") e la fattura non arriva al SdI.
	if  pos(upper(ls_cod_azienda), "SILVERDR") > 0 and upper(trim(as_cod_riga)) = "MAIL" then
		//non la aggiungo se l'indirizzo c'e' gia' fra i destinatari o in CC, se no
		//gli arriva due volte. I due campi vanno protetti dal null PRIMA di concatenarli:
		//in PowerScript concatenare un null annulla tutta la stringa.
		ls_gia_presente = is_mail.s_email_1
		if isnull(ls_gia_presente) then ls_gia_presente = ""
		ls_tmp_mail = is_mail.s_email_2
		if isnull(ls_tmp_mail) then ls_tmp_mail = ""
		ls_gia_presente = lower(ls_gia_presente + ";" + ls_tmp_mail)
		if pos(ls_gia_presente, "info@silverdreams.it") = 0 then
			if f_validemail("info@silverdreams.it", ls_errormsg) then
				lnv_smtp.message.addbcc("info@silverdreams.it")
			else
				messagebox("Attenzione!", "La copia nascosta a info@silverdreams.it NON e' stata aggiunta: "+ls_errormsg)
			end if
		end if
	end if
	//20260905 fine
	li_idx = upperbound(is_mail.s_allegato)
	// Allego direttamente i file
	For i = 1 To li_idx
	   lnv_smtp.Message.AddAttachment(is_mail.s_allegato[i])
		ls_allegati+=is_mail.s_allegato[i]+";"
	Next
	if right(ls_allegati, 1)=';' then ls_allegati=left(ls_allegati, len(ls_allegati) - 1)
	ls_reply=of_rec_dati_server(as_cod_riga, "rispondi_a")
	if isnull(ls_reply) then ls_reply=""

	lnv_smtp.Host         =  LS_SERVER
	lnv_smtp.Port         = lui_port                    // Prova prima 587 (STARTTLS)
	lnv_smtp.EnableTLS    = TRUE
	lnv_smtp.SecureProtocol = integer(ls_encrypt)                  // Auto (TLS 1.2/1.3)
	lnv_smtp.AuthType = integer(ls_auth)        // LOGIN
	lnv_smtp.UserName     = ls_uid
	lnv_smtp.Password     = ls_pwd
	lnv_smtp.Message.Subject  = is_mail.s_oggetto
	lnv_smtp.Message.TextBody=ls_testo   // FALSE = plain, TRUE = HTML
	if ls_reply > " " then lnv_smtp.message.addreplyto(ls_reply)
		
	lnv_smtp.Message.SetSender(ls_mittente, ls_mittente)  //il nome visualizzato sarà uguale alla mail: più in qua si raffina... 20260707
	
	// Abilita LOGGING dettagliato (importantissimo per debug!)
	if ab_crea_log then
		//20261126 64_nita2: log in c:\nita\log (come mailsend), C:\dati sui PC di Labella puo' non esserci
		if directoryexists("c:\nita\log") = false then CreateDirectory("c:\nita\log")
		ls_logfile = "c:\nita\log\smtp_log.txt"
		lnv_smtp.LogFile(ls_logfile, TRUE)            // TRUE = append, FALSE = overwrite
	end if

	li_rc = lnv_smtp.Send()
	
	IF li_rc = 1 THEN
	    MessageBox("OK", "Inviata!")
		 if pos(is_mail.s_tipo_ae, "TD")>0 then  //è una fattura 20251007 prima era uguale più o meno cambia poco
			 
			f_salva_invio(is_mail.l_id_doc, ls_allegati)
		END IF
	ELSE
	    MessageBox("Errore", "Cod: " + String(li_rc) , StopSign!)
	END IF
	DESTROY lnv_smtp
end if

//Example 2: This example sends an HTML-formatted email with the Cc, attachment, priority, encoding and proxy settings. In addition, the EnableTLS option is set to true, and the logging feature is enabled.

//Integer li_rc
//String ls_linkedResources, ls_contentID,ls_HTML
//SMTPClient lnv_SmtpClient

//lnv_SmtpClient = CREATE SMTPClient

////Sets the email-sender information     
//lnv_SmtpClient.Host = "smtp.gmail.com"
//lnv_SmtpClient.Port = 587
//lnv_SmtpClient.Username = "tester001@gmail.com"
//lnv_SmtpClient.password = "Mypassword001"
//lnv_SmtpClient.EnableTLS = True
//lnv_SmtpClient.SetProxy("192.168.168.10",8004)
//lnv_SmtpClient.LogFile("c:\mail.log")

////Sets the email message
//lnv_SmtpClient.Message.SetSender("tester001@gmail.com","Tester001")
//lnv_SmtpClient.Message.AddRecipient("tester002@gmail.com")
//lnv_SmtpClient.Message.AddCc("CcTester1@gmail.com" )
//lnv_SmtpClient.Message.AddAttachment("c:\image\test01.png")
//lnv_SmtpClient.Message.Subject = "SMTPClient Test Message"
//lnv_SmtpClient.Message.Priority = 2 //High
//lnv_SmtpClient.Message.Encoding = "UTF-8"

////Sets the HTML content to be sent
//ls_linkedResources = "c:\\image\\example.jpg"
//ls_HTML =  &
//"<html><body>" + "~r~n" + &
//"<p>This is the inline " + "~r~n" + &
//"<b>HTML</b> message of the e-mail.</p><br />" + "~r~n" + &
//"</body></html>"
//lnv_SmtpClient.Message.HTMLBody = ls_HTML

////Sends the email
//li_rc = lnv_SmtpClient.Send()

//IF li_rc = 1 THEN
//                Messagebox('SMTPClient','Mail sent successfully')
//ELSE
//                Messagebox('SMTPClient' ,'Email sending failed. Return ' + String(li_rc) + '.', StopSign!)
//END IF

//DESTROY lnv_SmtpClient

//Example 3: The example sends an email with OAuth2 authentication. For how to properly acquire the OAuth2 access token, refer to TokenRequest in Objects and Controls.

//Integer li_rc
//SMTPClient  lnv_SmtpClient

//lnv_SmtpClient = CREATE SMTPClient

////Sets the email message
//lnv_SmtpClient.Message.SetSender("tester001.appeon@gmail.com","Tester001")
//lnv_SmtpClient.Message.AddRecipient("tester002.appeon@gmail.com")
//lnv_SmtpClient.Message.Subject = "SMTPClient Test Message"
//lnv_SmtpClient.Message.TextBody = "SMTPClient example message body"

////Sets the email-sender information        
//lnv_SmtpClient.Host = "ssmtp.gmail.com"
//lnv_SmtpClient.Port = 587
//lnv_SmtpClient.EnableTLS = True
//lnv_SmtpClient.Username = "tester001.appeon@gmail.com"

////Model Authentication
//lnv_SmtpClient.XOAuth2AccessToken = "<token OAuth2 qui>"

////Sends the email
//li_rc = lnv_SmtpClient.Send()

//IF li_rc = 1 THEN
//                Messagebox('SMTPClient','Mail sent successfully')
//ELSE
//                Messagebox('SMTPClient' ,'Email sending failed. Return ' + String(li_rc) + '.', StopSign!)
//END IF

//DESTROY lnv_SmtpClient

//Example 5: The example sends the email asynchronously. Note: You can obtain the result of the async call in the OnSendFinished event.

//Long ll_handle
//n_smtpclient inv_SmtpClient

//inv_SmtpClient = CREATE n_smtpclient

////Sets the email-sender information        
//inv_SmtpClient.Host = "smtp.gmail.com"
//inv_SmtpClient.Port = 587
//inv_SmtpClient.Username = "tester001.appeon@gmail.com"
//inv_SmtpClient.password = "Mypassword001"
//inv_SmtpClient.EnableTLS = True

////Sets the email message
//inv_SmtpClient.Message.SetSender("tester001.appeon@gmail.com","Tester001")
//inv_SmtpClient.Message.AddRecipient("tester002.appeon@gmail.com")
//inv_SmtpClient.Message.Subject = "SMTPClient Test Message"
//inv_SmtpClient.Message.TextBody = "SMTPClient example message body"

////Sends the email asynchronously
//ll_handle = inv_SmtpClient.SendAsync()

//...
//DESTROY inv_SmtpClient

////Check the OnSendFinished EVENT for the email-sending result


end subroutine

on uo_mail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

