forward
global type w_stampa_esistenza_cx from Window
end type
type st_pag from statictext within w_stampa_esistenza_cx
end type
type cb_7 from commandbutton within w_stampa_esistenza_cx
end type
type cb_6 from commandbutton within w_stampa_esistenza_cx
end type
type cb_5 from commandbutton within w_stampa_esistenza_cx
end type
type cb_4 from commandbutton within w_stampa_esistenza_cx
end type
type cb_1 from commandbutton within w_stampa_esistenza_cx
end type
type cb_2 from commandbutton within w_stampa_esistenza_cx
end type
type dw_1 from u_dw_ext_main within w_stampa_esistenza_cx
end type
end forward

global type w_stampa_esistenza_cx from Window
int X=5
int Y=5
int Width=3658
int Height=1453
boolean TitleBar=true
string Title="Stampa PDC CEE"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
st_pag st_pag
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_stampa_esistenza_cx w_stampa_esistenza_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4,il_zoom
end variables

forward prototypes
private function string wf_decode_key (string key, integer posizione)
end prototypes

event ue_post_open;this.windowstate=Maximized!
dw_1.Height=(this.Height) - 272
end event

private function string wf_decode_key (string key, integer posizione);

string 		ls_ritorno
long			ll_count
long			ll_lung
long			ll_pos

ll_pos = 0
ls_ritorno = ""
for ll_count = 1 to len(key)
	if mid(key,ll_count,1) = "(" then
		ll_pos = ll_pos + 1
		if ll_pos = Posizione then
			ll_lung = ll_count + 1
			do while mid(key,ll_lung,1) <> ")" 
				ls_ritorno = ls_ritorno + mid(key,ll_lung,1)
				ll_lung = ll_lung + 1 
			loop
		end if
	end if
next
if isnull (ls_ritorno) then ls_ritorno = '0'
return ls_ritorno
end function

event open;il_zoom=100
string	ls_chiave,ls_parsel
long	ret
str_fil_flag str_param
str_param=message.powerobjectparm
ls_chiave = str_param.filtro
ls_parsel=str_param.parametri



dw_1.settransobject(sqlca)
dw_1.object.datawindow.print.preview='yes'
ret = dw_1.retrieve( long(wf_decode_key(ls_chiave,1)),&
							long(wf_decode_key(ls_chiave,2)),&
							long(wf_decode_key(ls_chiave,3)),&
							wf_decode_key(ls_chiave,4),&
							wf_decode_key(ls_chiave,5),&
							wf_decode_key(ls_chiave,6),&
							wf_decode_key(ls_chiave,7),&
							wf_decode_key(ls_chiave,8),&
							wf_decode_key(ls_chiave,9),ls_parsel )

ST_PAG.text = string(ret / 4)+" Pagine "+string(ret)+" Righe" 

this.event post ue_post_open()
end event

on w_stampa_esistenza_cx.create
this.st_pag=create st_pag
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={ this.st_pag,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_stampa_esistenza_cx.destroy
destroy(this.st_pag)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type st_pag from statictext within w_stampa_esistenza_cx
int X=1335
int Y=41
int Width=869
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_7 from commandbutton within w_stampa_esistenza_cx
event clicked pbm_bnclicked
int X=2506
int Y=41
int Width=261
int Height=85
int TabOrder=11
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_esistenza_cx
event clicked pbm_bnclicked
int X=2231
int Y=41
int Width=261
int Height=85
int TabOrder=30
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_esistenza_cx
event clicked pbm_bnclicked
int X=353
int Y=41
int Width=467
int Height=85
int TabOrder=40
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_esistenza_cx
event clicked pbm_bnclicked
int X=833
int Y=41
int Width=467
int Height=85
int TabOrder=50
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_1 from commandbutton within w_stampa_esistenza_cx
int X=3388
int Y=41
int Width=247
int Height=85
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_2 from commandbutton within w_stampa_esistenza_cx
event clicked pbm_bnclicked
int X=23
int Y=41
int Width=247
int Height=85
int TabOrder=20
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_stampa_esistenza_cx
int X=23
int Y=141
int Width=3612
int Height=1181
int TabOrder=60
string DataObject="d_stampa_esistenza"
boolean HScrollBar=true
boolean VScrollBar=true
end type

