forward
global type w_imp_list_fab from Window
end type
type cb_1 from commandbutton within w_imp_list_fab
end type
type dw_1 from u_dw_ext_main within w_imp_list_fab
end type
end forward

global type w_imp_list_fab from Window
int X=1051
int Y=480
int Width=1056
int Height=1172
boolean TitleBar=true
string Title="Lista Fabbricanti"
long BackColor=80133307
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
dw_1 dw_1
end type
global w_imp_list_fab w_imp_list_fab

on w_imp_list_fab.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_imp_list_fab.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_run, ls_nomefile, ls_path
boolean lb_esiste
integer li_app, li_eof, li_ret
long ll_row

dw_1.SetTransObject(SQLCA)

select dir_export
into :ls_path
from par_sistema;

ls_path = trim(ls_path)

ls_run = "c:\cometa\listaprl.bat"
li_ret=runsync(ls_run)

lb_esiste=fileexists("lista.lis")
if lb_esiste=true then
	li_app=fileopen("lista.lis")	
	li_eof=0	
	
	do while li_eof<>-100 
		li_eof=fileread(li_app,ls_nomefile)
		if li_eof<>-100 then
			ll_row = dw_1.insertrow(0)
			dw_1.setitem(ll_row,"nomefile",ls_nomefile)
		end if
	loop
	
	fileclose(li_app)	
end if
end event

event close;long i
string ls_nomefile
ls_nomefile = ""

for i = 1 to dw_1.rowCount()
	IF dw_1.IsSelected (i) then	
		ls_nomefile = dw_1.getitemstring(i,"nomefile")
	end if
next

closewithreturn(this,ls_nomefile)
end event

type cb_1 from commandbutton within w_imp_list_fab
int X=398
int Y=972
int Width=247
int Height=92
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

type dw_1 from u_dw_ext_main within w_imp_list_fab
int X=37
int Y=36
int Width=974
int Height=912
int TabOrder=10
string DataObject="d_imp_lis_fab"
end type

event clicked;call super::clicked;this.setrow(row)
this.selectrow(row,true)
end event

