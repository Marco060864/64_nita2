forward
global type w_ver_sped_old_bollettina from w_base
end type
type cb_aggiorna from commandbutton within w_ver_sped_old_bollettina
end type
type dw_2 from udw_001 within w_ver_sped_old_bollettina
end type
type cb_ricerca from uo_commandbutton within w_ver_sped_old_bollettina
end type
type cb_salva from uo_commandbutton within w_ver_sped_old_bollettina
end type
type cb_ok from uo_commandbutton within w_ver_sped_old_bollettina
end type
type cb_annulla from uo_commandbutton within w_ver_sped_old_bollettina
end type
type cb_stampa from uo_commandbutton within w_ver_sped_old_bollettina
end type
type cb_cancella from uo_commandbutton within w_ver_sped_old_bollettina
end type
type cb_inserisci from uo_commandbutton within w_ver_sped_old_bollettina
end type
type dw_1 from udw_001 within w_ver_sped_old_bollettina
end type
end forward

global type w_ver_sped_old_bollettina from w_base
integer width = 4105
integer height = 2312
cb_aggiorna cb_aggiorna
dw_2 dw_2
cb_ricerca cb_ricerca
cb_salva cb_salva
cb_ok cb_ok
cb_annulla cb_annulla
cb_stampa cb_stampa
cb_cancella cb_cancella
cb_inserisci cb_inserisci
dw_1 dw_1
end type
global w_ver_sped_old_bollettina w_ver_sped_old_bollettina

forward prototypes
public subroutine wf_completa_riga (long al_riga, string ls_num_bol)
public subroutine wf_carica_spedizione ()
end prototypes

public subroutine wf_completa_riga (long al_riga, string ls_num_bol);long ll_id_riga, ll_id_rbol, ll_riga_inserita

select id_riga_documento into :ll_id_riga from dba.documento d, dba.riga_documento r 	
	where r.id_documento=d.id_documento and num_documento like '%'+:ls_num_bol+'%';
	if ll_id_riga>0 then
		select id_riga_documento into :ll_id_rbol from dba.riga_documento
		where id_riga_doc_provenienza=:ll_id_riga;
		if ll_id_rbol>0 then
			ll_riga_inserita=dw_1.retrieve(ll_id_rbol)
			dw_1.setitem(ll_riga_inserita, "num_bollettina", ls_num_bol)
			dw_1.deleterow(al_riga)
		else
			dw_1.setitem(al_riga, "articolo_codice", "NON SPEDITA!" )
			//messagebox("Attenzione!", "Bollettina "+ls_num_bol+" NON spedita!!")
		end if
	else
		messagebox("Attenzione!", "Bollettina "+ls_num_bol+" NON trovata!!")
		dw_1.setitem(al_riga, "num_bollettina", "")
	end if
end subroutine

public subroutine wf_carica_spedizione ();long ll_righe, ll_riga_inserita 
string ls_num_bollettina
integer i	

ll_righe=dw_2.retrieve()

for i= 1 to ll_righe
	ll_riga_inserita=dw_1.insertrow(0)
	ls_num_bollettina=dw_2.getitemstring(i, "num_bollettina")
	dw_1.setitem(ll_riga_inserita, "num_bollettina", ls_num_bollettina)
	wf_completa_riga(ll_riga_inserita, ls_num_bollettina)
	//dw_1.trigger event itemchanged(ll_riga_inserita, dw_1.object.num_bollettina, ls_num_bollettina)
next
end subroutine

on w_ver_sped_old_bollettina.create
int iCurrent
call super::create
this.cb_aggiorna=create cb_aggiorna
this.dw_2=create dw_2
this.cb_ricerca=create cb_ricerca
this.cb_salva=create cb_salva
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aggiorna
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_ricerca
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_annulla
this.Control[iCurrent+7]=this.cb_stampa
this.Control[iCurrent+8]=this.cb_cancella
this.Control[iCurrent+9]=this.cb_inserisci
this.Control[iCurrent+10]=this.dw_1
end on

on w_ver_sped_old_bollettina.destroy
call super::destroy
destroy(this.cb_aggiorna)
destroy(this.dw_2)
destroy(this.cb_ricerca)
destroy(this.cb_salva)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)


dw_2.settransobject(sqlca)

end event

event resize;call super::resize;dw_1.width=newwidth - 105
dw_1.height=newheight - 292

cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285

cb_stampa.x=cb_cancella.x + 285
cb_stampa.y=cb_salva.y




cb_ok.y=newheight - 224
cb_ok.x=dw_1.x+dw_1.width - cb_ok.width
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ok.x - 285
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_annulla.x - 285

cb_aggiorna.x=cb_stampa.x+50+cb_stampa.width
cb_aggiorna.y=cb_stampa.y


end event

event ue_postopen;call super::ue_postopen;long ll_righe, ll_riga_inserita
integer i
string ls_num_bollettina
date ldt_oggi

ldt_oggi=date(today())
dw_2.is_sql=" where data_spedizione =  "+string(ldt_oggi, "yyyymmdd")
wf_carica_spedizione()
ll_riga_inserita=dw_1.insertrow(0)	
dw_1.scrolltorow(ll_riga_inserita)
dw_1.setcolumn("num_bollettina")
post setfocus(dw_1)
dw_1.trigger event getfocus()
end event

type cb_aggiorna from commandbutton within w_ver_sped_old_bollettina
integer x = 736
integer y = 1360
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
end type

event clicked;cb_salva.triggerevent("clicked")
dw_2.reset()
dw_1.reset()
wf_carica_spedizione()
end event

type dw_2 from udw_001 within w_ver_sped_old_bollettina
boolean visible = false
integer x = 800
integer y = 1540
integer width = 1609
integer height = 300
integer taborder = 20
string dataobject = "d_salva_ver_sped_old_bollettina"
boolean vscrollbar = true
end type

type cb_ricerca from uo_commandbutton within w_ver_sped_old_bollettina
integer x = 2784
integer y = 1564
integer width = 261
integer height = 96
integer taborder = 60
integer textsize = -8
string text = "Ricerca"
end type

event clicked;long ll_id, ll_riga

if text='Ricerca' then
	dw_1.modify("datawindow.querymode=yes")
	text='Trova'
else
	text='Ricerca'
	dw_1.accepttext()
	dw_1.Modify("DataWindow.QueryMode=no")
	ll_riga=dw_1.retrieve()
end if

end event

type cb_salva from uo_commandbutton within w_ver_sped_old_bollettina
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 1664
integer y = 1348
integer width = 261
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;//dw_1.trigger event ue_update() 
integer i
string ls_num_bollettina
long ll_riga_inserita, ll_id_riga

for i  =1 to dw_1.rowcount()
	ls_num_bollettina=dw_1.getitemstring(i, "num_bollettina")	
	if dw_2.find("num_bollettina='"+ls_num_bollettina+"'", 1 , 999999)<=0 then  //la bollettina non c'è la inserisco
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_inserita, "num_bollettina", ls_num_bollettina)  //20230613 sostituisco con id_riga_doc
		dw_2.setitem(ll_riga_inserita, "data_spedizione", date(today()) )
	end if
next
if dw_2.update()=1 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "Bollettina "+ls_num_bollettina+" NON salvata!")
end if
end event

type cb_ok from uo_commandbutton within w_ver_sped_old_bollettina
string tag = "Chiude salvando le modifiche."
integer x = 2592
integer y = 1464
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string text = "Ok"
end type

event clicked;//if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
//	dw_1.trigger event ue_update()
//end if
close(parent)
end event

type cb_annulla from uo_commandbutton within w_ver_sped_old_bollettina
string tag = "Chiude senza salvare nulla."
integer x = 2299
integer y = 1464
integer width = 261
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_stampa from uo_commandbutton within w_ver_sped_old_bollettina
integer x = 1202
integer y = 1280
integer width = 261
integer height = 96
integer taborder = 40
integer textsize = -8
string text = "Stampa"
end type

event clicked;call super::clicked;string ls_data, ls_num_doc

ls_num_doc=parent.classname()
		
ls_data=string(today(), "dd-mm-yy")
ls_num_doc+="_"+ls_data
	
dw_1.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
dw_1.print(true, true)
end event

type cb_cancella from uo_commandbutton within w_ver_sped_old_bollettina
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 379
integer y = 1328
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare, ll_riga_trovata
string ls_num_bol

ll_riga_da_cancellare=dw_1.getrow()
ls_num_bol=dw_1.getitemstring(ll_riga_da_cancellare, "num_bollettina")
ll_riga_trovata=dw_2.find("num_bollettina='"+ls_num_bol+"'", 1, 99999999)
if ll_riga_trovata>0 then 
	dw_2.deleterow(ll_riga_trovata)
	dw_1.trigger event ue_delete(ll_riga_da_cancellare)		
else //non l'ha trovata???????
	messagebox("Attenzione!", "Riga NON trovata!!!")
end if


end event

event rbuttondown;integer li_ret

if messagebox("Attenzione!", "TUTTE LE RIGHE verranno CANCELLATE! Vuoi continuare?")=1 then
	li_ret=dw_2.RowsMove(1, dw_2.rowcount(), Primary!,  dw_2, 1, Delete!)
	if li_ret=1 then
		if dw_2.update()=1 then
			commit;
		else
			rollback;
			messagebox("attenzione!", "Righe NON cancellate!")
		end if
		dw_1.reset()
	else
		messagebox("attenzione!", "Righe NON cancellate!")
	end if
end if
end event

type cb_inserisci from uo_commandbutton within w_ver_sped_old_bollettina
string tag = "Inserisce una nuova riga nella finestra che ha il fuoco."
integer x = 78
integer y = 1320
integer width = 261
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_1.trigger event ue_insert(0)

end event

type dw_1 from udw_001 within w_ver_sped_old_bollettina
integer x = 46
integer y = 44
integer width = 3968
integer height = 1188
integer taborder = 10
string dataobject = "d_ver_sped_old_bollettina"
end type

event itemchanged;call super::itemchanged;string ls_num_bol
long ll_id_riga, ll_id_rbol, ll_riga_inserita

if dwo.name='num_bollettina' then
	ls_num_bol=data
	wf_completa_riga(row, ls_num_bol)
		ll_riga_inserita=insertrow(0)
		post scrolltorow(ll_riga_inserita)
		post setcolumn("num_bollettina")
		post setfocus(dw_1)

	
end if
end event

event retrievestart;call super::retrievestart;return 2
end event

