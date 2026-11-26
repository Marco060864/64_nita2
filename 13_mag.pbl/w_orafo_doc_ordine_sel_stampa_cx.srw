forward
global type w_orafo_doc_ordine_sel_stampa_cx from Window
end type
type cb_annulla from commandbutton within w_orafo_doc_ordine_sel_stampa_cx
end type
type cb_ok from commandbutton within w_orafo_doc_ordine_sel_stampa_cx
end type
type st_1 from statictext within w_orafo_doc_ordine_sel_stampa_cx
end type
type plb_seleziona from picturelistbox within w_orafo_doc_ordine_sel_stampa_cx
end type
end forward

global type w_orafo_doc_ordine_sel_stampa_cx from Window
int X=1943
int Y=1093
int Width=1111
int Height=809
boolean TitleBar=true
string Title="Tipo di stampa"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
WindowType WindowType=response!
cb_annulla cb_annulla
cb_ok cb_ok
st_1 st_1
plb_seleziona plb_seleziona
end type
global w_orafo_doc_ordine_sel_stampa_cx w_orafo_doc_ordine_sel_stampa_cx

type variables
long ll_sel

end variables

on w_orafo_doc_ordine_sel_stampa_cx.create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.st_1=create st_1
this.plb_seleziona=create plb_seleziona
this.Control[]={ this.cb_annulla,&
this.cb_ok,&
this.st_1,&
this.plb_seleziona}
end on

on w_orafo_doc_ordine_sel_stampa_cx.destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.plb_seleziona)
end on

event open;plb_seleziona.Selectitem(1)
ll_sel=1
end event

type cb_annulla from commandbutton within w_orafo_doc_ordine_sel_stampa_cx
int X=590
int Y=553
int Width=293
int Height=109
int TabOrder=2
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Closewithreturn(parent,-1)
end event

type cb_ok from commandbutton within w_orafo_doc_ordine_sel_stampa_cx
int X=147
int Y=553
int Width=247
int Height=109
int TabOrder=20
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_ret

ll_ret=CLosewithreturn(parent,ll_sel)
ll_ret=1
end event

type st_1 from statictext within w_orafo_doc_ordine_sel_stampa_cx
int X=23
int Y=25
int Width=1011
int Height=141
boolean Enabled=false
string Text="Seleziona una voce per la stampa degli articoli da allegare"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type plb_seleziona from picturelistbox within w_orafo_doc_ordine_sel_stampa_cx
int X=23
int Y=197
int Width=1011
int Height=317
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean Sorted=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Scheda Articolo con Immagine 1:1",&
"Scheda Articoli Breve",&
"Scheda di lavorazione"}
string PictureName[]={"DataWindow5!"}
int ItemPictureIndex[]={1,&
1,&
1}
long PictureMaskColor=553648127
end type

event selectionchanged;ll_sel=index
end event

event doubleclicked;ll_sel=index
cb_ok.trigger event clicked()
end event

