forward
global type w_imp_list_par from Window
end type
type cb_1 from commandbutton within w_imp_list_par
end type
type dw_1 from u_dw_ext_main within w_imp_list_par
end type
end forward

global type w_imp_list_par from Window
int X=1051
int Y=480
int Width=1280
int Height=1068
boolean TitleBar=true
string Title="Parametrizzazione Listini"
long BackColor=80133307
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
dw_1 dw_1
end type
global w_imp_list_par w_imp_list_par

type variables
string is_fab
end variables

on w_imp_list_par.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_imp_list_par.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_fab, ls_path
integer li_app, li_eof, li_pos, li_len
boolean lb_esiste
string ls_nomefile, ls_codart_pos, ls_codart_num, ls_desart_pos, ls_desart_num, ls_prz_pos, ls_prz_num, ls_iva_pos, ls_iva_num
string ls_codart, ls_desart, ls_prz, ls_iva
long ll_row

dw_1.SetTransObject(SQLCA)
dw_1.insertrow(0)
dw_1.setfocus()
ll_row = dw_1.getrow()

select dir_export
into :ls_path
from par_sistema;

ls_path = trim(ls_path)

is_fab = message.stringparm
is_fab = "c:\cometa\" + is_fab + ".prl"

lb_esiste=fileexists(is_fab)
if lb_esiste=true then
	li_app=fileopen(is_fab)	
	li_eof=0	
	
	do while li_eof<>-100 
		li_eof=fileread(li_app,ls_nomefile)
		li_eof=fileread(li_app,ls_codart)		
		li_eof=fileread(li_app,ls_desart)		
		li_eof=fileread(li_app,ls_prz)		
		li_eof=fileread(li_app,ls_iva)		
	loop
	
	fileclose(li_app)	
	
	li_pos = pos(ls_codart,"-")
	li_len = len(ls_codart)
	if li_pos <= 0 then
		ls_codart_pos = " "
		ls_codart_num = " "
	else
		ls_codart_pos = left  (ls_codart,(li_pos - 1))
		ls_codart_num = right (ls_codart,(li_len - li_pos))
	end if
	
	li_pos = pos(ls_desart,"-")
	li_len = len(ls_desart)
	if li_pos <= 0 then
		ls_desart_pos = " "
		ls_desart_num = " "
	else
		ls_desart_pos = left  (ls_desart,(li_pos - 1))
		ls_desart_num = right (ls_desart,(li_len - li_pos))
	end if	
	
	li_pos = pos(ls_prz,"-")
	li_len = len(ls_prz)
	if li_pos <= 0 then
		ls_prz_pos = " "
		ls_prz_num = " "
	else
		ls_prz_pos = left  (ls_prz,(li_pos - 1))
		ls_prz_num = right (ls_prz,(li_len - li_pos))
	end if		
	
	li_pos = pos(ls_iva,"-")
	li_len = len(ls_iva)
	if li_pos <= 0 then
		ls_iva_pos = " "
		ls_iva_num = " "
	else
		ls_iva_pos = left  (ls_iva,(li_pos - 1))
		ls_iva_num = right (ls_iva,(li_len - li_pos))
	end if	
	
	dw_1.setitem(ll_row,"nomefile",ls_nomefile)
	
	dw_1.setitem(ll_row,"codart_pos",integer(ls_codart_pos))
	dw_1.setitem(ll_row,"codart_num",integer(ls_codart_num))
	
	dw_1.setitem(ll_row,"desart_pos",integer(ls_desart_pos))
	dw_1.setitem(ll_row,"desart_num",integer(ls_desart_num))
	
	dw_1.setitem(ll_row,"prz_pos",integer(ls_prz_pos))
	dw_1.setitem(ll_row,"prz_num",integer(ls_prz_num))
	
	dw_1.setitem(ll_row,"iva_pos",integer(ls_iva_pos))
	dw_1.setitem(ll_row,"iva_num",integer(ls_iva_num))	
end if
end event

event close;integer li_app, li_ret 
long ll_row
string ls_nomefile, ls_codart_pos, ls_codart_num, ls_codart, ls_desart_pos, ls_desart_num, ls_desart
string ls_prz_pos, ls_prz_num, ls_prz, ls_iva_pos, ls_iva_num, ls_iva

ll_row = dw_1.getrow()
dw_1.accepttext()

li_app=fileopen((is_fab),LineMode!,Write!,Shared!,Replace!)

ls_nomefile = dw_1.getitemstring(ll_row,"nomefile")
if isnull(ls_nomefile) then ls_nomefile = ' '
filewrite(li_app,ls_nomefile)	

ls_codart_pos = string(dw_1.getitemnumber(ll_row,"codart_pos"))
if isnull(ls_codart_pos) then ls_codart_pos = ' '
ls_codart_num = string(dw_1.getitemnumber(ll_row,"codart_num"))
if isnull(ls_codart_num) then ls_codart_num = ' '
ls_codart = ls_codart_pos + "-" + ls_codart_num
filewrite(li_app,ls_codart)	

ls_desart_pos = string(dw_1.getitemnumber(ll_row,"desart_pos"))
if isnull(ls_desart_pos) then ls_desart_pos = ' '
ls_desart_num = string(dw_1.getitemnumber(ll_row,"desart_num"))
if isnull(ls_desart_num) then ls_desart_num = ' '
ls_desart = ls_desart_pos + "-" + ls_desart_num
filewrite(li_app,ls_desart)	

ls_prz_pos = string(dw_1.getitemnumber(ll_row,"prz_pos"))
if isnull(ls_prz_pos) then ls_prz_pos = ' '
ls_prz_num = string(dw_1.getitemnumber(ll_row,"prz_num"))
if isnull(ls_prz_num) then ls_prz_num = ' '
ls_prz = ls_prz_pos + "-" + ls_prz_num
filewrite(li_app,ls_prz)	

ls_iva_pos = string(dw_1.getitemnumber(ll_row,"iva_pos"))
if isnull(ls_iva_pos) then ls_iva_pos = ' '
ls_iva_num = string(dw_1.getitemnumber(ll_row,"iva_num"))
if isnull(ls_iva_num) then ls_iva_num = ' '
ls_iva = ls_iva_pos + "-" + ls_iva_num
filewrite(li_app,ls_iva)	

li_ret = fileclose(li_app)

end event

type cb_1 from commandbutton within w_imp_list_par
int X=475
int Y=840
int Width=247
int Height=100
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_imp_list_par
int X=32
int Y=32
int Width=1161
int Height=788
int TabOrder=10
string DataObject="d_imp_lis_par"
end type

