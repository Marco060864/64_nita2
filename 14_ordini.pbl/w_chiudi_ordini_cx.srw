forward
global type w_chiudi_ordini_cx from w_testa_righe_cx
end type
type cbx_1 from checkbox within w_chiudi_ordini_cx
end type
type cbx_chiudi_tutti from checkbox within w_chiudi_ordini_cx
end type
type rte_1 from richtextedit within w_chiudi_ordini_cx
end type
end forward

global type w_chiudi_ordini_cx from w_testa_righe_cx
integer width = 3529
integer height = 2284
string title = "Chiudi gli ordini"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
cbx_1 cbx_1
cbx_chiudi_tutti cbx_chiudi_tutti
rte_1 rte_1
end type
global w_chiudi_ordini_cx w_chiudi_ordini_cx

type variables
string is_vedi_chiuse, is_sintax_originale
end variables

on w_chiudi_ordini_cx.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_chiudi_tutti=create cbx_chiudi_tutti
this.rte_1=create rte_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_chiudi_tutti
this.Control[iCurrent+3]=this.rte_1
end on

on w_chiudi_ordini_cx.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_chiudi_tutti)
destroy(this.rte_1)
end on

event open;call super::open;integer rtn

rtn = rte_1.InsertDocument("c:\start\w_chiudi_ordini_cx.txt", TRUE)
rte_1.WordWrap = TRUE
rte_1.width=830	
rte_1.SetAlignment ( justify! )
//st_status.Text = String(rtn)

dw_1.setsort("num_progressivo_vero")
dw_1.sort()
end event

type st_1 from w_testa_righe_cx`st_1 within w_chiudi_ordini_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_chiudi_ordini_cx
integer x = 41
integer width = 2693
integer height = 848
string dataobject = "d_orafo_ordini_tutti_gd"
end type

type dw_2 from w_testa_righe_cx`dw_2 within w_chiudi_ordini_cx
integer x = 41
integer y = 904
integer width = 3406
integer height = 1224
string dataobject = "d_prod_bol_da_chiudere_gd"
boolean hscrollbar = true
end type

event dw_2::sqlpreview;call super::sqlpreview;//string ls_sql
//if is_sintax_originale= "" then is_sintax_originale=sqlsyntax
//
//
//if is_vedi_chiuse='S' then
//	ls_sql=sqlsyntax +" and riga_documento_b.forza_chius_evasione<>'S' " 
//else
//	ls_sql=is_sintax_originale
//end if
//setsqlpreview(ls_sql)
//
//
end event

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_chiudi_ordini_cx
boolean visible = false
integer x = 3191
integer y = 28
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_chiudi_ordini_cx
integer x = 2766
integer y = 680
integer width = 215
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_chiudi_ordini_cx
boolean visible = false
integer x = 3218
integer y = 168
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_chiudi_ordini_cx
integer x = 3035
integer y = 680
integer width = 219
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_chiudi_ordini_cx
integer x = 3278
integer y = 680
integer width = 192
end type

type cbx_1 from checkbox within w_chiudi_ordini_cx
integer x = 3104
integer y = 812
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi chiuse"
boolean lefttext = true
end type

event clicked;if checked then
	dw_2.setfilter("")
else
	dw_2.setfilter("forza_chius_evasione<>'S'")
end if
dw_2.filter()
dw_2.sort()
end event

type cbx_chiudi_tutti from checkbox within w_chiudi_ordini_cx
integer x = 2757
integer y = 812
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Chiudi Tutti"
boolean lefttext = true
end type

event clicked;integer i
string ls_segna

if checked then
	ls_segna='S'
else
	ls_segna='N'
end if
for i = 1 to dw_2.rowcount()
	dw_2.setitem(i, "forza_chius_evasione", ls_segna)
next
end event

type rte_1 from richtextedit within w_chiudi_ordini_cx
integer x = 2747
integer y = 40
integer width = 727
integer height = 604
integer taborder = 70
boolean bringtotop = true
boolean init_wordwrap = true
long init_leftmargin = 10
long init_topmargin = 10
long init_rightmargin = 10
long init_bottommargin = 10
borderstyle borderstyle = stylelowered!
boolean resizable = true
end type

