forward
global type w_rical_peso_componente_cx from w_np_single_data
end type
type cb_aggiorna from commandbutton within w_rical_peso_componente_cx
end type
type sle_nuovo_peso from singlelineedit within w_rical_peso_componente_cx
end type
type sle_vecchio_peso from singlelineedit within w_rical_peso_componente_cx
end type
type st_1 from statictext within w_rical_peso_componente_cx
end type
type st_2 from statictext within w_rical_peso_componente_cx
end type
type cb_annulla from commandbutton within w_rical_peso_componente_cx
end type
type cb_stampa from commandbutton within w_rical_peso_componente_cx
end type
end forward

global type w_rical_peso_componente_cx from w_np_single_data
int Width=2839
int Height=956
WindowType WindowType=response!
boolean TitleBar=true
string Title="Aggiorna Peso in Riga Distinta"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_aggiorna cb_aggiorna
sle_nuovo_peso sle_nuovo_peso
sle_vecchio_peso sle_vecchio_peso
st_1 st_1
st_2 st_2
cb_annulla cb_annulla
cb_stampa cb_stampa
end type
global w_rical_peso_componente_cx w_rical_peso_componente_cx

on w_rical_peso_componente_cx.create
int iCurrent
call super::create
this.cb_aggiorna=create cb_aggiorna
this.sle_nuovo_peso=create sle_nuovo_peso
this.sle_vecchio_peso=create sle_vecchio_peso
this.st_1=create st_1
this.st_2=create st_2
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aggiorna
this.Control[iCurrent+2]=this.sle_nuovo_peso
this.Control[iCurrent+3]=this.sle_vecchio_peso
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_annulla
this.Control[iCurrent+7]=this.cb_stampa
end on

on w_rical_peso_componente_cx.destroy
call super::destroy
destroy(this.cb_aggiorna)
destroy(this.sle_nuovo_peso)
destroy(this.sle_vecchio_peso)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_annulla)
destroy(this.cb_stampa)
end on

event resize;
end event

event open;ib_close_query = TRUE
ib_askforsave = TRUE
is_wintype = "_"					
u_freddie.iw_current = THIS
u_freddie.center_window(this)
This.TriggerEvent("ue_initvar")
ib_openok = f_check_serial(is_serialize)
if ib_openok then
	ib_openok = f_check_win_password(is_password)
end if
if ib_openok then
	
	iuo_msg_log = create uo_msg_log
	
	iuo_msg_log.uf_new_text("Sessione del " + String(Today()) + " - " + String(Now()),2)
	PostEvent("ue_post_open")
else
	
	postevent("ue_close")
end if

idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"

this.y = 100
 
s_ricalcola_distinta s_ric_distinta 
 
s_ric_distinta=message.powerobjectparm


sle_vecchio_peso.text=string(s_ric_distinta.vecchio_peso)
sle_nuovo_peso.text=string(s_ric_distinta.nuovo_peso)

dw_single.retrieve(s_ric_distinta.id_articolo)

cb_aggiorna.triggerevent(clicked!)



end event

type p_crescente from w_np_single_data`p_crescente within w_rical_peso_componente_cx
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_rical_peso_componente_cx
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_rical_peso_componente_cx
int X=27
int Y=160
int Width=2770
int TabOrder=10
string DataObject="d_agg_peso_riga_distinta"
end type

type cb_aggiorna from commandbutton within w_rical_peso_componente_cx
int X=2505
int Y=24
int Width=274
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i, li_righe
decimal ld_peso_vecchio, ld_peso_nuovo, ld_qta
li_righe=dw_single.rowcount()

ld_peso_nuovo=dec(sle_nuovo_peso.text)
for i=1 to li_righe
	ld_peso_vecchio=dw_single.getitemdecimal(i, "peso_netto")
	dw_single.setitem(i, "peso_vecchio", ld_peso_vecchio)
	ld_qta=dw_single.getitemdecimal(i, "quantita")
	dw_single.setitem(i, "peso_netto", ld_qta*ld_peso_nuovo)
next
end event

type sle_nuovo_peso from singlelineedit within w_rical_peso_componente_cx
int X=1573
int Y=48
int Width=416
int Height=92
int TabOrder=50
boolean Enabled=false
boolean BringToTop=true
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_vecchio_peso from singlelineedit within w_rical_peso_componente_cx
int X=814
int Y=48
int Width=361
int Height=92
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_rical_peso_componente_cx
int X=1262
int Y=48
int Width=306
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Nuovo Peso:"
Alignment Alignment=Right!
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

type st_2 from statictext within w_rical_peso_componente_cx
int X=471
int Y=48
int Width=338
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Vecchio Peso:"
Alignment Alignment=Right!
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

type cb_annulla from commandbutton within w_rical_peso_componente_cx
int X=41
int Y=24
int Width=274
int Height=108
int TabOrder=20
boolean BringToTop=true
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

type cb_stampa from commandbutton within w_rical_peso_componente_cx
int X=2112
int Y=24
int Width=274
int Height=108
int TabOrder=60
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
dw_single.Object.DataWindow.Print.preview='yes'
dw_single.print()
dw_single.Object.DataWindow.Print.preview='no'

end event

