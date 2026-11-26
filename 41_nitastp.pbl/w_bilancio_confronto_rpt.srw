forward
global type w_bilancio_confronto_rpt from w_print_main
end type
end forward

global type w_bilancio_confronto_rpt from w_print_main
integer width = 2245
integer height = 1360
string title = "Bilancio a colonne"
end type
global w_bilancio_confronto_rpt w_bilancio_confronto_rpt

forward prototypes
public function string wf_check_result (long al_value)
public function long wf_confronto (long anno1, long anno2, long mese1, long mese2, string confronto)
public function string wf_conversione (long anno, long mese)
public function string wf_data (long al_data)
end prototypes

public function string wf_check_result (long al_value);
char		lc_value[],lc_temp[]
long		ll_i,ll_k
string	ls_value

ls_value = string(al_value)
lc_value	= ls_value

if Len( ls_value ) = 5 then
	for ll_i = 1 to UpperBound( lc_value )
		if ll_i = UpperBound(lc_value) then
			lc_temp[ll_i] = '0'
			ll_k	= ll_i + 1
			lc_temp[ll_k] = lc_value[ll_i]
		else
			lc_temp[ll_i] = lc_value[ll_i]
		end if		
	next
	ls_value	= lc_temp
end if

return ls_value
end function

public function long wf_confronto (long anno1, long anno2, long mese1, long mese2, string confronto);
long ll_data, ll_data_1

if isnull(anno1) or isnull(anno2) then               
  ll_data	= -1
end if


if (not isnull(anno1) and not isnull (anno2)) then 
	ll_data	= ( ( anno1 * 100 ) + mese1 )
	ll_data_1	= ( ( anno2 * 100 ) + mese2 )



	if confronto	= "minore" then
		  if ll_data_1 < ll_data then
		  ll_data	= ll_data_1
		  end if
	elseif ll_data_1 > ll_data then
			ll_data	= ll_data_1		
	end if
end if
return ll_data

end function

public function string wf_conversione (long anno, long mese);long		ll_data
string	ls_data

ll_data	= ( ( anno * 100 ) + mese )
ls_data	= wf_check_result(ll_data)
return ls_data
end function

public function string wf_data (long al_data);
char		lc_value[],lc_temp[],lc_anno[],lc_mese[]
long		ll_i,ll_k
string	ls_value

ls_value = string(al_data)
lc_value	= ls_value

if Len( ls_value ) = 5 then
	for ll_i = 1 to UpperBound( lc_value )
		if ll_i = UpperBound(lc_value) then
			lc_temp[ll_i] = '0'
			ll_k	= ll_i + 1
			lc_temp[ll_k] = lc_value[ll_i]
		else
			lc_temp[ll_i] = lc_value[ll_i]
		end if		
	next
	ls_value	= lc_temp
end if

for ll_i =	1	to 4
lc_anno[ll_i] =	lc_value[ll_i]
next
lc_mese[1] =	lc_value[5]
lc_mese[2] =	lc_value[6]

ls_value =	"mese " +lc_mese+ " anno "+lc_anno+" "
return ls_value

end function

on w_bilancio_confronto_rpt.create
call super::create
end on

on w_bilancio_confronto_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_da_mese,ll_da_anno,ll_a_mese,ll_a_anno
long		ll_da_mese_p2,ll_da_anno_p2,ll_a_mese_p2,ll_a_anno_p2
long		ll_mio_inizio,ll_mio_fine, ll_pdc
string	ls_da_cod, ls_ad_cod
string	ls_daannomese1, ls_daannomese2, ls_aannomese1, ls_aannomese2 
string 	ls_statement, ls_selezione

ll_mio_inizio	= 0
ll_mio_fine		= 0
ls_statement	= " "
ls_selezione	= " "
ls_daannomese1	= " "
ls_daannomese2 = " "
ls_aannomese1  = " "
ls_aannomese2  = " "

ls_da_cod 		= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_conto_cod")
ls_ad_cod 		= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_conto_cod")
ll_da_mese		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_mese")
ll_da_anno		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_anno")
ll_a_mese		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_mese")
ll_a_anno		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_anno")
ll_da_mese_p2	= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_mese_p2")
ll_da_anno_p2	= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_anno_p2")
ll_a_mese_p2	= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_mese_p2")
ll_a_anno_p2	= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_anno_p2")

ll_pdc			 = tab_1.tabpage_select.dw_selection.GetItemNumber(1,"piano_cod")
if not isNull( ll_da_anno ) then
	if ll_da_anno < 100 then
		ll_da_anno += 1900
	end if	
end if	

if not isNull( ll_a_anno ) then
	if ll_a_anno < 100 then
		ll_a_anno += 1900
	end if	
end if	

if not isNull( ll_da_anno_p2 ) then
	if ll_da_anno_p2 < 100 then
		ll_da_anno_p2 += 1900
	end if	
end if	

if not isNull( ll_a_anno_p2 ) then
	if ll_a_anno_p2 < 100 then
		ll_a_anno_p2 += 1900
	end if	
end if	

if isNull( ll_da_mese ) and not isNull( ll_da_anno ) then
	MessageBox( "Validazione del periodo","Specificare un mese di inizio Periodo 1",Information! )
	return -1
end if

if not isNull( ll_da_mese ) and isNull( ll_da_anno ) then
	MessageBox( "Validazione del periodo","Specificare un anno di inizio Periodo 1",Information! )
	return -1
end if

if isNull( ll_a_mese ) and not isNull( ll_a_anno ) then
	MessageBox( "Validazione del periodo","Specificare un mese di fine Periodo 1",Information! )
	return -1
end if

if not isNull( ll_a_mese ) and isNull( ll_a_anno ) then
	MessageBox( "Validazione del periodo","Specificare un anno di fine Periodo 1",Information! )
	return -1
end if

if isNull( ll_da_mese_p2 ) and not isNull( ll_da_anno_p2 ) then
	MessageBox( "Validazione del periodo","Specificare un mese di inizio Periodo 2",Information! )
	return -1
end if

if not isNull( ll_da_mese_p2 ) and isNull( ll_da_anno_p2 ) then
	MessageBox( "Validazione del periodo","Specificare un anno di inizio Periodo 2",Information! )
	return -1
end if

if isNull( ll_a_mese_p2 ) and not isNull( ll_a_anno_p2 ) then
	MessageBox( "Validazione del periodo","Specificare un mese di fine Periodo 2",Information! )
	return -1
end if

if not isNull( ll_a_mese_p2 ) and isNull( ll_a_anno_p2 ) then
	MessageBox( "Validazione del periodo","Specificare un anno di fine Periodo 2",Information! )
	return -1
end if
if not isNull( ll_da_mese ) and not isNull( ll_da_anno ) then
	if not isNull( ll_a_mese ) and not isNull( ll_a_anno ) then
		if ll_da_anno > ll_a_anno then
			if MessageBox( "Validazione del periodo","Anno 'da' maggiore di Anno 'a',Continuare ? ",Question!,YesNo!,2 ) = 2 then
				return -1
			end if
		elseif ll_da_anno = ll_a_anno then 
			if ll_da_mese > ll_a_mese then
				if MessageBox( "Validazione del periodo","Mese 'da' maggiore di mese 'a',Continuare ? ",Question!,YesNo!,2 ) = 2 then
					return -1
				end if
			end if	
		end if	
	end if
end if	

if not isNull( ll_da_mese_p2 ) and not isNull( ll_da_anno_p2 ) then
	if not isNull( ll_a_mese_p2 ) and not isNull( ll_a_anno_p2 ) then
		if ll_da_anno > ll_a_anno then
			if MessageBox( "Validazione del periodo","Anno 'da' maggiore di Anno 'a',Continuare ? ",Question!,YesNo!,2 ) = 2 then
				return -1
			end if
		elseif ll_da_anno_p2 = ll_a_anno_p2 then
			if ll_da_mese_p2 > ll_a_mese_p2 then
				if MessageBox( "Validazione del periodo","Mese 'da' maggiore di mese 'a',Continuare ? ",Question!,YesNo!,2 ) = 2 then
					return -1
				end if
			end if	
		end if	
	end if
end if	

if not isNull(ll_pdc) then
	ls_statement 		= " {Conto_pdc.ID_pdc} = " + string(ll_pdc) 
	ls_selezione 		= 	" Piano dei conti " + string(ll_pdc)  + ", "
else
	ls_selezione 		= " Piano dei conti - non definito, "
end if
if Not IsNull(ls_da_cod) and ls_da_cod <> "" then
	if ls_statement <> " " then
		ls_statement = ls_statement + " AND  {Conto_pdc.Codice} >= '" + ls_da_cod + "'"
	else
		ls_statement =	"{Conto_pdc.Codice} >= '" + ls_da_cod + "'"
	end if
	ls_selezione 	= ls_selezione + " Dal codice conto " + ls_da_cod + ", "
else
	ls_selezione 	= ls_selezione + " Dal codice conto - non definito, "
end if

if Not IsNull(ls_ad_cod) and ls_ad_cod <> "" then
	if ls_statement <> " " then
		ls_statement 	= ls_statement + " AND {Conto_pdc.Codice} <= '" + ls_ad_cod + "'"
	else
		ls_statement	= "{Conto_pdc.Codice} <= '" + ls_ad_cod + "'"
	end if
	ls_selezione	= ls_selezione + " al codice conto " + ls_ad_cod +". "
else
	ls_selezione 	= ls_selezione + "al codice conto - non definito. "
end if
ll_mio_inizio	= wf_confronto(ll_da_anno, ll_da_anno_p2, ll_da_mese, ll_da_mese_p2, "minore")
if ll_mio_inizio > 0 then
	if ls_statement <> " " then
		ls_statement	= ls_statement+ " AND { Saldo_Mensile.anno_mese } >= " + wf_check_result(ll_mio_inizio)
	else 
		ls_statement	= " { Saldo_Mensile.anno_mese } >= " + wf_check_result(ll_mio_inizio)
	end if
	ls_selezione	= ls_selezione+ "Dal periodo "+ wf_data(ll_mio_inizio)
else 
	ls_selezione	= ls_selezione + "Dal periodo  - non definito "
end if
	
ll_mio_fine		= wf_confronto(ll_a_anno, ll_a_anno_p2, ll_a_mese, ll_a_mese_p2,"maggiore")
if ll_mio_fine > 0 then
	if ls_statement <> " " then
		ls_statement	= ls_statement + " AND { Saldo_Mensile.anno_mese } <= " + wf_check_result(ll_mio_fine)
	else
		ls_statement	= ls_statement + " AND { Saldo_Mensile.anno_mese } <= " + wf_check_result(ll_mio_fine)
	end if
	ls_selezione	= ls_selezione + "al periodo"+ wf_data(ll_mio_fine)+"."
else
	ls_selezione	= ls_selezione + "al periodo - non definito"
end if

ls_daannomese1=	wf_conversione(ll_da_anno, ll_da_mese)
ls_aannomese1=		wf_conversione(ll_a_anno, ll_a_mese)
ls_daannomese2=	wf_conversione(ll_da_anno_p2, ll_da_mese_p2)
ls_aannomese2=		wf_conversione(ll_a_anno_p2, ll_a_mese_p2)



is_selection 	= ls_statement
istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
istr_formule[2].formula_name 		= "daannomese1"
istr_formule[2].formula_string 	= ls_daannomese1
istr_formule[3].formula_name 		= "aannomese1"
istr_formule[3].formula_string 	= ls_aannomese1
istr_formule[4].formula_name 		= "daannomese2"
istr_formule[4].formula_string 	= ls_daannomese2
istr_formule[5].formula_name 		= "aannomese2"
istr_formule[5].formula_string 	= ls_aannomese2
return 0

end event

type cb_esci from w_print_main`cb_esci within w_bilancio_confronto_rpt
integer x = 1947
end type

type tab_1 from w_print_main`tab_1 within w_bilancio_confronto_rpt
integer x = 46
integer width = 2171
integer height = 1080
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
integer width = 2135
integer height = 952
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
integer y = 28
integer width = 2034
integer height = 880
string dataobject = "d_bilancio_confronto_rpt"
end type

event dw_selection::itemchanged;call super::itemchanged;
long		ll_anno
choose case dwo.name
	case 'da_mese'
		if not isNull(data) then
			if long(data) > 12 then
				return 1
			end if	
		end if	
		
	case 'a_mese'
		if not isNull(data) then
			if long(data) > 12 then
				return 1
			end if	
		end if	
		
	case 'da_mese_p2'
		if not isNull(data) then
			if long(data) > 12 then
				return 1
			end if	
		end if	
		
	case 'a_mese_p2'
		if not isNull(data) then
			if long(data) > 12 then
				return 1
			end if	
		end if	
		
	case 'da_anno'
		if not isNull(data) then
			ll_anno	= long(data)
			if ll_anno >= 100 and ll_anno < 1900 then
				return 1
			end if	
		end if	
		
	case 'a_anno'
		if not isNull(data) then
			ll_anno	= long(data)
			if ll_anno >= 100 and ll_anno < 1900 then
				return 1
			end if	
		end if
		
	case 'da_anno_p2'
		if not isNull(data) then
			ll_anno	= long(data)
			if ll_anno >= 100 and ll_anno < 1900 then
				return 1
			end if	
		end if	
		
	case 'a_anno_p2'
		if not isNull(data) then
			ll_anno	= long(data)
			if ll_anno >= 100 and ll_anno < 1900 then
				return 1
			end if	
		end if		
		
end choose
end event

event dw_selection::itemfocuschanged;call super::itemfocuschanged;string	ls_dal_conto_cod,ls_dal_conto_des
string	ls_al_conto_cod,ls_al_conto_des
long		ll_row

choose case dwo.name
		
	case 'a_conto_cod','a_conto_des'
		ll_row				= this.GetRow()
		ls_dal_conto_cod	= this.GetItemString( ll_row,"da_conto_cod" )
		ls_dal_conto_des	= this.GetItemString( ll_row,"da_conto_des" )
		ls_al_conto_cod	= this.GetItemString( ll_row,"a_conto_cod" )
		ls_al_conto_des	= this.GetItemString( ll_row,"a_conto_des" )
		if not isNull( ls_dal_conto_cod ) then
			if isNull( ls_al_conto_cod ) then
				this.SetItem( ll_row,"a_conto_cod",ls_dal_conto_cod )
			end if	
		end if
		if not isNull( ls_dal_conto_des ) then
			if isNull( ls_al_conto_des ) then
				this.SetItem( ll_row,"a_conto_des",ls_dal_conto_des )
			end if	
		end if
		
end choose

end event

event dw_selection::ue_set_search;call super::ue_set_search;
long ll_pdc
ll_pdc			 = this.GetItemNumber(1,"piano_cod")

CHOOSE CASE as_nomecol
		
	CASE "da_conto_cod", "a_conto_cod"
		is_search_window = "w_conto_pdc_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond		 	= "conto_pdc.id_pdc = " + string(ll_pdc)
	CASE "da_conto_des", "a_conto_des"
		is_search_window = "w_conto_pdc_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		is_ricpar.s_sql_cond		 	= "conto_pdc.id_pdc = " + string(ll_pdc)
END CHOOSE



end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_conto_cod", "a_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_conto_cod" then
			uf_set_colval("da_conto_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_conto_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_conto_des", "a_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_conto_des" then
			uf_set_colval("da_conto_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_conto_cod", is_ricpar.s_ausil_value[1])
		end if
END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "piano_cod"
is_drop_column[2] = "piano_des"

end event

event dw_selection::ue_set_drop;call super::ue_set_drop;long 					ll_row
string  				ls_filtro,ls_old_select,ls_where_clause,ls_new_select 
integer				il_id_conto
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

		end if	
	end if	
end if	

return 0


end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
integer width = 2135
integer height = 952
end type

type ddlb_stampanti from w_print_main`ddlb_stampanti within tabpage_stampante
end type

type cb_salva_config from w_print_main`cb_salva_config within tabpage_stampante
end type

type cb_printer_setup from w_print_main`cb_printer_setup within tabpage_stampante
end type

type st_6 from w_print_main`st_6 within tabpage_stampante
end type

type em_copie from w_print_main`em_copie within tabpage_stampante
end type

type em_a_pagina from w_print_main`em_a_pagina within tabpage_stampante
end type

type em_da_pagina from w_print_main`em_da_pagina within tabpage_stampante
end type

type st_3 from w_print_main`st_3 within tabpage_stampante
end type

type rb_page from w_print_main`rb_page within tabpage_stampante
end type

type rb_all_page from w_print_main`rb_all_page within tabpage_stampante
end type

type st_2 from w_print_main`st_2 within tabpage_stampante
end type

type st_1 from w_print_main`st_1 within tabpage_stampante
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
integer width = 2135
integer height = 952
end type

type st_5 from w_print_main`st_5 within tabpage_export
end type

type st_4 from w_print_main`st_4 within tabpage_export
end type

type sle_field_name from w_print_main`sle_field_name within tabpage_export
end type

type ddplb_tipi_file from w_print_main`ddplb_tipi_file within tabpage_export
end type

type rb_export from w_print_main`rb_export within w_bilancio_confronto_rpt
integer y = 76
end type

type rb_video from w_print_main`rb_video within w_bilancio_confronto_rpt
end type

type rb_stampante from w_print_main`rb_stampante within w_bilancio_confronto_rpt
end type

type cb_stampa from w_print_main`cb_stampa within w_bilancio_confronto_rpt
integer x = 1664
end type

type gb_output from w_print_main`gb_output within w_bilancio_confronto_rpt
end type

