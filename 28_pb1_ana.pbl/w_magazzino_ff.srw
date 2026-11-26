forward
global type w_magazzino_ff from w_p_data
end type
type dw_magazzino_ff from u_dw_master_main within tabpage_1
end type
type dw_magazzino_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_locazione_gd from u_dw_master_main within tabpage_2
end type
type cb_1 from commandbutton within w_magazzino_ff
end type
type tabpage_2 from userobject within tab_1
dw_locazione_gd dw_locazione_gd
end type
end forward

global type w_magazzino_ff from w_p_data
int Width=2529
int Height=1489
boolean TitleBar=true
string Title="Magazzino"
cb_1 cb_1
end type
global w_magazzino_ff w_magazzino_ff

type variables
boolean		ib_fix_id

end variables

event open;call super::open;il_HelpTopic = 109

idw_master = tab_1.tabpage_1.dw_magazzino_ff
idw_master.is_list = Message.PowerObjectParm

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_magazzino"
	idw_master.is_list.s_modo=modo_inserisci
end if

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "magazzino.id_magazzino"
ib_nonmodale=true

string ls_ges_locazione
select ges_locazioni
into :ls_ges_locazione
from par_sistema;
if ls_ges_locazione<>'S'OR ISNULL(ls_ges_locazione) then
	tab_1.tabpage_2.visible=false
end if
end event

on w_magazzino_ff.create
int iCurrent
call w_p_data::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_1
end on

on w_magazzino_ff.destroy
call w_p_data::destroy
destroy(this.cb_1)
end on

event ue_master_delete;call super::ue_master_delete;
if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false
	IF (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()
end event

type p_crescente from w_p_data`p_crescente within w_magazzino_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_magazzino_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_magazzino_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_magazzino_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_magazzino_ff
int X=641
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_magazzino_ff
int X=1578
int TabOrder=30
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_magazzino_ff
int X=1875
int TabOrder=20
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_magazzino_ff
int X=2195
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_magazzino_ff
event create ( )
event destroy ( )
int X=46
int Y=141
int Width=2423
int Height=1241
int TabOrder=10
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
event create ( )
event destroy ( )
int X=19
int Y=105
int Width=2387
int Height=1121
long BackColor=79741120
string Text="Magazzino"
long TabBackColor=79741120
dw_magazzino_ff dw_magazzino_ff
end type

on tabpage_1.create
this.dw_magazzino_ff=create dw_magazzino_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_magazzino_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_magazzino_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_magazzino_ff
int X=1281
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;
string ls_filtro,ls_codice
long ll_seg_value
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="id_magazzino"
openwithparm(lw_sm,idw_master.is_ricpar,"w_magazzino_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_magazzino"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_magazzino_ff from u_dw_master_main within tabpage_1
event updateend pbm_dwnupdateend
event updatestart pbm_dwnupdatestart
event ue_init pbm_custom01
event ue_set_search ( string as_nomecol,  string as_valcol )
int X=23
int Y=21
int Width=2364
int Height=1093
int TabOrder=3
string DataObject="d_magazzino_ff"
end type

event updateend;call super::updateend;
long ll_id_mag_w_error, ll_row, ll_id_magazzino
string ls_codice

if ib_fix_id then
	ll_row=GetRow()
	ls_codice= GetItemString(ll_row, "codice")
	SELECT Max("magazzino"."id_magazzino")  
		INTO :ll_id_magazzino  
		FROM "dba"."magazzino"  
		WHERE "magazzino"."codice" = :ls_codice ;
	If SQLCA.SQLCode = 0 then
		uf_SetItem(ll_row, "id_magazzino", ll_id_magazzino, TRUE)
	end if
end if
end event

event updatestart;call super::updatestart;
if GetItemStatus(GetRow(), 0, Primary!) = New! OR GetItemStatus(GetRow(), 0, Primary!) = NewModified! then
	ib_fix_id = TRUE
else
	ib_fix_id = FALSE
end if
end event

event ue_init;call super::ue_init;is_title = "Magazzino"
	iudw_children[1] = tab_1.tabpage_2.dw_locazione_gd
	is_list.s_identifica[1]="id_magazzino"


end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_tipo_magazzino_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_magazzino_gd"
		is_ricpar.s_titolo_finestra = "Tipi Magazzino"
		is_ricpar.s_ausil_value[1] = "id_tipo_magazzino_des"
	CASE "id_tipo_magazzino_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_magazzino_gd"
		is_ricpar.s_titolo_finestra = "Tipi Magazzino"
		is_ricpar.s_ausil_value[1] = "id_tipo_magazzino_cod"
		
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=105
int Width=2387
int Height=1121
long BackColor=79741120
string Text="Aree e Locazioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_locazione_gd dw_locazione_gd
end type

on tabpage_2.create
this.dw_locazione_gd=create dw_locazione_gd
this.Control[]={ this.dw_locazione_gd}
end on

on tabpage_2.destroy
destroy(this.dw_locazione_gd)
end on

type dw_locazione_gd from u_dw_master_main within tabpage_2
int X=28
int Y=17
int Width=2341
int Height=1093
int TabOrder=3
string DataObject="d_locazione_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_magazzino"
end event

type cb_1 from commandbutton within w_magazzino_ff
int X=938
int Y=41
int Width=270
int Height=85
int TabOrder=4
boolean BringToTop=true
string Text="Periodo B."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga_corrente, ll_id_magazzino
ll_riga_corrente=tab_1.tabpage_1.dw_magazzino_ff.getrow()
ll_id_magazzino=tab_1.tabpage_1.dw_magazzino_ff.getitemnumber(ll_riga_corrente, "id_magazzino")
if ll_id_magazzino> 0 then
	openwithparm(w_per_blocco_mag_tb, ll_id_magazzino)
end if
end event

