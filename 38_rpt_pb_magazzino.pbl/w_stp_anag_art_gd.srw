forward
global type w_stp_anag_art_gd from w_stampa_liq_iva1_ff
end type
end forward

global type w_stp_anag_art_gd from w_stampa_liq_iva1_ff
int Width=3694
int Height=2381
end type
global w_stp_anag_art_gd w_stp_anag_art_gd

on w_stp_anag_art_gd.create
call w_stampa_liq_iva1_ff::create
end on

on w_stp_anag_art_gd.destroy
call w_stampa_liq_iva1_ff::destroy
end on

event open;
dw_1.Height=(this.Height) - 272
long ret
str_anag_art str_param
string ls_filtro,ls_flag,ls_parametri,ls_da_art,ls_a_art
str_param=message.powerobjectparm
ls_flag=str_param.flag
ls_filtro=str_param.filtro
ls_parametri=str_param.parametri
ls_da_art=str_param.da_art
ls_a_art=str_param.a_art
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_flag,ls_parametri,ls_da_art,ls_a_art)
ret=dw_1.setfilter(ls_filtro)
ret=dw_1.filter()
dw_1.groupcalc()
il_zoom=100
this.event post ue_post_open()

end event

type dw_1 from w_stampa_liq_iva1_ff`dw_1 within w_stp_anag_art_gd
int X=37
int Y=185
int Width=3598
int Height=2053
int TabOrder=70
string DataObject="d_stampa_anag_art2_ff"
end type

type cb_6 from w_stampa_liq_iva1_ff`cb_6 within w_stp_anag_art_gd
int TabOrder=50
end type

type cb_5 from w_stampa_liq_iva1_ff`cb_5 within w_stp_anag_art_gd
int TabOrder=60
end type

type cb_3 from w_stampa_liq_iva1_ff`cb_3 within w_stp_anag_art_gd
string Text="Stam&pa"
end type

event cb_3::clicked;printsetup()
dw_1.print()
end event

type cb_1 from w_stampa_liq_iva1_ff`cb_1 within w_stp_anag_art_gd
int TabOrder=80
string Text="&Annulla"
end type

