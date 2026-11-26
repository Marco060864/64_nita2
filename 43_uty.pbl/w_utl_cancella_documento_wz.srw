forward
global type w_utl_cancella_documento_wz from w_cancella_record_wz
end type
end forward

global type w_utl_cancella_documento_wz from w_cancella_record_wz
end type
global w_utl_cancella_documento_wz w_utl_cancella_documento_wz

on w_utl_cancella_documento_wz.create
call w_cancella_record_wz::create
end on

on w_utl_cancella_documento_wz.destroy
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

event open;
long			ll_row, ll_tvi
string		ls_message, ls_SN
string		ls_args[]

istr_par_record	= Message.PowerObjectParm

iuo_msg_log = create uo_msg_log
iuo_msg_log.uf_new_text("Sessione del " + String(Today()) + " - " + String(Now()),2)

This.dw_cancella_record_lt.Event ue_insert_table()

TriggerEvent("ue_set_property")
this.title	= is_title


ls_args[1] = istr_par_record.nome_tabella
ls_args[2] = istr_par_record.nome_id_tabella
ls_args[3] = string(istr_par_record.id_tabella)
ls_args[4] = ""
ls_args[5] = ""
ls_args[6] = ""
ls_args[7] = ""

if this.dw_cancella_record_lt.Event ue_controlla_master() = "N" then
	wf_uscita()	
	CloseWithReturn(this,0)
	return 0
end if

ids_cd = CREATE datastore
if Not IsValid(ids_cd) then
	MessageBox("Errore Critico", "Impossibile creare DataStore per cancellazione.")
	Return
else
	ids_cd.DataObject = 'd_cancella_record_lt'	
end if

ll_row = This.dw_cancella_record_lt.Find("tabella = '" + ls_args[1] + &
			"'", 1, This.dw_cancella_record_lt.RowCount())		
			
if ll_row > 0 then
	
	wf_recurse_record(istr_par_record.nome_tabella,istr_par_record.id_tabella, "", 0, 0)
	
	if ib_recurse_ok = false then
		CloseWithReturn(this,0)
		return 0		
	end if
	
	This.dw_cancella_record_lt.SetItem(ll_row, "num_righe", 1)
	This.dw_cancella_record_lt.SetItem(ll_row, "priorita", 0)
	This.dw_cancella_record_lt.SetItem(ll_row, "visibile", "1")

	wf_insert_row_ds(ls_args[1],ls_args[2],long(ls_args[3]),ls_args[4],long(ls_args[5]),ls_args[6],long(ls_args[7]),0)

	This.dw_cancella_record_lt.SetFilter("visibile = '1'")
	This.dw_cancella_record_lt.Filter()

	This.wf_populate_tv(ls_args[1], 0)
	ll_tvi = This.tv_canc.FindItem(RootTreeItem! , 0)
	This.tv_canc.ExpandAll(ll_tvi)
	
	iuo_msg_log.uf_new_text("Per cancellare le righe solo da una tabella - spostare la tabella nel cestino.", 3)
	tv_canc.SetFocus()
end if


if istr_par_record.visible = true then
	this.visible = true
else	
	cb_ok.triggerevent ("clicked")
end if	



end event

type cb_ok from w_cancella_record_wz`cb_ok within w_utl_cancella_documento_wz
int X=42
end type

event cb_ok::clicked;
long		ll_rows, ll_i, ll_id_1, ll_id_2, ll_id_3,ll_ret
string	ls_tabella, ls_id_1, ls_id_2, ls_id_3
string	ls_sqlstatement
integer	li_ret
s_dberr	lstr_dberr
window	lw_err

pointer  lp_oldpointer  

ids_cd.Sort()
ll_rows = ids_cd.RowCount()
if ll_rows > 0 then
	ids_cd.Sort()
	
	li_ret	=1
					
					
	if li_ret = 1 then
		
		integer i
				if isvalid(istr_par_record.s_dw_aper_partita) then
					i=istr_par_record.s_dw_scar_partita.update()
					if i<>1 then 
						rollback using SQLCA;  //20261028 prima usciva senza rollback
						messagebox("Attenzione!", "Partite scarico collegate non salvate: operazione annullata")
						if IsValid(ids_cd) then
							destroy ids_cd
						end if
						CloseWithReturn(Parent, 0)
						return
					end if
				
					i=istr_par_record.s_dw_aper_partita.update()
					if i<>1 then 
						rollback using SQLCA;  //20261028 prima usciva senza rollback: restavano gli scarichi gia' cancellati
						messagebox("Attenzione!", "Partite APERTURA collegate non salvate: operazione annullata")
						if IsValid(ids_cd) then
							destroy ids_cd
						end if
						CloseWithReturn(Parent, 0)
						return
						
					end if
				end if
			
		lp_oldpointer = SetPointer(HourGlass!)
		if istr_par_record.visible = false then
			parent.x		 						= 1130
			parent.y							 	= 1000
			parent.height 						= 300
			parent.width	 					= 1300
			cb_anulla.visible					= false
			cb_ok.visible						= false
			cb_uscire.visible					= false
			dw_cancella_record_lt.visible	= false
			dw_controllo_con_riga.visible	= false
			dw_controllo_riga.visible		= false
			dw_controllo_scadenza.visible	= false
			p_msg_log.visible					= false
			tv_canc.visible					= false
			st_controlla_documento.visible = false
			parent.visible					 	= true
			st_canc_in_corso.visible 		= true
		end if	

		for ll_i = 1 to ll_rows
			
			if ll_ret = 0 then
				ls_tabella 	= ids_cd.GetItemString(ll_i, "tabella")
				ls_id_1	 	= ids_cd.GetItemString(ll_i, "id_tabella")
				ls_id_2 		= ids_cd.GetItemString(ll_i, "id_foreign")
				ls_id_3 		= ids_cd.GetItemString(ll_i, "padre")
				ll_id_1 		= ids_cd.GetItemNumber(ll_i, "id_1")
				ll_id_2 		= ids_cd.GetItemNumber(ll_i, "id_2")
				ll_id_3 		= ids_cd.GetItemNumber(ll_i, "id_3")
				
				
				if ls_tabella="riga_doc_lotto" then
					wf_cancella_lotto(ll_id_1, ll_id_2)
				end if
		

				ls_sqlstatement = "DELETE FROM " + ls_tabella + " WHERE ( " + ls_tabella + "." + ls_id_1 + "=?"
				
				if ll_id_2 > 0 then
					ls_sqlstatement	= ls_sqlstatement + " AND " + ls_tabella + "." + ls_id_2 + "=?"
				end if
				
				if ll_id_3 > 0 then
					ls_sqlstatement	= ls_sqlstatement + " AND " + ls_tabella + "." + ls_id_3 + "=?"
				end if
					ls_sqlstatement	= ls_sqlstatement + " )"

				prepare SQLSA from :ls_sqlstatement ;

				if sqlca.sqlcode = -1 then
					lstr_dberr.l_sqlcode 	= sqlca.sqlcode
					lstr_dberr.s_sqlerrtext = sqlca.sqlerrtext
					OpenWithParm(lw_err,lstr_dberr,"w_db_err")
					ll_ret = -1
				end if
			
			
				if sqlca.sqlcode = 0 then
					if ll_id_1 > 0 and ll_id_2 = 0 and ll_id_3 = 0 then
						execute SQLSA using :ll_id_1;
					end if	
		
					if ll_id_2 > 0 and ll_id_3 = 0 then
						execute SQLSA using :ll_id_1, :ll_id_2 ;
					end if
				
					if ll_id_3 > 0 then
						execute SQLSA using :ll_id_1, :ll_id_2, :ll_id_3 ;
					end if
		
					if sqlca.sqlcode = -1 then
						lstr_dberr.l_sqlcode 	= sqlca.sqlcode
						lstr_dberr.s_sqlerrtext = sqlca.sqlerrtext
						OpenWithParm(lw_err,lstr_dberr,"w_db_err")
						ll_ret = -1
					end if	
				
				end if
			end if
		next

		if ll_ret = 0 then
			commit using SQLCA;
		else
			rollback using SQLCA;
		end if
		
		if sqlca.sqlcode = -1 then
			lstr_dberr.l_sqlcode 	= sqlca.sqlcode
			lstr_dberr.s_sqlerrtext = sqlca.sqlerrtext
			OpenWithParm(lw_err,lstr_dberr,"w_db_err")
		end if	

		SetPointer(lp_oldpointer)
		CloseWithReturn(Parent, 1)
	else	
		if IsValid(ids_cd) then
			destroy ids_cd
		end if
		CloseWithReturn(Parent, 0)
	end if
	
else
	
	if IsValid(ids_cd) then
		destroy ids_cd
	end if
	CloseWithReturn(Parent, 0)
end if
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

type dw_controllo_riga from w_cancella_record_wz`dw_controllo_riga within w_utl_cancella_documento_wz
boolean BringToTop=true
end type

type dw_controllo_scadenza from w_cancella_record_wz`dw_controllo_scadenza within w_utl_cancella_documento_wz
boolean BringToTop=true
end type

type st_canc_in_corso from w_cancella_record_wz`st_canc_in_corso within w_utl_cancella_documento_wz
boolean BringToTop=true
end type

