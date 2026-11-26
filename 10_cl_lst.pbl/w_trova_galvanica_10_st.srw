forward
global type w_trova_galvanica_10_st from w_stampa
end type
type cbx_dettaglio from checkbox within w_trova_galvanica_10_st
end type
end forward

global type w_trova_galvanica_10_st from w_stampa
integer width = 3579
cbx_dettaglio cbx_dettaglio
end type
global w_trova_galvanica_10_st w_trova_galvanica_10_st

type variables
long il_id_sog
end variables

on w_trova_galvanica_10_st.create
int iCurrent
call super::create
this.cbx_dettaglio=create cbx_dettaglio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_dettaglio
end on

on w_trova_galvanica_10_st.destroy
call super::destroy
destroy(this.cbx_dettaglio)
end on

event open;call super::open;s_date_e_sog s_date

s_date=message.powerobjectparm
il_id_sog=s_date.id_sog_com
dw_1.settransobject(sqlca)
dw_1.retrieve(s_date.da_data, s_date.a_Data)
end event

type pb_1 from w_stampa`pb_1 within w_trova_galvanica_10_st
end type

type cb_preview from w_stampa`cb_preview within w_trova_galvanica_10_st
end type

type dw_1 from w_stampa`dw_1 within w_trova_galvanica_10_st
integer width = 3447
string dataobject = "d_trova_galvanica_10"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax


if il_id_sog>0 then
	ls_sql+= " and documento.id_sog_commerciale = "+string(il_id_sog)+" "
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
	
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_trova_galvanica_10_st
end type

type pb_stampa from w_stampa`pb_stampa within w_trova_galvanica_10_st
end type

type sle_pg from w_stampa`sle_pg within w_trova_galvanica_10_st
end type

type st_1 from w_stampa`st_1 within w_trova_galvanica_10_st
end type

type st_2 from w_stampa`st_2 within w_trova_galvanica_10_st
end type

type sle_copie from w_stampa`sle_copie within w_trova_galvanica_10_st
end type

type sle_zoom from w_stampa`sle_zoom within w_trova_galvanica_10_st
end type

type cb_7 from w_stampa`cb_7 within w_trova_galvanica_10_st
end type

type cb_6 from w_stampa`cb_6 within w_trova_galvanica_10_st
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_trova_galvanica_10_st
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_trova_galvanica_10_st
end type

type cb_esci from w_stampa`cb_esci within w_trova_galvanica_10_st
integer x = 3214
end type

type cbx_dettaglio from checkbox within w_trova_galvanica_10_st
integer x = 2752
integer y = 52
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Dettaglio"
boolean checked = true
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.detail.Height=84")
else
	dw_1.Modify("DataWindow.detail.Height=0")
end if
end event

