forward
global type w_scadenza_sog_commerciale_cx from w_p_data
end type
type dw_scadenza_sog_commerciale_ff from u_dw_master_main within w_scadenza_sog_commerciale_cx
end type
type tab_scadenze from tab within w_scadenza_sog_commerciale_cx
end type
type tabpage_filtro from userobject within tab_scadenze
end type
type dw_scadenza_filtro_ff from u_dw_ext_main within tabpage_filtro
end type
type tabpage_scadenze from userobject within tab_scadenze
end type
type dw_scadenza_lt from u_dw_master_main within tabpage_scadenze
end type
type tabpage_emesso from userobject within tab_scadenze
end type
type dw_scad_emesso_lt from u_dw_master_main within tabpage_emesso
end type
type tabpage_distinta from userobject within tab_scadenze
end type
type dw_scad_distinta_lt from u_dw_master_main within tabpage_distinta
end type
type tabpage_pagato from userobject within tab_scadenze
end type
type dw_scad_pagato_lt from u_dw_master_main within tabpage_pagato
end type
type tabpage_insoluto from userobject within tab_scadenze
end type
type dw_scad_insoluto_lt from u_dw_master_main within tabpage_insoluto
end type
type tabpage_bloccato from userobject within tab_scadenze
end type
type dw_scad_bloccato_lt from u_dw_master_main within tabpage_bloccato
end type
type tabpage_filtro from userobject within tab_scadenze
dw_scadenza_filtro_ff dw_scadenza_filtro_ff
end type
type tabpage_scadenze from userobject within tab_scadenze
dw_scadenza_lt dw_scadenza_lt
end type
type tabpage_emesso from userobject within tab_scadenze
dw_scad_emesso_lt dw_scad_emesso_lt
end type
type tabpage_distinta from userobject within tab_scadenze
dw_scad_distinta_lt dw_scad_distinta_lt
end type
type tabpage_pagato from userobject within tab_scadenze
dw_scad_pagato_lt dw_scad_pagato_lt
end type
type tabpage_insoluto from userobject within tab_scadenze
dw_scad_insoluto_lt dw_scad_insoluto_lt
end type
type tabpage_bloccato from userobject within tab_scadenze
dw_scad_bloccato_lt dw_scad_bloccato_lt
end type
type tab_scadenze from tab within w_scadenza_sog_commerciale_cx
tabpage_filtro tabpage_filtro
tabpage_scadenze tabpage_scadenze
tabpage_emesso tabpage_emesso
tabpage_distinta tabpage_distinta
tabpage_pagato tabpage_pagato
tabpage_insoluto tabpage_insoluto
tabpage_bloccato tabpage_bloccato
end type
end forward

global type w_scadenza_sog_commerciale_cx from w_p_data
int Width=2917
boolean TitleBar=true
string Title="Scadenze"
dw_scadenza_sog_commerciale_ff dw_scadenza_sog_commerciale_ff
tab_scadenze tab_scadenze
end type
global w_scadenza_sog_commerciale_cx w_scadenza_sog_commerciale_cx

type variables
datawindow 	idw_filtro
datawindow 	idw_scadenze
long		il_id_sog_commerciale
String		is_filtro, is_parametro
Date		id_data_inizio
end variables

forward prototypes
public subroutine uf_set_title ()
public subroutine uf_imposta_data_inizio ()
public subroutine uf_filtra ()
end prototypes

public subroutine uf_set_title ();

string	ls_title, ls_soggetti

CHOOSE CASE is_parametro
	CASE "C"
		ls_soggetti = "Clienti"
	CASE "F"
		ls_soggetti = "Fornitori"
	CASE Else
		ls_soggetti = "Soggetti Commerciali"
END CHOOSE

THIS.Title = "Scadenze " + ls_soggetti
end subroutine

public subroutine uf_imposta_data_inizio ();

SELECT esercizio.data_inizio
	INTO :id_data_inizio
	FROM dba.esercizio,
		  dba.azienda
	WHERE (esercizio.id_esercizio = azienda.id_esercizio) AND
	      (azienda.id_azienda = 1)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase","w_scadenza_sog_commerciale_cx / uf_imposta_data_inizio / 1")
END CHOOSE

end subroutine

public subroutine uf_filtra ();

string ls_filtro

idw_scadenze.SetFilter(is_filtro)
idw_scadenze.Filter()

IF is_filtro <> "" THEN
	ls_filtro = "(scadenza_esito_pagamento = 'E') AND " + is_filtro
ELSE
	ls_filtro = "(scadenza_esito_pagamento = 'E')"

END IF
tab_scadenze.tabpage_emesso.dw_scad_emesso_lt.SetFilter(ls_filtro)
tab_scadenze.tabpage_emesso.dw_scad_emesso_lt.Filter()

IF is_filtro <> "" THEN
	ls_filtro = "(scadenza_esito_pagamento = 'D') AND " + is_filtro
ELSE
	ls_filtro = "(scadenza_esito_pagamento = 'D')"
END IF
tab_scadenze.tabpage_distinta.dw_scad_distinta_lt.SetFilter(ls_filtro)
tab_scadenze.tabpage_distinta.dw_scad_distinta_lt.Filter()

IF is_filtro <> "" THEN
	ls_filtro = "(scadenza_esito_pagamento = 'P') AND " + is_filtro
ELSE
	ls_filtro = "(scadenza_esito_pagamento = 'P')"
END IF
tab_scadenze.tabpage_pagato.dw_scad_pagato_lt.SetFilter(ls_filtro)
tab_scadenze.tabpage_pagato.dw_scad_pagato_lt.Filter()

IF is_filtro <> "" THEN
	ls_filtro = "(scadenza_esito_pagamento = 'I') AND " + is_filtro
ELSE
	ls_filtro = "(scadenza_esito_pagamento = 'I')"
END IF
tab_scadenze.tabpage_insoluto.dw_scad_insoluto_lt.SetFilter(ls_filtro)
tab_scadenze.tabpage_insoluto.dw_scad_insoluto_lt.Filter()

IF is_filtro <> "" THEN
	ls_filtro = "(scadenza_esito_pagamento = 'B') AND " + is_filtro
ELSE
	ls_filtro = "(scadenza_esito_pagamento = 'B')"
END IF
tab_scadenze.tabpage_bloccato.dw_scad_bloccato_lt.SetFilter(ls_filtro)
tab_scadenze.tabpage_bloccato.dw_scad_bloccato_lt.Filter()
end subroutine

on w_scadenza_sog_commerciale_cx.create
int iCurrent
call super::create
this.dw_scadenza_sog_commerciale_ff=create dw_scadenza_sog_commerciale_ff
this.tab_scadenze=create tab_scadenze
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scadenza_sog_commerciale_ff
this.Control[iCurrent+2]=this.tab_scadenze
end on

on w_scadenza_sog_commerciale_cx.destroy
call super::destroy
destroy(this.dw_scadenza_sog_commerciale_ff)
destroy(this.tab_scadenze)
end on

event open;call super::open;

long ll_screenh
environment le_env
date ld_pippo, ld_in, ld_fin
string ls_pluto

idw_master = dw_scadenza_sog_commerciale_ff
idw_master.is_list = Message.PowerObjectParm

is_parametro = idw_master.is_list.s_win_parametri
if isnull(is_parametro) then is_parametro = ""

idw_master = dw_scadenza_sog_commerciale_ff
idw_master.is_list = Message.PowerObjectParm

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_reg_pd"
	idw_master.is_list.s_modo = modo_inserisci

	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF


CHOOSE CASE is_parametro

	CASE "C"
		il_HelpTopic = 61
	CASE "F"		
		il_HelpTopic = 62
	CASE ""
		il_HelpTopic = 60

END CHOOSE

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "sog_commerciale_gen.id_sog_commerciale"

idw_filtro = tab_scadenze.tabpage_filtro.dw_scadenza_filtro_ff
idw_scadenze = tab_scadenze.tabpage_scadenze.dw_scadenza_lt

IF idw_filtro.RowCount() = 0 THEN
	idw_Filtro.InsertRow(0)
END IF

idw_filtro.PostEvent("ue_post_open")

ib_NonModale = TRUE


long ll_id_esercizio

select id_esercizio
into :ll_id_esercizio
from azienda;

select data_inizio, data_fine
into :ld_in, :ld_fin
from esercizio
where id_esercizio = :ll_id_esercizio;


idw_filtro.SetItem(idw_filtro.GetRow(), "data_scad_dal", ld_in)
tab_scadenze.tabpage_filtro.dw_scadenza_filtro_ff.Event Post ue_setup_filter()

ls_pluto=string(year(ld_in))+"-12-31"
ld_pippo=Date(ls_pluto)


idw_filtro.SetItem(idw_filtro.GetRow(), "data_scad_al", ld_fin)
tab_scadenze.tabpage_filtro.dw_scadenza_filtro_ff.Event Post ue_setup_filter()

uf_set_title()
end event

type p_crescente from w_p_data`p_crescente within w_scadenza_sog_commerciale_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_scadenza_sog_commerciale_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_scadenza_sog_commerciale_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_scadenza_sog_commerciale_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scadenza_sog_commerciale_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_scadenza_sog_commerciale_cx
int X=1989
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_scadenza_sog_commerciale_cx
int X=2286
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_scadenza_sog_commerciale_cx
int X=2583
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_scadenza_sog_commerciale_cx
int Y=1320
int Width=210
int Height=100
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=174
end type

type cb_ricerca from w_p_data`cb_ricerca within w_scadenza_sog_commerciale_cx
int X=1600
int Width=306
boolean Visible=false
boolean BringToTop=true
end type

type dw_scadenza_sog_commerciale_ff from u_dw_master_main within w_scadenza_sog_commerciale_cx
int X=46
int Y=160
int Width=2811
int Height=340
int TabOrder=10
string DataObject="d_scadenza_sog_commerciale_ff"
boolean TitleBar=true
string Title="Soggetto Commerciale"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
iudw_children[1] = tab_scadenze.tabpage_scadenze.dw_scadenza_lt

iudw_children[2] = tab_scadenze.tabpage_emesso.dw_scad_emesso_lt
iudw_children[3] = tab_scadenze.tabpage_distinta.dw_scad_distinta_lt
iudw_children[4] = tab_scadenze.tabpage_pagato.dw_scad_pagato_lt
iudw_children[5] = tab_scadenze.tabpage_insoluto.dw_scad_insoluto_lt
iudw_children[6] = tab_scadenze.tabpage_bloccato.dw_scad_bloccato_lt

ib_AskForSave = FALSE
ib_Allow_Update = FALSE
end event

event ue_set_search;call super::ue_set_search;

is_search_window = "w_sog_commerciale_gen_coddes_sw"
is_ricpar.s_filter_value = as_valcol
is_ricpar.b_imm_retrieve = TRUE
IF (NOT IsNull(is_parametro)) AND (is_parametro <> "") THEN 
	is_ricpar.s_SQL_cond = "sog_commerciale_gen.tipo = '" + trim(is_parametro) + "'"
END IF

CHOOSE CASE as_nomecol
	CASE "sog_commerciale_codice"
		is_ricpar.s_filter_name = "codice"
	CASE "rag_soc_1"
		is_ricpar.s_filter_name = "rag_soc_1"
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

long ll_row

ll_row = THIS.GetRow()

CHOOSE CASE as_nomecol
	CASE "sog_commerciale_codice"
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])

		
		il_id_sog_commerciale = long(is_ricpar.s_id_seg_value[1])
		
		tab_scadenze.tabpage_scadenze.dw_scadenza_lt.Event ue_Retrieve(0,0)
		
		tab_scadenze.tabpage_emesso.dw_scad_emesso_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_distinta.dw_scad_distinta_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_pagato.dw_scad_pagato_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_insoluto.dw_scad_insoluto_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_bloccato.dw_scad_bloccato_lt.Event ue_Retrieve(0,0)
		
		THIS.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	CASE "rag_soc_1"
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_codice", is_ricpar.s_ausil_value[1])

		
		il_id_sog_commerciale = long(is_ricpar.s_id_seg_value[1])
		tab_scadenze.tabpage_scadenze.dw_scadenza_lt.Event ue_Retrieve(0,0)
		
		tab_scadenze.tabpage_emesso.dw_scad_emesso_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_distinta.dw_scad_distinta_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_pagato.dw_scad_pagato_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_insoluto.dw_scad_insoluto_lt.Event ue_Retrieve(0,0)
		tab_scadenze.tabpage_bloccato.dw_scad_bloccato_lt.Event ue_Retrieve(0,0)
		
		THIS.SetItemStatus(ll_row, 0, Primary!, NotModified!)
END CHOOSE
		

end event

event ue_update;long ll_RetVal

ib_AskForSave = FALSE
ib_Allow_Update = FALSE

ll_RetVal = Super::Event ue_update(wparam, lparam)
RETURN ll_RetVal 
end event

event itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc
date			ld_data_inizio,ld_data
long			ll_a, ll_ok, ll_row, ll_scode, ll_temp

ll_row = GetRow()
if ll_row > 0 then
	CHOOSE CASE dwo.name
		
		CASE "sog_commerciale_codice"
			ls_sql_cond = ""
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_sog_commerciale"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "sog_commerciale_codice"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "rag_soc_1"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			
			ll_row = this.GetRow()
			ll_temp = this.GetItemNumber(ll_row,"id_sog_commerciale")
			if (ll_ok>0) then	
				
				il_id_sog_commerciale = long(ls_dbv[1])
				tab_scadenze.tabpage_scadenze.dw_scadenza_lt.Event ue_Retrieve(0,0)		
				tab_scadenze.tabpage_emesso.dw_scad_emesso_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_distinta.dw_scad_distinta_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_pagato.dw_scad_pagato_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_insoluto.dw_scad_insoluto_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_bloccato.dw_scad_bloccato_lt.Event ue_Retrieve(0,0)
				THIS.SetItemStatus(ll_row, 0, Primary!, NotModified!)
				
				
				this.event rowfocuschanged(ll_row)
				this.ResetUpdate()
				return 2
			else
				if isNull(ll_temp) then
					this.event rowfocuschanged(ll_row)				
				end if
			end if

			
		CASE "rag_soc_1"
			ls_sql_cond = ""
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_sog_commerciale"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "sog_commerciale_codice"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "rag_soc_1"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			
			ll_row = this.GetRow()
			ll_temp = this.GetItemNumber(ll_row,"id_sog_commerciale")
			if (ll_ok>0) then	
				
				
				il_id_sog_commerciale = long(ls_dbv[1])
				tab_scadenze.tabpage_scadenze.dw_scadenza_lt.Event ue_Retrieve(0,0)		
				tab_scadenze.tabpage_emesso.dw_scad_emesso_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_distinta.dw_scad_distinta_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_pagato.dw_scad_pagato_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_insoluto.dw_scad_insoluto_lt.Event ue_Retrieve(0,0)
				tab_scadenze.tabpage_bloccato.dw_scad_bloccato_lt.Event ue_Retrieve(0,0)
				THIS.SetItemStatus(ll_row, 0, Primary!, NotModified!)
				
				
				this.event rowfocuschanged(ll_row)
				this.ResetUpdate()
				return 2
			else
				if isNull(ll_temp) then
					this.event rowfocuschanged(ll_row)				
				end if
			end if
			
	end choose
else
	MessageBox("Errore!","Riga nulla!")
end if
end event

type tab_scadenze from tab within w_scadenza_sog_commerciale_cx
event create ( )
event destroy ( )
int X=50
int Y=540
int Width=2798
int Height=944
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
tabpage_scadenze tabpage_scadenze
tabpage_emesso tabpage_emesso
tabpage_distinta tabpage_distinta
tabpage_pagato tabpage_pagato
tabpage_insoluto tabpage_insoluto
tabpage_bloccato tabpage_bloccato
end type

on tab_scadenze.create
this.tabpage_filtro=create tabpage_filtro
this.tabpage_scadenze=create tabpage_scadenze
this.tabpage_emesso=create tabpage_emesso
this.tabpage_distinta=create tabpage_distinta
this.tabpage_pagato=create tabpage_pagato
this.tabpage_insoluto=create tabpage_insoluto
this.tabpage_bloccato=create tabpage_bloccato
this.Control[]={this.tabpage_filtro,&
this.tabpage_scadenze,&
this.tabpage_emesso,&
this.tabpage_distinta,&
this.tabpage_pagato,&
this.tabpage_insoluto,&
this.tabpage_bloccato}
end on

on tab_scadenze.destroy
destroy(this.tabpage_filtro)
destroy(this.tabpage_scadenze)
destroy(this.tabpage_emesso)
destroy(this.tabpage_distinta)
destroy(this.tabpage_pagato)
destroy(this.tabpage_insoluto)
destroy(this.tabpage_bloccato)
end on

event selectionchanged;
end event

event selectionchanging;

if oldindex=1 and dw_scadenza_sog_commerciale_ff.rowcount()>0 then
	if isnull(dw_scadenza_sog_commerciale_ff.getitemnumber(1,'id_sog_commerciale')) then 
		messagebox('Attenzione','Selezionare un soggetto commerciale')
		return 1
	end if	
end if
	
end event

type tabpage_filtro from userobject within tab_scadenze
int X=18
int Y=104
int Width=2761
int Height=824
long BackColor=79741120
string Text="Filtro"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scadenza_filtro_ff dw_scadenza_filtro_ff
end type

on tabpage_filtro.create
this.dw_scadenza_filtro_ff=create dw_scadenza_filtro_ff
this.Control[]={this.dw_scadenza_filtro_ff}
end on

on tabpage_filtro.destroy
destroy(this.dw_scadenza_filtro_ff)
end on

type dw_scadenza_filtro_ff from u_dw_ext_main within tabpage_filtro
event ue_setup_filter ( )
int X=27
int Y=36
int Width=1806
int Height=652
int TabOrder=2
string DataObject="d_scadenza_filtro_ff"
end type

event ue_setup_filter;call super::ue_setup_filter;

long ll_CurrRow, ll_id_banca_azienda, ll_id_tipo_pagamento
date ld_data_scad_dal, ld_data_scad_al, ld_data_doc_dal, ld_data_doc_al
string ls_tipo_scadenza 
decimal ldc_imp_scad_da, ldc_imp_scad_a
string ls_data_scad, ls_data_doc, ls_imp_scad, ls_id_banca_azienda, ls_id_tipo_pagamento
string ls_stato_scadenza
char lc_stato_scadenza
constant string LCS_AND = " AND "

is_filtro = ""

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ld_data_scad_dal = THIS.GetItemDate(ll_CurrRow, "data_scad_dal")
	ld_data_scad_al = THIS.GetItemDate(ll_CurrRow, "data_scad_al")
	ld_data_doc_dal = THIS.GetItemDate(ll_CurrRow, "data_doc_dal")
	ld_data_doc_al = THIS.GetItemDate(ll_CurrRow, "data_doc_al")
	
	ll_id_tipo_pagamento = THIS.GetItemNumber(ll_CurrRow, "id_tipo_pagamento_cod")
	ldc_imp_scad_da = THIS.uf_GetItemDecimal(ll_CurrRow, "imp_scad_da")
	ldc_imp_scad_a = THIS.uf_GetItemDecimal(ll_CurrRow, "imp_scad_a")
	ll_id_banca_azienda = THIS.GetItemNumber(ll_CurrRow, "id_banca_azienda")
	lc_stato_scadenza = THIS.GetItemString(ll_CurrRow, "stato_scadenza")
	
	
	IF (NOT IsNull(ld_data_scad_dal)) AND (NOT IsNull(ld_data_scad_al)) THEN
		ls_data_scad = "(scadenza_data_scadenza >= date('" + string(ld_data_scad_dal) + "')) AND (scadenza_data_scadenza <= date('" + String(ld_data_scad_al) + "'))"
		IF is_filtro = "" THEN
			is_filtro = ls_data_scad
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_data_scad
		END IF
	END IF
	
	
	IF (NOT IsNull(ld_data_doc_dal)) AND (NOT IsNull(ld_data_doc_al)) THEN
		ls_data_doc = "(data_par_documento >= date('" + string(ld_data_doc_dal) + "')) AND (data_par_documento <= date('" + String(ld_data_doc_al) + "'))"
		IF is_filtro = "" THEN
			is_filtro = ls_data_doc
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_data_doc
		END IF
	END IF
	
	
	IF NOT IsNull(ll_id_tipo_pagamento) THEN
		ls_id_tipo_pagamento = "scadenza_id_tipo_pagamento = " + string(ll_id_tipo_pagamento)
		IF is_filtro = "" THEN
			is_filtro = ls_id_tipo_pagamento
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_id_tipo_pagamento
		END IF
	END IF
	
	
	IF NOT IsNull(lc_stato_scadenza) THEN
		ls_stato_scadenza = "stato_scadenza = '" + lc_stato_scadenza + "'"
		IF is_filtro = "" THEN
			is_filtro = ls_stato_scadenza
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_stato_scadenza
		END IF
	END IF

	
	IF (NOT IsNull(ldc_imp_scad_da)) AND (NOT IsNull(ldc_imp_scad_a)) THEN
		ls_imp_scad = "scadenza_importo >= " + string(ldc_imp_scad_da) + " AND scadenza_importo <= " + String(ldc_imp_scad_a)
		IF is_filtro = "" THEN
			is_filtro = ls_imp_scad
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_imp_scad
		END IF
	END IF
	
	
	IF NOT IsNull(ll_id_banca_azienda) THEN
		ls_id_banca_azienda = "scadenza_id_banca_azienda = " + string(ll_id_banca_azienda)
		IF is_filtro = "" THEN
			is_filtro = ls_id_banca_azienda
		ELSE
			is_filtro = is_filtro + LCS_AND + ls_id_banca_azienda
		END IF
	END IF
	
	uf_filtra()
END IF
end event

event itemchanged;

date ld_pippo
string ls_pluto


THIS.Event Post ue_Setup_Filter()

if dwo.name="data_scad_dal" then
  ld_pippo=getitemdate(THIS.GetRow(), "data_scad_dal")
  ls_pluto=string(year(ld_pippo))+"-12-31"
  ld_pippo=Date(ls_pluto)
  THIS.SetItem(THIS.GetRow(), "data_scad_al", ld_pippo)
end if


if dwo.name="data_scad_al" then
	 ld_pippo=getitemdate(THIS.GetRow(), "data_scad_dal")
	 if date(data)<ld_pippo then 
		messagebox('ATTENZIONE', 'La data iniziale è maggiore di quella finale')
	 end if
end if	 
end event

event ue_default;call super::ue_default;

string ls_pluto
date ld_pippo
CHOOSE CASE string(adwo_current.name)
	CASE "data_scad_dal"
		THIS.SetItem(THIS.GetRow(), "data_scad_dal", id_data_inizio)
		THIS.Event Post ue_setup_filter()
	CASE "data_scad_al"
		ld_pippo=getitemdate(THIS.GetRow(), "data_scad_dal")
		ls_pluto=string(year(ld_pippo))+"-12-31"
		ld_pippo=Date(ls_pluto)

		THIS.SetItem(THIS.GetRow(), "data_scad_al", ld_pippo)
		THIS.Event Post ue_setup_filter()
END CHOOSE

end event

event constructor;call super::constructor;uf_imposta_data_inizio()
end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "id_tipo_pagamento_cod"
is_colonne_drop[2]  = "id_tipo_pagamento_des"
is_colonne_drop[3]  = "id_banca_azienda"
end event

type tabpage_scadenze from userobject within tab_scadenze
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2761
int Height=824
long BackColor=79741120
string Text="Scadenze"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scadenza_lt dw_scadenza_lt
end type

on tabpage_scadenze.create
this.dw_scadenza_lt=create dw_scadenza_lt
this.Control[]={this.dw_scadenza_lt}
end on

on tabpage_scadenze.destroy
destroy(this.dw_scadenza_lt)
end on

type dw_scadenza_lt from u_dw_master_main within tabpage_scadenze
event ue_init pbm_custom01
int X=27
int Y=36
int Width=2706
int TabOrder=1
string DataObject="d_scadenza_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window = "w_scadenza_cx"

is_list.s_win_chiave[1] = "id_scadenza"
is_list.s_par_name[1] = "id_sog_commerciale"

is_title = "Scadenze"

end event

event ue_retrieve;THIS.Retrieve(il_id_sog_commerciale)
end event

event ue_insert;

long ll_RetVal

dw_scadenza_sog_commerciale_ff.SetItemStatus(dw_scadenza_sog_commerciale_ff.GetRow(), 0, Primary!, DataModified!)

ll_RetVal = Super::Event ue_insert(wparam, lparam)

dw_scadenza_sog_commerciale_ff.SetItemStatus(dw_scadenza_sog_commerciale_ff.GetRow(), 0, Primary!, NotModified!)
RETURN ll_RetVal
end event

event ue_delete;
long ll_scaduto, ll_ret
ll_scaduto=this.getitemnumber(this.getrow(),'id_scadenza')

if messagebox('Attenzione',"Sei sicuro di voler eliminare la scadenza selezionata?",Information!,yesno!)=1 then
	this.DeleteRow(this.getrow())
	this.SetFocus()
	delete from scadenza where id_scadenza=:ll_scaduto;
	if sqlca.sqlcode<0 then messagebox('Attenzione',"L'eliminazione della scadenza è fallita")
   ll_ret=0
else
	ll_ret=1
end if
return ll_ret
end event

type tabpage_emesso from userobject within tab_scadenze
int X=18
int Y=104
int Width=2761
int Height=824
long BackColor=79741120
string Text="Emesse"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scad_emesso_lt dw_scad_emesso_lt
end type

on tabpage_emesso.create
this.dw_scad_emesso_lt=create dw_scad_emesso_lt
this.Control[]={this.dw_scad_emesso_lt}
end on

on tabpage_emesso.destroy
destroy(this.dw_scad_emesso_lt)
end on

type dw_scad_emesso_lt from u_dw_master_main within tabpage_emesso
event ue_init pbm_custom01
event ue_retrieve pbm_custom07
int X=27
int Y=36
int Width=2706
int TabOrder=1
string DataObject="d_scadenza_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window = "w_scadenza_cx"

is_list.s_win_chiave[1] = "id_scadenza"
is_list.s_par_name[1] = "id_sog_commerciale"

is_title = "Scadenze"

end event

event ue_retrieve;THIS.Retrieve(il_id_sog_commerciale)
end event

event ue_insert;MessageBox("Scadenze", "Per inserire nuove scadenze selezionare prima la pagina " + char(34) + "Scadenze" + char(34) + ".")

end event

type tabpage_distinta from userobject within tab_scadenze
int X=18
int Y=104
int Width=2761
int Height=824
long BackColor=79741120
string Text="Distinta"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scad_distinta_lt dw_scad_distinta_lt
end type

on tabpage_distinta.create
this.dw_scad_distinta_lt=create dw_scad_distinta_lt
this.Control[]={this.dw_scad_distinta_lt}
end on

on tabpage_distinta.destroy
destroy(this.dw_scad_distinta_lt)
end on

type dw_scad_distinta_lt from u_dw_master_main within tabpage_distinta
event ue_init pbm_custom01
event ue_retrieve pbm_custom07
int X=27
int Y=36
int Width=2706
int TabOrder=1
string DataObject="d_scadenza_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window = "w_scadenza_cx"

is_list.s_win_chiave[1] = "id_scadenza"
is_list.s_par_name[1] = "id_sog_commerciale"

is_title = "Scadenze"

end event

event ue_retrieve;THIS.Retrieve(il_id_sog_commerciale)
end event

event ue_insert;MessageBox("Scadenze", "Per inserire nuove scadenze selezionare prima la pagina " + char(34) + "Scadenze" + char(34) + ".")
end event

type tabpage_pagato from userobject within tab_scadenze
int X=18
int Y=104
int Width=2761
int Height=824
long BackColor=79741120
string Text="Pagate"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scad_pagato_lt dw_scad_pagato_lt
end type

on tabpage_pagato.create
this.dw_scad_pagato_lt=create dw_scad_pagato_lt
this.Control[]={this.dw_scad_pagato_lt}
end on

on tabpage_pagato.destroy
destroy(this.dw_scad_pagato_lt)
end on

type dw_scad_pagato_lt from u_dw_master_main within tabpage_pagato
event ue_init pbm_custom01
event ue_retrieve pbm_custom07
int X=27
int Y=36
int Width=2706
int TabOrder=1
string DataObject="d_scadenza_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window = "w_scadenza_cx"

is_list.s_win_chiave[1] = "id_scadenza"
is_list.s_par_name[1] = "id_sog_commerciale"

is_title = "Scadenze"

end event

event ue_retrieve;THIS.Retrieve(il_id_sog_commerciale)
end event

event ue_insert;MessageBox("Scadenze", "Per inserire nuove scadenze selezionare prima la pagina " + char(34) + "Scadenze" + char(34) + ".")
end event

type tabpage_insoluto from userobject within tab_scadenze
int X=18
int Y=104
int Width=2761
int Height=824
long BackColor=79741120
string Text="Insolute"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scad_insoluto_lt dw_scad_insoluto_lt
end type

on tabpage_insoluto.create
this.dw_scad_insoluto_lt=create dw_scad_insoluto_lt
this.Control[]={this.dw_scad_insoluto_lt}
end on

on tabpage_insoluto.destroy
destroy(this.dw_scad_insoluto_lt)
end on

type dw_scad_insoluto_lt from u_dw_master_main within tabpage_insoluto
event ue_init pbm_custom01
event ue_retrieve pbm_custom07
int X=27
int Y=36
int Width=2706
int TabOrder=1
string DataObject="d_scadenza_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window = "w_scadenza_cx"

is_list.s_win_chiave[1] = "id_scadenza"
is_list.s_par_name[1] = "id_sog_commerciale"

is_title = "Scadenze"

end event

event ue_retrieve;THIS.Retrieve(il_id_sog_commerciale)
end event

event ue_insert;MessageBox("Scadenze", "Per inserire nuove scadenze selezionare prima la pagina " + char(34) + "Scadenze" + char(34) + ".")
end event

type tabpage_bloccato from userobject within tab_scadenze
int X=18
int Y=104
int Width=2761
int Height=824
long BackColor=79741120
string Text="Bloccate"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scad_bloccato_lt dw_scad_bloccato_lt
end type

on tabpage_bloccato.create
this.dw_scad_bloccato_lt=create dw_scad_bloccato_lt
this.Control[]={this.dw_scad_bloccato_lt}
end on

on tabpage_bloccato.destroy
destroy(this.dw_scad_bloccato_lt)
end on

type dw_scad_bloccato_lt from u_dw_master_main within tabpage_bloccato
event ue_init pbm_custom01
event ue_retrieve pbm_custom07
int X=27
int Y=36
int Width=2706
int TabOrder=1
string DataObject="d_scadenza_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window = "w_scadenza_cx"

is_list.s_win_chiave[1] = "id_scadenza"
is_list.s_par_name[1] = "id_sog_commerciale"

is_title = "Scadenze"

end event

event ue_retrieve;THIS.Retrieve(il_id_sog_commerciale)
end event

event ue_insert;MessageBox("Scadenze", "Per inserire nuove scadenze selezionare prima la pagina " + char(34) + "Scadenze" + char(34) + ".")
end event

