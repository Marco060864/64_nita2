forward
global type w_mov_art_riep_rpt from w_print_main
end type
end forward

global type w_mov_art_riep_rpt from w_print_main
int Width=2423
int Height=1424
boolean TitleBar=true
string Title="Scheda movimentazione articolo"
end type
global w_mov_art_riep_rpt w_mov_art_riep_rpt

on w_mov_art_riep_rpt.create
call super::create
end on

on w_mov_art_riep_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
string	ls_da_sogg, ls_a_sogg, ls_da_articolo, ls_a_articolo, ls_a_ag, ls_da_ag
date		ld_da_data, ld_a_data
String 	statement, ls_selezione

ls_da_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_comm")
ls_a_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_comm")
ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")
ls_da_articolo			= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_articolo")
ls_a_articolo			= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_articolo")
ls_da_ag         = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_cod_ag")
ls_a_ag          = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_cod_ag")

if ls_da_sogg > ls_a_sogg then
	if MessageBox( "Attenzione","Soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ld_da_data > ld_a_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_articolo > ls_a_articolo then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

statement  = " {Articolo.ID_Azienda} = 1"


if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data registrazione - non definita, "
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_a_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data registrazione - non definita."
end if

if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_articolo + ", "
else
	ls_selezione 	= ls_selezione + " Da articolo - non definito, "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "ad articolo " + ls_a_articolo + "."
else
	ls_selezione 	= ls_selezione + "ad articolo - non definito."
end if

if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " AND {Sog_Commerciale.Codice} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Dal soggetto commerciale " + ls_da_sogg + ", "
else
	ls_selezione 	= ls_selezione + " Dal soggetto commerciale - non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {Sog_Commerciale.Codice} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "al soggetto commerciale " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "al soggetto commerciale - non definito."
end if


if ls_da_ag<>'' and ls_a_ag<>'' and (not isnull(ls_da_ag)) and (not isnull(ls_a_ag)) then
	statement 		= statement + " AND {Gruppo_Agenti.Codice} >= '" + ls_da_ag + "'"
   ls_selezione 	= ls_selezione + "da agente " + ls_da_ag + "."
   statement 		= statement + " AND {Gruppo_Agenti.Codice} <= '" + ls_a_ag + "'"
   ls_selezione 	= ls_selezione + "a agente " + ls_a_ag + "."
end if



is_selection 	= statement

istr_formule[1].formula_name 	= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

type cb_esci from w_print_main`cb_esci within w_mov_art_riep_rpt
int X=2080
int Y=80
end type

type tab_1 from w_print_main`tab_1 within w_mov_art_riep_rpt
int Width=2359
int Height=1140
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2322
int Height=1012
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=14
int Y=28
int Width=2286
int Height=968
string DataObject="d_mov_art_riep_rpt"
end type

event dw_selection::itemchanged;date		ld_dalla_data
string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
integer li_ok

CHOOSE CASE dwo.name
	CASE 'alla_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("alla_data")
		end if
	case "da_articolo"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 this.setitem(1,'a_articolo',data)
				 this.setitem(1,'a_articolo_des',this.getitemstring(1,'da_articolo_des'))
			end if
			return 2
		end if	
		
	case "da_articolo_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 this.setitem(1,'a_articolo_des',data)
				 this.setitem(1,'a_articolo',this.getitemstring(1,'da_articolo'))
			end if
			return 2
		end if	
	
	case "a_articolo"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_articolo_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if		
		
		
		
	case "da_sogg_comm"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sogg_comm"
		ls_dwc[2] = "da_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 this.setitem(1,'a_sogg_comm',data)
				 this.setitem(1,'a_sogg_comm_des',this.getitemstring(1,'da_sogg_comm_des'))
			end if
			return 2
		end if	
		
	case "da_sogg_comm_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sogg_comm"
		ls_dwc[2] = "da_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 this.setitem(1,'a_sogg_comm_des',data)
				 this.setitem(1,'a_sogg_comm',this.getitemstring(1,'da_sogg_comm'))
			end if
			return 2
		end if	
	
	case "a_sogg_comm"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sogg_comm"
		ls_dwc[2] = "a_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_sogg_comm_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sogg_comm"
		ls_dwc[2] = "a_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	CASE 'da_cod_ag'
		ls_dbc[1] = "descrizione"
		ls_dwc[1] = "da_des_ag"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "da_cod_ag"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"codice","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)
										
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_ag")) or This.GetItemString(1, "a_cod_ag")='' then
           This.SetItem(1, "a_cod_ag", Data)			
           This.SetItem(1, "a_des_ag", This.GetItemString(1, "da_des_ag"))
	      end if
			RETURN 2
		END IF	
			
	CASE 'da_des_ag'
		ls_dbc[1] = "descrizione"
		ls_dwc[1] = "da_des_ag"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "da_cod_ag"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"descrizione","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_ag")) or This.GetItemString(1, "a_cod_ag")='' then
           This.SetItem(1, "a_cod_ag", Data)			
           This.SetItem(1, "a_des_ag", This.GetItemString(1, "da_des_ag"))
	      end if
			RETURN 2
		END IF	

	CASE 'a_cod_ag'
		ls_dbc[1] = "descrizione"
		ls_dwc[1] = "a_des_ag"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "a_cod_ag"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"codice","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)
										
		IF (li_ok > 0) THEN
			RETURN 2
		END IF	
			
	CASE 'a_des_ag'
		ls_dbc[1] = "descrizione"
		ls_dwc[1] = "a_des_ag"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "a_cod_ag"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"descrizione","A",data,ls_sql_cond,2,ls_dbc,ls_dbv,ls_dwc)
										
		IF (li_ok > 0) THEN
			RETURN 2
		END IF	
			
END CHOOSE

end event

event dw_selection::ue_set_search;

CHOOSE CASE as_nomecol
				
	CASE "da_articolo", "a_articolo"
		is_search_window = "w_articolo_coddes_sw" 			
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "articolo_codice" 			
	CASE "da_articolo_des", "a_articolo_des"
		is_search_window = "w_articolo_coddes_sw" 			
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "articolo_descrizione" 	
		
	CASE "da_sogg_comm", "a_sogg_comm"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "codice" 							
	CASE "da_sogg_comm_des", "a_sogg_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "rag_soc_1" 						
	
	CASE "da_cod_ag", "a_cod_ag"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_asneeded=TRUE
		
	CASE "da_des_ag", "a_des_ag"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		is_ricpar.b_asneeded=TRUE
		
END CHOOSE

end event

event dw_selection::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_sogg_comm", "a_sogg_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_comm" then
			uf_set_colval("da_sogg_comm_des", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 uf_set_colval('a_sogg_comm', is_ricpar.s_main_value)
			    uf_set_colval("a_sogg_comm_des", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_sogg_comm_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_sogg_comm_des", "a_sogg_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_comm_des" then
			uf_set_colval("da_sogg_comm", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 uf_set_colval('a_sogg_comm_des', is_ricpar.s_main_value)
			    uf_set_colval("a_sogg_comm", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_sogg_comm", is_ricpar.s_ausil_value[1])
		end if
		
  CASE "da_articolo", "a_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_articolo" then
			uf_set_colval("da_articolo_des", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 uf_set_colval('a_articolo', is_ricpar.s_main_value)
			    uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_articolo_des", "a_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_articolo_des" then
			uf_set_colval("da_articolo", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 uf_set_colval('a_articolo_des', is_ricpar.s_main_value)
			    uf_set_colval("a_articolo", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_articolo", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_cod_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_des_ag", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_ag")) or This.GetItemString(1, "a_cod_ag")='' then
        uf_set_colval('a_cod_ag', is_ricpar.s_main_value)
        uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])
	   end if
		

	CASE "da_des_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_cod_ag", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_ag")) or This.GetItemString(1, "a_cod_ag")='' then
        uf_set_colval('a_cod_ag', is_ricpar.s_main_value)
        uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])
	   end if

	CASE "a_cod_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])

	CASE "a_des_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_cod_ag", is_ricpar.s_ausil_value[1])
	
	
END CHOOSE

end event

event dw_selection::ue_default;call super::ue_default;
end event

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
int Width=2322
int Height=1012
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2322
int Height=1012
end type

type cb_stampa from w_print_main`cb_stampa within w_mov_art_riep_rpt
int X=1806
int Y=80
end type

