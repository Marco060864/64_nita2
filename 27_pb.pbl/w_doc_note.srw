forward
global type w_doc_note from w_wiz_main
end type
type mle_note from multilineedit within w_doc_note
end type
type cb_annulla from commandbutton within w_doc_note
end type
type cb_ok from commandbutton within w_doc_note
end type
end forward

global type w_doc_note from w_wiz_main
int X=833
int Y=373
int Width=1998
int Height=897
WindowType WindowType=response!
boolean TitleBar=true
string Title="Note"
mle_note mle_note
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_doc_note w_doc_note

type variables
string is_note
end variables

on w_doc_note.create
int iCurrent
call w_wiz_main::create
this.mle_note=create mle_note
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=mle_note
this.Control[iCurrent+2]=cb_annulla
this.Control[iCurrent+3]=cb_ok
end on

on w_doc_note.destroy
call w_wiz_main::destroy
destroy(this.mle_note)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;is_note= Message.StringParm
mle_note.text=is_note 
end event

event resize;mle_note.width=newwidth - 80
mle_note.height=newheight - 170
end event

type mle_note from multilineedit within w_doc_note
int X=46
int Y=41
int Width=1898
int Height=621
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_annulla from commandbutton within w_doc_note
int X=366
int Y=701
int Width=279
int Height=85
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,is_note)
end event

type cb_ok from commandbutton within w_doc_note
int X=46
int Y=701
int Width=279
int Height=85
int TabOrder=20
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
CloseWithReturn(Parent,mle_note.text)

end event

