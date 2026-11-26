forward
global type w_esi_disponibilita_wz from w_wiz_main
end type
type cb_disponibilita from commandbutton within w_esi_disponibilita_wz
end type
type cb_esistenza from commandbutton within w_esi_disponibilita_wz
end type
type dw_esi_disponibilita_sp_lt from u_dw_ext_main within w_esi_disponibilita_wz
end type
type cb_ok from commandbutton within w_esi_disponibilita_wz
end type
end forward

global type w_esi_disponibilita_wz from w_wiz_main
int X=833
int Y=373
int Width=2661
int Height=1141
WindowType WindowType=response!
boolean TitleBar=true
string Title="Esistenza e Disponibilità di Magazzino"
cb_disponibilita cb_disponibilita
cb_esistenza cb_esistenza
dw_esi_disponibilita_sp_lt dw_esi_disponibilita_sp_lt
cb_ok cb_ok
end type
global w_esi_disponibilita_wz w_esi_disponibilita_wz

type variables
s_any_array 	istr_any_array
end variables

on w_esi_disponibilita_wz.create
int iCurrent
call w_wiz_main::create
this.cb_disponibilita=create cb_disponibilita
this.cb_esistenza=create cb_esistenza
this.dw_esi_disponibilita_sp_lt=create dw_esi_disponibilita_sp_lt
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_disponibilita
this.Control[iCurrent+2]=cb_esistenza
this.Control[iCurrent+3]=dw_esi_disponibilita_sp_lt
this.Control[iCurrent+4]=cb_ok
end on

on w_esi_disponibilita_wz.destroy
call w_wiz_main::destroy
destroy(this.cb_disponibilita)
destroy(this.cb_esistenza)
destroy(this.dw_esi_disponibilita_sp_lt)
destroy(this.cb_ok)
end on

event open;call super::open;istr_any_array= Message.PowerObjectParm

dw_esi_disponibilita_sp_lt.Retrieve(istr_any_array.s_array[1], istr_any_array.s_array[2], istr_any_array.s_array[3], istr_any_array.s_array[4])
end event

type cb_disponibilita from commandbutton within w_esi_disponibilita_wz
int X=1943
int Y=41
int Width=348
int Height=85
int TabOrder=40
string Text="&Disponibilita"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;	dw_esi_disponibilita_sp_lt.event ue_loc_dettaglio ("disponibilita")
end event

type cb_esistenza from commandbutton within w_esi_disponibilita_wz
int X=1349
int Y=41
int Width=307
int Height=85
int TabOrder=30
string Text="&Esistenza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_esi_disponibilita_sp_lt.event ue_loc_dettaglio ("esistenza")
end event

type dw_esi_disponibilita_sp_lt from u_dw_ext_main within w_esi_disponibilita_wz
event type integer ue_loc_dettaglio ( string as_tipo )
int X=46
int Y=181
int Width=2538
int Height=841
int TabOrder=10
string DataObject="d_esi_disponibilita_sp_lt"
boolean VScrollBar=true
end type

event ue_loc_dettaglio;call super::ue_loc_dettaglio;
long 				ll_id_locazione, ll_row, ll_size
s_any_array 	lstr_any_array
string			ls_campo
 ls_campo=GetColumnName()
ll_row= GetRow()

IF not(IsNull(ll_row) OR  ll_row=0) AND not(IsNull(as_tipo) OR  as_tipo="") THEN
	ll_id_locazione= GetItemNumber(ll_row, "id_locazione")
	lstr_any_array.s_array= istr_any_array.s_array
	
	ll_size=Upperbound(istr_any_array.s_array)
	lstr_any_array.s_array[ll_size + 1]= ll_id_locazione
	lstr_any_array.s_array[ll_size + 2]= as_tipo
	OpenWithParm(w_esi_disp_locazione_wz,lstr_any_array)
end if
RETURN 0

end event

event ue_key;call super::ue_key;If keyflags = 2 then
	CHOOSE CASE key
		CASE  KeyE!
			event ue_loc_dettaglio ("esistenza")
			return 1
		CASE  KeyD!
			event ue_loc_dettaglio ("disponibilita")
			return 1
	END CHOOSE
end if
end event

event doubleclicked;call super::doubleclicked;CHOOSE CASE dwo.name
	CASE "c_esistenza"
		event ue_loc_dettaglio ("esistenza")
	CASE "c_disponibilita"
		event ue_loc_dettaglio ("disponibilita")
END CHOOSE

end event

event constructor;call super::constructor;SetTrans(SQLCA)
end event

event rowfocuschanged;call super::rowfocuschanged;If GetRow() > 0 then
	SelectRow(0,FALSE)
	SelectRow(GetRow(), TRUE)
end if
end event

type cb_ok from commandbutton within w_esi_disponibilita_wz
int X=46
int Y=41
int Width=261
int Height=85
int TabOrder=20
string Text="Ok"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)
end event

