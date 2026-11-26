forward
global type w_riep_liq_iva_rpt from w_print_main
end type
end forward

global type w_riep_liq_iva_rpt from w_print_main
int Width=2167
boolean TitleBar=true
string Title="Riepilogo liquidazione iva"
end type
global w_riep_liq_iva_rpt w_riep_liq_iva_rpt

forward prototypes
public function integer wf_commit_update_table (boolean ab_result)
public function integer wf_update_table ()
end prototypes

public function integer wf_commit_update_table (boolean ab_result);
date			ld_a_data,ld_da_data
long			ll_num,ll_scode,ll_id_registro,ll_id_reg_pd
long			ll_row,ll_righe,ll_k,ll_i,ll_idregpd,ll_id_attivita
string		ls_stampa_bollato,ls_stampa_mov
string		ls_where,ls_sql,ls_sql_init
integer		li_ret
u_ds_main	lds_reg_pd
u_ds_main	lds_mov_iva
datawindow 	ldw_w

ldw_w = tab_1.tabpage_select.dw_selection

ld_da_data 	= ldw_w.GetItemDate(1, "dalla_data", Primary!, TRUE)
ld_a_data 	= ldw_w.GetItemDate(1, "alla_data", Primary!, TRUE)
ll_id_attivita	= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_attivita_cod")

if isNull(ld_a_data) then
	ld_a_data = Date(3000,01,01)
end if	


lds_reg_pd	= create u_ds_main
lds_mov_iva	= create u_ds_main
lds_reg_pd.DataObject	= "d_reg_pd_stampa_bollato_ds"
lds_mov_iva.DataObject	= "d_mov_iva_stampa_bollato_ds"

lds_reg_pd.SetTransObject(SQLCA)
lds_mov_iva.SetTransObject(SQLCA)

ls_where  = " ( Mov_Iva.ID_Azienda} = 1 )"

if Not IsNull(ld_da_data) then
	ls_where	 	= ls_where + " AND ( Reg_PD.Data_Registrazione >= '" + string(ld_da_data, "yyyy-mm-dd") + "' )"
end if

if Not IsNull(ld_a_data) then
	ls_where 		= ls_where + " AND ( Reg_PD.Data_Registrazione <= '" + string(ld_a_data, "yyyy-mm-dd") + "' )"
end if

if Not IsNull(ll_id_attivita) then
	ls_where 		= ls_where + " AND ( Registro.ID_Attivita = " + string(ll_id_attivita) + " )"
end if

ls_sql_init = lds_reg_pd.object.datawindow.table.select
lds_reg_pd.iu_scan.f_setinitial(ls_sql_init)
lds_reg_pd.iu_scan.f_reset_cur_as_ini()
lds_reg_pd.iu_scan.f_add_where_condition(ls_where)
ls_sql = lds_reg_pd.iu_scan.f_getcurrent()

lds_reg_pd.object.datawindow.table.select = ls_sql

if ab_result = True then
	
	ll_row = lds_reg_pd.Retrieve()
	if ll_row >  0 then
		for ll_i = 1 to ll_row
			
			ls_stampa_bollato = lds_reg_pd.GetItemString( ll_i,"reg_pd_st_reg_iva" )
			
			if ls_stampa_bollato = "I" then
				
				
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_reg_iva","S" )
								
				
				ll_idregpd	= lds_reg_pd.GetItemNumber( ll_i,"reg_pd_id_reg_pd" )
							
				
				ll_righe = lds_mov_iva.Retrieve(ll_idregpd)
				
				if ll_righe > 0 then
					
					for ll_k = 1 to ll_righe 
						
						ls_stampa_mov = lds_mov_iva.GetItemString( ll_k,"st_liquidazione" )
						
						if ls_stampa_mov = "I" then
							
							
							lds_mov_iva.SetItem( ll_k,"st_liquidazione","S" )
											
						end if	
						
					next	
					
					
					li_ret = lds_mov_iva.Update()
					if li_ret = -1 then
						rollback using SQLCA;
						return -1
					end if		
					
					if li_ret = 1 then
						commit using SQLCA;
						if SQLCA.SQLCode <> 0 then
							rollback using SQLCA;
						end if						
					else
						rollback using SQLCA;
					end if
					
				end if
				
				
				li_ret = lds_reg_pd.Update()
				if li_ret = -1 then
					rollback using SQLCA;
					return -1					
				end if
				
				if li_ret = 1 then
					commit using SQLCA;
					if SQLCA.SQLCode <> 0 then
						rollback using SQLCA;
					end if					
				else
					rollback using SQLCA;
				end if
				
			end if	
		next	
		
	end if	
else
	SetNull(ll_num)

	lds_reg_pd.SetTransObject(SQLCA)
	ll_row = lds_reg_pd.Retrieve()
	if ll_row >  0 then
		for ll_i = 1 to ll_row
			
			ls_stampa_bollato = lds_reg_pd.GetItemString( ll_i,"reg_pd_st_reg_iva" )
			
			if ls_stampa_bollato = "I" then
				
				
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_reg_iva","N" )
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_data_reg_iva",u_freddie.gs_null )
				
				ll_idregpd	= lds_reg_pd.GetItemNumber( ll_i,"reg_pd_id_reg_pd" )
							
				lds_mov_iva.SetTransObject(SQLCA)
				
				
				ll_righe = lds_mov_iva.Retrieve(ll_idregpd)
				
				if ll_righe > 0 then
					
					for ll_k = 1 to ll_righe 
						
						ls_stampa_mov = lds_mov_iva.GetItemString( ll_k,"st_liquidazione" )
						
						if ls_stampa_mov = "I" then
							
							
							lds_mov_iva.SetItem( ll_k,"st_liquidazione","N" )
							lds_mov_iva.SetItem( ll_k,"st_data_liquidazione",u_freddie.gs_null )
														
						end if	
						
					next	
					
					
					li_ret = lds_mov_iva.Update()
					if li_ret = -1 then
						rollback using SQLCA;
						return -1
					end if	
					
					if li_ret = 1 then
						commit using SQLCA;
						if SQLCA.SQLCode <> 0 then
							rollback using SQLCA;
						end if						
					else
						rollback using SQLCA;
					end if
					
				end if
				
				
				li_ret = lds_reg_pd.Update()
				if li_ret = -1 then
					rollback using SQLCA;
					return -1					
				end if
				
				if li_ret = 1 then
					commit using SQLCA;
					if SQLCA.SQLCode <> 0 then
						rollback using SQLCA;
					end if					
				else
					rollback using SQLCA;
				end if
				
			end if	
		next	
	end if	
end if

destroy lds_reg_pd
destroy lds_mov_iva

return 0

end function

public function integer wf_update_table ();
date			ld_da_data, ld_a_data,ld_data_fino
long			ll_num,ll_scode,ll_id_registro,ll_id_reg_pd
long			ll_row,ll_righe,ll_k,ll_i,ll_idregpd,ll_id_attivita
string		ls_stampa_bollato,ls_stampa_mov
string		ls_where,ls_sql,ls_sql_init
integer		li_ret
u_ds_main	lds_reg_pd
u_ds_main	lds_mov_iva
datawindow 	ldw_w

ldw_w = tab_1.tabpage_select.dw_selection

ld_da_data 		= ldw_w.GetItemDate(1, "dalla_data", Primary!, TRUE)
ld_a_data 		= ldw_w.GetItemDate(1, "alla_data", Primary!, TRUE)
ll_id_attivita	= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_attivita_cod")

if isNull( ld_a_data ) then
	MessageBox( "Informazione","E' indispensabile inserire una data di fine periodo",Information! )
	return -1
end if

ld_data_fino	= ld_a_data


lds_reg_pd	= create u_ds_main
lds_mov_iva	= create u_ds_main

lds_reg_pd.DataObject	= "d_reg_pd_stampa_bollato_ds"
lds_mov_iva.DataObject	= "d_mov_iva_stampa_bollato_ds"
lds_reg_pd.SetTransObject(SQLCA)
lds_mov_iva.SetTransObject(SQLCA)

ls_where  = " ( Mov_Iva.ID_Azienda} = 1 )"

if Not IsNull(ld_da_data) then
	ls_where	 	= ls_where + " AND ( Reg_PD.Data_Registrazione >= '" + string(ld_da_data, "yyyy-mm-dd") + "' )"
end if

if Not IsNull(ld_a_data) then
	ls_where 		= ls_where + " AND ( Reg_PD.Data_Registrazione <= '" + string(ld_a_data, "yyyy-mm-dd") + "' )"
end if

if Not IsNull(ll_id_attivita) then
	ls_where 		= ls_where + " AND ( Registro.ID_Attivita = " + string(ll_id_attivita) + " )"
end if

ls_sql_init = lds_reg_pd.object.datawindow.table.select
lds_reg_pd.iu_scan.f_setinitial(ls_sql_init)
lds_reg_pd.iu_scan.f_reset_cur_as_ini()
lds_reg_pd.iu_scan.f_add_where_condition(ls_where)
ls_sql = lds_reg_pd.iu_scan.f_getcurrent()

lds_reg_pd.object.datawindow.table.select = ls_sql

ll_row = lds_reg_pd.Retrieve()
if ll_row >  0 then
	for ll_i = 1 to ll_row
		
		ls_stampa_bollato = lds_reg_pd.GetItemString( ll_i,"reg_pd_st_reg_iva" )
		
		if ls_stampa_bollato = "N" then
			
			
			lds_reg_pd.SetItem( ll_i,"reg_pd_st_reg_iva","I" )
			
			
			if not isNull(ld_data_fino) then
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_data_reg_iva",ld_data_fino )
			end if	
			
			
			ll_idregpd	= lds_reg_pd.GetItemNumber( ll_i,"reg_pd_id_reg_pd" )
						
			
			ll_righe = lds_mov_iva.Retrieve(ll_idregpd)
			
			if ll_righe > 0 then
				
				for ll_k = 1 to ll_righe 
					
					ls_stampa_mov = lds_mov_iva.GetItemString( ll_k,"st_liquidazione" )
					
					if ls_stampa_mov = "N" then
						
						
						lds_mov_iva.SetItem( ll_k,"st_liquidazione","I" )
						
						
						lds_mov_iva.SetItem( ll_k,"st_data_liquidazione",ld_data_fino )
						
					end if	
					
				next	
				
				
				li_ret = lds_mov_iva.Update()
				if li_ret = -1 then
					rollback using SQLCA;
					return -1
				end if		
				
				if li_ret = 1 then
					commit using SQLCA;
					if SQLCA.SQLCode <> 0 then
						rollback using SQLCA;
					end if
				else
					rollback using SQLCA;
				end if
				
			end if
			
			
			li_ret = lds_reg_pd.Update()
			if li_ret = -1 then
				return -1
			end if
			
			if li_ret = 1 then
				commit using SQLCA;
				if SQLCA.SQLCode <> 0 then
					rollback using SQLCA;
				end if
			else
				rollback using SQLCA;
			end if
			
		end if	
	next	
end if

destroy lds_reg_pd
destroy lds_mov_iva

return 0

end function

on w_riep_liq_iva_rpt.create
call w_print_main::create
end on

on w_riep_liq_iva_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_id_attivita
string	ls_stampa_definitiva
date		ld_da_data, ld_a_data
String 	statement, ls_selezione

ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")
ll_id_attivita			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_attivita_cod")
ls_stampa_definitiva = tab_1.tabpage_select.dw_selection.GetItemString(1,"stampa_definitiva")

if ld_da_data > ld_a_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	


statement  = " {Mov_Iva.ID_Azienda} = 1"

if Not IsNull(ld_da_data) then
	statement	 	= statement + " AND {Reg_PD.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data registrazione - non definita, "	
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Reg_PD.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_a_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data registrazione - non definita."
end if


if Not IsNull(ll_id_attivita) then
	statement 		= statement + " AND {Registro.ID_Attivita} = " + string(ll_id_attivita) + ""
	ls_selezione 	= ls_selezione + " Attività : " + string(ll_id_attivita) + "."
else
	ls_selezione 	= ls_selezione + " Attività - non definita."
end if


is_selection 	= statement
return 0

end event

type cb_esci from w_print_main`cb_esci within w_riep_liq_iva_rpt
int X=1829
int Y=81
end type

type tab_1 from w_print_main`tab_1 within w_riep_liq_iva_rpt
int Width=2081
int Height=881
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2044
int Height=753
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=49
int Width=1943
string DataObject="d_riep_liq_iva_rpt"
end type

event dw_selection::itemchanged;call super::itemchanged;date		ld_dalla_data,ld_ult_liquidazione

CHOOSE CASE dwo.name
	CASE 'alla_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("alla_data")
		end if
	CASE "stampa_definitiva"
		if data = "S" then
			SELECT par_sistema.ult_data_liquidazione INTO :ld_ult_liquidazione
			FROM dba.par_sistema WHERE par_sistema.id_azienda = 1 ;			
			this.SetItem(1, "dalla_data",ld_ult_liquidazione )
			Post SetColumn("alla_data")
		end if	
		
		
END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "id_attivita_cod"
is_drop_column[2] = "id_attivita_des"

end event

event dw_selection::ue_default;call super::ue_default;
date ld_ult_liquidazione
SELECT par_sistema.ult_data_liquidazione INTO :ld_ult_liquidazione
			FROM dba.par_sistema WHERE par_sistema.id_azienda = 1 ;			
this.SetItem(1, "dalla_data",ld_ult_liquidazione )
this.SetItem(1, "alla_data",Today() )

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2044
int Height=753
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2044
int Height=753
end type

type cb_stampa from w_print_main`cb_stampa within w_riep_liq_iva_rpt
int X=1578
int Y=81
end type

event cb_stampa::clicked;
integer	li_ret,li_msg
string	ls_def
long		ll_row
date 		ld_a_data

li_ret 	= 0
ll_row	= tab_1.tabpage_select.dw_selection.GetRow()
ls_def	= tab_1.tabpage_select.dw_selection.GetItemString(1,"stampa_definitiva")
ld_a_data	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")

if ls_def = "S" then
	li_ret = wf_update_table()
	if li_ret = -1 then
		return 0 
	end if	
end if	


if li_ret = 0 then
	li_ret	= wf_print()
end if	

if ls_def = "S" then
	li_msg = MessageBox( "Conferma","La stampa ha avuto esito positivo ?",Question!,YesNo!,1 )

	if li_msg = 1 then
		wf_commit_update_table(True)
	else	
		wf_commit_update_table(False)
	end if
	
end if	

return li_ret


end event

