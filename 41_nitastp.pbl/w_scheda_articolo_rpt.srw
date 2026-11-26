forward
global type w_scheda_articolo_rpt from w_print_main
end type
end forward

global type w_scheda_articolo_rpt from w_print_main
int Width=2757
int Height=1585
boolean TitleBar=true
string Title="Scheda Articolo"
end type
global w_scheda_articolo_rpt w_scheda_articolo_rpt

on w_scheda_articolo_rpt.create
call w_print_main::create
end on

on w_scheda_articolo_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
string	ls_da_articolo,ls_a_articolo
string	ls_da_sogg,ls_a_sogg
string	ls_da_profilo,ls_a_profilo
string	ls_da_caus,ls_a_caus
string 	statement,ls_selezione
date		ld_da_data, ld_ad_data
integer	li_tipo_doc

ls_da_articolo 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_articolo_cod")
ls_a_articolo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_articolo_cod")
ls_da_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_cod")
ls_a_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_cod")
ls_da_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_prof_cod")
ls_a_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_prof_cod")
ls_da_caus		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_caus_cod")
ls_a_caus		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_caus_cod")
li_tipo_doc			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"tipo_documento")
ld_da_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_ad_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")

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

if not isNull(ls_da_profilo) and not isNull( ls_a_profilo ) then
	if ls_da_profilo > ls_a_profilo then
		if MessageBox( "Attenzione","Profilo 'da' maggiore di Profilo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
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

if not isNull(ld_da_data) and not isNull( ld_ad_data ) then
	if ld_da_data > ld_ad_data then
		if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if	

statement  = " {Articolo.ID_Azienda} = 1"

if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	ls_selezione 	= " Dalla data registrazione - non definita, "	
end if

if Not IsNull(ld_ad_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_ad_data, "dd/mm/yyyy") + "."
else
	ls_selezione = ls_selezione + "alla data registrazione - non definita."
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

if Not IsNull(ls_da_profilo) and ls_da_profilo <> "" then
	statement 		= statement + " AND {Prof_documento.Codice} >= '" + ls_da_profilo + "'"
	ls_selezione 	= ls_selezione + " Da profilo " + ls_da_profilo + ", "
else
	ls_selezione 	= " Da profilo non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {Prof_documento.Codice} <= '" + ls_a_profilo + "'"
	ls_selezione 	= ls_selezione + "a profilo " + ls_a_profilo + "."
else
	ls_selezione 	= ls_selezione + "a profilo non definito."
end if

if Not IsNull(ls_da_caus) and ls_da_caus <> "" then
	statement 		= statement + " AND {Caus_magazzino.Codice} >= '" + ls_da_caus + "'"
	ls_selezione 	= ls_selezione + " Da causale " + ls_da_profilo + ", "
else
	ls_selezione 	= " Da causale non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {Caus_magazzino.Codice} <= '" + ls_a_caus + "'"
	ls_selezione 	= ls_selezione + "a causale " + ls_a_caus + "."
else
	ls_selezione 	= ls_selezione + "a causale non definito."
end if

if not isNull( li_tipo_doc ) then
	choose case li_tipo_doc
		case 1
			statement 		= statement + " AND {Registro.Tipo_Registro} IN ['GA','GV'] "
		case 2
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'GA' "	
		case 3
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'GV' "	
		case 4
			statement 		= statement + " AND {Registro.Tipo_Registro} IN ['PA','PV'] "	
		case 5
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'PA' "	
		case 6
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'PV' "	
		case 7
			statement 		= statement + " AND {Registro.Tipo_Registro} IN ['OA','OV'] "	
		case 8
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'OA' "	
		case 9
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'OV' "	
		case 10
			statement 		= statement + " AND {Registro.Tipo_Registro} IN ['DA','DV'] "				
		case 11
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'DA' "	
		case 12
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'DV' "	
		case 13
			statement 		= statement + " AND {Registro.Tipo_Registro} IN ['IA','IV'] "	
		case 14
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'IA' "	
		case 15
			statement 		= statement + " AND {Registro.Tipo_Registro} = 'IV' "	
	end choose
end if

is_selection = statement


return 0


end event

type cb_esci from w_print_main`cb_esci within w_scheda_articolo_rpt
int X=2469
int Y=81
end type

type tab_1 from w_print_main`tab_1 within w_scheda_articolo_rpt
int Width=2698
int Height=1301
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2661
int Height=1173
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=49
int Width=2561
int Height=1081
string DataObject="d_scheda_articolo_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_articolo_cod","a_articolo_cod"
		is_search_window = "w_articolo_coddes_sw"    
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "articolo_codice"  
		
		
	CASE "da_articolo_des","a_articolo_des"
		is_search_window = "w_articolo_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 				 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
	CASE "da_sogg_cod","a_sogg_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice" 
		
	CASE "da_sogg_des","a_sogg_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1" 
		
	CASE "da_prof_cod","a_prof_cod"
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
	CASE "da_prof_des","a_prof_des"
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_descrizione" 

	CASE "da_caus_cod","a_caus_cod"
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
	CASE "da_caus_des","a_caus_des"
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_descrizione" 


		
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
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
			uf_set_colval("da_articolo_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_articolo_cod", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sogg_cod", "a_sogg_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_cod" then
			uf_set_colval("da_sogg_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sogg_des", "a_sogg_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_des" then
			uf_set_colval("da_sogg_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_prof_cod", "a_prof_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_prof_cod" then
			uf_set_colval("da_prof_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_prof_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_prof_des", "a_prof_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_prof_des" then
			uf_set_colval("da_prof_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_prof_des", is_ricpar.s_ausil_value[1])
		end if
		
END CHOOSE


end event

event dw_selection::itemchanged;call super::itemchanged;
string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string	ls_cod,ls_des
long		ll_ok

choose case dwo.name		
		
	case 'da_articolo_cod'

		select	"articolo"."codice",
					"articolo"."descrizione"
			into	:ls_cod, :ls_des
			from	"dba"."articolo"  
			where "articolo"."codice" = :data;
			
		if sqlca.sqlcode=0 then
			setItem (row,"da_articolo_cod",ls_cod)
			setItem (row,"da_articolo_des",ls_des)
			setItem (row,"a_articolo_cod",ls_cod)
			setItem (row,"a_articolo_des",ls_des)
			return 2
		else
			setItem (row,"da_articolo_des",u_freddie.gs_null)
			return 0
		end if
	
	
	case 'da_articolo_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_articolo_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_articolo_des"
		ll_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												 
		if ll_ok	= 0 then
			return 2
		end if	
		
	case 'a_articolo_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_articolo_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_articolo_des"
		ll_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												  
		if ll_ok	= 0 then
			return 2
		end if	
		
		
	case 'da_sogg_cod'

		select	"sog_commerciale_gen"."codice",
					"sog_commerciale_gen"."rag_soc_1"
			into	:ls_cod, :ls_des
			from	"dba"."sog_commerciale_gen"  
			where "sog_commerciale_gen"."codice" = :data;
			
		if sqlca.sqlcode=0 then
			setItem (row,"da_sogg_cod",ls_cod)
			setItem (row,"da_sogg_des",ls_des)
			setItem (row,"a_sogg_cod",ls_cod)
			setItem (row,"a_sogg_des",ls_des)
			return 2
		else
			setItem (row,"da_sogg_des",u_freddie.gs_null)
			return 0
		end if		
		
	
	case 'da_sogg_des'
		
		ls_sql_cond=""
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_sogg_cod"
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"da_sogg_des"
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
		if ll_ok	= 0 then
			return 2
		end if	

	case 'a_sogg_des'
		
		ls_sql_cond=""
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_sogg_cod"
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"a_sogg_des"
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
	
		if ll_ok	= 0 then
			return 2
		end if	
		
	case 'da_prof_cod'

		select	"prof_documento"."codice",
					"prof_documento"."descrizione"
			into	:ls_cod, :ls_des
			from	"dba"."prof_documento"  
			where "prof_documento"."codice" = :data;
			
		if sqlca.sqlcode=0 then
			setItem (row,"da_prof_cod",ls_cod)
			setItem (row,"da_prof_des",ls_des)
			setItem (row,"a_prof_cod",ls_cod)
			setItem (row,"a_prof_des",ls_des)
			return 2
		else
			setItem (row,"da_prof_des",u_freddie.gs_null)
			return 0
		end if		
	
	
	case 'da_prof_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_prof_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_prof_des"
		ll_ok = uf_autofind_col(dwo.name,"prof_documento","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												 
		if ll_ok	= 0 then
			return 2
		end if	
		
	case 'a_prof_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_prof_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_prof_des"
		ll_ok = uf_autofind_col(dwo.name,"prof_documento","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												  
		if ll_ok	= 0 then
			return 2
		end if	
	
end choose
end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "da_caus_cod"
is_drop_column[2]	= "da_caus_des"
is_drop_column[3]	= "a_caus_cod"
is_drop_column[4]	= "a_caus_des"
end event

event dw_selection::ue_initial;call super::ue_initial;
string	ls_data_oggi
date 		ld_inizio_esercizio

SELECT esercizio.data_inizio INTO :ld_inizio_esercizio
	FROM dba.esercizio WHERE esercizio.id_azienda = 1 ;			
	
this.SetItem(1, "dalla_data",ld_inizio_esercizio )
this.SetItem( 1,"alla_data",Today() )

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2661
int Height=1173
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2661
int Height=1173
end type

type cb_stampa from w_print_main`cb_stampa within w_scheda_articolo_rpt
int X=2195
int Y=81
end type

