forward
global type w_invia_mail_old from w_data_main
end type
type dw_1 from udw_base within w_invia_mail_old
end type
type cb_invia from commandbutton within w_invia_mail_old
end type
end forward

global type w_invia_mail_old from w_data_main
integer width = 2153
integer height = 936
dw_1 dw_1
cb_invia cb_invia
end type
global w_invia_mail_old w_invia_mail_old

forward prototypes
public subroutine wf_carica ()
public subroutine wf_invia_mail ()
end prototypes

public subroutine wf_carica ();integer i
string ls_oggetto, ls_destinatario
string ls_allegati[], ls_testo, ls_allega
ls_destinatario='info@fantasy444ar.com'
ls_oggetto="Fiera "+string(today())
ls_allegati[1]="c:\temp\dafiera\f_articolo.txt;"
ls_allegati[2]="c:\temp\dafiera\f_cliente.txt;"
ls_allegati[3]="c:\temp\dafiera\f_art_lega.txt;"
ls_allegati[4]="c:\temp\dafiera\f_ordine.txt;"
ls_allegati[5]="c:\temp\dafiera\f_riga_ordine.txt;"
ls_allegati[6]="c:\temp\dafiera\f_art_lunghezza.txt;"
ls_allegati[7]="c:\temp\dafiera\f_riga_ordine_nota.txt;"
ls_allegati[8]="c:\temp\dafiera\f_riga_ordine_lega.txt;"
ls_testo="In allegato i files per il passaggio dati."
for i=1 to upperbound(ls_allegati)
	ls_allega+=ls_allegati[i]
next
dw_1.setitem(1, "destinatario", ls_destinatario)
dw_1.setitem(1, "allegati", ls_allega)
dw_1.setitem(1, "oggetto", ls_oggetto)
dw_1.setitem(1, "testo", ls_testo)

end subroutine

public subroutine wf_invia_mail ();string ls_indirizzo_e_mail, ls_attach
integer li_pos, li_test
mailSession mSes

mailReturnCode mRet

mailMessage mMsg, mmsg_2

mailFileDescription m_attach
integer n, i, ll_inizio
long c_row

// Crea una sessione di posta

mSes = create mailSession

// Log on to the session

mRet = mSes.mailLogon(mailNewSession!)

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.')
		RETURN
END IF

mMsg.Subject = dw_1.getitemstring(1, "oggetto")

mMsg.NoteText = dw_1.getitemstring(1, "testo")

ls_indirizzo_e_mail=dw_1.getitemstring(1, "destinatario")
if ls_indirizzo_e_mail='' or isnull(ls_indirizzo_e_mail) then
	mSes.mailAddress (mMsg)
else
	li_pos=0
	li_test=pos(ls_indirizzo_e_mail, ";", li_pos+1)
	
	do  while li_test>0
		i++
		mMsg.Recipient[i].address=mid(ls_indirizzo_e_mail, li_pos+1, li_test - 1)
		li_pos=li_test
		li_test=pos(ls_indirizzo_e_mail, ";", li_pos+1)
	loop 
	mMsg.Recipient[i+1].address=mid(ls_indirizzo_e_mail, li_pos+1, len(ls_indirizzo_e_mail) - li_pos)	
		
	//mMsg.Recipient[1].name=ls_indirizzo_e_mail
end if

li_pos=0
i=0
ls_attach=dw_1.getitemstring(1, "allegati")
DO 
	ll_inizio=li_pos+1
	i++
	li_pos=pos(ls_attach, ";" ,ll_inizio) 
	if li_pos>0 then
		m_attach.pathname=mid(ls_attach, ll_inizio, li_pos - ll_inizio)
		mMsg.AttachmentFile[i] = m_Attach
	end if
loop while li_pos>0
mRet = mSes.mailSend(mMsg)



IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Mail non inviata!')
		RETURN
END IF

mSes.mailLogoff()

DESTROY mSes
end subroutine

on w_invia_mail_old.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_invia=create cb_invia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_invia
end on

on w_invia_mail_old.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_invia)
end on

event open;call super::open;string ls_allegato

dw_1.insertrow(0)

ls_allegato=message.stringparm

dw_1.setitem(1, "allegati", ls_allegato+";")

end event

type p_msg_log from w_data_main`p_msg_log within w_invia_mail_old
end type

type p_crescente from w_data_main`p_crescente within w_invia_mail_old
end type

type p_decrescente from w_data_main`p_decrescente within w_invia_mail_old
end type

type dw_1 from udw_base within w_invia_mail_old
integer x = 18
integer y = 16
integer width = 2057
integer height = 792
boolean bringtotop = true
string dataobject = "d_posta_ex"
boolean vscrollbar = false
end type

event clicked;call super::clicked;if dwo.name="destinatario_sw" then
mailSession mSes
//
mailReturnCode mRet
//
mailMessage mMsg
// Crea una sessione di posta
mSes = create mailSession
// Log on to the session
mRet = mSes.mailLogon(mailNewSession!)

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.')
		RETURN
END IF
	mSes.mailAddress(mMsg)
	if upperbound(mMsg.Recipient) >0 then
		dw_1.setitem(1, "destinatario", mMsg.Recipient[1].name)
	end if
mSes.mailLogoff()

DESTROY mSes
	
end if
end event

type cb_invia from commandbutton within w_invia_mail_old
integer x = 1545
integer y = 36
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
string text = "Invia"
end type

event clicked;wf_invia_mail()
close(parent)
end event

