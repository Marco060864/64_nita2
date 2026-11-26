forward
global type w_lista_dich_per_iva_lt from w_list_main
end type
type cb_1 from commandbutton within w_lista_dich_per_iva_lt
end type
end forward

global type w_lista_dich_per_iva_lt from w_list_main
boolean TitleBar=true
string Title="Lista Dichiarazioni Periodiche IVA"
long BackColor=78682240
cb_1 cb_1
end type
global w_lista_dich_per_iva_lt w_lista_dich_per_iva_lt

on w_lista_dich_per_iva_lt.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_lista_dich_per_iva_lt.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;ias_key_name[1] = "id_dich_per_iva"
end event

event resize;
end event

event ue_insert;
end event

type p_crescente from w_list_main`p_crescente within w_lista_dich_per_iva_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_lista_dich_per_iva_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_lista_dich_per_iva_lt
int X=32
int Y=156
int Width=2496
int Height=776
string DataObject="d_dich_per_iva_lt"
end type

event dw_list::ue_init;call super::ue_init;
is_resp_window = "w_dich_per_iva_p2"
end event

event dw_list::ue_insert;
end event

type cb_1 from commandbutton within w_lista_dich_per_iva_lt
int X=23
int Y=20
int Width=741
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="Elabora nuova Dichiarazione"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
open (w_stampa_dich_iva_per_ff)
dw_list.retrieve()

end event

