forward
global type w_orafo_saldi_cliente2_tot_gd from w_p_data
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_single from u_dw_master_main within tabpage_1
end type
type dw_chiusi from u_dw_master_main within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_single from u_dw_master_main within tabpage_1
end type
type dw_chiusi from u_dw_master_main within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from u_dw_master_main within tabpage_2
end type
type cb_chiudisaldo from commandbutton within w_orafo_saldi_cliente2_tot_gd
end type
type cb_sceglichiusura from commandbutton within w_orafo_saldi_cliente2_tot_gd
end type
type cb_1 from commandbutton within w_orafo_saldi_cliente2_tot_gd
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
end type
end forward

global type w_orafo_saldi_cliente2_tot_gd from w_p_data
int X=1
int Width=2955
int Height=1796
cb_chiudisaldo cb_chiudisaldo
cb_sceglichiusura cb_sceglichiusura
cb_1 cb_1
end type
global w_orafo_saldi_cliente2_tot_gd w_orafo_saldi_cliente2_tot_gd

type variables
datetime ld_datamax, ld_datamin

end variables

forward prototypes
public subroutine wf_carica_saldi ()
public subroutine wf_carica_chiusura (integer ai_flag, long al_id_sog_com)
end prototypes

public subroutine wf_carica_saldi ();

		
		
		
		
		


decimal{4} ld_fino_entrata, ld_fino_uscita, ld_fino_saldo
integer i, a
string ls_campo, ls_cod_metallo, ls_cod_metallo_old, ls_data

string ls_met_chiuso
integer e
decimal{2} ld_g_in, ld_g_out, ld_g_saldo, ld_gp_in, ld_gp_out, ld_gp_saldo
long ll_ri
boolean lb_chiuso

for a = 1 to 4
	if a= 1 then ls_campo="fino_"
	if a =2 then ls_campo="calo_"
	if a =3 then ls_campo="fino_calo_"
	if a =4 then ls_campo="lire_"
	for i= 1 to tab_1.tabpage_1.dw_single.rowcount()
			ld_fino_entrata=tab_1.tabpage_1.dw_single.getitemdecimal(i, ls_campo+"entrata")
			ld_fino_uscita=tab_1.tabpage_1.dw_single.getitemdecimal(i, ls_campo+"uscita")
			if isnull(ld_fino_entrata) then ld_fino_entrata=0
			if isnull(ld_fino_uscita) then ld_fino_uscita=0
			if i= 1 then 
				tab_1.tabpage_1.dw_single.setitem(i, ls_campo+"saldo", ld_fino_entrata - ld_fino_uscita)
			else
				ls_cod_metallo_old=tab_1.tabpage_1.dw_single.getitemstring(i - 1, "orafo_metallo_codice")
				
				ls_cod_metallo=tab_1.tabpage_1.dw_single.getitemstring(i, "orafo_metallo_codice")
				if ls_cod_metallo = ls_cod_metallo_old and not isnull(ls_cod_metallo_old) then
					ld_fino_saldo=tab_1.tabpage_1.dw_single.getitemdecimal(i - 1, ls_campo+"saldo")
				else
					
					lb_chiuso=false
					e=1
					ll_ri=tab_1.tabpage_1.dw_chiusi.RowCount()
					if (ll_ri >0)and(a<>3) then
						do
							if ld_datamin=datetime(date('20/12/20'),time('20.20.20')) then
								exit
							end if
							if ld_datamin=datetime(date('10/10/10'),time('10.10.10')) then
								ls_met_chiuso=tab_1.tabpage_1.dw_chiusi.GetItemString(e,"codice_metallo")
								if (ls_met_chiuso=ls_cod_metallo_old) then
									ld_g_in=tab_1.tabpage_1.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"entrata")
									ld_g_out=tab_1.tabpage_1.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"uscita")
									e=ll_ri
								end if
							else
								ls_data=string(ld_datamin)
								choose case a
									case 1
										SELECT gran_fino_entrata, gran_fino_uscita
										INTO :ld_g_in, :ld_g_out
										FROM orafo_saldi_chiusi
										WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo_old);
									case 2
										SELECT gran_calo_entrata, gran_calo_uscita
										INTO :ld_g_in, :ld_g_out
										FROM orafo_saldi_chiusi
										WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo_old);
									case 4
										SELECT gran_lire_entrata, gran_lire_uscita
										INTO :ld_g_in, :ld_g_out
										FROM orafo_saldi_chiusi
										WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo_old);
								end choose
								if sqlca.sqlcode<>0 then
									SetNull(ld_g_in)
									SetNull(ld_g_out)
								end if
							end if
							ld_gp_in=tab_1.tabpage_1.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"entrata")
							ld_gp_out=tab_1.tabpage_1.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"uscita")
							ld_gp_saldo=tab_1.tabpage_1.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"saldo")
							tab_1.tabpage_1.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"in",ld_g_in+ld_gp_in)
							tab_1.tabpage_1.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"out",ld_g_out+ld_gp_out)
							ld_g_saldo=ld_g_in+ld_gp_in - (ld_g_out+ld_gp_out) + ld_gp_saldo
							tab_1.tabpage_1.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"saldo",ld_g_saldo)
							e++
						loop until (e=ll_ri+1)
					end if
					ld_fino_saldo=0
				end if
				ld_fino_saldo= ld_fino_saldo+ld_fino_entrata - ld_fino_uscita
				tab_1.tabpage_1.dw_single.setitem(i, ls_campo+"saldo", ld_fino_saldo)
			end if
	next
	
	lb_chiuso=false
	e=1
	ll_ri=tab_1.tabpage_1.dw_chiusi.RowCount()
	if (ll_ri >0)and(a<>3)and(tab_1.tabpage_1.dw_single.rowcount()>0) then
		do
			if ld_datamin=datetime(date('20/12/20'),time('20.20.20')) then
				exit
			end if
			if ld_datamin=datetime(date('10/10/10'),time('10.10.10')) then
				ls_met_chiuso=tab_1.tabpage_1.dw_chiusi.GetItemString(e,"codice_metallo")
				if (ls_met_chiuso=ls_cod_metallo_old) then
					ld_g_in=tab_1.tabpage_1.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"entrata")
					ld_g_out=tab_1.tabpage_1.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"uscita")
					e=ll_ri
				end if
			else
				ls_data=string(ld_datamin)
				choose case a
					case 1
						SELECT gran_fino_entrata, gran_fino_uscita
						INTO :ld_g_in, :ld_g_out
						FROM orafo_saldi_chiusi
						WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo_old);
					case 2
						SELECT gran_calo_entrata, gran_calo_uscita
						INTO :ld_g_in, :ld_g_out
						FROM orafo_saldi_chiusi
						WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo_old);
					case 4
						SELECT gran_lire_entrata, gran_lire_uscita
						INTO :ld_g_in, :ld_g_out
						FROM orafo_saldi_chiusi
						WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo_old);
				end choose
				if sqlca.sqlcode<>0 then
					SetNull(ld_g_in)
					SetNull(ld_g_out)
				end if
			end if
			ld_gp_in=tab_1.tabpage_1.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"entrata")
			ld_gp_out=tab_1.tabpage_1.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"uscita")
			ld_gp_saldo=tab_1.tabpage_1.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"saldo")
			tab_1.tabpage_1.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"in",ld_g_in+ld_gp_in)
			tab_1.tabpage_1.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"out",ld_g_out+ld_gp_out)
			ld_g_saldo=ld_g_in+ld_gp_in - (ld_g_out+ld_gp_out) + ld_gp_saldo
			tab_1.tabpage_1.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"saldo",ld_g_saldo)
			e++
		loop until (e=ll_ri+1)
	end if
next
end subroutine

public subroutine wf_carica_chiusura (integer ai_flag, long al_id_sog_com);
end subroutine

on w_orafo_saldi_cliente2_tot_gd.create
int iCurrent
call w_p_data::create
this.cb_chiudisaldo=create cb_chiudisaldo
this.cb_sceglichiusura=create cb_sceglichiusura
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_chiudisaldo
this.Control[iCurrent+2]=cb_sceglichiusura
this.Control[iCurrent+3]=cb_1
end on

on w_orafo_saldi_cliente2_tot_gd.destroy
call w_p_data::destroy
destroy(this.cb_chiudisaldo)
destroy(this.cb_sceglichiusura)
destroy(this.cb_1)
end on

event open;call super::open;
idw_master = tab_1.tabpage_1.dw_1
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "documento.id_sog_commerciale"

ld_datamin=datetime(date('10/10/10'),Time('10.10.10'))
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_sog_commerciale"
	idw_master.is_list.s_modo=modo_inserisci
	
	ld_datamax=datetime(date('10/10/10'),Time('10.10.10'))

	 
	ib_nonmodale=true
	
	cb_salva.Visible=false
else
	 
	 ib_nonmodale=false
	
	 cb_chiudisaldo.visible=false
	
	 cb_sceglichiusura.visible=false
	
	ld_datamax=datetime(date(idw_master.is_list.s_identifica[2]),time(idw_master.is_list.s_identifica[3]))
	if Upperbound(idw_master.is_list.s_identifica)>3 then
		ld_datamin=datetime(date(idw_master.is_list.s_identifica[4]),time(idw_master.is_list.s_identifica[5]))
		tab_1.tabpage_1.dw_single.retrieve(idw_master.is_list.l_identifica[1])
		tab_1.tabpage_1.st_1.text='Ultima chiusura nel periodo'
	end if
end if

end event

event ue_post_open;call super::ue_post_open;
cb_inserisci.Visible=false
cb_nuovo.Visible=false
cb_cancella.Visible=false
cb_annulla.Visible=false

if Upperbound(idw_master.is_list.s_identifica)=0 then
	cb_ricerca. triggerEvent("clicked")
end if
end event

event close;close(this)
end event

event closequery;
end event

type p_crescente from w_p_data`p_crescente within w_orafo_saldi_cliente2_tot_gd
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_orafo_saldi_cliente2_tot_gd
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_orafo_saldi_cliente2_tot_gd
int X=246
int Y=33
boolean BringToTop=true
end type

event cb_ok::clicked;close(parent)
end event

type cb_annulla from w_p_data`cb_annulla within w_orafo_saldi_cliente2_tot_gd
boolean Visible=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_orafo_saldi_cliente2_tot_gd
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_orafo_saldi_cliente2_tot_gd
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_orafo_saldi_cliente2_tot_gd
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_orafo_saldi_cliente2_tot_gd
int X=2084
int Y=33
int Width=353
boolean Enabled=false
boolean BringToTop=true
string Text="Salva chiusura"
end type

event cb_salva::clicked;

long ll_num_righe, ll_group, ll_id_sog_com, ll_next_group, ll_riga
integer i
decimal {2} ld_gf_in, ld_gf_out, ld_gc_in, ld_gc_out, ld_gl_in, ld_gl_out
string ls_metallo
datetime ld_data

ll_num_righe=tab_1.tabpage_1.dw_single.Rowcount()
ll_num_righe=1
Do
	ll_group=tab_1.tabpage_1.dw_single.FindGroupChange(ll_num_righe,1)
	if ll_group>0 then
		ll_next_group=tab_1.tabpage_1.dw_single.FindGroupChange(ll_group+1,1)
		if ll_next_group>0 then
			ll_riga=ll_next_group - 1
		else
			ll_riga=tab_1.tabpage_1.dw_single.RowCount()
		end if
		ld_gf_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_fino_in")
		if IsNull(ld_gf_in) then
			ld_gf_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_fino_entrata")
			ld_gf_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_fino_uscita")
			ld_gc_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_calo_entrata")
			ld_gc_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_calo_uscita")
			ld_gl_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_lire_entrata")
			ld_gl_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_lire_uscita")
		else
			ld_gf_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_fino_out")
			ld_gc_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_calo_in")
			ld_gc_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_calo_out")
			ld_gl_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_lire_in")
			ld_gl_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_lire_out")
		end if			
		ls_metallo=tab_1.tabpage_1.dw_single.getItemString(ll_group+1,"orafo_metallo_codice")
		ll_id_sog_com=tab_1.tabpage_1.dw_1.getItemNumber(1,"id_sog_commerciale")
		ld_data=datetime(today(),now())
		
		INSERT INTO orafo_saldi_chiusi (id_sog_commerciale, data_chiusura, gran_fino_entrata, 
												gran_fino_uscita, gran_calo_entrata, gran_calo_uscita, 
												gran_lire_entrata, gran_lire_uscita, codice_metallo)
		VALUES (:ll_id_sog_com, :ld_data, :ld_gf_in, :ld_gf_out, :ld_gc_in, :ld_gc_out, :ld_gl_in, :ld_gl_out, :ls_metallo);

		CHOOSE CASE sqlca.sqlcode
			CASE -1
				messagebox('errore','err')
		END CHOOSE

	end if
	ll_num_righe=ll_group+1
Loop Until ll_group=0
end event

type tab_1 from w_p_data`tab_1 within w_orafo_saldi_cliente2_tot_gd
int Y=141
int Width=2898
int Height=1556
int TabOrder=30
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=15
int Y=90
int Width=2870
int Height=1453
long BackColor=79741120
string Text="Scheda soggetto"
long TabBackColor=79741120
dw_1 dw_1
dw_single dw_single
dw_chiusi dw_chiusi
st_1 st_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.dw_single=create dw_single
this.dw_chiusi=create dw_chiusi
this.st_1=create st_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
this.Control[iCurrent+2]=dw_single
this.Control[iCurrent+3]=dw_chiusi
this.Control[iCurrent+4]=st_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_single)
destroy(this.dw_chiusi)
destroy(this.st_1)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_orafo_saldi_cliente2_tot_gd
int Y=33
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long LL_id_sog_com
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="codice"
openwithparm(lw_sm,idw_master.is_ricpar,"w_sog_commerciale_gen_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	LL_id_sog_com=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_sog_commerciale"
	idw_master.is_list.l_identifica[1]=LL_id_sog_com
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
	ld_datamax=datetime(date('10/10/10'),Time('10.10.10'))
	cb_salva.Visible=false
	
	parent.title="Scheda corrente di "+idw_master.is_ricpar.s_main_value +" "+idw_master.is_ricpar.s_ausil_value[1]
if tab_1.tabpage_1.dw_1.rowcount()<1 then
	tab_1.tabpage_1.dw_single.reset()
	tab_1.tabpage_1.dw_chiusi.reset()
end if
end if

end event

type dw_1 from u_dw_master_main within tabpage_1
int X=409
int Y=20
int Height=109
int TabOrder=1
boolean Visible=false
string DataObject="d_orafo_saldi_cliente_tot_prova_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_sog_commerciale"
iudw_children[1]=dw_chiusi
end event

type dw_single from u_dw_master_main within tabpage_1
int X=8
int Y=567
int Width=2827
int Height=852
int TabOrder=3
string DataObject="d_orafo_saldi_cliente_tot_righe_gran_tb2"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
end event

event retrieveend;call super::retrieveend;

if dw_1.rowcount()<1 then return
long ll_id_sog_com, ll_ret, ll_num_rows
string ls_met_retr
datetime ld_dataora1,ld_dataora2, ld_data_retr
integer i
boolean lb_condizione

ll_id_sog_com=tab_1.tabpage_1.dw_1.getItemNumber(1,"id_sog_commerciale")
if Not(IsNull(ll_id_sog_com)) then
	ll_num_rows=rowcount
	
	if ll_num_rows<1 then return
	
	i=1
	Do
		ls_met_retr = this.GetItemString(i,"orafo_metallo_codice")
		ld_data_retr = datetime(this.GetItemDate(i,"data_registrazione"),this.GetItemTime(i,"ora_registrazione"))

		
		
		
		
		
		if ld_datamin=datetime(date('10/10/10'),Time('10.10.10')) then
			lb_condizione=ld_data_retr<ld_datamax
		elseif ld_datamin=datetime(date('20/12/20'),Time('20.20.20')) then
			lb_condizione=ld_data_retr>ld_datamax
		else
			lb_condizione=(ld_data_retr>ld_datamax)or(ld_data_retr<ld_datamin)
		end if

		if lb_condizione then 
			ll_ret=this.RowsMove(i,i,Primary!,this,1,Filter!)
			ll_num_rows --
			i --
		end if
		i ++
	Loop Until (i=ll_num_rows+1)
	wf_carica_saldi()
end if
if this.Rowcount()>0 then 
	cb_chiudisaldo.Enabled=true
else
	cb_chiudisaldo.Enabled=false
end if

end event

event scrollhorizontal;call super::scrollhorizontal;dw_chiusi.modify("datawindow.horizontalscrollposition="+string(scrollpos))
end event

type dw_chiusi from u_dw_master_main within tabpage_1
int X=8
int Y=68
int Width=2827
int Height=468
int TabOrder=3
string DataObject="d_orafo_saldi_cliente_tot_chiusi_tb"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
end event

event retrieveend;call super::retrieveend;
if dw_1.rowcount()<1 then return
long i, ll_id_sog_com
datetime ld_data, ld_data1, ld_data2
boolean lb_trovata

rowcount=tab_1.tabpage_1.dw_chiusi.Rowcount()
if rowcount>0 then
	i=rowcount
	lb_trovata=false

	if ld_datamax=datetime(date('10/10/10'),Time('10.10.10')) then
		ld_datamax=tab_1.tabpage_1.dw_chiusi.GetItemDatetime(i,"data_chiusura")
		ld_datamin=datetime(date('10/10/10'),Time('10.10.10'))
		lb_trovata=true
		tab_1.tabpage_1.dw_chiusi.Title="Ultima chiusura"
	elseif ld_datamin<>datetime(date('10/10/10'),Time('10.10.10')) then 
		lb_trovata=true
	end if
	for i = 1 to rowcount
		ld_data=tab_1.tabpage_1.dw_chiusi.GetItemDatetime(i,"data_chiusura")
		
		if ld_data<>ld_datamax then 
			if (ld_data<ld_datamax) then
				if (Not(lb_trovata)) then
					lb_trovata = true
					ld_datamin=tab_1.tabpage_1.dw_chiusi.GetItemDatetime(i,"data_chiusura")
					tab_1.tabpage_1.dw_chiusi.Title=tab_1.tabpage_1.dw_chiusi.Title+" precedente: "+string(ld_datamin)
				elseif ld_data<ld_datamin then
					tab_1.tabpage_1.dw_chiusi.DeleteRow(i)
					rowcount --
					i --
				end if
			else
				tab_1.tabpage_1.dw_chiusi.DeleteRow(i)
				rowcount --
				i --
			end if				
		end if
	next
	if Not(lb_trovata) then 
		ld_datamin=datetime(date('20/12/20'),Time('20.20.20'))
		tab_1.tabpage_1.dw_chiusi.Title=tab_1.tabpage_1.dw_chiusi.Title+" precedente: inesistente"
	end if
end if
	ll_id_sog_com=tab_1.tabpage_1.dw_1.GetItemNumber(1,"id_sog_commerciale")
	tab_1.tabpage_1.dw_single.Retrieve(ll_id_sog_com)
if ld_datamin=datetime(date('20/12/20'),Time('20.20.20')) then
	tab_1.tabpage_2.dw_3.Retrieve(ll_id_sog_com,date('20/12/1920'),time(ld_datamin),date(ld_datamax),time(ld_datamax))
elseif ld_datamin=datetime(date('10/10/10'),Time('10.10.10')) then
	tab_1.tabpage_2.dw_3.Retrieve(ll_id_sog_com,date(ld_datamax),time(ld_datamax),date(ld_datamin),time(ld_datamin))	
else
	tab_1.tabpage_2.dw_3.Retrieve(ll_id_sog_com,date(ld_datamin),time(ld_datamin),date(ld_datamax),time(ld_datamax))
end if

end event

type st_1 from statictext within tabpage_1
int X=18
int Y=10
int Width=996
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Chiusura"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_2 from userobject within tab_1
int X=15
int Y=90
int Width=2870
int Height=1453
long BackColor=79741120
string Text="Totali perTipo Causale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_3 dw_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.Control[]={ this.dw_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw_master_main within tabpage_2
int X=22
int Y=36
int Width=2809
int Height=1383
int TabOrder=3
string DataObject="d_orafo_saldi_cliente_tot_tipo_causal_tb"
boolean TitleBar=true
string Title="Totali per causale"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
end event

event scrollhorizontal;call super::scrollhorizontal;
end event

type cb_chiudisaldo from commandbutton within w_orafo_saldi_cliente2_tot_gd
int X=2472
int Y=33
int Width=356
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Chiudi Scheda"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_num_righe, ll_group, ll_id_sog_com, ll_next_group, ll_riga
integer i
decimal {2} ld_gf_in, ld_gf_out, ld_gc_in, ld_gc_out, ld_gl_in, ld_gl_out
string ls_metallo, ls_s_data_chius
datetime ld_data
time tt

if messagebox('Chiusura Saldo','Confermi la chiusura del saldo?',Information!,YesNo!)=2 then return
tt=now()
ls_s_data_chius=string(tt,"hh.mm.ss")
tt=time(ls_s_data_chius)
ld_data=datetime(today(),tt)
ls_s_data_chius=string(ld_data)
if (ls_s_data_chius="")or IsNull(ls_s_data_chius) then return

ll_num_righe=tab_1.tabpage_1.dw_single.Rowcount()
ll_num_righe=1
Do
	ll_group=tab_1.tabpage_1.dw_single.FindGroupChange(ll_num_righe,1)
	if ll_group>0 then
		ll_next_group=tab_1.tabpage_1.dw_single.FindGroupChange(ll_group+1,1)
		if ll_next_group>0 then
			ll_riga=ll_next_group - 1
		else
			ll_riga=tab_1.tabpage_1.dw_single.RowCount()
		end if
		ld_gf_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_fino_in")
		if IsNull(ld_gf_in) then
			ld_gf_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_fino_entrata")
			ld_gf_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_fino_uscita")
			ld_gc_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_calo_entrata")
			ld_gc_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_calo_uscita")
			ld_gl_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_lire_entrata")
			ld_gl_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_group,"gran_lire_uscita")
		else
			ld_gf_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_fino_out")
			ld_gc_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_calo_in")
			ld_gc_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_calo_out")
			ld_gl_in=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_lire_in")
			ld_gl_out=tab_1.tabpage_1.dw_single.getItemDecimal(ll_riga,"cgrans_lire_out")
		end if			
		ls_metallo=tab_1.tabpage_1.dw_single.getItemString(ll_group,"orafo_metallo_codice")
		ll_id_sog_com=tab_1.tabpage_1.dw_1.getItemNumber(1,"id_sog_commerciale")
		tt=now()
		ls_s_data_chius=string(tt,"hh.mm.ss")
		tt=time(ls_s_data_chius)
		ld_data=datetime(today(),tt)
		ls_s_data_chius=string(ld_data)
		
		INSERT INTO orafo_saldi_chiusi (id_sog_commerciale, data_chiusura, gran_fino_entrata, 
												gran_fino_uscita, gran_calo_entrata, gran_calo_uscita, 
												gran_lire_entrata, gran_lire_uscita, codice_metallo, s_data_chius)
		VALUES (:ll_id_sog_com, :ld_data, :ld_gf_in, :ld_gf_out, :ld_gc_in, :ld_gc_out, :ld_gl_in, :ld_gl_out, :ls_metallo, :ls_s_data_chius);

		CHOOSE CASE sqlca.sqlcode
			CASE -1
				messagebox('Errore','Impossibile accedere al database!')
		END CHOOSE

	end if
	ll_num_righe=ll_group+1
Loop Until ll_group=0
ld_datamax=datetime(date('10/10/10'),time('10.10.10'))
tab_1.tabpage_1.dw_chiusi.Retrieve(ll_id_sog_com)

end event

type cb_sceglichiusura from commandbutton within w_orafo_saldi_cliente2_tot_gd
int X=1672
int Y=33
int Width=385
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="Scegli chiusura"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_id_sog_com
ll_id_sog_com=tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog_com>0 and not isnull(ll_id_sog_com) then 
	opensheetwithparm(w_orafo_saldi_chiusura_sel_gd, ll_id_sog_com, w_app_frame, 2, Original!)
end if


end event

type cb_1 from commandbutton within w_orafo_saldi_cliente2_tot_gd
int X=744
int Y=33
int Width=356
int Height=84
int TabOrder=21
boolean BringToTop=true
string Text="Scheda virtuale"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dati ld_date
s_list_main lstr_for_win
w_orafo_saldi_cliente2_tot_gd lw_saldi

Open(w_data_val_ff)
ld_date=Message.PowerObjectParm
	
lstr_for_win.s_modo = modo_modifica
lstr_for_win.s_identifica[1] = "id_sog_commerciale"
lstr_for_win.l_identifica[1] = tab_1.tabpage_1.dw_1.GetItemNumber(1,"id_sog_commerciale")

lstr_for_win.s_identifica[4] = string(ld_date.data_inizio)
lstr_for_win.s_identifica[5] = string(time('00.00.00'))	

lstr_for_win.s_identifica[2] = string(ld_date.data_fine)
lstr_for_win.s_identifica[3] = string(time('00.00.00'))	

opensheetwithparm(lw_saldi, lstr_for_win, w_app_frame, 2, original!)
end event

