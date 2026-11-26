forward
global type w_locazioni_predefinite_tb from w_data_main
end type
type dw_loc_pre_tb from datawindow within w_locazioni_predefinite_tb
end type
type cb_ok from commandbutton within w_locazioni_predefinite_tb
end type
type cb_annulla from commandbutton within w_locazioni_predefinite_tb
end type
type cb_inserisci from commandbutton within w_locazioni_predefinite_tb
end type
type cb_cancella from commandbutton within w_locazioni_predefinite_tb
end type
type cb_salva from commandbutton within w_locazioni_predefinite_tb
end type
end forward

global type w_locazioni_predefinite_tb from w_data_main
int X=517
int Y=5
int Width=2634
WindowType WindowType=response!
boolean TitleBar=true
string Title="Locazioni Predefinite"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_loc_pre_tb dw_loc_pre_tb
cb_ok cb_ok
cb_annulla cb_annulla
cb_inserisci cb_inserisci
cb_cancella cb_cancella
cb_salva cb_salva
end type
global w_locazioni_predefinite_tb w_locazioni_predefinite_tb

on w_locazioni_predefinite_tb.create
int iCurrent
call w_data_main::create
this.dw_loc_pre_tb=create dw_loc_pre_tb
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_loc_pre_tb
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=cb_annulla
this.Control[iCurrent+4]=cb_inserisci
this.Control[iCurrent+5]=cb_cancella
this.Control[iCurrent+6]=cb_salva
end on

on w_locazioni_predefinite_tb.destroy
call w_data_main::destroy
destroy(this.dw_loc_pre_tb)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.cb_salva)
end on

event open;call super::open;
dw_loc_pre_tb.settransobject(sqlca)
dw_loc_pre_tb.retrieve(message.doubleparm)


dw_loc_pre_tb.SetFocus()

end event

event key;call super::key;dw_loc_pre_tb.TriggerEvent("ue_key!")
end event

type p_crescente from w_data_main`p_crescente within w_locazioni_predefinite_tb
boolean BringToTop=true
end type

type p_decrescente from w_data_main`p_decrescente within w_locazioni_predefinite_tb
boolean BringToTop=true
end type

type dw_loc_pre_tb from datawindow within w_locazioni_predefinite_tb
event ue_key pbm_dwnkey
int X=46
int Y=141
int Width=2538
int Height=721
int TabOrder=60
boolean BringToTop=true
string DataObject="d_locazioni_predefinite_gd"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;

Keycode	lk_code
String	ls_nome
Long ll_row
lk_code = key

IF (keyFlags=2) THEN
	CHOOSE CASE lk_code
	CASE Keyadd!
		cb_inserisci.TriggerEvent(Clicked!)
		ll_row = THIS.RowCount()
		dw_loc_pre_tb.SetRow(ll_row)
	
	CASE KeySubtract!
		cb_cancella.TriggerEvent(Clicked!)
		ll_row = THIS.RowCount()
		dw_loc_pre_tb.SetRow(ll_row)
		
	CASE Keys!
		cb_salva.TriggerEvent(Clicked!)
		
	END CHOOSE	
END IF
end event

event rowfocuschanged;
end event

event clicked;dw_loc_pre_tb.scrolltorow(row)

end event

type cb_ok from commandbutton within w_locazioni_predefinite_tb
int X=23
int Y=21
int Width=247
int Height=85
boolean BringToTop=true
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer ll_ret

IF dw_loc_pre_tb.ModifiedCount( )+ dw_loc_pre_tb.deletedCount()> 0 THEN  
	ll_ret=messagebox("Attenzione!", "Ci sono cambiamenti non salvati,"& 
	+" salvare prima di uscire?",question!, yesnocancel!)
	if ll_ret=1 then
		dw_loc_pre_tb.update()
		ll_ret=2
	end if
end if
if LL_ret=2 or isnull(ll_ret) or ll_ret=0 then
	close(w_locazioni_predefinite_tb)	
end if

end event

type cb_annulla from commandbutton within w_locazioni_predefinite_tb
int X=321
int Y=21
int Width=247
int Height=85
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer ll_ret

IF dw_loc_pre_tb.ModifiedCount( )+ dw_loc_pre_tb.deletedCount()> 0 THEN  
	ll_ret=messagebox("Attenzione!", "Ci sono cambiamenti non salvati,"& 
	+" salvare prima di uscire?",question!, yesnocancel!)
	if ll_ret=1 then
		dw_loc_pre_tb.update()
	end if
end if
if LL_ret=2 or isnull(ll_ret) or ll_ret=0 then
	close(w_locazioni_predefinite_tb)	
end if

end event

type cb_inserisci from commandbutton within w_locazioni_predefinite_tb
int X=1623
int Y=21
int Width=247
int Height=85
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_riga_corrente
ll_riga_corrente=dw_loc_pre_tb.insertrow(0)
ll_riga_corrente=dw_loc_pre_tb.setitem(ll_riga_corrente, "id_articolo",message.doubleparm)
if ll_riga_corrente<>1 then
	messagebox("Errore!", "Non è stato trovato l'articolo in oggetto")
end if
end event

type cb_cancella from commandbutton within w_locazioni_predefinite_tb
int X=1966
int Y=21
int Width=247
int Height=85
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_riga_corrente
ll_riga_corrente=dw_loc_pre_tb.getrow()
if ll_riga_corrente>0 then
	dw_loc_pre_tb.deleterow(ll_riga_corrente)
end if
end event

type cb_salva from commandbutton within w_locazioni_predefinite_tb
int X=2309
int Y=21
int Width=247
int Height=85
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer ll_ret
ll_ret=messagebox("Attenzione!", "Vuoi salvare i cambiamenti effettuati?",question!, yesno!)
if ll_ret=1 then
	dw_loc_pre_tb.update()
end if
end event

