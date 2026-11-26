forward
global type w_scarico_componenti_cx from w_p_data
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type tv_1 from treeview within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type tv_1 from treeview within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_master_main within tabpage_2
end type
type cb_3 from commandbutton within w_scarico_componenti_cx
end type
type cb_preview from commandbutton within w_scarico_componenti_cx
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
end forward

global type w_scarico_componenti_cx from w_p_data
int X=512
int Width=3264
int Height=1488
boolean TitleBar=true
string Title="Carico\Scarico Articoli in Produzione"
long BackColor=80263581
cb_3 cb_3
cb_preview cb_preview
end type
global w_scarico_componenti_cx w_scarico_componenti_cx

type variables
datastore ds_lotto, ds_mov_lotto
boolean generato=false, commerciale=false, salvato=false
long il_id_doc_car, il_id_doc_scar
char ic_tipo_ges_lotti
boolean     ib_completa 
long il_dis
integer ii_ricla
date id_data1,id_data2
end variables

forward prototypes
public subroutine wf_genera_doc ()
public subroutine wf_cancella_doc ()
public subroutine wf_errore (string as_msg)
public subroutine uf_esplodi_distinta ()
end prototypes

public subroutine wf_genera_doc ();long ll_id_reg_car, ll_id_reg_scar, ll_num_prog, ll_id_sog_com_car, ll_id_sog_com_scar, ll_id_valuta, ll_id_tab_iva
long ll_id_art, ll_id_doc, ll_id_r_lotto, ll_id_u_conf, ll_riga, i, ll_id_caus_car, ll_id_caus_scar, ll_id_lotto, ll_id_locazione
long ll_num_progs
decimal{2} ld_quantita
date ld_data_reg, ld_data_regs
string ls_cod_lotto, ls_des_art, ls_tipo_fat_scar, ls_tipo_fat_car, ls_tipo_riga
boolean errore=false
long ll_id_lotto_mp 
long ll_id_loc1, ll_id_loc2
decimal {4} ld_peso_netto, ld_tot

long ll_prof_sca, ll_prof_car, ll_eser, ll_mod

ld_data_reg=tab_1.tabpage_1.dw_1.getitemdate(1,'data_reg')
ll_prof_sca=tab_1.tabpage_1.dw_1.getitemnumber(1,'id_prof_doc_b')
ll_prof_car=tab_1.tabpage_1.dw_1.getitemnumber(1,'id_prof_doc')

select id_esercizio into :ll_eser from esercizio 
where data_inizio<=:ld_data_reg and data_fine>=:ld_data_reg;

select r.id_registro, p.id_caus_magazzino_prop, p.id_sog_comm_prop, p.tipo_fattura, p.id_locazione_1_prop, p.id_locazione_2_prop
into :ll_id_reg_car, :ll_id_caus_car, :ll_id_sog_com_car, :ls_tipo_fat_car, :ll_id_loc1, :ll_id_loc2
from prof_documento p, registro r
where r.id_mod_registro=p.id_mod_registro_prop and p.id_prof_documento=:ll_prof_car and r.id_esercizio=:ll_eser;

select id_locazione
into   :ll_id_locazione
from   par_sistema;

if isnull(ll_id_loc1) then ll_id_loc1 = ll_id_locazione 

if IsNull(ll_id_reg_car)or(ll_id_reg_car=0) then 
	wf_errore('Registro di Carico')
	return
end if

if IsNull(ll_id_caus_car)or(ll_id_caus_car=0) then
	wf_errore('Causale di Carico')
	return
end if

if IsNull(ll_id_sog_com_car)or(ll_id_sog_com_car=0) then
	wf_errore('Sogg. Comm. proposto nel profilo,~r~nverificare che tale dato sia presente nel profilo selezionato"')
	return
end if	

select r.id_registro, p.id_caus_magazzino_prop, p.id_sog_comm_prop, p.tipo_fattura  
into :ll_id_reg_scar, :ll_id_caus_scar, :ll_id_sog_com_scar, :ls_tipo_fat_scar
from prof_documento p, registro r
where r.id_mod_registro=p.id_mod_registro_prop and p.id_prof_documento=:ll_prof_sca and r.id_esercizio=:ll_eser;

if IsNull(ll_id_reg_scar)or(ll_id_reg_scar=0) then
	wf_errore('Registro di Scarico')
	return
end if

if IsNull(ll_id_caus_scar)or(ll_id_caus_scar=0) then
	wf_errore('Causale di Scarico')
	return
end if	
	

if IsNull(ll_id_sog_com_scar)or(ll_id_sog_com_scar=0) then
	wf_errore('Sogg. Comm. "me stesso"')
	return
end if	
	

select id_valuta into :ll_id_valuta
from esercizio where id_esercizio = :ll_eser;
if IsNull(ll_id_valuta)or(ll_id_valuta=0) then
	wf_errore('Valuta')
	return
end if

select max(num_progressivo)
into :ll_num_prog
from documento
where (documento.id_prof_documento=:ll_prof_sca)and(documento.id_registro=:ll_id_reg_scar);
if IsNull(ll_num_prog) then 
	ll_num_prog=1
else
	ll_num_prog++
end if
insert into documento (documento.id_prof_documento, documento.id_registro,
								  documento.num_progressivo, documento.data_registrazione,
								  documento.num_documento, documento.data_documento, 
								  documento.id_sog_commerciale, documento.id_valuta, 
								  documento.id_caus_magazzino, documento.id_locazione_1, documento.tipo_fattura)
						values (:ll_prof_sca, :ll_id_reg_scar, 
								  :ll_num_prog, :ld_data_reg, 
								  :ll_num_prog, :ld_data_reg, 
								  :ll_id_sog_com_scar, :ll_id_valuta, 
								  :ll_id_caus_scar, :ll_id_locazione, :ls_tipo_fat_scar);
if sqlca.sqlcode<>0 then
	messagebox("Errore", "Documento di scarico non creato")
	errore=true
	rollback;
else
	commit;
	ll_num_progs = ll_num_prog
	ld_data_regs = ld_data_reg	
end if
	
select Max(id_documento)
into :ll_id_doc
from documento;
	
il_id_doc_scar=ll_id_doc
	
ll_riga=tab_1.tabpage_2.dw_2.RowCount()
for i=1 to ll_riga
		ll_id_art=tab_1.tabpage_2.dw_2.GetItemNumber(i,"riga_distinta_id_articolo")
		ld_tot=tab_1.tabpage_2.dw_2.GetItemDecimal(i,"tot_qta")
		ls_des_art=tab_1.tabpage_2.dw_2.getItemString(i,"articolo_descrizione")
		ld_quantita=tab_1.tabpage_2.dw_2.GetItemDecimal(i,"riga_distinta_quantita")
		ll_id_tab_iva = tab_1.tabpage_2.dw_2.GetItemNumber(i,"id_tab_iva") 
		
		ls_tipo_riga = tab_1.tabpage_2.dw_2.getItemString(i,"riga_distinta_tipo_riga") 
		
		if ls_tipo_riga <> "C" and ls_tipo_riga <> "D" and ls_tipo_riga <> "N" then 
			select id_unita_confezione
			into :ll_id_u_conf
			from unita_confezione
			where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');
		
			
			if (tab_1.tabpage_2.dw_2.getItemString(i,"tipo") = 'P') then
				INSERT INTO riga_documento (id_documento, num_riga, id_valuta, 
												 id_articolo, descrizione, id_unita_confezione, 
												 id_locazione_1, id_locazione_2, id_caus_magazzino, fat_con_unita_base, 
												 fat_con_globale, qta_un_base, peso_netto, id_tab_iva) 
									  VALUES (:ll_id_doc, :i, :ll_id_valuta, 
									  			 :ll_id_art, :ls_des_art, :ll_id_u_conf, 
												 :ll_id_loc1, :ll_id_loc2, :ll_id_caus_scar, 1, 
												 1, :ld_quantita, :ld_tot, :ll_id_tab_iva) ; 
	
			else
	
				insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
											    riga_documento.id_articolo, riga_documento.quantita, 
											    riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.id_locazione_1, riga_documento.id_locazione_2,
											    riga_documento.id_caus_magazzino, riga_documento.fat_con_unita_base,
											    riga_documento.fat_con_globale, riga_documento.qta_un_base, riga_documento.id_tab_iva) 
									  values (:ll_id_doc, :i, :ll_id_valuta, 
									          :ll_id_art, :ld_tot,
												 :ls_des_art, :ll_id_u_conf, :ll_id_loc1, :ll_id_loc2,  
												 :ll_id_caus_scar, 1, 1, :ld_quantita, :ll_id_tab_iva); 

			end if		
	
			if sqlca.sqlcode<>0 then
				messagebox("Errore", "Riga_Documento di scarico non creata")
				messagebox("", SQLCA.SQLERRTEXT) 
				errore=true			
				rollback;
			else
				commit; 
			end if
		end if 
	next
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where (documento.id_prof_documento=:ll_prof_car)and(documento.id_registro=:ll_id_reg_car);
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
								documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino, 
								documento.id_locazione_1, documento.tipo_fattura)
					 values (:ll_prof_car, :ll_id_reg_car, :ll_num_prog, :ld_data_reg, :ll_id_sog_com_car, :ll_id_valuta, 
					 			:ll_id_caus_car, :ll_id_locazione, :ls_tipo_fat_car);
	if sqlca.sqlcode<>0 then
		messagebox("Errore", "Documento di carico non creato")
		errore=true		
		rollback;
	else
		commit;
	end if
	select Max(id_documento)
	into :ll_id_doc
	from documento;
	
	
	long ll_handle, ll_valuta, ll_magazzino
	string tipo_calcolo, tipo_applicazione
	decimal ld_costo
	s_val ls_val
	treeview tv
	
	select tipo_cal_valore, tipo_applicazione
	into :tipo_calcolo, :tipo_applicazione
	from distinta
	where id_distinta = :il_dis;

	select id_magazzino
	into :ll_magazzino
	from locazione
	where id_locazione = :ll_id_locazione;
		
	tab_1.tabpage_1.tv_1.deleteitem(0)	
	ll_handle=tab_1.tabpage_1.tv_1.FindItem(RootTreeItem! , 0)	
	tv = tab_1.tabpage_1.tv_1
	ls_val=f_valorizza_comp(tv,ll_handle,true,il_dis,id_data1,id_data2,il_dis,tipo_calcolo,tipo_applicazione,ll_magazzino,false,ll_id_valuta,ll_id_sog_com_car)
	
	ld_costo = ls_val.costo_componenti
	if isnull(ld_costo) then ld_costo = 0
	

	
	il_id_doc_car=ll_id_doc

	ll_id_art=tab_1.tabpage_1.dw_1.GetItemNumber(1,"id_articolo")
	ld_quantita=tab_1.tabpage_1.dw_1.GetItemDecimal(1,"quantita")
	ld_tot=tab_1.tabpage_1.dw_1.GetItemdecimal(1,"peso")
	ls_des_art=tab_1.tabpage_1.dw_1.GetItemString(1,"descrizione")
	ll_id_tab_iva = tab_1.tabpage_1.dw_1.GetItemnumber(1,"id_tab_iva")
	
	
	select id_unita_confezione
	into :ll_id_u_conf
	from unita_confezione
	where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');
	
	
	if isnull(ld_tot) or ld_tot=0 then
		insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
										riga_documento.id_articolo, riga_documento.quantita, riga_documento.id_riga_lotto,
										riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.id_locazione_1, 
										riga_documento.id_caus_magazzino, riga_documento.fat_con_unita_base,
										riga_documento.fat_con_globale, riga_documento.qta_un_base, riga_documento.id_tab_iva, riga_documento.prezzo) 
		values (:ll_id_doc, 1, :ll_id_valuta, :ll_id_art, :ld_quantita, :ll_id_r_lotto, :ls_des_art, 
					:ll_id_u_conf, :ll_id_locazione, :ll_id_caus_car, 1, 1, 1, :ll_id_tab_iva, 
					:ld_costo); 
	else
		INSERT INTO riga_documento (id_documento, num_riga, id_valuta, 
			id_articolo, quantita, descrizione, id_unita_confezione, id_locazione_1, 
			id_caus_magazzino, fat_con_unita_base,
			fat_con_globale, qta_un_base, peso_netto, id_tab_iva, prezzo) 
		VALUES (:ll_id_doc, 1, :ll_id_valuta, :ll_id_art,:ld_quantita, :ls_des_art, :ll_id_u_conf, :ll_id_locazione, 
		:ll_id_caus_car, 1, 1, 1, :ld_tot, :ll_id_tab_iva,   
		:ld_costo); 
		
	end if
	if sqlca.sqlcode<>0 then
		messagebox("Errore", "Riga_documento di carico non creato")
		errore=true		
		rollback;
	else
		commit;		
	end if
	
	if errore = false then
		messagebox("Informazione","Generati Documenti N. " + string(ll_num_progs) + " del " + string(ld_data_regs) + "(S) e " + string(ll_num_prog) + " del " + string(ld_data_reg) + " (C)") 
	end if
	
	salvato=not(errore)
end subroutine

public subroutine wf_cancella_doc ();integer li_ret
s_par_record lstr_par_documento

lstr_par_documento.nome_tabella="documento" 
lstr_par_documento.nome_id_tabella="id_documento"
lstr_par_documento.id_tabella=il_id_doc_car
lstr_par_documento.visible=false
openwithparm(w_utl_cancella_documento_wz,lstr_par_documento)
li_ret=message.doubleparm

if li_ret<>1 then
	messagebox('Attenzione!','Impossibile cancellare il documento di carico del lotto produzione!')
end if

lstr_par_documento.nome_tabella="documento" 
lstr_par_documento.nome_id_tabella="id_documento"
lstr_par_documento.id_tabella=il_id_doc_scar
lstr_par_documento.visible=false
openwithparm(w_utl_cancella_documento_wz,lstr_par_documento)
li_ret=message.doubleparm

if li_ret<>1 then
	messagebox('Attenzione!','Impossibile cancellare il documento di scarico del lotto produzione!')
end if
end subroutine

public subroutine wf_errore (string as_msg);messagebox('Errore!', 'Impossibile trovare '+as_msg)
end subroutine

public subroutine uf_esplodi_distinta ();
end subroutine

on w_scarico_componenti_cx.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_preview=create cb_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_preview
end on

on w_scarico_componenti_cx.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_preview)
end on

event open;call super::open;




idw_master = tab_1.tabpage_1.dw_1
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_articolo"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "articolo_id_articolo"

end event

event close;



end event

event ue_post_open;call super::ue_post_open;tab_1.tabpage_1.dw_1.setitem(1,'data_reg',today())

ii_ricla=1
end event

event closequery;
end event

type p_crescente from w_p_data`p_crescente within w_scarico_componenti_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_scarico_componenti_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_scarico_componenti_cx
int X=37
int Y=32
boolean BringToTop=true
end type

event cb_ok::clicked;long ll_row, ll_id
string s_col_name
integer li_counter
parent.TriggerEvent("ue_close")

end event

type cb_annulla from w_p_data`cb_annulla within w_scarico_componenti_cx
int X=329
int Y=32
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scarico_componenti_cx
int X=622
int Y=32
boolean BringToTop=true
end type

event cb_nuovo::clicked;integer li_ync,ret

string ls_find, testo
long ll_riga, ll_riga_1, ll_riga2
long ll_tv1
		

ll_tv1=tab_1.tabpage_1.tv_1.finditem(roottreeitem!, 0)
tab_1.tabpage_1.tv_1.deleteitem(ll_tv1)

if generato=false then 
	li_ync=messagebox("Errore","Il lotto non è stato generato.~r~n"+&
	"Continuare senza salvare le ultime modifiche? ",stopsign!,yesno!)
   if li_ync=1 then
	   tab_1.tabpage_2.dw_2.reset()
		
		
      parent.TriggerEvent("ue_insert_mode")
      idw_master.SetFocus()
		tab_1.selecttab(1)
		return
   else	
      return 
   end if
end if
		

ls_find="id_articolo =0"
ll_riga=tab_1.tabpage_2.dw_2.RowCount( )
ll_riga = tab_1.tabpage_2.dw_2.Find(ls_find , 1, ll_riga)

if ll_riga>0 then	
  li_ync=messagebox("Errore","Il lotto non può essere creato ~r~n"+&
  "non ci sono sufficienti articoli in magazzino.~r~n"+&
  "Continuare senza salvare le ultime modifiche?",stopsign!,yesno!)
  if li_ync=1 then 
    tab_1.tabpage_2.dw_2.reset()
		
		
    parent.TriggerEvent("ue_insert_mode")
    idw_master.SetFocus()
    tab_1.selecttab(1)
    return
  else
	 return 
  end if
end if

li_ync=messagebox("Attenzione","Salvare le ultime modifiche?",exclamation!,yesnocancel!)
if li_ync=1 then
  if ((ds_lotto.ModifiedCount() + ds_lotto.DeletedCount()) > 0) then 
	 ret=ds_lotto.update()
	 if ret=-1 then messagebox("Errore","ds_lotto non salvata",stopsign!,ok!)
  end if
  if ((ds_mov_lotto.ModifiedCount() + ds_mov_lotto.DeletedCount()) > 0) then 
	  ret=ds_mov_lotto.update()
     if ret=-1 then messagebox("Errore","ds_mov_lotto non salvata",stopsign!,ok!)
  end if
  if ((tab_1.tabpage_1.dw_1.ModifiedCount() + tab_1.tabpage_1.dw_1.DeletedCount()) > 0) then 
  	  ret=tab_1.tabpage_1.dw_1.update()
	  if ret=-1 then messagebox("Errore","dw_genera_lotto_ff non salvata",stopsign!,ok!)
  end if
					
string ls_data
decimal{4}  ld_qta_car, qta_usata
long id_articolo,id_Articolo_base, id_art_temp
integer li_num_righe, i,ls_anno, ls_mese


li_num_righe=tab_1.tabpage_2.dw_2.rowcount()
id_articolo_base=0
for i = 1 to li_num_righe
	id_art_temp=tab_1.tabpage_2.dw_2.getitemnumber(i, "id_articolo")
	if id_art_temp<1  or isnull(id_art_temp) then
		id_art_temp=tab_1.tabpage_2.dw_2.getitemnumber(i -1, "id_articolo")
	end if
		qta_usata=tab_1.tabpage_2.dw_2.getitemdecimal(i, "quantita")
		if isnull(qta_usata) then qta_usata=0
		update riepilogo
		set qta_scaricata= qta_scaricata + :qta_usata
		where id_articolo= :id_art_temp;
	if sqlca.sqlcode<> 0 then 
		messagebox("Errore!", "Non si è aggiornata la quantità"+&
	"~r~nscaricata in uno o più elementi di base")
		return
	end if

next
	
commit;




ll_riga=tab_1.tabpage_1.dw_1.getrow()
id_articolo= tab_1.tabpage_1.dw_1.getitemnumber(ll_riga, "id_articolo")
ld_qta_car=tab_1.tabpage_1.dw_1.getitemdecimal(ll_riga, "lotto_qta_iniziale")
ls_data=string(today(), "dd/mm/yyyy")
ls_anno=dec(right(ls_data, 4))
ls_mese= dec(mid(ls_data, 4, 2))



insert into riepilogo
(id_esercizio, id_attivita, id_articolo, id_locazione, anno, mese, qta_caricata, id_azienda)
values
(2, 1,  :id_articolo, 2, :ls_anno, :ls_mese, :ld_qta_car, 1);
if sqlca.sqlcode<>0 then
	update riepilogo
	set qta_caricata =qta_caricata + :ld_qta_car
	where id_articolo=:id_articolo;
end if
	





	
elseif li_ync=3 then
	return
else
end if

tab_1.tabpage_2.dw_2.reset()
		
		
parent.TriggerEvent("ue_insert_mode")
idw_master.SetFocus()
tab_1.selecttab(1)

			select testo_modulo
			into :testo
			from prog_lotti;
			ll_riga2= tab_1.tabpage_1.dw_1.getrow()
			tab_1.tabpage_1.dw_1.setitem(ll_riga2, "modulo", testo)
			




end event

type cb_inserisci from w_p_data`cb_inserisci within w_scarico_componenti_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_scarico_componenti_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_scarico_componenti_cx
int X=2743
int Y=32
int Width=466
boolean BringToTop=true
string Text="Genera_documenti"
end type

event cb_salva::clicked;string ls_find
long ll_riga, i

integer ll_ret 

wf_genera_doc()
	


end event

type tab_1 from w_p_data`tab_1 within w_scarico_componenti_cx
event create ( )
event destroy ( )
int Y=160
int Width=3186
int Height=1216
int TabOrder=10
boolean BringToTop=true
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

event tab_1::selectionchanged;call super::selectionchanged;if tab_1.tabpage_1.dw_1.rowcount()>0 and ii_ricla=0 then
	
	tab_1.tabpage_2.dw_2.reset() 
	
	long ll_art_fig, ll_dis_fig, i, k, ll_livello
	decimal ld_qta
	string ls_tipo
   
	
	
   
	if tab_1.tabpage_1.dw_1.getitemstring(1,'tipo')='P' then
		ld_qta=tab_1.tabpage_1.dw_1.getitemdecimal(1,'peso')
		ls_tipo='Peso'
	else	
		ld_qta=tab_1.tabpage_1.dw_1.getitemdecimal(1,'quantita')
		ls_tipo='Quantita'
	end if 	
	if isnull(ld_qta) or ld_qta=0 then 
		messagebox('Attenzione','Il campo '+ls_tipo+' non puo essere nullo!')
		return 2
	end if
	tab_1.tabpage_2.dw_2.retrieve(il_dis,1,ld_qta)
	setnull(ll_dis_fig)
	k=tab_1.tabpage_2.dw_2.rowcount()
	long ll_dis_fig2
	ll_dis_fig2 = il_dis
	
	
	decimal ld_qta2
	for i= 1 to k
		 if tab_1.tabpage_2.dw_2.getitemstring(i,'tipo')='P' then
				ld_qta2=tab_1.tabpage_2.dw_2.getitemdecimal(i,'riga_distinta_peso_netto')
		 else	
				ld_qta2=tab_1.tabpage_2.dw_2.getitemdecimal(i,'riga_distinta_quantita')
		 end if 			
	 
		 ld_qta2=ld_qta2*ld_qta

		 tab_1.tabpage_2.dw_2.setitem(i,"tot_qta",ld_qta2)		 
	next
	
	
	
	long ll_dis[], ll_upper, j
	integer li_trova, i2, k2
	ll_dis[1] = il_dis
	ld_qta2=ld_qta
	
	
	for i=1 to k
				
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 ll_art_fig=tab_1.tabpage_2.dw_2.getitemnumber(i,'riga_distinta_id_articolo')
		 select id_distinta into :ll_dis_fig from distinta where id_articolo=:ll_art_fig;
		 
		 
		 if not isnull(ll_dis_fig) then
			
			 li_trova = 0
			 ll_upper = upperbound(ll_dis)
			 FOR j=1 TO ll_upper
				 if ll_dis_fig = ll_dis[j] then 
					li_trova = 1
					j = ll_upper
				 end if
			 NEXT

          if li_trova = 0 then
				 ll_dis[ll_upper+1] = ll_dis_fig
				 
	   		 ll_dis_fig2 = ll_dis_fig
				 		 
				 ld_qta=tab_1.tabpage_2.dw_2.getitemdecimal(i,'tot_qta')	 				 

			    ll_livello=tab_1.tabpage_2.dw_2.getitemdecimal(i,'livello')
				 tab_1.tabpage_2.dw_2.deleterow(i)
				 
  				 k2 = tab_1.tabpage_2.dw_2.retrieve(ll_dis_fig,ll_livello + 1,ld_qta)
				
				 for i2=k to k2
					 if tab_1.tabpage_2.dw_2.getitemstring(i2,'tipo')='P' then
							ld_qta2=tab_1.tabpage_2.dw_2.getitemdecimal(i2,'riga_distinta_peso_netto')
					 else	
							ld_qta2=tab_1.tabpage_2.dw_2.getitemdecimal(i2,'riga_distinta_quantita')
					 end if 							 				 
					 ld_qta2=ld_qta2*ld_qta
					 tab_1.tabpage_2.dw_2.setitem(i2,"tot_qta",ld_qta2)							
				 next 
				 
				 i=i - 1
				 k=tab_1.tabpage_2.dw_2.rowcount()
				 setnull(ll_dis_fig)
			end if
	 end if
		 
	next	
end if	
end event

event tab_1::selectionchanging;call super::selectionchanging;if oldindex=1 then
	if ii_ricla=1 then
		messagebox('Attenzione','Esplodere prima la distinta dal tasto aggiorna!')
		return 2
	end if	
end if
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3150
int Height=1096
long BackColor=80263581
string Text="Gestione Distinta"
long TabBackColor=80263581
dw_1 dw_1
tv_1 tv_1
cb_1 cb_1
cb_2 cb_2
end type

on tabpage_1.create
this.dw_1=create dw_1
this.tv_1=create tv_1
this.cb_1=create cb_1
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.tv_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_scarico_componenti_cx
int X=1097
int Y=32
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;
end event

type dw_1 from u_dw_master_main within tabpage_1
int X=0
int Y=24
int Width=1797
int Height=1044
int TabOrder=11
string DataObject="d_scarica_comp_ff"
end type

event ue_use_search;string ls_cod_articolo

CHOOSE CASE as_nomecol
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		ls_cod_articolo=is_ricpar.s_main_value
		tab_1.tabpage_1.tv_1.DeleteItem (0)
		ii_ricla=1
	
	
	CASE "descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		ls_cod_articolo=is_ricpar.s_ausil_value[1]
		tab_1.tabpage_1.tv_1.DeleteItem (0)
		ii_ricla=1		
	
		
  	CASE "prof_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_doc", is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_des", is_ricpar.s_ausil_value[1])
	
	

		
	CASE "prof_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_doc", is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_cod", is_ricpar.s_ausil_value[1])
	
	


	CASE "prof_cod_b"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_doc_b", is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_des_b", is_ricpar.s_ausil_value[1])
	
	

		
	CASE "prof_des_b"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_doc_b", is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_cod_b", is_ricpar.s_ausil_value[1])
	
	



END CHOOSE


end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "codice"
		is_search_window = "w_articolo_lotgen_sw" 
		is_ricpar.s_filter_value = uf_get_colval("codice") 
		is_ricpar.s_filter_name = "codice" 

	
	CASE "descrizione"
		is_search_window = "w_articolo_lotgen_sw" 
		is_ricpar.s_filter_value = uf_get_colval("descrizione") 
		is_ricpar.s_filter_name = "descrizione" 
	
		
	CASE "prof_cod", "prof_des"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		if as_nomecol="prof_cod" then
			is_ricpar.s_filter_name = "prof_documento_codice" 
		else
			is_ricpar.s_filter_name = "prof_documento_descrizione" 
		end if	
	
	CASE "prof_cod_b", "prof_des_b"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		if as_nomecol="prof_cod_b" then
			is_ricpar.s_filter_name = "prof_documento_codice" 
		else
			is_ricpar.s_filter_name = "prof_documento_descrizione" 
		end if	
	
	
END CHOOSE

end event

event itemchanged;generato=false
string anno, mese, giorno, str, prefisso
long ll_mia_riga
date ld_data

string		ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok
CHOOSE CASE dwo.name
	case "codice"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "codice"
		ls_dwc[3] = "descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		tab_1.tabpage_1.tv_1.DeleteItem (0)
		ii_ricla=1
		
	
	case "descrizione"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "codice"
		ls_dwc[3] = "descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		tab_1.tabpage_1.tv_1.DeleteItem (0)
		ii_ricla=1		
	
		
	CASE 'prof_cod'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "prof_cod"
		ls_dwc[2] = "prof_des"
		ls_dwc[3] = "id_prof_doc"
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
		
	CASE 'prof_des'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "prof_cod"
		ls_dwc[2] = "prof_des"
		ls_dwc[3] = "id_prof_doc"
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
				return 2 
		end if		
		
		
	CASE 'prof_cod_b'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "prof_cod_b"
		ls_dwc[2] = "prof_des_b"
		ls_dwc[3] = "id_prof_doc_b"
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
		
	CASE 'prof_des_b'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "prof_cod_b"
		ls_dwc[2] = "prof_des_b"
		ls_dwc[3] = "id_prof_doc_b"
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
				return 2 
		end if			
		
		
END CHOOSE

end event

type tv_1 from treeview within tabpage_1
int X=1856
int Y=24
int Width=1253
int Height=1044
int TabOrder=11
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string PictureName[]={"Library5!",&
"SingletonReturn!",&
"Custom017!",&
"Custom023!",&
"BorderShadowBox!",&
"Border3DLowered!",&
"RunWindow!",&
"RunWindow!",&
"RunWindow!",&
"NotFound!",&
"NotFound!",&
"NotFound!",&
"NotFound!"}
long PictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within tabpage_1
int X=1024
int Y=616
int Width=256
int Height=108
int TabOrder=12
boolean Visible=false
boolean BringToTop=true
string Text="Apri Dis."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
open(w_distinta_base_cx)
end event

type cb_2 from commandbutton within tabpage_1
int X=2853
int Y=32
int Width=247
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string testa
treeviewitem tvi_esplodi
long ll_root,id,id_art,ll_valuta,ll_id_sog_commerciale
string tipo_calcolo,tipo_applicazione
dati dat
testa=tab_1.tabpage_1.dw_1.getitemstring(1,"codice")
id_art=tab_1.tabpage_1.dw_1.getitemnumber(1,"id_articolo")
select id_distinta, tipo_cal_valore, tipo_applicazione, id_valuta  
into :id, :tipo_calcolo, :tipo_applicazione, :ll_valuta 
from distinta where id_articolo=:id_art;
dat.path=tab_1.tabpage_1.dw_1.getitemstring(1,"immagine")
tab_1.tabpage_1.tv_1.DeleteItem (0 )
il_dis=id
if testa<>"" and isnull(testa)=false then
	dat.quantita=1
	dat.peso_netto=0	
	dat.id_dis_figlio=id
	dat.id_distinta=id
	dat.id_articolo=id_art
	tvi_esplodi.data=dat
	tvi_esplodi.label=testa
	tvi_esplodi.pictureindex=4
	tvi_esplodi.selectedpictureindex=4
	tvi_esplodi.Expanded=true
	ll_root=tab_1.tabpage_1.tv_1.insertitemfirst(0,tvi_esplodi)
end if
treeview t
t=tab_1.tabpage_1.tv_1
integer li_anno
long ll_magazzino,ll_row
li_anno=year(today())
open(w_data_val_ff)
dat=message.powerobjectparm
date ld_1,ld_2
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))

id_data1 = ld_1
id_data2 = ld_2

f_rec_righe(t,1,false,id,ld_1,ld_2,id,false)

ii_ricla=0

end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3150
int Height=1096
long BackColor=80263581
string Text="Materie prime"
long TabBackColor=80263581
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw_master_main within tabpage_2
int X=18
int Y=28
int Width=3104
int Height=1024
int TabOrder=3
string DataObject="d_riga_dis_prime_lt2"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event retrievestart;return 2
end event

type cb_3 from commandbutton within w_scarico_componenti_cx
event clicked pbm_bnclicked
int X=2450
int Y=32
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
printsetup()
tab_1.tabpage_2.dw_2.print()
end event

type cb_preview from commandbutton within w_scarico_componenti_cx
event clicked pbm_bnclicked
int X=2158
int Y=32
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text="Preview" then
  tab_1.tabpage_2.dw_2.object.datawindow.print.preview='yes'
  tab_1.tabpage_2.dw_2.object.datawindow.print.preview.zoom='90'
  this.text="Exit"
else
 tab_1.tabpage_2.dw_2.object.datawindow.print.preview='no'
  this.text="Preview"
end if	
end event

