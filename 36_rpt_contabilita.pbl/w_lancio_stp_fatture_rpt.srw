forward
global type w_lancio_stp_fatture_rpt from w_print_main
end type
end forward

global type w_lancio_stp_fatture_rpt from w_print_main
int Width=2272
int Height=1232
boolean TitleBar=true
string Title="Stampa"
end type
global w_lancio_stp_fatture_rpt w_lancio_stp_fatture_rpt

type variables
integer ii_tab_seq_pro
integer ii_tab_seq_dat
long il_id_esercizio
long il_num_pro
date id_ult_dat
end variables

on w_lancio_stp_fatture_rpt.create
call super::create
end on

on w_lancio_stp_fatture_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
date		ld_da_data, ld_ad_data

String 	statement, ls_selezione, ls_tipo_registro, ls_da_ag, ls_a_ag, ls_da_zona, ls_a_zona


ld_da_data	     = tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_ad_data	     = tab_1.tabpage_select.dw_selection.GetItemDate(1,"fino_data")
ls_tipo_registro = tab_1.tabpage_select.dw_selection.GetItemstring(1,"tipo_registro")
ls_da_ag         = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_cod_ag")
ls_a_ag          = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_cod_ag")
ls_da_zona		  = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_zona")
ls_a_zona		  = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_zona")

statement  = " {Documento.ID_Azienda} = 1"



if ld_da_data > ld_ad_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if isnull(ls_tipo_registro) then 
   MessageBox( "Attenzione","Non è stato selezionato il tipo registro")
	return -1
end if	


if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Documento} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data documento " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data documento - non definita, "
end if

if Not IsNull(ld_ad_data) then
	statement 		= statement + " AND {Documento.Data_Documento} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data documento " + string(ld_ad_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data documento - non definita,"	
end if


statement 		= statement + " AND {Registro.Tipo_Registro} = '" + ls_tipo_registro + "'"
ls_selezione 	= ls_selezione + "con registro " + ls_tipo_registro + "."



if ls_da_ag<>'' and ls_a_ag<>'' and (not isnull(ls_da_ag)) and (not isnull(ls_a_ag)) then
	statement 		= statement + " AND {gruppo_agenti.Codice} >= '" + ls_da_ag + "'"
   ls_selezione 	= ls_selezione + "da agente " + ls_da_ag 
   statement 		= statement + " AND {gruppo_agenti.Codice} <= '" + ls_a_ag + "'"
   ls_selezione 	= ls_selezione + "a agente " + ls_a_ag + "."
end if

if ls_da_zona<>'' and ls_a_zona<>'' and (not isnull(ls_da_zona)) and (not isnull(ls_a_zona)) then
	statement 		= statement + " AND {Cat_zona.Codice} >= '" + ls_da_zona + "'"
   ls_selezione 	= ls_selezione + "dalla zona" + ls_da_zona
   statement 		= statement + " AND {Cat_zona.Codice} <= '" + ls_a_zona + "'"
   ls_selezione 	= ls_selezione + "alla zona " + ls_a_zona + "."
end if


is_selection = statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[1].formula_name 		= "id_valuta"
istr_formule[1].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

event open;call super::open;

datawindowchild ldw_zona, ldw_zona2
		
tab_1.tabpage_select.dw_selection.getchild("da_zona",ldw_zona)
ldw_zona.settransobject(sqlca)
ldw_zona.retrieve()
		
tab_1.tabpage_select.dw_selection.getchild("a_zona",ldw_zona2)
ldw_zona2.settransobject(sqlca)
ldw_zona2.retrieve()		
end event

event ue_pre_open;this.Title = istr_coddes_rpt.titolo_finestra
end event

type cb_esci from w_print_main`cb_esci within w_lancio_stp_fatture_rpt
int X=1499
end type

type tab_1 from w_print_main`tab_1 within w_lancio_stp_fatture_rpt
int X=14
int Y=204
int Width=2226
int Height=924
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2190
int Height=796
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=9
int Y=32
int Width=2162
int Height=744
string DataObject="d_lancio_stp_fatture_ff"
end type

event dw_selection::itemchanged;date		ld_dalla_data
string ls_sql_cond,ls_dbc[],ls_dbv[],ls_dwc[]
integer li_ok


CHOOSE CASE dwo.name
	CASE 'fino_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("fino_data")
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

event dw_selection::ue_initial;string	ls_data_oggi
date 		ld_inizio_esercizio

SELECT esercizio.data_inizio INTO :ld_inizio_esercizio
	FROM dba.esercizio WHERE esercizio.id_azienda = 1 ;			
	
this.SetItem(1, "dalla_data",ld_inizio_esercizio )
this.SetItem( 1,"fino_data",Today() )

long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if


end event

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

end event

event dw_selection::ue_set_search;choose case as_nomecol
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
end choose
end event

event dw_selection::ue_use_search;choose case as_nomecol
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

end choose		
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2190
int Height=796
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2190
int Height=796
end type

type cb_stampa from w_print_main`cb_stampa within w_lancio_stp_fatture_rpt
int X=1243
end type

event cb_stampa::pre_print;
end event

