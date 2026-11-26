forward
global type w_lotti_prezzo_cx from Window
end type
type cb_1 from commandbutton within w_lotti_prezzo_cx
end type
type dw_2 from datawindow within w_lotti_prezzo_cx
end type
type dw_1 from datawindow within w_lotti_prezzo_cx
end type
end forward

global type w_lotti_prezzo_cx from Window
int X=845
int Y=371
int Width=3061
int Height=1699
boolean TitleBar=true
string Title="Lotti e prezzi"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_lotti_prezzo_cx w_lotti_prezzo_cx

on w_lotti_prezzo_cx.create
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_lotti_prezzo_cx.destroy
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;long ll_id_variazione
string ls_cod

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
if dw_2.retrieve()>0 then
	ll_id_variazione = dw_2.getitemNumber(1,"id_variazione")
	dw_1.retrieve(ll_id_variazione)
	ls_cod = 'Valorizzazione basata sul listino: ' + dw_2.Getitemstring(1,"codice")
	ls_cod = ls_cod +' valido dal '+string(dw_2.getitemdate(1,"variazione_data_inizio"))
	ls_cod = ls_cod +' al '+string(dw_2.getitemdate(1,"variazione_data_fine"))
	dw_1.object.titolo.text = ls_cod
end if

end event

type cb_1 from commandbutton within w_lotti_prezzo_cx
int X=2714
int Y=1469
int Width=252
int Height=83
int TabOrder=20
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type dw_2 from datawindow within w_lotti_prezzo_cx
int X=62
int Y=29
int Width=2900
int Height=282
int TabOrder=10
string DataObject="d_listino_variazione_sl"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;long ll_id_variazione
string ls_cod

ll_id_variazione = this.getitemNumber(row,"id_variazione")
dw_1.retrieve(ll_id_variazione)
ls_cod = 'Valorizzazione basata sul listino: ' + this.Getitemstring(row,"codice")
ls_cod = ls_cod +' valido dal '+string(this.getitemdate(row,"variazione_data_inizio"))
ls_cod = ls_cod +' al '+string(this.getitemdate(row,"variazione_data_fine"))
dw_1.object.titolo.text = ls_cod

	

end event

type dw_1 from datawindow within w_lotti_prezzo_cx
int X=51
int Y=342
int Width=2933
int Height=1091
int TabOrder=20
string DataObject="d_lotti_prezzo_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

