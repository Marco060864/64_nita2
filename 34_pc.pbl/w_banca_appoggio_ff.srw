forward
global type w_banca_appoggio_ff from w_p_data
end type
type dw_banca_appoggio_ff from u_dw_master_main within w_banca_appoggio_ff
end type
end forward

global type w_banca_appoggio_ff from w_p_data
int Height=1033
boolean TitleBar=true
string Title="Banca di Appoggio"
dw_banca_appoggio_ff dw_banca_appoggio_ff
end type
global w_banca_appoggio_ff w_banca_appoggio_ff

type variables
string is_w_title
end variables

forward prototypes
public subroutine uf_ricerca ()
end prototypes

public subroutine uf_ricerca ();


w_search_main lw_sm
long ll_id_ban_appoggio
s_ric_param ls_ricpar
string ls_dwcolname[], ls_dbfield[], ls_SQL_cond

idw_master.is_ricpar.s_filter_name = "cod_abi"

ls_dwcolname[1] = "cod_abi"
ls_dwcolname[2] = "den_abi"
ls_dwcolname[3] = "cod_cab"
ls_dwcolname[4] = "den_cab"
ls_dwcolname[5] = "indirizzo"
ls_dwcolname[6] = "cap"
ls_dwcolname[7] = "localita"
ls_dwcolname[8] = "provincia"
ls_dwcolname[9] = "nazione"
ls_dwcolname[10] = "filiale"
ls_dwcolname[11] = "con_interbancaria"

ls_dbfield[1] = "banca_appoggio.cod_abi"
ls_dbfield[2] = "banca_appoggio.den_abi"
ls_dbfield[3] = "banca_appoggio.cod_cab"
ls_dbfield[4] = "banca_appoggio.den_cab"
ls_dbfield[5] = "banca_appoggio.indirizzo"
ls_dbfield[6] = "banca_appoggio.cap"
ls_dbfield[7] = "banca_appoggio.localita"
ls_dbfield[8] = "banca_appoggio.provincia"
ls_dbfield[9] = "banca_appoggio.nazione"
ls_dbfield[10] = "banca_appoggio.filiale"
ls_dbfield[11] = "banca_appoggio.con_interbancaria"

ls_SQL_cond = f_get_SQL_cond(dw_banca_appoggio_ff, dw_banca_appoggio_ff.GetRow(), ls_dwcolname, ls_dbfield)
idw_master.is_ricpar.s_SQL_cond = ls_SQL_cond 
idw_master.is_ricpar.b_asneeded = TRUE

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_banca_appoggio_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_ban_appoggio = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_banca_appoggio"
	idw_master.is_list.l_identifica[1] = ll_id_ban_appoggio
	
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
END IF

idw_master.SetFocus()

end subroutine

event open;call super::open;

long ll_screenh
environment le_env

il_HelpTopic = 82

idw_master = dw_banca_appoggio_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "banca_appoggio.id_banca_appoggio"
is_w_title = "Banca di Appoggio"
ib_NonModale = TRUE

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_banca_appoggio"
	idw_master.is_list.s_modo = modo_inserisci
	
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

end event

on w_banca_appoggio_ff.create
int iCurrent
call w_p_data::create
this.dw_banca_appoggio_ff=create dw_banca_appoggio_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_banca_appoggio_ff
end on

on w_banca_appoggio_ff.destroy
call w_p_data::destroy
destroy(this.dw_banca_appoggio_ff)
end on

event ue_master_delete;call super::ue_master_delete;

IF (idw_master.Event ue_delete(0, 0) = 0) THEN
	
	ib_AskForSave = FALSE
	IF (idw_master.uf_To_Update() > 0) THEN
		IF (idw_master.Event ue_update(0, 0) = 0) THEN
			ib_AskForSave = TRUE
			idw_master.is_list.s_modo = modo_inserisci
			idw_master.Event ue_insert(0, 0)
		END IF
	END IF
END IF
idw_master.SetFocus()
end event

type p_crescente from w_p_data`p_crescente within w_banca_appoggio_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_banca_appoggio_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_banca_appoggio_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_banca_appoggio_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_banca_appoggio_ff
boolean BringToTop=true
end type

event cb_nuovo::clicked;

IF idw_master.uf_to_update() > 0 THEN idw_master.event ue_update (0,0)

idw_master.Reset()
idw_master.is_list.s_modo = modo_inserisci
idw_master.triggerevent("ue_insert")
idw_master.SetFocus()

end event

type cb_inserisci from w_p_data`cb_inserisci within w_banca_appoggio_ff
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_banca_appoggio_ff
int TabOrder=30
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_banca_appoggio_ff
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_banca_appoggio_ff
int X=1623
int Y=1041
int Width=755
int Height=441
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=718
int Height=321
end type

type cb_ricerca from w_p_data`cb_ricerca within w_banca_appoggio_ff
int X=1121
int Width=307
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;

uf_ricerca()
end event

type dw_banca_appoggio_ff from u_dw_master_main within w_banca_appoggio_ff
int X=46
int Y=161
int Width=2318
int TabOrder=10
string DataObject="d_banca_appoggio_ff"
end type

event ue_init;call super::ue_init;is_title = "Banche di Appoggio"
end event

event ue_retrieve;call super::ue_retrieve;
String 		ls_title, ls_sep, ls_space, ls_abi, ls_cab

ls_sep	= "-"
ls_space = " "
ls_abi = uf_get_colval("cod_abi")
ls_cab = uf_get_colval("cod_cab")
IF (IsNull(ls_abi)) THEN
	ls_abi = ls_space
END IF
IF (IsNull(ls_cab)) THEN
	ls_cab = ls_space
END IF
ls_title = ls_abi + ls_sep + ls_cab
Parent.Title = is_w_title + ls_space + ls_title
end event

event itemchanged;call super::itemchanged;
String 		ls_title, ls_sep, ls_space, ls_abi, ls_cab

ls_abi = uf_get_colval("cod_abi")
ls_cab = uf_get_colval("cod_cab")
CHOOSE CASE dwo.Name
	CASE "cod_abi" 
		ls_abi = This.GetText()
	CASE "cod_cab" 
		ls_cab = This.GetText()
	CASE ELSE
		Return
END CHOOSE
ls_sep	= "-"
ls_space = " "
IF (IsNull(ls_abi)) THEN
	ls_abi = ls_space
END IF
IF (IsNull(ls_cab)) THEN
	ls_cab = ls_space
END IF
ls_title = ls_abi + ls_sep + ls_cab
Parent.Title = is_w_title + ls_space + ls_title
end event

