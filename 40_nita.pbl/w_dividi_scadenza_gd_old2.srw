forward
global type w_dividi_scadenza_gd_old2 from w_data_main
end type
type dw_1 from udw_base within w_dividi_scadenza_gd_old2
end type
end forward

global type w_dividi_scadenza_gd_old2 from w_data_main
integer width = 4992
integer height = 1816
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
end type
global w_dividi_scadenza_gd_old2 w_dividi_scadenza_gd_old2

type variables
long il_id_scad_originale
end variables

event open;call super::open;u_dw_master_main udw_scad

decimal ldc_scad_imp
string ls_imp, ls_err

udw_scad=message.powerobjectparm

udw_scad.rowscopy(1, udw_scad.rowcount(), primary!, dw_1, 1, primary!)

il_id_scad_originale=dw_1.getitemnumber(1, "id_scadenza")

ldc_scad_imp=dw_1.getitemdecimal(1, "scadenza_importo")
ls_imp=string(ldc_scad_imp, "#,0.00")
ls_err=dw_1.modify("t_imp_originale.text='"+ls_imp+"'")

end event

on w_dividi_scadenza_gd_old2.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_dividi_scadenza_gd_old2.destroy
call super::destroy
destroy(this.dw_1)
end on

type p_msg_log from w_data_main`p_msg_log within w_dividi_scadenza_gd_old2
end type

type p_crescente from w_data_main`p_crescente within w_dividi_scadenza_gd_old2
end type

type p_decrescente from w_data_main`p_decrescente within w_dividi_scadenza_gd_old2
end type

type dw_1 from udw_base within w_dividi_scadenza_gd_old2
integer x = 50
integer y = 40
integer width = 4850
integer height = 1636
boolean bringtotop = true
string dataobject = "d_dividi_scadenza_gd"
end type

