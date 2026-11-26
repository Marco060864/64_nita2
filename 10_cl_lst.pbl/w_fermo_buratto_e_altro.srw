forward
global type w_fermo_buratto_e_altro from w_stampa
end type
type cbx_vedi_righe from checkbox within w_fermo_buratto_e_altro
end type
end forward

global type w_fermo_buratto_e_altro from w_stampa
integer width = 4379
cbx_vedi_righe cbx_vedi_righe
end type
global w_fermo_buratto_e_altro w_fermo_buratto_e_altro

on w_fermo_buratto_e_altro.create
int iCurrent
call super::create
this.cbx_vedi_righe=create cbx_vedi_righe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_vedi_righe
end on

on w_fermo_buratto_e_altro.destroy
call super::destroy
destroy(this.cbx_vedi_righe)
end on

event open;call super::open;long ll_id_prof
s_list_main ls_list

ls_list=message.powerobjectparm
ll_id_prof=long(ls_list.s_win_parametri)

if ll_id_prof =184 then dw_1.dataobject="d_fermo_buratto_gd"
if ll_id_prof =170 then dw_1.dataobject="d_fermo_galvanica_gd"
if ll_id_prof =224 then dw_1.dataobject="d_fermo_ceramico_gd"
if ll_id_prof =226 then dw_1.dataobject="d_fermo_attesa_gd"

dw_1.settransobject(sqlca)


dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_fermo_buratto_e_altro
end type

type cb_preview from w_stampa`cb_preview within w_fermo_buratto_e_altro
end type

type dw_1 from w_stampa`dw_1 within w_fermo_buratto_e_altro
integer width = 4187
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_fermo_buratto_e_altro
end type

type pb_stampa from w_stampa`pb_stampa within w_fermo_buratto_e_altro
end type

type sle_pg from w_stampa`sle_pg within w_fermo_buratto_e_altro
end type

type st_1 from w_stampa`st_1 within w_fermo_buratto_e_altro
end type

type st_2 from w_stampa`st_2 within w_fermo_buratto_e_altro
end type

type sle_copie from w_stampa`sle_copie within w_fermo_buratto_e_altro
end type

type sle_zoom from w_stampa`sle_zoom within w_fermo_buratto_e_altro
end type

type cb_7 from w_stampa`cb_7 within w_fermo_buratto_e_altro
end type

type cb_6 from w_stampa`cb_6 within w_fermo_buratto_e_altro
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_fermo_buratto_e_altro
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_fermo_buratto_e_altro
end type

type cb_esci from w_stampa`cb_esci within w_fermo_buratto_e_altro
integer x = 3886
integer y = 44
end type

type cbx_vedi_righe from checkbox within w_fermo_buratto_e_altro
integer x = 3470
integer y = 52
integer width = 334
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi righe"
end type

event clicked;if checked then
		
	dw_1.Modify("datawindow.detail.Height.AutoSize=Yes")

else
	dw_1.Modify("datawindow.detail.Height.AutoSize=No")
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

