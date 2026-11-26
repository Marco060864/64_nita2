forward
global type w_st_ctrl_agenti from w_print_main
end type
end forward

global type w_st_ctrl_agenti from w_print_main
int Width=2386
int Height=1360
end type
global w_st_ctrl_agenti w_st_ctrl_agenti

on w_st_ctrl_agenti.create
call super::create
end on

on w_st_ctrl_agenti.destroy
call super::destroy
end on

event open;call super::open;datawindowchild ldw_da_grp_ag, ldw_a_grp_Ag, ldw_da_grp_ag2, ldw_a_grp_Ag2
datawindowchild ldw_da_mod_reg, ldw_a_mod_reg, ldw_da_mod_reg2, ldw_a_mod_reg2

tab_1.tabpage_select.dw_selection.GetChild("da_grp_ag",ldw_da_grp_ag)
tab_1.tabpage_select.dw_selection.GetChild("a_grp_ag",ldw_a_grp_Ag)

tab_1.tabpage_select.dw_selection.GetChild("da_grp_ag_2",ldw_da_grp_ag2)
tab_1.tabpage_select.dw_selection.GetChild("a_grp_ag_2",ldw_a_grp_Ag2)

tab_1.tabpage_select.dw_selection.GetChild("da_mod_reg",ldw_da_mod_reg)
tab_1.tabpage_select.dw_selection.GetChild("a_mod_reg",ldw_a_mod_reg)

tab_1.tabpage_select.dw_selection.GetChild("da_mod_reg_2",ldw_da_mod_reg2)
tab_1.tabpage_select.dw_selection.GetChild("a_mod_reg_2",ldw_a_mod_reg2)

tab_1.tabpage_select.dw_selection.accepttext()


ldw_da_grp_ag.SetTransObject(SQLCA)
ldw_da_grp_ag.Retrieve()
ldw_a_grp_Ag.SetTransObject(SQLCA)
ldw_a_grp_Ag.Retrieve()

ldw_da_grp_ag2.SetTransObject(SQLCA)
ldw_da_grp_ag2.Retrieve()
ldw_a_grp_Ag2.SetTransObject(SQLCA)
ldw_a_grp_Ag2.Retrieve()

ldw_da_mod_reg.SetTransObject(SQLCA)
ldw_da_mod_reg.Retrieve()
ldw_a_mod_reg.SetTransObject(SQLCA)
ldw_a_mod_reg.Retrieve()

ldw_da_mod_reg2.SetTransObject(SQLCA)
ldw_da_mod_reg2.Retrieve()
ldw_a_mod_reg2.SetTransObject(SQLCA)
ldw_a_mod_reg2.Retrieve()

end event

event ue_pre_print;call super::ue_pre_print;string ls_da_grp_ag, ls_a_grp_ag, ls_da_grp_ag2, ls_a_grp_ag_2
string ls_da_mod_reg, ls_a_mod_reg, ls_da_mod_reg2, ls_a_mod_reg2
date ld_da_data, ld_a_data

string statement,ls_selezione
integer li_test, li_cont

ls_da_grp_ag = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_grp_ag")
ls_a_grp_ag  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_grp_ag")

ls_da_mod_reg = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_mod_reg")
ls_a_mod_reg  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_mod_reg")

ld_da_data = tab_1.tabpage_select.dw_selection.GetItemdate(1,"da_data_doc")
ld_a_data  = tab_1.tabpage_select.dw_selection.GetItemdate(1,"a_data_doc")



if not isNull(ls_da_grp_ag) and not isNull(ls_a_grp_ag) then
	if ls_da_grp_ag > ls_a_grp_ag then
		if MessageBox( "Attenzione","Gruppo Agenti 'da' maggiore di Gruppo Agenti 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_mod_reg) and not isNull(ls_a_mod_reg) then
	if ls_da_mod_reg > ls_a_mod_reg then
		if MessageBox( "Attenzione","Tipo Doc. 'da' maggiore di Tipo DOc. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ld_da_data) and not isNull(ld_a_data) then
	if ld_da_data > ld_a_data then
		if MessageBox( "Attenzione","Data Doc. 'da' maggiore di Data Doc. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if Not IsNull(ls_da_grp_ag) and ls_da_grp_ag <> "" then
	if statement <> "" then
		statement 		= statement + " AND {Gruppo_agenti.Codice} >= '" + ls_da_grp_ag + "'"
	else
		statement 		= statement + " {Gruppo_agenti.Codice} >= '" + ls_da_grp_ag + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Gruppo Ag. " + ls_da_grp_ag + ", "
end if

if Not IsNull(ls_a_grp_ag) and ls_a_grp_ag <> "" then
	if statement <> "" then	
		statement 		= statement + " AND {Gruppo_agenti.Codice} <= '" + ls_a_grp_ag + "'"
	else
		statement 		= statement + " {Gruppo_agenti.Codice} <= '" + ls_a_grp_ag + "'"		
	end if
	ls_selezione 	= ls_selezione + "a Gruppo Ag. " + ls_a_grp_ag + "."
end if

if Not IsNull(ls_da_mod_reg) and ls_da_mod_reg <> "" then
	if statement <> "" then		
		statement 		= statement + " AND {mod_registro.tipo_registro} >= '" + ls_da_mod_reg + "'"
	else
		statement 		= statement + " {mod_registro.tipo_registro} >= '" + ls_da_mod_reg + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Tipo doc. " + ls_da_mod_reg + ", "
end if

if Not IsNull(ls_a_mod_reg) and ls_a_mod_reg <> "" then
	if statement <> "" then			
		statement 		= statement + " AND {mod_registro.tipo_registro} <= '" + ls_a_mod_reg+ "'"
	else
		statement 		= statement + " {mod_registro.tipo_registro} <= '" + ls_a_mod_reg + "'"
	end if		
	ls_selezione 	= ls_selezione + "a Tipo doc. " + ls_a_mod_reg + "."
end if

if Not IsNull(string(ld_da_data)) and string(ld_da_data) <> "" then
	if statement <> "" then  
		statement 		= statement + " AND {Documento.Data_Documento} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	else
		statement 		= statement + " {Documento.Data_Documento} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"		
	end if
	ls_selezione 	= ls_selezione + " Da Data Doc. " + string(ld_da_data) + ", "
end if

if Not IsNull(string(ld_a_data)) and string(ld_a_data) <> "" then
	if statement <> "" then 
		statement 		= statement + " AND {Documento.Data_Documento} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	else
	   statement 		= statement + " {Documento.Data_Documento} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"	
	end if
	ls_selezione 	= ls_selezione + "a Data Doc. " + string(ld_a_data) + "."
end if

is_selection = statement


istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0


end event

type cb_esci from w_print_main`cb_esci within w_st_ctrl_agenti
int X=2107
end type

type tab_1 from w_print_main`tab_1 within w_st_ctrl_agenti
int X=27
int Width=2322
int Height=1076
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2286
int Height=948
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Width=2176
int Height=864
string DataObject="d_st_ctrl_agenti"
end type

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

end event

event dw_selection::ue_initial;
long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2286
int Height=948
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2286
int Height=948
end type

type cb_stampa from w_print_main`cb_stampa within w_st_ctrl_agenti
int X=1847
end type

