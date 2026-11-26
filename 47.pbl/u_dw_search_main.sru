forward
global type u_dw_search_main from datawindow
end type
end forward

global type u_dw_search_main from datawindow
integer y = 1220
integer width = 2066
integer height = 752
integer taborder = 2
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_init pbm_custom01
event type long ue_insert ( unsignedlong wparam,  long lparam )
event type long ue_retrieve ( )
event ue_show ( )
event ue_modify ( )
event ue_pre_retrieve ( )
event ue_key pbm_dwnkey
event ue_keystop pbm_dwnprocessenter
event ue_change_col ( boolean ib_reset )
event ue_return_values ( )
event ue_comment ( )
end type
global u_dw_search_main u_dw_search_main

type variables
transaction	it_transaction
u_sql_scanner	ius_scanner

s_list_main	is_list
s_ric_param	 is_ricpar

string		is_resp_window 
window		iw_support

boolean		ib_havetoscan	
string		is_last_Column	
string		is_last_coldesc	
string		is_last_dbname	
string		is_last_Coltype	
string		is_last_sort	
integer		ii_tipo_sel		
string		is_val_sel		
long		il_last_row	


end variables

forward prototypes
public subroutine uf_init ()
public subroutine uf_set_scolval (string as_colname, string as_colvalue)
public function string uf_get_colval (string as_nomecol)
public function decimal uf_getitemdecimal (long al_row, string as_column)
public function decimal uf_getitemdecimal (long al_row, string as_column, dwbuffer ad_tipo, boolean ab_original)
public subroutine uf_set_colval (string as_nomecol, string as_valcol)
public function long uf_get_where_cond (string as_col_name, string as_col_value, integer ai_tipo, ref string as_sql_cond)
public function boolean uf_is_scannable (string as_value)
public function string uf_filtro (string as_filtro)
end prototypes

event type long ue_insert(unsignedlong wparam, long lparam);

long				ll_row
integer			li_size, li_counter
s_list_main		lstr_for_win
string			ls_filter, ls_colname, ls_colval
window			lw_support
s_rit_wp			lstr_rit

ll_row = GetRow()
if is_resp_window>"" then
	
	li_size = upperbound(is_list.s_win_chiave)
	for li_counter = 1 to li_size
		if ll_row>0 then
			is_list.l_win_chiave[li_counter] = GetItemNumber(ll_row, is_list.s_win_chiave[li_counter])
		else
			is_list.l_win_chiave[li_counter] = 0
		end if
	next
	lstr_for_win.s_identifica = is_list.s_win_chiave
	lstr_for_win.l_identifica = is_list.l_win_chiave
	
	lstr_for_win.s_par_name = is_list.s_par_name
	lstr_for_win.s_par_value = is_list.s_par_value
	lstr_for_win.s_modo = modo_inserisci
	lstr_for_win.s_win_parametri = is_list.s_win_parametri
	//per samy 02-11-17
	if isvalid(w_articolo_coddes_documento_sw) then
		if w_articolo_coddes_documento_sw.istr_ric.metallo> " " then
			lstr_for_win.s_provenienza=w_articolo_coddes_documento_sw.istr_ric.metallo
		end if
	end if
	//fine
	
	OpenWithParm(lw_support, lstr_for_win, is_resp_window)

	
	ls_filter = ""
	lstr_rit = Message.PowerObjectParm
	li_size = UpperBound(lstr_rit.s_identifica)
	if li_size>0 then
		ls_colname = lstr_rit.s_identifica[1]
		ls_colval = string(lstr_rit.l_identifica[1])
		is_last_dbname = string(Describe(ls_colname+".dbName"))
		is_val_sel = ls_colval
		ii_tipo_sel = 1
	end if
	for  li_counter = 1 to li_size
		ls_colname = lstr_rit.s_identifica[li_counter]
		ls_colval = string(lstr_rit.l_identifica[li_counter])
		ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
	next
	ls_filter = Mid(ls_filter,5)
	
	
	if ls_filter <> "" then
		ib_havetoscan = true
		TriggerEvent("ue_retrieve")
		ll_row = Find( ls_filter, 1, RowCount( ))
		ScrollToRow(ll_row)
	end if
	
	
end if

return 0

end event

event ue_retrieve;


string	ls_sql, ls_where_cond, ls_sql_cond 
pointer	lp_oldp
long		ll_retval


ll_retval = 0
lp_oldp = setpointer(Hourglass!)

if ib_havetoscan then
	
	
		
		
		ls_sql_cond = ""
		if is_last_dbname<>"" then
			ll_retval = uf_get_where_cond(is_last_dbname,is_val_sel,ii_tipo_sel,ls_sql_cond)
		end if
		if is_ricpar.s_sql_cond <> "" then
			ls_sql_cond = "( "+ ls_sql_cond + " ) AND ( " + is_ricpar.s_sql_cond + " )"
		end if
		if ls_sql_cond > "" then
			ius_scanner.f_reset_cur_as_ini()
			ius_scanner.f_add_where_condition(ls_sql_cond)
			ls_sql = ius_scanner.f_getcurrent()
			this.object.datawindow.table.select = ls_sql
			ib_havetoscan = false
		end if
	
end if

retrieve()
if rowcount() > 0 then
	this.SetSort(is_last_column + " A")
	is_last_sort = "A"
	this.sort()
	this.ScrollToRow(0)
	il_last_row = getrow()
	this.SelectRow(0, false)
	this.SelectRow(il_last_row, true)
end if
lp_oldp = setpointer(lp_oldp)
return(ll_retval)

end event

event ue_modify;

long				ll_row
s_list_main		lstr_for_win
string			ls_filter, ls_colname, ls_colval
integer			li_size, li_counter
window			lw_support
s_rit_wp			lstr_rit

ll_row = GetRow()
if ll_row>0 then
	
	if is_resp_window>"" then
		
		li_size = upperbound(is_list.s_win_chiave)
		for li_counter = 1 to li_size
			is_list.l_win_chiave[li_counter] = GetItemNumber(ll_row, is_list.s_win_chiave[li_counter])
		next
		
		lstr_for_win.s_identifica = is_list.s_win_chiave
		lstr_for_win.l_identifica = is_list.l_win_chiave
		
		lstr_for_win.s_par_name = is_list.s_par_name
		lstr_for_win.s_par_value = is_list.s_par_value
		lstr_for_win.s_modo = modo_modifica
		lstr_for_win.s_win_parametri = is_list.s_win_parametri
		
		OpenWithParm(lw_support, lstr_for_win, is_resp_window)
		
		
		ls_filter = ""
		lstr_rit = Message.PowerObjectParm
		li_size = UpperBound(lstr_rit.s_identifica)
		if li_size>0 then
			ls_colname = lstr_rit.s_identifica[1]
			ls_colval = string(lstr_rit.l_identifica[1])
			is_last_dbname = string(Describe(ls_colname+".dbName"))
			is_val_sel = ls_colval
			ii_tipo_sel = 1
			
			
		end if
		
		for li_counter = 1 to li_size
			ls_colname = lstr_rit.s_identifica[li_counter]
			ls_colval = string(lstr_rit.l_identifica[li_counter])
			ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
		next
		ls_filter = Mid(ls_filter,5)
		
		
		if ls_filter <> "" then
			ib_havetoscan = true
			TriggerEvent("ue_retrieve")
			ll_row = Find( ls_filter, 1, RowCount( ))
			ScrollToRow(ll_row)
		end if
		
		
	end if
end if

end event

event ue_key;string		ls_nome

choose case key
	case KeyAdd!
		if (KeyFlags=2) then
			if is_resp_window<>"" then
				Triggerevent("ue_insert")
			end if
		end if
	case KeyF12!
		if (keyflags=3) then
			ls_nome = this.ClassName()
			MessageBox("ClassName",ls_nome)
		end if
end choose


end event

event ue_keystop;if KeyDown(KeyEnter!) then
	PostEvent("doubleclicked")
	return 1
end if
end event

public subroutine uf_init ();

ib_havetoscan = true			
ii_tipo_sel = 1
il_last_row = 0				
is_last_Column = ""			
is_last_dbname = ""			
is_last_sort = ""				
is_resp_window = ""			
is_val_sel = ""				
it_transaction = SQLCA		
SetNull (iw_support)			

end subroutine

public subroutine uf_set_scolval (string as_colname, string as_colvalue);string ls_coltype, ls_value
long ll_row

ll_row = GetRow()
ls_coltype = Describe(as_colname + ".coltype")
CHOOSE CASE Mid(ls_coltype,1,5)
	CASE "char("
		SetItem(ll_row, as_colname, as_colvalue)
	CASE "long"
		SetItem(ll_row, as_colname, Long(as_colvalue))
	CASE "date"
		SetItem(ll_row, as_colname, Date(as_colvalue))
	CASE "datet"
		SetItem(ll_row, as_colname, DateTime(as_colvalue))
	CASE "decim"
		SetItem(ll_row, as_colname, Dec(as_colvalue))
	CASE ELSE
END CHOOSE


end subroutine

public function string uf_get_colval (string as_nomecol);string ls_coltype, ls_value
long ll_row

ll_row = GetRow()
ls_coltype = Describe(as_nomecol + ".coltype")
CHOOSE CASE Mid(ls_coltype,1,5)
	CASE "char("
		ls_value = string(GetItemString(ll_row, as_nomecol))
	CASE "long"
		ls_value = string(GetItemNumber(ll_row, as_nomecol))
	CASE "date"
		ls_value = string(GetItemDate(ll_row, as_nomecol),"dd/mm/yyyy")
	CASE "datet"
		ls_value = string(GetItemDateTime(ll_row, as_nomecol))
	CASE "decim"
		ls_value = string(uf_GetItemDecimal(ll_row, as_nomecol))	
	CASE ELSE
END CHOOSE

return ls_value

end function

public function decimal uf_getitemdecimal (long al_row, string as_column);

decimal ld_value

ld_value = this.GetItemNumber(al_row,as_column)
if not (isNull(ld_value)) then
	ld_value = this.GetItemDecimal(al_row,as_column)
end if

return ld_value


end function

public function decimal uf_getitemdecimal (long al_row, string as_column, dwbuffer ad_tipo, boolean ab_original);

decimal ld_value

ld_value = GetItemNumber(al_row,as_column,ad_tipo,ab_original)
if not (isNull(ld_value)) then
	ld_value = GetItemDecimal(al_row,as_column,ad_tipo,ab_original)
end if

return ld_value

end function

public subroutine uf_set_colval (string as_nomecol, string as_valcol);string ls_coltype, ls_value
long ll_row

ll_row = GetRow()
ls_coltype = Describe(as_nomecol + ".coltype")
CHOOSE CASE Mid(ls_coltype,1,5)
	CASE "char("
		SetItem(ll_row, as_nomecol, as_valcol)
	CASE "long"
		SetItem(ll_row, as_nomecol, Long(as_valcol))
	CASE "date"
		SetItem(ll_row, as_nomecol, Date(as_valcol))
	CASE "datet"
		SetItem(ll_row, as_nomecol, DateTime(as_valcol))
	CASE "decim"
		SetItem(ll_row, as_nomecol, Dec(as_valcol))
	CASE ELSE
END CHOOSE


end subroutine

public function long uf_get_where_cond (string as_col_name, string as_col_value, integer ai_tipo, ref string as_sql_cond);

string 	ls_sql_cond, ls_date, ls_date_wsep 
long		ll_retval	
date		ld_date 
boolean  lb_can_convert 
long		ll_num, ll_num_dec, ll_num_dec_ric 

ll_retval = 0

as_col_value = uf_filtro(as_col_value)

CHOOSE CASE Left(is_last_coltype,4)
	CASE "char" 
		choose case ai_tipo
		 	case 1
				ls_sql_cond = as_col_name+" like "+char(39)+as_col_value+"%"+char(39)
				
			case 2
				ls_sql_cond = as_col_name+" like "+char(39)+"%"+as_col_value+"%"+char(39)
			case 3
				ls_sql_cond = as_col_name+" like "+char(39)+"%"+as_col_value+char(39)
			case 4
				
				ls_sql_cond = as_col_name+" = "+char(39)+as_col_value+char(39)
			case else
				ls_sql_cond = ""
		end choose
	case "date"
		
		
		
		
		
		
		
		
		
		
		ls_date_wsep = left(as_col_value,2)+"/"+mid(as_col_value,3,2)+"/"+mid(as_col_value,5)
		
		if IsDate(as_col_value) then 
			
			lb_can_convert = true
		elseif IsDate(ls_date_wsep) then
			
			lb_can_convert = true
			
			as_col_value = ls_date_wsep 
		else
			
			lb_can_convert = false
		end if
		if lb_can_convert then
			
			ld_date = Date(as_col_value)
			ls_date = String(ld_date,"yyyymmdd")
			choose case ai_tipo
				case 1
					ls_sql_cond = as_col_name+" >= "+ls_date
				case 2, 4  
					ls_sql_cond = as_col_name+" = "+ls_date
				case 3
					ls_sql_cond = as_col_name+" <= "+ls_date
				case else
					ls_sql_cond = ""
			end choose
		else
			if as_col_value = "" then
				
				ls_sql_cond = as_col_name+" like '%' or "+as_col_name+" Is Null"
			else
				
				messagebox("Ricerca","< "+as_col_value+" > non è una data;~rImmettere una data")
				ls_sql_cond = as_col_name+" Not like '%'"
				ll_retval = -1
			end if
		end if
	CASE ELSE
		
		
		

		if IsNumber(as_col_value) then
			if len(as_col_value) <= 18 then
				as_col_value = string (dec(as_col_value))
				
				choose case ai_tipo
					case 1
						ls_sql_cond = as_col_name+" >= "+as_col_value
					case 2, 4 	
						ls_sql_cond = as_col_name+" = "+as_col_value
					case 3
						ls_sql_cond = as_col_name+" <= "+as_col_value
					case else
						ls_sql_cond = ""
				end choose
				
				
				if Pos(as_col_value,",") > 0 then
					
					ll_num_dec = long(mid(is_last_coltype,9,len(is_last_coltype)-9))
					
					ll_num_dec_ric = len(as_col_value) - Pos(as_col_value,",")
					if ll_num_dec_ric > ll_num_dec then
						MessageBox("Numero di cifre decimali fuori rango","Digitate: < "+ &
										string(ll_num_dec_ric)+" >, accettabili: < "+string(ll_num_dec)+&
										" >~rNon posso impostare il filtro...")
						ls_sql_cond = as_col_name + " not like '%'"
						ll_retval = -1
					end if
				end if
			else
				MessageBox("Troppe cifre.","Numero di cifre inserite non può superare 18."+ &
								"~rSono state inserite "+string(len(as_col_value)))
				ls_sql_cond = as_col_name + " not like '%'"
				ll_retval = -1
			end if 
		else
			
			if as_col_value = "" then
				
				ls_sql_cond = as_col_name+" like '%' or "+as_col_name+" Is Null"
			else
				
				messagebox ("Ricerca","< "+as_col_value+" > non è un numero;~rImmettere un numero")
				ls_sql_cond = as_col_name +" not like '%'"
				ll_retval = -1
			end if
		end if
END CHOOSE

if (as_col_value <= " ") then
	ls_sql_cond = "( "+ls_sql_cond+" ) OR ( "+as_col_name+" is NULL ) "
end if

as_sql_cond = ls_sql_cond
return ll_retval


end function

public function boolean uf_is_scannable (string as_value);
char		lc_array[]
integer	li_i,li_size
boolean	lb_ret

lb_ret	= true

if not isNull(as_value) then
	lc_array	= as_value
	li_size 	= UpperBound( lc_array )
	for li_i = 1 to li_size 
		if lc_array[li_i] = "'" then
			lb_ret = false
		end if
	next	
end if	

return lb_ret

end function

public function string uf_filtro (string as_filtro);



char		ls_in[], ls_out[]
integer	li_i, li_size, li_j
string	ls_ret

ls_in = as_filtro
li_j=0
li_size = upperBound(ls_in)

for li_i=1 to li_size
	if ls_in[li_i] = char(34) then
		li_j++
		ls_out[li_j] = char(126)
	end if
	li_j++
	ls_out[li_j] = ls_in[li_i]
	if ls_in[li_i] = char(39) then
		li_j++
		ls_out[li_j] = ls_in[li_i]
	end if
next

ls_ret = ls_out

return ls_ret

end function

event constructor;string ls_sql

ius_scanner = create u_sql_scanner

this.uf_init()

this.triggerevent("ue_init")

this.SetTransObject(it_transaction)
ls_sql = this.object.datawindow.table.select
ius_scanner.f_setinitial(ls_sql)
ius_scanner.f_setcurrent(ls_sql)

end event

event destructor;destroy ius_scanner
end event

event getfocus;
SelectRow(0, false)
SelectRow(GetRow(), true)
end event

event rowfocuschanged;
SelectRow(0, false)
SelectRow(currentrow, true)
il_last_row = currentrow
end event

event doubleclicked;string ls_column

if row = 0 then 
	if not (dwo.Name = "datawindow") then
		
	 	ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 2)
		if ls_column = is_last_column then 
			if is_last_sort = "D" then
				this.SetSort(ls_column + " A")
				is_last_sort = "A"
			else
				this.SetSort(ls_column + " D")
				is_last_sort = "D"
			end if
		else 
			this.SetSort(ls_column + " A")
			is_last_column = ls_column
			is_last_sort = "A"
			is_last_dbname = string(Describe(ls_column+".dbName"))
			is_last_coltype = string(Describe(ls_column+".coltype"))
			is_last_coldesc = dwo.text
			trigger event ue_change_col (true)
		end if
		this.Sort()
	end if
else
	
	
	triggerevent("ue_return_values")
	CloseWithReturn (parent,is_ricpar)	
end if 


end event

on u_dw_search_main.create
end on

on u_dw_search_main.destroy
end on

