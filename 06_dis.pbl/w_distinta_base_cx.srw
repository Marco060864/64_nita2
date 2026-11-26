forward
global type w_distinta_base_cx from w_p_data
end type
type p_1 from picture within tabpage_1
end type
type dw_distinta_base_ff from u_dw_master_main within tabpage_1
end type
type cbx_mostra_imm from checkbox within tabpage_1
end type
type pb_scheda_tecnica from picturebutton within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_17 from commandbutton within tabpage_2
end type
type cb_controlla_distinta from commandbutton within tabpage_2
end type
type dw_riga_dis_base_lt from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_17 cb_17
cb_controlla_distinta cb_controlla_distinta
dw_riga_dis_base_lt dw_riga_dis_base_lt
end type
type p_esplodi from picture within w_distinta_base_cx
end type
type cb_9 from commandbutton within w_distinta_base_cx
end type
type cb_copia from commandbutton within w_distinta_base_cx
end type
type cb_rip_dis_figli from commandbutton within w_distinta_base_cx
end type
end forward

global type w_distinta_base_cx from w_p_data
integer x = 183
integer y = 112
integer width = 3342
integer height = 2124
string title = "Distinta Base"
p_esplodi p_esplodi
cb_9 cb_9
cb_copia cb_copia
cb_rip_dis_figli cb_rip_dis_figli
end type
global w_distinta_base_cx w_distinta_base_cx

type variables
integer ii_livello,ii_con,ii_livello_var, ii_livello_sost
long ll_id_variante
datastore ids_testa,ids_righe
string is_operazione[]
long  is_eliminate[]
string is_oper_sost[]
long  is_sost[]
boolean ib_copia, ib_visualizza_prezzo
end variables

forward prototypes
public subroutine wf_esplodi_distinta ()
public subroutine wf_reset ()
public function integer wf_cambia_status (datawindow a_dw, long al_row, string as_colonna, string as_buffer, string as_status)
public function long crea_articolo (string cod_arte_padre, string cod_art)
public function long crea_distinta (long id_articolo, long id_dis_padre, string codice)
public function decimal wf_proponi_peso (long al_id_articolo, decimal ad_quantita, string as_flag, decimal adc_peso)
public subroutine wf_mostra_immagine (string immagine)
end prototypes

public subroutine wf_esplodi_distinta ();
//dati dat
//treeviewitem tvi_esplodi
//integer li_anno
//date ld_1,ld_2
//tab_1.tabpage_4.tv_variante.deleteitem(0)
//string testa
//long ll_root,id,id_art
//tab_1.tabpage_4.tv_variante.ib_completa=true
//testa=ids_testa.getitemstring(1,"articolo_codice")
//id_art=ids_testa.getitemnumber(1,"id_articolo")
//id=ids_testa.getitemnumber(1,"id_distinta")
//dat.path=ids_testa.getitemstring(1,"articolo_immagine")
//if testa<>"" and isnull(testa)=false then
//	dat.quantita=1
//	dat.id_dis_figlio=id
//	dat.id_distinta=id
//	dat.id_articolo=id_art
//	tvi_esplodi.data=dat
//	tvi_esplodi.label=testa
//	tvi_esplodi.pictureindex=4
//	tvi_esplodi.selectedpictureindex=4
//	tvi_esplodi.Expanded=true
//	ll_root=tab_1.tabpage_4.tv_variante.insertitemfirst(0,tvi_esplodi)
//end if
//treeview t
//t=tab_1.tabpage_4.tv_variante
//li_anno=year(today())
//ld_1=date(tab_1.tabpage_4.sle_2.text)
//ld_2=date(tab_1.tabpage_4.sle_3.text)
//if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
//if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
//f_rec_righe(t,1,false,id,ld_1,ld_2,id,true)
end subroutine

public subroutine wf_reset ();
//tab_1.tabpage_1.ole_1.visible=true
//tab_1.tabpage_1.ole_1.object.clearimage=true
wf_mostra_immagine("")
tab_1.tabpage_1.cbx_mostra_imm.checked=false
//tab_1.tabpage_3.ole_2.visible=true
//tab_1.tabpage_3.ole_2.object.DelImage = True
//tab_1.tabpage_3.cbx_2.checked=false
//tab_1.tabpage_4.cb_4.enabled=false
//tab_1.tabpage_4.cb_7.enabled=false
//tab_1.tabpage_4.cb_elimina.enabled=false	
//tab_1.tabpage_4.cb_sostituisci.enabled=false
//tab_1.tabpage_4.cb_agg_riga.enabled=false	
//if isvalid(w_esplosione) then close(w_esplosione)
//tab_1.tabpage_4.lb_1.reset ( )
//tab_1.tabpage_4.rb_2.checked=true
//tab_1.tabpage_4.rb_2.event post clicked()
//tab_1.tabpage_4.tv_variante.deleteitem(0)
ii_livello=0
ii_livello_var=0
ii_livello_sost=0
//tab_1.tabpage_3.sle_livello.text=""
//tab_1.tabpage_4.sle_livello_var.text=""
//tab_1.tabpage_5.sle_sost.text=""
//tab_1.tabpage_3.tv_1.deleteitem(0)
//tab_1.tabpage_3.sle_1.text=""
//tab_1.tabpage_4.sle_2.text=""
//tab_1.tabpage_4.sle_3.text=""
//tab_1.tabpage_5.sle_8.text=""
//tab_1.tabpage_5.sle_9.text=""
//tab_1.tabpage_5.cb_15.enabled=false
//tab_1.tabpage_5.cb_16.enabled=false
//tab_1.tabpage_5.rb_5.checked=true
//tab_1.tabpage_5.rb_5.event post clicked()
//tab_1.tabpage_5.deleteitem(0)
//tab_1.tabpage_5.dw_1.reset()
//tab_1.tabpage_5.dw_sost_cascata.reset()
ib_copia=false
end subroutine

public function integer wf_cambia_status (datawindow a_dw, long al_row, string as_colonna, string as_buffer, string as_status);integer li_ok
choose case as_status
	case "datamodified"
		li_ok=a_dw.setitemstatus(al_row, as_colonna, primary!, datamodified!)
		if li_ok<>1 then messagebox("Errore!", "Riga non visibile al salvataggio!")
end choose
return li_ok
end function

public function long crea_articolo (string cod_arte_padre, string cod_art);long id_padre
long id_art
datastore articolo, art_padre, unita_conf_padre, unita_conf
select id_articolo
into :id_padre
from articolo
where codice=:cod_arte_padre;
art_padre= create datastore;
art_padre.dataobject='ds_art_testa'
art_padre.settransobject(sqlca)
art_padre.retrieve(id_padre)

articolo= create datastore;
articolo.dataobject='ds_art_testa'
articolo.settransobject(sqlca)

art_padre.rowscopy(1,1,Primary!,articolo, 1, Primary!)
long ll_null
setnull(ll_null)
articolo.setitem(1,"id_articolo",ll_null)
articolo.setitem(1,"codice",cod_art)
articolo.setitemstatus(1,0,Primary!,New!)

articolo.update()
select id_articolo
into :id_art
from articolo
where codice=:cod_art;
destroy(art_padre)
destroy(articolo)

unita_conf_padre= create datastore;
unita_conf_padre.dataobject='d_unita_conf_ds'
unita_conf_padre.settransobject(sqlca)
unita_conf_padre.retrieve(id_padre)

unita_conf= create datastore;
unita_conf.dataobject='d_unita_conf_ds'
unita_conf.settransobject(sqlca)
unita_conf.retrieve(id_art)
unita_conf.deleterow(1)
long ll_row,i
ll_row=unita_conf_padre.rowcount()
unita_conf_padre.rowscopy(1,ll_row,Primary!,unita_conf, 1, Primary!)
for i=1 to ll_row
	unita_conf.setitem(i,"id_unita_confezione",ll_null)
	unita_conf.setitem(i,"id_articolo",id_art)
	unita_conf.setitemstatus(i,0,Primary!,New!)
next
unita_conf.update()
destroy(unita_conf_padre)
destroy(unita_conf)
return id_art
end function

public function long crea_distinta (long id_articolo, long id_dis_padre, string codice);datastore distinta,dis
distinta=create datastore
distinta.dataobject='ds_dis_base'
distinta.settransobject(sqlca)
distinta.retrieve(id_dis_padre)

dis=create datastore
dis.dataobject='ds_dis_base'
dis.settransobject(sqlca)


distinta.rowscopy(1,1,Primary!,dis,1,Primary!)
long ll_null
setnull(ll_null)
dis.setitem(1,"id_distinta",ll_null)
dis.setitem(1,"id_dis_base",id_dis_padre)
dis.setitem(1,"id_articolo",id_articolo)
dis.setitem(1,"codice",codice)
dis.setitemstatus(1,0,Primary!,New!)
dis.update()

long ll_distinta
select id_distinta
into :ll_distinta
from distinta
where codice=:codice;
destroy(distinta)
destroy(dis)
return ll_distinta

end function

public function decimal wf_proponi_peso (long al_id_articolo, decimal ad_quantita, string as_flag, decimal adc_peso);decimal {4} ld_peso_netto, ldc_costo, ldc_costo_man
string ls_tipo, ls_tipo_um
long ll_id_uc

if (isnull(aL_id_articolo) or (aL_id_articolo = 0)) then
	return 0
end if

if (isnull(ad_quantita) or ad_quantita = 0) then
	ad_quantita = 1
end if


	select id_unita_confezione, m.tipo, u.peso_netto
	into :ll_id_uc, :ls_tipo_um, :ld_peso_netto
	from unita_confezione u, unita_misura m
	where id_articolo=:al_id_articolo
	and unita_base='S'
	and u.id_unita_misura=m.id_unita_misura
	
	;
	if adc_peso>0 then ld_peso_netto=adc_peso
if as_flag='COSTO' then
	select prezzo, prezzo_manifattura
	into :ldc_costo, :ldc_costo_man
	from dba.prezzo p, DBA.variazione v, DBA.LISTINO L
	where id_unita_confezione=:ll_id_uc
	and v.data_inizio<=today()
	and (v.data_fine>=today() 
	or v.data_fine is null)
	and p.id_variazione=v.id_variazione
	AND l.id_listino=v.id_listino
	and l.lis_base='S'
	and l.tipo='A'
	;
//	IF ldc_costo_man>0 THEN
//		LDC_COSTO=ldc_costo_man
//	END IF
	if ls_tipo_um='N' then //movimento al pezzo
		LDC_COSTO*= ad_quantita
	else
		ldc_costo_man*=ld_peso_netto
		LDC_COSTO=ldc_costo_man
	end if
	if isnull(ldc_costo) then ldc_costo=0 
	return ldc_costo
else
	if isnull(ld_peso_netto) then ld_peso_netto=0
	ld_peso_netto = ld_peso_netto * ad_quantita
	return ld_peso_netto
end if

end function

public subroutine wf_mostra_immagine (string immagine);string ls_immagine
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

on w_distinta_base_cx.create
int iCurrent
call super::create
this.p_esplodi=create p_esplodi
this.cb_9=create cb_9
this.cb_copia=create cb_copia
this.cb_rip_dis_figli=create cb_rip_dis_figli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_esplodi
this.Control[iCurrent+2]=this.cb_9
this.Control[iCurrent+3]=this.cb_copia
this.Control[iCurrent+4]=this.cb_rip_dis_figli
end on

on w_distinta_base_cx.destroy
call super::destroy
destroy(this.p_esplodi)
destroy(this.cb_9)
destroy(this.cb_copia)
destroy(this.cb_rip_dis_figli)
end on

event open;call super::open;string ls_codice,  ls_nome_azienda, is_par_menu

s_list_main ls_list
idw_master = tab_1.tabpage_1.dw_distinta_base_ff
idw_master.is_list = Message.PowerObjectParm
if UpperBound(idw_master.is_list.s_identifica) > 0 THEN
	if idw_master.is_list.s_identifica[1]='id_articolo' THEN
		select codice
		into :ls_codice
		from articolo
		where id_articolo=:idw_master.is_list.l_identifica[1];
		tab_1.tabpage_1.dw_distinta_base_ff.event post itemchanged(1,&
		tab_1.tabpage_1.dw_distinta_base_ff.object.articolo_codice,ls_codice)
		idw_master.is_list=ls_list
	end if
end if
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_distinta"
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "distinta.id_distinta"
ib_nonmodale=true

is_par_menu = idw_master.is_list.s_win_parametri
CHOOSE CASE is_par_menu
	CASE 'S'
		ib_visualizza_prezzo=true
	CASE 'N'
		ib_visualizza_prezzo=false
		tab_1.tabpage_1.dw_distinta_base_ff.object.valuta_t.visible=false
		tab_1.tabpage_1.dw_distinta_base_ff.object.distinta_id_valuta.visible=false
END CHOOSE
select rag_soc_1
into :ls_nome_azienda
from azienda
where id_azienda=1;
//20230104 Samy non vuole i doppioni dovuti al lavoro XX-CM nella des_articolo di diversi anni fa, tolgo la des_articolo dalla query
if pos(upper(ls_nome_azienda), "SILVER DR")>0 then
	tab_1.tabpage_2.dw_riga_dis_base_lt.dataobject="d_riga_dis_base_silver_lt"
	tab_1.tabpage_2.dw_riga_dis_base_lt.settransobject(sqlca)
end if
//20230104 fine
tab_1.tabpage_2.dw_riga_dis_base_lt.SetRowFocusIndicator(Hand!) 
//tab_1.tabpage_3.mle_1.visible=false
ib_copia=false
wf_mostra_immagine(ls_codice+".jpg")




end event

event ue_master_delete;call super::ue_master_delete;
long ll_riga,ll_righe,ll_dis
tab_1.tabpage_2.dw_riga_dis_base_lt.update()
ll_righe=tab_1.tabpage_2.dw_riga_dis_base_lt.rowcount()
if ll_righe=0 then
	ll_dis=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
	delete from var_riga_distinta where id_dis_variante=:ll_dis;
end if
ll_riga=tab_1.tabpage_1.dw_distinta_base_ff.getrow()
tab_1.tabpage_1.dw_distinta_base_ff.deleterow(ll_riga)
ib_askforsave=false
idw_master.event trigger ue_update(0,0)
idw_master.is_list.s_modo	= modo_inserisci
idw_master.triggerevent("ue_insert")


end event

event close;call super::close;
if IsValid(w_esplosione) then close(w_esplosione)
if isvalid(ids_testa) then destroy(ids_testa)
if isvalid(ids_righe) then destroy(ids_righe)


end event

event ue_post_open;call super::ue_post_open;
long ll_articolo
string ls_cod,ls_des
if upperbound(idw_master.is_list.s_par_value)>0 then
	ll_articolo=long(idw_master.is_list.s_par_value[1])
	if ll_articolo>0 then
		select codice,descrizione
		into :ls_cod,:ls_des
		from articolo
		where id_articolo=:ll_articolo;
		tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"id_articolo",ll_articolo)
		tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"articolo_codice",ls_cod)
		tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"articolo_descrizione",ls_des)
	end if
end if
datawindowchild ldwc_magazzino
//long ll_row,ll_mag
//ll_row=tab_1.tabpage_3.dw_mag.rowcount()
//if ll_row>0 then
//	tab_1.tabpage_3.dw_mag.deleterow(ll_row)
//end if
//ll_row=tab_1.tabpage_3.dw_mag.insertrow(0)
//tab_1.tabpage_3.dw_mag.getchild("magazzino",ldwc_magazzino)
//ldwc_magazzino.settransobject(sqlca)
//ldwc_magazzino.retrieve()
//select id_magazzino
//into :ll_mag
//from par_sistema;
//tab_1.tabpage_3.dw_mag.setitem(ll_row,"magazzino",ll_mag)
//if ib_visualizza_prezzo=false then
//	tab_1.tabpage_3.dw_mag.visible=false
//	tab_1.tabpage_3.tv_1.Height=1381
//	tab_1.tabpage_3.st_3.visible=false
//else
//	tab_1.tabpage_3.st_2.visible=false
//	tab_1.tabpage_3.dw_mag.visible=true
//	tab_1.tabpage_3.tv_1.Height=1261
	long ll_valuta
	tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
	if isnull(ll_valuta) or ll_valuta<=0 then
		select id_valuta
		into :ll_valuta
		from par_sistema;
		tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"distinta_id_valuta",ll_valuta)
		tab_1.tabpage_1.dw_distinta_base_ff.setitemstatus(1,0,primary!,notmodified!)
	end if
//end if
end event

type p_msg_log from w_p_data`p_msg_log within w_distinta_base_cx
end type

type p_crescente from w_p_data`p_crescente within w_distinta_base_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_distinta_base_cx
end type

type cb_ok from w_p_data`cb_ok within w_distinta_base_cx
end type

type cb_annulla from w_p_data`cb_annulla within w_distinta_base_cx
end type

type cb_nuovo from w_p_data`cb_nuovo within w_distinta_base_cx
end type

event cb_nuovo::clicked;call super::clicked;wf_reset()
long ll_row
ll_row=tab_1.tabpage_1.dw_distinta_base_ff.getrow()
tab_1.tabpage_1.dw_distinta_base_ff.post SetItemStatus(ll_row, 0, Primary!, notmodified!)
tab_1.SelectedTab = 1 

wf_mostra_immagine("")

end event

type cb_inserisci from w_p_data`cb_inserisci within w_distinta_base_cx
integer x = 2400
end type

type cb_cancella from w_p_data`cb_cancella within w_distinta_base_cx
integer x = 2697
end type

event cb_cancella::clicked;

w_p_data  lw_win
u_dw_main lu_dw

lw_win = u_freddie.iw_current
lu_dw = u_freddie.iudw_current
if isValid(lu_dw) then
	if isValid(lu_dw.iudw_parent) then
		if not lu_dw.ib_dw_shared then
			if lu_dw.RowCount() >0 then
				parent.triggerevent("ue_delete")
			end if
		end if
   else
      parent.triggerevent("ue_master_delete")			
	end if
end if



end event

type cb_salva from w_p_data`cb_salva within w_distinta_base_cx
integer x = 2994
end type

type tab_1 from w_p_data`tab_1 within w_distinta_base_cx
integer x = 32
integer y = 156
integer width = 3241
integer height = 1808
integer taborder = 30
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

event tab_1::selectionchanged;call super::selectionchanged;long ll_handle,ll_id_distinta,ll_magazzino,ll_row,ll_valuta,ll_id_sog_commerciale
string ls_cod,tipo_calcolo,tipo_applicazione
choose case newindex 
	case 3
		
		
//		ll_handle=tab_1.tabpage_3.tv_1.FindItem(RootTreeItem! , 0)
		if ll_handle= -1 then
			treeviewitem tvi_esplodi
			ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
			if ll_id_distinta>0 then
				ls_cod=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
			//	ll_handle=tab_1.tabpage_3.tv_1.FindItem(childTreeItem! , 0)
				tvi_esplodi.label=ls_cod
				integer li_anno
				li_anno=year(today())
				
				
				open(w_data_val_ff)
				
				
				
				
				dati dat
				dat=message.powerobjectparm
				date ld_1,ld_2
				ld_1=dat.data_inizio
				ld_2=dat.data_fine
				if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
				if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
				
				
				
				if ib_visualizza_prezzo=false then
//					f_rec_righe(tab_1.tabpage_3.tv_1,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,false)
				else
					tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
					tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
					//ll_row=tab_1.tabpage_3.dw_mag.getrow()
				//	ll_magazzino=tab_1.tabpage_3.dw_mag.getitemnumber(1,"magazzino")
					ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
					if isnull(ll_valuta) then
						select id_valuta
						into :ll_valuta
						from par_sistema;
					end if
					ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
					
 			 		//f_valorizza_comp(tab_1.tabpage_3.tv_1,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,tipo_calcolo,tipo_applicazione,ll_magazzino,false,ll_valuta,ll_id_sog_commerciale)
				end if
				tab_1.tabpage_2.dw_riga_dis_base_lt.retrieve(ll_id_distinta)
			end if
		end if
	case 4
		
		
//		tab_1.tabpage_4.lb_1.reset()
		ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
		declare dis cursor for
			select codice
			from distinta
			where id_dis_base=:ll_id_distinta
			and id_distinta<>:ll_id_distinta;
		open dis;
		do while sqlca.sqlcode=0 
			fetch dis into :ls_cod;
			if sqlca.sqlcode=0 then
//				tab_1.tabpage_4.lb_1.insertitem(ls_cod,1)
			end if
		loop
		close dis;
		
end choose
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 3205
integer height = 1688
long backcolor = 79741120
string text = "Distinta"
long tabbackcolor = 79741120
p_1 p_1
dw_distinta_base_ff dw_distinta_base_ff
cbx_mostra_imm cbx_mostra_imm
pb_scheda_tecnica pb_scheda_tecnica
end type

on tabpage_1.create
this.p_1=create p_1
this.dw_distinta_base_ff=create dw_distinta_base_ff
this.cbx_mostra_imm=create cbx_mostra_imm
this.pb_scheda_tecnica=create pb_scheda_tecnica
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.dw_distinta_base_ff
this.Control[iCurrent+3]=this.cbx_mostra_imm
this.Control[iCurrent+4]=this.pb_scheda_tecnica
end on

on tabpage_1.destroy
call super::destroy
destroy(this.p_1)
destroy(this.dw_distinta_base_ff)
destroy(this.cbx_mostra_imm)
destroy(this.pb_scheda_tecnica)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_distinta_base_cx
integer x = 2103
end type

event cb_ricerca::clicked;call super::clicked;w_search_main lw_sm
long ll_id_distinta
string ls_imm
s_ric_param ls_ricpar
idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_distinta_base_sw")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	if tab_1.tabpage_1.dw_distinta_base_ff.ModifiedCount () + & 
	   tab_1.tabpage_1.dw_distinta_base_ff.DeletedCount()>0 then &
		tab_1.tabpage_1.dw_distinta_base_ff.event trigger ue_update(0,0)
	if tab_1.tabpage_2.dw_riga_dis_base_lt.ModifiedCount () + & 
	   tab_1.tabpage_2.dw_riga_dis_base_lt.DeletedCount()>0 then &
		tab_1.tabpage_2.dw_riga_dis_base_lt.event trigger ue_update(0,0)
		
	ll_id_distinta = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_distinta"
	idw_master.is_list.l_identifica[1] = ll_id_distinta
	idw_master.Event ue_retrieve(0, 0)
	wf_reset()
	long ll_dis,ll_base
	ll_dis=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
	ll_base=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_dis_base")
//	if not isnull(ll_base) and  (ll_dis<>ll_base) then
//		tab_1.tabpage_4.enabled=false
//	else 
//		tab_1.tabpage_4.enabled=true
//	end if
	long ll_row
	ll_row=tab_1.tabpage_1.dw_distinta_base_ff.getrow()
	tab_1.tabpage_1.dw_distinta_base_ff.post SetItemStatus(ll_row, 0, Primary!, notmodified!)

END IF
idw_master.SetFocus()
ls_imm=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"codice")
select immagine
	into :ls_imm
	from articolo
	where codice=:ls_imm;
	wf_mostra_immagine(ls_imm)
	
	
end event

type p_1 from picture within tabpage_1
integer x = 2286
integer y = 776
integer width = 727
integer height = 472
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_distinta_base_ff from u_dw_master_main within tabpage_1
integer x = 32
integer y = 44
integer width = 3131
integer height = 1508
integer taborder = 1
string dataobject = "d_distinta_base_ff"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "articolo_codice"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="codice"
	CASE "articolo_descrizione"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="descrizione"
	CASE "ccod_cli"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="codice"
		CASE "des_articolo_codice"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="des_articolo_codice"
END CHOOSE
end event

event ue_use_search;string ls_codice
CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("des_articolo_codice", is_ricpar.s_ausil_value[2])		
		ls_codice=getitemstring(1,"codice")
		if ls_codice='' or isnull(ls_codice) then
			uf_set_colval("codice",is_ricpar.s_main_value)
		end if
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("des_articolo_codice", is_ricpar.s_ausil_value[2])
		ls_codice=getitemstring(1,"codice")
		if ls_codice='' or isnull(ls_codice) then
			uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		end if
	CASE "ccod_cli"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
	CASE "des_articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[2])
END CHOOSE
end event

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_distinta"
iudw_children[1]=tab_1.tabpage_2.dw_riga_dis_base_lt
//iudw_children[2]=tab_1.tabpage_4.dw_sost
//iudw_children[3]=tab_1.tabpage_5.dw_sost_cascata
//iudw_children[4]=tab_1.tabpage_6.dw_3
end event

event ue_insert;call super::ue_insert;
datetime ldt_data
ldt_data=datetime(today(),now())
long ll_row
ll_row=this.getrow()
this.setitem(ll_row,"data_ora_creazione",ldt_data)
this.setitem(ll_row,"data_ora_ult_cambiamento",ldt_data)
this.post SetItemStatus(ll_row, 0, Primary!, notmodified!)



end event

event updateend;call super::updateend;
long i,ll_rows,ll_distinta,ll_null
if ib_copia=true then
	setnull(ll_null)
	ll_rows=tab_1.tabpage_2.dw_riga_dis_base_lt.rowcount()
	ll_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
	for i=1 to ll_rows
		tab_1.tabpage_2.dw_riga_dis_base_lt.setitem(i,"id_distinta",ll_null)

		tab_1.tabpage_2.dw_riga_dis_base_lt.setitemstatus(i,0,primary!,newmodified!)
		tab_1.tabpage_2.dw_riga_dis_base_lt.setitem(i,"id_distinta",ll_distinta)
	next
end if
end event

event itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_codice, ls_cod_art
integer li_ok
CHOOSE CASE dwo.name
	case "articolo_codice"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		ls_dbc[4] = "des_breve"
		ls_dwc[4] = "des_articolo_codice"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)
		if li_ok=1 then
			ls_codice=getitemstring(1,"codice")
			if ls_codice='' or isnull(ls_codice) then
				ls_cod_art=getitemstring(1,"articolo_codice")
				uf_set_colval("codice", ls_cod_art)
				post wf_cambia_status(this, 1, "id_articolo", "primary","datamodified")
			end if
		end if
	case "articolo_descrizione"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		ls_dbc[4] = "des_breve"
		ls_dwc[4] = "des_articolo_codice"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)
		if li_ok=1 then
			ls_codice=getitemstring(1,"codice")
			if ls_codice='' or isnull(ls_codice) then
				ls_cod_art=getitemstring(1,"articolo_codice")
				uf_set_colval("codice", ls_cod_art)
			end if
		end if
	case "des_articolo_codice"
	   ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		ls_dbc[4] = "des_breve"
		ls_dwc[4] = "des_articolo_codice"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","des_breve","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)
		if li_ok=1 then
			ls_codice=getitemstring(1,"codice")
			if ls_codice='' or isnull(ls_codice) then
				ls_cod_art=getitemstring(1,"articolo_codice")
				uf_set_colval("codice", ls_cod_art)
			end if
		end if
		
end choose
end event

event updatestart;call super::updatestart;datetime ldt_data
ldt_data=datetime(today(),now())
long ll_row
ll_row=this.getrow()
if ll_row >0 then
	this.setitem(ll_row,"data_ora_ult_cambiamento",ldt_data)
	
	
	String ls_descrizione
	
	ls_descrizione = This.GetItemString(1, "articolo_descrizione")
	If IsNull(This.GetItemString(1, "descrizione")) Then
		This.SetItem(1, "descrizione", ls_descrizione)
	End If
end if
end event

type cbx_mostra_imm from checkbox within tabpage_1
integer x = 1851
integer y = 556
integer width = 462
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Mostra Immagine"
boolean lefttext = true
end type

event clicked;
//string ls_imm,ls_path_imm
//boolean lb_con
//if checked=true then
//	ole_1.object.aspectratio=1
//	ls_imm = tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
//	if isnull(ls_imm) then return
//	select immagine
//	into :ls_imm
//	from articolo
//	where codice=:ls_imm;
//	
//	lb_con=fileexists(ls_imm)
//	if not lb_con then
//		select dir_immagini
//		into :ls_path_imm
//		from par_sistema;
//		if sqlca.sqlcode<>0 then ls_path_imm=""
//		ls_imm=ls_path_imm+"\"+ls_imm
//		lb_con=fileexists(ls_imm)
//		if lb_con then
//			
//			ole_1.object.loadimage=ls_imm
//		end if
//	else	
//		ole_1.object.loadimage=ls_imm
//	end if
//	
//else
//	ole_1.object.clearimage=true
//end if

	
end event

type pb_scheda_tecnica from picturebutton within tabpage_1
integer x = 2729
integer y = 80
integer width = 407
integer height = 324
integer taborder = 24
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scheda Tecnica"
string picturename = "s:\pb\commonframework\word.bmp"
string disabledname = "s:\pb\commonframework\word.bmp"
alignment htextalign = left!
end type

event clicked;
string nome,ls_path,ls_prog,ls_key[],ls_p
long a,ll_file
integer li_ret,li_pos
boolean lb_es,lb_prog
nome=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"codice")
if nome<>"" then
	select dir_export
	into :ls_path
	from par_sistema;
	if isnull(ls_path) or ls_path="" then 
		ls_path="c:"
		messagebox("Attenzione!", "Sarà impostato il percorso di export 'c:' ~r~n"&
						+"Impostare il valore corretto nel campo 'dir_export' in ~r~n"&
						+"Parametri di Sistema, pagina 'Altro'.")
	end if
	nome=ls_path+"\"+nome+".doc"
	li_pos=pos(nome,' ',1)
	do while li_pos<>0 and not isnull(li_pos) 
		nome=Replace ( nome, li_pos, 1, "_" ) 
		li_pos=pos(nome,' ',1)
	loop
	
	RegistryGet("HKEY_CLASSES_ROOT\.doc","",ls_p)
	RegistryGet("HKEY_CLASSES_ROOT\"+ls_p+"\shell\open\command","",ls_p)
	
	
	ls_prog=ls_p

	
	lb_es=FileExists(nome)
	if lb_es=true then	
		nome=ls_prog+" "+ nome
		li_ret=run(nome, Maximized!)
	else
		ll_file=fileopen(nome,lineMode!, Write!, LockWrite!, Append!)
		fileclose(ll_file)
		nome=ls_prog+ " "+nome
		run(nome, Maximized!)
	end if
end if

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3205
integer height = 1688
long backcolor = 79741120
string text = "Righe Distinta"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_17 cb_17
cb_controlla_distinta cb_controlla_distinta
dw_riga_dis_base_lt dw_riga_dis_base_lt
end type

on tabpage_2.create
this.cb_17=create cb_17
this.cb_controlla_distinta=create cb_controlla_distinta
this.dw_riga_dis_base_lt=create dw_riga_dis_base_lt
this.Control[]={this.cb_17,&
this.cb_controlla_distinta,&
this.dw_riga_dis_base_lt}
end on

on tabpage_2.destroy
destroy(this.cb_17)
destroy(this.cb_controlla_distinta)
destroy(this.dw_riga_dis_base_lt)
end on

type cb_17 from commandbutton within tabpage_2
integer x = 2523
integer y = 1584
integer width = 361
integer height = 100
integer taborder = 53
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "correggi doppi"
end type

event clicked;long i, ll_distinte, ll_id_dis, ll_righe, a, ll_id_art, ll_id_art2, ll_riga_trovata
decimal ldc_costo, ld_quantita, ld_peso_netto
datastore ds_distinta



if messagebox("Attenzione!", "Vuoi davvero controllare? L'operazione durerà diversi minuti ...!",stopsign!, yesno! )=1 then
	ds_distinta=create datastore
	ds_distinta.dataobject="d_distinta_gd"
	ds_distinta.settransobject(sqlca)
	ll_distinte=ds_distinta.retrieve()
	
	
	for i= 1 to ll_distinte
		ll_id_dis=ds_distinta.getitemnumber(i, "id_distinta")
		ll_righe=dw_riga_dis_base_lt.retrieve(ll_id_dis)
		for a= 1 to ll_righe - 1
			ll_id_art=dw_riga_dis_base_lt.getitemnumber(a, "riga_distinta_id_articolo")
			ll_riga_trovata=dw_riga_dis_base_lt.find("riga_distinta_id_articolo="+string(ll_id_art), a+1,dw_riga_dis_base_lt.rowcount())
			if ll_riga_trovata>0 then
				dw_riga_dis_base_lt.deleterow(ll_riga_trovata)
				ll_righe --
			end if
		next
		if dw_riga_dis_base_lt.update()=1 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio "+string(ll_id_dis)+" NON riuscito!")
		end if
	next
	destroy ds_distinta
	
end if
end event

type cb_controlla_distinta from commandbutton within tabpage_2
integer x = 2917
integer y = 1580
integer width = 238
integer height = 100
integer taborder = 43
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Controlla"
end type

event clicked;long i, ll_distinte, ll_id_dis, ll_righe, a, ll_id_art
decimal ldc_costo, ld_quantita, ld_peso_netto
datastore ds_distinta

ds_distinta=create datastore
ds_distinta.dataobject="d_distinta_gd"
ds_distinta.settransobject(sqlca)
ll_distinte=ds_distinta.retrieve()


for i= 1 to ll_distinte
	ll_id_dis=ds_distinta.getitemnumber(i, "id_distinta")
	ll_righe=dw_riga_dis_base_lt.retrieve(ll_id_dis)
	for a= 1 to ll_righe
		ll_id_art=dw_riga_dis_base_lt.getitemnumber(a, "riga_distinta_id_articolo")
		ld_peso_netto=dw_riga_dis_base_lt.getitemdecimal(a, "riga_distinta_peso_netto")
		ld_quantita=dw_riga_dis_base_lt.getitemdecimal(a, "riga_distinta_quantita")
		ldc_costo=wf_proponi_peso(ll_id_art, ld_quantita, "COSTO", ld_peso_netto)
		if ldc_costo>0 then 	dw_riga_dis_base_lt.setitem(a, "riga_distinta_costo", ldc_costo)
	next
	if dw_riga_dis_base_lt.update()=1 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Salvataggio "+string(ll_id_dis)+" NON riuscito!")
	end if
next
end event

type dw_riga_dis_base_lt from u_dw_master_main within tabpage_2
integer y = 28
integer width = 3205
integer height = 1532
integer taborder = 3
string dataobject = "d_riga_dis_base_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_use_search;long ll_dis
decimal {4} ld_peso_netto, ld_quantita, ldc_costo
long li_id_articolo, li_row


CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_distinta_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("des_articolo_codice", is_ricpar.s_ausil_value[2])
		
		
		select id_distinta
		into :ll_dis
		from distinta
		where id_articolo=:is_ricpar.s_id_seg_value[1];
		if sqlca.sqlcode=0 then
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))
		else
			setnull(ll_dis)
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))
		end if
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_distinta_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("des_articolo_codice", is_ricpar.s_ausil_value[2])
		
		
		select id_distinta
		into :ll_dis
		from distinta
		where id_articolo=:is_ricpar.s_id_seg_value[1];
		if sqlca.sqlcode=0 then
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))
		else
			setnull(ll_dis)
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))			
		end if
	CASE "des_articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_distinta_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[2])
		
		
		select id_distinta
		into :ll_dis
		from distinta
		where id_articolo=:is_ricpar.s_id_seg_value[1];
		if sqlca.sqlcode=0 then
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))
		else
			setnull(ll_dis)
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))			
		end if
END CHOOSE



if (as_nomecol = "articolo_codice" or as_nomecol = "articolo_descrizione" ) then
	li_row = this.getrow()
	
	li_id_articolo = this.object.riga_distinta_id_articolo[li_row]
	ld_quantita = this.object.riga_distinta_quantita[li_row]
		
	ld_peso_netto = wf_proponi_peso(li_id_articolo, ld_quantita, "", 0)
	ldc_costo = wf_proponi_peso(li_id_articolo, ld_quantita, "COSTO", 0)
	if (ld_peso_netto > 0) then this.setitem(li_row, "riga_distinta_peso_netto", ld_peso_netto)

	if (ldc_costo > 0) then this.setitem(li_row, "riga_distinta_costo", ldc_costo)
end if	






end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "articolo_codice"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="codice"
	CASE "articolo_descrizione"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="descrizione"
		CASE "des_articolo_codice"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="des_articolo_codice"
END CHOOSE




end event

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_distinta"
end event

event ue_insert;call super::ue_insert;
long ll_row,ll_righe
integer li_num_riga,li_con
ll_righe=tab_1.tabpage_2.dw_riga_dis_base_lt.rowcount()
if ll_righe>1 then
	li_num_riga=tab_1.tabpage_2.dw_riga_dis_base_lt.getitemnumber(ll_righe - 1,"riga_distinta_num_riga")
	li_con=mod(li_num_riga,10)
	li_num_riga=li_num_riga + 10 - li_con
else
	li_num_riga=10
end if
ll_row=tab_1.tabpage_2.dw_riga_dis_base_lt.getrow()
tab_1.tabpage_2.dw_riga_dis_base_lt.setitem(ll_row,"riga_distinta_num_riga",li_num_riga)
this.setcolumn("articolo_codice")
this.object.datawindow.horizontalscrollposition=0
tab_1.tabpage_2.dw_riga_dis_base_lt.setitemstatus(ll_row,0,primary!,notmodified!)

end event

event itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok
decimal {4} ld_peso_netto, ld_quantita, ldc_costo
long li_id_articolo
CHOOSE CASE dwo.name
	case "articolo_codice"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "riga_distinta_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	case "articolo_descrizione"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "riga_distinta_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
end choose





if (dwo.name = "articolo_codice" or dwo.name = "articolo_descrizione" or dwo.name = "riga_distinta_quantita") then
	
	
	li_id_articolo = this.object.riga_distinta_id_articolo[row]
	
	if (dwo.name = "riga_distinta_quantita") then 
		ld_quantita = dec(data)
	else
		ld_quantita = this.getitemnumber(row, "riga_distinta_quantita")
	end if
		
	ld_peso_netto = wf_proponi_peso(li_id_articolo, ld_quantita, "", 0)
	ldc_costo=wf_proponi_peso(li_id_articolo, ld_quantita, "COSTO", ld_peso_netto)
	
	if ldc_costo>0 then 	setitem(row, "riga_distinta_costo", ldc_costo)

	if (ld_peso_netto > 0) then this.setitem(row, "riga_distinta_peso_netto", ld_peso_netto)
end if
if dwo.name='riga_distinta_peso_netto' then
	ld_quantita = this.getitemnumber(row, "riga_distinta_quantita")
	li_id_articolo = this.object.riga_distinta_id_articolo[row]
	ldc_costo=wf_proponi_peso(li_id_articolo, ld_quantita, "COSTO", dec(data))
	if ldc_costo>0 then 	setitem(row, "riga_distinta_costo", ldc_costo)
end if
end event

event updateend;call super::updateend;
long ll_id_distinta
ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
this.retrieve(ll_id_distinta)
end event

event doubleclicked;call super::doubleclicked;
if (dwo.name = "tot_peso_netto") then
	integer li_ret
	li_ret = messagebox("Distinta Base", "Vuoi riportare il peso totale nella testa della distinta base ?", question!, YesNo!)
	if (li_ret = 1) then
		tab_1.tabpage_1.dw_distinta_base_ff.object.peso_netto[1] = tab_1.tabpage_2.dw_riga_dis_base_lt.object.tot_peso_netto[1]
	end if
end if

end event

type p_esplodi from picture within w_distinta_base_cx
integer x = 1463
integer y = 44
integer width = 91
integer height = 84
boolean bringtotop = true
string picturename = "s:\pb\commonframework\esplodi.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
integer li_anno
li_anno=year(today())
if isvalid(w_esplosione)=false then open(w_data_val_ff)
dati dat
dat=message.powerobjectparm
if isnull(dat.data_inizio) then dat.data_inizio=date('01/01/'+string(li_anno))
if isnull(dat.data_fine) then dat.data_fine=date('31/12/'+string(li_anno))
dat.id_dis_figlio=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
if dat.id_dis_figlio>0 then
	dat.codice=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
	openwithparm(w_esplosione,dat)
end if
end event

type cb_9 from commandbutton within w_distinta_base_cx
integer x = 1161
integer y = 44
integer width = 261
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rinumera"
end type

event clicked;
long ll_righe,i,ll_id_riga ,ll_num,ll_id_dis
ll_righe=tab_1.tabpage_2.dw_riga_dis_base_lt.rowcount()
if ll_righe>0 then
	for i=1 to ll_righe
		ll_id_riga=tab_1.tabpage_2.dw_riga_dis_base_lt.getitemnumber(i,"riga_distinta_id_riga_distinta")
		ll_num=i*10
		update riga_distinta
		set num_riga=:ll_num
		where id_riga_distinta=:ll_id_riga;
	next
	ll_id_dis=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
	tab_1.tabpage_2.dw_riga_dis_base_lt.retrieve(ll_id_dis)
end if
end event

type cb_copia from commandbutton within w_distinta_base_cx
integer x = 1591
integer y = 44
integer width = 247
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copia"
end type

event clicked;
w_search_main lw_sm
long ll_id_distinta
s_ric_param ls_ricpar
idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_distinta_base_sw")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	if tab_1.tabpage_1.dw_distinta_base_ff.ModifiedCount () + & 
	   tab_1.tabpage_1.dw_distinta_base_ff.DeletedCount()>0 then &
		tab_1.tabpage_1.dw_distinta_base_ff.event trigger ue_update(0,0)
	if tab_1.tabpage_2.dw_riga_dis_base_lt.ModifiedCount () + & 
	   tab_1.tabpage_2.dw_riga_dis_base_lt.DeletedCount()>0 then &
		tab_1.tabpage_2.dw_riga_dis_base_lt.event trigger ue_update(0,0)
		
	ll_id_distinta = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_distinta"
	idw_master.is_list.l_identifica[1] = ll_id_distinta
	idw_master.Event ue_retrieve(0, 0)
	wf_reset()
	long ll_dis,ll_base
	ll_dis=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
	ll_base=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_dis_base")
//	if not isnull(ll_base) and  (ll_dis<>ll_base) then
//		tab_1.tabpage_4.enabled=false
//	else 
//		tab_1.tabpage_4.enabled=true
//	end if
	
END IF
idw_master.SetFocus()
long ll_null
date ld_null
char lc_null[1]
string ls_null
setnull(ll_null)
setnull(ld_null)
ls_null=""
setnull(lc_null[1])
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"id_distinta",ll_null)
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"id_articolo",ll_null)
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"codice",ls_null)
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"descrizione",ls_null)
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"articolo_codice",ls_null)
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"articolo_descrizione",ls_null)
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"data_ora_ult_agg",ld_null)
tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"tipo_aggiornamento",lc_null[1])
tab_1.tabpage_1.dw_distinta_base_ff.setitemstatus(1,0,primary!,newmodified!)
ib_copia=true
end event

type cb_rip_dis_figli from commandbutton within w_distinta_base_cx
integer x = 2638
integer y = 160
integer width = 626
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Riporta Distinta su Varianti"
end type

event clicked;
integer li_righe, li_null, i, li_art_figli, a
long ll_id_dis_variante, ll_id_dis_padre, ll_id_art_padre, ll_id_art, ll_test
datastore ds_crea_dis, ds_trova_figli
string ls_cod_articolo, ls_cod_art_figlio

setpointer(HourGlass!)

setnull(li_null)

ds_trova_figli=create datastore
ds_trova_figli.dataobject="d_trova_art_figli"
ds_trova_figli.settransobject(sqlca)

ds_crea_dis=create datastore
ds_crea_dis.dataobject='ds_duplica_distinta'
ds_crea_dis.settransobject(sqlca)
ls_cod_articolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1, "articolo_codice")
ll_id_art_padre=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1, "id_articolo")
li_righe=ds_crea_dis.retrieve(ll_id_art_padre)
if li_righe=1 then 
	
	
	li_art_figli=ds_trova_figli.retrieve(ls_cod_articolo+"%")
	
	ll_id_dis_padre=ds_crea_dis.getitemnumber(1, "id_distinta")
	for a=1 to li_art_figli
		ll_test=0
		
		ll_id_art=ds_trova_figli.getitemnumber(a, "id_articolo")
		
		
		select id_distinta
		into :ll_test
		from distinta
		where id_articolo=:ll_id_art;
		if ll_test>0 then continue
		ds_crea_dis.dataobject='ds_duplica_distinta'
		ds_crea_dis.settransobject(sqlca)
		li_righe=ds_crea_dis.retrieve(ll_id_art_padre)
		
		ds_crea_dis.setitemstatus(1,0,primary!, newmodified!)
		
		ls_cod_art_figlio=ds_trova_figli.getitemstring(a, "codice")
		
		ds_crea_dis.setitem(1, "id_articolo", ll_id_art)
		
		ds_crea_dis.setitem(1, "id_distinta", li_null)
		
		ds_crea_dis.setitem(1, "codice", ls_cod_art_figlio)
	
		
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
	next	
end if
		
		
		

destroy ds_crea_dis
destroy ds_trova_figli
setpointer(arrow!)
end event

