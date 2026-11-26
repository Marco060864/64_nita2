forward
global type w_sped_a_barre from w_base
end type
type cbx_2_in_1 from checkbox within w_sped_a_barre
end type
type st_1 from statictext within w_sped_a_barre
end type
type em_pezzi from editmask within w_sped_a_barre
end type
type cb_1 from commandbutton within w_sped_a_barre
end type
type cb_reset from commandbutton within w_sped_a_barre
end type
type cb_cancella from commandbutton within w_sped_a_barre
end type
type cb_salva from commandbutton within w_sped_a_barre
end type
type cbx_bilancia from checkbox within w_sped_a_barre
end type
type dw_4 from udw_001 within w_sped_a_barre
end type
type pb_stampa from picturebutton within w_sped_a_barre
end type
type st_operatore from statictext within w_sped_a_barre
end type
type dw_3 from udw_001 within w_sped_a_barre
end type
type dw_5 from udw_001 within w_sped_a_barre
end type
type dw_2 from udw_base within w_sped_a_barre
end type
type dw_1 from udw_base within w_sped_a_barre
end type
end forward

global type w_sped_a_barre from w_base
integer width = 3849
integer height = 2456
cbx_2_in_1 cbx_2_in_1
st_1 st_1
em_pezzi em_pezzi
cb_1 cb_1
cb_reset cb_reset
cb_cancella cb_cancella
cb_salva cb_salva
cbx_bilancia cbx_bilancia
dw_4 dw_4
pb_stampa pb_stampa
st_operatore st_operatore
dw_3 dw_3
dw_5 dw_5
dw_2 dw_2
dw_1 dw_1
end type
global w_sped_a_barre w_sped_a_barre

type variables

end variables

forward prototypes
public subroutine wf_recupera_peso_bil (long al_riga)
public function string wf_ins_cod_barre (long al_riga, date adt_data_doc)
end prototypes

public subroutine wf_recupera_peso_bil (long al_riga);//wf_recupera_peso_bil
end subroutine

public function string wf_ins_cod_barre (long al_riga, date adt_data_doc);string ls_cod_barre, ls_num_prog, ls_stato
string ls_fornitore, ls_codice_ok, ls_codice, ls_check
long ll_num_prog, ll_riga




	ls_num_prog=string(dw_5.getitemnumber(al_riga,"num_progressivo"))
	ls_stato='80'
	
	ls_fornitore="0"+string(year(adt_data_doc))
	
	do while len(ls_num_prog)<5 
		ls_num_prog="0"+ls_num_prog
	loop
	
	ls_codice= ls_stato+ls_fornitore+ls_num_prog
	ls_check=string(f_check_digit(ls_codice, 13))
	
	ls_codice+= ls_check
	ls_codice_ok=f_crea_codice_a_barre(ls_codice)
	return ls_codice_ok


end function

on w_sped_a_barre.create
int iCurrent
call super::create
this.cbx_2_in_1=create cbx_2_in_1
this.st_1=create st_1
this.em_pezzi=create em_pezzi
this.cb_1=create cb_1
this.cb_reset=create cb_reset
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.cbx_bilancia=create cbx_bilancia
this.dw_4=create dw_4
this.pb_stampa=create pb_stampa
this.st_operatore=create st_operatore
this.dw_3=create dw_3
this.dw_5=create dw_5
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_2_in_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_pezzi
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_reset
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_salva
this.Control[iCurrent+8]=this.cbx_bilancia
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.pb_stampa
this.Control[iCurrent+11]=this.st_operatore
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.dw_5
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.dw_1
end on

on w_sped_a_barre.destroy
call super::destroy
destroy(this.cbx_2_in_1)
destroy(this.st_1)
destroy(this.em_pezzi)
destroy(this.cb_1)
destroy(this.cb_reset)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.cbx_bilancia)
destroy(this.dw_4)
destroy(this.pb_stampa)
destroy(this.st_operatore)
destroy(this.dw_3)
destroy(this.dw_5)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)

dw_1.insertrow(1)
dw_2.insertrow(1)
dw_3.insertrow(1)

dw_3.setitem(1, 1, relativedate(today(), -120))

 dw_2.post scrolltorow(1)
post setfocus(dw_2)
em_pezzi.text="100"
end event

type cbx_2_in_1 from checkbox within w_sped_a_barre
boolean visible = false
integer x = 1198
integer y = 240
integer width = 823
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa 2 Bollettine insieme"
boolean lefttext = true
end type

type st_1 from statictext within w_sped_a_barre
integer x = 539
integer y = 248
integer width = 279
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "N. PEZZI:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_pezzi from editmask within w_sped_a_barre
integer x = 846
integer y = 232
integer width = 178
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 65535
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#,0"
end type

type cb_1 from commandbutton within w_sped_a_barre
integer x = 3319
integer y = 228
integer width = 343
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

type cb_reset from commandbutton within w_sped_a_barre
integer x = 2167
integer y = 232
integer width = 343
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci"
end type

event clicked;if messagebox("Attenzione!", "Tutte le righe spariranno come per magia. Continuare=", stopsign!,  yesno!)=1 then
	dw_5.reset()
end if
end event

type cb_cancella from commandbutton within w_sped_a_barre
integer x = 2560
integer y = 232
integer width = 343
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_5.getrow()
dw_5.trigger event ue_delete(ll_riga_da_cancellare)		
end event

type cb_salva from commandbutton within w_sped_a_barre
integer x = 2953
integer y = 228
integer width = 343
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_5.trigger event ue_update()


end event

type cbx_bilancia from checkbox within w_sped_a_barre
integer x = 114
integer y = 252
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bilancia"
boolean checked = true
end type

type dw_4 from udw_001 within w_sped_a_barre
integer x = 96
integer y = 1416
integer width = 1655
integer height = 672
integer taborder = 30
string dataobject = "d_sped_a_barre"
end type

type pb_stampa from picturebutton within w_sped_a_barre
integer x = 613
integer y = 1292
integer width = 402
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;integer li_ret
string ls_nome_file




//dw_4.Modify("DataWindow.Print.printername = 'Dymo'")
//dw_4.print(false, false)	
	
	dw_5.Modify("Export.PDF.Method = Distill!")
	dw_5.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	dw_5.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	ls_nome_file="c:\nita\spedbar\"+string(today(),"dd_mm_yy hh_mm_ss")+".pdf"
	li_ret=dw_5.SaveAs(ls_nome_file, PDF!, FALSE)
	
	dw_4.Modify("DataWindow.Print.printername = 'DYMO'")
	dw_4.print(false, false)


end event

type st_operatore from statictext within w_sped_a_barre
integer x = 864
integer y = 44
integer width = 1106
integer height = 116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_3 from udw_001 within w_sped_a_barre
integer x = 2107
integer y = 32
integer width = 814
integer height = 148
integer taborder = 40
string dataobject = "d_da_data_per_righe"
end type

type dw_5 from udw_001 within w_sped_a_barre
integer x = 96
integer y = 348
integer width = 3570
integer height = 904
integer taborder = 40
string dataobject = "d_sped_a_barre_salva"
end type

event retrievestart;call super::retrievestart;
	return 2
end event

event itemfocuschanged;call super::itemfocuschanged;dwobject my_dwo
string data, ls_metallo
decimal ldc_peso,ldc_null
setnull(ldc_null)
w_bilancia w_bil
long ll_id_articolo

if dwo.name='grammi' then //and is_ultimo_campo='quantita' and cbx_bilancia.checked then
	
	open(w_bil)
	ldc_peso=w_bil.f_rendi_peso()
//	data=wf_bilancia()
	//my_dwo = this.object.peso_netto
//	ldc_peso=dec(data)
	//arrotondo 040612 al primo decimale richiesta samy
	
	if ldc_peso>0 then
//		ll_id_articolo=dw_1.getitemnumber(row, "id_articolo")
//		select m.codice
//		into :ls_metallo
//		from articolo a, orafo_titolo t, orafo_metallo m
//		where a.id_titolo=t.id_titolo and t.id_metallo=m.id_metallo
//		and a.id_articolo=:ll_id_articolo
//		;
//		if ls_metallo<>"AU" then
//			if u_freddie.s_utenti.i_idutente =39 then //secondo Samy deve arrontondare sempre per eccesso a meno che non sia Elisa (39) 18-20 luglio2 2018
//				ldc_peso=round(ldc_peso, 1) 
//			else
//				ldc_peso=ceiling(ldc_peso) 
//			end if
//		end if
	
		data=string(ldc_peso)
		setitem(row, "grammi", ldc_peso)
		//this.trigger event itemchanged(row, my_dwo, data)

		if ldc_peso<1 then
			messagebox("ATTENZIONE!", "Il peso è inferiore ad 1 grammo!")
			setitem(row, "peso_netto", ldc_null)
			
		end if
	end if
	close(w_bil)
end if


end event

type dw_2 from udw_base within w_sped_a_barre
integer x = 59
integer y = 44
integer width = 736
integer height = 176
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ins_barcode_dipendente"
boolean vscrollbar = false
end type

event editchanged;call super::editchanged;long  ll_codice

if len(data)=13 then
		ll_codice=long(mid(data, 8, 5))
		
		ST_OPERATORE.text=string(ll_codice)+" - "+string(today(),"dd/mm/yy")+" - "+string(now(),"hh:mm:ss")
		post scrolltorow(1)
		post setfocus(dw_1)
end if
end event

type dw_1 from udw_base within w_sped_a_barre
integer x = 3003
integer y = 28
integer width = 736
integer height = 176
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ins_barcode_plurimo_ext"
boolean vscrollbar = false
end type

event editchanged;call super::editchanged;long ll_id_bollettina, ll_riga_trovata,ll_riga_inserita, ll_codice
long ll_num_prog, ll_id_doc_bollettina,ll_righe_esistenti, ll_test_num_prog
string ls_num_doc,ls_cod_operatore, ls_cod_barre
datastore ds_trova_bol_pacco
date ldt_da_data, ldt_data_doc
integer li_pezzi
 
dw_2.accepttext()
ds_trova_bol_pacco=create datastore

//se è silver va bene così, se è vener cambia peer num prog
if dwo.name="cod_barre"  and len(data)=7 then
	dw_5.reset()
	li_pezzi=integer(em_pezzi.text)
	//prendo il profilo entro il quale devo ricercare dalla dw in alto (dw_2)
	//ll_id_prof=dw_2.getitemnumber(1, "id_prof_doc")
	ds_trova_bol_pacco.dataobject="d_trova_bollettina_pacco"
	ds_trova_bol_pacco.settransobject(sqlca)
	ll_test_num_prog=0
	ls_num_doc=mid(data, 3, 5)
	select num_progressivo
	into :ll_test_num_prog
	from dba.sped_a_barre
	where num_bollettina=:ls_num_doc
	;
	if ll_test_num_prog>0 then
		if messagebox("Attenzione!", "La bollettina è già presente in archivio. Vuoi nserirla lo stesso?", stopsign!, yesNo!)=2 then
			destroy ds_trova_bol_pacco
			return
		end if
	end if
	ldt_da_data=dw_3.getitemdate(1, "da_data")
	if isnull(ldt_da_data) then
		messagebox("Attenzione!", "Valore della data dalla quale partire per ricercare le bollettine NON valorizzato!")
		destroy ds_trova_bol_pacco
		return
	end if
	ll_riga_trovata=ds_trova_bol_pacco.retrieve(ls_num_doc, ldt_da_data)
	if ll_riga_trovata>0 then
		if ll_riga_trovata>1 then
			messagebox("Attenzione!", "trovate 2 bollettine con lo stesso numero")
		else
			ll_id_bollettina=ds_trova_bol_pacco.getitemnumber(1, "id_documento")
			ldt_data_doc=ds_trova_bol_pacco.getitemdate(1, "data_documento")

				
				ll_riga_inserita=dw_5.insertrow(0)
				ll_num_prog=ds_trova_bol_pacco.getitemnumber(1, "num_progressivo")
				dw_5.setitem(ll_riga_inserita,"id_doc_bollettina" ,ll_id_bollettina)
				dw_5.setitem(ll_riga_inserita,"num_bollettina" , ls_num_doc)
				dw_5.setitem(ll_riga_inserita,"num_progressivo" , ll_num_prog)
				dw_5.setitem(ll_riga_inserita,"pezzi", li_pezzi) 
	
				ls_cod_operatore=dw_2.getitemstring(1, "cod_barre")
				ll_codice=long(mid(ls_cod_operatore, 8, 5))
				dw_5.setitem(ll_riga_inserita,"cod_operatore", ll_codice)
				//prendo il peso da bilancia
				dw_5.trigger event itemfocuschanged(ll_riga_inserita, dw_5.object.grammi)
				
				//copio le righe in etichette
				//salvo
				dw_5.trigger event ue_update()
				dw_5.rowscopy(ll_riga_inserita, ll_riga_inserita, primary!,dw_4, 1, primary!)
				ls_cod_barre=wf_ins_cod_barre(ll_riga_inserita,ldt_data_doc)
				dw_5.setitem(ll_riga_inserita, "cod_barre_bollettina", ls_cod_barre)
				dw_4.setitem(ll_riga_inserita, "cod_barre_bollettina", ls_cod_barre)
				//stampo
				pb_stampa.triggerevent(clicked!)
			//end if
		end if
		dw_1.reset()
		dw_1.insertrow(1)
		post scrolltorow(1)
		post setfocus(dw_1)
		destroy ds_trova_bol_pacco
		dw_5.reset()
		dw_4.reset()
	end if
end if
		
			

end event

