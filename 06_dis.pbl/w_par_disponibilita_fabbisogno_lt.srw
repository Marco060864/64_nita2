forward
global type w_par_disponibilita_fabbisogno_lt from Window
end type
type cb_1 from commandbutton within w_par_disponibilita_fabbisogno_lt
end type
type dw_1 from datawindow within w_par_disponibilita_fabbisogno_lt
end type
end forward

global type w_par_disponibilita_fabbisogno_lt from Window
int X=833
int Y=361
int Width=2574
int Height=1309
boolean TitleBar=true
string Title="Parametri di Disponibilità"
long BackColor=79741120
WindowType WindowType=response!
cb_1 cb_1
dw_1 dw_1
end type
global w_par_disponibilita_fabbisogno_lt w_par_disponibilita_fabbisogno_lt

on w_par_disponibilita_fabbisogno_lt.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_par_disponibilita_fabbisogno_lt.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_1 from commandbutton within w_par_disponibilita_fabbisogno_lt
int X=46
int Y=41
int Width=247
int Height=89
int TabOrder=1
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_disponibilita,ll_row
if dw_1.rowcount()>0 then
ll_row=dw_1.getrow()
if ll_row>0 then
else
	ll_row=1
end if
ll_disponibilita=dw_1.getitemnumber(ll_row,"id_par_disponibilita")
closewithreturn(parent,ll_disponibilita)
else
	close(parent)
end if
end event

type dw_1 from datawindow within w_par_disponibilita_fabbisogno_lt
int X=46
int Y=161
int Width=2469
int Height=1021
int TabOrder=1
string DataObject="d_par_disponibilita_lt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

