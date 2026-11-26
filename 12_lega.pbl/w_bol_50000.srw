forward
global type w_bol_50000 from w_semplice_cx
end type
end forward

global type w_bol_50000 from w_semplice_cx
integer width = 3922
integer height = 1728
boolean minbox = false
windowtype windowtype = response!
end type
global w_bol_50000 w_bol_50000

on w_bol_50000.create
call super::create
end on

on w_bol_50000.destroy
call super::destroy
end on

event open;call super::open;
if dw_1.retrieve()<=0 then
	close(this)
end if
end event

event close;call super::close;long ll_max_prog
ll_max_prog=dw_1.getitemnumber(1, "c_max_prog")
closewithreturn(this, ll_max_prog)
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_bol_50000
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_bol_50000
end type

type cb_primo from w_semplice_cx`cb_primo within w_bol_50000
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_bol_50000
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_bol_50000
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_bol_50000
end type

type dw_1 from w_semplice_cx`dw_1 within w_bol_50000
integer width = 3831
string dataobject = "d_bol_obol_50000"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_bol_50000
end type

type cb_salva from w_semplice_cx`cb_salva within w_bol_50000
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_bol_50000
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_bol_50000
end type

type cb_ok from w_semplice_cx`cb_ok within w_bol_50000
end type

