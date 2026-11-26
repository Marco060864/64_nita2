forward
global type uo_or_documento from nonvisualobject
end type
end forward

global type uo_or_documento from nonvisualobject
end type
global uo_or_documento uo_or_documento

type variables

end variables

forward prototypes
public subroutine of_proponi_righe (ref u_dw_master_main adw_riga, integer al_id_prof)
public subroutine of_orafo_wizard (string ls_oggetto, ref u_dw_master_main ldw_gen, string ls_cod_sog)
public function string of_proponi_num_doc (long al_id_registro, long al_num_prog)
public function long of_converti_in_numero (string as_numero)
end prototypes

public subroutine of_proponi_righe (ref u_dw_master_main adw_riga, integer al_id_prof);integer li_righe, i, LI_righe_doc
DWObject uo_dwo
long ll_id_caus_mag, ll_id_test

string ls_articolo

datastore ds_righe_da_proporre


ds_righe_da_proporre=create datastore
ds_righe_da_proporre.dataobject="d_orafo_prof_prop_righe"
ds_righe_da_proporre.settransobject(sqlca)
ds_righe_da_proporre.retrieve(al_id_prof)
ds_righe_da_proporre.setsort("num_riga")
ds_righe_da_proporre.sort()

li_righe=ds_righe_da_proporre.rowcount()
if li_righe>0 then
	LI_righe_doc=adw_riga.rowcount()
	if	LI_righe_doc>1 then
		destroy ds_righe_da_proporre
		return
	ELSEIF LI_righe_doc=1 then
		ll_id_test=adw_riga.getitemnumber(1, "riga_documento_id_articolo")
		if ll_id_test>0 then
			destroy ds_righe_da_proporre
			return
		end if
	end if
	for i=1 to li_righe
		ls_articolo=ds_righe_da_proporre.getitemstring(i, "cod_articolo")
		ll_id_caus_mag=ds_righe_da_proporre.getitemnumber(i, "id_caus_magazzino")
		if not(i=1 and LI_righe_doc=1) then adw_riga.triggerevent("ue_insert")
		
		adw_riga.setitem(i, "riga_documento_id_caus_magazzino", ll_id_caus_mag)
		uo_dwo=adw_riga.object.c_articolo_cod
		adw_riga.trigger event itemchanged(i, uo_dwo, ls_articolo)
	next
end if
destroy ds_righe_da_proporre
end subroutine

public subroutine of_orafo_wizard (string ls_oggetto, ref u_dw_master_main ldw_gen, string ls_cod_sog);long ll_id_sog_com, ll_id_esercizio
string ls_nullo
s_param_articoli s_parametri

ll_id_esercizio=ldw_gen.getitemnumber(1, "c_esercizio")
s_parametri.a_data=ldw_gen.getitemdate(1, "data_documento")

select data_inizio
into :s_parametri.inizio_es
from esercizio
where id_esercizio=:ll_id_esercizio;
if isnull(s_parametri.inizio_es) then s_parametri.inizio_es=date(1900, 01,01)
s_parametri.da_data=date(1900, 01,01)
if isnull(s_parametri.a_data) then s_parametri.a_data=date(2100, 12,12)

choose case ls_oggetto
		
	case "Saldo Old"
	
		ll_id_sog_com=ldw_gen.getitemnumber(1, "id_sog_commerciale")
		if ll_id_sog_com>0 and not isnull(ll_id_sog_com) then 
			s_list_main lstr_for_win
			setnull(ls_nullo)
			lstr_for_win.s_modo = modo_modifica
			lstr_for_win.s_identifica[1] = "id_sog_commerciale"
			lstr_for_win.l_identifica[1] = ll_id_sog_com
			lstr_for_win.s_identifica[2] = ls_nullo
			lstr_for_win.s_identifica[3] = ls_nullo
			lstr_for_win.s_identifica[4] = ls_nullo
			lstr_for_win.s_identifica[5] = ls_nullo
			opensheetwithparm(w_orafo_saldi_cliente_cx, lstr_for_win, w_app_frame, 2, original!)
		end if
	case "Saldo New", "Saldo New T", "Saldo SinMet", "Saldo Prog L", "Solo Saldo","Solo ToT"
		if ls_oggetto="Saldo New T" then
			s_parametri.totali_doc="d_or_saldi_tot_tikal_con_saldo_prec"
		elseif ls_oggetto="Saldo SinMet" then
			s_parametri.totali_doc="d_or_saldi_mov_sintesi_tb"
		elseif ls_oggetto="Saldo Prog L" then
			s_parametri.totali_doc="d_or_saldi_cau_tikal_ok_tb"
		elseif ls_oggetto="Solo Saldo" then
			s_parametri.totali_doc="d_or_saldi_tot_tikal"
		elseif ls_oggetto="Solo ToT" then	
			s_parametri.totali_doc="d_or_saldi_mov_tb"
		else
			s_parametri.totali_doc="d_or_saldi_cau_dett_tb"
		end if
		s_parametri.legato_fino="N"
		s_parametri.da_data=s_parametri.da_data
		s_parametri.a_data=s_parametri.a_data
		s_parametri.da_sog_comm=ls_cod_sog
		s_parametri.a_sog_comm=ls_cod_sog
		OpenWithParm(w_or_saldi_rpt, s_parametri)
	case "Partite"
		
		ll_id_sog_com=ldw_gen.getitemnumber(1, "id_sog_commerciale")
		if ll_id_sog_com>0 and not isnull(ll_id_sog_com) then 
			opensheetwithparm(w_orafo_aper_partita_gd, ll_id_sog_com , w_app_frame, 2, original!)
		end if
		
	case "Partitario", "PartitarioT"
		if ls_oggetto="PartitarioT" then
			s_parametri.tipo_stampa="M"
		end if
		s_parametri.da_sog_comm=ls_cod_sog
		s_parametri.a_sog_comm=ls_cod_sog
		s_parametri.filtro="SSog. Commerciale: "+ls_cod_sog
		OpenWithParm(w_or_partitario_b_rpt, s_parametri)
end choose
end subroutine

public function string of_proponi_num_doc (long al_id_registro, long al_num_prog);integer li_righe
datastore ds_trova_num_doc
string ls_numero
long ll_numero

ds_trova_num_doc=create datastore
ds_trova_num_doc.dataobject="d_trova_num_doc_gd"
ds_trova_num_doc.settransobject(sqlca)
li_righe=ds_trova_num_doc.retrieve(al_id_registro, al_num_prog - 1)
if li_righe>0 then
	ls_numero=ds_trova_num_doc.getitemstring(1, "num_documento")
	ll_numero=long(ls_numero)
	if ll_numero>0 then
		ll_numero++
	else
		ll_numero=of_converti_in_numero(ls_numero)
		if ll_numero>0 then ll_numero++
		
	end if
	
	
end if
destroy ds_trova_num_doc
if ll_numero<=0 then ll_numero=al_num_prog
return string(ll_numero)

end function

public function long of_converti_in_numero (string as_numero);integer li_pos, li_lunghezza_stringa, i
string ls_test, ls_num_finale

li_lunghezza_stringa=len(as_numero)
for i= 1 to li_lunghezza_stringa
	ls_test=mid(as_numero, i, 1)
	if asc(ls_test)> 47 and asc(ls_test)< 58 then
		ls_num_finale+=ls_test
	else
		if i=1 then
			for i=li_lunghezza_stringa to 1
				ls_test=mid(as_numero, i, 1)
				if asc(ls_test)> 47 and asc(ls_test)< 58 then
					ls_num_finale+=ls_test
				else
					exit
				end if
			next
		else
			exit
		end if
	end if
next
return long(ls_num_finale)

end function

on uo_or_documento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_or_documento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

