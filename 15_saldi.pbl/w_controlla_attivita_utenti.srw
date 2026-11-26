forward
global type w_controlla_attivita_utenti from w_001
end type
type cb_reg_pd from commandbutton within w_controlla_attivita_utenti
end type
type cb_1 from commandbutton within w_controlla_attivita_utenti
end type
type cb__cl_fo from commandbutton within w_controlla_attivita_utenti
end type
end forward

global type w_controlla_attivita_utenti from w_001
integer width = 1254
integer height = 685
cb_reg_pd cb_reg_pd
cb_1 cb_1
cb__cl_fo cb__cl_fo
end type
global w_controlla_attivita_utenti w_controlla_attivita_utenti

on w_controlla_attivita_utenti.create
int iCurrent
call super::create
this.cb_reg_pd=create cb_reg_pd
this.cb_1=create cb_1
this.cb__cl_fo=create cb__cl_fo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reg_pd
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb__cl_fo
end on

on w_controlla_attivita_utenti.destroy
call super::destroy
destroy(this.cb_reg_pd)
destroy(this.cb_1)
destroy(this.cb__cl_fo)
end on

type st_1 from w_001`st_1 within w_controlla_attivita_utenti
end type

type cb_reg_pd from commandbutton within w_controlla_attivita_utenti
integer x = 59
integer y = 51
integer width = 1112
integer height = 102
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Controlla Registrazioni Contabili"
end type

event clicked;open(w_ute_reg_pd_gd)
end event

type cb_1 from commandbutton within w_controlla_attivita_utenti
integer x = 59
integer y = 230
integer width = 1112
integer height = 102
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Controlla Documenti Magazzino"
end type

event clicked;open(w_ute_documento_gd)
end event

type cb__cl_fo from commandbutton within w_controlla_attivita_utenti
integer x = 59
integer y = 410
integer width = 1112
integer height = 102
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Controlla Anagrafiche Condivise"
end type

event clicked;open(w_ute_ana_cl_fo_gd)
end event

