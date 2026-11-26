forward
global type w_stp_giac_consumi_rpt from w_stampa_liq_iva1_ff
end type
end forward

global type w_stp_giac_consumi_rpt from w_stampa_liq_iva1_ff
int Width=3557
int Height=2428
long BackColor=80263581
WindowState WindowState=normal!
end type
global w_stp_giac_consumi_rpt w_stp_giac_consumi_rpt

on w_stp_giac_consumi_rpt.create
call super::create
end on

on w_stp_giac_consumi_rpt.destroy
call super::destroy
end on

event open;dw_1.Height=(this.Height) - 350
s_riep_art str_param
string ls_da_art,ls_a_art
date ld_data

str_param=message.powerobjectparm
ls_da_art=str_param.da_articolo
ls_a_art=str_param.a_articolo
ld_data=str_param.alla_data
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_da_art,ls_a_art,datetime(RelativeDate(ld_data, -28)),datetime(RelativeDate(ld_data, -21)),datetime(RelativeDate(ld_data, -14)),datetime(RelativeDate(ld_data, -7)),datetime(ld_data))
il_zoom=100
this.event post ue_post_open()

end event

type cb_2 from w_stampa_liq_iva1_ff`cb_2 within w_stp_giac_consumi_rpt
int X=2903
end type

type dw_1 from w_stampa_liq_iva1_ff`dw_1 within w_stp_giac_consumi_rpt
int X=37
int Y=184
int Width=3406
int Height=2052
int TabOrder=70
string DataObject="d_giac_consumi"
boolean HScrollBar=false
end type

type cb_6 from w_stampa_liq_iva1_ff`cb_6 within w_stp_giac_consumi_rpt
int TabOrder=50
end type

type cb_5 from w_stampa_liq_iva1_ff`cb_5 within w_stp_giac_consumi_rpt
int TabOrder=60
end type

type cb_3 from w_stampa_liq_iva1_ff`cb_3 within w_stp_giac_consumi_rpt
int X=3159
string Text="Stam&pa"
end type

event cb_3::clicked;printsetup()
dw_1.print()
end event

type cb_1 from w_stampa_liq_iva1_ff`cb_1 within w_stp_giac_consumi_rpt
string Text="&Annulla"
end type

