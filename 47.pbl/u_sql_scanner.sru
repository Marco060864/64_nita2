forward
global type u_sql_scanner from nonvisualobject
end type
end forward

global type u_sql_scanner from nonvisualobject
end type
global u_sql_scanner u_sql_scanner

type variables

boolean		ib_scan_needed
boolean		ib_ini, ib_cur
string		is_token_name[]
string		is_token_pred[]
string		is_sql_initial
string		is_sql_current
s_sql_parse_data	istr_token[]

end variables

forward prototypes
public function string f_getlista ()
public function string f_getinitial ()
public function string f_getcurrent ()
public function integer f_get_token_pos (string as_token, integer ai_level, integer ai_posiz)
public function integer f_setinitial (ref string as_sql_st)
public function integer f_setcurrent (ref string as_sql_st)
public function integer f_true_pred (string as_token, integer ai_level)
public function integer f_pred (string as_token, integer ai_level)
public function string f_replace_initial (string as_token, string as_newstr)
public function integer f_succ (string as_token, integer ai_level)
public function integer f_reset_cur_as_ini ()
public function integer f_doscan ()
public function string f_get_token_value (string as_token, integer ai_level, integer ai_posiz)
public function integer f_set_token (string as_token, string as_newst)
public function integer f_add_where_condition (string as_newst)
end prototypes

public function string f_getlista ();string ls_lista
integer li_i, li_nt

li_nt = UpperBound(istr_token)
for li_i = 1 to li_nt
	ls_lista = ls_lista+"# "+string(li_i)+" "+istr_token[li_i].s_sql_name+" - "+ &
	string(istr_token[li_i].l_start) + " fino "+ string(istr_token[li_i].l_finish) + " Liv. " + & 
		string (istr_token[li_i].i_level)+ "~r~n"
next
return ls_lista
end function

public function string f_getinitial ();
return is_sql_initial

end function

public function string f_getcurrent ();return is_sql_current


end function

public function integer f_get_token_pos (string as_token, integer ai_level, integer ai_posiz);
string		ls_token
integer		li_i, li_nt, li_fnd, li_retval

ls_token = upper(as_token)
if ib_scan_needed then
	li_i = f_doscan()
end if
li_nt = upperbound(is_token_name)
li_fnd = 0
for li_i = 1 to li_nt
	if (ls_token = is_token_name[li_i]) then li_fnd = 1
next

if li_fnd = 0 then
	li_retval = -1
else
	li_nt = upperbound(istr_token)
	li_i = 1
	li_retval = 0
	do while li_i <= li_nt
		if ((istr_token[li_i].s_sql_name = ls_token) and (istr_token[li_i].i_level = ai_level)) then
			li_retval = li_i
			li_i = li_nt+1
		end if
		li_i ++
	loop
end if

return li_retval

end function

public function integer f_setinitial (ref string as_sql_st);
integer li_retval

is_sql_initial = as_sql_st
li_retval = 0
ib_ini = true

return li_retval

end function

public function integer f_setcurrent (ref string as_sql_st);
integer li_retval

is_sql_current = as_sql_st
ib_cur = true
li_retval = 0
ib_scan_needed = true

return li_retval

end function

public function integer f_true_pred (string as_token, integer ai_level);

integer li_finito, li_nt, li_ntt, li_trovato, li_i, li_j, li_rtv
string ls_curr,ls_pred

li_rtv = 0
ls_curr = upper(as_token)
li_nt = upperbound(is_token_pred)
li_ntt = upperbound(istr_token)

li_finito = 0
do while li_finito = 0
	
	li_i = 1
	li_trovato = 0
	do while li_i <= li_nt
		if (is_token_name[li_i])=ls_curr then
			li_trovato = li_i
			li_i = li_nt + 1
		else
			li_i ++
		end if
	loop
	
	if li_trovato > 0 then
		ls_pred = is_token_pred[li_trovato]
		
		li_i = 1
		li_trovato = 0
		do while li_i <= li_ntt
			if ((ls_pred = istr_token[li_i].s_sql_name) and (istr_token[li_i].i_level = ai_level))then
				li_trovato = li_i
				li_i = li_ntt+1
			end if
			li_i ++
		loop
		
		if li_trovato >0 then
			li_finito = 1
			li_rtv = li_trovato
		elseif ls_pred = "---" then 
			li_finito = 1
			li_rtv = 0
		else
			
			
			ls_curr = ls_pred
			li_finito = 0
		end if
	else
		li_finito = 1
		li_rtv = -1
	end if
	
loop

return li_rtv
end function

public function integer f_pred (string as_token, integer ai_level);

integer li_mypos, li_mylev, li_retval, li_i

li_mypos = f_get_token_pos(as_token,ai_level,0)
if (li_mypos > 0) then
	li_mylev = istr_token[li_mypos].i_level
	li_i = li_mypos -1
	do while ((li_i>0) and (istr_token[li_i].i_level > li_mylev))
		li_i --
	loop
	li_retval = li_i
else
	li_retval = f_true_pred(as_token,ai_level)
end if

return li_retval

end function

public function string f_replace_initial (string as_token, string as_newstr);
return ""

end function

public function integer f_succ (string as_token, integer ai_level);

integer li_mypos, li_mylev, li_retval, li_i, li_ntt, li_finito, li_trovato

li_ntt = upperbound(istr_token)
li_mypos = f_get_token_pos(as_token,ai_level,0)
if (li_mypos > 0) then
	li_mylev = istr_token[li_mypos].i_level		
	li_i = li_mypos +1
	li_finito = 0
	li_trovato = 0
	do while (li_finito = 0) 
		if li_i > li_ntt then 
			li_finito = 1
		else
			if (istr_token[li_i].s_sql_name ="") then li_finito = 1
			if (istr_token[li_i].i_level = li_mylev) then
				li_finito = 1
				li_trovato = 1
			end if
		end if
		if (li_finito=0) then li_i ++
	loop
	if li_trovato > 0 then li_retval = li_i
else
	li_retval = -1
end if

return li_retval

end function

public function integer f_reset_cur_as_ini ();string ls_dummy

ls_dummy = f_getinitial()
f_setcurrent(ls_dummy)

return 0
end function

public function integer f_doscan ();

integer		li_retval					
integer		li_tokpos, li_ntt			
integer 		li_i, li_j, li_nt			
integer     li_liv_virg					
integer     li_liv_par              
long			ll_cpos, ll_lung			
integer		li_stato						
string		ls_sql, ls_mytok			
char			lc_car						

li_retval = 0
if is_sql_current = "" then li_retval = 1 else ls_sql = is_sql_current

if (li_retval=0) then
	
	
	
	li_liv_virg = 0
	li_liv_par = 0
	ll_lung = len (ls_sql)
	li_nt = UpperBound(is_token_name)
	ls_mytok = ""
	
	li_ntt = UpperBound(istr_token)
	for li_i = 1 to li_ntt
		istr_token[li_i].i_sql_toknum = 0
		istr_token[li_i].l_start = 0
		istr_token[li_i].l_finish = 0
		istr_token[li_i].s_sql_name = ""
		istr_token[li_i].i_level = 0
	next
	
	li_ntt = 0
	
	
	if li_nt>0 then
		
		
		
		
		
		
		
		
		
		ll_cpos = 1
		li_stato = 0
		
		do while ll_cpos < ll_lung
			lc_car = mid (ls_sql,ll_cpos,1)
			CHOOSE CASE li_stato
				case 0
					
					
					
					if ((lc_car>='A') and (lc_car<='Z')) or ((lc_car>='a') and (lc_car<='z')) then
						if li_liv_virg=0 then
							ls_mytok = ls_mytok+lc_car
							li_stato = 1
						end if
					
					
					
					elseif lc_car = '"' then
						if li_liv_virg=0 then li_liv_virg = 1 else li_liv_virg = 0
					
					
					
					elseif lc_car = '(' then
						if li_liv_virg=0 then li_liv_par ++
					elseif lc_car = ')' then
						if li_liv_virg=0 then li_liv_par --
					
					
					elseif lc_car = char(126) then
						li_stato = 10
					elseif f_isprint(lc_car) then
						li_stato = 0
					else
						li_stato = 0
					end if
	
				case 1
					
					
					
					
					
					if ((lc_car>='A') and (lc_car<='Z')) or ((lc_car>='a') and (lc_car<='z')) then
						ls_mytok = ls_mytok+lc_car
					elseif ((lc_car>='0') and (lc_car<='9')) then
						ls_mytok = ls_mytok+lc_car
					elseif lc_car = '(' then
						li_stato = 0
						li_liv_par ++		
					elseif lc_car = ')' then
						li_stato = 0
						li_liv_par --		
					elseif lc_car = '"' then
						li_stato = 0
						
						if li_liv_virg=0 then li_liv_virg = 1 else li_liv_virg = 0
					elseif lc_car = char(126) then
						li_stato = 10
					else
						
						
						li_stato=0
					end if
					if li_stato<>1 then
						ls_mytok = upper(ls_mytok)				
						
						li_nt = upperBound(is_token_name)
						li_tokpos = 0
						for li_i = 1 to li_nt
							if ls_mytok = is_token_name[li_i] then
								li_tokpos = li_i
							end if
						next
						
						if li_tokpos > 0 then
							li_ntt ++
							istr_token[li_ntt].i_sql_toknum = li_tokpos
							istr_token[li_ntt].l_start = ll_cpos - len(is_token_name[li_tokpos])
							istr_token[li_ntt].l_finish = 0
							istr_token[li_ntt].s_sql_name = is_token_name[li_tokpos]
							istr_token[li_ntt].i_level = li_liv_par
						end if
						ls_mytok = "" 
					end if
					
				case 10
					
					
					if (lc_car = '"') then
						if li_liv_virg=0 then li_liv_virg = 1 else li_liv_virg = 0
					end if
					li_stato = 0
	
			END CHOOSE
			ll_cpos++
		loop
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		li_i = 1
		do while li_i < li_ntt
			li_j = li_i + 1
			do while li_j <= li_ntt
				if istr_token[li_j].i_level <= istr_token[li_i].i_level then
					istr_token[li_i].l_finish = istr_token[li_j].l_start - 1
					li_j = li_ntt+1
				else
					li_j ++
				end if
			loop
			if istr_token[li_i].l_finish = 0 then istr_token[li_i].l_finish = ll_lung
			li_i ++
		loop
		if istr_token[li_ntt].l_finish = 0 then istr_token[li_ntt].l_finish = ll_lung
		
		
	end if
	
	if li_ntt <=0 then li_retval = 1
end if

ib_scan_needed = false

return li_retval
end function

public function string f_get_token_value (string as_token, integer ai_level, integer ai_posiz);integer li_tp
long ll_start, ll_finish, ll_lung
string ls_tmpstr

ls_tmpstr = ""
li_tp = f_get_token_pos (as_token, ai_level, ai_posiz)
if (li_tp>0) then
	ll_start = istr_token[li_tp].l_start
	ll_start = ll_start + len(as_token)
	ll_finish = istr_token[li_tp].l_finish
	ll_lung = ll_finish - ll_start + 1
	ls_tmpstr = mid(is_sql_current,ll_start,ll_lung)
end if

return ls_tmpstr

end function

public function integer f_set_token (string as_token, string as_newst);
integer li_dmy, li_pred, li_succ, li_retval
string ls_p1, ls_new, ls_tmp
long ll_fi1, ll_in2, ll_lung

ls_tmp = ""
li_retval = -1
li_pred = 0
li_succ = upperbound(is_token_name)
for li_dmy = 1 to li_succ
	if is_token_name[li_dmy] = upper(as_token) then li_pred = 1
next
if is_sql_current="" then
	ls_tmp = as_token+" "+as_newst
	li_retval = 0
else
	if (li_pred >0) then
		ll_lung = len(is_sql_current)
		
		if ib_scan_needed then
			li_dmy = f_doscan()
		end if
		
		ls_p1 = f_get_token_value (as_token,0,0)
		
		li_pred = f_pred(as_token,0)
		if li_pred > 0 then ll_fi1 = istr_token[li_pred].l_finish else ll_fi1 = 0
		
		if (ls_p1 <> "") then
			li_succ = f_succ(as_token,0)
			if li_succ > 0 then ll_in2 = istr_token[li_succ].l_start else ll_in2 = 0
		else
			ls_tmp = istr_token[li_pred].s_sql_name
			li_succ = f_succ(ls_tmp,0)
			if li_succ > 0 then ll_in2 = istr_token[li_succ].l_start else ll_in2 = 0
		end if
		ls_new = " "+as_token+" "+as_newst+" "
		
		ls_tmp = ""
		if ll_fi1 >0 then ls_tmp = mid (is_sql_current,1,ll_fi1)
		
		ls_tmp = ls_tmp + ls_new
		
		if ll_in2 > 0 then ls_tmp = ls_tmp + mid(is_sql_current,ll_in2)
		
		li_retval = 0
	end if
end if
	
if li_retval=0 then
	is_sql_current = ls_tmp
	ib_scan_needed = true
end if

return li_retval
end function

public function integer f_add_where_condition (string as_newst);
string ls_token, ls_old, ls_new
integer li_level, li_posiz, li_retval

ls_token = "WHERE"
li_level = 0
li_posiz = 0
ls_old = f_get_token_value ("WHERE",0,0)
if ls_old <> "" then
	ls_new = " ("+as_newst+") AND ("+ls_old+") "
else
	ls_new = " ("+as_newst+") "
end if

li_retval = f_set_token("WHERE",ls_new)
return li_retval

end function

on u_sql_scanner.create
TriggerEvent( this, "constructor" )
end on

on u_sql_scanner.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;
is_token_name[1] = "SELECT"
is_token_name[2] = "INTO"
is_token_name[3] = "FROM"
is_token_name[4] = "WHERE"
is_token_name[5] = "GROUP"
is_token_name[6] = "HAVING"
is_token_name[7] = "ORDER"
is_token_name[8] = "USING"
is_token_pred[1] = "---"
is_token_pred[2] = "SELECT"
is_token_pred[3] = "INTO"
is_token_pred[4] = "FROM"
is_token_pred[5] = "WHERE"
is_token_pred[6] = "GROUP"
is_token_pred[7] = "HAVING"
is_token_pred[8] = "ORDER"
ib_cur = false
ib_ini = false
is_sql_current = ""
is_sql_initial = ""
ib_scan_needed = true
end event

