forward
global type w_p_single_data from w_data_main
end type
type dw_single from u_dw_single_main within w_p_single_data
end type
type cb_ok from commandbutton within w_p_single_data
end type
type cb_nuovo from commandbutton within w_p_single_data
end type
type cb_annulla from commandbutton within w_p_single_data
end type
end forward

global type w_p_single_data from w_data_main
int Width=2606
int Height=1557
WindowType WindowType=response!
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_single dw_single
cb_ok cb_ok
cb_nuovo cb_nuovo
cb_annulla cb_annulla
end type
global w_p_single_data w_p_single_data

type variables
end variables

on w_p_single_data.create
int iCurrent
call w_data_main::create
this.dw_single=create dw_single
this.cb_ok=create cb_ok
this.cb_nuovo=create cb_nuovo
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_single
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=cb_nuovo
this.Control[iCurrent+4]=cb_annulla
end on

on w_p_single_data.destroy
call w_data_main::destroy
destroy(this.dw_single)
destroy(this.cb_ok)
destroy(this.cb_nuovo)
destroy(this.cb_annulla)
end on

event open;call super::open;dw_single.is_list = Message.PowerObjectParm
is_wintype = "W_P_SINGLE_DATA"
Message.Processed = true
CHOOSE CASE dw_single.is_list.s_modo
	CASE modo_inserisci
		TriggerEvent("ue_insert")
		cb_nuovo.Visible = TRUE
	CASE modo_modifica
		TriggerEvent("ue_retrieve")
		TriggerEvent("ue_modify")
		cb_nuovo.Visible = FALSE
	CASE modo_visualizza
		TriggerEvent("ue_retrieve")
		dw_single.Enabled = FALSE
		cb_nuovo.Visible = FALSE
END CHOOSE
end event

event close;call super::close;CloseWithReturn(this, is_filter)
end event

event ue_retrieve;call super::ue_retrieve;
end event

event closequery;call super::closequery;if ib_close_query then return dw_single.Ask_For_Save()

end event

type p_crescente from w_data_main`p_crescente within w_p_single_data
boolean BringToTop=true
end type

type p_decrescente from w_data_main`p_decrescente within w_p_single_data
boolean BringToTop=true
end type

type dw_single from u_dw_single_main within w_p_single_data
int X=23
int Y=121
int Width=2538
int Height=1341
int TabOrder=5
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_insert;call super::ue_insert;long ll_newrow
integer li_colNumber

ll_newrow = InsertRow(0) 
ScrollToRow(ll_newrow)

li_colNumber = 1
do while SetColumn(li_colNumber) = -1 AND li_colNumber < 10
	li_colNumber = li_colNumber + 1
loop

end event

event losefocus;
end event

event ue_retrieve;
string s_col_name
integer li_counter
long ll_size

is_filter = ""
ll_size = UpperBound(is_list.s_identifica)
for  li_counter = 1 to ll_size
	is_filter = is_filter + " AND " + is_list.s_identifica[li_counter] + " = " + string(is_list.l_identifica[li_counter])
next
is_filter = Mid(is_filter,5)
SetFilter(is_filter)
Filter( )
Retrieve()
end event

type cb_ok from commandbutton within w_p_single_data
int X=23
int Y=21
int Width=261
int Height=85
int TabOrder=10
boolean BringToTop=true
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row, ll_id
string s_col_name
integer li_counter
long ll_size

parent.TriggerEvent("ue_update")
ll_row = dw_single.GetRow()

is_filter = ""
ll_size = UpperBound(dw_single.is_list.s_identifica)
for  li_counter = 1 to ll_size
	s_col_name = dw_single.is_list.s_identifica[li_counter]
	is_filter = is_filter + " AND " + s_col_name + " = " + string(dw_single.GetItemNumber(ll_row, s_col_name))
next
is_filter = Mid(is_filter,5)
ib_close_query = FALSE
parent.TriggerEvent("close")


end event

type cb_nuovo from commandbutton within w_p_single_data
int X=755
int Y=21
int Width=261
int Height=85
int TabOrder=30
boolean BringToTop=true
string Text="Nuovo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent("ue_update")

parent.TriggerEvent("ue_insert")
dw_single.SetFocus()
end event

type cb_annulla from commandbutton within w_p_single_data
int X=321
int Y=21
int Width=261
int Height=85
int TabOrder=20
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent("close")
end event

