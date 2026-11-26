forward
global type w_formato_stampa_etichette from Window
end type
type st_30 from statictext within w_formato_stampa_etichette
end type
type st_10 from statictext within w_formato_stampa_etichette
end type
type st_9 from statictext within w_formato_stampa_etichette
end type
type st_28 from statictext within w_formato_stampa_etichette
end type
type st_27 from statictext within w_formato_stampa_etichette
end type
type st_26 from statictext within w_formato_stampa_etichette
end type
type st_25 from statictext within w_formato_stampa_etichette
end type
type st_24 from statictext within w_formato_stampa_etichette
end type
type st_21 from statictext within w_formato_stampa_etichette
end type
type st_20 from statictext within w_formato_stampa_etichette
end type
type st_8 from statictext within w_formato_stampa_etichette
end type
type st_7 from statictext within w_formato_stampa_etichette
end type
type st_6 from statictext within w_formato_stampa_etichette
end type
type st_5 from statictext within w_formato_stampa_etichette
end type
type st_4 from statictext within w_formato_stampa_etichette
end type
type st_3 from statictext within w_formato_stampa_etichette
end type
type st_2 from statictext within w_formato_stampa_etichette
end type
type st_1 from statictext within w_formato_stampa_etichette
end type
type cb_2 from commandbutton within w_formato_stampa_etichette
end type
type cb_3 from commandbutton within w_formato_stampa_etichette
end type
type cb_salva from commandbutton within w_formato_stampa_etichette
end type
type cb_1 from commandbutton within w_formato_stampa_etichette
end type
type dw_1 from datawindow within w_formato_stampa_etichette
end type
end forward

global type w_formato_stampa_etichette from Window
int X=46
int Y=16
int Width=3287
int Height=1444
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_30 st_30
st_10 st_10
st_9 st_9
st_28 st_28
st_27 st_27
st_26 st_26
st_25 st_25
st_24 st_24
st_21 st_21
st_20 st_20
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_3 cb_3
cb_salva cb_salva
cb_1 cb_1
dw_1 dw_1
end type
global w_formato_stampa_etichette w_formato_stampa_etichette

type variables
boolean bl_modified
string is_conf
end variables

on w_formato_stampa_etichette.create
this.st_30=create st_30
this.st_10=create st_10
this.st_9=create st_9
this.st_28=create st_28
this.st_27=create st_27
this.st_26=create st_26
this.st_25=create st_25
this.st_24=create st_24
this.st_21=create st_21
this.st_20=create st_20
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_salva=create cb_salva
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_30,&
this.st_10,&
this.st_9,&
this.st_28,&
this.st_27,&
this.st_26,&
this.st_25,&
this.st_24,&
this.st_21,&
this.st_20,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_3,&
this.cb_salva,&
this.cb_1,&
this.dw_1}
end on

on w_formato_stampa_etichette.destroy
destroy(this.st_30)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_28)
destroy(this.st_27)
destroy(this.st_26)
destroy(this.st_25)
destroy(this.st_24)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_salva)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long ll_found
string query

query = message.StringParm	
is_conf = query
if isnull(is_conf) or is_conf = '' then is_conf = 'default'

dw_1.setTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_1.retrieve(query)

bl_modified = FALSE
end event

event close;if bl_modified then
		integer Res
		
		
		Res = MessageBox("Alert", "Vuoi salvare le modifiche?", Exclamation!, OKCancel!, 2)
		IF Res = 1 THEN
		
			cb_salva.triggerEvent(Clicked!)
		END IF
			
	
	
	
end if

end event

type st_30 from statictext within w_formato_stampa_etichette
int X=2437
int Y=1068
int Width=219
int Height=60
boolean Enabled=false
string Text="simbolo"
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

type st_10 from statictext within w_formato_stampa_etichette
int X=2441
int Y=1132
int Width=247
int Height=72
boolean Enabled=false
string Text="libero"
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

type st_9 from statictext within w_formato_stampa_etichette
int X=2441
int Y=1204
int Width=247
int Height=72
boolean Enabled=false
string Text="libero2"
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

type st_28 from statictext within w_formato_stampa_etichette
int X=2441
int Y=1268
int Width=279
int Height=64
boolean Enabled=false
string Text="des_valuta"
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

type st_27 from statictext within w_formato_stampa_etichette
int X=2107
int Y=1268
int Width=279
int Height=60
boolean Enabled=false
string Text="desc_uc"
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

type st_26 from statictext within w_formato_stampa_etichette
int X=2107
int Y=1204
int Width=279
int Height=60
boolean Enabled=false
string Text="prezzo_p"
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

type st_25 from statictext within w_formato_stampa_etichette
int X=2107
int Y=1132
int Width=279
int Height=60
boolean Enabled=false
string Text="pp_t"
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

type st_24 from statictext within w_formato_stampa_etichette
int X=2107
int Y=1068
int Width=279
int Height=60
boolean Enabled=false
string Text="pc_t"
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

type st_21 from statictext within w_formato_stampa_etichette
int X=1774
int Y=1268
int Width=279
int Height=60
boolean Enabled=false
string Text="cod_barre_t"
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

type st_20 from statictext within w_formato_stampa_etichette
int X=119
int Y=996
int Width=745
int Height=76
boolean Enabled=false
string Text="Le misure sono espresse in mm."
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

type st_8 from statictext within w_formato_stampa_etichette
int X=1463
int Y=992
int Width=553
int Height=76
boolean Enabled=false
string Text="Dati Parametrizzabili:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80659129
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_formato_stampa_etichette
int X=1774
int Y=1204
int Width=247
int Height=60
boolean Enabled=false
string Text="prezzo_t"
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

type st_6 from statictext within w_formato_stampa_etichette
int X=1774
int Y=1132
int Width=306
int Height=60
boolean Enabled=false
string Text="descrizione_t"
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

type st_5 from statictext within w_formato_stampa_etichette
int X=1774
int Y=1068
int Width=247
int Height=60
boolean Enabled=false
string Text="codice_t"
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

type st_4 from statictext within w_formato_stampa_etichette
int X=1472
int Y=1268
int Width=247
int Height=60
boolean Enabled=false
string Text="prezzo"
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

type st_3 from statictext within w_formato_stampa_etichette
int X=1472
int Y=1204
int Width=247
int Height=60
boolean Enabled=false
string Text="cod_barre"
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

type st_2 from statictext within w_formato_stampa_etichette
int X=1472
int Y=1132
int Width=265
int Height=68
boolean Enabled=false
string Text="descrizione"
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

type st_1 from statictext within w_formato_stampa_etichette
int X=1472
int Y=1068
int Width=247
int Height=60
boolean Enabled=false
string Text="codice"
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

type cb_2 from commandbutton within w_formato_stampa_etichette
int X=2775
int Y=1128
int Width=274
int Height=108
int TabOrder=40
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_formato_stampa_etichette
int X=978
int Y=1128
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
config = dw_1.GetItemString(ll_row,"nome_formato")

	LONG LL_RIS
	ll_ris = dw_1.DeleteRow(ll_row)
	ll_ris = dw_1.Update(TRUE)
	if ll_ris<>1 then
		messagebox("Alert","Cancellazione fallita!")
	else
		messagebox("Alert","Cancellazione eseguita!")
		
	end if


end event

type cb_salva from commandbutton within w_formato_stampa_etichette
int X=590
int Y=1128
int Width=334
int Height=108
int TabOrder=50
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

ll_row = dw_1.rowcount()
FOR i=1 TO ll_row
   dw_1.setitem(i,"nome_configurazione",is_conf)
NEXT


ll_ris = dw_1.update(true)
if ll_ris<>1 then
	messagebox("Alert","Salvataggio fallito!")
else
	messagebox("Alert","Salvataggio eseguito!")
	bl_modified = FALSE
end if

end event

type cb_1 from commandbutton within w_formato_stampa_etichette
int X=128
int Y=1128
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

type dw_1 from datawindow within w_formato_stampa_etichette
int X=37
int Y=72
int Width=3191
int Height=884
int TabOrder=10
string DataObject="d_formato_stampa_etichette"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;bl_modified = TRUE
end event

event losefocus;this.acceptText()
end event

