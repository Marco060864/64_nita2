forward
global type w_st_prov_def_wz from window
end type
type pb_1 from picturebutton within w_st_prov_def_wz
end type
type pb_excel from picturebutton within w_st_prov_def_wz
end type
type dw_3 from udw_000 within w_st_prov_def_wz
end type
type st_3 from statictext within w_st_prov_def_wz
end type
type cb_salva_excel from commandbutton within w_st_prov_def_wz
end type
type cb_mail_old from commandbutton within w_st_prov_def_wz
end type
type cb_new_pec from commandbutton within w_st_prov_def_wz
end type
type cb_mail_new from commandbutton within w_st_prov_def_wz
end type
type rb_1 from radiobutton within w_st_prov_def_wz
end type
type cbx_importo from checkbox within w_st_prov_def_wz
end type
type dw_uc from udw_base within w_st_prov_def_wz
end type
type dw_art from udw_base within w_st_prov_def_wz
end type
type cb_1 from commandbutton within w_st_prov_def_wz
end type
type cbx_brogliaccio from checkbox within w_st_prov_def_wz
end type
type cbx_prezzo from checkbox within w_st_prov_def_wz
end type
type sle_report from singlelineedit within w_st_prov_def_wz
end type
type dw_2 from datawindow within w_st_prov_def_wz
end type
type rb_mail from radiobutton within w_st_prov_def_wz
end type
type st_1 from statictext within w_st_prov_def_wz
end type
type em_copie from editmask within w_st_prov_def_wz
end type
type cbx_sintetica from checkbox within w_st_prov_def_wz
end type
type ddlb_stampante from dropdownlistbox within w_st_prov_def_wz
end type
type st_stampante from statictext within w_st_prov_def_wz
end type
type rb_video from radiobutton within w_st_prov_def_wz
end type
type rb_stampa from radiobutton within w_st_prov_def_wz
end type
type rb_def from radiobutton within w_st_prov_def_wz
end type
type rb_prov from radiobutton within w_st_prov_def_wz
end type
type cb_stampa from commandbutton within w_st_prov_def_wz
end type
type cb_annulla from commandbutton within w_st_prov_def_wz
end type
type gb_stvi from groupbox within w_st_prov_def_wz
end type
type cb_old_pec from commandbutton within w_st_prov_def_wz
end type
type cb_printer_setup from commandbutton within w_st_prov_def_wz
end type
type st_2 from statictext within w_st_prov_def_wz
end type
type gb_1 from groupbox within w_st_prov_def_wz
end type
type dw_1 from udw_base within w_st_prov_def_wz
end type
type cbx_galvanica from checkbox within w_st_prov_def_wz
end type
type gb_provdef from groupbox within w_st_prov_def_wz
end type
end forward

global type w_st_prov_def_wz from window
integer x = 832
integer y = 364
integer width = 1998
integer height = 1736
boolean titlebar = true
string title = "Wizard Stampe"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
string icon = "AppIcon!"
pb_1 pb_1
pb_excel pb_excel
dw_3 dw_3
st_3 st_3
cb_salva_excel cb_salva_excel
cb_mail_old cb_mail_old
cb_new_pec cb_new_pec
cb_mail_new cb_mail_new
rb_1 rb_1
cbx_importo cbx_importo
dw_uc dw_uc
dw_art dw_art
cb_1 cb_1
cbx_brogliaccio cbx_brogliaccio
cbx_prezzo cbx_prezzo
sle_report sle_report
dw_2 dw_2
rb_mail rb_mail
st_1 st_1
em_copie em_copie
cbx_sintetica cbx_sintetica
ddlb_stampante ddlb_stampante
st_stampante st_stampante
rb_video rb_video
rb_stampa rb_stampa
rb_def rb_def
rb_prov rb_prov
cb_stampa cb_stampa
cb_annulla cb_annulla
gb_stvi gb_stvi
cb_old_pec cb_old_pec
cb_printer_setup cb_printer_setup
st_2 st_2
gb_1 gb_1
dw_1 dw_1
cbx_galvanica cbx_galvanica
gb_provdef gb_provdef
end type
global w_st_prov_def_wz w_st_prov_def_wz

type variables
long		il_ret_code
long		il_stvi 
long		il_prov_def
integer		ii_find_profilo
integer		ii_id_utente
string		is_nome_report, ls_allegati
long                         il_id_doc
u_dw_master_main idw_riga	, idw_gen

end variables

forward prototypes
public function integer wf_get_printer_info ()
public function integer wf_set_printer_info ()
public subroutine wf_select_profilo (integer ai_p_id_utenti, string as_p_nome_report)
public subroutine wf_update_profilo ()
public function string wf_trova_broadgun ()
public subroutine wf_invia_mail ()
public function string wf_estrai_nome_file (string as_path)
public function string wf_controlla_nome_file (string as_nome_file)
public subroutine wf_stampa_brogliaccio (long al_id_doc, string as_flag)
public subroutine wf_allega_file_doc ()
public subroutine wf_new_invia_mail ()
public subroutine wf_mailsend (string as_tipo_mail)
public subroutine wf_stampa_pdf (integer ai_ordinamento)
end prototypes

public function integer wf_get_printer_info ();
char		lc_array[], lc_temp[]	
long		ll_size,ll_i		
integer	li_rtn,li_count, li_env
string	ls_subkeylist[]
string   ls_regKey,ls_value,ls_default,ls_temp

environment env
li_env = GetEnvironment(env)

if li_env <> 1 then return 1

ls_regKey	= "HKEY_LOCAL_MACHINE\System\CurrentControlSet\control\Print\Printers"

choose case env.OsType
	case Windows!
		ls_default	= "HKEY_CURRENT_CONFIG\System\CurrentControlSet\Control\Print\Printers"		
	case WindowsNT!
		ls_default	= "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows"  //"HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PrinterPorts"
		
end choose	

		
if RegistryKeys( ls_regKey,ls_subkeylist ) = -1 then
	MessageBox( "Errore","Errore nel leggere il registry",StopSign! )
	return 1
end if

ll_size = UpperBound( ls_subkeylist )
if ll_size > 0 then
	
	if ll_size > 1 then
		this.ddlb_stampante.Reset()
	end if	
	
	for ll_i = 1 to ll_size 
		if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_value ) = -1 then
			//MessageBox( "scorro stampanti","Reading Subkey value:"+ ls_value,StopSign! )
			//MessageBox( "Errore","Reading Subkey value",StopSign! )
			//return 1
		end if	
		
		if this.ddlb_stampante.AddItem( ls_value ) = -1 then
			MessageBox( "Errore","Adding item error",StopSign! )
			return 1
		end if	
	next	
end if	


choose case env.OsType
			
	case Windows!
		if RegistryGet( ls_default,"Default",ls_value ) = -1 then
			MessageBox( "Errore","Reading Subkey value WINDOWS98",StopSign! )
			return 1
		end if	

		ddlb_stampante.Text = ls_value
			
	case WindowsNT!
		if RegistryGet( ls_default,"Device",ls_value ) = -1 then
			MessageBox( "Errore","Reading Subkey value:"+ ls_value,StopSign! )
			return 1
		end if	

		lc_array = ls_value
		ll_i = 1
		do
			lc_temp[ll_i] = lc_array[ll_i]
			ll_i++
	   loop while lc_array[ll_i] <> ','			
		ls_value = lc_temp
		ddlb_stampante.Text = ls_value

end choose		

return 0
end function

public function integer wf_set_printer_info ();
long ll_id_sog_com, ll_num_prog, ll_id_reg
string ls_tipo_reg, ls_test, ls_cod_prof, ls_num_doc, ls_nome_file, ls_des, ls_art_mancanti
datetime ld_a_data
date ldt_data_doc
s_crea_dw s_dati_doc
long ll_id_prof_doc, ll_id_doc, ll_id_ana
datastore ds_stampa
string ls_printer, dwsyntax, ls_path_libreria, ls_return,ls_ordina
integer li_num_copie, li_ret

select codice, libreria
into :ls_test, :ls_path_libreria
from conf_oggetti
where codice= :is_nome_report;
if upper(ls_test)=upper(is_nome_report) then
	
	select data_documento, id_sog_commerciale, id_prof_documento
	into :ldt_data_doc, :ll_id_sog_com, :ll_id_prof_doc
	from dba.documento
	where id_documento=:il_id_doc;
	is_nome_report=f_scegli_report(il_id_doc, is_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc)
	
//se è karizia e rbol e > 31-12-2018  16-7-2018 devo cambiare report da cambiare la data con quella per partire
//	select data_documento, id_sog_commerciale, id_prof_documento
//	into :ldt_data_doc, :ll_id_sog_com, :ll_id_prof_doc
//	from dba.documento
//	where id_documento=:il_id_doc;
	
//	ldt_data_doc=ds_stampa.getitemdate(1, "documento_data_documento") 
//is_nome_report=f_scegli_report(il_id_doc, is_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc)
//	if ldt_data_doc>= date("2018/12/31") and  ldt_data_doc<= date("2021/02/01") and ll_id_sog_com=43 and upper(is_nome_report)='D_DDT_RBOL' and ll_id_prof_doc=66 then
//		is_nome_report+="167"
//	elseif 	 ldt_data_doc>= date("2021/06/14") and ll_id_sog_com=43 and upper(is_nome_report)='D_DDT_RBOL' and ll_id_prof_doc=66 then
//		is_nome_report+="167" //aggiunto il 11/06/2021
//	elseif ldt_data_doc>= date("2018/12/31") and ll_id_sog_com=43 and upper(is_nome_report)='D_DDT_RBOL' and &
//			(ll_id_prof_doc=114 or ll_id_prof_doc=150) then
//			is_nome_report+="167"
//	end if
	
	if rb_stampa.checked then
		printsetup()
		dwsyntax = LibraryExport(ls_path_libreria, is_nome_report, ExportDataWindow!)
		IF dwsyntax>"" THEN
			ds_stampa=create datastore
			ds_stampa.create(dwsyntax)
			ds_stampa.settransobject(sqlca)
			ds_stampa.Modify("dw_galv.visible=true")
			ds_stampa.retrieve(il_id_doc)
			
			select tipo_registro
			into :ls_tipo_reg
			from dba.registro r, dba.documento d
			where id_documento=:il_id_doc
			and d.id_registro=r.id_registro;
			
			if ls_tipo_reg='IV' then
				//21032017 dich intento nuova
				if ldt_data_doc>= date("2017/03/01") then //upper(is_nome_report)="D_FATTURA_S2" then
					ll_id_ana=ds_stampa.getitemnumber(1, "id_anagrafica")
					
					ls_return="Operazione non imponibile ai sensi dello Art. 8 2° C. D.P.R. 633 del 26/10/72 e modifiche successive  come  da Vs. dichiarazione di intento N. "&
					+f_dich_intento_2017(ll_id_ana, ldt_data_doc, " ", il_id_doc)
					ds_stampa.modify("t_dich_intento.text='"+ls_return+"'")
				end if
				//21032017 fine
			end if
			
			//090712 per samy: inserisco eventuali articoli mancanti al completamento del pronto
			ls_art_mancanti=f_controlla_pronto(il_id_doc)
			if ls_art_mancanti>" " then
				ds_stampa.modify("t_art_mancanti.text='"+ls_art_mancanti+"'")
			end if
			//fine 090712 per samy
			//per samy  //20241014 aggiunto d_fattura_vfat per mostrare anche lì la galvanbica
			if (upper(is_nome_report)="D_FATTURA_S2" or upper(is_nome_report)="D_DDT_RBOL167" or upper(is_nome_report)="D_DDT_RBOL0302" or upper(is_nome_report)="D_FATTURA_VFAT") and cbx_galvanica.checked then
				//vuol vedere lo specchietto galvanica in fattura
				ds_stampa.Modify("dw_galv.visible=true")
				ds_stampa.retrieve(il_id_doc)
			else
				ds_stampa.Modify("dw_galv.visible=false")
			end if
			//fine 28 02 1019
			li_num_copie=integer(em_copie.text)
			if li_num_copie<=0 or isnull(li_num_copie) then li_num_copie=1
			ds_stampa.Modify("DataWindow.Print.copies = "+ string(li_num_copie))	
			if cbx_prezzo.checked then
				ds_stampa.Modify("c_prezzo.visible =0 ")
				ds_stampa.Modify("riga_documento_tot_riga_val_doc.visible =0 ")	
			else
				ds_stampa.Modify("c_prezzo.visible =1 ")
				ds_stampa.Modify("riga_documento_tot_riga_val_doc.visible =1 ")
			end if
			if cbx_importo.checked then
				ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
				ds_stampa.modify("riga_documento_prezzo_metallo.visible=0")
			else
				ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=1")
				ds_stampa.modify("riga_documento_prezzo_metallo.visible=1")
			end if
		else
			messagebox("Errore!", "Dw di stampa "+is_nome_report+" non trovata!")
			return -1	
		end if
		//ordino secondo il flag impostato nella finestra 13/10/2021 richiesta Samy per Karizia
		ls_ordina=dw_3.getitemstring(1, "ordina") 
		if ls_ordina= "C" then  //20220823 Samy vuole su richiesta Karizia ordine anche per data_scadenza e pacco
			ds_stampa.setsort("c_ordina_per_cliente, data_prev_consegna_1, c_num_pacco, riga_documento_id_riga_documento")
			ds_stampa.sort()
			// 20250626 sulle NC e ND se si scegli "A" metti in ordine per id_articolo
		elseif ls_ordina = "A" then
			ds_stampa.setsort("riga_documento_id_articolo, data_prev_consegna_1, c_num_pacco, riga_documento_id_riga_documento")
			ds_stampa.sort()
		end if
		ds_stampa.print()
		destroy(ds_stampa)
		//28-04-2016
		if cbx_brogliaccio.checked then
			wf_stampa_brogliaccio(il_id_doc, "STAMPA")
		end if
		//fine 28-04-2016
		return -1
//	elseif rb_mail.checked then
//			dwsyntax = LibraryExport(ls_path_libreria, is_nome_report, ExportDataWindow!)
//			IF dwsyntax>"" THEN
//				ds_stampa=create datastore
//				ds_stampa.create(dwsyntax)
//				ds_stampa.settransobject(sqlca)
//				ds_stampa.retrieve(il_id_doc)
//				//090712 per samy: inserisco eventuali articoli mancanti al completamento del pronto
//				ls_art_mancanti=f_controlla_pronto(il_id_doc)
//				if ls_art_mancanti>" " then
//					ds_stampa.modify("t_art_mancanti.text='"+ls_art_mancanti+"'")
//				end if
//				//fine 090712 per samy
//			else
//				messagebox("Errore!", "Dw di stampa "+is_nome_report+" non trovata!")
//				return -1	
//			end if
//			select p.codice, d.num_documento, d.data_documento
//			into :ls_cod_prof, :ls_num_doc, :ldt_data_doc
//			from prof_documento p, documento d
//			where d.id_prof_documento=p.id_prof_documento
//			and d.id_documento=:il_id_doc;
//			
//			select dir_output
//			into :ls_nome_file
//			from orafo_par_sistema;
//			if isnull(ls_nome_file) or ls_nome_file="" then
//				messagebox("Attenzione!", "Specificare la directory di output nei parametri di sistema!")
//				return -1
//			end if
//			if right(ls_nome_file, 1)<>"\" then ls_nome_file+="\"
//			ls_nome_file+=ls_cod_prof+ls_num_doc+".pdf"
//			ls_test=ds_stampa.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
//			if cbx_prezzo.checked then
//				ds_stampa.Modify("c_prezzo.visible =0 ")
//			end if
//			
//			
//			if ls_test="" then 
//				
//
//				li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
//				//ds_stampa.Modify("DataWindow.Print.printername = 'Acrobat PDFWriter'")
//				//ds_stampa.print()
//				wf_crea_mail(ls_nome_file, ls_cod_prof+" n. "+ls_num_doc+" del "+string(ldt_data_doc))
//			else
//				messagebox("Errore!", "File PDF non generato!")	
//			end if
//			destroy(ds_stampa)
//			return -100
	else
		s_dati_doc.ls_dw_sintax=lower(is_nome_report)
		s_dati_doc.ll_id_doc=il_id_doc
		if cbx_prezzo.checked then
			s_dati_doc.s_selezione="NO PREZZO"
		end if
		if cbx_importo.checked then
			s_dati_doc.s_selezione+=" |NO IMPORTO"
		end if
		if cbx_galvanica.checked then
			s_dati_doc.s_selezione+=" - VEDI GALV"
		end if
			//ordino secondo il flag impostato nella finestra 13/10/2021 richiesta Samy per Karizia
		s_dati_doc.s_ordina= dw_3.getitemstring(1, "ordina")
		
		openwithparm(w_catalogo_foto, s_dati_doc)
		return -1
	end if
end if

if upper(is_nome_report)='ORDINE_FO' then
	openwithparm(w_stampa_doc_bolla, il_id_doc)
	return -1
end if





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
		
		if ls_value = this.ddlb_stampante.Text then
			
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

public subroutine wf_select_profilo (integer ai_p_id_utenti, string as_p_nome_report);

string ls_destinazione,ls_stampante
decimal {0} ld_numero_copie

select destinazione, stampante, numero_copie
	into :ls_destinazione, :ls_stampante, :ld_numero_copie
	from dba.profilo_stampa
	where id_utenti = :ai_p_id_utenti and nome_report = :as_p_nome_report;

if sqlca.sqlcode = 100 then
	select destinazione, stampante, numero_copie
		into :ls_destinazione, :ls_stampante, :ld_numero_copie
		from dba.profilo_stampa
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

	if ls_destinazione = "S" then
		rb_stampa.Checked	= True
		rb_video.Checked	= False
		rb_stampa.triggerevent("clicked")
	else
		rb_stampa.Checked	= False
		rb_video.Checked	= True
	end if	

	ddlb_stampante.Text = ls_stampante
	em_copie.text=string(ld_numero_copie)
	
end if

end subroutine

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

if rb_stampa.Checked = true then
	ls_destinazione 	= 'S'
else
	if rb_video.Checked = true then
		ls_destinazione 	= 'V'
	end if	
end if

ls_stampante 		= ddlb_stampante.Text
li_copie 			= 3
li_da_pagina 		= 0
li_a_pagina			= 0

ls_all_page 		= 'S'

ls_nome_file 		= ""
li_id_utente 		= ii_id_utente
li_formato 			= 0


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
		where id_utenti 		= :li_id_utente and nome_report = :is_nome_report;
	
	   if sqlca.sqlcode <> 0 then
			MessageBox("Errore","Update Profilo")
			ROLLBACK;
		ELSE
			commit;
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
			MessageBox("Errore","Update Profilo")
			ROLLBACK;
		ELSE
			commit;
		end if
		
		
	end if	
		
end if

end subroutine

public function string wf_trova_broadgun ();string ls_regkey, ls_value,ls_subkeylist[]
integer ll_size, ll_i
string ls_printer_name, ls_driver_name, ls_port_name
ls_regKey	= "HKEY_LOCAL_MACHINE\System\CurrentControlSet\control\Print\Printers"


if RegistryKeys( ls_regKey, ls_subkeylist ) = -1 then
	MessageBox( "Errore","Errore nel leggere il registry",StopSign! )
	return ""
end if

ll_size = UpperBound( ls_subkeylist )
for ll_i = 1 to ll_size 
	
	if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_value ) = -1 then
		MessageBox( "Errore","Reading Subkey value",StopSign! )
	end if	
	if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Printer Driver",ls_driver_name ) = -1 then
		MessageBox( "Errore","Reading Subkey value",StopSign! )
	end if	
	if ls_driver_name = "BroadGun pdfMachine" then
		if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_printer_name ) = -1 then
			MessageBox( "Errore","Reading Subkey value",StopSign! )
		end if	
		return ls_printer_name
	end if	
next	
return ""
end function

public subroutine wf_invia_mail ();string ls_indirizzo_e_mail, ls_stampato, ls_mail_cc, ls_data
long ll_righe
integer i, a,li_pos, b
date ldt_data
string ls_allegati[],ls_allegato, ls_tipo_reg
w_orafo_documento_ordine_cx w_doc

dw_1.accepttext()

mailsession lms_sess
mailmessage lm_mess
mailrecipient lm_recipient, lm_recipient2, lm_recipient3
mailFileDescription lmf_file
mailreturncode lmc_rc


ls_allegato=dw_1.getitemstring(1, "allegati")
a=1
li_pos=pos(ls_allegato, ";",a )
if li_pos=0 then 
	ls_allegati[1]=ls_allegato
else
	do while li_pos >0 or len(ls_allegato) > a
		b++
		if li_pos=0 then 
			li_pos=len(ls_allegati[b - 1]) +1
			ls_allegati[b]=mid(ls_allegato, a, li_pos - 1)
			exit
		end if
		ls_allegati[b]=mid(ls_allegato, a, li_pos - a)	
		a=li_pos+1
		li_pos=pos(ls_allegato, ";",a )
	loop
end if
a=0
for a=1 to upperbound(ls_allegati)
	lmf_file.FileType = mailAttach!
		
	lmf_file.PathName = ls_allegati[a]//dw_1.getitemstring(1, "allegati")
	lmf_file.FileName = wf_estrai_nome_file(lmf_file.PathName)
		
	lm_mess.Attachmentfile[a] = lmf_file
next

lm_mess.NoteText = dw_1.getitemstring(1, "testo")
lm_mess.Subject = dw_1.getitemstring(1, "oggetto")
ls_indirizzo_e_mail=dw_1.getitemstring(1, "destinatario")
	
lm_recipient.Address = ls_indirizzo_e_mail
lm_recipient.Name = ls_indirizzo_e_mail
lm_recipient.RecipientType = mailTo!
lm_mess.Recipient[1] = lm_recipient


ls_mail_cc=dw_1.getitemstring(1, "cc")
if ls_mail_cc>" " then
	lm_recipient2.Address = ls_mail_cc
	lm_recipient2.Name = ls_mail_cc
	lm_recipient2.RecipientType = mailCC!
	lm_mess.Recipient[2] = lm_recipient2
end if	

ls_mail_cc=dw_1.getitemstring(1, "cc_2")
if ls_mail_cc>" " then
	lm_recipient3.Address = ls_mail_cc
	lm_recipient3.Name = ls_mail_cc
	lm_recipient3.RecipientType = mailCC!
	lm_mess.Recipient[3] = lm_recipient3
end if	



lms_sess = create mailsession
lmc_rc = lms_Sess.mailLogon()


lmc_rc = lms_Sess.mailSend(lm_mess)
IF lmc_rc <> mailReturnSuccess! THEN
	choose case lmc_rc
		case mailReturnFailure!
				MessageBox("mailreturnfailure", "Error on Send")
		case mailReturnInsufficientMemory!
				MessageBox("mailReturnInsufficientMemory", "Error on Send")
		case mailReturnLoginFailure!
			MessageBox("mailReturnLoginFailure", "Error on Send")
		case mailReturnUserAbort!
			MessageBox("mailReturnUserAbort", "Error on Send")
		case mailReturnDiskFull!
			MessageBox("mailReturnDiskFull", "Error on Send")
		case mailReturnTooManySessions!
			MessageBox("mailReturnTooManySessions", "Error on Send")
		case mailReturnTooManyFiles!
			MessageBox("mailReturnTooManyFiles", "Error on Send")
		case mailReturnTooManyRecipients!
			MessageBox("mailReturnTooManyRecipients", "Error on Send")
		case mailReturnUnknownRecipient!
			MessageBox("mailReturnUnknownRecipient", "Error on Send")
		case mailReturnAttachmentNotFound!
			MessageBox("mailReturnAttachmentNotFound", "Error on Send")
	//	case null
		//	MessageBox("mailReturnNULL", "Error on Send un argomento è nullo!")
	end choose
	
	
   MessageBox("Error", "Error on Send")
else //il messaggio è stato inviato
select tipo_registro
into :ls_tipo_reg
from dba.documento d, dba.registro r
where d.id_documento=:il_id_doc
and d.id_registro=r.id_registro
;
if ls_tipo_reg='IV' then
	f_salva_invio(il_id_doc, LS_ALLEGATO)
	//se invia la mail allo SDI contabilizzo in automatico la fattura
	//w_doc=w_st_prov_def_wz.parent
	
end if

	ls_data=right(trim(lmf_file.FileName), 14)
	ls_data=left(ls_data, len(ls_data) -4)
	ldt_data=date(ls_data)
	
	f_sposta_in_mail(lmf_file.PathName, ldt_data)
	
	//se il messaggio è stato correttamente inviato lo segno nel campo "da_stampare"
	//valori: S=stampato; N=NON stampato; E=inviato pdf via mail; C=Prezzi confermati; 
	//X=prezzi confermati e inviato via mail;
		//ora lo salvo nella idw_gen
//	ll_righe=idw_riga.rowcount()
//	for i= 1 to ll_righe
		idw_gen.getitemstring(1, "documento_stampato")
		if ls_stampato= "C" then
			ls_stampato="X"  //inviato via mail e prezzi confermati
		else
			ls_stampato="E"
		end if
//		idw_riga.setitem(i, "riga_documento_da_stampare", ls_stampato)
//	next
	idw_gen.setitem(1, "documento_stampato", ls_stampato)
	idw_gen.update()
	//idw_riga.update()
END IF

lmc_rc = lms_sess.mailLogoff()
IF lmc_rc <> mailReturnSuccess! THEN
   MessageBox("Error", "Error on Close")
END IF
DESTROY lms_sess
 
 
end subroutine

public function string wf_estrai_nome_file (string as_path);string ls_nome_file
integer li_pos

li_pos=lastpos(as_path, "\")
if li_pos>0 then
	ls_nome_file=right(as_path, len(as_path) - li_pos)
else
	ls_nome_file=as_path
end if
return ls_nome_file
end function

public function string wf_controlla_nome_file (string as_nome_file);integer i


i=pos(as_nome_file, "/")

do while i>0 
	as_nome_file=Replace ( as_nome_file, i, 1, "-") 
	i=pos(as_nome_file, "/")
loop

return as_nome_file
end function

public subroutine wf_stampa_brogliaccio (long al_id_doc, string as_flag);datastore ds_silver
date ldt_data_doc
string ls_num_doc
decimal ldc_imponibile, ldc_imposta, ldc_totale
integer li_ret


//if cbx_brogliaccio.checked then
	ds_silver=create datastore
	ds_silver.dataobject="d_orafo_riga_documento_silver_k_stampa"
	ds_silver.settransobject(sqlca)
	ds_silver.retrieve(al_id_doc)
	ds_silver.sort()
	
	//23-04-2016 aggiungo intestazione e totali documento
	select num_documento, data_documento
	into :ls_num_doc, :ldt_data_doc
	from dba.documento
	where id_documento=:al_id_doc;
	
	select sum(val_tot_imp_v), sum(val_tot_iva_v)
	into :ldc_imponibile, :ldc_imposta
	from dba.cast_iva_documento
	where id_documento=:al_id_doc;
	
	ls_num_doc+= " del "+string(ldt_data_doc, "dd/mm/yy")
	ds_silver.modify("t_num_doc.text='"+ls_num_doc+"'")
	
	ds_silver.object.t_intestazione.text="St. Brogliaccio Doc "+ls_num_doc
	
	if isnull(ldc_imposta) then ldc_imposta=0
	ds_silver.object.t_imponibile.text=string(ldc_imponibile, "#,0.00")
	ds_silver.object.t_imposta.text=string(ldc_imposta, "#,0.00")
	ds_silver.object.t_totale.text=string(ldc_imponibile+ldc_imposta, "#,0.00")
	
	if as_flag='STAMPA' then
		ds_silver.print()
	else
		ds_silver.Modify("Export.PDF.Method = Distill!")
		ds_silver.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
		ds_silver.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
		li_ret=ds_silver.SaveAs(as_flag, PDF!, FALSE)
		IF LI_RET<> 1 THEN
			//ds_stampa.Modify("DataWindow.Print.printername = 'Acrobat PDFWriter'")
			//ds_stampa.print()
			//wf_crea_mail(ls_nome_file, ls_oggetto)
			messagebox("Errore!", "File PDF brogliaccio non generato!")	
		end if
	end if
	destroy ds_silver
//end if
end subroutine

public subroutine wf_allega_file_doc ();string mysql, mysql2,ls_file_doc
integer li_ret, i, li_righe
long ll_id_riga_doc_provenienza, ll_id_uc, ll_id_anagrafica, ll_id_sog_commerciale


//mysql="select * from dba.documento where id_documento="+string(il_id_doc)
//mysql2="output to 'c:\nita\exp_doc\doc_n_002.txt'"
//EXECUTE immediate :mysql;
//EXECUTE immediate :mysql2;
//li_ret=sqlca.sqlcode
//messagebox("1", li_ret)
//EXECUTE immediate :my_sql2;
//li_ret=sqlca.sqlcode
//messagebox("2", li_ret)

decimal  ldc_titolo
string LS_INVIA,ls_ret,  ls_doc, ls_numero,  ls_num_doc, ls_metallo, ls_des, ls_um, ls_azienda, ls_allegato
date ldt_data
integer li_pos
long ll_id_prof_doc,ll_id_sog , ll_id_art, ll_id_riga, ll_id_doc_provenienza
uo_mail u_mail

ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")

//select invia_mail_e_dati, mostra_prezzi
//into :ls_invia, :ls_ret
//from dba.sog_profilo_personalizza, 
//where id_sog_commerciale=:ll_id_sog
//and id_prof_documento=:ll_id_prof_doc
//;
//if isnull(ls_ret) then ls_ret='N'
//if ls_invia='S' then 
//	u_mail.of_allega_files(il_id_doc, ls_ret )
//end if 
//
//LS_DOC=idw_gen.getitemstring(1, "num_documento")

//ls_allegato=dw_1.getitemstring(1, "allegati")
//if ls_allegato>" " then
//	ls_allegato+=";"+"c:\nita\exp_doc\Doc_"+ls_doc+".txt"
//else
//	ls_allegato="c:\nita\exp_doc\Doc_"+ls_doc+".txt"
//end if
//ls_allegato+=";"+"c:\nita\exp_doc\Riga_"+ls_doc+".txt"
//ls_allegato+=";"+"c:\nita\exp_doc\Art_"+ls_doc+".txt"
//ls_allegato+=";"+"c:\nita\exp_doc\Uc_"+ls_doc+".txt"
//dw_1.setitem(1, "allegati", ls_allegato)

select rag_soc_1
into :ls_azienda
from dba.azienda
;
ls_azienda=upper(ls_azienda)


select data_documento, num_documento
into :ldt_data, :ls_numero
from dba.documento
where id_documento=:il_id_doc
;
li_pos=pos(ls_numero, "/")
if li_pos>0 then
	ls_numero=left(ls_numero, li_pos -1) +"-"+right(ls_numero, len(ls_numero) - li_pos)
end if
ls_doc="n_"+ls_numero+"_del_"+string(ldt_data, "dd-mm-yy")

datastore ds_doc, ds_righe, ds_sog_comm, ds_anagrafica

ds_doc=create datastore
ds_doc.dataobject="ds_documento_2016"
ds_doc.settransobject(sqlca)
li_ret=ds_doc.retrieve(il_id_doc)
if li_ret>0 then
	//20220928 Samy vuole che se il prof_doc è laser allora il numero doc sia "xx/L" se è ripara "xx/R
	if pos(upper(ls_azienda), "SILVER DR")>0 then
		if ll_id_prof_doc=204 then  //ripara
			ds_doc.setitem(1, "num_documento", ls_numero+ "/R")
		elseif ll_id_prof_doc=196 then  //TLaser
			ds_doc.setitem(1, "num_documento", ls_numero+ "/L")
		end if
	end if
	//fine 20220928
	//li_ret=ds_doc.saveasascii("c:\nita\exp_doc\Doc_"+ls_doc+".txt") //20250915 sembra che con file .txt alcuni clilente di posta mettano "CRLF" (wrapping) come torna meglio a loro e mi fanno danno ("Prezzo CompleCRLFssivo") o dopo data scadenza in doc
	ls_file_doc="c:\nita\exp_doc\Doc_"+ls_doc+".txt"
	li_ret=ds_doc.saveasascii(ls_file_doc) //20250915 provo a mettere ".dat" dovrebbe esser lo stesso
	ls_allegati=dw_1.getitemstring(1, "allegati")
	if ls_allegati>" " then
		//ls_allegati+=";"+"c:\nita\exp_doc\Doc_"+ls_doc+".txt"  ////20250915 prima era così
		ls_allegati+=";"+ls_file_doc
	else
		ls_allegati=ls_file_doc
	end if
	dw_1.setitem(1, "allegati", ls_allegati)
else
	messagebox("Attenzione!", "Doc non trovato!")
end if
//recupero i dati dell'intestatario per eventuale inserimento nell'importazione
ll_id_sog_commerciale=ds_doc.getitemnumber(1, "id_sog_commerciale")

ds_sog_comm=create datastore
ds_sog_comm.dataobject="ds_sog_comm_2016"
ds_sog_comm.settransobject(sqlca)
li_righe=ds_sog_comm.retrieve(ll_id_sog_commerciale)
if li_righe>0 then
	ls_file_doc="c:\nita\exp_doc\sog_com_"+ls_doc+".txt"  //cambio txt in dat 20250915
	//li_ret=ds_sog_comm.saveasascii("c:\nita\exp_doc\sog_com_"+ls_doc+".txt")
	li_ret=ds_sog_comm.saveasascii(ls_file_doc)
	ll_id_anagrafica=ds_sog_comm.getitemnumber(1, "id_anagrafica")
	ds_anagrafica=create datastore
	ds_anagrafica.dataobject="ds_anagrafica_2016"
	ds_anagrafica.settransobject(sqlca)
	li_righe=ds_anagrafica.retrieve(ll_id_anagrafica)
	if li_righe>0 then
		ls_file_doc="c:\nita\exp_doc\ana_"+ls_doc+".txt" //20250915 cambio estensione perché txt da problilmi di wrapping in invio mail...
		//li_ret=ds_anagrafica.saveasascii("c:\nita\exp_doc\ana_"+ls_doc+".txt")
		li_ret=ds_anagrafica.saveasascii(ls_file_doc)
	end if
end if

//fine intestatario
ds_righe=create datastore
ds_righe.dataobject="ds_riga_documento_2016"
ds_righe.settransobject(sqlca)
li_righe=ds_righe.retrieve(il_id_doc)
if li_righe>0 then
	for i=1 to li_righe
		if pos(upper(ls_azienda), "SILVER DR")>0 then
			ll_id_riga_doc_provenienza=ds_righe.getitemnumber(i, "provv_imp_subage_2")
			//if ll_id_riga_doc_provenienza>0 then
//				select num_documento
//				into :ls_num_doc
//				from dba.riga_documento r, dba.documento d
//				where d.id_documento=r.id_documento
//				and r.id_riga_documento=:ll_id_riga_doc_provenienza
//				;
//				ds_righe.setitem(i, "provv_imp_carea_2", dec(right(ls_num_doc, 5)))
			//else
			if  ll_id_riga_doc_provenienza<=0 or isnull(ll_id_riga_doc_provenienza) then
				ll_id_riga=ds_righe.getitemnumber(i, "id_riga_documento")
				select id_bollettina into :ll_id_doc_provenienza
				from dba.produzione_2011 where id_doc_produzione=:ll_id_riga
				;
				//20220818 aggiunto per recuperare num_bol se non c'è in derivazione (id_riga_doc_provenienza)
				select first(id_riga_documento) into :ll_id_riga_doc_provenienza 
				from riga_documento where id_documento=:ll_id_doc_provenienza;
			end if
			if ll_id_riga_doc_provenienza>0 then
				select num_documento
				into :ls_num_doc
				from dba.riga_documento r, dba.documento d
				where d.id_documento=r.id_documento
				and r.id_riga_documento=:ll_id_riga_doc_provenienza
				;
				//ds_righe.setitem(i, "provv_imp_carea_2", dec(right(ls_num_doc, 5)))   //20251016 proviamo a cambiare che provv_imp_carea_2 sono i lacci...
				ds_righe.setitem(i, "provv_imp_carea", dec(right(ls_num_doc, 7)))  //porto il valore a 7 così non ci saranno più problemi con le bollettine dell'anno precedente...
			else
				//messagebox("Attenzione!", "Bollettina non legata a questa riga: "+string(i))
			end if
		end if
		//prendo titolo e metallo e li aggiungo ala descrizione riga
		//20220921samy vuole che col profilo ripara (204) parta solo l'articolo (id_articolo) 281 
		if ll_id_prof_doc=204 and pos(upper(ls_azienda), "SILVER DR")>0 then
			ll_id_art=281
			ds_righe.setitem(i, "id_articolo",ll_id_art)
		else
			ll_id_art=ds_righe.getitemnumber(i, "id_articolo")
		end if
		//20220921 fine
		if ll_id_art>0 then
			select m.codice, t.titolo
			into :ls_metallo, :ldc_titolo
			from dba.orafo_metallo m, orafo_titolo t, articolo a
			where a.id_titolo=t.id_titolo
			and m.id_metallo=t.id_metallo
			and a.id_articolo=:ll_id_art
			;
		end if
		if ldc_titolo>=0 then
			ls_des=ds_righe.getitemstring(i, "descrizione")
			//08-09-2019 Samy NON vuole che la des galvanica vada al fornitore: la tolgo ("__")
			
			if pos(upper(ls_azienda), "SILVER DR")>0 then
				li_pos=pos(ls_des,  "__")
				if li_pos>0 then
					ls_des=left(ls_des, li_pos - 1)
				end if
			end if
			//fine 08092019
			ls_des+="::"+ls_metallo+string(ldc_titolo, "#,0.00")  //aggiungo metallo e titolo
			ll_id_uc=ds_righe.getitemnumber(i, "id_unita_confezione")
			select u.simbolo
			into :ls_um
			from dba.unita_misura u, dba.unita_confezione uc
			where uc.id_unita_misura=u.id_unita_misura
			and uc.id_unita_confezione=:ll_id_uc
			;
			if ls_um> " " then
				ls_des+=";;"+ls_um  //aggiungo um movimento
			end if
			ds_righe.setitem(i, "descrizione", ls_des)
		end if
	next
	
	li_ret=ds_righe.saveasascii("c:\nita\exp_doc\Riga_"+ls_doc+".txt")
	ls_allegati+=";"+"c:\nita\exp_doc\Riga_"+ls_doc+".txt"
	dw_1.setitem(1, "allegati", ls_allegati)
else
	messagebox("Attenzione!", "RIGA non trovata!")
end if
//recupera articoli e uc
for i= 1 to li_righe
	ll_id_art=ds_righe.getitemnumber(i, "id_articolo")
	dw_art.retrieve(ll_id_art)
	dw_uc.retrieve(ll_id_art)
next
li_ret=dw_art.saveasascii("c:\nita\exp_doc\Art_"+ls_doc+".txt")
ls_allegati+=";"+"c:\nita\exp_doc\Art_"+ls_doc+".txt"
li_ret=dw_uc.saveasascii("c:\nita\exp_doc\Uc_"+ls_doc+".txt")
ls_allegati+=";"+"c:\nita\exp_doc\Uc_"+ls_doc+".txt"
dw_1.setitem(1, "allegati", ls_allegati)
//dw_3.settransobject(sqlca)
//ds_righe.rowscopy(1, ds_righe.rowcount(), primary!, dw_3, 1, primary!)
destroy ds_doc
destroy ds_righe
destroy ds_sog_comm
destroy ds_anagrafica
end subroutine

public subroutine wf_new_invia_mail ();//testo, oggetto email_1 s_allegato[]
string  ls_allegato, ls_alleg[], ls_indirizzo_e_mail,ls_vedi_prezzo,ls_ordina
uo_mail u_mail
integer a, li_pos, b

dw_1.accepttext()
u_mail.of_prepara_campi_mail(il_id_doc)
ls_allegato=dw_1.getitemstring(1, "allegati")
a=1
li_pos=pos(ls_allegato, ";",a )
if li_pos=0 then 
	ls_alleg[1]=ls_allegato
else
	do while li_pos >0 or len(ls_allegato) > a
		b++
		if li_pos=0 then 
			li_pos=len(ls_alleg[b - 1]) +1
			ls_alleg[b]=mid(ls_allegato, a, li_pos - 1)
			exit
		end if
		ls_alleg[b]=mid(ls_allegato, a, li_pos - a)	
		a=li_pos+1
		li_pos=pos(ls_allegato, ";",a )
	loop
end if
ls_indirizzo_e_mail=dw_1.getitemstring(1, "DESTINaTARIO")
u_mail.is_mail.s_email_1=ls_indirizzo_e_mail
//u_mail.is_mail.s_allegato=ls_allegati
if cbx_prezzo.checked then ls_vedi_prezzo="N" else ls_vedi_prezzo="S"
if isnull(ls_vedi_prezzo) then ls_vedi_prezzo='N'
//ordino secondo il flag impostato nella finestra 13/10/2021 richiesta Samy per Karizia
if dw_3.getitemstring(1, "ordina") = "C" then
	ls_ordina=dw_3.getitemstring(1, "ordina") 
else
	ls_ordina="I"
end if	
u_mail.of_crea_pdf(il_id_doc, ls_vedi_prezzo,ls_ordina)
u_mail.of_invia_mail("PEC", "S", true, true) //il primo è il codice della riga con i dati (mittente, smtp ecc..) per inviare la mail, il secondo il "vedi prezzi",
//il terzo e il quarto per creare o no file di log e debug
f_salva_invio(il_id_doc, ls_allegato)

messagebox("Attenzione!", "La Fattura è stata inviata allo SDI! Occorre quindi CONTABILIZZARLA!")


end subroutine

public subroutine wf_mailsend (string as_tipo_mail);//testo, oggetto email_1 s_allegato[]
string  ls_allegati_ok[], ls_indirizzo_e_mail, ls_tipo_reg,ls_vedi_prezzo, ls_mail_per_risposta,ls_7zip_path, ls_allegatiM_path
uo_mail u_mail
integer a, li_pos, b, li_pos_2

dw_1.accepttext()
ls_indirizzo_e_mail=dw_1.getitemstring(1, "destinatario") //può contenere indirizzi divisi da ";"
if pos(ls_indirizzo_e_mail, "@")>0 then
//if isnull(is_mail.s_email_1) or is_mail.s_email_1="" then
//	select num_riferimento
//	into :ls_indirizzo_e_mail
//	from telefono
//	where tipo='E'
//	and id_anagrafica=:ll_id_ana;
//	if pos( ls_indirizzo_e_mail, "@")> 0 then
		//300713 per ora gestisco solo 3 indirizzi: il primo in To e il secondo e il terzo in CC e cc_2
		//si cambia 20210126 speriamo bene: il primo in TO il secondo in CC, gli altri divisi dal ; tutti insieme
	//20210928 cambio: tutto su 	".s_email_1" diviso da ;
//	li_pos=pos(ls_indirizzo_e_mail, ";")
//	li_pos_2=pos(ls_indirizzo_e_mail, ";",li_pos+1 )
//	if li_pos_2>0 then //ci sono 3 indirizzi
//		//su s_mail.s_email_3 ci metto il terzo
//		u_mail.is_mail.s_email_3=right(ls_indirizzo_e_mail, len(ls_indirizzo_e_mail) - li_pos_2)
//		//tolgo l'indirizzo cc_2
//		ls_indirizzo_e_mail=left(ls_indirizzo_e_mail, li_pos_2 -1)
//	end if
//	if li_pos>0 then
//		u_mail.is_mail.s_email_2=right(ls_indirizzo_e_mail, len(ls_indirizzo_e_mail) - li_pos)
//		u_mail.is_mail.s_email_1=left(ls_indirizzo_e_mail, li_pos -1)
//	else
		u_mail.is_mail.s_email_1=ls_indirizzo_e_mail
		//controllo se sono stati inseriti negli altri campi CC e CC_2
		ls_indirizzo_e_mail=dw_1.getitemstring(1, "cc")
		if ls_indirizzo_e_mail> " " then 	u_mail.is_mail.s_email_1+=";"+ls_indirizzo_e_mail
		ls_indirizzo_e_mail=""
		ls_indirizzo_e_mail=dw_1.getitemstring(1, "cc_2")
		if ls_indirizzo_e_mail> " " then u_mail.is_mail.s_email_1+=";"+ls_indirizzo_e_mail
//		select mail_per_risposta into :ls_mail_per_risposta from dba.dati_mail where codice='MAIL';  //DA CONTROLLARE E FINIRE
		if ls_mail_per_risposta> " " then u_mail.is_mail.s_mail_per_risposta=ls_mail_per_risposta
	//end if
else
	messagebox("Attenzione!", "Inserire un indirizzo mail corretto! Operazione annullata.")
end if
//u_mail.is_mail.s_email_1=ls_indirizzo_e_mail

u_mail.of_prepara_campi_mail(il_id_doc)
ls_allegati=dw_1.getitemstring(1, "allegati")
a=1
li_pos=pos(ls_allegati, ";",a )
if li_pos=0 then 
	ls_allegati_ok[1]=ls_allegati
else
	do while li_pos >0 or len(ls_allegati) > a
		b++
		if li_pos=0 then 
			li_pos=len( ls_allegati_ok[b - 1]) +1
			ls_allegati_ok[b]=mid(ls_allegati, a, li_pos - 1)
			exit
		end if
		ls_allegati_ok[b]=mid(ls_allegati, a, li_pos - a)	
		a=li_pos+1
		li_pos=pos(ls_allegati, ";",a )
	loop
end if
//20250918: commento perché lo rifà sia su 	u_mail.of_send_mail che su u_mail.of_invia_mail("MAIL", "S", true, true )
////20250915 zippo per evitare wrapping in doc e riga che sono lunghi: mi mette a capo a caso qua e là...
//ls_7zip_path="C:\Programmi\7-Zip\7z.exe"
//ls_allegatiM_path="c:\nita\exp_doc\allegati.zip"
//f_zip_files(ls_allegatiM_path, ls_7zip_path, ls_allegati_ok)
//

u_mail.is_mail.s_allegato= ls_allegati_ok

if cbx_prezzo.checked then ls_vedi_prezzo="N" else ls_vedi_prezzo="S"
if isnull(ls_vedi_prezzo) then ls_vedi_prezzo='N'

u_mail.is_mail.s_testo=dw_1.getitemstring(1, "testo")
if isnull(u_mail.is_mail.s_testo) or u_mail.is_mail.s_testo="" then u_mail.is_mail.s_testo="Compilata Automaticamente."
u_mail.is_mail.l_id_doc=il_id_doc //20261126 come nella 64_2025: uo_mail deve sapere quale documento (fattura o no)
if as_tipo_mail="PEC" then
//	f_controlla_num_invio(
	//u_mail.of_send_mail("PEC", "S", true, true)  //20261126 si passa a of_new_mailsender come nella 64_2025
	u_mail.of_new_mailsender("PEC", "S", true, true) //il primo è il codice della riga con i dati (mittente, smtp ecc..) per inviare la mail, il secondo il "vedi prezzi",
else
	//u_mail.of_crea_pdf(il_id_doc, ls_vedi_prezzo)
	//u_mail.of_invia_mail("MAIL", "S", true, true )  //20261126 come nella 64_2025
	u_mail.of_new_mailsender("MAIL", "S", true, true )
end if
//il terzo e il quarto per creare o no file di log e debug

//20261126 come nella 64_2025: f_salva_invio lo fa gia' of_new_mailsender, solo se l invio riesce (se no la fattura risultava inviata 2 volte)
//select tipo_registro
//into :ls_tipo_reg
//from dba.registro r, dba.documento d
//where d.id_documento= :il_id_doc
//and d.id_registro=r.id_registro
//;
//if ls_tipo_reg='IV'  then
//	f_salva_invio(il_id_doc, ls_allegati)
//	//messagebox("Attenzione!", "La Fattura è stata inviata allo SDI! Occorre quindi CONTABILIZZARLA!")
//end if


end subroutine

public subroutine wf_stampa_pdf (integer ai_ordinamento);string dwsyntax, ls_path_libreria, ls_art_mancanti, ls_path
string ls_des_prof, ls_COD_prof, ls_num_doc, ls_nome_file, ls_test
string ls_destinatario, ls_azienda, ls_testo, ls_indirizzo_e_mail
string ls_oggetto, ls_mail_cc,ls_mail_cc_2, ls_tipo_reg, ls_ret, ls_return
long ll_id_ana, ll_id_sog_com, ll_id_prof_doc, ll_len
date ldt_data_doc
datastore ds_stampa
integer li_ret, li_num_righe, li_pos,li_pos_2


select p.codice, d.num_documento, d.data_documento, d.id_sog_commerciale, d.id_prof_documento
	into :ls_cod_prof, :ls_num_doc, :ldt_data_doc, :ll_id_sog_com, :ll_id_prof_doc
	from prof_documento p, documento d
	where d.id_prof_documento=p.id_prof_documento
	and d.id_documento=:il_id_doc;
	
	//se è karizia e rbol e > 31-12-2018  16-7-2018 devo cambiare report da cambiare la data con quella per partire
	if cbx_sintetica.checked then
		//is_nome_report="d_ddt_rbol_e" //per esterni: samy 20201001
		is_nome_report=f_scegli_report(il_id_doc, is_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc) //anche qui occorre fare il giochino 20230612
	else
		is_nome_report=f_scegli_report(il_id_doc, is_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc)
	end if
	sle_report.text=is_nome_report
	sle_report.textcolor=255
	sle_report.Weight=700 //bold

select codice, libreria
into :ls_test, :ls_path_libreria
from conf_oggetti
where codice= :is_nome_report;

if ls_path_libreria> " " then
	ls_oggetto=ls_cod_prof+" n. "+ls_num_doc+" del "+string(ldt_data_doc, "dd/mm/yyyy")

	
	


	dwsyntax = LibraryExport(ls_path_libreria, is_nome_report, ExportDataWindow!)
	IF dwsyntax>"" THEN
		ds_stampa=create datastore
		ds_stampa.create(dwsyntax)
		ds_stampa.settransobject(sqlca)
		li_num_righe=ds_stampa.retrieve(il_id_doc)
	
		//090712 per samy: inserisco eventuali articoli mancanti al completamento del pronto
		ls_art_mancanti=f_controlla_pronto(il_id_doc)
		if ls_art_mancanti>" " then
			ds_stampa.modify("t_art_mancanti.text='"+ls_art_mancanti+"'")
		end if
		//fine 090712 per samy
	else
		messagebox("Errore!", "Dw di stampa "+is_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE'")
//		return -1	
	end if
	
	
//	select dir_output
//	into :ls_path
//	from orafo_par_sistema;
//	if isnull(ls_path) or ls_path="" then
//		messagebox("Attenzione!", "Specificare la directory di output nei parametri di sistema!")
////		return -1
//	end if
	ls_path="C:\nita\pdf\"
	//if right(ls_path, 1)<>"\" then ls_path+="\"
	ls_nome_file=ls_path+ls_cod_prof+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf"
	ls_nome_file=wf_controlla_nome_file(ls_nome_file)
	//ls_test=ds_stampa.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
	select tipo_registro
	into :ls_tipo_reg
	from dba.registro r, dba.documento d
	where id_documento=:il_id_doc
	and r.id_registro=d.id_registro
	;
	if cbx_prezzo.checked then
		//16-03-2016 se  è una bolla (DV) e è stato attivato il flag "senza prezzo" rendo invisibile prezzo e importo
		if ls_tipo_reg='DV' then
			ds_stampa.Modify("c_prezzo.visible =0")
			ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
		end if
	end if
	//240713 se voglio che funga devo aggiungere la stampante da usare 
	//che deve essere una postscript (vedi esempio successivo)
	//dichiarazione intento nuova 2017-04-19
	If ls_tipo_reg='IV' then
		ll_id_ana=ds_stampa.getitemnumber(1, "id_anagrafica")
	//	ldt_data_doc=ds_stampa.getitemdate(1, "documento_data_documento")
		ls_return="Operazione non imponibile ai sensi dello Art. 8 2° C. D.P.R. 633 del 26/10/72 e modifiche successive  come  da Vs. dichiarazione di intento N. "&
		+f_dich_intento_2017(ll_id_ana, ldt_data_doc, "", il_id_doc)
		ds_stampa.modify("t_dich_intento.text='"+ls_return+"'") 
		//inserisco galvanica specchietto solo se è d_fattura_s2 silver 18-10-2019
		if cbx_galvanica.checked and is_nome_report="D_FATTURA_S2" then
				ds_stampa.modify("dw_galv.visible=true")
				ds_stampa.retrieve(il_id_doc)
		end if
	end if
	 //fine 2017-04-19
	ds_stampa.Modify("Export.PDF.Method = Distill!")
	ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	ds_stampa.Modify("Export.PDF.Distill.CustomPostScript='Yes'")

	//ordino secondo il flag impostato nella finestra 13/10/2021 richiesta Samy per Karizia
		if ai_ordinamento = 1 then  //20250604 sarebbe 1="C" cliente 
			ls_nome_file=left(ls_nome_file, len(ls_nome_file) - 4)+"_"+string(ai_ordinamento)+".pdf"
			ds_stampa.setsort("c_ordina_per_cliente, data_prev_consegna_1, c_num_pacco, riga_documento_id_riga_documento")
			ds_stampa.sort()
		end if		
	
	li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		messagebox("Errore!", "File PDF non generato!")	
	else  //20230908 per LABELLA: ogni tanto crea pdf vuoto, allora controllo len del file e vedo se è pieno p no... altrimenti ristampo finché non lo fa bene!!!!!
		ll_len = FileLength64(ls_nome_file)
		do while ll_len <=3500
			li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
		loop
	end if
	//20230908 fine
//	//28-04-2016
//	if cbx_brogliaccio.checked then
//		wf_stampa_brogliaccio(il_id_doc, ls_path+"BROGL_"+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf")
//		ls_nome_file+=";"+ls_path+"BROGL_"+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf"
//	end if
	//fine 28-04-2016
	destroy(ds_stampa)
else
	messagebox("Errore!", "Dw di stampa "+is_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE' ")
end if
end subroutine

on w_st_prov_def_wz.create
this.pb_1=create pb_1
this.pb_excel=create pb_excel
this.dw_3=create dw_3
this.st_3=create st_3
this.cb_salva_excel=create cb_salva_excel
this.cb_mail_old=create cb_mail_old
this.cb_new_pec=create cb_new_pec
this.cb_mail_new=create cb_mail_new
this.rb_1=create rb_1
this.cbx_importo=create cbx_importo
this.dw_uc=create dw_uc
this.dw_art=create dw_art
this.cb_1=create cb_1
this.cbx_brogliaccio=create cbx_brogliaccio
this.cbx_prezzo=create cbx_prezzo
this.sle_report=create sle_report
this.dw_2=create dw_2
this.rb_mail=create rb_mail
this.st_1=create st_1
this.em_copie=create em_copie
this.cbx_sintetica=create cbx_sintetica
this.ddlb_stampante=create ddlb_stampante
this.st_stampante=create st_stampante
this.rb_video=create rb_video
this.rb_stampa=create rb_stampa
this.rb_def=create rb_def
this.rb_prov=create rb_prov
this.cb_stampa=create cb_stampa
this.cb_annulla=create cb_annulla
this.gb_stvi=create gb_stvi
this.cb_old_pec=create cb_old_pec
this.cb_printer_setup=create cb_printer_setup
this.st_2=create st_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cbx_galvanica=create cbx_galvanica
this.gb_provdef=create gb_provdef
this.Control[]={this.pb_1,&
this.pb_excel,&
this.dw_3,&
this.st_3,&
this.cb_salva_excel,&
this.cb_mail_old,&
this.cb_new_pec,&
this.cb_mail_new,&
this.rb_1,&
this.cbx_importo,&
this.dw_uc,&
this.dw_art,&
this.cb_1,&
this.cbx_brogliaccio,&
this.cbx_prezzo,&
this.sle_report,&
this.dw_2,&
this.rb_mail,&
this.st_1,&
this.em_copie,&
this.cbx_sintetica,&
this.ddlb_stampante,&
this.st_stampante,&
this.rb_video,&
this.rb_stampa,&
this.rb_def,&
this.rb_prov,&
this.cb_stampa,&
this.cb_annulla,&
this.gb_stvi,&
this.cb_old_pec,&
this.cb_printer_setup,&
this.st_2,&
this.gb_1,&
this.dw_1,&
this.cbx_galvanica,&
this.gb_provdef}
end on

on w_st_prov_def_wz.destroy
destroy(this.pb_1)
destroy(this.pb_excel)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.cb_salva_excel)
destroy(this.cb_mail_old)
destroy(this.cb_new_pec)
destroy(this.cb_mail_new)
destroy(this.rb_1)
destroy(this.cbx_importo)
destroy(this.dw_uc)
destroy(this.dw_art)
destroy(this.cb_1)
destroy(this.cbx_brogliaccio)
destroy(this.cbx_prezzo)
destroy(this.sle_report)
destroy(this.dw_2)
destroy(this.rb_mail)
destroy(this.st_1)
destroy(this.em_copie)
destroy(this.cbx_sintetica)
destroy(this.ddlb_stampante)
destroy(this.st_stampante)
destroy(this.rb_video)
destroy(this.rb_stampa)
destroy(this.rb_def)
destroy(this.rb_prov)
destroy(this.cb_stampa)
destroy(this.cb_annulla)
destroy(this.gb_stvi)
destroy(this.cb_old_pec)
destroy(this.cb_printer_setup)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cbx_galvanica)
destroy(this.gb_provdef)
end on

event systemkey;integer		li_rc
unsignedlong l_keyflags

l_keyflags = keyflags

CHOOSE CASE l_keyflags
	CASE 1 
		IF key = KeyF4! THEN
			li_rc= THIS.cb_annulla.TriggerEvent(Clicked!)
		END IF
	CASE ELSE
		IF key = KeyF4! THEN
			li_rc= THIS.cb_annulla.TriggerEvent(Clicked!)
		END IF
END CHOOSE



end event

event open;s_crea_dw s_par
string ls_prof_cod, ls_codice_az
long ll_id_dest

dw_2.insertrow(1)
dw_3.insertrow(1)

rb_prov.TriggerEvent(Clicked!)
rb_video.TriggerEvent(Clicked!)
il_ret_code = -1
wf_get_printer_info() 

ii_id_utente	= u_freddie.s_utenti.i_idutente
s_par=Message.PowerObjectParm
idw_riga=s_par.dw_riga
idw_gen=s_par.dw_gen
is_nome_report=s_par.ls_dw_sintax
il_id_doc=s_par.ll_id_doc
is_nome_report=upper(is_nome_report)
sle_report.text=is_nome_report
wf_select_profilo( ii_id_utente,is_nome_report )

select d.id_destinazione, p.codice
into :ll_id_dest, :ls_prof_cod
from prof_documento p, documento d
where d.id_prof_documento=p.id_prof_documento
and d.id_documento=:il_id_doc
;

if ls_prof_cod="CLF" and ll_id_dest>0 then
	em_copie.text='3'
end if

//30102021 Samy non lo vuole più
//if  ls_prof_cod="SALD" then
//	 cbx_prezzo.checked=true
//end if
dw_art.settransobject(sqlca)
dw_uc.settransobject(sqlca)


select codice
into :ls_codice_az
from dba.azienda
;
if ls_codice_az="SILVERDR" then
	cbx_galvanica.checked=true
//elseif ls_codice_az="LABELLA" then //commento provo a fargli usare quella nuova nache perché la vecchia NON funge più (ho integrato 3 indirizzi...) 20210928
//	cb_mail_old.x=1632
//	cb_mail_old.y=680
//	cb_mail_new.x=69
//	cb_mail_new.y=1256
end if
end event

event close;st_stampa_doc lst_stampa
string ls_nome_report
lst_stampa.s_nome_report=is_nome_report
lst_stampa.i_num_copie=integer(em_copie.text)
if rb_stampa.checked and il_ret_code>=0 then il_ret_code=2
	
if is_nome_report='ORDINE_FO' then  il_ret_code=-1
if rb_mail.checked then il_ret_code=-1
if il_ret_code>=0 then
	lst_stampa.ordina_per=dw_2.getitemstring(1, "campo")
	if isnull(lst_stampa.ordina_per) then lst_stampa.ordina_per=""
end if
if rb_1.checked then
	lst_stampa.fat_da_contabilizzare='S'
end if
Message.DoubleParm = il_ret_code
message.powerobjectparm=lst_stampa

end event

type pb_1 from picturebutton within w_st_prov_def_wz
boolean visible = false
integer x = 41
integer y = 148
integer width = 174
integer height = 144
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\xls_down.jpg"
alignment htextalign = left!
end type

event clicked;//integer li_y, i, li_num_riga
//string ls_codice_azienda, ls_num_doc, ls_des2, ls_doc_controllato,LS_NOME_FILE
//datawindowchild dwc_galvanica
//decimal ldc_imponibile, ldc_imposta, ldc_totale , ldc_tara,ldc_prezzo_attuale, ldc_test
//long ll_id_uc,ll_num_prog, ll_id_art,ll_test, ll_id_sog, ll_righe
date ldt_data_doc  //, ldt_2_mesi_prima, ldt_modifica_listino, ldt_data_fine,ldt_primo_gmese
long ll_righe
string LS_NOME_FILE, ls_ordina, ls_tipo_reg, ls_sort,ls_versione_office
datastore ds_silver

select r.tipo_registro, d.data_documento into :ls_tipo_reg, :ldt_data_doc
from dba.registro r, documento d
where r.id_registro=d.id_registro and d.id_documento=:il_id_doc;

ds_silver=create datastore
ls_ordina=dw_3.getitemstring(1, "ordina")
if ls_ordina="I"  then
	if ls_tipo_reg="DV" then
		ds_silver.dataobject="d_ddt_excel_ins_ra"
	else
		ds_silver.dataobject="d_doc_excel_ins_ra"
	end if
else
	if ls_tipo_reg="DV" then
		ds_silver.dataobject="d_ddt_excel_ins_ra"
		ls_sort="c_ordina"
	else
		ds_silver.dataobject="d_doc_excel_id_art_ra"
	end if
end if

ds_silver.settransobject(sqlca)
ll_righe=ds_silver.retrieve(il_id_doc)
if ls_sort>" " then 
	ds_silver.setsort(ls_sort)
	ds_silver.sort()
end if
LS_NOME_FILE="c:\nita\excel\"
LS_NOME_FILE+="N_"+ idw_gen.getitemstring(1, "num_documento")
LS_NOME_FILE+= "_"+string(ldt_data_doc, "yy-mm-dd")
ds_silver.saveas(LS_NOME_FILE+".xls",Excel!, false)

destroy ds_silver
// Creazione dell'oggetto Excel

OLEObject excel
excel = CREATE OLEObject
IF excel.ConnectToNewObject("Excel.Application") <> 0 THEN
    MessageBox("Errore", "Impossibile connettersi a Excel")
    RETURN
END IF

// Rendere visibile Excel (utile per debugging)
excel.Visible = TRUE  

// Apri il file dei dati esportati
OLEObject workbook
OLEObject sheetData
workbook = excel.Workbooks.Open(LS_NOME_FILE+".XLS")
sheetData = workbook.Sheets(1)

// Apri il file template **prima** di copiare i dati
OLEObject templateWorkbook
ls_versione_office=string(excel.Version)
if pos(ls_versione_office, "8.0")>0 then
	templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xlt")
else
	templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xls")
end if
// Attivare il template come file attivo
//templateWorkbook.Activate()
// Selezionare il foglio corretto nel template
OLEObject sheetTemplate
sheetTemplate = templateWorkbook.Sheets(1)

// Copiare i dati dal file dati e incollarli nel template
sheetData.UsedRange.Copy()
//MessageBox("Debug", "Dati copiati correttamente?")
sheetTemplate.Range("A2").Select()
sheetTemplate.Paste()
//sheetTemplate.Range("A2").PasteSpecial(-4122)  // Incolla solo valori

// Salva il file risultante con un nuovo nome
templateWorkbook.SaveAs(LS_NOME_FILE+"_OK.xls")

// Chiudi i file e Excel correttamente
workbook.Close(FALSE)  // Chiude il file dei dati senza salvare modifiche
templateWorkbook.Close(TRUE)  // Salva e chiude il template
excel.Quit()
DESTROY excel
		
		//ls_num_doc= "t_num_doc.text= "+ls_num_doc
//		tab_1.tabpage_2.dw_6.modify("t_num_doc.text='"+ls_num_doc+"'")
//		//23-04-2016 aggiungo intestazione e totali documento
//		tab_1.tabpage_2.dw_6.object.t_intestazione.text="Brogliaccio "+ls_num_doc
//		ldc_imponibile=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imponibile_lire")
//		ldc_imposta=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imposta_lire")
//		ldc_totale=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_documento_lire")
//		tab_1.tabpage_2.dw_6.object.t_imponibile.text=string(ldc_imponibile, "#,0.00")
//		tab_1.tabpage_2.dw_6.object.t_imposta.text=string(ldc_imposta, "#,0.00")
//		tab_1.tabpage_2.dw_6.object.t_totale.text=string(ldc_totale, "#,0.00")
		//fine 23-04-2016
	
//		tab_1.tabpage_2.dw_6.setredraw(true)
//		f_doc_excel(tab_1.tabpage_2.dw_6)
//	else
//		idw_riga.object.c_tot_righe.visible="0"
//		idw_riga.object.linea.visible="0"
//		idw_riga.object.c_tot_righe_t.visible="0"
//		idw_riga.object.c_tot_righe_lire_t.visible="0"
//		idw_riga.object.c_tot_righe_lire.visible="0"
//			
//		idw_riga.print()	
//		idw_riga.object.c_tot_righe.visible="1"
//		idw_riga.object.linea.visible="1"
//		idw_riga.object.c_tot_righe_t.visible="1"
//		idw_riga.object.c_tot_righe_lire_t.visible="1"
//		idw_riga.object.c_tot_righe_lire.visible="1"
//	
//	end if

end event

type pb_excel from picturebutton within w_st_prov_def_wz
integer x = 1760
integer y = 456
integer width = 174
integer height = 144
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\xls_down.jpg"
alignment htextalign = left!
end type

event clicked;//integer li_y, i, li_num_riga
//string ls_codice_azienda, ls_num_doc, ls_des2, ls_doc_controllato,LS_NOME_FILE
//datawindowchild dwc_galvanica
//decimal ldc_imponibile, ldc_imposta, ldc_totale , ldc_tara,ldc_prezzo_attuale, ldc_test
//long ll_id_uc,ll_num_prog, ll_id_art,ll_test, ll_id_sog, ll_righe
date ldt_data_doc  //, ldt_2_mesi_prima, ldt_modifica_listino, ldt_data_fine,ldt_primo_gmese
long ll_righe
string LS_NOME_FILE, ls_ordina, ls_tipo_reg, ls_sort,ls_versione_office
datastore ds_silver


//20250604 stampo PDF della FATTURA o BOLLA in ordine per cliente e poi per inserimento

wf_stampa_pdf(1)
wf_stampa_pdf(0)
//20250604 FINE



select r.tipo_registro, d.data_documento into :ls_tipo_reg, :ldt_data_doc
from dba.registro r, documento d
where r.id_registro=d.id_registro and d.id_documento=:il_id_doc;

ds_silver=create datastore
ls_ordina=dw_3.getitemstring(1, "ordina")
if ls_ordina="I"  then
	if ls_tipo_reg="DV" then
		ds_silver.dataobject="d_ddt_excel_ins_ra"
	else
		ds_silver.dataobject="d_doc_excel_ins_ra"
	end if
else
	if ls_tipo_reg="DV" then
		ds_silver.dataobject="d_ddt_excel_ins_ra"
		ls_sort="c_ordina"
	else
		ds_silver.dataobject="d_doc_excel_id_art_ra"
	end if
end if

ds_silver.settransobject(sqlca)
ll_righe=ds_silver.retrieve(il_id_doc)
if ls_sort>" " then 
	ds_silver.setsort(ls_sort)
	ds_silver.sort()
end if
LS_NOME_FILE="c:\nita\excel\"
LS_NOME_FILE+="N_"+ idw_gen.getitemstring(1, "num_documento")
LS_NOME_FILE+= "_"+string(ldt_data_doc, "yy-mm-dd")
ds_silver.saveas(LS_NOME_FILE+".xls",Excel!, false)

destroy ds_silver
// Creazione dell'oggetto Excel

OLEObject excel
excel = CREATE OLEObject
IF excel.ConnectToNewObject("Excel.Application") <> 0 THEN
    MessageBox("Errore", "Impossibile connettersi a Excel")
    RETURN
END IF

// Rendere visibile Excel (utile per debugging)
excel.Visible = TRUE  

// Apri il file dei dati esportati
OLEObject workbook
OLEObject sheetData
workbook = excel.Workbooks.Open(LS_NOME_FILE+".XLS")
sheetData = workbook.Sheets(1)

// Apri il file template **prima** di copiare i dati
OLEObject templateWorkbook
ls_versione_office=string(excel.Version)
if pos(ls_versione_office, "8.0")>0 then
	templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xlt")
else
	templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xls")
end if
// Attivare il template come file attivo
//templateWorkbook.Activate()
// Selezionare il foglio corretto nel template
OLEObject sheetTemplate
sheetTemplate = templateWorkbook.Sheets(1)

// Copiare i dati dal file dati e incollarli nel template
sheetData.UsedRange.Copy()
//MessageBox("Debug", "Dati copiati correttamente?")
sheetTemplate.Range("A2").Select()
sheetTemplate.Paste()
//sheetTemplate.Range("A2").PasteSpecial(-4122)  // Incolla solo valori

// Salva il file risultante con un nuovo nome
templateWorkbook.SaveAs(LS_NOME_FILE+"_OK.xls")

// Chiudi i file e Excel correttamente
workbook.Close(FALSE)  // Chiude il file dei dati senza salvare modifiche
templateWorkbook.Close(TRUE)  // Salva e chiude il template
excel.Quit()
DESTROY excel
		
		//ls_num_doc= "t_num_doc.text= "+ls_num_doc
//		tab_1.tabpage_2.dw_6.modify("t_num_doc.text='"+ls_num_doc+"'")
//		//23-04-2016 aggiungo intestazione e totali documento
//		tab_1.tabpage_2.dw_6.object.t_intestazione.text="Brogliaccio "+ls_num_doc
//		ldc_imponibile=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imponibile_lire")
//		ldc_imposta=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imposta_lire")
//		ldc_totale=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_documento_lire")
//		tab_1.tabpage_2.dw_6.object.t_imponibile.text=string(ldc_imponibile, "#,0.00")
//		tab_1.tabpage_2.dw_6.object.t_imposta.text=string(ldc_imposta, "#,0.00")
//		tab_1.tabpage_2.dw_6.object.t_totale.text=string(ldc_totale, "#,0.00")
		//fine 23-04-2016
	
//		tab_1.tabpage_2.dw_6.setredraw(true)
//		f_doc_excel(tab_1.tabpage_2.dw_6)
//	else
//		idw_riga.object.c_tot_righe.visible="0"
//		idw_riga.object.linea.visible="0"
//		idw_riga.object.c_tot_righe_t.visible="0"
//		idw_riga.object.c_tot_righe_lire_t.visible="0"
//		idw_riga.object.c_tot_righe_lire.visible="0"
//			
//		idw_riga.print()	
//		idw_riga.object.c_tot_righe.visible="1"
//		idw_riga.object.linea.visible="1"
//		idw_riga.object.c_tot_righe_t.visible="1"
//		idw_riga.object.c_tot_righe_lire_t.visible="1"
//		idw_riga.object.c_tot_righe_lire.visible="1"
//	
//	end if

end event

type dw_3 from udw_000 within w_st_prov_def_wz
integer x = 279
integer y = 488
integer width = 480
integer height = 112
integer taborder = 70
string dataobject = "d_ordinamento_rbol"
boolean border = false
string icon = "AppIcon!"
borderstyle borderstyle = stylebox!
end type

type st_3 from statictext within w_st_prov_def_wz
integer x = 37
integer y = 508
integer width = 251
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Ordina per:"
boolean focusrectangle = false
end type

type cb_salva_excel from commandbutton within w_st_prov_def_wz
integer x = 1577
integer y = 356
integer width = 338
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salva Excel"
end type

event clicked;int li_rtn, b
long ll_excel_rows, ll_righe, ll_id_sog
string ls_range, ls_art, ls_num_fattura, ls_des,ls_um, ls_coef_calo, ls_prezzo, ls_peso, ls_qta, ls_titolo,ls_simb_valuta
string ls_quotazione, ls_prezzo_man, ls_importo, ls_iva_codice, ls_aliquota,ls_rag_soc, ls_indirizzo, ls_cap_loc_prov
date ldt_data
integer i, a
decimal ldc_cambio
datastore ds_excel

oleobject lole_excel, lole_workbook, lole_worksheet, lole_range

lole_excel = create oleobject
li_rtn = lole_excel.ConnectToNewObject("excel.application")
if li_rtn <> 0 then
      MessageBox( "Error", 'Error running MS Excel api.')
      destroy lole_Excel
else
  lole_excel.WorkBooks.Open("C:\nita\excel\modello\fat_alpa_ok.xls") 


  lole_workbook = lole_excel.application.workbooks(1)
  lole_worksheet = lole_workbook.worksheets(1)

select num_documento, data_documento, id_sog_commerciale, simbolo, d.cambio
into :ls_num_fattura, :ldt_data, :ll_id_sog, :ls_simb_valuta, :ldc_cambio
from dba.documento d, dba.valuta v
where id_documento = :il_id_doc
and d.id_valuta=v.id_valuta
;

lole_worksheet.cells(3,10).value = string(ldt_data, "dd/mm/yyyy")
lole_worksheet.cells(4,10).value = ls_num_fattura

 select rag_soc_1, indirizzo, cap+' '+ localita+' '+ provincia
 into :ls_rag_soc, :ls_indirizzo, :ls_cap_loc_prov
 from dba.sog_commerciale_gen
 where id_sog_commerciale=:ll_id_sog
 ;
lole_worksheet.cells(3,3).value = ls_rag_soc
lole_worksheet.cells(4,3).value = ls_indirizzo
lole_worksheet.cells(5,3).value = ls_cap_loc_prov
 
  ds_excel=create datastore
  ds_excel.dataobject="d_esci_excel_st"
  ds_excel.settransobject(sqlca)
  ll_righe= ds_excel.retrieve(il_id_doc)
  // Set the cell value
 for a = 1 to ll_righe 
	if a=1 then
		ls_iva_codice=ds_excel.getitemstring(a, "tab_iva_codice")
		ls_aliquota=string(ds_excel.getitemdecimal(a, "per_aliquota"), "#,0.00")
		lole_worksheet.cells(53,10).value =ls_iva_codice
		lole_worksheet.cells(53,11).value =ls_aliquota
		lole_worksheet.cells(55,12).value =string(ldc_cambio, "#,0.0000")
		//lole_worksheet.cells(56,12).value =tot_doc_in_euro
		
	end if
	i=7+a  //le righe del corpo fattura iniziano all'ottavo rigo excel
	ls_art=ds_excel.getitemstring(a, "articolo_codice")
	ls_des=ds_excel.getitemstring(a, "descrizione")
	ls_um=ds_excel.getitemstring(a, "simbolo")
	ls_coef_calo=string(ds_excel.getitemdecimal(a, "coef_calo"), "#,0.00")
	ls_titolo=ds_excel.getitemstring(a, "orafo_metallo_codice")
	ls_titolo+=string(ds_excel.getitemdecimal(a, "orafo_titolo_titolo"), "#,0.00")
	ls_qta=string(ds_excel.getitemdecimal(a, "quantita"), "#,0.00")
	ls_peso=string(ds_excel.getitemdecimal(a, "peso_netto"), "#,0.00")
	
	ls_importo= string(ds_excel.getitemdecimal(a, "tot_riga_val_riga"), "#,0.00")
	ls_prezzo=ls_simb_valuta+". "+string(ds_excel.getitemdecimal(a, "prezzo_complessivo"), "#,0.0000")
	
	ls_prezzo_man=ls_simb_valuta+". "+string(ds_excel.getitemdecimal(a, "prezzo_manifattura"), "#,0.0000")
	if ls_prezzo_man>ls_prezzo then ls_prezzo=ls_prezzo_man
	ls_quotazione=ls_simb_valuta+". "+string(ds_excel.getitemdecimal(a, "prezzo_metallo"), "#,0.0000")
	
	lole_worksheet.cells(i,2).value = ls_art //string(ldt_data, "gg/mm/yyyy") //it is cells(line, column) 3, 10 data, 4,10 num_fattura
	lole_worksheet.cells(i,3).value = ls_des //it is cells(line, column)
	lole_worksheet.cells(i,5).value =ls_um
	lole_worksheet.cells(i,6).value =ls_coef_calo
	lole_worksheet.cells(i,7).value =ls_titolo
	lole_worksheet.cells(i,8).value =ls_qta
	lole_worksheet.cells(i,9).value =ls_peso
	lole_worksheet.cells(i,10).value =ls_prezzo //it is cells(line, column)
	lole_worksheet.cells(i,11).value =ls_quotazione
	lole_worksheet.cells(i,12).value =ls_importo //it is cells(line, column)
	
next
//lole_worksheet.cells(20,2).value = "Some value" //it is cells(line, column)
boolean lb_found
long ll_breakrow
datastore ds_riep_tit_alpa

ds_riep_tit_alpa=create datastore
ds_riep_tit_alpa.dataobject="d_riep_titoli_solo_fiscale_gd_alpa"
ds_riep_tit_alpa.settransobject(sqlca)
ll_righe=ds_riep_tit_alpa.retrieve(il_id_doc)
lb_found = false
ll_breakrow = 0
i++
DO WHILE NOT (lb_found)    
	
	ll_breakrow = ds_riep_tit_alpa.FindGroupChange(ll_breakrow, 1)    // If no breaks are found, exit.   
	IF ll_breakrow <= 0 THEN EXIT    // Have we found the section for Dept 121?   
	IF ds_riep_tit_alpa.GetItemstring(ll_breakrow, "orafo_metallo_codice") > " " THEN  
		b++
		i++
		if b=1 then
			lole_worksheet.cells(i,5).value ="Met."
			lole_worksheet.cells(i,6).value ="TIT."
			lole_worksheet.cells(i,7).value ="Legato"
			lole_worksheet.cells(i,8).value ="FINO"
			lole_worksheet.cells(i,9).value ="CALO"
			lole_worksheet.cells(i,10).value ="F+C"
			lole_worksheet.cells(i,11).value ="Quot."
			i++
		end if
		lole_worksheet.cells(i,5).value =ds_riep_tit_alpa.GetItemstring(ll_breakrow, "orafo_metallo_codice")  
		lole_worksheet.cells(i,6).value =ds_riep_tit_alpa.getitemdecimal(ll_breakrow,"orafo_titolo_titolo_1")
		lole_worksheet.cells(i,7).value ="g."+string(ds_riep_tit_alpa.getitemdecimal(ll_breakrow, "sum_legato"), "#,0.00")
		lole_worksheet.cells(i,8).value ="g."+string(ds_riep_tit_alpa.getitemdecimal(ll_breakrow, "sum_fino"), "#,0.00")
		lole_worksheet.cells(i,9).value ="g."+string(ds_riep_tit_alpa.getitemdecimal(ll_breakrow, "sum_calo11"), "#,0.00")
		lole_worksheet.cells(i,10).value ="g."+string(ds_riep_tit_alpa.getitemdecimal(ll_breakrow, "sum_fino_calo"), "#,0.00")
		lole_worksheet.cells(i,11).value =ls_simb_valuta+". "+string(ds_riep_tit_alpa.getitemdecimal(ll_breakrow, "riga_documento_prezzo_metallo"), "#,0.0000")
		
		
	END IF    // Increment starting row to find next break    
	ll_breakrow = ll_breakrow + 1
LOOP
 
 destroy ds_riep_tit_alpa
  
//ll_excel_rows=3
//  //example to work on a range of cells
////  ls_range = "A1:F"+string(ll_excel_rows)
////  lole_range = lole_worksheet.Range(ls_range)
////  lole_range.Select
////  lole_range.Locked = True

  // Save
  lole_workbook.saveas("c:\nita\excel\fat_"+ls_num_fattura+"_"+string(ldt_data, "dd-mm-yyyy")+".xls") //".xls" , 43) è il formato excel 97-2003
  // Quit
  lole_excel.application.quit()
  lole_excel.DisconnectObject()

  destroy lole_Excel
end if
end event

type cb_mail_old from commandbutton within w_st_prov_def_wz
integer x = 69
integer y = 1256
integer width = 270
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "MAIL"
end type

event clicked;
wf_invia_mail()
close(parent)
end event

type cb_new_pec from commandbutton within w_st_prov_def_wz
integer x = 1637
integer y = 768
integer width = 270
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pec"
end type

event clicked;dw_1.accepttext()
wf_mailsend("PEC")
close(parent)
end event

type cb_mail_new from commandbutton within w_st_prov_def_wz
integer x = 1632
integer y = 680
integer width = 270
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Invia MAIL"
end type

event clicked;
//wf_new_invia_mail()
wf_mailsend("MAIL")
close(parent)
end event

type rb_1 from radiobutton within w_st_prov_def_wz
integer x = 1723
integer y = 204
integer width = 174
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "&F.E."
boolean lefttext = true
end type

event clicked;string dwsyntax, ls_path_libreria, ls_art_mancanti, ls_path
string ls_des_prof, ls_COD_prof, ls_num_doc, ls_nome_file, ls_test
string ls_destinatario, ls_azienda, ls_testo, ls_indirizzo_e_mail
string ls_oggetto, ls_mail_cc,ls_mail_cc_2, ls_tipo_reg, ls_ret, ls_return
long ll_id_ana, ll_id_sog_com, ll_id_prof_doc
date ldt_data_doc
datastore ds_stampa
integer li_ret, li_num_righe, li_pos,li_pos_2

parent.height=1603
cb_stampa.enabled=false



select hub_ae
into :ls_indirizzo_e_mail
from dba.azienda;
if isnull(ls_indirizzo_e_mail) or ls_indirizzo_e_mail<=" " then
	messagebox("Attenzione!", "Inserire un indirizzo mail valido nei dati azienda campo 'hub_scelto'")
	return
end if

ls_nome_file=f_crea_fat_e(il_id_doc)
ls_oggetto=ls_nome_file
ls_testo=""  //o firma dell'azienda vedi poi
	
dw_1.insertrow(1)
dw_1.setitem(1, "destinatario", ls_indirizzo_e_mail)
dw_1.setitem(1, "cc", ls_mail_cc)
dw_1.setitem(1, "cc_2", ls_mail_cc_2)
dw_1.setitem(1, "oggetto", ls_oggetto)
dw_1.setitem(1, "allegati", ls_nome_file)
dw_1.setitem(1, "testo", ls_testo)



end event

type cbx_importo from checkbox within w_st_prov_def_wz
integer x = 27
integer y = 76
integer width = 402
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Senza Importo"
boolean lefttext = true
end type

type dw_uc from udw_base within w_st_prov_def_wz
integer x = 2135
integer y = 1180
integer width = 1143
integer taborder = 50
string dataobject = "ds_unita_confezione_2016"
end type

event retrievestart;call super::retrievestart;return 2
end event

type dw_art from udw_base within w_st_prov_def_wz
integer x = 2135
integer y = 796
integer width = 1623
integer taborder = 50
string dataobject = "ds_articolo_2016"
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_1 from commandbutton within w_st_prov_def_wz
integer x = 1637
integer y = 864
integer width = 270
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "PLUS"
end type

event clicked;wf_allega_file_doc()
end event

type cbx_brogliaccio from checkbox within w_st_prov_def_wz
integer x = 59
integer y = 172
integer width = 654
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Stampa anche brogliaccio"
boolean lefttext = true
end type

type cbx_prezzo from checkbox within w_st_prov_def_wz
integer x = 457
integer y = 80
integer width = 384
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Senza prezzo"
boolean lefttext = true
end type

event clicked;if checked then cbx_importo.checked=true
end event

type sle_report from singlelineedit within w_st_prov_def_wz
integer x = 873
integer y = 28
integer width = 814
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;is_nome_report=this.text
end event

type dw_2 from datawindow within w_st_prov_def_wz
integer x = 1065
integer y = 492
integer width = 695
integer height = 116
integer taborder = 70
string dataobject = "d_ordina_cr"
boolean border = false
boolean livescroll = true
end type

type rb_mail from radiobutton within w_st_prov_def_wz
integer x = 1403
integer y = 204
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&E-Mail"
boolean lefttext = true
end type

event clicked;string dwsyntax, ls_path_libreria, ls_art_mancanti, ls_path
string ls_des_prof, ls_COD_prof, ls_num_doc, ls_nome_file, ls_test
string ls_destinatario, ls_azienda, ls_testo, ls_indirizzo_e_mail
string ls_oggetto, ls_mail_cc,ls_mail_cc_2, ls_tipo_reg, ls_ret, ls_return
long ll_id_ana, ll_id_sog_com, ll_id_prof_doc, ll_len
date ldt_data_doc
datastore ds_stampa
integer li_ret, li_num_righe, li_pos,li_pos_2

//questo fa fatto sparire... con un if che se lo chiamo dal excel non lo fa...
parent.height=1800
cb_stampa.enabled=false
// questo sopra
select p.descrizione, a.rag_soc_1, az.rag_soc_1, a.id_anagrafica, p.codice,
 d.num_documento, d.data_documento

into :ls_des_prof, :ls_destinatario, :ls_azienda, :ll_id_ana, 
:ls_cod_prof, :ls_num_doc, :ldt_data_doc
from prof_documento p, documento d, sog_commerciale s, anagrafica a, azienda az
where a.id_anagrafica=s.id_anagrafica
and s.id_sog_commerciale=d.id_sog_commerciale
and p.id_prof_documento=d.id_prof_documento
and d.id_documento=:il_id_doc
and az.id_azienda=d.id_azienda;

ls_testo="Spettabile "+ls_destinatario+",~r~n"+&
"in allegato trasmettiamo "+ ls_des_prof+" in oggetto in formato PDF.~r~n"+ &
"QUESTA STAMPA È PRIVA DI VALENZA GIURIDICO-FISCALE AI SENSI DELL’ARTICOLO 21 DPR 633/72.~r~n"+&
"Per visualizzare l'allegato è necessario utilizzare Acrobat Reader (gratuitamente scaricabile presso "+&
"questo indirizzo:~r~nhttp://www.adobe.it/products/acrobat/readstep2.html).~r~n"+&
"Porgendo distinti saluti e ringraziando per la fiducia accordata, restiamo a completa "+&
"disposizione per ogni ulteriore informazione.~r~n~r~n"+&
ls_azienda+"~r~n"+&
"~r~n"+&
"~r~n"+&
"~r~n"+&
"Informativa Privacy: Ai sensi del D.Lgs n. 196/2003 (Codice Privacy)~r~n"+&
"si precisa che le informazioni contenute in questo messaggio~r~n"+&
"sono riservate e ad uso esclusivo del destinatario. ~r~n"+&
"Qualora il messaggio in parola Le fosse pervenuto per errore, ~r~n"+&
"La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,~r~n"+&
"dandocene gentilmente comunicazione. ~r~n"+&
"Grazie."


select num_riferimento
into :ls_indirizzo_e_mail
from telefono
where tipo='E'
and id_anagrafica=:ll_id_ana;
//300713 per ora gestisco solo 3 indirizzi: il primo in To e il secondo e il terzo in CC e cc_2
li_pos=pos(ls_indirizzo_e_mail, ";")
li_pos_2=pos(ls_indirizzo_e_mail, ";",li_pos+1 )
if li_pos_2>0 then //ci sono 3 indirizzi
	//su cc_2 ci metto il terzo
	ls_mail_cc_2=right(ls_indirizzo_e_mail, len(ls_indirizzo_e_mail) - li_pos_2)
	//tolgo l'indirizzo cc_2
	ls_indirizzo_e_mail=left(ls_indirizzo_e_mail, li_pos_2 -1)
end if
if li_pos>0 then
	ls_mail_cc=right(ls_indirizzo_e_mail, len(ls_indirizzo_e_mail) - li_pos)
	ls_indirizzo_e_mail=left(ls_indirizzo_e_mail, li_pos -1)
end if

select p.codice, d.num_documento, d.data_documento, d.id_sog_commerciale, d.id_prof_documento
	into :ls_cod_prof, :ls_num_doc, :ldt_data_doc, :ll_id_sog_com, :ll_id_prof_doc
	from prof_documento p, documento d
	where d.id_prof_documento=p.id_prof_documento
	and d.id_documento=:il_id_doc;
	
	//se è karizia e rbol e > 31-12-2018  16-7-2018 devo cambiare report da cambiare la data con quella per partire
	if cbx_sintetica.checked then
		//is_nome_report="d_ddt_rbol_e" //per esterni: samy 20201001
		is_nome_report=f_scegli_report(il_id_doc, is_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc) //anche qui occorre fare il giochino 20230612
	else
		is_nome_report=f_scegli_report(il_id_doc, is_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc)
	end if
	sle_report.text=is_nome_report
	sle_report.textcolor=255
	sle_report.Weight=700 //bold

////	ldt_data_doc=ds_stampa.getitemdate(1, "documento_data_documento")
//	if ldt_data_doc>= date("2018/12/31") and ll_id_sog_com=43 and upper(is_nome_report)='D_DDT_RBOL' and ll_id_prof_doc=66 then
//		is_nome_report+="167"
//	elseif ldt_data_doc>= date("2018/12/31") and ll_id_sog_com=43 and upper(is_nome_report)='D_DDT_RBOL' and &
//			(ll_id_prof_doc=114 or ll_id_prof_doc=150) then //e anche se è grbol e orbol
//			is_nome_report+="167"
//	end if



select codice, libreria
into :ls_test, :ls_path_libreria
from conf_oggetti
where codice= :is_nome_report;

if ls_path_libreria> " " then
	ls_oggetto=ls_cod_prof+" n. "+ls_num_doc+" del "+string(ldt_data_doc, "dd/mm/yyyy")

	
	


	dwsyntax = LibraryExport(ls_path_libreria, is_nome_report, ExportDataWindow!)
	IF dwsyntax>"" THEN
		ds_stampa=create datastore
		ds_stampa.create(dwsyntax)
		ds_stampa.settransobject(sqlca)
		li_num_righe=ds_stampa.retrieve(il_id_doc)
//		//16-03-2016 se  è una bolla (DV) e è stato attivato il flag "senza prezzo" rendo invisibile prezzo e importo
//		if cbx_prezzo.checked then
//			select tipo_registro
//			into :ls_tipo_reg
//			from dba.registro r, dba.documento d
//			where id_documento=:il_id_doc
//			and r.id_registro=d.id_registro
//			;
//			if ls_tipo_reg='DV' then
//				ls_ret=ds_stampa.modify("c_prezzo.visible=0")
//				ls_ret=ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
//				ls_ret=ds_stampa.modify("riga_documento_prezzo_metallo.visible=0")
//			end if
//		end if
		//16-03-2016 fine
		
		//090712 per samy: inserisco eventuali articoli mancanti al completamento del pronto
		ls_art_mancanti=f_controlla_pronto(il_id_doc)
		if ls_art_mancanti>" " then
			ds_stampa.modify("t_art_mancanti.text='"+ls_art_mancanti+"'")
		end if
		//fine 090712 per samy
	else
		messagebox("Errore!", "Dw di stampa "+is_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE'")
		return -1	
	end if
	
	
	select dir_output
	into :ls_path
	from orafo_par_sistema;
	if isnull(ls_path) or ls_path="" then
		messagebox("Attenzione!", "Specificare la directory di output nei parametri di sistema!")
		return -1
	end if
	if right(ls_path, 1)<>"\" then ls_path+="\"
	ls_nome_file=ls_path+ls_cod_prof+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf"
	ls_nome_file=wf_controlla_nome_file(ls_nome_file)
	//ls_test=ds_stampa.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
	select tipo_registro
	into :ls_tipo_reg
	from dba.registro r, dba.documento d
	where id_documento=:il_id_doc
	and r.id_registro=d.id_registro
	;
	if cbx_prezzo.checked then
		//16-03-2016 se  è una bolla (DV) e è stato attivato il flag "senza prezzo" rendo invisibile prezzo e importo
		if ls_tipo_reg='DV' then
			ds_stampa.Modify("c_prezzo.visible =0")
			ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
		end if
	end if
	//240713 se voglio che funga devo aggiungere la stampante da usare 
	//che deve essere una postscript (vedi esempio successivo)
	//dichiarazione intento nuova 2017-04-19
	If ls_tipo_reg='IV' then
		ll_id_ana=ds_stampa.getitemnumber(1, "id_anagrafica")
	//	ldt_data_doc=ds_stampa.getitemdate(1, "documento_data_documento")
		ls_return="Operazione non imponibile ai sensi dello Art. 8 2° C. D.P.R. 633 del 26/10/72 e modifiche successive  come  da Vs. dichiarazione di intento N. "&
		+f_dich_intento_2017(ll_id_ana, ldt_data_doc, "", il_id_doc)
		ds_stampa.modify("t_dich_intento.text='"+ls_return+"'") 
		//inserisco galvanica specchietto solo se è d_fattura_s2 silver 18-10-2019
		if cbx_galvanica.checked and is_nome_report="D_FATTURA_S2" then
				ds_stampa.modify("dw_galv.visible=true")
				ds_stampa.retrieve(il_id_doc)
		end if
	end if
	 //fine 2017-04-19
	ds_stampa.Modify("Export.PDF.Method = Distill!")
	ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	ds_stampa.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	
////	This example specifies an HP LaserJet PostScript printer as the printer to be used to export PDF with customized settings, and saves the data to a file called custom.pdf:
////
//int li_ret
//
// 
//
//		dw_1.Object.DataWindow.Export.PDF.Method = Distill!
//
//		dw_1.Object.DataWindow.Printer = "HP LaserJet 4Si/4Si MX PostScript"
//
//		dw_1.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
//
// 
//
//li_ret = dw_1.SaveAs("custom.pdf", PDF!, true)
//
////This example uses Modify to set the PDF export properties and specify a network printer:
//
//		dw_1.Modify("Export.PDF.Method = Distill!")
//
//		dw_1.Modify("Printer = '\\print-server\pr-18' ")
//
//		dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	//ordino secondo il flag impostato nella finestra 13/10/2021 richiesta Samy per Karizia
		if dw_3.getitemstring(1, "ordina") = "C" then
			ds_stampa.setsort("c_ordina_per_cliente, data_prev_consegna_1, c_num_pacco, riga_documento_id_riga_documento")
			ds_stampa.sort()
		end if		
	
	li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		//ds_stampa.Modify("DataWindow.Print.printername = 'Acrobat PDFWriter'")
		//ds_stampa.print()
		//wf_crea_mail(ls_nome_file, ls_oggetto)
		messagebox("Errore!", "File PDF non generato!")	
	else  //20230908 per LABELLA: ogni tanto crea pdf vuoto, allora controllo len del file e vedo se è pieno p no... altrimenti ristampo finché non lo fa bene!!!!!
		ll_len = FileLength64(ls_nome_file)
		do while ll_len <=3500
			li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
		loop
	end if
	//20230908 fine
	//28-04-2016
	if cbx_brogliaccio.checked then
		wf_stampa_brogliaccio(il_id_doc, ls_path+"BROGL_"+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf")
		ls_nome_file+=";"+ls_path+"BROGL_"+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf"
	end if
	//fine 28-04-2016
	destroy(ds_stampa)
	
	dw_1.insertrow(1)
	dw_1.setitem(1, "destinatario", ls_indirizzo_e_mail)
	dw_1.setitem(1, "cc", ls_mail_cc)
	dw_1.setitem(1, "cc_2", ls_mail_cc_2)
	dw_1.setitem(1, "oggetto", ls_oggetto)
	dw_1.setitem(1, "allegati", ls_nome_file)
	dw_1.setitem(1, "testo", ls_testo)
	return -100
else
	messagebox("Errore!", "Dw di stampa "+is_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE' ")
end if
end event

type st_1 from statictext within w_st_prov_def_wz
integer x = 750
integer y = 512
integer width = 160
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copie:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copie from editmask within w_st_prov_def_wz
integer x = 910
integer y = 500
integer width = 165
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#,0"
end type

type cbx_sintetica from checkbox within w_st_prov_def_wz
integer x = 439
integer y = 12
integer width = 407
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Stampa altern."
boolean lefttext = true
boolean threestate = true
end type

event clicked;
if cbx_sintetica.ThirdState  then 
	if pos(is_nome_report, "_SIN")>0 then
		is_nome_report=left(is_nome_report, len(is_nome_report) - 8) + "_BIS"
	else
		is_nome_report+="_BIS"
	end if
	sle_report.text=is_nome_report
elseif cbx_sintetica.checked  then
	if pos(is_nome_report, "_BIS")>0 then
		is_nome_report=left(is_nome_report, len(is_nome_report) - 4) + "_SIN"
	else
		is_nome_report+="_E"
	end if
	sle_report.text=is_nome_report
else
	if pos(is_nome_report, "_SIN")>0 or pos(is_nome_report, "_BIS")>0 then
		is_nome_report=left(is_nome_report, len(is_nome_report) - 4) 
	elseif right(is_nome_report, 4)="_SIN" then
		is_nome_report=left(is_nome_report, len(is_nome_report) - 4)
	elseif right(is_nome_report, 2)="_E" then
		is_nome_report=left(is_nome_report, len(is_nome_report) - 2)
	end if
	sle_report.text=is_nome_report
end if
end event

type ddlb_stampante from dropdownlistbox within w_st_prov_def_wz
integer x = 306
integer y = 384
integer width = 773
integer height = 444
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_stampante from statictext within w_st_prov_def_wz
integer x = 50
integer y = 400
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Stampante:"
boolean focusrectangle = false
end type

type rb_video from radiobutton within w_st_prov_def_wz
integer x = 1134
integer y = 204
integer width = 224
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "&Video"
boolean checked = true
boolean lefttext = true
end type

event clicked;il_stvi = 1

if rb_def.checked then
	rb_prov.checked = true
end if	
rb_def.enabled					= false
ddlb_stampante.enabled 		= false
cb_printer_setup.enabled 	= false


parent.height=750
cb_stampa.enabled=true
end event

type rb_stampa from radiobutton within w_st_prov_def_wz
integer x = 846
integer y = 204
integer width = 242
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "&Stampa"
boolean lefttext = true
end type

event clicked;il_stvi = 0

rb_def.enabled					= true
ddlb_stampante.enabled 		= true
cb_printer_setup.enabled 	= true
em_copie.enabled=true

parent.height=750
cb_stampa.enabled=true
end event

type rb_def from radiobutton within w_st_prov_def_wz
boolean visible = false
integer x = 439
integer y = 336
integer width = 361
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "St.&Definitiva"
boolean lefttext = true
end type

event clicked;il_prov_def = 1
end event

type rb_prov from radiobutton within w_st_prov_def_wz
boolean visible = false
integer x = 439
integer y = 388
integer width = 288
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "St.&Provv."
boolean checked = true
boolean lefttext = true
end type

event clicked;il_prov_def = 0
end event

type cb_stampa from commandbutton within w_st_prov_def_wz
integer x = 1696
integer y = 28
integer width = 224
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;CHOOSE CASE il_prov_def
	CASE 0
		CHOOSE CASE il_stvi
			CASE 0
				il_ret_code = 2
			CASE 1
				il_ret_code = 0
		END CHOOSE			
	CASE 1
		CHOOSE CASE il_stvi
			CASE 0
				il_ret_code = 3
			CASE 1
				il_ret_code = 1
		END CHOOSE			
END CHOOSE				

il_ret_code=wf_set_printer_info()

if il_ret_code<> -100 then
	close (parent)
end if
end event

type cb_annulla from commandbutton within w_st_prov_def_wz
integer x = 27
integer width = 265
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;il_ret_code = -1

close (parent)
end event

type gb_stvi from groupbox within w_st_prov_def_wz
integer x = 827
integer y = 140
integer width = 1102
integer height = 180
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
end type

type cb_old_pec from commandbutton within w_st_prov_def_wz
integer x = 69
integer y = 1364
integer width = 270
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "PEC"
end type

event clicked;dw_1.accepttext()
wf_new_invia_mail()
close(parent)
end event

type cb_printer_setup from commandbutton within w_st_prov_def_wz
integer x = 1088
integer y = 384
integer width = 210
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Setup"
end type

event clicked;
string	ls_printer_name
//u_freddie.iuo_stampa.of_setup_printer()
//ls_printer_name	= u_freddie.iuo_stampa.of_get_dev_printer_name()
if ls_printer_name <> "" then
	ddlb_stampante.Text	= ls_printer_name
end if

end event

type st_2 from statictext within w_st_prov_def_wz
integer x = 1225
integer y = 440
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ordina per"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_st_prov_def_wz
integer x = 23
integer y = 320
integer width = 1911
integer height = 288
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from udw_base within w_st_prov_def_wz
integer x = 23
integer y = 656
integer width = 1911
integer height = 908
integer taborder = 20
string dataobject = "d_posta_ex"
boolean vscrollbar = false
end type

event clicked;//mailsession lms_sess
//mailmessage lm_mess
//mailrecipient lm_recipient
//mailFileDescription lmf_file
//mailreturncode lmc_rc
//integer	mRet
//string ls_ind_mail, ls_campo
//
//if dwo.name="destinatario_sw"  or dwo.name="cc_sw"then
//	ls_campo=left(string(dwo.name), len(string(dwo.name)) - 3)
//	
//	lms_sess = create mailsession
//	lmc_rc = lms_Sess.mailLogon()
//	IF lmc_rc = mailReturnSuccess! THEN
//	ls_ind_mail=dw_1.getitemstring(1, ls_campo)	
//	lm_recipient.Address = ls_ind_mail
//		
//		lmc_rc = lms_sess.mailResolveRecipient(lm_recipient)
//
//		IF lmc_rc = mailReturnSuccess! THEN
//		
//			dw_1.setitem(1, ls_campo, lm_recipient.Address)
//		
//		ELSEIF lmc_rc = mailReturnFailure! THEN
//		
//			 MessageBox("INDIRIZZO MAIL", "Spiacente, indirizzo NON trovato in rubrica.")
//		
//		ELSE
//		
//			 MessageBox("Address", "Request not evaluated.")
//		
//		END IF
//		
//	else
//		MessageBox("Mail", 'Logon failed.')
//	END IF
//	
//	
//		
//	lms_Sess.mailLogoff()
//	
//	DESTROY lms_sess
//	
//end if
end event

type cbx_galvanica from checkbox within w_st_prov_def_wz
integer x = 59
integer y = 240
integer width = 654
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Vedi Galv. in fattura"
boolean lefttext = true
end type

type gb_provdef from groupbox within w_st_prov_def_wz
integer x = 32
integer y = 140
integer width = 791
integer height = 180
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
end type

