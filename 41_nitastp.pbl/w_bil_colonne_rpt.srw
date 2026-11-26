forward
global type w_bil_colonne_rpt from w_print_main
end type
end forward

global type w_bil_colonne_rpt from w_print_main
string title = "Bilancio a colonne"
end type
global w_bil_colonne_rpt w_bil_colonne_rpt

forward prototypes
public function string wf_check_result (long al_value)
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

on w_bil_colonne_rpt.create
call super::create
end on

on w_bil_colonne_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_da_mese,ll_da_anno,ll_a_mese,ll_a_anno
long		ll_mio_inizio,ll_mio_fine
string	ls_stampa_con
string 	ls_statement, ls_selezione

ll_mio_inizio	= 0
ll_mio_fine		= 0

ll_da_mese		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_mese")
ll_da_anno		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_anno")
ll_a_mese		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_mese")
ll_a_anno		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_anno")
ls_stampa_con	= tab_1.tabpage_select.dw_selection.GetItemString(1,"val_stampa")

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

if isNull( ll_da_mese ) and not isNull( ll_da_anno ) then
	MessageBox( "Validazione del periodo","Specificare un mese di inizio periodo",Information! )
	return -1
end if

if not isNull( ll_da_mese ) and isNull( ll_da_anno ) then
	MessageBox( "Validazione del periodo","Specificare un anno di inizio periodo",Information! )
	return -1
end if

if isNull( ll_a_mese ) and not isNull( ll_a_anno ) then
	MessageBox( "Validazione del periodo","Specificare un mese di fine periodo",Information! )
	return -1
end if

if not isNull( ll_a_mese ) and isNull( ll_a_anno ) then
	MessageBox( "Validazione del periodo","Specificare un anno di fine periodo",Information! )
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


if not isNull( ll_da_mese ) and not isNull( ll_da_anno ) then
	ll_mio_inizio	= ( ( ll_da_anno * 100 ) + ll_da_mese )
	ls_statement	= "( { Saldo_Mensile.anno_mese } ) >= " + wf_check_result(ll_mio_inizio)
end if	
	
if not isNull( ll_a_mese ) and not isNull( ll_a_anno ) then
	ll_mio_fine	= ( ( ll_a_anno * 100 ) + ll_a_mese )
	if ll_mio_inizio > 0 then
		ls_statement	= ls_statement + " AND ( { Saldo_Mensile.anno_mese } ) <= " + wf_check_result(ll_mio_fine)
	else
		ls_statement	= "( { Saldo_Mensile.anno_mese } ) <= " + wf_check_result(ll_mio_fine)
	end if
end if	

if ll_mio_inizio > 0 then
end if
	
if ll_mio_fine > 0 then
end if

istr_sub_formule[1].s_subreport				= "GRS_bil_colonne.rpt"
istr_sub_formule[1].s_selection_formula 	= ls_statement
istr_sub_formule[1].str_formula[1].formula_name 		= "tipo_conto"
istr_sub_formule[1].str_formula[1].formula_string 	= "'" + ls_stampa_con + "'"

return 0
end event

type cb_esci from w_print_main`cb_esci within w_bil_colonne_rpt
end type

type tab_1 from w_print_main`tab_1 within w_bil_colonne_rpt
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
string dataobject = "d_bil_colonne_rpt"
end type

event dw_selection::itemchanged;call super::itemchanged;long		ll_anno
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
		
end choose
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
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
end type

type st_5 from w_print_main`st_5 within tabpage_export
end type

type st_4 from w_print_main`st_4 within tabpage_export
end type

type sle_field_name from w_print_main`sle_field_name within tabpage_export
end type

type ddplb_tipi_file from w_print_main`ddplb_tipi_file within tabpage_export
end type

type rb_export from w_print_main`rb_export within w_bil_colonne_rpt
integer y = 76
end type

type rb_video from w_print_main`rb_video within w_bil_colonne_rpt
end type

type rb_stampante from w_print_main`rb_stampante within w_bil_colonne_rpt
end type

type cb_stampa from w_print_main`cb_stampa within w_bil_colonne_rpt
end type

type gb_output from w_print_main`gb_output within w_bil_colonne_rpt
end type

