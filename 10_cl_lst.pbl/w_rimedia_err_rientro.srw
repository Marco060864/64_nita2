forward
global type w_rimedia_err_rientro from w_semplice_cx
end type
end forward

global type w_rimedia_err_rientro from w_semplice_cx
integer width = 3433
end type
global w_rimedia_err_rientro w_rimedia_err_rientro

on w_rimedia_err_rientro.create
call super::create
end on

on w_rimedia_err_rientro.destroy
call super::destroy
end on

event open;call super::open;dw_1.retrieve()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_rimedia_err_rientro
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_rimedia_err_rientro
end type

type cb_primo from w_semplice_cx`cb_primo within w_rimedia_err_rientro
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_rimedia_err_rientro
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_rimedia_err_rientro
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_rimedia_err_rientro
end type

type dw_1 from w_semplice_cx`dw_1 within w_rimedia_err_rientro
integer width = 3319
string dataobject = "d_rimedia_err_rientro"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_rimedia_err_rientro
end type

type cb_salva from w_semplice_cx`cb_salva within w_rimedia_err_rientro
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_rimedia_err_rientro
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_rimedia_err_rientro
end type

type cb_ok from w_semplice_cx`cb_ok within w_rimedia_err_rientro
end type

