forward
global type w_cod_accessori_k from w_semplice_gd
end type
type cb_carica from commandbutton within w_cod_accessori_k
end type
type ole_1 from olecontrol within w_cod_accessori_k
end type
type dw_2 from udw_001 within w_cod_accessori_k
end type
type dw_3 from udw_000 within w_cod_accessori_k
end type
type cb_cerca from commandbutton within w_cod_accessori_k
end type
type cb_annul from commandbutton within w_cod_accessori_k
end type
type cb_sostituisci from commandbutton within w_cod_accessori_k
end type
type st_1 from statictext within w_cod_accessori_k
end type
type cb_doppi from commandbutton within w_cod_accessori_k
end type
end forward

global type w_cod_accessori_k from w_semplice_gd
integer width = 5751
integer height = 2732
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_carica cb_carica
ole_1 ole_1
dw_2 dw_2
dw_3 dw_3
cb_cerca cb_cerca
cb_annul cb_annul
cb_sostituisci cb_sostituisci
st_1 st_1
cb_doppi cb_doppi
end type
global w_cod_accessori_k w_cod_accessori_k

on w_cod_accessori_k.create
int iCurrent
call super::create
this.cb_carica=create cb_carica
this.ole_1=create ole_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_cerca=create cb_cerca
this.cb_annul=create cb_annul
this.cb_sostituisci=create cb_sostituisci
this.st_1=create st_1
this.cb_doppi=create cb_doppi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_carica
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_cerca
this.Control[iCurrent+6]=this.cb_annul
this.Control[iCurrent+7]=this.cb_sostituisci
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_doppi
end on

on w_cod_accessori_k.destroy
call super::destroy
destroy(this.cb_carica)
destroy(this.ole_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_cerca)
destroy(this.cb_annul)
destroy(this.cb_sostituisci)
destroy(this.st_1)
destroy(this.cb_doppi)
end on

event resize;call super::resize;cb_carica.y=newheight - 224
cb_carica.x=cb_ricerca.x - 385

dw_3.x=cb_stampa.x + cb_stampa.width +50
dw_3.y=cb_stampa.y 


cb_cerca.x=dw_3.x + dw_3.width +50
cb_sostituisci.x=cb_cerca.x

cb_cerca.y=dw_3.y - 22
cb_sostituisci.y=dw_3.y+dw_3.height - cb_sostituisci.height - cb_annul.height +10

cb_annul.y=dw_3.y+dw_3.height - cb_sostituisci.height +15
cb_annul.x=cb_sostituisci.x
st_1.x=cb_carica.x - 80
st_1.y=cb_annul.y - 20

cb_doppi.x=cb_salva.x
cb_doppi.y=cb_salva.y + cb_salva.height+20
end event

event open;call super::open;long ll_riga_inserita
string ls_accessorio

if message.stringparm> "  " then
	ls_accessorio=message.stringparm
	ll_riga_inserita=dw_1.insertrow(0)
	dw_1.setitem(ll_riga_inserita, "cod_accessorio", ls_accessorio)
	dw_1.scrolltorow(ll_riga_inserita)
	dw_1.setcolumn("descrizione")
end if

dw_2.settransobject(sqlca)

dw_3.insertrow(1)
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_cod_accessori_k
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_cod_accessori_k
end type

type cb_primo from w_semplice_gd`cb_primo within w_cod_accessori_k
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_cod_accessori_k
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_cod_accessori_k
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_cod_accessori_k
end type

type dw_1 from w_semplice_gd`dw_1 within w_cod_accessori_k
integer width = 5678
string dataobject = "d_cod_accessori_k"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_cod_accessori_k
end type

type cb_salva from w_semplice_gd`cb_salva within w_cod_accessori_k
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_cod_accessori_k
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_cod_accessori_k
end type

type cb_ok from w_semplice_gd`cb_ok within w_cod_accessori_k
end type

type cb_carica from commandbutton within w_cod_accessori_k
integer x = 2459
integer y = 992
integer width = 352
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica XLS"
end type

event clicked;string ls_path, ls_file,ls_acc_new, ls_des_new
integer i
long ll_righe,ll_riga_trovata

getfileopenname("Cerca Accessori", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+"txt"
	if fileexists(ls_file) then FileDelete(ls_file)
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_2.reset()
	dw_2.importfile(Text!,ls_file,2)
	if messagebox("Attenzione!", "Saranno aggiornate le descrizione degli accessori esistenti e aggiunti i nuovi accessori: procedere?", stopsign!, yesno!)=1 then
		ll_righe=dw_2.rowcount()
		for i = 1 to  ll_righe
			ls_acc_new=dw_2.getitemstring(i, "cod_accessorio")
			ls_des_new=dw_2.getitemstring(i, "descrizione")
		
			ll_riga_trovata=0
			ll_riga_trovata=dw_1.find("cod_accessorio='"+ls_acc_new+"'", 1, dw_1.rowcount())
			if ll_riga_trovata>0 then
				if isnull(ls_des_new) or ls_des_new="" then ls_des_new=dw_1.getitemstring(ll_riga_trovata, "descrizione")
				dw_1.setitem(ll_riga_trovata, "descrizione", ls_des_new)
				//20221216 samy vuole anche la data di inserimento
				dw_1.setitem(ll_riga_trovata, "des_ges_scorta", string(today(), "yy/mm/dd")+"-Riga "+string(i)+" del file xls")
			else
				dw_2.rowscopy(i, i, primary!, dw_1, dw_1.rowcount(), primary!)
				if isnull(ls_des_new) or ls_des_new="" then dw_1.setitem(ll_riga_trovata, "descrizione", "?")
				dw_1.setitem(i, "des_ges_scorta", "Inserita riga "+string(i)+" del file xls")
			end if
		next
		
	end if

end if	 
end event

type ole_1 from olecontrol within w_cod_accessori_k
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
integer x = 3666
integer y = 1140
integer width = 320
integer height = 140
integer taborder = 90
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_cod_accessori_k.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type dw_2 from udw_001 within w_cod_accessori_k
boolean visible = false
integer x = 32
integer y = 1632
integer width = 5678
integer height = 848
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_cod_accessori_k"
boolean minbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event clicked;call super::clicked;integer i, li_ret
string ls_cod
decimal ldc_peso
if dwo.name="b_cancella" then
	for I=1 to dw_2.rowcount()
		
		li_ret=dw_2.setitemstatus(i, 0, primary!, DataModified!)
		ls_cod=dw_2.getitemstring(i, "cod_accessorio")
		ldc_peso=dw_2.getitemdecimal(i, "peso")
		delete cod_accessori_k where cod_accessorio=:ls_cod and peso=:ldc_peso;
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Attrenzione!", "Riga "+string(i)+" non cancellata!")
		end if
	next
//	dw_2.rowsmove(1, dw_2.rowcount(), primary!, dw_2, 1, delete!) 
//	dw_2.trigger event ue_update()
	dw_2.modify("b_cancella.visible=false")
	dw_2.modify("b_stampa.visible=false")
	dw_2.visible=false
end if
if dwo.name="b_stampa" then
	dw_2.print(true,true)
end if

if dwo.name="b_chiudi" then
	dw_2.reset()
	dw_2.modify("b_cancella.visible=false")
	dw_2.modify("b_stampa.visible=false")
	dw_2.visible=false
end if
end event

type dw_3 from udw_000 within w_cod_accessori_k
integer x = 987
integer y = 1352
integer width = 2592
integer height = 204
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_cerca_e_sostituisci_acc_k"
end type

type cb_cerca from commandbutton within w_cod_accessori_k
integer x = 3611
integer y = 1336
integer width = 315
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cerca"
end type

event clicked;string ls_colonna, ls_da_cercare, ls_filtro, ls_da_sostituire, ls_valore_campo, ls_replace
integer i, n, li_start
dw_3.accepttext()
ls_colonna=dw_3.getitemstring(1,"colonna")
ls_da_cercare=dw_3.getitemstring(1,"da_cercare")
ls_da_cercare=upper(ls_da_cercare)  //20250306 faccio in modo da ignorare le lettere minuscole maiuscole: forzo tutto a maiuscolo
if ls_colonna> " " and ls_da_cercare> " " then
	ls_filtro="Upper("+ls_colonna+") like '%"+ls_da_cercare+"%'"    //20250306 faccio in modo da ignorare le lettere minuscole maiuscole: forzo tutto a maiuscolo
	dw_1.setfilter(ls_filtro)
	dw_1.filter()
else
	messagebox("Attenzione!", "Definire prima la colonna e la stringa da cercare!")
end if



end event

type cb_annul from commandbutton within w_cod_accessori_k
integer x = 3611
integer y = 1496
integer width = 315
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;	dw_1.setfilter("")
	
dw_1.filter()
end event

type cb_sostituisci from commandbutton within w_cod_accessori_k
integer x = 3611
integer y = 1416
integer width = 315
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sostituisci"
end type

event clicked;string ls_da_sostituire, ls_valore_campo, ls_colonna, ls_replace,ls_da_cercare
integer i, li_start, n
ls_colonna=dw_3.getitemstring(1,"colonna")
ls_da_cercare=dw_3.getitemstring(1,"da_cercare")
ls_da_sostituire=dw_3.getitemstring(1,"da_sostituire")
if ls_colonna> " " and ls_da_cercare> " " and ls_da_sostituire> " " then
	for i=1 to dw_1.rowcount()
		ls_valore_campo=dw_1.getitemstring(i,ls_colonna)
		li_start=pos(ls_valore_campo,ls_da_cercare)
		n=len(ls_da_cercare)
		ls_replace=Replace ( ls_valore_campo, li_start, n, ls_da_sostituire )
		dw_1.setitem(i,ls_colonna, ls_replace)
	next
else
	messagebox("Attenzione!", "Definire prima la colonna e la stringa da cercare e anche quella da sostituire!")
end if
	
end event

type st_1 from statictext within w_cod_accessori_k
integer x = 2350
integer y = 1096
integer width = 1193
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32896
long backcolor = 67108864
string text = "Il file da caricare DEVE essere formato ~"XLS~""
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_doppi from commandbutton within w_cod_accessori_k
integer x = 50
integer y = 1156
integer width = 261
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "DOPPI"
end type

event clicked;integer i
string ls_cod, ls_cod_test

dw_2.reset()
dw_2.visible=true
dw_2.modify("b_cancella.visible=true")
dw_2.modify("b_stampa.visible=true")
for i=1 to dw_1.rowcount() - 1
	ls_cod=dw_1.getitemstring(i, "cod_accessorio")
	ls_cod_test=dw_1.getitemstring(i+1, "cod_accessorio")
	if ls_cod=ls_cod_test then
		dw_1.rowscopy(i+1, i+1, primary!, dw_2, dw_2.rowcount()+1, primary!)
	end if
next
//dw_1.rowscopy(1, dw_1.rowcount(), primary!, dw_2, 1, primary!)

end event

