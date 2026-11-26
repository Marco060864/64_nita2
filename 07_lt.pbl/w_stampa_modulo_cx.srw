forward
global type w_stampa_modulo_cx from w_p_data
end type
type dw_1 from u_dw_master_main within w_stampa_modulo_cx
end type
type cb_stampa from commandbutton within w_stampa_modulo_cx
end type
end forward

global type w_stampa_modulo_cx from w_p_data
int Width=2611
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
dw_1 dw_1
cb_stampa cb_stampa
end type
global w_stampa_modulo_cx w_stampa_modulo_cx

event open;call super::open;long ll_riga_sel, ll_id_distinta
ll_id_distinta=message.doubleparm
dw_1.retrieve(LL_ID_DISTINTA)
end event

on w_stampa_modulo_cx.create
int iCurrent
call w_p_data::create
this.dw_1=create dw_1
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
this.Control[iCurrent+2]=cb_stampa
end on

on w_stampa_modulo_cx.destroy
call w_p_data::destroy
destroy(this.dw_1)
destroy(this.cb_stampa)
end on

event close;
close(this)
end event

event ue_post_open;
end event

event closequery;
end event

event resize;call super::resize;dw_1.width=this.width - 200
dw_1.height=this.height - 400
end event

type p_crescente from w_p_data`p_crescente within w_stampa_modulo_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_stampa_modulo_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_stampa_modulo_cx
int X=69
boolean Visible=false
boolean BringToTop=true
end type

event cb_ok::clicked;
close (w_stampa_modulo_cx)
end event

type cb_annulla from w_p_data`cb_annulla within w_stampa_modulo_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_stampa_modulo_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_stampa_modulo_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_stampa_modulo_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_stampa_modulo_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_stampa_modulo_cx
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=17
int Width=2323
int Height=1289
boolean Visible=false
boolean Enabled=false
long BackColor=79741120
long TabBackColor=79741120
end type

type cb_ricerca from w_p_data`cb_ricerca within w_stampa_modulo_cx
boolean BringToTop=true
end type

type dw_1 from u_dw_master_main within w_stampa_modulo_cx
int X=69
int Y=141
int Width=2469
int Height=1301
int TabOrder=10
string DataObject="d_stampa_ok_modulo_cp"
boolean HScrollBar=true
boolean VScrollBar=true
end type

type cb_stampa from commandbutton within w_stampa_modulo_cx
int X=69
int Y=41
int Width=261
int Height=85
int TabOrder=1
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer ret
printsetup()
ret=messagebox("Attenzione!","Vuoi davvero stampare?", stopsign!, yesno!)
if ret=1 then
	dw_1.print()
end if
end event

