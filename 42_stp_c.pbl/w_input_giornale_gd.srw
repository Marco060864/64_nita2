forward
global type w_input_giornale_gd from Window
end type
type dw_1 from u_dw_ext_main within w_input_giornale_gd
end type
type cb_ok from commandbutton within w_input_giornale_gd
end type
type st_1 from statictext within w_input_giornale_gd
end type
end forward

global type w_input_giornale_gd from Window
int X=1056
int Y=484
int Width=1755
int Height=572
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
dw_1 dw_1
cb_ok cb_ok
st_1 st_1
end type
global w_input_giornale_gd w_input_giornale_gd

on w_input_giornale_gd.create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.cb_ok,&
this.st_1}
end on

on w_input_giornale_gd.destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.st_1)
end on

event open;dw_1.insertrow(1)
end event

type dw_1 from u_dw_ext_main within w_input_giornale_gd
int X=37
int Y=128
int Width=1655
int Height=188
int TabOrder=10
string DataObject="d_input_giornale_ex"
end type

type cb_ok from commandbutton within w_input_giornale_gd
int X=649
int Y=356
int Width=279
int Height=88
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;st_lib_giornale lst_lib_giornale
dw_1.accepttext()	
lst_lib_giornale.sdt_a_data=dw_1.getitemdate(1, "ult_data_st")
lst_lib_giornale.sd_riporto=dw_1.getitemdecimal(1,"riporto")
lst_lib_giornale.sl_ult_progressivo=dw_1.getitemnumber(1,"ult_progressivo_st")

if isnull(lst_lib_giornale.sdt_a_data) or isnull(lst_lib_giornale.sd_riporto) or isnull(lst_lib_giornale.sl_ult_progressivo) then
	messagebox("Attenzione!", "Dati incompleti!")
	return
end if
closewithreturn(parent,  lst_lib_giornale)
end event

type st_1 from statictext within w_input_giornale_gd
int X=37
int Y=32
int Width=1655
int Height=76
boolean Enabled=false
string Text="Inserire i dati dell'ultima registrazione stampata correttamente"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

