forward
global type w_saldi_contropartita_rpt from w_stampa_001
end type
type cbx_dettaglio from checkbox within w_saldi_contropartita_rpt
end type
end forward

global type w_saldi_contropartita_rpt from w_stampa_001
cbx_dettaglio cbx_dettaglio
end type
global w_saldi_contropartita_rpt w_saldi_contropartita_rpt

on w_saldi_contropartita_rpt.create
int iCurrent
call super::create
this.cbx_dettaglio=create cbx_dettaglio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_dettaglio
end on

on w_saldi_contropartita_rpt.destroy
call super::destroy
destroy(this.cbx_dettaglio)
end on

event open;call super::open;s_passa_date str_parametri 

str_parametri=MESSAGE.POWEROBJECTPARM
DW_1.settransobject(sqlca)
DW_1.RETRIEVE(str_parametri.Da_conto, str_parametri.a_conto, &
					str_parametri.data_inizio_estratto,str_parametri.data_fine_estratto)
end event

type dw_1 from w_stampa_001`dw_1 within w_saldi_contropartita_rpt
string dataobject = "d_saldi_contropartita"
end type

type sle_pg from w_stampa_001`sle_pg within w_saldi_contropartita_rpt
integer x = 1760
integer width = 361
end type

type st_1 from w_stampa_001`st_1 within w_saldi_contropartita_rpt
integer x = 1495
end type

type st_2 from w_stampa_001`st_2 within w_saldi_contropartita_rpt
integer x = 2130
end type

type sle_copie from w_stampa_001`sle_copie within w_saldi_contropartita_rpt
integer x = 2277
end type

type sle_zoom from w_stampa_001`sle_zoom within w_saldi_contropartita_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_saldi_contropartita_rpt
integer x = 3003
integer width = 242
string text = "Salva &File"
end type

type cb_7 from w_stampa_001`cb_7 within w_saldi_contropartita_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_saldi_contropartita_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_saldi_contropartita_rpt
integer x = 2706
integer width = 274
end type

type cb_stampa from w_stampa_001`cb_stampa within w_saldi_contropartita_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_saldi_contropartita_rpt
integer x = 2455
integer width = 229
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_saldi_contropartita_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_saldi_contropartita_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_saldi_contropartita_rpt
end type

type cbx_dettaglio from checkbox within w_saldi_contropartita_rpt
integer x = 1088
integer y = 44
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
	dw_1.modify("datawindow.detail.height = 76")
	dw_1.modify("datawindow.header.1.height = 176")
	dw_1.modify("datawindow.header.height = 88")
else
	dw_1.modify("datawindow.detail.height = 0")
	dw_1.modify("datawindow.header.1.height = 88")
	dw_1.modify("datawindow.header.height = 160")
end if
end event

