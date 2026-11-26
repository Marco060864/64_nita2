forward
global type prova from Window
end type
type cb_exp_script from commandbutton within prova
end type
type dw_gest_agg_db_ff from datawindow within prova
end type
end forward

global type prova from Window
int X=833
int Y=361
int Width=2428
int Height=1209
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_exp_script cb_exp_script
dw_gest_agg_db_ff dw_gest_agg_db_ff
end type
global prova prova

event open;dw_gest_agg_db_ff.insertrow(1)
end event

on prova.create
this.cb_exp_script=create cb_exp_script
this.dw_gest_agg_db_ff=create dw_gest_agg_db_ff
this.Control[]={ this.cb_exp_script,&
this.dw_gest_agg_db_ff}
end on

on prova.destroy
destroy(this.cb_exp_script)
destroy(this.dw_gest_agg_db_ff)
end on

type cb_exp_script from commandbutton within prova
int X=110
int Y=589
int Width=385
int Height=93
int TabOrder=2
boolean BringToTop=true
string Text="&Export Script"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
String 	ls_script
Integer	li_ret


		
end event

type dw_gest_agg_db_ff from datawindow within prova
int X=23
int Y=117
int Width=1971
int Height=445
int TabOrder=1
string DataObject="d_gest_agg_db_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

