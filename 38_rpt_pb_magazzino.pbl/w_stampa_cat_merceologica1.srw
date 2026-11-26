forward
global type w_stampa_cat_merceologica1 from Window
end type
type cb_5 from commandbutton within w_stampa_cat_merceologica1
end type
type cb_4 from commandbutton within w_stampa_cat_merceologica1
end type
type cb_3 from commandbutton within w_stampa_cat_merceologica1
end type
type cb_2 from commandbutton within w_stampa_cat_merceologica1
end type
type cb_1 from commandbutton within w_stampa_cat_merceologica1
end type
type dw_1 from datawindow within w_stampa_cat_merceologica1
end type
end forward

global type w_stampa_cat_merceologica1 from Window
int X=846
int Y=372
int Width=3589
int Height=1132
boolean TitleBar=true
string Title="Stampa Fatturato per Articolo"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_post_open ( )
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_stampa_cat_merceologica1 w_stampa_cat_merceologica1

event ue_post_open;
end event

on w_stampa_cat_merceologica1.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_stampa_cat_merceologica1.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;date da_data, a_data
string ls_da_codice_cat, ls_a_codice_cat, ls_da_codice, ls_a_codice
s_param_articoli s_parametri   
s_parametri=message.powerobjectparm
da_data = s_parametri.da_data
a_data = s_parametri.a_data
ls_da_codice_cat=s_parametri.da_categoria
ls_a_codice_cat=s_parametri.a_categoria
dw_1.settransobject(sqlca)
dw_1.retrieve( ls_da_codice_cat, ls_a_codice_cat,da_data, a_data)




end event

type cb_5 from commandbutton within w_stampa_cat_merceologica1
int X=3063
int Y=44
int Width=251
int Height=108
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_4 from commandbutton within w_stampa_cat_merceologica1
int X=2738
int Y=44
int Width=251
int Height=108
int TabOrder=20
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_3 from commandbutton within w_stampa_cat_merceologica1
int X=1655
int Y=44
int Width=448
int Height=108
int TabOrder=30
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_2 from commandbutton within w_stampa_cat_merceologica1
int X=1143
int Y=44
int Width=448
int Height=108
int TabOrder=40
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_1 from commandbutton within w_stampa_cat_merceologica1
int X=119
int Y=44
int Width=251
int Height=108
int TabOrder=50
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_stampa_cat_merceologica1
int X=23
int Y=196
int Width=3497
int Height=752
int TabOrder=60
string DataObject="d_stampa_cat_merceologica"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

