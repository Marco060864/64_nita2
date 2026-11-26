forward
global type u_lotti_uso_generale from nonvisualobject
end type
end forward

global type u_lotti_uso_generale from nonvisualobject
end type
global u_lotti_uso_generale u_lotti_uso_generale

forward prototypes
public subroutine uf_canc_lotto_prod (long al_id_lotto)
end prototypes

public subroutine uf_canc_lotto_prod (long al_id_lotto);
string 		ls_tipo_lotto
integer		li_ret
long			ll_id_documento_CL = 0
long			ll_id_documento_SL = 0
long			ll_rows
decimal {0} ld_num_prog_CL
decimal {0} ld_num_prog_SL
date			ldt_data_reg_CL
date			ldt_data_reg_SL

SELECT tipo_lotto
INTO	 :ls_tipo_lotto
FROM	 lotto
WHERE  id_lotto = :al_id_lotto
;

if (SQLCA.SQLCODE	= -1) then 
	messagebox("DBError", SQLCA.SQLERRTEXT)
	return
end if

if (ls_tipo_lotto <> 'K' and ls_tipo_lotto <> 'Z') then 
	messagebox("Attenzione", "E' possibile cancellare solamente i lotti di produzione")
	return
end if

SELECT COUNT(*)
INTO	 :li_ret
FROM	 riga_doc_lotto l, riga_documento r, documento d, prof_documento p
WHERE  l.id_lotto = :al_id_lotto
AND	 r.id_riga_lotto = l.id_riga_lotto 
AND    d.id_documento = r.id_documento
AND    p.id_prof_documento = d.id_prof_documento
AND	 p.codice <> 'CL'
;

if (SQLCA.SQLCODE	= -1) then 
	messagebox("DBError", SQLCA.SQLERRTEXT)
	return
end if

if li_ret > 0 then 
	messagebox("Attenzione", "Il lotto scelto è stato usato nei documenti")
	return
end if	


DATASTORE lds_docsl_mp_gd
lds_docsl_mp_gd = CREATE datastore
lds_docsl_mp_gd.dataobject = "ds_docsl_mp_gd"
lds_docsl_mp_gd.settransobject(sqlca)
ll_rows = lds_docsl_mp_gd.retrieve(al_id_lotto)
if (ll_rows > 0) then 
	ll_id_documento_SL = lds_docsl_mp_gd.getitemnumber(1, "id_documento")
	ld_num_prog_SL = lds_docsl_mp_gd.getitemnumber(1, "num_progressivo")
	ldt_data_reg_SL = lds_docsl_mp_gd.getitemdate(1, "data_registrazione")
end if
	
DESTROY lds_docsl_mp_gd

if ll_id_documento_SL > 0 then 
	
	
	DELETE FROM cast_iva_documento
	WHERE id_documento = :ll_id_documento_SL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if

	DELETE FROM cast_cpt_documento
	WHERE id_documento = :ll_id_documento_SL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	
	DELETE FROM riga_doc_lotto rl
	FROM	 riga_documento r
	WHERE  r.id_documento = :ll_id_documento_SL
	AND	 rl.id_riga_lotto = r.id_riga_lotto
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	
	
	DELETE FROM movimenti_lotto m
	FROM	 lotto l
	WHERE  l.id_lotto = :al_id_lotto
	AND	 m.num_lotto_prod = l.numero
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	DELETE FROM riga_documento
	WHERE id_documento = :ll_id_documento_SL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	DELETE FROM documento
	WHERE id_documento = :ll_id_documento_SL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	COMMIT USING SQLCA;
	if (SQLCA.SQLCODE = -1) then
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if		
end if




DATASTORE lds_doccl_pf_gd
lds_doccl_pf_gd = CREATE datastore
lds_doccl_pf_gd.dataobject = "ds_doccl_pf_gd"
lds_doccl_pf_gd.settransobject(sqlca)
ll_rows = lds_doccl_pf_gd.retrieve(al_id_lotto)
if (ll_rows > 0) then
	ll_id_documento_CL = lds_doccl_pf_gd.getitemnumber(1, "id_documento")
	ld_num_prog_CL = lds_doccl_pf_gd.getitemnumber(1, "num_progressivo")
	ldt_data_reg_CL = lds_doccl_pf_gd.getitemdate(1, "data_registrazione")
end if

DESTROY lds_doccl_pf_gd

if (ll_id_documento_CL > 0) then
	
	
	DELETE FROM cast_iva_documento
	WHERE id_documento = :ll_id_documento_CL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if

	DELETE FROM cast_cpt_documento
	WHERE id_documento = :ll_id_documento_CL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	
	DELETE FROM riga_documento 
	WHERE  id_documento = :ll_id_documento_CL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	DELETE FROM documento
	WHERE  id_documento = :ll_id_documento_CL
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if
	
	
	DELETE FROM riga_doc_lotto
	WHERE id_lotto = :al_id_lotto
	;
	
	if (SQLCA.SQLCODE	= -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if

	COMMIT USING SQLCA;
	if (SQLCA.SQLCODE = -1) then
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK USING SQLCA;
		return
	end if		
end if

DELETE FROM lotto
WHERE id_lotto = :al_id_lotto
;

if (SQLCA.SQLCODE	= -1) then 
	messagebox("DBError", SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA;
	return
end if

COMMIT USING SQLCA;
if (SQLCA.SQLCODE = -1) then
	messagebox("DBError", SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA;
	return
end if		

messagebox("Cancellazione Lotto", "La cancellazione del lotto è andata a buon fine.~n" + &
			  "Sono stati correttamente cancellati:~n" + &
			  " . Documento SL " + string(ld_num_prog_SL) + " del " + string(ldt_data_reg_SL) + " di scarico delle Materie Prime.~n" + &
			  " . Documento CL " + string(ld_num_prog_CL) + " del " + string(ldt_data_reg_CL) + " di carico del Prodotto Finito.~n" + &
			  " . Lotto di prodotto finito")

end subroutine

on u_lotti_uso_generale.create
TriggerEvent( this, "constructor" )
end on

on u_lotti_uso_generale.destroy
TriggerEvent( this, "destructor" )
end on

