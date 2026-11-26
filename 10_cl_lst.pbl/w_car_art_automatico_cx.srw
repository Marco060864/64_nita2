forward
global type w_car_art_automatico_cx from w_001
end type
type cb_inserisci from commandbutton within w_car_art_automatico_cx
end type
type cb_salva from commandbutton within w_car_art_automatico_cx
end type
type cb_cancella from commandbutton within w_car_art_automatico_cx
end type
type dw_6 from udw_base within w_car_art_automatico_cx
end type
type cb_cancella_righe_vuote from commandbutton within w_car_art_automatico_cx
end type
type cb_art_doppi from commandbutton within w_car_art_automatico_cx
end type
type cb_art_esistenti from commandbutton within w_car_art_automatico_cx
end type
type cb_cancella_tutto from commandbutton within w_car_art_automatico_cx
end type
type cbx_fatto from checkbox within w_car_art_automatico_cx
end type
type dw_2 from udw_base within w_car_art_automatico_cx
end type
type dw_3 from udw_base within w_car_art_automatico_cx
end type
type dw_1 from udw_base within w_car_art_automatico_cx
end type
type cb_crea_articoli from commandbutton within w_car_art_automatico_cx
end type
end forward

global type w_car_art_automatico_cx from w_001
integer width = 4000
integer height = 2244
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
dw_6 dw_6
cb_cancella_righe_vuote cb_cancella_righe_vuote
cb_art_doppi cb_art_doppi
cb_art_esistenti cb_art_esistenti
cb_cancella_tutto cb_cancella_tutto
cbx_fatto cbx_fatto
dw_2 dw_2
dw_3 dw_3
dw_1 dw_1
cb_crea_articoli cb_crea_articoli
end type
global w_car_art_automatico_cx w_car_art_automatico_cx

type variables
integer i_dw_corrente
end variables

forward prototypes
public subroutine wf_inserisci_dati_fissi (long al_riga)
public subroutine wf_ins_peso_e_prezzo ()
end prototypes

public subroutine wf_inserisci_dati_fissi (long al_riga);long ll_id_cat_fiscale, ll_id_cat_codifica, ll_id_titolo
decimal ldc_coef_calo
long ll_id_cat_com, ll_id_uc_base
string ls_prod_interna


ls_prod_interna=dw_6.getitemstring(1, "prod_interna")

ll_id_cat_codifica=dw_6.getitemnumber(1, "id_cat_codifica")
ll_id_cat_com=dw_6.getitemnumber(1, "id_cat_com")
ll_id_titolo=dw_6.getitemnumber(1, "id_titolo")
ldc_coef_calo=dw_6.getitemdecimal(1, "c_calo")
ll_id_uc_base=dw_6.getitemnumber(1, "id_uc_base")

select id_cat_fis_prop
into :ll_id_cat_fiscale
from dba.par_sistema
;
dw_1.setitem(al_riga, "id_cat_fiscale", ll_id_cat_fiscale)
dw_1.setitem(al_riga, "id_titolo", ll_id_titolo)
dw_1.setitem(al_riga, "coef_calo", ldc_coef_calo)
dw_1.setitem(al_riga, "id_cat_com_articolo", ll_id_cat_com)
dw_1.setitem(al_riga, "id_cat_codifica", ll_id_cat_codifica)
dw_1.setitem(al_riga, "prod_interna", ls_prod_interna)
dw_1.setitem(al_riga, "id_unita_conf_base", ll_id_uc_base)
end subroutine

public subroutine wf_ins_peso_e_prezzo ();integer i
decimal ldc_peso, ldc_prezzo
long ll_id_art, ll_id_uc, ll_id_variazione, ll_riga_inserita, ll_riga_trovata
string ls_codice
//datastore ds_prezzo, ds_peso
//
//ds_prezzo=create datastore
//ds_prezzo.dataobject="ds_inserisci_prezzi_da_excel"
//ds_prezzo.settransobject(sqlca)
//ds_peso=create datastore
//ds_peso.dataobject="ds_metti_peso_da_excel"
//ds_peso.settransobject(sqlca)
//

//ora metto peso nell'unita confezione e prezzo nel listino
ldc_peso=dw_6.getitemdecimal(1, "peso")
ldc_prezzo=dw_6.getitemdecimal(1, "prezzo")

ll_id_variazione=dw_6.getitemnumber(1, "lis_vendita")
for i= 1 to dw_1.rowcount()
	dw_2.reset()
	dw_3.reset()
	ls_codice=dw_1.getitemstring(i, "codice")
	
	select id_articolo
	into :ll_id_art
	from dba.articolo
	where codice=:ls_codice
	;
	select  id_unita_confezione
	into :ll_id_uc
	from dba.unita_confezione
	where id_articolo=:ll_id_art
	and unita_base='S'
	;
	ll_riga_trovata=dw_3.retrieve(ll_id_uc)
	dw_3.setitem(ll_riga_trovata, "peso_netto", ldc_peso)
	dw_3.update()
	
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Peso articolo: "+ls_codice+" non inserito!")
	end if
	ll_riga_trovata=dw_2.retrieve(ll_id_variazione, ll_id_uc)
	if ll_riga_trovata>0 then
		dw_2.setitem(ll_riga_trovata, "prezzo", ldc_prezzo)
	else
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_inserita, "id_variazione", ll_id_variazione)
		dw_2.setitem(ll_riga_inserita, "id_unita_confezione", ll_id_uc)
		dw_2.setitem(ll_riga_inserita, "prezzo", ldc_prezzo)
	end if
	dw_2.update()
	if sqlca.sqlcode=0 then
		commit;
		else
			rollback;
			messagebox("Attenzione!", "Prezzo articolo: "+ls_codice+" non inserito!")
		end if	
	
next

end subroutine

on w_car_art_automatico_cx.create
int iCurrent
call super::create
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.dw_6=create dw_6
this.cb_cancella_righe_vuote=create cb_cancella_righe_vuote
this.cb_art_doppi=create cb_art_doppi
this.cb_art_esistenti=create cb_art_esistenti
this.cb_cancella_tutto=create cb_cancella_tutto
this.cbx_fatto=create cbx_fatto
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_1=create dw_1
this.cb_crea_articoli=create cb_crea_articoli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_inserisci
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.cb_cancella
this.Control[iCurrent+4]=this.dw_6
this.Control[iCurrent+5]=this.cb_cancella_righe_vuote
this.Control[iCurrent+6]=this.cb_art_doppi
this.Control[iCurrent+7]=this.cb_art_esistenti
this.Control[iCurrent+8]=this.cb_cancella_tutto
this.Control[iCurrent+9]=this.cbx_fatto
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.cb_crea_articoli
end on

on w_car_art_automatico_cx.destroy
call super::destroy
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.dw_6)
destroy(this.cb_cancella_righe_vuote)
destroy(this.cb_art_doppi)
destroy(this.cb_art_esistenti)
destroy(this.cb_cancella_tutto)
destroy(this.cbx_fatto)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.cb_crea_articoli)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_6.insertrow(1)

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
end event

type st_1 from w_001`st_1 within w_car_art_automatico_cx
end type

type cb_inserisci from commandbutton within w_car_art_automatico_cx
integer x = 41
integer y = 444
integer width = 247
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_id

ll_riga=dw_1.trigger event ue_insert(0)


end event

type cb_salva from commandbutton within w_car_art_automatico_cx
integer x = 306
integer y = 444
integer width = 247
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;
dw_1.trigger event ue_update()
post wf_ins_peso_e_prezzo()

end event

type cb_cancella from commandbutton within w_car_art_automatico_cx
integer x = 576
integer y = 444
integer width = 247
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancella"
end type

event clicked;dw_1.trigger event ue_delete(dw_1.getrow())
end event

type dw_6 from udw_base within w_car_art_automatico_cx
integer x = 37
integer y = 28
integer width = 3835
integer height = 356
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_dati_fissi_car_art_auto"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_cancella_righe_vuote from commandbutton within w_car_art_automatico_cx
integer x = 1257
integer y = 444
integer width = 517
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancella Righe Vuote"
end type

event clicked;


string ls_cod_art
long i, ll_righe

ll_righe=dw_1.rowcount()
//messagebox("W", ll_righe)
for i = ll_righe to 1 step -1
	ls_cod_art=dw_1.getitemstring(i, "codice")
	//messagebox("W", "dentro for")
	//messagebox("W", ls_cod_art)
	if isnull(ls_cod_art) or trim(ls_cod_art)<=" " then
		dw_1.deleterow(i)
		//messagebox("W", "dentro del")
	
	end if
next 
end event

type cb_art_doppi from commandbutton within w_car_art_automatico_cx
integer x = 1792
integer y = 444
integer width = 357
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Articoli Doppi"
end type

event clicked;integer i, li_riga_trovata, li_righe
string ls_art_codice

li_righe=dw_1.rowcount()
for i= 1 to li_righe - 1
	ls_art_codice=dw_1.getitemstring(i, "codice")
	
	li_riga_trovata=dw_1.find("codice ='"+ls_art_codice+"'", i+1, li_righe)
	if li_riga_trovata>0 then
		dw_1.scrolltorow(li_riga_trovata)
		messagebox("Attenzione!", "Articolo "+ls_art_codice+&
		" è presente alla riga n. "+string(i) + " e alla riga n. "+string(li_riga_trovata))
		exit
		
	end if
next

end event

type cb_art_esistenti from commandbutton within w_car_art_automatico_cx
integer x = 2176
integer y = 444
integer width = 594
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancella Articoli Esistenti"
end type

event clicked;integer i, li_riga_trovata, li_righe
string ls_art_codice
long ll_id_art_esistente

li_righe=dw_1.rowcount()
for i= li_righe to 1 step -1
	ls_art_codice=dw_1.getitemstring(i, "codice")
	select id_articolo
	into :ll_id_art_esistente
	from dba.articolo
	where codice=:ls_art_codice
	;
	if ll_id_art_esistente>0 then
		dw_1.deleterow(i)
	end if
next

end event

type cb_cancella_tutto from commandbutton within w_car_art_automatico_cx
integer x = 869
integer y = 444
integer width = 357
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancella Tutto"
end type

event clicked;dw_1.trigger event ue_delete(0)
cbx_fatto.checked=false
cb_crea_articoli.enabled=true


cb_art_esistenti.enabled=false
cb_art_doppi.enabled=false
cb_cancella_righe_vuote.enabled=false
cb_cancella_tutto.enabled=false
cb_cancella.enabled=false
cb_salva.enabled=false
cb_inserisci.enabled=false


end event

type cbx_fatto from checkbox within w_car_art_automatico_cx
integer x = 3232
integer y = 452
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fatto"
end type

event clicked;if checked then
	cb_art_esistenti.enabled=true
	cb_art_doppi.enabled=true
	cb_cancella_righe_vuote.enabled=true
	cb_cancella_tutto.enabled=true
	cb_cancella.enabled=true
	cb_salva.enabled=true
	cb_inserisci.enabled=true
else
	cb_art_esistenti.enabled=false
	cb_art_doppi.enabled=false
	cb_cancella_righe_vuote.enabled=false
	cb_cancella_tutto.enabled=false
	cb_cancella.enabled=false
	cb_salva.enabled=false
	cb_inserisci.enabled=false
end if
end event

type dw_2 from udw_base within w_car_art_automatico_cx
boolean visible = false
integer x = 59
integer y = 1300
integer width = 1152
integer height = 848
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_inserisci_prezzi_da_excel"
boolean hscrollbar = true
end type

event dragdrop;call super::dragdrop;datawindow ldw_drag
integer li_n_colonna, li_righe, i
string ls_dato, ls_dato_aggiunto

long ll_riga

if source.TypeOf()=Datawindow! then
	//questa è la dw sorgente (dw che ha recuperato il file excel
	ldw_drag=source
	li_n_colonna=ldw_drag.getcolumn()
	li_righe=ldw_drag.rowcount()
	if rowcount()>1 then
		//sono già state inserite le righe
		if string(dwo.name) ="codice" or string(dwo.name) ="descrizione" or string(dwo.name) ="nota" then
			if getitemstring(1, string(dwo.name))> " " then
				if messagebox("Attenzione!", &
					"Vuoi aggiungere il testo attuale a quello esistente?", stopsign!, yesno!)=1 then
					for i=2 to li_righe
						ls_dato=getitemstring(i -1, string(dwo.name))
						ls_dato_aggiunto=ldw_drag.getitemstring(i, li_n_colonna)
						if ls_dato_aggiunto>" " then
							ls_dato+=" "+ls_dato_aggiunto
						end if
						setitem(i -1, string(dwo.name), ls_dato)
						if string(dwo.name) ="codice" then
							setitem(i -1, "immagine", ls_dato+".jpg")
						end if
					next
					
				end if
			else
				for i= 2 to li_righe
					ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
					dw_1.setitem(i -1, string(dwo.name), ls_dato)
					if string(dwo.name) ="codice" then
						setitem(i -1, "immagine", ls_dato+".jpg")
					end if
				next
			end if
			return 0
		else
		
			for i= 2 to li_righe
				ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
				dw_1.setitem(i -1, string(dwo.name), ls_dato)
			next
		end if
	else
		//è il primo drag, devo inserire le righe
		for i= 2 to li_righe
			ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
			
			if i=2 then
				dw_1.setitem(row, string(dwo.name), ls_dato)
				ll_riga=row
			else
				dw_1.setitem(ll_riga, string(dwo.name), ls_dato)
			end if
			wf_inserisci_dati_fissi(ll_riga)
			ll_riga=dw_1.trigger event ue_insert(0)
		next
	end if	
//	cb_cancella_righe_vuote.triggerevent(clicked!)
end if
end event

event dragleave;call super::dragleave;drag(end!)
end event

type dw_3 from udw_base within w_car_art_automatico_cx
boolean visible = false
integer x = 1509
integer y = 1304
integer width = 1349
integer height = 844
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_metti_peso_da_excel"
boolean hscrollbar = true
end type

event dragdrop;call super::dragdrop;datawindow ldw_drag
integer li_n_colonna, li_righe, i
string ls_dato, ls_dato_aggiunto

long ll_riga

if source.TypeOf()=Datawindow! then
	//questa è la dw sorgente (dw che ha recuperato il file excel
	ldw_drag=source
	li_n_colonna=ldw_drag.getcolumn()
	li_righe=ldw_drag.rowcount()
	if rowcount()>1 then
		//sono già state inserite le righe
		if string(dwo.name) ="codice" or string(dwo.name) ="descrizione" or string(dwo.name) ="nota" then
			if getitemstring(1, string(dwo.name))> " " then
				if messagebox("Attenzione!", &
					"Vuoi aggiungere il testo attuale a quello esistente?", stopsign!, yesno!)=1 then
					for i=2 to li_righe
						ls_dato=getitemstring(i -1, string(dwo.name))
						ls_dato_aggiunto=ldw_drag.getitemstring(i, li_n_colonna)
						if ls_dato_aggiunto>" " then
							ls_dato+=" "+ls_dato_aggiunto
						end if
						setitem(i -1, string(dwo.name), ls_dato)
						if string(dwo.name) ="codice" then
							setitem(i -1, "immagine", ls_dato+".jpg")
						end if
					next
					
				end if
			else
				for i= 2 to li_righe
					ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
					dw_1.setitem(i -1, string(dwo.name), ls_dato)
					if string(dwo.name) ="codice" then
						setitem(i -1, "immagine", ls_dato+".jpg")
					end if
				next
			end if
			return 0
		else
		
			for i= 2 to li_righe
				ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
				dw_1.setitem(i -1, string(dwo.name), ls_dato)
			next
		end if
	else
		//è il primo drag, devo inserire le righe
		for i= 2 to li_righe
			ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
			
			if i=2 then
				dw_1.setitem(row, string(dwo.name), ls_dato)
				ll_riga=row
			else
				dw_1.setitem(ll_riga, string(dwo.name), ls_dato)
			end if
			wf_inserisci_dati_fissi(ll_riga)
			ll_riga=dw_1.trigger event ue_insert(0)
		next
	end if	
//	cb_cancella_righe_vuote.triggerevent(clicked!)
end if
end event

event dragleave;call super::dragleave;drag(end!)
end event

type dw_1 from udw_base within w_car_art_automatico_cx
integer x = 32
integer y = 604
integer width = 3863
integer height = 1504
boolean bringtotop = true
string dataobject = "d_crea_art_gd"
boolean hscrollbar = true
end type

event dragdrop;call super::dragdrop;//datawindow ldw_drag
//integer li_n_colonna, li_righe, i
//string ls_dato, ls_dato_aggiunto
//
//long ll_riga
//
//if source.TypeOf()=Datawindow! then
//	//questa è la dw sorgente (dw che ha recuperato il file excel
//	ldw_drag=source
//	li_n_colonna=ldw_drag.getcolumn()
//	li_righe=ldw_drag.rowcount()
//	if rowcount()>1 then
//		//sono già state inserite le righe
//		if string(dwo.name) ="codice" or string(dwo.name) ="descrizione" or string(dwo.name) ="nota" then
//			if getitemstring(1, string(dwo.name))> " " then
//				if messagebox("Attenzione!", &
//					"Vuoi aggiungere il testo attuale a quello esistente?", stopsign!, yesno!)=1 then
//					for i=2 to li_righe
//						ls_dato=getitemstring(i -1, string(dwo.name))
//						ls_dato_aggiunto=ldw_drag.getitemstring(i, li_n_colonna)
//						if ls_dato_aggiunto>" " then
//							ls_dato+=" "+ls_dato_aggiunto
//						end if
//						setitem(i -1, string(dwo.name), ls_dato)
//						if string(dwo.name) ="codice" then
//							setitem(i -1, "immagine", ls_dato+".jpg")
//						end if
//					next
//					
//				end if
//			else
//				for i= 2 to li_righe
//					ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
//					dw_1.setitem(i -1, string(dwo.name), ls_dato)
//					if string(dwo.name) ="codice" then
//						setitem(i -1, "immagine", ls_dato+".jpg")
//					end if
//				next
//			end if
//			return 0
//		else
//		
//			for i= 2 to li_righe
//				ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
//				dw_1.setitem(i -1, string(dwo.name), ls_dato)
//			next
//		end if
//	else
//		//è il primo drag, devo inserire le righe
//		for i= 2 to li_righe
//			ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
//			
//			if i=2 then
//				dw_1.setitem(row, string(dwo.name), ls_dato)
//				ll_riga=row
//			else
//				dw_1.setitem(ll_riga, string(dwo.name), ls_dato)
//			end if
//			wf_inserisci_dati_fissi(ll_riga)
//			ll_riga=dw_1.trigger event ue_insert(0)
//		next
//	end if	
////	cb_cancella_righe_vuote.triggerevent(clicked!)
//end if
end event

event dragleave;call super::dragleave;//drag(end!)
end event

type cb_crea_articoli from commandbutton within w_car_art_automatico_cx
integer x = 2821
integer y = 444
integer width = 384
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea articoli"
end type

event clicked;string ls_prefisso, ls_suffisso, ls_immagine, ls_prod_interna, ls_des,ls_codice
integer li_progressivo, i, LI_DA, LI_A
long ll_id_cat_codifica, ll_id_cat_comm, ll_id_titolo, ll_id_uc_base, ll_riga_inserita
decimal ldc_coef_calo
string ls_contatore

dw_6.accepttext()
ls_prefisso=dw_6.getitemstring(1, "prefisso")
ls_suffisso=dw_6.getitemstring(1, "suffisso")
LI_DA=dw_6.getitemnumber(1, "da_num")
li_a=dw_6.getitemnumber(1, "a_num")
if LI_DA>0 and li_a>0 and li_a> li_da then
	li_progressivo=li_a - LI_DA
	if isnull(li_progressivo) then li_progressivo=0
	if isnull(ls_prefisso) or ls_prefisso<" " then 	return
	
	
	ls_prod_interna=dw_6.getitemstring(1, "prod_interna")
	ls_des=dw_6.getitemstring(1, "art_descrizione")
	ll_id_cat_codifica=dw_6.getitemnumber(1, "id_cat_codifica")
	ll_id_cat_comm=dw_6.getitemnumber(1, "id_cat_com")
	ldc_coef_calo=dw_6.getitemnumber(1, "c_calo")
	ll_id_titolo=dw_6.getitemnumber(1, "id_titolo")
	ll_id_uc_base=dw_6.getitemnumber(1, "id_uc_base")
	dw_1.reset()
	for i= 1 to li_progressivo +1
		ll_riga_inserita=dw_1.insertrow(0)
		
		choose case li_da -1 +i
			case is  < 10 
				ls_contatore="000"
			case 10 to 99
				ls_contatore="00"
			case 100 to 999
				ls_contatore="0"
			case else
				ls_contatore=""
		end  choose
		ls_contatore+=string(li_da - 1 +i)
		
		
		ls_codice=ls_prefisso+ls_contatore
		ls_immagine=ls_codice+".jpg"
		dw_1.setitem(ll_riga_inserita, "codice", ls_codice)
		dw_1.setitem(ll_riga_inserita, "prod_interna", ls_prod_interna)
		dw_1.setitem(ll_riga_inserita, "descrizione", ls_des)
		dw_1.setitem(ll_riga_inserita, "immagine", ls_immagine)
		dw_1.setitem(ll_riga_inserita, "id_cat_codifica", ll_id_cat_codifica)
		dw_1.setitem(ll_riga_inserita, "id_cat_com_articolo", ll_id_cat_comm)
		dw_1.setitem(ll_riga_inserita, "id_titolo", ll_id_titolo)
		dw_1.setitem(ll_riga_inserita, "coef_calo", ldc_coef_calo)
		dw_1.setitem(ll_riga_inserita, "id_unita_conf_base", ll_id_uc_base)
	next
else
	
end if

enabled=false
end event

