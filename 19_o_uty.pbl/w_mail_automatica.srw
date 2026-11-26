forward
global type w_mail_automatica from w_data_main
end type
type cb_1 from commandbutton within w_mail_automatica
end type
type st_time from statictext within w_mail_automatica
end type
type dw_1 from udw_base within w_mail_automatica
end type
type cb_2 from commandbutton within w_mail_automatica
end type
type cb_3 from commandbutton within w_mail_automatica
end type
type dw_2 from udw_base within w_mail_automatica
end type
type sle_ora from singlelineedit within w_mail_automatica
end type
type sle_stampante from singlelineedit within w_mail_automatica
end type
type cb_4 from commandbutton within w_mail_automatica
end type
type cb_5 from commandbutton within w_mail_automatica
end type
type uo_timer_1 from uo_timer within w_mail_automatica
end type
end forward

global type w_mail_automatica from w_data_main
integer width = 3950
integer height = 1864
windowstate windowstate = minimized!
cb_1 cb_1
st_time st_time
dw_1 dw_1
cb_2 cb_2
cb_3 cb_3
dw_2 dw_2
sle_ora sle_ora
sle_stampante sle_stampante
cb_4 cb_4
cb_5 cb_5
uo_timer_1 uo_timer_1
end type
global w_mail_automatica w_mail_automatica

type variables
uo_timer MyTimer
long il_cat_codifica, il_magazzino, il_id_sog
string is_bollo, IS_CHIUDI='N'

integer ii_fiscale
end variables

forward prototypes
public subroutine wf_crea_mail (string as_nome_attach, string as_oggetto, string as_e_mail)
public subroutine wf_crea_pdf (string as_mail)
end prototypes

public subroutine wf_crea_mail (string as_nome_attach, string as_oggetto, string as_e_mail);string ls_ret
long ll_row, ll_id_ana
string ls_destinatario, ls_des_prof,ls_azienda, ls_testo
string ls_indirizzo_e_mail, s_id
integer n, i, li_pos, li_File
long c_row

mailSession mSes
mailReturnCode mRet
mailMessage mMsg
mailFileDescription m_attach
mailrecipient lm_recipient

mSes = create mailSession


mRet = mSes.mailLogon(mailNewSession!)

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.')
		RETURN
END IF

this.height*=2.14



select a.rag_soc_1, az.rag_soc_1, a.id_anagrafica
into :ls_destinatario, :ls_azienda, :ll_id_ana
from  sog_commerciale s, anagrafica a, azienda az
where a.id_anagrafica=s.id_anagrafica
and s.id_sog_commerciale=:il_id_sog
and az.id_azienda=1;

ls_testo="Spett. "+ls_destinatario+"~r~nin allegato alla presente E-MAIL inviamo ~r~nSTAMPA della SITUAZIONE COMPONENTI"+&
+"~r~ndi cui all'oggetto in formato di documento PDF."+&
"~r~nDistinti saluti~r~n"+Upper(ls_azienda)

if as_e_mail > " " then
	ls_indirizzo_e_mail=as_e_mail
else
	select num_riferimento
	into :ls_indirizzo_e_mail
	from telefono
	where tipo='E'
	and id_anagrafica=:ll_id_ana;
end if
	

string mname, ls_nome

mMsg.Subject = as_oggetto

mMsg.NoteText = ls_testo


//if ls_indirizzo_e_mail='' or isnull(ls_indirizzo_e_mail) then
//	mSes.mailAddress (mMsg)
//else
//	mMsg.Recipient[1].name=ls_indirizzo_e_mail
//	mSes.mailAddress (mMsg)
//end if
//AGGIUNGO  +".PDF" 180608 PERCHé per una ragione che ancora non conosco
//la procedura crea due file pdf, uno con il nome giusto (pippo.pdf) e uno
//con doppia estensione (pippo.pdf.pdf) il bello è che il primo è un file
//di 0 byte, l'altro è l'effettivo PDF!!!!?????
m_attach.pathname=as_nome_attach +".pdf"
m_attach.filetype=mailAttach! 
if m_attach.pathname>'' then
	mMsg.AttachmentFile[1] = m_Attach
	//file di log email
	li_File=FileOpen("C:\start\logemail\logemail.txt", LineMode!, Write!, LockWrite!, Append!)
	filewrite(li_File, "File allegato: "+ m_attach.pathname)
	Fileclose(li_file)
else
	messagebox("Errore!", "File PDF non trovato")
end if


//mRet = mSes.mailResolveRecipient(ls_indirizzo_e_mail)

//IF mRet = mailReturnSuccess! THEN

    //MessageBox("Address", mname + " found.")
	 
//end if

lm_recipient.Address = ls_indirizzo_e_mail
ls_nome=dw_1.getitemstring(1, "nome")
if ls_nome> " " then
	lm_recipient.Name =ls_nome
else
	messagebox("Attenzione!", "Inserire Nome del destinatario di posta!")
	return
end if

lm_recipient.RecipientType = mailTo!
mMsg.Recipient[1] = lm_recipient



//mMsg.Recipient[1].recipientType=mailto!

//mMsg.Recipient[1].address=ls_indirizzo_e_mail
//mMsg.Recipient[1] = lm_recipient
//mSes.mailAddress (mMsg)

mRet = mSes.mailSend(mMsg)



IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail", 'Mail non inviata!')
	beep(10)
	RETURN
ELSE
	//file di log email
	li_File=FileOpen("C:\start\logemail\logemail.txt", LineMode!, Write!, LockWrite!, Append!)
	filewrite(li_File, "Mail Inviata ore: "+ string(now(), "hh:mm:ss"))
	Fileclose(li_file)
	is_chiudi='S'
	close(this)
	
END IF


mSes.mailLogoff()

DESTROY mSes




end subroutine

public subroutine wf_crea_pdf (string as_mail);string ls_nome_file, ls_test, ls_email, ls_stampante
integer li_File
select dir_output
into :ls_nome_file
from orafo_par_sistema;
if isnull(ls_nome_file) or ls_nome_file="" then
	messagebox("Attenzione!", "Specificare la directory di output nei parametri di sistema!")
	return
end if
if right(ls_nome_file, 1)<>"\" then ls_nome_file+="\"
ls_nome_file+="Stampa situazione Componenti"+string(today(), "dd-mm-yy")+".pdf"

ls_test=dw_2.Modify("DataWindow.Print.documentname = '"+ls_nome_file+"'")
ls_test=dw_2.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")

if ls_test="" then 
	ls_stampante=sle_stampante.text
	ls_test=dw_2.Modify("DataWindow.Print.printername = '"+ls_stampante+"'")
	dw_2.print()
	
	wf_crea_mail(ls_nome_file, "Stampa Situazione Componenti al "+string(today()), as_mail )
	//file di log email
	li_File=FileOpen("C:\start\logemail\logemail.txt", LineMode!, Write!, LockWrite!, Append!)
	filewrite(li_File, "File PDF: "+ ls_nome_file)
	Fileclose(li_file)
else
	messagebox("Errore!", "File PDF non generato!")	
end if
end subroutine

on w_mail_automatica.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_time=create st_time
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_2=create dw_2
this.sle_ora=create sle_ora
this.sle_stampante=create sle_stampante
this.cb_4=create cb_4
this.cb_5=create cb_5
this.uo_timer_1=create uo_timer_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_time
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.sle_ora
this.Control[iCurrent+8]=this.sle_stampante
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_5
end on

on w_mail_automatica.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_time)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_2)
destroy(this.sle_ora)
destroy(this.sle_stampante)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.uo_timer_1)
end on

event open;call super::open;date ld_a_data, ld_da_data
setredraw(false)

dw_1.settransobject(sqlca)
dw_1.retrieve()
timer(80)

//MyTimer = CREATE uo_timer
//
//MyTimer.Start(1)
//
setredraw(true)
ld_a_data=today()
ld_da_data=relativedate(ld_a_data, -7)
dw_1.setitem(1, "da_data", ld_da_data)
dw_1.setitem(1, "a_data", ld_a_data)

end event

event timer;call super::timer;string ls_ora, ls_result
time ltm_ora
ls_result = ProfileString ( "c:\start\cometa.ini", "PC", "Nome", "Error!" )
if ls_result='SERVER' then
	
	ltm_ora=Now()
	st_time.Text = String(ltm_ora, "hh:mm:ss")
	ls_ora=sle_ora.text
	if String(Now(), "hh:mm")> ls_ora then
		cb_1.triggerevent(clicked!)
		timer(0)
		close(this)
	end if
end if
end event

event ue_post_open;call super::ue_post_open;string ls_ora
ls_ora=dw_1.getitemstring(1, "ora")
if isnull(ls_ora) then ls_ora="17:30"
sle_ora.text=ls_ora
if now()> time(ls_ora) then 
	IS_CHIUDI='S'
	close(this)
end if

end event

event closequery;call super::closequery;IF IS_CHIUDI<> 'S' THEN
	IF MessageBox("Chiusura finestra di invio mail", "LA CHIUSURA DI QUESTA FINESTRA METTERA' FUORI USO"&
	+" LA MAIL AUTOMATICA! SEI SICURO DI VOLERLA CHIUDERE?", Question!, YesNo!) = 2 THEN
	
		RETURN 1
	
	ELSE
	
		RETURN 0
	
	END IF
END IF
end event

type p_msg_log from w_data_main`p_msg_log within w_mail_automatica
end type

type p_crescente from w_data_main`p_crescente within w_mail_automatica
end type

type p_decrescente from w_data_main`p_decrescente within w_mail_automatica
end type

type cb_1 from commandbutton within w_mail_automatica
integer x = 1989
integer y = 24
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;date ldt_inizio_es
long ll_titolo[], ll_test
integer li_file
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, lstr_param, ls_cod_magazzino, ls_mail
string ls_a_articolo, ls_da_articolo, ls_a_categoria, ls_da_categoria, ls_totali_doc, ls_ragsoc1
date ld_da_data,ld_a_data
s_param_articoli str_param
long ll_found

ll_found = dw_1.Find("base = 'S'", 1, dw_1.RowCount())

str_param.tipo_stampa=dw_1.getitemstring(ll_found, "tipo_stampa")
if isnull(str_param.tipo_stampa) then str_param.tipo_stampa=''


str_param.legato_fino=dw_1.getitemstring(ll_found, "legato_fino")
ls_totali_doc=dw_1.getitemstring(ll_found, "totali_doc")
if isnull(ls_totali_doc) then ls_totali_doc='N'

ls_da_cod_sog_comm=dw_1.Describe("Evaluate('LookUpDisplay(id_soggetto) ', " + "1" + ")")

//dw_1.getitemstring(1,"da_cod_sog_comm")
ls_a_cod_sog_comm=ls_da_cod_sog_comm
if ls_da_cod_sog_comm>ls_a_cod_sog_comm or (isnull(ls_da_cod_sog_comm) and ls_a_cod_sog_comm>'') then
	messagebox("Attenzione!", "Sog. Com. iniziale maggiore di quello finale!")
	return
end if
//lstr_param=dw_1.getitemstring(1, "st_art_sog")

ls_da_articolo=dw_1.getitemstring(1,"da_cod_art")
ls_a_articolo=dw_1.getitemstring(1,"a_cod_art")

if ls_da_articolo>'' then lstr_param=lstr_param+'Da Articolo: ' + ls_da_articolo + " "
if ls_a_articolo>'' then lstr_param=lstr_param+'Ad Articolo: ' + ls_a_articolo + " "

if ls_da_articolo>ls_a_articolo or (isnull(ls_da_articolo) and ls_a_articolo>'') then
	messagebox("Attenzione!", "Articolo iniziale maggiore di quello finale!")
	return
end if

//ls_a_categoria=dw_1.getitemstring(1,"a_cod_cat")
//ls_da_categoria=dw_1.getitemstring(1,"da_cod_cat")
//if ls_da_categoria>ls_a_categoria or (isnull(ls_da_categoria) and ls_a_categoria>'') then
//	messagebox("Attenzione!", "Causale iniziale maggiore di quella finale!")
//	return
//end if
//if ls_a_categoria>'' then lstr_param=lstr_param+"~r~n"+'Da Causale: ' + ls_a_categoria + " "
//if ls_da_categoria>'' then lstr_param=lstr_param+'A Causale: ' + ls_da_categoria + " "
//


ld_da_data=dw_1.getitemdate(ll_found,"da_data")
ld_a_data=dw_1.getitemdate(ll_found,"a_data")

if string(ld_da_data)>'' then lstr_param=lstr_param+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then lstr_param=lstr_param+'A Data: ' + string(ld_a_data) + " "



ldt_inizio_es=dw_1.getitemdate(ll_found, "data_inizio_esercizio")
If IsNull(ldt_inizio_es)  Then 
	messagebox("Attenzione!", "La data di inizio esercizio è obbligatoria!")
	return
end if

If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti partitari","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti partitari","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If

//STR_PARAM.cambio=dw_1.getitemnumber(1, "dest_id")
//if STR_PARAM.cambio>0 then 
//	select rag_soc_1
//	into :ls_ragsoc1
//	from destinazione
//	where id_destinazione=:STR_PARAM.cambio;
//	
//	lstr_param=lstr_param+'Destinazione: ' + ls_ragsoc1 + " "
//end if

str_param.solo_preziosi=dw_1.getitemstring(ll_found, "solo_preziosi")
//aggiunto 091209 per stmpe silverdreams
str_param.bollo=dw_1.getitemstring(ll_found, "bollo")
if str_param.bollo>" " then
	lstr_param=lstr_param+' Bollo: ' + str_param.bollo
end if


str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_cod_art=ls_da_articolo
str_param.a_cod_art=ls_a_articolo
str_param.da_CATEGORIA=ls_da_categoria
str_param.a_categoria = ls_a_categoria
str_param.inizio_es=ldt_inizio_es
str_param.totali_doc=ls_totali_doc
str_param.da_sog_comm=ls_da_cod_sog_comm
str_param.a_sog_comm=ls_a_cod_sog_comm
str_param.li_fiscale=dw_1.getitemnumber(1, "fiscale")
if isnull(str_param.li_fiscale) then
	str_param.li_fiscale=0
end if
str_param.ll_magazzino=dw_1.getitemnumber(ll_found, "magazzino")
if isnull(str_param.ll_magazzino) then 
	str_param.ll_magazzino=0
else
	ls_cod_magazzino=dw_1.Describe("Evaluate('LookUpDisplay(magazzino) ', " + "1" + ")")
	lstr_param=lstr_param+' Magazzino: ' + ls_cod_magazzino 
end if
str_param.tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
if isnull(str_param.tipo_stampa) then str_param.tipo_stampa=''
//ll_titolo[1]=dw_1.getitemnumber(1, "da_titolo")
//ll_titolo[2]=dw_1.getitemnumber(1, "a_titolo")
//if ll_titolo[1]>0 then
//	ll_titolo[2]=dw_1.getitemnumber(1, "a_titolo")
//	if isnull(ll_titolo[2]) then ll_titolo[2]=0
//	str_param.li_titolo[1]=ll_titolo[1]	
//	str_param.li_titolo[2]=ll_titolo[2]
//end if
str_param.id_cat_codifica=dw_1.getitemnumber(1, "id_cat_codifica")
lstr_param=lstr_param+' Cat.Codifica: ' + string(str_param.id_cat_codifica)

str_param.filtro=lstr_param
//str_param.ordinamento=dw_1.getitemstring(1, "per_causale")

//----------

//aggiunto 091209 silver
il_cat_codifica=str_param.id_cat_codifica
is_bollo=str_param.bollo
il_magazzino=str_param.ll_magazzino
ii_fiscale=str_param.li_fiscale
il_id_sog=dw_1.getitemnumber(ll_found, "id_soggetto")

if isnull(str_param.da_cod_art) then str_param.da_cod_art=' '
if isnull(str_param.a_cod_art) then str_param.a_cod_art='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if isnull(str_param.da_categoria) then str_param.da_categoria=' '
if isnull(str_param.a_categoria) or str_param.a_categoria <= " " then str_param.a_categoria='ZZZZZZZZ'
if isnull(str_param.filtro) then str_param.filtro='Nessun filtro'
	
//if upperbound(str_param.li_titolo)>0 then
//	id_titolo[1]=str_param.li_titolo[1]
//	id_titolo[2]=str_param.li_titolo[2]
//end if
	

dw_2.dataobject=str_param.tipo_stampa
				
str_param.filtro=right(str_param.filtro, len(str_param.filtro) - 1)

//is_per_causale=str_param.ordinamento
//il_destinazione=str_param.cambio
dw_2.settransobject(sqlca)
setredraw(false)
	ll_test=dw_2.retrieve(str_param.da_cod_art,str_param.a_cod_art,&
	str_param.da_sog_comm, str_param.a_sog_comm, &
	str_param.da_categoria, str_param.a_categoria, str_param.da_data,&
	str_param.a_data, str_param.inizio_es,str_param.filtro,str_param.totali_doc,&
	str_param.legato_fino, str_param.solo_preziosi, il_magazzino, ii_fiscale)
setredraw(true)
ls_mail=dw_1.getitemstring(ll_found, "E_mail")
//creo file di log per eventuali problemi
li_File=FileOpen("C:\start\logemail\logemail.txt", LineMode!, Write!, LockWrite!, Append!)
filewrite(li_File, String(Today(), "dd/mm/yyyy hh:mm:ss")+"- Righe Stampate: " +string(ll_test))
Fileclose(li_file)
WF_CREA_pdf(ls_mail)


end event

type st_time from statictext within w_mail_automatica
integer x = 224
integer y = 36
integer width = 617
integer height = 132
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
alignment alignment = center!
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_1 from udw_base within w_mail_automatica
integer x = 41
integer y = 192
integer width = 3749
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mail_configurazione"
boolean hscrollbar = true
end type

type cb_2 from commandbutton within w_mail_automatica
integer x = 891
integer y = 24
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "crea mail"
end type

event clicked;//string ls_ret
//long ll_row, ll_id_ana
//string ls_destinatario, ls_des_prof,ls_azienda, ls_testo
//string ls_indirizzo_e_mail, s_id
//
//
//mailSession mSes
//mailReturnCode mRet
//mailMessage mMsg
//integer n, i, li_pos
//long c_row
//
//
//mSes = create mailSession
//
//
//mRet = mSes.mailLogon(mailNewSession!)
//
//IF mRet <> mailReturnSuccess! THEN
//		MessageBox("Mail", 'Logon failed.')
//		RETURN
//END IF
//
//this.height*=2.14
//
//select p.descrizione, a.rag_soc_1, az.rag_soc_1, a.id_anagrafica
//into :ls_des_prof, :ls_destinatario, :ls_azienda, :ll_id_ana
//from prof_documento p, documento d, sog_commerciale s, anagrafica a, azienda az
//where a.id_anagrafica=s.id_anagrafica
//and s.id_sog_commerciale=d.id_sog_commerciale
//and p.id_prof_documento=d.id_prof_documento
//and d.id_documento=:il_id_doc
//and az.id_azienda=d.id_azienda;
//
//ls_testo="Spett. "+ls_destinatario+"~r~nin allegato alla presente E-MAIL inviamo "+&
//ls_des_prof+"~r~ndi cui all'oggetto in formato di documento PDF."+&
//"~r~nLa stampa di tale documento costituirà a tutti gli effetti "+&
//"~r~nsupporto cartaceo contabile fiscalmente valido."+&
//"~r~nDistinti saluti~r~n"+ls_azienda
//
//select num_riferimento
//into :ls_indirizzo_e_mail
//from telefono
//where tipo='E'
//and id_anagrafica=:ll_id_ana;
//
//if ls_indirizzo_e_mail='' or isnull(ls_indirizzo_e_mail) then
//	mSes.mailAddress (mMsg)
//	if upperbound(mMsg.Recipient) >0 then
//		ls_indirizzo_e_mail=mMsg.Recipient[1].name
//	end if
//else
//	mMsg.Recipient[1].name=ls_indirizzo_e_mail
//end if
//mSes.mailLogoff()
//
//DESTROY mSes
//
//dw_1.insertrow(1)
//dw_1.setitem(1, "destinatario", ls_indirizzo_e_mail)
//dw_1.setitem(1, "oggetto", as_oggetto)
//dw_1.setitem(1, "allegati", as_nome_attach)
//dw_1.setitem(1, "testo", ls_testo)
//
//
end event

type cb_3 from commandbutton within w_mail_automatica
integer x = 1271
integer y = 24
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
string text = "invia mail"
end type

event clicked;//string ls_indirizzo_e_mail
//mailSession mSes
//
//mailReturnCode mRet
//
//mailMessage mMsg, mmsg_2
//
//mailFileDescription m_attach
//integer n, i, li_pos
//long c_row
//
//
//mSes = create mailSession
//
//
//mRet = mSes.mailLogon(mailNewSession!)
//
//IF mRet <> mailReturnSuccess! THEN
//		MessageBox("Mail", 'Logon failed.')
//		RETURN
//END IF
//
//mMsg.Subject = dw_1.getitemstring(1, "oggetto")
//
//mMsg.NoteText = dw_1.getitemstring(1, "testo")
//
//ls_indirizzo_e_mail=dw_1.getitemstring(1, "destinatario")
//if ls_indirizzo_e_mail='' or isnull(ls_indirizzo_e_mail) then
//	mSes.mailAddress (mMsg)
//else
//	mMsg.Recipient[1].name=ls_indirizzo_e_mail
//end if
////AGGIUNGO  +".PDF" 180608 PERCHé per una ragione che ancora non conosco
////la procedura crea due file pdf, uno con il nome giusto (pippo.pdf) e uno
////con doppia estensione (pippo.pdf.pdf) il bello è che il primo è un file
////di 0 byte, l'altro è l'effettivo PDF!!!!?????
//m_attach.pathname=dw_1.getitemstring(1, "allegati")+".pdf"
//m_attach.filetype=mailAttach! 
//if m_attach.pathname>'' then
//	mMsg.AttachmentFile[1] = m_Attach
//else
//	messagebox("Errore!", "File PDF non trovato")
//end if
//
//mRet = mSes.mailSend(mMsg)
//
//
//
//IF mRet <> mailReturnSuccess! THEN
//		MessageBox("Mail", 'Mail non inviata!')
//		RETURN
//END IF
//
//mSes.mailLogoff()
//
//DESTROY mSes
end event

type dw_2 from udw_base within w_mail_automatica
integer x = 50
integer y = 572
integer width = 3753
integer height = 1156
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_data_tot_doc_silver_tb"
end type

event sqlpreview;call super::sqlpreview;string ls_sql, ls_titolo[],ls_cod_met[]
decimal{2} ld_titolo[]
integer i, li_pos
s_param_articoli s_lista_causali


	ls_sql=sqlsyntax
	if il_magazzino>0 then
		ls_sql=ls_sql + " and (riga_documento.id_locazione_1= "+string(il_magazzino)+" or riga_documento.id_locazione_2= "+string(il_magazzino)+")"
		
		
	end if
	if ii_fiscale=1 then
		ls_sql=ls_sql + " and not((caus_magazzino.mp_car_fiscali is null) and "&
		+"(caus_magazzino.mp_scar_fiscali is null) and (caus_magazzino.mp_val_caricato is null) and "&
		+"(caus_magazzino.mp_val_scaricato is null))"
	end if
//	if upperbound(id_titolo)>0 then
//		select t.titolo, m.codice
//		into :ld_titolo[1], :ls_cod_met[1]
//		from orafo_titolo t, orafo_metallo m
//		where t.id_titolo=:id_titolo[1]
//		and m.id_metallo=t.id_metallo;
//		if sqlca.sqlcode<>0 then
//			messagebox("Errore", "Titolo1 non recuperato correttamente:sqlpreview, dw_1, 24")
//			return
//		end if
//		select t.titolo, m.codice
//		into :ld_titolo[2], :ls_cod_met[2]
//		from orafo_titolo t, orafo_metallo m
//		where t.id_titolo=:id_titolo[2]
//		and m.id_metallo=t.id_metallo;
//		if sqlca.sqlcode<>0 then
//			messagebox("Errore", "Titolo2 non recuperato correttamente:sqlpreview, dw_1, 33")
//			return
//		end if
//		ls_titolo[1]=string(ld_titolo[1])
//		ls_titolo[2]=string(ld_titolo[2])
//		
//		for i= 1 to 2
//			li_pos=pos(ls_titolo[i], ",")
//			if li_pos>0 then
//				ls_titolo[i]=replace(ls_titolo[i], li_pos, 1, ".")
//			end if
//		next
//		ls_sql=ls_sql + " and orafo_titolo.titolo>= "+ls_titolo[1]&
//		+" and orafo_titolo.titolo<= "+ls_titolo[2]+" and orafo_metallo.codice= '"+ls_cod_met[1]+"'"
//		
//		
//	end if
//	if is_per_causale='S' then
//		open(w_sel_causali_st)
//		s_lista_causali=message.powerobjectparm
//		if isvalid(s_lista_causali) then
//			for i=1 to upperbound(s_lista_causali.li_titolo)
//				if i=1 then
//					ls_sql+=" and (caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
//				else
//					ls_sql+=" or caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
//				end if
//			next
//			ls_sql+=")"
//		else
//			close(parent)
//			return
//		end if
//	end if
//	if il_destinazione>0 then
//		ls_sql+=" and (documento.id_destinazione= "+string(il_destinazione)+")"
//	end if
	if il_id_sog>0 then
		ls_sql+=" and (documento.id_sog_commerciale= "+string(il_id_sog)+")"
	end if
	//aggiunto 091209 per silverdreams filtro per bollo articolo (campo riga_documento.sigla_prezzo)
	if is_bollo> " " then
		ls_sql+=" and (riga_documento.sigla_prezzo= '"+is_bollo+"') "
	end if
	//aggiunto 091209 per silverdreams filtro per cat-codifica articolo
	if il_cat_codifica> 0 then
		ls_sql+=" and (articolo.id_cat_codifica= "+string(il_cat_codifica) +")"
	end if
	
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if

end event

type sle_ora from singlelineedit within w_mail_automatica
integer x = 2560
integer y = 32
integer width = 283
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "16:32"
borderstyle borderstyle = stylelowered!
end type

type sle_stampante from singlelineedit within w_mail_automatica
integer x = 2944
integer y = 36
integer width = 850
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Acrobat PDFWriter"
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_mail_automatica
boolean visible = false
integer x = 1659
integer y = 32
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
string text = "NEW"
end type

event clicked;//altro
mailsession lms_sess
mailmessage lm_mess
mailrecipient lm_recipient
mailFileDescription lmf_file
mailreturncode lmc_rc
string ls_nome_file


lmf_file.FileType = mailAttach!
ls_nome_file+="Stampa situazione Componenti"+string(today(), "dd-mm-yy")+".pdf"

lmf_file.FileName = ls_nome_file
lmf_file.PathName = "c:\start\pdf\"+ls_nome_file

lm_mess.NoteText = "this my report."
lm_mess.Subject = "report may2004"
lm_mess.Attachmentfile[1] = lmf_file

lm_recipient.Address = "m.mozzorecchi@email.it"
lm_recipient.Name = "Mozzorecchi, Marco"
lm_recipient.RecipientType = mailTo!
lm_mess.Recipient[1] = lm_recipient

lms_sess = create mailsession
lmc_rc = lms_Sess.mailLogon()
lmc_rc = lms_Sess.mailSend(lm_Mess)
IF lmc_rc <> mailReturnSuccess! THEN
        MessageBox("Error", "Error on Send")
END IF

lmc_rc = lms_sess.mailLogoff()
DESTROY lms_sess
end event

type cb_5 from commandbutton within w_mail_automatica
boolean visible = false
integer x = 846
integer y = 104
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
string text = "none"
end type

event clicked;OLEObject mailman 
OLEObject eMail
integer li_return

mailman = Create OLEObject
eMail   = Create OLEObject

li_return = mailman.ConnectToNewObject("ChilkatMail2.ChilkatMailMan2.1")
If li_return <> 0 Then
   Destroy mailman 
   Return 98       
End if

li_return = eMail.ConnectToNewObject("ChilkatMail2.ChilkatEMail2.1")    
If li_return <> 0 Then
   Destroy eMail
   Return 97      
End if

mailman.UnlockComponent("unlock-code")

mailman.SmtpHost = "smtp.mail.com"
mailman.SmtpPort = 25

eMail.AddTo("Support", "support@chilkatsoft.com")
eMail.Subject = "This is the email subject"
eMail.Body = "This is the email body."
eMail.From = "joe.programmer@somewhere.com"

mailman.SendEmail(eMail)


end event

type uo_timer_1 from uo_timer within w_mail_automatica descriptor "pb_nvo" = "true" 
end type

event timer;call super::timer;w_mail_automatica.st_time.Text = String(Now(), "hh:mm")

if String(Now(), "hh:mm")> "09:10" then
	cb_1.triggerevent("clicked!")
end if
end event

on uo_timer_1.create
call super::create
end on

on uo_timer_1.destroy
call super::destroy
end on

