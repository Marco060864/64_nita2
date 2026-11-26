forward
global type w_libro_giornale_rpt from w_print_main
end type
end forward

global type w_libro_giornale_rpt from w_print_main
int Width=1793
int Height=969
boolean TitleBar=true
string Title="Stampa Libro Giornale"
end type
global w_libro_giornale_rpt w_libro_giornale_rpt

type variables
integer 		ii_tab_seq_pro
integer 		ii_tab_seq_dat
long 		il_id_esercizio
long 		il_num_pro
date 		id_ult_dat
long		il_ultimo_progressivo


end variables

forward prototypes
public function integer wf_update_table ()
public function integer wf_commit_update_table (boolean ab_result)
end prototypes

public function integer wf_update_table ();
date			ld_da_data, ld_a_data,ld_data_fino
long			ll_num,ll_scode,ll_id_registro,ll_id_reg_pd
long			ll_row,ll_righe,ll_k,ll_i,ll_idregpd
string		ls_stampa_bollato,ls_stampa_mov
string		ls_where,ls_sql,ls_sql_init
integer		li_ret
u_ds_main	lds_reg_pd
u_ds_main	lds_mov_con
datawindow 	ldw_w

ldw_w = tab_1.tabpage_select.dw_selection

ld_da_data 	= ldw_w.GetItemDate(1, "ult_data", Primary!, TRUE)
ld_a_data 	= ldw_w.GetItemDate(1, "fino_data", Primary!, TRUE)

ld_data_fino	= ld_a_data

ll_num = ldw_w.GetItemNumber(1, "ult_progress", Primary!, TRUE)
if isNull(ll_num) then
	ll_num = 0
end if
ll_num++ 



lds_reg_pd	= create u_ds_main
lds_mov_con	= create u_ds_main

lds_reg_pd.DataObject	= "d_reg_pd_stampa_bollato_ds"
lds_mov_con.DataObject	= "d_mov_cont_stampa_bollato_ds"

ls_where	= "( Reg_PD.azienda = 1 ) "

if not isNull(ld_da_data) then
	ls_where = ls_where + " AND ( Reg_PD.Data_Registrazione >= '" + string(ld_da_data, "yyyy-mm-dd") + "' )"
end if

if not isNull(ld_a_data) then
	ls_where = ls_where + " AND ( Reg_PD.Data_Registrazione <= '" + string(ld_a_data, "yyyy-mm-dd") + "' )"
end if	

ls_sql_init = lds_reg_pd.object.datawindow.table.select
lds_reg_pd.iu_scan.f_setinitial(ls_sql_init)
lds_reg_pd.iu_scan.f_reset_cur_as_ini()
lds_reg_pd.iu_scan.f_add_where_condition(ls_where)
ls_sql = lds_reg_pd.iu_scan.f_getcurrent()

lds_reg_pd.object.datawindow.table.select = ls_sql

lds_reg_pd.SetTransObject(SQLCA)
ll_row = lds_reg_pd.Retrieve()

if ll_row >  0 then
	lds_reg_pd.SetRow(1)
	for ll_i = 1 to ll_row
		
		ls_stampa_bollato = lds_reg_pd.GetItemString( ll_i,"reg_pd_st_stampa_bollato" )
		
		if ls_stampa_bollato = "N" then
			
			
			lds_reg_pd.SetItem( ll_i,"reg_pd_st_stampa_bollato","I" )
			
			if not isNull(ld_data_fino) then
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_data_bollato",ld_data_fino )
			end if	
			
			
			ll_idregpd	= lds_reg_pd.GetItemNumber( ll_i,"reg_pd_id_reg_pd" )
						
			lds_mov_con.SetTransObject(SQLCA)
			
			
			ll_righe = lds_mov_con.Retrieve(ll_idregpd)
			
			if ll_righe > 0 then
				
				for ll_k = 1 to ll_righe 
					
					ls_stampa_mov = lds_mov_con.GetItemString( ll_k,"mov_contabile_st_stampa_bollato" )
					
					if ls_stampa_mov = "N" then
						
						
						lds_mov_con.SetItem( ll_k,"mov_contabile_st_stampa_bollato","I" )
						
						lds_mov_con.SetItem( ll_k,"mov_contabile_st_data_bollato",ld_data_fino )
						
						
						lds_mov_con.SetItem( ll_k,"mov_contabile_prog_stampato",ll_num )
						
						il_ultimo_progressivo = ll_num
						
						ll_num++					
						
					end if	
					
				next	
				
				
				li_ret = lds_mov_con.Update()
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

destroy lds_reg_pd
destroy lds_mov_con

return 0

end function

public function integer wf_commit_update_table (boolean ab_result);
date			ld_da_data, ld_a_data
long			ll_num,ll_scode,ll_id_registro,ll_id_reg_pd
long			ll_row,ll_righe,ll_k,ll_i,ll_idregpd
string		ls_stampa_bollato,ls_stampa_mov
string		ls_where,ls_sql,ls_sql_init
integer		li_ret
u_ds_main	lds_reg_pd
u_ds_main	lds_mov_con
datawindow 	ldw_w

ldw_w = tab_1.tabpage_select.dw_selection

ld_da_data 	= ldw_w.GetItemDate(1, "ult_data", Primary!, TRUE)
ld_a_data 	= ldw_w.GetItemDate(1, "fino_data", Primary!, TRUE)

ll_num = ldw_w.GetItemNumber(1, "ult_progress", Primary!, TRUE)
if isNull(ll_num) then
	ll_num = 0
end if


lds_reg_pd	= create u_ds_main
lds_mov_con	= create u_ds_main
lds_reg_pd.DataObject	= "d_reg_pd_stampa_bollato_ds"
lds_mov_con.DataObject	= "d_mov_cont_stampa_bollato_ds"
lds_reg_pd.SetTransObject(SQLCA)
lds_mov_con.SetTransObject(SQLCA)

ls_where	= "( Reg_PD.azienda = 1 ) "

if not isNull(ld_da_data) then
	ls_where = ls_where + " AND ( Reg_PD.Data_Registrazione >= '" + string(ld_da_data, "yyyy-mm-dd") + "' )"
end if

if not isNull(ld_a_data) then
	ls_where = ls_where + " AND ( Reg_PD.Data_Registrazione <= '" + string(ld_a_data, "yyyy-mm-dd") + "' )"
end if	

ls_sql_init = lds_reg_pd.object.datawindow.table.select
lds_reg_pd.iu_scan.f_setinitial(ls_sql_init)
lds_reg_pd.iu_scan.f_reset_cur_as_ini()
lds_reg_pd.iu_scan.f_add_where_condition(ls_where)
ls_sql = lds_reg_pd.iu_scan.f_getcurrent()

lds_reg_pd.object.datawindow.table.select = ls_sql


ll_row = lds_reg_pd.Retrieve()

if ab_result = True then
	
	ll_row = lds_reg_pd.Retrieve()
	
	if ll_row >  0 then
		lds_reg_pd.SetRow(1)
		for ll_i = 1 to ll_row
			
			ls_stampa_bollato = lds_reg_pd.GetItemString( ll_i,"reg_pd_st_stampa_bollato" )
			
			if ls_stampa_bollato = "I" then
				
				
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_stampa_bollato","S" )
				
				
				ll_idregpd	= lds_reg_pd.GetItemNumber( ll_i,"reg_pd_id_reg_pd" )
				
				
				ll_righe = lds_mov_con.Retrieve(ll_idregpd)
				
				if ll_righe > 0 then
					
					for ll_k = 1 to ll_righe 
						
						ls_stampa_mov = lds_mov_con.GetItemString( ll_k,"mov_contabile_st_stampa_bollato" )
						
						if ls_stampa_mov = "I" then
							
							
							lds_mov_con.SetItem( ll_k,"mov_contabile_st_stampa_bollato","S" )
							
							
							
							
							
							
							
						end if	
						
					next	
					
					
					li_ret = lds_mov_con.Update()
					if li_ret = -1 then
						MessageBox( "Update Error","Errore nel tentativo di aggiornare il database",StopSign! )
					end if		
					
					if li_ret = 1 then
						commit using SQLCA;
					else
						rollback using SQLCA;
					end if
					
				end if
				
				
				li_ret = lds_reg_pd.Update()
				if li_ret = -1 then
					MessageBox( "Update Error","Errore nel tentativo di aggiornare il database",StopSign! )
				end if
				
				if li_ret = 1 then
					commit using SQLCA;
				else
					rollback using SQLCA;
				end if
				
			end if	
		next	
		update "dba"."esercizio"
			set "esercizio"."num_progressivo" = il_ultimo_progressivo
			where "dba"."id_esercizio" = il_id_esercizio
			using SQLCA;
			
		if SQLCA.SQLCode = 0 then
			commit using SQLCA;
		else
			rollback using SQLCA;
		end if
		
	end if	
else
	SetNull(ll_num)
	
	lds_reg_pd.SetTransObject(SQLCA)
	ll_row = lds_reg_pd.Retrieve()
	if ll_row >  0 then
		for ll_i = 1 to ll_row
			
			ls_stampa_bollato = lds_reg_pd.GetItemString( ll_i,"reg_pd_st_stampa_bollato" )
			
			if ls_stampa_bollato = "I" then
				
				
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_stampa_bollato","N" )
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_data_bollato",u_freddie.gs_null )
				
				
				ll_idregpd	= lds_reg_pd.GetItemNumber( ll_i,"reg_pd_id_reg_pd" )
							
				lds_mov_con.SetTransObject(SQLCA)
				
				
				ll_righe = lds_mov_con.Retrieve(ll_idregpd)
				
				if ll_righe > 0 then
					
					for ll_k = 1 to ll_righe 
						
						ls_stampa_mov = lds_mov_con.GetItemString( ll_k,"mov_contabile_st_stampa_bollato" )
						
						if ls_stampa_mov = "I" then
							
							
							lds_mov_con.SetItem( ll_k,"mov_contabile_st_stampa_bollato","N" )
							lds_mov_con.SetItem( ll_k,"mov_contabile_st_data_bollato",u_freddie.gs_null )
							
							lds_mov_con.SetItem( ll_k,"mov_contabile_prog_stampato",ll_num )
														
						end if	
						
					next	
					
					
					li_ret = lds_mov_con.Update()
					if li_ret = -1 then
						MessageBox( "Update Error","Errore nel tentativo di aggiornare il database",StopSign! )
					end if	
					
					if li_ret = 1 then
						commit using SQLCA;
					else
						rollback using SQLCA;
					end if
					
				end if
				
				
				li_ret = lds_reg_pd.Update()
				if li_ret = -1 then
					MessageBox( "Update Error","Errore nel tentativo di aggiornare il database",StopSign! )
				end if
				
				if li_ret = 1 then
					commit using SQLCA;
				else
					rollback using SQLCA;
				end if
				
			end if	
		next	
	end if	
end if

destroy lds_reg_pd
destroy lds_mov_con

return 0

end function

on w_libro_giornale_rpt.create
call w_print_main::create
end on

on w_libro_giornale_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;

String	ls_da, ls_ad
String	ls_rpt, ls_IA, ls_IV, ls_IC
String 	ls_statement, ar_codice, ar_instampa
String	ls_id_es, ls_num, ls_tipo_reg, ls_day, ls_month, ls_year
date		ld_da_data, ld_a_data
long		ll_num, ll_id_es, ll_w
integer  li_msg
datawindow ldw_w

ldw_w = tab_1.tabpage_select.dw_selection

ls_statement  = "{reg_pd.id_azienda} = 1"

ld_da_data 	= ldw_w.GetItemDate(1, "ult_data", Primary!, TRUE)
ld_a_data 	= ldw_w.GetItemDate(1, "fino_data", Primary!, TRUE)

if isNull(ld_a_data) then
	MessageBox( "Attenzione","E' necessario inserire una data di fine periodo",StopSign! )
	return -1 
end if	

if not isNull(ld_da_data) and not isNull( ld_a_data) then
	if (DaysAfter(ld_da_data, ld_a_data) < 0) then
		li_msg = MessageBox("Warning!", "Data DA maggiore di data A ,continuare ?",Exclamation!, OKCancel!, 2)
		return -1
	end if	
end if

ll_num = ldw_w.GetItemNumber(1, "ult_progress", Primary!, TRUE)
if isNull(ll_num) then
	ll_num = 0
end if	

ls_statement = ls_statement + " AND {Registro.tipo_registro} IN ['IV','IC','IA','PN']"

if not isNull(ld_da_data) then
	ls_statement = ls_statement + " AND {Reg_PD.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
end if

if not isNull(ld_a_data) then
	ls_statement = ls_statement + " AND {Reg_PD.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
end if	

is_selection = ls_statement


messagebox ('mes', is_selection)

RETURN 0

end event

event open;call super::open;

datawindow ldw_sel
ldw_sel = Tab_1.Tabpage_select.dw_selection
ii_tab_seq_pro = Long(ldw_sel.Describe("ult_progressivo.TabSequence"))
ii_tab_seq_dat = Long(ldw_sel.Describe("ult_data.TabSequence"))
ldw_sel.TriggerEvent("ue_esercizio_def")

end event

type cb_esci from w_print_main`cb_esci within w_libro_giornale_rpt
int X=1486
int Y=61
end type

type tab_1 from w_print_main`tab_1 within w_libro_giornale_rpt
int Y=201
int Width=1738
int Height=641
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=1701
int Height=513
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
event ue_esercizio ( )
event ue_esercizio_def ( )
int X=28
int Y=37
int Width=1623
int Height=429
string DataObject="d_libro_giornale_rpt"
end type

event dw_selection::ue_esercizio;call super::ue_esercizio;
long		ll_num_pro
date 		ld_ult_dat

select esercizio.num_progressivo, esercizio.ult_data_stampa_bollato
	into	:ll_num_pro, :ld_ult_dat
	from esercizio
	where esercizio.id_esercizio = :il_id_esercizio
	using SQLCA;
	
this.SetItem(1, "ult_progress", ll_num_pro)
this.SetItem(1, "ult_data", ld_ult_dat)
il_num_pro =  ll_num_pro
id_ult_dat = ld_ult_dat
	




end event

event dw_selection::ue_esercizio_def;call super::ue_esercizio_def;
long		ll_id

select azienda.id_esercizio
	into :ll_id
	from azienda
	where azienda.id_azienda = 1 using SQLCA;
	
this.SetItem(1, "esercizio", ll_id)
il_id_esercizio = ll_id
this.TriggerEvent("ue_esercizio")

	
	




end event

event dw_selection::losefocus;call super::losefocus;THIS.AcceptText()
end event

event dw_selection::itemchanged;call super::itemchanged;CHOOSE CASE dwo.Name
	CASE "esercizio"
		il_id_esercizio = Long(data)
		THIS.TriggerEvent("ue_esercizio")
	CASE ELSE
END CHOOSE		
		
end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "esercizio"

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=1701
int Height=513
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=1701
int Height=513
end type

event rb_video::clicked;call super::clicked;
long		ll_row
ll_row	= tab_1.tabpage_select.dw_selection.GetRow()

tab_1.tabpage_select.dw_selection.SetItem(ll_row,"ela_def",'N')
tab_1.tabpage_select.dw_selection.object.ela_def.protect = 1
end event

event rb_stampante::clicked;call super::clicked;
tab_1.tabpage_select.dw_selection.object.ela_def.protect = 0
end event

type cb_stampa from w_print_main`cb_stampa within w_libro_giornale_rpt
int X=1212
int Y=61
end type

event cb_stampa::clicked;
integer	li_ret,li_msg
string	ls_def
long		ll_row

li_ret 	= 0
ll_row	= tab_1.tabpage_select.dw_selection.GetRow()
ls_def	= tab_1.tabpage_select.dw_selection.GetItemString(1,"ela_def")


if ls_def = "S" then
	li_ret = wf_update_table()  
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

