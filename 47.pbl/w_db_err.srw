forward
global type w_db_err from Window
end type
type mle_dettagli from multilineedit within w_db_err
end type
type cb_dettagli from commandbutton within w_db_err
end type
type cb_ok from commandbutton within w_db_err
end type
type mle_1 from multilineedit within w_db_err
end type
type sle_2 from singlelineedit within w_db_err
end type
type sle_1 from singlelineedit within w_db_err
end type
type st_2 from statictext within w_db_err
end type
type st_1 from statictext within w_db_err
end type
end forward

global type w_db_err from Window
int X=833
int Y=361
int Width=1879
int Height=761
boolean TitleBar=true
string Title="Errore nel Database"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
string Icon="Exclamation!"
mle_dettagli mle_dettagli
cb_dettagli cb_dettagli
cb_ok cb_ok
mle_1 mle_1
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_1 st_1
end type
global w_db_err w_db_err

type variables
boolean		ib_dettagli = false
long		il_codici_err[]
string		is_testi_err[]
integer		ii_npar_err[]
end variables

forward prototypes
public function string uf_putargs (ref string as_linea, string as_token[], integer ai_quanti)
public function integer uf_gettoken (string as_linea, ref string as_tok[], integer ai_quanti)
public function string uf_parseodbcstate (string as_input)
end prototypes

public function string uf_putargs (ref string as_linea, string as_token[], integer ai_quanti);

string	ls_linea
integer	li_i
long		ll_ini, ll_fin, ll_lung

ls_linea = ""
ll_ini = 1
ll_fin = 0
ll_lung = len (as_linea)
for li_i = 1 to ai_quanti
	ll_fin = pos (as_linea,"$$$$",ll_ini)
	if ll_fin > 0 then
		ls_linea = ls_linea + mid(as_linea, ll_ini, (ll_fin - ll_ini))
		
		ls_linea = ls_linea + as_token[li_i]
		ll_ini = ll_fin+4
	end if
next
ls_linea = ls_linea + mid(as_linea,ll_ini, ll_lung)

return ls_linea

end function

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

public function string uf_parseodbcstate (string as_input);

integer	li_i
string	ls_odbcstate, ls_c1

li_i = 12
ls_odbcstate = ""
do
	ls_c1 = mid (as_input,li_i,1)
	if ls_c1 >= '0' then
		ls_odbcstate = ls_odbcstate+ls_c1
		li_i ++
	end if
	if li_i > 100 then
		ls_c1 = char(2)
	end if
loop while ls_c1 >= '0'

return ls_odbcstate

end function

on w_db_err.create
this.mle_dettagli=create mle_dettagli
this.cb_dettagli=create cb_dettagli
this.cb_ok=create cb_ok
this.mle_1=create mle_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.mle_dettagli,&
this.cb_dettagli,&
this.cb_ok,&
this.mle_1,&
this.sle_2,&
this.sle_1,&
this.st_2,&
this.st_1}
end on

on w_db_err.destroy
destroy(this.mle_dettagli)
destroy(this.cb_dettagli)
destroy(this.cb_ok)
destroy(this.mle_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;

s_dberr		lstr_dberr
integer		li_i, li_done
string		ls_toks[]
boolean		lb_fatto

lstr_dberr = Message.PowerObjectParm

sle_2.text = string(lstr_dberr.l_sqlcode)
mle_dettagli.text = lstr_dberr.s_sqlerrtext


sle_1.text = uf_parseodbcstate(lstr_dberr.s_sqlerrtext)

lb_fatto = false
for li_i = 1 to u_freddie.ii_maxerr
	if lstr_dberr.l_sqlcode = u_freddie.il_sqlcode[li_i] then
		lb_fatto = true
		li_done = uf_gettoken(lstr_dberr.s_sqlerrtext,ls_toks[],u_freddie.ii_numargs[li_i])
		if li_done >= 0 then
			mle_1.text = uf_putargs(u_freddie.is_mytext[li_i],ls_toks[],u_freddie.ii_numargs[li_i])
		end if
	end if
next
if not lb_fatto then
	mle_1.text = "Errore generale, controllare i dettagli"
end if


end event

type mle_dettagli from multilineedit within w_db_err
int X=46
int Y=661
int Width=1751
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

type cb_dettagli from commandbutton within w_db_err
int X=1500
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
	parent.width = 1870
	parent.height = 1250
	mle_dettagli.visible = true
	this.text = "<< Dettagli"
else
	ib_dettagli = false
	parent.width = 1870
	parent.height = 755
	mle_dettagli.visible = false
	this.text = "Dettagli >>"
end if
end event

type cb_ok from commandbutton within w_db_err
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

type mle_1 from multilineedit within w_db_err
int X=46
int Y=41
int Width=1751
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

type sle_2 from singlelineedit within w_db_err
int X=1500
int Y=421
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

type sle_1 from singlelineedit within w_db_err
int X=343
int Y=421
int Width=293
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

type st_2 from statictext within w_db_err
int X=1143
int Y=429
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

type st_1 from statictext within w_db_err
int X=46
int Y=429
int Width=298
int Height=57
boolean Enabled=false
string Text="Stato ODBC :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

