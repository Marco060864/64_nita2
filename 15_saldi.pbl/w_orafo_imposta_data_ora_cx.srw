forward
global type w_orafo_imposta_data_ora_cx from Window
end type
type cb_2 from commandbutton within w_orafo_imposta_data_ora_cx
end type
type em_ora from editmask within w_orafo_imposta_data_ora_cx
end type
type st_2 from statictext within w_orafo_imposta_data_ora_cx
end type
type st_1 from statictext within w_orafo_imposta_data_ora_cx
end type
type cb_1 from commandbutton within w_orafo_imposta_data_ora_cx
end type
type em_data from editmask within w_orafo_imposta_data_ora_cx
end type
type gb_1 from groupbox within w_orafo_imposta_data_ora_cx
end type
end forward

global type w_orafo_imposta_data_ora_cx from Window
int X=836
int Y=372
int Width=801
int Height=676
boolean TitleBar=true
string Title="Data - Ora chiusura scheda"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
em_ora em_ora
st_2 st_2
st_1 st_1
cb_1 cb_1
em_data em_data
gb_1 gb_1
end type
global w_orafo_imposta_data_ora_cx w_orafo_imposta_data_ora_cx

on w_orafo_imposta_data_ora_cx.create
this.cb_2=create cb_2
this.em_ora=create em_ora
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.em_data=create em_data
this.gb_1=create gb_1
this.Control[]={ this.cb_2,&
this.em_ora,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.em_data,&
this.gb_1}
end on

on w_orafo_imposta_data_ora_cx.destroy
destroy(this.cb_2)
destroy(this.em_ora)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.em_data)
destroy(this.gb_1)
end on

event open;string ls_data_ora, ls_data, ls_ora
integer li_pos


ls_data_ora=Message.StringParm
li_pos=Pos(ls_data_ora,' ')
ls_data=Left(ls_data_ora,li_pos -1)
ls_ora=Right(ls_data_ora,len(ls_data_ora)- li_pos)


em_data.text=ls_data
em_ora.text=ls_ora
em_data.SetFocus()

end event

type cb_2 from commandbutton within w_orafo_imposta_data_ora_cx
int X=417
int Y=436
int Width=289
int Height=84
int TabOrder=11
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)
end event

type em_ora from editmask within w_orafo_imposta_data_ora_cx
int X=267
int Y=196
int Width=399
int Height=81
int TabOrder=30
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm:ss"
MaskDataType MaskDataType=TimeMask!
string DisplayData=""
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_orafo_imposta_data_ora_cx
int X=54
int Y=205
int Width=193
int Height=77
boolean Enabled=false
string Text="Ora:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_orafo_imposta_data_ora_cx
int X=54
int Y=87
int Width=193
int Height=77
boolean Enabled=false
string Text="Data:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_orafo_imposta_data_ora_cx
int X=89
int Y=436
int Width=264
int Height=84
int TabOrder=10
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(parent,em_data.text+' '+em_ora.text)
end event

type em_data from editmask within w_orafo_imposta_data_ora_cx
int X=267
int Y=77
int Width=399
int Height=81
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
string DisplayData=""
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_orafo_imposta_data_ora_cx
int X=33
int Width=729
int Height=554
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

