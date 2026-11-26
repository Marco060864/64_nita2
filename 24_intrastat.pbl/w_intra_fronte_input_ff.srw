forward
global type w_intra_fronte_input_ff from w_p_data
end type
type dw_intra_fronte_riepilogo_ff from u_dw_master_main within tabpage_1
end type
type dw_intra_fronte_riepilogo_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_intra_riep_acq_ff from u_dw_master_main within tabpage_2
end type
type tab_2 from tab within tabpage_2
end type
type tabpage_3 from userobject within tab_2
end type
type dw_intra_2bis_gd from u_dw_master_main within tabpage_3
end type
type tabpage_4 from userobject within tab_2
end type
type dw_intra_2ter_gd from u_dw_master_main within tabpage_4
end type
type st_1 from statictext within tabpage_2
end type
type cb_sposta2 from commandbutton within tabpage_2
end type
type cb_cancella_riga2 from commandbutton within tabpage_2
end type
type tabpage_5 from userobject within tab_1
end type
type st_2 from statictext within tabpage_5
end type
type dw_intra_riep_cess_ff from u_dw_master_main within tabpage_5
end type
type tab_3 from tab within tabpage_5
end type
type tabpage_6 from userobject within tab_3
end type
type dw_intra_1bis_gd from u_dw_master_main within tabpage_6
end type
type tabpage_7 from userobject within tab_3
end type
type dw_intra_1ter_gd from u_dw_master_main within tabpage_7
end type
type cb_sposta from commandbutton within tabpage_5
end type
type cb_cancella_riga from commandbutton within tabpage_5
end type
type cb_contabilita from commandbutton within w_intra_fronte_input_ff
end type
type p_1 from picture within w_intra_fronte_input_ff
end type
type cb_1 from commandbutton within w_intra_fronte_input_ff
end type
type tabpage_3 from userobject within tab_2
dw_intra_2bis_gd dw_intra_2bis_gd
end type
type tabpage_4 from userobject within tab_2
dw_intra_2ter_gd dw_intra_2ter_gd
end type
type tab_2 from tab within tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type tabpage_2 from userobject within tab_1
dw_intra_riep_acq_ff dw_intra_riep_acq_ff
tab_2 tab_2
st_1 st_1
cb_sposta2 cb_sposta2
cb_cancella_riga2 cb_cancella_riga2
end type
type tabpage_6 from userobject within tab_3
dw_intra_1bis_gd dw_intra_1bis_gd
end type
type tabpage_7 from userobject within tab_3
dw_intra_1ter_gd dw_intra_1ter_gd
end type
type tab_3 from tab within tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
type tabpage_5 from userobject within tab_1
st_2 st_2
dw_intra_riep_cess_ff dw_intra_riep_cess_ff
tab_3 tab_3
cb_sposta cb_sposta
cb_cancella_riga cb_cancella_riga
end type
end forward

global type w_intra_fronte_input_ff from w_p_data
int Width=3584
int Height=1444
boolean TitleBar=true
string Title="Intra Bis e Ter"
cb_contabilita cb_contabilita
p_1 p_1
cb_1 cb_1
end type
global w_intra_fronte_input_ff w_intra_fronte_input_ff

forward prototypes
public subroutine uf_canc_passaggio ()
public subroutine wf_sposta_su_bis (integer al_riga, u_dw_master_main adw_bis, u_dw_master_main adw_ter, string as_tipo)
public subroutine wf_sposta_su_ter (integer al_riga, u_dw_master_main adw_bis, u_dw_master_main adw_ter, string as_tipo)
public subroutine wf_rinumera_progressivi (u_dw_master_main adw_da_rinumerare)
public subroutine wf_salva_dw ()
end prototypes

public subroutine uf_canc_passaggio ();integer  ll_id_fronte

ll_id_fronte=tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemnumber(1, 'id_i_fronte')

delete from intra_1bis
where id_i_fronte = :ll_id_fronte;

delete from intra_2bis
where id_i_fronte = :ll_id_fronte;

delete from intra_1ter
where id_i_fronte = :ll_id_fronte;

delete from intra_2ter
where id_i_fronte = :ll_id_fronte;

messagebox ('OK', 'Rimossi precedenti passaggi dati')

TAB_1.TABPAGE_2.TAB_2.TABPAGE_3.dw_intra_2bis_gd.RETRIEVE(ll_id_fronte)
TAB_1.TABPAGE_2.TAB_2.TABPAGE_4.dw_intra_2ter_gd.RETRIEVE(ll_id_fronte)
TAB_1.TABPAGE_5.TAB_3.TABPAGE_6.dw_intra_1bis_gd.RETRIEVE(ll_id_fronte)
TAB_1.TABPAGE_5.TAB_3.TABPAGE_7.dw_intra_1ter_gd.RETRIEVE(ll_id_fronte)


end subroutine

public subroutine wf_sposta_su_bis (integer al_riga, u_dw_master_main adw_bis, u_dw_master_main adw_ter, string as_tipo);
string ls_par_iva, ls_segno, ls_rag_sociale, ls_nazione
long ll_id_natura_trans, ll_id_nomenclatura, ll_id_sog, ll_id_frontespizio
integer li_righe_bis, li_riga_trovata
decimal ldc_segno, ldc_amm_operazioni, ldc_val_statistico, ldc_amm_valuta


ls_par_iva=adw_ter.getitemstring(al_riga, "par_iva")
ll_id_natura_trans=adw_ter.getitemnumber(al_riga, "id_i_nat_trans")
ll_id_nomenclatura=adw_ter.getitemnumber(al_riga, "id_i_nomenclatura")
ls_segno=adw_ter.getitemstring(al_riga, "segno")		
if ls_segno='-' then 
	ldc_segno= -1 
else 
	ldc_segno=1
end if
ldc_amm_operazioni=adw_ter.getitemdecimal(al_riga, "amm_oper")*ldc_segno
if isnull(ldc_amm_operazioni) then ldc_amm_operazioni=0
ldc_val_statistico=adw_ter.getitemdecimal(al_riga, "val_stat")*ldc_segno
if isnull(ldc_val_statistico) then ldc_val_statistico=0
if as_tipo='A' then
	ldc_amm_valuta=adw_ter.getitemdecimal(al_riga, "amm_valuta")*ldc_segno
	if isnull(ldc_amm_valuta) then ldc_amm_valuta=0
end if
adw_bis.triggerevent("ue_insert")
li_riga_trovata=adw_bis.getrow()

ll_id_sog=adw_ter.getitemnumber(al_riga, "id_sog_commerciale")
ll_id_frontespizio=adw_ter.getitemnumber(al_riga, "id_i_fronte")
ls_rag_sociale=adw_ter.getitemstring(al_riga, "rag_soc_1")
ls_par_iva=adw_ter.getitemstring(al_riga, "par_iva" )
ls_nazione=adw_ter.getitemstring(al_riga, "nazione")
if as_tipo='A' then
	adw_bis.setitem(li_riga_trovata, "amm_valuta", ldc_amm_valuta)
end if
adw_bis.setitem(li_riga_trovata, "amm_operazioni", ldc_amm_operazioni)
adw_bis.setitem(li_riga_trovata, "valore_stat", ldc_val_statistico)
adw_bis.setitem(li_riga_trovata, "id_i_nat_trans", ll_id_natura_trans)
adw_bis.setitem(li_riga_trovata,"id_i_fronte", ll_id_frontespizio)
adw_bis.setitem(li_riga_trovata,"rag_soc_1", ls_rag_sociale)
adw_bis.setitem(li_riga_trovata,  "par_iva", ls_par_iva)
adw_bis.setitem(li_riga_trovata, "nazione", ls_nazione)
adw_bis.setitem(li_riga_trovata, "id_i_nomenclatura", ll_id_nomenclatura)
adw_bis.setitem(li_riga_trovata, "id_sog_commerciale", ll_id_sog)

adw_bis.scrolltorow(li_riga_trovata)
adw_ter.deleterow(al_riga)
	

end subroutine

public subroutine wf_sposta_su_ter (integer al_riga, u_dw_master_main adw_bis, u_dw_master_main adw_ter, string as_tipo);
string ls_par_iva, ls_segno, ls_rag_sociale, ls_nazione
long ll_id_natura_trans, ll_id_nomenclatura, ll_id_frontespizio, ll_id_sog
integer li_riga_inserita
decimal  ldc_amm_operazioni, ldc_val_statistico, ldc_amm_valuta

ls_segno='+'
if messagebox("Attenzione!", "La rettifica deve avere segno - ?", stopsign!, yesno!)=1 then
	ls_segno='-'
end if
ll_id_sog=adw_bis.getitemnumber(al_riga, "id_sog_commerciale")
ls_rag_sociale=adw_bis.getitemstring(al_riga, "rag_soc_1")
ls_nazione=adw_bis.getitemstring(al_riga, "nazione")
ls_par_iva=adw_bis.getitemstring(al_riga, "par_iva")
ll_id_natura_trans=adw_bis.getitemnumber(al_riga, "id_i_nat_trans")
ll_id_nomenclatura=adw_bis.getitemnumber(al_riga, "id_i_nomenclatura")
ll_id_frontespizio=adw_bis.getitemnumber(al_riga, "id_i_fronte")
ldc_amm_operazioni=adw_bis.getitemdecimal(al_riga, "amm_operazioni")
ldc_val_statistico=adw_bis.getitemdecimal(al_riga, "valore_stat")


adw_ter.triggerevent("ue_insert")
li_riga_inserita=adw_ter.getrow()

adw_ter.scrolltorow(li_riga_inserita)

if as_tipo='A' then
	ldc_amm_valuta=adw_bis.getitemdecimal(al_riga, "amm_valuta")
	adw_ter.setitem(li_riga_inserita, "amm_valuta", ldc_amm_valuta)
end if

adw_ter.setitem(li_riga_inserita, "amm_oper", ldc_amm_operazioni)
adw_ter.setitem(li_riga_inserita, "val_stat", ldc_val_statistico)
adw_ter.setitem(li_riga_inserita, "id_sog_commerciale", ll_id_sog)
adw_ter.setitem(li_riga_inserita, "segno", ls_segno)
adw_ter.setitem(li_riga_inserita, "id_i_nat_trans", ll_id_natura_trans)
adw_ter.setitem(li_riga_inserita, "id_i_nomenclatura", ll_id_nomenclatura)
adw_ter.setitem(li_riga_inserita, "id_i_fronte", ll_id_frontespizio)
adw_ter.setitem(li_riga_inserita, "rag_soc_1", ls_rag_sociale)
adw_ter.setitem(li_riga_inserita, "par_iva", ls_par_iva)
adw_ter.setitem(li_riga_inserita, "nazione", ls_nazione)

adw_bis.deleterow(al_riga)
end subroutine

public subroutine wf_rinumera_progressivi (u_dw_master_main adw_da_rinumerare);integer li_righe_totali, i
li_righe_totali=adw_da_rinumerare.rowcount()
for i= 1 to li_righe_totali
	adw_da_rinumerare.setitem(i, "prog_operazioni", i)
next
end subroutine

public subroutine wf_salva_dw ();


if tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.update()=1 then
	commit;
else
	rollback;
end if
end subroutine

on w_intra_fronte_input_ff.create
int iCurrent
call super::create
this.cb_contabilita=create cb_contabilita
this.p_1=create p_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_contabilita
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.cb_1
end on

on w_intra_fronte_input_ff.destroy
call super::destroy
destroy(this.cb_contabilita)
destroy(this.p_1)
destroy(this.cb_1)
end on

event open;call super::open;

idw_master = tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff
idw_master.is_list = Message.PowerObjectParm

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	ib_NonModale = TRUE
	idw_master.is_list.s_modo = modo_inserisci
	idw_master.ias_key_name[1] = "id_i_fronte"
END IF


il_helptopic = 71 
end event

event ue_post_open;call super::ue_post_open;
long ll_id_reg_pd, ll_id_conto, ll_id_sog_com, ll_id_registro, ll_id_i_fronte, ll_id_prof_reg
long					ll_i_fronte, ll_row
decimal ll_importo, ll_imp_valuta, ll_imponibile,ld_imp_origine
long ll_id_val_lire, ll_id_valuta, ll_id_wizard, ll_id_wizard_app
date ld_data_registrazione
string ls_tipo_reg, ls_riepilogo, ls_tipo_fattura
integer li_ret
string ls_rag_soc1, ls_pariva, ls_naz

ll_id_reg_pd = message.doubleparm

if message.doubleparm > 0 then
	
	select id_conto, data_registrazione, importo, imp_valuta, id_registro, id_prof_registrazione, id_valuta
	into :ll_id_conto, :ld_data_registrazione, :ll_importo, :ll_imp_valuta, :ll_id_registro, :ll_id_prof_reg, :ll_id_valuta
	from reg_pd
	where reg_pd.id_reg_pd = :ll_id_reg_pd;

   
	select tipo_fattura
	into :ls_tipo_fattura
	from prof_registrazione
	where id_prof_registrazione = :ll_id_prof_reg;

	select id_sog_commerciale
	into :ll_id_sog_com
	from sog_commerciale
	where sog_commerciale.id_conto = :ll_id_conto;

	
	select tipo_registro
	into :ls_tipo_reg
	from registro
	where registro.id_registro = :ll_id_registro;
	
	
	select id_val_lire
	into :ll_id_val_lire
	from par_sistema;

	
	select id_wizard
	into :ll_id_wizard
	from wizard
	where wizard.codice = 'IVACEE';
	
	select id_wizard
	into :ll_id_wizard_app
	from wiz_profilo
	where wiz_profilo.id_wizard = :ll_id_wizard
	and wiz_profilo.id_prof_registrazione = :ll_id_prof_reg;
	
	if sqlca.sqlcode <> 0 then 
		ll_imponibile = 0
	else 
		select sum(imponibile)
		into :ll_imponibile
		from mov_iva
		where mov_iva.id_reg_pd = :ll_id_reg_pd;
	end if
	
	CHOOSE CASE ls_tipo_reg
		CASE 'IV', 'IC'
			ls_riepilogo = 'C'
		CASE 'IA'
			ls_riepilogo = 'A'		
	END CHOOSE

	select id_i_fronte
	into :ll_id_i_fronte
	from intra_frontespizio_input
	where intra_frontespizio_input.riepilogo = :ls_riepilogo
	and :ld_data_registrazione >= intra_frontespizio_input.da_data1
	and :ld_data_registrazione <= intra_frontespizio_input.a_data1;
	if sqlca.sqlcode <> 0 then
		li_ret = messagebox("ATTENZIONE!","Non è stato trovato un Frontespizio valido per il periodo~r~nVUOI INSERIRLO?",Question!,YesNo!)
		if li_ret = 1 then
			open(w_intra_frontespizio_input_cx)
			select id_i_fronte
			into :ll_id_i_fronte
			from intra_frontespizio_input
			where intra_frontespizio_input.riepilogo = :ls_riepilogo
			and :ld_data_registrazione >= intra_frontespizio_input.da_data1
			and :ld_data_registrazione <= intra_frontespizio_input.a_data1;			
		end if
	end if
	if sqlca.sqlcode = 0 then	
		ll_i_fronte = ll_id_i_fronte
		idw_master.is_list.s_modo = modo_modifica
		idw_master.is_list.s_identifica[1] = "id_i_fronte"
		idw_master.is_list.l_identifica[1] = ll_i_fronte
		idw_master.Event ue_retrieve(0, 0)
		idw_master.SetFocus()
		tab_1.selecttab(1)
	
		cb_contabilita.enabled = true

		select rag_soc_1, par_iva, nazione
		into :ls_rag_soc1, :ls_pariva, :ls_naz
		from sog_commerciale_gen
		where id_sog_commerciale = :ll_id_sog_com;
		
		if ls_riepilogo = 'C' then
			
			if ls_tipo_fattura = 'N' then
				tab_1.tabpage_5.tab_3.tabpage_6.dw_intra_1bis_gd.triggerevent("ue_insert")
				ll_row = tab_1.tabpage_5.tab_3.tabpage_6.dw_intra_1bis_gd.getrow()
				tab_1.tabpage_5.tab_3.tabpage_6.dw_intra_1bis_gd.setitem(ll_row,"id_sog_commerciale",ll_id_sog_com)
				tab_1.tabpage_5.tab_3.tabpage_6.dw_intra_1bis_gd.setitem(ll_row,"rag_soc_1",ls_rag_soc1)
				tab_1.tabpage_5.tab_3.tabpage_6.dw_intra_1bis_gd.setitem(ll_row,"par_iva",ls_pariva)
				tab_1.tabpage_5.tab_3.tabpage_6.dw_intra_1bis_gd.setitem(ll_row,"nazione",ls_naz)
				tab_1.tabpage_5.tab_3.tabpage_6.dw_intra_1bis_gd.setitem(ll_row,"amm_operazioni",ll_importo)			
			end if
			if ls_tipo_fattura = 'C' then
				tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.triggerevent("ue_insert")
				ll_row = tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.getrow()
				
				tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.setitem(ll_row,"id_sog_commerciale",ll_id_sog_com)
				tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.setitem(ll_row,"rag_soc_1",ls_rag_soc1)
				tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.setitem(ll_row,"par_iva",ls_pariva)
				tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.setitem(ll_row,"nazione",ls_naz)
				tab_1.tabpage_5.tab_3.tabpage_7.dw_intra_1ter_gd.setitem(ll_row,"amm_operazioni",ll_importo)				
			end if
		end if
		
		if ls_riepilogo = 'A' then
			if ls_tipo_fattura = 'N' then			
				tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.triggerevent("ue_insert")			
			
				ll_row = tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.getrow()			
			
				tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.setitem(ll_row,"id_sog_commerciale",ll_id_sog_com)
				tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.setitem(ll_row,"rag_soc_1",ls_rag_soc1)
				tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.setitem(ll_row,"par_iva",ls_pariva)
				tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.setitem(ll_row,"nazione",ls_naz)
				
				if ll_imponibile = 0 then
					tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.setitem(ll_row,"amm_operazioni",ll_importo)	
				else
					tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.setitem(ll_row,"amm_operazioni",ll_imponibile)	
				end if
				if ll_id_val_lire <> ll_id_valuta then 
					tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.setitem(ll_row,"amm_valuta",ll_imp_valuta)
				end if
			end if
			if ls_tipo_fattura = 'C' then			
				tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.triggerevent("ue_insert")			
			
				ll_row = tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.getrow()			
			
				tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.setitem(ll_row,"id_sog_commerciale",ll_id_sog_com)
				tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.setitem(ll_row,"rag_soc_1",ls_rag_soc1)
				tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.setitem(ll_row,"par_iva",ls_pariva)
				tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.setitem(ll_row,"nazione",ls_naz)			
				
				if ll_imponibile = 0 then				
					tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.setitem(ll_row,"amm_operazioni",ll_importo)						
				else
					tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.setitem(ll_row,"amm_operazioni",ll_imponibile)						
				end if
				if ll_id_val_lire <> ll_id_valuta then 
					tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.setitem(ll_row,"amm_valuta",ll_imp_valuta)
				end if
			end if			
		end if		
	end if
end if

end event

type p_crescente from w_p_data`p_crescente within w_intra_fronte_input_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_intra_fronte_input_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_intra_fronte_input_ff
boolean BringToTop=true
end type

event cb_ok::clicked;cb_salva.triggerevent(clicked!)
Super::EVENT Clicked()
end event

type cb_annulla from w_p_data`cb_annulla within w_intra_fronte_input_ff
int X=325
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_intra_fronte_input_ff
int X=2318
int Width=224
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

event cb_nuovo::clicked;call super::clicked;idw_master.is_list.s_modo = modo_inserisci
tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.reset()
parent.triggerevent ("ue_insert_mode")
tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.setfocus()
end event

type cb_inserisci from w_p_data`cb_inserisci within w_intra_fronte_input_ff
int X=3063
int Width=224
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_intra_fronte_input_ff
int X=951
int Y=28
int Width=434
boolean Visible=false
boolean BringToTop=true
end type

event cb_cancella::clicked;call super::clicked;w_p_data  lw_win
u_dw_main  lu_dw

lw_win = u_freddie.iw_current
lu_dw= u_freddie.iudw_current

IF IsValid(lu_dw) THEN
	IF isValid (lu_dw.iudw_parent) then
		if not lu_dw.ib_dw_shared THEN
			if lu_dw.rowcount() >0 then
				parent.triggerevent("ue_delete")
			end if
		end if
	else
		idw_master.event ue_delete (0,0)
	end if
end if

end event

type cb_salva from w_p_data`cb_salva within w_intra_fronte_input_ff
int X=3314
int Width=224
boolean BringToTop=true
end type

event cb_salva::clicked;call super::clicked;wf_salva_dw()
end event

type tab_1 from w_p_data`tab_1 within w_intra_fronte_input_ff
int Y=192
int Width=3520
int Height=1152
int TabOrder=30
boolean BringToTop=true
long BackColor=79741120
int Weight=700
tabpage_2 tabpage_2
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_5=create tabpage_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_5
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_5)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3483
int Height=1032
long BackColor=79741120
string Text="Dati Riepilogo"
long TabBackColor=79741120
long PictureMaskColor=553648127
dw_intra_fronte_riepilogo_ff dw_intra_fronte_riepilogo_ff
end type

on tabpage_1.create
this.dw_intra_fronte_riepilogo_ff=create dw_intra_fronte_riepilogo_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_intra_fronte_riepilogo_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_intra_fronte_riepilogo_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_intra_fronte_input_ff
int X=2811
int Width=224
boolean BringToTop=true
string Text="&Ricerca.."
end type

event cb_ricerca::clicked;
w_search_main		lw_sm
long					ll_i_fronte, ll_row
s_ric_param			ls_ricpar

idw_master.is_ricpar.s_filter_name = "denominazione"
idw_master.is_ricpar.s_filter_value=""
OpenWithParm (lw_sm, idw_master.is_ricpar, "w_intra_frontespizio_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_i_fronte = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_i_fronte"
	idw_master.is_list.l_identifica[1] = ll_i_fronte
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetFocus()
	
	tab_1.selecttab(1)
end if
cb_contabilita.enabled = true
end event

type dw_intra_fronte_riepilogo_ff from u_dw_master_main within tabpage_1
int X=9
int Y=32
int Width=3456
int Height=1000
int TabOrder=1
string DataObject="d_intra_fronte_riepilogo_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_i_fronte"
iudw_children[1]=tab_1.tabpage_2.dw_intra_riep_acq_ff
iudw_children[2]=tab_1.tabpage_5.dw_intra_riep_cess_ff
is_list.s_colonne_drop[1]="riepilogo"
is_list.s_colonne_drop[2]="tipo_riepilogo"



end event

event itemfocuschanged;call super::itemfocuschanged;integer li_rig
string ls_modello 

	li_rig = tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getrow ()
	ls_modello = tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemstring (li_rig, "riepilogo")
	
	
	IF ls_modello = "A" then
			tab_1.tabpage_2.visible = true
			tab_1.tabpage_5.visible = false

	end if
	IF ls_modello = "C" then
		tab_1.tabpage_5.visible = true
		tab_1.tabpage_2.visible = false

	end if


end event

event ue_key;DataWindowChild	ldw_dropdown
DataWindowChild	ldw_drop
string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval
integer				li_cdw, li_size, li_i, li_ret
w_search_main		lw_sm
w_data_main			lw_win
w_mod_single_data lw_mw
w_p_data				lw_pwin
u_dw_main			lu_dw

long					ll_retv


ll_retv = 0


choose case key
	
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
	
		
	case KeyF4!
		ll_retv = 1
		ib_during_f4 = true
		is_ricpar = is_e_ricpar
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		is_ricpar.b_imm_retrieve = false
		is_ricpar.s_caller_column = ls_column
		is_ricpar.s_sql_cond = ""
		is_search_window = ""
		ls_colval = ""
		trigger event ue_set_search (ls_column,ls_colval)
		if (is_search_window) <> "" then
			choose case keyflags
				case 0	
					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = false
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) <> "dddw" then
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						
						
						
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
					
				case 1	

					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column, ls_colval)
					if lower (ls_style) = "dddw" then
						
						OpenWithParm (lw_mw,is_ricpar,is_search_window)
						this.GetChild (ls_column, ldw_dropdown)
						ldw_dropdown.SetTransObject(SQLCA)
						ldw_dropdown.Retrieve ()
						li_size = upperbound(is_ricpar.s_ausil_value)
						for li_i = 1 to li_size
							if is_ricpar.s_ausil_value[li_i] > " " then
								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
								ldw_dropdown.SetTransObject(SQLCA)
								ldw_dropdown.Retrieve ()
							end if
						next
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
				case 2	
				case 3	
					ls_colval = gettext()
					is_ricpar.b_imm_maint = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) = "dddw" then
						
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						if not IsNull(Message.PowerObjectParm) then
							is_ricpar = Message.PowerObjectParm
							trigger event ue_use_search (ls_column)
						end if
					end if
					is_ricpar.b_imm_maint = false
			end choose
		end if
		ib_during_f4 = false


	
	

	case KeyS!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
	case KeyF12!
		if (keyFlags=0) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
		
		
		if (keyflags=3) then
			lw_win = u_freddie.iw_current
			lw_win.trigger event key (keyF12!,3)
		end if
	

	case KeyF6!
		lw_win = u_freddie.iw_current
		ls_tipof = lw_win.is_wintype
		if ls_tipof = "W_P_DATA" then
			lw_win.ib_F6_in_dw = true
			if (keyflags=0) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw++
					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
		end if
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
			ll_retv = 1
		end if
end choose


return ll_retv


end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=3483
int Height=1032
long BackColor=79741120
string Text="Acquisizioni"
long TabBackColor=79741120
long TabTextColor=255
long PictureMaskColor=536870912
dw_intra_riep_acq_ff dw_intra_riep_acq_ff
tab_2 tab_2
st_1 st_1
cb_sposta2 cb_sposta2
cb_cancella_riga2 cb_cancella_riga2
end type

on tabpage_2.create
this.dw_intra_riep_acq_ff=create dw_intra_riep_acq_ff
this.tab_2=create tab_2
this.st_1=create st_1
this.cb_sposta2=create cb_sposta2
this.cb_cancella_riga2=create cb_cancella_riga2
this.Control[]={this.dw_intra_riep_acq_ff,&
this.tab_2,&
this.st_1,&
this.cb_sposta2,&
this.cb_cancella_riga2}
end on

on tabpage_2.destroy
destroy(this.dw_intra_riep_acq_ff)
destroy(this.tab_2)
destroy(this.st_1)
destroy(this.cb_sposta2)
destroy(this.cb_cancella_riga2)
end on

type dw_intra_riep_acq_ff from u_dw_master_main within tabpage_2
int X=9
int Y=88
int Width=1947
int Height=124
int TabOrder=10
string DataObject="d_intra_riep_acq_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared=true
ias_key_name[1] = "id_i_fronte"
iudw_children[1]=tab_2.tabpage_3.dw_intra_2bis_gd
iudw_children[2]=tab_2.tabpage_4.dw_intra_2ter_gd



end event

event ue_key;DataWindowChild	ldw_dropdown
DataWindowChild	ldw_drop
string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval
integer				li_cdw, li_size, li_i, li_ret
w_search_main		lw_sm
w_data_main			lw_win
w_mod_single_data lw_mw
w_p_data				lw_pwin
u_dw_main			lu_dw

long					ll_retv


ll_retv = 0


choose case key
	
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
	
		
	case KeyF4!
		ll_retv = 1
		ib_during_f4 = true
		is_ricpar = is_e_ricpar
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		is_ricpar.b_imm_retrieve = false
		is_ricpar.s_caller_column = ls_column
		is_ricpar.s_sql_cond = ""
		is_search_window = ""
		ls_colval = ""
		trigger event ue_set_search (ls_column,ls_colval)
		if (is_search_window) <> "" then
			choose case keyflags
				case 0	
					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = false
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) <> "dddw" then
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						
						
						
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
					
				case 1	

					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column, ls_colval)
					if lower (ls_style) = "dddw" then
						
						OpenWithParm (lw_mw,is_ricpar,is_search_window)
						this.GetChild (ls_column, ldw_dropdown)
						ldw_dropdown.SetTransObject(SQLCA)
						ldw_dropdown.Retrieve ()
						li_size = upperbound(is_ricpar.s_ausil_value)
						for li_i = 1 to li_size
							if is_ricpar.s_ausil_value[li_i] > " " then
								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
								ldw_dropdown.SetTransObject(SQLCA)
								ldw_dropdown.Retrieve ()
							end if
						next
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
				case 2	
				case 3	
					ls_colval = gettext()
					is_ricpar.b_imm_maint = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) = "dddw" then
						
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						if not IsNull(Message.PowerObjectParm) then
							is_ricpar = Message.PowerObjectParm
							trigger event ue_use_search (ls_column)
						end if
					end if
					is_ricpar.b_imm_maint = false
			end choose
		end if
		ib_during_f4 = false


	
	

	case KeyS!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
	case KeyF12!
		if (keyFlags=0) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
		
		
		if (keyflags=3) then
			lw_win = u_freddie.iw_current
			lw_win.trigger event key (keyF12!,3)
		end if
	

	case KeyF6!
		lw_win = u_freddie.iw_current
		ls_tipof = lw_win.is_wintype
		if ls_tipof = "W_P_DATA" then
			lw_win.ib_F6_in_dw = true
			if (keyflags=0) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw++
					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
		end if
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
			ll_retv = 1
		end if
end choose


return ll_retv


end event

type tab_2 from tab within tabpage_2
int X=5
int Y=248
int Width=3451
int Height=784
int TabOrder=20
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_2.create
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_3,&
this.tabpage_4}
end on

on tab_2.destroy
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_3 from userobject within tab_2
int X=18
int Y=104
int Width=3415
int Height=664
long BackColor=79741120
string Text="Intra 2 Bis"
long TabBackColor=79741120
long TabTextColor=255
long PictureMaskColor=536870912
dw_intra_2bis_gd dw_intra_2bis_gd
end type

on tabpage_3.create
this.dw_intra_2bis_gd=create dw_intra_2bis_gd
this.Control[]={this.dw_intra_2bis_gd}
end on

on tabpage_3.destroy
destroy(this.dw_intra_2bis_gd)
end on

type dw_intra_2bis_gd from u_dw_master_main within tabpage_3
int X=23
int Y=28
int Width=3378
int Height=620
int TabOrder=3
string DataObject="d_intra_2bis_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_i_fronte"

is_list.s_colonne_drop[1]="id_sog_commerciale"
is_list.s_colonne_drop[2]="id_sog_commerciale"
is_list.s_colonne_drop[3]="id_sog_commerciale"
is_list.s_colonne_drop[4]="id_i_nat_trans"
is_list.s_colonne_drop[5]="id_i_nomenclatura"
is_list.s_colonne_drop[6]="id_i_modo_trsp"
is_list.s_colonne_drop[7]="id_i_tab_iso"
is_list.s_colonne_drop[8]="intra_tab_iso"
is_list.s_colonne_drop[9]="id_localita"



end event

event ue_insert;call super::ue_insert;long ll_riga, ll_rig, ll_row
string ls_codice, ls_cod, var
dwitemstatus l_status

integer li_id, num

ll_riga = dw_intra_2bis_gd.getrow()
l_status=dw_intra_2bis_gd.getitemstatus(ll_riga,0,Primary!)

if l_status=New!  then
	ll_row = dw_intra_2bis_gd.RowCount( ) 
	num = ll_row
	dw_intra_2bis_gd.setitem (ll_riga, 'prog_operazioni',num)
end if

dw_intra_2bis_gd.ScrollToRow(ll_riga) 
end event

event updateend;long ll_riga, ll_rig, ll_row, amm_1
string ls_codice, ls_cod, var
integer li_id, num, prog

ll_riga = dw_intra_2bis_gd.getrow()

if ll_riga > 0 then li_id = 	dw_intra_2bis_gd.getitemnumber (ll_riga, "id_i_fronte")

select sum (amm_operazioni)
into :amm_1
from intra_2bis
where id_i_fronte = :li_id;


select max (prog_operazioni)
into :prog
from intra_2bis
where id_i_fronte = :li_id;



update intra_frontespizio_input
 set amm_compl_sez1 = :amm_1, tot_rig_sez1 = :prog, tot_sez1 = 1
 where id_i_fronte = :li_id
 using SQLCA;
 
tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.retrieve()

end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		is_search_window = "w_intra_sog_com_FO_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE


CHOOSE CASE as_nomecol
		
	CASE "id_i_nat_trans"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nat_transazione_gd"
		is_ricpar.s_titolo_finestra = "Natura Transazione"
		is_ricpar.s_ausil_value[1] = "desc_nat_trans"
		
	CASE "id_i_nomenclatura"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nomenclatura_gd"
		is_ricpar.s_titolo_finestra = "Nomenclatura"
		is_ricpar.s_ausil_value[1] = "desc_nomen"
		
	CASE "id_i_cod_cons"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_condizioni_consegna_gd"
		is_ricpar.s_titolo_finestra = "Condizioni Consegna"
	   is_ricpar.s_ausil_value[1] = "desc_cons"
		
	CASE "id_i_modo_trsp"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_modo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Modo trasporto"
		is_ricpar.s_ausil_value[1] = "descrizione"

	CASE "id_i_tab_iso"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_tab_codici_iso_gd"
		is_ricpar.s_titolo_finestra = "Codici Iso"
		is_ricpar.s_ausil_value[1] = "stato"
		
	CASE "intra_tab_iso"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_tab_codici_iso_gd"
		is_ricpar.s_titolo_finestra = "Codici Iso"
		is_ricpar.s_ausil_value[1] = "stato"
		
	CASE "id_localita"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_localita_gd"
		is_ricpar.s_titolo_finestra = "Località"
		is_ricpar.s_ausil_value[1] = "localita"		

END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		uf_set_colval("rag_soc_1", is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("par_iva", is_ricpar.s_ausil_value[1])
		uf_set_colval("nazione", is_ricpar.s_ausil_value[2])
END CHOOSE
end event

event itemchanged;choose case dwo.name
	case 'amm_operazioni'
      dw_intra_2bis_gd.setitem(row,"valore_stat",long(data))		
end choose
end event

event updatestart;wf_rinumera_progressivi(this)
end event

type tabpage_4 from userobject within tab_2
int X=18
int Y=104
int Width=3415
int Height=664
long BackColor=79741120
string Text="Intra 2 Ter"
long TabBackColor=79741120
long TabTextColor=255
long PictureMaskColor=536870912
dw_intra_2ter_gd dw_intra_2ter_gd
end type

on tabpage_4.create
this.dw_intra_2ter_gd=create dw_intra_2ter_gd
this.Control[]={this.dw_intra_2ter_gd}
end on

on tabpage_4.destroy
destroy(this.dw_intra_2ter_gd)
end on

type dw_intra_2ter_gd from u_dw_master_main within tabpage_4
int X=18
int Y=28
int Width=3378
int Height=620
int TabOrder=3
string DataObject="d_intra_2ter_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_i_fronte"

is_list.s_colonne_drop[1]="id_sog_commerciale"
is_list.s_colonne_drop[2]="id_sog_commerciale"
is_list.s_colonne_drop[3]="id_sog_commerciale"
is_list.s_colonne_drop[4]="segn"
is_list.s_colonne_drop[5]="id_i_nat_trans"
is_list.s_colonne_drop[6]="id_i_nomenclatura"

end event

event ue_insert;call super::ue_insert;long ll_riga, ll_rig, ll_row
string ls_codice, ls_cod, var
dwitemstatus l_status

integer li_id, num

ll_riga = dw_intra_2ter_gd.getrow()
l_status=dw_intra_2ter_gd.getitemstatus(ll_riga,0,Primary!)

if l_status=New!  then
	ll_row = dw_intra_2ter_gd.RowCount( ) 
	num = ll_row
	dw_intra_2ter_gd.setitem (ll_riga, 'prog_operazioni',num)
end if

dw_intra_2ter_gd.ScrollToRow(ll_riga) 
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		is_search_window = "w_intra_sog_com_FO_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_i_nat_trans"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nat_transazione_gd"
		is_ricpar.s_titolo_finestra = "Natura Transazione"
		is_ricpar.s_ausil_value[1] = "desc_nat_trans"
		
	CASE "id_i_nomenclatura"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nomenclatura_gd"
		is_ricpar.s_titolo_finestra = "Nomenclatura"
		is_ricpar.s_ausil_value[1] = "desc_nomen"
		
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		uf_set_colval("rag_soc_1", is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("par_iva", is_ricpar.s_ausil_value[1])
		uf_set_colval("nazione", is_ricpar.s_ausil_value[2])
END CHOOSE
end event

event updateend;long ll_riga, ll_rig, ll_row, amm_1, amm_temp
string ls_codice, ls_cod, var, ss_segno
integer li_id, num, prog

ll_riga = dw_intra_2ter_gd.getrow()

if ll_riga > 0 then li_id = 	dw_intra_2ter_gd.getitemnumber (ll_riga, "id_i_fronte")

select max (prog_oper)
into :prog
from intra_2ter
where id_i_fronte = :li_id;

amm_1=0;

declare somma cursor for
select amm_oper,segn
from intra_2ter
where id_i_fronte= :li_id;

open somma;

fetch somma into :amm_temp, :ss_segno;

do while SQLCA.sqlcode = 0

  if ss_segno="+" then
	  amm_1 += amm_temp
  else
	  amm_1 -= amm_temp
  end if

  fetch somma into :amm_temp, :ss_segno;
loop
close somma;

update intra_frontespizio_input
 set amm_compl_sez2 = :amm_1, tot_rig_sez2  = :prog, tot_sez2 = 1
 where id_i_fronte = :li_id
 using SQLCA;
 
tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.retrieve()

end event

event itemchanged;choose case dwo.name
	case 'amm_oper'
      dw_intra_2ter_gd.setitem(row,"val_stat",long(data))		
end choose
end event

event updatestart;wf_rinumera_progressivi(this)
end event

type st_1 from statictext within tabpage_2
int X=9
int Y=12
int Width=297
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="RIEPILOGO"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_sposta2 from commandbutton within tabpage_2
int X=1938
int Y=228
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Sposta"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_riga
choose case u_freddie.iudw_current
	case tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd
		 li_riga=tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd.getrow()
		 if li_riga>0 then
			wf_sposta_su_bis(li_riga,tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd  ,&
			tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd, 'A')
		end if
	case tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd 	
			 li_riga=tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd.getrow()
		 if li_riga>0 then
			wf_sposta_su_ter(li_riga, tab_1.tabpage_2.tab_2.tabpage_3.dw_intra_2bis_gd  ,&
			tab_1.tabpage_2.tab_2.tabpage_4.dw_intra_2ter_gd, 'A')
		end if
end choose
end event

type cb_cancella_riga2 from commandbutton within tabpage_2
int X=2213
int Y=228
int Width=256
int Height=108
int TabOrder=41
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_riga
li_riga=u_freddie.iudw_current.getrow()
if li_riga>0 then
	u_freddie.iudw_current.deleterow(li_riga)
end if
end event

type tabpage_5 from userobject within tab_1
int X=18
int Y=104
int Width=3483
int Height=1032
long BackColor=79741120
string Text="Cessioni"
long TabBackColor=79741120
long TabTextColor=32768
long PictureMaskColor=536870912
st_2 st_2
dw_intra_riep_cess_ff dw_intra_riep_cess_ff
tab_3 tab_3
cb_sposta cb_sposta
cb_cancella_riga cb_cancella_riga
end type

on tabpage_5.create
this.st_2=create st_2
this.dw_intra_riep_cess_ff=create dw_intra_riep_cess_ff
this.tab_3=create tab_3
this.cb_sposta=create cb_sposta
this.cb_cancella_riga=create cb_cancella_riga
this.Control[]={this.st_2,&
this.dw_intra_riep_cess_ff,&
this.tab_3,&
this.cb_sposta,&
this.cb_cancella_riga}
end on

on tabpage_5.destroy
destroy(this.st_2)
destroy(this.dw_intra_riep_cess_ff)
destroy(this.tab_3)
destroy(this.cb_sposta)
destroy(this.cb_cancella_riga)
end on

type st_2 from statictext within tabpage_5
int X=9
int Y=12
int Width=297
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="RIEPILOGO"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_intra_riep_cess_ff from u_dw_master_main within tabpage_5
int X=9
int Y=88
int Width=1947
int Height=124
int TabOrder=3
string DataObject="d_intra_riep_cess_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared=true
ias_key_name[1] = "id_i_fronte"
iudw_children[1]=tab_3.tabpage_6.dw_intra_1bis_gd
iudw_children[2]=tab_3.tabpage_7.dw_intra_1ter_gd



end event

event ue_key;DataWindowChild	ldw_dropdown
DataWindowChild	ldw_drop
string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval
integer				li_cdw, li_size, li_i, li_ret
w_search_main		lw_sm
w_data_main			lw_win
w_mod_single_data lw_mw
w_p_data				lw_pwin
u_dw_main			lu_dw

long					ll_retv


ll_retv = 0


choose case key
	
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
	
		
	case KeyF4!
		ll_retv = 1
		ib_during_f4 = true
		is_ricpar = is_e_ricpar
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		is_ricpar.b_imm_retrieve = false
		is_ricpar.s_caller_column = ls_column
		is_ricpar.s_sql_cond = ""
		is_search_window = ""
		ls_colval = ""
		trigger event ue_set_search (ls_column,ls_colval)
		if (is_search_window) <> "" then
			choose case keyflags
				case 0	
					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = false
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) <> "dddw" then
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						
						
						
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
					
				case 1	

					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column, ls_colval)
					if lower (ls_style) = "dddw" then
						
						OpenWithParm (lw_mw,is_ricpar,is_search_window)
						this.GetChild (ls_column, ldw_dropdown)
						ldw_dropdown.SetTransObject(SQLCA)
						ldw_dropdown.Retrieve ()
						li_size = upperbound(is_ricpar.s_ausil_value)
						for li_i = 1 to li_size
							if is_ricpar.s_ausil_value[li_i] > " " then
								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
								ldw_dropdown.SetTransObject(SQLCA)
								ldw_dropdown.Retrieve ()
							end if
						next
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
				case 2	
				case 3	
					ls_colval = gettext()
					is_ricpar.b_imm_maint = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) = "dddw" then
						
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						if not IsNull(Message.PowerObjectParm) then
							is_ricpar = Message.PowerObjectParm
							trigger event ue_use_search (ls_column)
						end if
					end if
					is_ricpar.b_imm_maint = false
			end choose
		end if
		ib_during_f4 = false


	
	

	case KeyS!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
	case KeyF12!
		if (keyFlags=0) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
		
		
		if (keyflags=3) then
			lw_win = u_freddie.iw_current
			lw_win.trigger event key (keyF12!,3)
		end if
	

	case KeyF6!
		lw_win = u_freddie.iw_current
		ls_tipof = lw_win.is_wintype
		if ls_tipof = "W_P_DATA" then
			lw_win.ib_F6_in_dw = true
			if (keyflags=0) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw++
					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
		end if
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
			ll_retv = 1
		end if
end choose


return ll_retv


end event

type tab_3 from tab within tabpage_5
int X=9
int Y=244
int Width=3456
int Height=784
int TabOrder=21
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_3.create
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_6,&
this.tabpage_7}
end on

on tab_3.destroy
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_6 from userobject within tab_3
int X=18
int Y=104
int Width=3419
int Height=664
long BackColor=79741120
string Text="Intra 1 Bis"
long TabBackColor=79741120
long TabTextColor=32768
long PictureMaskColor=536870912
dw_intra_1bis_gd dw_intra_1bis_gd
end type

on tabpage_6.create
this.dw_intra_1bis_gd=create dw_intra_1bis_gd
this.Control[]={this.dw_intra_1bis_gd}
end on

on tabpage_6.destroy
destroy(this.dw_intra_1bis_gd)
end on

type dw_intra_1bis_gd from u_dw_master_main within tabpage_6
int X=18
int Y=32
int Width=3387
int Height=620
int TabOrder=3
boolean BringToTop=true
string DataObject="d_intra_1bis_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_i_fronte"

is_list.s_colonne_drop[1]="id_sog_commerciale"
is_list.s_colonne_drop[2]="id_sog_commerciale"
is_list.s_colonne_drop[3]="id_sog_commerciale"
is_list.s_colonne_drop[4]="id_i_nat_trans"
is_list.s_colonne_drop[5]="id_i_nomenclatura"
is_list.s_colonne_drop[6]="id_i_modo_trsp"
is_list.s_colonne_drop[7]="id_i_tab_iso"
is_list.s_colonne_drop[8]="id_localita"
is_list.s_colonne_drop[9]="id_i_cond_cons"

end event

event ue_insert;call super::ue_insert;long ll_riga, ll_rig, ll_row
string ls_codice, ls_cod, var
dwitemstatus l_status

integer li_id, num

ll_riga = dw_intra_1bis_gd.getrow()
l_status=dw_intra_1bis_gd.getitemstatus(ll_riga,0,Primary!)

if l_status=new!  then
	ll_row = dw_intra_1bis_gd.RowCount( ) 
	num = ll_row
	dw_intra_1bis_gd.setitem (ll_riga, 'prog_operazioni',num)
end if

dw_intra_1bis_gd.ScrollToRow(ll_row) 
end event

event updateend;long ll_riga, ll_rig, ll_row, amm_1
string ls_codice, ls_cod, var
integer li_id, num, prog

ll_riga = dw_intra_1bis_gd.getrow()

if ll_riga > 0 then li_id = 	dw_intra_1bis_gd.getitemnumber (ll_riga, "id_i_fronte")

select sum (amm_operazioni)
into :amm_1
from intra_1bis
where id_i_fronte = :li_id;


select max (prog_operazioni)
into :prog
from intra_1bis
where id_i_fronte = :li_id;



update intra_frontespizio_input
 set amm_compl_sez1 = :amm_1, tot_rig_sez1 = :prog, tot_sez1 = 1
 where id_i_fronte = :li_id
 using SQLCA;
 
tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.retrieve()

end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		is_search_window = "w_intra_sog_com_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_i_nat_trans"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nat_transazione_gd"
		is_ricpar.s_titolo_finestra = "Natura Transazione"
		is_ricpar.s_ausil_value[1] = "desc_nat_trans"
		
	CASE "id_i_nomenclatura"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nomenclatura_gd"
		is_ricpar.s_titolo_finestra = "Nomenclatura"
		is_ricpar.s_ausil_value[1] = "desc_nomen"
		
	CASE "id_i_cod_cons"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_condizioni_consegna_gd"
		is_ricpar.s_titolo_finestra = "Condizioni Consegna"
	   is_ricpar.s_ausil_value[1] = "desc_cons"
		
	CASE "id_i_modo_trsp"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_modo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Modo trasporto"
		is_ricpar.s_ausil_value[1] = "descrizione"

	CASE "id_i_tab_iso"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_tab_codici_iso_gd"
		is_ricpar.s_titolo_finestra = "Codici Iso"
		is_ricpar.s_ausil_value[1] = "stato"
		
	CASE "id_localita"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_localita_gd"
		is_ricpar.s_titolo_finestra = "Località"
		is_ricpar.s_ausil_value[1] = "localita"		

END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		uf_set_colval("rag_soc_1", is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("par_iva", is_ricpar.s_ausil_value[1])
		uf_set_colval("nazione", is_ricpar.s_ausil_value[2])
END CHOOSE
end event

event itemchanged;choose case dwo.name
	case 'amm_operazioni'
      dw_intra_1bis_gd.setitem(row,"valore_stat",long(data))		
end choose
end event

event updatestart;wf_rinumera_progressivi(this)
end event

type tabpage_7 from userobject within tab_3
int X=18
int Y=104
int Width=3419
int Height=664
long BackColor=79741120
string Text="Intra 1 Ter"
long TabBackColor=79741120
long TabTextColor=32768
long PictureMaskColor=536870912
dw_intra_1ter_gd dw_intra_1ter_gd
end type

on tabpage_7.create
this.dw_intra_1ter_gd=create dw_intra_1ter_gd
this.Control[]={this.dw_intra_1ter_gd}
end on

on tabpage_7.destroy
destroy(this.dw_intra_1ter_gd)
end on

type dw_intra_1ter_gd from u_dw_master_main within tabpage_7
int X=23
int Y=32
int Width=3378
int Height=620
int TabOrder=3
boolean BringToTop=true
string DataObject="d_intra_1ter_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_i_fronte"

is_list.s_colonne_drop[1]="id_sog_commerciale"
is_list.s_colonne_drop[2]="id_sog_commerciale"
is_list.s_colonne_drop[3]="id_sog_commerciale"
is_list.s_colonne_drop[4]="segno"
is_list.s_colonne_drop[5]="id_i_nat_trans"
is_list.s_colonne_drop[6]="id_i_nomenclatura"

end event

event ue_insert;call super::ue_insert;long ll_riga, ll_rig, ll_row
string ls_codice, ls_cod, var
dwitemstatus l_status

integer li_id, num

ll_riga = dw_intra_1ter_gd.getrow()
l_status=dw_intra_1ter_gd.getitemstatus(ll_riga,0,Primary!)

if l_status=New!  then
	ll_row = dw_intra_1ter_gd.RowCount( ) 
	num = ll_row
	dw_intra_1ter_gd.setitem (ll_riga, 'prog_operazioni',num)
end if

dw_intra_1ter_gd.ScrollToRow(ll_riga) 
end event

event updateend;long ll_riga, ll_rig, ll_row, amm_1, amm_temp
string ls_codice, ls_cod, var, ss_segno
integer li_id, num, prog

ll_riga = dw_intra_1ter_gd.getrow()

if ll_riga > 0 then 
	li_id = 	dw_intra_1ter_gd.getitemnumber (ll_riga, "id_i_fronte")
	
	select max (prog_operaz)
	into :prog
	from intra_1ter
	where id_i_fronte = :li_id;
	
	amm_1=0;
	
	declare somma cursor for
	select amm_operaz,segno
	from intra_1ter
	where id_i_fronte= :li_id;
	
	open somma;
	
	fetch somma into :amm_temp, :ss_segno;
	
	do while SQLCA.sqlcode = 0
	
	  if ss_segno="+" then
		  amm_1 += amm_temp
	  else
		  amm_1 -= amm_temp
	  end if
	
	  fetch somma into :amm_temp, :ss_segno;
	loop
	close somma;
	
	update intra_frontespizio_input
	 set amm_compl_sez2 = :amm_1, tot_rig_sez2  = :prog, tot_sez2 = 1
	 where id_i_fronte = :li_id
	 using SQLCA;
	 if sqlca.sqlnrows>0 then
		commit;
	else
		messagebox("Errore!", "ter non salvato!")
		rollback;
	end if
	 
	tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.retrieve()
else
	li_id = 	tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemnumber (1, "id_i_fronte")
	update intra_frontespizio_input
	 set amm_compl_sez2 = 0, tot_rig_sez2  = 0, tot_sez2 = 0
	 where id_i_fronte = :li_id
	 using SQLCA;
	 if sqlca.sqlnrows>0 then
		commit;
	else
		messagebox("Errore!", "ter non salvato!")
		rollback;
	end if
end if
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		uf_set_colval("rag_soc_1", is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("par_iva", is_ricpar.s_ausil_value[1])
		uf_set_colval("codice", is_ricpar.s_ausil_value[2])
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "rag_soc_1"
		is_search_window = "w_intra_sog_com_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_i_nat_trans"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nat_transazione_gd"
		is_ricpar.s_titolo_finestra = "Natura Transazione"
		is_ricpar.s_ausil_value[1] = "desc_nat_trans"
		
	CASE "id_i_nomenclatura"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_intra_nomenclatura_gd"
		is_ricpar.s_titolo_finestra = "Nomenclatura"
		is_ricpar.s_ausil_value[1] = "desc_nomen"
		
END CHOOSE
end event

event itemchanged;choose case dwo.name
	case 'amm_operaz'
      dw_intra_1ter_gd.setitem(row,"val_stat",long(data))		
end choose
end event

event updatestart;wf_rinumera_progressivi(this)
end event

type cb_sposta from commandbutton within tabpage_5
int X=1979
int Y=224
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Sposta"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_riga
choose case u_freddie.iudw_current
	case tab_3.tabpage_7.dw_intra_1ter_gd
		 li_riga= tab_3.tabpage_7.dw_intra_1ter_gd.getrow()
		 if li_riga>0 then
			wf_sposta_su_bis(li_riga,  tab_3.tabpage_6.dw_intra_1bis_gd,&
			tab_3.tabpage_7.dw_intra_1ter_gd ,'C')
		end if
	case tab_3.tabpage_6.dw_intra_1bis_gd 	
			 li_riga= tab_3.tabpage_6.dw_intra_1bis_gd.getrow()
		 if li_riga>0 then
			wf_sposta_su_ter(li_riga, tab_3.tabpage_6.dw_intra_1bis_gd , tab_3.tabpage_7.dw_intra_1ter_gd, 'C')
		end if
end choose
end event

type cb_cancella_riga from commandbutton within tabpage_5
int X=2336
int Y=220
int Width=256
int Height=108
int TabOrder=31
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_riga
li_riga=u_freddie.iudw_current.getrow()
if li_riga>0 then
	u_freddie.iudw_current.deleterow(li_riga)
end if
end event

type cb_contabilita from commandbutton within w_intra_fronte_input_ff
int X=3109
int Y=164
int Width=434
int Height=104
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="Passa Contabilità"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string ls_tipo_riepilogo, ls_data, ls_data_ini, ls_data_fin, ls_risp, ls_filter, ls_des_nomen
string ls_tiporeg1, ls_tiporeg2, ls_tiporeg3, ls_tipodoc1, ls_tipodoc2, ls_tipodoc3
date ld_data_sistema, ld_data_ini, ld_data_fin, ld_data_eser_ini, ld_data_eser_fin
date ld_da_data1, ld_a_data1
integer li_id_esercizio, li_id_esercizio_proposto, i
long ll_row, ll_id_nomen, ll_tot_rows
decimal ld_imptot, ld_imptotval, ll_massa_netta

ls_tipo_riepilogo=tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemstring(1,"tipo_riepilogo")
ld_da_data1 = tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemdate(1,"da_data1")
ld_a_data1 = tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemdate(1,"a_data1")


string ls_tipo, li_segno, ls_segno
long ll_mod_reg,ll_id_prof1,ll_id_prof2,ll_id_es,ll_id_reg,ll_id_sog_com, ll_prof_app,ll_id_fronte
decimal{4} ld_importo,ld_imp_valuta
long ll_prog1,ll_prog2

		
		
		
		
		

ll_id_fronte=tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemnumber(1,"id_i_fronte")
ls_tipo=tab_1.tabpage_1.dw_intra_fronte_riepilogo_ff.getitemstring(1,"riepilogo")


IF ls_tipo='A' then
		select intra_prof_reg_acq,intra_prof_reg_acq_nc,intra_mod_reg_acq
			into :ll_id_prof1,:ll_id_prof2,:ll_mod_reg
			from intra_contatore;
ELSE
		select intra_prof_reg_vend,intra_prof_reg_vend_nc,intra_mod_reg_vend
			into :ll_id_prof1,:ll_id_prof2,:ll_mod_reg
			from intra_contatore;
END IF
	
	select id_esercizio_proposto
		into :ll_id_es
		from azienda;
		
		
	select id_registro 
		into :ll_id_reg
		from registro
		where id_mod_registro= :ll_mod_reg
		and id_esercizio= :ll_id_es;
		
		ls_data_ini=string(ld_da_data1,"yy/mm/dd")
		ls_data_fin=string(ld_a_data1,"yy/mm/dd")

	LONG NUM_RIGH, num_righ2
	
	SELECT COUNT(*)
   	    INTO :NUM_RIGH
			 FROM "conto",   
					"reg_pd",   
					"sog_commerciale"  
			WHERE ( "reg_pd"."id_conto" = "conto"."id_conto" ) and  
					( "sog_commerciale"."id_conto" = "conto"."id_conto" ) and  
					(  "reg_pd"."id_registro" = :ll_id_reg) AND 
					("reg_pd"."ges_oper_intracomunitarie" = 'S' ) and
					( (dateformat("reg_pd"."data_competenza",'yy/mm/dd') >= :ls_data_ini) and (dateformat("reg_pd"."data_competenza",'yy/mm/dd') <= :ls_data_fin));
					

DATASTORE ds_recupera_doc 
ds_recupera_doc = CREATE DATASTORE
ds_recupera_doc.DATAOBJECT = "ds_rec_doc_intra"
ds_recupera_doc.SETTRANSOBJECT(SQLCA)

ls_tiporeg1 = "IA"
ls_tiporeg2 = "IV"
ls_tipodoc1 = "C"
ls_tipodoc2 = "N"

ll_row=ds_recupera_doc.RETRIEVE(ld_da_data1,ld_a_data1,ls_tiporeg1,ls_tiporeg2,ls_tipodoc1,ls_tipodoc2)  
	
if ll_row > 0 then num_righ = num_righ + ll_row
					
	IF NUM_RIGH = 0 THEN
		MESSAGEBOX ('ATTENZIONE', 'Il periodo selezionato non presenta scritture da passare')
	ELSE
		 DECLARE rec_contabilita CURSOR FOR  
		  SELECT "sog_commerciale"."id_sog_commerciale",   
					"mov_iva"."imponibile",
					"reg_pd"."imp_valuta",   
					"reg_pd"."segno_reg_iva",
					"reg_pd"."id_prof_registrazione"  
			 FROM "conto",   
					"reg_pd",   
					"sog_commerciale" ,
					"mov_iva"
			WHERE ( "reg_pd"."id_conto" = "conto"."id_conto" ) and 
					( "mov_iva"."id_reg_pd" = "reg_pd"."id_reg_pd") and
					( "sog_commerciale"."id_conto" = "conto"."id_conto" ) and  
					(  "reg_pd"."id_registro" = :ll_id_reg) AND  
					("reg_pd"."ges_oper_intracomunitarie" = 'S' ) AND
					( (dateformat("reg_pd"."data_competenza",'yy/mm/dd') >= :ls_data_ini) and (dateformat("reg_pd"."data_competenza",'yy/mm/dd') <= :ls_data_fin));
	
		ll_prog1=0
		ll_prog2=0
		open rec_contabilita;
		
		do while sqlca.sqlcode=0
			fetch rec_contabilita into :ll_id_sog_com, :ld_importo, :ld_imp_valuta, :li_segno, :ll_prof_app;
			if sqlca.sqlcode=0 then
				
				
				if li_segno= '1' then
					ls_segno='+'
				else
					ls_segno='-'
				end if
				
		
			if ls_tipo='A' then
					
					
					if ls_segno = '+' then
						ll_prog1++
						INSERT INTO "intra_2bis"  
						( "id_sog_commerciale","amm_operazioni","amm_valuta","prog_operazioni","id_i_fronte" )  
						VALUES ( :ll_id_sog_com,:ld_importo,:ld_imp_valuta,:ll_prog1,:ll_id_fronte );
					else
						ll_prog2++
						INSERT INTO "intra_2ter"  
						( "id_sog_commerciale","amm_oper","amm_valut","segn","prog_oper","id_i_fronte" )  
						VALUES ( :ll_id_sog_com,:ld_importo,:ld_imp_valuta,:ls_segno,:ll_prog2,:ll_id_fronte )  ;
					end if
				else
		
					
					
					
					if ls_segno = '+' then
						ll_prog1++
						INSERT INTO "intra_1bis"  
						( "id_sog_commerciale","amm_operazioni","prog_operazioni","id_i_fronte" )  
						VALUES ( :ll_id_sog_com,:ld_importo,:ll_prog1,:ll_id_fronte );
					else
						ll_prog2++
						INSERT INTO "intra_1ter"  
						( "id_sog_commerciale" ,"amm_operaz","segno","prog_operaz","id_i_fronte" )						
						VALUES ( :ll_id_sog_com,:ld_importo,:ls_segno,:ll_prog2,:ll_id_fronte )  ;
					end if
				end if
			end if
		loop
		
		
		
    	
			
			
		
			
			
			
		if ls_tipo='V' then	
			ls_tiporeg1 = "IC"
			ls_tiporeg2 = "IV"
			ls_tipodoc1 = "D"
			ls_tipodoc2 = "N"
			ds_recupera_doc.RETRIEVE(ld_da_data1,ld_a_data1,ls_tiporeg1,ls_tiporeg2,ls_tipodoc1,ls_tipodoc2) 
				
			ls_segno = '+'
			ll_tot_rows = ds_recupera_doc.rowcount()
			
			if ll_tot_rows > 0 then
								
				FOR i=1 TO ds_recupera_doc.rowcount()
					ll_id_sog_com = ds_recupera_doc.getitemnumber (i,"sog_commerciale_id_sog_commerciale")			
					ls_des_nomen  = ds_recupera_doc.getitemstring (i,"articolo_cod_intrastat")
					ld_imptot     = ds_recupera_doc.getitemdecimal(i,"tot_importo")
					ll_massa_netta = ds_recupera_doc.getitemdecimal(i,"tot_peso") 
				
					select id_i_nomenclatura
					into :ll_id_nomen
					from intra_nomenclatura
					
					
					where cod_nomen = :ls_des_nomen;					
					
					
					if ll_id_nomen = 0 then setnull(ll_id_nomen)
										
					ll_prog1++
					INSERT INTO "intra_1bis"  
					
					
					
					
					( "id_sog_commerciale","amm_operazioni","prog_operazioni","id_i_fronte","id_i_nomenclatura","massa_netta")  
					VALUES ( :ll_id_sog_com,:ld_imptot,:ll_prog1,:ll_id_fronte, :ll_id_nomen , :ll_massa_netta);					
					
					
					if (ds_recupera_doc.findgroupchange(i+1,1)) < 1 then 
						i = ds_recupera_doc.rowcount() 			
					else
						i = ( ds_recupera_doc.findgroupchange(i+1,1) ) - 1										
					end if
									
					
					
					
					
					
					
					
				
					
				NEXT
			end if
			
			
			
			
 
		   
			
			
			
			
         
			ls_tiporeg1 = "IC"
			ls_tiporeg2 = "IV"			
			ls_tipodoc1 = "C"
			ls_tipodoc2 = "C"
			ds_recupera_doc.RETRIEVE(ld_da_data1,ld_a_data1,ls_tiporeg1,ls_tiporeg2,ls_tipodoc1,ls_tipodoc2) 			
			
			ls_segno = '-'
			ll_tot_rows = ds_recupera_doc.rowcount()
			
			if ll_tot_rows > 0 then
				
				FOR i=1 TO ds_recupera_doc.rowcount()
					ll_id_sog_com = ds_recupera_doc.getitemnumber(i,"sog_commerciale_id_sog_commerciale")	
					ls_des_nomen  = ds_recupera_doc.getitemstring(i,"articolo_cod_intrastat")
					ld_imptot     = ds_recupera_doc.getitemdecimal(i,"tot_importo")					
				
					select id_i_nomenclatura
					into :ll_id_nomen
					from intra_nomenclatura
					
					
					where cod_nomen = :ls_des_nomen;					
					
					
					if ll_id_nomen = 0 then setnull(ll_id_nomen)				
					
					ll_prog2++
					INSERT INTO "intra_1ter"  
					( "id_sog_commerciale" ,"amm_operaz","segno","prog_operaz","id_i_fronte","id_i_nomenclatura" )  
					VALUES ( :ll_id_sog_com , :ld_imptot,:ls_segno,:ll_prog2,:ll_id_fronte, :ll_id_nomen)  ;
				
					if (ds_recupera_doc.findgroupchange(i+1,1)) < 1 then 
						i = ds_recupera_doc.rowcount() 			
					else
						i = ( ds_recupera_doc.findgroupchange(i+1,1) ) - 1										
					end if
					
				NEXT		
			end if
		end if 
		
		
		
			
			
		
			
			
			
		if ls_tipo='A' then	
			ls_tiporeg1 = "IA"
			ls_tiporeg2 = "IA"			
			ls_tipodoc1 = "D"
			ls_tipodoc2 = "N"
			ds_recupera_doc.RETRIEVE(ld_da_data1,ld_a_data1,ls_tiporeg1,ls_tiporeg2,ls_tipodoc1,ls_tipodoc2) 				
				
			ls_segno = '+'
			ll_tot_rows = ds_recupera_doc.rowcount()
			
			if ll_tot_rows > 0 then			
				FOR i=1 TO ds_recupera_doc.rowcount()
					ll_id_sog_com = ds_recupera_doc.getitemnumber(i,"sog_commerciale_id_sog_commerciale")	
					ls_des_nomen  = ds_recupera_doc.getitemstring(i,"articolo_cod_intrastat")
					ld_imptot     = ds_recupera_doc.getitemdecimal(i,"tot_importo")					
					ld_imptotval  = ds_recupera_doc.getitemdecimal(i,"tot_impval")						
					ll_massa_netta = ds_recupera_doc.getitemdecimal(i,"tot_peso")	
				
					select id_i_nomenclatura
					into :ll_id_nomen
					from intra_nomenclatura
					
					
					where cod_nomen = :ls_des_nomen;					
					
					
					if ll_id_nomen = 0 then setnull(ll_id_nomen)
					
					ll_prog1++
					INSERT INTO "intra_2bis"  
					
					
					
					( "id_sog_commerciale","amm_operazioni","amm_valuta","prog_operazioni","id_i_fronte","id_i_nomenclatura","massa_netta" )  
					VALUES ( :ll_id_sog_com,:ld_imptot,:ld_imptotval,:ll_prog1,:ll_id_fronte, :ll_id_nomen, :ll_massa_netta );					
					
				
					if (ds_recupera_doc.findgroupchange(i+1,1)) < 1 then 
						i = ds_recupera_doc.rowcount() 			
					else
						i = ( ds_recupera_doc.findgroupchange(i+1,1) ) - 1										
					end if
				NEXT
			end if
			
			
			
			
		
			
			
		
			
			
			
			ls_tiporeg1 = "IA"
			ls_tiporeg2 = "IA"			
			ls_tipodoc1 = "C"
			ls_tipodoc2 = "C"			
			ds_recupera_doc.RETRIEVE(ld_da_data1,ld_a_data1,ls_tiporeg1,ls_tiporeg2,ls_tipodoc1,ls_tipodoc2) 			

			ls_segno = '-'
			ll_tot_rows = ds_recupera_doc.rowcount()
			
			if ll_tot_rows > 0 then						
				FOR i=1 TO ds_recupera_doc.rowcount()
					ll_id_sog_com = ds_recupera_doc.getitemnumber(i,"sog_commerciale_id_sog_commerciale")
					ls_des_nomen  = ds_recupera_doc.getitemstring(i,"articolo_cod_intrastat")
					ld_imptot     = ds_recupera_doc.getitemdecimal(i,"tot_importo")			
					ld_imptotval  = ds_recupera_doc.getitemdecimal(i,"tot_impval")											
				
					select id_i_nomenclatura
					into :ll_id_nomen
					from intra_nomenclatura
					
					
					where cod_nomen = :ls_des_nomen;					
					
					
					if ll_id_nomen = 0 then setnull(ll_id_nomen)
					
					ll_prog2++
					INSERT INTO "intra_2ter"  
					( "id_sog_commerciale","amm_oper","amm_valut","segn","prog_oper","id_i_fronte","id_i_nomenclatura"  )  
					VALUES ( :ll_id_sog_com,:ld_imptot,:ld_imptotval,:ls_segno,:ll_prog2,:ll_id_fronte, :ll_id_nomen )  ;
				
					if (ds_recupera_doc.findgroupchange(i+1,1)) < 1 then 
						i = ds_recupera_doc.rowcount() 			
					else
						i = ( ds_recupera_doc.findgroupchange(i+1,1) ) - 1										
					end if
				NEXT		
			end if
		end if 
		
		
		
END IF
TAB_1.TABPAGE_2.TAB_2.TABPAGE_3.dw_intra_2bis_gd.RETRIEVE(ll_id_fronte)
TAB_1.TABPAGE_2.TAB_2.TABPAGE_4.dw_intra_2ter_gd.RETRIEVE(ll_id_fronte)
TAB_1.TABPAGE_5.TAB_3.TABPAGE_6.dw_intra_1bis_gd.RETRIEVE(ll_id_fronte)
TAB_1.TABPAGE_5.TAB_3.TABPAGE_7.dw_intra_1ter_gd.RETRIEVE(ll_id_fronte)

cb_contabilita.enabled = false
end event

type p_1 from picture within w_intra_fronte_input_ff
int X=617
int Y=28
int Width=183
int Height=108
boolean BringToTop=true
string PictureName="s:\pb\commonframework\beuro.bmp"
boolean FocusRectangle=false
end type

type cb_1 from commandbutton within w_intra_fronte_input_ff
int X=2565
int Y=40
int Width=224
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

integer li_ret

li_ret = messagebox("ATTENZIONE!!","Vuoi cancellare le registrazioni?",Question!,YesNoCancel!)
if li_ret= 1 then uf_canc_passaggio()
end event

