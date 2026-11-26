forward
global type w_utente_ff from w_p_data
end type
type cb_cambio from commandbutton within w_utente_ff
end type
type dw_utente_ff from u_dw_master_main within w_utente_ff
end type
end forward

global type w_utente_ff from w_p_data
integer width = 1879
integer height = 1036
string title = "Utente"
cb_cambio cb_cambio
dw_utente_ff dw_utente_ff
end type
global w_utente_ff w_utente_ff

on w_utente_ff.create
int iCurrent
call super::create
this.cb_cambio=create cb_cambio
this.dw_utente_ff=create dw_utente_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cambio
this.Control[iCurrent+2]=this.dw_utente_ff
end on

on w_utente_ff.destroy
call super::destroy
destroy(this.cb_cambio)
destroy(this.dw_utente_ff)
end on

event open;call super::open;idw_master = dw_utente_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "utenti.id_utenti"
end event

type p_msg_log from w_p_data`p_msg_log within w_utente_ff
end type

type p_crescente from w_p_data`p_crescente within w_utente_ff
end type

type p_decrescente from w_p_data`p_decrescente within w_utente_ff
end type

type cb_ok from w_p_data`cb_ok within w_utente_ff
string text = "&OK"
end type

type cb_annulla from w_p_data`cb_annulla within w_utente_ff
integer x = 320
string text = "&Annulla"
end type

type cb_nuovo from w_p_data`cb_nuovo within w_utente_ff
boolean visible = false
integer x = 617
end type

type cb_inserisci from w_p_data`cb_inserisci within w_utente_ff
boolean visible = false
integer x = 1006
end type

type cb_cancella from w_p_data`cb_cancella within w_utente_ff
boolean visible = false
integer x = 1280
end type

type cb_salva from w_p_data`cb_salva within w_utente_ff
integer x = 1554
string text = "&Salva"
end type

type tab_1 from w_p_data`tab_1 within w_utente_ff
boolean visible = false
integer x = 2149
integer y = 220
integer width = 183
integer height = 100
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 146
integer height = -20
end type

type cb_ricerca from w_p_data`cb_ricerca within w_utente_ff
end type

type cb_cambio from commandbutton within w_utente_ff
integer x = 1143
integer y = 500
integer width = 535
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cambio Password ..."
boolean default = true
end type

event clicked;long		ll_row, ll_sbagli = 0
string	ls_passwd, ls_nuova

ll_row = Parent.dw_utente_ff.GetRow()
ls_passwd = Parent.dw_utente_ff.GetItemString(ll_row,"ut_password")
if Not IsNull(ls_passwd) And ls_passwd <> "" then
	ls_passwd = f_cripting(ls_passwd)
end if
ll_sbagli = OpenWithParm(w_inserimento_passwd_cx, ls_passwd)
ll_sbagli=1
if ll_sbagli < 0 then
	MessageBox("Attenzione","Impossibile aprire la finestra delle password.")
end if

ls_nuova = Message.StringParm
if IsNumber(ls_nuova) then
	ll_sbagli = ll_sbagli + long(ls_nuova)
end if

If ll_sbagli >= 0 then
	
	if Not IsNull(ls_nuova) And ls_nuova <> "" then
		ls_nuova = f_cripting(ls_nuova)
	end if
	Parent.dw_utente_ff.SetItem(ll_row,"ut_password",ls_nuova)
end if

Return ll_sbagli
end event

type dw_utente_ff from u_dw_master_main within w_utente_ff
integer x = 46
integer y = 160
integer width = 1760
integer height = 740
integer taborder = 10
string dataobject = "d_utente_ff"
end type

