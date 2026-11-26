forward
global type w_stp_mag_val_gd from Window
end type
type cb_7 from commandbutton within w_stp_mag_val_gd
end type
type cb_6 from commandbutton within w_stp_mag_val_gd
end type
type cb_5 from commandbutton within w_stp_mag_val_gd
end type
type cb_4 from commandbutton within w_stp_mag_val_gd
end type
type dw_1 from datawindow within w_stp_mag_val_gd
end type
type cb_3 from commandbutton within w_stp_mag_val_gd
end type
type cb_1 from commandbutton within w_stp_mag_val_gd
end type
end forward

global type w_stp_mag_val_gd from Window
int X=5
int Y=365
int Width=3676
int Height=1529
boolean TitleBar=true
string Title="Stampa Listini"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stp_mag_val_gd w_stp_mag_val_gd

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
long row,i

row=dw_1.rowcount()

end event

event open;

string ls_filtro,ls_parametri,ls_costo
date ld_data
str_mag_val str_param
str_param=message.powerobjectparm
ls_filtro=str_param.filtro
ls_parametri=str_param.parametri
ld_data=str_param.data
ls_costo=str_param.costo
dw_1.settransobject(sqlca)
String 	ls_car_fiscali, ls_sca_fiscali, ls_ord_clienti, ls_ord_fornitori, ls_vis_clienti
String	ls_vis_fornitori, ls_imp_produzione, ls_ord_produzione, ls_cl_clienti, ls_cl_fornitori
String 	ls_gr_lib_1, ls_gr_lib_2, ls_gr_lib_3, ls_gr_lib_4

Decimal 	ld_esistenza
Integer	li_car_fiscali, li_sca_fiscali, li_ord_clienti, li_ord_fornitori, li_vis_clienti
Integer	li_vis_fornitori, li_imp_produzione, li_ord_produzione, li_cl_clienti
Integer	li_cl_fornitori, li_gr_lib_1, li_gr_lib_2, li_gr_lib_3, li_gr_lib_4, li_id_magazzino








SELECT	car_fiscali, sca_fiscali, ord_clienti, ord_fornitori, vis_clienti, vis_fornitori,
         imp_produzione, ord_produzione, cl_clienti, cl_fornitori, gr_lib_1, gr_lib_2,
         gr_lib_3, gr_lib_4
INTO		:ls_car_fiscali, :ls_sca_fiscali, :ls_ord_clienti, :ls_ord_fornitori, :ls_vis_clienti, 
			:ls_vis_fornitori, :ls_imp_produzione, :ls_ord_produzione, :ls_cl_clienti, 
			:ls_cl_fornitori, :ls_gr_lib_1, :ls_gr_lib_2, :ls_gr_lib_3, :ls_gr_lib_4
FROM     par_esistenza
;

	

li_car_fiscali = 0

If ls_car_fiscali='+' Then
	li_car_fiscali=1
elseif ls_car_fiscali='-' Then
   li_car_fiscali=-1
End If

li_sca_fiscali=0
If ls_sca_fiscali='+' Then
	li_sca_fiscali=1
elseif ls_sca_fiscali='-' Then
	li_sca_fiscali=-1
End If


If (not IsNull(ls_ord_clienti)) Then
	If ls_ord_clienti='+' Then
   	li_ord_clienti=1
	else
      li_ord_clienti=-1
	End If
Else
   li_ord_clienti=0
End If

If (not IsNull(ls_ord_fornitori)) Then
	If ls_ord_fornitori='+' Then
   	li_ord_fornitori=1
	else
      li_ord_fornitori=-1
	End If
Else
   li_ord_fornitori=0
End If

If (not IsNull(ls_vis_clienti)) Then
	If ls_vis_clienti='+' Then
   	li_vis_clienti=1
	else
      li_vis_clienti=-1
	End If
Else
   li_vis_clienti=0
End If

If (not IsNull(ls_vis_fornitori)) Then
	If ls_vis_fornitori='+' Then
   	li_vis_fornitori=1
	else
      li_vis_fornitori=-1
	End If
Else
   li_vis_fornitori=0
End If

If (not IsNull(ls_imp_produzione)) Then
	If ls_imp_produzione='+' Then
   	li_imp_produzione=1
	else
      li_imp_produzione=-1
	End If
Else
   li_imp_produzione=0
End If

If (not IsNull(ls_ord_produzione)) Then
	If ls_ord_produzione='+' Then
   	li_ord_produzione=1
	else
      li_ord_produzione=-1
	End If
Else
   li_ord_produzione=0
End If

If (not IsNull(ls_cl_clienti)) Then
	If ls_cl_clienti='+' Then
   	li_cl_clienti=1
	else
      li_cl_clienti=-1
	End If
Else
   li_cl_clienti=0
End If

If (not IsNull(ls_cl_fornitori)) Then
	If ls_cl_fornitori='+' Then
   	li_cl_fornitori=1
	else
      li_cl_fornitori=-1
	End If
Else
   li_cl_fornitori=0
End If
  
If (not IsNull(ls_gr_lib_1)) Then
	If ls_gr_lib_1='+' Then
   	li_gr_lib_1=1
	else
      li_gr_lib_1=-1
	End If
Else
   li_gr_lib_1=0
End If

If (not IsNull(ls_gr_lib_1)) Then
	If ls_gr_lib_1='+' Then
   	li_gr_lib_1=1
	else
      li_gr_lib_1=-1
	End If
Else
   li_gr_lib_1=0
End If



dw_1.retrieve(ls_parametri,ld_data,ls_costo,li_car_fiscali,li_sca_fiscali,li_ord_clienti,li_ord_fornitori,li_vis_clienti,li_vis_fornitori,li_imp_produzione,li_ord_produzione,li_cl_clienti,li_cl_fornitori,li_gr_lib_1,li_gr_lib_2,li_gr_lib_3,li_gr_lib_4)
dw_1.setfilter(ls_filtro)
dw_1.filter()


il_zoom=100
this.event post ue_post_open()
dw_1.groupcalc()
end event

on w_stp_mag_val_gd.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={ this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stp_mag_val_gd.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_7 from commandbutton within w_stp_mag_val_gd
event clicked pbm_bnclicked
int X=2506
int Y=41
int Width=261
int Height=85
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stp_mag_val_gd
event clicked pbm_bnclicked
int X=2231
int Y=41
int Width=261
int Height=85
int TabOrder=40
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stp_mag_val_gd
int X=682
int Y=41
int Width=467
int Height=85
int TabOrder=50
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stp_mag_val_gd
int X=1162
int Y=41
int Width=467
int Height=85
int TabOrder=20
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_stp_mag_val_gd
int X=28
int Y=173
int Width=3612
int Height=1261
int TabOrder=60
string DataObject="d_mag_val_gd"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_stp_mag_val_gd
int X=3388
int Y=41
int Width=247
int Height=85
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_stp_mag_val_gd
int X=23
int Y=41
int Width=247
int Height=85
int TabOrder=70
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

