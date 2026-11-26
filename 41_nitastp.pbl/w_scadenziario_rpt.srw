forward
global type w_scadenziario_rpt from w_print_main
end type
end forward

global type w_scadenziario_rpt from w_print_main
int Width=2345
int Height=1456
boolean TitleBar=true
string Title="Scadenziario"
end type
global w_scadenziario_rpt w_scadenziario_rpt

on w_scadenziario_rpt.create
call super::create
end on

on w_scadenziario_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_tipo_pagamento, ll_da_dist, ll_a_dist
string	ls_esito_pagamento
string	ls_tipo_scadenza, ls_stato_scadenza
date		ld_da_data, ld_a_data, ld_da_data_doc, ld_a_data_doc
String 	statement, ls_selezione
Date		ldt_da_data_dis, ldt_a_data_dis		

ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")

ll_da_dist				= tab_1.tabpage_select.dw_selection.GetItemnumber(1,"da_dis_banca")
ll_a_dist				= tab_1.tabpage_select.dw_selection.GetItemnumber(1,"a_dis_banca")

ldt_da_data_dis			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data_dis")
ldt_a_data_dis				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data_dis")

if ld_da_data > ld_a_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	


ld_da_data_doc				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data_doc")
ld_a_data_doc				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data_doc")
if ld_da_data_doc > ld_a_data_doc then
	if MessageBox( "Attenzione","Data documento 'da' maggiore di Data documento 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

ll_tipo_pagamento		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"tipo_pagamento")
ls_esito_pagamento	= tab_1.tabpage_select.dw_selection.GetItemString(1,"esito_pagamento")
ls_tipo_scadenza		= tab_1.tabpage_select.dw_selection.GetItemString(1,"tipo_scadenza")
ls_stato_scadenza		= tab_1.tabpage_select.dw_selection.GetItemString(1,"stato_scadenza")

statement  = " {Scadenza.ID_Azienda} = 1"


if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Scadenza.Data_Scadenza} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data scadenza " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data scadenza - non definita, "
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Scadenza.Data_Scadenza} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data scadenza " + string(ld_a_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data scadenza - non definita."
end if

if Not IsNull(ll_tipo_pagamento) then
	statement 		= statement + " AND {Tipo_Pagamento.ID_Tipo_Pagamento} = " + string(ll_tipo_pagamento) + ""
	ls_selezione 	= ls_selezione + " Tipo pagamento: " + string(ll_tipo_pagamento) + "."
else
	ls_selezione 	= ls_selezione + " Tipo pagamento non definito."
end if

if Not IsNull(ls_esito_pagamento) and ls_esito_pagamento <> "" then
	statement 		= statement + " AND {Scadenza.Esito_Pagamento} = '" + ls_esito_pagamento + "'"
	ls_selezione 	= ls_selezione + " Esito pagamento: " + ls_esito_pagamento + "."
else
	ls_selezione 	= ls_selezione + " Esito pagamento non definito."
end if

if Not IsNull(ls_tipo_scadenza) and ls_tipo_scadenza <> "" then
	statement 		= statement + " AND {Scadenza.Tipo_Scadenza} = '" + ls_tipo_scadenza + "'"
	ls_selezione 	= ls_selezione + " Tipo scadenza: " + ls_tipo_scadenza + "."
else
	ls_selezione 	= ls_selezione + " Tipo scadenza non definito."
end if

if Not IsNull(ls_stato_scadenza) and ls_stato_scadenza <> "" then
	statement 		= statement + " AND {Scadenza.Stato_Scadenza} = '" + ls_stato_scadenza + "'"
	ls_selezione 	= ls_selezione + " Stato scadenza: " + ls_stato_scadenza + "."
else
	ls_selezione 	= ls_selezione + " Stato scadenza non definito."
end if



if Not IsNull(ld_da_data_doc) then
	statement 		= statement + " AND {Documento.Data_documento} >= Date (" + string(ld_da_data_doc, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data documento " + string(ld_da_data_doc, "dd/mm/yyyy") + ", "
else
	ls_selezione 	= " Dalla data documento - non definita, "
end if

if Not IsNull(ld_a_data_doc) then
	statement 		= statement + " AND {Documento.Data_documento} <= Date (" + string(ld_a_data_doc, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data documento " + string(ld_a_data_doc, "dd/mm/yyyy") + "."
else
	ls_selezione 	= ls_selezione + "alla data documento - non definita."
end if

if Not IsNull(ll_da_dist) then
	statement 		= statement + " AND {dis_banca.num_distinta} >= " + string(ll_da_dist) + ""
	ls_selezione 	= " Da num. distinta " + string(ll_da_dist) + ", "
else
	ls_selezione 	= " Da num. distinta - non definita, "
end if

if Not IsNull(ll_a_dist) then
	statement 		= statement + " AND {dis_banca.num_distinta} <= " + string(ll_a_dist) + ""
	ls_selezione 	= ls_selezione + "a num. distinta " + string(ll_a_dist) + "."
else
	ls_selezione 	= ls_selezione + "a num. distinta - non definita."
end if
if Not IsNull(ldt_da_data_dis) then
	statement 		= statement + " AND {dis_banca.data_distinta} >= Date (" + string(ldt_da_data_dis, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data distinta " + string(ldt_da_data_dis, "dd/mm/yyyy") + ", "
end if

if Not IsNull(ldt_a_data_dis) then
	statement 		= statement + " AND {dis_banca.data_distinta} <= Date (" + string(ldt_a_data_dis, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Alla data distinta " + string(ldt_a_data_dis, "dd/mm/yyyy") + ", "
end if


is_selection 	= statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

type cb_esci from w_print_main`cb_esci within w_scadenziario_rpt
int X=2057
int Y=60
end type

type tab_1 from w_print_main`tab_1 within w_scadenziario_rpt
int Width=2286
int Height=1168
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2249
int Height=1040
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=48
int Width=2149
int Height=972
string DataObject="d_scadenze_rpt"
end type

event dw_selection::ue_initial;
integer 	li_esercizio_corrente,li_azienda
long		ll_ret
date	  	ld_esercizio

SELECT azienda.id_esercizio INTO :li_esercizio_corrente
FROM dba.azienda WHERE azienda.id_azienda = 1;		

ll_ret = SQLCA.SQLCode

if ll_ret = 0 then		
	SELECT esercizio.data_inizio INTO :ld_esercizio
	FROM dba.esercizio WHERE esercizio.id_esercizio = :li_esercizio_corrente;			
end if	
			
post SetItem(1, "dalla_data",ld_esercizio )
post SetItem(1, "alla_data",Today() )

long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

event dw_selection::itemchanged;date		ld_dalla_data
integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]


CHOOSE CASE dwo.name
	CASE 'alla_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("alla_data")
		end if
	
	
	
	CASE 'a_data_doc'
		ld_dalla_data = This.GetItemDate(1, "da_data_doc")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data documento di fine non può essere inferiore alla data documento di inizio.")
			Post SetColumn("a_data_doc")
		end if	


		
END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "tipo_pagamento"
is_drop_column[2] = "tipo_pagamento_des"

is_drop_column[3]	= "id_valuta"
is_drop_column[4]	= "id_valuta_des"

end event

event dw_selection::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "da_dis_banca"
		is_search_window = "w_dis_banca_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "num_distinta" 				
		
	CASE "a_dis_banca"
		is_search_window = "w_dis_banca_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "num_distinta" 				

END CHOOSE

end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "da_dis_banca"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval('id_dis_banca', is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_data_dis", is_ricpar.s_ausil_value[1])		
		
	CASE "a_dis_banca"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval('id_dis_banca_2', is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_data_dis", is_ricpar.s_ausil_value[1])				
END CHOOSE


end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2249
int Height=1040
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2249
int Height=1040
end type

type cb_stampa from w_print_main`cb_stampa within w_scadenziario_rpt
int X=1783
int Y=60
end type

