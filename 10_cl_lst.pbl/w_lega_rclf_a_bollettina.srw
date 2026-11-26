forward
global type w_lega_rclf_a_bollettina from w_001
end type
type dw_1 from udw_base within w_lega_rclf_a_bollettina
end type
type dw_2 from udw_base within w_lega_rclf_a_bollettina
end type
type dw_4 from udw_base within w_lega_rclf_a_bollettina
end type
type cb_crea_doc from commandbutton within w_lega_rclf_a_bollettina
end type
type dw_3 from udw_base within w_lega_rclf_a_bollettina
end type
type cb_cancella from commandbutton within w_lega_rclf_a_bollettina
end type
type dw_5 from udw_base within w_lega_rclf_a_bollettina
end type
end forward

global type w_lega_rclf_a_bollettina from w_001
integer width = 3054
integer height = 1962
dw_1 dw_1
dw_2 dw_2
dw_4 dw_4
cb_crea_doc cb_crea_doc
dw_3 dw_3
cb_cancella cb_cancella
dw_5 dw_5
end type
global w_lega_rclf_a_bollettina w_lega_rclf_a_bollettina

forward prototypes
public subroutine wf_inserisci_righe (long al_id_doc, long al_id_caus)
public function integer wf_controlla_se_esiste (long al_id_registro)
end prototypes

public subroutine wf_inserisci_righe (long al_id_doc, long al_id_caus);long ll_id_riga_provenienza, ll_null
integer i, li_ret

setnull(ll_null)

for i = 1 to dw_3.rowcount()
	ll_id_riga_provenienza=dw_3.getitemnumber(i, "id_riga_documento")
	dw_3.setitem(i, "provv_imp_subage_2", ll_null)
	dw_3.setitem(i, "id_riga_doc_provenienza", ll_id_riga_provenienza)
	dw_3.setitem(i, "id_riga_documento", ll_null)
	dw_3.setitem(i, "id_documento", al_id_doc)
	dw_3.setitem(i, "id_caus_magazzino", al_id_caus)
	dw_3.setitem(i, "num_riga", i)
	dw_3.setitemstatus(i, 0, primary!, NewModified!)
next

li_ret=dw_3.trigger event ue_update()
if li_ret=1 then
	
else
	messagebox("Attenzione!", "Salvataggio RIGHE NON riuscito!")
end if
end subroutine

public function integer wf_controlla_se_esiste (long al_id_registro);string ls_num_doc
long ll_id_sog, ll_id_doc

ll_id_sog=dw_2.getitemnumber(1, "id_sog_commerciale")
ls_num_doc=dw_2.getitemstring(1, "num_documento")
select id_documento
into :ll_id_doc
from dba.documento
where id_registro=:al_id_registro
and id_sog_commerciale=:ll_id_sog
and num_documento=:ls_num_doc
;

if ll_id_doc>0 then
	messagebox("Attenzione!", "Il documento num. "+ls_num_doc+" intestato a "+string(ll_id_sog) +" ESISTE già!")
	return 0
else
	return 1
end if
	
end function

on w_lega_rclf_a_bollettina.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_4=create dw_4
this.cb_crea_doc=create cb_crea_doc
this.dw_3=create dw_3
this.cb_cancella=create cb_cancella
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cb_crea_doc
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.dw_5
end on

on w_lega_rclf_a_bollettina.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.cb_crea_doc)
destroy(this.dw_3)
destroy(this.cb_cancella)
destroy(this.dw_5)
end on

event open;call super::open;datawindowchild dwc_prof

dw_1.insertrow(1)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.insertrow(1)
dw_4.getchild("id_prof_doc", dwc_prof)
dwc_prof.settransobject(sqlca)
dwc_prof.retrieve()

dw_1.post setfocus()



end event

type st_1 from w_001`st_1 within w_lega_rclf_a_bollettina
end type

type dw_1 from udw_base within w_lega_rclf_a_bollettina
integer x = 1112
integer y = 29
integer width = 903
integer height = 259
boolean bringtotop = true
string dataobject = "d_cod_barre_rclf_bol"
boolean vscrollbar = false
end type

event editchanged;call super::editchanged;long ll_id_bollettina, ll_riga_trovata, ll_id_riga_rclf, ll_id_sog, ll_riga_ext
string ls_num_doc, ls_num_bol, ls_fornitore, ls_prof_doc
integer li_ret, i, li_num_riga
long ll_prog
datastore ds_trova_bol_pacco
ds_trova_bol_pacco=create datastore
	
ds_trova_bol_pacco.dataobject="d_trova_bollettina_pacco"
ds_trova_bol_pacco.settransobject(sqlca)
if dwo.name="cod_barre" and len(data)=7 then  //il codice a barre è un EAN7
	if dw_2.rowcount()> 0 then ll_id_sog=dw_2.getitemnumber(1, "id_sog_commerciale")
		
	ls_num_doc=mid(data, 3, 5)
	ll_riga_trovata=ds_trova_bol_pacco.retrieve(ls_num_doc)
	if ll_riga_trovata>0 then
		if ll_riga_trovata>1 then
	
		else
			ll_id_bollettina=ds_trova_bol_pacco.getitemnumber(1, "id_riga_documento")
			if ll_id_bollettina>0 then
				ll_riga_trovata=dw_3.find("provv_imp_subage_2="+string(ll_id_bollettina), 1, dw_3.rowcount())
				if ll_riga_trovata>0 then
					messagebox("Attenzione!", "Questa bollettina è già stata inserita!")
					return
				end if
				li_ret=dw_3.retrieve(ll_id_bollettina)
				if li_ret>0 then
					//if li_ret>1 then
						//messagebox("Attenzione!", "Questa bollettina ha generato più di 1 SALD!")
//						for i= 1 to li_ret
//							ll_id_riga_rclf=dw_3.getitemnumber(li_ret, "id_documento")
//							select p.codice, d.num_progressivo, r.num_riga
//							into :ls_prof_doc, :ll_prog, :li_num_riga
//							from dba.prof_documento p, documento d, riga_documento r
//							where d.id_prof_documento=p.id_prof_documento
//							and r.id_documento=d.id_documento
//							and d.id_documento=:ll_id_riga_rclf
//							;
//							ll_riga_ext=dw_5.insertrow(0)
//							dw_5.setitem(ll_riga_ext, "num_bollettina", data)
//							dw_5.setitem(ll_riga_ext, "Esito", ls_prof_doc+" - n. "+string(ll_prog)+" - riga: "+string(li_num_riga))
//						next
						//return
					//else
						ll_id_riga_rclf=dw_3.getitemnumber(li_ret, "id_documento")
						ll_riga_ext=dw_5.insertrow(0)
						dw_5.setitem(ll_riga_ext, "num_bollettina", data)
						dw_5.setitem(ll_riga_ext, "Esito", "OK! Trovata!")
					//end if
					
				//	if li_ret>1 then 	messagebox("Attenzione!", "La bollettina ha generato più di un doc. di produzione!")
				end if
//				//trovo l'id_documento da copiare (in genere è un sald o npsald)
//				select id_documento
//				into :ll_id_riga_rclf
//				from dba.riga_documento
//				where provv_imp_subage_2= :ll_id_bollettina
//				;
				if ll_id_riga_rclf>0 then
					//se trovo il doc lo carico
					
					li_ret=dw_2.retrieve(ll_id_riga_rclf)
					
					if ll_id_sog>0 and ll_id_sog<> dw_2.getitemnumber(1, "id_sog_commerciale") then
						messagebox("Attenzione!", "Il fornitore è cambiato! Stai mischiando i documenti di un fornitore con quelli di un altro!")
					end if
					//e carico anche le sue righe
					//li_ret=dw_3.retrieve(ll_id_riga_rclf)
				else
					messagebox("Attenzione!", "RCLF: "+ls_num_doc+" non trovato!")
				end if
			else
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
			end if
			dw_1.reset()
			dw_1.insertrow(1)
			dw_1.setfocus()
			dw_1.setcolumn("cod_barre")
		end if
	else
		ll_riga_ext=dw_5.insertrow(0)
		dw_5.setitem(ll_riga_ext, "num_bollettina", data)
		dw_5.setitem(ll_riga_ext, "Esito", "NON Trovata!")
	end if
end if
end event

type dw_2 from udw_base within w_lega_rclf_a_bollettina
integer x = 11
integer y = 426
integer width = 2033
integer height = 362
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_vedi_bollettina"
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type dw_4 from udw_base within w_lega_rclf_a_bollettina
integer x = 26
integer y = 22
integer width = 1064
integer height = 224
boolean bringtotop = true
string dataobject = "d_da_data_a_Data_bollettine"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type cb_crea_doc from commandbutton within w_lega_rclf_a_bollettina
integer x = 2081
integer y = 669
integer width = 413
integer height = 118
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Crea RCLF"
end type

event clicked;date ldt_data
long ll_null, ll_id_prof_doc, ll_id_caus, ll_id_registro
long ll_num_prog, ll_id_mod_registro, ll_id_doc_rclf
string ls_num_doc
integer li_ret

setnull(ll_null)

dw_2.setitem(1, "id_documento", ll_null)
ll_id_prof_doc=dw_4.getitemnumber(1, "id_prof_doc")
ldt_data=dw_4.getitemdate(1, "data_doc")
if ll_id_prof_doc>0 and ldt_data>date('1900-01-01') then
	
	select id_caus_magazzino_prop, id_mod_registro_prop
	into :ll_id_caus, :ll_id_mod_registro
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof_doc
	;
	select r.id_registro, r.num_progressivo
	into :ll_id_registro, :ll_num_prog
	from dba.registro r, esercizio e
	where r.id_mod_registro=:ll_id_mod_registro
	and e.data_inizio<=:ldt_data
	and e.data_fine>=:ldt_data
	and r.id_esercizio=e.id_esercizio
	;

	dw_2.setitem(1, "id_prof_documento", ll_id_prof_doc)
	dw_2.setitem(1, "id_caus_magazzino", ll_id_caus)
	dw_2.setitem(1, "id_registro", ll_id_registro)
	dw_2.setitem(1, "num_progressivo", ll_num_prog)
	dw_2.setitem(1, "num_documento", string(ll_num_prog))
	dw_2.setitem(1, "data_registrazione", today())
	dw_2.setitem(1, "data_documento", ldt_data)
	
	//cambio status alla riga (newinsert)
	dw_2.setitemstatus(1, 0, primary!, NewModified!)
	
	li_ret=wf_controlla_se_esiste(ll_id_registro)
	
	if li_ret=0 then //il doc esiste già
		if messagebox("Attenzione!", "Vuoi creare lo stesso il documento?", stopsign!, yesno! )=2 then return 
	end if
	li_ret=dw_2.trigger event ue_update()
	if li_ret=1 then
		ll_id_doc_rclf=dw_2.getitemnumber(1, "id_documento")
		wf_inserisci_righe(ll_id_doc_rclf, ll_id_caus)
	else
		messagebox("Attenzione!", "Salvataggio Testa NON riuscito!")
	end if

else
	messagebox("Attenzione!", "Inserire il profilo documento!")
end if




end event

type dw_3 from udw_base within w_lega_rclf_a_bollettina
integer x = 11
integer y = 806
integer width = 2962
integer height = 730
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_riga_doc_rclf_gd"
end type

event retrievestart;call super::retrievestart;return 2
end event

event doubleclicked;call super::doubleclicked;long ll_id_riga_rclf

ll_id_riga_rclf=dw_3.getitemnumber(row, "id_documento")
if ll_id_riga_rclf>0 then
	dw_2.retrieve(ll_id_riga_rclf)
end if
end event

type cb_cancella from commandbutton within w_lega_rclf_a_bollettina
integer x = 2553
integer y = 1565
integer width = 413
integer height = 118
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_3.getrow()
if ll_riga_da_cancellare>0 then
 	dw_3.trigger event ue_delete(ll_riga_da_cancellare)
end if

end event

type dw_5 from udw_base within w_lega_rclf_a_bollettina
integer x = 2074
integer y = 19
integer width = 903
integer height = 634
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_elenco_bol_ext"
boolean vscrollbar = false
end type

event editchanged;call super::editchanged;long ll_id_bollettina, ll_riga_trovata, ll_id_riga_rclf, ll_id_sog
string ls_num_doc
integer li_ret
datastore ds_trova_bol_pacco
ds_trova_bol_pacco=create datastore
	
ds_trova_bol_pacco.dataobject="d_trova_bollettina_pacco"
ds_trova_bol_pacco.settransobject(sqlca)
if dwo.name="cod_barre" and len(data)=7 then  //il codice a barre è un EAN7
	if dw_2.rowcount()> 0 then ll_id_sog=dw_2.getitemnumber(1, "id_sog_commerciale")
		
	ls_num_doc=mid(data, 3, 5)
	ll_riga_trovata=ds_trova_bol_pacco.retrieve(ls_num_doc)
	if ll_riga_trovata>0 then
		if ll_riga_trovata>1 then
	
		else
			
			ll_id_bollettina=ds_trova_bol_pacco.getitemnumber(1, "id_riga_documento")
			if ll_id_bollettina>0 then
				ll_riga_trovata=dw_3.find("provv_imp_subage_2="+string(ll_id_bollettina), 1, dw_3.rowcount())
				if ll_riga_trovata>0 then
					messagebox("Attenzione!", "Questa bollettina è già stata inserita!")
					return
				end if
				li_ret=dw_3.retrieve(ll_id_bollettina)
				if li_ret>0 then
					ll_id_riga_rclf=dw_3.getitemnumber(li_ret, "id_documento")
				//	if li_ret>1 then 	messagebox("Attenzione!", "La bollettina ha generato più di un doc. di produzione!")
				end if
//				//trovo l'id_documento da copiare (in genere è un sald o npsald)
//				select id_documento
//				into :ll_id_riga_rclf
//				from dba.riga_documento
//				where provv_imp_subage_2= :ll_id_bollettina
//				;
				if ll_id_riga_rclf>0 then
					//se trovo il doc lo carico
					
					li_ret=dw_2.retrieve(ll_id_riga_rclf)
					
					if ll_id_sog>0 and ll_id_sog<> dw_2.getitemnumber(1, "id_sog_commerciale") then
						messagebox("Attenzione!", "Il fornitore è cambiato! Stai mischiando i documenti di un fornitore con quelli di un altro!")
					end if
					//e carico anche le sue righe
					//li_ret=dw_3.retrieve(ll_id_riga_rclf)
				else
					messagebox("Attenzione!", "RCLF: "+ls_num_doc+" non trovato!")
				end if
			else
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
			end if
			dw_1.reset()
			dw_1.insertrow(1)
			dw_1.setfocus()
			dw_1.setcolumn("cod_barre")
		end if
	end if
end if
end event

