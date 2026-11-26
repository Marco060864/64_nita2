forward
global type w_piano_dei_conti_rpt from w_print_main
end type
end forward

global type w_piano_dei_conti_rpt from w_print_main
int Width=2103
int Height=1272
boolean TitleBar=true
string Title="Stampa Piano dei Conti"
end type
global w_piano_dei_conti_rpt w_piano_dei_conti_rpt

type prototypes

end prototypes

on w_piano_dei_conti_rpt.create
call super::create
end on

on w_piano_dei_conti_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_pdc
string	ls_da_mastro, ls_ad_mastro, ls_da_cod, ls_a_cod, ls_tipo_stampa,ls_pdc,ls_saldo,ls_stampa_saldo,ls_stampaclifor

boolean 	lb_can_convert
String 	statement, ls_selezione, ls_statform1, ls_statform2

ls_da_mastro	 = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_mastro")
ls_ad_mastro	 = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_mastro")

if ls_da_mastro > ls_ad_mastro then
	if MessageBox( "Attenzione","Mastro 'da' maggiore di Mastro 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

ls_da_cod		 = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod")
ls_a_cod			 = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod")

if ls_da_cod > ls_a_cod then
	if MessageBox( "Attenzione","Codice 'da' maggiore di Codice 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

ls_tipo_stampa  = tab_1.tabpage_select.dw_selection.GetItemString(1,"tipo_stampa")
ll_pdc			 = tab_1.tabpage_select.dw_selection.GetItemNumber(1,"piano_cod")
ls_saldo			 = tab_1.tabpage_select.dw_selection.GetItemString(1,"saldo_div_zero")
ls_stampa_saldo = tab_1.tabpage_select.dw_selection.GetItemString(1,"stampa_saldo")
ls_stampaclifor = tab_1.tabpage_select.dw_selection.GetItemString(1,"stampa_completa")

statement  = " {Mastro.ID_Azienda} = 1 "

if not isNull(ls_pdc) then
	statement 		= statement + " AND {Mastro.ID_pdc} = " + string(ll_pdc) 
	ls_statform1 	= " Piano dei conti " + string(ll_pdc)  + ", "
else
	ls_statform1 	= " Piano dei conti - non definito, "
end if

if not isNull(ls_da_mastro) and ls_da_mastro <> "" then
	statement 		= statement + " AND {Mastro.Codice} >= '" + ls_da_mastro + "'"
	ls_statform1 	= " Da codice mastro " + ls_da_mastro + ", "
else
	ls_statform1   = " Da codice mastro - non definito, "
end if

if not isNull(ls_ad_mastro) and ls_ad_mastro <> "" then
	statement 		= statement + " AND {Mastro.Codice} <= '" + ls_ad_mastro + "'"
	ls_statform1 	= ls_statform1 + "a codice mastro " + ls_ad_mastro + "."
else
	ls_statform1 	= ls_statform1 + "a codice mastro - non definito."
end if

if not isNull(ls_da_cod) and ls_da_cod <> "" then
	statement 		= statement + " AND {Conto.Codice} >= '" + ls_da_cod + "'"
	ls_statform2 	= " Da codice conto " + ls_da_cod + ", "
else
	ls_statform2 	= " Da codice conto - non definito, "
end if

if not isNull(ls_a_cod) and ls_a_cod <> "" then
	statement 		= statement + " AND {Conto.Codice} <= '" + ls_a_cod + "'"
	ls_statform2 	= ls_statform2 + "a codice conto " + ls_a_cod + ".'"
else
	ls_statform2 	= ls_statform2 + "a codice conto - non definito.'"
end if


is_selection = statement

istr_formule[1].formula_name = "selezione"
istr_formule[2].formula_name = "sottomastri"
istr_formule[3].formula_name = "Solodivzero"
istr_formule[4].formula_name = "Solovalori"
istr_formule[5].formula_name = "Qualiconti"
istr_formule[6].formula_name = "conclifor"


if ls_tipo_stampa = "M" then
	ls_selezione = "'Stampa Mastri"
	istr_formule[2].formula_string = "'F'"
	istr_formule[5].formula_string = "'M'"
elseif ls_tipo_stampa = "S" then
	ls_selezione = "'Stampa Sottomastri"
	istr_formule[2].formula_string = "''"
	istr_formule[5].formula_string = "'S'"
else
	ls_selezione = "'Stampa Conti"	
	istr_formule[2].formula_string = "''"
	istr_formule[5].formula_string = "'C'"
end if

if ls_stampaclifor = "S" then
	istr_formule[6].formula_string = "'S'"
else	
	istr_formule[6].formula_string = "'N'"
end if

if ls_saldo = "S" then
	istr_formule[3].formula_string = "'S'"
else
	istr_formule[3].formula_string = "'N'"
end if

if ls_stampa_saldo = "S" then
	istr_formule[4].formula_string = "'S'"
else
	istr_formule[4].formula_string = "'N'"
end if	

ls_selezione = ls_selezione + ls_statform1 + ls_statform2
if left(ls_selezione,1) <> "'" then
	ls_selezione = "'" + ls_selezione
end if
if right(ls_selezione,1) <> "'" then
	ls_selezione = ls_selezione + "'"
end if

istr_formule[1].formula_string = ls_selezione

return 0

end event

event ue_post_open;call super::ue_post_open;
return 0
end event

type cb_esci from w_print_main`cb_esci within w_piano_dei_conti_rpt
int X=1742
end type

type tab_1 from w_print_main`tab_1 within w_piano_dei_conti_rpt
int Y=200
int Width=2034
int Height=980
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=1998
int Height=852
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=27
int Y=28
int Width=1943
int Height=800
string DataObject="d_piano_dei_conti_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;
long ll_pdc
ll_pdc			 = this.GetItemNumber(1,"piano_cod")

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		is_search_window 				= "w_conto_pdc_sw" 
		is_ricpar.s_filter_value 	= as_valcol 
		is_ricpar.s_filter_name 	= "codice" 
		is_ricpar.s_sql_cond		 	= "conto_pdc.id_pdc = " + string(ll_pdc)
		
	CASE "da_descr", "a_descr"
		is_search_window 				= "w_conto_pdc_sw" 
		is_ricpar.s_filter_value 	= as_valcol 
		is_ricpar.s_filter_name 	= "descrizione" 
		is_ricpar.s_sql_cond		 	= "conto_pdc.id_pdc = " + string(ll_pdc)
		
END CHOOSE

end event

event dw_selection::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_id_conto", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_cod" then
			
			if isnull(this.getitemstring(1,'a_cod'))  or this.getitemstring(1,'a_cod')='' then
		           	uf_set_colval('a_cod', is_ricpar.s_main_value)
			end if			  
		
			
		end if
END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "da_mastro"
is_drop_column[2] = "a_mastro"
is_drop_column[3] = "piano_cod"
is_drop_column[4] = "piano_des"

end event

event dw_selection::ue_set_drop;call super::ue_set_drop;long 					ll_row
string  				ls_filtro,ls_old_select,ls_where_clause,ls_new_select 
integer				il_id_conto
datawindowchild	ldw_da_mastro
datawindowchild	ldw_a_mastro

ll_row = this.GetRow()

SELECT "azienda"."id_pdc"
	INTO : il_id_conto
	FROM "dba"."azienda"   
	WHERE ( "azienda"."id_azienda" = 1 );

if SQLCA.SQLCode = -1 then
	MessageBox( "Errore Database","Tabella azienda : " + SQLCA.SQLErrText,StopSign! )
else
	if SQLCA.SQLCode = 100 then
		MessageBox( "Warning","Non è stato trovato un piano dei conti aziendale",StopSign! )
	else	
		if not isNull( il_id_conto ) then
			post SetItem(ll_row,"piano_cod",il_id_conto)
			this.GetChild( "da_mastro",ldw_da_mastro )
			this.GetChild( "a_mastro",ldw_a_mastro )
			ls_filtro = "id_pdc = " + string(il_id_conto)
			ldw_da_mastro.SetFilter(ls_filtro)
			ldw_da_mastro.Filter()
			ldw_a_mastro.SetFilter(ls_filtro)
			ldw_a_mastro.Filter()		
		end if	
	end if	
end if	

return 0


end event

event dw_selection::itemchanged;long 					ll_row
string  				ls_filtro,ls_old_select,ls_where_clause,ls_new_select 
integer				li_id_conto
datawindowchild	ldw_da_mastro
datawindowchild	ldw_a_mastro
string  ls_dbc[], ls_dbv[], ls_dwc[], ls_codice, ls_cod_art
integer li_ok



choose case dwo.name
		
	case "piano_cod"
		
		if not isNull( data ) then
			
			this.SetItem( row,"da_mastro","" )
			this.SetItem( row,"a_mastro","" )
			
			this.GetChild( "da_mastro",ldw_da_mastro )
			this.GetChild( "a_mastro",ldw_a_mastro )
			
			ls_filtro = "id_pdc = " + data
			ldw_da_mastro.SetFilter(ls_filtro)
			ldw_da_mastro.Filter()
			ldw_a_mastro.SetFilter(ls_filtro)
			ldw_a_mastro.Filter()		
			
		end if	
		



	case "da_cod"
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod"
		li_ok = uf_autofind_col (string(dwo.name),"conto_pdc","codice","A",data,"",1,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod'))  or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_cod',data)
			end if
			return 2
		end if	
		
	case "a_cod"
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod"
		li_ok = uf_autofind_col (string(dwo.name),"conto_pdc","codice","A",data,"",1,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			return 2
		end if

end choose


end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=1998
int Height=852
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=1998
int Height=852
end type

type rb_video from w_print_main`rb_video within w_piano_dei_conti_rpt
int X=366
end type

type cb_stampa from w_print_main`cb_stampa within w_piano_dei_conti_rpt
int X=1481
end type

