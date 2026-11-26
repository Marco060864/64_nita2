forward
global type w_print_err from Window
end type
type mle_dettagli from multilineedit within w_print_err
end type
type cb_dettagli from commandbutton within w_print_err
end type
type cb_ok from commandbutton within w_print_err
end type
type mle_1 from multilineedit within w_print_err
end type
type sle_2 from singlelineedit within w_print_err
end type
type st_2 from statictext within w_print_err
end type
end forward

global type w_print_err from Window
int X=833
int Y=361
int Width=1486
int Height=749
boolean TitleBar=true
string Title="Errore in fase di stampa "
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
string Icon="Exclamation!"
mle_dettagli mle_dettagli
cb_dettagli cb_dettagli
cb_ok cb_ok
mle_1 mle_1
sle_2 sle_2
st_2 st_2
end type
global w_print_err w_print_err

type variables
boolean		ib_dettagli = false
long		il_codici_err[]
string		is_testi_err[]
integer		ii_npar_err[]
end variables

forward prototypes
public function integer uf_gettoken (string as_linea, ref string as_tok[], integer ai_quanti)
end prototypes

public function integer uf_gettoken (string as_linea, ref string as_tok[], integer ai_quanti);

string	ls_tok
char		lc_c
integer	li_ntk, li_stt
boolean	lb_finito
long		ll_lung, ll_pos


li_ntk = 0
ls_tok = ""
li_stt = 0
ll_pos = 1
lb_finito = false
ll_lung = len(as_linea)
do
	lc_c = mid (as_linea,ll_pos,1)
	choose case li_stt
		case 0		
			if lc_c = "'" then
				li_stt = 1
			end if
		case 1
			if lc_c = "'" then
				li_ntk ++
				as_tok[li_ntk] = ls_tok
				ls_tok = ""
				li_stt = 0
				if li_ntk >= ai_quanti then lb_finito = true
			else
				ls_tok = ls_tok + lc_c
			end if
	end choose
	ll_pos ++
	if ll_pos > ll_lung then lb_finito = true
loop while not lb_finito


return li_ntk

end function

on w_print_err.create
this.mle_dettagli=create mle_dettagli
this.cb_dettagli=create cb_dettagli
this.cb_ok=create cb_ok
this.mle_1=create mle_1
this.sle_2=create sle_2
this.st_2=create st_2
this.Control[]={ this.mle_dettagli,&
this.cb_dettagli,&
this.cb_ok,&
this.mle_1,&
this.sle_2,&
this.st_2}
end on

on w_print_err.destroy
destroy(this.mle_dettagli)
destroy(this.cb_dettagli)
destroy(this.cb_ok)
destroy(this.mle_1)
destroy(this.sle_2)
destroy(this.st_2)
end on

event open;s_printerr	  lstr_err
integer		  li_i, li_done
string		  ls_toks[]
boolean		  lb_fatto


lstr_err = Message.PowerObjectParm



mle_1.text 			=	lstr_err.principale
mle_dettagli.text =lstr_err.dettaglio

sle_2.text			=	string(lstr_err.errore)



end event

type mle_dettagli from multilineedit within w_print_err
int X=46
int Y=661
int Width=1395
int Height=441
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_dettagli from commandbutton within w_print_err
int X=1121
int Y=541
int Width=298
int Height=89
int TabOrder=20
string Text="Dettagli >>"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if not ib_dettagli then
	ib_dettagli = true
	parent.width = 1486
	parent.height = 1250
	mle_dettagli.visible = true
	this.text = "<< Dettagli"
else
	ib_dettagli = false
	parent.width = 1486
	parent.height = 755
	mle_dettagli.visible = false
	this.text = "Dettagli >>"
end if
end event

type cb_ok from commandbutton within w_print_err
int X=755
int Y=541
int Width=293
int Height=89
int TabOrder=10
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)

end event

type mle_1 from multilineedit within w_print_err
int X=46
int Y=41
int Width=1372
int Height=361
BorderStyle BorderStyle=StyleLowered!
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_print_err
int X=1121
int Y=441
int Width=298
int Height=73
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_print_err
int X=732
int Y=441
int Width=357
int Height=57
boolean Enabled=false
string Text="Numero errore :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

