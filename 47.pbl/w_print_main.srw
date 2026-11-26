forward
global type w_print_main from window
end type
type cb_esci from commandbutton within w_print_main
end type
type tab_1 from tab within w_print_main
end type
type tabpage_select from userobject within tab_1
end type
type dw_selection from u_dw_ext_main within tabpage_select
end type
type tabpage_select from userobject within tab_1
dw_selection dw_selection
end type
type tabpage_stampante from userobject within tab_1
end type
type ddlb_stampanti from dropdownlistbox within tabpage_stampante
end type
type cb_salva_config from commandbutton within tabpage_stampante
end type
type cb_printer_setup from commandbutton within tabpage_stampante
end type
type st_6 from statictext within tabpage_stampante
end type
type em_copie from editmask within tabpage_stampante
end type
type em_a_pagina from editmask within tabpage_stampante
end type
type em_da_pagina from editmask within tabpage_stampante
end type
type st_3 from statictext within tabpage_stampante
end type
type rb_page from radiobutton within tabpage_stampante
end type
type rb_all_page from radiobutton within tabpage_stampante
end type
type st_2 from statictext within tabpage_stampante
end type
type st_1 from statictext within tabpage_stampante
end type
type tabpage_stampante from userobject within tab_1
ddlb_stampanti ddlb_stampanti
cb_salva_config cb_salva_config
cb_printer_setup cb_printer_setup
st_6 st_6
em_copie em_copie
em_a_pagina em_a_pagina
em_da_pagina em_da_pagina
st_3 st_3
rb_page rb_page
rb_all_page rb_all_page
st_2 st_2
st_1 st_1
end type
type tabpage_export from userobject within tab_1
end type
type st_5 from statictext within tabpage_export
end type
type st_4 from statictext within tabpage_export
end type
type sle_field_name from singlelineedit within tabpage_export
end type
type ddplb_tipi_file from dropdownpicturelistbox within tabpage_export
end type
type tabpage_export from userobject within tab_1
st_5 st_5
st_4 st_4
sle_field_name sle_field_name
ddplb_tipi_file ddplb_tipi_file
end type
type tab_1 from tab within w_print_main
tabpage_select tabpage_select
tabpage_stampante tabpage_stampante
tabpage_export tabpage_export
end type
type rb_export from radiobutton within w_print_main
end type
type rb_video from radiobutton within w_print_main
end type
type rb_stampante from radiobutton within w_print_main
end type
type cb_stampa from commandbutton within w_print_main
end type
type gb_output from groupbox within w_print_main
end type
end forward

global type w_print_main from window
integer x = 640
integer y = 272
integer width = 1870
integer height = 1168
windowtype windowtype = child!
long backcolor = 79741120
event type integer ue_post_open ( )
event type integer ue_pre_print ( )
event ue_pre_open ( )
event type integer ue_initvar ( )
event ue_help ( helpcommand ae_hcom,  long al_helpid,  string as_helpkey )
event ue_comment ( )
cb_esci cb_esci
tab_1 tab_1
rb_export rb_export
rb_video rb_video
rb_stampante rb_stampante
cb_stampa cb_stampa
gb_output gb_output
end type
global w_print_main w_print_main

type variables
uo_msg_log	iuo_msg_log
s_variabili_stampa	istr_variabili
string 		is_drop_column[]
s_coddes_rpt	istr_coddes_rpt

boolean		ib_openok = True
boolean		ib_change_page = False
long		il_HelpTopic
string		is_HelpKey
string		is_Password
string		is_Serialize
string		is_wintype

integer		ii_find_profilo              
integer		ii_view = 1
integer		ii_sort_field_n
integer		ii_sort_field_direction	
string		is_title
string		is_directory_report
string		is_nome_report
string		is_selection
string		is_group
string		is_sort_field_name
		   

s_formula		istr_formule[]
s_sub_formula	istr_sub_formule[]

end variables

forward prototypes
public function string wf_find_export_string (integer ai_export_type)
public function integer wf_find_export_type ()
public subroutine wf_update_profilo ()
public function integer wf_print ()
public subroutine wf_select_profilo (integer ai_p_id_utenti, string as_p_nome_report)
public function integer wf_set_printer_info ()
public function integer wf_get_printer_info ()
public subroutine wf_converti_per_pb (ref string as_selezione)
end prototypes

event ue_post_open;
integer utente
utente = u_freddie.s_utenti.i_idutente
wf_select_profilo( utente,is_nome_report )
return 0
end event

event ue_pre_print;
return 0
end event

event ue_help;if ae_Hcom = Keyword! then
	ShowHelp(u_freddie.is_helpfile, Keyword!, as_HelpKey)
else
	if ae_Hcom = Topic! then
		ShowHelp(u_freddie.is_helpfile, Topic!, al_HelpId)
	end if
end if

end event

public function string wf_find_export_string (integer ai_export_type);CHOOSE CASE ai_export_type
	CASE 0
		return "Record"
	CASE 2
		return "Text"
	CASE 3
		return "DIF"
	CASE 4
		return "CSV"
	CASE 7
		return "Crystal Report RPT"
	CASE 5
		return "Separatori Caratteri"
	CASE 6
		return "Separatori Tab"
	CASE 1
		return "Separatori Tab Text"
	CASE 8
	  	return "Excel 2.1"
	CASE 9
		return "Excel 3"
	CASE 10
		return "Excel 4"
	CASE 19
		return "Excel 5"
	CASE 14
		return "Quattro Pro 5.0 WB1 16 bit"
	CASE 15
		return "RTF"
	CASE 16
		return "Word per ODS"
	CASE 17
		return "Word per Windows"
	CASE 18
		return "WordPerfect 16 bit"
	CASE 21
		return "HTML Microsoft IS"
	CASE 23
		return "HTML Netscape"
	CASE 29
		return "HTML 3"
	CASE 30
		return "POWER BUILDER"
END CHOOSE

return ""

end function

public function integer wf_find_export_type ();
string ls_Tipo

ls_Tipo = tab_1.tabpage_export.ddplb_tipi_file.Text

if ls_Tipo = 'Record' then
	return 0
elseif ls_tipo ='Text' then
	return 2
elseif ls_tipo ='DIF' then
	return 3
elseif ls_tipo ='CSV' then
	return 4
elseif ls_tipo =	'RTF' then
	return 15
elseif ls_tipo = 'Crystal Report RPT' then
	return 7
elseif ls_tipo = 'Separatori Caratteri' then
	return 5
elseif ls_tipo = 'Separatori Tab' then
	return 1
elseif ls_tipo = 'Separatori Tab Text' then
	return 6
elseif ls_tipo = 'Excel 2.1' then
	return 8
elseif ls_tipo = 'Excel 3' then
	return 9
elseif ls_tipo = 'Excel 4' then
	return 10
elseif ls_tipo = 'Excel 5' then
	return 19
elseif ls_tipo = 'Quattro Pro 5.0 WB1 16 bit' then
	return 14
elseif ls_tipo = 'Word per ODS' then
	return 16
elseif ls_tipo = 'Word per Windows' then
	return 17
elseif ls_tipo = 'WordPerfect 16 bit' then
	return 18
elseif ls_tipo = 'HTML Microsoft IS' then
	return 21
elseif ls_tipo = 'HTML Netscape' then
	return 23
elseif ls_tipo = 'HTML 3' then
	return 20
end if
	

return 0
end function

public subroutine wf_update_profilo ();

String  ls_all_page
String  ls_stampante
String  ls_destinazione
String  ls_nome_file
integer li_copie
integer li_da_pagina
integer li_a_pagina
integer li_id_utente
integer li_formato

if rb_stampante.Checked = true then
	ls_destinazione 	= 'S'
else
	if rb_video.Checked = true then
		ls_destinazione 	= 'V'
	end if	
end if

ls_stampante 		= tab_1.tabpage_stampante.ddlb_stampanti.Text
li_copie 			= integer(tab_1.tabpage_stampante.em_copie.Text)
li_da_pagina 		= integer(tab_1.tabpage_stampante.em_da_pagina.Text)
li_a_pagina			= integer(tab_1.tabpage_stampante.em_a_pagina.Text)

if tab_1.tabpage_stampante.rb_all_page.Checked = true then
	ls_all_page 		= 'S'
else
   ls_all_page 		= 'N'
end if	

ls_nome_file 		= tab_1.tabpage_export.sle_field_name.Text
li_id_utente 		= u_freddie.s_utenti.i_idutente
li_formato 			= wf_find_export_type()


if ii_find_profilo = 0 then	
	
	
	update dba.profilo_stampa
		set destinazione		= :ls_destinazione
		,stampante 				= :ls_stampante
		,numero_copie			= :li_copie
		,stampa_tutto			= :ls_all_page
		,da_pagina				= :li_da_pagina
		,a_pagina				= :li_a_pagina
		,nome_file_stampa 	= :ls_nome_file
		,formato_file_stampa = :li_formato
		where id_utenti 		= :li_id_utente
		and nome_report 		= :is_nome_report;
	
	   if sqlca.sqlcode <> 0 then
			MessageBox("Errore","Update Profilo")
		end if
		
else
	if ii_find_profilo > 0 then	
		insert into dba.profilo_stampa
			(id_utenti, nome_report, destinazione, stampante, numero_copie,
			da_pagina, a_pagina, nome_file_stampa, formato_file_stampa)
			values
			(:li_id_utente,:is_nome_report,:ls_destinazione, :ls_stampante,
				:li_copie,:li_da_pagina,:li_a_pagina,:ls_nome_file,:li_formato);
			
		if sqlca.sqlcode <> 0 then
			MessageBox("Errore", string(sqlca.sqlerrtext))
		end if
	end if	
		
end if

end subroutine

public function integer wf_print ();

integer	li_hwin
integer	li_output
integer	li_da
integer	li_a
integer	li_copie
integer  li_val
long		ll_idx,ll_i,ll_ret
pointer  lp_oldpointer  



lp_oldpointer = SetPointer(HourGlass!)


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

	
	SELECT par_sistema.dir_report INTO :is_directory_report
	FROM dba.par_sistema WHERE par_sistema.id_azienda = 1 ;	
  
	ll_ret = SQLCA.SQLCode
	if ll_ret = 0 then
  
  		li_val = this.event ue_pre_print()
		 
		if li_val = -1 then
			SetPointer(lp_oldpointer)
			return 1
		end if         

		
		wf_set_printer_info()
	

//		u_freddie.iuo_stampa.of_set_Selection_Formula( is_selection )	
		
//		u_freddie.iuo_stampa.of_set_Group_Selection_Formula( is_group )
//		u_freddie.iuo_stampa.of_set_Formula( istr_formule )	
//		u_freddie.iuo_stampa.of_set_subreport( istr_sub_formule )	
										
//		u_freddie.iuo_stampa.of_set_order( ii_sort_field_n,is_sort_field_name,ii_sort_field_direction )
//		u_freddie.iuo_stampa.of_set_title( istr_coddes_rpt.titolo_finestra )
		
		if ii_view = 0 or ii_view = 1 then
//			u_freddie.iuo_stampa.of_set_view( ii_view )      
		end if	


//		if upper(right(is_nome_report, 3))<>'RPT' then
			

//  		u_freddie.iuo_stampa.of_stampa( li_hwin,li_output,li_da,li_a,li_copie,is_directory_report,is_nome_report )
		
		
	   
	else
		if ll_ret = 100 then
			MessageBox( "Errore","Fallito select dei parametri di sistema",StopSign! )
		else
			MessageBox( "Errore","Nessun record selezionato",StopSign! )
		end if
	end if	

end if

SetPointer(lp_oldpointer)

return 0
end function

public subroutine wf_select_profilo (integer ai_p_id_utenti, string as_p_nome_report);

select destinazione, stampante, numero_copie,
	stampa_tutto, da_pagina, a_pagina, nome_file_stampa, formato_file_stampa
	into :istr_variabili.s_destinazione, :istr_variabili.s_stampante,:istr_variabili.i_numero_copie, 
	:istr_variabili.s_stampa_tutto,:istr_variabili.i_da_pagina, :istr_variabili.i_a_pagina,:istr_variabili.s_nome_file_stampa, 
	:istr_variabili.i_formato_file_stampa from dba.profilo_stampa
	where id_utenti = :ai_p_id_utenti and nome_report = :as_p_nome_report;

if sqlca.sqlcode = 100 then
	
	select destinazione, stampante, numero_copie,
		stampa_tutto, da_pagina, a_pagina, nome_file_stampa, formato_file_stampa
		into :istr_variabili.s_destinazione, :istr_variabili.s_stampante,:istr_variabili.i_numero_copie, 
		:istr_variabili.s_stampa_tutto,:istr_variabili.i_da_pagina, :istr_variabili.i_a_pagina,:istr_variabili.s_nome_file_stampa, 
		:istr_variabili.i_formato_file_stampa from dba.profilo_stampa
		where nome_report = :as_p_nome_report;

	
	if sqlca.sqlcode = 100 then
		ii_find_profilo = 1
	else
		
		if sqlca.sqlcode <> 0 then
			ii_find_profilo = -1
		end if	
	end if		
	
else
	
	if sqlca.sqlcode <> 0 then
		ii_find_profilo = -1
	else
	
		ii_find_profilo = 0	
	end if
end if

if ii_find_profilo = 0 then

	tab_1.tabpage_stampante.ddlb_stampanti.Text = istr_variabili.s_stampante
	
	if istr_variabili.s_stampa_tutto = "S" then
		tab_1.tabpage_stampante.rb_all_page.Checked	= True
		tab_1.tabpage_stampante.rb_page.Checked		= False
	else
		tab_1.tabpage_stampante.rb_all_page.Checked	= False
		tab_1.tabpage_stampante.rb_page.Checked		= True
	end if	
	
	if istr_variabili.s_destinazione = "S" then
		rb_stampante.Checked	= True
	else
		rb_video.Checked	= False
	end if	
		
	tab_1.tabpage_stampante.em_copie.Text 		 = String(istr_variabili.i_numero_copie)
	tab_1.tabpage_stampante.em_da_pagina.Text  = String(istr_variabili.i_da_pagina)
	tab_1.tabpage_stampante.em_a_pagina.Text   = String(istr_variabili.i_a_pagina)
	tab_1.tabpage_export.sle_field_name.Text   = String(istr_variabili.s_nome_file_stampa)
	tab_1.tabpage_export.ddplb_tipi_file.Text  = wf_find_export_string(istr_variabili.i_formato_file_stampa)

end if

end subroutine

public function integer wf_set_printer_info ();

long		ll_size,ll_i		 
integer	li_rtn,li_count
string	ls_subkeylist[]
string   ls_regKey,ls_value
string   ls_driver_name,ls_printer_name,ls_port_name

ls_regKey	= "HKEY_LOCAL_MACHINE\System\CurrentControlSet\control\Print\Printers"


if RegistryKeys( ls_regKey,ls_subkeylist ) = -1 then
	MessageBox( "Errore","Errore nel leggere il registry",StopSign! )
	return 0
end if

ll_size = UpperBound( ls_subkeylist )
if ll_size > 0 then
	
	for ll_i = 1 to ll_size 
		
		if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_value ) = -1 then
			MessageBox( "Errore","Reading Subkey value",StopSign! )
		end if	
		
		if ls_value = tab_1.tabpage_stampante.ddlb_stampanti.Text then
			
			if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_printer_name ) = -1 then
				MessageBox( "Errore","Reading Subkey value",StopSign! )
			end if	

			if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Printer Driver",ls_driver_name ) = -1 then
				MessageBox( "Errore","Reading Subkey value",StopSign! )
			end if	
			
			if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Port",ls_port_name ) = -1 then
				MessageBox( "Errore","Reading Subkey value",StopSign! )
			end if	
			
//			u_freddie.iuo_stampa.of_set_printer_info( ls_driver_name,ls_printer_name,ls_port_name )
			
			return 0
			
		end if	
	next	
end if	

return 0
end function

public function integer wf_get_printer_info ();
char		lc_array[], lc_temp[]	
long		ll_size,ll_i		
integer	li_rtn,li_count, li_env
string	ls_subkeylist[]
string   ls_regKey,ls_value,ls_default,ls_temp,ls_devices[]

environment env
li_env = GetEnvironment(env)

if li_env <> 1 then return 1

ls_regKey	= "HKEY_LOCAL_MACHINE\System\CurrentControlSet\control\Print\Printers"

choose case env.OsType
	case Windows!
		ls_default	= "HKEY_CURRENT_CONFIG\System\CurrentControlSet\Control\Print\Printers"		
	case WindowsNT!
		ls_default	= "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows"		
end choose	

		
if RegistryKeys( ls_regKey,ls_subkeylist ) = -1 then
	MessageBox( "Errore","Errore nel leggere il registry",StopSign! )
	return 1
end if

ll_size = UpperBound( ls_subkeylist )
if ll_size > 0 then
	
	if ll_size > 1 then
		this.tab_1.tabpage_stampante.ddlb_stampanti.Reset()
	end if	
	
	for ll_i = 1 to ll_size 
		if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_value ) = -1 then
			MessageBox( "Errore","Reading Subkey value",StopSign! )
			return 1
		end if	
		
		if this.tab_1.tabpage_stampante.ddlb_stampanti.AddItem( ls_value ) = -1 then
			MessageBox( "Errore","Adding item error",StopSign! )
			return 1
		end if	
	next	
end if	


choose case env.OsType
			
	case Windows!
		if RegistryGet( ls_default,"Default",ls_value ) = -1 then
			MessageBox( "Errore","Reading Subkey value",StopSign! )
			return 1
		end if	

		this.tab_1.tabpage_stampante.ddlb_stampanti.Text = ls_value
			
	case WindowsNT!
		if RegistryValues( ls_default + "Device",ls_devices ) = -1 then
			MessageBox( "Errore","Reading Subkey value",StopSign! )
			return 1
		end if	

		lc_array = ls_devices
		ll_i = 1
		do
			lc_temp[ll_i] = lc_array[ll_i]
			ll_i++
	   loop while lc_array[ll_i] <> ','			
		ls_value = lc_temp
		
		this.tab_1.tabpage_stampante.ddlb_stampanti.Text = ls_value

end choose		

return 0

end function

public subroutine wf_converti_per_pb (ref string as_selezione);long ll_pos=1
string ls_data

//messagebox("inizio", as_selezione)
ll_pos=pos(as_selezione, "{", ll_pos)
do  while ll_pos > 0
	as_selezione=Replace (as_selezione, ll_pos, 1, "(")
	ll_pos=pos(as_selezione, "{", ll_pos)
loop 
ll_pos=1
ll_pos=pos(as_selezione, "}", ll_pos)
do  while ll_pos > 0
	as_selezione=Replace (as_selezione, ll_pos, 1, ")")
	ll_pos=pos(as_selezione, "}", ll_pos)
loop  
ll_pos=1   //date (2006, 01, 01)
ll_pos=pos(as_selezione, "Date (", ll_pos)
do  while ll_pos > 0
	ls_data=mid(as_selezione, ll_pos, 19)
	ls_data="Date ('"+mid(ls_data,  7,4)+"/"+mid(ls_data, 13, 2)+"/"+mid(ls_data, 17,2)+"')"
	as_selezione=Replace (as_selezione, ll_pos, 19, ls_data)
	ll_pos=pos(as_selezione, "Date (", ll_pos+1)
	ls_data=""
loop  
//messagebox("fine", as_selezione)
end subroutine

on w_print_main.create
this.cb_esci=create cb_esci
this.tab_1=create tab_1
this.rb_export=create rb_export
this.rb_video=create rb_video
this.rb_stampante=create rb_stampante
this.cb_stampa=create cb_stampa
this.gb_output=create gb_output
this.Control[]={this.cb_esci,&
this.tab_1,&
this.rb_export,&
this.rb_video,&
this.rb_stampante,&
this.cb_stampa,&
this.gb_output}
end on

on w_print_main.destroy
destroy(this.cb_esci)
destroy(this.tab_1)
destroy(this.rb_export)
destroy(this.rb_video)
destroy(this.rb_stampante)
destroy(this.cb_stampa)
destroy(this.gb_output)
end on

event open;
long		ll_id_par_stampa
string	ls_titolo_finestra,ls_tipo_serve,ls_no_param,ls_use_completa_semplificata

ll_id_par_stampa		= Message.DoubleParm

ii_find_profilo		= 0
is_directory_report 	= ""
is_nome_report			= ""
is_group 				= ""
is_selection			= ""

if isNull(ll_id_par_stampa) then
	Close(This)
end if

SELECT "par_stampa"."titolo_finestra","par_stampa"."nome_report","par_stampa"."nome_campo_db_cod", &
       "par_stampa"."nome_campo_db_des","par_stampa"."nome_campo_instampa", &
		 "par_stampa"."nome_dddw_sl","par_stampa"."nome_dddw_codice","par_stampa"."nome_dddw_descrizione", &
		 "par_stampa"."tipo_serve","par_stampa"."no_param","par_stampa"."use_completa_semplificata"
	INTO	:istr_coddes_rpt.titolo_finestra,:istr_coddes_rpt.nome_report,:istr_coddes_rpt.nome_campo_db_cod, &
			:istr_coddes_rpt.nome_campo_db_des,:istr_coddes_rpt.nome_campo_instampa, &
			:istr_coddes_rpt.nome_dddw_sl,:istr_coddes_rpt.nome_dddw_codice,:istr_coddes_rpt.nome_dddw_descrizione, &
			:ls_tipo_serve,:ls_no_param,:ls_use_completa_semplificata
	FROM "dba"."par_stampa"   
	WHERE "par_stampa"."id_par_stampa" = :ll_id_par_stampa
	USING SQLCA;

if SQLCA.SQLCode = 100 then
	MessageBox("Parametri di Stampa","Id non trovato")
	Close(This)
else
	if SQLCA.SQLCode = -1 then
		MessageBox("Database Error " + string(SQLCA.SQLDBCode),SQLCA.SQLErrText, Exclamation!)
		Close(This)
	end if	
end if

if ls_tipo_serve = 'N' then
	istr_coddes_rpt.tipo_serve = False
else
	istr_coddes_rpt.tipo_serve = True
end if

if ls_no_param = 'N' then
	istr_coddes_rpt.no_param = False
else
	istr_coddes_rpt.no_param = True
end if

if ls_use_completa_semplificata = 'N' then
	istr_coddes_rpt.use_completa_semplificata = False
else	
	istr_coddes_rpt.use_completa_semplificata = True
end if	

is_wintype = "W_PRINT_MAIN"	

u_freddie.center_window(this)

This.TriggerEvent("ue_initvar")

ib_openok = f_check_serial(is_serialize)

if ib_openok then
	ib_openok = f_check_win_password(is_password)
end if

if ib_openok then
	iuo_msg_log = create uo_msg_log
	iuo_msg_log.uf_new_text("Sessione del " + String(Today()) + " - " + String(Now()),2)


	is_nome_report			= istr_coddes_rpt.nome_report

	this.triggerEvent( "ue_pre_open" )


   
	
	
	Tab_1.Tabpage_select.dw_selection.event ue_insert()
	Tab_1.Tabpage_select.dw_selection.event ue_set_drop()

	this.triggerEvent( "ue_post_open" )
	
else
	Close(This)
end if




end event

event close;

SetNull(u_freddie.iudw_current)
If IsValid(iuo_msg_log) then
	
	iuo_msg_log.uf_new_text("",1)
	destroy iuo_msg_log
end if

end event

event activate;

If IsValid(iuo_msg_log) then
	iuo_msg_log.uf_catch_msg()
end if

end event

event deactivate;
SetNull(u_freddie.iw_current)

If IsValid(iuo_msg_log) then
	iuo_msg_log.uf_leave_msg()
end if

end event

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			This.Event ue_help(Topic!, il_HelpTopic, "")
		end if
end choose
end event

type cb_esci from commandbutton within w_print_main
integer x = 1445
integer y = 68
integer width = 229
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Esci"
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_print_main
integer x = 23
integer y = 180
integer width = 1801
integer height = 884
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_select tabpage_select
tabpage_stampante tabpage_stampante
tabpage_export tabpage_export
end type

on tab_1.create
this.tabpage_select=create tabpage_select
this.tabpage_stampante=create tabpage_stampante
this.tabpage_export=create tabpage_export
this.Control[]={this.tabpage_select,&
this.tabpage_stampante,&
this.tabpage_export}
end on

on tab_1.destroy
destroy(this.tabpage_select)
destroy(this.tabpage_stampante)
destroy(this.tabpage_export)
end on

event selectionchanged;


choose case newindex 
		
	case 1
		
	case 2	
		if	ib_change_page = false then
			wf_get_printer_info()
			ib_change_page = true
		end if	
		
		if tabpage_stampante.rb_all_page.Checked = true then
			tabpage_stampante.em_da_pagina.Enabled = false
			tabpage_stampante.em_a_pagina.Enabled = false
		end if 	
		
end choose

return 0

end event

type tabpage_select from userobject within tab_1
integer x = 18
integer y = 112
integer width = 1765
integer height = 756
long backcolor = 79741120
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Preview!"
long picturemaskcolor = 553648127
string powertiptext = "Inserimento PArametri di Selezione "
dw_selection dw_selection
end type

on tabpage_select.create
this.dw_selection=create dw_selection
this.Control[]={this.dw_selection}
end on

on tabpage_select.destroy
destroy(this.dw_selection)
end on

type dw_selection from u_dw_ext_main within tabpage_select
event type integer ue_set_drop ( )
integer x = 50
integer y = 44
integer width = 1664
integer height = 660
integer taborder = 2
end type

event ue_set_drop;call super::ue_set_drop;
DataWindowChild	ldw_c_drop

integer	li_size,li_counter
integer  li_trans,li_ret,li_retv,li_child

li_retv = 0

li_size = UpperBound( is_drop_column )

if li_size > 0 then
	for li_counter = 1 to li_size
		
		li_child = this.GetChild ( is_drop_column[li_counter],ldw_c_drop )
	
		if li_child = -1 then
			MessageBox( "Error","GetChild Error",StopSign! )
			li_retv = -1
		end if	
	
		li_trans = ldw_c_drop.SetTransObject(SQLCA)
	
		if li_trans = -1 then
			MessageBox( "Transaction error","SetTransObject Error",StopSign! )
			li_retv = -1
		end if	
	
		li_ret = ldw_c_drop.Retrieve ()
	
		if li_ret = -1 then
			MessageBox( "Retrieve error","Retrieve Error",StopSign! )
			li_retv = -1
   	end if

	next
end if	

return li_ret
end event

event constructor;call super::constructor;
return 0
end event

type tabpage_stampante from userobject within tab_1
integer x = 18
integer y = 112
integer width = 1765
integer height = 756
long backcolor = 79741120
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Report5!"
long picturemaskcolor = 553648127
string powertiptext = "Settaggio Stampante e Stampa"
ddlb_stampanti ddlb_stampanti
cb_salva_config cb_salva_config
cb_printer_setup cb_printer_setup
st_6 st_6
em_copie em_copie
em_a_pagina em_a_pagina
em_da_pagina em_da_pagina
st_3 st_3
rb_page rb_page
rb_all_page rb_all_page
st_2 st_2
st_1 st_1
end type

on tabpage_stampante.create
this.ddlb_stampanti=create ddlb_stampanti
this.cb_salva_config=create cb_salva_config
this.cb_printer_setup=create cb_printer_setup
this.st_6=create st_6
this.em_copie=create em_copie
this.em_a_pagina=create em_a_pagina
this.em_da_pagina=create em_da_pagina
this.st_3=create st_3
this.rb_page=create rb_page
this.rb_all_page=create rb_all_page
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.ddlb_stampanti,&
this.cb_salva_config,&
this.cb_printer_setup,&
this.st_6,&
this.em_copie,&
this.em_a_pagina,&
this.em_da_pagina,&
this.st_3,&
this.rb_page,&
this.rb_all_page,&
this.st_2,&
this.st_1}
end on

on tabpage_stampante.destroy
destroy(this.ddlb_stampanti)
destroy(this.cb_salva_config)
destroy(this.cb_printer_setup)
destroy(this.st_6)
destroy(this.em_copie)
destroy(this.em_a_pagina)
destroy(this.em_da_pagina)
destroy(this.st_3)
destroy(this.rb_page)
destroy(this.rb_all_page)
destroy(this.st_2)
destroy(this.st_1)
end on

type ddlb_stampanti from dropdownlistbox within tabpage_stampante
integer x = 530
integer y = 88
integer width = 937
integer height = 420
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_salva_config from commandbutton within tabpage_stampante
integer x = 1239
integer y = 428
integer width = 229
integer height = 80
integer taborder = 44
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S&ave"
end type

event clicked;
wf_update_profilo()
return 0


end event

type cb_printer_setup from commandbutton within tabpage_stampante
integer x = 1239
integer y = 188
integer width = 229
integer height = 80
integer taborder = 43
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Setup"
end type

event clicked;string	ls_printer_name
//u_freddie.iuo_stampa.of_setup_printer()
//ls_printer_name	= u_freddie.iuo_stampa.of_get_dev_printer_name()
if ls_printer_name <> "" then
	ddlb_stampanti.Text	= ls_printer_name
end if



end event

type st_6 from statictext within tabpage_stampante
integer x = 896
integer y = 432
integer width = 50
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "a"
boolean focusrectangle = false
end type

type em_copie from editmask within tabpage_stampante
integer x = 530
integer y = 196
integer width = 233
integer height = 76
integer taborder = 41
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = "Ä"
end type

type em_a_pagina from editmask within tabpage_stampante
integer x = 965
integer y = 424
integer width = 233
integer height = 76
integer taborder = 42
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "999"
borderstyle borderstyle = stylelowered!
string mask = "#####"
string displaydata = ""
end type

type em_da_pagina from editmask within tabpage_stampante
integer x = 530
integer y = 428
integer width = 233
integer height = 76
integer taborder = 41
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#####"
string displaydata = "ô"
end type

type st_3 from statictext within tabpage_stampante
integer x = 430
integer y = 428
integer width = 96
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "da"
boolean focusrectangle = false
end type

type rb_page from radiobutton within tabpage_stampante
integer x = 73
integer y = 428
integer width = 288
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Pagine"
end type

event clicked;em_da_pagina.Enabled = true
em_a_pagina.Enabled = true
end event

type rb_all_page from radiobutton within tabpage_stampante
integer x = 73
integer y = 348
integer width = 503
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Tutte le Pagine"
boolean checked = true
end type

event clicked;em_da_pagina.Enabled = false
em_a_pagina.Enabled = false
end event

type st_2 from statictext within tabpage_stampante
integer x = 114
integer y = 196
integer width = 398
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Numero Copie"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_stampante
integer x = 114
integer y = 100
integer width = 398
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Stampante"
alignment alignment = right!
boolean focusrectangle = false
end type

type tabpage_export from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 1765
integer height = 756
long backcolor = 79741120
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom008!"
long picturemaskcolor = 553648127
string powertiptext = "Formato Esportazione e nome File"
st_5 st_5
st_4 st_4
sle_field_name sle_field_name
ddplb_tipi_file ddplb_tipi_file
end type

on tabpage_export.create
this.st_5=create st_5
this.st_4=create st_4
this.sle_field_name=create sle_field_name
this.ddplb_tipi_file=create ddplb_tipi_file
this.Control[]={this.st_5,&
this.st_4,&
this.sle_field_name,&
this.ddplb_tipi_file}
end on

on tabpage_export.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_field_name)
destroy(this.ddplb_tipi_file)
end on

type st_5 from statictext within tabpage_export
integer x = 9
integer y = 160
integer width = 352
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Formato File"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_export
integer x = 9
integer y = 44
integer width = 352
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Nome File"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_field_name from singlelineedit within tabpage_export
integer x = 389
integer y = 36
integer width = 1225
integer height = 80
integer taborder = 21
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type ddplb_tipi_file from dropdownpicturelistbox within tabpage_export
integer x = 389
integer y = 132
integer width = 1230
integer height = 612
integer taborder = 31
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean vscrollbar = true
string item[] = {"Crystal Report","Power Builder"}
integer itempictureindex[] = {1,2}
string picturename[] = {"Custom039!"}
long picturemaskcolor = 536870912
end type

type rb_export from radiobutton within w_print_main
boolean visible = false
integer x = 626
integer y = 44
integer width = 238
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "E&xport"
end type

type rb_video from radiobutton within w_print_main
integer x = 389
integer y = 76
integer width = 238
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "&Video"
end type

type rb_stampante from radiobutton within w_print_main
integer x = 55
integer y = 76
integer width = 393
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "&Stampante"
end type

type cb_stampa from commandbutton within w_print_main
integer x = 1184
integer y = 68
integer width = 229
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stam&pa"
end type

event clicked;integer li_ret
long ll_id_conf_oggetti, ll_id_documento
s_crea_dw s_par_dw

s_par_dw.ls_dw_sintax=is_nome_report



select id_conf_oggetti
into :ll_id_conf_oggetti
from conf_oggetti
where codice=:s_par_dw.ls_dw_sintax;


if ll_id_conf_oggetti>0 then
	tab_1.tabpage_select.dw_selection.AcceptText()
	parent.event ue_pre_print()
	wf_converti_per_PB(is_selection)
	s_par_dw.s_selezione=is_selection
	openwithparm(w_st_pb, s_par_dw)
else
	li_ret = wf_print()
	
end if

return 0
end event

type gb_output from groupbox within w_print_main
integer x = 27
integer y = 12
integer width = 640
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
end type

