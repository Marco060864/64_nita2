forward
global type w_carica_art_da_excel_cx from w_001
end type
type cb_carica from commandbutton within w_carica_art_da_excel_cx
end type
type cb_inserisci from commandbutton within w_carica_art_da_excel_cx
end type
type cb_salva from commandbutton within w_carica_art_da_excel_cx
end type
type cb_cancella from commandbutton within w_carica_art_da_excel_cx
end type
type dw_6 from udw_base within w_carica_art_da_excel_cx
end type
type cb_cancella_righe_vuote from commandbutton within w_carica_art_da_excel_cx
end type
type cb_art_doppi from commandbutton within w_carica_art_da_excel_cx
end type
type cb_art_esistenti from commandbutton within w_carica_art_da_excel_cx
end type
type cb_cancella_tutto from commandbutton within w_carica_art_da_excel_cx
end type
type cbx_fatto from checkbox within w_carica_art_da_excel_cx
end type
type ole_1 from olecontrol within w_carica_art_da_excel_cx
end type
type dw_2 from udw_base within w_carica_art_da_excel_cx
end type
type dw_3 from udw_base within w_carica_art_da_excel_cx
end type
type dw_1 from udw_base within w_carica_art_da_excel_cx
end type
type dw_4 from datawindow within w_carica_art_da_excel_cx
end type
end forward

global type w_carica_art_da_excel_cx from w_001
integer width = 4001
integer height = 2426
cb_carica cb_carica
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
dw_6 dw_6
cb_cancella_righe_vuote cb_cancella_righe_vuote
cb_art_doppi cb_art_doppi
cb_art_esistenti cb_art_esistenti
cb_cancella_tutto cb_cancella_tutto
cbx_fatto cbx_fatto
ole_1 ole_1
dw_2 dw_2
dw_3 dw_3
dw_1 dw_1
dw_4 dw_4
end type
global w_carica_art_da_excel_cx w_carica_art_da_excel_cx

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

on w_carica_art_da_excel_cx.create
int iCurrent
call super::create
this.cb_carica=create cb_carica
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.dw_6=create dw_6
this.cb_cancella_righe_vuote=create cb_cancella_righe_vuote
this.cb_art_doppi=create cb_art_doppi
this.cb_art_esistenti=create cb_art_esistenti
this.cb_cancella_tutto=create cb_cancella_tutto
this.cbx_fatto=create cbx_fatto
this.ole_1=create ole_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_1=create dw_1
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_carica
this.Control[iCurrent+2]=this.cb_inserisci
this.Control[iCurrent+3]=this.cb_salva
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.dw_6
this.Control[iCurrent+6]=this.cb_cancella_righe_vuote
this.Control[iCurrent+7]=this.cb_art_doppi
this.Control[iCurrent+8]=this.cb_art_esistenti
this.Control[iCurrent+9]=this.cb_cancella_tutto
this.Control[iCurrent+10]=this.cbx_fatto
this.Control[iCurrent+11]=this.ole_1
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.dw_4
end on

on w_carica_art_da_excel_cx.destroy
call super::destroy
destroy(this.cb_carica)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.dw_6)
destroy(this.cb_cancella_righe_vuote)
destroy(this.cb_art_doppi)
destroy(this.cb_art_esistenti)
destroy(this.cb_cancella_tutto)
destroy(this.cbx_fatto)
destroy(this.ole_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.dw_4)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_6.insertrow(1)

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
end event

type st_1 from w_001`st_1 within w_carica_art_da_excel_cx
end type

type cb_carica from commandbutton within w_carica_art_da_excel_cx
integer x = 3379
integer y = 250
integer width = 450
integer height = 99
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica File Excel"
end type

event clicked;
integer li_ret
string ls_path, ls_file, ls_name
long ll_rigains, ll_max
	
getfileopenname("Cerca file excel", ls_path, ls_name)
if  not(trim(ls_name)="" or isnull(ls_name)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+".txt"
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_4.reset()
	dw_4.importfile(Text!,ls_file)
	parent.height=2450
	ole_1.object.close(False)
end if	 

//cb_cancella_righe_vuote.triggerevent(clicked!)



end event

type cb_inserisci from commandbutton within w_carica_art_da_excel_cx
integer x = 40
integer y = 250
integer width = 249
integer height = 99
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

type cb_salva from commandbutton within w_carica_art_da_excel_cx
integer x = 307
integer y = 250
integer width = 249
integer height = 99
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

type cb_cancella from commandbutton within w_carica_art_da_excel_cx
integer x = 578
integer y = 250
integer width = 249
integer height = 99
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

type dw_6 from udw_base within w_carica_art_da_excel_cx
integer x = 37
integer y = 29
integer width = 3836
integer height = 202
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_dati_fissi_art_da_excel"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_cancella_righe_vuote from commandbutton within w_carica_art_da_excel_cx
integer x = 1258
integer y = 250
integer width = 516
integer height = 99
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

type cb_art_doppi from commandbutton within w_carica_art_da_excel_cx
integer x = 1792
integer y = 250
integer width = 358
integer height = 99
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

type cb_art_esistenti from commandbutton within w_carica_art_da_excel_cx
integer x = 2176
integer y = 250
integer width = 592
integer height = 99
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

type cb_cancella_tutto from commandbutton within w_carica_art_da_excel_cx
integer x = 870
integer y = 250
integer width = 358
integer height = 99
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
end event

type cbx_fatto from checkbox within w_carica_art_da_excel_cx
integer x = 2896
integer y = 266
integer width = 344
integer height = 74
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

type ole_1 from olecontrol within w_carica_art_da_excel_cx
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
boolean visible = false
integer x = 2381
integer y = 2125
integer width = 347
integer height = 189
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean isdragtarget = true
string binarykey = "w_carica_art_da_excel_cx.win"
string displayname = "Prova"
boolean resizable = true
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayasactivexdocument!
omcontentsallowed contentsallowed = containsany!
end type

type dw_2 from udw_base within w_carica_art_da_excel_cx
boolean visible = false
integer x = 2319
integer y = 355
integer width = 1159
integer height = 333
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

type dw_3 from udw_base within w_carica_art_da_excel_cx
boolean visible = false
integer x = 2330
integer y = 701
integer width = 1485
integer height = 333
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

type dw_1 from udw_base within w_carica_art_da_excel_cx
integer x = 37
integer y = 355
integer width = 3862
integer height = 672
boolean bringtotop = true
string dataobject = "d_art_per_rec_da_excel_gd"
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

type dw_4 from datawindow within w_carica_art_da_excel_cx
integer x = 37
integer y = 1040
integer width = 3862
integer height = 989
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_imp_art_da_excel_ext"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;drag(begin!)
if dw_1.rowcount()<1 then
	dw_1.trigger event ue_insert(0)
end if
end event

