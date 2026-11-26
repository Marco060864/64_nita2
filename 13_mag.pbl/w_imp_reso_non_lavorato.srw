forward
global type w_imp_reso_non_lavorato from w_semplice_cx
end type
type dw_2 from udw_001 within w_imp_reso_non_lavorato
end type
type cb_carica from commandbutton within w_imp_reso_non_lavorato
end type
type ole_1 from olecontrol within w_imp_reso_non_lavorato
end type
type cb_1 from commandbutton within w_imp_reso_non_lavorato
end type
type cb_2 from commandbutton within w_imp_reso_non_lavorato
end type
end forward

global type w_imp_reso_non_lavorato from w_semplice_cx
integer width = 3931
integer height = 1952
boolean minbox = false
windowtype windowtype = response!
dw_2 dw_2
cb_carica cb_carica
ole_1 ole_1
cb_1 cb_1
cb_2 cb_2
end type
global w_imp_reso_non_lavorato w_imp_reso_non_lavorato

forward prototypes
public function long wf_crea_articolo (string as_cod_art, long al_id_titolo)
public function long wf_esiste_articolo (string as_cod_articolo)
end prototypes

public function long wf_crea_articolo (string as_cod_art, long al_id_titolo);long ll_riga_inserita, ll_null, ll_id_art_locale, ll_id_uc, ll_id_variazione
string ls_data, ls_num_doc
datetime ldt_data
dw_2.reset()

setnull(ll_null)

ll_riga_inserita=dw_2.insertrow(1)
dw_2.setitem(ll_riga_inserita, "id_articolo", ll_null)
if len(as_cod_art)>64 then messagebox("Attenzione!", "Articolo: "+as_cod_art+" Più lungo di 64!!!!")
dw_2.setitem(ll_riga_inserita, "codice", as_cod_art)  
dw_2.setitem(ll_riga_inserita, "descrizione", as_cod_art)
dw_2.setitem(ll_riga_inserita, "des_breve", left(as_cod_art, 40))
dw_2.setitem(ll_riga_inserita, "id_cat_codifica", 13) //è cat_codifica creata all'uopo "AUTO"
dw_2.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)

dw_2.setitem(ll_riga_inserita,"id_cat_com_articolo", 8) //è Altri art
dw_2.setitem(ll_riga_inserita,"id_titolo", al_id_titolo) 
dw_2.setitem(ll_riga_inserita,"coef_calo",1000) //deve essere sempre 1000 ????
dw_2.setitem(ll_riga_inserita,"immagine", as_cod_art+".jpg")
dw_2.setitem(ll_riga_inserita,"nota", "Art. da EXCEL")
dw_2.setitem(ll_riga_inserita,"id_unita_conf_base", 3) // con questa crea da se unita_conf a PZ
dw_2.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
dw_2.trigger event ue_update()  //salvo e inserisco l'articolo

ll_id_art_locale=dw_2.getitemnumber(1, "id_articolo") //lo recupero
	
return ll_id_art_locale
end function

public function long wf_esiste_articolo (string as_cod_articolo);long ll_id_art_locale

select id_articolo
into :ll_id_art_locale
from dba.articolo
where codice=:as_cod_articolo 
;						
return ll_id_art_locale
end function

on w_imp_reso_non_lavorato.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_carica=create cb_carica
this.ole_1=create ole_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_carica
this.Control[iCurrent+3]=this.ole_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
end on

on w_imp_reso_non_lavorato.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_carica)
destroy(this.ole_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event resize;//dw_1.width=newwidth - 105
//dw_1.height=newheight - 292
//
//cb_inserisci.y=newheight - 224
//cb_inserisci.x=dw_1.x
//cb_cancella.y=newheight - 224
//cb_salva.y=newheight - 224
//cb_salva.x=cb_inserisci.x + 285
//cb_cancella.x=cb_salva.x + 285
//
//
//
//cb_ultimo.x=cb_avanti.x + 128
//
//cb_ok.y=newheight - 224
//cb_ok.x=dw_1.x + dw_1.width - cb_ok.width
//cb_ricerca.y=newheight - 224
//cb_ricerca.x=cb_ok.x - 285
//cb_annulla.y=newheight - 224
//cb_annulla.x=cb_ricerca.x - 285
//cb_ricerca.y=newheight - 224
//cb_ricerca.x=cb_annulla.x - 285
//cb_stampa.x=cb_cancella.x + 285
//cb_stampa.y=cb_salva.y
//
//cb_primo.y=newheight - 208
//cb_primo.x=cb_stampa.x + 261
//cb_indietro.y=newheight - 208
//cb_indietro.x=cb_primo.x + 160
//cb_avanti.y=newheight - 208
//cb_avanti.x=cb_indietro.x + 160
//cb_ultimo.y=newheight - 208
end event

event open;call super::open;dw_2.settransobject(sqlca)
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_imp_reso_non_lavorato
boolean visible = false
integer x = 46
integer y = 1768
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_imp_reso_non_lavorato
boolean visible = false
integer x = 1467
integer y = 1904
end type

type cb_primo from w_semplice_cx`cb_primo within w_imp_reso_non_lavorato
integer x = 905
integer y = 1912
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_imp_reso_non_lavorato
integer x = 1321
integer y = 1912
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_imp_reso_non_lavorato
integer x = 1234
integer y = 1912
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_imp_reso_non_lavorato
integer x = 1362
integer y = 1912
end type

type dw_1 from w_semplice_cx`dw_1 within w_imp_reso_non_lavorato
integer width = 3456
integer height = 1212
string dataobject = "d_imp_reso_non_lavorato"
end type

event dw_1::itemchanged;call super::itemchanged;s_dw_ritorna ldw_ritorna
integer li_ret

ldw_ritorna.ds=create datastore
ldw_ritorna.ds.dataobject="d_imp_reso_non_lavorato"
ldw_ritorna.ds.settransobject(sqlca)

li_ret=dw_1.rowscopy(1, dw_1.rowcount(), primary!, ldw_ritorna.ds, 1, primary!)

closewithreturn(parent, ldw_ritorna)

end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_imp_reso_non_lavorato
boolean visible = false
integer x = 37
integer y = 1896
end type

type cb_salva from w_semplice_cx`cb_salva within w_imp_reso_non_lavorato
boolean visible = false
integer x = 320
integer y = 1896
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_imp_reso_non_lavorato
boolean visible = false
integer x = 608
integer y = 1896
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_imp_reso_non_lavorato
boolean visible = false
integer x = 1742
integer y = 1900
end type

type cb_ok from w_semplice_cx`cb_ok within w_imp_reso_non_lavorato
boolean visible = false
integer x = 2030
integer y = 1900
end type

type dw_2 from udw_001 within w_imp_reso_non_lavorato
integer x = 32
integer y = 1300
integer width = 3840
integer taborder = 10
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_carica from commandbutton within w_imp_reso_non_lavorato
integer x = 3502
integer y = 28
integer width = 338
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica Excel"
end type

event clicked;string ls_path, ls_file
	
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\excel")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+"txt"
	if fileexists(ls_file) then FileDelete(ls_file)
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_1.importfile(Text!,ls_file,2)

end if	 



end event

type ole_1 from olecontrol within w_imp_reso_non_lavorato
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
integer x = 3502
integer y = 1020
integer width = 338
integer height = 216
integer taborder = 20
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_imp_reso_non_lavorato.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type cb_1 from commandbutton within w_imp_reso_non_lavorato
integer x = 3502
integer y = 176
integer width = 338
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Articoli"
end type

event clicked;integer i
string ls_cod_art
long ll_id_titolo, ll_id_art_locale
ll_id_titolo=27

for i =1 to dw_1.rowcount()
	ls_cod_art=dw_1.getitemstring(i, "cod_articolo")
	ll_id_art_locale=wf_esiste_articolo(ls_cod_art)
	if isnull( ll_id_art_locale) or ll_id_art_locale<=0  then
		
		ll_id_art_locale=wf_crea_articolo(ls_cod_art, ll_id_titolo)
	end if
	dw_1.setitem(i, "id_articolo", ll_id_art_locale)
next
end event

type cb_2 from commandbutton within w_imp_reso_non_lavorato
integer x = 3502
integer y = 324
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
string text = "Riporta"
end type

event clicked;s_dw_ritorna ldw_ritorna

ldw_ritorna.ds= create datastore
ldw_ritorna.ds.dataobject="d_imp_reso_non_lavorato"
ldw_ritorna.ds.settransobject(sqlca)
//ldw_ritorna.ds=dw_1
dw_1.rowscopy(1, dw_1.rowcount(), primary!, ldw_ritorna.ds, 1, primary!)
closewithreturn(parent, ldw_ritorna)
end event

