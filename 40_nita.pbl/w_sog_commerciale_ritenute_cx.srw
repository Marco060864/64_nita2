forward
global type w_sog_commerciale_ritenute_cx from w_p_data
end type
type dw_sog_commerciale_ritenute_ff from u_dw_master_main within w_sog_commerciale_ritenute_cx
end type
type tab_compenso from tab within w_sog_commerciale_ritenute_cx
end type
type tabpage_filtro from userobject within tab_compenso
end type
type dw_compenso_filtro_ff from u_dw_ext_main within tabpage_filtro
end type
type tabpage_compenso from userobject within tab_compenso
end type
type dw_compenso_lt from u_dw_master_main within tabpage_compenso
end type
type tabpage_filtro from userobject within tab_compenso
dw_compenso_filtro_ff dw_compenso_filtro_ff
end type
type tabpage_compenso from userobject within tab_compenso
dw_compenso_lt dw_compenso_lt
end type
type tab_compenso from tab within w_sog_commerciale_ritenute_cx
tabpage_filtro tabpage_filtro
tabpage_compenso tabpage_compenso
end type
end forward

global type w_sog_commerciale_ritenute_cx from w_p_data
int Width=2423
int Height=1533
boolean TitleBar=true
string Title="Ritenute dei Soggetti Commerciali"
dw_sog_commerciale_ritenute_ff dw_sog_commerciale_ritenute_ff
tab_compenso tab_compenso
end type
global w_sog_commerciale_ritenute_cx w_sog_commerciale_ritenute_cx

type variables
string is_filtro
date id_data_inizio_esercizio
end variables

forward prototypes
public subroutine uf_ricerca ()
end prototypes

public subroutine uf_ricerca ();

w_search_main lw_sm
long ll_id_sog_commerciale

idw_master.is_ricpar.s_filter_name = "sog_commerciale_codice"

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_sog_commerciale_ritenute_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_sog_commerciale = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_sog_commerciale"
	idw_master.is_list.l_identifica[1] = ll_id_sog_commerciale
	
	idw_master.uf_set_colval("sog_commerciale_codice", idw_master.is_ricpar.s_ausil_value[1])
	idw_master.uf_set_colval("anagrafica_rag_soc_1", idw_master.is_ricpar.s_ausil_value[2])
	idw_master.uf_set_colval("anagrafica_rag_soc_2", idw_master.is_ricpar.s_ausil_value[3])
	idw_master.uf_set_colval("anagrafica_par_iva", idw_master.is_ricpar.s_ausil_value[4])
	idw_master.uf_set_colval("anagrafica_cod_fiscale", idw_master.is_ricpar.s_ausil_value[5])
	
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
END IF
end subroutine

on w_sog_commerciale_ritenute_cx.create
int iCurrent
call w_p_data::create
this.dw_sog_commerciale_ritenute_ff=create dw_sog_commerciale_ritenute_ff
this.tab_compenso=create tab_compenso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_sog_commerciale_ritenute_ff
this.Control[iCurrent+2]=tab_compenso
end on

on w_sog_commerciale_ritenute_cx.destroy
call w_p_data::destroy
destroy(this.dw_sog_commerciale_ritenute_ff)
destroy(this.tab_compenso)
end on

event open;call super::open;

long ll_screenh
environment le_env

ib_NonModale = TRUE 
il_HelpTopic = 33
idw_master = dw_sog_commerciale_ritenute_ff
idw_master.is_list = Message.PowerObjectParm


IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_sog_commerciale"
	idw_master.is_list.s_modo = modo_inserisci
	
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

SetNull(id_data_inizio_esercizio)
SELECT esercizio.data_inizio
	INTO :id_data_inizio_esercizio
	FROM dba.esercizio, dba.azienda
	WHERE (azienda.id_esercizio = esercizio.id_esercizio) AND
	      (azienda.id_azienda = 1)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		IF IsNull(id_data_inizio_esercizio) THEN
			MessageBox(w_sog_commerciale_ritenute_cx.title, "Attenzione: Non è stato impostato l'esercizio per l'azienda corrente.")
		END IF
	CASE -1
		MessageBox("Errore sul DataBase", "w_sog_commerciale_ritenute_cx / open / 1")
END CHOOSE

tab_compenso.tabpage_filtro.dw_compenso_filtro_ff.postevent("ue_post_open")

IF tab_compenso.tabpage_filtro.dw_compenso_filtro_ff.GetRow() = 0 THEN
	tab_compenso.tabpage_filtro.dw_compenso_filtro_ff.InsertRow(0)
END IF
end event

event ue_post_open;call super::ue_post_open;

tab_compenso.tabpage_compenso.dw_compenso_lt.SetFocus()

end event

type p_crescente from w_p_data`p_crescente within w_sog_commerciale_ritenute_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_sog_commerciale_ritenute_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_sog_commerciale_ritenute_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_sog_commerciale_ritenute_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_sog_commerciale_ritenute_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_sog_commerciale_ritenute_cx
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_sog_commerciale_ritenute_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_sog_commerciale_ritenute_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_sog_commerciale_ritenute_cx
int X=1098
int Y=21
int Width=252
int Height=121
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=215
int Height=1
end type

type cb_ricerca from w_p_data`cb_ricerca within w_sog_commerciale_ritenute_cx
int X=1143
int Width=316
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;

uf_ricerca()
end event

type dw_sog_commerciale_ritenute_ff from u_dw_master_main within w_sog_commerciale_ritenute_cx
int X=46
int Y=161
int Width=2318
int Height=533
int TabOrder=10
string DataObject="d_sog_commerciale_ritenute_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
iudw_children[1] = tab_compenso.tabpage_compenso.dw_compenso_lt
is_title = "Ritenute dei Soggetti Commerciali"

end event

type tab_compenso from tab within w_sog_commerciale_ritenute_cx
event create ( )
event destroy ( )
int X=46
int Y=741
int Width=2318
int Height=685
int TabOrder=20
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_filtro tabpage_filtro
tabpage_compenso tabpage_compenso
end type

on tab_compenso.create
this.tabpage_filtro=create tabpage_filtro
this.tabpage_compenso=create tabpage_compenso
this.Control[]={ this.tabpage_filtro,&
this.tabpage_compenso}
end on

on tab_compenso.destroy
destroy(this.tabpage_filtro)
destroy(this.tabpage_compenso)
end on

type tabpage_filtro from userobject within tab_compenso
int X=19
int Y=105
int Width=2282
int Height=565
long BackColor=79741120
string Text="Filtro"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_compenso_filtro_ff dw_compenso_filtro_ff
end type

on tabpage_filtro.create
this.dw_compenso_filtro_ff=create dw_compenso_filtro_ff
this.Control[]={ this.dw_compenso_filtro_ff}
end on

on tabpage_filtro.destroy
destroy(this.dw_compenso_filtro_ff)
end on

type dw_compenso_filtro_ff from u_dw_ext_main within tabpage_filtro
event ue_setup_filter ( )
int X=28
int Y=37
int Width=2218
int Height=501
int TabOrder=2
string DataObject="d_compenso_filtro_ff"
end type

event ue_setup_filter;call super::ue_setup_filter;

long ll_CurrRow, ll_id_tributo
date ld_data_reg_dal, ld_data_reg_al, ld_data_scad_dal, ld_data_scad_al, ld_data_pag_dal
date ld_data_pag_al
string ls_data_reg, ls_data_scad, ls_data_pag, ls_id_tributo

constant string LCS_AND = " AND "

is_filtro = ""

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ld_data_reg_dal  = THIS.GetItemDate(ll_CurrRow, "data_reg_dal")
	ld_data_reg_al   = THIS.GetItemDate(ll_CurrRow, "data_reg_al")
	ld_data_scad_dal = THIS.GetItemDate(ll_CurrRow, "data_scad_dal")
	ld_data_scad_al  = THIS.GetItemDate(ll_CurrRow, "data_scad_al")
	ld_data_pag_dal  = THIS.GetItemDate(ll_CurrRow, "data_pag_dal")
	ld_data_pag_al   = THIS.GetItemDate(ll_CurrRow, "data_pag_al")
	ll_id_tributo    = THIS.GetItemNumber(ll_CurrRow, "id_tributo_des")
	
	
	IF (NOT IsNull(ld_data_reg_dal)) AND (NOT IsNull(ld_data_reg_al)) THEN
		ls_data_reg = "(compenso_data_registrazione >= date('" + string(ld_data_reg_dal) + "')) AND (compenso_data_registrazione <= date('" + String(ld_data_reg_al) + "'))"
		IF is_filtro = "" THEN
			is_filtro = ls_data_reg
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_data_reg
		END IF
	END IF
	
	
	IF (NOT IsNull(ld_data_scad_dal)) AND (NOT IsNull(ld_data_scad_al)) THEN
		ls_data_scad = "(compenso_data_scadenza >= date('" + string(ld_data_scad_dal) + "')) AND (compenso_data_scadenza <= date('" + String(ld_data_scad_al) + "'))"
		IF is_filtro = "" THEN
			is_filtro = ls_data_scad
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_data_scad
		END IF
	END IF
	
	
	IF (NOT IsNull(ld_data_pag_dal)) AND (NOT IsNull(ld_data_pag_al)) THEN
		ls_data_pag = "(compenso_data_pagamento >= date('" + string(ld_data_pag_dal) + "')) AND (compenso_data_pagamento <= date('" + String(ld_data_pag_al) + "'))"
		IF is_filtro = "" THEN
			is_filtro = ls_data_pag
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_data_pag
		END IF
	END IF
	
	
	IF NOT IsNull(ll_id_tributo) THEN
		ls_id_tributo = "compenso_id_tributo = " + string(ll_id_tributo)
		IF is_filtro = "" THEN
			is_filtro = ls_id_tributo
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_id_tributo
		END IF
	END IF
	
	tab_compenso.tabpage_compenso.dw_compenso_lt.SetFilter(is_filtro)
	tab_compenso.tabpage_compenso.dw_compenso_lt.Filter()
END IF
end event

event itemchanged;call super::itemchanged;

THIS.Event Post ue_Setup_Filter()
end event

event ue_default;call super::ue_default;

CHOOSE CASE string(adwo_current.name)
	CASE "data_reg_dal", "data_scad_dal", "data_pag_dal"
		THIS.SetItem(al_row, string(adwo_current.name), id_data_inizio_esercizio)
		THIS.Event Post ue_Setup_Filter()
	CASE "data_reg_al", "data_scad_al", "data_pag_al"
		THIS.SetItem(al_row, string(adwo_current.name), date("31/12/2099"))
		THIS.Event Post ue_Setup_Filter()
END CHOOSE

end event

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_tributo_cod"
is_colonne_drop[2] = "id_tributo_des"
end event

type tabpage_compenso from userobject within tab_compenso
event create ( )
event destroy ( )
int X=19
int Y=105
int Width=2282
int Height=565
long BackColor=79741120
string Text="Compensi"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_compenso_lt dw_compenso_lt
end type

on tabpage_compenso.create
this.dw_compenso_lt=create dw_compenso_lt
this.Control[]={ this.dw_compenso_lt}
end on

on tabpage_compenso.destroy
destroy(this.dw_compenso_lt)
end on

type dw_compenso_lt from u_dw_master_main within tabpage_compenso
event rowfocuschanged pbm_dwnrowchange
event ue_init pbm_custom01
int X=28
int Y=37
int Width=2227
int Height=513
int TabOrder=3
string DataObject="d_compenso_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
is_title = "Compensi"
is_resp_window = "w_compenso_ff"
is_list.s_win_chiave[1] = "compenso_id_compenso"
end event

