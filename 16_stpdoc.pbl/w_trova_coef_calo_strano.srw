forward
global type w_trova_coef_calo_strano from w_stampa
end type
type cb_salva from commandbutton within w_trova_coef_calo_strano
end type
end forward

global type w_trova_coef_calo_strano from w_stampa
cb_salva cb_salva
end type
global w_trova_coef_calo_strano w_trova_coef_calo_strano

on w_trova_coef_calo_strano.create
int iCurrent
call super::create
this.cb_salva=create cb_salva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva
end on

on w_trova_coef_calo_strano.destroy
call super::destroy
destroy(this.cb_salva)
end on

event open;call super::open;long ll_id_sog

dw_1.settransobject(sqlca)

ll_id_sog=message.doubleparm
dw_1.retrieve(ll_id_sog)
end event

type pb_1 from w_stampa`pb_1 within w_trova_coef_calo_strano
end type

type cb_preview from w_stampa`cb_preview within w_trova_coef_calo_strano
end type

type dw_1 from w_stampa`dw_1 within w_trova_coef_calo_strano
string dataobject = "d_trova_coef_calo_strano"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_trova_coef_calo_strano
end type

type pb_stampa from w_stampa`pb_stampa within w_trova_coef_calo_strano
end type

type sle_pg from w_stampa`sle_pg within w_trova_coef_calo_strano
end type

type st_1 from w_stampa`st_1 within w_trova_coef_calo_strano
end type

type st_2 from w_stampa`st_2 within w_trova_coef_calo_strano
end type

type sle_copie from w_stampa`sle_copie within w_trova_coef_calo_strano
end type

type sle_zoom from w_stampa`sle_zoom within w_trova_coef_calo_strano
end type

type cb_7 from w_stampa`cb_7 within w_trova_coef_calo_strano
end type

type cb_6 from w_stampa`cb_6 within w_trova_coef_calo_strano
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_trova_coef_calo_strano
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_trova_coef_calo_strano
end type

type cb_esci from w_stampa`cb_esci within w_trova_coef_calo_strano
end type

type cb_salva from commandbutton within w_trova_coef_calo_strano
integer x = 2729
integer y = 32
integer width = 256
integer height = 92
integer taborder = 19
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salva"
end type

event clicked;if dw_1.update()=1 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "Salvataggio NON riuscito!")
end if
end event

