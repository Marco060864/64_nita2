forward
global type w_rif_pericolosi_st from w_stampa
end type
type cbx_vedi_righe from checkbox within w_rif_pericolosi_st
end type
end forward

global type w_rif_pericolosi_st from w_stampa
string title = "Rifiuti Pericolosi ST."
cbx_vedi_righe cbx_vedi_righe
end type
global w_rif_pericolosi_st w_rif_pericolosi_st

on w_rif_pericolosi_st.create
int iCurrent
call super::create
this.cbx_vedi_righe=create cbx_vedi_righe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_vedi_righe
end on

on w_rif_pericolosi_st.destroy
call super::destroy
destroy(this.cbx_vedi_righe)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_rif_pericolosi_st
integer x = 2802
end type

type cb_preview from w_stampa`cb_preview within w_rif_pericolosi_st
integer x = 2199
end type

type dw_1 from w_stampa`dw_1 within w_rif_pericolosi_st
string dataobject = "d_rif_pericolosi_rpt"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_rif_pericolosi_st
integer x = 2606
end type

type pb_stampa from w_stampa`pb_stampa within w_rif_pericolosi_st
integer x = 2395
end type

type sle_pg from w_stampa`sle_pg within w_rif_pericolosi_st
integer x = 1294
end type

type st_1 from w_stampa`st_1 within w_rif_pericolosi_st
integer x = 1015
end type

type st_2 from w_stampa`st_2 within w_rif_pericolosi_st
end type

type sle_copie from w_stampa`sle_copie within w_rif_pericolosi_st
end type

type sle_zoom from w_stampa`sle_zoom within w_rif_pericolosi_st
end type

type cb_7 from w_stampa`cb_7 within w_rif_pericolosi_st
end type

type cb_6 from w_stampa`cb_6 within w_rif_pericolosi_st
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_rif_pericolosi_st
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_rif_pericolosi_st
end type

type cb_esci from w_stampa`cb_esci within w_rif_pericolosi_st
end type

type cbx_vedi_righe from checkbox within w_rif_pericolosi_st
integer x = 1696
integer y = 48
integer width = 343
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
string text = "Vedi Righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 88")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

