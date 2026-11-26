forward
global type w_orafo_cancella_documenti2_cx from w_canc_documenti2_cx
end type
type cb_1 from commandbutton within tab_seleziona
end type
type dw_2 from u_dw_pura within tab_seleziona
end type
type cb_duplica from commandbutton within w_orafo_cancella_documenti2_cx
end type
end forward

global type w_orafo_cancella_documenti2_cx from w_canc_documenti2_cx
integer height = 2180
string title = "Cancellazione Documenti Orafo"
cb_duplica cb_duplica
end type
global w_orafo_cancella_documenti2_cx w_orafo_cancella_documenti2_cx

forward prototypes
public subroutine wf_cancella_aper_partita (long al_id_doc, long al_id_titolo, decimal ad_val_scarico, ref datastore adw_aper)
public subroutine wf_cancella_partite (ref datastore adw_scar, ref datastore adw_aper, long al_id_riga_partita)
public function integer wf_carica_datastore (ref s_par_record lsrt1_par_documento)
end prototypes

public subroutine wf_cancella_aper_partita (long al_id_doc, long al_id_titolo, decimal ad_val_scarico, ref datastore adw_aper);
long ll_riga_trovata
decimal{2} ld_aper

ll_riga_trovata=adw_aper.find("id_documento="+string(al_id_doc)&
					+ " and id_titolo="+string(al_id_titolo), 1, adw_aper.rowcount())

if  ll_riga_trovata>0 then
	ld_aper=adw_aper.getitemdecimal(ll_riga_trovata, "val_apertura")
	if ld_aper > ad_val_scarico then
		ld_aper= ld_aper - ad_val_scarico
		adw_aper.setitem(ll_riga_trovata, "val_scarico", ld_aper)
	else
		adw_aper.deleterow(ll_riga_trovata)
	end if
end if
end subroutine

public subroutine wf_cancella_partite (ref datastore adw_scar, ref datastore adw_aper, long al_id_riga_partita);
long ll_riga_trovata, ll_id_partita
decimal{2} ld_val_scarico, ld_val_scar_attuale, ld_val_aper
string ls_stato

ll_riga_trovata=adw_scar.find("id_riga_documento="+string(al_id_riga_partita), 1, adw_scar.rowcount())
if ll_riga_trovata<1 then 
	messagebox("Errore!", "Non trovato scarico da cancellare!")
	return
end if
do while ll_riga_trovata>0
	
	ld_val_scarico = adw_scar.getitemdecimal(ll_riga_trovata, "val_scarico")
	
	ll_id_partita=adw_scar.getitemnumber(ll_riga_trovata, "id_partita")
	
	adw_scar.deleterow(ll_riga_trovata)
	
	ll_riga_trovata=adw_aper.find("id_partita="+string(ll_id_partita), 1, adw_aper.rowcount())
	if ll_riga_trovata < 1 then 
		messagebox("Errore!", "Non trovata partita da aggiornare!")
		return
	end if
	
	ld_val_scar_attuale=adw_aper.getitemdecimal(ll_riga_trovata, "val_scarico")
	ls_stato=adw_aper.getitemstring(ll_riga_trovata, "stato")
	if ld_val_scar_attuale<ld_val_scarico then 
		messagebox("Errore!", "Lo scarico è negativo, nessuna operazione effettuata!")
		return
	
	
	elseif ld_val_scar_attuale=ld_val_scarico and ls_stato='Z' or isnull(ls_stato) then
		ld_val_aper=adw_aper.getitemdecimal(ll_riga_trovata, "val_apertura")
		adw_aper.setitem(ll_riga_trovata, "val_apertura", ld_val_aper - ld_val_scarico)
	end if
	
	adw_aper.setitem(ll_riga_trovata, "val_scarico", ld_val_scar_attuale - ld_val_scarico)
	if ld_val_scarico >0 then adw_aper.setitem(ll_riga_trovata, "stato", 'A')
	
	ll_riga_trovata=adw_scar.find("id_riga_documento="+string(al_id_riga_partita), 1, adw_scar.rowcount())
loop

end subroutine

public function integer wf_carica_datastore (ref s_par_record lsrt1_par_documento);long ll_id_sog, ll_id_caus_magazzino, ll_id_riga_partita, ll_id_titolo, ll_righe
string ls_cod_tipo_partita
integer i
decimal{2} ld_fino_calo
datetime ldt_data_ora


select id_caus_magazzino, id_sog_commerciale, data_ora_creazione
into :ll_id_caus_magazzino, :ll_id_sog, :ldt_data_ora
from documento
where id_documento=:lsrt1_par_documento.id_tabella;
if ll_id_caus_magazzino>0 and not isnull(ll_id_caus_magazzino) then

	select cod_tipo_partita
	into :ls_cod_tipo_partita
	from  orafo_tipo_partita,  caus_magazzino
	where id_caus_magazzino=:ll_id_caus_magazzino
	and orafo_tipo_partita.id_tipo_partita=caus_magazzino.id_tipo_partita;
	if ls_cod_tipo_partita>"" and not isnull(ls_cod_tipo_partita) then
		if left(ls_cod_tipo_partita, 1) = 'A' or left(ls_cod_tipo_partita, 1)='S' then
			if not isvalid(lsrt1_par_documento.s_dw_aper_partita) then
				lsrt1_par_documento.s_dw_aper_partita = create datastore 
				lsrt1_par_documento.s_dw_scar_partita = create datastore
				lsrt1_par_documento.s_dw_aper_partita.dataobject = "ds_orafo_part_aperte" 
				lsrt1_par_documento.s_dw_scar_partita.dataobject = "ds_orafo_partite_scarico_doc"
				lsrt1_par_documento.s_dw_aper_partita.settransobject(sqlca)
				lsrt1_par_documento.s_dw_scar_partita.settransobject(sqlca)
				lsrt1_par_documento.s_dw_aper_partita.retrieve(ll_id_sog, ldt_data_ora)
				lsrt1_par_documento.s_dw_scar_partita.RETRIEVE(lsrt1_par_documento.id_tabella)
				datastore ds_righe
				ds_righe=create datastore
				ds_righe.dataobject='ds_orafo_righe_da_cancellare'
				ds_righe.settransobject(sqlca)
				ds_righe.retrieve(lsrt1_par_documento.id_tabella)
				ll_righe=ds_righe.rowcount()
				if ll_righe>0 then
					if left(ls_cod_tipo_partita, 1) = 'A' then
						for i =1 to ll_righe
							ll_id_titolo=ds_righe.getitemnumber(i, "id_titolo")
							ld_fino_calo=ds_righe.getitemdecimal(i, "fino")
							ld_fino_calo =ld_fino_calo + ds_righe.getitemdecimal(i, "calo")
							wf_cancella_aper_partita(lsrt1_par_documento.id_tabella, ll_id_titolo, ld_fino_calo, lsrt1_par_documento.s_dw_aper_partita)
						next
					elseif left(ls_cod_tipo_partita, 1) = 'S' then
						for i =1 to ll_righe
							ll_id_riga_partita=ds_righe.getitemnumber(i, "id_riga_partita")
							wf_cancella_partite(lsrt1_par_documento.s_dw_scar_partita, lsrt1_par_documento.s_dw_aper_partita, ll_id_riga_partita)
						next
					end if
				end if
			end if
		end if
	else
		
		return 1
	end if
end if 
return 1


end function

on w_orafo_cancella_documenti2_cx.create
int iCurrent
call super::create
this.cb_duplica=create cb_duplica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_duplica
end on

on w_orafo_cancella_documenti2_cx.destroy
call super::destroy
destroy(this.cb_duplica)
end on

event open;call super::open;tab_distinta.tab_seleziona.dw_2.settransobject(sqlca)
tab_distinta.tab_seleziona.dw_2.retrieve()
end event

type cb_chiudi from w_canc_documenti2_cx`cb_chiudi within w_orafo_cancella_documenti2_cx
integer taborder = 30
end type

type cb_crea from w_canc_documenti2_cx`cb_crea within w_orafo_cancella_documenti2_cx
end type

event cb_crea::clicked;call super::clicked;

end event

type tab_distinta from w_canc_documenti2_cx`tab_distinta within w_orafo_cancella_documenti2_cx
integer height = 2020
integer taborder = 40
end type

event tab_distinta::selectionchanged;call super::selectionchanged;if newindex=2 then
	cb_crea.enabled=true
else
	cb_crea.enabled=false
end if
	
end event

type tab_filtri from w_canc_documenti2_cx`tab_filtri within tab_distinta
integer height = 1900
end type

type dw_filtro_ff from w_canc_documenti2_cx`dw_filtro_ff within tab_filtri
end type

event dw_filtro_ff::itemchanged;string ls_test
if dwo.name='da_profilo' then
	ls_test=getitemstring(1, "a_profilo")
	if ls_test>="" or isnull(ls_test) then
		setitem(1, "a_profilo", upper(data))
	end if
end if
end event

type dw_1 from w_canc_documenti2_cx`dw_1 within tab_filtri
end type

type tab_seleziona from w_canc_documenti2_cx`tab_seleziona within tab_distinta
integer height = 1900
cb_1 cb_1
dw_2 dw_2
end type

on tab_seleziona.create
this.cb_1=create cb_1
this.dw_2=create dw_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
end on

on tab_seleziona.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
end on

type cb_drop_all from w_canc_documenti2_cx`cb_drop_all within tab_seleziona
end type

type cb_drop_many from w_canc_documenti2_cx`cb_drop_many within tab_seleziona
end type

type cb_remove_many from w_canc_documenti2_cx`cb_remove_many within tab_seleziona
end type

type cb_remove_all from w_canc_documenti2_cx`cb_remove_all within tab_seleziona
end type

type st_1 from w_canc_documenti2_cx`st_1 within tab_seleziona
string text = "0"
end type

type st_2 from w_canc_documenti2_cx`st_2 within tab_seleziona
end type

type dw_recuperati_lt from w_canc_documenti2_cx`dw_recuperati_lt within tab_seleziona
integer x = 73
end type

event dw_recuperati_lt::retrieveend;st_1.text=string(rowcount)
end event

type st_4 from w_canc_documenti2_cx`st_4 within tab_seleziona
integer x = 2702
integer y = 1120
end type

type dw_selezionati_lt from w_canc_documenti2_cx`dw_selezionati_lt within tab_seleziona
end type

type st_3 from w_canc_documenti2_cx`st_3 within tab_seleziona
integer x = 2597
integer y = 1204
integer width = 521
string text = "Doc. da cancellare"
end type

type cb_stampa from w_canc_documenti2_cx`cb_stampa within w_orafo_cancella_documenti2_cx
integer x = 992
integer taborder = 20
end type

type cb_1 from commandbutton within tab_seleziona
integer x = 1824
integer y = 1124
integer width = 718
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scollega Documento Derivato"
end type

event clicked;integer i, a, li_num_righe, li_num_righe_der, e, li_ret
long ll_id_doc, ll_null, ll_id_riga
datastore ds_righe, ds_riga_derivata

setnull(ll_null)

ds_righe=create datastore
ds_righe.dataobject='d_scollega_riga_ds'
ds_righe.settransobject(sqlca)

ds_riga_derivata=create datastore
ds_riga_derivata.dataobject='ds_trova_righe_derivate'
ds_riga_derivata.settransobject(sqlca)

FOR i= 1 to dw_selezionati_lt.rowcount()
	ll_id_doc=dw_selezionati_lt.getitemnumber(i, "documento_id_documento")
	li_num_righe=ds_righe.retrieve(ll_id_doc)
	for a= 1 to li_num_righe
		ds_righe.setitem(a, "qta_evasa", 0)
		ds_righe.setitem(a, "qta_evasa_un_base", 0)
		ds_righe.setitem(a, "peso_netto_evaso", 0)
		ll_id_riga=ds_righe.getitemnumber(a, "id_riga_documento")
		li_num_righe_der=ds_riga_derivata.retrieve(ll_id_riga)
		FOR e=1 to li_num_righe_der
			ds_riga_derivata.setitem(e, "id_riga_doc_provenienza", ll_null)
			if ds_riga_derivata.update()=1 then
				COMMIT;
			ELSE
				ROLLBACK;
				messagebox("Errore!", SQLCA.SQLErrText)
				
				EXIT
			END IF
		NEXT
		
	next
	li_ret=0
	if li_num_righe>0 then li_ret= ds_righe.update() 
		
		sqlca.triggers_on_off('off');
		update documento
		set evaso_totalmente='N'
		where id_documento=:ll_id_doc;
		
		if sqlca.sqlcode=0 then
			commit;
			//messagebox("OK", "ok")
			sqlca.triggers_on_off('on');
		else
			rollback;
			messagebox("Errore!", SQLCA.SQLErrText)
			
		end if
		sqlca.triggers_on_off('on');
	

NEXT
sqlca.triggers_on_off('on');
destroy ds_righe
end event

type dw_2 from u_dw_pura within tab_seleziona
integer x = 101
integer y = 1288
integer width = 3013
integer height = 604
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_prof_doc_caus_magazzino_gd"
boolean vscrollbar = true
end type

type cb_duplica from commandbutton within w_orafo_cancella_documenti2_cx
integer x = 2117
integer y = 24
integer width = 361
integer height = 92
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Duplica"
end type

event clicked;integer i, a
long ll_id_doc, ll_null, ll_riga_corrente, ll_righe, ll_id_reg
long ll_id_prof, ll_id_caus, ll_new_id_doc, ll_num_prog, ll_id_mod_reg
datastore ds_doc, ds_riga
setnull(ll_null)
date ldt_data_doc
string ls_num_doc

ds_doc=create datastore
ds_doc.dataobject='d_orafo_documento_ordine_retrieve_ff'
ds_doc.settransobject(sqlca)

ds_riga=create datastore
ds_riga.dataobject="d_orafo_riga_documento_ordine_gd"
ds_riga.settransobject(sqlca)

ll_riga_corrente=tab_distinta.tab_seleziona.dw_2.getrow()
ll_id_prof=tab_distinta.tab_seleziona.dw_2.getitemnumber(ll_riga_corrente, "id_prof_documento")
ll_id_caus=tab_distinta.tab_seleziona.dw_2.getitemnumber(ll_riga_corrente, "id_caus_magazzino")
ll_id_mod_reg=tab_distinta.tab_seleziona.dw_2.getitemnumber(ll_riga_corrente, "id_mod_registro_prop")
	
for i= 1 to tab_distinta.tab_seleziona.dw_selezionati_lt.rowcount()
	ll_id_doc=tab_distinta.tab_seleziona.dw_selezionati_lt.getitemnumber(i,"documento_id_documento")
	ldt_data_doc=tab_distinta.tab_seleziona.dw_selezionati_lt.getitemdate(i,"documento_data_documento")
	//ls_num_doc=tab_distinta.tab_seleziona.dw_selezionati_lt.getitemstring(i,"documento_num_documento")
		
	select id_registro
	into :ll_id_reg
	from registro r, esercizio e
	where e.data_inizio<= :ldt_data_doc
	and e.data_fine>=:ldt_data_doc
	and e.id_esercizio=r.id_esercizio
	and id_mod_registro=:ll_id_mod_reg
	;
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where id_registro=:ll_id_reg
	;
	if isnull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	ds_doc.retrieve(ll_id_doc)
	
	ds_doc.setitem(1, "id_documento", ll_null)
	ds_doc.setitem(1, "id_prof_documento", ll_id_prof)
	ds_doc.setitem(1, "documento_id_caus_magazzino", ll_id_caus)
	ds_doc.setitem(1, "num_progressivo", ll_num_prog)
	ds_doc.setitem(1, "data_registrazione", today())
	ds_doc.setitem(1, "id_registro", ll_id_reg)
	ds_doc.setitem(1, "documento_contabilizzato", "N")
	
	ds_doc.SetItemStatus(1, 0, Primary!, NewModified!)
	if ds_doc.update()= 1 then
		commit;
		SELECT @@identity 
		INTO :ll_new_id_doc
		FROM "dba"."documento";
	
			//ds_doc.getitemnumber(ds_doc.GETROW(), "id_documento")
		ll_righe=ds_riga.RETRIEVE(ll_id_doc)
		for a= 1 to ll_righe
			ds_riga.setitem(a, "riga_documento_id_caus_magazzino", ll_id_caus)
			ds_riga.setitem(a, "id_riga_documento", ll_null)
			ds_riga.setitem(a, "id_documento", ll_new_id_doc)
			ds_riga.SetItemStatus(a, 0, Primary!, NewModified!)
		next
		if ds_riga.update()=1 then
		commit;
		else
			rollback;
			messagebox("Attenzione!", "Errore Salvataggio Righe!")
		end if
		else
			rollback;
		end if
next
destroy ds_doc
destroy ds_riga



end event

