forward
global type w_orafo_articolo_cx from w_articolo_cx
end type
type cb_peso_netto from commandbutton within tabpage_1
end type
type cb_classe from commandbutton within tabpage_1
end type
type dw_3 from udw_base within tabpage_1
end type
type p_1 from picture within tabpage_1
end type
end forward

global type w_orafo_articolo_cx from w_articolo_cx
integer width = 2949
integer height = 2028
end type
global w_orafo_articolo_cx w_orafo_articolo_cx

type variables
long	il_id_titolo
decimal 	id_calo
integer       ii_vai_a_legato
integer       ii_colore
decimal 	id_coeff_calo
s_ricalcola_distinta is_ric_distinta
end variables

forward prototypes
public subroutine wf_proponi_titolo ()
public subroutine wf_crea_distinta (long al_id_art_padre, long al_id_art)
public subroutine wf_ricalcola_distinta ()
public subroutine wf_ricarico (string as_data)
public subroutine wf_messaggio ()
public subroutine wf_ins_cod_fo ()
public subroutine uf_agg_cod_barre (integer al_row, datawindow adw_art)
public subroutine wf_conta_vener ()
public subroutine wf_ins_prezzo_lis_personale ()
public subroutine uf_mostra_immagine (string immagine)
end prototypes

public subroutine wf_proponi_titolo ();
long	ll_righe, ll_id

select count() 
into :ll_righe
from orafo_titolo;
if ll_righe=1 then
	select id_titolo
	into :ll_id
	from orafo_titolo;
	tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"id_titolo",ll_id)
	tab_1.tabpage_1.dw_articolo_gen_ff.post event itemchanged(1,tab_1.tabpage_1.dw_articolo_gen_ff.object.id_titolo,string(ll_id))
end if

if il_id_titolo<>0 and il_id_titolo<>ll_id and Not(IsNull(il_id_titolo)) then
	tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"id_titolo",il_id_titolo)
end if
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"coeff_calo",id_coeff_calo)
tab_1.tabpage_1.dw_articolo_gen_ff.post event ue_prepare_codice()
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"id_colore",ii_colore)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"coef_calo",id_calo)
end subroutine

public subroutine wf_crea_distinta (long al_id_art_padre, long al_id_art);
integer li_righe, li_null, i
long ll_id_dis_variante, ll_id_dis_padre
datastore ds_crea_dis
string ls_cod_articolo

setnull(li_null)
ds_crea_dis=create datastore
ds_crea_dis.dataobject='ds_duplica_distinta'
ds_crea_dis.settransobject(sqlca)
li_righe=ds_crea_dis.retrieve(al_id_art_padre)
if li_righe=1 then 
	
	ds_crea_dis.setitemstatus(1,0,primary!, newmodified!)
	ls_cod_articolo=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "codice")
	
	ll_id_dis_padre=ds_crea_dis.getitemnumber(1, "id_distinta")
	
	ds_crea_dis.setitem(1, "id_articolo", al_id_art)
	
	ds_crea_dis.setitem(1, "id_distinta", li_null)
	
	ds_crea_dis.setitem(1, "codice", ls_cod_articolo)

	
	if ds_crea_dis.update()=1 then
		commit;
		ll_id_dis_variante=ds_crea_dis.getitemnumber(1, "id_distinta")
		ds_crea_dis.dataobject='ds_duplica_r_distinta'
		ds_crea_dis.settransobject(sqlca)
		li_righe=ds_crea_dis.retrieve(ll_id_dis_padre)
		if li_righe>0 then
			for i= 1 to li_righe
				ds_crea_dis.setitemstatus(i,0,primary!, newmodified!)
				ds_crea_dis.setitem(i, "id_distinta", ll_id_dis_variante)
				ds_crea_dis.setitem(i, "id_riga_distinta", li_null)
			next
				if ds_crea_dis.update()=1 then
					commit;
				else
					rollback;
					messagebox("Errore", "Righe Distinta non salvate!")
				end if
		end if
	else
		rollback;
		messagebox("Errore", "Distinta non salvata!")
	end if
	
end if
	
	
	

destroy ds_crea_dis
end subroutine

public subroutine wf_ricalcola_distinta ();s_ricalcola_distinta s_azzera


integer i, li_righe
decimal ld_peso_vecchio, ld_peso_nuovo, ld_qta
datastore ds_agg_peso
ds_agg_peso=create datastore
ds_agg_peso.dataobject='ds_agg_peso_distinta'
ds_agg_peso.settransobject(sqlca)

open(w_agg_attesa)

li_righe=ds_agg_peso.retrieve(is_ric_distinta.id_articolo)
if li_righe>0 then
	ld_peso_nuovo=is_ric_distinta.nuovo_peso
	for i=1 to li_righe
		ld_qta=ds_agg_peso.getitemdecimal(i, "quantita")
		ds_agg_peso.setitem(i, "peso_netto", ld_qta*ld_peso_nuovo)
	next
	
	if ds_agg_peso.update()=1 then
		commit;
		
	else
		rollback;
		
		messagebox("Errore!", "Peso in distinta non aggiornato!")
	end if
end if
close (w_agg_attesa)
is_ric_distinta=s_azzera
end subroutine

public subroutine wf_ricarico (string as_data);string ls_sem, ls_num_riga
long ll_id_art, ll_id_cat
decimal ld_prezzo

ll_id_cat=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_cat_codifica")
select codice
into :ls_sem
from cat_codifica
where id_cat_codifica=:ll_id_cat;
if ls_sem='SEM' then return
ll_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_articolo")
if isnull(ll_id_art) then ll_id_art=0
ld_prezzo=f_ricarico(dec(as_data), ll_id_art)
if ld_prezzo<>dec(as_data) then

	tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1, "prezzo", f_round(ld_prezzo,-2,"S"))
end if


end subroutine

public subroutine wf_messaggio ();
			

end subroutine

public subroutine wf_ins_cod_fo ();string ls_cod_sog, ls_cod_des_parte
long ll_id_cat_codifica

ll_id_cat_codifica=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_cat_codifica")

SELECT   "parte_regola"."descrizione"  
into :ls_cod_des_parte
FROM "dba"."cod_parte", "dba"."parte_regola"  
WHERE  "parte_regola"."id_parte_regola" = "cod_parte"."id_parte_regola" 
and   "cod_parte"."id_cat_codifica" = :ll_id_cat_codifica 
and "parte_regola"."num_sezione"= 1
;
if upper(ls_cod_des_parte)='FORNITORE' then
	ls_cod_sog=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_sog_commerciale_codice")
	if ls_cod_sog>" " then 
			ls_cod_sog=right(ls_cod_sog, 4)
			tab_1.tabpage_1.dw_articolo_gen_ff.Setitem(1, "c_codice_1", ls_cod_sog)
			tab_1.tabpage_1.dw_articolo_gen_ff.trigger event itemchanged(1, tab_1.tabpage_1.dw_articolo_gen_ff.object.c_codice_1, ls_cod_sog)
			tab_1.tabpage_1.dw_articolo_gen_ff.triggerevent("ue_set_part_prog")
			
	end if
end if
end subroutine

public subroutine uf_agg_cod_barre (integer al_row, datawindow adw_art);//
end subroutine

public subroutine wf_conta_vener ();string ls_vener
select max(codice)
into :ls_vener
from dba.articolo
where codice like 'vener%'
;


tab_1.tabpage_1.dw_articolo_gen_ff.object.t_vener.text= ls_vener

end subroutine

public subroutine wf_ins_prezzo_lis_personale ();//09-03-12 per samy: se c'è id_sog_comm_variante (è il cliente per il quale l'articolo sarà prodotto) allora articolo
//e prezzo vanno anche nel suo listino personale (se esiste) Il cliente viene recuperato in automatico all'inserimento dell
//articolo in base alla categoria di codifica (che è inserita ad hoc = alle ultime 3 lettere del codice cliente (speriamo bene, se ci sono due
//sottomastri clienti la cosa va a farsi benedire ....
long ll_id_sog_comm_cliente_variante, ll_righe,ll_riga_inserita
long ll_id_listino, ll_id_variazione, ll_id_uc, ll_riga_trovata, ll_id_um
string ls_tipo,ls_prezzo
decimal ldc_prezzo
datastore ds_prezzo

ds_prezzo=create datastore
ds_prezzo.dataobject="d_orafo_prezzo_variaz_uc_gd"
ds_prezzo.settransobject(sqlca)


ll_id_sog_comm_cliente_variante=tab_1.tabpage_2.dw_articolo_gen2_ff.getitemnumber(1, "id_sog_comm_variante")
if ll_id_sog_comm_cliente_variante>0 then
	select id_listino
	into :ll_id_listino
	from dba.sog_commerciale
	where id_sog_commerciale=:ll_id_sog_comm_cliente_variante
	;
	if ll_id_listino>0 then
		select id_variazione
		into :ll_id_variazione
		from dba.variazione
		where id_listino=:ll_id_listino
		and data_inizio<=today()
		and data_fine>=today()
		;
		if ll_id_variazione>0 then
			ll_riga_trovata=tab_1.tabpage_1.dw_unita_confezione2_lt.find("unita_confezione_unita_base='S'", 1, &
								tab_1.tabpage_1.dw_unita_confezione2_lt.rowcount())
			if ll_riga_trovata>0 then
				ll_id_uc=tab_1.tabpage_1.dw_unita_confezione2_lt.getitemnumber(ll_riga_trovata, "id_unita_confezione")
				ll_id_um=tab_1.tabpage_1.dw_unita_confezione2_lt.getitemnumber(ll_riga_trovata,"id_unita_misura")
				select tipo
				into :ls_tipo
				from dba.unita_misura
				where id_unita_misura=:ll_id_um
				;
				if ls_tipo='P' then 
					ls_prezzo="prezzo_manifattura"
				else
					ls_prezzo="prezzo"
				end if
				ldc_prezzo=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "prezzo")
				ll_righe=ds_prezzo.retrieve(ll_id_variazione, ll_id_uc)
				if isnull(ll_righe) or ll_righe<1 then
					ll_riga_inserita=ds_prezzo.insertrow(0)
					ll_righe=ll_riga_inserita
					ds_prezzo.setitem(ll_riga_inserita, "id_unita_confezione", ll_id_uc)
					ds_prezzo.setitem(ll_riga_inserita, "id_variazione", ll_id_variazione)			
				end if
				ds_prezzo.setitem(ll_righe, ls_prezzo, ldc_prezzo)
				if ds_prezzo.update() =1 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Prezzo nel listino personale/variante non salvato!")
				end if
					
			end if
			
		end if
	end if
end if

destroy ds_prezzo
end subroutine

public subroutine uf_mostra_immagine (string immagine);string ls_immagine
	if Pos(immagine, "\")>0 then
		ls_immagine=immagine
	else
		select dir_immagini
		into :ls_immagine
		from par_sistema;
		if right(ls_immagine,1) <> "\" then ls_immagine = ls_immagine+"\"
		if ls_immagine<>"" and not isnull(ls_immagine) then
			ls_immagine+=immagine
		end if
	end if
	if FileExists(ls_immagine) then

//		tab_1.tabpage_1.p1.object.aspectratio=1
		tab_1.tabpage_1.p_1.picturename=ls_immagine
//	else
//		tab_1.tabpage_1.ole_imm.object.delimage=true
	end if
end subroutine

on w_orafo_articolo_cx.create
int iCurrent
call super::create
end on

on w_orafo_articolo_cx.destroy
call super::destroy
end on

event close;call super::close;
if isvalid(w_orafo_variante_gd) then
	close(w_orafo_variante_gd)
end if
end event

event open;call super::open;string ls_azienda

tab_1.movetab(8,2)
tab_1.tabpage_1.dw_3.settransobject(sqlca)
post wf_conta_vener()

//per samy 02-11-17
if idw_master.is_list.s_provenienza> " " then idw_master.is_list.s_win_parametri=idw_master.is_list.s_provenienza
//fine


end event

event ue_post_open;call super::ue_post_open;integer li_titolo
string ls_cod,ls_azienda
long ll_id_titolo

select codice
into :ls_cod
from azienda
where id_azienda=1;
if ls_cod="FANTASY" THEN
	tab_1.tabpage_1.dw_articolo_gen_ff.modify("id_colore.visible=0")
	tab_1.tabpage_1.dw_articolo_gen_ff.modify("id_colore_t.visible=0")
	select t.id_titolo 
	into :ll_id_titolo
	from orafo_titolo t, orafo_metallo m
	where t.id_metallo=m.id_metallo
	and m.codice='AG'
	and t.titolo=925;
	if ll_id_titolo>0 then
		tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1, "id_titolo", ll_id_titolo)
		tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1, "coef_calo", 1000)
	end if
END IF

if idw_master.is_list.s_win_parametri> "" then
	if idw_master.is_list.s_win_parametri = 'AG' then 
		li_titolo=925
	else
		li_titolo=1000
	end if
	select id_titolo
	into :ll_id_titolo
	from dba.orafo_titolo t, dba.orafo_metallo m
	where m.codice= :idw_master.is_list.s_win_parametri
	and m.id_metallo=t.id_metallo
	and t.titolo=:li_titolo
	;
	if ll_id_titolo>0 then
		tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1, "id_titolo", ll_id_titolo)
		tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1, "coef_calo", 1000)
	end if
end if
//20221114 per visualizare cod barre su cod_intrastat
select rag_soc_1 into :ls_azienda from dba.azienda; 
if pos(upper(ls_azienda),"SILVER DR") >0 then
	tab_1.tabpage_4.dw_articolo_altro_ff.modify("cod_intrastat.height=290")
	tab_1.tabpage_4.dw_articolo_altro_ff.modify("cod_intrastat.font.face='EAN-13'")
	tab_1.tabpage_4.dw_articolo_altro_ff.modify("cod_intrastat.font.height= -32")
end if
end event

type p_msg_log from w_articolo_cx`p_msg_log within w_orafo_articolo_cx
integer x = 1435
integer y = 36
integer height = 84
end type

type p_crescente from w_articolo_cx`p_crescente within w_orafo_articolo_cx
end type

type p_decrescente from w_articolo_cx`p_decrescente within w_orafo_articolo_cx
end type

type cb_ok from w_articolo_cx`cb_ok within w_orafo_articolo_cx
integer x = 32
end type

type cb_annulla from w_articolo_cx`cb_annulla within w_orafo_articolo_cx
end type

type cb_nuovo from w_articolo_cx`cb_nuovo within w_orafo_articolo_cx
integer x = 512
end type

event cb_nuovo::clicked;long ll_riga
decimal coef_calo
tab_1.tabpage_1.dw_3.reset()

ll_riga = tab_1.tabpage_1.dw_articolo_gen_ff.GetRow()
il_id_titolo = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_riga,"id_titolo")
id_coeff_calo = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_riga,"coeff_calo")
ii_colore = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_riga,"id_colore")
id_calo = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_riga,"coef_calo")

call super::clicked

uf_mostra_immagine("")
post wf_proponi_titolo()


end event

type cb_inserisci from w_articolo_cx`cb_inserisci within w_orafo_articolo_cx
integer x = 1833
end type

type cb_cancella from w_articolo_cx`cb_cancella within w_orafo_articolo_cx
integer x = 2318
end type

type cb_salva from w_articolo_cx`cb_salva within w_orafo_articolo_cx
end type

event cb_salva::clicked;call super::clicked;//
end event

type tab_1 from w_articolo_cx`tab_1 within w_orafo_articolo_cx
integer x = 23
integer y = 160
integer width = 2875
integer height = 1756
end type

type tabpage_1 from w_articolo_cx`tabpage_1 within tab_1
integer width = 2839
integer height = 1636
cb_peso_netto cb_peso_netto
cb_classe cb_classe
dw_3 dw_3
p_1 p_1
end type

on tabpage_1.create
this.cb_peso_netto=create cb_peso_netto
this.cb_classe=create cb_classe
this.dw_3=create dw_3
this.p_1=create p_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_peso_netto
this.Control[iCurrent+2]=this.cb_classe
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.p_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_peso_netto)
destroy(this.cb_classe)
destroy(this.dw_3)
destroy(this.p_1)
end on

type cb_codice from w_articolo_cx`cb_codice within tabpage_1
boolean visible = false
integer x = 1787
integer y = 152
integer taborder = 60
end type

type st_information from w_articolo_cx`st_information within tabpage_1
end type

type dw_unita_confezione2_lt from w_articolo_cx`dw_unita_confezione2_lt within tabpage_1
integer x = 0
integer y = 1276
integer width = 2802
integer height = 336
integer taborder = 69
string dataobject = "d_orafo_unita_confezione2_lt"
boolean hscrollbar = false
end type

event dw_unita_confezione2_lt::ue_init;call super::ue_init;
is_resp_window = "w_orafo_unita_confezione_ff"

end event

event dw_unita_confezione2_lt::itemchanged;decimal{4} ld_dim_l, ld_peso_netto, ld_conv_misura_peso, ld_cmp



choose case string (dwo.name)
	     
		  
	case "unita_confezione_peso_netto" 
		
		ld_dim_l=dw_unita_confezione2_lt.getitemdecimal(row,"unita_confezione_dim_l")
		
		ld_cmp=dw_unita_confezione2_lt.getitemdecimal(row,"conv_misura_peso")
		
		if ld_dim_l>0 and not isnull(ld_dim_l) then
			ld_peso_netto=dec(data)
			ld_conv_misura_peso=ld_peso_netto/ld_dim_l 
         setitem(row, "conv_misura_peso", ld_conv_misura_peso)
	   end if
		
		is_ric_distinta.vecchio_peso=getitemdecimal(row, "unita_confezione_peso_netto")
		is_ric_distinta.nuovo_peso=dec(data)
	   	is_ric_distinta.id_articolo=dw_articolo_gen_ff.getitemnumber(1, "id_articolo")
	
	case "unita_confezione_dim_l"
	    ld_peso_netto=dw_unita_confezione2_lt.getitemdecimal(row,"unita_confezione_peso_netto")
       
		 ld_cmp=dw_unita_confezione2_lt.getitemdecimal(row,"conv_misura_peso")
		
		if ld_peso_netto>0 and not isnull(ld_peso_netto) then
			ld_dim_l=dec(data)
			if ld_dim_l >0 and not isnull(ld_dim_l) then 
				ld_conv_misura_peso=ld_peso_netto/ld_dim_l 
   	      setitem(row, "conv_misura_peso", ld_conv_misura_peso)
			end if	
	   end if	
end choose







if "conv_misura_peso"=(dwo.name) then
	  ld_conv_misura_peso=getitemdecimal(row,"conv_misura_peso") 
	  if ld_conv_misura_peso <> dec(data) then
		    messagebox("Controllo", "Incongruenza tra i dati inseriti ~re l'attuale Conversione Misura/Peso")
	  end if
end if	  



end event

event dw_unita_confezione2_lt::updateend;long ll_id_cat_codifica
string ls_cod

if rowsupdated>0 then
	if is_ric_distinta.id_articolo>0 then
		
		post wf_ricalcola_distinta()
		
	end if
end if


end event

type cb_ingrandisci_immagine from w_articolo_cx`cb_ingrandisci_immagine within tabpage_1
integer x = 2135
integer y = 364
end type

type cb_2 from w_articolo_cx`cb_2 within tabpage_1
integer x = 2560
integer y = 1292
end type

type ole_imm from w_articolo_cx`ole_imm within tabpage_1
integer x = 2126
integer y = 36
integer width = 576
integer height = 320
end type

event ole_imm::doubleclicked;call super::doubleclicked;
end event

type dw_articolo_gen_ff from w_articolo_cx`dw_articolo_gen_ff within tabpage_1
event ue_post_itemchanged ( long al_riga,  string as_colonna,  long al_valore )
integer x = 18
integer y = 20
integer width = 2807
integer height = 1248
integer taborder = 10
string dataobject = "d_orafo_articolo_gen_ff"
end type

event dw_articolo_gen_ff::ue_post_itemchanged;call super::ue_post_itemchanged;this.SetItem(al_riga,as_colonna,al_valore)


end event

event dw_articolo_gen_ff::updatestart;call super::updatestart;long row, ll_titolo, ll_id_articolo, ll_id_cat_codifica, ll_id_sog, ll_id_reparto
decimal ld_titolo
string ls_cod_art, ls_null, ls_cat_codifica
row=tab_1.tabpage_1.dw_articolo_gen_ff.getRow()
if row>0 then
	row=1
	
	ll_titolo=tab_1.tabpage_1.dw_articolo_gen_ff.GetItemDecimal(row,"id_titolo")
	if isnull(ll_titolo) then
		messagebox("Attenzione!", "Il titolo è obbligatorio!")
		rollback;
		return 1
	end if
	
	if IsNull(tab_1.tabpage_1.dw_articolo_gen_ff.GetItemDecimal(row,"coef_calo")) then
		select titolo
		into :ld_titolo
		from orafo_titolo
		where orafo_titolo.id_titolo=:ll_titolo;
		tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(row,"coef_calo",ld_titolo)
	end if
	//08-03-12 per samy aggiungo soggetto legato all'articolo per aggiornare listino personale
	ll_id_cat_codifica=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_cat_codifica")
	select codice
	into :ls_cat_codifica
	from dba.cat_codifica
	where id_cat_codifica=:ll_id_cat_codifica;
	//aggiunto per Paolo (samy) 15-05-2014 ritoccato 12-04-2016: or ll_id_cat_codifica=65
	If ls_cat_codifica='PAOL' or ll_id_cat_codifica=65 then
		select id_reparto
		into :ll_id_reparto
		from reparto
		where codice='PAOL'
		;
		if ll_id_reparto>0 then
			setitem(row, "id_reparto_des", ll_id_reparto)
		end if
	end if
	//fine aggiunto per Paolo (samy) 15-05-2014
	ls_cat_codifica='CL010'+ls_cat_codifica
	select id_sog_commerciale
	into :ll_id_sog
	from sog_commerciale
	where codice=:ls_cat_codifica;
	if ll_id_sog>0 then
		tab_1.tabpage_2.dw_articolo_gen2_ff.setitem(1, "id_sog_comm_variante", ll_id_sog)
	end if
end if
if dw_unita_confezione2_lt.rowcount()>0 then
	ll_id_articolo=dw_unita_confezione2_lt.getitemnumber(1, "id_articolo") 
	if ll_id_articolo>0 then
		if il_old_variante>0 then
			setitem(1, "spina", "variante")
		else
			setnull(ls_null)
			setitem(1, "spina", ls_null)
		end if
	end if
end if





end event

event dw_articolo_gen_ff::itemchanged;call super::itemchanged;
long ll_id_cat_cod, ll_null
string ls_codice, ls_null, ls_sem
long ll_tit, ll_titolo, ll_id_art
string ls_code
decimal ld_prezzo

choose case dwo.name
		
		
	CASE "id_articolo"	
		ll_id_art=long(data)
		idw_master.is_list.s_identifica[1] = "id_articolo"
		idw_master.is_list.l_identifica[1] = ll_id_art
		SetPointer(HourGlass!)
		this.enabled= FALSE
		idw_master.Event ue_retrieve(0, 0)
		tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")
		this.enabled= truE
		
		
		
	case "id_cat_codifica" 
		if il_old_variante<=0 then
			setnull(ls_null)
			setitem(1, "spina", ls_null)
		end if

	
//	ll_id_cat_cod=long(data)  //commentato 11-03-2020 perché inutile e non mi ricordo a chi servisse
//	select codice
//	into :ls_codice
//	from cat_codifica
//	where id_cat_codifica=:ll_id_cat_cod;
//	if ls_codice='PIET' then
//		this.object.id_pietra.visible=1
//	else
//		this.object.id_pietra.visible=0
//		SetNull(ll_null)
//		this.event post ue_post_itemchanged(row,"id_pietra",ll_null)
//	end if
	
	case "id_titolo" 
		ll_id_cat_cod=getitemnumber(1, "id_articolo")
		if ll_id_cat_cod>0 and not isnull(ll_id_cat_cod) then 
			
			ll_titolo=getitemnumber(1, "id_titolo")
			
			select id_articolo
			into :ll_tit
			from riga_documento 
			where id_articolo=:ll_id_cat_cod;
			if ll_tit>0 and not isnull(ll_tit) then
				messagebox("Attenzione!", "Articolo già movimentato: impossibile cambiare titolo")
				post setitem(1, "id_titolo", ll_titolo)
				return
			end if
		END IF
		
		ll_tit = long(data)
		
		  SELECT   
				"orafo_metallo"."codice",   
				"orafo_titolo"."titolo"   
		  into :ls_code, :ll_titolo  
		 FROM "orafo_titolo",   
				"orafo_metallo"  
		WHERE (( "orafo_titolo"."id_titolo" = :ll_tit ) and 
		( "orafo_metallo"."id_metallo" = "orafo_titolo"."id_metallo" ));
		if idw_master.is_list.s_win_parametri> "" then
			if ls_code<> idw_master.is_list.s_win_parametri then
				messagebox("Attenzione!", "In questa modalità di inserimento NON puoi inserire metalli diversi da "+ idw_master.is_list.s_win_parametri)
				return 2
			end if
		end if
		
		
		
		
		if (ll_titolo = 925) then
			setItem(1,"coef_calo",1000)
		else 
			setnull(ll_null)
			setItem(1,"coef_calo",ll_null)
		end if
		
		
		
	case "prezzo_for"
		post wf_ricarico(data)
		
	case "c_sog_commerciale_codice", "c_anagrafica_b_rag_soc_1"
		post wf_ins_cod_fo()
		
end choose

end event

event dw_articolo_gen_ff::retrieveend;call super::retrieveend;long ll_id_cat_cod
string ls_codice, ls_null
if rowcount<>0 then
		ll_id_cat_cod=this.getItemNumber(rowcount,"id_cat_codifica")
		select codice
		into :ls_codice
		from cat_codifica
		where id_cat_codifica=:ll_id_cat_cod;
		if ls_codice='PIET' then
			this.object.id_pietra.visible=1
		else
			this.object.id_pietra.visible=0
		end if

end if

post wf_conta_vener()
end event

event dw_articolo_gen_ff::ue_init;call super::ue_init;window 	lw_parent
tab    	lw_tab

iudw_children[1] = tab_1.tabpage_1.dw_unita_confezione2_lt
iudw_children[2] = tab_1.tabpage_2.dw_articolo_gen2_ff
iudw_children[3] = tab_1.tabpage_3.dw_sostituzione_gd
iudw_children[4] = tab_1.tabpage_3.dw_articoli_sostituiti_gd
iudw_children[5] = tab_1.tabpage_4.dw_articolo_altro_ff
iudw_children[6] = tab_1.tabpage_6.dw_des_articolo_lt
iudw_children[7] = tab_1.tabpage_6.dw_approvvigionamento_gd
iudw_children[8] = tab_1.tabpage_list_generici.dw_listino_var_base_articolo_lt



lw_tab = Parent.GetParent()
lw_parent = lw_tab.GetParent()
is_title_modifica = lw_parent.Title

end event

event dw_articolo_gen_ff::updateend;long ll_id_articolo, ll_id_uc, ll_id_art_padre, ll_id_cat_codifica, ll_row
integer i, li_righe
string ls_cod

li_righe=dw_unita_confezione2_lt.rowcount()

if li_righe>0 and rowsinserted>0 then
	ll_id_uc=dw_unita_confezione2_lt.getitemnumber(1,"id_unita_confezione")
	if getitemstring(1, "spina")='variante' and isnull(ll_id_uc) then
		
		
		ll_id_articolo=getitemnumber(1, "id_articolo")
		ll_id_art_padre=dw_unita_confezione2_lt.getitemnumber(1, "id_articolo")
		for i= 1 to li_righe
			dw_unita_confezione2_lt.setitemstatus(i,0, primary!, newmodified!)
			dw_unita_confezione2_lt.setitem(i, "id_articolo", ll_id_articolo)
		next
		
		
		i=dw_unita_confezione2_lt.update()
		if i=1 then
			commit;
			wf_crea_distinta(ll_id_art_padre, ll_id_articolo)
			
		else
			rollback;
			messagebox("Errore", "UC non salvata!")
		end if
	end if
end if
Super::EVENT updateend(rowsinserted,rowsupdated,rowsdeleted)

if rowsinserted>0 then
	wf_messaggio()
end if
//09-03-12 per samy: se c'è id_sog_comm_variante (è il cliente per il quale l'articolo sarà prodotto) allora articolo
//e prezzo vanno anche nel suo listino personale (se esiste) Il cliente viene recuperato in automatico all'inserimento dell
//articolo in base alla categoria di codifica (che è inserita ad hoc = alle ultime 3 lettere del codice cliente (speriamo bene, se ci sono due
//sottomastri clienti la cosa va a farsi benedire ....
if  rowsupdated+rowsinserted>0 then
	//post
	post wf_ins_prezzo_lis_personale()
	ll_row=GetRow()
	//post 
	post wf_aggiungi_prezzo_a_listino(ll_row, this)  //aggiunto 20231129 NON salvava il prezzo in alcun listino....
//	Post uf_agg_cod_barre(ll_row, this)
end if
end event

event dw_articolo_gen_ff::ue_key;call super::ue_key;
end event

event dw_articolo_gen_ff::losefocus;call super::losefocus;
if getrow()>0 then
	if getitemstring(getrow(), "prod_interna")='S' then
			if getcolumn()=56 then
			dw_unita_confezione2_lt.post setfocus()
			dw_unita_confezione2_lt.post setcolumn("unita_confezione_peso_netto")
		end if
	else
		if getcolumn()=44 then
			dw_unita_confezione2_lt.post setfocus()
			dw_unita_confezione2_lt.post setcolumn("unita_confezione_peso_netto")
		end if
	end if
end if
end event

event dw_articolo_gen_ff::ue_use_search;call super::ue_use_search;choose case as_nomecol 
	case "c_sog_commerciale_codice", "c_anagrafica_b_rag_soc_1"
	post wf_ins_cod_fo()
	
end choose
end event

event dw_articolo_gen_ff::ue_initial;call super::ue_initial;long ll_id_titolo, ll_id_cat_com_art

post wf_conta_vener()
select min(id_cat_com_articolo)
into :ll_id_cat_com_art
from dba.cat_com_articolo
;
if ll_id_cat_com_art>0 then setitem(1, "id_cat_com_articolo", ll_id_cat_com_art)

if idw_master.is_list.s_win_parametri> "" then
	choose case  idw_master.is_list.s_win_parametri
		case "AG"
			select id_titolo
			into  :ll_id_titolo
			from dba.orafo_metallo m, dba.orafo_titolo t
			where m.id_metallo=t.id_metallo
			and m.codice='AG'
			and t.titolo=925
			;
			post setitem(1, "id_titolo", ll_id_titolo)
			
		case "BZ"
			select id_titolo
			into  :ll_id_titolo
			from dba.orafo_metallo m, dba.orafo_titolo t
			where m.id_metallo=t.id_metallo
			and m.codice='BZ'
			and t.titolo=1000
			;
			post setitem(1, "id_titolo", ll_id_titolo)
		case "SI"
			select id_titolo
			into  :ll_id_titolo
			from dba.orafo_metallo m, dba.orafo_titolo t
			where m.id_metallo=t.id_metallo
			and m.codice='SI'
			and t.titolo=1000
			;
			post setitem(1, "id_titolo", ll_id_titolo)
		case "OT"
			select id_titolo
			into  :ll_id_titolo
			from dba.orafo_metallo m, dba.orafo_titolo t
			where m.id_metallo=t.id_metallo
			and m.codice='OT'
			and t.titolo=1000
			;
			post setitem(1, "id_titolo", ll_id_titolo)
			
	end choose
end if
end event

event dw_articolo_gen_ff::itemfocuschanged;call super::itemfocuschanged;long ll_id_cat_cod


if dwo.name='c_codice_1' then
	ll_id_cat_cod=getitemnumber(1, "id_cat_codifica")
	if ll_id_cat_cod=100000 then
		object.c_codice_1.width=400
		object.c_codice_2.visible=true
		object.c_codice_2.x=	object.c_codice_1.x + 	object.c_codice_1.width
	end if
	
end if
end event

event dw_articolo_gen_ff::clicked;call super::clicked;//p_ricerca_id

long ll_id_art, ll_row
string ls_id_art
if dwo.name='p_ricerca_id' then
	ll_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_articolo")
	if ll_id_art>0 then
		
	else
		tab_1.tabpage_1.dw_articolo_gen_ff.accepttext()
		ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "codice")
		ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_1")
		
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_2")
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_3")
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_4")
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_5")
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_6")
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_7")
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_8")
		if isnull(ls_id_art) then ls_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "c_codice_9")
		if isnumber(ls_id_art) then
			ll_id_art=long(ls_id_art)
			idw_master.is_list.s_modo = modo_modifica
				idw_master.is_list.s_identifica[1] = "id_articolo"
				idw_master.is_list.l_identifica[1] = ll_id_art
				SetPointer(HourGlass!)
				
				this.enabled= FALSE
				idw_master.Event ue_retrieve(0, 0)
				tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")
				this.enabled= true
//				ll_row = ldw_gen.getRow()
		end if
	end if
end if
end event

type tabpage_2 from w_articolo_cx`tabpage_2 within tab_1
integer width = 2839
integer height = 1636
end type

type dw_articolo_gen2_ff from w_articolo_cx`dw_articolo_gen2_ff within tabpage_2
integer x = 18
integer width = 2670
integer height = 1228
string dataobject = "d_orafo_articolo_gen2_ff"
end type

event dw_articolo_gen2_ff::ue_init;call super::ue_init;is_list.s_colonne_drop[1]="id_gruppo_articoli_cod"
is_list.s_colonne_drop[2]="id_gruppo_articoli_des"
is_list.s_colonne_drop[3]="id_cat_merceologica_cod"
is_list.s_colonne_drop[4]="id_cat_merceologica_des"
is_list.s_colonne_drop[5]="id_cat_fiscale_cod"
is_list.s_colonne_drop[6]="id_cat_fiscale_des"
is_list.s_colonne_drop[7]="id_reparto_cod"
is_list.s_colonne_drop[8]="id_reparto_des"
is_list.s_colonne_drop[9]="id_tab_iva_cod"
is_list.s_colonne_drop[10]="id_tab_iva_des"
is_list.s_colonne_drop[11]="id_valuta"
is_list.s_colonne_drop[12]="id_tipo_cod_barre"
is_list.s_colonne_drop[13]="cod_barre"
end event

type tabpage_3 from w_articolo_cx`tabpage_3 within tab_1
integer width = 2839
integer height = 1636
end type

type dw_articoli_sostituiti_gd from w_articolo_cx`dw_articoli_sostituiti_gd within tabpage_3
integer taborder = 10
string dataobject = "d_orafo_articoli_sostituiti_gd"
end type

type st_1 from w_articolo_cx`st_1 within tabpage_3
end type

type dw_sostituzione_gd from w_articolo_cx`dw_sostituzione_gd within tabpage_3
integer height = 588
integer taborder = 20
string dataobject = "d_orafo_sostituzione_gd"
end type

type st_2 from w_articolo_cx`st_2 within tabpage_3
end type

type tabpage_4 from w_articolo_cx`tabpage_4 within tab_1
integer width = 2839
integer height = 1636
end type

type dw_articolo_altro_ff from w_articolo_cx`dw_articolo_altro_ff within tabpage_4
integer height = 1508
string dataobject = "d_orafo_articolo_altro_ff"
end type

type tabpage_5 from w_articolo_cx`tabpage_5 within tab_1
integer width = 2839
integer height = 1636
end type

type tabpage_6 from w_articolo_cx`tabpage_6 within tab_1
integer width = 2839
integer height = 1636
end type

type dw_des_articolo_lt from w_articolo_cx`dw_des_articolo_lt within tabpage_6
integer width = 2688
string dataobject = "d_orafo_des_articolo_lt"
end type

type st_5 from w_articolo_cx`st_5 within tabpage_6
end type

type st_6 from w_articolo_cx`st_6 within tabpage_6
end type

type dw_approvvigionamento_gd from w_articolo_cx`dw_approvvigionamento_gd within tabpage_6
integer width = 2688
string dataobject = "d_orafo_approvvigionamento_gd"
end type

type tabpage_list_generici from w_articolo_cx`tabpage_list_generici within tab_1
integer width = 2839
integer height = 1636
end type

type dw_listino_var_base_articolo_lt from w_articolo_cx`dw_listino_var_base_articolo_lt within tabpage_list_generici
integer x = 9
integer width = 2697
string dataobject = "d_orafo_listino_var_base_art_gd"
end type

event dw_listino_var_base_articolo_lt::ue_init;call super::ue_init;is_resp_window = "w_orafo_listino_cx"


end event

type cb_ricerca from w_articolo_cx`cb_ricerca within w_orafo_articolo_cx
integer x = 1573
end type

event cb_ricerca::clicked;call super::clicked;long ll_id_art

ll_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_articolo")
tab_1.tabpage_1.dw_3.reset()
tab_1.tabpage_1.dw_3.retrieve(ll_id_art)
end event

type cb_locazione from w_articolo_cx`cb_locazione within w_orafo_articolo_cx
integer x = 754
integer taborder = 20
end type

type cb_1 from w_articolo_cx`cb_1 within w_orafo_articolo_cx
integer x = 1093
integer taborder = 50
end type

type cb_varianti from w_articolo_cx`cb_varianti within w_orafo_articolo_cx
integer x = 2523
integer y = 148
integer taborder = 30
end type

type cb_duplica from w_articolo_cx`cb_duplica within w_orafo_articolo_cx
integer x = 2075
integer taborder = 60
end type

type cb_peso_netto from commandbutton within tabpage_1
integer x = 887
integer y = 1292
integer width = 251
integer height = 108
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Legato"
end type

event clicked;boolean lb_controllo
string ls_prova
char lc_rit[255]
long	ll_row
lc_rit=space(255)
ls_prova='Mettler 16'
lb_controllo=GetWeight(ls_prova,lc_rit)
ll_row = tab_1.tabpage_1.dw_unita_confezione2_lt.getrow()
tab_1.tabpage_1.dw_unita_confezione2_lt.setitem(ll_row,"unita_confezione_peso_netto",dec(string(lc_rit)))
end event

type cb_classe from commandbutton within tabpage_1
integer x = 96
integer y = 232
integer width = 233
integer height = 76
integer taborder = 43
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Classe"
end type

event clicked;st_ass_art_sottoclasse st_associa
long ll_riga, ll_righe
s_recupera_classe s_classe
integer i
st_associa.id_articolo =  tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_articolo")
if st_associa.id_articolo>0 then
	openwithparm(w_classe_struttura_cx, "Articolo")
	s_classe=message.powerobjectparm
	if isvalid(s_classe) then
		delete from classe_articolo
		where id_articolo=:st_associa.id_articolo;
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Errore!", "Non cancellate Classi!")
		end if
		dw_3.reset()
		for i=upperbound(s_classe.id_classe) to 1 step -1 
			ll_riga=dw_3.insertrow(0)
			dw_3.setitem(ll_riga, "id_classe", s_classe.id_classe[i])
			dw_3.setitem(ll_riga, "cod_classe", s_classe.cod_classe[i])
			dw_3.setitem(ll_riga, "classe_articolo_id_articolo", st_associa.id_articolo)
			dw_3.setitem(ll_riga, "classe_livello", i)
		next
		dw_3.sort()
		if dw_3.update()=1 then
			commit;
		else
			rollback;
			messagebox("Errore!", "Non salvate Classi!")
		end if
	end if
end if
end event

type dw_3 from udw_base within tabpage_1
integer x = 32
integer y = 312
integer width = 366
integer height = 288
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_classe_art_lt"
end type

type p_1 from picture within tabpage_1
integer x = 2135
integer y = 36
integer width = 672
integer height = 396
boolean bringtotop = true
boolean focusrectangle = false
end type

