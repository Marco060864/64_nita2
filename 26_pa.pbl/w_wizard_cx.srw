forward
global type w_wizard_cx from w_p_data
end type
type dw_wizard_ff from u_dw_master_main within w_wizard_cx
end type
type dw_par_wizard_gd from u_dw_master_main within w_wizard_cx
end type
end forward

type str_pwd from structure
	string		s_pwd
end type

global type w_wizard_cx from w_p_data
int Width=2187
int Height=1476
boolean TitleBar=true
string Title="Wizard"
dw_wizard_ff dw_wizard_ff
dw_par_wizard_gd dw_par_wizard_gd
end type
global w_wizard_cx w_wizard_cx

type variables
public str_pwd istr_pwd
end variables

on w_wizard_cx.create
int iCurrent
call w_p_data::create
this.dw_wizard_ff=create dw_wizard_ff
this.dw_par_wizard_gd=create dw_par_wizard_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_wizard_ff
this.Control[iCurrent+2]=dw_par_wizard_gd
end on

on w_wizard_cx.destroy
call w_p_data::destroy
destroy(this.dw_wizard_ff)
destroy(this.dw_par_wizard_gd)
end on

event open;long ll_RetVal
string ls_pwd
s_any_array lstr_any_array

idw_master = dw_wizard_ff
idw_master.is_list = Message.PowerObjectParm
Message.Processed = TRUE

OpenWithParm(w_wizard_pwd_ff, lstr_any_array)
lstr_any_array = Message.PowerObjectParm
Message.Processed = TRUE

ls_pwd = lstr_any_array.s_array[1]

IF ls_pwd = "cometa" THEN
	idw_master.ib_use_scanner = TRUE
	idw_master.is_list.s_sql_ident[1] = "wizard.id_wizard"
	Message.PowerObjectParm = idw_master.is_list
	ll_RetVal = Super::Event Open()
	
	RETURN ll_RetVal
ELSE
	MessageBox("Wizard", "Password errata.")
	Close(THIS)
END IF
end event

type p_crescente from w_p_data`p_crescente within w_wizard_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_wizard_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_wizard_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_wizard_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_wizard_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_wizard_cx
int X=1281
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_wizard_cx
int X=1576
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_wizard_cx
int X=1874
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_wizard_cx
int X=1074
int Y=20
int Width=249
int Height=119
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=15
int Y=90
int Width=221
int Height=17
end type

type cb_ricerca from w_p_data`cb_ricerca within w_wizard_cx
boolean BringToTop=true
end type

type dw_wizard_ff from u_dw_master_main within w_wizard_cx
int X=43
int Y=161
int Width=2088
int Height=692
int TabOrder=10
string DataObject="d_wizard_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_wizard"
iudw_children[1] = dw_par_wizard_gd
is_title = "Wizard"
end event

type dw_par_wizard_gd from u_dw_master_main within w_wizard_cx
int X=43
int Y=881
int Width=2088
int Height=471
int TabOrder=3
string DataObject="d_par_wizard_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title = "Parametri Wizard"
is_list.s_identifica[1] = "id_wizard"
end event

event ue_default;call super::ue_default;

long ll_CurrRow, ll_max_numero

CHOOSE CASE string(adwo_current.name)
	CASE "num_ordine"
		ll_CurrRow = dw_par_wizard_gd.GetRow()
		ll_max_numero = dw_par_wizard_gd.GetItemNumber(ll_CurrRow, "max_numero")
		IF IsNull(ll_max_numero) THEN ll_max_numero = 0
		dw_par_wizard_gd.SetItem(ll_CurrRow, "num_ordine", (ll_max_numero + 1))
END CHOOSE

end event

