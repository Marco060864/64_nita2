forward
global type w_mod_provvigioni_cx from w_p_data
end type
type dw_mod_provvigioni_agenti_ff from u_dw_master_main within tabpage_1
end type
type dw_mod_provvigioni_agenti_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_mod_provvigioni_altro_ff from u_dw_master_main within tabpage_2
end type
type dw_mod_provvigioni_ff from u_dw_master_main within w_mod_provvigioni_cx
end type
type dw_mod_provvigioni_gd from u_dw_master_main within w_mod_provvigioni_cx
end type
type dw_mod_provvigioni_ext from u_dw_ext_main within w_mod_provvigioni_cx
end type
type tabpage_2 from userobject within tab_1
dw_mod_provvigioni_altro_ff dw_mod_provvigioni_altro_ff
end type
end forward

global type w_mod_provvigioni_cx from w_p_data
int Width=3410
int Height=1868
boolean TitleBar=true
string Title="Modifica delle provvigioni Agente"
dw_mod_provvigioni_ff dw_mod_provvigioni_ff
dw_mod_provvigioni_gd dw_mod_provvigioni_gd
dw_mod_provvigioni_ext dw_mod_provvigioni_ext
end type
global w_mod_provvigioni_cx w_mod_provvigioni_cx

on w_mod_provvigioni_cx.create
int iCurrent
call super::create
this.dw_mod_provvigioni_ff=create dw_mod_provvigioni_ff
this.dw_mod_provvigioni_gd=create dw_mod_provvigioni_gd
this.dw_mod_provvigioni_ext=create dw_mod_provvigioni_ext
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mod_provvigioni_ff
this.Control[iCurrent+2]=this.dw_mod_provvigioni_gd
this.Control[iCurrent+3]=this.dw_mod_provvigioni_ext
end on

on w_mod_provvigioni_cx.destroy
call super::destroy
destroy(this.dw_mod_provvigioni_ff)
destroy(this.dw_mod_provvigioni_gd)
destroy(this.dw_mod_provvigioni_ext)
end on

event open;call super::open;il_HelpTopic = 43

idw_master = dw_mod_provvigioni_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_documento"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_documento"

end event

event ue_post_open;call super::ue_post_open;

cb_ricerca.visible=true
dw_mod_provvigioni_ext.insertrow(0)

DataWindowChild ldw_id_gruppo_agenti, ldw_id_gruppo_agenti_des, ldw_id_gruppo_agenti_2, ldw_id_gruppo_agenti_2_des
DataWindowChild ldw_id_valuta, ldw_id_valuta_des
tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff.getchild("id_gruppo_agenti", ldw_id_gruppo_agenti)
ldw_id_gruppo_agenti.settransobject(SQLCA)
ldw_id_gruppo_agenti.retrieve()

tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff.getchild("id_gruppo_agenti_des", ldw_id_gruppo_agenti_des)
ldw_id_gruppo_agenti_des.settransobject(SQLCA)
ldw_id_gruppo_agenti_des.retrieve()

tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff.getchild("id_gruppo_agenti_2", ldw_id_gruppo_agenti_2)
ldw_id_gruppo_agenti_2.settransobject(SQLCA)
ldw_id_gruppo_agenti_2.retrieve()

tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff.getchild("id_gruppo_agenti_2_des", ldw_id_gruppo_agenti_2_des)
ldw_id_gruppo_agenti_2_des.settransobject(SQLCA)
ldw_id_gruppo_agenti_2_des.retrieve()

tab_1.tabpage_2.dw_mod_provvigioni_altro_ff.getchild("riga_documento_id_valuta", ldw_id_valuta)
ldw_id_valuta.settransobject(SQLCA)
ldw_id_valuta.retrieve()

tab_1.tabpage_2.dw_mod_provvigioni_altro_ff.getchild("riga_documento_id_valuta_des", ldw_id_valuta_des)
ldw_id_valuta_des.settransobject(SQLCA)
ldw_id_valuta_des.retrieve()
end event

type p_crescente from w_p_data`p_crescente within w_mod_provvigioni_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_mod_provvigioni_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_mod_provvigioni_cx
int X=37
int Y=32
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_mod_provvigioni_cx
int X=329
int Y=32
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_mod_provvigioni_cx
int Y=32
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_mod_provvigioni_cx
int Y=32
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_mod_provvigioni_cx
int Y=32
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_mod_provvigioni_cx
int X=2121
int Y=32
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_mod_provvigioni_cx
int X=37
int Y=796
int Width=3333
int Height=972
int TabOrder=40
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3296
int Height=852
long BackColor=79741120
string Text="Agenti"
long TabBackColor=79741120
dw_mod_provvigioni_agenti_ff dw_mod_provvigioni_agenti_ff
end type

on tabpage_1.create
this.dw_mod_provvigioni_agenti_ff=create dw_mod_provvigioni_agenti_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mod_provvigioni_agenti_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_mod_provvigioni_agenti_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_mod_provvigioni_cx
int X=1829
int Y=32
boolean BringToTop=true
end type

event cb_ricerca::clicked;
w_search_main 	lw_sm
string 			ls_filtro, ls_codice
long 				ll_seg_value, ll_id_prof_documento, ll_num_progressivo, ll_id_sog_commerciale
date				ldt_data_registrazione
long				li_i
s_ric_param		ls_ric_param


ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="documento_num_progressivo"
ls_filtro = " ( registro.tipo_registro = 'IV' OR registro.tipo_registro = 'IC' ) "

ll_id_prof_documento = dw_mod_provvigioni_ext.getitemnumber(1, "id_prof_documento")
if (ll_id_prof_documento > 0) then ls_filtro = ls_filtro  + " AND documento.id_prof_documento = " + string(ll_id_prof_documento)

ll_num_progressivo = dw_mod_provvigioni_ext.getitemnumber(1, "documento_num_progressivo")
if (ll_num_progressivo > 0) then ls_filtro = ls_filtro  + " AND documento.num_progressivo = " + string(ll_num_progressivo)

ldt_data_registrazione = dw_mod_provvigioni_ext.getitemdate(1, "documento_data_registrazione")
if (not isnull(ldt_data_registrazione)) then ls_filtro = ls_filtro  + " AND documento.data_registrazione = '" + string(ldt_data_registrazione, 'yyyy/mm/dd') + "'"

ll_id_sog_commerciale = dw_mod_provvigioni_ext.getitemnumber(1, "sog_commerciale_gen_id_sog_commerciale")
if (not isnull(ll_id_sog_commerciale)) then ls_filtro = ls_filtro  + " AND documento.id_sog_commerciale = " + string(ll_id_sog_commerciale)

idw_master.is_ricpar.s_SQL_cond = ls_filtro
openwithparm(lw_sm, idw_master.is_ricpar, "w_documento_sw")

idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_documento"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
	
	SELECT count(*)
	INTO	 :li_i
	FROM	 riep_provvigioni
	WHERE  id_documento = :ll_seg_value
	AND	 stato_provvigioni = 'C'
	;
	
	if (li_i > 0) then
		messagebox("Attenzione", "Il documento è già stato utilizzato in una liquidazione definitiva")
	end if
	
end if
end event

type dw_mod_provvigioni_agenti_ff from u_dw_master_main within tabpage_1
int X=27
int Y=28
int Width=3246
int Height=812
int TabOrder=20
boolean BringToTop=true
string DataObject="d_mod_provvigioni_agenti_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE

end event

event itemchanged;
s_con_provvigione ls_con_provvigione

CHOOSE CASE dwo.name 
	CASE "id_gruppo_agenti", "id_gruppo_agenti_des", "id_gruppo_agenti_2", "id_gruppo_agenti_2_des"
		ls_con_provvigione.id_gruppo_agenti = long(data)
		ls_con_provvigione.id_sog_commerciale  = dw_mod_provvigioni_ff.getitemnumber(1, "sog_commerciale_gen_id_sog_commerciale")
		ls_con_provvigione.id_unita_confezione = this.getitemnumber(row, "id_unita_confezione")
		ls_con_provvigione.id_articolo = this.getitemnumber(row, "id_articolo")
		ls_con_provvigione.data = dw_mod_provvigioni_ff.getitemdate(1, "documento_data_registrazione")
		ls_con_provvigione.sconto_perc = this.getitemstring(row, "sconto")		
		ls_con_provvigione.sconto_imp = this.getitemnumber(row, "sconto_riga")		
		ls_con_provvigione.id_valuta = this.getitemnumber(row, "id_valuta")		
		ls_con_provvigione.id_con_lis_articolo = this.getitemnumber(row, "riga_documento_id_con_lis_articolo")  
END CHOOSE

CHOOSE CASE dwo.name
	CASE "id_gruppo_agenti", "id_gruppo_agenti_des"
			post f_gruppo_agenti(tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff, row, 1, "M")
			post f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff, row, 1, "M")
			
	CASE "id_gruppo_agenti_2", "id_gruppo_agenti_2_des"
			post f_gruppo_agenti(tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff, row, 2, "M")		
			post f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff, row, 2, "M")			
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=3296
int Height=852
long BackColor=79741120
string Text="Altro"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_mod_provvigioni_altro_ff dw_mod_provvigioni_altro_ff
end type

on tabpage_2.create
this.dw_mod_provvigioni_altro_ff=create dw_mod_provvigioni_altro_ff
this.Control[]={this.dw_mod_provvigioni_altro_ff}
end on

on tabpage_2.destroy
destroy(this.dw_mod_provvigioni_altro_ff)
end on

type dw_mod_provvigioni_altro_ff from u_dw_master_main within tabpage_2
int X=18
int Y=24
int Width=3255
int Height=808
int TabOrder=12
boolean BringToTop=true
string DataObject="d_mod_provvigioni_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

type dw_mod_provvigioni_ff from u_dw_master_main within w_mod_provvigioni_cx
int X=3515
int Y=36
int Width=3301
int Height=324
int TabOrder=10
boolean BringToTop=true
string DataObject="d_mod_provvigioni_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_documento"
iudw_children[1] = dw_mod_provvigioni_gd
end event

event retrieveend;
dw_mod_provvigioni_ext.setitem(1, "prof_documento_codice", this.getitemstring(1, "prof_documento_codice"))
dw_mod_provvigioni_ext.setitem(1, "prof_documento_descrizione", this.getitemstring(1, "prof_documento_descrizione"))
dw_mod_provvigioni_ext.setitem(1, "id_prof_documento", this.getitemnumber(1, "prof_documento_id_prof_documento"))
dw_mod_provvigioni_ext.setitem(1, "documento_data_registrazione", this.getitemdate(1, "documento_data_registrazione"))
dw_mod_provvigioni_ext.setitem(1, "documento_num_progressivo", this.getitemnumber(1, "documento_num_progressivo"))
dw_mod_provvigioni_ext.setitem(1, "sog_commerciale_gen_codice", this.getitemstring(1, "sog_commerciale_gen_codice"))
dw_mod_provvigioni_ext.setitem(1, "sog_commerciale_gen_rag_soc_1", this.getitemstring(1, "sog_commerciale_gen_rag_soc_1"))
dw_mod_provvigioni_ext.setitem(1, "sog_commerciale_gen_id_sog_commerciale", this.getitemnumber(1, "sog_commerciale_gen_id_sog_commerciale"))
end event

type dw_mod_provvigioni_gd from u_dw_master_main within w_mod_provvigioni_cx
int X=37
int Y=400
int Width=3333
int Height=388
int TabOrder=30
boolean BringToTop=true
string DataObject="d_mod_provvigioni_gd"
boolean VScrollBar=true
boolean LiveScroll=false
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_documento"
iudw_children[1] = tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff
iudw_children[2] = tab_1.tabpage_2.dw_mod_provvigioni_altro_ff

end event

event retrieveend;
integer li_i, ll_rows
ll_rows = this.rowcount()
if ll_rows > 0 then
	for li_i = 1 to ll_rows 
		f_gruppo_agenti(tab_1.tabpage_1.dw_mod_provvigioni_agenti_ff, li_i, 0, "M")
	next
end if
end event

type dw_mod_provvigioni_ext from u_dw_ext_main within w_mod_provvigioni_cx
int X=37
int Y=148
int Width=3301
int Height=240
int TabOrder=20
boolean BringToTop=true
string DataObject="d_mod_provvigioni_ext"
end type

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "prof_documento_codice", "prof_documento_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"		
		
		ls_dwc[1] = "prof_documento_codice"
		ls_dwc[2] = "prof_documento_descrizione"
		ls_dwc[3] = "id_prof_documento"				

		if dwo.name = "prof_documento_codice" then
			li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 3, &
				ls_dbc, ls_dbv, ls_dwc)
		else
			li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 3, &
				ls_dbc, ls_dbv, ls_dwc)
		end if
	
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "sog_commerciale_gen_codice", "sog_commerciale_gen_rag_soc_1"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"		
		
		ls_dwc[1] = "sog_commerciale_gen_codice"
		ls_dwc[2] = "sog_commerciale_gen_rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_id_sog_commerciale"	
		
		if dwo.name = "sog_commerciale_gen_codice" then		
			li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, &
			ls_sql_cond, 3, ls_dbc, ls_dbv, ls_dwc)
		else
			li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, &
			ls_sql_cond, 3, ls_dbc, ls_dbv, ls_dwc)
		end if
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF		
END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE	"prof_documento_codice", "prof_documento_descrizione"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		
		if as_nomecol = "prof_documento_codice" then		
			is_ricpar.s_filter_name="prof_documento_codice"
		else
			is_ricpar.s_filter_name="prof_documento_descrizione"			
		end if
		
		
	CASE "sog_commerciale_gen_codice", "sog_commerciale_gen_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
			
		if as_nomecol = "sog_commerciale_gen_codice" then
			is_ricpar.s_filter_name = "codice"			
		else 
			is_ricpar.s_filter_name = "rag_soc_1"
		end if
END CHOOSE
end event

event ue_use_search;
CHOOSE CASE as_nomecol
	CASE	"prof_documento_codice"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("prof_documento_descrizione",is_ricpar.s_ausil_value[1])
	CASE	"prof_documento_descrizione"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("prof_documento_codice",is_ricpar.s_ausil_value[1])		
			
	CASE	"sog_commerciale_gen_codice"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("sog_commerciale_gen_id_sog_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("sog_commerciale_gen_rag_soc_1",is_ricpar.s_ausil_value[1])
	CASE	"sog_commerciale_gen_rag_soc_1"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("sog_commerciale_gen_id_sog_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("sog_commerciale_gen_codice",is_ricpar.s_ausil_value[1])		
END CHOOSE
end event

