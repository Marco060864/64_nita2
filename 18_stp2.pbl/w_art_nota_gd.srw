forward
global type w_art_nota_gd from w_001
end type
type cb_seleziona from commandbutton within w_art_nota_gd
end type
type dw_3 from u_dw_figlio within w_art_nota_gd
end type
type cb_nuovo from commandbutton within w_art_nota_gd
end type
type cb_cancella from commandbutton within w_art_nota_gd
end type
type cb_1 from commandbutton within w_art_nota_gd
end type
type cb_2 from commandbutton within w_art_nota_gd
end type
type cb_salva from commandbutton within w_art_nota_gd
end type
type cb_stampa from commandbutton within w_art_nota_gd
end type
type cb_esci from commandbutton within w_art_nota_gd
end type
type dw_1 from udw_base within w_art_nota_gd
end type
type cb_salva_prezzi from commandbutton within w_art_nota_gd
end type
type cb_salva_righe_distinta from commandbutton within w_art_nota_gd
end type
type cb_3 from commandbutton within w_art_nota_gd
end type
type cb_4 from commandbutton within w_art_nota_gd
end type
end forward

global type w_art_nota_gd from w_001
integer width = 5215
cb_seleziona cb_seleziona
dw_3 dw_3
cb_nuovo cb_nuovo
cb_cancella cb_cancella
cb_1 cb_1
cb_2 cb_2
cb_salva cb_salva
cb_stampa cb_stampa
cb_esci cb_esci
dw_1 dw_1
cb_salva_prezzi cb_salva_prezzi
cb_salva_righe_distinta cb_salva_righe_distinta
cb_3 cb_3
cb_4 cb_4
end type
global w_art_nota_gd w_art_nota_gd

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public subroutine wf_rec_des_2_da_prezzo (long al_id_art, long al_riga)
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
	ll_id_art=long(ls_ric_param.s_id_seg_value[1])
	dw_3.deleterow(al_riga_corrente)
	dw_3.retrieve(ll_id_art)
	
//	dw_3.setitem(al_riga_corrente, "id_articolo",ll_id_art)
//	dw_3.setitem(al_riga_corrente,"cod_articolo", ls_ric_param.s_main_value)
//	dw_3.setitem(al_riga_corrente, "des_articolo",ls_ric_param.s_ausil_value[1])
//	dw_3.setitem(al_riga_corrente,"tipo_um",ls_ric_param.s_ausil_value[14])
	
//	select peso_lordo 
//	into :ldc_peso_lordo
//	from articolo a, unita_confezione u
//	where a.id_articolo=u.id_articolo
//	and u.unita_base='S'
//	and a.id_articolo=:ll_id_art
//	;
//	dw_3.setitem(al_riga_corrente,"peso_lordo",ldc_peso_lordo)
////	if IL_ID_SOG >0 then 
//		ll_id_sog=IL_ID_SOG
//	else
//		ll_id_sog=dw_3.getitemnumber(al_riga_corrente, "id_sog_commerciale")
//	end if
//	post wf_trova_lung_peso(long(ls_ric_param.s_id_seg_value[1]), ll_id_sog, al_riga_corrente)
//	post wf_trova_prezzo(long(ls_ric_param.s_id_seg_value[1]), ll_id_sog, al_riga_corrente)
//	post wf_trova_immagine(long(ls_ric_param.s_id_seg_value[1]), ll_id_sog, al_riga_corrente)
end if
end subroutine

public subroutine wf_rec_des_2_da_prezzo (long al_id_art, long al_riga);string ls_des_2
date ldt_data_attuale
long ll_id_U_C

ldt_data_attuale=date(today())
select id_unita_confezione
into :ll_id_U_C
from dba.unita_confezione
where id_articolo=:al_id_art
and unita_base='S'
;
select des_2
into :ls_des_2
from dba.prezzo p, dba.listino l, dba.variazione v
where l.id_listino=v.id_listino
and v.id_variazione=p.id_variazione
and p.id_unita_confezione=:ll_id_U_C
and l.lis_base='S'
and l.tipo='V'
and v.data_inizio<=:ldt_data_attuale
and v.data_fine>=:ldt_data_attuale
;
if ls_des_2>" " then
	dw_3.setitem(al_riga, "des_2_da_prezzo", ls_des_2)
end if
end subroutine

on w_art_nota_gd.create
int iCurrent
call super::create
this.cb_seleziona=create cb_seleziona
this.dw_3=create dw_3
this.cb_nuovo=create cb_nuovo
this.cb_cancella=create cb_cancella
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_salva=create cb_salva
this.cb_stampa=create cb_stampa
this.cb_esci=create cb_esci
this.dw_1=create dw_1
this.cb_salva_prezzi=create cb_salva_prezzi
this.cb_salva_righe_distinta=create cb_salva_righe_distinta
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_seleziona
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_nuovo
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_salva
this.Control[iCurrent+8]=this.cb_stampa
this.Control[iCurrent+9]=this.cb_esci
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.cb_salva_prezzi
this.Control[iCurrent+12]=this.cb_salva_righe_distinta
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.cb_4
end on

on w_art_nota_gd.destroy
call super::destroy
destroy(this.cb_seleziona)
destroy(this.dw_3)
destroy(this.cb_nuovo)
destroy(this.cb_cancella)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_salva)
destroy(this.cb_stampa)
destroy(this.cb_esci)
destroy(this.dw_1)
destroy(this.cb_salva_prezzi)
destroy(this.cb_salva_righe_distinta)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event open;call super::open;dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
DW_1.RETRIEVE()
end event

type st_1 from w_001`st_1 within w_art_nota_gd
end type

type cb_seleziona from commandbutton within w_art_nota_gd
integer x = 55
integer y = 1283
integer width = 362
integer height = 109
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona"
end type

event clicked;s_dw_ritorna st_p
long ll_righe, ll_riga_partenza, i,ll_riga_inserita, ll_id_art
string ls_Cod_articolo
decimal ldc_qta
 
openwithparm(w_auto_aggiunta_cx, 0)
	
st_p=message.powerobjectparm
	
if isvalid(st_p) then
	ll_righe=st_p.ds.rowcount()
	for i=1 to ll_righe
		ll_id_art=st_p.ds.getitemnumber(i, "id_articolo")
		ll_riga_inserita=dw_3.retrieve(ll_id_art)
	next
end if
	
//	ll_riga_partenza=dw_3.rowcount()+1
//	if ll_riga_partenza<=0 then ll_riga_partenza=1
//	ll_righe=st_p.ds.rowcount()
//	for i= 1 to ll_righe
//		
//		ll_riga_inserita=dw_3.INSERTROW(0)
//		ls_Cod_articolo=st_p.ds.getitemstring(i, "articolo_codice")
//		ldc_qta=st_p.ds.getitemdecimal(i, "qta")
////		dw_3.setitem(ll_riga_inserita, "id_sog_commerciale",il_id_sog)
//		if ldc_qta>0 then
//			dw_3.setitem(ll_riga_inserita, "qta",ldc_qta)
//		end if
////		li_da_rec_catalogo=0
//		dw_3.trigger event itemchanged(ll_riga_inserita, dw_3.object.cod_articolo, ls_Cod_articolo) 
//		
//	next
//end if
	
end event

type dw_3 from u_dw_figlio within w_art_nota_gd
integer y = 26
integer width = 2926
integer height = 1229
boolean bringtotop = true
string dataobject = "d_art_nota_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;string ls_codice, ls_intestatario
s_list_main ls_list_distinta
long ll_articolo,ll_id_dis

accepttext()
if row>0 then
	if string(dwo.name)= "cod_articolo_sw"  then
		ls_codice=dw_3.getitemstring(row, "cod_articolo")
		wf_ricerca( row, ls_codice)
	end if
	if string(dwo.name)= "distinta_sw"  then
		ll_articolo=dw_3.getitemnumber(row,"id_articolo")
		select id_distinta
		into :ll_id_dis
		from distinta
		where id_articolo=:ll_articolo;
		if sqlca.sqlcode=0 then
			ls_list_distinta.s_modo = modo_modifica
			ls_list_distinta.s_SQL_ident[1] = "distinta.id_distinta"
			ls_list_distinta.s_identifica[1]="id_distinta"
			ls_list_distinta.l_identifica[1]=ll_id_dis
			OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
			setfocus(w_distinta_base_cx)
		elseif ll_articolo>0 then
				ls_list_distinta.s_identifica[1]="id_articolo"
				ls_list_distinta.l_identifica[1]=ll_articolo
				OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
				setfocus(w_distinta_base_cx)
		else
			messagebox("Informazione!","Non è stato selezionato nessun articolo o non è stato salvato!") 
		end if
	end if
end if




end event

event doubleclicked;string ls_column_color, ls_etichetta
ls_etichetta=dwo.name

choose case ls_etichetta
	case "peso_lordo_t", "peso_t" ,"qta_t","lunghezza_t", "nome_immagine_t", "sconto_t", "des_articolo_t", "prezzo_t", "peso_unitario_t"
	ls_column_color = Describe(ls_etichetta+".Color")
	if ls_column_color='16777215' then
		modify(ls_etichetta+".Color=0")
		modify(ls_etichetta+".font.weight=400")
	
	else
		modify(ls_etichetta+".Color=16777215")
		modify(ls_etichetta+".font.weight=700")
	end if
	CASE "cod_articolo_t"
		dw_3.setsort("cod_articolo")
		dw_3.sort()
end choose

end event

event getfocus;call super::getfocus;//adw=this
end event

event itemchanged;st_ass_art_sottoclasse st_associa
long ll_riga_esistente, ll_id_articolo
string ls_tipo_um
decimal ldc_peso_lordo

choose case DWO.NAME
	
	case 'cod_articolo' 
		
			select id_articolo
			into :ll_id_articolo
			from articolo 
			where codice=:data;
			if sqlca.sqlcode=0 then
				deleterow(row)
				dw_3.retrieve(ll_id_articolo)
				wf_rec_des_2_da_prezzo(ll_id_articolo, row)
//				setitem(row, "id_articolo", st_associa.id_articolo)
//				setitem(row, "cod_articolo", st_associa.cod_articolo)
//				setitem(row, "des_articolo", st_associa.des_articolo)
//				setitem(row, "tipo_um", ls_tipo_um)
//				setitem(row, "peso_lordo", ldc_peso_lordo)
//				st_associa.id_sog_commerciale=DW_3.GETITEMNUMBER(ROW, "ID_SOG_COMMERCIALE")
//							
//				post wf_trova_lung_peso(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
//				post wf_trova_prezzo(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
//				post wf_trova_immagine(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
//					
			else
				post wf_ricerca(row, data)
		end if
		
	
			
		
		
	
end choose
end event

event rowfocuschanged;//string ls_imm
//setrowfocusindicator(hand!)
//
//if currentrow>0 and cbx_vedi_foto.checked then
//	ls_imm=getitemstring(currentrow, "nome_immagine")
//	if ls_imm>"" then
//		if isvalid(w_mostra_imm_ocx) then
//			w_mostra_imm_ocx.wf_mostra(ls_imm)
//		else
//			openwithparm(w_mostra_imm_ocx, ls_imm, "w_mostra_imm_ocx", parent)
//		end if
//	end if
//end if
//
end event

event rowfocuschanging;
end event

event ue_key;choose case key
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

type cb_nuovo from commandbutton within w_art_nota_gd
integer x = 22
integer y = 1517
integer width = 241
integer height = 109
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_riga_cliente, ll_id_cat_cl, ll_num_prog

	
			ll_riga=dw_3.INSERTROW(0)
		//	wf_metti_sog_commerciale(ll_riga)

			dw_3.post setfocus()
			dw_3.post setcolumn("cod_articolo")
	dw_3.scrolltorow(ll_riga)
end event

type cb_cancella from commandbutton within w_art_nota_gd
integer x = 289
integer y = 1517
integer width = 241
integer height = 109
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga

ll_riga=dw_3.getrow()
if ll_riga>0 then
	if messagebox("Attenzione!", "Si conferma la cancellazione della riga?", stopsign!, yesno!)&
			=1 then
		dw_3.deleterow(ll_riga)
	end if
end if
end event

type cb_1 from commandbutton within w_art_nota_gd
integer x = 457
integer y = 1283
integer width = 271
integer height = 109
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_riga_cliente, ll_id_cat_cl, ll_num_prog

	
			ll_riga=dw_3.INSERTROW(0)
			//wf_metti_sog_commerciale(ll_riga)

			dw_3.post setfocus()
			dw_3.post setcolumn("cod_articolo")
	dw_3.scrolltorow(ll_riga)
end event

type cb_2 from commandbutton within w_art_nota_gd
integer x = 750
integer y = 1283
integer width = 271
integer height = 109
integer taborder = 180
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga

ll_riga=dw_3.getrow()
if ll_riga>0 then
	if messagebox("Attenzione!", "Si conferma la cancellazione della riga?", stopsign!, yesno!)&
			=1 then
		dw_3.deleterow(ll_riga)
	end if
end if
end event

type cb_salva from commandbutton within w_art_nota_gd
integer x = 1375
integer y = 1280
integer width = 388
integer height = 109
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Nota"
end type

event clicked;//integer li_ret
//
//li_ret=dw_3.update()
//if li_ret=1 then
//	COMMIT;
//ELSE
//	rollback;
//end if

long ll_righe, ll_id_articolo, i
string ls_nota, ls_per_lavorazioni

dw_3.accepttext()

ll_righe=dw_3.rowcount()
for i= 1 to ll_righe
	ls_per_lavorazioni=""
	ls_nota=""
	ll_id_articolo=dw_3.getitemnumber(i, "id_articolo")
	ls_nota=dw_3.getitemstring(i, "nota")
	ls_per_lavorazioni=dw_3.getitemstring(i, "note")
	update articolo
	set nota=:ls_nota, note=:ls_per_lavorazioni
	where id_articolo=:ll_id_articolo;
	if sqlca.sqlcode=0 then
		commit;
		messagebox("OK!", "Salvataggio nota riuscito!")
	else
		rollback;
		messagebox("Attenzione!", "Salvataggio note non riuscito!")
	end if
next


end event

type cb_stampa from commandbutton within w_art_nota_gd
integer x = 2516
integer y = 1280
integer width = 274
integer height = 109
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_3.print()
end event

type cb_esci from commandbutton within w_art_nota_gd
integer x = 4849
integer y = 1283
integer width = 241
integer height = 109
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;close(parent)
end event

type dw_1 from udw_base within w_art_nota_gd
integer x = 2926
integer y = 26
integer width = 2253
integer height = 1229
integer taborder = 20
boolean bringtotop = true
string dataobject = "D_ART_PER_LAV_SCELTA"
end type

event doubleclicked;call super::doubleclicked;//long 				ll_row
//integer 			li_size, li_counter
//string 			ls_filter, ls_colname, ls_colval, is_resp_window
//s_list_main 	lstr_for_win, is_list
//s_rit_wp			lstr_rit
//window		iw_support
//
//is_resp_window="w_orafo_variazione_ff"
//iw_support=w_orafo_variazione_ff
//ll_row = GetRow()
//if ll_row>0 then
//	if not(is_resp_window = "") OR not(is_list.s_win_zoom = "") then
//	
//		is_list.s_modo 					= modo_modifica
//		lstr_for_win.s_modo 				= is_list.s_modo
//		lstr_for_win.s_identifica 		= is_list.s_win_chiave
//		lstr_for_win.l_identifica 		= is_list.l_win_chiave
//		lstr_for_win.s_par_name 		= is_list.s_par_name
//		lstr_for_win.s_par_value 		= is_list.s_par_value
//		lstr_for_win.s_win_parametri 	= is_list.s_win_parametri
//		
//		li_size = UpperBound(lstr_for_win.s_identifica)		
//		for li_counter = 1 to li_size
//			lstr_for_win.l_identifica[li_counter] = GetItemNumber( ll_row, lstr_for_win.s_identifica[li_counter])
//		next
//		
//		li_size = UpperBound(lstr_for_win.s_par_name)
//		for li_counter = 1 to li_size
//			lstr_for_win.s_par_value[li_counter] = string(GetItemNumber(GetRow(), lstr_for_win.s_par_name[li_counter]))
//		next
//
//		
//		long ll_id_valuta
//		select id_valuta
//		into :ll_id_valuta
//		from dba.par_sistema;
//
//		lstr_for_win.s_par_name[1] = "id_valuta"
//		lstr_for_win.s_par_value[1] = string(ll_id_valuta)
//		
//
//		if is_list.s_win_zoom = "" then
//			OpenWithParm(iw_support, lstr_for_win, is_resp_window)
//		else
//			if not ((GetItemStatus(ll_row, 0, Primary!) = New!) OR (GetItemStatus(ll_row, 0, Primary!) = NewModified!)) then
//				this.update()
//				OpenWithParm(iw_support, lstr_for_win,is_list.s_win_zoom)
//			end if
//		end if
//	
//		
//		ls_filter = ""
//		lstr_rit = Message.PowerObjectParm
//		li_size = UpperBound(lstr_rit.s_identifica)
//		for  li_counter = 1 to li_size
//			ls_colname = lstr_rit.s_identifica[li_counter]
//			ls_colval = string(lstr_rit.l_identifica[li_counter])
//			ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
//		next
//		ls_filter = Mid(ls_filter,5)
//		
//		
//		
//		
//			TriggerEvent("ue_retrieve")
//			if (RowCount()>0) and (is_resp_window <> "") then
//				selectrow(1,true)
//			end if
//			ll_row = Find( ls_filter, 1, RowCount( ))
//			ScrollToRow(ll_row)
//		
//		
//	else
//		
//	end if
//end if
//
//
end event

type cb_salva_prezzi from commandbutton within w_art_nota_gd
integer x = 3540
integer y = 1283
integer width = 410
integer height = 109
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Prezzi"
end type

event clicked;decimal ldc_prezzo, ldc_prezzo_man
long ll_id_uc, i, e=0

dw_1.accepttext()
//prima il prezzo di vendita
for i = 1 to dw_1.rowcount()
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
		e++
	end if
next
if e=0 then messagebox("OK!", "Salvataggio prezzo riuscito!")
end event

type cb_salva_righe_distinta from commandbutton within w_art_nota_gd
integer x = 2893
integer y = 1283
integer width = 581
integer height = 109
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Lavorazioni"
end type

event clicked;string ls_nota, ls_lavorazione, ls_tipo_um,ls_test_lav, ls_cod_art
long ll_id_articolo, ll_righe, i, a, ll_lavorazioni, ll_id_uc, b, ll_esiste
decimal ldc_sald, ldc_spaz, ldc_galv, ldc_costo, ldc_prezzo, ldc_prezzo_man,ldc_peso
integer li_scelto
LONG ll_righe_lavorazione, ll_id_art_lavorazione,ll_riga_trovata, ll_num_riga
long ll_id_distinta, e=0

datastore ds_cerca_costi
ds_cerca_costi=create datastore
ds_cerca_costi.dataobject="d_rec_costi_distinta"
ds_cerca_costi.settransobject(sqlca)

ll_righe=dw_3.rowcount()
ll_righe_lavorazione=dw_1.rowcount()
for i=1 to ll_righe
	ll_id_articolo=dw_3.getitemnumber(i, "id_articolo")
	select peso_netto
	into :ldc_peso
	from dba.unita_confezione
	where id_articolo=:ll_id_articolo
	and unita_base='S'
	;
	ls_cod_art=dw_3.getitemstring(i, "cod_articolo")
	select id_distinta
	into :ll_id_distinta
	from dba.distinta
	where id_articolo=:ll_id_articolo;
	if isnull(ll_id_distinta) then
		messagebox("Attenzione!", "L'articolo "+ls_cod_art+" non ha distinta!")
	 	continue
	end if
	for a= 1 to ll_righe_lavorazione
		//controllo se  sono stati modificati (c_scegli=1)
		li_scelto=dw_1.getitemnumber(a,"c_scegli")
		if li_scelto=1 then //se è stato scelto lo devo aggiornare 
			ll_lavorazioni=ds_cerca_costi.retrieve(ll_id_articolo)
			ll_id_art_lavorazione=dw_1.getitemnumber(a, "id_articolo")
			ll_riga_trovata=ds_cerca_costi.find("riga_distinta_id_articolo="+string(ll_id_art_lavorazione), 1,ds_cerca_costi.rowcount()) 
			ls_tipo_um=dw_1.getitemstring(a, "unita_misura_tipo")
			if ls_tipo_um='P' then
				if ldc_peso>0 then
					ldc_costo=dw_1.getitemdecimal(a, "prezzo_manifattura")*ldc_peso
				else
					ldc_costo=dw_1.getitemdecimal(a, "prezzo_manifattura")
				end if
			else 
				ldc_costo=dw_1.getitemdecimal(a, "prezzo")
			end if
			if ll_riga_trovata>0 then //se c'è devo solo aggiornare il prezzo
				ds_cerca_costi.setitem(a, "costo", ldc_costo)
			else
				//devo insirere la riga e il costo e potrei anche vedere 
				//di inserirlo corretto come totale (moltiplicando per il peso invece che per i pezzi ma anche no ...
				ll_num_riga=ds_cerca_costi.insertrow(0)
				
				ds_cerca_costi.setitem(ll_num_riga, "num_riga", 900+ll_num_riga*10)
				ds_cerca_costi.setitem(ll_num_riga,"riga_distinta_id_distinta", ll_id_distinta)
				ds_cerca_costi.setitem(ll_num_riga,"riga_distinta_id_articolo", ll_id_art_lavorazione)
				ds_cerca_costi.setitem(ll_num_riga,"quantita", 1)
				ds_cerca_costi.setitem(ll_num_riga,"tipo_riga", "E")
				ds_cerca_costi.setitem(ll_num_riga,"varie", "S" )//S= lavorazione (non è un articolo vero e proprio è una lavorazione)
				ds_cerca_costi.setitem(ll_num_riga, "costo", ldc_costo)
				ds_cerca_costi.setitem(ll_num_riga, "peso_netto", 0)
			end if
			
			
			if ds_cerca_costi.update()=1 then
				commit;
				
				
			else
				rollback;
				messagebox("Attenzione!", "Salvataggio costo non riuscito!")
				e++
			end if
			
		end if
	next
	
next

if e=0 then messagebox("OK!", "Salvataggio costo riuscito!")

destroy ds_cerca_costi
//			for a=1 to ds_cerca_costi.rowcount()
//				ldc_costo=0
//				ls_lavorazione=ds_cerca_costi.getitemstring(a, "lavorazione")
//				choose case upper(ls_lavorazione)
//					case 'SA'
//						if ldc_sald>0 then 
//							
//							ldc_costo=ldc_sald
//						end if
//					case "SP"
//						if ldc_spaz>0 then  ldc_costo=ldc_spaz
//					case "GV"
//						if ldc_galv>0 then ldc_costo=ldc_galv
//				end choose
end event

type cb_3 from commandbutton within w_art_nota_gd
integer x = 1042
integer y = 1283
integer width = 271
integer height = 109
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci"
end type

event clicked;dw_3.reset()
end event

type cb_4 from commandbutton within w_art_nota_gd
boolean visible = false
integer x = 1843
integer y = 1280
integer width = 421
integer height = 106
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva DES_2"
end type

