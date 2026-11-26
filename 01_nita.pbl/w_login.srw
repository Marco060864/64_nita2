forward
global type w_login from window
end type
type cb_1 from commandbutton within w_login
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
type sle_password from singlelineedit within w_login
end type
type cb_ok from commandbutton within w_login
end type
type ddlb_utente from dropdownlistbox within w_login
end type
end forward

global type w_login from window
integer x = 832
integer y = 364
integer width = 1253
integer height = 552
boolean titlebar = true
string title = "Login"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 134217752
string icon = "C:\nita\icone\nita.ico"
integer animationtime = 50
event ue_close ( )
event ue_validazione ( )
cb_1 cb_1
st_2 st_2
st_1 st_1
sle_password sle_password
cb_ok cb_ok
ddlb_utente ddlb_utente
end type
global w_login w_login

type variables
string is_database, is_dbms
integer  ii_count
s_login is_ritorno


end variables

event ue_close;CloseWithReturn(This, is_ritorno)
end event

event ue_validazione();string		sl_pass_found, ls_winxp
integer		il_ret_value, il_idutente, il_idmenu
boolean		bl_pass

bl_pass = FALSE
ii_count = ii_count + 1
sle_password.SetFocus()

SELECT utenti.UT_Password, utenti.ID_utenti, utenti.ID_menu, utenti.winxp
	INTO :sl_pass_found, :il_idutente, :il_idmenu, :ls_winxp
	FROM utenti
	WHERE utenti.UT_Utente = :ddlb_utente.text
	USING SQLCA ;	
	
if SQLCA.SQLCode = 100 then
	MessageBox("Risultato della Login", "Utente non Trovato")
elseif SQLCA.SQLCode < 0 then
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
else
	//Validazione della Password
	IF f_cripting(sl_pass_found) = sle_password.text then
		bl_pass = TRUE
	else
		IF ii_count = 2 then
			MessageBox("Login.","Password Errata.~rUltimo Tentativo.")
		else
			MessageBox("Login.","Password Errata.")
		end if
	end if
	IF bl_pass then
		//	Il confronto con la password ha dato esito positivo
		is_ritorno.i_successo = 0
		is_ritorno.i_idutente = il_idutente
		is_ritorno.i_idmenu = il_idmenu
		u_freddie.ii_id_utenti=il_idutente
		is_ritorno.s_utente = ddlb_utente.text
		is_ritorno.s_winxp = ls_winxp ///winxp		
		TriggerEvent("ue_close")
	else
		//	Il confronto con la password ha dato esito positivo
		IF ii_count >= 3 THEN
			//	Esce al quarto tentativo
			is_ritorno.i_successo = -1
			is_ritorno.i_idutente = -1
			is_ritorno.i_idmenu = -1
			is_ritorno.s_utente = ""
			is_ritorno.s_winxp = ls_winxp ///winxp					
			TriggerEvent("ue_close")
		END IF
	END IF
End If

end event

on w_login.create
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_password=create sle_password
this.cb_ok=create cb_ok
this.ddlb_utente=create ddlb_utente
this.Control[]={this.cb_1,&
this.st_2,&
this.st_1,&
this.sle_password,&
this.cb_ok,&
this.ddlb_utente}
end on

on w_login.destroy
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.cb_ok)
destroy(this.ddlb_utente)
end on

event open;string ls_utenti
string	ls_select, ls_name, ls_add, ls_menu

ii_count = 0
// se connessione corretta eseguo determinate cose
SELECT  utenti.ut_utente
	INTO :ls_utenti
	FROM utenti

	USING SQLCA ;

if SQLCA.SQLCode = 100 then
	MessageBox("Risultato della Login", &
		"Utente non Trovato")
elseif SQLCA.SQLCode > 0 then
	MessageBox("Database Error", &
		SQLCA.SQLErrText, Exclamation!)
End If
// Load the ddlb with customer names from the customer table.
declare lcur_utente cursor for
  SELECT distinct ut_utente
    FROM utenti, menu
	 WHERE ( utenti.id_menu = menu.id_menu )   ;
open lcur_utente;

if sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
	return
end if 

ddlb_utente.SetRedraw(false)

do while sqlca.sqlcode = 0
	fetch lcur_utente into :ls_name ;
	if sqlca.sqlcode = 0 then
		ls_add = ls_name
		ddlb_utente.AddItem (ls_add)
	elseif sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
		return
	else
		exit
	end if
loop
ddlb_utente.text =""
ddlb_utente.SetRedraw(true)

close lcur_utente;

// centra su video la finestra
u_freddie.center_window(this)

end event

event close;TriggerEvent("ue_close")
end event

event key;IF key = KeyEscape! then
	is_ritorno.i_successo = -1
	is_ritorno.i_idutente = -1
	is_ritorno.i_idmenu = -1
	is_ritorno.s_utente = ""
	CloseWithReturn(This, is_ritorno)
End IF
end event

type cb_1 from commandbutton within w_login
integer x = 320
integer y = 336
integer width = 297
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;is_ritorno.i_successo = -1
is_ritorno.i_idutente = -1
is_ritorno.i_idmenu = -1
is_ritorno.s_utente = ""
Parent.TriggerEvent("ue_close")
	
end event

type st_2 from statictext within w_login
integer x = 32
integer y = 212
integer width = 265
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Password"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
integer x = 32
integer y = 80
integer width = 265
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Login"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_login
integer x = 320
integer y = 204
integer width = 759
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_login
integer x = 782
integer y = 336
integer width = 297
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;Parent.TriggerEvent("ue_validazione")

end event

type ddlb_utente from dropdownlistbox within w_login
integer x = 320
integer y = 68
integer width = 759
integer height = 364
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;sle_password.Text = ""

end event

event losefocus;this.Text = Upper(this.Text)
end event

