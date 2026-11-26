forward
global type w_cat_immediato_cx from w_testa_righe_cx
end type
end forward

global type w_cat_immediato_cx from w_testa_righe_cx
integer width = 3397
integer height = 2180
end type
global w_cat_immediato_cx w_cat_immediato_cx

on w_cat_immediato_cx.create
call super::create
end on

on w_cat_immediato_cx.destroy
call super::destroy
end on

type st_1 from w_testa_righe_cx`st_1 within w_cat_immediato_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_cat_immediato_cx
integer height = 792
string dataobject = "d_cat_immediato"
end type

type dw_2 from w_testa_righe_cx`dw_2 within w_cat_immediato_cx
integer x = 37
integer y = 836
integer width = 3273
integer height = 1216
string dataobject = "d_cat_immediato_righe"
boolean hscrollbar = true
end type

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_cat_immediato_cx
integer x = 1705
integer y = 40
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_cat_immediato_cx
integer x = 1993
integer y = 40
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_cat_immediato_cx
integer x = 2281
integer y = 40
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_cat_immediato_cx
integer x = 2766
integer y = 40
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_cat_immediato_cx
integer x = 3058
integer y = 40
end type

