forward
global type w_cerca_bol_excel_per_cliente from w_padre_figlio_cx
end type
end forward

global type w_cerca_bol_excel_per_cliente from w_padre_figlio_cx
integer width = 5047
integer height = 2532
end type
global w_cerca_bol_excel_per_cliente w_cerca_bol_excel_per_cliente

on w_cerca_bol_excel_per_cliente.create
call super::create
end on

on w_cerca_bol_excel_per_cliente.destroy
call super::destroy
end on

event open;call super::open;dw_1.insertrow(1)
end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_cerca_bol_excel_per_cliente
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_cerca_bol_excel_per_cliente
integer y = 24
integer height = 240
string dataobject = "D_CErca_bol_excel_cliente"
end type

type dw_2 from w_padre_figlio_cx`dw_2 within w_cerca_bol_excel_per_cliente
integer x = 69
integer y = 280
integer width = 4901
integer height = 1812
string dataobject = "d_bol_excel_ra_cliente"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_cerca_bol_excel_per_cliente
integer x = 78
integer y = 2136
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_cerca_bol_excel_per_cliente
integer x = 366
integer y = 2136
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_cerca_bol_excel_per_cliente
integer x = 654
integer y = 2136
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_cerca_bol_excel_per_cliente
integer x = 1248
integer y = 2132
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_cerca_bol_excel_per_cliente
integer x = 1545
integer y = 2136
end type

