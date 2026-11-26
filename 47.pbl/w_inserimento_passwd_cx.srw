forward
global type w_inserimento_passwd_cx from Window
end type
type dw_inserimento_passwd_ff from datawindow within w_inserimento_passwd_cx
end type
type cb_annulla from commandbutton within w_inserimento_passwd_cx
end type
type cb_ok from commandbutton within w_inserimento_passwd_cx
end type
end forward

global type w_inserimento_passwd_cx from Window
int X=832
int Y=360
int Width=1358
int Height=676
boolean TitleBar=true
string Title="Cambio Password"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
dw_inserimento_passwd_ff dw_inserimento_passwd_ff
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_inserimento_passwd_cx w_inserimento_passwd_cx

type variables
string   is_passwd, is_nuova, is_colname

end variables

on w_inserimento_passwd_cx.create
this.dw_inserimento_passwd_ff=create dw_inserimento_passwd_ff
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.Control[]={this.dw_inserimento_passwd_ff,&
this.cb_annulla,&
this.cb_ok}
end on

on w_inserimento_passwd_cx.destroy
destroy(this.dw_inserimento_passwd_ff)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;long ll_newrow

is_passwd = Message.StringParm

ll_newrow = This.dw_inserimento_passwd_ff.InsertRow(0) 
This.dw_inserimento_passwd_ff.ScrollToRow(ll_newrow)

If len(is_passwd) > 0 then
	This.dw_inserimento_passwd_ff.Object.old.Visible = True
	This.dw_inserimento_passwd_ff.Object.old_t.visible = True
	This.dw_inserimento_passwd_ff.setColumn("old")
else
	This.dw_inserimento_passwd_ff.Object.old.Visible = False
	This.dw_inserimento_passwd_ff.Object.old_t.Visible = False
	This.dw_inserimento_passwd_ff.setColumn("new")
	
end if
end event

type dw_inserimento_passwd_ff from datawindow within w_inserimento_passwd_cx
event ue_setcolumn ( string as_colname )
int X=69
int Y=180
int Width=1211
int Height=360
int TabOrder=10
string DataObject="d_inserimento_passwd_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_setcolumn;GraphicObject which_control

which_control = GetFocus( ) 
if which_control <> this then
	this.setfocus()
end if

if not isnull(as_colname) then
	if as_colname <> "" then
		this.setcolumn(as_colname)
	end if
end if


end event

event itemchanged;string	ls_Null, ls_old, ls_new, ls_colname
long		ll_row, ll_ret

ll_ret = 0
SetNull(ls_Null)
ll_row = getRow()
ls_colname = dwo.name
if ll_row>0 then
	ls_new = GetItemString(1, "new")
	ls_old = GetItemString(1, "old")
	CHOOSE CASE ls_colname
		CASE "old"
			if (data <> is_passwd) then
				MessageBox("Avvertimento","Vecchia Password errata.")
				SetItem(1,"old",ls_Null)
				is_nuova = "-5"
				ll_ret = 2
				post event ue_setColumn ("old")
			end if
		case "new"
		CASE "retype"
			if ls_new <> data then
				MessageBox("Avvertimento","Password ridigitata sbagliata.")
				SetItem(1,"new",ls_Null)
				SetItem(1,"retype",ls_Null)
				is_nuova = "-5"
				ll_ret = 2
				post event ue_setColumn ("new")
			else
				is_nuova = data
			end if
		case else
			
			messageBox ("Errore","La colonna era "+ls_colname)
	END CHOOSE
else
	
	MessageBox("Errore!","Riga nulla!")
end if

return ll_ret
end event

event itemfocuschanged;
CHOOSE CASE dwo.name
	CASE "old"
		is_colname = "old"
	CASE "new", "retype"
		if is_colname = "old" AND len(is_passwd) > 0 then
			if IsNull(GetItemString(1, "old")) then
				Event ue_setColumn("old")
			end if
		end if
END CHOOSE


end event

type cb_annulla from commandbutton within w_inserimento_passwd_cx
int X=1029
int Y=60
int Width=247
int Height=84
int TabOrder=30
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_nuova = "-10"
CloseWithReturn(w_inserimento_passwd_cx,is_nuova)
end event

type cb_ok from commandbutton within w_inserimento_passwd_cx
int X=69
int Y=60
int Width=247
int Height=84
int TabOrder=20
string Text="&OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_inserimento_passwd_ff.accepttext()
string	ll_new

ll_new = dw_inserimento_passwd_ff.GetItemString(1, "new")

if IsNull(ll_new) Or ll_new = "" then
	if MessageBox("Attenzione","Sto cancellando la password. Si vuole procedere?",&
			Question!, YesNo!) = 1 then
		IF MessageBox("Uscita", "Confermi dati inseriti?", Question!, YesNo!) = 2 THEN
			RETURN 1
		END IF
	else
		RETURN 1
	end if
else
	IF MessageBox("Uscita", "Confermi dati inseriti?", Question!, YesNo!) = 2 THEN
		RETURN 1
	END IF
end if

CloseWithReturn(w_inserimento_passwd_cx,is_nuova)
end event

