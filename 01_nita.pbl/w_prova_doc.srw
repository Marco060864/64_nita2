forward
global type w_prova_doc from w_semplice_cx
end type
end forward

global type w_prova_doc from w_semplice_cx
integer width = 3122
integer height = 2092
end type
global w_prova_doc w_prova_doc

on w_prova_doc.create
call super::create
end on

on w_prova_doc.destroy
call super::destroy
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_prova_doc
integer x = 891
integer y = 1816
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_prova_doc
integer x = 1467
integer y = 1744
end type

type cb_primo from w_semplice_cx`cb_primo within w_prova_doc
integer x = 905
integer y = 1752
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_prova_doc
integer x = 1321
integer y = 1752
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_prova_doc
integer x = 1234
integer y = 1752
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_prova_doc
integer x = 1362
integer y = 1752
end type

type dw_1 from w_semplice_cx`dw_1 within w_prova_doc
integer width = 2994
integer height = 1684
string dataobject = "d_documento_ordine_ff"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_prova_doc
integer x = 37
integer y = 1736
end type

type cb_salva from w_semplice_cx`cb_salva within w_prova_doc
integer x = 320
integer y = 1736
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_prova_doc
integer x = 608
integer y = 1736
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_prova_doc
integer x = 1742
integer y = 1740
end type

type cb_ok from w_semplice_cx`cb_ok within w_prova_doc
integer x = 2030
integer y = 1740
end type

