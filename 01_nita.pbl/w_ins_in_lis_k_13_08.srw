forward
global type w_ins_in_lis_k_13_08 from w_semplice_gd
end type
type cb_1 from commandbutton within w_ins_in_lis_k_13_08
end type
end forward

global type w_ins_in_lis_k_13_08 from w_semplice_gd
integer width = 3538
cb_1 cb_1
end type
global w_ins_in_lis_k_13_08 w_ins_in_lis_k_13_08

on w_ins_in_lis_k_13_08.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ins_in_lis_k_13_08.destroy
call super::destroy
destroy(this.cb_1)
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_ins_in_lis_k_13_08
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_ins_in_lis_k_13_08
end type

type cb_primo from w_semplice_gd`cb_primo within w_ins_in_lis_k_13_08
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_ins_in_lis_k_13_08
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_ins_in_lis_k_13_08
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_ins_in_lis_k_13_08
end type

type dw_1 from w_semplice_gd`dw_1 within w_ins_in_lis_k_13_08
integer width = 2752
string dataobject = "d_inserisci_in_listino_13-08"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_ins_in_lis_k_13_08
end type

type cb_salva from w_semplice_gd`cb_salva within w_ins_in_lis_k_13_08
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_ins_in_lis_k_13_08
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_ins_in_lis_k_13_08
end type

type cb_ok from w_semplice_gd`cb_ok within w_ins_in_lis_k_13_08
end type

type cb_1 from commandbutton within w_ins_in_lis_k_13_08
integer x = 3026
integer y = 100
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;
long ll_id_uc,  a, ll_id_var

declare CI  cursor for
select id_unita_confezione from unita_confezione 
where id_articolo>=19513 and id_articolo<=19599 
;
open  CI;

fetch ci INTO :ll_id_uc;
DO WHILE SQLCA.SQLCODE=0 
	ll_id_var=0
	select id_variazione into :ll_id_var from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=15;
	if ll_id_var<=0 or isnull(ll_id_var) then
		a=dw_1.insertrow(0)
		dw_1.setitem(a, "prezzo_id_unita_confezione", ll_id_uc)
	end if
	fetch ci INTO :ll_id_uc;
LOOP
	
end event

