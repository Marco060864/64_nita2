forward
global type w_aggiusta_cespiti from w_001
end type
type dw_1 from udw_base within w_aggiusta_cespiti
end type
type cb_1 from commandbutton within w_aggiusta_cespiti
end type
type cb_aggiusta from commandbutton within w_aggiusta_cespiti
end type
type cb_3 from commandbutton within w_aggiusta_cespiti
end type
type cb_4 from commandbutton within w_aggiusta_cespiti
end type
type dw_2 from udw_base within w_aggiusta_cespiti
end type
type dw_3 from udw_base within w_aggiusta_cespiti
end type
end forward

global type w_aggiusta_cespiti from w_001
integer width = 5189
integer height = 2272
dw_1 dw_1
cb_1 cb_1
cb_aggiusta cb_aggiusta
cb_3 cb_3
cb_4 cb_4
dw_2 dw_2
dw_3 dw_3
end type
global w_aggiusta_cespiti w_aggiusta_cespiti

type variables
long il_cat_int_cespite
end variables

on w_aggiusta_cespiti.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_aggiusta=create cb_aggiusta
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_aggiusta
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_3
end on

on w_aggiusta_cespiti.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_aggiusta)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_2.insertrow(1)
end event

type st_1 from w_001`st_1 within w_aggiusta_cespiti
end type

type dw_1 from udw_base within w_aggiusta_cespiti
integer x = 29
integer y = 256
integer width = 5091
integer height = 1229
boolean bringtotop = true
string dataobject = "d_movimenti_cespite"
end type

event sqlpreview;call super::sqlpreview;string ls_sql,ls_sql2
integer i

if il_cat_int_cespite>0 then
	ls_sql=sqlsyntax
	i=pos(ls_sql, "ORDER BY")
	ls_sql2=left(ls_sql, i - 1)
	ls_sql=mid(ls_sql, i, len(ls_sql) - i)
	ls_sql2+=" and cespite.id_cat_int_cespite= "+string(il_cat_int_cespite)+" "+ls_sql
	
	i=SetSQLPreview(ls_sql2)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_cespite_ff w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_cespite"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "cespite_id_cespite")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type cb_1 from commandbutton within w_aggiusta_cespiti
integer x = 88
integer y = 102
integer width = 322
integer height = 90
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica"
end type

event clicked;dw_1.retrieve()
end event

type cb_aggiusta from commandbutton within w_aggiusta_cespiti
integer x = 497
integer y = 102
integer width = 322
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiusta"
end type

event clicked;long i, ll_riga, ll_riga_inizio, ll_riga_trovata, ll_calcolato, ll_attuale
long ll_ultima_riga, ll_riga_cespite, ll_id_cespite
decimal{2} ldc_calcolato, ldc_attuale, ldc_calcolato_acq, ldc_calcolato_alienazione, ldc_calcolato_totale
decimal{2} ldc_minus, ldc_plus, ldc_minus_calcolato , ldc_plus_calcolato,ldc_residuo
date ldt_calcolato, ldt_attuale
string ls_attuale
dwitemstatus dwstatus

dw_3.reset()

ll_riga=dw_1.FindGroupChange(1,1)

ll_riga_inizio=1
Do while ll_riga>0
	//cerco l'ultima riga del gruppo
	ll_ultima_riga=dw_1.FindGroupChange(ll_riga+1,1) - 1
	if ll_ultima_riga<=0 then
		ll_ultima_riga=dw_1.rowcount()
	end if
	//inserisco riga cespite: se non ci saranno variazioni la cancello alla fine? SI poi salvo e la cancello davvero...
	ll_id_cespite=dw_1.getitemnumber(ll_riga, "cespite_id_cespite")
	ll_riga_cespite=dw_3.retrieve(ll_id_cespite)
	//ll_riga_cespite=dw_3.rowcount()
	//amm normale
	ldc_calcolato=dw_1.getitemdecimal(ll_riga, "c_amm_normale")
	ldc_attuale=dw_1.getitemdecimal(ll_riga, "cespite_fondo_amm_norm")
	if ldc_attuale<>ldc_calcolato then 
		//dw_1.setitem(ll_riga, "cespite_fondo_amm_norm", ldc_calcolato)
		dw_3.setitem(ll_riga_cespite, "cespite_fondo_amm_norm", ldc_calcolato)
	end if
	//amm ant
	ldc_calcolato=dw_1.getitemdecimal(ll_riga, "c_amm_anticipato")
	ldc_attuale=dw_1.getitemdecimal(ll_riga, "cespite_fondo_amm_ant")
	if ldc_attuale<>ldc_calcolato then 
		//dw_1.setitem(ll_riga, "cespite_fondo_amm_ant", ldc_calcolato)
		dw_3.setitem(ll_riga_cespite, "cespite_fondo_amm_ant", ldc_calcolato)
	end if
	//val acq
	ldc_calcolato_acq=dw_1.getitemdecimal(ll_riga, "c_val_acquisto")
	ldc_attuale=dw_1.getitemdecimal(ll_riga, "cespite_valore_acq")
	if ldc_attuale<>ldc_calcolato_acq then 
		//dw_1.setitem(ll_riga, "c_val_acquisto", ldc_calcolato_acq)
		dw_3.setitem(ll_riga_cespite, "cespite_valore_acq", ldc_calcolato_acq)
	end if
	ldc_calcolato_totale=dw_1.getitemdecimal(ll_riga, "c_amm_totale")
	if ldc_calcolato_acq=ldc_calcolato_totale then
		ls_attuale=dw_1.getitemstring(ll_riga, "cespite_stato")
		if ls_attuale<>'E' then
			//dw_1.setitem(ll_riga, "cespite_stato", "E")
			dw_3.setitem(ll_riga_cespite, "cespite_stato", "E")
			//e la data fine ammortamento deve essere uguale all'ultimo mov di amm
			//ll_riga_trovata=dw_1.find("prof_cespite_acquisto='S'", ll_riga_inizio, ll_ultima_riga)
			//se il cespite è completamente ammortizzato l'ultimo movimento ha la data di fine ammortamento
			ldt_calcolato=dw_1.getitemdate(ll_ultima_riga, "mov_cespite_data_mov_cespite")
			//dw_1.setitem(ll_riga, "cespite_data_fine_amm", ldt_calcolato)
			dw_3.setitem(ll_riga_cespite, "cespite_data_fine_amm", ldt_calcolato)
		end if
	end if
		
	//ora controllo la data acquisto e, se c'è, di cessione
	ll_riga_trovata=dw_1.find("prof_cespite_acquisto='S'", ll_riga_inizio, ll_ultima_riga)
	ldt_calcolato=dw_1.getitemdate(ll_riga_trovata, "mov_cespite_data_mov_cespite")
	ldt_attuale=dw_1.getitemdate(ll_riga, "cespite_data_inizio_utilizzo")
	if ldt_attuale<>ldt_calcolato then 
		//dw_1.setitem(ll_riga, "cespite_data_inizio_utilizzo", ldt_calcolato)
		dw_3.setitem(ll_riga_cespite, "cespite_data_inizio_utilizzo", ldt_calcolato)
	end if
	//cessione ldc_calcolato_alienazione
	ll_riga_trovata=dw_1.find("prof_cespite_cessione='S'", ll_riga_inizio, ll_ultima_riga)
	if ll_riga_trovata>0 then
		ldt_calcolato=dw_1.getitemdate(ll_riga_trovata, "mov_cespite_data_mov_cespite")
		ldt_attuale=dw_1.getitemdate(ll_riga, "cespite_alien_data")
		//dw_1.setitem(ll_riga, "cespite_data_fine_amm", ldt_calcolato)
		dw_3.setitem(ll_riga_cespite, "cespite_data_fine_amm", ldt_calcolato)
		if ldt_attuale<>ldt_calcolato then 
			//dw_1.setitem(ll_riga, "cespite_alien_data", ldt_calcolato)
			dw_3.setitem(ll_riga_cespite, "cespite_alien_data", ldt_calcolato)
		end if
		//anche il valore della cessione va controllato
		ldc_calcolato_alienazione=dw_1.getitemdecimal(ll_riga_trovata, "mov_cespite_importo")
		ldc_attuale=dw_1.getitemdecimal(ll_riga, "cespite_alien_valore")
		if ldc_attuale<>ldc_calcolato_alienazione then 
			//dw_1.setitem(ll_riga, "cespite_alien_valore", ldc_calcolato)
			dw_3.setitem(ll_riga_cespite, "cespite_alien_valore", ldc_calcolato_alienazione)
		end if
		//se lo stato non è "V" (venduto) allora lo metto
		ls_attuale=dw_1.getitemstring(ll_riga, "cespite_stato")
		if ls_attuale<>'V' then
			//dw_1.setitem(ll_riga, "cespite_stato", "V")
			dw_3.setitem(ll_riga_cespite, "cespite_stato", "V")
		end if
		//in ogni caso devo controllare se c'è un plusvalore o minusvalore
		ldc_minus=dw_3.getitemdecimal(ll_riga_cespite, "minus")
		ldc_plus=dw_3.getitemdecimal(ll_riga_cespite, "plus")
		ldc_residuo=ldc_calcolato_acq - ldc_calcolato_totale
		if ldc_calcolato_alienazione> ldc_residuo then
			ldc_plus_calcolato=ldc_calcolato_alienazione - ldc_residuo
			if ldc_plus_calcolato<>ldc_plus then
				dw_3.setitem(ll_riga_cespite, "plus",ldc_plus_calcolato )
				if ldc_minus<>0 then dw_3.setitem(ll_riga_cespite, "minus", 0)
			end if
		elseif ldc_calcolato_alienazione<ldc_residuo then
			ldc_minus_calcolato=ldc_residuo - ldc_calcolato_alienazione
			if ldc_minus_calcolato<>ldc_minus then
				dw_3.setitem(ll_riga_cespite, "minus", ldc_minus_calcolato)
				if ldc_plus<>0 then dw_3.setitem(ll_riga_cespite, "plus", 0)
			end if
		end if
	else //non c'è vendita quindi non cè neppure plus né minus
		ldc_minus=dw_3.getitemdecimal(ll_riga_cespite, "minus")
		ldc_plus=dw_3.getitemdecimal(ll_riga_cespite, "plus")
		if ldc_plus<>0 then dw_3.setitem(ll_riga_cespite, "plus", 0)
		if ldc_minus<>0 then dw_3.setitem(ll_riga_cespite, "minus", 0)
		//controllo anche lo stato (se non è tutto ammortizzato non può essere "Estinto"
		if ldc_calcolato_totale<ldc_calcolato_acq then
			ls_attuale=dw_1.getitemstring(ll_riga, "cespite_stato")
			if ls_attuale='E' then
				//dw_1.setitem(ll_riga, "cespite_stato", "V")
				dw_3.setitem(ll_riga_cespite, "cespite_stato", "U")
			end if
		end if
	end if
	//anni ammortizzati
	ll_calcolato=dw_1.getitemnumber(ll_riga, "c_anni_ammortizzati")
	ll_attuale=dw_1.getitemnumber(ll_riga, "cespite_anni_ammortizzati")
	if ll_attuale<>ll_calcolato then 
		//dw_1.setitem(ll_riga, "cespite_anni_ammortizzati", ll_calcolato)
		dw_3.setitem(ll_riga_cespite, "cespite_anni_ammortizzati", ll_calcolato)
	end if
	
		
	ll_riga_inizio=ll_ultima_riga+1
	ll_riga=dw_1.FindGroupChange(ll_riga+1,1)
loop

end event

type cb_3 from commandbutton within w_aggiusta_cespiti
integer x = 878
integer y = 102
integer width = 322
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_3.trigger event ue_update()
end event

type cb_4 from commandbutton within w_aggiusta_cespiti
integer x = 1287
integer y = 102
integer width = 322
integer height = 90
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

type dw_2 from udw_base within w_aggiusta_cespiti
integer x = 1755
integer y = 51
integer width = 731
integer height = 179
boolean bringtotop = true
string dataobject = "d_cat_interna_cespite_ext"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;il_cat_int_cespite=long(data)
dw_1.retrieve()
end event

type dw_3 from udw_base within w_aggiusta_cespiti
integer x = 29
integer y = 1510
integer width = 5091
integer height = 640
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_salva_cespite_corretto"
end type

event retrievestart;call super::retrievestart;return 2
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_cespite_ff w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_cespite"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "cespite_id_cespite")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

