forward
global type w_orafo_saldi_cliente_cx from w_p_data
end type
type dw_filtro from u_dw_master_main within tabpage_1
end type
type dw_filtro from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type st_1 from statictext within tabpage_2
end type
type dw_chiusi from u_dw_master_main within tabpage_2
end type
type dw_single from u_dw_master_main within tabpage_2
end type
type dw_1 from u_dw_master_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_causali from u_dw_master_main within tabpage_3
end type
type cb_preview_caus from commandbutton within tabpage_3
end type
type cb_st_causali from commandbutton within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_stampa from datawindow within tabpage_4
end type
type cb_preview from commandbutton within tabpage_4
end type
type cb_stampa from commandbutton within tabpage_4
end type
type cb_zoomout from commandbutton within tabpage_4
end type
type cb_zoomin from commandbutton within tabpage_4
end type
type cb_next from commandbutton within tabpage_4
end type
type cb_prev from commandbutton within tabpage_4
end type
type gb_2 from groupbox within tabpage_4
end type
type gb_1 from groupbox within tabpage_4
end type
type st_zoom from statictext within tabpage_4
end type
type cb_zoom100 from commandbutton within tabpage_4
end type
type cb_chiudisaldo from commandbutton within w_orafo_saldi_cliente_cx
end type
type cb_sceglichiusura from commandbutton within w_orafo_saldi_cliente_cx
end type
type st_2 from statictext within w_orafo_saldi_cliente_cx
end type
type st_3 from statictext within w_orafo_saldi_cliente_cx
end type
type tabpage_2 from userobject within tab_1
st_1 st_1
dw_chiusi dw_chiusi
dw_single dw_single
dw_1 dw_1
end type
type tabpage_3 from userobject within tab_1
dw_causali dw_causali
cb_preview_caus cb_preview_caus
cb_st_causali cb_st_causali
end type
type tabpage_4 from userobject within tab_1
dw_stampa dw_stampa
cb_preview cb_preview
cb_stampa cb_stampa
cb_zoomout cb_zoomout
cb_zoomin cb_zoomin
cb_next cb_next
cb_prev cb_prev
gb_2 gb_2
gb_1 gb_1
st_zoom st_zoom
cb_zoom100 cb_zoom100
end type
end forward

global type w_orafo_saldi_cliente_cx from w_p_data
int X=0
int Width=3365
int Height=1852
cb_chiudisaldo cb_chiudisaldo
cb_sceglichiusura cb_sceglichiusura
st_2 st_2
st_3 st_3
end type
global w_orafo_saldi_cliente_cx w_orafo_saldi_cliente_cx

type variables
datetime ld_datamax, ld_datamin
long il_id_titolo, il_id_articolo, il_id_caus_mag, il_id_sog_com
string is_filtro, is_operazione
boolean lb_ultima, lb_trovata_chiusura




end variables

forward prototypes
public subroutine wf_carica_chiusura (integer ai_flag, long al_id_sog_com)
public function string wf_crea_filtro ()
public subroutine wf_carica_saldi ()
public subroutine wf_carica_parziali (datastore ads_data)
public subroutine wf_insert_parziali (datastore ads_origine, datawindow adw_dest)
public subroutine wf_genera_doc ()
public subroutine wf_carica_saldi2 ()
end prototypes

public subroutine wf_carica_chiusura (integer ai_flag, long al_id_sog_com);
end subroutine

public function string wf_crea_filtro ();string ls_filtro
date ld_da_data, ld_a_data

tab_1.tabpage_2.st_1.text='Ultima chiusura'
ls_filtro=""
il_id_articolo=tab_1.tabpage_1.dw_filtro.GetItemNumber(1,"id_articolo")
il_id_titolo=tab_1.tabpage_1.dw_filtro.GetItemNumber(1,"id_titolo")
il_id_caus_mag=tab_1.tabpage_1.dw_filtro.GetItemNumber(1,"id_caus_magazzino")		
ld_da_data=tab_1.tabpage_1.dw_filtro.GetItemDate(1,"da_data")
ld_a_data=tab_1.tabpage_1.dw_filtro.GetItemDate(1,"a_data")

if Not(IsNull(il_id_articolo)) then ls_filtro=ls_filtro+"(articolo_id_articolo="+string(il_id_articolo)+") and "
if Not(isNull(il_id_titolo)) then ls_filtro=ls_filtro+"(orafo_titolo_id_titolo="+string(il_id_titolo)+") and "
if Not(IsNull(il_id_caus_mag)) then ls_filtro=ls_filtro+"(caus_magazzino_id_caus_magazzino="+string(il_id_caus_mag)+") and "
if Not(isNull(ld_da_data)) then ld_datamin=datetime(ld_da_data,tab_1.tabpage_1.dw_filtro.GetItemTime(1,"da_ora"))
if Not(isNull(ld_a_data)) then ld_datamax=datetime(ld_a_data,tab_1.tabpage_1.dw_filtro.GetItemTime(1,"a_ora"))

return ls_filtro
end function

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
	for i= 1 to tab_1.tabpage_2.dw_single.rowcount()
			ld_fino_entrata=tab_1.tabpage_2.dw_single.getitemdecimal(i, ls_campo+"entrata")
			ld_fino_uscita=tab_1.tabpage_2.dw_single.getitemdecimal(i, ls_campo+"uscita")
			if isnull(ld_fino_entrata) then ld_fino_entrata=0
			if isnull(ld_fino_uscita) then ld_fino_uscita=0
			if i= 1 then 
				tab_1.tabpage_2.dw_single.setitem(i, ls_campo+"saldo", ld_fino_entrata - ld_fino_uscita)
			else
				ls_cod_metallo_old=tab_1.tabpage_2.dw_single.getitemstring(i - 1, "orafo_metallo_codice")
				
				ls_cod_metallo=tab_1.tabpage_2.dw_single.getitemstring(i, "orafo_metallo_codice")
				if ls_cod_metallo = ls_cod_metallo_old and not isnull(ls_cod_metallo_old) then
					ld_fino_saldo=tab_1.tabpage_2.dw_single.getitemdecimal(i - 1, ls_campo+"saldo")
				else
					
					lb_chiuso=false
					e=1
					ll_ri=tab_1.tabpage_2.dw_chiusi.RowCount()
					if (ll_ri >0)and(a<>3) then
						do
							if ld_datamin=datetime(date('20/12/20'),time('20.20.20')) then
								exit
							end if
							if ld_datamin=datetime(date('10/10/10'),time('10.10.10')) then
								ls_met_chiuso=tab_1.tabpage_2.dw_chiusi.GetItemString(e,"codice_metallo")
								if (ls_met_chiuso=ls_cod_metallo_old) then
									ld_g_in=tab_1.tabpage_2.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"entrata")
									ld_g_out=tab_1.tabpage_2.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"uscita")
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
							ld_gp_in=tab_1.tabpage_2.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"entrata")
							ld_gp_out=tab_1.tabpage_2.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"uscita")
							ld_gp_saldo=tab_1.tabpage_2.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"saldo")
							tab_1.tabpage_2.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"in",ld_g_in+ld_gp_in)
							tab_1.tabpage_2.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"out",ld_g_out+ld_gp_out)
							ld_g_saldo=ld_g_in+ld_gp_in - (ld_g_out+ld_gp_out) 
							tab_1.tabpage_2.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"saldo",ld_g_saldo)
							e++
						loop until (e=ll_ri+1)
					end if
					ld_fino_saldo=0
				end if
				ld_fino_saldo= ld_fino_saldo+ld_fino_entrata - ld_fino_uscita
				tab_1.tabpage_2.dw_single.setitem(i, ls_campo+"saldo", ld_fino_saldo)
			end if
	next
	
	lb_chiuso=false
	e=1
	ll_ri=tab_1.tabpage_2.dw_chiusi.RowCount()
	if (ll_ri >0)and(a<>3)and(tab_1.tabpage_2.dw_single.rowcount()>0) then
		do
			if ld_datamin=datetime(date('20/12/20'),time('20.20.20')) then
				exit
			end if
			if ld_datamin=datetime(date('10/10/10'),time('10.10.10')) then
				ls_met_chiuso=tab_1.tabpage_2.dw_chiusi.GetItemString(e,"codice_metallo")
				if (ls_met_chiuso=ls_cod_metallo_old) then
					ld_g_in=tab_1.tabpage_2.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"entrata")
					ld_g_out=tab_1.tabpage_2.dw_chiusi.GetItemDecimal(e,"gran_"+ls_campo+"uscita")
					e=ll_ri
				end if
			else
				ls_data=string(ld_datamin)
				choose case a
					case 1
						SELECT gran_fino_entrata, gran_fino_uscita
						INTO :ld_g_in, :ld_g_out
						FROM orafo_saldi_chiusi
						WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo);
					case 2
						SELECT gran_calo_entrata, gran_calo_uscita
						INTO :ld_g_in, :ld_g_out
						FROM orafo_saldi_chiusi
						WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo);
					case 4
						SELECT gran_lire_entrata, gran_lire_uscita
						INTO :ld_g_in, :ld_g_out
						FROM orafo_saldi_chiusi
						WHERE (s_data_chius=:ls_data)AND(codice_metallo=:ls_cod_metallo);
				end choose
				if sqlca.sqlcode<>0 then
					SetNull(ld_g_in)
					SetNull(ld_g_out)
				end if
			end if
			ld_gp_in=tab_1.tabpage_2.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"entrata")
			ld_gp_out=tab_1.tabpage_2.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"uscita")
			ld_gp_saldo=tab_1.tabpage_2.dw_single.GetItemDecimal(i -1,"gran_"+ls_campo+"saldo")
			tab_1.tabpage_2.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"in",ld_g_in+ld_gp_in)
			tab_1.tabpage_2.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"out",ld_g_out+ld_gp_out)
			ld_g_saldo=ld_g_in+ld_gp_in - (ld_g_out+ld_gp_out) 
			tab_1.tabpage_2.dw_single.SetItem(i - 1,"cgrans_"+ls_campo+"saldo",ld_g_saldo)
			e++
		loop until (e=ll_ri+1)
	end if
next
end subroutine

public subroutine wf_carica_parziali (datastore ads_data);long ll_group, ll_next_group, ll_riga, i, n, ll_met, ll_num_righe, ll_ret
decimal{2} ld_in, ld_out, ld_saldo
string ls_campo, ls_metallo

ll_riga=ads_data.Rowcount()
if ll_riga>0 then
	for n=1 to 2
		if n=1 then ls_campo="fino_calo"
		if n=2 then ls_campo="lire"
		ll_riga=0
		ll_num_righe=1
		do
			ll_group=ads_data.FindGroupChange(ll_num_righe,1)
			if ll_group>0 then
				ll_next_group=ads_data.FindGroupChange(ll_group+1,1)
				if ll_next_group>0 then
					ll_riga=ll_next_group -1
				else
					ll_riga=ads_data.rowcount()
				end if
				ld_saldo=0
				for i=ll_group to ll_riga
					ld_in=ads_data.GetItemdecimal(i,ls_campo+"_entrata")
					ld_out=ads_data.GetItemdecimal(i,ls_campo+"_uscita")
					ld_saldo=ld_saldo+(ld_in - ld_out)
					ads_data.SetItem(i,ls_campo+"_saldo", ld_saldo)
				next
			end if
			ll_num_righe=ll_group+1
		loop until ll_group=0
	next
	
end if
end subroutine

public subroutine wf_insert_parziali (datastore ads_origine, datawindow adw_dest);

long ll_num_righe, ll_group, ll_id_sog_com, ll_next_group, ll_riga, err
integer i
decimal {2} ld_gf_in, ld_gf_out, ld_gc_in, ld_gc_out, ld_gl_in, ld_gl_out
string ls_metallo, ls_s_data_chius
datetime ld_data
time tt

ll_num_righe=ads_origine.Rowcount()
ll_riga=0
ll_num_righe=1
do
	ll_group=ads_origine.FindGroupChange(ll_num_righe,1)
	if ll_group>0 then
		ll_next_group=ads_origine.FindGroupChange(ll_group+1,1)
		if ll_next_group>0 then
			ll_riga=ll_next_group -1
		else
			ll_riga=ads_origine.rowcount()
		end if
			ld_gf_in=ads_origine.getItemDecimal(ll_group,"gran_fino_entrata")
			ld_gf_out=ads_origine.getItemDecimal(ll_group,"gran_fino_uscita")
			ld_gc_in=ads_origine.getItemDecimal(ll_group,"gran_calo_entrata")
			ld_gc_out=ads_origine.getItemDecimal(ll_group,"gran_calo_uscita")
			ld_gl_in=ads_origine.getItemDecimal(ll_group,"gran_lire_entrata")
			ld_gl_out=ads_origine.getItemDecimal(ll_group,"gran_lire_uscita")
		ls_metallo=ads_origine.getItemString(ll_group,"orafo_metallo_codice")

		
		ll_riga=adw_dest.InsertRow(0)
		adw_dest.Setitem(ll_riga,"orafo_metallo_codice",ls_metallo)
		adw_dest.Setitem(ll_riga,"articolo_codice",'Saldo parz.')
		adw_dest.Setitem(ll_riga,"fino",ld_gf_in)
		adw_dest.Setitem(ll_riga,"calo",ld_gc_in)
		adw_dest.Setitem(ll_riga,"tot_riga_val_az",ld_gl_in)
		adw_dest.Setitem(ll_riga,"caus_magazzino_saldi_cl_fino",'+')
		adw_dest.Setitem(ll_riga,"caus_magazzino_saldi_cl_lire",'+')

		
		ll_riga=adw_dest.InsertRow(0)
		adw_dest.Setitem(ll_riga,"orafo_metallo_codice",ls_metallo)
		adw_dest.Setitem(ll_riga,"articolo_codice",'Saldo parz.')
		adw_dest.Setitem(ll_riga,"fino",ld_gf_out)
		adw_dest.Setitem(ll_riga,"calo",ld_gc_out)
		adw_dest.Setitem(ll_riga,"tot_riga_val_az",ld_gl_out)
		adw_dest.Setitem(ll_riga,"caus_magazzino_saldi_cl_fino",'-')
		adw_dest.Setitem(ll_riga,"caus_magazzino_saldi_cl_lire",'-')

	end if
	ll_num_righe=ll_group+1
loop until ll_group=0
adw_dest.sort()
adw_dest.groupcalc()

end subroutine

public subroutine wf_genera_doc ();long ll_id_reg_car, ll_id_reg_scar, ll_id_prof_car, ll_id_prof_scar, ll_num_prog, ll_id_sog_com, ll_id_valuta
long ll_id_art, ll_id_doc, ll_id_r_lotto, ll_id_u_conf, ll_riga, i, ll_id_caus_car, ll_id_caus_scar, ll_id_lotto
decimal{2} ld_quantita
date ld_data_reg=Today()
string ls_cod_lotto, ls_des_art

	select id_registro
	into :ll_id_reg_car
	from registro
	where registro.tipo_registro='CL';
	select id_registro
	into :ll_id_reg_scar
	from registro
	where registro.tipo_registro='SL';
	select id_prof_documento
	into :ll_id_prof_car
	from prof_documento
	where prof_documento.codice='CL';
	select id_prof_documento
	into :ll_id_prof_scar
	from prof_documento
	where prof_documento.codice='SL';
	select id_caus_magazzino
	into :ll_id_caus_car
	from caus_magazzino
	where caus_magazzino.codice='CL';
	select id_caus_magazzino
	into :ll_id_caus_scar
	from caus_magazzino
	where caus_magazzino.codice='SL';
	select id_sog_commerciale
	into :ll_id_sog_com
	from sog_commerciale_gen
	where sog_commerciale_gen.rag_soc_1='me stesso';
	select id_valuta
	into :ll_id_valuta
	from valuta
	where valuta.descrizione='Lire';
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where (documento.id_prof_documento=:ll_id_prof_scar)and(documento.id_registro=:ll_id_reg_scar);
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
								documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino)
	values (:ll_id_prof_scar, :ll_id_reg_scar, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus_scar);
	select Max(id_documento)
	into :ll_id_doc
	from documento;
	for i=1 to ll_riga
	next
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where (documento.id_prof_documento=:ll_id_prof_car)and(documento.id_registro=:ll_id_reg_car);
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
								documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino)
	values (:ll_id_prof_car, :ll_id_reg_car, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus_car);
	select Max(id_documento)
	into :ll_id_doc
	from documento;
end subroutine

public subroutine wf_carica_saldi2 ();long ll_group, ll_next_group, ll_riga, i, n, ll_met, ll_num_righe, ll_ret
decimal{2} ld_in, ld_out, ld_saldo
string ls_campo, ls_metallo

ll_riga=tab_1.tabpage_2.dw_single.Rowcount()
if ll_riga>0 then
		ll_riga=0
		ll_num_righe=1
		do
			ll_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_num_righe,1)
			if ll_group>0 then
				ll_next_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_group+1,1)
				if ll_next_group>0 then
					ll_riga=ll_next_group -1
				else
					ll_riga=tab_1.tabpage_2.dw_single.rowcount()
				end if
				ld_saldo=0
				for i=ll_group to ll_riga
					st_2.text=string(i)
					
		
					ld_in=tab_1.tabpage_2.dw_single.GetItemDecimal(i,"fino_calo_entrata")
					
					ld_out=tab_1.tabpage_2.dw_single.GetItemDecimal(i,"fino_calo_uscita")					
					
					ld_saldo=ld_saldo+(ld_in - ld_out)
					tab_1.tabpage_2.dw_single.SetItem(i,"fino_calo_saldo",ld_saldo)
				next
				ld_saldo=0
				for i=ll_group to ll_riga
					st_2.text=string(i)
				
					
					
					ld_in=tab_1.tabpage_2.dw_single.object.lire_entrata[i]
					
					ld_out=tab_1.tabpage_2.dw_single.object.lire_uscita[i]
					ld_saldo=ld_saldo+(ld_in - ld_out)
					tab_1.tabpage_2.dw_single.object.lire_saldo[i]=ld_saldo
					
				next
			end if
			ll_num_righe=ll_group+1
		loop until ll_group=0
	
	
	
	
	if lb_trovata_chiusura then	
		ll_riga=0
		ll_num_righe=1
		do
			ll_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_num_righe,1)
			if ll_group>0 then
				ll_next_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_group+1,1)
				if ll_next_group>0 then
					ll_riga=ll_next_group -1
				else
					ll_riga=tab_1.tabpage_2.dw_single.rowcount()
				end if
				ls_metallo=tab_1.tabpage_2.dw_single.getItemString(ll_group,"orafo_metallo_codice")
				ll_met=tab_1.tabpage_2.dw_chiusi.Find("codice_metallo='"+ls_metallo+"'",1,tab_1.tabpage_2.dw_chiusi.rowcount())
				for n=1 to 3
					if n=1 then ls_campo="fino"
					if n=2 then ls_campo="calo"
					if n=3 then ls_campo="lire"
					ld_in=tab_1.tabpage_2.dw_chiusi.GetItemDecimal(ll_met,"gran_"+ls_campo+"_entrata")
					ld_out=tab_1.tabpage_2.dw_chiusi.GetItemDecimal(ll_met,"gran_"+ls_campo+"_uscita")				
					ll_ret=tab_1.tabpage_2.dw_single.SetItem(ll_riga,"chius_"+ls_campo+"_in",ld_in)
					tab_1.tabpage_2.dw_single.SetItem(ll_riga,"chius_"+ls_campo+"_out",ld_out)
				next
			end if
			ll_num_righe=ll_group+1
		loop until ll_group=0
	end if
	
	if lb_trovata_chiusura then
		tab_1.tabpage_2.dw_single.modify("gran_lire_in2.expression='sum(gran_lire_in for all)'")
		tab_1.tabpage_2.dw_single.modify("gran_lire_out2.expression='sum(gran_lire_out for all)'")
	end if
end if
end subroutine

on w_orafo_saldi_cliente_cx.create
int iCurrent
call super::create
this.cb_chiudisaldo=create cb_chiudisaldo
this.cb_sceglichiusura=create cb_sceglichiusura
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudisaldo
this.Control[iCurrent+2]=this.cb_sceglichiusura
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
end on

on w_orafo_saldi_cliente_cx.destroy
call super::destroy
destroy(this.cb_chiudisaldo)
destroy(this.cb_sceglichiusura)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;
idw_master = tab_1.tabpage_2.dw_1
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "documento.id_sog_commerciale"

tab_1.tabpage_1.dw_filtro.InsertRow(0)

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_sog_commerciale"
	idw_master.is_list.s_modo=modo_inserisci

	ib_nonmodale=false
	
	cb_chiudisaldo.enabled=false
else
	 ib_nonmodale=false
	
	 cb_chiudisaldo.visible=false
	
	 cb_sceglichiusura.visible=false
end if

end event

event ue_post_open;call super::ue_post_open;
cb_inserisci.Visible=false
cb_nuovo.Visible=false
cb_cancella.Visible=false
cb_annulla.Visible=false
tab_1.tabpage_1.dw_filtro.SetFocus()


if Upperbound(idw_master.is_list.s_identifica)>0 then

	tab_1.tabpage_1.dw_filtro.SetItem(1,"id_sog_commerciale",idw_master.is_list.l_identifica[1])
	tab_1.tabpage_1.dw_filtro.SetItem(1,"da_data",date(idw_master.is_list.s_identifica[4]))
	tab_1.tabpage_1.dw_filtro.SetItem(1,"da_ora",time(idw_master.is_list.s_identifica[5]))
	tab_1.tabpage_1.dw_filtro.SetItem(1,"a_data",date(idw_master.is_list.s_identifica[2]))
	tab_1.tabpage_1.dw_filtro.SetItem(1,"a_ora",time(idw_master.is_list.s_identifica[3]))
	is_filtro="date"
	tab_1.SelectTab(2)
	tab_1.tabpage_1.visible=false
end if
end event

event close;close(this)
end event

event closequery;
end event

type p_crescente from w_p_data`p_crescente within w_orafo_saldi_cliente_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_orafo_saldi_cliente_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_orafo_saldi_cliente_cx
int X=69
int Y=28
boolean BringToTop=true
end type

event cb_ok::clicked;close(parent)
end event

type cb_annulla from w_p_data`cb_annulla within w_orafo_saldi_cliente_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_orafo_saldi_cliente_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_orafo_saldi_cliente_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_orafo_saldi_cliente_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_orafo_saldi_cliente_cx
int X=2080
int Y=32
int Width=352
boolean Visible=false
boolean BringToTop=true
string Text="Salva chiusura"
end type

event cb_salva::clicked;

long ll_num_righe, ll_group, ll_id_sog_com, ll_next_group, ll_riga
integer i
decimal {2} ld_gf_in, ld_gf_out, ld_gc_in, ld_gc_out, ld_gl_in, ld_gl_out
string ls_metallo
datetime ld_data

ll_num_righe=tab_1.tabpage_2.dw_single.Rowcount()
ll_num_righe=1
Do
	ll_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_num_righe,1)
	if ll_group>0 then
		ll_next_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_group+1,1)
		if ll_next_group>0 then
			ll_riga=ll_next_group - 1
		else
			ll_riga=tab_1.tabpage_2.dw_single.RowCount()
		end if
		ld_gf_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"cgrans_fino_in")
		if IsNull(ld_gf_in) then
			ld_gf_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_fino_entrata")
			ld_gf_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_fino_uscita")
			ld_gc_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_calo_entrata")
			ld_gc_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_calo_uscita")
			ld_gl_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_lire_entrata")
			ld_gl_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_lire_uscita")
		else
			ld_gf_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"cgrans_fino_out")
			ld_gc_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"cgrans_calo_in")
			ld_gc_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"cgrans_calo_out")
			ld_gl_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"cgrans_lire_in")
			ld_gl_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"cgrans_lire_out")
		end if			
		ls_metallo=tab_1.tabpage_2.dw_single.getItemString(ll_group+1,"orafo_metallo_codice")
		ll_id_sog_com=tab_1.tabpage_2.dw_1.getItemNumber(1,"id_sog_commerciale")
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

type tab_1 from w_p_data`tab_1 within w_orafo_saldi_cliente_cx
int X=64
int Y=124
int Width=3255
int Height=1620
int TabOrder=30
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event tab_1::selectionchanging;call super::selectionchanging;
end event

event tab_1::selectionchanged;call super::selectionchanged;long ll_id_sog_com
date ld_da_data, ld_a_data
boolean lb_a, lb_da

if (oldindex=1) then 
	il_id_sog_com=tab_1.tabpage_1.dw_filtro.GetItemNumber(1,"id_sog_commerciale")
	if IsNull(il_id_sog_com) then
		return 1
	else
		choose case newindex
			case 2
				dwItemStatus l_status
				l_status=tab_1.tabpage_1.dw_filtro.getitemstatus(1,0,primary!)
				if (l_status<>NotModified!) and (l_status<>New!) then
					tab_1.tabpage_1.dw_filtro.setitemstatus(1,0,primary!,NotModified!)
					tab_1.tabpage_1.dw_filtro.accepttext()
					ld_da_data=tab_1.tabpage_1.dw_filtro.GetitemDate(1,"da_data")
					ld_a_data=tab_1.tabpage_1.dw_filtro.GetitemDate(1,"a_data")
					lb_a=Not(IsNull(ld_a_data))
					lb_da=Not(IsNull(ld_da_data))
					if lb_a then is_operazione="data fine"
					if lb_da then is_operazione="data inizio"
					if lb_a and lb_da then is_operazione="entrambe le date"
					if Not(lb_a) and Not(lb_da) then is_operazione="no date"
				
					is_filtro=wf_crea_filtro()
					
					idw_master.is_list.s_modo=modo_modifica
					idw_master.is_list.s_identifica[1]="id_sog_commerciale"
					idw_master.is_list.l_identifica[1]=il_id_sog_com
					idw_master.event ue_retrieve(0,0)
					idw_master.setfocus()
					
					parent.title="Scheda corrente di "+tab_1.tabpage_1.dw_filtro.GetItemString(1,"sog_commerciale_cod")+" "+&
							+tab_1.tabpage_1.dw_filtro.GetItemString(1,"sog_commerciale_des")
				
					cb_salva.Visible=false
					if tab_1.tabpage_2.dw_1.RowCount()<1 then
						tab_1.tabpage_2.dw_single.reset()
						tab_1.tabpage_2.dw_chiusi.reset()
						tab_1.tabpage_3.dw_causali.reset()
					end if
				end if
			case 3
		end choose
	end if
end if
				
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3218
int Height=1500
long BackColor=79741120
string Text="Impostazioni"
long TabBackColor=79741120
dw_filtro dw_filtro
end type

on tabpage_1.create
this.dw_filtro=create dw_filtro
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filtro
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_filtro)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_orafo_saldi_cliente_cx
int Y=32
boolean Visible=false
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
if tab_1.tabpage_2.dw_1.rowcount()<1 then
	tab_1.tabpage_2.dw_single.reset()
	tab_1.tabpage_2.dw_chiusi.reset()
end if
end if

end event

type dw_filtro from u_dw_master_main within tabpage_1
int X=23
int Y=32
int Width=3168
int Height=1460
int TabOrder=3
string DataObject="d_orafo_saldi_cliente_filtro_ff"
end type

event ue_set_search;call super::ue_set_search;

choose case as_nomecol
		
	case "articolo_cod"
		is_search_window 	= "w_articolo_coddes_documento_sw"
		is_ricpar.s_filter_value	= as_valcol
		is_ricpar.s_filter_name 	= "articolo_codice"
	case "articolo_des"
		is_search_window = "w_articolo_coddes_documento_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	case "sog_commerciale_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"

	case "sog_commerciale_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"

end choose


end event

event ue_use_search;call super::ue_use_search;
long ll_row

ll_row=GetRow()
choose case as_nomecol
		
	case "articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("articolo_cod", is_ricpar.s_main_value)
		uf_set_colval("articolo_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		is_filtro="articolo"
		
	case "articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("articolo_des", is_ricpar.s_main_value)
		uf_set_colval("articolo_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		is_filtro="articolo"		
		
	case "sog_commerciale_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_cod", is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		is_filtro=""		
		
	case "sog_commerciale_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_des", is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		is_filtro=""		

end choose

end event

event itemchanged;

		
String 	ls_sql_cond
String 	ls_dbc[], ls_dwc[], ls_dbv[]
Long	   ll_ok




choose case dwo.name
	
	CASE "articolo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "articolo_cod"
		ls_dwc[2] = "articolo_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
		
	CASE "articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "articolo_cod"
		ls_dwc[2] = "articolo_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (ll_ok > 0) THEN 
			RETURN 2
		END IF


  CASE "sog_commerciale_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "sog_commerciale_cod"
		ls_dwc[2] = "sog_commerciale_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	
		IF (ll_ok > 0) THEN  	
			RETURN 2
		END IF
		
		
	CASE "sog_commerciale_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "sog_commerciale_cod"
		ls_dwc[2] = "sog_commerciale_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (ll_ok > 0) THEN 
			RETURN 2
		END IF
	
end choose
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=3218
int Height=1500
long BackColor=79741120
string Text="Scheda soggetto"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
st_1 st_1
dw_chiusi dw_chiusi
dw_single dw_single
dw_1 dw_1
end type

on tabpage_2.create
this.st_1=create st_1
this.dw_chiusi=create dw_chiusi
this.dw_single=create dw_single
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_chiusi,&
this.dw_single,&
this.dw_1}
end on

on tabpage_2.destroy
destroy(this.st_1)
destroy(this.dw_chiusi)
destroy(this.dw_single)
destroy(this.dw_1)
end on

type st_1 from statictext within tabpage_2
int X=23
int Y=8
int Width=2080
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

type dw_chiusi from u_dw_master_main within tabpage_2
int X=0
int Y=68
int Width=3182
int Height=484
int TabOrder=4
string DataObject="d_orafo_saldi_cliente_tot_chiusi_tb"
boolean VScrollBar=true
end type

event retrieveend;call super::retrieveend;
if dw_1.rowcount()<1 then return
datetime ld_data
string ls_filtro
date ld_dd

rowcount=tab_1.tabpage_2.dw_chiusi.Rowcount()
if rowcount>0 then
	choose case is_operazione
		case "data inizio", "entrambe le date"
			
			ls_filtro="data_chiusura<=datetime('"+string(ld_datamin)+"')"
			SetFilter(ls_filtro)
			Filter()
			rowcount=tab_1.tabpage_2.dw_chiusi.Rowcount()
			
			if rowcount>0 then
				st_1.text='Ultima chiusura precedente il giorno '+string(date(ld_datamin))
				lb_trovata_chiusura=true
				ld_data=tab_1.tabpage_2.dw_chiusi.GetItemDatetime(rowcount,"data_chiusura")
				ls_filtro="data_chiusura=datetime('"+string(ld_data)+"')"
				SetFilter(ls_filtro)
				Filter()
			end if
		case "data fine"
			
			ls_filtro="data_chiusura<=datetime('"+string(ld_datamax)+"')"
			SetFilter(ls_filtro)
			Filter()
			rowcount=tab_1.tabpage_2.dw_chiusi.Rowcount()
			
			if rowcount>0 then
				st_1.text='Ultima chiusura precedente il giorno '+string(date(ld_datamax))
				lb_trovata_chiusura=true
				ld_data=tab_1.tabpage_2.dw_chiusi.GetItemDatetime(rowcount,"data_chiusura")
				ls_filtro="data_chiusura=datetime('"+string(ld_data)+"')"
				SetFilter(ls_filtro)
				Filter()
			end if
		case "no date"
			
			rowcount=tab_1.tabpage_2.dw_chiusi.Rowcount()
			
			if rowcount>0 then
				lb_trovata_chiusura=true
				ld_data=tab_1.tabpage_2.dw_chiusi.GetItemDatetime(rowcount,"data_chiusura")
				ld_datamin=ld_data
				ls_filtro="data_chiusura=datetime('"+string(ld_data)+"')"
				SetFilter(ls_filtro)
				Filter()
			end if
	end choose
end if
tab_1.tabpage_2.dw_single.post Retrieve(il_id_sog_com)

if Not(lb_trovata_chiusura) then st_1.text="Ultima chiusra inesistente"




end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sog_commerciale"
end event

event retrievestart;call super::retrievestart;lb_trovata_chiusura=false
SetFilter("")
Filter()
end event

type dw_single from u_dw_master_main within tabpage_2
int X=14
int Y=588
int Width=3186
int Height=900
int TabOrder=4
string DataObject="d_orafo_saldi_cliente_tb"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event retrieveend;

datetime ld_data, ld_dd, ld1, ld2, ld_data_chius
string ls_filtro, ls_filtro_parz=""



ld1=ld_datamin
ld2=ld_datamax

choose case is_operazione
	case "data inizio", "entrambe le date"
		ls_filtro_parz=wf_crea_filtro()
		if lb_trovata_chiusura then
			
			ld_data_chius=tab_1.tabpage_2.dw_chiusi.GetItemDateTime(1,"data_chiusura")
			ls_filtro_parz=ls_filtro_parz + "(datetime(data_documento,ora_registrazione)>=datetime('"+string(ld_data_chius)+"')) and "+&
							+"(datetime(data_documento,ora_registrazione)<=datetime('"+string(ld_datamin)+"'))"
		else
			ls_filtro_parz=ls_filtro_parz + "(datetime(data_documento,ora_registrazione)<=datetime('"+string(ld_datamin)+"'))"
		end if
	case else
		if ls_filtro_parz<>"" then ls_filtro_parz=Left(ls_filtro_parz, len(ls_filtro_parz) -4)
end choose
		










ls_filtro=describe("datawindow.table.filter")
if ls_filtro="?" then ls_filtro=""
tab_1.tabpage_3.dw_causali.Setfilter(ls_filtro)
tab_1.tabpage_3.dw_causali.filter()
tab_1.tabpage_3.dw_causali.retrieve(il_id_sog_com)


ld_data=ld_datamax
ls_filtro="relativetime(ora_registrazione,5)"
ls_filtro="datetime(data_documento,"+ls_filtro+")"
ls_filtro="string("+ls_filtro+")"
ls_filtro=ls_filtro+"=~~'"+string(ld_datamax)+"~~'"
ls_filtro="if("+ls_filtro+",1,0)'"
ls_filtro="r_arrotonda.visible='0 ~t "+ls_filtro
ls_filtro=this.modify(ls_filtro)
if (this.Rowcount()>0) and (is_operazione="no date") then 
	cb_chiudisaldo.Enabled=true
else
	cb_chiudisaldo.Enabled=false
end if


end event

event scrollhorizontal;call super::scrollhorizontal;dw_chiusi.modify("datawindow.horizontalscrollposition="+string(scrollpos))
end event

event ue_init;call super::ue_init;
end event

event retrievestart;call super::retrievestart;

date ld_a_data
string ls_filtro
datetime ld1, ld2

is_filtro=wf_crea_filtro()
ld1=ld_datamin
ld2=ld_datamax
choose case is_operazione
	case "data inizio"
		is_filtro=is_filtro+"(datetime(data_documento,ora_registrazione)>=datetime('"+string(ld_datamin)+"'))"
	case "data fine"
		is_filtro=is_filtro+"(datetime(data_documento,ora_registrazione)<=datetime('"+string(ld_datamax)+"'))"		
	case "entrambe le date"
		is_filtro=is_filtro+"(datetime(data_documento,ora_registrazione)>=datetime('"+string(ld_datamin)+"')) and "
		is_filtro=is_filtro+"(datetime(data_documento,ora_registrazione)<=datetime('"+string(ld_datamax)+"'))"
	case "no date"
		if lb_trovata_chiusura then
			ld_datamin=tab_1.tabpage_2.dw_chiusi.GetItemDateTime(1,"data_chiusura")
			is_filtro=is_filtro+"(datetime(data_documento,ora_registrazione)>=datetime('"+string(ld_datamin)+"'))"
		else
			is_filtro=left(is_filtro,Len(is_filtro)-5)
		end if
end choose

ls_filtro=is_filtro
SetFilter(is_filtro)
Filter()


end event

type dw_1 from u_dw_master_main within tabpage_2
int X=393
int Y=20
int TabOrder=1
boolean Visible=false
string DataObject="d_orafo_saldi_cliente_tot_prova_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_sog_commerciale"
iudw_children[1]=dw_chiusi
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=3218
int Height=1500
long BackColor=79741120
string Text="Totali per tipo causale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_causali dw_causali
cb_preview_caus cb_preview_caus
cb_st_causali cb_st_causali
end type

on tabpage_3.create
this.dw_causali=create dw_causali
this.cb_preview_caus=create cb_preview_caus
this.cb_st_causali=create cb_st_causali
this.Control[]={this.dw_causali,&
this.cb_preview_caus,&
this.cb_st_causali}
end on

on tabpage_3.destroy
destroy(this.dw_causali)
destroy(this.cb_preview_caus)
destroy(this.cb_st_causali)
end on

type dw_causali from u_dw_master_main within tabpage_3
int X=18
int Y=28
int Width=3168
int Height=1272
int TabOrder=4
string DataObject="d_orafo_saldi_cliente_cm_causali_tot"
boolean TitleBar=true
string Title="Totali per causale"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event scrollhorizontal;call super::scrollhorizontal;
end event

event ue_init;call super::ue_init;
end event

type cb_preview_caus from commandbutton within tabpage_3
int X=2213
int Y=1332
int Width=416
int Height=116
int TabOrder=15
boolean BringToTop=true
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_causali.object.datawindow.print.preview='yes'
dw_causali.object.datawindow.print.preview.rulers='yes'

end event

type cb_st_causali from commandbutton within tabpage_3
int X=2757
int Y=1332
int Width=416
int Height=116
int TabOrder=17
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_causali.print()
end event

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=3218
int Height=1500
long BackColor=79741120
string Text="Stampa"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_stampa dw_stampa
cb_preview cb_preview
cb_stampa cb_stampa
cb_zoomout cb_zoomout
cb_zoomin cb_zoomin
cb_next cb_next
cb_prev cb_prev
gb_2 gb_2
gb_1 gb_1
st_zoom st_zoom
cb_zoom100 cb_zoom100
end type

on tabpage_4.create
this.dw_stampa=create dw_stampa
this.cb_preview=create cb_preview
this.cb_stampa=create cb_stampa
this.cb_zoomout=create cb_zoomout
this.cb_zoomin=create cb_zoomin
this.cb_next=create cb_next
this.cb_prev=create cb_prev
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_zoom=create st_zoom
this.cb_zoom100=create cb_zoom100
this.Control[]={this.dw_stampa,&
this.cb_preview,&
this.cb_stampa,&
this.cb_zoomout,&
this.cb_zoomin,&
this.cb_next,&
this.cb_prev,&
this.gb_2,&
this.gb_1,&
this.st_zoom,&
this.cb_zoom100}
end on

on tabpage_4.destroy
destroy(this.dw_stampa)
destroy(this.cb_preview)
destroy(this.cb_stampa)
destroy(this.cb_zoomout)
destroy(this.cb_zoomin)
destroy(this.cb_next)
destroy(this.cb_prev)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_zoom)
destroy(this.cb_zoom100)
end on

type dw_stampa from datawindow within tabpage_4
int X=14
int Y=28
int Width=3177
int Height=1164
int TabOrder=5
boolean BringToTop=true
string DataObject="d_orafo_saldi_cliente_stampa_nr"
BorderStyle BorderStyle=StyleRaised!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_preview from commandbutton within tabpage_4
int X=2231
int Y=1320
int Width=416
int Height=116
int TabOrder=5
boolean BringToTop=true
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_righe
datawindowchild dwc_chiusura, dwc_righe, dwc_causali
string ls_app, ls_campo

setpointer(HourGlass!)

tab_1.tabpage_4.dw_stampa.Reset()
tab_1.tabpage_4.dw_stampa.Getchild("chiusura",dwc_chiusura)
dwc_chiusura.Reset()
tab_1.tabpage_4.dw_stampa.Getchild("righe",dwc_righe)
dwc_righe.Reset()
tab_1.tabpage_4.dw_stampa.Getchild("causali",dwc_causali)
dwc_causali.Reset()

ll_righe=tab_1.tabpage_2.dw_chiusi.RowCount()
tab_1.tabpage_2.dw_chiusi.RowsCopy(1,ll_righe,Primary!,dwc_chiusura,1,Primary!)
ll_righe=tab_1.tabpage_2.dw_single.RowCount()
tab_1.tabpage_2.dw_single.RowsCopy(1,ll_righe,Primary!,dwc_righe,1,Primary!)
ll_righe=tab_1.tabpage_3.dw_causali.RowCount()
tab_1.tabpage_3.dw_causali.RowsCopy(1,ll_righe,Primary!,dwc_causali,1,Primary!)

ls_app=tab_1.tabpage_1.dw_filtro.GetItemString(1,"sog_commerciale_cod")
if isnull(ls_app) then ls_app=''
tab_1.tabpage_4.dw_stampa.object.codice_sog_comm.text=ls_app
ls_app=tab_1.tabpage_1.dw_filtro.GetItemString(1,"sog_commerciale_des")
if isnull(ls_app) then ls_app=''
tab_1.tabpage_4.dw_stampa.object.rag_soc.text=ls_app
ls_app=""
if Not(IsNull(il_id_articolo)) then ls_app="Articolo '"+tab_1.tabpage_1.dw_filtro.GetItemString(1,"articolo_cod")+"', "
if Not(isNull(il_id_titolo)) then 
	select titolo
	into :ls_campo
	from orafo_titolo
	where orafo_titolo.id_titolo=:il_id_titolo;
	ls_app=ls_app+"Titolo '"+ls_campo+"', " 
end if
if Not(IsNull(il_id_caus_mag)) then 
	select codice
	into :ls_campo
	from caus_magazzino
	where caus_magazzino.id_caus_magazzino=:il_id_caus_mag;
	ls_app=ls_app+"Causale '"+ls_campo+"', "
end if

choose case is_operazione
	case "data inizio"
		ls_app=ls_app + "Movimenti a partire dal giorno "+string(date(ld_datamin))
	case "data fine"
		ls_app=ls_app + "Movimenti antecedenti il giorno "+string(date(ld_datamax))
	case "entrambe le date"
		ls_app=ls_app + "Movimenti effettuati nel periodo  "+string(date(ld_datamin))+" - "+string(date(ld_datamax))
	case else
		if ls_app<>"" then ls_app=Left(ls_app,len(ls_app) - 2)
end choose
if isnull(ls_app) then ls_app=''
tab_1.tabpage_4.dw_stampa.object.note.text=ls_app

tab_1.tabpage_4.cb_stampa.enabled=true
dw_stampa.object.datawindow.zoom=50

setpointer(Arrow!)

end event

type cb_stampa from commandbutton within tabpage_4
int X=2729
int Y=1316
int Width=416
int Height=116
int TabOrder=5
boolean Enabled=false
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
tab_1.tabpage_4.dw_stampa.print()
end event

type cb_zoomout from commandbutton within tabpage_4
int X=146
int Y=1328
int Width=114
int Height=84
int TabOrder=6
boolean BringToTop=true
string Text="-"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_zoom

li_zoom=integer(dw_stampa.describe("datawindow.zoom"))
if li_zoom>10 then 
	dw_stampa.object.datawindow.Zoom=li_zoom - 5
	st_zoom.text=string(li_zoom - 5)+" %"
end if
end event

type cb_zoomin from commandbutton within tabpage_4
int X=306
int Y=1328
int Width=114
int Height=84
int TabOrder=7
boolean BringToTop=true
string Text="+"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_zoom

li_zoom=integer(dw_stampa.describe("datawindow.zoom"))
if li_zoom>10 then 
	dw_stampa.object.datawindow.Zoom=li_zoom + 5
	st_zoom.text=string(li_zoom + 5)+" %"
end if

end event

type cb_next from commandbutton within tabpage_4
int X=1445
int Y=1324
int Width=247
int Height=84
int TabOrder=8
boolean BringToTop=true
string Text="Þ"
int TextSize=-12
int Weight=700
string FaceName="Symbol"
FontCharSet FontCharSet=Symbol!
FontFamily FontFamily=Decorative!
FontPitch FontPitch=Variable!
end type

event clicked;dw_stampa.scrollnextpage()
end event

type cb_prev from commandbutton within tabpage_4
int X=1166
int Y=1324
int Width=247
int Height=84
int TabOrder=9
boolean BringToTop=true
string Text="Ü"
int TextSize=-12
int Weight=700
string FaceName="Symbol"
FontCharSet FontCharSet=Symbol!
FontFamily FontFamily=Decorative!
FontPitch FontPitch=Variable!
end type

event clicked;dw_stampa.scrollpriorpage()
end event

type gb_2 from groupbox within tabpage_4
int X=1125
int Y=1244
int Width=603
int Height=220
int TabOrder=7
string Text="Pagine"
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within tabpage_4
int X=73
int Y=1244
int Width=1019
int Height=220
int TabOrder=6
string Text="Zoom"
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_zoom from statictext within tabpage_4
int X=475
int Y=1324
int Width=297
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="50 %"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_zoom100 from commandbutton within tabpage_4
int X=837
int Y=1324
int Width=206
int Height=84
int TabOrder=8
boolean BringToTop=true
string Text="100 %"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;	dw_stampa.object.datawindow.Zoom=100
	st_zoom.text="100 %"
end event

type cb_chiudisaldo from commandbutton within w_orafo_saldi_cliente_cx
int X=2843
int Y=16
int Width=416
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
decimal {2} ld_gf_in, ld_gf_out, ld_gc_in, ld_gc_out, ld_gl_in, ld_gl_out, ld_manif
string ls_metallo, ls_s_data_chius
datetime ld_data
time tt
datastore ds_contr

if messagebox('Chiusura Scheda','Confermi la chiusura della scheda?',Information!,YesNo!)=2 then return

tt=now()
ls_s_data_chius=string(tt,"hh.mm.ss")
tt=time(ls_s_data_chius)
ld_data=datetime(today(),tt)
ls_s_data_chius=string(ld_data)
if (ls_s_data_chius="")or IsNull(ls_s_data_chius) then return

ll_num_righe=tab_1.tabpage_2.dw_single.Rowcount()
ll_num_righe=1
Do
	ll_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_num_righe,1)
	if ll_group>0 then
		ll_next_group=tab_1.tabpage_2.dw_single.FindGroupChange(ll_group+1,1)
		if ll_next_group>0 then
			ll_riga=ll_next_group - 1
		else
			ll_riga=tab_1.tabpage_2.dw_single.RowCount()
		end if
		ld_gf_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"chius_fino_in")
		if IsNull(ld_gf_in) then
			ld_gf_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_fino_entrata")
			ld_gf_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_fino_uscita")
			ld_gc_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_calo_entrata")
			ld_gc_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_calo_uscita")
			ld_gl_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_lire_entrata")
			ld_gl_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"gran_lire_uscita")
			ld_manif=tab_1.tabpage_2.dw_single.getItemDecimal(ll_group,"somma_manifattura")
		else
			ld_gf_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"gran_fino_in")
			ld_gf_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"gran_fino_out")
			ld_gc_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"gran_calo_in")
			ld_gc_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"gran_calo_out")
			ld_gl_in=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"gran_lire_in")
			ld_gl_out=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"gran_lire_out")
			ld_manif=tab_1.tabpage_2.dw_single.getItemDecimal(ll_riga,"somma_manifattura_chius")
		end if			
		ls_metallo=tab_1.tabpage_2.dw_single.getItemString(ll_group,"orafo_metallo_codice")
		ll_id_sog_com=tab_1.tabpage_2.dw_1.getItemNumber(1,"id_sog_commerciale")
		tt=now()
		ls_s_data_chius=string(tt,"hh.mm.ss")
		tt=time(ls_s_data_chius)
		ld_data=datetime(today(),tt)
		ls_s_data_chius=string(ld_data)
		
		INSERT INTO orafo_saldi_chiusi (id_sog_commerciale, data_chiusura, gran_fino_entrata, 
												gran_fino_uscita, gran_calo_entrata, gran_calo_uscita, 
												gran_lire_entrata, gran_lire_uscita, codice_metallo, s_data_chius, importo_manifattura)
		VALUES (:ll_id_sog_com, :ld_data, :ld_gf_in, :ld_gf_out, :ld_gc_in, :ld_gc_out, :ld_gl_in, :ld_gl_out, :ls_metallo, :ls_s_data_chius, :ld_manif);

		CHOOSE CASE sqlca.sqlcode
			CASE -1
				messagebox('Errore','Impossibile accedere al database!')
		END CHOOSE

	end if
	ll_num_righe=ll_group+1
Loop Until ll_group=0

ds_contr=create datastore
ds_contr.DataObject="d_orafo_saldi_cliente_tot_chiusi_tb"
ds_contr.settransobject(sqlca)
ds_contr.retrieve(il_id_sog_com)
ds_contr.SetFilter("s_data_chius='"+ls_s_data_chius+"'")
ds_contr.Filter()
ll_num_righe=ds_contr.Rowcount()
destroy ds_contr



tab_1.tabpage_2.dw_chiusi.Retrieve(ll_id_sog_com)

end event

type cb_sceglichiusura from commandbutton within w_orafo_saldi_cliente_cx
int X=2368
int Y=16
int Width=416
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
ll_id_sog_com=tab_1.tabpage_2.dw_1.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog_com>0 and not isnull(ll_id_sog_com) then 
	openwithparm(w_orafo_saldi_chiusura_sel_gd, ll_id_sog_com)
	tab_1.SelectTab(1)
	tab_1.SelectTab(2)
end if


end event

type st_2 from statictext within w_orafo_saldi_cliente_cx
int X=1618
int Y=20
int Width=247
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_orafo_saldi_cliente_cx
int X=1335
int Y=28
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Riga n°"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

