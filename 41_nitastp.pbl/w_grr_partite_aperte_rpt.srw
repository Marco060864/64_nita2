forward
global type w_grr_partite_aperte_rpt from w_print_main
end type
end forward

global type w_grr_partite_aperte_rpt from w_print_main
int Width=2345
int Height=1264
boolean TitleBar=true
string Title="Stampa Partite Aperte"
end type
global w_grr_partite_aperte_rpt w_grr_partite_aperte_rpt

type variables

end variables

on w_grr_partite_aperte_rpt.create
call super::create
end on

on w_grr_partite_aperte_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval,ll_row
string	ls_da_cod, ls_ad_cod, ls_pr, ls_trans, ls_sort,ls_aperte, ls_a_ag, ls_da_ag
date		ld_da_data, ld_ad_data

String 	statement, ls_selezione

ll_row 		= tab_1.tabpage_select.dw_selection.GetRow()
ls_da_cod	= tab_1.tabpage_select.dw_selection.GetItemString(ll_row,"dal_conto_cod")
ls_ad_cod	= tab_1.tabpage_select.dw_selection.GetItemString(ll_row,"al_conto_cod")
ld_da_data	= tab_1.tabpage_select.dw_selection.GetItemDate(ll_row,"dalla_data")
ld_ad_data	= tab_1.tabpage_select.dw_selection.GetItemDate(ll_row,"fino_data")
ls_sort 		= tab_1.tabpage_select.dw_selection.GetItemString(ll_row,"ordinamento")
ls_aperte 	= tab_1.tabpage_select.dw_selection.GetItemString(ll_row,"partite_aperte")

ls_da_ag         = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_cod_ag")
ls_a_ag          = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_cod_ag")

if IsNull(ls_da_cod) or ls_da_cod = "" or IsNull(ls_ad_cod) or ls_ad_cod = "" or IsNull(ld_ad_data) or IsNull(ld_da_data) then
   MessageBox( "Attenzione","Non tutti i dati sono stati inseriti correttamente")
	return -1
end if 

if ls_da_cod > ls_ad_cod then
	if MessageBox( "Attenzione","Conto 'da' maggiore di Conto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	


statement  = " {Conto.ID_Azienda} = 1"

if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Par_Aperta.Data_Partita} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data registrazione - non definita, "	
end if

if Not IsNull(ld_ad_data) then
	statement 		= statement + " AND {Par_Aperta.Data_Partita} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_ad_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data registrazione - non definita."	
end if

if Not IsNull(ls_da_cod) and ls_da_cod <> "" then
	statement 		= statement + " AND {Conto.Codice} >= '" + ls_da_cod + "'"
	ls_selezione 	= ls_selezione + " Dal codice conto " + ls_da_cod + ", "
else
	ls_selezione 	= " Dal codice conto - non definito, "
end if

if Not IsNull(ls_ad_cod) and ls_ad_cod <> "" then
	statement 		= statement + " AND {Conto.Codice} <= '" + ls_ad_cod + "'"
	ls_selezione 	= ls_selezione + "al codice conto " + ls_ad_cod + "."
else
	ls_selezione 	= ls_selezione + "al codice conto - non definito."
end if

if ls_aperte='A' then
	statement 		= statement + " AND {Par_Aperta.Stato} = '" + ls_aperte + "'"
else 
	if	ls_aperte='C' then statement 		= statement + " AND {Par_Aperta.Stato} = '" + ls_aperte + "'"
end if	


if ls_da_ag<>'' and ls_a_ag<>'' and (not isnull(ls_da_ag)) and (not isnull(ls_a_ag)) then
	statement 		= statement + " AND {Gruppo_Agenti.Codice} >= '" + ls_da_ag + "'"
   ls_selezione 	= ls_selezione + "da agente " + ls_da_ag + "."
   statement 		= statement + " AND {Gruppo_Agenti.Codice} <= '" + ls_a_ag + "'"
   ls_selezione 	= ls_selezione + "a agente " + ls_a_ag + "."
end if




is_selection = statement

istr_formule[1].formula_name = "selezione"
istr_formule[1].formula_string = "'" + ls_selezione + "'"
istr_formule[2].formula_name = "ordinamento"
istr_formule[2].formula_string = "'" + ls_sort + "'"

istr_formule[3].formula_name 		= "id_valuta"
istr_formule[3].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return ll_retval


end event

event ue_post_open;call super::ue_post_open;string ls_data

ls_data='01/01/'+string(year(today()))
tab_1.tabpage_select.dw_Selection.SetItem( 1,"fino_Data",Today() )
tab_1.tabpage_select.dw_Selection.SetItem( 1,"dalla_Data",date(ls_data) )
return 0
end event

type cb_esci from w_print_main`cb_esci within w_grr_partite_aperte_rpt
int X=1943
end type

type tab_1 from w_print_main`tab_1 within w_grr_partite_aperte_rpt
int Y=200
int Width=2286
int Height=956
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2249
int Height=828
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=32
int Y=32
int Width=2190
int Height=760
string DataObject="d_partite_aperte_rpt"
end type

event dw_selection::itemchanged;date		ld_dalla_data
string  ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
integer li_ok

CHOOSE CASE dwo.name
	CASE 'fino_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("fino_data")
		end if
		
		
	case "dal_conto_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "dal_conto_cod"
		ls_dwc[2] = "dal_conto_des"
		li_ok = uf_autofind_col (string(dwo.name),"conto","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'al_conto_cod'))  or this.getitemstring(1,'al_conto_cod')='' then
				 this.setitem(1,'al_conto_cod',data)
				 this.setitem(1,'al_conto_des',this.getitemstring(1,'dal_conto_des'))
			end if
			return 2
		end if	
		
	case "dal_conto_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "dal_conto_cod"
		ls_dwc[2] = "dal_conto_des"
		li_ok = uf_autofind_col (string(dwo.name),"conto","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'al_conto_cod'))  or this.getitemstring(1,'al_conto_cod')='' then
				 this.setitem(1,'al_conto_des',data)
				 this.setitem(1,'al_conto_cod',this.getitemstring(1,'dal_conto_cod'))
			end if
			return 2
		end if		
		
	case "al_conto_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "al_conto_cod"
		ls_dwc[2] = "al_conto_des"
		li_ok = uf_autofind_col (string(dwo.name),"conto","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "al_conto_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "al_conto_cod"
		ls_dwc[2] = "al_conto_des"
		li_ok = uf_autofind_col (string(dwo.name),"conto","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
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
end choose


end event

event dw_selection::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "dal_conto_cod", "al_conto_cod"
		is_search_window = "w_conti_pdc_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "dal_conto_des", "al_conto_des"
		is_search_window = "w_conti_pdc_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 

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
		
	CASE "dal_conto_cod", "al_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_id_conto", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "dal_conto_cod" then
			uf_set_colval("dal_conto_des", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'al_conto_cod'))  or this.getitemstring(1,'al_conto_cod')='' then
				 uf_set_colval("al_conto_cod", is_ricpar.s_main_value)
				 uf_set_colval("al_conto_des", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("al_conto_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "dal_conto_des", "al_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_id_conto", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "dal_conto_des" then
			uf_set_colval("dal_conto_cod", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'al_conto_cod'))  or this.getitemstring(1,'al_conto_cod')='' then
				 uf_set_colval("al_conto_des", is_ricpar.s_main_value)
				 uf_set_colval("al_conto_cod", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("al_conto_cod", is_ricpar.s_ausil_value[1])
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

event dw_selection::itemfocuschanged;call super::itemfocuschanged;



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
int Width=2249
int Height=828
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2249
int Height=828
end type

type cb_stampa from w_print_main`cb_stampa within w_grr_partite_aperte_rpt
int X=1664
end type

