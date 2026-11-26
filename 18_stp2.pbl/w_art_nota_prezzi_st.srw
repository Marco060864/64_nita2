forward
global type w_art_nota_prezzi_st from w_001
end type
type cb_nuovo from commandbutton within w_art_nota_prezzi_st
end type
type cb_salva from commandbutton within w_art_nota_prezzi_st
end type
type cb_cancella from commandbutton within w_art_nota_prezzi_st
end type
type cb_esci from commandbutton within w_art_nota_prezzi_st
end type
type dw_1 from u_dw_base within w_art_nota_prezzi_st
end type
type cb_stampa from commandbutton within w_art_nota_prezzi_st
end type
end forward

global type w_art_nota_prezzi_st from w_001
integer width = 4357
string title = "Inserisci note, prezzi e costi articolo"
cb_nuovo cb_nuovo
cb_salva cb_salva
cb_cancella cb_cancella
cb_esci cb_esci
dw_1 dw_1
cb_stampa cb_stampa
end type
global w_art_nota_prezzi_st w_art_nota_prezzi_st

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public subroutine wf_carica_costi (long al_row, long al_id_art)
end prototypes

public subroutine wf_ricerca (long al_riga_corrente, string as_data);long ll_id_sog, ll_id_art
decimal ldc_peso_lordo
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_documento_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	//RETRIEVE
	dw_1.deleterow(al_riga_corrente)
	DW_1.RETRIEVE(ls_ric_param.s_main_value)
	dw_1.scrolltorow(dw_1.rowcount())
	post wf_carica_costi(al_riga_corrente, long(ls_ric_param.s_id_seg_value[1]))
end if
end subroutine

public subroutine wf_carica_costi (long al_row, long al_id_art);//carica saldatura, spazzolatura e galvanica se ci sono
datastore ds_cerca_costi
integer i
string ls_lavorazione
decimal ldc_costo
long ll_righe

ds_cerca_costi=create datastore
ds_cerca_costi.dataobject="d_rec_costi_distinta"
ds_cerca_costi.settransobject(sqlca)
ll_righe=ds_cerca_costi.retrieve(al_id_art)
for i=1 to ll_righe
	ls_lavorazione=ds_cerca_costi.getitemstring(i, "lavorazione")
	ldc_costo=ds_cerca_costi.getitemdecimal(i, "costo")
	dw_1.setitem(al_row, "c_"+ls_lavorazione, ldc_costo)
next
destroy ds_cerca_costi
end subroutine

on w_art_nota_prezzi_st.create
int iCurrent
call super::create
this.cb_nuovo=create cb_nuovo
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_esci=create cb_esci
this.dw_1=create dw_1
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_nuovo
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.cb_cancella
this.Control[iCurrent+4]=this.cb_esci
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_stampa
end on

on w_art_nota_prezzi_st.destroy
call super::destroy
destroy(this.cb_nuovo)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_esci)
destroy(this.dw_1)
destroy(this.cb_stampa)
end on

event open;call super::open;DW_1.SETTRANsOBJECT(SQLCA)
end event

type st_1 from w_001`st_1 within w_art_nota_prezzi_st
end type

type cb_nuovo from commandbutton within w_art_nota_prezzi_st
integer x = 2843
integer y = 20
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga

ll_riga=dw_1.INSERTROW(0)
dw_1.scrolltorow(ll_riga)
dw_1.setfocus()
dw_1.setcolumn(2)
end event

type cb_salva from commandbutton within w_art_nota_prezzi_st
integer x = 3575
integer y = 20
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
string text = "Salva"
end type

event clicked;string ls_nota, ls_lavorazione, ls_tipo_um,ls_test_lav
long ll_id_articolo, ll_righe, i, a, ll_lavorazioni, ll_id_uc, b, ll_esiste
decimal ldc_sald, ldc_spaz, ldc_galv, ldc_costo, ldc_prezzo, ldc_prezzo_man
datastore ds_cerca_costi
ds_cerca_costi=create datastore
ds_cerca_costi.dataobject="d_rec_costi_distinta"
ds_cerca_costi.settransobject(sqlca)

dw_1.accepttext()

ll_righe=dw_1.rowcount()
for i= 1 to ll_righe
	ll_id_articolo=dw_1.getitemnumber(i, "articolo_id_articolo")
	ls_nota=dw_1.getitemstring(i, "articolo_nota")
	update articolo
	set nota=:ls_nota
	where id_articolo=:ll_id_articolo;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Salvataggio nota non riuscito!")
	end if
	//ora salvo i costi e il prezzo di vendita
	//prima il prezzo di vendita
	ldc_prezzo=dw_1.getitemdecimal(i, "prezzo")
	ldc_prezzo_man=dw_1.getitemdecimal(i, "prezzo_manifattura")
	ll_id_uc=dw_1.getitemnumber(i, "id_unita_confezione")
	update prezzo
	set prezzo_manifattura=:ldc_prezzo_man, prezzo=:ldc_prezzo
	from prezzo p, variazione v, listino l
	where id_unita_confezione=:ll_id_uc
	and l.tipo='V'
	and l.lis_base='S'
	and v.data_inizio<= today()
	and (v.data_fine>= today() or v.data_fine is null)
	and v.id_listino=l.id_listino
	and p.id_variazione=v.id_variazione
	;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Salvataggio prezzo non riuscito!")
	end if
	//poi i costi
	ldc_sald=dw_1.getitemdecimal(i, "c_sa")
	ldc_spaz=dw_1.getitemdecimal(i, "c_sp")
	ldc_galv=dw_1.getitemdecimal(i, "c_gv")
	ll_lavorazioni=ds_cerca_costi.retrieve(ll_id_articolo)
	if ll_lavorazioni<3 then
		//controllo se il campo saldatura e gli altri sono stati modificati (status newmodify or mofidy)
		
		//... da fare
		for b= 1 to 3
			
			if b=1 then ls_test_lav='SA'
			if b=2 then ls_test_lav='SP'
			if b=3 then ls_test_lav='GV'
			ll_esiste=ds_cerca_costi.find("lavorazione="+ls_test_lav, 1, ll_lavorazioni)
			if ll_esiste<=0 then
				//inserisco la riga mancante
			end if
				
		next
	end if
	for a=1 to ds_cerca_costi.rowcount()
		ldc_costo=0
		ls_lavorazione=ds_cerca_costi.getitemstring(a, "lavorazione")
		choose case upper(ls_lavorazione)
			case 'SA'
				if ldc_sald>0 then 
					
					ldc_costo=ldc_sald
				end if
			case "SP"
				if ldc_spaz>0 then  ldc_costo=ldc_spaz
			case "GV"
				if ldc_galv>0 then ldc_costo=ldc_galv
		end choose
		ds_cerca_costi.setitem(a, "costo", ldc_costo)
		if ds_cerca_costi.update()=1 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio costo non riuscito!")
		end if

	next
	
next

destroy ds_cerca_costi

end event

type cb_cancella from commandbutton within w_art_nota_prezzi_st
integer x = 3209
integer y = 20
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
string text = "Cancella"
end type

event clicked;if dw_1.getrow()>0 then
	dw_1.deleterow(dw_1.getrow())
end if
end event

type cb_esci from commandbutton within w_art_nota_prezzi_st
integer x = 3941
integer y = 20
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_base within w_art_nota_prezzi_st
integer x = 32
integer y = 148
integer width = 4256
integer height = 1328
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_art_nota_prezzo_costo_tb"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;LONG ll_id_articolo

if dwo.name="articolo_codice" then
	deleterow(row)
	select id_articolo
	into :ll_id_articolo
	from articolo 
	where codice=:data
	;
	if sqlca.sqlcode=0 then
		//retrieve
		dw_1.retrieve(data)
		post setfocus(this)
		post wf_carica_costi(row, ll_id_articolo)
					
//		post wf_trova_lung_peso(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
//		post wf_trova_prezzo(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
//		post wf_trova_immagine(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
			
	else
		post wf_ricerca(row, data)
		
		
	end if
end if
end event

event clicked;call super::clicked;string ls_codice, ls_intestatario

accepttext()
if row>0 then
	if string(dwo.name)= "cod_articolo_sw"  then
		ls_codice=dw_1.getitemstring(row, "cod_articolo")
		wf_ricerca( row, ls_codice)
	end if
end if
end event

event ue_key;call super::ue_key;choose case key
	case KeyS!, keyf12!
		if keyflags=2 then
			cb_salva.triggerevent(clicked!)
		end if
	case Keydownarrow!
		if getrow()=rowcount()and keyflags=2 then
			cb_salva.triggerevent(clicked!)
		end if
	case KeyAdd!
		if keyflags=2 then
			cb_nuovo.triggerevent(clicked!)
		end if
	case KeyDelete!,KeySubtract!
		if keyflags=2 then
			cb_cancella.triggerevent(clicked!)
		end if
	case KeyPrintScreen!
		cb_stampa.triggerevent(clicked!)
	case KeyP!
		if keyflags=2 then
			cb_stampa.triggerevent(clicked!)
		end if
	case KeyX!
		if keyflags=2 then
			cb_ESCI.triggerevent(clicked!)
		end if
	case keyenter!
		cb_nuovo.triggerevent(clicked!)
	case keytab! 
		if getcolumn()=6 then
			cb_nuovo.triggerevent(clicked!)
		end if
end choose

end event

event retrievestart;call super::retrievestart;return 2
end event

type cb_stampa from commandbutton within w_art_nota_prezzi_st
integer x = 2391
integer y = 20
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
string text = "Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

