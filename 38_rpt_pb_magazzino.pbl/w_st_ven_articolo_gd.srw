forward
global type w_st_ven_articolo_gd from w_np_single_data
end type
type cb_stampa from commandbutton within w_st_ven_articolo_gd
end type
end forward

global type w_st_ven_articolo_gd from w_np_single_data
int Height=1024
cb_stampa cb_stampa
end type
global w_st_ven_articolo_gd w_st_ven_articolo_gd

on w_st_ven_articolo_gd.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
end on

on w_st_ven_articolo_gd.destroy
call super::destroy
destroy(this.cb_stampa)
end on

type dw_single from w_np_single_data`dw_single within w_st_ven_articolo_gd
int Y=32
string DataObject="d_vendite_per_articolo"
end type

type cb_stampa from commandbutton within w_st_ven_articolo_gd
int X=453
int Y=776
int Width=247
int Height=108
int TabOrder=11
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_single.print()
end event

