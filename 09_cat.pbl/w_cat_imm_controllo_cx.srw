forward
global type w_cat_imm_controllo_cx from w_testa_righe_cx
end type
end forward

global type w_cat_imm_controllo_cx from w_testa_righe_cx
integer width = 3689
integer height = 2008
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
end type
global w_cat_imm_controllo_cx w_cat_imm_controllo_cx

on w_cat_imm_controllo_cx.create
call super::create
end on

on w_cat_imm_controllo_cx.destroy
call super::destroy
end on

type st_1 from w_testa_righe_cx`st_1 within w_cat_imm_controllo_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_cat_imm_controllo_cx
string dataobject = "d_cat_immediato"
end type

type dw_2 from w_testa_righe_cx`dw_2 within w_cat_imm_controllo_cx
integer y = 420
integer width = 3557
integer height = 1300
string dataobject = "d_cat_immediato_righe"
boolean hscrollbar = true
end type

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_cat_imm_controllo_cx
integer x = 55
integer y = 1748
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_cat_imm_controllo_cx
integer x = 343
integer y = 1748
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_cat_imm_controllo_cx
integer x = 631
integer y = 1748
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_cat_imm_controllo_cx
integer x = 2880
integer y = 1748
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_cat_imm_controllo_cx
integer x = 3173
integer y = 1748
end type

