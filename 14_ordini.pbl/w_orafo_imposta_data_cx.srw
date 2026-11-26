forward
global type w_orafo_imposta_data_cx from Window
end type
type cb_1 from commandbutton within w_orafo_imposta_data_cx
end type
type em_data from editmask within w_orafo_imposta_data_cx
end type
type gb_1 from groupbox within w_orafo_imposta_data_cx
end type
end forward

global type w_orafo_imposta_data_cx from Window
int X=836
int Y=372
int Width=630
int Height=567
boolean TitleBar=true
string Title="Data scadenza massima"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
em_data em_data
gb_1 gb_1
end type
global w_orafo_imposta_data_cx w_orafo_imposta_data_cx

on w_orafo_imposta_data_cx.create
this.cb_1=create cb_1
this.em_data=create em_data
this.gb_1=create gb_1
this.Control[]={ this.cb_1,&
this.em_data,&
this.gb_1}
end on

on w_orafo_imposta_data_cx.destroy
destroy(this.cb_1)
destroy(this.em_data)
destroy(this.gb_1)
end on

event open;em_data.SetFocus()
end event

type cb_1 from commandbutton within w_orafo_imposta_data_cx
int X=171
int Y=279
int Width=281
int Height=106
int TabOrder=10
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(parent,em_data.text)
end event

type em_data from editmask within w_orafo_imposta_data_cx
int X=79
int Y=74
int Width=445
int Height=119
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
string DisplayData=""
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_orafo_imposta_data_cx
int X=33
int Width=548
int Height=445
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

