forward
global type w_app_frame from w_mdi_frame
end type
end forward

global type w_app_frame from w_mdi_frame
string title = "NITATRON"
string menuname = "m_app_frame"
long backcolor = 67108864
string icon = "C:\nita\icone\nita.ico"
end type
global w_app_frame w_app_frame

type variables

end variables

forward prototypes
public subroutine wf_controlla_bol ()
public subroutine wf_invia_mail (string as_path_file)
public function string wf_estrai_nome_file (string as_path)
public function string uf_extract_path (string url)
public function string uf_extract_exe_name (string url)
end prototypes

public subroutine wf_controlla_bol ();date ldt_data_odierna, ldt_a_data, ldt_appoggio, ldt_da_data, ldt_invio
long ll_id_registro
integer li_mese, li_anno
datastore ds_bol_appese
	string ls_nome_file, ls_test, ls_email, ls_stampante
integer li_File, li_ret


ldt_data_odierna=date(today())
select invio
into :ldt_invio
from dba.invio_bol_controllo
where invio=:ldt_data_odierna
;
if ldt_invio=ldt_data_odierna then return

ds_bol_appese=create datastore
ds_bol_appese.dataobject="d_controlla_bol_mese"
ds_bol_appese.settransobject(sqlca)

li_mese=month(ldt_data_odierna)
li_anno=year(ldt_data_odierna)
ldt_appoggio=date(li_anno, li_mese,1)
ldt_a_data=relativedate(ldt_appoggio, -1)

if li_mese=1 then
	li_mese=12
	li_anno=li_anno - 1
else
	li_mese --
end if


ldt_da_data=date(li_anno, li_mese,1 )
select id_registro
into :ll_id_registro
from registro r, esercizio e
where id_mod_registro=54
and e.id_esercizio=r.id_esercizio
and e.data_fine>=:ldt_a_data
and e.data_inizio<=:ldt_a_data
;
if ll_id_registro>0 then
	
	ds_bol_appese.retrieve(ll_id_registro,ldt_da_data, ldt_a_data)


	ls_nome_file="c:\nita\controllo\CONTROLLO_BOL_"+string(today(), "dd_mm_yy_hh_mm_ss")+".pdf"
	
	ls_test=ds_bol_appese.Modify("DataWindow.Print.documentname = '"+ls_nome_file+"'")
	ls_test=ds_bol_appese.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
	
	ds_bol_appese.Modify ('DataWindow.Printer="Sybase DataWindow PS" ')
	ds_bol_appese.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	ds_bol_appese.Modify("Export.PDF.Method = Distill!")
	ds_bol_appese.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
		
	li_ret=ds_bol_appese.SaveAs(ls_nome_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		messagebox("Errore!", "File PDF non generato!")	
	else
		wf_invia_mail(ls_nome_file)
		
	end if
end if
end subroutine

public subroutine wf_invia_mail (string as_path_file);string ls_allegato, ls_allegati[], ls_indirizzo_e_mail, ls_mail_cc, ls_data
date ldt_data
integer a, li_pos, b

mailsession lms_sess
mailmessage lm_mess
mailrecipient lm_recipient, lm_recipient2, lm_recipient3
mailFileDescription lmf_file
mailreturncode lmc_rc


ls_allegato=as_path_file
li_pos=pos(ls_allegato, ";",a )
if li_pos=0 then 
	ls_allegati[1]=ls_allegato
else
	do while li_pos >0 or len(ls_allegato) > a
		b++
		if li_pos=0 then 
			li_pos=len(ls_allegati[b - 1]) +1
			ls_allegati[b]=mid(ls_allegato, a, li_pos - 1)
			exit
		end if
		ls_allegati[b]=mid(ls_allegato, a, li_pos - a)	
		a=li_pos+1
		li_pos=pos(ls_allegato, ";",a )
	loop
end if
a=0
for a=1 to upperbound(ls_allegati)
	lmf_file.FileType = mailAttach!
		
	lmf_file.PathName = ls_allegati[a]
	lmf_file.FileName = wf_estrai_nome_file(lmf_file.PathName)
		
	lm_mess.Attachmentfile[a] = lmf_file
next

lm_mess.NoteText = "Queste bollettine sono da controllare!"
lm_mess.Subject = "Bollettine Appese"
ls_indirizzo_e_mail="contabilita@silverdreams.it" //"marco.mozzorecchi@libero.it"
	
lm_recipient.Address = ls_indirizzo_e_mail
lm_recipient.Name = ls_indirizzo_e_mail
lm_recipient.RecipientType = mailTo!
lm_mess.Recipient[1] = lm_recipient


ls_mail_cc="info@silverdreams.it"
if ls_mail_cc>" " then
	lm_recipient2.Address = ls_mail_cc
	lm_recipient2.Name = ls_mail_cc
	lm_recipient2.RecipientType = mailCC!
	lm_mess.Recipient[2] = lm_recipient2
end if	

lms_sess = create mailsession
lmc_rc = lms_Sess.mailLogon()


lmc_rc = lms_Sess.mailSend(lm_mess)
IF lmc_rc <> mailReturnSuccess! THEN
	choose case lmc_rc
		case mailReturnFailure!
				MessageBox("mailreturnfailure", "Error on Send")
		case mailReturnInsufficientMemory!
				MessageBox("mailReturnInsufficientMemory", "Error on Send")
		case mailReturnLoginFailure!
			MessageBox("mailReturnLoginFailure", "Error on Send")
		case mailReturnUserAbort!
			MessageBox("mailReturnUserAbort", "Error on Send")
		case mailReturnDiskFull!
			MessageBox("mailReturnDiskFull", "Error on Send")
		case mailReturnTooManySessions!
			MessageBox("mailReturnTooManySessions", "Error on Send")
		case mailReturnTooManyFiles!
			MessageBox("mailReturnTooManyFiles", "Error on Send")
		case mailReturnTooManyRecipients!
			MessageBox("mailReturnTooManyRecipients", "Error on Send")
		case mailReturnUnknownRecipient!
			MessageBox("mailReturnUnknownRecipient", "Error on Send")
		case mailReturnAttachmentNotFound!
			MessageBox("mailReturnAttachmentNotFound", "Error on Send")
	//	case null
		//	MessageBox("mailReturnNULL", "Error on Send un argomento è nullo!")
	end choose
	
	
   MessageBox("Error", "Error on Send")	
else
	ldt_data=date(today())
	insert into dba.invio_bol_controllo (invio)
	values(:ldt_data);
	if sqlca.sqlnrows>0 then
		commit;
	else
		messagebox("Errore!", "Invio non salvato!")	
		rollback;
	end if
end if
	
end subroutine

public function string wf_estrai_nome_file (string as_path);string ls_nome_file
integer li_pos

li_pos=lastpos(as_path, "\")
if li_pos>0 then
	ls_nome_file=right(as_path, len(as_path) - li_pos)
else
	ls_nome_file=as_path
end if
return ls_nome_file
end function

public function string uf_extract_path (string url);long ll_last_slash, ll_pos

ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(url,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0
return mid(url,1,ll_last_slash)
end function

public function string uf_extract_exe_name (string url);long ll_last_slash, ll_pos

ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(url,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0
return mid(url,ll_last_slash+1, len(url) - ll_last_slash - 4)
end function

on w_app_frame.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_app_frame" then this.MenuID = create m_app_frame
end on

on w_app_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//if isvalid(w_mail_automatica) then close(w_mail_automatica)
end event

event open;call super::open;//string ls_apri_tracciamento, ls_path,  ls_file_ini,  ls_minuti
//integer li_minuti
//ls_path=""
//GetModuleFileNameA(0, ls_path, 256) 
//ls_file_ini ="C:\nita\"+uf_extract_exe_name(ls_path)+".ini"
//ls_apri_tracciamento = ProfileString (ls_file_ini , "TRACCIAMENTO", "APRI", "Error!" ) 
//if ls_apri_tracciamento="S" then
//	ls_minuti = ProfileString ( ls_file_ini,  "TRACCIAMENTO", "INTERVALLO_LETTURA", "Error!" ) 
//	li_minuti=integer (ls_minuti)
//	openwithparm(w_tracciamento_produzione, li_minuti)
//end if




//string ls_azienda
//date ldt_oggi
//
//select codice
//into :ls_azienda
//from dba.azienda
//;
//if ls_azienda='SILVERDR' then 
//	ldt_oggi=date(today())
//	if day(ldt_oggi)= 15 then
//		wf_controlla_bol()
//	end if
//end if
end event

