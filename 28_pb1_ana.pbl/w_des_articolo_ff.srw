forward
global type w_des_articolo_ff from w_p_data
end type
type ddlb_scelta_sog from dropdownlistbox within w_des_articolo_ff
end type
type dw_des_articolo_ff from u_dw_master_main within w_des_articolo_ff
end type
end forward

global type w_des_articolo_ff from w_p_data
int Width=2492
int Height=1285
boolean TitleBar=true
string Title="Descrizione Articolo"
ddlb_scelta_sog ddlb_scelta_sog
dw_des_articolo_ff dw_des_articolo_ff
end type
global w_des_articolo_ff w_des_articolo_ff

event open;call super::open;il_helpTopic = 45
idw_master = dw_des_articolo_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "des_articolo.id_des_articolo"

end event

on w_des_articolo_ff.create
int iCurrent
call w_p_data::create
this.ddlb_scelta_sog=create ddlb_scelta_sog
this.dw_des_articolo_ff=create dw_des_articolo_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=ddlb_scelta_sog
this.Control[iCurrent+2]=dw_des_articolo_ff
end on

on w_des_articolo_ff.destroy
call w_p_data::destroy
destroy(this.ddlb_scelta_sog)
destroy(this.dw_des_articolo_ff)
end on

event ue_post_open;call super::ue_post_open;string ls_cod_sog, ls_cod_fornitore, ls_cod_cliente 
ls_cod_sog=dw_des_articolo_ff.getitemstring(1,"c_sog_commerciale_codice")
select pref_cod_cliente, pref_cod_fornitore
into :ls_cod_cliente, :ls_cod_fornitore
from par_sistema;
if left(ls_cod_sog, 2)=ls_cod_cliente then
	ddlb_scelta_sog.selectitem(1)
elseif left(ls_cod_sog, 2)=ls_cod_fornitore then
	ddlb_scelta_sog.selectitem(2)
else
	ddlb_scelta_sog.selectitem(3)
end if

end event

event ue_master_delete;call super::ue_master_delete;long ll_row
ll_row=dw_des_articolo_ff.getrow()
if ll_row > 0 then
	dw_des_articolo_ff.deleterow(ll_row)
end if
end event

type p_crescente from w_p_data`p_crescente within w_des_articolo_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_des_articolo_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_des_articolo_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_des_articolo_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_des_articolo_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_des_articolo_ff
int X=1555
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_des_articolo_ff
int X=1852
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_des_articolo_ff
int X=2149
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_des_articolo_ff
int X=1989
int Y=1321
int Width=389
int Height=161
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=353
int Height=41
end type

type cb_ricerca from w_p_data`cb_ricerca within w_des_articolo_ff
boolean BringToTop=true
end type

type ddlb_scelta_sog from dropdownlistbox within w_des_articolo_ff
int X=549
int Y=313
int Width=545
int Height=229
int TabOrder=20
boolean BringToTop=true
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Clienti",&
"Fornitori",&
"Tutti"}
end type

type dw_des_articolo_ff from u_dw_master_main within w_des_articolo_ff
int X=46
int Y=161
int Width=2364
int Height=1017
int TabOrder=10
string DataObject="d_des_articolo_ff"
end type

event ue_init;call super::ue_init;is_title = "Descrizione Articolo"
end event

event ue_set_search;call super::ue_set_search;string ls_filtro

if ddlb_scelta_sog.text = "Clienti" then 
	select pref_cod_cliente
	into :ls_filtro
	from par_sistema;
	if isnull(ls_filtro) then ls_filtro='' 
end if
if ddlb_scelta_sog.text = "Fornitori" then 
	select pref_cod_fornitore
	into :ls_filtro
	from par_sistema;
	if isnull(ls_filtro) then ls_filtro='' 
end if
if ddlb_scelta_sog.text = "Tutti" then ls_filtro='' 


CHOOSE CASE as_nomecol
	CASE "c_sog_commerciale_codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 

		is_ricpar.s_filter_value = LS_Filtro 
		is_ricpar.s_filter_name = "codice" 
		
		
	CASE "c_anagrafica_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
			
END CHOOSE

CHOOSE CASE as_nomecol

	CASE "id_lingua"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_des"
	CASE "id_lingua_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua"
		
	CASE "id_linguaggio"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio_des"
	CASE "id_linguaggio_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio"

END CHOOSE
end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	
	CASE "c_sog_commerciale_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_anagrafica_rag_soc_1", is_ricpar.s_ausil_value[1])
	CASE "c_anagrafica_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_commerciale_codice", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""
CHOOSE CASE dwo.name

	CASE 'c_sog_commerciale_codice'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_commerciale_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_anagrafica_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

		
	CASE 'c_anagrafica_rag_soc_1'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "cc_anagrafica_comm_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;
string ls_codice, ls_descrizione
long ll_row, ll_sog_comm

ll_row = GetRow()

if RowCount() > 0 then
	
ll_sog_comm = long(uf_get_colval("id_sog_commerciale"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm )   ;
	
	uf_set_colval("c_sog_commerciale_codice",ls_codice)
	uf_set_colval("c_anagrafica_rag_soc_1",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_sog_commerciale_codice", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_anagrafica_rag_soc_1", PRIMARY!, NotModified!)

end if
end event

