forward
global type w_dinamica_rpt from w_print_main
end type
type st_attesa from statictext within tabpage_select
end type
type st_attesa from statictext within tabpage_select
end type
type cb_check from commandbutton within w_dinamica_rpt
end type
end forward

global type w_dinamica_rpt from w_print_main
int Width=2661
int Height=1377
cb_check cb_check
end type
global w_dinamica_rpt w_dinamica_rpt

type variables
integer		ii_job
string		is_report
pointer		ip_pointer
end variables

forward prototypes
public function string wf_costruisci_formula ()
public function string wf_crw_format (string as_value, string as_tipo)
public function string wf_get_riga_op (string as_value)
public function string wf_get_tipo (string as_value)
public function string wf_get_valore (string as_value)
public function integer wf_scan (string as_formula)
public function integer wf_scan_formula (string as_formula)
public function string wf_format_value (string as_value, string as_tipo)
public function integer wf_check_formula ()
public function string wf_parse_range (string as_value, string as_tipo)
end prototypes

public function string wf_costruisci_formula ();
long		ll_num_rows,ll_row,ll_size,ll_len,ll_i,ll_num_statement
char		lc_statement[],lc_new_statement[]
string	ls_statement,ls_campo,ls_operatore,ls_tipo,ls_valore,ls_op_riga
string	ls_temp


ls_statement		= ""
ll_num_statement	= 0
ll_num_rows			= this.tab_1.tabpage_select.dw_selection.RowCount()



for ll_row = 1 to ll_num_rows
	
	ls_campo			= this.tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"colonna" )
	ls_operatore	= this.tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"operatore" )
	ls_tipo			= this.tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"tipo" )
	ls_valore		= this.tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"valore" )
	ls_op_riga		= this.tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"operatore_riga" )

	
	if isNull(ls_valore) then
		ls_valore = ""
	end if	
	
	
	if ls_valore <> "" then
		
		ls_temp = ls_statement
		ls_temp = Trim(ls_temp)
		
		if Right(ls_temp,3) <> "AND" and Right(ls_temp,2) <> "OR" and ll_num_statement > 0 then
			ls_statement = ls_statement + " AND"
		end if	
		
		if isNull(ls_op_riga) then
			ls_op_riga = ""
		end if	
		
		if ls_operatore <> "compreso" then
			ls_statement	= ls_statement + "{" + ls_campo + "} " + ls_operatore 
		else
			ls_statement	= ls_statement + "{" + ls_campo + "} in " 
		end if	
		
		choose case ls_tipo 
				
			case "A" 
				ls_statement = ls_statement  + " '" + ls_valore + "' "  + ls_op_riga + " "
				
			case "N"
				ls_statement = ls_statement  + " " + ls_valore + " "  + ls_op_riga  + " "
				
			case "D"
				ls_valore = wf_crw_format( ls_valore,ls_tipo )
				ls_statement = ls_statement  + "Date(" + ls_valore + ") " + ls_op_riga  + " "
				
			case "I"	
				ls_valore = wf_crw_format( ls_valore,ls_tipo )
				ls_statement = ls_statement  + " [" + ls_valore + "] "  + ls_op_riga  + " "
				
			case "U"	
				ls_valore = wf_crw_format( ls_valore,ls_tipo )
				ls_statement = ls_statement  + " [" + ls_valore + "] "  + ls_op_riga  + " "
				
			case "R"	
				ls_valore = wf_crw_format( ls_valore,ls_tipo )
				ls_statement = ls_statement  + ls_valore + ls_op_riga  + " "
	
			case "E"	
				ls_valore = wf_crw_format( ls_valore,ls_tipo )
				ls_statement = ls_statement  + ls_valore + ls_op_riga  + " "
				
			case "T"	
				ls_valore 		= wf_crw_format( ls_valore,ls_tipo )
				ls_statement 	= ls_statement  + ls_valore + ls_op_riga  + " "
	
			
		end choose				
		ll_num_statement++
	else	
	
		ls_temp = ls_statement
		ls_temp = Trim(ls_temp)
		lc_statement = ls_temp
		
		if Right(ls_temp,3) = "AND" then
			ll_size = UpperBound( lc_statement )
			ll_len = ll_size - 3 
			for ll_i = 1 to ll_len 
				lc_new_statement[ll_i] = lc_statement[ll_i]  

			next	
			ls_statement = lc_new_statement				
		end if	
		
		if Right(ls_temp,2) = "OR" then
			ll_size = UpperBound( lc_statement )
			ll_len = ll_size - 2 
			for ll_i = 1 to ll_len 
				lc_new_statement[ll_i] = lc_statement[ll_i]  
			next	
			ls_statement = lc_new_statement				
		end if	
		
	end if	

next	

return ls_statement

end function

public function string wf_crw_format (string as_value, string as_tipo);
boolean	day_found,month_found
long		ll_size,ll_i,ll_k	
char		lc_value[],lc_new_value[],lc_anno[],lc_mese[],lc_giorno[]
char		lc_anno_vuoto[],lc_mese_vuoto[],lc_giorno_vuoto[]
string	ls_value

ls_value	= as_value
lc_value	= ls_value

day_found	= False
month_found	= False

ll_size	= UpperBound( lc_value )
ll_k		= 1

choose case as_tipo
		
	case "I"
		lc_new_value[ll_k] = "'"
		ll_k++
		for ll_i = 1 to ll_size
			if lc_value[ll_i] <> " " then
				if lc_value[ll_i] = "," then 
					lc_new_value[ll_k] = "'" 
					ll_k++
					lc_new_value[ll_k] = lc_value[ll_i]
					ll_k++
					lc_new_value[ll_k] = "'" 
					ll_k++
				else
					lc_new_value[ll_k] = lc_value[ll_i]
					ll_k++
				end if	
			end if	
			
			if ll_i = ll_size then
				lc_new_value[ll_k] = "'" 
			end if	
		next	
		
		ls_value = lc_new_value
		return ls_value
		
	case "U"
		ls_value = Trim(ls_value)
		return ls_value	
		
	case "D"	
		
		
		
		
		ll_size 	= UpperBound( lc_value )
		ll_k		= 1
		for ll_i = 1 to ll_size
			
			if day_found = False then
				
				if lc_value[ll_i] = "/" then
					day_found = True
					ll_k = 1
				else
					lc_giorno[ll_k] = lc_value[ll_i]
					ll_k++					
				end if
				
			else
				if month_found = False then
					
					if lc_value[ll_i] = "/" then
						month_found = True
						ll_k = 1
					else
						lc_mese[ll_k] = lc_value[ll_i]
						ll_k++					
					end if
						
				else
					lc_anno[ll_k] = lc_value[ll_i]
					ll_k++					
				end if
				
			end if			
		next	
		
		ls_value = lc_anno + "," + lc_mese + "," + lc_giorno
		return ls_value
	
	case "R"  
		lc_new_value[ll_k] = "'"
		ll_k++
		for ll_i = 1 to ll_size
			if lc_value[ll_i] = "," then 
				lc_new_value[ll_k] = "'" 
				ll_k++
				lc_new_value[ll_k] = " "
				ll_k++
				lc_new_value[ll_k] = "t"
				ll_k++
				lc_new_value[ll_k] = "o"
				ll_k++
				lc_new_value[ll_k] = " "
				ll_k++
				lc_new_value[ll_k] = "'" 
				ll_k++
			else
				if lc_value[ll_i] <> " " then
					lc_new_value[ll_k] = lc_value[ll_i]
					ll_k++
				end if	
			end if	
			
			if ll_i = ll_size then
				lc_new_value[ll_k] = "'" 
			end if	
		next	
		
		ls_value = lc_new_value
		ls_value = Trim(ls_value)
		return ls_value
		
	case "E"	
		for ll_i = 1 to ll_size
			
			if lc_value[ll_i] = "," then 
				lc_new_value[ll_k] = " "
				ll_k++
				lc_new_value[ll_k] = "t"
				ll_k++
				lc_new_value[ll_k] = "o"
				ll_k++
				lc_new_value[ll_k] = " "
				ll_k++
			else
				if lc_value[ll_i] <> " " then
					lc_new_value[ll_k] = lc_value[ll_i]
					ll_k++
				end if	
			end if	
		
		next	
		
		ls_value = lc_new_value
		ls_value = Trim(ls_value)
		return ls_value

	case "T"	
			
		
		
		
		ll_size 	= UpperBound( lc_value )
		ll_k		= 1
		for ll_i = 1 to ll_size
			
			if day_found = False then
				
				if lc_value[ll_i] = "/" then
					day_found = True
					ll_k = 1
				else
					lc_giorno[ll_k] = lc_value[ll_i]
					ll_k++					
				end if
				
			else
				if month_found = False then
					
					if lc_value[ll_i] = "/" then
						month_found = True
						ll_k = 1
					else
						lc_mese[ll_k] = lc_value[ll_i]
						ll_k++					
					end if
						
				else
					if lc_value[ll_i] = "," then
						ls_value = "Date(" + lc_anno + "," + lc_mese + "," + lc_giorno + ") to Date("
						lc_giorno 	= lc_giorno_vuoto
						lc_mese 		= lc_mese_vuoto
						lc_anno		= lc_anno_vuoto
						month_found = False
						day_found 	= False
						ll_k = 1
					else	
						lc_anno[ll_k] = lc_value[ll_i]
						ll_k++					
					end if	
				end if
				
			end if			
		next	
		
		ls_value = ls_value + lc_anno + "," + lc_mese + "," + lc_giorno + ") "
		return ls_value
			
		
		return ls_value
	
	
	case else	
		return as_value
		
end choose		
end function

public function string wf_get_riga_op (string as_value);

String	ls_value

ls_value	= as_value

if Right( ls_value,3 ) = "AND" or Right( ls_value,3 ) = "and" then
	return "AND"
end if	

if Right( ls_value,2 ) = "OR" or Right( ls_value,2 ) = "or" then
	return "OR"
end if	

return ""
end function

public function string wf_get_tipo (string as_value);
string		ls_value

ls_value	= as_value
ls_value	= Trim(ls_value)

if Left(ls_value,2) = "['" or Left(ls_value,2) = "[~""then
	return "I"
end if

if Left(ls_value,1 ) = "[" then
	return "U"
end if

if Left(ls_value,4) = "Date" then
	return "D"
end if

if Left(ls_value,1) = "'" or Left(ls_value,1) = "~"" then
	return "A"
end if

if IsNumber(ls_value) then
	return "N"
end if

return ""
end function

public function string wf_get_valore (string as_value);
char		lc_value[],lc_new_value[]
String	ls_value, ls_temp
long		ll_size,ll_i,ll_end

ls_value	= ""
lc_value	= as_value
ls_temp  = as_value
ls_temp	= Trim(ls_temp)

ll_size	= UpperBound(lc_value)

if Right( ls_temp,3 ) = "AND" or Right( ls_temp,3 ) = "and" then
	ll_end	= ll_size - 3
	for ll_i = 1 to ll_end
		lc_new_value[ll_i] = lc_value[ll_i]
	next	
	ls_value = lc_new_value
else
	if Right( ls_temp,2 ) = "OR" or Right( ls_temp,2 ) = "or" then
		ll_end	= ll_size - 2
		for ll_i = 1 to ll_end
			lc_new_value[ll_i] = lc_value[ll_i]
		next	
		ls_value = lc_new_value
	else
		ls_value = ls_temp
	end if	
	
end if	


return ls_value
end function

public function integer wf_scan (string as_formula);
string	ls_formulas[],ls_formula_temp
char		lc_formula_temp[],lc_formula_serv[],lc_formula_vuota[]
long		ll_size,ll_i,ll_k,ll_s,ll_parentesi

lc_formula_serv 	= as_formula
ll_size 				= Len( as_formula )
ll_k					= 1
ll_s					= 1

for ll_i = 1 to ll_size 
	
	if lc_formula_serv[ll_i] <> "~n" and lc_formula_serv[ll_i] <> "~r" then
		
		lc_formula_temp[ll_k] = lc_formula_serv[ll_i]
		ll_k++	
		
		
		if lc_formula_serv[ll_i] = '{' or lc_formula_serv[ll_i] = '}' then
			ll_parentesi++
		end if	
				
		ls_formula_temp = lc_formula_temp
		ls_formula_temp = Trim(ls_formula_temp)
		
		
		if ll_parentesi = 2 then
			if Right(ls_formula_temp,3) = "AND" or Right(ls_formula_temp,2) = "OR" or & 
				Right(ls_formula_temp,3) = "and" or Right(ls_formula_temp,2) = "or" then
				ls_formulas[ll_s] = ls_formula_temp
				lc_formula_temp	= lc_formula_vuota
				ll_k = 1
				ll_s++
				ll_parentesi = 0
			end if	
		end if
	end if	
next	

ls_formula_temp 	= lc_formula_temp
ls_formula_temp 	= Trim(ls_formula_temp)
ls_formulas[ll_s] = ls_formula_temp

for ll_i = 1 to ll_s 		
	if wf_scan_formula( ls_formulas[ll_i] ) = 1 then
		return 1	
	end if	
next

return 0
end function

public function integer wf_scan_formula (string as_formula);
boolean	lb_stop_cicle,lb_range
integer	li_count,li_count_col,li_count_op,li_count_val
string	ls_formula,ls_colonna,ls_operatore,ls_tipo,ls_valore,ls_op_riga,ls_temp,ls_test
string	ls_formulas[],ls_formula_temp,ls_tipo_range
char 		lc_formula[],lc_temp[],lc_vuoto[]
char		lc_colonna[],lc_operatore[],lc_valore[],lc_op_riga[]
char		lc_formula_temp[],lc_formula_serv[],lc_formula_vuota[]
long		ll_row,ll_size,ll_i,ll_k,ll_s,ll_taglia


	
lb_stop_cicle	= false
lb_range			= false

ls_formula		= as_formula
ls_formula		= Trim(ls_formula)
lc_formula 		= ls_formula
li_count			= 2
ll_taglia		= UpperBound(lc_formula)

if lc_formula[1] <> '{' then
	MessageBox( "Parsing","Errore nella formula di selezione : " + as_formula,StopSign! )
	return 1
end if

ll_row	= this.tab_1.tabpage_select.dw_selection.InsertRow(0)

li_count_col = 1
do 
	lc_colonna[li_count_col] = lc_formula[li_count]
	li_count++
	li_count_col++
loop while 	lc_formula[li_count] <> '}'

ls_colonna = lc_colonna
if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"colonna",ls_colonna ) = -1 then
	MessageBox( "Parsing","Set item error",StopSign! )
	return 1
end if	

li_count++

li_count_op = 1
do 
	lc_operatore[li_count_op] = lc_formula[li_count]
	ls_temp = lc_operatore
	ls_temp = Trim(ls_temp)
		
	
	if lc_operatore[li_count_op] = "=" then		
		lb_stop_cicle	= true
		ls_operatore = lc_operatore
	end if
	
	li_count++
	li_count_op++
	
	
	if ( ls_temp = ">" or ls_temp = "<"  ) and  lc_formula[li_count] <> "=" then
		lb_stop_cicle	= true
		ls_operatore = ls_temp
	end if	
	
	
	if ls_temp = "IN" or ls_temp = "BETWEEN" or &
		ls_temp = "in" or ls_temp = "between" then
		lb_stop_cicle	= true
		ls_operatore = ls_temp
	end if		
	
loop while 	lb_stop_cicle	= false

ls_operatore = Trim(ls_operatore)
if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"operatore",ls_operatore ) = -1 then
	MessageBox( "Parsing","Set item error",StopSign! )
	return 1
end if	


li_count_val 	= 1
lb_stop_cicle	= false

do 
		
	lc_valore[li_count_val] = lc_formula[li_count]
	
	ls_temp = lc_valore
	
	
	if Right(ls_temp,2) = "to" or Right(ls_temp,2) = "TO" then
		ls_test	= Trim(ls_temp)
		if Left(ls_test,1) = "~"" or Left(ls_test,1) = "'" then   
			
			ls_tipo_range = "A"
			if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"tipo","R" ) = -1 then
				MessageBox( "Parsing","Set item error",StopSign! )
				return 1
			end if	
			if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"operatore","compreso" ) = -1 then
				MessageBox( "Parsing","Set item error",StopSign! )
				return 1
			end if	
		else
			if Left(ls_test,1) = "D" or Left(ls_test,1) = "d" then   
				
				ls_tipo_range = "T"
				if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"tipo","T" ) = -1 then
					MessageBox( "Parsing","Set item error",StopSign! )
					return 1
				end if	
				if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"operatore","compreso" ) = -1 then
					MessageBox( "Parsing","Set item error",StopSign! )
					return 1
				end if	
			else
				
				ls_tipo_range = "N"
				if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"tipo","E" ) = -1 then
					MessageBox( "Parsing","Set item error",StopSign! )
					return 1
				end if	
				if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"operatore","compreso" ) = -1 then
					MessageBox( "Parsing","Set item error",StopSign! )
					return 1
				end if	
			end if	
		end if			
		lb_range			= true
	end if	
	
	
	ls_op_riga	= wf_get_riga_op(ls_temp)  
	
	if ls_op_riga = "AND" or ls_op_riga = "OR" or ls_op_riga = "and" or ls_op_riga = "or" then
		
		ls_op_riga = Trim(ls_op_riga)
		
		if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"operatore_riga",ls_op_riga ) = -1 then
			MessageBox( "Parsing","Set item error",StopSign! )
			return 1
		else
			lb_stop_cicle	= true
		end if
	else
		if li_count = ll_taglia then
			lb_stop_cicle	= true
		end if	
	end if
	
	
	if lb_stop_cicle	= true then
		
		ls_valore = wf_get_valore(ls_temp)
		if ls_valore <> "" then
						
			if lb_range = true then
				ls_valore = wf_parse_range( ls_valore,ls_tipo_range )
				if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"valore",ls_valore ) = -1 then
					MessageBox( "Parsing","Set item error",StopSign! )
					return 1
				end if	
			else			
				ls_tipo = wf_get_tipo(ls_valore)
				if ls_tipo <> "" then
					
					ls_tipo = Trim( ls_tipo )
					
					if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"tipo",ls_tipo ) = -1 then
						MessageBox( "Parsing","Set item error",StopSign! )
						return 1
					end if	
				end if
				
				ls_valore = wf_format_value( ls_valore,ls_tipo )
				
				ls_valore = Trim( ls_valore )
				
				if this.tab_1.tabpage_select.dw_selection.SetItem(ll_row,"valore",ls_valore ) = -1 then
					MessageBox( "Parsing","Set item error",StopSign! )
					return 1
				end if	
			end if
		end if	
	end if	
	
	li_count++
	li_count_val++	

	
loop while lb_stop_cicle = false

return 0
end function

public function string wf_format_value (string as_value, string as_tipo);
boolean	month_found,year_found
long		ll_size,ll_i,ll_k	
char		lc_value[],lc_new_value[],lc_anno[],lc_mese[],lc_giorno[]
string	ls_value

ls_value	= as_value
Trim( ls_value )
lc_value	= ls_value

month_found	= False
year_found	= False

ll_size	= UpperBound( lc_value )
ll_k		= 1

choose case as_tipo
		
	case "I"
		for ll_i = 1 to ll_size
			if lc_value[ll_i] <> "[" and lc_value[ll_i] <> "]" and lc_value[ll_i] <> "'" and lc_value[ll_i] <> "~"" then
				lc_new_value[ll_k] = lc_value[ll_i]
				ll_k++
			end if			
		next	
		
		ls_value = lc_new_value
		return ls_value
		
	case "U"
		for ll_i = 1 to ll_size
			if lc_value[ll_i] <> "[" and lc_value[ll_i] <> "]" then
				lc_new_value[ll_k] = lc_value[ll_i]
				ll_k++
			end if			
		next	
		
		ls_value = lc_new_value
		return ls_value
	
	case "D"	
		for ll_i = 1 to ll_size
			if lc_value[ll_i] <> "'" and lc_value[ll_i] <> "(" and lc_value[ll_i] <> ")" and &
			   lc_value[ll_i] <> "D" and lc_value[ll_i] <> "d" and lc_value[ll_i] <> "a" and &
				lc_value[ll_i] <> "A" and lc_value[ll_i] <> "T" and lc_value[ll_i] <> "t" and & 
				lc_value[ll_i] <> "E" and lc_value[ll_i] <> "e" and lc_value[ll_i] <> " " then
				lc_new_value[ll_k] = lc_value[ll_i]
				ll_k++
			end if						
		next	
		
		
		
		lc_value = lc_new_value
		ll_size 	= UpperBound( lc_value )
		ll_k		= 1
		for ll_i = 1 to ll_size
			
			if year_found = False then
				
				if lc_value[ll_i] = "," then
					year_found = True
					ll_k = 1
				else
					lc_anno[ll_k] = lc_value[ll_i]
					ll_k++					
				end if
				
			else
				if month_found = False then
					
					if lc_value[ll_i] = "," then
						month_found = True
						ll_k = 1
					else
						lc_mese[ll_k] = lc_value[ll_i]
						ll_k++					
					end if
						
				else
					lc_giorno[ll_k] = lc_value[ll_i]
					ll_k++					
				end if
				
			end if			
		next	
		
		ls_value = lc_giorno + "/" + lc_mese + "/" + lc_anno
		return ls_value
		
	case "A"
		for ll_i = 1 to ll_size
			if lc_value[ll_i] <> "'" and lc_value[ll_i] <> " " and lc_value[ll_i] <> "~"" then
				lc_new_value[ll_k] = lc_value[ll_i]
				ll_k++
			end if			
		next	
		ls_value = lc_new_value
		return ls_value
		
	case "N"
		return ls_value
		
	case else	
		return ls_value
		
end choose		
end function

public function integer wf_check_formula ();integer 	li_ret

is_selection	= wf_costruisci_formula()
//li_ret			= u_freddie.iuo_stampa.of_check_selection_formula( is_selection,is_report )
return li_ret
end function

public function string wf_parse_range (string as_value, string as_tipo);
char			lc_value[],lc_new_value[],lc_result[],lc_anno[],lc_mese[],lc_giorno[]
char			lc_anno_vuoto[],lc_mese_vuoto[],lc_giorno_vuoto[]
string		ls_tipo,ls_result,ls_copy,ls_test,ls_value
integer		li_i,li_k,li_t,li_s,li_size
boolean		month_found,year_found,day_found
long			ll_size


month_found	= False
year_found	= False
day_found	= False

ls_test		= ""
ls_tipo		= as_tipo

ls_value	= as_value
Trim( ls_value )
lc_value	= ls_value

ll_size	= UpperBound( lc_value )
li_k		= 1

choose case as_tipo
	case "A"
		
		li_k			= 1
		for li_i = 1 to UpperBound( lc_value )
			if lc_value[li_i] <> "~"" and lc_value[li_i] <> "'" then
				lc_new_value[li_k] = lc_value[li_i]
				li_k++
			end if
		next

		
		li_k = 1		
		for li_i = 1 to UpperBound( lc_new_value )
			
			if Right(ls_test,2) = "to" or Right(ls_test,2) = "TO" then
				li_t = li_k - 2 
				li_s = li_k - 1 
				lc_result[li_t] 	= ","
				lc_result[li_s] 	= " "
				ls_test 				= lc_result
			else
				lc_result[li_k] 	= lc_new_value[li_i]
				ls_test 				= lc_result
				li_k++				
			end if
		next
		
		ls_result = lc_result

	case "N"
		
		
		li_k = 1		
		for li_i = 1 to UpperBound( lc_value )
			
			if Right(ls_test,2) = "to" or Right(ls_test,2) = "TO" then
				li_t = li_k - 2 
				li_s = li_k - 1 
				lc_result[li_t] 	= ","
				lc_result[li_s] 	= " "
				ls_test 				= lc_result
			else
				lc_result[li_k] 	= lc_value[li_i]
				ls_test 				= lc_result
				li_k++				
			end if
		next
		
		ls_result = lc_result
		
	case "T"
		
		for li_i = 1 to ll_size
			if lc_value[li_i] <> "'" and lc_value[li_i] <> "(" and lc_value[li_i] <> ")" and &
			   lc_value[li_i] <> "D" and lc_value[li_i] <> "d" and lc_value[li_i] <> "a" and &
				lc_value[li_i] <> "A" and lc_value[li_i] <> "T" and lc_value[li_i] <> "t" and & 
				lc_value[li_i] <> "E" and lc_value[li_i] <> "e" and lc_value[li_i] <> " " then
				
				if lc_value[li_i] = "O" or lc_value[li_i] = "o" then
					lc_new_value[li_k] = ","
					li_k++
				else	
					lc_new_value[li_k] = lc_value[li_i]
					li_k++
				end if	
			end if						
		next	
		
		
		
		
		lc_value = lc_new_value
		ll_size 	= UpperBound( lc_value )
		li_k		= 1
		for li_i = 1 to ll_size
			
			if year_found = False then
				
				if lc_value[li_i] = "," then
					year_found = True
					li_k = 1
				else
					lc_anno[li_k] = lc_value[li_i]
					li_k++					
				end if
				
			else
				if month_found = False then
					
					if lc_value[li_i] = "," then
						month_found = True
						li_k = 1
					else
						lc_mese[li_k] = lc_value[li_i]
						li_k++					
					end if
						
				else					
					if lc_value[li_i] = "," then
						day_found = True
						ls_result	= lc_giorno + "/" + lc_mese + "/" + lc_anno + " , "
						lc_giorno 	= lc_giorno_vuoto
						lc_mese 		= lc_mese_vuoto
						lc_anno		= lc_anno_vuoto
						month_found = False
						year_found 	= False
						li_k = 1
					else
						lc_giorno[li_k] = lc_value[li_i]
						li_k++						
					end if				
					
				end if
				
			end if			
		next	
		
		ls_result = ls_result + lc_giorno + "/" + lc_mese + "/" + lc_anno
		
end choose

return ls_result
end function

on w_dinamica_rpt.create
int iCurrent
call w_print_main::create
this.cb_check=create cb_check
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_check
end on

on w_dinamica_rpt.destroy
call w_print_main::destroy
destroy(this.cb_check)
end on

event ue_post_open;call super::ue_post_open;

string	ls_dir_report

ip_pointer = SetPointer(HourGlass!)

select par_sistema.dir_report
	into :ls_dir_report
	from dba.par_sistema 
	where par_sistema.id_azienda = 1 ;	
  
if SQLCA.SQLCode = 100 then
	MessageBox( "Errore","Fallito select dei parametri di sistema",StopSign! )
	Close( this )
else
	if SQLCA.SQLCode <> 0 then
		MessageBox( "Errore","Nessun record selezionato",StopSign! )		
		Close( this )
	end if
end if

is_report	= ls_dir_report + "\" + is_nome_report


//is_selection = u_freddie.iuo_stampa.of_get_selection_formula(is_report)

this.tab_1.tabpage_select.st_attesa.visible	= False

if is_selection <> "" and not isNull(is_selection) then
	wf_scan( is_selection )
else
	if isNull(is_selection) then
		is_selection = ""
	end if	
end if	

SetPointer(ip_pointer)

return 0



end event

event open;
long		ll_id_par_stampa
string	ls_titolo_finestra,ls_tipo_serve,ls_no_param,ls_use_completa_semplificata

ll_id_par_stampa		= Message.DoubleParm

ii_find_profilo		= 0
is_directory_report 	= ""
is_nome_report			= ""
is_group 				= ""
is_selection			= ""

if isNull(ll_id_par_stampa) then
	Close(This)
end if

SELECT "par_stampa"."titolo_finestra","par_stampa"."nome_report","par_stampa"."nome_campo_db_cod", &
       "par_stampa"."nome_campo_db_des","par_stampa"."nome_campo_instampa", &
		 "par_stampa"."nome_dddw_sl","par_stampa"."nome_dddw_codice","par_stampa"."nome_dddw_descrizione", &
		 "par_stampa"."tipo_serve","par_stampa"."no_param","par_stampa"."use_completa_semplificata"
	INTO	:istr_coddes_rpt.titolo_finestra,:istr_coddes_rpt.nome_report,:istr_coddes_rpt.nome_campo_db_cod, &
			:istr_coddes_rpt.nome_campo_db_des,:istr_coddes_rpt.nome_campo_instampa, &
			:istr_coddes_rpt.nome_dddw_sl,:istr_coddes_rpt.nome_dddw_codice,:istr_coddes_rpt.nome_dddw_descrizione, &
			:ls_tipo_serve,:ls_no_param,:ls_use_completa_semplificata
	FROM "dba"."par_stampa"   
	WHERE "par_stampa"."id_par_stampa" = :ll_id_par_stampa
	USING SQLCA;

if SQLCA.SQLCode = 100 then
	MessageBox("Parametri di Stampa","Id non trovato")
	Close(This)
else
	if SQLCA.SQLCode = -1 then
		MessageBox("Database Error " + string(SQLCA.SQLDBCode),SQLCA.SQLErrText, Exclamation!)
		Close(This)
	end if	
end if

if ls_tipo_serve = 'N' then
	istr_coddes_rpt.tipo_serve = False
else
	istr_coddes_rpt.tipo_serve = True
end if

if ls_no_param = 'N' then
	istr_coddes_rpt.no_param = False
else
	istr_coddes_rpt.no_param = True
end if

if ls_use_completa_semplificata = 'N' then
	istr_coddes_rpt.use_completa_semplificata = False
else	
	istr_coddes_rpt.use_completa_semplificata = True
end if	

is_wintype = "W_PRINT_MAIN"	

u_freddie.center_window(this)

ib_openok = f_check_serial(is_serialize)

if ib_openok then
	ib_openok = f_check_win_password(is_password)
end if

if ib_openok then
	iuo_msg_log = create uo_msg_log
	iuo_msg_log.uf_new_text("Sessione del " + String(Today()) + " - " + String(Now()),2)


	is_nome_report			= istr_coddes_rpt.nome_report
	
	this.Title				= "Stampa del report : " + is_nome_report

	this.PostEvent( "ue_post_open" )
	
else
	Close(This)
end if




end event

event ue_pre_print;call super::ue_pre_print;
is_selection = wf_costruisci_formula()
return 0
end event

type cb_esci from w_print_main`cb_esci within w_dinamica_rpt
int X=2378
int Y=81
end type

type tab_1 from w_print_main`tab_1 within w_dinamica_rpt
int X=46
int Width=2583
int Height=1101
end type

event tab_1::selectionchanged;call super::selectionchanged;choose case newindex
	case 2
		cb_check.visible = false
	case 1	
		cb_check.visible = true
end choose		
end event

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2547
int Height=973
st_attesa st_attesa
end type

on tabpage_select.create
this.st_attesa=create st_attesa
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_attesa
end on

on tabpage_select.destroy
call super::destroy
destroy(this.st_attesa)
end on

type dw_selection from w_print_main`dw_selection within tabpage_select
event type integer ue_itemchanged ( long al_row,  string as_column,  string as_value )
int Y=49
int Width=2428
int Height=801
string DataObject="d_scan_sel_formula_ff"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dw_selection::ue_itemchanged;call super::ue_itemchanged;
return 0
end event

event dw_selection::itemchanged;call super::itemchanged;
return 0
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2547
int Height=973
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2547
int Height=973
end type

type cb_stampa from w_print_main`cb_stampa within w_dinamica_rpt
int X=2103
int Y=81
end type

type st_attesa from statictext within tabpage_select
int X=714
int Y=229
int Width=1235
int Height=141
boolean Enabled=false
boolean BringToTop=true
string Text="Estrazione della formula in corso..."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
string Pointer="HourGlass!"
int TextSize=-12
int Weight=700
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_check from commandbutton within w_dinamica_rpt
int X=2309
int Y=1161
int Width=229
int Height=85
int TabOrder=31
boolean BringToTop=true
string Text="&Verifica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
ip_pointer = SetPointer(HourGlass!)
li_ret = wf_check_formula()
SetPointer(ip_pointer)
if li_ret = 0 then
	MessageBox( "Selection Formula","La formula è corretta !!!",Information! )
else
	MessageBox( "Selection Formula","La formula non è corretta !!! " + "~n" + &
	                                "Formula : " + is_selection   ,Information! )
end if	

return 0
end event

