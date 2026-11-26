forward
global type w_stp_giorn_magaz_gd from w_stampa_liq_iva1_ff
end type
end forward

global type w_stp_giorn_magaz_gd from w_stampa_liq_iva1_ff
int Width=3694
int Height=2380
boolean TitleBar=true
string Title="Stampa Libro giornale di magazzino"
end type
global w_stp_giorn_magaz_gd w_stp_giorn_magaz_gd

on w_stp_giorn_magaz_gd.create
call super::create
end on

on w_stp_giorn_magaz_gd.destroy
call super::destroy
end on

event open;
dw_1.Height=(this.Height) - 272

long 		ret
string 	ls_filtro,ls_flag
date 		ld_da_data,ld_a_data
Long		ll_id_valuta	
str_giorn_mag str_param

str_param=message.powerobjectparm

ls_flag=str_param.flag
ld_da_data=str_param.da_data
ld_a_data=str_param.a_data
ls_filtro=str_param.filtro
ll_id_valuta	= str_param.id_valuta	

dw_1.settransobject(sqlca)
dw_1.retrieve(ld_da_data,ld_a_data,ls_flag, ll_id_valuta)	

ret=dw_1.setfilter(ls_filtro)
ret=dw_1.filter()
dw_1.groupcalc()
il_zoom=100
this.event post ue_post_open()

end event

type dw_1 from w_stampa_liq_iva1_ff`dw_1 within w_stp_giorn_magaz_gd
int X=32
int Y=184
int Width=3598
int Height=2052
string DataObject="d_stp_giorn_magaz_gd"
end type

event cb_3::clicked;printsetup()
dw_1.print()
end event

