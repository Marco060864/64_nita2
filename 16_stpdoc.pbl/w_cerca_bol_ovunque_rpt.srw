forward
global type w_cerca_bol_ovunque_rpt from w_stampa_001
end type
type cbx_1 from checkbox within w_cerca_bol_ovunque_rpt
end type
end forward

global type w_cerca_bol_ovunque_rpt from w_stampa_001
integer width = 5687
cbx_1 cbx_1
end type
global w_cerca_bol_ovunque_rpt w_cerca_bol_ovunque_rpt

type variables
s_param_articoli s_par
end variables

forward prototypes
public subroutine wf_insert_riga_derivata ()
end prototypes

public subroutine wf_insert_riga_derivata ();integer i, li_num_riga
long ll_num_prog, ll_id_riga_doc, ll_id_riga_rip, ll_riga_inserita // ,ll_righe
string ls_num_doc, ls_des, ls_cod_prof, ls_rag_soc
date ldt_data_doc
decimal ldc_qta, ldc_peso

//ll_righe=dw_1.rowcount()
for i=2 to dw_1.rowcount()  //salto la bollettina i cui derivati li ho tutti
	
	if dw_1.getitemstring(i, "prof_documento_codice")='RIP' then
		ll_id_riga_rip=dw_1.getitemnumber(i, "id_riga_documento")
		declare c_trova cursor for
		SELECT "documento"."num_progressivo",   	"documento"."num_documento",   "documento"."data_documento",   
				"riga_documento"."num_riga",   "riga_documento"."descrizione",   "riga_documento"."quantita",   
				"riga_documento"."peso_netto",  "sog_commerciale_gen"."rag_soc_1",  "prof_documento"."codice"
		 FROM "riga_documento",   	"documento", "sog_commerciale_gen",   "prof_documento",  "registro"  
		WHERE ( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
				( "documento"."id_sog_commerciale" = "sog_commerciale_gen"."id_sog_commerciale" ) and  
				( "documento"."id_prof_documento" = "prof_documento"."id_prof_documento" ) and  
				( "documento"."id_registro" = "registro"."id_registro" ) and  
				(  id_riga_doc_provenienza =:ll_id_riga_rip   OR   provv_imp_subage_2 =:ll_id_riga_rip  )
		;
		open c_trova;
		ll_num_prog=0
		fetch 	c_trova into :ll_num_prog, :ls_num_doc, :ldt_data_doc, :li_num_riga, :ls_des, 
						:ldc_qta, :ldc_peso,  :ls_rag_soc, :ls_cod_prof;
		do while ll_num_prog>0 
		
			ll_riga_inserita=dw_1.insertrow(i+1)
			i++
//			ll_righe++
			dw_1.setitem(ll_riga_inserita, "prof_documento_codice", ls_cod_prof)
			dw_1.setitem(ll_riga_inserita, "num_progressivo", ll_num_prog)
			dw_1.setitem(ll_riga_inserita, "num_documento", ls_num_doc)
			dw_1.setitem(ll_riga_inserita, "data_documento", ldt_data_doc)
			dw_1.setitem(ll_riga_inserita, "rag_soc_1", ls_rag_soc)
			dw_1.setitem(ll_riga_inserita, "num_riga", li_num_riga)
			dw_1.setitem(ll_riga_inserita, "descrizione", ls_des)
			dw_1.setitem(ll_riga_inserita, "peso_netto", ldc_peso)
			dw_1.setitem(ll_riga_inserita, "quantita", ldc_qta)
			ll_num_prog=0
			fetch 	c_trova into :ll_num_prog, :ls_num_doc, :ldt_data_doc, :li_num_riga, :ls_des, 
						:ldc_qta, :ldc_peso,  :ls_rag_soc, :ls_cod_prof;
		loop
		close c_trova;
	end if
next
	
end subroutine

on w_cerca_bol_ovunque_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_cerca_bol_ovunque_rpt.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;string ls_num_doc,ls_rag_sociale
long ll_id_riga, ll_numprog,ll_id_doc_bol, ll_num_bol


s_par=message.powerobjectparm
select rag_soc_1 into :ls_rag_sociale from dba.azienda;
if pos(upper(ls_rag_sociale), "ITALPANNA")>0 then
	ll_num_bol=long(right(s_par.da_sog_comm, 5))
	dw_1.dataobject="d_cerca_bol_mun"
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ll_num_bol)
else
	//s_par.da_sog_comm = right(s_par.da_sog_comm , 5)  //da portare a 7 o toglliere???? 20220808
	select id_riga_documento, d.num_progressivo, d.id_documento
	into :ll_id_riga, :ll_numprog, :ll_id_doc_bol
	from dba.riga_documento r, dba.documento d, registro reg, esercizio e
	where r.id_documento=d.id_documento
	and  right(d.num_documento, 7) = :s_par.da_sog_comm //è il num_bollettina = agli ultimi 5 caratteri del num_documento e univoco  //20220131 ora sono 7 caratteri
	and d.id_registro=reg.id_registro
	and reg.id_esercizio=e.id_esercizio
	and e.data_inizio<=d.data_documento and e.data_fine>=d.data_documento
	and (d.id_prof_documento=65 or d.id_prof_documento=111 or d.id_prof_documento=112 or d.id_prof_documento=113 or d.id_prof_documento=230 )  //221019 aggiutni obol, bbol e 2bol
	;
	if ll_id_riga> 0 then
		//messagebox("Attenzione!",  ll_id_riga)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(ll_id_riga, ll_id_doc_bol)
	//	post event ue_post_open()
	else
		messagebox("Attenzione!", "Bollettina non trovata!")
	end if
	//IF s_par.bollo= "d_cerca_bol_no_fo_tb" then
	//	dw_1.dataobject="d_cerca_bol_no_fo_tb"
	//	dw_1.settransobject(sqlca)
	//
	//	dw_1.retrieve(s_par.da_data, s_par.a_data)
	//else
	//	dw_1.settransobject(sqlca)
	//	dw_1.retrieve(s_par.da_data, s_par.a_data)
	//end if
	post wf_insert_riga_derivata()
end if
end event

event ue_post_open;call super::ue_post_open;long i, ll_test, ll_id_riga_bol
string ls_qta, ls_ancora_qui, ls_prof_doc
//datawindowchild dw_robol

decimal ldc_qta, ldc_qta_tot, ldc_peso, ldc_peso_tot
//integer li_ret


wf_insert_riga_derivata()
ls_ancora_qui=s_par.par_stampa
for i = 1 to dw_1.rowcount()
	
	if long(dw_1.Object.dw_rbol[i].object.datawindow.lastrowonpage)>=1 then
		ldc_qta=dw_1.Object.dw_rbol[i].object.riga_documento_quantita[1]
		ldc_peso=dw_1.Object.dw_rbol[i].object.riga_documento_peso_netto[1]
		if ldc_qta>0 then
			ldc_qta_tot+=ldc_qta
		end if
		if ldc_peso>0 then
			ldc_peso_tot+=ldc_peso
		end if
	end if
	if ls_ancora_qui='S' then
		ll_test=0
		ll_id_riga_bol=dw_1.getitemnumber(i, "riga_documento_id_riga_documento")
		select id_riga_documento
		into :ll_test
		from dba.riga_documento r, dba.documento d
		where id_riga_Doc_provenienza=:ll_id_riga_bol
		and d.id_documento=r.id_documento
		and ( d.id_prof_documento=114 or d.id_prof_documento= 66)
		;
		
		if ll_test>0 then
			dw_1.setitem(i, "c_visibile", -1)
			
		end if
	end if
next
if ls_ancora_qui='S' then
	dw_1.setfilter("c_visibile>=0")
	dw_1.filter()
end if
//messagebox("W", string(ldc_qta_tot))
dw_1.modify("t_tot_qta.text='Totale Q.ta RBOL: "+string(ldc_qta_tot, "#,0")+"'")
dw_1.modify("t_tot_peso.text='"+string(ldc_peso_tot, "#,0")+"'")






end event

type dw_1 from w_stampa_001`dw_1 within w_cerca_bol_ovunque_rpt
integer x = 27
integer y = 128
integer width = 5563
integer height = 1496
string dataobject = "d_trova_bol_ovunque"
end type

event dw_1::sqlpreview;call super::sqlpreview;//string ls_sql
//
//ls_sql=sqlsyntax
//if s_par.ll_magazzino>0 then
//	ls_sql+=" and riga_documento.id_articolo="+string(s_par.ll_magazzino)+" "
//	
//end if
//
//if s_par.da_sog_comm> " " then
//	if left(s_par.da_sog_comm, 1)="-" then
//		ls_sql+=" and documento.num_documento like '%"+right(s_par.da_sog_comm, 5)+"' "
//	else
//		ls_sql+=" and documento.num_documento like '"+s_par.da_sog_comm+"%' "
//	end if
//end if
//
//if s_par.id_variazione>0 then
//	ls_sql+=" and documento.id_prof_documento="+string(s_par.id_variazione)+" "
//	
//end if
//if s_par.id_cat_codifica> 0 then
//	ls_sql+=" and documento.num_progressivo="+string(s_par.id_cat_codifica)+" "
//end if
//
//
//if ls_sql> sqlsyntax then
//	setsqlpreview(ls_sql)
//end if
end event

event dw_1::doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

event dw_1::itemchanged;call super::itemchanged;string ls_num_bol, ls_cerca_bol
date ldt_data_oggi, ldt_data_spedizione_bol, ldt_data_sped, ldt_data_inserimento
long ll_null,ll_test, ll_id_utenti
datetime ldt_data_ora

setnull(ll_null) 
//20241002 riporto la bollettina in spedizione verifica w_ver_sped_bollettina

if dwo.name="c_sposta_in_ver_sped_bollettina" then
	if data="1" then
		ls_num_bol=getitemstring(row, "num_documento")
		ls_cerca_bol=right(ls_num_bol, 7)
		ll_test=0
		select first(id_ver_sped_bollettina) into :ll_test from dba.ver_sped_bollettina where num_bollettina=:ls_cerca_bol;
		if ll_test>0 then 
			post setitem(row, "c_sposta_in_ver_sped_bollettina", 0)
			return
		end if
		ldt_data_spedizione_bol=getitemdate(row, "documento_data_prev_consegna")
		ls_num_bol=ls_cerca_bol
		ldt_data_sped=DATE("1901/01/01")  //non ho la data spedizione
		ldt_data_inserimento=date(today())
		ll_id_utenti=u_freddie.s_utenti.i_idutente
		insert into dba.ver_sped_bollettina ("id_ver_sped_bollettina", "num_bollettina", "data_spedizione", "data_inserimento", "provenienza",  "id_utenti")
		values( :ll_null, :ls_num_bol, :ldt_data_spedizione_bol, :ldt_data_inserimento, '1', :ll_id_utenti)
		;
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio NON riuscito!")
		end if
	end if
end if
if  dwo.name="c_vgmf"  then
	if data="1" then
		ls_num_bol=getitemstring(row, "num_documento")
		ls_cerca_bol=right(ls_num_bol, 7)
		ll_test=0
		ldt_data_inserimento=date(today())
		select first(id_ver_giorno_merce_fo) into :ll_test from dba.ver_giorno_merce_fo where num_bollettina=:ls_cerca_bol  and data_spedizione=:ldt_data_inserimento;
		if ll_test>0 then 
			post setitem(row, "c_sposta_in_ver_sped_bollettina", 0)
			Messagebox("Attenzione!", "VER GIORNO: La bollettina n. "+ls_cerca_bol+ " è già presente in data di oggi ("+string(ldt_data_inserimento)+")")
			return
		end if
//		select data_prev_consegna into :ldt_data_spedizione_bol from dba.documento where num_documento = :ls_num_bol;
//		ls_num_bol=right(ls_num_bol, 7)
//		ldt_data_sped=DATE(LEFT(getitemSTRING(row, "data_sped_k"), 10))
//		ldt_data_inserimento=date(today())
//	
//		ll_id_sog=dw_1.getitemnumber(row, "c_id_sog_com_sald")
		ll_id_utenti=u_freddie.s_utenti.i_idutente
		ldt_data_ora=datetime(today(), now())
		insert into dba.ver_giorno_merce_fo ("id_ver_giorno_merce_fo", "data_spedizione", "num_bollettina", "provenienza", "id_sog_commerciale", "data_ora", "id_utenti")
		values( :ll_null, today(), :ls_cerca_bol, '1', :ll_null, :ldt_data_ora, :ll_id_utenti)
		;
		if sqlca.sqlnrows>0 then
			commit;
			//20250319: inserisco il valore della data anche nel campo apposito per mostrare subito la riga colorata
			//setitem(row, "c_data_ora", ldt_data_ora)
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio NON riuscito!")
		end if
	end if
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_cerca_bol_ovunque_rpt
end type

type st_1 from w_stampa_001`st_1 within w_cerca_bol_ovunque_rpt
end type

type st_2 from w_stampa_001`st_2 within w_cerca_bol_ovunque_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_cerca_bol_ovunque_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_cerca_bol_ovunque_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_cerca_bol_ovunque_rpt
integer x = 3589
end type

type cb_7 from w_stampa_001`cb_7 within w_cerca_bol_ovunque_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_cerca_bol_ovunque_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_cerca_bol_ovunque_rpt
integer x = 3259
end type

type cb_stampa from w_stampa_001`cb_stampa within w_cerca_bol_ovunque_rpt
integer x = 3941
end type

type cb_preview from w_stampa_001`cb_preview within w_cerca_bol_ovunque_rpt
integer x = 2967
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_cerca_bol_ovunque_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_cerca_bol_ovunque_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_cerca_bol_ovunque_rpt
end type

type cbx_1 from checkbox within w_cerca_bol_ovunque_rpt
integer x = 2487
integer y = 44
integer width = 306
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
string text = "Cliente NO"
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.modify("rag_soc_1.visible=false")
	dw_1.modify("t_1.visible=false")
else
	dw_1.modify("rag_soc_1.visible=true")
	dw_1.modify("t_1.visible=true")
end if
end event

