forward
global type w_evadi_doc_con_tot_righe_evase from w_semplice_cx
end type
end forward

global type w_evadi_doc_con_tot_righe_evase from w_semplice_cx
integer width = 2537
integer height = 1684
boolean righttoleft = true
end type
global w_evadi_doc_con_tot_righe_evase w_evadi_doc_con_tot_righe_evase

on w_evadi_doc_con_tot_righe_evase.create
call super::create
end on

on w_evadi_doc_con_tot_righe_evase.destroy
call super::destroy
end on

event open;call super::open;DW_1.RETRIEVE(DATE(22/07/2022), 66)
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_evadi_doc_con_tot_righe_evase
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_evadi_doc_con_tot_righe_evase
end type

type cb_primo from w_semplice_cx`cb_primo within w_evadi_doc_con_tot_righe_evase
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_evadi_doc_con_tot_righe_evase
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_evadi_doc_con_tot_righe_evase
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_evadi_doc_con_tot_righe_evase
end type

type dw_1 from w_semplice_cx`dw_1 within w_evadi_doc_con_tot_righe_evase
integer width = 2386
string dataobject = "d_evadi_doc_tutte_righe_evase"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_evadi_doc_con_tot_righe_evase
end type

type cb_salva from w_semplice_cx`cb_salva within w_evadi_doc_con_tot_righe_evase
integer weight = 700
end type

event cb_salva::clicked;call super::clicked;
dw_1.trigger event ue_update()

end event

type cb_cancella from w_semplice_cx`cb_cancella within w_evadi_doc_con_tot_righe_evase
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_evadi_doc_con_tot_righe_evase
integer width = 265
string text = "EVADI"
end type

event cb_annulla::clicked;integer i

for i =1 to dw_1.rowcount()
	dw_1.setitem(i, "evaso_totalmente", "S")
next
end event

type cb_ok from w_semplice_cx`cb_ok within w_evadi_doc_con_tot_righe_evase
end type

