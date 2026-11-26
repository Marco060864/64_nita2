forward
global type w_orafo_parametri_stampa_etichette from Window
end type
type cb_4 from commandbutton within w_orafo_parametri_stampa_etichette
end type
type st_1 from statictext within w_orafo_parametri_stampa_etichette
end type
type cb_applica from commandbutton within w_orafo_parametri_stampa_etichette
end type
type cb_3 from commandbutton within w_orafo_parametri_stampa_etichette
end type
type cb_salva from commandbutton within w_orafo_parametri_stampa_etichette
end type
type cb_1 from commandbutton within w_orafo_parametri_stampa_etichette
end type
type dw_1 from datawindow within w_orafo_parametri_stampa_etichette
end type
end forward

global type w_orafo_parametri_stampa_etichette from Window
int X=46
int Y=16
int Width=3259
int Height=1224
boolean TitleBar=true
string Title="Parametri Etichette"
long BackColor=77633680
boolean ControlMenu=true
WindowType WindowType=response!
cb_4 cb_4
st_1 st_1
cb_applica cb_applica
cb_3 cb_3
cb_salva cb_salva
cb_1 cb_1
dw_1 dw_1
end type
global w_orafo_parametri_stampa_etichette w_orafo_parametri_stampa_etichette

type variables
boolean bl_modified
end variables

on w_orafo_parametri_stampa_etichette.create
this.cb_4=create cb_4
this.st_1=create st_1
this.cb_applica=create cb_applica
this.cb_3=create cb_3
this.cb_salva=create cb_salva
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.st_1,&
this.cb_applica,&
this.cb_3,&
this.cb_salva,&
this.cb_1,&
this.dw_1}
end on

on w_orafo_parametri_stampa_etichette.destroy
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.cb_applica)
destroy(this.cb_3)
destroy(this.cb_salva)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.setTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_1.retrieve()
long ll_found
string query
bl_modified = FALSE
query ="nome_configurazione = '" + message.StringParm	+ "'"
ll_found = dw_1.Find(query, 1, dw_1.RowCount())

if ll_found > 0 then
	dw_1.setRow(ll_found)
end if

end event

event close;if bl_modified then
		integer Res
		
		
		Res = MessageBox("Alert", "Vuoi salvare le modifiche?", Exclamation!, OKCancel!, 2)
		IF Res = 1 THEN
		
			cb_salva.triggerEvent(Clicked!)
		END IF
			
	
	
	
end if

end event

type cb_4 from commandbutton within w_orafo_parametri_stampa_etichette
int X=2578
int Y=980
int Width=347
int Height=108
int TabOrder=40
string Text="Non applicare"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string config
config = ""
closewithreturn(w_parametri_stampa_etichette, config)


end event

type st_1 from statictext within w_orafo_parametri_stampa_etichette
int X=37
int Y=988
int Width=832
int Height=76
boolean Enabled=false
string Text="Le misure sono espresse in 1/10 mm."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_applica from commandbutton within w_orafo_parametri_stampa_etichette
int X=2976
int Y=980
int Width=247
int Height=108
int TabOrder=50
string Text="Applica"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_row
string config
ll_row = dw_1.getRow()
config = dw_1.getItemString(LL_ROW,"nome_configurazione")
closewithreturn(w_orafo_parametri_stampa_etichette, config)
end event

type cb_3 from commandbutton within w_orafo_parametri_stampa_etichette
int X=1733
int Y=980
int Width=453
int Height=108
int TabOrder=30
string Text="Cancella config."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row
ll_row = dw_1.getRow()
string config
config = dw_1.GetItemString(ll_row,"nome_configurazione")
if config="default" then
	messageBox("Alert", "La configurazione Default non può essere rimossa")
else
	LONG LL_RIS
	ll_ris = dw_1.DeleteRow(ll_row)
	ll_ris = dw_1.Update(TRUE)
	if ll_ris<>1 then
		messagebox("Alert","Cancellazione fallita!")
	else
		messagebox("Alert","Cancellazione eseguita!")
		
	end if

end if

end event

type cb_salva from commandbutton within w_orafo_parametri_stampa_etichette
int X=1339
int Y=980
int Width=334
int Height=108
int TabOrder=60
string Text="Salva config."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;LONG LL_RIS, ll_row
integer i

ll_ris = dw_1.update(true)
if ll_ris<>1 then
	messagebox("Alert","Salvataggio fallito!")
else
	messagebox("Alert","Salvataggio eseguito!")
	bl_modified = FALSE
end if

end event

type cb_1 from commandbutton within w_orafo_parametri_stampa_etichette
int X=887
int Y=980
int Width=393
int Height=108
int TabOrder=20
string Text="Inserisci config."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_newRow
ll_newRow = dw_1.insertRow(0)
dw_1.SetRow(ll_newRow)
end event

type dw_1 from datawindow within w_orafo_parametri_stampa_etichette
int X=37
int Y=72
int Width=3186
int Height=884
int TabOrder=10
string DataObject="d_parametri_stampa_etichette"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;bl_modified = TRUE
end event

event losefocus;this.acceptText()
end event

