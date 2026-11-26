forward
global type w_st_foto_articolo_cx from w_001
end type
type cb_salva from commandbutton within w_st_foto_articolo_cx
end type
type cb_nuovo from commandbutton within w_st_foto_articolo_cx
end type
type cb_cancella from commandbutton within w_st_foto_articolo_cx
end type
type cb_esci from commandbutton within w_st_foto_articolo_cx
end type
type cb_ordina from commandbutton within w_st_foto_articolo_cx
end type
type dw_1 from udw_base within w_st_foto_articolo_cx
end type
type cb_preview from commandbutton within w_st_foto_articolo_cx
end type
type cb_st_testo from commandbutton within w_st_foto_articolo_cx
end type
type cbx_par_stampa from checkbox within w_st_foto_articolo_cx
end type
type cb_seleziona from commandbutton within w_st_foto_articolo_cx
end type
type cb_azzera from commandbutton within w_st_foto_articolo_cx
end type
type dw_3 from u_dw_figlio within w_st_foto_articolo_cx
end type
type st_2 from statictext within w_st_foto_articolo_cx
end type
type cb_stampa from commandbutton within w_st_foto_articolo_cx
end type
type cbx_solo_nuovi from checkbox within w_st_foto_articolo_cx
end type
type dw_2 from datawindow within w_st_foto_articolo_cx
end type
type cbx_1 from checkbox within w_st_foto_articolo_cx
end type
type ole_imm from olecustomcontrol within w_st_foto_articolo_cx
end type
type cb_foto2 from commandbutton within w_st_foto_articolo_cx
end type
type cbx_recupera_prezzo from checkbox within w_st_foto_articolo_cx
end type
type sle_lista_art from singlelineedit within w_st_foto_articolo_cx
end type
type cbx_3 from checkbox within w_st_foto_articolo_cx
end type
type cb_salva_lista from commandbutton within w_st_foto_articolo_cx
end type
type sle_limite from singlelineedit within w_st_foto_articolo_cx
end type
type cbx_qta from checkbox within w_st_foto_articolo_cx
end type
type dw_4 from u_dw_base within w_st_foto_articolo_cx
end type
type st_3 from statictext within w_st_foto_articolo_cx
end type
type cb_1 from commandbutton within w_st_foto_articolo_cx
end type
type dw_5 from udw_base within w_st_foto_articolo_cx
end type
type cb_2 from commandbutton within w_st_foto_articolo_cx
end type
type cbx_vedi_foto from checkbox within w_st_foto_articolo_cx
end type
type st_4 from statictext within w_st_foto_articolo_cx
end type
type rb_3 from radiobutton within w_st_foto_articolo_cx
end type
type rb_1 from radiobutton within w_st_foto_articolo_cx
end type
type rb_2 from radiobutton within w_st_foto_articolo_cx
end type
type cb_salva_art_cliente from commandbutton within w_st_foto_articolo_cx
end type
type ddlb_dec_prezzo from dropdownlistbox within w_st_foto_articolo_cx
end type
type cbx_mostra_cliente from checkbox within w_st_foto_articolo_cx
end type
type cbx_non_girare from checkbox within w_st_foto_articolo_cx
end type
type ddlb_traduci from dropdownlistbox within w_st_foto_articolo_cx
end type
type st_5 from statictext within w_st_foto_articolo_cx
end type
type cb_3 from commandbutton within w_st_foto_articolo_cx
end type
type p_1 from picture within w_st_foto_articolo_cx
end type
type dw_6 from udw_base within w_st_foto_articolo_cx
end type
type dw_7 from udw_base within w_st_foto_articolo_cx
end type
type sle_scala from singlelineedit within w_st_foto_articolo_cx
end type
type st_6 from statictext within w_st_foto_articolo_cx
end type
type st_7 from statictext within w_st_foto_articolo_cx
end type
end forward

global type w_st_foto_articolo_cx from w_001
integer x = 1057
integer y = 483
integer width = 5083
integer height = 2812
string title = "Catalogo Immediato"
windowtype windowtype = response!
cb_salva cb_salva
cb_nuovo cb_nuovo
cb_cancella cb_cancella
cb_esci cb_esci
cb_ordina cb_ordina
dw_1 dw_1
cb_preview cb_preview
cb_st_testo cb_st_testo
cbx_par_stampa cbx_par_stampa
cb_seleziona cb_seleziona
cb_azzera cb_azzera
dw_3 dw_3
st_2 st_2
cb_stampa cb_stampa
cbx_solo_nuovi cbx_solo_nuovi
dw_2 dw_2
cbx_1 cbx_1
ole_imm ole_imm
cb_foto2 cb_foto2
cbx_recupera_prezzo cbx_recupera_prezzo
sle_lista_art sle_lista_art
cbx_3 cbx_3
cb_salva_lista cb_salva_lista
sle_limite sle_limite
cbx_qta cbx_qta
dw_4 dw_4
st_3 st_3
cb_1 cb_1
dw_5 dw_5
cb_2 cb_2
cbx_vedi_foto cbx_vedi_foto
st_4 st_4
rb_3 rb_3
rb_1 rb_1
rb_2 rb_2
cb_salva_art_cliente cb_salva_art_cliente
ddlb_dec_prezzo ddlb_dec_prezzo
cbx_mostra_cliente cbx_mostra_cliente
cbx_non_girare cbx_non_girare
ddlb_traduci ddlb_traduci
st_5 st_5
cb_3 cb_3
p_1 p_1
dw_6 dw_6
dw_7 dw_7
sle_scala sle_scala
st_6 st_6
st_7 st_7
end type
global w_st_foto_articolo_cx w_st_foto_articolo_cx

type variables
datawindow adw
integer li_record
LONG IL_ID_SOG 


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

public subroutine wf_post_open ();
datastore ds_recupera
integer li_ret, i
string ls_class
long ll_righe
s_st_cat_immediato st_cat
	
if isvalid(message.powerobjectparm) then
	ls_class=message.powerobjectparm.classname()
	if ls_class="s_st_cat_immediato" then 
		st_cat=message.powerobjectparm
		wf_stampa_da_selezione(st_cat)
	elseif ls_class='s_list_main' then 
			
	else 
		ds_recupera=message.powerobjectparm
		ll_righe= ds_recupera.rowcount()
		if ll_righe>0 then
			wf_stampa_da_ordine(ds_recupera)
		end if
	end if
end if
SETREDRAW(TRUE)
cbx_non_girare.CHECKED=TRUE


end subroutine

public subroutine wf_stampa_foto (s_dati_foto s_foto[], long mydc, decimal adc_dpi_x, decimal adc_dpi_y);long ll_dpi_x, ll_dpi_y, ll_alt, ll_lar, ll_top, ll_left
string ls_path, ls_logo
integer i

for i=1 to upperbound(s_foto)
	if s_foto[i].nome_imm='NO' then continue
	ole_imm.object.loadimage=s_foto[i].nome_imm
	
	ole_imm.object.printtop=s_foto[i].top 
	ole_imm.object.printleft= s_foto[i].left
	ole_imm.object.printbottom=s_foto[i].bottom
	ole_imm.object.printright=s_foto[i].right
	
	
	ole_imm.object.printimage=	mydc				
	
next

select logo
into :ls_logo
from azienda
where id_azienda=1;

select dir_immagini
into :ls_path
from par_sistema;

if right(ls_path, 1)<>'\' then ls_path+='\'
if fileexists(ls_path+ls_logo) then
	ole_imm.object.loadimage=ls_path+ls_logo
	ll_dpi_x=ole_imm.object.imageXDpi
	ll_dpi_y=ole_imm.object.imageYDpi
	ll_alt=200
	ll_lar=600
	
	
	ll_top=25*adc_dpi_y 
	
	ll_left=750*adc_dpi_x
	

	ole_imm.object.printtop=ll_top
	ole_imm.object.printleft=ll_left
	ole_imm.object.printbottom=ll_top+ (ll_alt*adc_dpi_y)    
	ole_imm.object.printright=ll_left+ (ll_lar *adc_dpi_x)  
	
	ole_imm.object.printimage=	mydc				
else
	
end if

	
end subroutine

public subroutine wf_stampa_art_acq_cliente (u_dw_figlio adw_art_acq);integer i, li_righe
string ls_cod_articolo
li_righe=adw_art_acq.rowcount()

for i= 1 to li_righe
	dw_3.insertrow(i)
	ls_cod_articolo=adw_art_acq.getitemstring(i, "cod_articolo")
	dw_3.setitem(i, "cod_articolo",ls_cod_articolo)
next

dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.peso_t)
dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.lunghezza_t)
cb_stampa.postevent(clicked!)

	

end subroutine

public subroutine wf_stampa_da_ordine (datastore ds_recupera);integer li_ret, i
string ls_imm,ls_registro
long ll_righe, ll_di_art, ll_id_riga
SETREDRAW(FALSE)



dw_3.reset()

li_ret=ds_recupera.rowcount()
cbx_solo_nuovi.visible=true
li_ret=ds_recupera.rowscopy(1, li_ret, primary!, dw_3, 1, primary!)
if li_ret<>1 then messagebox("Errore!", "Righe non copiate!")

ll_righe=dw_3.rowcount()
if ll_righe>0 then
	il_id_sog=dw_3.getitemnumber(1, "id_sog_commerciale")
	dw_1.setitem(1, "id_sog_commerciale", il_id_sog)
end if

//seleziono i campi che sono da stampare normalmente (peso e prezzo oltre a codice art)
dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.peso_unitario_t)
//modifico su richiesta Lucio kati (unica ditta che lo usa) 110207 prima era .lunghezza_t
dw_3.trigger event doubleclicked(0,0, 1, dw_3.object.prezzo_t)

dw_3.sort()
ll_id_riga=dw_3.getitemnumber(1, "id_riga_documento")
select tipo_registro
into :ls_registro
from documento d, riga_documento rd, registro r
where d.id_documento=rd.id_documento
and rd.id_riga_documento=:ll_id_riga
and d.id_registro=r.id_registro
;
if ls_registro='OA' then
	dw_4.setitem(1,1, "d_ordine_fo")
else
	dw_4.setitem(1,1, "d_conferma_ordine_foto")
end if
rb_2.checked=true
rb_2.triggerevent(clicked!)
cb_foto2.triggerevent(clicked!)

SETREDRAW(TRUE)
end subroutine

public subroutine wf_stampa_testo (s_testo_cat as_text[], integer ai_larghezza, integer ai_altezza, long ai_job);
integer li_righe, i, li_incremento_y
string ls_cod_articolo, ls_descrizione, ls_listino
decimal{2} ldc_peso, ldc_lunghezza, ldc_prezzo
long ldc_qta, ll_id_variazione  

ai_larghezza*=3.94
ai_altezza*=3.94
PrintDefineFont(ai_job, 1, "Arial", -8, 400, Default!, AnyFont!, false, false) 
PrintDefineFont(ai_job, 2, "Arial", -8, 700, Default!, AnyFont!, false, false) 
PrintSetFont(ai_job, 1)

for i= 1 to upperbound(as_text)
	li_record++
	if as_text[i].s_num_riga = -1 then continue
	
	as_text[i].s_top*=3.94
	as_text[i].s_left*=3.94
	
	PrintRect(ai_job, as_text[i].s_left, as_text[i].s_top, ai_larghezza,ai_altezza, 5)
	
	ls_cod_articolo=dw_3.getitemstring(li_record, "cod_articolo")
	ldc_prezzo=dw_3.getitemdecimal(li_record, "prezzo")
	ldc_peso=dw_3.getitemdecimal(li_record, "peso_unitario")
	ldc_lunghezza=dw_3.getitemdecimal(li_record, "lunghezza")
	ls_descrizione=dw_3.getitemstring(li_record, "des_articolo")
	ldc_qta=dw_3.getitemnumber(li_record, "qta")
	ll_id_variazione=dw_3.getitemnumber(li_record, "listino")
	select lis_base
	into :ls_listino
	from variazione v, listino l
	where v.id_variazione=:ll_id_variazione
	and l.id_listino=v.id_listino
	;
	
	li_incremento_y=80
	printtext(ai_job, ls_cod_articolo, as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
	li_incremento_y+=200
	if dw_3.Describe("des_articolo_t.Color")='16777215' then
		printtext(ai_job, ls_descrizione, as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)	
		li_incremento_y+=200
	end if
	if dw_3.Describe("peso_unitario_t.Color")='16777215' then 
		printtext(ai_job, "g. "+string(ldc_peso), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
		li_incremento_y+=200
	end if
	if dw_3.Describe("lunghezza_t.Color")='16777215' then 
		printtext(ai_job, "CM. "+string(ldc_lunghezza), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
		li_incremento_y+=200
	end if
	if dw_3.Describe("qta_t.Color")='16777215' then 
		printtext(ai_job, "Pz. "+string(ldc_qta), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
		li_incremento_y+=200
	end if
	if ls_listino<>"S" then
		PrintSetFont(ai_job, 2)
	end if
	if dw_3.Describe("prezzo_t.Color")='16777215' then 
		printtext(ai_job, "€: "+string(ldc_prezzo), as_text[i].s_left+(18*3.94), as_text[i].s_top+li_incremento_y)
	end if
	if ls_listino<>"S" then
		PrintSetFont(ai_job, 1)
	end if
next



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
	select peso_lordo 
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

public function integer wf_trova_lung_peso (long ad_articolo, long ad_sog, long al_riga);decimal ld_dim, ld_peso_manuale,ld_dim_esistente, ld_peso_unitario, ld_test
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
	select u.dim_l, u.peso_netto
	into :ld_dim, :ld_peso_unitario
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
destroy(ds_orafo_lung_peso)
return 1

end function

public subroutine wf_trova_prezzo (long al_id_art, long al_id_sog, long al_riga);long ll_id_uc, ll_id_listino, ll_id_var,ll_id_um
decimal ld_prezzo_manifattura, ldc_prezzo_pz
string ls_pref_fornitore, ls_cod_soggetto, ls_cod_listino,ls_tipo_um




if cbx_recupera_prezzo.checked then
	
	
	if isnull(al_id_art) or al_id_art<=0 then return
	
	select id_unita_confezione, id_unita_misura
	into :ll_id_uc, :ll_id_um
	from unita_confezione
	where id_articolo=:al_id_art
	and unita_base='S'
	;
	if al_id_sog>0 then
		select id_listino, codice
		into :ll_id_listino, :ls_cod_soggetto
		from sog_commerciale
		where id_sog_commerciale=:al_id_sog;
	end if
	
	select pref_cod_fornitore
	into :ls_pref_fornitore
	from par_sistema;
	if isnull(ls_pref_fornitore) then
		messagebox("Attenzione!", "Specificare il prefisso dei fornitori in Parametri di Sistema")
	end if
	
	if left(ls_cod_soggetto, 2)=ls_pref_fornitore then
		ls_pref_fornitore='A'
	else
		ls_pref_fornitore='V'
	end if
	
	if ll_id_listino<=0 or isnull(ll_id_listino) then
		select id_listino
		into :ll_id_listino
		from listino
		where lis_base='S'
		and tipo= :ls_pref_fornitore
		;
	else
	end if
	
	select id_variazione
	into :ll_id_var
	from variazione
	where id_listino=:ll_id_listino
	and (data_inizio<=today() 
	and (data_fine>=today() or data_fine is null));
	
	select prezzo_manifattura, prezzo
	into :ld_prezzo_manifattura, :ldc_prezzo_pz
	from prezzo
	where id_unita_confezione=:ll_id_uc
	and id_variazione=:ll_id_var
	;
	if (isnull(ld_prezzo_manifattura) or ld_prezzo_manifattura=0) and &
		(isnull(ldc_prezzo_pz) or ldc_prezzo_pz=0) then
		select id_listino
		into :ll_id_listino
		from listino
		where lis_base='S'
		and tipo= :ls_pref_fornitore
		;
		
		select id_variazione
		into :ll_id_var
		from variazione
		where id_listino=:ll_id_listino
		and (data_inizio<=today() 
		and (data_fine>=today() or data_fine is null));
		
		select prezzo_manifattura, prezzo
		into :ld_prezzo_manifattura, :ldc_prezzo_pz
		from prezzo
		where id_unita_confezione=:ll_id_uc
		and id_variazione=:ll_id_var
		;
	end if
	select tipo
	into :ls_tipo_um
	from unita_misura
	where id_unita_misura=:ll_id_um;
	if ls_tipo_um='N' then
		dw_3.setitem(al_riga, "prezzo", ldc_prezzo_pz)
	else
		dw_3.setitem(al_riga, "prezzo", ld_prezzo_manifattura)
	end if
	dw_3.setitem(al_riga, "listino", ll_id_var)
end if
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

public subroutine wf_metti_sog_commerciale (long al_riga);if il_id_sog>0 then
	dw_3.setitem(al_riga, "id_sog_commerciale", il_id_sog)
end if
end subroutine

public subroutine wf_stampa_da_selezione (s_st_cat_immediato ast_cat);long ll_righe, i,ll_riga_inserita

dw_1.trigger event itemchanged(1, dw_1.object.id_sog_commerciale, string(ast_cat.id_sog_commerciale[1]))
dw_1.setitem(1, "id_sog_commerciale", ast_cat.id_sog_commerciale[1])

ll_righe=upperbound(ast_cat.id_articolo)
for i=1 to ll_righe
	ll_riga_inserita=dw_3.INSERTROW(0)
	dw_3.setitem(ll_riga_inserita, "id_sog_commerciale",ast_cat.id_sog_commerciale[1])
	
	dw_3.trigger event itemchanged(ll_riga_inserita, dw_3.object.cod_articolo, ast_cat.cod_articolo[i]) 

	
	
next
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

public function integer wf_trova_ris (string as_h_v, string as_nome_imm);integer li_res
ole_imm.object.printsize=6
ole_imm.object.delimage=true
ole_imm.object.loadimage=as_nome_imm
if as_h_v ='V' then
	li_res=ole_imm.object.imageYDpi
else
	li_res=ole_imm.object.imageXDpi
end if

return li_res
end function

on w_st_foto_articolo_cx.create
int iCurrent
call super::create
this.cb_salva=create cb_salva
this.cb_nuovo=create cb_nuovo
this.cb_cancella=create cb_cancella
this.cb_esci=create cb_esci
this.cb_ordina=create cb_ordina
this.dw_1=create dw_1
this.cb_preview=create cb_preview
this.cb_st_testo=create cb_st_testo
this.cbx_par_stampa=create cbx_par_stampa
this.cb_seleziona=create cb_seleziona
this.cb_azzera=create cb_azzera
this.dw_3=create dw_3
this.st_2=create st_2
this.cb_stampa=create cb_stampa
this.cbx_solo_nuovi=create cbx_solo_nuovi
this.dw_2=create dw_2
this.cbx_1=create cbx_1
this.ole_imm=create ole_imm
this.cb_foto2=create cb_foto2
this.cbx_recupera_prezzo=create cbx_recupera_prezzo
this.sle_lista_art=create sle_lista_art
this.cbx_3=create cbx_3
this.cb_salva_lista=create cb_salva_lista
this.sle_limite=create sle_limite
this.cbx_qta=create cbx_qta
this.dw_4=create dw_4
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_5=create dw_5
this.cb_2=create cb_2
this.cbx_vedi_foto=create cbx_vedi_foto
this.st_4=create st_4
this.rb_3=create rb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_salva_art_cliente=create cb_salva_art_cliente
this.ddlb_dec_prezzo=create ddlb_dec_prezzo
this.cbx_mostra_cliente=create cbx_mostra_cliente
this.cbx_non_girare=create cbx_non_girare
this.ddlb_traduci=create ddlb_traduci
this.st_5=create st_5
this.cb_3=create cb_3
this.p_1=create p_1
this.dw_6=create dw_6
this.dw_7=create dw_7
this.sle_scala=create sle_scala
this.st_6=create st_6
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva
this.Control[iCurrent+2]=this.cb_nuovo
this.Control[iCurrent+3]=this.cb_cancella
this.Control[iCurrent+4]=this.cb_esci
this.Control[iCurrent+5]=this.cb_ordina
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_preview
this.Control[iCurrent+8]=this.cb_st_testo
this.Control[iCurrent+9]=this.cbx_par_stampa
this.Control[iCurrent+10]=this.cb_seleziona
this.Control[iCurrent+11]=this.cb_azzera
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.cb_stampa
this.Control[iCurrent+15]=this.cbx_solo_nuovi
this.Control[iCurrent+16]=this.dw_2
this.Control[iCurrent+17]=this.cbx_1
this.Control[iCurrent+18]=this.ole_imm
this.Control[iCurrent+19]=this.cb_foto2
this.Control[iCurrent+20]=this.cbx_recupera_prezzo
this.Control[iCurrent+21]=this.sle_lista_art
this.Control[iCurrent+22]=this.cbx_3
this.Control[iCurrent+23]=this.cb_salva_lista
this.Control[iCurrent+24]=this.sle_limite
this.Control[iCurrent+25]=this.cbx_qta
this.Control[iCurrent+26]=this.dw_4
this.Control[iCurrent+27]=this.st_3
this.Control[iCurrent+28]=this.cb_1
this.Control[iCurrent+29]=this.dw_5
this.Control[iCurrent+30]=this.cb_2
this.Control[iCurrent+31]=this.cbx_vedi_foto
this.Control[iCurrent+32]=this.st_4
this.Control[iCurrent+33]=this.rb_3
this.Control[iCurrent+34]=this.rb_1
this.Control[iCurrent+35]=this.rb_2
this.Control[iCurrent+36]=this.cb_salva_art_cliente
this.Control[iCurrent+37]=this.ddlb_dec_prezzo
this.Control[iCurrent+38]=this.cbx_mostra_cliente
this.Control[iCurrent+39]=this.cbx_non_girare
this.Control[iCurrent+40]=this.ddlb_traduci
this.Control[iCurrent+41]=this.st_5
this.Control[iCurrent+42]=this.cb_3
this.Control[iCurrent+43]=this.p_1
this.Control[iCurrent+44]=this.dw_6
this.Control[iCurrent+45]=this.dw_7
this.Control[iCurrent+46]=this.sle_scala
this.Control[iCurrent+47]=this.st_6
this.Control[iCurrent+48]=this.st_7
end on

on w_st_foto_articolo_cx.destroy
call super::destroy
destroy(this.cb_salva)
destroy(this.cb_nuovo)
destroy(this.cb_cancella)
destroy(this.cb_esci)
destroy(this.cb_ordina)
destroy(this.dw_1)
destroy(this.cb_preview)
destroy(this.cb_st_testo)
destroy(this.cbx_par_stampa)
destroy(this.cb_seleziona)
destroy(this.cb_azzera)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.cb_stampa)
destroy(this.cbx_solo_nuovi)
destroy(this.dw_2)
destroy(this.cbx_1)
destroy(this.ole_imm)
destroy(this.cb_foto2)
destroy(this.cbx_recupera_prezzo)
destroy(this.sle_lista_art)
destroy(this.cbx_3)
destroy(this.cb_salva_lista)
destroy(this.sle_limite)
destroy(this.cbx_qta)
destroy(this.dw_4)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_5)
destroy(this.cb_2)
destroy(this.cbx_vedi_foto)
destroy(this.st_4)
destroy(this.rb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_salva_art_cliente)
destroy(this.ddlb_dec_prezzo)
destroy(this.cbx_mostra_cliente)
destroy(this.cbx_non_girare)
destroy(this.ddlb_traduci)
destroy(this.st_5)
destroy(this.cb_3)
destroy(this.p_1)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.sle_scala)
destroy(this.st_6)
destroy(this.st_7)
end on

event open;integer li_ret
SETREDRAW(FALSE)

dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_1.insertrow(1)
dw_4.insertrow(1)
dw_4.setitem(1, 1, "d_foto_art_da_documento_2")
ddlb_dec_prezzo.text="2"
dw_5.settransobject(sqlca)
dw_5.insertrow(1)

datawindowchild ldwc_sog_commerciale, ldw_listino
dw_3.getchild("id_sog_commerciale", ldwc_sog_commerciale)
ldwc_sog_commerciale.settransobject(sqlca)
ldwc_sog_commerciale.retrieve()
dw_3.getchild("listino", ldw_listino)
ldw_listino.settransobject(sqlca)
ldw_listino.retrieve()
dw_7.settransobject(sqlca)
dw_7.retrieve()
post wf_post_open()


end event

event closequery;if isvalid(w_mostra_imm_ocx) then
	close(w_mostra_imm_ocx)
end if
end event

type st_1 from w_001`st_1 within w_st_foto_articolo_cx
end type

type cb_salva from commandbutton within w_st_foto_articolo_cx
boolean visible = false
integer x = 1001
integer y = 1492
integer width = 320
integer height = 128
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret

li_ret=adw.update()
if li_ret=1 then
	COMMIT;
ELSE
	rollback;
end if
end event

type cb_nuovo from commandbutton within w_st_foto_articolo_cx
integer x = 23
integer y = 1516
integer width = 242
integer height = 108
integer taborder = 160
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

type cb_cancella from commandbutton within w_st_foto_articolo_cx
integer x = 288
integer y = 1516
integer width = 242
integer height = 108
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

type cb_esci from commandbutton within w_st_foto_articolo_cx
integer x = 3227
integer y = 1516
integer width = 242
integer height = 108
integer taborder = 30
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

type cb_ordina from commandbutton within w_st_foto_articolo_cx
integer x = 2199
integer y = 1516
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
string text = "Ordina"
end type

event clicked;string ls_null
setnull(ls_null)
dw_3.setsort(ls_null)
dw_3.sort()
end event

type dw_1 from udw_base within w_st_foto_articolo_cx
integer x = 841
integer y = 1492
integer width = 795
integer height = 188
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_rag_sog_com_ext"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;
integer i
string ls_rag, ls_imm
long ll_id_art

IL_ID_SOG =long(data)
select rag_soc_1
into :ls_rag
from sog_commerciale s, anagrafica a
where a.id_anagrafica=s.id_anagrafica
and s.id_sog_commerciale=:il_id_sog;

dw_3.object.titolo_t.text="Soggetto: "+ls_rag

for i=1 to dw_3.rowcount()
	dw_3.setitem(i, "id_sog_commerciale", il_id_sog)
	ll_id_art=dw_3.getitemnumber(i, "id_articolo")
	ls_imm=f_trova_immagine(il_id_sog, ll_id_art)
	if ls_imm> " " then
		dw_3.setitem(i, "nome_immagine", ls_imm)
	end if
next
end event

type cb_preview from commandbutton within w_st_foto_articolo_cx
boolean visible = false
integer x = 2414
integer y = 1516
integer width = 242
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Preview"
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_3.object.datawindow.print.preview='yes'
	dw_3.object.datawindow.print.preview.rulers='yes'
	dw_3.modify("cod_articolo_sw.visible=0")

else
	cb_preview.text='Preview'
	dw_3.object.datawindow.print.preview='no'
	dw_3.object.datawindow.print.preview.rulers='no'
	dw_3.modify("cod_articolo_sw.visible=1")

end if
end event

type cb_st_testo from commandbutton within w_st_foto_articolo_cx
integer x = 2469
integer y = 1516
integer width = 242
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lista"
end type

event clicked;String ls_colore, ls_mask, ls_h_footer, ls_st_totali
long ll_righe

ll_righe=dw_3.rowcount()
if ll_righe>0 then
	printsetup()
	
	choose case ddlb_dec_prezzo.text
		case "0"
			ls_mask="#,0"
		case "1"
			ls_mask="#,0.0"
		case "2"
			ls_mask="#,0.00"
		case "3"
			ls_mask="#,0.000"
		case "4"
			ls_mask="#,0.0000"
		case "5"
			ls_mask="#,0.00000"
		case "6"
			ls_mask="#,0.000000"
	end choose
	if ddlb_dec_prezzo.text>"" then dw_3.modify("prezzo.format='"+ls_mask+"'")


	
	
	
	
	
	dw_3.modify("cod_articolo_sw.visible=0")
	dw_3.modify("calc.visible=0")
	dw_3.modify("vedi_totali.visible=0")
	if cbx_par_stampa.checked=false then
		
		
		dw_3.modify("c_scegli.visible=0")
		
		dw_3.modify("nome_immagine.visible=0")
		dw_3.modify("id_sog_commerciale.visible=0")
		dw_3.modify("lunghezza.visible=0")
		dw_3.modify("des_articolo.visible=0")
		dw_3.modify("prezzo.visible=0")
		dw_3.modify("peso_unitario.visible=0")
		dw_3.modify("qta.visible=0")
		dw_3.modify("listino.visible=0")
		
		
		ls_colore=dw_3.describe("peso_lordo_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("peso_lordo_t.visible=1")
			dw_3.modify("peso_lordo_t.color=0")
		end if
	
		
		ls_colore=dw_3.describe("lunghezza_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("lunghezza.visible=1")
			dw_3.modify("lunghezza_t.color=0")
		end if
		
		ls_colore=dw_3.describe("peso_unitario_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("peso_unitario.visible=1")
			dw_3.modify("peso_unitario_t.color=0")
		end if
		
		ls_colore=dw_3.describe("prezzo_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("prezzo.visible=1")
			dw_3.modify("prezzo_t.color=0")
		end if
		
		ls_colore=dw_3.describe("des_articolo_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("des_articolo.visible=1")
			dw_3.modify("des_articolo_t.color=0")
		end if
		
		ls_colore=dw_3.describe("nome_immagine_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("nome_immagine.visible=1")
			dw_3.modify("nome_immagine_t.color=0")
		end if
		
		ls_colore=dw_3.describe("qta_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("qta.visible=1")
			dw_3.modify("qta_t.color=0")
		end if
		ls_colore=dw_3.describe("listino.color")
		if ls_colore="16777215" then 
			dw_3.modify("listino.visible=1")
			dw_3.modify("listino.color=0")
		end if

	ls_colore=dw_3.describe("sconto_t.color")
		if ls_colore="16777215" then 
			dw_3.modify("sconto_t.visible=1")
			dw_3.modify("sconto_t.color=0")
		end if
		
		
		dw_3.modify("titolo_t.visible=0")
	end if
	dw_3.print()
	
	
	dw_3.modify("c_scegli.visible=0")
	dw_3.modify("nome_immagine.visible=0")
	dw_3.modify("id_sog_commerciale.visible=0")
	dw_3.modify("lunghezza.visible=0")
	dw_3.modify("des_articolo.visible=0")
	dw_3.modify("prezzo.visible=0")
	dw_3.modify("peso_unitario.visible=0")
	dw_3.modify("peso_lordo.visible=0")
	dw_3.modify("qta.visible=0")
	dw_3.modify("listino.visible=0")
	
	dw_3.modify("calc.visible=1")
	dw_3.modify("cod_articolo_sw.visible=1")
	dw_3.modify("lunghezza.visible=1")
	dw_3.modify("peso_unitario.visible=1")
	dw_3.modify("peso_lordo.visible=1")
	dw_3.modify("prezzo.visible=1")
	dw_3.modify("des_articolo.visible=1")
	dw_3.modify("nome_immagine.visible=1")
	dw_3.modify("id_sog_commerciale.visible=1")
	dw_3.modify("qta.visible=1")
	dw_3.modify("listino.visible=1")
	dw_3.modify("titolo_t.visible=1")
	dw_3.modify("vedi_totali.visible=1")
	dw_3.modify("sconto.visible=0")
		
	dw_3.modify("c_scegli.visible=1")
		
	
	
	
	
end if






end event

type cbx_par_stampa from checkbox within w_st_foto_articolo_cx
integer x = 2971
integer y = 1152
integer width = 681
integer height = 76
integer taborder = 140
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Lista Completa di ogni campo"
boolean lefttext = true
end type

type cb_seleziona from commandbutton within w_st_foto_articolo_cx
integer x = 32
integer y = 1164
integer width = 325
integer height = 88
integer taborder = 60
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

type cb_azzera from commandbutton within w_st_foto_articolo_cx
integer x = 553
integer y = 1516
integer width = 242
integer height = 108
integer taborder = 80
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

type dw_3 from u_dw_figlio within w_st_foto_articolo_cx
integer x = 23
integer y = 16
integer width = 5001
integer height = 1128
integer taborder = 40
string dataobject = "d_foto_art_da_documento"
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

type st_2 from statictext within w_st_foto_articolo_cx
integer x = 3264
integer y = 1392
integer width = 201
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
string text = "Dec. Pr."
boolean focusrectangle = false
end type

type cb_stampa from commandbutton within w_st_foto_articolo_cx
integer x = 1669
integer y = 1516
integer width = 242
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Foto"
end type

event clicked;long myDC, job, ll_penna_noimm, ll_penna_riquadro
long ll_PixelDiX, ll_PixelDiY, ll_MmDiX, ll_MmDiY
long ll_img_dpi_x, ll_img_dpi_y
decimal ld_Dpi_X, ld_Dpi_Y
long alt, lar
integer i, li_ret, li_art_da_stampare, a, li_left_rect, li_top_rect
string ls_nome_immagine, ls_img_dir
s_dati_foto s_foto[], s_azzera[]
s_testo_cat s_text[], s_azzera_text[]
long ll_id_sog, ll_id_art

integer lar_effettiva,li_x_foto, li_y_foto, li_alt_dcmm,li_lar_q_testo_pix
integer alt_max_precedenti, li_alt_q_testo_pix, lunghezza_disp2
integer larghezza_pg, lunghezza_pg, margine_sx, margine_dx
integer margine_sup, margine_inf, margine_sx1, margine_sup1,altezza_righe_prec
integer lunghezza_disp, larghezza_disp,lunghezza_disp1, larghezza_disp1
integer li_lar_q_testo, li_alt_q_testo 
integer li_num_riga=1, li_num_pag, conta_testo, num_riga=1
INTEGER li_num_riga_precedente, LI_CONFRONTO

constant integer HorzRes = 8	
constant integer VertRes = 10	
constant integer HorzSize = 4	
constant integer VertSize = 6  
constant integer PhysicalOffsetX = 112	
constant integer PhysicalOffsetY = 113	

li_record=0

PrintSetup()
job=PrintOpen()
myDC=PRP_GetDC(job)
ole_imm.object.printsize=6

select dir_immagini
into :ls_img_dir
from par_sistema;
if ls_img_dir="" or isnull(ls_img_dir) then
	messagebox("Attenzione!", "Non è stato definito il path per le foto!")
end if


larghezza_pg=2100
lunghezza_pg=2970
margine_sx=150
margine_dx=100
margine_sup=230
margine_inf=180

li_lar_q_testo=400
li_alt_q_testo=330
li_alt_q_testo=wf_calcola_altezza_testo(li_alt_q_testo)

ll_PixelDiX = getdevicecaps(mydc,HorzRes) 
ll_PixelDiY = getdevicecaps(mydc,VertRes) 
ll_MmDiX = getdevicecaps(mydc,HorzSize) 
ll_MmDiY = getdevicecaps(mydc,VertSize) 

ld_Dpi_X = ll_PixelDiX / (10*ll_MmDiX)
ld_Dpi_Y = ll_PixelDiY / (10*ll_MmDiY)

larghezza_pg*=ld_Dpi_X 
lunghezza_pg*=ld_Dpi_Y
margine_sx*=ld_Dpi_X 
margine_dx*=ld_Dpi_X
margine_sup*=ld_Dpi_Y 
margine_inf*=ld_Dpi_Y
margine_sup1=margine_sup
margine_sx1=margine_sx
li_alt_q_testo_pix=li_alt_q_testo*ld_Dpi_Y
li_lar_q_testo_pix=li_lar_q_testo*ld_Dpi_X
larghezza_disp=larghezza_pg - (margine_dx)
lunghezza_disp=lunghezza_pg - (margine_sup + margine_inf)
larghezza_disp1=larghezza_disp
lunghezza_disp1=lunghezza_disp
lunghezza_disp2=0

li_art_da_stampare=dw_3.rowcount()

for i=1 to li_art_da_stampare
	a++
	conta_testo++
	
	ole_imm.object.delimage=true
	
	
	li_num_riga=dw_3.getitemnumber(i, "num_riga")
	IF i>1 THEN
		li_num_riga_precedente=dw_3.getitemnumber(i - 1, "num_riga")
	end if
	IF li_num_riga_precedente=li_num_riga THEN
		
		
		
		s_foto[a].nome_imm='NO'
		s_text[a].s_num_riga = -1
		continue
		
		
		
	ELSE
		
		
		ll_id_sog=dw_3.getitemnumber(i, "id_sog_commerciale")
		ll_id_art=dw_3.getitemnumber(i, "id_articolo")
		select nome_immagine
		into :ls_nome_immagine
		from immagini_cliente
		where id_sog_commerciale=:ll_id_sog
		and id_articolo=:ll_id_art;
		if sqlca.sqlcode<>0 then
			ls_nome_immagine=dw_3.getitemstring(i, "nome_immagine")
		end if
	END IF

	
	if ls_nome_immagine > "" then
		
		if POS(ls_nome_immagine,"\")<1 then ls_nome_immagine=ls_img_dir+'\'+ls_nome_immagine
		if FileExists(ls_nome_immagine) then 
			ole_imm.object.loadimage=ls_nome_immagine
			
			alt=ole_imm.object.imageHeight 
			lar=ole_imm.object.imagewidth
			
			ll_img_dpi_x = ole_imm.object.imageXDpi
			
			if isnull(ll_img_dpi_x) or (ll_img_dpi_x = 0) then ll_img_dpi_x = 96
			
			ll_img_dpi_y = ole_imm.object.imageYDpi
			
			if isnull(ll_img_dpi_y) or (ll_img_dpi_y = 0) then ll_img_dpi_y = 96
			
			
			alt=(alt/ll_img_dpi_y)*254 
			lar=(lar/ll_img_dpi_x)*254
			//inserisco limiti di grandezza foto da stampare (23,5x18)
			if lar>1800 then
				alt=1800*alt/lar
				lar=1800
			end if

			if  alt>2300 then
				lar=2300*lar/alt
				alt=2300
			end if

			li_alt_dcmm=alt 

			
			
			alt=ld_dpi_y*alt
			lar=ld_dpi_x*lar
		else
			
			ls_nome_immagine='NO'
			
				alt=li_alt_dcmm
			
			
			
			lar=li_lar_q_testo_pix
		end if
	else
		
		ls_nome_immagine='NO'
			alt=li_alt_dcmm
		
		
		
		lar=li_lar_q_testo_pix
	end if
	if li_lar_q_testo_pix>lar then
		lar_effettiva=li_lar_q_testo_pix
	else
		lar_effettiva=lar
	end if

	if larghezza_disp1< lar_effettiva then
		lunghezza_disp2+=alt_max_precedenti
		if num_riga <= 2 then
			LI_CONFRONTO= (li_alt_q_testo_pix + margine_sup1)*2
		else
			LI_CONFRONTO= (li_alt_q_testo_pix + margine_sup1)
		END IF
		if lunghezza_disp1 < lunghezza_DISP2 + alt + LI_CONFRONTO  then
		
			
			li_ret=100
			if ls_nome_immagine='NO' then
				alt_max_precedenti=100
			else
				alt_max_precedenti = alt
			end if	
			li_num_pag++
			wf_stampa_testo(s_text, li_lar_q_testo, li_alt_q_testo, job)
			wf_stampa_intestazione(job, li_num_pag)
			wf_stampa_foto(s_foto, mydc, ld_dpi_x, ld_dpi_y)
			
			printpage(job)
			s_foto=s_azzera
			s_text=s_azzera_text
			a=1
			conta_testo=1
			num_riga=1
			margine_sup1=margine_sup
			margine_sx1=margine_sx
			lunghezza_disp1=lunghezza_disp
			larghezza_disp1=larghezza_disp
			lunghezza_disp2=0
			altezza_righe_prec=0
			if ls_nome_immagine="" or ls_nome_immagine='NO' then li_alt_dcmm=100 
			
		else
			num_riga++
			margine_sx1=margine_sx
			margine_sup1=50*ld_dpi_y
			larghezza_disp1=larghezza_disp 
			li_ret=100
			altezza_righe_prec+=li_alt_q_testo_pix +margine_sup1
			if num_riga =2 then
				lunghezza_disp2 += li_alt_q_testo_pix + margine_sup + (margine_sup1)*2
			else
				lunghezza_disp2 += li_alt_q_testo_pix + margine_sup1
			end if
		END IF	
		
	else
		
		if alt_max_precedenti<alt  then
			
			
			
			
			if num_riga=1 then
				li_confronto=0
			else
				LI_CONFRONTO= (li_alt_q_testo_pix + margine_sup1)
			end if
			if lunghezza_disp1 < lunghezza_disp2 + alt + LI_CONFRONTO  then
				li_ret=100
				if ls_nome_immagine='NO' then
					alt_max_precedenti=100
				else
					alt_max_precedenti = alt
				end if	
				li_num_pag++
				wf_stampa_testo(s_text, li_lar_q_testo, li_alt_q_testo, job)
				wf_stampa_intestazione(job, li_num_pag)
				wf_stampa_foto(s_foto, mydc, ld_dpi_x, ld_dpi_y)
				
				printpage(job)
				s_foto=s_azzera
				s_text=s_azzera_text
				a=1
				conta_testo=1
				num_riga=1
				margine_sup1=margine_sup
				margine_sx1=margine_sx
				lunghezza_disp1=lunghezza_disp
				larghezza_disp1=larghezza_disp
				lunghezza_disp2=0
				altezza_righe_prec=0
				if ls_nome_immagine="" or ls_nome_immagine='NO' then li_alt_dcmm=100 
			else
				alt_max_precedenti = alt
				if larghezza_disp1=larghezza_disp then 
					margine_sx1=margine_sx
				else
					margine_sx1=20*ld_dpi_x
				end if
				li_ret=100
			end if
		else	
			if larghezza_disp1=larghezza_disp then 
				margine_sx1=margine_sx
			else
				margine_sx1=20*ld_dpi_x
			end if
			li_ret=100
		end if
	end if
	
	li_left_rect=(larghezza_disp +margine_sx1 - (larghezza_disp1))
	li_top_rect=lunghezza_disp2 +margine_sup1
	
	s_foto[a].nome_imm=ls_nome_immagine
	
	s_foto[a].left=li_left_rect + (lar_effettiva - lar)/2 
	s_foto[a].top=li_top_rect 
	s_foto[a].bottom=s_foto[a].top +alt
	s_foto[a].right=s_foto[a].left + lar
	
	
	
	li_left_rect+= (lar_effettiva - li_lar_q_testo_pix )/2
	li_left_rect/=ld_dpi_x
	
	li_top_rect=li_top_rect/ld_dpi_y + li_alt_dcmm +20
	s_text[conta_testo].s_left=li_left_rect
	s_text[conta_testo].s_top=li_top_rect
	s_text[conta_testo].s_num_riga=num_riga
	
	if li_ret=100 then larghezza_disp1 -= (lar_effettiva + margine_sx1) 
next
wf_stampa_testo(s_text, li_lar_q_testo, li_alt_q_testo, job)
wf_stampa_intestazione(job, li_num_pag+1)
wf_stampa_foto(s_foto, mydc, ld_dpi_x, ld_dpi_y)

PrintClose(job)
li_ret=DeleteDc(mydc)



end event

type cbx_solo_nuovi from checkbox within w_st_foto_articolo_cx
boolean visible = false
integer x = 2976
integer y = 1212
integer width = 434
integer height = 76
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Solo Articoli Nuovi"
boolean lefttext = true
end type

event clicked;integer i, li_test, li_righe
long ll_id_riga, ll_id_art, ll_id_sog, ll_da
if this.checked then
	if dw_3.rowcount()<=0 then return
	
	ll_id_sog=dw_3.getitemnumber(1, "id_sog_commerciale")
	if ll_id_sog>0 then
		li_righe=dw_3.rowcount()
		for i= li_righe to 1 step -1
			ll_id_riga=dw_3.getitemnumber(i, "id_riga_documento")
			ll_id_art=dw_3.getitemnumber(i, "id_articolo")
			select num_riga into :li_test
			from riga_documento r, documento d, registro reg
			where id_riga_documento<>:ll_id_riga
			and id_articolo=:ll_id_art
			and r.id_documento=d.id_documento
			and d.id_sog_commerciale=:ll_id_sog
			and reg.id_registro=d.id_registro
			and reg.tipo_registro='IV'
			;
			if li_test>0 then
				dw_3.rowsmove(i,i,primary!, dw_2,  1, PRIMARY!)
				li_test=0
			end if
		next
	end if
else
	ll_da=dw_3.rowcount()
	if ll_da<=0 then ll_da=1
	dw_2.rowsmove(1,DW_2.ROWCOUNT(), primary!, dw_3, ll_da , PRIMARY!)
end if
end event

type dw_2 from datawindow within w_st_foto_articolo_cx
boolean visible = false
integer x = 46
integer y = 1972
integer width = 3598
integer height = 448
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_foto_art_da_documento"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_st_foto_articolo_cx
integer x = 3406
integer y = 1212
integer width = 247
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
string text = "Totali"
boolean lefttext = true
end type

event clicked;string ls_st_totali, ls_h_footer


if cbx_1.checked then
	ls_h_footer=dw_3.modify("datawindow.summary.height=80")
else
	dw_3.modify("datawindow.summary.height=5")
end if
end event

type ole_imm from olecustomcontrol within w_st_foto_articolo_cx
event paintevent ( )
event selectevent ( long lplleft,  long lpltop,  long lplright,  long lplbottom )
event statusevent ( long lppercent )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event keyup ( integer keycode,  integer shift )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event scroll ( long scrolltype )
event errorevent ( integer nerrcount )
event thumbnail ( string filename,  long page )
event tag ( integer tagid,  integer tagtype,  long tagsize,  integer wordval,  long longval,  string strval )
event thumbtitle ( string title,  integer page )
boolean visible = false
integer x = 2757
integer y = 1168
integer width = 219
integer height = 116
integer taborder = 120
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_st_foto_articolo_cx.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_foto2 from commandbutton within w_st_foto_articolo_cx
integer x = 1938
integer y = 1516
integer width = 242
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Foto2"
end type

event clicked;s_ds_per_foto s_foto
integer li_test

//s_foto.w_padre=parent
s_foto.ds_dati_doc=create datastore
s_foto.dw=dw_4.getitemstring(1,1)
if s_foto.dw='d_cat_uno_a_uno' then
	s_foto.ds_dati_doc.dataobject="d_foto_art_da_documento"
else
	s_foto.ds_dati_doc.dataobject=s_foto.dw
end if
s_foto.ds_dati_doc.settransobject(sqlca)

dw_3.setfilter("c_scegli='S'")
dw_3.filter()
li_test=dw_3.rowscopy(1, dw_3.rowcount(), primary!, s_foto.ds_dati_doc, 1, primary!)
setredraw(false)
if cbx_non_girare.checked then s_foto.ruota="S"
dw_7.accepttext()
s_foto.LI_max_larghezza=dw_7.getitemnumber(1, "w_max_foto")
s_foto.LI_max_altezza=dw_7.getitemnumber(1, "h_max_foto")
s_foto.li_x_foto=dw_7.getitemnumber(1, "x_foto")
s_foto.li_y_foto=dw_7.getitemnumber(1, "y_foto")
s_foto.scala=dec(sle_scala.text)

openwithparm(w_foto_da_doc_2, s_foto)

dw_3.setfilter("")
dw_3.filter()
dw_3.setsort("c_scegli desc, cod_articolo")
dw_3.sort()
setredraw(true)
end event

type cbx_recupera_prezzo from checkbox within w_st_foto_articolo_cx
integer x = 37
integer y = 1412
integer width = 608
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recupera Prezzo"
end type

event clicked;long i, ll_id_art, ll_id_sog, ll_null
if checked then
	for i=1 to dw_3.rowcount()
		ll_id_sog=dw_3.getitemnumber(i, "id_sog_commerciale")
		ll_id_art=dw_3.getitemnumber(i, "id_articolo")
		wf_trova_prezzo(ll_id_art, ll_id_sog, i)
	next
else
	if messagebox("Attenzione!", "Vuoi azzerare tutti i prezzi?", stopsign!, yesno!)=1 then
		setnull(ll_null)
		for i=1 to dw_3.rowcount()
			dw_3.setitem(i, "prezzo", ll_null)
		next
	end if
end if
end event

type sle_lista_art from singlelineedit within w_st_foto_articolo_cx
integer x = 2117
integer y = 1156
integer width = 590
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_3 from checkbox within w_st_foto_articolo_cx
string tag = "Per applicare uno sconto a tutte le righe inserirlo nella prima e poi spuntare questa checkbox."
integer x = 37
integer y = 1264
integer width = 859
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ricopia sconto in tutte le righe"
end type

event clicked;decimal ldc_sconto
long i, ll_righe

ll_righe=dw_3.rowcount()
if ll_righe>0 then
	dw_3.accepttext()
	if checked then
		if messagebox("Attenzione!", "Se esistono già sconti applicati manualmente verranno sovrascritti! Continuare?",+&
			stopsign!, yesno!)=1 then
			ldc_sconto=dw_3.getitemdecimal(1, "sconto")
			for i=1 to ll_righe
				dw_3.setitem(i, "sconto", ldc_sconto)
			next
		end if
	else
		if messagebox("Attenzione!", "Se esistono già sconti applicati manualmente verranno annullati! Continuare?",+&
			stopsign!, yesno!)=1 then
			setnull(ldc_sconto)
			for i=1 to ll_righe
				dw_3.setitem(i, "sconto", ldc_sconto)
			next
		end if
	end if
end if
end event

type cb_salva_lista from commandbutton within w_st_foto_articolo_cx
integer x = 1710
integer y = 1152
integer width = 407
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Lista"
end type

event clicked;	integer i,li_ret
	long ll_id_lista, ll_id_art, ll_test
	string ls_codice_lista
	datastore ds_lista_figlio, ds_lista
	decimal ldc_qta
	
	ls_codice_lista=trim(sle_lista_art.text)
	if ls_codice_lista>" " then
		select id_lista_articoli
		into :ll_test
		from lista_art_def
		where cod_lista_articoli=:ls_codice_lista;
		if ll_test>0 then
			li_ret=messagebox("Attenzione!", "Codice Lista già esistente!"+&
			" Se vuoi sovrascriverla scegli 'Sì', altrimenti 'No' e cambia il codice alla lista", stopsign!, yesno!)
			if li_ret= 1 then 
				ll_id_lista=ll_test
				delete from dba.lista_art_key
				where id_lista_articoli=:ll_id_lista;
				if sqlca.sqlcode= -1 then
					rollback;
					messagebox("Errore!", "Lista non salvata 21")
					return
				else
					commit;
				end if
			else
				return
			end if
		else
			ds_lista=create datastore
			ds_lista.dataobject="d_lista_art_def_gd"
			ds_lista.settransobject(sqlca)
				
			ds_lista.insertrow(1)
			ds_lista.setitem(1, "cod_lista_articoli", ls_codice_lista)
			if ds_lista.update()=1 then
				commit;
				select @@identity 
				INTO :ll_id_lista
				from lista_art_def;
			else
				rollback;
				messagebox("Errore!", "Lista non salvata 33")
				return
			end if
		end if
		ds_lista_figlio=create datastore
		ds_lista_figlio.dataobject="d_lista_art_key_gd"
		ds_lista_figlio.settransobject(sqlca)
		
		
		IF ll_id_lista> 0 THEN
			dw_3.setfilter("c_scegli='S'")
			dw_3.filter()
			for i= 1 to dw_3.rowcount()
				//prende tutti gli articoli con scegli spuntato e li salva in una lista
				//(chiede prima il nome della lista all'utente)
				ll_id_art=dw_3.getitemnumber(i, "id_articolo")
				ldc_qta=dw_3.getitemdecimal(i, "qta")
				ds_lista_figlio.insertrow(1)
				ds_lista_figlio.setitem(1, "lista_art_key_id_lista_articoli", ll_id_lista)
				ds_lista_figlio.setitem(1, "lista_art_key_id_articolo", ll_id_art)
				ds_lista_figlio.setitem(1, "lista_art_key_qta", ldc_qta)
			next
			if ds_lista_figlio.update()=1 then
				commit;
				messagebox("OK!", "Lista Salvata!")
			else
				rollback;
				messagebox("Errore!", "Lista non salvata 58")
			end if
		ELSE
			messagebox("Errore!", "Lista non salvata 61")	
		END IF
		destroy ds_lista
		destroy ds_lista_figlio
		dw_3.setfilter("")
		dw_3.filter()
		

	else
		messagebox("Attenzione!", "Inserire il nome della lista da salvare!")
	end if
end event

type sle_limite from singlelineedit within w_st_foto_articolo_cx
string tag = "Il numero che inserisci in questo campo sarà il limite delle righe selezionate (se premi ~"scegli tutto~" con questo campo valorizzato verranno selezionati solo tante rghe quanto è il numero inserito)."
integer x = 1019
integer y = 1156
integer width = 224
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type cbx_qta from checkbox within w_st_foto_articolo_cx
string tag = "Per applicare uno sconto a tutte le righe inserirlo nella prima e poi spuntare questa checkbox."
integer x = 37
integer y = 1340
integer width = 859
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ricopia Q.ta in tutte le righe"
end type

event clicked;integer li_qta
long i, ll_righe

ll_righe=dw_3.rowcount()
if ll_righe>0 then
	dw_3.accepttext()
	if checked then
		if messagebox("Attenzione!", "Se esistono già Q.ta applicate manualmente verranno sovrascritti! Continuare?",+&
			stopsign!, yesno!)=1 then
			li_qta=dw_3.getitemdecimal(1, "qta")
			for i=1 to ll_righe
				dw_3.setitem(i, "qta", li_qta)
			next
		end if
	else
		if messagebox("Attenzione!", "Se esistono già Q.ta applicate manualmente verranno annullati! Continuare?",+&
			stopsign!, yesno!)=1 then
			setnull(li_qta)
			for i=1 to ll_righe
				dw_3.setitem(i, "qta", li_qta)
			next
		end if
	end if
end if
end event

type dw_4 from u_dw_base within w_st_foto_articolo_cx
integer x = 2450
integer y = 1396
integer width = 763
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_scegli_dw"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_3 from statictext within w_st_foto_articolo_cx
integer x = 2034
integer y = 1408
integer width = 398
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo Stampa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_st_foto_articolo_cx
integer x = 425
integer y = 1164
integer width = 325
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerca Ordine"
end type

event clicked;datastore ds_recupera
long ll_righe

open(w_elenco_ordini)

if isvalid(message.powerobjectparm) then
	ds_recupera=message.powerobjectparm
	
	ll_righe= ds_recupera.rowcount()
	if ll_righe>0 then
		wf_stampa_da_ordine(ds_recupera)
	end if
END IF
end event

type dw_5 from udw_base within w_st_foto_articolo_cx
integer x = 2295
integer y = 1268
integer width = 901
integer height = 124
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_carica_catalogo"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;integer i
string ls_rag, ls_art
long ll_id_cat, ll_riga, ll_id_sog, ll_id_art
datastore ds_lista_figlio

if dw_3.rowcount()>0 then
	if messagebox("Attenzione!", "Cancellare le righe presenti e caricare il catalogo scelto?", &
	stopsign!, yesno!)=2 then return
end if
dw_3.reset()

ll_id_cat=long(data)

ds_lista_figlio=create datastore
ds_lista_figlio.dataobject="d_cat_immediato_righe"
ds_lista_figlio.settransobject(sqlca)
ds_lista_figlio.retrieve(ll_id_cat)

for i= 1 to ds_lista_figlio.rowcount()
	ll_riga=dw_3.insertrow(0)
	dw_3.object.data[i,1,i,19]=ds_lista_figlio.object.data[i, 2, i, 20]
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



end event

type cb_2 from commandbutton within w_st_foto_articolo_cx
integer x = 1710
integer y = 1264
integer width = 407
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Catalogo"
end type

event clicked;	integer i,li_ret, c
	long ll_id_lista, ll_id_art, ll_test
	string ls_codice_lista
	datastore ds_lista_figlio, ds_lista
	decimal ldc_qta
	
	dw_3.accepttext()
	ds_lista_figlio=create datastore
	ds_lista_figlio.dataobject="d_cat_immediato_righe"
	ds_lista_figlio.settransobject(sqlca)
	
	ls_codice_lista=trim(sle_lista_art.text)
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
				for c=1 to 19
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
	datawindowchild ldwc_catalogo
	
	dw_5.getchild("id_cat_immediato", ldwc_catalogo)
	ldwc_catalogo.settransobject(sqlca)
	ldwc_catalogo.retrieve()
	
end event

type cbx_vedi_foto from checkbox within w_st_foto_articolo_cx
integer x = 3314
integer y = 1292
integer width = 343
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
string text = "Vedi Foto"
boolean checked = true
boolean lefttext = true
end type

type st_4 from statictext within w_st_foto_articolo_cx
integer x = 795
integer y = 1172
integer width = 219
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Limite:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_st_foto_articolo_cx
integer x = 1221
integer y = 1312
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

type rb_1 from radiobutton within w_st_foto_articolo_cx
integer x = 955
integer y = 1240
integer width = 654
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
string text = "Solo Articoli del Cliente"
boolean lefttext = true
end type

event clicked;integer i, li_limite
long ll_id_articolo, ll_id_sog
string ls_nome_immagine


	ll_id_sog=dw_1.getitemnumber(1, "id_sog_commerciale")
	if ll_id_sog>0 then
		for i= 1 to dw_3.rowcount()
			ls_nome_immagine=""
			ll_id_articolo=dw_3.getitemnumber(i, "id_articolo")
			select nome_immagine
			into :ls_nome_immagine
			from dba.immagini_cliente
			where id_sog_commerciale=:ll_id_sog
			and id_articolo=:ll_id_articolo;
	
			if ls_nome_immagine>" " then
				dw_3.setitem(i, "c_scegli", 'S')
			else
				dw_3.setitem(i, "c_scegli", 'N')
			end if
			
		next
	else
		messagebox("Attenzione!", "E' necessario scegliere un cliente!")
	end if
	
end event

type rb_2 from radiobutton within w_st_foto_articolo_cx
integer x = 1243
integer y = 1164
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

type cb_salva_art_cliente from commandbutton within w_st_foto_articolo_cx
integer x = 2761
integer y = 1520
integer width = 430
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Associa Art./Cli"
end type

event clicked;string ls_test, ls_imm, ls_new_imm
integer i
long ll_id_sog, ll_id_articolo

ll_id_sog=dw_1.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog>0 then
setpointer(hourglass!)
	for i= 1 to dw_3.rowcount()
		ls_test=dw_3.getitemstring(i, "c_scegli")
		ll_id_articolo=dw_3.getitemnumber(i, "id_articolo")
		if ls_test='S' then
			ls_new_imm=dw_3.getitemstring(i, "nome_immagine")
			ls_imm=""
			select nome_immagine
			into :ls_imm
			from dba.immagini_cliente
			where id_articolo=:ll_id_articolo
			and id_sog_commerciale=:ll_id_sog
			;
			if sqlca.sqlcode=0 then
				
				if ls_new_imm	<> ls_imm then
					update dba.immagini_cliente
					set nome_immagine=:ls_new_imm
					where  id_articolo=:ll_id_articolo
					and id_sog_commerciale=:ll_id_sog
					;
					if sqlca.sqlNrows>0  then
						commit;
					else
						rollbacK;
					end if
				end if
			else	
				insert into dba.immagini_cliente
				(id_sog_commerciale, id_articolo, nome_immagine)
				values(:ll_id_sog, :ll_id_articolo, :ls_new_imm)
				;
				if sqlca.sqlcode=0 then
					commit;
				else
					rollbacK;
					messagebox("Attenzione!", "Non inserito riga "+string(i))
				end if
			end if
		end if
	next
else
	messagebox("Attenzione!", "E' necessario scegliere un cliente!")
end if
setpointer(arrow!)
end event

type ddlb_dec_prezzo from dropdownlistbox within w_st_foto_articolo_cx
integer x = 3451
integer y = 1380
integer width = 210
integer height = 228
integer taborder = 130
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

type cbx_mostra_cliente from checkbox within w_st_foto_articolo_cx
integer x = 613
integer y = 1408
integer width = 997
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostra Cliente Associato all~'Articolo"
boolean lefttext = true
end type

event clicked;integer i
long ll_id_art, ll_id_sog

if checked then
	for i=1 to dw_3.rowcount()
		setnull(ll_id_sog)
		ll_id_art=dw_3.getitemnumber(i, "id_articolo")
		select first(id_sog_commerciale)
		into :ll_id_sog
		from dba.immagini_cliente
		where id_articolo=:ll_id_art
		;
		dw_3.setitem(i, "id_sog_commerciale", ll_id_sog)
		
		
	next
else
	setnull(ll_id_sog)
	for i=1 to dw_3.rowcount()
		dw_3.setitem(i, "id_sog_commerciale", ll_id_sog)
	next
	
end if
end event

type cbx_non_girare from checkbox within w_st_foto_articolo_cx
integer x = 1646
integer y = 1408
integer width = 430
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Non girare foto"
boolean lefttext = true
end type

type ddlb_traduci from dropdownlistbox within w_st_foto_articolo_cx
integer x = 576
integer y = 1676
integer width = 462
integer height = 352
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean allowedit = true
string item[] = {"Inglese","Francese"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_da_lingua, ls_a_lingua, ls_descrizione, ls_tradotto
integer i

ls_da_lingua='italiano'
ls_a_lingua=ddlb_traduci.text
for i= 1 to dw_3.rowcount()
	
	ls_descrizione=dw_3.getitemstring(i, "des_articolo")
	ls_tradotto=f_traduci_frase(ls_da_lingua, ls_a_lingua, ls_descrizione)
	dw_3.setitem(i, "des_articolo", ls_tradotto)
next


end event

type st_5 from statictext within w_st_foto_articolo_cx
integer x = 64
integer y = 1684
integer width = 507
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Traduci descrizione in "
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_st_foto_articolo_cx
boolean visible = false
integer x = 3488
integer y = 1516
integer width = 343
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;integer i, LI_MAX_width, Li_TEST, LI_MAX_height
integer li_x, li_y, li_mg_sx
decimal ldc_coef_vert, ldc_coef_horz, LDC_H, LDC_W
string ls_imm, modstring, ls_ret, ls_nome, ls_visible
string ls_h, ls_w, modstring_line,modstring_rect, ls_select
string ls_nuovo, dwsyntax, ls_nome_col_dw, ls_path
string ls_null
long ll_inizio, ll_fine, ll_esiste
LONG ll_altezza_foto, ll_larghezza_foto
integer li_res_h, li_res_v, li_appoggio, li_posx_attuale, li_posy_attuale
long ll_id_art

dw_6.Object.DataWindow.Zoom = 30

select w_max_foto, h_max_foto, x_foto, y_foto
into :LI_MAX_width, :LI_MAX_height, :li_x, :li_y
from dba.orafo_par_sistema
;
//valori espressi in cm/1000 (ricorda che anche la dw deve avere questa UM)
if isnull(LI_MAX_width) or LI_MAX_width=0 then LI_MAX_width=16000
if isnull(LI_MAX_height) or LI_MAX_height=0 then LI_MAX_height=26000
if isnull(li_x) or li_x=0 then li_x=200
if isnull(li_y) or li_y=0 then li_y=4000

dw_6.settransobject(sqlca)
dw_6.insertrow(0)

ls_path=  "c:\dati\foto"//wf_trova_dir_immagini()
select dir_immagini
into :ls_path
from par_sistema;
setnull(ls_null)
dw_1.setredraw(false)
for i=1 to dw_3.rowcount()
	ls_imm= dw_3.getitemstring(i, "nome_immagine")
	//dw_1.setitem(i, "nome_immagine", ls_null)
	if pos(ls_imm, "\")=0 then
		ls_imm=ls_path+"\"+ls_imm
	end if
	ls_nome=string(i)
	ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'
	//ll_id_art=dw_1.getitemnumber(i, "id_articolo")
	//ls_visible='"1~tif(id_articolo='+string(ll_id_art)+', 1, 0)"'
	//inserisco una bitmap legata alla riga (se riga=num. bitmap allora visibile)
	if fileexists(ls_imm) then
		//cerco dove siamo nel foglio
		li_posx_attuale+=integer(ls_w)
		li_posy_attuale+=integer(ls_h)
		li_res_h=wf_trova_ris('V', ls_imm)
		li_res_v=wf_trova_ris('H', ls_imm)
		//la datawindow deve avere come unita di misura i cm/1000
		ldc_coef_horz=li_res_h/2540  //4
		ldc_coef_vert=li_res_v/2540		//6
				
		setredraw(false)
		p_1.picturename=ls_imm
		setredraw(true)
		ll_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
		ll_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
		
		ll_altezza_foto /= ldc_coef_vert
		ll_larghezza_foto /= ldc_coef_horz
		
		if ll_altezza_foto>LI_MAX_height and ll_altezza_foto>ll_larghezza_foto+5 then
			//wf_ruota_imm(ls_imm, ll_larghezza_foto,ll_altezza_foto )
//			li_appoggio=ll_larghezza_foto
//			ll_larghezza_foto=ll_altezza_foto
//			ll_altezza_foto=li_appoggio
		end if

		
		if ll_altezza_foto>=ll_larghezza_foto then
			if ll_altezza_foto> LI_MAX_height then
				ls_h=string(LI_MAX_height)
				ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*LI_MAX_height,0))
			else
				ls_h=string(ll_altezza_foto)
				ls_w=string(ll_larghezza_foto)
			end if
				
		else
			if ll_larghezza_foto > LI_MAX_width then
				ls_w=string(LI_MAX_width)
				ls_h=string(round((ll_altezza_foto/ll_larghezza_foto)*LI_MAX_width,0))
				if integer(ls_h) > LI_MAX_height then
					ls_h=string(LI_MAX_height)
					ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*LI_MAX_height,0))
				end if
			else
				ls_w=string(ll_larghezza_foto)
				if ll_altezza_foto > LI_MAX_height then
					ls_h=string(LI_MAX_height)
					ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*LI_MAX_height,0))
				else
					ls_h=string(ll_altezza_foto)
				end if
			end if
		end if
		//creo la bitmap
		modstring = 'create bitmap(band=detail x="'+string(li_x + li_posx_attuale)+'" y="'+string(li_y)+&
						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+& 
						' resizeable=1  moveable=1  )'
			
		ls_ret=dw_6.Modify(modstring)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco il rettangolo di contorno alla foto
		ls_h=string(long(ls_h) + 80)
		ls_w=string(long(ls_w)+80)
		modstring_rect = 'create rectangle(band=detail x="'+string(li_x - 40 +li_posx_attuale)+'" y="'+string(li_y - 40)+&
							+'" height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
				+' brush.color="553648127" pen.style="0" pen.width="10"'& 
				+' pen.color="0"  background.mode="1" background.color="0"'+ &
				' resizeable=1  moveable=1 )'
		ls_ret=dw_6.Modify(modstring_rect)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
//		
//		//inserisco una riga di divisione con il record successivo
//		ls_h=string(long(ls_h) + li_y+ 300)
//		Li_TEST=INTEGER(DW_1.DESCRIBE("NOME_IMMAGINE_1.Y"))+integer(DW_1.describe("NOME_IMMAGINE_1.height"))
//		if li_test>integer(ls_h) then ls_h=string(li_test+60) 
//		modstring_line='create line(name=l_'+ls_nome+' moveable=1 resizeable=1 band=detail background.mode="2"'& 
//			+' background.color="16777215" pen.style="0" pen.width="30" pen.color="0"'+&
//			' visible='+ls_visible+&
//			+' x1="21" y1="'+ls_h+'" x2="'+string(LI_MAX_width - 25)+'" y2="'+ls_h+'" )'
//		ls_ret=dw_1.Modify(modstring_line)
//		if ls_ret<>"" then 
//			messagebox("ERRORE!", ls_ret)
//		end if
	//chiudo L'if del fileexists 
	end if
	
next
end event

type p_1 from picture within w_st_foto_articolo_cx
boolean visible = false
integer x = 1701
integer y = 1696
integer width = 320
integer height = 168
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_6 from udw_base within w_st_foto_articolo_cx
boolean visible = false
integer x = 462
integer y = 1916
integer width = 2770
integer height = 456
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_st_new_catalogo"
boolean vscrollbar = false
end type

type dw_7 from udw_base within w_st_foto_articolo_cx
integer x = 1056
integer y = 1656
integer width = 2647
integer height = 236
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_orafo_par_sistema_cat_cx"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;
integer i
string ls_rag, ls_imm
long ll_id_art

IL_ID_SOG =long(data)
select rag_soc_1
into :ls_rag
from sog_commerciale s, anagrafica a
where a.id_anagrafica=s.id_anagrafica
and s.id_sog_commerciale=:il_id_sog;

dw_3.object.titolo_t.text="Soggetto: "+ls_rag

for i=1 to dw_3.rowcount()
	dw_3.setitem(i, "id_sog_commerciale", il_id_sog)
	ll_id_art=dw_3.getitemnumber(i, "id_articolo")
	ls_imm=f_trova_immagine(il_id_sog, ll_id_art)
	if ls_imm> " " then
		dw_3.setitem(i, "nome_immagine", ls_imm)
	end if
next
end event

type sle_scala from singlelineedit within w_st_foto_articolo_cx
integer x = 640
integer y = 1796
integer width = 192
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_st_foto_articolo_cx
integer x = 251
integer y = 1812
integer width = 375
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scala le foto del"
boolean focusrectangle = false
end type

type st_7 from statictext within w_st_foto_articolo_cx
integer x = 846
integer y = 1804
integer width = 105
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "%"
boolean focusrectangle = false
end type

