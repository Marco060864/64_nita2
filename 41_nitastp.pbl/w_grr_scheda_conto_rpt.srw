forward
global type w_grr_scheda_conto_rpt from w_print_main
end type
end forward

global type w_grr_scheda_conto_rpt from w_print_main
int Width=2245
int Height=1116
boolean TitleBar=true
string Title="Stampa Scheda Contabile"
end type
global w_grr_scheda_conto_rpt w_grr_scheda_conto_rpt

type variables

end variables

on w_grr_scheda_conto_rpt.create
call super::create
end on

on w_grr_scheda_conto_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;

string	ls_da_cod, ls_ad_cod, ls_pr, ls_sort
string 	statement, ls_selezione, ls_riporto, ls_temp
date		ld_da_data, ld_da_data_es, ld_ad_data

ls_da_cod 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"dal_conto_cod")
ls_ad_cod 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"al_conto_cod")
ld_ad_data 	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"fino_data")
ld_da_data 	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ls_sort 		= tab_1.tabpage_select.dw_selection.GetItemString(1,"ordinamento")
ls_riporto  = tab_1.tabpage_select.dw_selection.GetItemString(1,"riporto_periodo")

if ls_riporto = "S" then	
	SELECT "esercizio"."data_inizio"  
  	  INTO :ld_da_data_es 
   	FROM "esercizio",   
       	  "azienda"  
  	 WHERE ( "esercizio"."id_esercizio" = "azienda"."id_esercizio" ) and ("azienda"."id_azienda" =1)  ;
	if SQLCA.SQLCode <>0 then 
		MessageBox("Errore", "Errore sul database")
 	return -1
	end if

	if ls_da_cod > ls_ad_cod then
		if MessageBox( "Attenzione","Conto 'da' maggiore di Conto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if
statement  = " {Conto.ID_Azienda} = 1"

STATEMENT = STATEMENT + "AND {REGISTRO.TIPO_REGISTRO} <> 'MN'"

if ls_riporto = "S" then
	if Not IsNull(ld_da_data_es) then
		statement 		= statement + " AND {Reg_PD.Data_Registrazione} >= Date (" + string(ld_da_data_es, "yyyy, mm, dd") + ")"
		ls_selezione 	= " Dalla data di Inizio Esercizio Corrente " + string(ld_da_data_es, "dd/mm/yyyy") + ", "
	else
		
		ls_selezione 	= " Dalla data - non definita, "	
	end if
else
	if not isnull(ld_da_data) then
		statement 		= statement + " AND {Reg_PD.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
		ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
	else
		
		ls_selezione 	= " Dalla data - non definita, "	
	end if
end if
if Not IsNull(ld_ad_data) then
	statement 		= statement + " AND {Reg_PD.Data_Registrazione} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_ad_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione = ls_selezione + "alla data registrazione - non definita."
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

is_selection = statement

return 0


end event

event ue_post_open;call super::ue_post_open;
rb_video.Checked = True
return 0
end event

type cb_esci from w_print_main`cb_esci within w_grr_scheda_conto_rpt
int X=1943
end type

type tab_1 from w_print_main`tab_1 within w_grr_scheda_conto_rpt
int Y=200
int Width=2149
int Height=820
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2112
int Height=692
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Width=2007
int Height=600
string DataObject="d_scheda_conto_rpt"
end type

event dw_selection::itemchanged;date		ld_dalla_data
string	ls_cod,ls_des,ls_codice
string  ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok


choose case dwo.name
	case 'fino_data'
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
end choose


end event

event dw_selection::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "dal_conto_cod", "al_conto_cod"
		is_search_window = "w_conti_pdc_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.b_imm_retrieve = TRUE
	CASE "dal_conto_des", "al_conto_des"
		is_search_window = "w_conti_pdc_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.b_imm_retrieve = TRUE
		
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
END CHOOSE

end event

event dw_selection::itemfocuschanged;call super::itemfocuschanged;


end event

event dw_selection::ue_initial;call super::ue_initial;
string	ls_data_oggi
date 		ld_inizio_esercizio

SELECT esercizio.data_inizio INTO :ld_inizio_esercizio
	FROM dba.esercizio WHERE esercizio.id_azienda = 1 ;			
	
this.SetItem(1, "dalla_data",ld_inizio_esercizio )
this.SetItem( 1,"fino_data",Today() )


end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2112
int Height=692
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2112
int Height=692
end type

type cb_stampa from w_print_main`cb_stampa within w_grr_scheda_conto_rpt
int X=1664
end type

