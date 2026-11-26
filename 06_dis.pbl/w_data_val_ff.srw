forward
global type w_data_val_ff from Window
end type
type cb_1 from commandbutton within w_data_val_ff
end type
type dw_1 from u_dw_ext_main within w_data_val_ff
end type
end forward

global type w_data_val_ff from Window
int X=833
int Y=361
int Width=878
int Height=565
boolean TitleBar=true
string Title="Data Validazione Righe"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
dw_1 dw_1
end type
global w_data_val_ff w_data_val_ff

on w_data_val_ff.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_data_val_ff.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.insertrow(1)

end event

event close;dati dat
dw_1.accepttext()
dat.data_inizio=dw_1.getitemdate(1,"data_inizio")
dat.data_fine=dw_1.getitemdate(1,"data_fine")
closewithreturn(this,dat)
end event

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

type cb_1 from commandbutton within w_data_val_ff
int X=298
int Y=361
int Width=247
int Height=89
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_data_val_ff
int X=69
int Y=41
int Width=709
int Height=281
int TabOrder=10
string DataObject="d_data_val_ff"
end type

