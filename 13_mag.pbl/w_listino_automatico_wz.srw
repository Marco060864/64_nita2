forward
global type w_listino_automatico_wz from w_wiz_main
end type
type cb_esci from commandbutton within w_listino_automatico_wz
end type
type cb_salva from commandbutton within w_listino_automatico_wz
end type
type cb_inserisci from commandbutton within w_listino_automatico_wz
end type
type cb_cancella from commandbutton within w_listino_automatico_wz
end type
type tab_1 from tab within w_listino_automatico_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_sel2 from u_dw_ext_main within tabpage_1
end type
type dw_sel1 from u_dw_ext_main within tabpage_1
end type
type cb_procedi from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_sel2 dw_sel2
dw_sel1 dw_sel1
cb_procedi cb_procedi
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tabella from u_dw_ext_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tabella dw_tabella
end type
type tabpage_3 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_1 dw_1
end type
type tab_1 from tab within w_listino_automatico_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type cb_stampa from commandbutton within w_listino_automatico_wz
end type
end forward

global type w_listino_automatico_wz from w_wiz_main
integer width = 2816
integer height = 1912
string title = "Generazione automatica dei listini"
cb_esci cb_esci
cb_salva cb_salva
cb_inserisci cb_inserisci
cb_cancella cb_cancella
tab_1 tab_1
cb_stampa cb_stampa
end type
global w_listino_automatico_wz w_listino_automatico_wz

type variables
u_sql_scanner	iu_scan1, iu_scan2, iu_sct
w_wait_01	iw_wait
s_azione_listino	istr_az
integer		ii_dwi
decimal		idc_cambio1, idc_cambio2

end variables

forward prototypes
public function integer wf_selez_uc ()
public function integer wf_check_sel ()
public function integer wf_crea_mancanti (string as_sql, long al_idvar)
public function integer wf_calc_azione (s_azione_listino astr_az, datawindow adw_1, string as_nomein, string as_nomeout)
public subroutine wf_dwsetfocus ()
public function integer wf_taglia_prezzi (datawindow adw_1, decimal adc_p1, decimal adc_p2)
public function integer wf_crea_mancanti_2 (string as_sql, integer al_id_var_partenza, integer al_id_var_arrivo)
public function string wf_multisel (long row, datawindow adw_origine, string as_col_origine, datawindow adw_destinazione, string as_col_dest, string as_filtro_agg)
end prototypes

public function integer wf_selez_uc ();


string			ls_sql, ls_sql2, ls_sql3, ls_val1, ls_val2, ls_sql_solo_prezzo
string			ls_azione_pracq
long				ll_row, ll_val1, ll_scode, ll_iduc, ll_idvar, ll_idvar2
long				ll_nuc, ll_cuc, ll_idvalu, ll_temp
integer			li_caso
u_dw_ext_main	ldw_s1, ldw_s2, ldw_s3
integer			li_dummy
decimal			ldc_p1, ldc_p2

s_azione_listino	lstr_az

iw_wait.st_wait.text = "Selezione delle U/C"
ls_azione_pracq = '3'

ldw_s1 = tab_1.tabpage_1.dw_sel1


ll_row = ldw_s1.GetRow()
ll_idvar = ldw_s1.GetItemNumber(ll_row,"id_variazione")
ldw_s2 = tab_1.tabpage_1.dw_sel2
ll_idvar2 = ldw_s2.GetItemNumber(ll_row,"id_old_var")
ll_idvalu=0
ll_temp=0

select "variazione"."id_listino" into :ll_temp
from "dba"."variazione" where "variazione"."id_variazione" = :ll_idvar;
if ll_temp>0 then
	select "listino"."id_valuta" into :ll_idvalu
	from "dba"."listino" where "listino"."id_listino" = :ll_temp;
	if ll_idvalu>0 then
		istr_az.l_idvalu = ll_idvalu
	end if
end if

ldw_s2 = tab_1.tabpage_1.dw_sel2
ll_row = ldw_s2.GetRow()

istr_az.s_azione 		= ldw_s2.GetItemString(ll_row,"azione")
istr_az.l_idlistino	= ldw_s2.GetItemNumber(ll_row,"id_old_lis")
istr_az.l_idvar		= ldw_s2.GetItemNumber(ll_row,"id_old_var")

istr_az.d_percento	= ldw_s2.GetItemDecimal(ll_row,"percentuale")
istr_az.d_importo		= ldw_s2.GetItemDecimal(ll_row,"valore")
istr_az.d_prmin		= ldw_s2.GetItemDecimal(ll_row,"prezzo_minimo")
istr_az.d_arrot		= ldw_s2.GetItemDecimal(ll_row,"imp_arro")
istr_az.s_tipoarr		= ldw_s2.GetItemString(ll_row,"tipo_arro")
istr_az.s_crea			= ldw_s2.GetItemString(ll_row,"crea_vuoti")
istr_az.d_cambio		= 1

ldw_s3 = tab_1.tabpage_2.dw_tabella
iw_wait.st_wait_b.text = "Preparazione statement SQL"



ls_sql = "select unita_confezione.id_unita_confezione"
ls_sql_solo_prezzo=ls_sql
ls_sql += " from dba.unita_confezione, dba.articolo where "
ls_sql_solo_prezzo +=" from dba.unita_confezione, dba.articolo, dba.prezzo where "
ls_sql_solo_prezzo +="(unita_confezione.id_articolo = articolo.id_articolo) and "
	
		
ls_sql += "(unita_confezione.id_articolo = articolo.id_articolo)"



ll_val1 = ldw_s2.GetItemNumber(ll_row,"id_cat_codifica")
if (not isNull(ll_val1)) and (ll_val1>0) then
	ls_sql3 = ls_sql3 + " AND (articolo.id_cat_codifica = "+string(ll_val1)+")"
end if
ls_val1 = ldw_s2.GetItemString(ll_row,"cod_art1")
if (not isNull(ls_val1)) and (ls_val1>"") then
	ls_sql3 = ls_sql3 + " AND (articolo.codice >= '"+ls_val1+"')"
end if
ls_val1 = ldw_s2.GetItemString(ll_row,"cod_art2")
if (not isNull(ls_val1)) and (ls_val1>"") then
	ls_sql3 = ls_sql3 + " AND (articolo.codice <= '"+ls_val1+"')"
end if
ll_val1 = ldw_s2.GetItemNumber(ll_row,"id_cat_com_articolo")
if (not isNull(ll_val1)) and (ll_val1>0) then
	ls_sql3 = ls_sql3 + " AND (articolo.id_cat_com_articolo = "+string(ll_val1)+")"
end if
ll_val1 = ldw_s2.GetItemNumber(ll_row,"id_cat_merceologica")
if (not isNull(ll_val1)) and (ll_val1>0) then
	ls_sql3 = ls_sql3 + " AND (articolo.id_cat_merceologica = "+string(ll_val1)+")"
end if
ll_val1 = ldw_s2.GetItemNumber(ll_row,"id_cat_fiscale")
if (not isNull(ll_val1)) and (ll_val1>0) then
	ls_sql3 = ls_sql3 + " AND (articolo.id_cat_fiscale = "+string(ll_val1)+")"
end if
ll_val1 = ldw_s2.GetItemNumber(ll_row,"id_gruppo")
if (not isNull(ll_val1)) and (ll_val1>0) then
	ls_sql3 = ls_sql3 + " AND (articolo.id_gruppo_articoli = "+string(ll_val1)+")"
end if
ll_val1 = ldw_s2.GetItemNumber(ll_row,"id_produttore")
if (not isNull(ll_val1)) and (ll_val1>0) then
	ls_sql3 = ls_sql3 + " AND (articolo.id_anagrafica = "+string(ll_val1)+")"
end if
ll_val1 = ldw_s2.GetItemNumber(ll_row,"id_fornitore")
if (not isNull(ll_val1)) and (ll_val1>0) then
	ls_sql3 = ls_sql3 + " AND (articolo.id_sog_commerciale = "+string(ll_val1)+")"
end if

ldc_p1 = ldw_s2.GetItemNumber(ll_row,"da_prezzo")
if not isNull(ldc_p1) then
	ldc_p1 = ldw_s2.GetItemDecimal(ll_row,"da_prezzo")
else
	ldc_p1=0
end if
ldc_p2 = ldw_s2.GetItemNumber(ll_row,"a_prezzo")
if not isNull(ldc_p2) then
	ldc_p2 = ldw_s2.GetItemDecimal(ll_row,"a_prezzo")
else
	ldc_p2=99999999999999.9999
end if

ls_val1 = ldw_s2.GetItemString(ll_row,"azione")

ls_sql = ls_sql+ls_sql3
ls_sql_solo_prezzo = left(ls_sql_solo_prezzo, len(ls_sql_solo_prezzo) - 4) +ls_sql3
ls_sql3 = mid(ls_sql3,5)

ls_val1 = ldw_s2.GetItemString(ll_row,"azione")
ls_val2 = ldw_s2.GetItemString(ll_row,"crea_vuoti")
li_caso = 0
choose case ls_val1
	case '1'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '2'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '3'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '4'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '5'
		
		if ls_val2 = 'S' then li_caso = 4 else li_caso = 3
	case '6'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 3 
	
	case '7'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '8'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '9'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
		
end choose

choose case li_caso
	case 1
	case 2
		wf_crea_mancanti (ls_sql,ll_idvar)
	case 3
		ls_sql_solo_prezzo=trim(ls_sql_solo_prezzo)
		if right(ls_sql_solo_prezzo, 3)<>'AND' then ls_sql_solo_prezzo+= " and "
		ls_sql=ls_sql_solo_prezzo+ " (prezzo.id_unita_confezione = unita_confezione.id_unita_confezione) "
		ls_sql = ls_sql + " AND (prezzo.id_variazione = "+string(ll_idvar2)+")"
		wf_crea_mancanti_2 (ls_sql,ll_idvar2, ll_idvar)
		ls_sql=ls_sql_solo_prezzo
		
		
		
		
		
		
	case 4
		wf_crea_mancanti (ls_sql,ll_idvar)
end choose

ls_val1 = ldw_s2.GetItemString(ll_row,"azione")
iu_sct.f_reset_cur_as_ini()
if (ls_sql3 > " ") then
	iu_sct.f_add_where_condition(ls_sql3)
end if
ls_sql = iu_sct.f_getcurrent()
ldw_s3.object.datawindow.table.select = ls_sql
ldw_s3.retrieve(ll_idvar)

//if (not isNull(ldc_p1)) and (not isNull(ldc_p2)) and (ldc_p1>=0) and (ldc_p2>0)  then
if (ldc_p1>=0 and ldc_p2>0) and (not(ldc_p1=0 and ldc_p2=99999999999999.9999)) then
	lstr_az = istr_az
	lstr_az.d_percento = 0
	lstr_az.d_importo = 0
	lstr_az.d_arrot = 1
	lstr_az.s_tipoarr = 'X'
	wf_calc_azione (lstr_az, tab_1.tabpage_2.dw_tabella, "prezzo_prezzo", "prezzo_prezzo")
	wf_taglia_prezzi(tab_1.tabpage_2.dw_tabella,ldc_p1,ldc_p2)
end if
wf_calc_azione (istr_az, tab_1.tabpage_2.dw_tabella, "prezzo_prezzo", "prezzo_prezzo")


return 0

end function

public function integer wf_check_sel ();


string		ls_errmsg, ls_1, ls_2
long			ll_row, ll_id1, ll_id2
decimal{4}	ldc_1, ldc_2
integer		li_ret

ls_errmsg = ""
li_ret = 0

if tab_1.tabpage_1.dw_sel1.accepttext() < 0 then
	return -1
end if
if tab_1.tabpage_1.dw_sel2.accepttext() < 0 then
	return -1
end if

ll_row = tab_1.tabpage_1.dw_sel1.getrow()
if ll_row>0 then
	ll_id1 = tab_1.tabpage_1.dw_sel1.getitemnumber(ll_row,"id_variazione")
	if (isNull(ll_id1)) or (ll_id1 <=0) then
		ls_errmsg += "E' indispensabile una variazione su cui operare!~r~n"
	else
		
		SELECT	"valuta"."cambio"  
			INTO	:idc_cambio1  
			FROM	"dba"."listino", "dba"."valuta", "dba"."variazione"  
			WHERE	("valuta"."id_valuta" = "listino"."id_valuta") and
					("variazione"."id_listino" = "listino"."id_listino") and
					("variazione"."id_variazione" = :ll_id1)
			USING SQLCA;
	end if
else
	ls_errmsg += "Errore critico nell'accesso al dw_sel1!"
end if

ll_row = tab_1.tabpage_1.dw_sel2.getrow()
if ll_row>0 then
	
	ls_1 = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"cod_art1")
	ls_2 = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"cod_art2")
	if (not isNull(ls_1)) and (not isNull(ls_2)) and (ls_1>"") and (ls_2>"") then
		if ls_1 > ls_2 then
			ls_errmsg += "Gli estremi per il codice articolo non sono validi!~r~n"
		end if
	end if
	
	
	
	
	
	
		ldc_1 = 	tab_1.tabpage_1.dw_sel2.uf_getitemdecimal(ll_row,"da_prezzo")
		ldc_2 = 	tab_1.tabpage_1.dw_sel2.uf_getitemdecimal(ll_row,"a_prezzo")
						if (not isNull(ldc_1)) or (not isNull(ldc_2)) then
							if (isNull(ldc_1)) then ldc_1=0 
							if (isNull(ldc_2)) then ldc_2=999999999
					
						end if
		if (ldc_1>ldc_2) then
			ls_errmsg += "I prezzi devono essere in ordine!~r~n"
		end if
	
	
					
					
					
					
					
					
					
					
					
	
	
		if (not isNull(ldc_1)) and (not isNull(ldc_2)) then
			ls_1 = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"crea_vuoti")
			if ls_1 = "S" then
				ls_errmsg += "Non ha senso creare le voci assenti in una selezione di prezzo!~r~n"
			end if
		end if
	
	
	
	ls_1 = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"azione")
	if isNull (ls_1) then
		ls_errmsg += "L'azione da intraprendere non può essere nulla!~r~n"
	end if
	
	if (ls_1='2') or (ls_1='3') or (ls_1='5') or ls_1='7' or ls_1='8'  then
		ldc_1 = 	tab_1.tabpage_1.dw_sel2.uf_getitemdecimal(ll_row,"percentuale")
		
		if isNull(ldc_1) then
			ls_errmsg += "Ci deve essere una PERCENTUALE non nulla per l'azione scelta!~r~n"
		end if
	end if
	if (ls_1='4') then
		ldc_1 = 	tab_1.tabpage_1.dw_sel2.uf_getitemdecimal(ll_row,"valore")
		if (isNull(ldc_1)) or (ldc_1=0) then
			ls_errmsg += "Ci deve essere un VALORE non nullo per l'azione scelta!~r~n"
		end if
	end if
	if (ls_1='5') or (ls_1='6') then
		ll_id1 = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row,"id_old_lis")
		ll_id2 = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row,"id_old_var")
		if (isNull(ll_id1)) and (isNull(ll_id2)) then
			ls_errmsg += "Serve un listino o una variazione di partenza per l'azione scelta!~r~n"
		end if
	end if
	
	ls_1 = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"tipo_arro")
	if isNull (ls_1) or ls_1 <= " " then
		ls_errmsg += "Il tipo di arrotondamento DEVE essere specificato!~r~n"
	end if
	
else
	ls_errmsg += "Errore critico nell'accesso al dw_sel2!"
end if


if ls_errmsg > "" then
	messageBox("Attenzione, errori!",ls_errmsg)
	li_ret = -1
end if

return li_ret

end function

public function integer wf_crea_mancanti (string as_sql, long al_idvar);


long			ll_scode, ll_iduc
long			ll_sc2, ll_idpr


declare mycursor dynamic cursor for sqlsa;
prepare sqlsa from :as_sql;
ll_scode = sqlca.sqlcode
if ll_scode=0 then
	open dynamic mycursor;
	ll_scode=0
	do while ll_scode=0
		fetch mycursor INTO :ll_iduc;
		ll_scode = sqlca.sqlcode
		if ll_scode=0 then
			
			select id_unita_confezione into  :ll_idpr from	"dba".prezzo
				where	(prezzo.id_unita_confezione = :ll_iduc) and (prezzo.id_variazione = :al_idvar)
				using SQLCA;
			ll_sc2 = sqlca.sqlcode
			
			if ll_sc2=100 then
				insert into prezzo (id_unita_confezione, id_variazione, prezzo, coef_calo, prezzo_manifattura)
					values (:ll_iduc, :al_idvar, 0, 0, 0);
				ll_sc2 = sqlca.sqlcode
				if ll_sc2<0 then
					close mycursor;
					return -1
				end if
			end if
				
			
		end if
	loop
	close mycursor;
end if


return 0

end function

public function integer wf_calc_azione (s_azione_listino astr_az, datawindow adw_1, string as_nomein, string as_nomeout);


long			ll_row, ll_nrows, ll_idvalu, ll_idvar, ll_rig, ll_id_var
decimal		ldc_val, ldc_tot, ldc_qta, ldc_cambio, ld_perc_cif, ld_coef_cif, ldc_val_manif
string		ls_tipo
long			ll_iduc1
date			ld_datareg
long			ll_idval, ll_scode
long			ll_id_cif
long			ll_id_articolo
decimal		ld_coefficiente
string		ls_spesa_cif,ls_tipo_prezzo
decimal		ld_costo_aggiuntivo
decimal		ld_cambio_cif,ld_cif,ld_perc
decimal{2} ldc_calo

ld_perc=tab_1.tabpage_1.dw_sel2.getitemdecimal(1,"percentuale")
if isNull (adw_1) or (not isValid(adw_1)) then
	return -1
end if
if isNull(as_nomein) or (as_nomein<=" ") then
	return -1
end if
if (isNull (as_nomeout)) or (as_nomeout<= " ") then
	as_nomeout = as_nomein
end if
ll_nrows = adw_1.rowcount()
if ll_nrows <=0 then
	return -1
end if

ls_tipo = astr_az.s_azione
for ll_row = 1 to ll_nrows
	ldc_val = adw_1.getItemNumber(ll_row,as_nomein)
	ldc_val_manif = adw_1.getItemNumber(ll_row,"prezzo_manifattura")
	if  not isNull (ldc_val) or not IsNull(ldc_val_manif) then
		ldc_val = adw_1.getItemDecimal(ll_row,as_nomein)
		ldc_val_manif = adw_1.getItemDecimal(ll_row,"prezzo_manifattura")		
		
		choose case ls_tipo
			case '1'
				
			case '2'
				
				
				ldc_val = ldc_val * (1 + astr_az.d_percento/100.0)
				ldc_val_manif = ldc_val_manif * (1 + astr_az.d_percento/100.0)				
				
			case '3'
				
				
				
				
				
				
				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if isNull (ll_iduc1) then ll_iduc1=0
				
				ldc_val=f_rec_ult_costo(ll_iduc1, idc_cambio1, 1) 
				ldc_val		= ldc_val * (1 + astr_az.d_percento/100.0)
				ldc_val_manif	= ldc_val_manif * (1 + astr_az.d_percento/100.0)				
				
				
			case '4'
				
				ldc_val = ldc_val + astr_az.d_importo
				ldc_val_manif = ldc_val_manif + astr_az.d_importo				
			case '5','6'
				
				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if not isNull(astr_az.l_idvar) then
					
					select	prezzo, prezzo_manifattura
					into	:ldc_val,:ldc_val_manif
					from	prezzo
					where id_unita_confezione = :ll_iduc1 
					and id_variazione = :astr_az.l_idvar;
					if sqlca.sqlcode=0 then

						idc_cambio2=0
						
						SELECT	"valuta"."cambio"
							INTO	:idc_cambio2
							FROM	"dba"."listino", "dba"."valuta", "dba"."variazione"  
							WHERE	("valuta"."id_valuta" = "listino"."id_valuta") and
									("variazione"."id_listino" = "listino"."id_listino") and
									("variazione"."id_variazione" = :astr_az.l_idvar)
							USING SQLCA;
						if (idc_cambio1=0) or (idc_cambio2=0) then
							idc_cambio1 = 1
							idc_cambio2 = 1
						end if
						
						if ls_tipo='5' then
							ldc_val = ldc_val * (1 + astr_az.d_percento/100.0)
							ldc_val_manif = ldc_val_manif * (1 + astr_az.d_percento/100.0)							
						else
							ldc_val = ldc_val + astr_az.d_importo
							ldc_val_manif = ldc_val_manif + astr_az.d_importo							
						end if
						ldc_val = ldc_val * idc_cambio2 / idc_cambio1
						ldc_val_manif = ldc_val_manif * idc_cambio2 / idc_cambio1						
						adw_1.setItem(ll_row,"cstato","S")
					else
						ldc_val = 0
						ldc_val_manif = 0						
						adw_1.setItem(ll_row,"cstato","N")
					end if
				else
					
					
					if not isNull (astr_az.l_idlistino) then
						SQLCA.sp_prezzo_riferimento(ll_iduc1,astr_az.l_idlistino,today(),ldc_val)
						if not isNull (ldc_val) then
							

							idc_cambio2=0
							
							SELECT	"valuta"."cambio"
								INTO	:idc_cambio2
								FROM	"dba"."listino", "dba"."valuta"
								WHERE	("valuta"."id_valuta" = "listino"."id_valuta") and
										("listino"."id_listino" = :astr_az.l_idlistino)
								USING SQLCA;
							if (idc_cambio1=0) or (idc_cambio2=0) then
								idc_cambio1 = 1
								idc_cambio2 = 1
							end if
							
							if ls_tipo='5' then
								ldc_val = ldc_val * (1 + astr_az.d_percento/100.0)
								ldc_val_manif = 0
							else
								ldc_val = ldc_val + astr_az.d_importo
								ldc_val_manif = 0
							end if
							ldc_val = ldc_val * idc_cambio2 / idc_cambio1
							ldc_val_manif = 0
							adw_1.setItem(ll_row,"cstato","S")
						else
							ldc_val = 0
							ldc_val_manif = 0							
							adw_1.setItem(ll_row,"cstato","N")
						end if
					else
						
						ldc_val = -1
					end if
				end if
			case '7'
				
				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if isNull (ll_iduc1) then ll_iduc1=0
				
				ll_id_articolo=adw_1.getItemNumber(ll_row,"id_articolo")
				
				select articolo.id_cif
				into :ll_id_cif
				from articolo
				where id_articolo=:ll_id_articolo;
				
				if sqlca.sqlcode=0 then
					
					select cambio, coefficiente
					into :ld_cambio_cif, :ld_coef_cif
					from cif
					where id_cif=:ll_id_cif;
					ldc_val=f_rec_ult_costo(ll_iduc1, idc_cambio1, 1) 
					if sqlca.sqlcode=0 then
						
						declare cur_cif cursor for
						select percentuale
						from spesa_cif
						where id_cif=:ll_id_cif;
						open cur_cif;
						ld_cif=ld_cambio_cif
						fetch cur_cif into: ld_perc_cif;
						do while sqlca.sqlcode=0
							fetch cur_cif into: ld_perc_cif;
							ld_cif=ld_cif+(ld_cif*ld_perc_cif/100)
							
						loop
						close cur_cif;
						ldc_val=(ldc_val*ld_cif)+ld_perc
						ldc_val_manif=(ldc_val_manif*ld_cif)+ld_perc						
						select costo_aggiuntivo
						into :ld_costo_aggiuntivo
						from articolo
						where id_articolo=:ll_id_articolo;
						if ld_costo_aggiuntivo > 0 then
							ldc_val=ldc_val+ld_costo_aggiuntivo
							ldc_val_manif=ldc_val_manif+ld_costo_aggiuntivo
							ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
							ldc_val_manif=ldc_val_manif*(1 + astr_az.d_percento/100.0)							
						else
							ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
							ldc_val_manif=ldc_val_manif*(1 + astr_az.d_percento/100.0)							
						end if
						if ldc_val>0 then ldc_val=ldc_val*ld_coef_cif
						if ldc_val_manif>0 then ldc_val_manif=ldc_val_manif*ld_coef_cif						
					end if
				end if
			case '8'
				
				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if isNull (ll_iduc1) then ll_iduc1=0
				
				ll_id_articolo=adw_1.getItemNumber(ll_row,"id_articolo")
				
				select articolo.id_cif
				into :ll_id_cif
				from articolo
				where id_articolo=:ll_id_articolo;
				
				if sqlca.sqlcode=0 then
					
					select cambio, coefficiente
					into :ld_cambio_cif, :ld_coef_cif
					from cif
					where id_cif=:ll_id_cif;
					
					ldc_val=f_rec_ult_costo(ll_iduc1, idc_cambio1, 2)
					if sqlca.sqlcode=0 then
						
						declare cur1_cif cursor for
						select percentuale
						from spesa_cif
						where id_cif=:ll_id_cif;
						open cur1_cif;
						ld_cif=ld_cambio_cif
						fetch cur_cif into: ld_perc_cif;
						do while sqlca.sqlcode=0
							fetch cur1_cif into: ld_perc_cif;
							ld_cif=ld_cif+(ld_cif*ld_perc_cif/100)
						loop
						close cur1_cif;
						ldc_val=(ldc_val * ld_cif)+ld_perc 
						ldc_val_manif=(ldc_val_manif * ld_cif)+ld_perc 						
						select costo_aggiuntivo
						into :ld_costo_aggiuntivo
						from articolo
						where id_articolo=:ll_id_articolo;
						if ld_costo_aggiuntivo > 0 then
							ldc_val=ldc_val+ld_costo_aggiuntivo
							ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
							ldc_val_manif=ldc_val_manif+ld_costo_aggiuntivo
							ldc_val_manif=ldc_val_manif*(1 + astr_az.d_percento/100.0)
						else
							ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
							ldc_val_manif=ldc_val_manif*(1 + astr_az.d_percento/100.0)							
   					end if
						if ldc_val>0 then ldc_val=ldc_val*ld_coef_cif
						if ldc_val_manif>0 then ldc_val_manif=ldc_val_manif*ld_coef_cif						
					end if
				end if
				
				
			case '9'
				
				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if isNull (ll_iduc1) then ll_iduc1=0
				
				select a.costo_aggiuntivo
				into :ld_costo_aggiuntivo
				from articolo a, unita_confezione u
				where a."id_articolo"=u."id_articolo"
				and u.id_unita_confezione=:ll_iduc1;
				if sqlca.sqlcode=0 then
					ldc_val=ld_costo_aggiuntivo
					ldc_val		= ldc_val * (1 + astr_az.d_percento/100.0)
					ldc_val_manif=ld_costo_aggiuntivo
					ldc_val_manif	= ldc_val_manif * (1 + astr_az.d_percento/100.0)
				else
					ldc_val=-1
				end if
				
			case else
				
				ldc_val = -99
		end choose
		
		
		
		if IsNull(astr_az.d_prmin) then astr_az.d_prmin=0
		if (ldc_val<astr_az.d_prmin) then ldc_val = astr_az.d_prmin
		if isNull(astr_az.d_arrot)  then
			
			f_cerca_arrotondamento(ldc_val,astr_az.l_idvalu,astr_az.d_arrot,astr_az.s_tipoarr)
			f_cerca_arrotondamento(ldc_val_manif,astr_az.l_idvalu,astr_az.d_arrot,astr_az.s_tipoarr)			
		end if
		if abs(astr_az.d_arrot)>0 then
			ldc_val = f_round(ldc_val,astr_az.d_arrot,astr_az.s_tipoarr)
			ldc_val_manif = f_round(ldc_val_manif,astr_az.d_arrot,astr_az.s_tipoarr)
		end if
		//AGGIUNGO PER ARROTONDAMENTO
			
		ls_tipo_prezzo=tab_1.tabpage_1.dw_sel2.getitemstring(1, "manif_pezzo")
		if ls_tipo_prezzo='S' then
			
			adw_1.setItem(ll_row,"prezzo_manifattura",ldc_val_manif)		
		elseif ls_tipo_prezzo='X' then
			adw_1.setItem(ll_row,as_nomeout,ldc_val)
			adw_1.setItem(ll_row,"prezzo_manifattura",ldc_val_manif)
		else
			adw_1.setItem(ll_row,as_nomeout,ldc_val)
		end if
			
		ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				ldc_val = ldc_val * (1 + astr_az.d_percento/100.0)
				ldc_val_manif = ldc_val_manif * (1 + astr_az.d_percento/100.0)				
				select coef_calo
				into :ldc_calo
				from prezzo
				where id_variazione=:astr_az.l_idvar
				and id_unita_confezione=:ll_iduc1;
		adw_1.setItem(ll_row,"coef_calo",ldc_calo)
	end if
next

return 0

end function

public subroutine wf_dwsetfocus ();

choose case ii_dwi
	case 1
		tab_1.SelectTab(1)
		tab_1.tabpage_1.dw_sel1.setfocus()
	case 2
		tab_1.SelectTab(1)
		tab_1.tabpage_1.dw_sel2.setfocus()
	case 3
		tab_1.SelectTab(2)
		tab_1.tabpage_2.dw_tabella.setfocus()
end choose


end subroutine

public function integer wf_taglia_prezzi (datawindow adw_1, decimal adc_p1, decimal adc_p2);

long			ll_nrows, ll_row
decimal		ldc_p
string ls_man_pezzo, ls_campo_prezzo


ll_nrows = adw_1.rowcount()
if ll_nrows <=0 then
	return -1
end if
ls_man_pezzo=tab_1.tabpage_1.dw_sel2.getitemstring(1, "manif_pezzo")
if ls_man_pezzo='S' then
	ls_campo_prezzo="prezzo_manifattura"
else
	ls_campo_prezzo="prezzo_prezzo"
end if

for ll_row = ll_nrows to 1 step -1
	ldc_p = adw_1.GetItemNumber(ll_row,ls_campo_prezzo)
	if not IsNull(ldc_p) then
		ldc_p = adw_1.GetItemDecimal(ll_row,ls_campo_prezzo)
	else
		ldc_p=0
	end if
	if (ldc_p<adc_p1) or (ldc_p>adc_p2) then
		adw_1.deleterow(ll_row)
	end if
next

return 0
end function

public function integer wf_crea_mancanti_2 (string as_sql, integer al_id_var_partenza, integer al_id_var_arrivo);
long			ll_scode, ll_iduc
long			ll_sc2, ll_idpr

ll_sc2=messagebox("Attenzione!", "Vuoi davvero riportare gli articoli del listino sorgente~r~n"&
				+"su quello di destinazione?", stopsign!, yesno!)
if ll_sc2<>1 then	return - 1	
ll_sc2=0

declare mycursor dynamic cursor for sqlsa;
prepare sqlsa from :as_sql;
ll_scode = sqlca.sqlcode
if ll_scode=0 then
	open dynamic mycursor;
	ll_scode=0
	do while ll_scode=0
		fetch mycursor INTO :ll_iduc;
		ll_scode = sqlca.sqlcode
		if ll_scode=0 then
			
			select id_unita_confezione into  :ll_idpr from	"dba".prezzo
				where	(prezzo.id_unita_confezione = :ll_iduc) and (prezzo.id_variazione = :al_id_var_arrivo)
				using SQLCA;
			ll_sc2 = sqlca.sqlcode
			
			if ll_sc2=100 then
				insert into prezzo (id_unita_confezione, id_variazione, prezzo, coef_calo, prezzo_manifattura)
					values (:ll_iduc, :al_id_var_arrivo, 0, 0, 0);
				ll_sc2 = sqlca.sqlcode
				if ll_sc2<0 then
					close mycursor;
					return -1
				end if
			end if
				
			
		end if
	loop
	close mycursor;
end if


return 0

end function

public function string wf_multisel (long row, datawindow adw_origine, string as_col_origine, datawindow adw_destinazione, string as_col_dest, string as_filtro_agg);long i, ll_righe, ll_row
string ls_filter,ls_sql, ls_val_filter
boolean lb_filter

if as_filtro_agg<>"" then
	ls_filter=as_filtro_agg+" and ("
else
	ls_filter="("
end if
lb_filter=(as_col_origine<>"")and(as_col_dest<>"")
if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
	ll_righe=adw_origine.RowCount()
	ll_row=row
	
	for i = 1 to ll_righe
		if i=ll_row then continue
		if adw_origine.IsSelected(i) then adw_origine.SelectRow(i,false)
	next
	
	adw_origine.SelectRow(ll_row, not (adw_origine.isselected(ll_row)))
//	if adw_origine=tab_1.tabpage_1.dw_testa then
//		if adw_origine.isselected(ll_row) then 
//			lb_filter=true 
//		else 
//			lb_filter=false	
//		end if
//	else
//		lb_filter=false
//	end if
//	if lb_filter then
//		ls_val_filter=string(adw_origine.GetItemNumber(ll_row,as_col_origine))
//	 	ls_filter = ls_filter + as_col_dest+' ='+ls_val_filter+' or '
//	end if
elseif KeyDown(KeyShift!) then
		ll_row=row
		adw_origine.SelectRow(ll_row,true)
		ll_righe=adw_origine.RowCount()
		ll_row=ll_righe
		
		for i= 1 to ll_row
			if adw_origine.IsSelected(i) then ll_row=i
		next
		
		for i=ll_row+1 to ll_righe
			if adw_origine.IsSelected(i) then ll_righe=i
		next
		
		for i = ll_row to ll_righe
			adw_origine.SelectRow(i,true)
			if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '					
		next
	elseif KeyDown(KeyControl!) then
		
		ll_row=row
		adw_origine.SelectRow(ll_row,Not adw_origine.IsSelected(ll_row))
		
		ll_righe=adw_origine.RowCount()
		for i = 1 to ll_righe
			if adw_origine.IsSelected(i) then
				if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '	
			end if
		next
end if
//if lb_filter AND Len(ls_filter)>2 THEN
//	ls_filter=Left(ls_filter,Len(ls_filter) - 3)+")"
//	
//	
//	ls_sql=is_sql
//	
//	ls_sql=ls_sql+" and "+ls_filter
//	adw_dest.Setsqlselect(ls_sql)
//	adw_dest.Retrieve()
//	return ls_filter
//else
//	if adw_origine=tab_1.tabpage_1.dw_testa then
//		adw_dest.reset()
//	end if
//	return ""
//end if
return ""

	

end function

on w_listino_automatico_wz.create
int iCurrent
call super::create
this.cb_esci=create cb_esci
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.tab_1=create tab_1
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_esci
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.cb_inserisci
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.cb_stampa
end on

on w_listino_automatico_wz.destroy
call super::destroy
destroy(this.cb_esci)
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.tab_1)
destroy(this.cb_stampa)
end on

event open;call super::open;long					ll_row
DataWindowChild	dwc_drop
string				ls_sql
il_helptopic=112
iu_scan1 = create u_sql_scanner
iu_scan2 = create u_sql_scanner
iu_sct = create u_sql_scanner

tab_1.tabpage_2.dw_tabella.SetTransObject(SQLCA)
ls_sql = tab_1.tabpage_2.dw_tabella.object.datawindow.table.select
iu_sct.f_setinitial(ls_sql)
iu_sct.f_setcurrent(ls_sql)


tab_1.tabpage_1.dw_sel1.event ue_insert()
tab_1.tabpage_1.dw_sel2.event ue_insert()
tab_1.tabpage_1.dw_sel1.event ue_post_open()
tab_1.tabpage_1.dw_sel2.event ue_post_open()

ll_row = tab_1.tabpage_1.dw_sel1.getrow()
tab_1.tabpage_1.dw_sel1.getchild("id_variazione",dwc_drop)
ls_sql = dwc_drop.GetSqlSelect()
iu_scan1.f_setinitial(ls_sql)
iu_scan1.f_setcurrent(ls_sql)
ll_row = tab_1.tabpage_1.dw_sel2.getrow()
tab_1.tabpage_1.dw_sel1.getchild("id_old_var",dwc_drop)
ls_sql = dwc_drop.GetSqlSelect()
iu_scan2.f_setinitial(ls_sql)
iu_scan2.f_setcurrent(ls_sql)


end event

event close;call super::close;destroy iu_scan1
destroy iu_scan2
destroy iu_sct
end event

event closequery;call super::closequery;

long		ll_nmod
integer	li_ync, li_retval


if tab_1.tabpage_2.dw_tabella.accepttext()>0 then
	ll_nmod = tab_1.tabpage_2.dw_tabella.deletedcount()+tab_1.tabpage_2.dw_tabella.modifiedcount()
	if ll_nmod>0 then
		li_ync = MessageBox("Listini automatici", "Vi sono aggiornamenti del listino non salvati." + &
			"~n~rVuoi salvarli?", Question!, YesNoCancel!)

		CHOOSE CASE li_ync
			CASE 1
				
				tab_1.tabpage_2.dw_tabella.triggerevent("ue_update")
				ll_nmod = tab_1.tabpage_2.dw_tabella.deletedcount()+tab_1.tabpage_2.dw_tabella.modifiedcount()
				if ll_nmod = 0 then 
					li_retval = 0
				else
					li_retval = 1
				end if
				
			CASE 2
				
				ROLLBACK using SQLCA;
				li_retval = 0
				
			CASE 3
				
				li_retval = 1
				
		END CHOOSE
	else
		
		li_retval = 0
	end if
else
	
	li_retval = 1
end if


return li_retval

end event

event key;call super::key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>3 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=3
	end choose
	wf_dwsetfocus()
end if



end event

event ue_post_open;call super::ue_post_open;ii_dwi=1
wf_dwsetfocus()
end event

type cb_esci from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
integer x = 23
integer y = 24
integer width = 283
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;close (parent)
end event

type cb_salva from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
integer x = 2345
integer y = 24
integer width = 283
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_update")

end event

type cb_inserisci from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
integer x = 1691
integer y = 24
integer width = 283
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Inserisci"
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_insert")

end event

type cb_cancella from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
integer x = 2011
integer y = 24
integer width = 283
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancella"
end type

event clicked;long ll_riga=0
ll_riga=tab_1.tabpage_2.dw_tabella.getselectedrow(0)
do  while ll_riga>0
	tab_1.tabpage_2.dw_tabella.deleterow(ll_riga)
	ll_riga=tab_1.tabpage_2.dw_tabella.getselectedrow(0)
loop


end event

type tab_1 from tab within w_listino_automatico_wz
integer x = 32
integer y = 124
integer width = 2720
integer height = 1660
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2683
integer height = 1540
long backcolor = 79741120
string text = "Selezioni"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_sel2 dw_sel2
dw_sel1 dw_sel1
cb_procedi cb_procedi
end type

on tabpage_1.create
this.dw_sel2=create dw_sel2
this.dw_sel1=create dw_sel1
this.cb_procedi=create cb_procedi
this.Control[]={this.dw_sel2,&
this.dw_sel1,&
this.cb_procedi}
end on

on tabpage_1.destroy
destroy(this.dw_sel2)
destroy(this.dw_sel1)
destroy(this.cb_procedi)
end on

type dw_sel2 from u_dw_ext_main within tabpage_1
integer x = 27
integer y = 256
integer width = 2592
integer height = 1260
integer taborder = 30
string dataobject = "d_sel_listino_2_wz"
end type

event itemchanged;
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc,ls_tipo,ls_null
date			ld_data_inizio
long			ll_a, ll_ok, ll_row, ll_scode,ll_valuta,ll_null

DataWindowChild	dwc_drop
string				ls_sql, ls_add
setnull(ll_null)
setnull(ls_null)

ll_row = GetRow()
if ll_row > 0 then

	choose case dwo.name
		
		
		
		
		
		CASE "cod_art1"
          
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art1"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art1"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"codice", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				if isnull(this.getitemstring(1,'cod_art2')) or this.getitemstring(1,'cod_art2')='' then
					this.setitem(1, 'cod_art2', data)
					this.setitem(1, 'des_art2', this.getitemstring(1,'des_art1'))
				end if	
				RETURN 2
			END IF


		CASE 'des_art1'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art1"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art1"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				if isnull(this.getitemstring(1,'cod_art2')) or this.getitemstring(1,'cod_art2')='' then
					this.setitem(1, 'des_art2', data)
					this.setitem(1, 'cod_art2', this.getitemstring(1,'cod_art1'))
				end if
				RETURN 2
			END IF

		
		
		
		CASE "cod_art2"

         ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art2"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"codice", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF 


		CASE 'des_art2'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art2"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE 'des_prod'
			ls_sql_cond = ""
			ls_dbc[1] = "id_anagrafica"
			ls_dwc[1] = "id_produttore"
			ls_dbc[2] = "rag_soc_1"
			ls_dwc[2] = "des_prod"
			ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF		
	
		
		
		
		CASE 'cod_forn'
			ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"		
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_fornitore"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_forn"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_forn"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF	
	
		CASE 'des_forn'
			ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"				
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_fornitore"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_forn"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_forn"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		case "id_old_lis"
			this.setItem(ll_row,"id_old_var",u_freddie.gl_null)
			this.getchild("id_old_var",dwc_drop)
			if Not isNull(data) then
				ls_add = "variazione.id_listino = "+data
				iu_scan2.f_reset_cur_as_ini()
				iu_scan2.f_add_where_condition(ls_add)
				ls_sql = iu_scan2.f_getcurrent()
				dwc_drop.SetSqlSelect(ls_sql)
				select id_valuta,tipo
				into :ll_valuta,:ls_tipo
				from listino
				where id_listino=:data;
				setitem(ll_row,"id_old_valuta",ll_valuta)
				setitem(ll_row,"old_tipo_listino",ls_tipo)
				else
				setitem(ll_row,"id_old_valuta",ll_null)
				setitem(ll_row,"old_tipo_listino",ls_null)
				iu_scan2.f_reset_cur_as_ini()
				ls_sql = iu_scan2.f_getcurrent()
				dwc_drop.SetSqlSelect(ls_sql)
			end if
			dwc_drop.retrieve()
	
		
		
		
		case "azione"
			setItem(ll_row,"percentuale",u_freddie.gl_null)
			setItem(ll_row,"valore",u_freddie.gl_null)
			setItem(ll_row,"id_old_lis",u_freddie.gl_null)
			setItem(ll_row,"id_old_var",u_freddie.gl_null)
			setItem(ll_row,"crea_vuoti","N")
			
	end choose

end if





end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>3 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=3
	end choose
	wf_dwsetfocus()
end if



end event

event ue_set_search;call super::ue_set_search;

choose case as_nomecol
	case "cod_art1", "cod_art2"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
	case "des_art1", "des_art2"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	case "des_prod"
		is_search_window = "w_anagrafica_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
	case "cod_forn"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	case "des_forn"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"

end choose

end event

event ue_use_search;

choose case as_nomecol
	case "cod_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_art1", is_ricpar.s_ausil_value[1])
		
		if isnull(this.getitemstring(1,'cod_art2')) or this.getitemstring(1,'cod_art2')='' then
		  uf_set_colval("cod_art2", is_ricpar.s_main_value)
	     uf_set_colval("des_art2", is_ricpar.s_ausil_value[1])
	   end if  
		
	case "des_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_art1", is_ricpar.s_ausil_value[1])
		
		if isnull(this.getitemstring(1,'cod_art2')) or this.getitemstring(1,'cod_art2')='' then
		  uf_set_colval("des_art2", is_ricpar.s_main_value)
		  uf_set_colval("cod_art2", is_ricpar.s_ausil_value[1])
	   end if
		
	case "cod_art2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_art2", is_ricpar.s_ausil_value[1])
	case "des_art2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_art2", is_ricpar.s_ausil_value[1])

	case "des_prod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_produttore", is_ricpar.s_id_seg_value[1])
		
	case "cod_forn"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_forn", is_ricpar.s_ausil_value[1])
	case "des_forn"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_forn", is_ricpar.s_ausil_value[1])
end choose

end event

event ue_init;is_colonne_drop[1] = "id_cat_codifica"
is_colonne_drop[2] = "id_cat_com_articolo"
is_colonne_drop[3] = "id_cat_merceologica"
is_colonne_drop[4] = "id_cat_fiscale"
is_colonne_drop[5] = "id_gruppo"
is_colonne_drop[6] = "id_old_lis"
is_colonne_drop[7] = "id_old_var"
is_colonne_drop[8] = "id_old_valuta"
is_colonne_drop[9] = "id_filtro_variazione"

end event

type dw_sel1 from u_dw_ext_main within tabpage_1
integer x = 27
integer y = 16
integer width = 2217
integer height = 220
integer taborder = 10
string dataobject = "d_sel_listino_1_wz"
end type

event itemchanged;call super::itemchanged;
long					ll_row,ll_null,ll_valuta
DataWindowChild	dwc_drop
string				ls_sql, ls_add,ls_null,ls_tipo
setnull(ll_null)
setnull(ls_null)
ll_row = getrow()
choose case dwo.name
	case "id_listino"
		this.setItem(ll_row,"id_variazione",u_freddie.gl_null)
		this.getchild("id_variazione",dwc_drop)
		if Not isNull(data) then
			ls_add = "variazione.id_listino = "+data
			iu_scan1.f_reset_cur_as_ini()
			iu_scan1.f_add_where_condition(ls_add)
			ls_sql = iu_scan1.f_getcurrent()
			dwc_drop.SetSqlSelect(ls_sql)
			select id_valuta,tipo
			into :ll_valuta,:ls_tipo
			from listino
			where id_listino=:data;
			setitem(ll_row,"id_valuta",ll_valuta)
			setitem(ll_row,"tipo_listino",ls_tipo)
		else
			setitem(ll_row,"id_valuta",ll_null)
			setitem(ll_row,"tipo_listino",ls_null)
			iu_scan1.f_reset_cur_as_ini()
			ls_sql = iu_scan1.f_getcurrent()
			dwc_drop.SetSqlSelect(ls_sql)
		end if
		dwc_drop.retrieve()
end choose
end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>3 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=3
	end choose
	wf_dwsetfocus()
end if



end event

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_listino"
is_colonne_drop[2] = "id_variazione"
is_colonne_drop[3] = "id_valuta"

end event

type cb_procedi from commandbutton within tabpage_1
integer x = 2304
integer y = 76
integer width = 283
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procedi..."
end type

event clicked;

long			ll_nmod
integer		li_ync, li_retval
integer		li_val1


if tab_1.tabpage_2.dw_tabella.accepttext()>0 then
	ll_nmod = tab_1.tabpage_2.dw_tabella.deletedcount()+tab_1.tabpage_2.dw_tabella.modifiedcount()
	if ll_nmod>0 then
		li_ync = MessageBox("Listini automatici", "Vi sono aggiornamenti del listino non salvati." + &
			"~n~rVuoi salvarli prima di continuare?", Question!, YesNoCancel!)

		CHOOSE CASE li_ync
			CASE 1
				
				tab_1.tabpage_2.dw_tabella.triggerevent("ue_update")
				ll_nmod = tab_1.tabpage_2.dw_tabella.deletedcount()+tab_1.tabpage_2.dw_tabella.modifiedcount()
				if ll_nmod = 0 then 
					li_retval = 0
				else
					li_retval = 1
				end if
			CASE 2
				
				li_retval = 0
			CASE 3
				
				li_retval = 1
		END CHOOSE
	else
		
		li_retval = 0
	end if
else
	
	li_retval = 1
end if

if li_retval=0 then

	
	
	
	open (iw_wait,"w_wait_01")
	cb_cancella.enabled = false
	cb_inserisci.enabled = false
	cb_salva.enabled = false
	cb_stampa.enabled = false
	
	tab_1.tabpage_2.dw_tabella.reset()
	li_val1 = wf_check_sel()
	if li_val1 = 0 then
		wf_selez_uc()
		cb_cancella.enabled = true
		cb_inserisci.enabled = true
		cb_salva.enabled = true
		cb_stampa.enabled = true
		ii_dwi = 3
		wf_dwsetfocus()
	end if
	close (iw_wait)
	
	
	

end if

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2683
integer height = 1540
long backcolor = 79741120
string text = "Risultati"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_tabella dw_tabella
end type

on tabpage_2.create
this.dw_tabella=create dw_tabella
this.Control[]={this.dw_tabella}
end on

on tabpage_2.destroy
destroy(this.dw_tabella)
end on

type dw_tabella from u_dw_ext_main within tabpage_2
event ue_delete ( )
event ue_update ( )
integer x = 18
integer y = 28
integer width = 2633
integer height = 1496
integer taborder = 11
string dataobject = "d_orafo_listino_aut_risult_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_delete;call super::ue_delete;
long		ll_row
string	ls_msg
integer	li_but

if this.RowCount() > 0 then
	ls_msg = "Confermi l'eliminazione del record?"
	li_but = 2
	if MessageBox(THIS.is_Title, ls_msg, Question!, YesNo!, li_but) = 1 then	
		this.DeleteRow(0)
		this.SetFocus()
	end if
end if


end event

event ue_update;
long		ll_nmod


if accepttext()>0 then
	ll_nmod = deletedcount()+modifiedcount()
	if ll_nmod > 0 then
		if this.update(false,false) >0 then
			COMMIT using SQLCA;
			if sqlca.sqlcode=0 then
				resetupdate()
			else
				ROLLBACK using SQLCA;
			end if
		else
			ROLLBACK using SQLCA;
		end if
	end if
end if


end event

event retrieveend;Long ll
select 1
into	 :ll
from	 sys.dummy
;
end event

event ue_key;call super::ue_key;

choose case key
	case Keyadd!
		
		if (keyFlags=2) then
			
			triggerevent ("ue_insert")
		end if
		
	case KeySubtract!
		if (keyFlags=2) then
			triggerevent("ue_delete")
		end if

	case KeyS!
		if (keyFlags=2) then
			triggerevent("ue_update")
		end if

	case KeyF6!
		choose case keyflags
			case 0
				
				ii_dwi ++
				if ii_dwi>3 then ii_dwi=1
			case 1
				
				ii_dwi --
				if ii_dwi<1 then ii_dwi=3
		end choose
		wf_dwsetfocus()

end choose
end event

event ue_set_search;call super::ue_set_search;
long		ll_row, ll_idart

choose case as_nomecol
	case "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
		is_ricpar.s_sql_cond = ""
	case "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		is_ricpar.s_sql_cond = ""
		
	case "c_unita_confezione_cod"
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_codice"
		ll_row = getRow()
		ll_idart=getitemnumber(ll_row,"id_articolo")
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = "+string(ll_idart)

end choose

end event

event ue_use_search;call super::ue_use_search;choose case as_nomecol
	case "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
	case "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
	case "c_unita_confezione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
end choose
end event

event ue_init;call super::ue_init;is_title = "Listini Automatici"
end event

event ue_insert;


long		ll_row, ll_idvar

ll_row = tab_1.tabpage_1.dw_sel1.Getrow()
if ll_row > 0 then
	ll_idvar = tab_1.tabpage_1.dw_sel1.GetItemNumber(ll_row,"id_variazione")
	if (Not IsNull(ll_idvar)) and (ll_idvar>0) then
		super::event ue_insert()
		ll_row = getrow()
		setItem(ll_row, "id_variazione",ll_idvar)
	end if
end if


end event

event clicked;call super::clicked;if row>0 then
	wf_multisel(row,this,"",this,"","")
end if
end event

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 104
integer width = 2683
integer height = 1540
long backcolor = 79741120
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_3.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_3.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_3
integer x = 9
integer y = 40
integer width = 2505
integer height = 1436
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_articolo_prezzo_prova"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;settransobject(sqlca)
retrieve()
end event

type cb_stampa from commandbutton within w_listino_automatico_wz
integer x = 1344
integer y = 24
integer width = 283
integer height = 88
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Stampa"
end type

event clicked;printsetup()
tab_1.tabpage_2.dw_tabella.object.datawindow.print.preview="yes"

tab_1.tabpage_2.dw_tabella.print()
tab_1.tabpage_2.dw_tabella.object.datawindow.print.preview="no"
end event

