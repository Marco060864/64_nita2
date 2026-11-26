forward
global type w_ver_prov_agenti_rpt from w_print_main
end type
type dw_1 from datawindow within tabpage_select
end type
type dw_1 from datawindow within tabpage_select
end type
end forward

global type w_ver_prov_agenti_rpt from w_print_main
int Width=2350
int Height=1264
boolean TitleBar=true
string Title="Stampa"
end type
global w_ver_prov_agenti_rpt w_ver_prov_agenti_rpt

type variables
integer ii_tab_seq_pro
integer ii_tab_seq_dat
long il_id_esercizio
long il_num_pro
date id_ult_dat
end variables

on w_ver_prov_agenti_rpt.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_ver_prov_agenti_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
date		ld_da_data, ld_ad_data

String 	statement, ls_selezione, ls_tipo_registro, ls_filtro
string	ls_da_ag, ls_a_ag, ls_da_zona, ls_a_zona
char		lc_cal_riep

ld_da_data	     = tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_ad_data	     = tab_1.tabpage_select.dw_selection.GetItemDate(1,"fino_data")
ls_tipo_registro = tab_1.tabpage_select.dw_selection.GetItemstring(1,"tipo_registro")
ls_da_ag         = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_cod_ag")
ls_a_ag          = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_cod_ag")
ls_da_zona		  = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_zona")
ls_a_zona		  = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_zona")
lc_cal_riep		  = tab_1.tabpage_select.dw_selection.GetItemstring(1,"cal_riepiloghi")

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
	statement 		= statement + " AND {Documento.data_registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_filtro 		= ls_filtro + " AND Documento.data_registrazione >= '" + string(ld_da_data, "yyyy-mm-dd") + "'"
	ls_selezione 	= " Dal data doc. " + string(ld_da_data, "dd/mm/yyyy") + ", "
end if

if Not IsNull(ld_ad_data) then
	statement 		= statement + " AND {Documento.data_registrazione} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	ls_filtro 		= ls_filtro +  " AND Documento.data_registrazione <= '" + string(ld_ad_data, "yyyy-mm-dd") + "'"
	ls_selezione 	= ls_selezione + "a data doc.: " + string(ld_ad_data, "dd/mm/yyyy") + "."
end if

statement 		= statement + " AND {Registro.Tipo_Registro} = '" + ls_tipo_registro + "'"
ls_filtro 		= ls_filtro + " AND Registro.Tipo_Registro = '" + ls_tipo_registro + "'"
ls_selezione 	= ls_selezione + "con registro " + ls_tipo_registro + "."


if ls_da_ag <> '' and (not isnull(ls_da_ag))then
	statement 		= statement + " AND {sog_commerciale.Codice} >= '" + ls_da_ag + "'"
	ls_filtro 		= ls_filtro + " AND sog_commerciale.Codice >= '" + ls_da_ag + "'"

   ls_selezione 	= ls_selezione + "da Agente: " + ls_da_ag 
end if
if ls_a_ag <> '' and (not isnull(ls_a_ag)) then
   statement 		= statement + " AND {sog_commerciale.Codice} <= '" + ls_a_ag + "'"
	ls_filtro 		= ls_filtro +  " AND sog_commerciale.Codice <= '" + ls_a_ag + "'"
	
   ls_selezione 	= ls_selezione + "a Agente: " + ls_a_ag + "."
end if


if ls_da_zona <> '' and (not isnull(ls_da_zona)) then
	statement 		= statement + " AND {Cat_zona.Codice} >= '" + ls_da_zona + "'"
	ls_filtro 		= ls_filtro + " AND Cat_zona.Codice >= '" + ls_da_zona + "'"

   ls_selezione 	= ls_selezione + "da zona: " + ls_da_zona
end if

if ls_a_zona <> '' and (not isnull(ls_a_zona)) then
   statement 		= statement + " AND {Cat_zona.Codice} <= '" + ls_a_zona + "'"
	ls_filtro 		= ls_filtro + " AND Cat_zona.Codice <= '" + ls_a_zona + "'"
	
   ls_selezione 	= ls_selezione + "a zona: " + ls_a_zona
end if


is_selection = statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[1].formula_name 		= "id_valuta"
istr_formule[1].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

if (lc_cal_riep = 'S') then
			
	datastore lds, lds2
	string	 ls_sql
	integer	 li_rows, li_i, li_pos
	
	delete from app_st_agenti_cr;
	if (sqlca.sqlcode = -1) then
		messagebox("dberror", sqlca.sqlerrtext)
		rollback;
	else
		commit;
		
		tab_1.tabpage_select.dw_1.settransobject(sqlca)		
	
		for li_i = 1 to 6
			
			lds = create datastore
			lds.dataobject = "ds_ver_prov_agenti_g1_rpt"
			lds.settransobject(sqlca)
			ls_sql = lds.Object.DataWindow.Table.select

			if (li_i = 2) then
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_agente")
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_agente")
				li_pos = pos(ls_sql, "'CA'")
				ls_sql = Replace(ls_sql, li_pos, 4, "'AG'")
			end if

			if (li_i = 3) then
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_sub_agente")
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_sub_agente")
				li_pos = pos(ls_sql, "'CA'")
				ls_sql = Replace(ls_sql, li_pos, 4, "'SA'")
			end if
			
			if (li_i = 4) then
				li_pos = pos(ls_sql, "id_gruppo_agenti", 450)
				ls_sql = Replace(ls_sql, li_pos, 16, "id_gruppo_agenti_2")

				li_pos = pos(ls_sql, "'1'")
				ls_sql = Replace(ls_sql, li_pos, 4, "'2'")
			end if			
			
			if (li_i = 5) then
				li_pos = pos(ls_sql, "id_gruppo_agenti", 450)
				ls_sql = Replace(ls_sql, li_pos, 16, "id_gruppo_agenti_2")

				li_pos = pos(ls_sql, "'1'")
				ls_sql = Replace(ls_sql, li_pos, 4, "'2'")
				
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_agente")
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_agente")
				li_pos = pos(ls_sql, "'CA'")
				ls_sql = Replace(ls_sql, li_pos, 4, "'AG'")
			end if			
			
			if (li_i = 6) then
				li_pos = pos(ls_sql, "id_gruppo_agenti", 450)
				ls_sql = Replace(ls_sql, li_pos, 16, "id_gruppo_agenti_2")

				li_pos = pos(ls_sql, "'1'")
				ls_sql = Replace(ls_sql, li_pos, 4, "'2'")
				
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_sub_agente")
				li_pos = pos(ls_sql, "id_sog_com_capo_area")
				ls_sql = Replace(ls_sql, li_pos, 20, "id_sog_com_sub_agente")
				li_pos = pos(ls_sql, "'CA'")
				ls_sql = Replace(ls_sql, li_pos, 4, "'SA'")
			end if
			
			ls_sql = ls_sql + ls_filtro
			
			lds.Object.DataWindow.Table.select = ls_sql
			
			li_rows = lds.retrieve()
			
			if (li_rows > 0) then
				
				lds.resetupdate()
				li_rows = lds.RowsCopy(1, li_rows, Primary!, tab_1.tabpage_select.dw_1, 1, Primary!)	
				li_rows = tab_1.tabpage_select.dw_1.rowcount()
				li_rows = tab_1.tabpage_select.dw_1.update()
				
				if li_rows = 1 then
					commit using SQLCA;
				else
					rollback using SQLCA;
				end if
			end if
		
			destroy lds
		next
	end if
	
end if

return 0

end event

event ue_pre_open;this.Title = istr_coddes_rpt.titolo_finestra
end event

type cb_esci from w_print_main`cb_esci within w_ver_prov_agenti_rpt
int X=1499
int Y=64
end type

type tab_1 from w_print_main`tab_1 within w_ver_prov_agenti_rpt
int X=14
int Y=204
int Width=2295
int Height=952
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2258
int Height=824
dw_1 dw_1
end type

on tabpage_select.create
this.dw_1=create dw_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on tabpage_select.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=32
int Width=2190
int Height=744
string DataObject="d_ver_prov_agenti_rpt"
end type

event dw_selection::itemchanged;date		ld_dalla_data
string 	ls_sql_cond,ls_dbc[],ls_dbv[],ls_dwc[]
integer  li_ok
string	ls_null

setnull(ls_null)


CHOOSE CASE dwo.name
	CASE 'fino_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("fino_data")
		end if

	CASE 'da_cod_ag'
		IF IsNull(data) OR (isnull(data)) THEN
 		   This.SetItem(row, "da_cod_ag", ls_null)
			This.SetItem(row, "da_des_ag", ls_null)
		ELSE
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod_ag"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_des_ag"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			if isnull(This.getitemstring(1,"a_cod_ag")) or This.getitemstring(1,"a_cod_ag")='' then
		 This.SetItem(1, "a_cod_ag", Data)
		  This.SetItem(1, "a_des_ag", This.Object.da_des_ag[1])
	   end if
			RETURN 2
		END IF

	 END IF
	 
	 CASE 'da_des_ag'
		IF IsNull(data) OR (isnull(data)) THEN
			This.SetItem(row, "da_cod_ag", ls_null)
			This.SetItem(row, "da_des_ag", ls_null)
		ELSE
			
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod_ag"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_des_ag"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)								
										
		IF (li_ok > 0) THEN
			if isnull(This.getitemstring(1,"a_cod_ag")) or This.getitemstring(1,"a_cod_ag")='' then
		  This.SetItem(1, "a_des_ag", Data)
		  This.SetItem(1, "a_cod_ag", This.Object.da_cod_ag[1])
	   end if
			RETURN 2
		END IF
	END IF
	
	CASE 'a_cod_ag'
		IF IsNull(data) OR (isnull(data)) THEN
 		   This.SetItem(row, "a_cod_ag", ls_null)
			This.SetItem(row, "a_des_ag", ls_null)
		ELSE
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod_ag"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_des_ag"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	 END IF
	 
	 CASE 'a_des_ag'
		IF IsNull(data) OR (isnull(data)) THEN
			This.SetItem(row, "a_cod_ag", ls_null)
			This.SetItem(row, "a_des_ag", ls_null)
		ELSE
			
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod_ag"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_des_ag"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
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

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"
is_drop_column[3]	= "da_zona"
is_drop_column[4]	= "a_zona"

end event

event dw_selection::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cod_ag",  "a_cod_ag"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"
	CASE "da_des_ag", "a_des_ag"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"		
END CHOOSE
end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_cod_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_des_ag", is_ricpar.s_ausil_value[1])
		if isnull(This.getitemstring(1,"a_cod_ag")) or This.getitemstring(1,"a_cod_ag")='' then
		  uf_set_colval("a_cod_ag", is_ricpar.s_main_value)
  		  uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])
	   end if	
		
	CASE "da_des_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_ag", is_ricpar.s_ausil_value[1])
		if isnull(This.getitemstring(1,"a_cod_ag")) or This.getitemstring(1,"a_cod_ag")='' then
		  uf_set_colval("a_des_ag", is_ricpar.s_main_value)
  		  uf_set_colval("a_cod_ag", is_ricpar.s_ausil_value[1])
	   end if	
		
	CASE "a_cod_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])		
	CASE "a_des_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod_ag", is_ricpar.s_ausil_value[1])		
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2258
int Height=824
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2258
int Height=824
end type

type cb_stampa from w_print_main`cb_stampa within w_ver_prov_agenti_rpt
int X=1243
int Y=64
end type

event cb_stampa::pre_print;
end event

type dw_1 from datawindow within tabpage_select
int X=165
int Y=872
int Width=2007
int Height=852
int TabOrder=54
boolean BringToTop=true
string DataObject="ds_ver_prov_agenti_c_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

