forward
global type w_or_partitario_b_rpt from window
end type
type pb_save_xls from picturebutton within w_or_partitario_b_rpt
end type
type dw_6 from udw_base within w_or_partitario_b_rpt
end type
type dw_4 from udw_base within w_or_partitario_b_rpt
end type
type dw_3 from udw_base within w_or_partitario_b_rpt
end type
type cb_crea_cbmag from commandbutton within w_or_partitario_b_rpt
end type
type cbx_giac_sotto from checkbox within w_or_partitario_b_rpt
end type
type cbx_vedi_righe from checkbox within w_or_partitario_b_rpt
end type
type sle_pg from singlelineedit within w_or_partitario_b_rpt
end type
type st_1 from statictext within w_or_partitario_b_rpt
end type
type st_2 from statictext within w_or_partitario_b_rpt
end type
type sle_copie from singlelineedit within w_or_partitario_b_rpt
end type
type sle_zoom from singlelineedit within w_or_partitario_b_rpt
end type
type cb_salva_su_file from commandbutton within w_or_partitario_b_rpt
end type
type cb_7 from commandbutton within w_or_partitario_b_rpt
end type
type cb_6 from commandbutton within w_or_partitario_b_rpt
end type
type cb_imp_st from commandbutton within w_or_partitario_b_rpt
end type
type cb_stampa from commandbutton within w_or_partitario_b_rpt
end type
type cb_preview from commandbutton within w_or_partitario_b_rpt
end type
type cb_pg_dopo from commandbutton within w_or_partitario_b_rpt
end type
type cb_pg_prima from commandbutton within w_or_partitario_b_rpt
end type
type cb_1 from commandbutton within w_or_partitario_b_rpt
end type
type dw_1 from datawindow within w_or_partitario_b_rpt
end type
end forward

global type w_or_partitario_b_rpt from window
integer x = 23
integer y = 12
integer width = 3598
integer height = 1788
boolean titlebar = true
string title = "Stampa Movimenti Magazzino"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_post_open ( )
pb_save_xls pb_save_xls
dw_6 dw_6
dw_4 dw_4
dw_3 dw_3
cb_crea_cbmag cb_crea_cbmag
cbx_giac_sotto cbx_giac_sotto
cbx_vedi_righe cbx_vedi_righe
sle_pg sle_pg
st_1 st_1
st_2 st_2
sle_copie sle_copie
sle_zoom sle_zoom
cb_salva_su_file cb_salva_su_file
cb_7 cb_7
cb_6 cb_6
cb_imp_st cb_imp_st
cb_stampa cb_stampa
cb_preview cb_preview
cb_pg_dopo cb_pg_dopo
cb_pg_prima cb_pg_prima
cb_1 cb_1
dw_1 dw_1
end type
global w_or_partitario_b_rpt w_or_partitario_b_rpt

type variables

integer ii_zoom=100, ii_FISCALE
long il_cat_codifica
string is_no_zero
end variables

forward prototypes
public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita)
end prototypes

public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita);long ll_id_articolo, ll_riga, ll_id_UC
integer i
string ls_cod_art, ls_des_art
decimal ldc_qta, ldc_prezzo

boolean lb_found

long ll_breakrow

lb_found = FALSE

ll_breakrow = 0

DO WHILE NOT (lb_found)

    ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 2)

    // If no breaks are found, exit.

    IF ll_breakrow <= 0 THEN EXIT

    // Have we found the section for Dept 121?
	 	i=ll_breakrow
		ldc_qta=dw_1.getitemdecimal(i, "c_saldo_pezzi")
		// NO! se la qta è <0 NON la riporto in positivo per azzerare, tanto nell'anno successivo
		// il conto dell'anno precedetne NON viene riportato (sto creando il riporto
		//del saldo nell'anno successivo, qundi ...
		//if ldc_qta<0 then ldc_qta=ldc_qta* -1 
		if ldc_qta> 0 then
			
			ll_riga=dw_4.insertrow(0)
			dw_4.setitem(ll_riga, "id_documento", al_id_doc)
			dw_4.setitem(ll_riga, "riga_documento_num_riga", i)
			dw_4.setitem(ll_riga, "riga_documento_id_caus_magazzino", al_id_caus)
			dw_4.setitem(ll_riga, "id_locazione_1", al_id_locazione)
			dw_4.setitem(ll_riga, "riga_documento_id_valuta", al_id_valuta)
			dw_4.setitem(ll_riga, "riga_documento_cambio", 1)
			dw_4.setitem(ll_riga, "tipo_um", "N")
			dw_4.setitem(ll_riga, "riga_documento_id_conto", al_id_contropartita)
			
			ls_cod_art=dw_1.getitemstring(i, "articolo_codice")
			ls_cod_art=trim(ls_cod_art)
			if ls_cod_art>" " then
				select a.id_articolo, id_unita_confezione, a.descrizione
				into :ll_id_articolo, :ll_id_UC, :ls_des_art
				from dba.articolo a, dba.unita_confezione u
				where a.codice=:ls_cod_art
				and a.id_articolo=u.id_articolo
				and u.unita_base='S'
				;
				if ll_id_articolo>0 then
					dw_4.setitem(ll_riga, "riga_documento_id_articolo", ll_id_articolo)
					dw_4.setitem(ll_riga, "riga_documento_id_unita_confezione", ll_id_UC)
				end if
				
				dw_4.setitem(ll_riga, "riga_documento_descrizione", ls_des_art)
			end if
			
			dw_4.setitem(ll_riga, "quantita", ldc_qta)
			dw_4.setitem(ll_riga, "qta_un_base", ldc_qta)
			ldc_prezzo=dw_1.getitemdecimal(i, "c_prezzo")
			dw_4.setitem(ll_riga, "prezzo_complessivo", ldc_prezzo)
			dw_4.setitem(ll_riga, "prezzo", ldc_prezzo)
			dw_4.setitem(ll_riga, "riga_documento_prezzo_netto", ldc_prezzo)
			dw_4.setitem(ll_riga, "riga_documento_id_tab_iva", al_id_tab_iva)
			
			//il totale è prezzo per qta
			dw_4.setitem(ll_riga, "importo_manifattura", ldc_prezzo*ldc_qta)
			dw_4.setitem(ll_riga, "tot_riga_val_riga", ldc_prezzo*ldc_qta)
			dw_4.setitem(ll_riga, "tot_riga_val_az", ldc_prezzo*ldc_qta)
			dw_4.setitem(ll_riga, "tot_riga_val_doc", ldc_prezzo*ldc_qta)
		end if
    // Increment starting row to find next break

    ll_breakrow = ll_breakrow + 1


		
loop
if dw_4.trigger event ue_update() = 1 then
	messagebox("OK!", "Documento creato correttamente!")
else
	messagebox("Ahi!", "Documento non creato!")
end if
return 1
end function

on w_or_partitario_b_rpt.create
this.pb_save_xls=create pb_save_xls
this.dw_6=create dw_6
this.dw_4=create dw_4
this.dw_3=create dw_3
this.cb_crea_cbmag=create cb_crea_cbmag
this.cbx_giac_sotto=create cbx_giac_sotto
this.cbx_vedi_righe=create cbx_vedi_righe
this.sle_pg=create sle_pg
this.st_1=create st_1
this.st_2=create st_2
this.sle_copie=create sle_copie
this.sle_zoom=create sle_zoom
this.cb_salva_su_file=create cb_salva_su_file
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_imp_st=create cb_imp_st
this.cb_stampa=create cb_stampa
this.cb_preview=create cb_preview
this.cb_pg_dopo=create cb_pg_dopo
this.cb_pg_prima=create cb_pg_prima
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.pb_save_xls,&
this.dw_6,&
this.dw_4,&
this.dw_3,&
this.cb_crea_cbmag,&
this.cbx_giac_sotto,&
this.cbx_vedi_righe,&
this.sle_pg,&
this.st_1,&
this.st_2,&
this.sle_copie,&
this.sle_zoom,&
this.cb_salva_su_file,&
this.cb_7,&
this.cb_6,&
this.cb_imp_st,&
this.cb_stampa,&
this.cb_preview,&
this.cb_pg_dopo,&
this.cb_pg_prima,&
this.cb_1,&
this.dw_1}
end on

on w_or_partitario_b_rpt.destroy
destroy(this.pb_save_xls)
destroy(this.dw_6)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.cb_crea_cbmag)
destroy(this.cbx_giac_sotto)
destroy(this.cbx_vedi_righe)
destroy(this.sle_pg)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_copie)
destroy(this.sle_zoom)
destroy(this.cb_salva_su_file)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_imp_st)
destroy(this.cb_stampa)
destroy(this.cb_preview)
destroy(this.cb_pg_dopo)
destroy(this.cb_pg_prima)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_test, ls_tikal, ls_tipo_arr
integer li_num_dec
date ldt_data_inizio_saldi
s_param_articoli s_parametri   // dichiaro la struttura per ricevere i dati
//// parametri di stampa

dw_4.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_6.insertrow(1)

s_parametri=message.powerobjectparm

il_cat_codifica=s_parametri.ll_magazzino
ii_fiscale=s_parametri.li_fiscale

if isnull(s_parametri.da_sog_comm) then s_parametri.da_sog_comm='0000000000000000000000000'
if isnull(s_parametri.a_sog_comm) then s_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if isnull(s_parametri.da_cod_art) then s_parametri.da_cod_art='0000000000000000000000000'
if isnull(s_parametri.a_cod_art) then s_parametri.a_cod_art='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
//if isnull(s_parametri.da_categoria) then s_parametri.da_categoria='00000000'
//if isnull(s_parametri.a_categoria) then s_parametri.a_categoria='ZZZZZZZZ'
if isnull(s_parametri.filtro) then s_parametri.filtro='Nessun filtro'
	
//if upperbound(s_parametri.li_titolo)>0 then
//	id_titolo[1]=s_parametri.li_titolo[1]
//	id_titolo[2]=s_parametri.li_titolo[2]
//end if
//recuperola data da cui calcolare i saldi 120414
select data_calc_saldi
INTO :ldt_data_inizio_saldi
FROM DBA.ORAFO_PAR_SISTEMA
;
IF ldt_data_inizio_saldi>DATE("1900-01-01") THEN
	s_parametri.inizio_es=ldt_data_inizio_saldi
END IF


ls_test=left(s_parametri.filtro, 1)
s_parametri.filtro=right(s_parametri.filtro, len(s_parametri.filtro) - 1)
choose case ls_test
	case 'S' 
		if s_parametri.tipo_stampa='M' then
			dw_1.dataobject="d_sub_mov_soggetto_mg_b"	
		else
			dw_1.dataobject="d_sub_mov_soggetto_b"
		end if
		dw_1.settransobject(sqlca)
		dw_1.retrieve(s_parametri.da_sog_comm, s_parametri.a_sog_comm, s_parametri.da_data,&
		s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro)
		if dw_1.dataobject="d_sub_mov_soggetto_b" then
			if s_parametri.solo_preziosi='N' then //rendo invisibili i totali documento
				dw_1.object.saldo_val_doc.visible=0
				dw_1.object.somma_prog_grammi_doc.visible=0
				dw_1.object.saldo_val_s_doc.visible=0
				dw_1.object.saldo_val_c_doc.visible=0
				dw_1.object.somma_grs_doc.visible=0
				dw_1.object.somma_grc_doc.visible=0
				dw_1.object.somma_legato_doc.visible=0
				dw_1.object.tot_doc.visible=0				
			end if
		end if
		
	case 'A'
		if s_parametri.tipo_stampa='M' then
			dw_1.dataobject="d_sub_mov_articolo_mg_b"
		elseif s_parametri.tipo_stampa='G' or s_parametri.tipo_stampa='0' or s_parametri.tipo_stampa='1'then
			dw_1.dataobject="d_giac_art_tb"
			if s_parametri.tipo_stampa='0' then 
				is_no_zero='S'
				dw_6.visible=true
				cb_crea_cbmag.visible=true
			elseif s_parametri.tipo_stampa='1' then
				is_no_zero='1'
			end if
		else
			dw_1.dataobject="d_sub_mov_articolo_b"
		end if
		dw_1.settransobject(sqlca)
		dw_1.retrieve(s_parametri.da_cod_art,s_parametri.a_cod_art, s_parametri.da_data,&
		s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro )
	case 'P'
		dw_1.dataobject="d_es_art_pezzo_tb"
		dw_1.settransobject(sqlca)
		//cerco i decimali a cui arrotondare e il tipo di arrotondamento
		select tipo_arrotondamento, cifra_arrotondamento
		into :ls_tipo_arr, :li_num_dec
		from valuta
		where id_valuta=:s_parametri.li_titolo[1];
		
		dw_1.retrieve(s_parametri.li_titolo[1],s_parametri.cambio,&
		s_parametri.da_data,s_parametri.a_data, s_parametri.da_cod_art, &
		s_parametri.a_cod_art, li_num_dec, ls_tipo_arr)
	case '0'
		dw_1.dataobject="d_es_art_pezzo_no_0_tb"
		dw_1.settransobject(sqlca)
		//cerco i decimali a cui arrotondare e il tipo di arrotondamento
		select tipo_arrotondamento, cifra_arrotondamento
		into :ls_tipo_arr, :li_num_dec
		from valuta
		where id_valuta=:s_parametri.li_titolo[1];
		
		dw_1.retrieve(s_parametri.li_titolo[1],s_parametri.cambio,&
		s_parametri.da_data,s_parametri.a_data, s_parametri.da_cod_art, &
		s_parametri.a_cod_art, li_num_dec, ls_tipo_arr)
	case 'C'
		dw_1.dataobject="d_cl_fo_art_tb"
		dw_1.settransobject(sqlca)
		if isnull(s_parametri.da_cod_art) or s_parametri.da_cod_art <= " " then
			s_parametri.da_cod_art="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
		end if
		
		dw_1.retrieve(s_parametri.da_sog_comm, s_parametri.a_sog_comm, s_parametri.da_data,&
		s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro, s_parametri.id_variazione,&
		s_parametri.da_cod_art, s_parametri.a_cod_art)
		
end choose





//	dw_1.retrieve(,&
//	s_parametri.da_sog_comm, s_parametri.a_sog_comm, &
//	s_parametri.da_categoria, s_parametri.a_categoria, s_parametri.da_data,&
//	s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro,s_parametri.totali_doc,&
//	s_parametri.legato_fino, s_parametri.solo_preziosi)
//end if
////s_parametri.totali_doc,s_parametri.legato_fino )
//
//
//dw_1.retrieve(ls_da_sog_comm, ls_a_sog_comm)
//
//LONG LL_ROW
//INTEGER I
//LL_ROW = DW_1.ROWCOUNT()
////MESSAGEBOX ('RIGHE', LL_ROW)
//
//FOR I = 1 TO LL_ROW
//
//	dw_1.setitem(I,"data_in", d_data_in)
//	dw_1.setitem(I,"data_fin", d_data_fin)
//NEXT
//
//this.event post ue_post_open()
end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75
end event

type pb_save_xls from picturebutton within w_or_partitario_b_rpt
integer x = 3081
integer y = 36
integer width = 160
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\ordina.png"
alignment htextalign = left!
end type

event clicked;integer i
string ls_art, ls_des, ls_filename,ls_art_old
decimal ldc_qta, ldc_costo_un, ldc_costo_tot, ldc_pr_ven
datastore ds_xls
long ll_riga

ds_xls=create datastore
ds_xls.dataobject="d_xls_pezzi_no_0"
ds_xls.settransobject(sqlca)

for i= 1 to dw_1.rowcount()
	ls_art=dw_1.getitemstring(i, "articolo_codice")
	ls_des=dw_1.getitemstring(i, "articolo_descrizione")
	ldc_qta=dw_1.getitemdecimal(i, "sum_qta")
	ldc_costo_un=dw_1.getitemdecimal(i, "c_costo")
	ldc_costo_tot=dw_1.getitemdecimal(i, "c_costo_tot")
	ldc_pr_ven=dw_1.getitemdecimal(i, "c_pr_un_vendita")
	if ldc_qta >0 and  (ls_art <>  ls_art_old or i=1)  then
		ll_riga=ds_xls.insertrow(0)	
		ds_xls.setitem(ll_riga, "articolo", ls_art)
		ds_xls.setitem(ll_riga, "descrizione", ls_des)
		ds_xls.setitem(ll_riga, "qta", ldc_qta)
		ds_xls.setitem(ll_riga, "costo_unitario", ldc_costo_un)
		ds_xls.setitem(ll_riga, "costo_totale", ldc_costo_tot)
		ds_xls.setitem(ll_riga, "pr_ven_unitario", ldc_pr_ven)
	end if
	ls_art_old=ls_art

next
if DirectoryExists("c:\nita\xls")=false then
	CreateDirectory ( "c:\nita\xls" )
end if
ls_filename="C:\nita\xls\"+string(today(), "yyyy-mm-dd hhmm")+".xls"
ds_xls.saveas(ls_filename, Excel!, true)
end event

type dw_6 from udw_base within w_or_partitario_b_rpt
boolean visible = false
integer x = 1614
integer y = 132
integer width = 1335
integer height = 124
boolean bringtotop = true
string dataobject = "d_dati_fissi_crea_car_base"
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_4 from udw_base within w_or_partitario_b_rpt
boolean visible = false
integer x = 1280
integer y = 1756
integer width = 1051
integer height = 348
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_orafo_riga_documento_ordine_260510_gd"
end type

type dw_3 from udw_base within w_or_partitario_b_rpt
boolean visible = false
integer x = 2423
integer y = 1824
integer width = 526
integer height = 244
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_doc"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type cb_crea_cbmag from commandbutton within w_or_partitario_b_rpt
boolean visible = false
integer x = 2967
integer y = 152
integer width = 567
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Carico Inizio Anno"
end type

event clicked;date ldt_data_doc
string ls_num_doc
long ll_id_prof_doc, ll_id_locazione, ll_id_caus, ll_id_prof_reg, ll_id_valuta,ll_id_doc
long ll_id_registro, ll_num_prog, ll_id_sog, ll_id_contropartita, ll_id_tab_iva

dw_3.insertrow(1)

ldt_data_doc=dw_6.getitemdate(1, "data_documento")
ll_id_prof_doc=dw_6.getitemnumber(1, "id_prof_documento")
dw_3.setitem(1, "data_documento", ldt_data_doc)
dw_3.setitem(1, "data_competenza", ldt_data_doc)
dw_3.setitem(1, "num_documento", ls_num_doc)

dw_3.setitem(1, "id_prof_documento", ll_id_prof_doc)
select id_prof_registrazione, id_caus_magazzino_prop, id_locazione_1_prop
into :ll_id_prof_reg, :ll_id_caus, :ll_id_locazione
from dba.prof_documento
where id_prof_documento=:ll_id_prof_doc;
dw_3.setitem(1, "id_prof_registrazione", ll_id_prof_reg)
select first(id_registro)
into :ll_id_registro
from registro r, esercizio e
where tipo_registro='GA'
and e.id_esercizio=r.id_esercizio
and e.data_inizio<=today()
and e.data_fine>=today()
;
if ll_id_registro >0 then
	dw_3.setitem(1, "id_registro", ll_id_registro)
	select num_progressivo
	into :ll_num_prog
	from registro
	where id_registro=:ll_id_registro
	;
	dw_3.setitem(1, "num_progressivo", ll_num_prog)
	
	dw_3.setitem(1, "data_registrazione", 	today())
	ll_id_sog=dw_6.getitemnumber(1, "id_sog_com")
	dw_3.setitem(1, "id_sog_commerciale", 	ll_id_sog)
	dw_3.setitem(1, "id_sog_commerciale_fattura", 	ll_id_sog)
	//trova contropartita
	select id_conto
	into :ll_id_contropartita
	from dba.con_movimento
	where id_sog_commerciale=:ll_id_sog
	and applicazione='A'
	;
	if isnull(ll_id_contropartita) or ll_id_contropartita=0 then
		select id_conto_predefinito
		into :ll_id_contropartita
		from dba.par_sistema;
	end if
	select id_tab_iva
	into :ll_id_tab_iva
	from dba.sog_commerciale
	where id_sog_commerciale=:ll_id_sog
	;
	if isnull(ll_id_tab_iva) then
		select id_conto_iva_ia
		into :ll_id_contropartita
		from dba.par_sistema;
	end if
	
	//valuta
	select id_val_euro
	into :ll_id_valuta
	from dba.par_sistema;
	dw_3.setitem(1, "id_valuta", 	ll_id_valuta)
	
	//ora provo a salvare
	dw_3.triggerevent("ue_update")
	//se tutto va bene carico le righe
	ll_id_doc=dw_3.getitemnumber(1, "id_documento")
	if ll_id_doc>0 then
		wf_inserisci_righe(ll_id_doc, ll_id_caus, ll_id_locazione, ll_id_valuta,ll_id_tab_iva, ll_id_contropartita)
	else
		messagebox("Errore!", "Documento non salvato!")
	end if
else
	//manca il registro!!!
end if
end event

type cbx_giac_sotto from checkbox within w_or_partitario_b_rpt
integer x = 526
integer y = 164
integer width = 645
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo articoli con giac < 0"
end type

event clicked;if checked then
	dw_1.setfilter("c_saldo_pezzi <0 ")
else
	dw_1.setfilter("")
end if
dw_1.filter()
end event

type cbx_vedi_righe from checkbox within w_or_partitario_b_rpt
integer x = 96
integer y = 160
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 80")
	if dw_1.dataobject<>"d_cl_fo_art_tb" then
		dw_1.modify("datawindow.header.2.height = 160")
	end if
else
	dw_1.modify("datawindow.detail.height = 0")
	if dw_1.dataobject<>"d_cl_fo_art_tb" then
		dw_1.modify("datawindow.header.2.height = 80")
	end if
	
end if
end event

type sle_pg from singlelineedit within w_or_partitario_b_rpt
integer x = 1458
integer y = 32
integer width = 503
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_or_partitario_b_rpt
integer x = 1189
integer y = 44
integer width = 270
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stampa Pg.:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_or_partitario_b_rpt
integer x = 1970
integer y = 44
integer width = 151
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copie:"
boolean focusrectangle = false
end type

type sle_copie from singlelineedit within w_or_partitario_b_rpt
integer x = 2117
integer y = 32
integer width = 165
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_zoom from singlelineedit within w_or_partitario_b_rpt
integer x = 782
integer y = 32
integer width = 146
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;ii_zoom=integer(this.text)
dw_1.object.datawindow.zoom=ii_zoom

end event

type cb_salva_su_file from commandbutton within w_or_partitario_b_rpt
integer x = 2775
integer y = 36
integer width = 279
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save as file"
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_or_partitario_b_rpt
integer x = 933
integer y = 36
integer width = 242
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from commandbutton within w_or_partitario_b_rpt
integer x = 562
integer y = 36
integer width = 219
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_imp_st from commandbutton within w_or_partitario_b_rpt
integer x = 2478
integer y = 36
integer width = 297
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imp. Stamp."
end type

event clicked;printsetup()
dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_stampa from commandbutton within w_or_partitario_b_rpt
integer x = 3269
integer y = 36
integer width = 261
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_preview from commandbutton within w_or_partitario_b_rpt
integer x = 2295
integer y = 36
integer width = 183
integer height = 92
integer taborder = 70
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_1.object.datawindow.print.preview='No'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_pg_dopo from commandbutton within w_or_partitario_b_rpt
integer x = 434
integer y = 36
integer width = 91
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_pg_prima from commandbutton within w_or_partitario_b_rpt
integer x = 325
integer y = 36
integer width = 91
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_1 from commandbutton within w_or_partitario_b_rpt
integer x = 37
integer y = 36
integer width = 261
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_or_partitario_b_rpt
integer x = 18
integer y = 256
integer width = 3506
integer height = 1424
integer taborder = 120
string dataobject = "d_sub_mov_soggetto_b"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event printpage;//integer li_copie, li_ap, i , li_pos=0, li_inizio, li_fine
//string ls_nr_pg
//boolean lb_stampa=false
//
//
//
//ls_nr_pg=sle_pg.text
//if isnull(ls_nr_pg) then ls_nr_pg='T'
//
//choose case ls_nr_pg
//	case 'T'
//		
//	case 'P'
//		if mod(pagenumber, 2)<>0 then
//			return 1
//		end if
//	case 'D'
//		if mod(pagenumber, 2)=0 then
//			return 1
//		end if	
//	case else
//		li_copie=len(ls_nr_pg)
//      li_pos=pos(ls_nr_pg, "-", li_pos+1)
//		if li_pos>0 then	
//			li_inizio=integer(left(ls_nr_pg, li_pos - 1))
//			li_fine=integer(right(ls_nr_pg, li_copie - li_pos))
//			if li_fine=0 or isnull(li_fine) then li_fine=pagenumber
//			if li_inizio=0 or li_fine=0 or isnull(li_inizio) then
//				messagebox("Attenzione!", "Pagine da stampare non impostate correttamente")
//			end if
//			if pagenumber>=li_inizio and pagenumber<=li_fine then lb_stampa=true
//		else	
//			for i = 1 to li_copie
//				if li_pos>=i then continue
//				//if li_pos>=li_copie then exit
//				li_pos=pos(ls_nr_pg, ",", li_pos+1)
//				if li_pos=0 then li_pos=li_copie + 1
//				li_ap=integer(mid(ls_nr_pg, i, li_pos - 1))
//				if li_ap=0 or isnull(li_ap) then
//					messagebox("Attenzione!", "Pagine da stampare non impostate correttamente")
//				else
//					if li_ap=pagenumber then 
//						lb_stampa=true
//						exit
//					end if
//				end if
//			next
//		end if
//		if lb_stampa=false then return 1
//end choose
//
//
////messagebox("pagina", pagenumber)
//
////messagebox("copie", copy)
end event

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;string ls_sql
//, ls_titolo[],ls_cod_met[]
//decimal{2} ld_titolo[]
//integer i, li_pos
//
//if is_tipo_dw="data" then
	ls_sql=sqlsyntax
	
	if il_cat_codifica>0 then
		ls_sql=ls_sql + " and (articolo.id_cat_codifica= "+string(il_cat_codifica)+")"
		//messagebox("W", ls_sql)
		setsqlpreview(ls_sql)
		if is_no_zero='S' then
			dw_1.setfilter("c_saldo_pezzi<>0")
			dw_1.filter()
			dw_1.groupcalc()
		elseif is_no_zero = "1" then
			dw_1.setfilter("c_saldo_pezzi>0")
			dw_1.filter()
			dw_1.groupcalc()
		end if
		
	end if
	if ii_fiscale=1 then
		ls_sql=ls_sql + " and (caus_magazzino.mp_car_fiscali>' ' or caus_magazzino.mp_scar_fiscali>' ')"
		setsqlpreview(ls_sql)
	end if
//	
//	
//	//messagebox("0", right(sqlsyntax, 400))
//end if
end event

