forward
global type w_cambia_cod_articolo from w_001
end type
type dw_1 from udw_base within w_cambia_cod_articolo
end type
type cb_seleziona from commandbutton within w_cambia_cod_articolo
end type
type cb_stampa from commandbutton within w_cambia_cod_articolo
end type
type cb_salva from commandbutton within w_cambia_cod_articolo
end type
type cb_inserisci from commandbutton within w_cambia_cod_articolo
end type
type cb_cancella from commandbutton within w_cambia_cod_articolo
end type
type cb_ricopia from commandbutton within w_cambia_cod_articolo
end type
type cb_modifica from commandbutton within w_cambia_cod_articolo
end type
type dw_2 from udw_base within w_cambia_cod_articolo
end type
type cb_pulisci from commandbutton within w_cambia_cod_articolo
end type
type cb_canc_tutto from commandbutton within w_cambia_cod_articolo
end type
type cb_riepiloghi from commandbutton within w_cambia_cod_articolo
end type
type cb_esaminatore from commandbutton within w_cambia_cod_articolo
end type
type dw_3 from udw_base within w_cambia_cod_articolo
end type
end forward

global type w_cambia_cod_articolo from w_001
integer width = 3438
integer height = 2028
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
cb_seleziona cb_seleziona
cb_stampa cb_stampa
cb_salva cb_salva
cb_inserisci cb_inserisci
cb_cancella cb_cancella
cb_ricopia cb_ricopia
cb_modifica cb_modifica
dw_2 dw_2
cb_pulisci cb_pulisci
cb_canc_tutto cb_canc_tutto
cb_riepiloghi cb_riepiloghi
cb_esaminatore cb_esaminatore
dw_3 dw_3
end type
global w_cambia_cod_articolo w_cambia_cod_articolo

type variables
udw_base idw
end variables

on w_cambia_cod_articolo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_seleziona=create cb_seleziona
this.cb_stampa=create cb_stampa
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.cb_ricopia=create cb_ricopia
this.cb_modifica=create cb_modifica
this.dw_2=create dw_2
this.cb_pulisci=create cb_pulisci
this.cb_canc_tutto=create cb_canc_tutto
this.cb_riepiloghi=create cb_riepiloghi
this.cb_esaminatore=create cb_esaminatore
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_seleziona
this.Control[iCurrent+3]=this.cb_stampa
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_ricopia
this.Control[iCurrent+8]=this.cb_modifica
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.cb_pulisci
this.Control[iCurrent+11]=this.cb_canc_tutto
this.Control[iCurrent+12]=this.cb_riepiloghi
this.Control[iCurrent+13]=this.cb_esaminatore
this.Control[iCurrent+14]=this.dw_3
end on

on w_cambia_cod_articolo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_seleziona)
destroy(this.cb_stampa)
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.cb_ricopia)
destroy(this.cb_modifica)
destroy(this.dw_2)
destroy(this.cb_pulisci)
destroy(this.cb_canc_tutto)
destroy(this.cb_riepiloghi)
destroy(this.cb_esaminatore)
destroy(this.dw_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.insertrow(1)
dw_3.settransobject(sqlca)
end event

type st_1 from w_001`st_1 within w_cambia_cod_articolo
end type

type dw_1 from udw_base within w_cambia_cod_articolo
integer x = 18
integer y = 24
integer width = 3282
integer height = 1464
boolean bringtotop = true
boolean titlebar = true
string title = "Articoli da modificare"
string dataobject = "d_cambia_cod_articolo"
end type

event itemchanged;call super::itemchanged;long ll_id_art, ll_id_cat_cod, ll_id_cat_com
string ls_des, ls_intr, ls_stato
datetime ldt_data_ora

if dwo.name='codice' then
	select id_articolo, descrizione, cod_intrastat, data_ora_ult_cambiamento,
	id_cat_codifica, id_cat_com_articolo, stato
	into :ll_id_art, :ls_des, :ls_intr, :ldt_data_ora, 
	:ll_id_cat_cod, :ll_id_cat_com, :ls_stato
	
	from articolo
	where codice=:data
	;
	setitem(row, "descrizione", ls_des)
	setitem(row, "cod_intrastat", ls_intr)
	setitem(row, "id_articolo", ll_id_art)
	setitem(row, "data_ora_ult_cambiamento", ldt_data_ora)
	setitem(row, "id_cat_codifica", ll_id_cat_cod)
	setitem(row, "id_cat_com_articolo", ll_id_cat_com)
	setitem(row, "stato", ls_stato)
end if
end event

event retrievestart;call super::retrievestart;return 2
end event

event getfocus;call super::getfocus;idw=this
end event

type cb_seleziona from commandbutton within w_cambia_cod_articolo
integer x = 64
integer y = 1732
integer width = 416
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona"
end type

event clicked;s_dw_ritorna st_p
integer li_righe, i, ll_riga
long ll_id_lista, ll_id_art
string ls_cod_art

li_righe=dw_1.getrow()

openwithparm(w_auto_aggiunta_cx, ll_id_lista)


st_p=message.powerobjectparm

if isvalid(st_p) then
	for i=1 to st_p.ds.rowcount()
		//ls_cod_art=st_p.ds.getitemstring(i, "articolo_codice")
		ll_id_art=st_p.ds.getitemnumber(i, "id_articolo")
		dw_1.retrieve(ll_id_art)
//		ll_riga=dw_1.trigger event ue_insert(0)
//		dw_1.setitem(ll_riga, "codice", ls_cod_art)
//		dw_1.trigger event itemchanged(ll_riga, dw_1.object.codice, ls_cod_art)
		
		
	next
//		st_p.ds.rowscopy(1, st_p.ds.rowcount(), primary!, dw_2, li_righe, primary!)
end if


	
end event

type cb_stampa from commandbutton within w_cambia_cod_articolo
integer x = 2843
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;
printsetup()
idw.print()

end event

type cb_salva from commandbutton within w_cambia_cod_articolo
integer x = 576
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_1.triggerevent("ue_update")
end event

type cb_inserisci from commandbutton within w_cambia_cod_articolo
integer x = 942
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;dw_1.trigger event ue_insert(0)
end event

type cb_cancella from commandbutton within w_cambia_cod_articolo
integer x = 1307
integer y = 1732
integer width = 343
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;dw_1.trigger event ue_delete(dw_1.getrow())
end event

type cb_ricopia from commandbutton within w_cambia_cod_articolo
integer x = 1696
integer y = 1728
integer width = 370
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricopia Codice"
end type

event clicked;string ls_cod
integer i
dw_1.setfilter("scegli='1'")
dw_1.filter()
for i= 1 to dw_1.rowcount()
	ls_cod=dw_1.getitemstring(i, "cod_intrastat")
	if ls_cod> "" then continue
	ls_cod=dw_1.getitemstring(i, "codice")
	dw_1.setitem(i, "cod_intrastat", ls_cod)
next
dw_1.setfilter("")
dw_1.filter()
end event

type cb_modifica from commandbutton within w_cambia_cod_articolo
integer x = 2277
integer y = 1728
integer width = 343
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Modifica"
end type

event clicked;string ls_newcod, ls_max_codice, ls_finalcod, ls_like
long ll_id_codifica , ll_riga
integer li_pos_prog, i, li_num_prog, a, li_len_prog
datastore ds_max_codice
dw_2.accepttext()



cb_ricopia.triggerevent("clicked")
ds_max_codice=create datastore
ds_max_codice.dataobject="ds_max_articolo"
ds_max_codice.settransobject(sqlca)
ll_id_codifica=dw_2.getitemnumber(1, "id_cat_cod")
ls_newcod=dw_2.getitemstring(1, "newcod")
li_pos_prog=dw_2.getitemnumber(1, "prog")
IF ll_id_codifica>0 and li_pos_prog>0 and ls_newcod>"" THEN
	ll_riga=ds_max_codice.retrieve(ls_newcod+"%")
	if ll_riga>0 then
		ls_max_codice=ds_max_codice.getitemstring(1, "max_codice")
		li_num_prog=integer(right(ls_max_codice, li_pos_prog))
	else
		li_num_prog=0
	end if
	if isnull(li_num_prog) then li_num_prog=0
	
	dw_1.setfilter("scegli='1'")
	dw_1.filter()
	
	for i=1 to dw_1.rowcount()
		ls_max_codice=""
		dw_1.setitem(i, "id_cat_codifica", ll_id_codifica)
		li_num_prog++
		li_len_prog=len(string(li_num_prog))
		for a=1 to li_pos_prog - li_len_prog
			ls_max_codice+="0"
		next
		ls_finalcod=ls_newcod+ls_max_codice+string(li_num_prog)
		dw_1.setitem(i, "codice", ls_finalcod)
		dw_1.setitem(i, "data_ora_ult_cambiamento", today())
	next
else
	MESSAGEBOX("Attenzione!", "Valorizzare tabella in basso!")
end if
dw_1.setfilter("")
dw_1.filter()
destroy ds_max_codice


end event

type dw_2 from udw_base within w_cambia_cod_articolo
integer x = 2427
integer y = 1508
integer width = 873
integer height = 184
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_new_cod_ext"
end type

type cb_pulisci from commandbutton within w_cambia_cod_articolo
integer x = 64
integer y = 1512
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
string text = "Pulisci DW"
end type

event clicked;



if messagebox("Attenzione!", "Si sta per effettuare la pulizia della DW qui sopra! Continuare?",&
stopsign!, yesno!)=1 then
	dw_1.reset()
	if dw_1.title="Articoli non cancellati" then
		dw_1.title="Articoli da modificare"
	end if
end if
end event

type cb_canc_tutto from commandbutton within w_cambia_cod_articolo
integer x = 1271
integer y = 1512
integer width = 398
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella TUTTO"
end type

event clicked;integer i, a
long ll_id_art[], ll_id

if messagebox("Attenzione!", "Si sta per effettuare cancellazione definitiva degli articoli"+&
" qui sopra! Continuare?",stopsign!, yesno!)=1 then

dw_1.setfilter("scegli='1'")
dw_1.filter()
For i = dw_1.rowcount() to 1 step -1
	ll_id=dw_1.getitemnumber(i, "id_articolo")
	dw_1.deleterow(i)
	if dw_1.update()=1 then
		commit;
	else
		a++
		ll_id_art[a]=ll_id
		rollback;
	end if
next

for i= 1 to a
	if i=1 then
		dw_1.title="Articoli non cancellati"
	end if
	dw_1.retrieve(ll_id_art[i])
next 
end if
dw_1.setfilter("")
dw_1.filter()
end event

type cb_riepiloghi from commandbutton within w_cambia_cod_articolo
integer x = 1691
integer y = 1512
integer width = 393
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Canc. Riepiloghi"
end type

event clicked;delete from riepilogo
;
if sqlca.sqlcode= -1 then
	rollback;
	MessageBox("SQL error", SQLCA.SQLErrText)

else
	commit;	
end if
end event

type cb_esaminatore from commandbutton within w_cambia_cod_articolo
integer x = 864
integer y = 1512
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esaminatore"
end type

event clicked;integer i, a
long ll_id_art, ll_id_trovato[], ll_riga
string ls_tab[]
string  Mysql, ls_app
	
ls_tab[1]="anag_modello"
ls_tab[2]="art_accessorio"
ls_tab[3]="art_commessa"
ls_tab[4]="art_lav_commessa"
ls_tab[5]="articolo_produzione"
ls_tab[6]="classe_articolo"
ls_tab[7]="cmc"
ls_tab[8]="com_bilancio"
ls_tab[9]="con_cpt_sconti"
ls_tab[10]="con_lis_articolo"
ls_tab[11]="con_lis_articolo"
ls_tab[12]="con_movimento"
ls_tab[13]="con_movimento_pdc"
ls_tab[14]="con_provvigione"
ls_tab[15]="con_provvigione"
ls_tab[16]="des_articolo"
ls_tab[17]="distinta"
ls_tab[18]="fabbisogno"
ls_tab[19]="infilatura"
ls_tab[20]="lista_art_key"
ls_tab[21]="loc_predefinita"
ls_tab[22]="lotto"
ls_tab[23]="orafo_lung_peso"
ls_tab[24]="pre_commessa"
ls_tab[25]="prof_prop_righe_documento"
ls_tab[26]="prz_attribuito"
ls_tab[27]="rch_scn_mag"
ls_tab[28]="rch_tmp_log"
ls_tab[29]="riepilogo"
ls_tab[30]="riga_componente"
ls_tab[31]="riga_distinta"
ls_tab[32]="riga_documento"
ls_tab[33]="sconto_quantita"
ls_tab[34]="sostituzione"
ls_tab[35]="sostituzione"
ls_tab[36]="sotto_articolo"
ls_tab[37]="unita_conf_base"
ls_tab[38]="unita_confezione"
ls_tab[39]="var_mod_riga_documento"
dw_3.visible=true
		
DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
for i= 1 to dw_1.rowcount()
	ll_id_art=dw_1.getitemnumber(i, "id_articolo")
	ls_app=""
	ll_riga=dw_3.retrieve(ll_id_art)
	for a= 1 to 39
		mysql="select id_articolo FROM "+ls_tab[a] +" WHERE id_articolo=?" 
			
		PREPARE SQLSA FROM :mysql ;
	
		OPEN DYNAMIC my_cursor using :ll_id_art ;
		ll_id_trovato[i]=0
		FETCH my_cursor INTO :ll_id_trovato[i] ;
		
		if ll_id_trovato[i]> 0 then
			ls_app+="tabella: "+ls_tab[a]+"; "
		end if
		CLOSE my_cursor ;
		dw_3.setitem(dw_3.rowcount(), "note", ls_app)
	next

		
next
end event

type dw_3 from udw_base within w_cambia_cod_articolo
boolean visible = false
integer y = 28
integer width = 3159
integer height = 1464
boolean titlebar = true
string title = "Referenze articoli non cancellati"
string dataobject = "d_cerca_ref_articolo"
end type

event itemchanged;call super::itemchanged;long ll_id_art, ll_id_cat_cod, ll_id_cat_com
string ls_des, ls_intr, ls_stato
datetime ldt_data_ora

if dwo.name='codice' then
	select id_articolo, descrizione, cod_intrastat, data_ora_ult_cambiamento,
	id_cat_codifica, id_cat_com_articolo, stato
	into :ll_id_art, :ls_des, :ls_intr, :ldt_data_ora, 
	:ll_id_cat_cod, :ll_id_cat_com, :ls_stato
	
	from articolo
	where codice=:data
	;
	setitem(row, "descrizione", ls_des)
	setitem(row, "cod_intrastat", ls_intr)
	setitem(row, "id_articolo", ll_id_art)
	setitem(row, "data_ora_ult_cambiamento", ldt_data_ora)
	setitem(row, "id_cat_codifica", ll_id_cat_cod)
	setitem(row, "id_cat_com_articolo", ll_id_cat_com)
	setitem(row, "stato", ls_stato)
end if
end event

event retrievestart;call super::retrievestart;return 2
end event

event rbuttondown;call super::rbuttondown;visible=false
end event

event getfocus;call super::getfocus;idw=this
end event

