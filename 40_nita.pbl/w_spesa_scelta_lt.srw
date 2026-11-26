forward
global type w_spesa_scelta_lt from w_wiz_main
end type
type cb_annulla from commandbutton within w_spesa_scelta_lt
end type
type cb_ok from commandbutton within w_spesa_scelta_lt
end type
type dw_spesa_scelta_lt from u_dw_pura within w_spesa_scelta_lt
end type
end forward

global type w_spesa_scelta_lt from w_wiz_main
int X=833
int Y=373
int Width=1550
int Height=1277
WindowType WindowType=response!
boolean TitleBar=true
string Title="Selezione Spese"
cb_annulla cb_annulla
cb_ok cb_ok
dw_spesa_scelta_lt dw_spesa_scelta_lt
end type
global w_spesa_scelta_lt w_spesa_scelta_lt

type variables
s_list_main istr_list
boolean ib_modified=FALSE
string ia_array[]
end variables

event open;call super::open;string ls_spese, ls_spesa
long ll_len, ll_count, ll_row

istr_list = Message.PowerObjectParm
ls_spese = istr_list.s_win_parametri
if IsNull(ls_spese) then ls_spese = ""
ia_array[1]= ls_spese
dw_spesa_scelta_lt.Retrieve()

il_HelpTopic = 1

if not IsNull(ls_spese) then
	ll_len = Len(ls_spese)
	for ll_count = 1 to ll_len
		ls_spesa = Mid(ls_spese, ll_count, 1)
		ll_row = dw_spesa_scelta_lt.Find("codice ='" + ls_spesa + "'", 1, dw_spesa_scelta_lt.RowCount())
		if ll_row > 0 then dw_spesa_scelta_lt.SelectRow(ll_row, true)
	next
end if

end event

on w_spesa_scelta_lt.create
int iCurrent
call w_wiz_main::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_spesa_scelta_lt=create dw_spesa_scelta_lt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_annulla
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=dw_spesa_scelta_lt
end on

on w_spesa_scelta_lt.destroy
call w_wiz_main::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_spesa_scelta_lt)
end on

event close;call super::close;u_freddie.sp_push(ia_array)
end event

type cb_annulla from commandbutton within w_spesa_scelta_lt
int X=458
int Y=1081
int Width=261
int Height=85
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
Close(parent)
end event

type cb_ok from commandbutton within w_spesa_scelta_lt
int X=46
int Y=1081
int Width=261
int Height=85
int TabOrder=20
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_sel_spesa
long ll_row

ls_sel_spesa = ""

ll_row = dw_spesa_scelta_lt.GetSelectedRow(0)
DO while not (IsNull(ll_row) OR ll_row = 0)
	ls_sel_spesa = ls_sel_spesa + dw_spesa_scelta_lt.GetItemString(ll_row, "codice")
	ll_row = dw_spesa_scelta_lt.GetSelectedRow(ll_row)
LOOP
ia_array[1] = ls_sel_spesa

Close(parent)
end event

type dw_spesa_scelta_lt from u_dw_pura within w_spesa_scelta_lt
int X=46
int Y=41
int Width=1436
int Height=1021
int TabOrder=10
string DataObject="d_spesa_scelta_lt"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;SetTransObject(SQLCA)
end event

event clicked;SelectRow(row, not IsSelected(row))
ib_modified = TRUE
end event

