forward
global type w_stampa_documenti_rpt from w_print_main
end type
end forward

global type w_stampa_documenti_rpt from w_print_main
int Width=2195
int Height=1269
boolean TitleBar=true
string Title="Stampa documenti"
end type
global w_stampa_documenti_rpt w_stampa_documenti_rpt

type variables
long			il_id_esercizio
end variables

forward prototypes
public function integer wf_print_documenti ()
public function integer wf_get_da_protocollo_iva (long al_id_registro, long al_anno)
public function integer wf_get_a_protocollo_iva (long al_id_registro, long al_anno)
public function long wf_get_protocollo_a (long ai_id_registro)
public function long wf_get_protocollo_da (long ai_id_registro)
public function string wf_create_sql ()
public function integer wf_doc_stampato (long al_id_documento[])
end prototypes

public function integer wf_print_documenti ();
long		ll_idx,ll_i,ll_ret
long		ll_id_profilo,ll_id_doc_profilo,ll_row,ll_id_documento
long		ll_id_stampati[],ll_k
date		ld_dalla_data,ld_alla_data
string	ls_SQL,ls_stampa_definitiva
string	ls_directory_report,ls_nome_report_prof,ls_nome_report_doc,ls_selection
integer	li_hwin
integer	li_output
integer	li_da
integer	li_a
integer	li_copie
integer  li_val
integer	li_stampa_ok
pointer  lp_oldpointer  

ll_k = 1

lp_oldpointer = SetPointer(HourGlass!)

ll_row					= tab_1.tabpage_select.dw_selection.GetRow()
ls_stampa_definitiva	= tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"stampa_definitiva" )
ll_id_profilo			= tab_1.tabpage_select.dw_selection.GetItemNumber( ll_row,"id_profilo" )

if not isNull( ll_id_profilo ) then
	
	select "prof_documento"."nome_report"
		into :ls_nome_report_prof
		from "dba"."prof_documento"   
		where "prof_documento"."id_prof_documento" = :ll_id_profilo 
		using SQLCA;
		
	if ls_nome_report_prof = "" or isNull(ls_nome_report_prof) then
		MessageBox( "Attenzione !!!","E' stato selezionato un profilo che non ha un report di stampa",Information! )
		return 0
	end if
end if

if rb_video.checked = true then
	li_output = 1
else
	li_output = 2 
end if	

li_hwin  = 0	
li_da    = integer( tab_1.tabpage_stampante.em_da_pagina.Text )
li_a	   = integer( tab_1.tabpage_stampante.em_a_pagina.Text )
li_copie = integer( tab_1.tabpage_stampante.em_copie.Text )	

if tab_1.tabpage_stampante.rb_all_page.Checked = True then
	li_da	= 0
	li_a	= 0
end if

if tab_1.tabpage_select.dw_selection.AcceptText() > 0 then
	select par_sistema.dir_report 
		into :ls_directory_report
		from dba.par_sistema
		where par_sistema.id_azienda = 1
		using SQLCA;	
		
	if SQLCA.SQLCode = 0 then
		wf_set_printer_info()
	end if

	ls_SQL	= wf_create_SQL()
	
	prepare SQLSA from :ls_SQL;
	
	describe SQLSA into SQLDA;
	
	declare doc_cursor dynamic cursor for SQLSA;
	
	open dynamic doc_cursor using descriptor SQLDA;
	
	do while SQLCA.SQLCode = 0 
	
		fetch doc_cursor using descriptor SQLDA; 	
	
		choose case SQLDA.OutParmType[1]
			case TypeInteger!,TypeLong!
				ll_id_documento = GetDynamicNumber(SQLDA, 1)
		end choose
	
		if SQLCA.SQLCode = 0 then
		
			if not isNull( ll_id_documento ) then
				
				ls_selection	= "{documento.id_documento}=" + String(ll_id_documento)
				
//				u_freddie.iuo_stampa.of_set_Selection_Formula( ls_selection )		
//				u_freddie.iuo_stampa.of_set_title( istr_coddes_rpt.titolo_finestra )
				
				if ii_view = 0 or ii_view = 1 then
//					u_freddie.iuo_stampa.of_set_view( ii_view )      
				end if	
				
				if isNull( ll_id_profilo ) then
					
					select "documento"."id_prof_documento"
						into :ll_id_doc_profilo
						from "dba"."documento"
						where "documento"."id_documento" = :ll_id_documento
						using SQLCA;
					
					select "prof_documento"."nome_report"
						into :ls_nome_report_doc
						from "dba"."prof_documento"   
						where "prof_documento"."id_prof_documento" = :ll_id_doc_profilo 
						using SQLCA;
					
					if SQLCA.SQLCode = 0 then
//						li_stampa_ok	= u_freddie.iuo_stampa.of_stampa( li_hwin,li_output,li_da,li_a,li_copie,ls_directory_report,ls_nome_report_doc )		
						if li_stampa_ok = 0 then
							ll_id_stampati[ll_k] = ll_id_documento
							ll_k++
						end if	
					end if	
					
				else
					
//					li_stampa_ok	= u_freddie.iuo_stampa.of_stampa( li_hwin,li_output,li_da,li_a,li_copie,ls_directory_report,ls_nome_report_prof )		
					if li_stampa_ok = 0 then
						ll_id_stampati[ll_k] = ll_id_documento
						ll_k++
					end if	
					
				end if
				
			end if
			
		end if	
		
	loop	
	
	close doc_cursor;
	
	if ls_stampa_definitiva = 'S' then
		if UpperBound( ll_id_stampati ) > 0 then
			wf_doc_stampato(ll_id_stampati)
		end if
	end if	

end if

SetPointer(lp_oldpointer)

return 0
end function

public function integer wf_get_da_protocollo_iva (long al_id_registro, long al_anno);
long		ll_num_progressivo,ll_row
string	ls_tipo_registro

select	registro.tipo_registro 
	into	:ls_tipo_registro
	from  registro
	where registro.id_registro =: al_id_registro
	using SQLCA;

if ls_tipo_registro = 'IA' or ls_tipo_registro = 'IV' then
	
	select min(documento.num_progressivo) 
		into :ll_num_progressivo
		from documento
		where documento.id_registro = :al_id_registro and
				Year(documento.data_registrazione) = :al_anno and
				documento.stampato = 'N'
		using SQLCA;			

	if SQLCA.SQLCode = 0 then
		if isNull(ll_num_progressivo) then
			MessageBox( "Informazione","Per il registro selezionato sono stati stampati tutti i documenti",Information! )
		end if		
		ll_row	= tab_1.tabpage_select.dw_selection.GetRow()
		tab_1.tabpage_select.dw_selection.SetItem( ll_row,"da_protocollo",ll_num_progressivo ) 	
	end if
	
	if SQLCA.SQLCode = 100 then
		MessageBox( "Informazione","Per il registro selezionato sono stati stampati tutti i documenti",Information! )
	end if
	
end if

return 0
end function

public function integer wf_get_a_protocollo_iva (long al_id_registro, long al_anno);
long		ll_num_progressivo,ll_row
string	ls_tipo_registro

select	registro.tipo_registro 
	into	:ls_tipo_registro
	from  registro
	where registro.id_registro =: al_id_registro
	using SQLCA;

if ls_tipo_registro = 'IA' or ls_tipo_registro = 'IV' then
	
	select max(documento.num_progressivo) 
		into :ll_num_progressivo
		from documento
		where documento.id_registro = :al_id_registro and
				Year(documento.data_registrazione) = :al_anno
		using SQLCA;			
		
	if SQLCA.SQLCode = 0 then
		ll_row	= tab_1.tabpage_select.dw_selection.GetRow()
		tab_1.tabpage_select.dw_selection.SetItem( ll_row,"a_protocollo",ll_num_progressivo ) 	
	end if
		
end if

return 0
end function

public function long wf_get_protocollo_a (long ai_id_registro);
long		ll_num_progressivo,ll_row
string	ls_tipo_registro

select	registro.tipo_registro 
	into	:ls_tipo_registro
	from  registro
	where registro.id_registro =: ai_id_registro
	using SQLCA;

if ls_tipo_registro <> 'IA' and ls_tipo_registro <> 'IV' then
	
	select max(documento.num_progressivo) 
		into :ll_num_progressivo
		from documento
		where documento.id_registro = :ai_id_registro
		using SQLCA;					
		
	if SQLCA.SQLCode = 0 then
		ll_row	= tab_1.tabpage_select.dw_selection.GetRow()
		tab_1.tabpage_select.dw_selection.SetItem( ll_row,"a_protocollo",ll_num_progressivo ) 	
	end if	
		
end if

return 0
end function

public function long wf_get_protocollo_da (long ai_id_registro);
long		ll_num_progressivo,ll_row
string	ls_tipo_registro

select	registro.tipo_registro 
	into	:ls_tipo_registro
	from  registro
	where registro.id_registro =: ai_id_registro
	using SQLCA;

if ls_tipo_registro <> 'IA' and ls_tipo_registro <> 'IV' then
	
	select min(documento.num_progressivo) 
		into :ll_num_progressivo
		from documento
		where documento.id_registro = :ai_id_registro and
				documento.stampato = 'N'
		using SQLCA;					

	if SQLCA.SQLCode = 0 then
		if isNull(ll_num_progressivo) then
			MessageBox( "Informazione","Per il registro selezionato sono stati stampati tutti i documenti",Information! )
		end if
		ll_row	= tab_1.tabpage_select.dw_selection.GetRow()
		tab_1.tabpage_select.dw_selection.SetItem( ll_row,"da_protocollo",ll_num_progressivo ) 	
	end if
	
	if SQLCA.SQLCode = 100 then
		MessageBox( "Informazione","Per il registro selezionato sono stati stampati tutti i documenti",Information! )
	end if
	

end if

return 0

end function

public function string wf_create_sql ();
long 		ll_row,ll_id_registro,ll_da_protocollo,ll_a_protocollo,ll_id_profilo,ll_anno
date		ld_dalla_data,ld_alla_data
string	ls_tipo_registro,ls_da_documento,ls_a_documento,ls_profilo
string	ls_SQL

ll_row				= tab_1.tabpage_select.dw_selection.GetRow()
ll_id_registro		= tab_1.tabpage_select.dw_selection.GetItemNumber( ll_row,"id_registro" )
ll_da_protocollo	= tab_1.tabpage_select.dw_selection.GetItemNumber( ll_row,"da_protocollo" )
ll_a_protocollo	= tab_1.tabpage_select.dw_selection.GetItemNumber( ll_row,"a_protocollo" )
ll_anno				= tab_1.tabpage_select.dw_selection.GetItemNumber( ll_row,"anno" )
ll_id_profilo		= tab_1.tabpage_select.dw_selection.GetItemNumber( ll_row,"id_profilo" )
ls_da_documento	= tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"da_documento" )
ls_a_documento		= tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"a_documento" )
ls_profilo			= tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"profilo_cod" )
ls_tipo_registro	= tab_1.tabpage_select.dw_selection.GetItemString( ll_row,"tipo_registro" )
ld_dalla_data		= tab_1.tabpage_select.dw_selection.GetItemDate( ll_row,"dalla_data" )
ld_alla_data		= tab_1.tabpage_select.dw_selection.GetItemDate( ll_row,"alla_data" )

ls_SQL	= 	"select documento.id_documento " + &
				" from documento " + &
				" where documento.id_azienda = 1 and "  + &
						 "documento.stampato = 'N'"	

if not isNull( ll_id_registro ) then
	ls_SQL	+= " and documento.id_registro = " + string(ll_id_registro)
end if

if not isNull( ld_dalla_data ) then
	ls_SQL	+= " and documento.data_registrazione >= '" + string(ld_dalla_data, "yyyy-mm-dd") + "'"
end if

if not isNull( ld_alla_data ) then
	ls_SQL	+= " and documento.data_registrazione >= '" + string(ld_alla_data,"yyyy-mm-dd") + "'"
end if

if not isNull( ll_da_protocollo ) then
	ls_SQL	+= " and documento.num_progressivo >= " + string(ll_da_protocollo)
end if

if not isNull( ll_a_protocollo ) then
	ls_SQL	+= " and documento.num_progressivo <= " + string(ll_a_protocollo)
end if

if not isNull( ls_da_documento ) then
	ls_SQL	+= " and documento.num_documento >= '" + ls_da_documento + "'"
end if

if not isNull( ls_a_documento ) then
	ls_SQL	+= " and documento.num_documento <= '" + ls_a_documento + "'"
end if

if not isNull( ls_profilo ) then
	ls_SQL	+= " and documento.id_prof_documento = " + string(ll_id_profilo)
end if


if not isNull( ls_tipo_registro ) then

	if ls_tipo_registro = 'IA' or ls_tipo_registro = 'IV' then
		if not isNull( ll_anno ) then
			ls_SQL	+= " and Year(documento.data_registrazione) = " + string(ll_anno)
		end if	
	end if

end if

return ls_SQL
end function

public function integer wf_doc_stampato (long al_id_documento[]);
long 		ll_i
boolean	lb_error

lb_error	= false

for ll_i	= 1 to UpperBound(al_id_documento)

	update documento
		set documento.stampato = 'S'
		where documento.id_documento = :al_id_documento[ll_i]
		using SQLCA;
		
	if SQLCA.SQLCode = -1 then
		lb_error = true
		MessageBox( "Attenzione","Errore scrivendo sul database",StopSign! )
	end if
	
next		
	
if lb_error	= false then
	commit using SQLCA;
else
	rollback using SQLCA;	
end if

return 0


end function

on w_stampa_documenti_rpt.create
call w_print_main::create
end on

on w_stampa_documenti_rpt.destroy
call w_print_main::destroy
end on

type cb_esci from w_print_main`cb_esci within w_stampa_documenti_rpt
int X=1875
int Y=81
end type

type tab_1 from w_print_main`tab_1 within w_stampa_documenti_rpt
int Width=2126
int Height=981
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2090
int Height=853
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=49
int Width=1989
int Height=761
string DataObject="d_stampa_documento_rpt"
end type

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "id_esercizio"
is_drop_column[2]	= "id_registro"
end event

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "profilo_cod"
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
	CASE "profilo_des"
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_descrizione" 

END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "profilo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("profilo_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_profilo", is_ricpar.s_id_seg_value[1])
		
	CASE "profilo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("profilo_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_profilo", is_ricpar.s_id_seg_value[1])
		
END CHOOSE


end event

event dw_selection::ue_initial;call super::ue_initial;
long					ll_row,ll_anno
string 				ls_filtro
datawindowchild	ldwc_drop

select  "azienda"."id_esercizio_proposto"
	into :il_id_esercizio
	from "dba"."azienda"
	where "azienda"."id_azienda" = 1
	using SQLCA;

if SQLCA.SQLCode = 0 then
	if not isNull( il_id_esercizio ) then
		
		ll_row	= this.GetRow()
		this.SetItem( ll_row,"id_esercizio",il_id_esercizio )
	
		if this.GetChild( "id_registro",ldwc_drop ) = 1 then
			if not isNull( ldwc_drop ) then
				ls_filtro = "registro_id_esercizio = " + string(il_id_esercizio)
				if ldwc_drop.SetFilter(ls_filtro) = -1 then
					MessageBox( "Set Filter error","Errore nell'applicazione del filtro",Information! )
				end if
				if ldwc_drop.Filter() = -1 then
					MessageBox( "Filter error","Errore nell'applicazione del filtro",Information! )
				end if
			end if
		end if	
	end if	
		
end if

ll_anno	= Year(Today())
ll_row	= this.GetRow()
this.SetItem( ll_row,"anno",ll_anno )



end event

event dw_selection::itemchanged;call super::itemchanged;long					ll_row,ll_id_registro,ll_anno
string 				ls_filtro,ls_tipo_registro
datawindowchild	ldwc_drop

choose case dwo.name 
		
	case 'id_esercizio'
		
		il_id_esercizio	= long(data)
		
		if not isNull( il_id_esercizio ) then
		
			ll_row	= this.GetRow()
			this.SetItem( ll_row,"id_esercizio",il_id_esercizio )
		
			if this.GetChild( "id_registro",ldwc_drop ) = 1 then
				if not isNull( ldwc_drop ) then
					ls_filtro = "registro_id_esercizio = " + string(il_id_esercizio)
					ldwc_drop.SetFilter(ls_filtro)
			      ldwc_drop.Filter()
				end if
			end if	
		else
			
			if this.GetChild( "id_registro",ldwc_drop ) = 1 then
				if not isNull( ldwc_drop ) then
					ldwc_drop.SetFilter("")
			      ldwc_drop.Filter()
				end if
			end if	
			
			this.SetItem( ll_row,"id_registro",u_freddie.gs_null )
		end if
		
	case 'id_registro'	
		
		ll_id_registro = long( data )
		
		select registro.tipo_registro
			into :ls_tipo_registro
			from registro
			where registro.id_registro = :ll_id_registro;
		
		if SQLCA.SQLCode = 0 then
			
			this.SetItem( row,"tipo_registro",ls_tipo_registro )

			if ls_tipo_registro <> 'IA' and ls_tipo_registro <> 'IV' then
				
				this.SetItem( row,"anno",u_freddie.gs_null )
				if not isNull( ll_id_registro ) then
					wf_get_protocollo_da(ll_id_registro)
					wf_get_protocollo_a(ll_id_registro)
				end if	
			else
				
				ll_anno			= this.getItemNumber( row,"anno" )		
				if not isNull( ll_id_registro ) and not isNull(ll_anno) then
					wf_get_da_protocollo_iva(ll_id_registro,ll_anno)
					wf_get_a_protocollo_iva(ll_id_registro,ll_anno)
				end if	
			end if
		end if	
		
		
		
		
	case 'anno'	
		
		ll_id_registro = this.getItemNumber( row,"id_registro" )
		ll_anno			= long( data )
		
		
		select registro.tipo_registro
			into :ls_tipo_registro
			from registro
			where registro.id_registro = :ll_id_registro;
		
		if SQLCA.SQLCode = 0 then

			if ls_tipo_registro <> 'IA' and ls_tipo_registro <> 'IV' then
				
				this.SetItem( row,"anno",u_freddie.gs_null )
				
				if not isNull( ll_id_registro ) then
					wf_get_protocollo_da(ll_id_registro)
					wf_get_protocollo_a(ll_id_registro)
				end if	
				
			else

				if not isNull( ll_id_registro ) and not isNull(ll_anno) then
					wf_get_da_protocollo_iva(ll_id_registro,ll_anno)
					wf_get_a_protocollo_iva(ll_id_registro,ll_anno)
				end if	
				
			end if
		end if	
						
		
end choose
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2090
int Height=853
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2090
int Height=853
end type

type cb_stampa from w_print_main`cb_stampa within w_stampa_documenti_rpt
int X=1601
int Y=81
end type

event cb_stampa::clicked;

wf_print_documenti()

return 0
end event

