forward
global type w_catalogo_2018_cx from w_001
end type
type cb_salva from commandbutton within w_catalogo_2018_cx
end type
type cb_nuovo from commandbutton within w_catalogo_2018_cx
end type
type cb_cancella from commandbutton within w_catalogo_2018_cx
end type
type cb_esci from commandbutton within w_catalogo_2018_cx
end type
type cb_ordina from commandbutton within w_catalogo_2018_cx
end type
type cb_seleziona from commandbutton within w_catalogo_2018_cx
end type
type cb_azzera from commandbutton within w_catalogo_2018_cx
end type
type dw_3 from u_dw_figlio within w_catalogo_2018_cx
end type
type st_2 from statictext within w_catalogo_2018_cx
end type
type cb_foto2 from commandbutton within w_catalogo_2018_cx
end type
type dw_4 from u_dw_base within w_catalogo_2018_cx
end type
type cb_2 from commandbutton within w_catalogo_2018_cx
end type
type cbx_vedi_foto from checkbox within w_catalogo_2018_cx
end type
type rb_3 from radiobutton within w_catalogo_2018_cx
end type
type rb_2 from radiobutton within w_catalogo_2018_cx
end type
type ddlb_dec_prezzo from dropdownlistbox within w_catalogo_2018_cx
end type
type p_1 from picture within w_catalogo_2018_cx
end type
type dw_8 from udw_001 within w_catalogo_2018_cx
end type
type cb_cat_ins from commandbutton within w_catalogo_2018_cx
end type
type cb_cat_canc from commandbutton within w_catalogo_2018_cx
end type
type cb_1 from commandbutton within w_catalogo_2018_cx
end type
type sle_1 from singlelineedit within w_catalogo_2018_cx
end type
type cb_3 from commandbutton within w_catalogo_2018_cx
end type
type lb_msgbox from listbox within w_catalogo_2018_cx
end type
type uo_remote from u_panel_remote within w_catalogo_2018_cx
end type
type uo_local from u_panel_local within w_catalogo_2018_cx
end type
type cb_4 from commandbutton within w_catalogo_2018_cx
end type
type cb_5 from commandbutton within w_catalogo_2018_cx
end type
type cb_6 from commandbutton within w_catalogo_2018_cx
end type
end forward

global type w_catalogo_2018_cx from w_001
boolean visible = false
integer width = 5143
integer height = 2544
string title = "Catalogo Immediato"
boolean minbox = true
boolean maxbox = true
windowtype windowtype = main!
boolean center = true
cb_salva cb_salva
cb_nuovo cb_nuovo
cb_cancella cb_cancella
cb_esci cb_esci
cb_ordina cb_ordina
cb_seleziona cb_seleziona
cb_azzera cb_azzera
dw_3 dw_3
st_2 st_2
cb_foto2 cb_foto2
dw_4 dw_4
cb_2 cb_2
cbx_vedi_foto cbx_vedi_foto
rb_3 rb_3
rb_2 rb_2
ddlb_dec_prezzo ddlb_dec_prezzo
p_1 p_1
dw_8 dw_8
cb_cat_ins cb_cat_ins
cb_cat_canc cb_cat_canc
cb_1 cb_1
sle_1 sle_1
cb_3 cb_3
lb_msgbox lb_msgbox
uo_remote uo_remote
uo_local uo_local
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
end type
global w_catalogo_2018_cx w_catalogo_2018_cx

type variables
datawindow adw
//integer li_record
LONG IL_ID_SOG 
//
//
boolean ib_stopaction

end variables

forward prototypes
public subroutine wf_stampa_intestazione (long ai_job, integer ai_num_pag)
public function integer wf_calcola_altezza_testo (integer ai_altezza_testo)
public subroutine wf_post_open ()
public subroutine wf_stampa_foto (s_dati_foto s_foto[], long mydc, decimal adc_dpi_x, decimal adc_dpi_y)
public subroutine wf_stampa_art_acq_cliente (u_dw_figlio adw_art_acq)
public subroutine wf_stampa_da_ordine (datastore ds_recupera)
public subroutine wf_stampa_testo (s_testo_cat as_text[], integer ai_larghezza, integer ai_altezza, long ai_job)
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public function integer wf_trova_lung_peso (long ad_articolo, long ad_sog, long al_riga)
public subroutine wf_trova_prezzo (long al_id_art, long al_id_sog, long al_riga)
public subroutine wf_trova_immagine (long al_id_articolo, long al_id_sog, long al_riga)
public subroutine wf_metti_sog_commerciale (long al_riga)
public subroutine wf_stampa_da_selezione (s_st_cat_immediato ast_cat)
public subroutine wf_trova_um (long al_id_art, long al_riga)
public function integer wf_trova_ris (string as_h_v, string as_nome_imm)
public function string wf_des_lunga (long al_id_art)
public function string wf_path_categoria (long al_id_art)
public subroutine wf_addmsg (string as_msg)
public function string wf_copia_imm_in_sito (string as_path_file[])
public function string wf_agg_art_correlati (string as_nome_imm, string as_path_imm)
public function string wf_rec_h_p (long al_id_art)
end prototypes

public subroutine wf_stampa_intestazione (long ai_job, integer ai_num_pag);string ls_rif, ls_nota, ls_cod_azienda


PrintDefineFont(ai_job, 2, "Arial", -8, 400, Default!, AnyFont!, false, false) 
printtext(ai_job, string(today()), 150*3.94, 70*3.94,2)
printtext(ai_job, "Pg. "+string(ai_num_pag), 450*3.94, 70*3.94,2)

select codice, note
into :ls_cod_azienda, :ls_nota
from azienda
where id_azienda=1;
if isnull(ls_nota) then ls_nota=""
if  ls_cod_azienda='FANTASY' then
	printtext(ai_job, "Via Aldo Moro, 27/29 - Capolona (Ar) Italy - Tel. 0575-48479 Fax 0575-420135 E-Mail: info@fantasy444ar.com",&
				290*3.94, 2780*3.94,2)
else
	printtext(ai_job,ls_nota ,	290*3.94, 2780*3.94,2)
end if



end subroutine

public function integer wf_calcola_altezza_testo (integer ai_altezza_testo);
integer i
string ls_column[]

ls_column[1]="peso_unitario_t"
ls_column[2]="lunghezza_t"
ls_column[3]="prezzo_t"
ls_column[4]="des_articolo_t"
ls_column[5]="qta_t"


for i=1 to upperbound(ls_column)
	if dw_3.Describe(ls_column[i]+".Color")<>'16777215' then
		ai_altezza_testo -= 50
	end if
next	
return ai_altezza_testo
end function

public subroutine wf_post_open ();//
//datastore ds_recupera
//integer li_ret, i
//string ls_class
//long ll_righe
//s_st_cat_immediato st_cat
//	
//if isvalid(message.powerobjectparm) then
//	ls_class=message.powerobjectparm.classname()
//	if ls_class="s_st_cat_immediato" then 
//		st_cat=message.powerobjectparm
//		wf_stampa_da_selezione(st_cat)
//	elseif ls_class='s_list_main' then 
//			
//	else 
//		ds_recupera=message.powerobjectparm
//		ll_righe= ds_recupera.rowcount()
//		if ll_righe>0 then
//			wf_stampa_da_ordine(ds_recupera)
//		end if
//	end if
//end if
//SETREDRAW(TRUE)
//cbx_non_girare.CHECKED=TRUE
//

end subroutine

public subroutine wf_stampa_foto (s_dati_foto s_foto[], long mydc, decimal adc_dpi_x, decimal adc_dpi_y);//long ll_dpi_x, ll_dpi_y, ll_alt, ll_lar, ll_top, ll_left
//string ls_path, ls_logo
//integer i
//
//for i=1 to upperbound(s_foto)
//	if s_foto[i].nome_imm='NO' then continue
//	ole_imm.object.loadimage=s_foto[i].nome_imm
//	
//	ole_imm.object.printtop=s_foto[i].top 
//	ole_imm.object.printleft= s_foto[i].left
//	ole_imm.object.printbottom=s_foto[i].bottom
//	ole_imm.object.printright=s_foto[i].right
//	
//	
//	ole_imm.object.printimage=	mydc				
//	
//next
//
//select logo
//into :ls_logo
//from azienda
//where id_azienda=1;
//
//select dir_immagini
//into :ls_path
//from par_sistema;
//
//if right(ls_path, 1)<>'\' then ls_path+='\'
//if fileexists(ls_path+ls_logo) then
//	ole_imm.object.loadimage=ls_path+ls_logo
//	ll_dpi_x=ole_imm.object.imageXDpi
//	ll_dpi_y=ole_imm.object.imageYDpi
//	ll_alt=200
//	ll_lar=600
//	
//	
//	ll_top=25*adc_dpi_y 
//	
//	ll_left=750*adc_dpi_x
//	
//
//	ole_imm.object.printtop=ll_top
//	ole_imm.object.printleft=ll_left
//	ole_imm.object.printbottom=ll_top+ (ll_alt*adc_dpi_y)    
//	ole_imm.object.printright=ll_left+ (ll_lar *adc_dpi_x)  
//	
//	ole_imm.object.printimage=	mydc				
//else
//	
//end if
//
//	
end subroutine

public subroutine wf_stampa_art_acq_cliente (u_dw_figlio adw_art_acq);//integer i, li_righe
//string ls_cod_articolo
//li_righe=adw_art_acq.rowcount()
//
//for i= 1 to li_righe
//	dw_3.insertrow(i)
//	ls_cod_articolo=adw_art_acq.getitemstring(i, "cod_articolo")
//	dw_3.setitem(i, "cod_articolo",ls_cod_articolo)
//next
//
//dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.peso_t)
//dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.lunghezza_t)
//cb_stampa.postevent(clicked!)
//
	

end subroutine

public subroutine wf_stampa_da_ordine (datastore ds_recupera);//integer li_ret, i
//string ls_imm,ls_registro
//long ll_righe, ll_di_art, ll_id_riga
//SETREDRAW(FALSE)
//
//
//
//dw_3.reset()
//
//li_ret=ds_recupera.rowcount()
//cbx_solo_nuovi.visible=true
//li_ret=ds_recupera.rowscopy(1, li_ret, primary!, dw_3, 1, primary!)
//if li_ret<>1 then messagebox("Errore!", "Righe non copiate!")
//
//ll_righe=dw_3.rowcount()
//if ll_righe>0 then
//	il_id_sog=dw_3.getitemnumber(1, "id_sog_commerciale")
//	dw_1.setitem(1, "id_sog_commerciale", il_id_sog)
//end if
//
////seleziono i campi che sono da stampare normalmente (peso e prezzo oltre a codice art)
//dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.peso_unitario_t)
////modifico su richiesta Lucio kati (unica ditta che lo usa) 110207 prima era .lunghezza_t
//dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.prezzo_t)
//
//dw_3.sort()
//ll_id_riga=dw_3.getitemnumber(1, "id_riga_documento")
//select tipo_registro
//into :ls_registro
//from documento d, riga_documento rd, registro r
//where d.id_documento=rd.id_documento
//and rd.id_riga_documento=:ll_id_riga
//and d.id_registro=r.id_registro
//;
//if ls_registro='OA' then
//	dw_4.setitem(1,1, "d_ordine_fo")
//else
//	dw_4.setitem(1,1, "d_conferma_ordine_foto")
//end if
//rb_2.checked=true
//rb_2.triggerevent(clicked!)
//cb_foto2.triggerevent(clicked!)
//
//SETREDRAW(TRUE)
end subroutine

public subroutine wf_stampa_testo (s_testo_cat as_text[], integer ai_larghezza, integer ai_altezza, long ai_job);//
//integer li_righe, i, li_incremento_y
//string ls_cod_articolo, ls_descrizione, ls_listino
//decimal{2} ldc_peso, ldc_lunghezza, ldc_prezzo
//long ldc_qta, ll_id_variazione  
//
//ai_larghezza*=3.94
//ai_altezza*=3.94
//PrintDefineFont(ai_job, 1, "Arial", -8, 400, Default!, AnyFont!, false, false) 
//PrintDefineFont(ai_job, 2, "Arial", -8, 700, Default!, AnyFont!, false, false) 
//PrintSetFont(ai_job, 1)
//
//for i= 1 to upperbound(as_text)
//	li_record++
//	if as_text[i].s_num_riga = -1 then continue
//	
//	as_text[i].s_top*=3.94
//	as_text[i].s_left*=3.94
//	
//	PrintRect(ai_job, as_text[i].s_left, as_text[i].s_top, ai_larghezza,ai_altezza, 5)
//	
//	ls_cod_articolo=dw_3.getitemstring(li_record, "cod_articolo")
//	ldc_prezzo=dw_3.getitemdecimal(li_record, "prezzo")
//	ldc_peso=dw_3.getitemdecimal(li_record, "peso_unitario")
//	ldc_lunghezza=dw_3.getitemdecimal(li_record, "lunghezza")
//	ls_descrizione=dw_3.getitemstring(li_record, "des_articolo")
//	ldc_qta=dw_3.getitemnumber(li_record, "qta")
//	ll_id_variazione=dw_3.getitemnumber(li_record, "listino")
//	select lis_base
//	into :ls_listino
//	from variazione v, listino l
//	where v.id_variazione=:ll_id_variazione
//	and l.id_listino=v.id_listino
//	;
//	
//	li_incremento_y=80
//	printtext(ai_job, ls_cod_articolo, as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
//	li_incremento_y+=200
//	if dw_3.Describe("des_articolo_t.Color")='16777215' then
//		printtext(ai_job, ls_descrizione, as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)	
//		li_incremento_y+=200
//	end if
//	if dw_3.Describe("peso_unitario_t.Color")='16777215' then 
//		printtext(ai_job, "g. "+string(ldc_peso), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
//		li_incremento_y+=200
//	end if
//	if dw_3.Describe("lunghezza_t.Color")='16777215' then 
//		printtext(ai_job, "CM. "+string(ldc_lunghezza), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
//		li_incremento_y+=200
//	end if
//	if dw_3.Describe("qta_t.Color")='16777215' then 
//		printtext(ai_job, "Pz. "+string(ldc_qta), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
//		li_incremento_y+=200
//	end if
//	if ls_listino<>"S" then
//		PrintSetFont(ai_job, 2)
//	end if
//	if dw_3.Describe("prezzo_t.Color")='16777215' then 
//		printtext(ai_job, "€: "+string(ldc_prezzo), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
//	end if
//	if ls_listino<>"S" then
//		PrintSetFont(ai_job, 1)
//	end if
//next
//
//
//
end subroutine

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
	dw_3.setitem(al_riga_corrente, "id_articolo",ll_id_art)
	dw_3.setitem(al_riga_corrente,"cod_articolo", ls_ric_param.s_main_value)
	dw_3.setitem(al_riga_corrente, "des_articolo",ls_ric_param.s_ausil_value[1])
	dw_3.setitem(al_riga_corrente,"tipo_um",ls_ric_param.s_ausil_value[14])
	select peso_lordo , 
	into :ldc_peso_lordo
	from articolo a, unita_confezione u
	where a.id_articolo=u.id_articolo
	and u.unita_base='S'
	and a.id_articolo=:ll_id_art
	;
	dw_3.setitem(al_riga_corrente,"peso_lordo",ldc_peso_lordo)
	if IL_ID_SOG >0 then 
		ll_id_sog=IL_ID_SOG
	else
		ll_id_sog=dw_3.getitemnumber(al_riga_corrente, "id_sog_commerciale")
	end if
	post wf_trova_lung_peso(long(ls_ric_param.s_id_seg_value[1]), ll_id_sog, al_riga_corrente)
	post wf_trova_prezzo(long(ls_ric_param.s_id_seg_value[1]), ll_id_sog, al_riga_corrente)
	post wf_trova_immagine(long(ls_ric_param.s_id_seg_value[1]), ll_id_sog, al_riga_corrente)
end if
end subroutine

public function integer wf_trova_lung_peso (long ad_articolo, long ad_sog, long al_riga);decimal ld_dim, ld_peso_manuale,ld_dim_esistente, ld_peso_unitario, ld_test, ldc_larghezza
long ll_righe,ll_riga_trovata
integer i

datastore ds_orafo_lung_peso
dw_3.accepttext()
ds_orafo_lung_peso=create datastore
ds_orafo_lung_peso.dataobject="ds_or_lung_peso"
ds_orafo_lung_peso.settransobject(sqlca)
ll_righe=ds_orafo_lung_peso.retrieve(ad_sog,ad_articolo)
if ll_righe>0 then
	ld_dim_esistente=dw_3.getitemdecimal(al_riga, "lunghezza")
	if ld_dim_esistente>0 then
		for i=1 to ll_righe
			ld_test=ds_orafo_lung_peso.getitemdecimal(i, "lunghezza")
			if ld_test=ld_dim_esistente then
				ll_riga_trovata=i
			end if
		next
	end if
	if ll_riga_trovata<=0 then ll_riga_trovata=1
	
	
	ld_peso_unitario=ds_orafo_lung_peso.getitemdecimal(ll_riga_trovata, "peso_unitario")
	ld_peso_manuale=ds_orafo_lung_peso.getitemdecimal(ll_riga_trovata, "peso_manuale")
	if ld_peso_manuale>0 then ld_peso_unitario=ld_peso_manuale
	ld_dim=ds_orafo_lung_peso.getitemdecimal(ll_riga_trovata, "lunghezza")
	
else
	select u.dim_l, u.peso_netto, u.dim_h
	into :ld_dim, :ld_peso_unitario, :ldc_larghezza
	from unita_confezione u
	where u.id_articolo=:ad_articolo
	and u.unita_base='S';
end if
if ld_peso_unitario>0 then
	dw_3.setitem(al_riga, "peso_unitario", ld_peso_unitario)
end if
if ld_dim>0 then
	dw_3.setitem(al_riga, "lunghezza",ld_dim)
end if
if ldc_larghezza>0 then
	dw_3.setitem(al_riga, "larghezza",ldc_larghezza)
end if
destroy(ds_orafo_lung_peso)
return 1

end function

public subroutine wf_trova_prezzo (long al_id_art, long al_id_sog, long al_riga);//long ll_id_uc, ll_id_listino, ll_id_var,ll_id_um
//decimal ld_prezzo_manifattura, ldc_prezzo_pz
//string ls_pref_fornitore, ls_cod_soggetto, ls_cod_listino,ls_tipo_um
//
//
//
//
//if cbx_recupera_prezzo.checked then
//	
//	
//	if isnull(al_id_art) or al_id_art<=0 then return
//	
//	select id_unita_confezione, id_unita_misura
//	into :ll_id_uc, :ll_id_um
//	from unita_confezione
//	where id_articolo=:al_id_art
//	and unita_base='S'
//	;
//	if al_id_sog>0 then
//		select id_listino, codice
//		into :ll_id_listino, :ls_cod_soggetto
//		from sog_commerciale
//		where id_sog_commerciale=:al_id_sog;
//	end if
//	
//	select pref_cod_fornitore
//	into :ls_pref_fornitore
//	from par_sistema;
//	if isnull(ls_pref_fornitore) then
//		messagebox("Attenzione!", "Specificare il prefisso dei fornitori in Parametri di Sistema")
//	end if
//	
//	if left(ls_cod_soggetto, 2)=ls_pref_fornitore then
//		ls_pref_fornitore='A'
//	else
//		ls_pref_fornitore='V'
//	end if
//	
//	if ll_id_listino<=0 or isnull(ll_id_listino) then
//		select id_listino
//		into :ll_id_listino
//		from listino
//		where lis_base='S'
//		and tipo= :ls_pref_fornitore
//		;
//	else
//	end if
//	
//	select id_variazione
//	into :ll_id_var
//	from variazione
//	where id_listino=:ll_id_listino
//	and (data_inizio<=today() 
//	and (data_fine>=today() or data_fine is null));
//	
//	select prezzo_manifattura, prezzo
//	into :ld_prezzo_manifattura, :ldc_prezzo_pz
//	from prezzo
//	where id_unita_confezione=:ll_id_uc
//	and id_variazione=:ll_id_var
//	;
//	if (isnull(ld_prezzo_manifattura) or ld_prezzo_manifattura=0) and &
//		(isnull(ldc_prezzo_pz) or ldc_prezzo_pz=0) then
//		select id_listino
//		into :ll_id_listino
//		from listino
//		where lis_base='S'
//		and tipo= :ls_pref_fornitore
//		;
//		
//		select id_variazione
//		into :ll_id_var
//		from variazione
//		where id_listino=:ll_id_listino
//		and (data_inizio<=today() 
//		and (data_fine>=today() or data_fine is null));
//		
//		select prezzo_manifattura, prezzo
//		into :ld_prezzo_manifattura, :ldc_prezzo_pz
//		from prezzo
//		where id_unita_confezione=:ll_id_uc
//		and id_variazione=:ll_id_var
//		;
//	end if
//	select tipo
//	into :ls_tipo_um
//	from unita_misura
//	where id_unita_misura=:ll_id_um;
//	if ls_tipo_um='N' then
//		dw_3.setitem(al_riga, "prezzo", ldc_prezzo_pz)
//	else
//		dw_3.setitem(al_riga, "prezzo", ld_prezzo_manifattura)
//	end if
//	dw_3.setitem(al_riga, "listino", ll_id_var)
//end if
end subroutine

public subroutine wf_trova_immagine (long al_id_articolo, long al_id_sog, long al_riga);string ls_nome_immagine

if al_id_articolo>0 then
	if al_id_sog>0 then
		select nome_immagine
		into :ls_nome_immagine
		from immagini_cliente
		where id_sog_commerciale=:al_id_sog
		and id_articolo=:al_id_articolo;
	end if
	if ls_nome_immagine="" or isnull(ls_nome_immagine) then
		select immagine
		into :ls_nome_immagine
		from articolo
		where id_articolo=:al_id_articolo
		;
		
	end if
	dw_3.setitem(al_riga, "nome_immagine"	,ls_nome_immagine)
end if

	
			
end subroutine

public subroutine wf_metti_sog_commerciale (long al_riga);//if il_id_sog>0 then
//	dw_3.setitem(al_riga, "id_sog_commerciale", il_id_sog)
//end if
end subroutine

public subroutine wf_stampa_da_selezione (s_st_cat_immediato ast_cat);//long ll_righe, i,ll_riga_inserita
//
//dw_1.trigger event itemchanged(1, dw_1.object.id_sog_commerciale, string(ast_cat.id_sog_commerciale[1]))
//dw_1.setitem(1, "id_sog_commerciale", ast_cat.id_sog_commerciale[1])
//
//ll_righe=upperbound(ast_cat.id_articolo)
//for i=1 to ll_righe
//	ll_riga_inserita=dw_3.INSERTROW(0)
//	dw_3.setitem(ll_riga_inserita, "id_sog_commerciale",ast_cat.id_sog_commerciale[1])
//	
//	dw_3.trigger event itemchanged(ll_riga_inserita, dw_3.object.cod_articolo, ast_cat.cod_articolo[i]) 
//
//	
//	
//next
end subroutine

public subroutine wf_trova_um (long al_id_art, long al_riga);string ls_tipo_um


ls_tipo_um=dw_3.getitemstring(al_riga, "tipo_um")
if isnull(ls_tipo_um) or ls_tipo_um<=" " then
	select m.tipo
	into :ls_tipo_um
	from articolo a, unita_confezione u, unita_misura m
	where a.id_articolo=:al_id_art
	and a.id_articolo=u.id_articolo and u.unita_base='S'
	and u.id_unita_misura=m.id_unita_misura;
	if sqlca.sqlcode=0 then
		dw_3.setitem(al_riga, "tipo_um", ls_tipo_um)
	end if
end if
end subroutine

public function integer wf_trova_ris (string as_h_v, string as_nome_imm);//integer li_res
//ole_imm.object.printsize=6
//ole_imm.object.delimage=true
//ole_imm.object.loadimage=as_nome_imm
//if as_h_v ='V' then
//	li_res=ole_imm.object.imageYDpi
//else
//	li_res=ole_imm.object.imageXDpi
//end if
//
return 0
end function

public function string wf_des_lunga (long al_id_art);string ls_des

select descrizione
into :ls_des
from dba.articolo
where id_articolo=:al_id_art
;
if ls_des> " " then
	return ls_des
else
	return "-1"
end if
	
end function

public function string wf_path_categoria (long al_id_art);string ls_return, ls_cat, ls_cat_padre, ls_cat_nonno
long ll_id_cat_sup, ll_cat_nonno

select m.descrizione, m.id_cat_mer_superiore
into :ls_cat, :ll_id_cat_sup
from dba.articolo a, dba.cat_merceologica m
where m.id_cat_merceologica=a.id_cat_merceologica
and id_articolo=:al_id_art;

if ls_cat> " " then
	if ll_id_cat_sup> 0 then
		select descrizione, id_cat_mer_superiore
		into :ls_cat_padre, :ll_cat_nonno
		from dba.cat_merceologica
		where id_cat_merceologica=:ll_id_cat_sup
		;
		if isnull(ls_cat_padre) then ls_cat_padre=""
		if ll_cat_nonno> 0 then
			select descrizione
			into :ls_cat_nonno
			from dba.cat_merceologica
			where id_cat_merceologica=:ll_cat_nonno
			;
		end if
		if isnull(ls_cat_nonno) then ls_cat_nonno=""	
	end if
	ls_return=ls_cat_nonno
	if ls_cat_nonno> " " then ls_return+=">"
	ls_return+=ls_cat_padre
	if ls_cat_padre> " " then ls_return+=">"
	ls_return+=ls_cat
	return ls_return
else
	return "-1"
end if
end function

public subroutine wf_addmsg (string as_msg);lb_msgbox.InsertItem(as_msg,1)

Yield()

lb_msgbox.SetRedraw(True)

end subroutine

public function string wf_copia_imm_in_sito (string as_path_file[]);string ls_directory, ls_remotefile, ls_solo_file[], ls_errmsg, ls_dir, ls_art_correlati, ls_file_correlato, ls_path_file_correlato
integer li_pos, i, li_pos_ok, li_path, a
boolean lb_result

//connessione e copia del file nel sito foma
lb_result = gn_ftp.of_Ftp_InternetConnect("ftp.labellasrl.it", "6319200@aruba.it", "Pippo2018",  0, true)
If lb_result = False Then
	ls_errmsg = "Connect Error " + String(gn_ftp.LastErrorNbr)+" Errore Connessione"
	//gw_frame.wf_addmsg(ls_errmsg + ": " + gn_ftp.LastErrorMsg)
	MessageBox(ls_errmsg, gn_ftp.LastErrorMsg, StopSign!)
End If

//ls_directory="/public_html/uploads/"
ls_directory="/www.labellasrl.it/uploads/"

If Not gn_ftp.of_ftp_SetCurrentDirectory(ls_directory) Then
	MessageBox("SetCurrentDirectory Error " + String(gn_ftp.LastErrorNbr) +" Errore SET directory", gn_ftp.LastErrorMsg, StopSign!)
End If
gn_ftp.of_Ftp_GetCurrentDirectory(ls_dir)
//MessageBox(ls_dir, ls_dir, StopSign!)
li_pos=1
for i = 1 to upperbound(as_path_file)
	li_pos=pos(as_path_file[i], "\", li_pos+1)
	do while li_pos>0
		li_pos_ok=li_pos
		li_pos=pos(as_path_file[i], "\", li_pos+1)
	loop
	ls_solo_file[i]=right(as_path_file[i], len(as_path_file[i]) - li_pos_ok)
	ls_remotefile=ls_directory+ls_solo_file[i]
	
	If Not gn_ftp.of_Ftp_WriteFile(as_path_file[i], ls_remotefile, Handle(gw_frame), 1025) Then
		gw_frame.wf_addmsg(gn_ftp.LastErrorMsg)
		MessageBox("WriteFile Error " + String(gn_ftp.LastErrorNbr)+" errore scrittura file csv", gn_ftp.LastErrorMsg, StopSign!)
		//Return ls_solo_file
	End If
	li_path=len(as_path_file[i]) -  len(ls_solo_file[i]) 
	ls_art_correlati=wf_agg_art_correlati(ls_solo_file[i], left(as_path_file[i] , li_path))
	if ls_art_correlati> " " then
		ls_path_file_correlato=left(as_path_file[i], len(as_path_file[i]) - len(ls_solo_file[i]))
		li_pos=2
		a=2
		li_pos=pos(ls_art_correlati, ",", li_pos)
		do while li_pos>0 
			ls_file_correlato=""
			ls_file_correlato=mid(ls_art_correlati, a, li_pos - a)
			ls_remotefile=ls_directory+ls_file_correlato
			If Not gn_ftp.of_Ftp_WriteFile(ls_path_file_correlato+ls_file_correlato, ls_remotefile, Handle(gw_frame), 1025) Then
				gw_frame.wf_addmsg(gn_ftp.LastErrorMsg)
				MessageBox("WriteFile Error " + String(gn_ftp.LastErrorNbr), gn_ftp.LastErrorMsg, StopSign!)
			End If
			
			li_pos++
			a=li_pos
			li_pos=pos(ls_art_correlati, ",",li_pos)
		loop
		if a< len(ls_art_correlati) then
			ls_file_correlato=mid(ls_art_correlati, a, 1000)
			ls_remotefile=ls_directory+ls_file_correlato
			If Not gn_ftp.of_Ftp_WriteFile(ls_path_file_correlato+ls_file_correlato, ls_remotefile, Handle(gw_frame), 1025) Then
				gw_frame.wf_addmsg(gn_ftp.LastErrorMsg)
				MessageBox("WriteFile Error " + String(gn_ftp.LastErrorNbr), gn_ftp.LastErrorMsg, StopSign!)
			End If
		end if
		
		
	end if
next
return "OK"
end function

public function string wf_agg_art_correlati (string as_nome_imm, string as_path_imm);nvo_file_list lstr_parms
integer i, li_len, li_inizio, li_pos
string ls_return=""


li_inizio=len(as_path_imm)+1
lstr_parms=f_leggi_files(as_path_imm, false)
for i=1 to upperbound(lstr_parms.as_file)
	li_len=len(as_nome_imm)
	if upper(mid(lstr_parms.as_file[i], li_inizio,li_len - 4))=upper(left(as_nome_imm, len(as_nome_imm) - 4)) then
		li_pos=pos(lstr_parms.as_file[i], "_")
		if li_pos> 0 then
			ls_return+=","+"http://labella.sottolinea.com/uploads/"+mid(lstr_parms.as_file[i], li_inizio, 1000)
		end if
	end if
next

return ls_return
end function

public function string wf_rec_h_p (long al_id_art);string ls_ret
decimal ldc_altezza, ldc_spessore

select qta_minima, dim_p
into :ldc_altezza, :ldc_spessore
from unita_confezione
where unita_base='S'
and id_articolo=:al_id_art
;
if ldc_altezza>0 then 
	ls_ret=string(ldc_altezza, "#,0.00")+ " mm;"
else
	ls_ret=";"
end if
if ldc_spessore>0 then
	ls_ret+=string(ldc_spessore, "#,0.00")+ " mm;"
else
	ls_ret+=";"
end if

return ls_ret
end function

on w_catalogo_2018_cx.create
int iCurrent
call super::create
this.cb_salva=create cb_salva
this.cb_nuovo=create cb_nuovo
this.cb_cancella=create cb_cancella
this.cb_esci=create cb_esci
this.cb_ordina=create cb_ordina
this.cb_seleziona=create cb_seleziona
this.cb_azzera=create cb_azzera
this.dw_3=create dw_3
this.st_2=create st_2
this.cb_foto2=create cb_foto2
this.dw_4=create dw_4
this.cb_2=create cb_2
this.cbx_vedi_foto=create cbx_vedi_foto
this.rb_3=create rb_3
this.rb_2=create rb_2
this.ddlb_dec_prezzo=create ddlb_dec_prezzo
this.p_1=create p_1
this.dw_8=create dw_8
this.cb_cat_ins=create cb_cat_ins
this.cb_cat_canc=create cb_cat_canc
this.cb_1=create cb_1
this.sle_1=create sle_1
this.cb_3=create cb_3
this.lb_msgbox=create lb_msgbox
this.uo_remote=create uo_remote
this.uo_local=create uo_local
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva
this.Control[iCurrent+2]=this.cb_nuovo
this.Control[iCurrent+3]=this.cb_cancella
this.Control[iCurrent+4]=this.cb_esci
this.Control[iCurrent+5]=this.cb_ordina
this.Control[iCurrent+6]=this.cb_seleziona
this.Control[iCurrent+7]=this.cb_azzera
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.cb_foto2
this.Control[iCurrent+11]=this.dw_4
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.cbx_vedi_foto
this.Control[iCurrent+14]=this.rb_3
this.Control[iCurrent+15]=this.rb_2
this.Control[iCurrent+16]=this.ddlb_dec_prezzo
this.Control[iCurrent+17]=this.p_1
this.Control[iCurrent+18]=this.dw_8
this.Control[iCurrent+19]=this.cb_cat_ins
this.Control[iCurrent+20]=this.cb_cat_canc
this.Control[iCurrent+21]=this.cb_1
this.Control[iCurrent+22]=this.sle_1
this.Control[iCurrent+23]=this.cb_3
this.Control[iCurrent+24]=this.lb_msgbox
this.Control[iCurrent+25]=this.uo_remote
this.Control[iCurrent+26]=this.uo_local
this.Control[iCurrent+27]=this.cb_4
this.Control[iCurrent+28]=this.cb_5
this.Control[iCurrent+29]=this.cb_6
end on

on w_catalogo_2018_cx.destroy
call super::destroy
destroy(this.cb_salva)
destroy(this.cb_nuovo)
destroy(this.cb_cancella)
destroy(this.cb_esci)
destroy(this.cb_ordina)
destroy(this.cb_seleziona)
destroy(this.cb_azzera)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.cb_foto2)
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.cbx_vedi_foto)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.ddlb_dec_prezzo)
destroy(this.p_1)
destroy(this.dw_8)
destroy(this.cb_cat_ins)
destroy(this.cb_cat_canc)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.cb_3)
destroy(this.lb_msgbox)
destroy(this.uo_remote)
destroy(this.uo_local)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
end on

event open;integer li_ret
SETREDRAW(FALSE)

//dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
//dw_1.insertrow(1)
dw_4.insertrow(1)

ddlb_dec_prezzo.text="2"
//dw_5.settransobject(sqlca)
//dw_5.insertrow(1)

datawindowchild ldwc_sog_commerciale, ldw_listino
dw_3.getchild("id_sog_commerciale", ldwc_sog_commerciale)
ldwc_sog_commerciale.settransobject(sqlca)
ldwc_sog_commerciale.retrieve()
dw_3.getchild("listino", ldw_listino)
ldw_listino.settransobject(sqlca)
ldw_listino.retrieve()
//dw_7.settransobject(sqlca)
//dw_7.retrieve()
dw_8.settransobject(sqlca)
dw_8.retrieve()
post wf_post_open()


end event

event closequery;if isvalid(w_mostra_imm_ocx) then
	close(w_mostra_imm_ocx)
end if
end event

type st_1 from w_001`st_1 within w_catalogo_2018_cx
end type

type cb_salva from commandbutton within w_catalogo_2018_cx
integer x = 4608
integer y = 1836
integer width = 434
integer height = 108
integer taborder = 230
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Cat."
end type

event clicked;integer li_ret

li_ret=dw_8.update()
if li_ret=1 then
	COMMIT;
ELSE
	rollback;
end if
end event

type cb_nuovo from commandbutton within w_catalogo_2018_cx
integer x = 32
integer y = 1160
integer width = 242
integer height = 100
integer taborder = 320
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
			wf_metti_sog_commerciale(ll_riga)

			dw_3.post setfocus()
			dw_3.post setcolumn("cod_articolo")
	dw_3.scrolltorow(ll_riga)
end event

type cb_cancella from commandbutton within w_catalogo_2018_cx
integer x = 297
integer y = 1160
integer width = 242
integer height = 100
integer taborder = 10
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

type cb_esci from commandbutton within w_catalogo_2018_cx
integer x = 4763
integer y = 1156
integer width = 242
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;close(parent)
end event

type cb_ordina from commandbutton within w_catalogo_2018_cx
integer x = 859
integer y = 1160
integer width = 242
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordina"
end type

event clicked;string ls_null
setnull(ls_null)
dw_3.setsort(ls_null)
dw_3.sort()
end event

type cb_seleziona from commandbutton within w_catalogo_2018_cx
integer x = 1152
integer y = 1156
integer width = 325
integer height = 100
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona"
end type

event clicked;s_dw_ritorna st_p
long ll_righe, ll_riga_partenza, i,ll_riga_inserita
string ls_Cod_articolo
decimal ldc_qta
 
openwithparm(w_auto_aggiunta_cx, 0)
	
st_p=message.powerobjectparm
	
if isvalid(st_p) then
	ll_riga_partenza=dw_3.rowcount()+1
	if ll_riga_partenza<=0 then ll_riga_partenza=1
	ll_righe=st_p.ds.rowcount()
	for i= 1 to ll_righe
		ll_riga_inserita=dw_3.INSERTROW(0)
		ls_Cod_articolo=st_p.ds.getitemstring(i, "articolo_codice")
		ldc_qta=st_p.ds.getitemdecimal(i, "qta")
		dw_3.setitem(ll_riga_inserita, "id_sog_commerciale",il_id_sog)
		if ldc_qta>0 then
			dw_3.setitem(ll_riga_inserita, "qta",ldc_qta)
		end if
//		li_da_rec_catalogo=0
		dw_3.trigger event itemchanged(ll_riga_inserita, dw_3.object.cod_articolo, ls_Cod_articolo) 
		
	next
end if
	
end event

type cb_azzera from commandbutton within w_catalogo_2018_cx
integer x = 562
integer y = 1160
integer width = 242
integer height = 100
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ripulisci"
end type

event clicked;if messagebox("Attenzione!", "Procedere a ripulire la lista attuale?", stopsign!, yesno!)&
			=1 then
		dw_3.reset()
	end if

end event

type dw_3 from u_dw_figlio within w_catalogo_2018_cx
integer x = 23
integer y = 16
integer width = 5001
integer height = 1128
integer taborder = 80
string dataobject = "d_foto_art_new_doc"
boolean vscrollbar = true
end type

event rowfocuschanging;
end event

event getfocus;call super::getfocus;adw=this
end event

event itemchanged;st_ass_art_sottoclasse st_associa
long ll_riga_esistente
string ls_tipo_um
decimal ldc_peso_lordo

choose case DWO.NAME
	case "num_riga"
		ll_riga_esistente=dw_3.find(string(dwo.name)+"="+data,1, dw_3.rowcount())
		if ll_riga_esistente>0 then
			messagebox("Attenzione!", "Anche la riga "+ string(ll_riga_esistente)+ &
							" è numerata: "+data+". Valore rifiutato!")
			return 1				
		end if
	case 'cod_articolo' 
		
			select a.id_articolo, a.codice, a.descrizione, m.tipo, u.peso_lordo
			into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo, :ls_tipo_um, :ldc_peso_lordo
			from articolo a, unita_confezione u, unita_misura m
			where a.codice=:data
			and a.id_articolo=u.id_articolo and u.unita_base='S'
			and u.id_unita_misura=m.id_unita_misura;
			if sqlca.sqlcode=0 then
				setitem(row, "id_articolo", st_associa.id_articolo)
				setitem(row, "cod_articolo", st_associa.cod_articolo)
				setitem(row, "des_articolo", st_associa.des_articolo)
				setitem(row, "tipo_um", ls_tipo_um)
				setitem(row, "peso_lordo", ldc_peso_lordo)
				st_associa.id_sog_commerciale=DW_3.GETITEMNUMBER(ROW, "ID_SOG_COMMERCIALE")
							
				post wf_trova_lung_peso(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
				post wf_trova_prezzo(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
				post wf_trova_immagine(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
					
			else
				post wf_ricerca(row, data)
		end if

	
			
		
		
	case "id_sog_commerciale"
		st_associa.id_articolo=getitemnumber(row, "id_articolo")
		if st_associa.id_articolo>0 then
			st_associa.id_sog_commerciale=long(data)
			post wf_trova_lung_peso(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
			post wf_trova_prezzo(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
			post wf_trova_immagine(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
		end if	
		
	case "lunghezza"
		st_associa.id_articolo=getitemnumber(row, "id_articolo")
		if st_associa.id_articolo>0 then
			st_associa.id_sog_commerciale=DW_3.GETITEMNUMBER(ROW, "ID_SOG_COMMERCIALE")
			post wf_trova_lung_peso(st_associa.id_articolo, st_associa.id_sog_commerciale, row)
		end if
end choose
end event

event rowfocuschanged;string ls_imm
setrowfocusindicator(hand!)

if currentrow>0 and cbx_vedi_foto.checked then
	ls_imm=getitemstring(currentrow, "nome_immagine")
	if ls_imm>"" then
		if isvalid(w_mostra_imm_ocx) then
			w_mostra_imm_ocx.wf_mostra(ls_imm)
		else
			openwithparm(w_mostra_imm_ocx, ls_imm, "w_mostra_imm_ocx", parent)
		end if
	end if
end if

end event

event clicked;string ls_codice, ls_intestatario

accepttext()
if row>0 then
	if string(dwo.name)= "cod_articolo_sw"  then
		ls_codice=dw_3.getitemstring(row, "cod_articolo")
		wf_ricerca( row, ls_codice)
	end if
end if
end event

event ue_key;//choose case key
//	case KeyS!, keyf12!
//		if keyflags=2 then
//			cb_salva.triggerevent(clicked!)
//		end if
//	case Keydownarrow!
//		if getrow()=rowcount()and keyflags=2 then
//			cb_salva.triggerevent(clicked!)
//		end if
//	case KeyAdd!
//		if keyflags=2 then
//			cb_nuovo.triggerevent(clicked!)
//		end if
//	case KeyDelete!,KeySubtract!
//		if keyflags=2 then
//			cb_cancella.triggerevent(clicked!)
//		end if
//	case KeyPrintScreen!
//		cb_stampa.triggerevent(clicked!)
//	case KeyP!
//		if keyflags=2 then
//			cb_stampa.triggerevent(clicked!)
//		end if
//	case KeyX!
//		if keyflags=2 then
//			cb_ESCI.triggerevent(clicked!)
//		end if
//	case keyenter!
//		cb_nuovo.triggerevent(clicked!)
//	case keytab! 
//		if getcolumn()=6 then
//			cb_nuovo.triggerevent(clicked!)
//		end if
//end choose
//
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

type st_2 from statictext within w_catalogo_2018_cx
integer x = 1888
integer y = 1160
integer width = 320
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
boolean enabled = false
string text = "Dec. Prezzo:"
boolean focusrectangle = false
end type

type cb_foto2 from commandbutton within w_catalogo_2018_cx
integer x = 4119
integer y = 1156
integer width = 421
integer height = 108
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostra"
end type

event clicked;s_ds_per_foto s_foto
integer li_test, li_riga_scelta

s_foto.w_padre_2018=parent
s_foto.ds_dati_doc=create datastore
dw_4.accepttext()

li_riga_scelta=dw_8.find("c_scegli=1", 1, dw_8.rowcount())
if li_riga_scelta> 0 then
	s_foto.dw=dw_8.getitemstring(li_riga_scelta,"dw")
	s_foto.ds_dati_doc.dataobject=s_foto.dw
	s_foto.ds_dati_doc.settransobject(sqlca)
	
	dw_3.setfilter("c_scegli='S'")
	dw_3.filter()
	li_test=dw_3.rowscopy(1, dw_3.rowcount(), primary!, s_foto.ds_dati_doc, 1, primary!)
	setredraw(false)
	//if cbx_non_girare.checked then s_foto.ruota="S"
	//dw_7.accepttext()
	
	//s_foto.li_x_foto=dw_7.getitemnumber(1, "x_foto")
	//s_foto.li_y_foto=dw_7.getitemnumber(1, "y_foto")
	//s_foto.scala=dec(sle_scala.text)
	
	s_foto.li_x_foto=dw_8.getitemnumber(li_riga_scelta, "x_foto")
	s_foto.li_y_foto=dw_8.getitemnumber(li_riga_scelta, "y_foto")
	s_foto.h_foto=dw_8.getitemnumber(li_riga_scelta, "h_foto")
	s_foto.w_foto=dw_8.getitemnumber(li_riga_scelta, "w_foto")
	
	s_foto.LI_max_larghezza=s_foto.w_foto
	s_foto.LI_max_altezza=s_foto.h_foto	
	
	s_foto.ret_spes=dw_8.getitemnumber(li_riga_scelta, "rettangolo_spessore")
	s_foto.ret_colore=dw_8.getitemstring(li_riga_scelta, "rettangolo_colore")
	s_foto.linea_sep_spes=dw_8.getitemnumber(li_riga_scelta, "linea_sep_spessore")
	s_foto.linea_sep_colore=dw_8.getitemstring(li_riga_scelta, "linea_sep_colore")
	s_foto.pag_di_partenza=dw_4.getitemnumber(1, "inizia_da_pag")
	s_foto.testo=dw_4.getitemstring(1, "testo_alto_sx")
	s_foto.t_x=dw_4.getitemnumber(1, "t_x")
	s_foto.t_y=dw_4.getitemnumber(1, "t_y")
	s_foto.t_width=dw_4.getitemnumber(1, "t_width")
	openwithparm(w_cat_2018_rpt, s_foto)
	
	dw_3.setfilter("")
	dw_3.filter()
	dw_3.setsort("c_scegli desc, cod_articolo")
	dw_3.sort()
	setredraw(true)
else
	messagebox("Attenzione!", "Non hai scelto alcun catalogo!")
end if
end event

type dw_4 from u_dw_base within w_catalogo_2018_cx
integer x = 64
integer y = 1288
integer width = 1902
integer height = 196
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_cat_parti_da_pagina"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_2 from commandbutton within w_catalogo_2018_cx
integer x = 4608
integer y = 1988
integer width = 434
integer height = 108
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Righe"
end type

event clicked;	integer i,li_ret, c
	long ll_id_lista, ll_id_art, ll_test, li_riga_scelta
	string ls_codice_lista
	datastore ds_lista_figlio, ds_lista
	decimal ldc_qta
	
	dw_3.accepttext()
	ds_lista_figlio=create datastore
	ds_lista_figlio.dataobject="d_new_cat_immediato_righe"
	ds_lista_figlio.settransobject(sqlca)
	
li_riga_scelta=dw_8.find("c_scegli=1", 1, dw_8.rowcount())
if li_riga_scelta> 0 then
	ls_codice_lista=dw_8.getitemstring(li_riga_scelta, "codice")
	
	if ls_codice_lista>" " then
		select id_cat_immediato
		into :ll_test
		from cat_immediato
		where codice=:ls_codice_lista;
		if ll_test>0 then
			li_ret=messagebox("Attenzione!", "Codice Catalogo già esistente!"+&
			" Se vuoi sovrascriverlo scegli 'Sì', altrimenti 'No' e cambia il codice al Catalogo", stopsign!, yesno!)
			if li_ret= 1 then 
				ll_id_lista=ll_test
			ds_lista_figlio.retrieve(ll_id_lista)
				ds_lista_figlio.rowsmove(1, ds_lista_figlio.rowcount(), &
												primary!, ds_lista_figlio, 1, delete!)
				if ds_lista_figlio.update()=1 then
					commit;
				else
					rollback;
					messagebox("Errore!", "Cat. non salvato 29")
				end if	
//				delete from dba.cat_immediato
//				where id_cat_immediato=:ll_id_lista;
//				if sqlca.sqlcode= -1 then
//					rollback;
//					messagebox("Errore!", "Cat. non salvato 21")
//					return
//				else
//					commit;
//				end if
			else
				return
			end if
		else
			ds_lista=create datastore
			ds_lista.dataobject="d_cat_immediato"
			ds_lista.settransobject(sqlca)
				
			ds_lista.insertrow(1)
			ds_lista.setitem(1, "codice", ls_codice_lista)
			if ds_lista.update()=1 then
				commit;
				select @@identity 
				INTO :ll_id_lista
				from dba.cat_immediato;
			else
				rollback;
				messagebox("Errore!", "Catalogo non salvato 33")
				return
			end if
		end if
		ds_lista_figlio.reset()
		
		
		IF ll_id_lista> 0 THEN
			dw_3.setfilter("c_scegli='S'")
			dw_3.filter()
			for i= 1 to dw_3.rowcount()
				ds_lista_figlio.insertrow(0)
				ds_lista_figlio.setitem(i, "id_cat_immediato", ll_id_lista)
				//la d_cat_immediato_righe della ds_lista_figlio ha un campo in più
				//che è il primo, ovvero il proprio id ecco perché il c+1
				for c=1 to 20
					ds_lista_figlio.object.data[i, c+1, i, c+1]=dw_3.object.data[i,c,i,c]
				next
			next
			if ds_lista_figlio.update()=1 then
				commit;
				messagebox("OK!", "Lista Salvata!")
			else
				rollback;
				messagebox("Errore!", "Lista non salvata 82")
			end if
		ELSE
			messagebox("Errore!", "Lista non salvata 61")	
		END IF
		destroy ds_lista
		destroy ds_lista_figlio
		dw_3.setfilter("")
		dw_3.filter()
	
		dw_3.sort()
		

	else
		messagebox("Attenzione!", "Inserire il nome della lista da salvare!")
	end if
	//forse ricarico i cataloghi
	dw_8.retrieve()
else
	messagebox("Attenzione!", "Non hai scelto alcun catalogo!")
end if
//	datawindowchild ldwc_catalogo
//	
//	dw_5.getchild("id_cat_immediato", ldwc_catalogo)
//	ldwc_catalogo.settransobject(sqlca)
//	ldwc_catalogo.retrieve()
	
end event

type cbx_vedi_foto from checkbox within w_catalogo_2018_cx
integer x = 3607
integer y = 1180
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Vedi Foto"
boolean lefttext = true
end type

type rb_3 from radiobutton within w_catalogo_2018_cx
integer x = 3136
integer y = 1172
integer width = 389
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Pulisci tutto"
boolean lefttext = true
end type

event clicked;integer i, li_limite



for i= 1 to dw_3.rowcount()
	dw_3.setitem(i, "c_scegli", 'N')
next

end event

type rb_2 from radiobutton within w_catalogo_2018_cx
integer x = 2720
integer y = 1172
integer width = 366
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Scegli tutto"
boolean lefttext = true
end type

event clicked;integer i, li_limite



	//li_limite=integer(sle_limite.text)
	if isnull(li_limite) or li_limite<=0 or li_limite > dw_3.rowcount() then
		li_limite=dw_3.rowcount()
	end if
	for i= 1 to li_limite
		dw_3.setitem(i, "c_scegli", 'S')
	next


end event

type ddlb_dec_prezzo from dropdownlistbox within w_catalogo_2018_cx
integer x = 2222
integer y = 1160
integer width = 261
integer height = 228
integer taborder = 300
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"0","1","2","3","4","5","6"}
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_catalogo_2018_cx
boolean visible = false
integer x = 1701
integer y = 1696
integer width = 320
integer height = 168
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_8 from udw_001 within w_catalogo_2018_cx
integer x = 64
integer y = 1512
integer width = 4507
integer height = 840
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_cat_immediato"
end type

event getfocus;call super::getfocus;adw=this
end event

event clicked;call super::clicked;integer i
string ls_rag, ls_art
long ll_id_cat, ll_riga, ll_id_sog, ll_id_art
datastore ds_lista_figlio

if dwo.name='c_scegli' then
	
	for i= 1 to rowcount()
		if i<>row then setitem(i, "c_scegli", 0)
	next
	if dw_3.rowcount()>0 then
		if messagebox("Attenzione!", "Cancellare le righe presenti e caricare il catalogo scelto?", &
		stopsign!, yesno!)=2 then return
	end if
	dw_3.reset()
	
	ll_id_cat=getitemnumber(row, "id_cat_immediato")
	
	ds_lista_figlio=create datastore
	ds_lista_figlio.dataobject="d_new_cat_immediato_righe"
	ds_lista_figlio.settransobject(sqlca)
	ds_lista_figlio.retrieve(ll_id_cat)
	
	for i= 1 to ds_lista_figlio.rowcount()
		ll_riga=dw_3.insertrow(0)
		dw_3.object.data[i,1,i,20]=ds_lista_figlio.object.data[i, 2, i, 21]
		ls_art=dw_3.getitemstring(ll_riga, "cod_articolo")
	//	li_da_rec_catalogo=100
		ll_id_sog=DW_3.GETITEMNUMBER(ll_riga, "ID_SOG_COMMERCIALE")
		ll_id_art=DW_3.GETITEMNUMBER(ll_riga, "ID_articolo")
		wf_trova_immagine(ll_id_art, ll_id_sog, ll_riga)
		wf_trova_um(ll_id_art, ll_riga)
		//dw_3.post event itemchanged(ll_riga, dw_3.object.cod_articolo, ls_art)
	//	post wf_azzera_variabile()
	//	for c=1 to 16
	//		ds_lista_figlio.object.data[i, c+1, i, c+1]=dw_3.object.data[i,c,i,c]
	//	next
	next
	destroy(ds_lista_figlio)
	dw_3.sort()
end if
end event

type cb_cat_ins from commandbutton within w_catalogo_2018_cx
integer x = 4608
integer y = 1544
integer width = 434
integer height = 108
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci Catalogo"
end type

event clicked;long ll_riga
ll_riga=dw_8.INSERTROW(0)
			

dw_8.post setfocus()
dw_8.post setcolumn("codice")
dw_8.scrolltorow(ll_riga)
end event

type cb_cat_canc from commandbutton within w_catalogo_2018_cx
integer x = 4608
integer y = 1688
integer width = 434
integer height = 108
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella Catalogo"
end type

event clicked;long ll_riga

ll_riga=dw_8.getrow()
if ll_riga>0 then
	if messagebox("Attenzione!", "Si conferma la cancellazione della riga?", stopsign!, yesno!)=1 then
		dw_8.deleterow(ll_riga)
	end if
end if
end event

type cb_1 from commandbutton within w_catalogo_2018_cx
boolean visible = false
integer x = 1440
integer y = 1364
integer width = 1125
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Apri pag. html con browser predefinito"
end type

event clicked;string ls_url
inet iinet_base

ls_url = sle_1.text
if isnull(ls_url) or ls_url< " "then ls_url="http://www.nonviolenza.com"
GetContextService("Internet", iinet_base)
iinet_base.HyperlinkToURL(ls_url)
end event

type sle_1 from singlelineedit within w_catalogo_2018_cx
boolean visible = false
integer x = 3145
integer y = 1368
integer width = 850
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "http://www.nonviolenza.com"
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_catalogo_2018_cx
integer x = 4608
integer y = 1380
integer width = 434
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Prepara File"
end type

event clicked;integer i, li_FileNum, li_test
string ls_file, ls_file_nome, ls_nome_imm, ls_path, ls_imm_file[], ls_ret, ls_path_imm,ls_cod_art
string ls_art_correlati
long ll_id_art
decimal ldc_prezzo, ldc_lunghezza, ldc_larghezza, ldc_peso


select path_imm_web
into :ls_path_imm
from dba.orafo_par_sistema
;
if isnull(ls_path) or ls_path="" then ls_path="c:\nita\fotoWEB"

//select dir_immagini
//into :ls_path_imm
//from dba.par_sistema
//;
if right(ls_path_imm, 1)<>"\" then ls_path_imm+="\"

ls_file='Product Title;SKU;Price;Category Path;Description;Short Description;lunghezza;larghezza;peso;altezza;spessore;img url'+"~r~n"
for i= 1 to dw_3.rowcount()
	if dw_3.getitemstring(i, "c_scegli")='S' then
		ll_id_art=dw_3.getitemnumber(i, "id_articolo")
		ls_cod_art=	dw_3.getitemstring(i, "cod_articolo")
		ls_file+=ls_cod_art +";"
		ls_file+= string(ll_id_art, "#0")+";"
		ldc_prezzo=dw_3.getitemdecimal(i, "prezzo")
		if ldc_prezzo>0 then
			ls_file+= string(ldc_prezzo, "#,0.000")+";"
		else
			ls_file+=";"
		end if
		//ls_file+= "Bracciali"+";"
		ls_ret=wf_path_categoria(ll_id_art)
		if ls_ret="-1" then
			if messagebox("Attenzione!", "Articolo: "+ls_cod_art+" NON ha assegnata alcuna categoria Merceologica! Vuoi andare avanti lo stesso (sarà assegnata categoria='BRACCIALI'", stopsign!, yesno!)<>1 then return
			ls_file+="BRACCIALI"+";"
		else
			ls_file+=ls_ret+";"//category path
		end if
		
		ls_file+= wf_des_lunga(ll_id_art)+";"    // descrizione lunga
		ls_file+= dw_3.getitemstring(i, "des_articolo")+";"
		ldc_lunghezza= dw_3.getitemdecimal(i, "lunghezza")
		if ldc_lunghezza>0 then
			ls_file+=string(ldc_lunghezza, "#,0.00")+" cm;"
		else
			ls_file+=";"
		end if
		ldc_larghezza= dw_3.getitemdecimal(i, "larghezza")
		if ldc_larghezza>0 then
			ls_file+=string(ldc_larghezza, "#,0.00")+" mm;"
		else
			ls_file+=";"
		end if
		ldc_peso= dw_3.getitemdecimal(i, "peso_unitario")
		if ldc_peso>0 then
			ls_file+=string(ldc_peso, "#,0.00")+" g;"
		else
			ls_file+=";"
		end if
		//altezza e spessore
		ls_file+=wf_rec_h_p(ll_id_art)
		//fine altezza e spessore
		ls_nome_imm= dw_3.getitemstring(i, "nome_immagine")
		ls_imm_file[i]=ls_path_imm+ls_nome_imm
		ls_art_correlati=wf_agg_art_correlati(ls_nome_imm, ls_path_imm)
		//ls_file+=ls_nome_imm+ls_art_correlati+";"
		ls_file+="https://www.labellasrl.it/uploads/"+ls_nome_imm+ls_art_correlati //+";"
		ls_file+="~r~n"
		//ll_id_art=0
	end if
next

ls_file_nome=string(today(), "dd_mm_yyyy")
ls_file_nome=ls_path_imm+"\prodotti.csv"
li_FileNum = FileOpen(ls_file_nome, TextMode!, Write!, LockWrite!, Replace!, EncodingANSI! )
if li_FileNum= -1 then messagebox("Attenzione!", "Errore nell'apertura del file")
li_test=FileWriteEx(li_FileNum, ls_file)
if li_test<=0 then messagebox("Attenzione!", "Errore nella scrittura del file")
fileclose(li_FileNum)
ls_imm_file[upperbound(ls_imm_file)+1]=ls_file_nome
//copio le immagini nel sito e il file csv ...
open(w_attesa)
ls_ret=wf_copia_imm_in_sito(ls_imm_file)	
if ls_ret='OK' then
	messagebox("OK", "TUTTO A POSTO!")
else
	messagebox("AHI", "Qualcosa non va ...!")
end if
close(w_attesa)



end event

type lb_msgbox from listbox within w_catalogo_2018_cx
boolean visible = false
integer x = 946
integer y = 584
integer width = 480
integer height = 400
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_remote from u_panel_remote within w_catalogo_2018_cx
boolean visible = false
integer x = 526
integer y = 1208
integer taborder = 100
boolean bringtotop = true
end type

on uo_remote.destroy
call u_panel_remote::destroy
end on

type uo_local from u_panel_local within w_catalogo_2018_cx
boolean visible = false
integer x = 672
integer y = 1340
integer taborder = 310
boolean bringtotop = true
end type

on uo_local.destroy
call u_panel_local::destroy
end on

type cb_4 from commandbutton within w_catalogo_2018_cx
integer x = 3255
integer y = 1380
integer width = 731
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Assegna Categorie ad Articolo"
end type

event clicked;open(w_ins_cat_articolo)
end event

type cb_5 from commandbutton within w_catalogo_2018_cx
integer x = 4050
integer y = 1380
integer width = 457
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Categorie Articolo"
end type

event clicked;open(w_cat_merceologica_gd)
end event

type cb_6 from commandbutton within w_catalogo_2018_cx
integer x = 2555
integer y = 1380
integer width = 640
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Varia Misure Articolo"
end type

event clicked;open(w_varia_dati_uc_gd)
end event

