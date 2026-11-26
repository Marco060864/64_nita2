forward
global type w_tot_magazzino_rpt from w_stampa_001
end type
type cbx_1 from checkbox within w_tot_magazzino_rpt
end type
end forward

global type w_tot_magazzino_rpt from w_stampa_001
cbx_1 cbx_1
end type
global w_tot_magazzino_rpt w_tot_magazzino_rpt

type variables
string is_solo_preziosi
end variables

on w_tot_magazzino_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_tot_magazzino_rpt.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;s_param_articoli s_par

s_par=message.powerobjectparm
is_solo_preziosi=s_par.solo_preziosi
if s_par.tipo_stampa>"" then
	dw_1.dataobject=s_par.tipo_stampa
end if
dw_1.settransobject(sqlca)
dw_1.retrieve(s_par.da_data, s_par.a_data)
end event

type dw_1 from w_stampa_001`dw_1 within w_tot_magazzino_rpt
string dataobject = "d_tot_magazzino_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
ls_sql=upper(sqlsyntax)

if is_solo_preziosi='S' then
	ls_sql+=" and orafo_metallo.prezioso='S' "
		setsqlpreview(ls_sql)
end if

end event

type sle_pg from w_stampa_001`sle_pg within w_tot_magazzino_rpt
integer x = 1637
integer width = 315
end type

type st_1 from w_stampa_001`st_1 within w_tot_magazzino_rpt
integer x = 1454
integer width = 183
string text = "St. Pg.:"
alignment alignment = right!
end type

type st_2 from w_stampa_001`st_2 within w_tot_magazzino_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_tot_magazzino_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_tot_magazzino_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_tot_magazzino_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_tot_magazzino_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_tot_magazzino_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_tot_magazzino_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_tot_magazzino_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_tot_magazzino_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_tot_magazzino_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_tot_magazzino_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_tot_magazzino_rpt
end type

type cbx_1 from checkbox within w_tot_magazzino_rpt
integer x = 1083
integer y = 44
integer width = 448
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
string text = "Vedi dettaglio"
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 69")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

