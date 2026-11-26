forward
global type w_controllo_bol_excel from w_semplice_cx
end type
type dw_2 from udw_000 within w_controllo_bol_excel
end type
type st_2 from statictext within w_controllo_bol_excel
end type
type dw_3 from udw_000 within w_controllo_bol_excel
end type
type cb_carica from commandbutton within w_controllo_bol_excel
end type
type dw_4 from udw_001 within w_controllo_bol_excel
end type
end forward

global type w_controllo_bol_excel from w_semplice_cx
integer width = 5294
integer height = 2292
dw_2 dw_2
st_2 st_2
dw_3 dw_3
cb_carica cb_carica
dw_4 dw_4
end type
global w_controllo_bol_excel w_controllo_bol_excel

type variables
integer righe_inserite_5
end variables

forward prototypes
public subroutine wf_salva_tara (long al_riga, decimal adc_peso, string as_tipo)
public subroutine wf_stampa ()
end prototypes

public subroutine wf_salva_tara (long al_riga, decimal adc_peso, string as_tipo);//long ll_id_bol
//integer a, li_ordine
//date ldt_data_ins
decimal ldc_peso, ldc_tara_precedente
////as tipo = P (peso) o T (tara)
//
//ll_id_bol=dw_1.getitemnumber(al_riga, "id_bollettine_excel")
////20241121 aggiungo gestione data odierrna, la salvo per recuperare tutto quanto fatto oggi, al bisogno
//li_ordine=dw_1.rowcount()
//ldt_data_ins=dw_1.getitemdate(al_riga, "data_inserimento")
//if isnull(ldt_data_ins) or ldt_data_ins<date("01/01/1901") then
//	ldt_data_ins= today()
//	dw_1.setitem(al_riga, "data_inserimento", ldt_data_ins)
//	update dba.bollettine_excel_ext
//	set data_inserimento=:ldt_data_ins, ordine_riga=:li_ordine
//	where id_bollettine_excel=:ll_id_bol;
//	if sqlca.sqlNrows>0 then
//		commit;
//	else
//		rollback;
//		insert into dba.bollettine_excel_ext (id_bollettine_excel, peso_bilancia, TARA)
//		values (:ll_id_bol, :ldt_data_ins, 0);
//		if sqlca.sqlNrows>0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Data inserimento NON salvata!")
//		end if
//	end if
//end if
//
//
//if as_tipo='T' then
//	update dba.bollettine_excel_ext
//	set tara=:adc_peso
//	where id_bollettine_excel=:ll_id_bol;
//	if sqlca.sqlNrows>0 then
//		commit;
//		a=1
//	else
//		rollback;
//		insert into dba.bollettine_excel_ext (id_bollettine_excel, tara)
//		values (:ll_id_bol, :adc_peso);
//		if sqlca.sqlNrows>0 then
//			commit;
//			a=1
//		else
//			rollback;
//			messagebox("Attenzione!", "Tara NON salvata!")
//		end if
//	end if
//	if a=1 then  //correzione 19/10/2021 Samy dice che deve togliere il peso da peso_bilancia, NON da peso...
		ldc_peso=dw_1.getitemdecimal(al_riga, "peso_bilancia") //"peso"
		ldc_tara_precedente=dw_1.getitemdecimal(al_riga, "tara")
		if ldc_tara_precedente>0 then
			adc_peso -=ldc_tara_precedente
		end if
		ldc_peso=ldc_peso - adc_peso
		dw_1.setitem(al_riga, "peso_bilancia", ldc_peso)
	
	//	dw_1.setitem(al_riga, "tara", 0)
	
//else
//	update dba.bollettine_excel_ext
//	set peso_bilancia=:adc_peso
//	where id_bollettine_excel=:ll_id_bol;
//	if sqlca.sqlNrows>0 then
//		commit;
//	else
//		rollback;
//		insert into dba.bollettine_excel_ext (id_bollettine_excel, peso_bilancia, TARA)
//		values (:ll_id_bol, :adc_peso, 0);
//		if sqlca.sqlNrows>0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Peso NON salvata!")
//		end if
//	end if
//end if
end subroutine

public subroutine wf_stampa ();string ls_nome_file
integer li_ret


if dw_1.rowcount()>0 then
	dw_1.Modify("Export.PDF.Method = Distill!")
	dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	ls_nome_file="c:\nita\pdfcontrolloddt\"+string(today(), "dd_mm_yy_hh_mm")+".pdf"
	li_ret=dw_1.SaveAs(ls_nome_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		messagebox("Errore!", "File PDF non generato!")	
	end if
end if


end subroutine

on w_controllo_bol_excel.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_2=create st_2
this.dw_3=create dw_3
this.cb_carica=create cb_carica
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_carica
this.Control[iCurrent+5]=this.dw_4
end on

on w_controllo_bol_excel.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.dw_3)
destroy(this.cb_carica)
destroy(this.dw_4)
end on

event open;call super::open;dw_2.settransobject(sqlca)
dw_2.insertrow(1)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
dw_4.settransobject(sqlca)
post setfocus(dw_2)

//timer(240)
end event

event resize;//
end event

event timer;call super::timer;//wf_stampa()
end event

event close;call super::close;wf_stampa()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_controllo_bol_excel
integer x = 3040
integer y = 96
integer width = 297
integer taborder = 70
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_controllo_bol_excel
boolean visible = false
integer x = 1509
integer y = 1936
integer taborder = 130
end type

type cb_primo from w_semplice_cx`cb_primo within w_controllo_bol_excel
integer x = 942
integer y = 1944
integer taborder = 50
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_controllo_bol_excel
integer x = 1362
integer y = 1944
integer taborder = 120
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_controllo_bol_excel
integer x = 1271
integer y = 1944
integer taborder = 100
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_controllo_bol_excel
integer x = 1399
integer y = 1944
integer taborder = 80
end type

type dw_1 from w_semplice_cx`dw_1 within w_controllo_bol_excel
integer x = 27
integer y = 208
integer width = 5207
integer height = 1896
string dataobject = "d_controllo_pesi_bol_excel"
boolean vscrollbar = true
end type

event dw_1::retrievestart;call super::retrievestart;return 2
end event

event dw_1::itemchanged;call super::itemchanged;
choose case dwo.name
	case "controllato"
		post event ue_update()
	case "tara"
		wf_salva_tara(row, dec(data), "T")

			
		
end choose


end event

event dw_1::ue_post_insert;call super::ue_post_insert;//spostato sul retrieveend

string ls_metallo, ls_cod_barre
decimal ldc_titolo
long ll_num_riga, ll_num_barre, ll_righe_tot
datetime ldt_data

w_bilancia w_bil
decimal ld_peso_netto
integer i
long ll_riga_inserita

dw_1.retrieve("9900000")
ll_riga_inserita=dw_1.find("cod_barre='9900000'", 1, dw_1.rowcount(), primary!)
open(w_bil)
ld_peso_netto=w_bil.f_rendi_peso()
if isnull(ld_peso_netto) or ld_peso_netto<=0 then
	for i=1 to 100
		ld_peso_netto=w_bil.f_rendi_peso()
		if ld_peso_netto>0 then exit
	next
end if
if  isnull(ld_peso_netto) or ld_peso_netto<=0 then
	dw_1.setitem(al_riga, "peso_bilancia", 0)
	messagebox("A", "Peso Non recuperato.... mha...")
else
	dw_1.setitem(al_riga, "peso_bilancia", ld_peso_netto)
end if
close(w_bil)

//select max(cod_barre)
//into :ls_cod_barre
//from dba.bollettine_excel
//where left(cod_barre, 2)='99'
//;
//if isnull(ls_cod_barre) then ls_cod_barre='990000'
//
//ll_num_barre=long(ls_cod_barre)
//ll_num_barre++
//ls_cod_barre=string(ll_num_barre)
//setitem(al_riga, "tipo", "C")
//setitem(al_riga, "cod_barre", ls_cod_barre)
//setitem(al_riga, "cliente", "00000")
//setitem(al_riga, "pezzi", 0)
//setitem(al_riga, "peso", 0)
//setitem(al_riga, "descrizione", "Correzione")
//setitem(al_riga, "articolo", "Correzione")
//ldt_data=getitemdatetime(al_riga -1, "data")
//setitem(al_riga, "data", ldt_data)
//ls_metallo=getitemstring(al_riga -1, "metallo")
//setitem(al_riga, "metallo", ls_metallo)
//ldc_titolo=getitemdecimal(al_riga -1, "titolo")
//setitem(al_riga, "titolo",ldc_titolo)
//ll_righe_tot=rowcount()
////ll_num_riga=getitemnumber(al_riga -1, "c_max_num_riga")
//setitem(al_riga, "num_riga", ll_righe_tot) //ll_num_riga)
//dw_1.setitem(al_riga, "ordine_riga", al_riga)
//setitem(al_riga, "galvanica", "")
//setitem(al_riga, "controllato", "S")
//setitem(al_riga, "bollettine_excel_ext_id_bollettine_excel", 0)
//setitem(al_riga, "tara", 0)
//setitem(al_riga, "data_inserimento", today())
//setitem(al_riga, "controllato", "S")
dw_1.trigger event ue_update()
dw_1.sort()
end event

event dw_1::ue_delete;//

RowsMove(al_riga_da_cancellare, al_riga_da_cancellare,Primary!,  dw_1, 1, filter! )
end event

event dw_1::ue_update;call super::ue_update;
//righe_inserite_5++
//if righe_inserite_5=5 then
//	righe_inserite_5=0
//	wf_stampa()
//end if


Return ANCESTORRETURNVALUE
end event

event dw_1::retrieveend;call super::retrieveend;//string ls_metallo, ls_cod_barre
//decimal ldc_titolo
//long ll_num_riga, ll_num_barre, ll_righe_tot
//datetime ldt_data
//
//
//setitem(1, "controllato", "S")
//dw_1.trigger event ue_update()
//dw_1.sort()
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_controllo_bol_excel
integer x = 2039
integer y = 96
integer taborder = 30
end type

event cb_inserisci::clicked;datetime ldt_data
string ls_cod_barre, ls_data
w_bilancia w_bil
decimal ld_peso_netto
integer i
long ll_riga_inserita, ll_id_bol, ll_cod_barre, ll_num_ordine
datetime ldt_data_ora

select max(cod_barre)
into :ls_cod_barre
from dba.bollettine_excel
where left(cod_barre, 2)='99'
;
ll_cod_barre=long(ls_cod_barre)
ll_cod_barre++
ls_cod_barre=string(ll_cod_barre)
ldt_data_ora=datetime(today(), now())
ls_data="'"+string(year(today()))+string(month(today()))+string(day(today()))+"'"
ll_riga_inserita=dw_4.insertrow(0)
dw_4.setitem(ll_riga_inserita, "cod_barre", ls_cod_barre)
dw_4.setitem(ll_riga_inserita, "cliente", '00000')
dw_4.setitem(ll_riga_inserita, "pezzi", 0)
dw_4.setitem(ll_riga_inserita, "peso", 0)
dw_4.setitem(ll_riga_inserita, "articolo", "Correzione")
dw_4.setitem(ll_riga_inserita, "data", today())
dw_4.setitem(ll_riga_inserita, "galvanica", "")
dw_4.setitem(ll_riga_inserita, "tipo", "B")

dw_4.trigger event ue_update()
ll_id_bol=dw_4.getitemnumber(ll_riga_inserita, "id_bollettine_excel")
//insert into dba.bollettine_excel ("cod_barre", "cliente", "pezzi", "peso", "articolo", "data", "galvanica", "tipo")
//values(ls_cod_barre,  '00000',0, 0, 'Correzione',:ls_data, '0','B');
//if sqlca.sqlcode=0 then
//	commit;
//else
//	rollback;
//	
//end if
dw_1.retrieve(ls_cod_barre)
ll_riga_inserita=dw_1.find("cod_barre='"+ls_cod_barre+"'", 1, dw_1.rowcount(), primary!)

dw_1.setitem(ll_riga_inserita, "bollettine_excel_ext_id_bollettine_excel", ll_id_bol)
dw_1.setitem(ll_riga_inserita, "tara", 0)
dw_1.setitem(ll_riga_inserita, "data_inserimento", today())
ll_num_ordine=dw_1.getitemnumber(1, "c_max_ordine") 
dw_1.setitem(ll_riga_inserita, "ordine_riga", ll_num_ordine)
open(w_bil)
ld_peso_netto=w_bil.f_rendi_peso()
if isnull(ld_peso_netto) or ld_peso_netto<=0 then
	for i=1 to 100
		ld_peso_netto=w_bil.f_rendi_peso()
		if ld_peso_netto>0 then exit
	next
end if
if  isnull(ld_peso_netto) or ld_peso_netto<=0 then
	dw_1.setitem(ll_riga_inserita, "peso_bilancia", 0)
	messagebox("A", "Peso Non recuperato.... mha...")
else
	dw_1.setitem(ll_riga_inserita, "peso_bilancia", ld_peso_netto)
end if
close(w_bil)

dw_1.setitemstatus(ll_riga_inserita, 0, primary!,NewModified!)
dw_1.trigger event ue_update()





end event

type cb_salva from w_semplice_cx`cb_salva within w_controllo_bol_excel
integer x = 2331
integer y = 96
integer taborder = 40
integer weight = 700
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_controllo_bol_excel
integer x = 2615
integer y = 96
integer taborder = 60
end type

event cb_cancella::clicked;long ll_riga_da_cancellare,ll_id_bol
date ldt_data
integer li_ordine

wf_stampa()

if messagebox("Attenzione!", "La riga sarà tolta dalla lista, tuttavia TUTTE LE MODIFICHE ad essa apportate saranno SALVATE!! VUOI PROCEDERE?", stopsign!, yesno!)=1 then
	ll_riga_da_cancellare=dw_1.getrow()
	ll_id_bol=dw_1.getitemnumber(ll_riga_da_cancellare, "bollettine_excel_ext_id_bollettine_excel")
	ldt_data=dw_1.getitemdate(ll_riga_da_cancellare, "data_inserimento")
	
	delete from dba.bollettine_excel_ext
	where id_bollettine_excel=:ll_id_bol and data_inserimento=:ldt_data; //and ordine_riga=:li_ordine;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
	end if
//	dw_1.trigger event ue_delete(ll_riga_da_cancellare)		
	//dw_1.trigger event ue_update()
	cb_carica.trigger event clicked()
end if
end event

type cb_annulla from w_semplice_cx`cb_annulla within w_controllo_bol_excel
boolean visible = false
integer x = 3735
integer y = 96
integer taborder = 90
end type

type cb_ok from w_semplice_cx`cb_ok within w_controllo_bol_excel
integer x = 3387
integer y = 96
integer taborder = 110
end type

type dw_2 from udw_000 within w_controllo_bol_excel
integer x = 549
integer y = 60
integer width = 466
integer height = 112
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cliente_cod_barre"
end type

event editchanged;call super::editchanged;string ls_cod_barre
integer li_ret, i
decimal ld_peso_netto, ldc_peso_attuale
long ll_riga_inserita,ll_id_bol_excel
date ldt_data_ins
w_bilancia w_bil


if len(data) =7 then
	ls_cod_barre=data
	//ls_cod_barre=right(data, 5)
	//ls_cod_barre="%"+ls_cod_barre
	li_ret=dw_1.retrieve(ls_cod_barre)
		//dw_1.sort()
		//sleep(1)
		ll_riga_inserita=dw_1.find("cod_barre='"+ls_cod_barre+"'" , 1, dw_1.rowcount(), primary!)
		//ll_riga_inserita= dw_1.rowcount()
		dw_1.setitem(ll_riga_inserita, "ordine_riga", dw_1.rowcount())
		if li_ret<=0 then
			messagebox("Attenzione!", "Bollettina "+ ls_cod_barre+ " NON trovata!")
			return
		end if
		dw_2.reset()
		dw_2.insertrow(1)
		//recupero peso da bilancia
		ldc_peso_attuale=dw_1.getitemdecimal(1, "peso_bilancia")
		//messagebox("Attuale", string(ldc_peso_attuale))
		//ldc_peso_attuale=0
		if  ldc_peso_attuale<=0 or isnull(ldc_peso_attuale) then
			open(w_bil)
			ld_peso_netto=w_bil.f_rendi_peso()
			if isnull(ld_peso_netto) or ld_peso_netto<=0 then
				for i=1 to 100
					ld_peso_netto=w_bil.f_rendi_peso()
					if ld_peso_netto>0 then exit
				next
			end if
			if  isnull(ld_peso_netto) or ld_peso_netto<=0 then
				messagebox("A", "Peso Non recuperato.... mha...")
			end if
			close(w_bil)
			if isnull(ld_peso_netto) then ld_peso_netto=0
			dw_1.setitem(1, "peso_bilancia", ld_peso_netto)
			ldt_data_ins=dw_1.getitemdate(1, "data_inserimento") //20241121  scrivo la data inseirimento ma prima controllo se già c'è ed è >20240101 (quella che è riemimento per fare campo not null)
			if isnull(ldt_data_ins) or ldt_data_ins<=date("01/01/2024") then ldt_data_ins= today()
			dw_1.setitem(1, "data_inserimento", ldt_data_ins)
			ll_id_bol_excel=dw_1.getitemnumber(1, "bollettine_excel_id_bollettine_excel")
			dw_1.setitem(1, "bollettine_excel_ext_id_bollettine_excel", ll_id_bol_excel)
			dw_1.setitem(1, "tara", 0)
			dw_1.setitemstatus(1, 0, primary!,NewModified!)
			dw_1.trigger event ue_update()
			//post wf_salva_tara(ll_riga_inserita, ld_peso_netto, "P")  //20241121 proviamo così poerché l'ultima riga resta la prima della dw (sono in ordine desc per "ordine" che è il numero di riga, quindi l'ìultima è sempre la prima
			//post wf_salva_tara(1, ld_peso_netto, "P")
		end if
		post setfocus(dw_2)

	
	
	//wf_filtra(ls_cod_barre)
//	post setitem(1, "numero", "")
//	post setfocus(dw_1)
//	dw_1.post scrolltorow(1)
//	dw_1.post setcolumn("num_progressivo")
end if
end event

type st_2 from statictext within w_controllo_bol_excel
integer x = 55
integer y = 84
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "CODICE a BARRE:"
boolean focusrectangle = false
end type

type dw_3 from udw_000 within w_controllo_bol_excel
integer x = 1061
integer y = 56
integer width = 731
integer height = 112
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_data_bol_lista"
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;datetime ldt_data
date ldt_data_ra
string ls_cod_barre, ls_cliente,ls_test
datastore ds_bol_excel
integer i, li_righe

ldt_data=datetime(data)

ds_bol_excel=create datastore
ds_bol_excel.dataobject="d_bol_excel_ra"
ds_bol_excel.settransobject(sqlca)

if ldt_data> datetime('1900-01-01') then
	ldt_data_ra=date(ldt_data)
	li_righe=ds_bol_excel.retrieve(ldt_data_ra)
end if
if messagebox("Attento!", "Se non hai salvato perderai tutte le modifiche. Vado avanti?", stopsign!,  yesno!)=1 then
	dw_1.reset()
	for i = 1 to li_righe
		ls_test=ds_bol_excel.getitemstring(i, "controllato")
		//if ls_test='S' then
			ls_cod_barre=ds_bol_excel.getitemstring(i, "cod_barre")
			//ls_cod_barre="%"+right(ls_cod_barre, 5)
			dw_1.retrieve(ls_cod_barre)
		//end if
	next
end if
destroy ds_bol_excel
end event

type cb_carica from commandbutton within w_controllo_bol_excel
integer x = 4101
integer y = 96
integer width = 343
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica Oggi"
end type

event clicked;date ldt_data
string ls_n_bol

ldt_data=today()

dw_1.reset()

DECLARE c_carica_dw CURSOR FOR
  SELECT cod_barre   
    FROM dba.bollettine_excel  b,  dba.bollettine_excel_ext e
           
   WHERE b.id_bollettine_excel=e.id_bollettine_excel
	and data_inserimento=:ldt_data;
         

OPEN c_carica_dw;

FETCH c_carica_dw INTO :ls_n_bol;

DO WHILE sqlca.sqlcode=0
	dw_1.retrieve(ls_n_bol)
	FETCH c_carica_dw INTO :ls_n_bol;
LOOP

CLOSE c_carica_dw;
end event

type dw_4 from udw_001 within w_controllo_bol_excel
boolean visible = false
integer x = 64
integer y = 2144
integer width = 4859
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_bol_excel_controllo"
end type

