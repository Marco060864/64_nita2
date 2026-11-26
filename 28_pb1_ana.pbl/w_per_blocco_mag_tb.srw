forward
global type w_per_blocco_mag_tb from w_data_main
end type
type cb_ok from commandbutton within w_per_blocco_mag_tb
end type
type cb_annulla from commandbutton within w_per_blocco_mag_tb
end type
type cb_inserisci from commandbutton within w_per_blocco_mag_tb
end type
type cb_cancella from commandbutton within w_per_blocco_mag_tb
end type
type cb_salva from commandbutton within w_per_blocco_mag_tb
end type
type dw_loc_pre_tb from u_dw_main within w_per_blocco_mag_tb
end type
end forward

global type w_per_blocco_mag_tb from w_data_main
int Width=1482
WindowType WindowType=response!
boolean TitleBar=true
string Title="Periodi di Blocco"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
cb_inserisci cb_inserisci
cb_cancella cb_cancella
cb_salva cb_salva
dw_loc_pre_tb dw_loc_pre_tb
end type
global w_per_blocco_mag_tb w_per_blocco_mag_tb

type variables
u_dw_main iudw_data
end variables

on w_per_blocco_mag_tb.create
int iCurrent
call w_data_main::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.dw_loc_pre_tb=create dw_loc_pre_tb
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_ok
this.Control[iCurrent+2]=cb_annulla
this.Control[iCurrent+3]=cb_inserisci
this.Control[iCurrent+4]=cb_cancella
this.Control[iCurrent+5]=cb_salva
this.Control[iCurrent+6]=dw_loc_pre_tb
end on

on w_per_blocco_mag_tb.destroy
call w_data_main::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.dw_loc_pre_tb)
end on

event open;call super::open;
dw_loc_pre_tb.settransobject(sqlca)
dw_loc_pre_tb.retrieve(message.doubleparm)
iudw_data=create u_dw_main

end event

event close;call super::close;destroy iudw_data
end event

type p_crescente from w_data_main`p_crescente within w_per_blocco_mag_tb
boolean BringToTop=true
end type

type p_decrescente from w_data_main`p_decrescente within w_per_blocco_mag_tb
boolean BringToTop=true
end type

type cb_ok from commandbutton within w_per_blocco_mag_tb
int X=1189
int Y=21
int Width=247
int Height=85
int TabOrder=20
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
	end if
end if
if ll_ret=2 or isnull(ll_ret) or ll_ret=0 then
	close(w_per_blocco_mag_tb)	
end if

close(w_per_blocco_mag_tb)

end event

type cb_annulla from commandbutton within w_per_blocco_mag_tb
int X=1189
int Y=201
int Width=247
int Height=85
int TabOrder=30
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
	close(w_per_blocco_mag_tb)	
end if

end event

type cb_inserisci from commandbutton within w_per_blocco_mag_tb
int X=1189
int Y=401
int Width=247
int Height=85
int TabOrder=40
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

type cb_cancella from commandbutton within w_per_blocco_mag_tb
int X=1189
int Y=601
int Width=247
int Height=85
int TabOrder=50
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

type cb_salva from commandbutton within w_per_blocco_mag_tb
int X=1189
int Y=801
int Width=247
int Height=85
int TabOrder=60
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

type dw_loc_pre_tb from u_dw_main within w_per_blocco_mag_tb
int X=23
int Y=21
int Width=1130
int Height=873
int TabOrder=10
string DataObject="d_per_blocco_magazzino_tb"
boolean VScrollBar=true
end type

event itemchanged;call super::itemchanged;
date ldt_data_1
choose case dwo.name
	case "data_inizio"
	if rowcount()>0 and row >1 then
		ldt_data_1 = getitemdate(row - 1, "data_fine")
		if date(data)<= ldt_data_1 or isnull(ldt_data_1) then
			messagebox("Attenzione!", "Valore non valido: i periodi non possono "&
							+"accavallarsi!")		
			setnull(ldt_data_1)
			setitem(row, "data_inizio", ldt_data_1)
			setcolumn("data_inizio")
		end if
	end if
	case "data_fine"
		ldt_data_1 = getitemdate(row, "data_inizio")
		if date(data)<= ldt_data_1 then
			messagebox("Attenzione!", "Valore non valido: la data di fine deve "&
							+"essere maggiore di quella iniziale!")		
			setnull(ldt_data_1)
			setitem(row, "data_fine", ldt_data_1)
			SCROLLTOROW(ROW)
			setcolumn("data_fine")
		end if
end choose
end event

