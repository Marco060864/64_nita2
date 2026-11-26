forward
global type w_st_el_sog_com from w_print_main
end type
end forward

global type w_st_el_sog_com from w_print_main
int Width=2482
int Height=2076
end type
global w_st_el_sog_com w_st_el_sog_com

on w_st_el_sog_com.create
call super::create
end on

on w_st_el_sog_com.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
string ls_da_sc, ls_a_sc, ls_da_cat_com, ls_a_cat_com, ls_da_cat_att, ls_a_cat_att
string ls_da_cat_zon, ls_a_cat_zon, ls_da_val, ls_a_val, ls_da_lin, ls_a_lin
string ls_da_ling, ls_a_ling, ls_cli, ls_for, ls_vet, ls_age, ls_clipon, ls_altro
string ls_cli_app, ls_for_app, ls_vet_app, ls_age_app, ls_clipon_app, ls_altro_app
string statement,ls_selezione
integer li_test, li_cont

ls_da_sc 	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod_forn")
ls_a_sc  	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod_forn")

ls_da_cat_com = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cat_com")
ls_a_cat_com  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cat_com")

ls_da_cat_att = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_att")
ls_a_cat_att  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_att")

ls_da_cat_zon = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cat_zona")
ls_a_cat_zon  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cat_zona")

ls_da_val     = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_valuta")
ls_a_val      = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_valuta")

ls_da_lin     = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_lingua")
ls_a_lin      = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_lingua")

ls_da_ling    = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_linguaggio")
ls_a_ling     = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_linguaggio")

ls_cli        = tab_1.tabpage_select.dw_selection.GetItemString(1,"clienti")
ls_for        = tab_1.tabpage_select.dw_selection.GetItemString(1,"fornitori")
ls_vet    	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"vettori")
ls_age    	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"agenti")
ls_clipon	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"cli_poten")
ls_altro  	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"altro")

if not isNull(ls_da_sc) and not isNull(ls_a_sc) then
	if ls_da_sc > ls_a_sc then
		if MessageBox( "Attenzione","Sog.Com. 'da' maggiore di Sog.Com. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_cat_com) and not isNull(ls_a_cat_com) then
	if ls_da_cat_com > ls_a_cat_com then
		if MessageBox( "Attenzione","Cat.Com. 'da' maggiore di Cat.Com. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_cat_att) and not isNull(ls_a_cat_att) then
	if ls_da_cat_att > ls_a_cat_att then
		if MessageBox( "Attenzione","Cat.Att. 'da' maggiore di Cat.Att. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_cat_zon) and not isNull(ls_a_cat_zon) then
	if ls_da_cat_zon > ls_a_cat_zon then
		if MessageBox( "Attenzione","Cat.Zona 'da' maggiore di Cat.Zona 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_val) and not isNull(ls_a_val) then
	if ls_da_val > ls_a_val then
		if MessageBox( "Attenzione","Valuta 'da' maggiore di Valuta 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_lin) and not isNull(ls_a_lin) then
	if ls_da_lin > ls_a_lin then
		if MessageBox( "Attenzione","Lingua 'da' maggiore di Lingua 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_ling) and not isNull(ls_a_ling) then
	if ls_da_ling > ls_a_ling then
		if MessageBox( "Attenzione","Linguaggio 'da' maggiore di Linguaggio 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if


if Not IsNull(ls_da_sc) and ls_da_sc <> "" then
	if statement <> "" then
		statement 		= statement + " AND {Sog_Commerciale.Codice} >= '" + ls_da_sc + "'"
	else
		statement 		= statement + " {Sog_Commerciale.Codice} >= '" + ls_da_sc + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Sog.Com. " + ls_da_sc + ", "
end if

if Not IsNull(ls_a_sc) and ls_a_sc <> "" then
	if statement <> "" then 
		statement 		= statement + " AND {Sog_Commerciale.Codice} <= '" + ls_a_sc + "'"
	else
	   statement 		= statement + " {Sog_Commerciale.Codice} <= '" + ls_a_sc + "'"	
	end if
	ls_selezione 	= ls_selezione + "a Sog.Com. " + ls_a_sc + "."
end if

if Not IsNull(ls_cli)    and ls_cli    = "S" then ls_cli_app    = "{Sog_Commerciale.Tipo} = 'C'"
if Not IsNull(ls_for)    and ls_for    = "S" then ls_for_app    = "{Sog_Commerciale.Tipo} = 'F'"
if Not IsNull(ls_vet)    and ls_vet    = "S" then ls_vet_app    = "{Sog_Commerciale.Tipo} = 'V'"
if Not IsNull(ls_age)    and ls_age    = "S" then ls_age_app    = "{Sog_Commerciale.Tipo} = 'A'"
if Not IsNull(ls_clipon) and ls_clipon = "S" then ls_clipon_app = "{Sog_Commerciale.Tipo} = 'P'"
if Not IsNull(ls_altro)  and ls_altro  = "S" then ls_altro_app  = "{Sog_Commerciale.Tipo} = 'Z'"
li_test = 0
if ls_cli_app 	  <> "" then li_test++
if ls_for_app    <> "" then li_test++
if ls_vet_app    <> "" then li_test++
if ls_age_app    <> "" then li_test++
if ls_clipon_app <> "" then li_test++
if ls_altro_app  <> "" then li_test++

if li_test > 0 then
	if li_test = 1 then 
		if statement <> "" then statement = statement + " AND "	
		if ls_cli_app <> "" then
			statement 		= statement + ls_cli_app
			ls_selezione 	= ls_selezione + " Clienti, "
		end if
		if ls_for_app <> "" then
			statement 		= statement + ls_for_app
			ls_selezione 	= ls_selezione + " Fornitori, "
		end if		
		if ls_vet_app <> "" then
			statement 		= statement + ls_vet_app
			ls_selezione 	= ls_selezione + " Vettori, "
		end if				
		if ls_age_app <> "" then
			statement 		= statement + ls_age_app
			ls_selezione 	= ls_selezione + " Agenti, "
		end if						
		if ls_clipon_app <> "" then
			statement 		= statement + ls_clipon_app
			ls_selezione 	= ls_selezione + " Clienti Poten., "
		end if								
		if ls_altro_app <> "" then
			statement 		= statement + ls_altro_app
			ls_selezione 	= ls_selezione + " Altro, "
		end if
	else
		
		li_cont = 0
		if statement <> "" then 
			statement = statement + "AND ("
		else 
			statement = statement + " ("
		end if
		if ls_cli_app <> "" then
			statement 		= statement + ls_cli_app
			ls_selezione 	= ls_selezione + " Clienti, "
			li_cont++
			if li_cont < li_test then statement 		= statement + " OR "
		end if
		if ls_for_app <> "" then
			statement 		= statement + ls_for_app
			ls_selezione 	= ls_selezione + " Fornitori, "
			li_cont++
			if li_cont < li_test then statement 		= statement + " OR "			
		end if		
		if ls_vet_app <> "" then
			statement 		= statement + ls_vet_app
			ls_selezione 	= ls_selezione + " Vettori, "
			li_cont++
			if li_cont < li_test then statement 		= statement + " OR "			
		end if				
		if ls_age_app <> "" then
			statement 		= statement + ls_age_app
			ls_selezione 	= ls_selezione + " Agenti, "
			li_cont++
			if li_cont < li_test then statement 		= statement + " OR "			
		end if						
		if ls_clipon_app <> "" then
			statement 		= statement + ls_clipon_app
			ls_selezione 	= ls_selezione + " Clienti Poten., "
			li_cont++
			if li_cont < li_test then statement 		= statement + " OR "			
		end if								
		if ls_altro_app <> "" then
			statement 		= statement + ls_altro_app
			ls_selezione 	= ls_selezione + " Altro, "
			li_cont++
			if li_cont < li_test then statement 		= statement + " OR "			
		end if		
		
		statement 		= statement + " )"		
	end if
end if

if Not IsNull(ls_da_cat_com) and ls_da_cat_com <> "" then
	if statement <> "" then
		statement 		= statement + " AND {Cat_Com_Sc.Codice} >= '" + ls_da_cat_com + "'"
	else
		statement 		= statement + " {Cat_Com_Sc.Codice} >= '" + ls_da_cat_com + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Cat.Com. " + ls_da_cat_com + ", "
end if

if Not IsNull(ls_a_cat_com) and ls_a_cat_com <> "" then
	if statement <> "" then	
		statement 		= statement + " AND {Cat_Com_Sc.Codice} <= '" + ls_a_cat_com + "'"
	else
		statement 		= statement + " {Cat_Com_Sc.Codice} <= '" + ls_a_cat_com + "'"		
	end if
	ls_selezione 	= ls_selezione + "a Cat.Com. " + ls_a_cat_com + "."
end if

if Not IsNull(ls_da_cat_att) and ls_da_cat_att <> "" then
	if statement <> "" then		
		statement 		= statement + " AND {Cat_Attivita.Codice} >= '" + ls_da_cat_att + "'"
	else
		statement 		= statement + " {Cat_Attivita.Codice} >= '" + ls_da_cat_att + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Cat.Att. " + ls_da_cat_att + ", "
end if

if Not IsNull(ls_a_cat_att) and ls_a_cat_att <> "" then
	if statement <> "" then			
		statement 		= statement + " AND {Cat_Attivita.Codice} <= '" + ls_a_cat_att + "'"
	else
		statement 		= statement + " {Cat_Attivita.Codice} <= '" + ls_a_cat_att + "'"
	end if		
	ls_selezione 	= ls_selezione + "a Cat.Att. " + ls_a_cat_att + "."
end if

if Not IsNull(ls_da_cat_zon) and ls_da_cat_zon <> "" then
	if statement <> "" then				
		statement 		= statement + " AND {Cat_Zona.Codice} >= '" + ls_da_cat_zon + "'"
	else
		statement 		= statement + " {Cat_Zona.Codice} >= '" + ls_da_cat_zon + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Cat.Zona " + ls_da_cat_zon + ", "
end if

if Not IsNull(ls_a_cat_zon) and ls_a_cat_zon <> "" then
	if statement <> "" then					
		statement 		= statement + " AND {Cat_Zona.Codice} <= '" + ls_a_cat_zon + "'"
	else
		statement 		= statement + " {Cat_Zona.Codice} <= '" + ls_a_cat_zon + "'"		
	end if
	ls_selezione 	= ls_selezione + "a Cat.Zona " + ls_a_cat_zon + "."
end if

if Not IsNull(ls_da_val) and ls_da_val <> "" then
	if statement <> "" then						
		statement 		= statement + " AND {Valuta.Codice} >= '" + ls_da_val + "'"
	else
		statement 		= statement + " {Valuta.Codice} >= '" + ls_da_val + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Valuta " + ls_da_val + ", "
end if

if Not IsNull(ls_a_val) and ls_a_val <> "" then
	if statement <> "" then							
		statement 		= statement + " AND {Valuta.Codice} <= '" + ls_a_val + "'"
	else
		statement 		= statement + " {Valuta.Codice} <= '" + ls_a_val + "'"		
	end if
	ls_selezione 	= ls_selezione + "a Valuta " + ls_a_val + "."
end if

if Not IsNull(ls_da_lin) and ls_da_lin <> "" then
	if statement <> "" then								
		statement 		= statement + " AND {Lingua.Codice} >= '" + ls_da_lin + "'"
	else
		statement 		= statement + " {Lingua.Codice} >= '" + ls_da_lin + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Lingua " + ls_da_lin + ", "
end if

if Not IsNull(ls_a_lin) and ls_a_lin <> "" then
	if statement <> "" then									
		statement 		= statement + " AND {Lingua.Codice} <= '" + ls_a_lin + "'"
	else
		statement 		= statement + " {Lingua.Codice} <= '" + ls_a_lin + "'"		
	end if
	ls_selezione 	= ls_selezione + "a Lingua " + ls_a_lin + "."
end if

if Not IsNull(ls_da_ling) and ls_da_ling <> "" then
	if statement <> "" then										
		statement 		= statement + " AND {Linguaggio.Codice} >= '" + ls_da_ling + "'"
	else
		statement 		= statement + " {Linguaggio.Codice} >= '" + ls_da_ling + "'"		
	end if
	
	ls_selezione 	= ls_selezione + " Da Linguaggio " + ls_da_ling + ", "
end if

if Not IsNull(ls_a_ling) and ls_a_ling <> "" then
	if statement <> "" then											
		statement 		= statement + " AND {Linguaggio.Codice} <= '" + ls_a_ling + "'"
	else
		statement 		= statement + " {Linguaggio.Codice} <= '" + ls_a_ling + "'"		
	end if
	ls_selezione 	= ls_selezione + "a Linguaggio " + ls_a_ling + "."
end if




is_selection = statement


istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

return 0


end event

event open;call super::open;datawindowchild ldw_da_cat_com, ldw_a_cat_com, ldw_da_cat_att, ldw_a_cat_att, ldw_da_cat_zon, ldw_a_cat_zon
datawindowchild ldw_da_valuta, ldw_a_valuta, ldw_da_lingua, ldw_a_lingua, ldw_da_linguaggio, ldw_a_linguaggio
datawindowchild ldw_da_cat_com_2, ldw_a_cat_com_2, ldw_da_cat_att_2, ldw_a_cat_att_2, ldw_da_cat_zon_2, ldw_a_cat_zon_2
datawindowchild ldw_da_valuta_2, ldw_a_valuta_2, ldw_da_lingua_2, ldw_a_lingua_2, ldw_da_linguaggio_2, ldw_a_linguaggio_2

tab_1.tabpage_select.dw_selection.GetChild("da_cat_com",ldw_da_cat_com)
tab_1.tabpage_select.dw_selection.GetChild("a_cat_com",ldw_a_cat_com)

tab_1.tabpage_select.dw_selection.GetChild("da_cat_com_2",ldw_da_cat_com_2)
tab_1.tabpage_select.dw_selection.GetChild("a_cat_com_2",ldw_a_cat_com_2)

tab_1.tabpage_select.dw_selection.GetChild("da_att",ldw_da_cat_att)
tab_1.tabpage_select.dw_selection.GetChild("a_att",ldw_a_cat_att)

tab_1.tabpage_select.dw_selection.GetChild("da_att_2",ldw_da_cat_att_2)
tab_1.tabpage_select.dw_selection.GetChild("a_att_2",ldw_a_cat_att_2)

tab_1.tabpage_select.dw_selection.GetChild("da_cat_zona",ldw_da_cat_zon)
tab_1.tabpage_select.dw_selection.GetChild("a_cat_zona",ldw_a_cat_zon)

tab_1.tabpage_select.dw_selection.GetChild("da_cat_zona_2",ldw_da_cat_zon_2)
tab_1.tabpage_select.dw_selection.GetChild("a_cat_zona_2",ldw_a_cat_zon_2)

tab_1.tabpage_select.dw_selection.GetChild("da_valuta",ldw_da_valuta)
tab_1.tabpage_select.dw_selection.GetChild("a_valuta",ldw_a_valuta)

tab_1.tabpage_select.dw_selection.GetChild("da_valuta_2",ldw_da_valuta_2)
tab_1.tabpage_select.dw_selection.GetChild("a_valuta_2",ldw_a_valuta_2)

tab_1.tabpage_select.dw_selection.GetChild("da_lingua",ldw_da_lingua)
tab_1.tabpage_select.dw_selection.GetChild("a_lingua",ldw_a_lingua)

tab_1.tabpage_select.dw_selection.GetChild("da_lingua_2",ldw_da_lingua_2)
tab_1.tabpage_select.dw_selection.GetChild("a_lingua_2",ldw_a_lingua_2)

tab_1.tabpage_select.dw_selection.GetChild("da_linguaggio",ldw_da_linguaggio)
tab_1.tabpage_select.dw_selection.GetChild("a_linguaggio",ldw_a_linguaggio)

tab_1.tabpage_select.dw_selection.GetChild("da_linguaggio_2",ldw_da_linguaggio_2)
tab_1.tabpage_select.dw_selection.GetChild("a_linguaggio_2",ldw_a_linguaggio_2)


tab_1.tabpage_select.dw_selection.accepttext()


ldw_da_cat_com.SetTransObject(SQLCA)
ldw_da_cat_com.Retrieve()
ldw_a_cat_com.SetTransObject(SQLCA)
ldw_a_cat_com.Retrieve()

ldw_da_cat_com_2.SetTransObject(SQLCA)
ldw_da_cat_com_2.Retrieve()
ldw_a_cat_com_2.SetTransObject(SQLCA)
ldw_a_cat_com_2.Retrieve()

ldw_da_cat_att.SetTransObject(SQLCA)
ldw_da_cat_att.Retrieve()
ldw_a_cat_att.SetTransObject(SQLCA)
ldw_a_cat_att.Retrieve()

ldw_da_cat_att_2.SetTransObject(SQLCA)
ldw_da_cat_att_2.Retrieve()
ldw_a_cat_att_2.SetTransObject(SQLCA)
ldw_a_cat_att_2.Retrieve()

ldw_da_cat_zon.SetTransObject(SQLCA)
ldw_da_cat_zon.Retrieve()
ldw_a_cat_zon.SetTransObject(SQLCA)
ldw_a_cat_zon.Retrieve()

ldw_da_cat_zon_2.SetTransObject(SQLCA)
ldw_da_cat_zon_2.Retrieve()
ldw_a_cat_zon_2.SetTransObject(SQLCA)
ldw_a_cat_zon_2.Retrieve()

ldw_da_valuta.SetTransObject(SQLCA)
ldw_da_valuta.Retrieve()
ldw_a_valuta.SetTransObject(SQLCA)
ldw_a_valuta.Retrieve()

ldw_da_valuta_2.SetTransObject(SQLCA)
ldw_da_valuta_2.Retrieve()
ldw_a_valuta_2.SetTransObject(SQLCA)
ldw_a_valuta_2.Retrieve()

ldw_da_lingua.SetTransObject(SQLCA)
ldw_da_lingua.Retrieve()
ldw_a_lingua.SetTransObject(SQLCA)
ldw_a_lingua.Retrieve()

ldw_da_lingua_2.SetTransObject(SQLCA)
ldw_da_lingua_2.Retrieve()
ldw_a_lingua_2.SetTransObject(SQLCA)
ldw_a_lingua_2.Retrieve()

ldw_da_linguaggio.SetTransObject(SQLCA)
ldw_da_linguaggio.Retrieve()
ldw_a_linguaggio.SetTransObject(SQLCA)
ldw_a_linguaggio.Retrieve()

ldw_da_linguaggio_2.SetTransObject(SQLCA)
ldw_da_linguaggio_2.Retrieve()
ldw_a_linguaggio_2.SetTransObject(SQLCA)
ldw_a_linguaggio_2.Retrieve()
end event

type cb_esci from w_print_main`cb_esci within w_st_el_sog_com
int X=2203
end type

type tab_1 from w_print_main`tab_1 within w_st_el_sog_com
int Width=2414
int Height=1784
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2377
int Height=1656
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=23
int Width=2331
int Height=1592
string DataObject="d_st_el_sog_com"
end type

event dw_selection::ue_use_search;choose case as_nomecol
				
	CASE "da_cod_forn"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_forn", is_ricpar.s_ausil_value[1])
		
	CASE "a_cod_forn"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_forn", is_ricpar.s_ausil_value[1])			
			
	case "da_forn"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cod_forn", is_ricpar.s_ausil_value[1])			
	case "a_forn"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_cod_forn", is_ricpar.s_ausil_value[1])						
end choose
end event

event dw_selection::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cod_forn"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "a_cod_forn"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "da_forn"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"			
	CASE "a_forn"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"			
END CHOOSE
end event

event dw_selection::itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
		CASE "da_cod_forn"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_forn"
		ls_dwc[2] = "da_forn"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_forn")) or This.GetItemString(1, "a_cod_forn")='' then
           This.SetItem(1, "a_cod_forn", Data)			
           This.SetItem(1, "a_forn", This.GetItemString(1, "da_forn"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_forn"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_forn"
		ls_dwc[2] = "da_forn"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_forn")) or This.GetItemString(1, "a_cod_forn")='' then
		    This.SetItem(1, "a_forn", Data)			
          This.SetItem(1, "a_cod_forn", This.GetItemString(1, "da_cod_forn"))
	      end if
			RETURN 2
		END IF

	case "a_cod_forn"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_forn"
		ls_dwc[2] = "a_forn"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "a_forn"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_forn"
		ls_dwc[2] = "a_forn"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
end choose
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2377
int Height=1656
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2377
int Height=1656
end type

type cb_stampa from w_print_main`cb_stampa within w_st_el_sog_com
int X=1938
end type

