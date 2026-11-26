forward
global type w_and_mensile_rpt from w_print_main
end type
end forward

global type w_and_mensile_rpt from w_print_main
int Width=2459
int Height=1136
boolean TitleBar=true
string Title="Andamento Fatturato Mensile"
end type
global w_and_mensile_rpt w_and_mensile_rpt

on w_and_mensile_rpt.create
call super::create
end on

on w_and_mensile_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;

String	ls_da_codice, ls_ad_codice, ls_filtra, ls_pref_cl, ls_pref_fo
String 	ls_statement, ls_statform
long		ll_da, ll_ad, ll_mastro
date     ld_da_data,  ld_a_data

ls_statement  = "{Conto.ID_Azienda} = 1"

ls_da_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, "da_cod")	
ls_ad_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, "a_cod")
ld_da_data	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data")
ld_a_data	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data")
ls_filtra = tab_1.tabpage_select.dw_selection.GetItemString(1, "filtra")	

select pref_cod_cliente, pref_cod_fornitore
into :ls_pref_cl, :ls_pref_fo
from par_sistema;


if ls_da_codice > ls_ad_codice then
	if MessageBox( "Attenzione","Conto 'da' maggiore di conto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if

if ld_da_data > ld_a_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	




IF tab_1.tabpage_select.dw_selection.GetItemString(1, "tutti")='N' then

	if not IsNull(ls_da_codice) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {Conto.Codice} >= '" + ls_da_codice + "'"
		ls_statform 	= "'Da conto " + ls_da_codice + ", "
	else
		ls_statform 	= "'Da conto non definito, "
	end if

	if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
		ls_statement 	= ls_statement + " AND {Conto.Codice} <= '" + ls_ad_codice + "'"
		ls_statform  	= ls_statform + "a conto " + ls_ad_codice + ".'"
	else
		ls_statform  	= ls_statform + "a conto non definito.'"
	end if

END IF

if ls_filtra='C' then 
   select id_mastro into :ll_mastro
	from mastro where codice=:ls_pref_cl;
	ls_statement 		= ls_statement + " AND {Sottomastro.Id_mastro} =" +string(ll_mastro)
	ls_statement 		= ls_statement + " AND {Registro.Tipo_registro} ='IV'"
else	
   select id_mastro into :ll_mastro
	from mastro where codice=:ls_pref_fo;
	ls_statement 		= ls_statement + " AND {Sottomastro.Id_mastro} =" +string(ll_mastro)
	ls_statement 		= ls_statement + " AND {Registro.Tipo_registro} ='IA'"
end if	




if Not IsNull(ld_da_data) then
	ls_statement 		= ls_statement + " AND {Reg_pd.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
else
	
	
end if

if Not IsNull(ld_a_data) then
	ls_statement 		= ls_statement + " AND {Reg_pd.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	
else
	
	
end if



is_selection 	= ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

							
return 0



end event

type cb_esci from w_print_main`cb_esci within w_and_mensile_rpt
int X=2071
end type

type tab_1 from w_print_main`tab_1 within w_and_mensile_rpt
int Width=2409
int Height=852
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2373
int Height=724
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=14
int Y=24
int Width=2336
int Height=680
string DataObject="d_and_mensile_rpt"
end type

event dw_selection::ue_set_search;
STRING LS_FILTRO

ls_filtro=this.getitemstring(1,'filtra')

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = '" + ls_filtro + "'"
	CASE "da_descr", "a_descr"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = '" + ls_filtro + "'"
		
END CHOOSE

end event

event dw_selection::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_cod" then
			uf_set_colval("da_descr", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_cod', is_ricpar.s_main_value)
			    uf_set_colval("a_descr", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_descr", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_descr", "a_descr"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_descr" then
			uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_descr', is_ricpar.s_main_value)
			    uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
		end if
END CHOOSE

end event

event dw_selection::ue_initial;
this.SetItem(1, "da_data",date (string(year(today())) + '-01-01') )
this.SetItem( 1,"a_data",Today() )

long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

event dw_selection::itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_codice, ls_cod_art, ls_sql_cond, ls_filtro
integer li_ok

ls_filtro=this.getitemstring(1,'filtra')
ls_sql_cond="sog_commerciale_gen.tipo='"+ls_filtro+"'"

CHOOSE CASE dwo.name
	
	case "da_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_descr"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_cod',data)
				 this.setitem(1,'a_descr',this.getitemstring(1,'da_descr'))
			end if
			return 2
		end if	
		
	case "da_descr"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_descr"
		li_ok = uf_autofind_col (string(dwo.name),"conto","sog_commerciale_gen","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_descr',data)
				 this.setitem(1,'a_cod',this.getitemstring(1,'da_cod'))
			end if
			return 2
		end if	
	
	case "a_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_descr"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_descr"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_descr"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
end choose
end event

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2373
int Height=724
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2373
int Height=724
end type

type cb_stampa from w_print_main`cb_stampa within w_and_mensile_rpt
int X=1810
end type

