forward
global type w_stp_dett_cespite_rpt from w_stampa_001
end type
type cbx_1 from checkbox within w_stp_dett_cespite_rpt
end type
end forward

global type w_stp_dett_cespite_rpt from w_stampa_001
integer width = 3817
integer height = 1856
string title = "Stampa Situazione Cespite"
cbx_1 cbx_1
end type
global w_stp_dett_cespite_rpt w_stp_dett_cespite_rpt

type variables

long il_id_dich_per

end variables

event open;s_cespiti ls_par
date ldt_data_inizio, ldt_data_fine

ls_par=Message.PowerObjectParm	

if isnull(ls_par.s_tipo_movimento) then ls_par.s_tipo_movimento='d_stp_registro_cespite_rpt'

dw_1.dataobject=ls_par.s_tipo_movimento
dw_1.settransobject(sqlca)
select data_inizio, data_fine
into :ldt_data_inizio, :ldt_data_fine
from dba.esercizio
where id_esercizio=:ls_par.s_id_cespite
;
if ls_par.s_tipo_movimento="d_stp_registro_cesp_bro_rpt" then
	dw_1.retrieve(ls_par.da_cat,ls_par.a_cat,ls_par.a_data,ldt_data_inizio ) 
else
	dw_1.retrieve(ls_par.da_cat,ls_par.a_cat,ldt_data_fine,ldt_data_inizio ) 

end if

end event

on w_stp_dett_cespite_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_stp_dett_cespite_rpt.destroy
call super::destroy
destroy(this.cbx_1)
end on

type dw_1 from w_stampa_001`dw_1 within w_stp_dett_cespite_rpt
integer x = 0
integer y = 152
integer taborder = 60
string dataobject = "d_stp_dett_cespite_rpt"
end type

type sle_pg from w_stampa_001`sle_pg within w_stp_dett_cespite_rpt
integer x = 1586
integer width = 366
integer taborder = 80
end type

type st_1 from w_stampa_001`st_1 within w_stp_dett_cespite_rpt
integer x = 1317
integer y = 48
end type

type st_2 from w_stampa_001`st_2 within w_stp_dett_cespite_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_stp_dett_cespite_rpt
integer taborder = 90
end type

type sle_zoom from w_stampa_001`sle_zoom within w_stp_dett_cespite_rpt
integer x = 667
integer taborder = 70
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_stp_dett_cespite_rpt
integer taborder = 50
end type

type cb_7 from w_stampa_001`cb_7 within w_stp_dett_cespite_rpt
integer x = 818
integer taborder = 40
end type

type cb_6 from w_stampa_001`cb_6 within w_stp_dett_cespite_rpt
integer x = 553
integer taborder = 120
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_stp_dett_cespite_rpt
integer taborder = 30
end type

type cb_stampa from w_stampa_001`cb_stampa within w_stp_dett_cespite_rpt
integer taborder = 20
end type

event cb_stampa::clicked;printsetup()
dw_1.print()


end event

type cb_preview from w_stampa_001`cb_preview within w_stp_dett_cespite_rpt
integer taborder = 100
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_stp_dett_cespite_rpt
integer taborder = 110
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_stp_dett_cespite_rpt
integer taborder = 130
end type

type cb_1 from w_stampa_001`cb_1 within w_stp_dett_cespite_rpt
integer taborder = 140
end type

type cbx_1 from checkbox within w_stp_dett_cespite_rpt
integer x = 974
integer y = 44
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
string text = "Solo Totali"
end type

event clicked;if checked then
	dw_1.modify("DataWindow.Detail.Height.AutoSize='No'")
	dw_1.modify("DataWindow.Detail.Height=0")
	dw_1.modify("DataWindow.Trailer.2.Height=0")
else
	dw_1.modify("DataWindow.Detail.Height='0'")
	dw_1.modify("DataWindow.Trailer.2.Height=4")
	dw_1.modify("DataWindow.Detail.Height.AutoSize='Yes'")
end if
end event

