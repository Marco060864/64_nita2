forward
global type w_stp_sit_ord_scad_sint_gd from w_stampa_liq_iva1_ff
end type
end forward

global type w_stp_sit_ord_scad_sint_gd from w_stampa_liq_iva1_ff
int Width=3694
int Height=2381
boolean TitleBar=true
string Title="Situazione  ordini per scadenze"
end type
global w_stp_sit_ord_scad_sint_gd w_stp_sit_ord_scad_sint_gd

on w_stp_sit_ord_scad_sint_gd.create
call w_stampa_liq_iva1_ff::create
end on

on w_stp_sit_ord_scad_sint_gd.destroy
call w_stampa_liq_iva1_ff::destroy
end on

event open;
dw_1.Height=(this.Height) - 272
long ret
string ls_filtro,ls_flag,ls_parametri
str_fil_flag str_param

str_param=message.powerobjectparm

ls_filtro=str_param.filtro
ls_parametri=str_param.parametri
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_parametri)
ret=dw_1.setfilter(ls_filtro)
ret=dw_1.filter()
dw_1.groupcalc()
il_zoom=100
this.event post ue_post_open()

end event

type dw_1 from w_stampa_liq_iva1_ff`dw_1 within w_stp_sit_ord_scad_sint_gd
int X=37
int Y=185
int Width=3598
int Height=2053
int TabOrder=70
string DataObject="d_sit_ord_scad_sint_gd"
end type

type cb_6 from w_stampa_liq_iva1_ff`cb_6 within w_stp_sit_ord_scad_sint_gd
int TabOrder=50
end type

type cb_5 from w_stampa_liq_iva1_ff`cb_5 within w_stp_sit_ord_scad_sint_gd
int TabOrder=60
end type

type cb_3 from w_stampa_liq_iva1_ff`cb_3 within w_stp_sit_ord_scad_sint_gd
string Text="Stam&pa"
end type

event cb_3::clicked;printsetup()
dw_1.print()
end event

type cb_1 from w_stampa_liq_iva1_ff`cb_1 within w_stp_sit_ord_scad_sint_gd
int TabOrder=80
string Text="&Annulla"
end type

