forward
global type w_cerca_art_in_bollettina_rpt from w_stampa_001
end type
type rb_1 from radiobutton within w_cerca_art_in_bollettina_rpt
end type
type rb_2 from radiobutton within w_cerca_art_in_bollettina_rpt
end type
type cbx_1 from checkbox within w_cerca_art_in_bollettina_rpt
end type
type cbx_togli_xrclf from checkbox within w_cerca_art_in_bollettina_rpt
end type
type cbx_2 from checkbox within w_cerca_art_in_bollettina_rpt
end type
type cbx_3 from checkbox within w_cerca_art_in_bollettina_rpt
end type
type st_3 from statictext within w_cerca_art_in_bollettina_rpt
end type
type dw_2 from udw_000 within w_cerca_art_in_bollettina_rpt
end type
type cbx_4 from checkbox within w_cerca_art_in_bollettina_rpt
end type
type cbx_5 from checkbox within w_cerca_art_in_bollettina_rpt
end type
type cbx_6 from checkbox within w_cerca_art_in_bollettina_rpt
end type
type cbx_7 from checkbox within w_cerca_art_in_bollettina_rpt
end type
type cb_pdf from commandbutton within w_cerca_art_in_bollettina_rpt
end type
type st_5 from statictext within w_cerca_art_in_bollettina_rpt
end type
type r_1 from rectangle within w_cerca_art_in_bollettina_rpt
end type
end forward

global type w_cerca_art_in_bollettina_rpt from w_stampa_001
integer width = 6299
integer height = 1744
rb_1 rb_1
rb_2 rb_2
cbx_1 cbx_1
cbx_togli_xrclf cbx_togli_xrclf
cbx_2 cbx_2
cbx_3 cbx_3
st_3 st_3
dw_2 dw_2
cbx_4 cbx_4
cbx_5 cbx_5
cbx_6 cbx_6
cbx_7 cbx_7
cb_pdf cb_pdf
st_5 st_5
r_1 r_1
end type
global w_cerca_art_in_bollettina_rpt w_cerca_art_in_bollettina_rpt

type variables
s_param_articoli s_par
end variables

forward prototypes
public subroutine wf_ordina_per (string as_campo)
public subroutine wf_anticipa_cliente (integer ai_flag)
end prototypes

public subroutine wf_ordina_per (string as_campo);string ls_sort
integer li_pos

////ls_sort=dw_1.describe("datawindow.table.sort")
//if isnull(ls_sort) or ls_sort="?" then ls_sort=""
//li_pos=pos(ls_sort, as_campo+ " A,")
//if li_pos>0 then
//	ls_sort=right(ls_sort, len(ls_sort) - len( as_campo+ " A,"))
//else
//	ls_sort=as_campo+" A,"+ls_sort
//end if
ls_sort=as_campo+" A,"
dw_1.setsort(ls_sort)
dw_1.sort()
end subroutine

public subroutine wf_anticipa_cliente (integer ai_flag);INTEGER I
string ls_cliente, ls_cliente_old,ls_data_sped_k
date ldt_data_anticipo, ldt_data_sped_k, ldt_data_scadenza, ldt_oggi, ldt_fino_a_tutto
//20250609 creo funzione che cerca per ongi cliente se c'è anticipo data scadenza, se è così prendo tutte le bol del cliente entro la data scadenza
//e ci metto il giorno di rientro di consegna della settimana corrente (sped_lista_k)
wf_ordina_per("num_documento")
FOR I = 1 TO DW_1.ROWCOUNT()
	ls_cliente=dw_1.getitemstring(i, "c_cliente")
	setnull(ldt_data_anticipo)
	setnull(ldt_data_sped_k)
	ldt_oggi=today()
	
	select  fino_a_tutto into :ldt_data_anticipo
	from dba.anticipa_scadenza_k
	where cliente=:ls_cliente and anticipa_a_tutto <=:ldt_oggi and fino_a_tutto>=:ldt_oggi;
	
	select  s_data  into  :ldt_data_sped_k
	from dba.sped_lista_k
	where cliente=:ls_cliente;
	if ldt_data_anticipo>date("1901-01-01") then
		 //(0)=il formato del campo è dd-mm-yy-cliente
		 if ai_flag=0 then
			ls_data_sped_k=string(ldt_data_sped_k, "dd-mm-yy")+"-"+ls_cliente
		elseif ai_flag=1 then
//			(1) //il formato del campo è yyyy-mm-dd-cliente
			ls_data_sped_k=string(ldt_data_sped_k, "yyyy-mm-dd")+"-"+ls_cliente
		end if
		ls_data_sped_k+="X" //20250715 vuol dire che è anticipato!!!!
		ldt_data_scadenza=dw_1.getitemdate(i, "data_prev_consegna")
		if ldt_data_scadenza<=ldt_data_anticipo and ldt_data_scadenza>ldt_data_sped_k then
			dw_1.setitem(i, "data_sped_k",  ls_data_sped_k)
		end if
		ls_cliente_old=ls_cliente
		do while ls_cliente=ls_cliente_old and i<DW_1.ROWCOUNT()
			i++
			ldt_data_scadenza=dw_1.getitemdate(i, "data_prev_consegna")
			ls_cliente=dw_1.getitemstring(i, "c_cliente")
			if ldt_data_scadenza<=ldt_data_anticipo and ldt_data_scadenza>ldt_data_sped_k and ls_cliente_old=ls_cliente  then
				dw_1.setitem(i, "data_sped_k",  ls_data_sped_k)
			end if
		loop
	end if
	
NEXT
end subroutine

on w_cerca_art_in_bollettina_rpt.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_1=create cbx_1
this.cbx_togli_xrclf=create cbx_togli_xrclf
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.st_3=create st_3
this.dw_2=create dw_2
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.cbx_6=create cbx_6
this.cbx_7=create cbx_7
this.cb_pdf=create cb_pdf
this.st_5=create st_5
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cbx_togli_xrclf
this.Control[iCurrent+5]=this.cbx_2
this.Control[iCurrent+6]=this.cbx_3
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.cbx_4
this.Control[iCurrent+10]=this.cbx_5
this.Control[iCurrent+11]=this.cbx_6
this.Control[iCurrent+12]=this.cbx_7
this.Control[iCurrent+13]=this.cb_pdf
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.r_1
end on

on w_cerca_art_in_bollettina_rpt.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_1)
destroy(this.cbx_togli_xrclf)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.cbx_6)
destroy(this.cbx_7)
destroy(this.cb_pdf)
destroy(this.st_5)
destroy(this.r_1)
end on

event open;call super::open;string ls_num_doc,ls_filtro

s_par=message.powerobjectparm

dw_1.dataobject=s_par.tipo_stampa
if s_par.tipo_stampa="d_new_cerca_art_bol_fo_sped_tb" then
	
	cb_stampa.visible=false
	cb_pdf.visible=true

	//wf_qualcosa
end if
//IF s_par.bollo= "d_cerca_bol_no_fo_tb" then
//	dw_1.dataobject="d_cerca_bol_no_fo_tb"
//elseif s_par.tipo_stampa="d_new_cerca_art_in_bol_tb" then
//	dw_1.dataobject="d_new_cerca_art_in_bol_tb"
//elseif s_par.tipo_stampa="d_new_cerca_art_bol_fo_tb" then
//	dw_1.dataobject="d_new_cerca_art_bol_fo_tb"
//end if
dw_1.settransobject(sqlca)
dw_1.retrieve(s_par.da_data, s_par.a_data)
if s_par.li_fiscale> 0 then
	dw_1.setfilter("c_id_sog_com_sald="+string(s_par.li_fiscale)+" or c_id_sog_2="+string(s_par.li_fiscale) )
	dw_1.filter()	
end if


post event ue_post_open()




end event

event ue_post_open;call super::ue_post_open;long i, ll_test, ll_id_riga_bol
string ls_qta, ls_ancora_qui, ls_prof_doc, ls_filtro, ls_rag_soc
//datawindowchild dw_robol

decimal ldc_qta, ldc_qta_tot, ldc_peso, ldc_peso_tot
//integer li_ret
ls_ancora_qui=s_par.par_stampa
if  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_sped_evasa_tb" then
	
else
	if ls_ancora_qui='S' then
		for i = 1 to dw_1.rowcount()
			if  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_tb" or  s_par.tipo_stampa="d_new_cerca_art_bol_fo_gxg_tb"  then
				//if dw_1.getitemstring(i, "c_xrclf")>" " then dw_1.setitem(i, "c_visibile", -1)
			elseif s_par.tipo_stampa="d_new_cerca_art_in_bol_tb"then
				ldc_qta=0
				ldc_qta=	dw_1.getitemnumber(i, "quantita_1")
				if ldc_qta>0 then dw_1.setitem(i, "c_visibile", -1)
			elseif    s_par.tipo_stampa= "d_new_cerca_art_bol_fo_sped_tb" or s_par.tipo_stampa="d_new_cerca_art_bol_fo_gen_est_tb" or s_par.tipo_stampa= "d_new_cerca_art_bol_fo_gen_sped_tb"  then
				ldc_qta=0
				ldc_qta=	dw_1.getitemnumber(i, "quantita_rbol")
				ll_test=0
				ll_test=dw_1.getitemnumber(i, "id_riga_derivata")
				if ldc_qta>0 or ll_test>0 then dw_1.setitem(i, "c_visibile", -1)
				//if ldc_qta>0  then dw_1.setitem(i, "c_visibile", -1)
			else
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
	end if
end if
if s_par.tipo_stampa="d_cerca_art_in_bollettina_tb" then
	dw_1.modify("t_tot_qta.text='Totale Q.ta RBOL: "+string(ldc_qta_tot, "#,0")+"'")
	dw_1.modify("t_tot_peso.text='"+string(ldc_peso_tot, "#,0")+"'")
end if
if ls_ancora_qui='S' then
	if  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_tb"  or  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_sped_tb" or  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_gen_sped_tb" &
	 or  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_sped_evasa_tb"  then //20250512 spostato da sotto
		if s_par.li_fiscale>0 then ls_filtro="(c_id_sog_com_sald="+string(s_par.li_fiscale)+" or c_id_sog_2="+string(s_par.li_fiscale)+" ) " 
		if  s_par.li_fiscale<>2110 or isnull(s_par.li_fiscale)  then
			if ls_filtro>" " then ls_filtro+=" and " 
			//20250326 aggiugno filtro per ancora qui (NON ESISTE RBOL)			
			//ls_filtro+="c_visibile>=0 and isnull(quantita_rbol) and (c_num_sald> ' ' or c_ripara> ' ' or c_num_tlaser>' ' )"   //20250604 commento perché NON mostra le bol NON andate in lavorazione (sald o laser o ripara...)
			ls_filtro+="c_visibile>=0 and isnull(quantita_rbol) "  //and (c_num_sald> ' ' or c_ripara> ' ' or c_num_tlaser>' ' )"
		end if
		if  s_par.tipo_stampa=  "d_new_cerca_art_bol_fo_gen_sped_tb" then  //20240909 nuova stampa con nuovo filtro  //20250512 sposto sopra insieme a d_new_cerca_art_bol_fo_sped_tb
			dw_2.dataobject="d_filtra_data_cliente"
		end if
		dw_1.setfilter(ls_filtro)
		select rag_soc_1 into :ls_rag_soc from anagrafica a, sog_commerciale s where a.id_anagrafica=s.id_anagrafica and s.id_sog_commerciale=:s_par.li_fiscale;
		ls_filtro="Dal "+string(s_par.da_data,"dd/mm/yy")+" al "+string(s_par.a_data, "dd/mm/yy") +" - FO: "+left(ls_rag_soc, 10)+ " - Ancora_qui: "+ ls_ancora_qui
		IF S_PAR.SEGNO_COEF_CALO>"" THEN  ls_filtro+= " Scadenza  "+S_PAR.SEGNO_COEF_CALO
		IF S_PAR.da_scadenza>date("1900-01-01") THEN ls_filtro+= "  "+string(S_PAR.da_scadenza, "dd/mm/yy")
		dw_1.modify("t_filtro.text='"+ls_filtro+"'")
//	elseif  s_par.tipo_stampa=  "d_new_cerca_art_bol_fo_gen_sped_tb" then  //20240909 nuova stampa con nuovo filtro  //20250512 sposto sopra insieme a d_new_cerca_art_bol_fo_sped_tb
//		dw_2.dataobject="d_filtra_data_cliente"
//		//20250326 aggiugno filtro per ancora qui (NON ESISTE RBOL)
//20250512 sostituisco questo sotto con quello alla riga sopra n. 61 perché funziona e questo no.... speriamo bene
//		dw_1.setfilter("c_visibile>=0 and isnull(quantita_rbol) and (isnull(c_buratto) or c_buratto='') and (isnull(c_spazzo) or c_spazzo='') and (isnull(c_ceramico) or c_ceramico='') and (isnull(c_galvint) or c_galvint='') " ) //20240909 se è valorizzato anche solo uno di questi campi NON si deve vedere
	else
		dw_1.setfilter("c_num_ordine>0 and c_visibile>=0") //20230919 modificato con c_num_ordine>0
	end if
	dw_1.filter()
end if
dw_2.settransobject(sqlca)
dw_2.insertrow(1)

if s_par.tipo_stampa= "d_new_cerca_art_bol_fo_sped_tb" then 
	post WF_ANTICIPA_CLIENTE(0)
elseif  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_gen_sped_tb" or  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_gen_est_tb"  THEN
	post WF_ANTICIPA_CLIENTE(1) //il formato del campo è yyyy-mm-dd-cliente
END IF

//20250609 SE C'è ANTICIPO IN SPED_LISTA_K PER IL CLIENTE DEVO CERCARE TUTTE LE BOL CON SCADENZA <=ANTICIPO
// E METTERE GIORNO DEL CLIENTE A TUTTE

//messagebox("W", string(ldc_qta_tot))   //20230919 spostato sulla select 
//if  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_sped_tb" then
//	ls_filtro=dw_1.describe ("datawindow.table.filter") //20230830 aggiungo filtro per togliere gli RNL resi non lavorati
//	if ls_filtro="?" or ls_filtro<=" " then 
//		ls_filtro=" riga_documento_id_articolo<>23415 "
//	else
//		ls_filtro+=" and riga_documento_id_articolo<>23415 "
//	end if
//	dw_1.setfilter(ls_filtro)
//	dw_1.filter()
//end if



end event

type dw_1 from w_stampa_001`dw_1 within w_cerca_art_in_bollettina_rpt
integer y = 196
integer width = 6144
integer height = 1332
string dataobject = "d_cerca_art_in_bollettina_tb"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql, ls_rag_4

ls_sql=sqlsyntax
if s_par.tipo_stampa="d_cerca_art_in_bollettina_tb" then
//if  s_par.tipo_stampa= "d_new_cerca_art_bol_fo_tb"  then

	
	if s_par.ll_magazzino>0 then
		ls_sql+=" and riga_documento.id_articolo="+string(s_par.ll_magazzino)+" "
	end if
	
	if s_par.da_sog_comm> " " then
		if left(s_par.da_sog_comm, 1)="-" then
	//occorre aggiungere if data_doc>20220101 then ok così else ricerca con 5 lettere solamente...  modifica da 5 a 7 20220802
			ls_sql+=" and documento.num_documento like '%"+right(s_par.da_sog_comm, 7)+"' "
		else
			ls_sql+=" and documento.num_documento like '"+s_par.da_sog_comm+"%' "
		end if
	end if
	
	if s_par.id_variazione>0 then
		ls_sql+=" and documento.id_prof_documento="+string(s_par.id_variazione)+" "
		
	end if
	if s_par.id_cat_codifica> 0 then
		ls_sql+=" and documento.num_progressivo="+string(s_par.id_cat_codifica)+" "
	end if
	if s_par.da_scadenza> date('2000-01-01') then
		ls_sql+=" and documento.data_prev_consegna "+s_par.segno_coef_calo+ " '"+ string(s_par.da_scadenza, 'yyyy/mm/dd')+"' "
	end if
else
	if s_par.ll_magazzino>0 then
		ls_sql+=" and riga_documento_a.id_articolo="+string(s_par.ll_magazzino)+" "
	end if
	
	if s_par.da_sog_comm> " " then
		if left(s_par.da_sog_comm, 1)="-" then
			ls_sql+=" and documento_a.num_documento like '%"+right(s_par.da_sog_comm, 7)+"' "
		else
			ls_sql+=" and documento_a.num_documento like '"+s_par.da_sog_comm+"%' "
		end if
	end if
	
	if s_par.id_variazione>0 then
		ls_sql+=" and documento_a.id_prof_documento="+string(s_par.id_variazione)+" "
	end if
	if s_par.id_cat_codifica> 0 then
		ls_sql+=" and documento_a.num_progressivo="+string(s_par.id_cat_codifica)+" "
	end if
	if s_par.da_scadenza> date('2000-01-01') then
		ls_sql+=" and documento_a.data_prev_consegna "+s_par.segno_coef_calo+ " '"+ string(s_par.da_scadenza, 'yyyy/mm/dd')+"' "
	end if
end if


if ls_sql> sqlsyntax then
	setsqlpreview(ls_sql)
end if
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

event dw_1::rbuttondown;call super::rbuttondown;long ll_id_art, ll_temp
nvo_file_list sl_lista_file
integer li_ret, li_pos
string ls_file_trovato, ls_path, ls_sort

if dwo.name="articolo_id_articolo" then
	ll_id_art=dw_1.getitemnumber(row, "articolo_id_articolo")
	if ll_id_art>0 then
		select dir_immagini 
		into :ls_path
		from dba.par_sistema
		;
		sl_lista_file=f_leggi_files(ls_path, false)
	end if
	FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
		 li_ret=pos(sl_lista_file.as_file[ll_temp], string(ll_id_art))
		
		 if li_ret>0 then
			 messagebox("W", li_ret)
			ls_file_trovato=sl_lista_file.as_file[ll_temp]
			//l'ho trovato ora lo mostro
			//ma prima chiudo la finestra se fosse stata aperta già precedentemente
			close(w_mostra_foto)
			openwithparm(w_mostra_foto, ls_file_trovato)
			exit		
		end if
		 messagebox("W", li_ret)
	 NEXT
elseif dwo.name="c_num_ordine" or dwo.name="compute_4"  or dwo.name="num_documento" or  dwo.name= "riga_documento_descrizione" or dwo.name="c_data_documento"  &
				or dwo.name="data_documento" or  dwo.name="data_prev_consegna" or dwo.name="riga_documento_id_articolo" or dwo.name= "c_num_sald" then //20230919 ordiniamo anche per data sped e cliente (prima parte del num_documento)
			if dwo.name="compute_4" then
				wf_ordina_per("data_sped_k")
			elseif dwo.name="c_data_documento" then
				wf_ordina_per("data_documento")
			else
		//20231010 anche per data consegna e data documento
				wf_ordina_per(string(dwo.name))
			end if
end if


end event

event dw_1::itemchanged;call super::itemchanged;string ls_num_bol, ls_cerca_bol
date ldt_data_oggi, ldt_data_spedizione_bol, ldt_data_sped, ldt_data_inserimento
long ll_null,ll_test, ll_id_sog, ll_id_utente
datetime ldt_data_ora

setnull(ll_null) 
//20241002 riporto la bollettina in spedizione verifica w_ver_sped_bollettina

if dwo.name="c_sposta_in_ver_sped_bollettina" then
	if data="1" then
		ls_num_bol=getitemstring(row, "num_documento")
		ls_cerca_bol=right(ls_num_bol, 7)
		ll_test=0
		ldt_data_inserimento=date(today())
		select first(id_ver_sped_bollettina) into :ll_test from dba.ver_sped_bollettina where num_bollettina=:ls_cerca_bol and data_inserimento=:ldt_data_inserimento;
		if ll_test>0 then 
			post setitem(row, "c_sposta_in_ver_sped_bollettina", 0)
			Messagebox("Attenzione!", "La bollettina n. "+ls_cerca_bol+ " è già presente in data di oggi ("+string(ldt_data_inserimento)+")")
			return
		end if
		select data_prev_consegna into :ldt_data_spedizione_bol from dba.documento where num_documento = :ls_num_bol;
		//ls_num_bol=right(ls_num_bol, 7)
		ldt_data_sped=DATE(LEFT(getitemSTRING(row, "data_sped_k"), 10))
		//20250331 metto anche id_utenti
		ll_id_utente=u_freddie.s_utenti.i_idutente
		if isnull(ldt_data_sped) then
			insert into dba.ver_sped_bollettina ("id_ver_sped_bollettina", "data_spedizione", "num_bollettina",  "data_inserimento", "provenienza", "id_utenti")
			values( :ll_null, :ldt_data_spedizione_bol, :ls_cerca_bol,  :ldt_data_inserimento, '1', :ll_id_utente)
			;
		else
			insert into dba.ver_sped_bollettina ("id_ver_sped_bollettina", "data_spedizione", "num_bollettina", "data_richiesta", "data_inserimento", "provenienza", "id_utenti")
			values( :ll_null, :ldt_data_spedizione_bol, :ls_cerca_bol, :ldt_data_sped, :ldt_data_inserimento, '1', :ll_id_utente )
			;
		end if
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio NON riuscito!")
		end if
	end if
elseif  dwo.name="c_vgmf"  then
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
		ll_id_sog=dw_1.getitemnumber(row, "c_id_sog_com_sald")
		ll_id_utente=u_freddie.s_utenti.i_idutente
		ldt_data_ora=datetime(today(), now())
		insert into dba.ver_giorno_merce_fo ("id_ver_giorno_merce_fo", "data_spedizione", "num_bollettina", "provenienza", "id_sog_commerciale", "data_ora", "id_utenti")
		values( :ll_null, today(), :ls_cerca_bol, '1', :ll_id_sog, :ldt_data_ora, :ll_id_utente)
		;
		if sqlca.sqlnrows>0 then
			commit;
			//20250319: inserisco il valore della data anche nel campo apposito per mostrare subito la riga colorata
			setitem(row, "c_data_ora", ldt_data_ora)
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio NON riuscito!")
		end if
	end if
end if
end event

event dw_1::retrieveend;call super::retrieveend;integer i
datetime ldt_data_ora

for i= 1 to rowcount()
	ldt_data_ora=getitemdatetime(i, "c_data_ora")
	if ldt_data_ora> datetime("2000-01-01") then
		setitem(i, "c_vgmf", 1)
	end if
	
next
end event

type sle_pg from w_stampa_001`sle_pg within w_cerca_art_in_bollettina_rpt
integer x = 1170
integer width = 256
end type

type st_1 from w_stampa_001`st_1 within w_cerca_art_in_bollettina_rpt
integer x = 905
end type

type st_2 from w_stampa_001`st_2 within w_cerca_art_in_bollettina_rpt
integer x = 1435
integer width = 146
end type

type sle_copie from w_stampa_001`sle_copie within w_cerca_art_in_bollettina_rpt
integer x = 1582
integer width = 146
end type

type sle_zoom from w_stampa_001`sle_zoom within w_cerca_art_in_bollettina_rpt
integer x = 622
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_cerca_art_in_bollettina_rpt
integer x = 3611
integer y = 84
integer width = 206
integer height = 80
string text = "&File"
end type

type cb_7 from w_stampa_001`cb_7 within w_cerca_art_in_bollettina_rpt
integer x = 773
end type

type cb_6 from w_stampa_001`cb_6 within w_cerca_art_in_bollettina_rpt
integer x = 507
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_cerca_art_in_bollettina_rpt
integer x = 3374
integer y = 84
integer width = 238
integer height = 80
string text = "Imp. Stp."
end type

type cb_stampa from w_stampa_001`cb_stampa within w_cerca_art_in_bollettina_rpt
integer x = 3611
integer y = 0
integer width = 206
integer height = 80
end type

type cb_preview from w_stampa_001`cb_preview within w_cerca_art_in_bollettina_rpt
integer x = 3374
integer y = 0
integer width = 233
integer height = 80
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_cerca_art_in_bollettina_rpt
integer x = 402
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_cerca_art_in_bollettina_rpt
integer x = 302
end type

type cb_1 from w_stampa_001`cb_1 within w_cerca_art_in_bollettina_rpt
end type

type rb_1 from radiobutton within w_cerca_art_in_bollettina_rpt
integer x = 2002
integer width = 329
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
string text = "Consegna"
end type

event clicked;if checked then
	dw_1.setsort("documento_data_prev_consegna desc, documento_data_documento")
	dw_1.sort()
end if
end event

type rb_2 from radiobutton within w_cerca_art_in_bollettina_rpt
integer x = 1765
integer y = 76
integer width = 315
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Data Doc"
boolean checked = true
end type

event clicked;if checked then
	dw_1.setsort("documento_data_documento, documento_data_prev_consegna desc")
	dw_1.sort()
end if
end event

type cbx_1 from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 2048
integer y = 76
integer width = 338
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
string text = "Vedi Nome"
boolean checked = true
end type

event clicked;if checked then
	dw_1.object.dw_2.object.sog_commerciale_gen_rag_soc_1.visible="1"
else
	dw_1.object.dw_2.object.sog_commerciale_gen_rag_soc_1.visible="0"
	
end if
//dw_emp.Object.rpt_salary[li_row].Object.salary.Background.Mode = 0
end event

type cbx_togli_xrclf from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 2322
integer y = 4
integer width = 361
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Togli XRCLF"
end type

event clicked;string ls_filtro=""

if s_par.li_fiscale>0 then ls_filtro="c_id_sog_com_sald="+string(s_par.li_fiscale)
if ls_filtro> " " then ls_filtro+=" and "
if checked then
	ls_filtro+=" isnull(quantita_rbol) and c_num_sald> ' ' and c_xrclf<='  ' and  c_xrclf<>'ANNULLATO!'" 
	dw_1.setfilter(ls_filtro)
else
	ls_filtro+=" isnull(quantita_rbol) and c_num_sald> ' '"
	dw_1.setfilter(ls_filtro)
end if

dw_1.filter()
end event

type cbx_2 from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 2661
integer width = 448
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo ANNULLATI"
end type

event clicked;string ls_filtro=""

if s_par.li_fiscale>0 then ls_filtro="c_id_sog_com_sald="+string(s_par.li_fiscale)
if ls_filtro> " " then ls_filtro+=" and "
if checked then
	ls_filtro+="  c_id_riga_doc_der_sald >0 " 
	dw_1.setfilter(ls_filtro)
else
	if s_par.li_fiscale>0 then ls_filtro="c_id_sog_com_sald="+string(s_par.li_fiscale)
	dw_1.setfilter(ls_filtro)
end if

dw_1.filter()
end event

type cbx_3 from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 2373
integer y = 76
integer width = 402
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Escludi 23415"
boolean checked = true
end type

event clicked;string ls_filtro=""
integer li_pos

ls_filtro=dw_1.describe ("datawindow.table.filter")
IF checked=false then
	li_pos=POS(ls_filtro, " and riga_documento_id_articolo<>23415")
	if li_pos>0 then 
		ls_filtro=left(ls_filtro, li_pos)
	end if
else
	if ls_filtro="?" or ls_filtro<=" " then 
		ls_filtro=" riga_documento_id_articolo<>23415 "
	else
		ls_filtro+=" and riga_documento_id_articolo<>23415 "
	end if
END IF
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type st_3 from statictext within w_cerca_art_in_bollettina_rpt
integer x = 4965
integer y = 12
integer width = 489
integer height = 132
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tasto dx su colonna =ordina per colonna."
boolean focusrectangle = false
end type

type dw_2 from udw_000 within w_cerca_art_in_bollettina_rpt
integer x = 3831
integer width = 1115
integer height = 168
integer taborder = 29
boolean bringtotop = true
string dataobject = "d_ricerca_in_stampe"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long ll_riga_trovata
string ls_filtro, ls_data

if dwo.name= "data_sped" then
	if data> " " then
		ls_filtro = dw_1.describe("datawindow.table.filter")
		if ls_filtro> " " then
			ls_filtro+= " and (compute_4 like '%"+string(date(data), "dd/mm/yy")+"%') "
		else
			//NON dovrebbe essere possibile....
		end if
	else
		//ls_filtro="(isnull(c_buratto) or c_buratto='') and (isnull(c_spazzo) or c_spazzo='') and (isnull(c_ceramico) or c_ceramico='') and (isnull(c_galvint) or c_galvint='') " )
	end if
elseif dwo.name= "cliente" then
	ls_filtro = dw_1.describe("datawindow.table.filter")
	ls_filtro+=" and (num_documento like '"+data+"%') "   //documento_num_documento like '%1651053%'
elseif dwo.name= "fornitore" then
	ls_filtro = dw_1.describe("datawindow.table.filter")
	ls_data=upper(data)
	ls_filtro+=" and (c_num_sald like '"+ls_data+"%') "   //documento_num_documento like '%1651053%'
ELSE
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()

end event

type cbx_4 from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 1765
integer y = 4
integer width = 233
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TUTTI"
end type

event clicked;if checked then
	dw_1.setfilter("")
else
	dw_1.setfilter("c_num_ordine>0")
end if
dw_1.filter()
end event

type cbx_5 from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 2757
integer y = 72
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "NO Buratto"
end type

event clicked;string ls_filtro
integer li_pos

ls_filtro=dw_1.describe ("datawindow.table.filter")
IF checked=false then
	li_pos=POS(ls_filtro, " and (c_buratto_c ='' or isnull(c_buratto_c))")
	if li_pos>0 then 
		ls_filtro=left(ls_filtro, li_pos)
	end if
else
	if ls_filtro="?" or ls_filtro<=" " then 
		ls_filtro=" (c_buratto_c ='' or isnull(c_buratto_c))"
	else
		ls_filtro+=" and (c_buratto_c ='' or isnull(c_buratto_c))"
	end if
END IF
dw_1.setfilter(ls_filtro)
dw_1.filter()
IF checked=false then
	dw_1.modify("c_buratto_c.visible=1")
	dw_1.modify("t_buratto.visible=1")
else
	dw_1.modify("c_buratto_c.visible=0")
	dw_1.modify("t_buratto.visible=0")
end if
end event

type cbx_6 from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 3090
integer y = 76
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "NO Galv"
end type

event clicked;string ls_filtro
integer li_pos

ls_filtro=dw_1.describe ("datawindow.table.filter")
IF checked=false then
	li_pos=POS(ls_filtro, " and (c_galvanica_c ='' or isnull(c_galvanica_c))")
	if li_pos>0 then 
		ls_filtro=left(ls_filtro, li_pos)
	end if
else
	if ls_filtro="?" or ls_filtro<=" " then 
		ls_filtro=" (c_galvanica_c ='' or isnull(c_galvanica_c))"
	else
		ls_filtro+=" and (c_galvanica_c ='' or isnull(c_galvanica_c))"
	end if
END IF
dw_1.setfilter(ls_filtro)
dw_1.filter()
IF checked=false then
	dw_1.modify("c_galvanica_c.visible=1")
	dw_1.modify("t_galvanica.visible=1")
else
	dw_1.modify("c_galvanica_c.visible=0")
	dw_1.modify("t_galvanica.visible=0")
end if
end event

type cbx_7 from checkbox within w_cerca_art_in_bollettina_rpt
integer x = 3090
integer y = 4
integer width = 293
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "NO Xrclf"
end type

event clicked;string ls_filtro
integer li_pos

ls_filtro=dw_1.describe ("datawindow.table.filter")
IF checked=false then
	li_pos=POS(ls_filtro, " and (c_xrclf_c ='' or isnull(c_xrclf_c))")
	if li_pos>0 then 
		ls_filtro=left(ls_filtro, li_pos)
	end if
else
	if ls_filtro="?" or ls_filtro<=" " then 
		ls_filtro=" (c_xrclf_c ='' or isnull(c_xrclf_c))"
	else
		ls_filtro+=" and (c_xrclf_c ='' or isnull(c_xrclf_c))"
	end if
END IF
dw_1.setfilter(ls_filtro)
dw_1.filter()
IF checked=false then
	dw_1.modify("c_xrclf_c.visible=1")
	dw_1.modify("t_xrclf.visible=1")
else
	dw_1.modify("c_xrclf_c.visible=0")
	dw_1.modify("t_xrclf.visible=0")
end if
end event

type cb_pdf from commandbutton within w_cerca_art_in_bollettina_rpt
boolean visible = false
integer x = 3611
integer width = 206
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "PDF"
end type

event clicked;	string ls_file
	integer li_ret
	datetime ldt_ora
	
	//20241007 stampo PDF
	if  dw_1.dataobject="d_new_cerca_art_bol_fo_gxg_tb" then
		dw_1.modify("c_data_ora.visible=0")
		dw_1.modify("c_vgmf.visible=0")
	end if
	dw_1.Modify("Export.PDF.Method = Distill!")
	dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	ldt_ora=datetime(today(), now())
	ls_file=string(ldt_ora, "dd_mm_yy_hh_mm")+".PDF"
	li_ret=dw_1.SaveAs("c:\nita\pdfFOancoraqui\"+  ls_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		messagebox("Errore!", "File PDF non generato!")	
	end if
end event

type st_5 from statictext within w_cerca_art_in_bollettina_rpt
integer x = 5710
integer y = 28
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "ANTICIPATO"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_cerca_art_in_bollettina_rpt
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 65535
integer x = 5568
integer y = 24
integer width = 123
integer height = 72
end type

