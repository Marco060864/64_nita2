forward
global type w_check_deriva_silver_wz from w_wiz_main
end type
type st_1 from statictext within w_check_deriva_silver_wz
end type
type cb_annulla from commandbutton within w_check_deriva_silver_wz
end type
type dw_date from u_dw_ext_main within w_check_deriva_silver_wz
end type
type cb_ok from commandbutton within w_check_deriva_silver_wz
end type
type dw_sog_comm_derivabili_lt from u_dw_ext_main within w_check_deriva_silver_wz
end type
end forward

global type w_check_deriva_silver_wz from w_wiz_main
integer x = 800
integer y = 216
integer width = 1865
integer height = 1628
string title = "Selezione delle date"
windowtype windowtype = response!
st_1 st_1
cb_annulla cb_annulla
dw_date dw_date
cb_ok cb_ok
dw_sog_comm_derivabili_lt dw_sog_comm_derivabili_lt
end type
global w_check_deriva_silver_wz w_check_deriva_silver_wz

type variables
s_par_der_doc	is_par, is_null_par
date		id_data_max_valida
long		il_id_sog_comm

string		is_last_column, is_last_sort
end variables

event open;call super::open;
long		ll_row
integer	li_size, li_count, li_gg
boolean	lb_profok, lb_soggok
string	ls_mex
date		ld_end
s_par_der_doc ls_nulla
is_null_par=ls_nulla
SetNull(ld_end)
is_par 		= 	Message.PowerObjectParm


lb_soggok	=	TRUE

This.Width=965
This.Height=650
If UpperBound(is_par.s_dbv) > 0 then
	
	
	If (IsNull(is_par.s_dbv[2]) OR is_par.s_dbv[2]="") then
		If not (IsNull(is_par.s_dbv[1]) OR is_par.s_dbv[1]="")then
			
			
			dw_sog_comm_derivabili_lt.Retrieve(Long(is_par.s_dbv[1]))
			This.Width=1866
			This.Height=1625
		else
			lb_soggok=FALSE
		end if
	end if
else
	lb_soggok=FALSE
end if

li_size = upperbound (is_par.s_dbn)
lb_profok = false
for li_count = 1 to li_size
	if (is_par.s_dbn[li_count] = "der_profilo.id_prof_documento_derivato") and &
		(is_par.s_op[li_count] = "=" ) and &
		(not isNull(is_par.s_dbv[li_count])) and &
		(is_par.s_dbt[li_count] = "N" ) then
		lb_profok = true
	end if
next
If IsDate(is_par.a_optional[1]) then ld_end= Date(is_par.a_optional[1])

ls_mex = ""
if (not (lb_soggok)) or (not (lb_profok)) then
	if (not lb_profok) then
		ls_mex = ls_mex+"Manca il profilo documento!~r"
	end if
	if (not lb_soggok) then
		ls_mex = ls_mex+"Manca il soggetto commerciale!~r"
	end if
	ls_mex = ls_mex+"Impossibile continuare."
	close (this)
	MessageBox("Dati indispensabili",ls_mex, Exclamation!)
else
	ll_row = dw_date.insertrow(0)
	if ll_row>0 then
		If IsNull(ld_end) then 
			ld_end= Today()
		else
			If DaysAfter(Today(), ld_end) > 0 then ld_end=Today()
		end if
		id_data_max_valida=ld_end
		dw_date.SetItem(ll_row,"data_fin",ld_end)
		//inserisco anche data inizio, prendo giorni da orafo_par_sistema
		//e vado indietro rispetto a data fine
		select gg_derivazione
		into :li_gg
		from orafo_par_sistema
		;
		if li_gg>0 then
			
			dw_date.SetItem(ll_row, "data_ini", relativedate(ld_end, -li_gg))	
		end if
		
		
		dw_date.SetItem(ll_row,"bloccati","N")
	end if
end if





end event

on w_check_deriva_silver_wz.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_annulla=create cb_annulla
this.dw_date=create dw_date
this.cb_ok=create cb_ok
this.dw_sog_comm_derivabili_lt=create dw_sog_comm_derivabili_lt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_date
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.dw_sog_comm_derivabili_lt
end on

on w_check_deriva_silver_wz.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_annulla)
destroy(this.dw_date)
destroy(this.cb_ok)
destroy(this.dw_sog_comm_derivabili_lt)
end on

event closequery;
If (not(IsNull(il_id_sog_comm) OR il_id_sog_comm=0)) AND not IsNull(is_null_par) then &
				 is_null_par.s_dbv[2]= String(il_id_sog_comm)

Message.PowerObjectParm=is_null_par


end event

type st_1 from statictext within w_check_deriva_silver_wz
integer x = 361
integer y = 24
integer width = 206
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SILVER"
boolean focusrectangle = false
end type

type cb_annulla from commandbutton within w_check_deriva_silver_wz
event clicked pbm_bnclicked
integer x = 571
integer y = 44
integer width = 293
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;
SetNull(il_id_sog_comm)

is_null_par.s_dbv[2]= "" 

Close (parent)
end event

type dw_date from u_dw_ext_main within w_check_deriva_silver_wz
integer x = 50
integer y = 160
integer width = 846
integer height = 364
integer taborder = 40
string dataobject = "d_date_ex"
end type

event itemchanged;call super::itemchanged;date	ld_data, ld_old_data
long	ll_row

ll_row= GetRow()
If IsNull(ll_row) then ll_row=row
CHOOSE CASE dwo.name
	CASE "data_fin"
		if not isNull(data) then
			If IsDate(data) then
				ld_data=Date(data)
				If DaysAfter(id_data_max_valida, ld_data) > 0 then
					ld_old_data= GetItemDate(ll_row,"data_fin")
					MessageBox("Validazione delle Data","La Data di Fine deve essere precedente al "+ String(id_data_max_valida) + ".", Exclamation!)
					Post SetItem(ll_row,"data_fin", ld_old_data)
				end if
			end if
		else
			ld_old_data= GetItemDate(ll_row,"data_fin")
			MessageBox("Validazione delle Data","La Data di Fine non può essere nulla ", Exclamation!)
			Post SetItem(ll_row,"data_fin", ld_old_data)
		end if
END CHOOSE 
end event

event ue_itemerror;call super::ue_itemerror;date	ld_data, ld_old_data
long	ll_row, ll_ret_value

ll_row= GetRow()
SetNull(ll_ret_value)
If IsNull(ll_row) then ll_row=al_row
CHOOSE CASE adwo_dwo.name
	CASE "data_fin"
		If IsDate(as_data) then
			ld_data=Date(as_data)
			If DaysAfter(id_data_max_valida, ld_data) > 0 then
				ld_old_data= GetItemDate(ll_row,"data_fin")
				MessageBox("Validazione delle Data","La Data di Fine deve essere precedente al "+ String(id_data_max_valida) + ".", Exclamation!)
				Post SetItem(ll_row,"data_fin", ld_old_data)
			end if
		end if
		ll_ret_value= 1
END CHOOSE 
RETURN ll_ret_value

end event

type cb_ok from commandbutton within w_check_deriva_silver_wz
integer x = 50
integer y = 44
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;
long		ll_row
date		ldt_1, ldt_2
integer  li_size, li_k
string	ls_lock
date		ld_data

ll_row	= dw_date.GetRow()
if ll_row > 0 then
	ld_data	= dw_date.GetItemDate( ll_row,"data_fin" )
	If DaysAfter(id_data_max_valida, ld_data) > 0 then
		MessageBox("Validazione delle Data","La Data di Fine deve essere precedente al "+ String(id_data_max_valida) + ".", Exclamation!)
		return -1
	end if
end if

ll_Row	= dw_sog_comm_derivabili_lt.GetRow()
If Not(IsNull(ll_Row) OR ll_Row =0) then 
	il_Id_Sog_Comm	= dw_sog_comm_derivabili_lt.GetItemNumber(ll_Row, "sog_commerciale_gen_id_sog_commerciale")
end if

ll_row = dw_date.GetRow()

ldt_1 	= dw_date.GetItemDate(ll_row,"data_ini")
ldt_2 	= dw_date.GetItemDate(ll_row,"data_fin")

ls_lock 	= dw_date.GetItemString(ll_row,"bloccati")
li_size 	= UpperBound(is_par.s_dbn)

If IsNull(ldt_1) and IsNull(ldt_2) then
	MessageBox("Verifica delle Date","Impostare la Data di Inizio e la Data di Fine", Exclamation!)
	RETURN -1
end if

If not (IsNull(ldt_1)) and not (IsNull(ldt_2)) then
	If DaysAfter(ldt_1,ldt_2) < 0 then 
		MessageBox("Verifica delle Date","La Data di Inizio deve essere precedente alla Data di Fine", Exclamation!)
		RETURN -1
	end if
end if

if not IsNull(ldt_1) then
	li_size ++
	is_par.s_dbn[li_size] = "documento.data_registrazione"
	is_par.s_op[li_size] = ">="
	is_par.s_dbv[li_size] = string (ldt_1,"yyyymmdd")
	is_par.s_dbt[li_size] = "D"
end if

if not IsNull(ldt_2) then
	li_size ++
	is_par.s_dbn[li_size] = "documento.data_registrazione"
	is_par.s_op[li_size] = "<="
	is_par.s_dbv[li_size] = string (ldt_2,"yyyymmdd")
	is_par.s_dbt[li_size] = "D"
end if

if ls_lock <> "S" then
	li_size ++
	is_par.s_dbn[li_size] = "documento.bloccato"
	is_par.s_op[li_size] = "<>"
	is_par.s_dbv[li_size] = "S"
	is_par.s_dbt[li_size] = "S"
	li_size ++
	is_par.s_dbn[li_size] = "documento.sospeso"
	is_par.s_op[li_size] = "<>"
	is_par.s_dbv[li_size] = "S"
	is_par.s_dbt[li_size] = "S"
end if

is_null_par = is_par

close (parent)

end event

type dw_sog_comm_derivabili_lt from u_dw_ext_main within w_check_deriva_silver_wz
integer x = 50
integer y = 560
integer width = 1733
integer height = 940
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_sog_comm_derivabili_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;string ls_column

if isValid( dwo ) then
	if row = 0 then 
		if dwo.Type = "column" then
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
				end if
				this.Sort()
			end if
		end if	
	end if 
end if

end event

event constructor;SetTrans(SQLCA)
end event

event rowfocuschanged;
long	ll_Row

ll_Row = GetRow()
If Not(IsNull(ll_Row) OR ll_Row =0) then 
	il_Id_Sog_Comm = GetItemNumber(ll_Row, "sog_commerciale_gen_id_sog_commerciale")
	SelectRow(0, FALSE)
	SelectRow(currentrow, TRUE)
end if

end event

