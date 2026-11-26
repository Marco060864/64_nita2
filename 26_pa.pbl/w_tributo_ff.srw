forward
global type w_tributo_ff from w_p_data
end type
type dw_tributo_ff from u_dw_master_main within w_tributo_ff
end type
end forward

global type w_tributo_ff from w_p_data
int Width=2730
int Height=1245
boolean TitleBar=true
string Title="Tributi"
dw_tributo_ff dw_tributo_ff
end type
global w_tributo_ff w_tributo_ff

on w_tributo_ff.create
int iCurrent
call w_p_data::create
this.dw_tributo_ff=create dw_tributo_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_tributo_ff
end on

on w_tributo_ff.destroy
call w_p_data::destroy
destroy(this.dw_tributo_ff)
end on

event open;call super::open;
il_HelpTopic = 83

idw_master = dw_tributo_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "id_tributo"
end event

type p_crescente from w_p_data`p_crescente within w_tributo_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_tributo_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_tributo_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_tributo_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_tributo_ff
int X=641
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_tributo_ff
int X=1806
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_tributo_ff
int X=2103
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_tributo_ff
int X=2401
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_tributo_ff
int X=92
int Y=1161
int Width=366
int Height=81
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=330
end type

type cb_ricerca from w_p_data`cb_ricerca within w_tributo_ff
boolean BringToTop=true
end type

type dw_tributo_ff from u_dw_master_main within w_tributo_ff
int X=46
int Y=161
int Width=2629
int Height=961
int TabOrder=1
string DataObject="d_tributo_ff"
end type

event ue_init;call super::ue_init;is_title = "Tributi"
end event

event ue_validate_row;call super::ue_validate_row;

long ll_CurrRow, ll_RetVal = 0
date ld_inizio, ld_fine

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ld_inizio = THIS.GetItemDate(ll_CurrRow, "inizio_per_validita")
	ld_fine = THIS.GetItemDate(ll_CurrRow, "fine_per_validita")
	IF NOT (ld_fine >= ld_inizio) THEN
		as_error_text = "Impossibile salvare: la Data Inizio Validità deve essere~rminore o uguale rispetto alla Data Fine Validità."
		ll_RetVal = 1
	END IF
END IF

RETURN ll_RetVal
end event

