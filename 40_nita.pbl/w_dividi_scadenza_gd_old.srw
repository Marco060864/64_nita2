forward
global type w_dividi_scadenza_gd_old from w_np_single_data
end type
end forward

global type w_dividi_scadenza_gd_old from w_np_single_data
integer width = 4933
integer height = 1508
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_dividi_scadenza_gd_old w_dividi_scadenza_gd_old

type variables
long il_id_scad_originale
end variables

on w_dividi_scadenza_gd_old.create
call super::create
end on

on w_dividi_scadenza_gd_old.destroy
call super::destroy
end on

event open;u_dw_master_main udw_scad

decimal ldc_scad_imp
string ls_imp, ls_err

udw_scad=message.powerobjectparm

udw_scad.rowscopy(1, udw_scad.rowcount(), primary!, dw_single, 1, primary!)

il_id_scad_originale=dw_single.getitemnumber(1, "id_scadenza")

ldc_scad_imp=dw_single.getitemdecimal(1, "scadenza_importo")
ls_imp=string(ldc_scad_imp, "#,0.00")
ls_err=dw_single.modify("t_imp_originale.text='"+ls_imp+"'")
end event

type p_msg_log from w_np_single_data`p_msg_log within w_dividi_scadenza_gd_old
end type

type p_crescente from w_np_single_data`p_crescente within w_dividi_scadenza_gd_old
end type

type p_decrescente from w_np_single_data`p_decrescente within w_dividi_scadenza_gd_old
end type

type dw_single from w_np_single_data`dw_single within w_dividi_scadenza_gd_old
integer x = 37
integer width = 4805
integer height = 1300
string dataobject = "d_dividi_scadenza_gd"
end type

