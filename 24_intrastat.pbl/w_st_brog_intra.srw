forward
global type w_st_brog_intra from w_print_main
end type
end forward

global type w_st_brog_intra from w_print_main
int Width=2935
end type
global w_st_brog_intra w_st_brog_intra

on w_st_brog_intra.create
call super::create
end on

on w_st_brog_intra.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;string statement,ls_selezione
integer li_test, li_cont

long ll_id_fronte_acq, ll_id_fronte_ces

ll_id_fronte_acq 	  = tab_1.tabpage_select.dw_selection.GetItemnumber(1,"id_fronte_acq")
ll_id_fronte_ces    = tab_1.tabpage_select.dw_selection.GetItemnumber(1,"id_fronte_ces")


if Not IsNull(ll_id_fronte_acq) and ll_id_fronte_acq <> 0 then
	if statement <> "" then
		statement 		= statement + " OR {intra_frontespizio_input.id_i_fronte} = " + string(ll_id_fronte_acq)
	else
		statement 		= statement + " {intra_frontespizio_input.id_i_fronte} = " + string(ll_id_fronte_acq)	
	end if
	ls_selezione 	= ' '
end if

if Not IsNull(ll_id_fronte_ces) and ll_id_fronte_ces <> 0 then
	if statement <> "" then
		statement 		= statement + " OR {intra_frontespizio_input.id_i_fronte} = " + string(ll_id_fronte_ces)
	else
		statement 		= statement + " {intra_frontespizio_input.id_i_fronte} = " + string(ll_id_fronte_ces)		
	end if
	ls_selezione 	= ' '
end if

is_selection = statement


istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

return 0


end event

type cb_esci from w_print_main`cb_esci within w_st_brog_intra
int X=2642
int Y=72
end type

type tab_1 from w_print_main`tab_1 within w_st_brog_intra
int Y=184
int Width=2857
int Height=872
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2821
int Height=744
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Width=2715
int Height=636
string DataObject="d_st_brog_intra"
end type

event dw_selection::ue_set_search;CHOOSE CASE as_nomecol
	CASE "denominaz_acq"
		is_search_window = "w_intra_frontespizio_input_sw" 
		is_ricpar.s_filter_value = '' 
		is_ricpar.s_filter_name = "denominazione" 
		is_ricpar.s_sql_cond = "riepilogo = 'A'"
	CASE "denominaz_ces"
		is_search_window = "w_intra_frontespizio_input_sw" 
		is_ricpar.s_filter_value = '' 
		is_ricpar.s_filter_name = "denominazione" 
		is_ricpar.s_sql_cond = "riepilogo = 'C'"
END CHOOSE
end event

event dw_selection::ue_use_search;string ls_denom
date ld_data, ld_da_data, ld_a_data
integer li_disk
long ll_id_fronte

choose case as_nomecol
				
	CASE "denominaz_acq"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fronte_acq", is_ricpar.s_id_seg_value[1])
	
	   ll_id_fronte = integer(is_ricpar.s_id_seg_value[1])
		
      select denominazione, data, da_data1, a_data1, rif_disk
		into :ls_denom, :ld_data, :ld_da_data, :ld_a_data, :li_disk
		from intra_frontespizio_input
		where id_i_fronte = :ll_id_fronte;
		
		dw_selection.setitem(1,"denominaz_acq",ls_denom)
		dw_selection.setitem(1,"data_pres_acq",ld_data)
		dw_selection.setitem(1,"da_data_acq",ld_da_data)
		dw_selection.setitem(1,"a_data_acq",ld_a_data)
		dw_selection.setitem(1,"rif_disk_acq",li_disk)
		dw_selection.setitem(1,"id_fronte_acq",ll_id_fronte)
		
	CASE "denominaz_ces"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fronte_ces", is_ricpar.s_id_seg_value[1])

	   ll_id_fronte = integer(is_ricpar.s_id_seg_value[1])
		
      select denominazione, data, da_data1, a_data1, rif_disk
		into :ls_denom, :ld_data, :ld_da_data, :ld_a_data, :li_disk
		from intra_frontespizio_input
		where id_i_fronte = :ll_id_fronte;
		
		dw_selection.setitem(1,"denominaz_ces",ls_denom)
		dw_selection.setitem(1,"data_pres_ces",ld_data)
		dw_selection.setitem(1,"da_data_ces",ld_da_data)
		dw_selection.setitem(1,"a_data_ces",ld_a_data)
		dw_selection.setitem(1,"rif_disk_ces",li_disk)		
		dw_selection.setitem(1,"id_fronte_ces",ll_id_fronte)		

end choose


end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2821
int Height=744
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2821
int Height=744
end type

type cb_stampa from w_print_main`cb_stampa within w_st_brog_intra
int X=2382
int Y=72
end type

