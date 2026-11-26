forward
global type w_netto_lordo from w_stampa
end type
type cbx_1 from checkbox within w_netto_lordo
end type
end forward

global type w_netto_lordo from w_stampa
cbx_1 cbx_1
end type
global w_netto_lordo w_netto_lordo

on w_netto_lordo.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_netto_lordo.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;s_date_e_sog s_date


s_date=message.powerobjectparm

dw_1.settransobject(sqlca)
dw_1.retrieve(s_date.da_data, s_date.a_data)
end event

type pb_1 from w_stampa`pb_1 within w_netto_lordo
integer x = 2779
end type

type cb_preview from w_stampa`cb_preview within w_netto_lordo
integer x = 2176
end type

type dw_1 from w_stampa`dw_1 within w_netto_lordo
string dataobject = "d_netto_lordo"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_netto_lordo
integer x = 2583
end type

type pb_stampa from w_stampa`pb_stampa within w_netto_lordo
integer x = 2373
end type

type sle_pg from w_stampa`sle_pg within w_netto_lordo
integer x = 1262
integer width = 265
end type

type st_1 from w_stampa`st_1 within w_netto_lordo
integer x = 983
end type

type st_2 from w_stampa`st_2 within w_netto_lordo
end type

type sle_copie from w_stampa`sle_copie within w_netto_lordo
end type

type sle_zoom from w_stampa`sle_zoom within w_netto_lordo
integer width = 128
end type

type cb_7 from w_stampa`cb_7 within w_netto_lordo
end type

type cb_6 from w_stampa`cb_6 within w_netto_lordo
integer x = 859
integer width = 110
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_netto_lordo
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_netto_lordo
end type

type cb_esci from w_stampa`cb_esci within w_netto_lordo
end type

type cbx_1 from checkbox within w_netto_lordo
integer x = 1637
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
string text = " Vedi Righe"
end type

event clicked;if checked then
		
	dw_1.Modify("datawindow.detail.Height.AutoSize=Yes")

else
	dw_1.Modify("datawindow.detail.Height.AutoSize=No")
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

