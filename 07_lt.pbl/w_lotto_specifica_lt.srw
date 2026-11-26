forward
global type w_lotto_specifica_lt from w_list_main
end type
type cb_preview from commandbutton within w_lotto_specifica_lt
end type
type cb_stampa from commandbutton within w_lotto_specifica_lt
end type
end forward

global type w_lotto_specifica_lt from w_list_main
int X=182
int Y=161
int Width=3186
int Height=1181
boolean TitleBar=true
string Title="Lotto specifica"
cb_preview cb_preview
cb_stampa cb_stampa
end type
global w_lotto_specifica_lt w_lotto_specifica_lt

on w_lotto_specifica_lt.create
int iCurrent
call w_list_main::create
this.cb_preview=create cb_preview
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_preview
this.Control[iCurrent+2]=cb_stampa
end on

on w_lotto_specifica_lt.destroy
call w_list_main::destroy
destroy(this.cb_preview)
destroy(this.cb_stampa)
end on

event open;call super::open;ias_key_name[1]="id_lotto"
end event

event resize;cb_preview.y=newheight - 150
cb_stampa.y=newheight - 150
dw_list.Width = newwidth - 80
dw_list.Height = newheight - 200


end event

type p_crescente from w_list_main`p_crescente within w_lotto_specifica_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_lotto_specifica_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_lotto_specifica_lt
int X=22
int Y=33
int Width=3090
int Height=897
int TabOrder=10
string DataObject="d_lotto_lt"
end type

event dw_list::ue_init;call super::ue_init;is_resp_window="w_lotto_specifica_cx"
end event

event dw_list::doubleclicked;call super::doubleclicked;THIS.triggerevent("ue_retrieve")
end event

type cb_preview from commandbutton within w_lotto_specifica_lt
int X=2856
int Y=941
int Width=246
int Height=109
int TabOrder=20
boolean BringToTop=true
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text="Preview" then
  dw_list.object.datawindow.print.preview='yes'
  dw_list.object.datawindow.print.preview.zoom='90'
  this.text="Exit"
else
  dw_list.object.datawindow.print.preview='no'
  this.text="Preview"
end if	
end event

type cb_stampa from commandbutton within w_lotto_specifica_lt
int X=2561
int Y=941
int Width=246
int Height=109
int TabOrder=22
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_list.print()
end event

