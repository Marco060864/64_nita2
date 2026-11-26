forward
global type w_elenco_ordini from w_001
end type
type dw_1 from udw_base within w_elenco_ordini
end type
type cb_ok from commandbutton within w_elenco_ordini
end type
type cb_annulla from commandbutton within w_elenco_ordini
end type
end forward

global type w_elenco_ordini from w_001
integer width = 2921
integer height = 1776
string title = "Scegli un Ordine"
windowtype windowtype = response!
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_elenco_ordini w_elenco_ordini

on w_elenco_ordini.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_annulla
end on

on w_elenco_ordini.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;SETREDRAW(FALSE)
dw_1.settransobject(sqlca)
dw_1.retrieve()
SETREDRAW(TRUE)
end event

type st_1 from w_001`st_1 within w_elenco_ordini
end type

type dw_1 from udw_base within w_elenco_ordini
integer x = 41
integer y = 32
integer width = 2825
integer height = 1352
boolean bringtotop = true
string dataobject = "d_elenco_ordini"
end type

type cb_ok from commandbutton within w_elenco_ordini
integer x = 2514
integer y = 1428
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;long ll_id_doc, ll_n_doc_record,  ll_id_sog, ll_id_art
long ll_trovata,ll_id_var,ll_id_riga, ll_riga_selezionata
string ls_sintax,  ls_cod_cliente, ls_des, ls_imm, ls_rif, ls_articolo
integer li_righe, i,li_riga_inserita,li_st_ogni_riga
decimal ld_peso, ld_lunghezza, ld_qta, ld_prezzo, ld_peso_unitario, ldc_sconto_riga_perc
date ldt_data_prev_consegna

ll_riga_selezionata=dw_1.getrow()
if ll_riga_selezionata>0 then
	ll_id_doc=dw_1.getitemnumber(ll_riga_selezionata, "documento_id_documento")
else
	return 0
end if
datastore ds_recupera, ds_doc, ds_doc_righe
ds_recupera=create datastore
ds_recupera.dataobject="d_foto_art_da_documento"
//carico il doc
ds_doc=create datastore
ds_doc.dataobject="d_documento_ordine_ff"
ds_doc.settransobject(sqlca)
ls_sintax=ds_doc.getsqlselect()
ds_doc.setsqlselect(ls_sintax + " and documento.id_documento= "+string(ll_id_doc))
ll_n_doc_record=ds_doc.retrieve()
//carico i valori relativi al documento

ls_rif="Rif. Doc.: "+ds_doc.getitemstring(1, "num_documento")
ls_rif+=" - "+ string(ds_doc.getitemdate(1, "data_documento"))
ll_id_sog=ds_doc.getitemnumber(1, "id_sog_commerciale")
//aggiungo la data scadenza dell'ordine (data_prev_consegna)
ldt_data_prev_consegna=ds_doc.getitemdate(1, "data_prev_consegna")
if ldt_data_prev_consegna>date('1900-01-01') THEN
	ls_rif+=" - Data Consegna: "+ string(ldt_data_prev_consegna)
END IF

select codice
into :ls_cod_cliente
from sog_commerciale
where id_sog_commerciale=:ll_id_sog;
//carico le righe- articoli da stampare
ds_doc_righe=create datastore
ds_doc_righe.dataobject="d_orafo_riga_documento_ordine_gd"
ds_doc_righe.settransobject(sqlca)
li_righe=ds_doc_righe.retrieve(ll_id_doc)
//carico i valori degli articoli

//integer li_righe, i, li_riga_inserita, li_st_ogni_riga
//
//ls_articolo, ls_des, ls_imm, ls_rif 
//long , , ll_trovata, ll_id_var,ll_id_riga

//li_st_ogni_riga=messagebox("Attenzione!", "Vuoi raggruppare codici uguali?", stopsign!, yesno!)


for i= 1 to li_righe
	ll_id_art=ds_doc_righe.getitemnumber(i, "riga_documento_id_articolo")
	
	if ll_id_art>0 then
		select codice
		into :ls_articolo
		from dba.articolo
		where id_articolo=:ll_id_art
		;
		ld_peso=ds_doc_righe.getitemdecimal(i, "riga_documento_peso_netto")
		ld_qta=ds_doc_righe.getitemdecimal(i, "quantita")
		if ld_qta>0 then
			ld_peso_unitario=ld_peso/ld_qta
		else
			ld_peso_unitario=0
		end if
		ld_lunghezza=ds_doc_righe.getitemdecimal(i, "riga_documento_dim_l")
		ld_prezzo=ds_doc_righe.getitemdecimal(i, "prezzo_manifattura")
//		//aggiungo 110207: se non c'è manifattura prendo il complessivo
		if isnull(ld_prezzo) or ld_prezzo=0 then ld_prezzo=ds_doc_righe.getitemdecimal(i, "prezzo_complessivo")
//		//fine aggiunta 110206
		ls_des=ds_doc_righe.getitemstring(i, "riga_documento_descrizione")
//		
		ls_imm=f_trova_immagine(ll_id_sog, ll_id_art)
		if ls_imm="" then
			select immagine
			into :ls_imm 
			from articolo
			where id_articolo=:ll_id_art;
		end if
   	ll_id_var=ds_doc_righe.getitemnumber(i, "riga_documento_id_listino")
		ll_id_riga=ds_doc_righe.getitemnumber(i, "id_riga_documento")
		ldc_sconto_riga_perc=dec(ds_doc_righe.getitemstring(i, "sconto"))
//		
		li_riga_inserita=ds_recupera.insertrow(0)
		ds_recupera.setitem(li_riga_inserita, "cod_articolo", ls_articolo)
		ds_recupera.setitem(li_riga_inserita, "Lunghezza", ld_lunghezza)
		ds_recupera.setitem(li_riga_inserita, "peso_totale", ld_peso)
		ds_recupera.setitem(li_riga_inserita, "peso_unitario", ld_peso_unitario)
		ds_recupera.setitem(li_riga_inserita, "prezzo", ld_prezzo)
		ds_recupera.setitem(li_riga_inserita, "des_articolo", ls_des)
		ds_recupera.setitem(li_riga_inserita, "nome_immagine", ls_imm)
		ds_recupera.setitem(li_riga_inserita, "rif_doc", ls_rif)
		ds_recupera.setitem(li_riga_inserita, "id_sog_commerciale",ll_id_sog)
		ds_recupera.setitem(li_riga_inserita, "id_articolo",ll_id_art)
		ds_recupera.setitem(li_riga_inserita, "qta",ld_qta)
		ds_recupera.setitem(li_riga_inserita, "listino",ll_id_var)
		
		
		ds_recupera.setitem(li_riga_inserita, "id_riga_documento",ll_id_riga)
		ds_recupera.setitem(li_riga_inserita,"sconto", ldc_sconto_riga_perc)
		
		if li_st_ogni_riga=1 then
			ll_trovata=ds_recupera.find("cod_articolo='"+ls_articolo+"'", 1, i -1)
			if ll_trovata>0 then
				ds_recupera.setitem(li_riga_inserita, "num_riga", ll_trovata)
			else
				ds_recupera.setitem(li_riga_inserita, "num_riga", i)
			end if
		else
			ds_recupera.setitem(li_riga_inserita, "num_riga", i)
		end if
	end if
next

if li_righe>0 then
	closewithreturn(parent, ds_recupera)
end if
//destroy(ds_recupera)
destroy(ds_doc_righe)
destroy(ds_doc)

end event

type cb_annulla from commandbutton within w_elenco_ordini
integer x = 46
integer y = 1428
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;CLOSE(PARENT)
end event

