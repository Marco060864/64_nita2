forward
global type w_sogg_comm_rpt from w_print_main
end type
end forward

global type w_sogg_comm_rpt from w_print_main
int Width=2894
int Height=1428
boolean TitleBar=true
string Title="Ultimi Articoli movimentati per Sogg. Commerciale"
end type
global w_sogg_comm_rpt w_sogg_comm_rpt

on w_sogg_comm_rpt.create
call super::create
end on

on w_sogg_comm_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
string	ls_da_articolo,ls_a_articolo
string	ls_da_sogg,ls_a_sogg
string	ls_da_caus,ls_a_caus
string 	statement,ls_selezione
string ls_da_magaz,ls_a_magaz
long		ll_retval

ls_da_articolo 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_articolo_cod")
ls_a_articolo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_articolo_cod")
ls_da_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_cod")
ls_a_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_cod")
ls_da_caus		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_caus_cod")
ls_a_caus		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_caus_cod")
ls_da_magaz         = tab_1.tabpage_select.dw_selection.GetitemString(1,"da_magaz_cod")
ls_a_magaz          = tab_1.tabpage_select.dw_selection.GetitemString(1,"a_magaz_cod")

tab_1.tabpage_select.dw_selection.accepttext()

if not isNull(ls_da_articolo) and not isNull(ls_a_articolo) then
	if ls_da_articolo > ls_a_articolo then
		if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_sogg) and not isNull( ls_a_sogg ) then
	if ls_da_sogg > ls_a_sogg then
		if MessageBox( "Attenzione","Soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if


if not isNull(ls_da_caus) and not isNull( ls_a_caus ) then
	if ls_da_caus > ls_a_caus then
		if MessageBox( "Attenzione","Causale 'da' maggiore di Causale 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if
if not isNull(ls_da_magaz) and not isNull( ls_a_magaz ) then
	if ls_da_magaz > ls_a_magaz then
		if MessageBox( "Attenzione","Magazzino 'da' maggiore di Magazzino 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if



statement  = " {Articolo.ID_azienda} = 1"

if Not IsNull(ls_da_caus) and ls_da_caus <> "" then
	statement 		= statement + " AND {Caus_magazzino.Codice} >= '" + ls_da_caus + "'"
	ls_selezione 	= ls_selezione + " Da causale " + ls_da_caus + ", "
else
	ls_selezione 	= " Da causale non definita, "
end if

if Not IsNull(ls_a_caus) and ls_a_caus <> "" then
	statement 		= statement + " AND {Caus_magazzino.Codice} <= '" + ls_a_caus + "'"
	ls_selezione 	= ls_selezione + "a causale " + ls_a_caus + "."
else
	ls_selezione 	= ls_selezione + "a causale non definita."
end if
if Not IsNull(ls_da_magaz) and ls_da_magaz <> "" then
	statement 		= statement + " AND {Magazzino.Codice} >= '" + ls_da_magaz + "'"
	ls_selezione 	= ls_selezione + " Da magazzino " + ls_da_magaz + ", "
else
	ls_selezione 	= " Da magazzino non definito, "
end if

if Not IsNull(ls_a_magaz) and ls_a_magaz <> "" then
	statement 		= statement + " AND {magazzino.Codice} <= '" + ls_a_magaz + "'"
	ls_selezione 	= ls_selezione + "a magazzino " + ls_a_magaz + "."
else
	ls_selezione 	= ls_selezione + "a magazzino non definito."
end if




if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_articolo + ", "
else
	ls_selezione 	= " Da articolo  - non definito, "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_articolo + "."
else
	ls_selezione 	= ls_selezione + "a articolo - non definito."
end if

if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " AND {Sog_commerciale_gen.Codice} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Da soggetto " + ls_da_sogg + ", "
else
	ls_selezione 	= " Da soggetto non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {sog_commerciale_gen.Codice} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "a soggetto " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "a soggetto non definito."
end if


is_selection = statement
istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
istr_formule[2].formula_name 		= "selezione"
istr_formule[2].formula_string 	= "'" + ls_selezione + "'"
return 0


end event

type cb_esci from w_print_main`cb_esci within w_sogg_comm_rpt
int X=2592
int Y=64
end type

type tab_1 from w_print_main`tab_1 within w_sogg_comm_rpt
int Width=2811
int Height=1116
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2775
int Height=988
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=46
int Y=40
int Width=2674
int Height=912
string DataObject="d_scheda_sog_comm_rpt"
end type

event dw_selection::itemchanged;
string	ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok

CHOOSE CASE dwo.name
	
	case "da_sogg_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sogg_cod"
		ls_dwc[2] = "da_sogg_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
				 this.setitem(1,'a_sogg_cod',data)
				 this.setitem(1,'a_sogg_des',this.getitemstring(1,'da_sogg_des'))
			end if
			return 2
		end if	
		
	case "da_sogg_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sogg_cod"
		ls_dwc[2] = "da_sogg_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
				 this.setitem(1,'a_sogg_des',data)
				 this.setitem(1,'a_sogg_cod',this.getitemstring(1,'da_sogg_cod'))
			end if
			return 2
		end if	
	
	case "a_sogg_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sogg_cod"
		ls_dwc[2] = "a_sogg_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_sogg_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sogg_cod"
		ls_dwc[2] = "a_sogg_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
		
		
		
		
END CHOOSE

end event

event dw_selection::ue_set_search;call super::ue_set_search;		
CHOOSE CASE as_nomecol
		CASE "da_sogg_cod"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="codice"
		CASE "a_sogg_cod"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="codice"
	case "da_sogg_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="rag_soc_1"
		case "a_sogg_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="rag_soc_1"
		
	
	CASE "da_articolo_cod"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_codice"
		CASE "a_articolo_cod"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_codice"
	case "da_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_descrizione"
		case "a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_descrizione"
		
		
END CHOOSE


end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "da_articolo_cod", "a_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_articolo_cod" then
			uf_set_colval("da_articolo_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_articolo_des", "a_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_articolo_des" then
			uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sogg_cod", "a_sogg_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_cod" then
			uf_set_colval("da_sogg_des", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
				 uf_set_colval('a_sogg_cod', is_ricpar.s_main_value)
			    uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sogg_des", "a_sogg_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_des" then
			uf_set_colval("da_sogg_cod", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
				 uf_set_colval('a_sogg_des', is_ricpar.s_main_value)
			    uf_set_colval("a_sogg_cod", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
		end if

END CHOOSE


end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "da_caus_cod"
is_drop_column[2]	= "da_caus_des"
is_drop_column[3]	= "a_caus_cod"
is_drop_column[4]	=  "a_caus_des"
is_drop_column[5]	= "da_magaz_cod"
is_drop_column[6]	= "da_magaz_des"
is_drop_column[7]	= "a_magaz_cod"
is_drop_column[8] = "a_magaz_des"
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2775
int Height=988
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2775
int Height=988
end type

type cb_stampa from w_print_main`cb_stampa within w_sogg_comm_rpt
int X=2249
int Y=64
end type

