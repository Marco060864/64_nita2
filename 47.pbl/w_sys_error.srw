forward
global type w_sys_error from Window
end type
type dw_error from datawindow within w_sys_error
end type
type cb_stampa from commandbutton within w_sys_error
end type
type cb_esci from commandbutton within w_sys_error
end type
type cb_continua from commandbutton within w_sys_error
end type
end forward

global type w_sys_error from Window
int X=321
int Y=477
int Width=2071
int Height=885
boolean TitleBar=true
string Title="Errore di Sistema"
long BackColor=12632256
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
string Icon="Hand!"
dw_error dw_error
cb_stampa cb_stampa
cb_esci cb_esci
cb_continua cb_continua
end type
global w_sys_error w_sys_error

on w_sys_error.create
this.dw_error=create dw_error
this.cb_stampa=create cb_stampa
this.cb_esci=create cb_esci
this.cb_continua=create cb_continua
this.Control[]={ this.dw_error,&
this.cb_stampa,&
this.cb_esci,&
this.cb_continua}
end on

on w_sys_error.destroy
destroy(this.dw_error)
destroy(this.cb_stampa)
destroy(this.cb_esci)
destroy(this.cb_continua)
end on

event open;dw_error.InsertRow(0)

dw_error.SetItem(1, "errornum", string(Error.Number))
dw_error.SetItem(1, "message", Error.Text)
dw_error.SetItem(1, "where", Error.WindowMenu)
dw_error.SetItem(1, "object", Error.Object)
dw_error.SetItem(1, "event", Error.ObjectEvent)
dw_error.SetItem(1, "line", string(Error.Line))

MessageBox("", Error.Text)
end event

type dw_error from datawindow within w_sys_error
int X=23
int Y=21
int Width=1989
int Height=581
boolean Enabled=false
string DataObject="d_sys_error"
BorderStyle BorderStyle=StyleLowered!
end type

type cb_stampa from commandbutton within w_sys_error
int X=1326
int Y=641
int Width=526
int Height=101
int TabOrder=30
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Riga
Long		ll_Stampa


ll_Stampa = PrintOpen("Errore di Sistema")

Print(ll_Stampa, "Errore di Sistema - " + String(Today()) + " - " + String(Now(), "hh:mm"))
Print(ll_Stampa, " ")

ls_Riga = "       Numero : " + GetItemString(dw_error, 1, 1)
Print(ll_Stampa, ls_Riga)

ls_Riga = "    Messaggio : " + GetItemString(dw_error, 1, 2)
Print(ll_Stampa, ls_Riga)

ls_Riga = "Finestra/Menu : " + GetItemString(dw_error, 1, 3)
Print(ll_Stampa, ls_Riga)

ls_Riga = "      Oggetto : " + GetItemString(dw_error, 1, 4)
Print(ll_Stampa, ls_Riga)

ls_Riga = "       Evento : " + GetItemString(dw_error, 1, 5)
Print(ll_Stampa, ls_Riga)

ls_Riga = "         Riga : " + GetItemString(dw_error, 1, 6)
Print(ll_Stampa, ls_Riga)

PrintClose(ll_Stampa)

end event

type cb_esci from commandbutton within w_sys_error
int X=183
int Y=641
int Width=526
int Height=101
int TabOrder=10
string Text="Esci dal programma"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;HALT CLOSE

end event

type cb_continua from commandbutton within w_sys_error
int X=755
int Y=641
int Width=526
int Height=101
int TabOrder=20
string Text="&Continua"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

