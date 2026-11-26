forward
global type w_reg_iva_rpt from w_print_main
end type
end forward

global type w_reg_iva_rpt from w_print_main
int Height=1245
boolean TitleBar=true
string Title="Stampa Registro IVA"
end type
global w_reg_iva_rpt w_reg_iva_rpt

type variables
long il_id_esercizio
date il_data_da
date il_data_a
integer ii_tab_seq
integer ii_tab_seq_num
date il_data_da_esr
date il_data_a_esr
string is_tipo_reg


string			is_subreport


end variables

forward prototypes
public function integer wf_update_table ()
public function integer wf_commit_update_table (boolean ab_result)
end prototypes

public function integer wf_update_table ();
date			ld_da_data, ld_a_data,ld_data_fino
long			ll_num,ll_scode,ll_id_registro,ll_id_reg_pd
long			ll_row,ll_righe,ll_k,ll_i,ll_idregpd,ll_num_pro
string		ls_stampa_bollato,ls_stampa_mov,ls_tipo_reg,ls_num
string		ls_where,ls_sql,ls_sql_init
integer		li_ret
u_ds_main	lds_reg_pd
u_ds_main	lds_mov_iva
datawindow 	ldw_w

ldw_w = tab_1.tabpage_select.dw_selection

ld_da_data 	= ldw_w.GetItemDate(1, "dalla_data", Primary!, TRUE)
ld_a_data 	= ldw_w.GetItemDate(1, "alla_data", Primary!, TRUE)
ls_tipo_reg	= ldw_w.GetItemString(1, "tipo_registro", Primary!, TRUE)
ll_num_pro 	= ldw_w.GetItemNumber(1, "numero_registro", Primary!, TRUE)

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

ls_where 	= " ( reg_pd.id_azienda = 1 )" 
ls_where		+= " AND (Registro.Id_esercizio = " + string(il_id_esercizio) + " )" 

if not isNull(ls_tipo_reg) then
	ls_where 	= ls_where + " AND ( Registro.tipo_registro = '" + ls_tipo_reg + "' )"
end if	

if not isNull(ll_num_pro) and ll_num_pro  > 1 then
	ls_where 	= ls_where + " AND ( Registro.Numero = " + string(ll_num_pro) + " )"
end if

if not isNull(ld_da_data) then
	ls_where 	= ls_where + " AND ( Reg_PD.Data_Registrazione >= '" + string(ld_da_data, "yyyy-mm-dd") + "' )"
end if

if not isNull(ld_a_data) then
	ls_where 	= ls_where + " AND ( Reg_PD.Data_Registrazione <= '" + string(ld_a_data,"yyyy-mm-dd") + "' )"
end if	

ls_sql_init = lds_reg_pd.object.datawindow.table.select
lds_reg_pd.iu_scan.f_setinitial(ls_sql_init)
lds_reg_pd.iu_scan.f_reset_cur_as_ini()
lds_reg_pd.iu_scan.f_add_where_condition(ls_where)
ls_sql = lds_reg_pd.iu_scan.f_getcurrent()

lds_reg_pd.object.datawindow.table.select = ls_sql

ll_row = lds_reg_pd.Retrieve()
if ll_row >  0 then
	lds_reg_pd.SetRow(1)
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
					
					ls_stampa_mov = lds_mov_iva.GetItemString( ll_k,"mov_iva_st_reg_iva" )
					
					if ls_stampa_mov = "N" then
						
						
						lds_mov_iva.SetItem( ll_k,"mov_iva_st_reg_iva","I" )
						
						
						lds_mov_iva.SetItem( ll_k,"st_data_reg_iva",ld_data_fino )
						
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

destroy lds_reg_pd
destroy lds_mov_iva

return 0

end function

public function integer wf_commit_update_table (boolean ab_result);
date			ld_a_data,ld_da_data
long			ll_num,ll_scode,ll_id_registro,ll_id_reg_pd
long			ll_row,ll_righe,ll_k,ll_i,ll_idregpd,ll_num_pro
string		ls_stampa_bollato,ls_stampa_mov
string		ls_where,ls_sql,ls_sql_init,ls_tipo_reg
integer		li_ret
u_ds_main	lds_reg_pd
u_ds_main	lds_mov_iva
datawindow 	ldw_w

ldw_w = tab_1.tabpage_select.dw_selection

ld_a_data 	= ldw_w.GetItemDate(1, "alla_data", Primary!, TRUE)
ld_da_data	= ldw_w.GetItemDate(1, "dalla_data", Primary!, TRUE)
ls_tipo_reg	= ldw_w.GetItemString(1, "tipo_registro", Primary!, TRUE)
ll_num_pro 	= ldw_w.GetItemNumber(1, "numero_registro", Primary!, TRUE)


lds_reg_pd	= create u_ds_main
lds_mov_iva	= create u_ds_main
lds_reg_pd.DataObject	= "d_reg_pd_stampa_bollato_ds"
lds_mov_iva.DataObject	= "d_mov_iva_stampa_bollato_ds"
lds_reg_pd.SetTransObject(SQLCA)
lds_mov_iva.SetTransObject(SQLCA)

ls_where 	= " ( reg_pd.id_azienda = 1 ) AND (Registro.Id_esercizio = " + string(il_id_esercizio) + " )"

if not isNull(ls_tipo_reg) then
	ls_where 	= ls_where + " AND ( Registro.tipo_registro = '" + ls_tipo_reg + "' )"
end if	

if not isNull(ll_num_pro) and ll_num_pro  > 1 then
	ls_where 	= ls_where + " AND ( Registro.Numero = " + string(ll_num_pro) + " )"
end if

if not isNull(ld_da_data) then
	ls_where 	= ls_where + " AND ( Reg_PD.Data_Registrazione >= '" + string(ld_da_data, "yyyy-mm-dd") + "' )"
end if

if not isNull(ld_a_data) then
	ls_where 	= ls_where + " AND ( Reg_PD.Data_Registrazione <= '" + string(ld_a_data, "yyyy-mm-dd") + "' )"
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
		lds_reg_pd.SetRow(1)
		for ll_i = 1 to ll_row
			
			ls_stampa_bollato = lds_reg_pd.GetItemString( ll_i,"reg_pd_st_reg_iva" )
			
			if ls_stampa_bollato = "I" then
				
				
				lds_reg_pd.SetItem( ll_i,"reg_pd_st_reg_iva","S" )
								
				
				ll_idregpd	= lds_reg_pd.GetItemNumber( ll_i,"reg_pd_id_reg_pd" )
							
				
				ll_righe = lds_mov_iva.Retrieve(ll_idregpd)
				
				if ll_righe > 0 then
					
					for ll_k = 1 to ll_righe 
						
						ls_stampa_mov = lds_mov_iva.GetItemString( ll_k,"mov_iva_st_reg_iva" )
						
						if ls_stampa_mov = "I" then
							
							
							lds_mov_iva.SetItem( ll_k,"mov_iva_st_reg_iva","S" )
											
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
						
						ls_stampa_mov = lds_mov_iva.GetItemString( ll_k,"mov_iva_st_reg_iva" )
						
						if ls_stampa_mov = "I" then
							
							
							lds_mov_iva.SetItem( ll_k,"mov_iva_st_reg_iva","N" )
							lds_mov_iva.SetItem( ll_k,"st_data_reg_iva",u_freddie.gs_null )
														
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

event ue_post_open;call super::ue_post_open;date			ld_w
datawindow 	ldw_sel

ldw_sel = Tab_1.Tabpage_select.dw_selection

ii_tab_seq 		= Long(ldw_sel.Describe("dalla_data.TabSequence"))
ii_tab_seq_num = Long(ldw_sel.Describe("numero_registro.TabSequence"))

ldw_sel.TriggerEvent("ue_esrcz_azienda")
ldw_sel.TriggerEvent("ue_par_sis_data")
ld_w = RelativeDate(il_data_da, 365)
ldW_sel.SetItem(1, "alla_data", ld_w)

tab_1.tabpage_stampante.cb_printer_setup.Visible 	= FALSE
tab_1.tabpage_stampante.cb_salva_config.Visible 	= FALSE

if Lower(is_nome_report) = "txr_reg_iva.rpt" then
	is_subreport = "txs_riep_iva.rpt"
else
	if Lower(is_nome_report) = "st_reg_iva.rpt" then
		is_subreport = "st_riep_iva.rpt"
	else
		MessageBox( "Attenzione","Nome report non ammesso per questa finestra !!!",Information! )
	end if	
end if

return 0

end event

on w_reg_iva_rpt.create
call w_print_main::create
end on

on w_reg_iva_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da, ls_ad, ls_da_for, ls_ad_for,ls_da_data,ls_a_data
String	ls_rpt, ls_IA, ls_IV, ls_IC
String 	ls_statement, ls_statform[]
String	ls_id_es, ls_num, ls_tipo_reg
date		ld_da_data, ld_a_data
long		ll_num, ll_id_es, ll_w
integer  li_msg
datawindow ldw_w

ls_IA 		= "IVA Acquisti"
ls_IV 		= "IVA Vendite"
ls_IC 		= "IVA Corrispettivi"

ldw_w 		= tab_1.tabpage_select.dw_selection

ls_statement 	= "{reg_pd.id_azienda} = 1 "

ld_da_data	= ldw_w.GetItemDate(1, "dalla_data", Primary!, TRUE)
ld_a_data	= ldw_w.GetItemDate(1, "alla_data", Primary!, TRUE)

ls_id_es 		= String(il_id_esercizio)
ls_tipo_reg 	= ldw_w.GetItemString(1, "tipo_registro", Primary!, TRUE)
ll_w 				= ldw_w.GetItemNumber(1, "numero_registro", Primary!, TRUE)

if isNull(ll_w) then
	ll_w = 0
end if	
	
ls_num 			= String(ll_w)

if (IsNull(ls_tipo_reg) or (ls_tipo_reg = "")) then
	li_msg = MessageBox("Warning!", "TIPO REGISTRO NULLO = IVA VENDITE",  &
  			Exclamation!, OKCancel!, 2)
	if li_msg = 1 then 
		ls_tipo_reg = "IV"
	else
		return -1
	end if
end if

if not isNull(ld_da_data) and not isNull(ld_a_data) then
	if (DaysAfter(ld_da_data, ld_a_data) < 0) then
		li_msg = MessageBox("Warning!", "Date DA/A Errate",  &
					Exclamation!, OKCancel!, 2)
		if li_msg = 2 then
			return -1

		end if	
	end if
end if	

if not isNull(ld_da_data) and not isNull(il_data_da_esr) then
	if (DaysAfter(ld_da_data, il_data_da_esr) > 0) then
		li_msg = MessageBox("Warning!", "Data Inizio minore della Data Inizio Esercizio!",  &
				Exclamation!, OKCancel!, 2)
		if li_msg = 2 then
			return -1
		end if
	end if
end if	

if not isNull(ld_a_data) and not isNull(il_data_a_esr) then
	if (DaysAfter(ld_a_data, il_data_a_esr) < 0) then
		li_msg = MessageBox("Warning!", "Data Fine maggiore della Data Fine Esercizio!",  &
				Exclamation!, OKCancel!, 2)
		if li_msg = 2 then
			return -1
		end if
	end if
end if

ls_statement 	= ls_statement + " AND {Registro.Id_esercizio} = " + ls_id_es

if not isNull(ls_tipo_reg) then
	ls_statement 	= ls_statement + " AND {Registro.tipo_registro} = '" + ls_tipo_reg + "'"
end if	

if (IsNumber(ls_num) and (Long(ls_num) > 1)) then
	ls_statement 	= ls_statement + " AND {Registro.Numero} = " + ls_num 
end if

if not isNull(ld_da_data) then
	ls_statement 	= ls_statement + " AND {Reg_PD.Data_Registrazione} >= Date(" + string(ld_da_data, "yyyy, mm, dd") + ")"
end if

if not isNull(ld_a_data) then
	ls_statement 	= ls_statement + " AND {Reg_PD.Data_Registrazione} <= Date(" + string(ld_a_data, "yyyy, mm, dd") + ")"
end if	

is_selection = ls_statement

istr_formule[1].formula_name = "tipo_registro"
CHOOSE CASE ls_tipo_reg
	CASE "IA"
		ls_statform[1] = "'" + ls_IA + "'"
	CASE "IV"
		ls_statform[1] = "'" + ls_IV + "'"
	CASE "IC"
		ls_statform[1] = "'" + ls_IC + "'"	
END CHOOSE		

istr_formule[1].formula_string 	= ls_statform[1]

istr_formule[2].formula_name 		= "data"
ls_statform[2] 						= "'" + ls_da_for + " - " + ls_ad_for + "'"
istr_formule[2].formula_string 	= ls_statform[2]

istr_formule[3].formula_name 		= "dadata"
if isNull(ld_da_data) then
	ls_da_data = ""
else
	ls_da_data = string(ld_da_data)
end if	
istr_formule[3].formula_string 	= "'" + ls_da_data + "'"

istr_formule[4].formula_name 		= "adata"
if isNull(ld_a_data) then
	ls_a_data = ""
else
	ls_a_data = string(ld_a_data)
end if	
istr_formule[4].formula_string 	= "'" + ls_a_data + "'"

istr_sub_formule[1].s_subreport 				= is_subreport
istr_sub_formule[1].s_selection_formula 	= is_selection

RETURN 0



end event

type cb_esci from w_print_main`cb_esci within w_reg_iva_rpt
int X=1578
int Y=61
end type

type tab_1 from w_print_main`tab_1 within w_reg_iva_rpt
int Y=201
int Height=925
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=1765
int Height=797
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
event ue_par_sis_data ( )
event ue_esrcz_azienda ( )
event ue_esercizio ( )
event ue_tipo_reg ( )
event ue_num_reg ( )
event ue_ult_data ( )
int X=28
int Y=29
int Width=1692
int Height=741
string DataObject="d_reg_iva_rpt"
end type

event dw_selection::ue_par_sis_data;call super::ue_par_sis_data;date		ld_sis

SELECT par_sistema.ult_data_liquidazione
	INTO :ld_sis
	FROM par_sistema
	WHERE par_sistema.id_azienda = 1 USING SQLCA;
IF NOT(IsNull(ld_sis)) THEN	
	il_data_da = RelativeDate(ld_sis, 1)
	THIS.SetItem(1, "dalla_data", il_data_da)
ELSE
	il_data_da = il_data_da_esr
	THIS.SetItem(1, "dalla_data", il_data_da_esr)
	THIS.SetItem(1, "alla_data", il_data_a_esr)
END IF	
	
end event

event dw_selection::ue_esrcz_azienda;call super::ue_esrcz_azienda;long		ll_id
	
SELECT azienda.id_esercizio
	INTO :ll_id
	FROM azienda
	WHERE azienda.id_azienda = 1 
	USING SQLCA;
	
THIS.SetItem(1, "registro", ll_id)
il_id_esercizio = ll_id
THIS.TriggerEvent("ue_esercizio")

end event

event dw_selection::ue_esercizio;call super::ue_esercizio;date ld_da, ld_a

SELECT esercizio.data_inizio, esercizio.data_fine
	INTO	:ld_da, :ld_a
	FROM esercizio
	WHERE esercizio.id_esercizio = :il_id_esercizio
	USING SQLCA;
	
il_data_da_esr = ld_da
il_data_a_esr =  ld_a




end event

event dw_selection::ue_tipo_reg;call super::ue_tipo_reg;
long						ll_ret,ll_num
datawindowchild		ldw_child

SetNull(ll_num)

this.AcceptText()
this.GetChild("Numero_registro", ldw_child)
this.SetItem( this.GetRow(),"Numero_registro",ll_num )
ldw_child.SetTransObject(SQLCA)
ldw_child.Retrieve(is_tipo_reg, il_id_esercizio)




end event

event dw_selection::itemchanged;call super::itemchanged;CHOOSE CASE dwo.Name
	CASE "registro"
		il_id_esercizio = Long(data)
		THIS.TriggerEvent("ue_esercizio")
		THIS.TriggerEvent("ue_tipo_reg")
	CASE "tipo_registro"
		is_tipo_reg = data
		THIS.TriggerEvent("ue_tipo_reg")
	CASE "tutti_reg"
		THIS.Object.numero_registro.TabSequence = ii_tab_seq_num
		IF (data = "S") THEN
			THIS.Object.numero_registro.TabSequence = 0
			THIS.TriggerEvent("ue_num_reg")
		END IF
	CASE "elab_prova"
		THIS.Object.dalla_data.TabSequence = ii_tab_seq
		IF (data = "S") THEN
			THIS.Object.dalla_data.TabSequence = 0
			THIS.TriggerEvent("ue_par_sis_data")
		END IF
	CASE "dalla_data"
		il_data_da = Date(data)
	CASE "alla_data"
		il_data_a =  Date(data)
	CASE ELSE
END CHOOSE		
		
end event

event dw_selection::losefocus;call super::losefocus;THIS.AcceptText()
end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "registro"
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=1765
int Height=797
end type

type cb_salva_config from w_print_main`cb_salva_config within w_reg_iva_rpt
int X=1463
int Y=61
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=1765
int Height=797
end type

type st_4 from w_print_main`st_4 within tabpage_export
int X=5
int Y=29
end type

type cb_stampa from w_print_main`cb_stampa within w_reg_iva_rpt
int X=1303
int Y=61
end type

event cb_stampa::clicked;
integer	li_ret,li_msg
string	ls_def
long		ll_row
date 		ld_a_data

li_ret 	= 0
ll_row	= tab_1.tabpage_select.dw_selection.GetRow()
ls_def	= tab_1.tabpage_select.dw_selection.GetItemString(1,"elab_prova")
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
		
		if not isNull(ld_a_data) then
			update par_sistema
				set par_sistema.ult_data_liquidazione = :ld_a_data
				where par_sistema.id_azienda = 1 
				using SQLCA;
		
			if SQLCA.SQLNRows = 1 then
				commit using SQLCA ;
			end if	
		end if
		
	else	
		wf_commit_update_table(False)
	end if
	
end if	

return li_ret


end event

