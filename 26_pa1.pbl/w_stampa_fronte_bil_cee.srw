forward
global type w_stampa_fronte_bil_cee from w_p_data
end type
type dw_1 from u_dw_master_main within w_stampa_fronte_bil_cee
end type
type cb_1 from commandbutton within w_stampa_fronte_bil_cee
end type
end forward

global type w_stampa_fronte_bil_cee from w_p_data
int Width=2789
int Height=785
dw_1 dw_1
cb_1 cb_1
end type
global w_stampa_fronte_bil_cee w_stampa_fronte_bil_cee

event open;call super::open;idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm


dw_1.retrieve()

end event

on w_stampa_fronte_bil_cee.create
int iCurrent
call w_p_data::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
this.Control[iCurrent+2]=cb_1
end on

on w_stampa_fronte_bil_cee.destroy
call w_p_data::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

type p_crescente from w_p_data`p_crescente within w_stampa_fronte_bil_cee
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_stampa_fronte_bil_cee
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_stampa_fronte_bil_cee
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_stampa_fronte_bil_cee
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_stampa_fronte_bil_cee
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_stampa_fronte_bil_cee
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_stampa_fronte_bil_cee
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_stampa_fronte_bil_cee
boolean Visible=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_stampa_fronte_bil_cee
int Y=1109
int Width=243
int Height=137
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=206
int Height=17
end type

type cb_ricerca from w_p_data`cb_ricerca within w_stampa_fronte_bil_cee
boolean Visible=false
boolean BringToTop=true
end type

type dw_1 from u_dw_master_main within w_stampa_fronte_bil_cee
int X=1
int Y=173
int Width=2753
int Height=509
int TabOrder=10
string DataObject="d_stampa_fronte_bil_cee"
end type

event ue_init;call super::ue_init;is_list.s_colonne_drop[1]="id_azienda"
is_list.s_colonne_drop[2]="id_azienda"
end event

type cb_1 from commandbutton within w_stampa_fronte_bil_cee
int X=2483
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

event clicked;dw_1.print()
end event

