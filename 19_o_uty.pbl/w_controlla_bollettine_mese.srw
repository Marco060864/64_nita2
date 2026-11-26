forward
global type w_controlla_bollettine_mese from w_pop
end type
type dw_2 from udw_001 within w_controlla_bollettine_mese
end type
type cb_1 from commandbutton within w_controlla_bollettine_mese
end type
type cb_2 from commandbutton within w_controlla_bollettine_mese
end type
end forward

global type w_controlla_bollettine_mese from w_pop
integer width = 3685
integer height = 1988
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
end type
global w_controlla_bollettine_mese w_controlla_bollettine_mese

forward prototypes
public function string wf_estrai_nome_file (string as_path)
public subroutine wf_invia_mail (string as_path_file)
end prototypes

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

lm_mess.NoteText = "Queste bolletine sono da controllare!"
lm_mess.Subject = "Bollettine Appese"
ls_indirizzo_e_mail="marco.mozzorecchi@libero.it"  //"contabilita@silverdreams.it"
	
lm_recipient.Address = ls_indirizzo_e_mail
lm_recipient.Name = ls_indirizzo_e_mail
lm_recipient.RecipientType = mailTo!
lm_mess.Recipient[1] = lm_recipient


//ls_mail_cc="info@silverdreams.it"
//if ls_mail_cc>" " then
//	lm_recipient2.Address = ls_mail_cc
//	lm_recipient2.Name = ls_mail_cc
//	lm_recipient2.RecipientType = mailCC!
//	lm_mess.Recipient[2] = lm_recipient2
//end if	

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
//	insert into dba.invio_bol_controllo
	

	
end if
	
	//se il messaggio è stato correttamente inviato lo segno nel campo "da_stampare"
	//valori: S=stampato; N=NON stampato; E=inviato pdf via mail; C=Prezzi confermati; 
	//X=prezzi confermati e inviato via mail;
		//ora lo salvo nella idw_gen
//	ll_righe=idw_riga.rowcount()
//	for i= 1 to ll_righe

//		idw_riga.setitem(i, "riga_documento_da_stampare", ls_stampato)
//	next

end subroutine

on w_controlla_bollettine_mese.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_controlla_bollettine_mese.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.insertrow(1)
end event

type dw_1 from w_pop`dw_1 within w_controlla_bollettine_mese
integer x = 64
integer y = 40
integer width = 2075
integer height = 368
string dataobject = "d_correggi_bol_selezione"
end type

type dw_2 from udw_001 within w_controlla_bollettine_mese
integer x = 64
integer y = 460
integer width = 3529
integer height = 1340
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_controlla_bol_mese"
end type

type cb_1 from commandbutton within w_controlla_bollettine_mese
integer x = 2249
integer y = 72
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "carica"
end type

event clicked;date ldt_data_odierna, ldt_a_data, ldt_appoggio, ldt_da_data
long ll_id_registro
integer li_mese, li_anno

ldt_data_odierna=date(today())
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
	
	dw_2.retrieve(ll_id_registro,ldt_da_data, ldt_a_data)
	
end if
end event

type cb_2 from commandbutton within w_controlla_bollettine_mese
integer x = 2784
integer y = 116
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "crea pdf"
end type

event clicked;string ls_nome_file, ls_test, ls_email, ls_stampante
integer li_File, li_ret

ls_nome_file="c:\nita\controllo\CONTROLLO_BOL_"+string(today(), "dd_mm_yy_hh_mm_ss")+".pdf"

ls_test=dw_2.Modify("DataWindow.Print.documentname = '"+ls_nome_file+"'")
ls_test=dw_2.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")

dw_2.Modify ('DataWindow.Printer="Sybase DataWindow PS" ')
dw_2.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
dw_2.Modify("Export.PDF.Method = Distill!")
dw_2.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	
li_ret=dw_2.SaveAs(ls_nome_file, PDF!, FALSE)
IF LI_RET<> 1 THEN
	messagebox("Errore!", "File PDF non generato!")	
else
	wf_invia_mail(ls_nome_file)
end if
	
end event

