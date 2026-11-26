forward
global type w_cancella_documento_wz from w_cancella_record_wz
end type
end forward

global type w_cancella_documento_wz from w_cancella_record_wz
end type
global w_cancella_documento_wz w_cancella_documento_wz

on w_cancella_documento_wz.create
call w_cancella_record_wz::create
end on

on w_cancella_documento_wz.destroy
call w_cancella_record_wz::destroy
end on

event ue_set_property;call super::ue_set_property;string 	ls_tipo_registro, ls_tipo_fattura, ls_title
long 		ll_id_registro, ll_num_progressivo, ll_row
date		ld_data_registrazione

if istr_par_record.nome_tabella = "documento" then
	select documento.num_progressivo,
			 documento.id_registro, 
			 documento.data_registrazione,
			 documento.tipo_fattura
	into:ll_num_progressivo,
		  	:ll_id_registro,
			:ld_data_registrazione,
			:ls_tipo_fattura
	from dba.documento  
	where documento.id_documento = :istr_par_record.id_tabella  ;
	
	
	If IsNull(ll_num_progressivo) then ll_num_progressivo=0
	if not IsNull(ll_id_registro) then 
		SELECT registro.tipo_registro
			INTO :ls_tipo_registro  
			FROM dba.registro  
			WHERE registro.id_registro = :ll_id_registro  ;
		CHOOSE CASE left(ls_tipo_registro, 1)
			CASE "O"
				ls_title =	"Ordine" 
			CASE "I"
				ls_title =	"Fattura" 
			CASE "D"
				ls_title =	"Bolla-DDT"
			CASE "P"
				if right(ls_tipo_registro, 1) = "N" then
					ls_title =	"Prima Nota" 
				else
					ls_title =	"Preventivo" 
				end if
			CASE "L"	
				ls_title =	"Lista Prelievo" 
			CASE "G"	
				ls_title =	"Generico" 
			CASE "M"	
				ls_title =	"Manageriale" 
		END CHOOSE
		CHOOSE CASE right(ls_tipo_registro, 1)
			CASE "A"
				ls_title = ls_title + " Acquisti"
			CASE "V"
				ls_title = ls_title + " Vendite"
			CASE "C"
				ls_title = ls_title + " Corrispettivi"
		END CHOOSE
		ls_title = ls_title + " " + ls_tipo_registro
	end if
	If ll_num_progressivo <> 0 then ls_title= ls_title + " - Nr. " + string(ll_num_progressivo)
	
	If not (IsNull(ld_data_registrazione)) then ls_title= ls_title + " del " + string(ld_data_registrazione, "dd/mm/yyyy")
	CHOOSE CASE ls_tipo_fattura
		CASE "C"
			ls_title = "Nota di Accredito - " + ls_title
		CASE "D"
			ls_title = "Nota di Addebito - " + ls_title
	END CHOOSE
else
	
	ll_row = This.dw_cancella_record_lt.Find("tabella = '" + istr_par_record.nome_tabella + &
				"'", 1, This.dw_cancella_record_lt.RowCount())
	ls_title = "Cancellazione da tabella " + &
					This.dw_cancella_record_lt.GetItemString(ll_row, "nome_tabella")
end if

is_title = ls_title

end event

event dw_cancella_record_lt::ue_controlla_master;call super::ue_controlla_master;

string	ls_retval, ls_c, ls_s, ls_b, ls_e, ls_text

ls_retval = "S"

select documento.contabilizzato,   
       documento.sospeso,   
       documento.bloccato,   
       documento.evaso_totalmente 
 into :ls_c,   
      :ls_s,   
      :ls_b,   
      :ls_e  
 from dba.documento  
 where documento.id_documento = :istr_par_record.id_tabella
 using SQLCA;


ls_text = "~rE' impossibile cancellare il documento perchè:"

if ls_c = "S" then
	ls_text = ls_text + "~r     documento è stato contabilizzato"
	ls_retval = "N"
end if	

if ls_s = "S" then
	ls_text = ls_text + "~r     documento è stato sospeso"
	ls_retval = "N"
end if

if ls_b = "S" then
	ls_text = ls_text + "~r     documento è stato bloccato"
	ls_retval = "N"
end if	

if ls_e = "S" then
	ls_text = ls_text + "~r     documento è stato evaso totalmente"
	ls_retval = "N"
end if	

if ls_retval = "N" then
	ls_text = ls_text + "."
	st_controlla_documento.Text = ls_text
	st_controlla_documento.Visible = True
	is_message_error	= ls_text
end if

Return ls_retval


end event

event dw_cancella_record_lt::ue_controlla_children;call super::ue_controlla_children;

datastore	lds_controllo
datawindow	ldw_controllo
string		ls_retval = "S", ls_esito_pagamento, ls_nome_tabella, ls_message
dec{4} 		lc_qta_evasa, lc_qta_commessa
long 			ll_row, ll_rows, ll_id_riga_documento, ll_id_con_riga_documento, &
				ll_id_scadenza

lds_controllo = CREATE datastore
if Not IsValid(lds_controllo) then
	MessageBox("Errore Critico", "Impossibile creare DataStore per tabelle di supporto.")
	Return "N"
end if

ls_message = "~rE' impossibile cancellare il documento perchè :"

CHOOSE CASE as_figlia
	CASE "riga_documento"
		lds_controllo.DataObject 	= 'd_riga_documento_canc_lt'
		ls_nome_tabella 				= "Riga del Documento"
		ls_message 						= ls_message + "~resiste una quantità evasa nella riga documento"
		ldw_controllo 					= dw_controllo_riga
	CASE "scadenza"
		lds_controllo.DataObject 	= 'd_scadenza_documento_canc_lt'
		ls_nome_tabella 				= "Scadenza"
		ls_message 						= ls_message + "~rl'esito del pagamento nelle scadenze è diverso da EMESSO"
		ldw_controllo 					= dw_controllo_scadenza
	CASE "con_riga_documento"
		lds_controllo.DataObject 	= 'd_con_riga_documento_canc_lt'
		ls_nome_tabella 				= "Consegne per Riga Doc."
		ls_message 						= ls_message+ "~resiste una quantità commessa"
		ldw_controllo 					= dw_controllo_con_riga
END CHOOSE

lds_controllo.SetTransObject( SQLCA )
ll_rows = lds_controllo.Retrieve(al_id)
IF ll_rows < 1 THEN
	Return "S"
end if

CHOOSE CASE as_figlia
	CASE "riga_documento"
		declare lcur_riga_documento cursor for
		  SELECT distinct qta_evasa, id_riga_documento
			 FROM riga_documento
			 WHERE ( riga_documento.id_documento = :al_id ) ;
		open lcur_riga_documento;
		if sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error-1!", sqlca.sqlerrtext, exclamation!)
			return "N"
		end if 
		
		do while sqlca.sqlcode = 0
			fetch lcur_riga_documento into :lc_qta_evasa, :ll_id_riga_documento ;
			if sqlca.sqlcode = 0 then
				
				if lc_qta_evasa <> 0 then
					ls_retval = "N"
					ll_row = lds_controllo.Find("id_riga_documento = "+ string(ll_id_riga_documento), 1, ll_rows)
					if ll_row > 0 then
						lds_controllo.SetItem(ll_row, "c_filtro", 1)
					end if
				end if
			elseif sqlca.sqlcode < 0 then
				MessageBox ("DataBase Error-2!", sqlca.sqlerrtext, exclamation!)
				return "N"
			end if
		loop
		close lcur_riga_documento;
	CASE "scadenza"
		declare lcur_scadenza cursor for
		  SELECT distinct esito_pagamento, id_scadenza
			 FROM scadenza
			 WHERE ( scadenza.id_documento = :al_id ) ;
		open lcur_scadenza;
		if sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error-1!", sqlca.sqlerrtext, exclamation!)
			return "N"
		end if 
		
		do while sqlca.sqlcode = 0
			fetch lcur_scadenza into :ls_esito_pagamento, :ll_id_scadenza ;
			if sqlca.sqlcode = 0 then
				
				if ls_esito_pagamento <> "E" then
					ls_retval = "N"
					ll_row = lds_controllo.Find("id_scadenza = "+ string(ll_id_scadenza), 1, ll_rows)
					if ll_row > 0 then
						lds_controllo.SetItem(ll_row, "c_filtro", 1)
					end if
				end if
			elseif sqlca.sqlcode < 0 then
				MessageBox ("DataBase Error-2!", sqlca.sqlerrtext, exclamation!)
				return "N"
			end if
		loop
		close lcur_scadenza;	
	CASE "con_riga_documento"
		declare lcur_con_riga_documento cursor for
		  SELECT distinct qta_commessa, id_con_riga_documento
			 FROM dba.con_riga_documento
			 WHERE ( con_riga_documento.id_riga_documento_produzione = :al_id ) ;
		open lcur_con_riga_documento;
		if sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error-1!", sqlca.sqlerrtext, exclamation!)
			return "N"
		end if 
		
		do while sqlca.sqlcode = 0
			fetch lcur_con_riga_documento into :lc_qta_commessa, :ll_id_con_riga_documento ;
			if sqlca.sqlcode = 0 then
				
				if lc_qta_commessa <> 0 then
					ls_retval = "N"
					ll_row = lds_controllo.Find("id_con_riga_documento = "+ string(ll_id_con_riga_documento), 1, ll_rows)
					if ll_row > 0 then
						lds_controllo.SetItem(ll_row, "c_filtro", 1)
					end if
				end if
			elseif sqlca.sqlcode < 0 then
				MessageBox ("DataBase Error-2!", sqlca.sqlerrtext, exclamation!)
				return "N"
			end if
		loop
		close lcur_con_riga_documento;
	CASE ELSE
		Return "-1"
END CHOOSE

if ls_retval = "N" then
	
	lds_controllo.SetFilter("c_filtro = 1")
	lds_controllo.Filter()
	ldw_controllo.DataObject = lds_controllo.DataObject
	lds_controllo.ShareData(ldw_controllo)
	ldw_controllo.Title = "Tabella : " + ls_nome_tabella + "." + ls_message
	ldw_controllo.Visible = True
	
	is_message_error	= ls_message
	
	if IsValid(lds_controllo) then
		destroy lds_controllo
	end if
		
else
	if IsValid(lds_controllo) then
		destroy lds_controllo
	end if
end if

Return ls_retval

end event

type dw_controllo_riga from w_cancella_record_wz`dw_controllo_riga within w_cancella_documento_wz
boolean BringToTop=true
end type

type dw_controllo_scadenza from w_cancella_record_wz`dw_controllo_scadenza within w_cancella_documento_wz
boolean BringToTop=true
end type

type st_canc_in_corso from w_cancella_record_wz`st_canc_in_corso within w_cancella_documento_wz
boolean BringToTop=true
end type

