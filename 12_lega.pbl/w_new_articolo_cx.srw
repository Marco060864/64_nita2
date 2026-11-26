forward
global type w_new_articolo_cx from w_tab_ra_padre_figlio_cx
end type
end forward

global type w_new_articolo_cx from w_tab_ra_padre_figlio_cx
integer y = 426
integer width = 5038
end type
global w_new_articolo_cx w_new_articolo_cx

on w_new_articolo_cx.create
call super::create
end on

on w_new_articolo_cx.destroy
call super::destroy
end on

type tab_1 from w_tab_ra_padre_figlio_cx`tab_1 within w_new_articolo_cx
integer x = 133
integer width = 4658
end type

type tabpage_1 from w_tab_ra_padre_figlio_cx`tabpage_1 within tab_1
integer x = 18
integer y = 112
integer width = 4622
integer height = 2032
end type

type dw_1 from w_tab_ra_padre_figlio_cx`dw_1 within tabpage_1
integer width = 4530
string dataobject = "d_new_articolo"
end type

type tabpage_2 from w_tab_ra_padre_figlio_cx`tabpage_2 within tab_1
integer x = 18
integer y = 112
integer width = 4622
integer height = 2032
end type

type dw_2 from w_tab_ra_padre_figlio_cx`dw_2 within tabpage_2
end type

type cb_ricerca from w_tab_ra_padre_figlio_cx`cb_ricerca within w_new_articolo_cx
end type

type cb_inserisci from w_tab_ra_padre_figlio_cx`cb_inserisci within w_new_articolo_cx
end type

type cb_salva from w_tab_ra_padre_figlio_cx`cb_salva within w_new_articolo_cx
end type

type cb_cancella from w_tab_ra_padre_figlio_cx`cb_cancella within w_new_articolo_cx
end type

type cb_annulla from w_tab_ra_padre_figlio_cx`cb_annulla within w_new_articolo_cx
end type

type cb_ok from w_tab_ra_padre_figlio_cx`cb_ok within w_new_articolo_cx
end type

