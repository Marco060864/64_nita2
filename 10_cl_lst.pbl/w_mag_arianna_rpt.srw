forward
global type w_mag_arianna_rpt from w_stampa
end type
type dw_2 from udw_000 within w_mag_arianna_rpt
end type
end forward

global type w_mag_arianna_rpt from w_stampa
integer width = 3726
integer height = 1964
dw_2 dw_2
end type
global w_mag_arianna_rpt w_mag_arianna_rpt

on w_mag_arianna_rpt.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_mag_arianna_rpt.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_2.settransobject(sqlca)
dw_2.insertrow(1)

end event

type pb_1 from w_stampa`pb_1 within w_mag_arianna_rpt
end type

type cb_preview from w_stampa`cb_preview within w_mag_arianna_rpt
end type

type dw_1 from w_stampa`dw_1 within w_mag_arianna_rpt
integer width = 3575
string dataobject = "d_st_mag_arianna"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_mag_arianna_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_mag_arianna_rpt
end type

type sle_pg from w_stampa`sle_pg within w_mag_arianna_rpt
end type

type st_1 from w_stampa`st_1 within w_mag_arianna_rpt
end type

type st_2 from w_stampa`st_2 within w_mag_arianna_rpt
end type

type sle_copie from w_stampa`sle_copie within w_mag_arianna_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_mag_arianna_rpt
end type

type cb_7 from w_stampa`cb_7 within w_mag_arianna_rpt
end type

type cb_6 from w_stampa`cb_6 within w_mag_arianna_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_mag_arianna_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_mag_arianna_rpt
end type

type cb_esci from w_stampa`cb_esci within w_mag_arianna_rpt
integer x = 3351
end type

type dw_2 from udw_000 within w_mag_arianna_rpt
integer x = 2729
integer y = 48
integer width = 622
integer height = 112
integer taborder = 18
boolean bringtotop = true
string dataobject = "d_mag_arianna"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;if data> " " then
	dw_1.setfilter("c_magazzino='"+data+"'")
	dw_1.modify("t_titolo.text='Magazzino: "+data+"'")
else
	dw_1.setfilter("")
	dw_1.modify("t_titolo.text='Tutti i Magazzini'")
end if

dw_1.filter()
dw_1.groupcalc()
end event

