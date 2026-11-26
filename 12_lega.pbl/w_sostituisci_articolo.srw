forward
global type w_sostituisci_articolo from w_base
end type
type cb_4 from commandbutton within w_sostituisci_articolo
end type
type cb_3 from commandbutton within w_sostituisci_articolo
end type
type cb_2 from commandbutton within w_sostituisci_articolo
end type
type cb_cancella from commandbutton within w_sostituisci_articolo
end type
type cb_salva from commandbutton within w_sostituisci_articolo
end type
type cb_vedi_sostituzioini from commandbutton within w_sostituisci_articolo
end type
type cb_1 from commandbutton within w_sostituisci_articolo
end type
type dw_2 from udw_001 within w_sostituisci_articolo
end type
type dw_1 from udw_001 within w_sostituisci_articolo
end type
end forward

global type w_sostituisci_articolo from w_base
integer width = 4096
integer height = 2416
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_cancella cb_cancella
cb_salva cb_salva
cb_vedi_sostituzioini cb_vedi_sostituzioini
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_sostituisci_articolo w_sostituisci_articolo

forward prototypes
public subroutine wf_cancella_sostituito (long al_riga_da_cancellare)
end prototypes

public subroutine wf_cancella_sostituito (long al_riga_da_cancellare);dw_1.trigger event ue_delete(al_riga_da_cancellare)
dw_1.triggerevent("ue_update")
//dw_1.retrieve()

//delete from dba.unita_confezione
//where id_articolo=:al_id_da_cancellare;
//if sqlca.sqlcode=0 then
//	commit;
//	delete from dba.articolo
//	where id_articolo=:al_id_da_cancellare;
//	if sqlca.sqlcode=0 then
//		commit;
//		dw_1.retrieve()
//		messagebox("Attenzione!", "Articolo cancellato!")
//	else
//		rollback;
//		messagebox("Attenzione!", "Articolo NON cancellato")
//	end if
//else
//	rollback;
//	messagebox("Attenzione!", "Unita_confezione NON cancellata: NON si cancella neppure l'articolo!")
//end if
end subroutine

on w_sostituisci_articolo.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.cb_vedi_sostituzioini=create cb_vedi_sostituzioini
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_salva
this.Control[iCurrent+6]=this.cb_vedi_sostituzioini
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_1
end on

on w_sostituisci_articolo.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.cb_vedi_sostituzioini)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.retrieve()
dw_2.insertrow(1)
end event

type cb_4 from commandbutton within w_sostituisci_articolo
integer x = 2766
integer y = 1592
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<< Stampa"
end type

event clicked;open(w_sost_art_rpt)





//ds_art.print(true,true)
end event

type cb_3 from commandbutton within w_sostituisci_articolo
integer x = 3429
integer y = 1740
integer width = 562
integer height = 252
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "ISTRUZIONI"
end type

event clicked;messagebox("Istruzioni!", "1) scegli gli articoli da sostituire ed eventualmente cancellare e scegli l'articolo con il quale sostituirli (Rosso);~r~n&
2) la procedura ti mostrerà gli eventuali documenti in cui ognuno di quegli articoli si trova attualemente;~r~n&
3) poi ti sarà chiesto se sei sicuro di voler sostituire l'articolo nei movimenti visti (se non ci sono movimenti chiederà se lo vuoi cancellare);~r~n&
4) dopo averlo sostituito nei movimenti la procedura chiederà se vuoi cancellarlo;~r~n&
5) se vuoi modificare il codice di un articolo basta che lo trovi nella finestra e lo modifichi: la procedura ti mostrerà i movimenti interessati quindi ti chiederà conferma.~r~n&
Dopo questo premi SALVA per rendere le modifiche permanenti.")
end event

type cb_2 from commandbutton within w_sostituisci_articolo
integer x = 2766
integer y = 2048
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<<Aggiorna"
end type

event clicked;dw_1.retrieve()
end event

type cb_cancella from commandbutton within w_sostituisci_articolo
integer x = 2766
integer y = 1896
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<< Cancella"
end type

event clicked;//dw_1.trigger event ue_delete()
long i
integer li_test

for i= dw_1.rowcount() to 1 step -1
	li_test=dw_1.getitemnumber(i, "c_scegli")
	if li_test=1 then
		dw_1.trigger event ue_delete(i)
	end if
next
end event

type cb_salva from commandbutton within w_sostituisci_articolo
integer x = 2766
integer y = 1744
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<< Salva"
end type

event clicked;dw_1.trigger event ue_update()
end event

type cb_vedi_sostituzioini from commandbutton within w_sostituisci_articolo
integer x = 3584
integer y = 2048
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Storico"
end type

event clicked;open(w_art_sostituzioni)
end event

type cb_1 from commandbutton within w_sostituisci_articolo
string tag = "L~'articolo che scegli qui sostituirà gli articoli selezionati con ~"SCEGLI~" in TUTTI i movimenti (ovvero in ogni riga di qualsiasi documento quegli articoli si trovino). Dopo questo gli articoli selezionati potrano essere cancellati dal database!"
integer x = 3813
integer y = 104
integer width = 210
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "SQL"
end type

event clicked;integer i, li_test
string ls_filtro,ls_test,ls_codice_art_sostituito
long ll_id_art_da_sostituire, ll_art_sostitutivo,ll_id_uc, ll_test
datetime ldt_data

//ls_filtro="scegli='1'"
//
//dw_1.setfilter(ls_filtro)
//dw_1.filter()

ll_art_sostitutivo=dw_2.getitemnumber(1, "id_articolo")
select id_unita_confezione into :ll_id_uc from dba.unita_confezione where id_articolo=:ll_art_sostitutivo and unita_base='S';

for i=  dw_1.rowcount() to 1 step -1
	li_test=0
	ls_codice_art_sostituito=""
	ll_test=0
	setnull(ll_id_art_da_sostituire)
	li_test=dw_1.getitemnumber(i, "c_scegli")
	if li_test=1 then
		ll_id_art_da_sostituire=dw_1.getitemnumber(i, "id_articolo")
		ls_codice_art_sostituito=dw_1.getitemstring(i, "codice")
		select id_riga_documento into :ll_test from dba.riga_documento where id_articolo= :ll_id_art_da_sostituire;
		if ll_test>0 then 
			openwithparm(w_doc_art_sostituito, ll_id_art_da_sostituire)
			
			if messagebox("BIVIO!", "Vuoi davvero sostituire l'articolo "+ls_codice_art_sostituito+" nei movimenti?", stopsign!,  yesno!)<>1 then continue
			
			update dba.riga_documento
			set id_articolo=:ll_art_sostitutivo, id_unita_confezione= :ll_id_uc
			where id_articolo= :ll_id_art_da_sostituire;
			if sqlca.sqlNrows>0 then
				commit;
				//aggiorno la tabella delle sostituzioni (art_sostituzioni)
				ldt_data=datetime(date(today()), now())
				insert into dba.art_sostituzioni (id_art_sostituito, id_art_sostitutivo, data_sostituzione, cod_art_sostituito)
				values(:ll_id_art_da_sostituire, :ll_art_sostitutivo, :ldt_data, :ls_codice_art_sostituito)
				;
				if sqlca.sqlNrows>0 then
					commit;
					if messagebox("Attenzione!", "Articolo: "+ls_codice_art_sostituito+" CORRETTAMENTE sostituito! Vuoi cancellarlo anche dall'anagrafica articoli?", stopsign!,  yesno!)=1 then
						wf_cancella_sostituito(i)
					end if	
				else
				rollback;
				messagebox("Attenzione!", "Sostituzione Articolo "+ls_codice_art_sostituito+" NON memorizzata nello storico!")
				end if
			end if
		else
			rollback;
			select id_riga_documento into :ll_test from dba.riga_documento
			where id_articolo= :ll_id_art_da_sostituire;
			if sqlca.sqlcode=0 then
				messagebox("Attenzione!", "Articolo NON sostituito!")
			else
				if messagebox("Attenzione!", "Articolo "+ls_codice_art_sostituito+" SENZA movimenti, vuoi CANCELLARLO?", stopsign!,  yesno!)=1 then
					wf_cancella_sostituito(i)
				end if	
			end if
		end if
	end if
next
dw_1.setfilter("")
dw_1.filter()
end event

event rbuttondown;messagebox("ISTRUZIOINI!", this.tag)
end event

type dw_2 from udw_001 within w_sostituisci_articolo
integer x = 2816
integer y = 40
integer width = 974
integer height = 204
integer taborder = 20
string dataobject = "d_art_sostitutivo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event getfocus;//
end event

type dw_1 from udw_001 within w_sostituisci_articolo
integer x = 32
integer y = 28
integer width = 2706
integer height = 2140
integer taborder = 10
string dataobject = "d_art_da_sostituire"
boolean vscrollbar = true
end type

event getfocus;//
end event

event losefocus;//
end event

event itemchanged;call super::itemchanged;long ll_id_art
string ls_art_prima

if dwo.name='codice' then
	ll_id_art=getitemnumber(row, "id_articolo")
	ls_art_prima=getitemstring(row, "codice")
	openwithparm(w_doc_art_sostituito, ll_id_art)
			
	if messagebox("BIVIO!", "Vuoi davvero modificare l'articolo "+ls_art_prima+" in tutti i  movimenti che hai visto?", stopsign!,  yesno!)<>1 then return 2 
		
	
	
end if
end event

