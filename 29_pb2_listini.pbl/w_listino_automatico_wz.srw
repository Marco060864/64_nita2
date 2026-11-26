forward
global type w_listino_automatico_wz from w_wiz_main
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
type tabpage_2 from userobject within tab_1
end type
type dw_tabella from u_dw_ext_main within tabpage_2
end type
type cb_esci from commandbutton within w_listino_automatico_wz
end type
type cb_salva from commandbutton within w_listino_automatico_wz
end type
type cb_inserisci from commandbutton within w_listino_automatico_wz
end type
type cb_cancella from commandbutton within w_listino_automatico_wz
end type
type tabpage_1 from userobject within tab_1
dw_sel2 dw_sel2
dw_sel1 dw_sel1
cb_procedi cb_procedi
end type
type tabpage_2 from userobject within tab_1
dw_tabella dw_tabella
end type
type tab_1 from tab within w_listino_automatico_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_listino_automatico_wz from w_wiz_main
int Width=2779
int Height=1896
boolean TitleBar=true
string Title="Generazione automatica dei listini"
tab_1 tab_1
cb_esci cb_esci
cb_salva cb_salva
cb_inserisci cb_inserisci
cb_cancella cb_cancella
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
end prototypes

public function integer wf_selez_uc ();


string			ls_sql, ls_sql2, ls_sql3, ls_val1, ls_val2
string			ls_azione_pracq
long				ll_row, ll_val1, ll_scode, ll_iduc, ll_idvar
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


ll_idvalu=0
ll_temp=0

select "variazione"."id_listino" 
into 	 :ll_temp
from 	 "dba"."variazione" 
where  "variazione"."id_variazione" = :ll_idvar
;

if ll_temp>0 then

	select "listino"."id_valuta" 
	into 	 :ll_idvalu
	from 	 "dba"."listino" 
	where  "listino"."id_listino" = :ll_temp
	;

	if ll_idvalu>0 then
		istr_az.l_idvalu = ll_idvalu
	end if
	
end if

iw_wait.st_wait_b.text = "Preparazione statement SQL"

if (istr_az.s_crea = '2') then 
	ls_sql  = " INSERT INTO prezzo (id_unita_confezione, id_variazione, prezzo) "
	ls_sql += " SELECT prezzo.id_unita_confezione, " + string(ll_idvar) + ", prezzo.prezzo " 
	ls_sql += " FROM   unita_confezione, articolo, prezzo "
	ls_sql += " WHERE  prezzo.id_variazione = " + string(istr_az.l_idvar) 
	ls_sql += " AND    unita_confezione.id_unita_confezione = prezzo.id_unita_confezione "
	ls_sql += " AND    (unita_confezione.id_articolo = articolo.id_articolo) "	
	ls_sql += " AND    prezzo.id_unita_confezione NOT IN (SELECT id_unita_confezione FROM prezzo WHERE id_variazione = " + string(ll_idvar) + ")"
elseif (istr_az.s_crea = '1') then 
	ls_sql  = " INSERT INTO prezzo (id_unita_confezione, id_variazione, prezzo.prezzo) "
	ls_sql += " SELECT unita_confezione.id_unita_confezione, " + string(ll_idvar) + ", 0"
	ls_sql += " FROM	 unita_confezione, articolo "
	ls_sql += " WHERE  unita_confezione.id_articolo = articolo.id_articolo "
	ls_sql += " AND    unita_confezione.id_unita_confezione NOT IN (SELECT id_unita_confezione FROM prezzo WHERE id_variazione = " + string(ll_idvar) + ")"
end if

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
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	
	case '7'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '8'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
	case '9'
		if ls_val2 = 'S' then li_caso = 2 else li_caso = 1
		
END CHOOSE

if (istr_az.s_crea = '2') or (istr_az.s_crea = '1') then li_caso = 2 

choose case li_caso
	case 1
	case 2
		wf_crea_mancanti (ls_sql,ll_idvar)
	case 3
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
if (not isNull(ldc_p1)) and (not isNull(ldc_p2)) and (ldc_p1>=0) and (ldc_p2>0) then
	lstr_az = istr_az
	wf_calc_azione (lstr_az, tab_1.tabpage_2.dw_tabella, "prezzo_prezzo", "prezzo_prezzo")

	
	wf_taglia_prezzi(tab_1.tabpage_2.dw_tabella,ldc_p1,ldc_p2)
end if



return 0

end function

public function integer wf_check_sel ();


string		ls_errmsg, ls_1, ls_2
long			ll_row, ll_id1, ll_id2
decimal		ldc_1, ldc_2
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
	
	if (ls_1='2') or (ls_1='3') or ls_1='7' or ls_1='8'  then
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




EXECUTE IMMEDIATE :as_sql;

ll_scode = SQLCA.SQLCODE
if ll_scode=-1 then	
	messagebox("DBError", SQLCA.SQLERRTEXT)
	return -1
end if



return 0

end function

public function integer wf_calc_azione (s_azione_listino astr_az, datawindow adw_1, string as_nomein, string as_nomeout);

long			ll_row, ll_nrows
decimal		ldc_val, ld_perc_cif, ld_coef_cif
string		ls_tipo
long			ll_iduc1
long			ll_id_cif
long			ll_id_articolo
decimal		ld_costo_aggiuntivo
decimal		ld_cambio_cif,ld_cif,ld_perc
decimal 		ld_ult_costo 
long			ll_id_valuta	

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

ls_tipo 		 = astr_az.s_azione
ll_id_valuta = astr_az.l_idvalu	

for ll_row = 1 to ll_nrows
	ldc_val = adw_1.getItemNumber(ll_row,as_nomein)
	if isnull(ldc_val) then ldc_val = 0
	if not isNull (ldc_val) then
		ldc_val = adw_1.getItemDecimal(ll_row,as_nomein)
		
		choose case ls_tipo
			case '1'
				
			case '2'
				
				
				if (not isnull(astr_az.d_percento)) then 
					ldc_val = ldc_val * (1 + astr_az.d_percento/100.0)
				else
					ldc_val = ldc_val
				end if
				
			case '3'
				
				
				
				
				

				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if isNull (ll_iduc1) then ll_iduc1=0
				
				ll_id_articolo=adw_1.getItemNumber(ll_row,"id_articolo")
				SELECT fn_ultimo_costo(1, :ll_id_articolo, 0, YEAR(TODAY(*)), MONTH(TODAY(*)), :ll_id_valuta)
				INTO	 :ld_ult_costo
				FROM	 SYS.DUMMY, 
				;
				
				
				
				if ld_ult_costo > 0 then ldc_val = ld_ult_costo
				
				
				
				
				ldc_val		= ldc_val * (1 + astr_az.d_percento/100.0)
				

			case '4'
				
				
				if (not isnull(astr_az.d_importo)) then  
					ldc_val = ldc_val + astr_az.d_importo
				else
					ldc_val = ldc_val 
				end if
				
			case '5','6'
				
				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if not isNull(astr_az.l_idvar) then
					
					
					ldc_val = 0
					SELECT "prezzo"."prezzo"
					INTO   :ldc_val
					FROM	 "dba"."prezzo"
					WHERE  ("prezzo"."id_unita_confezione" = :ll_iduc1)
					AND	 ("prezzo"."id_variazione" = :astr_az.l_idvar)
					;
					
					
					
					if sqlca.sqlcode=0 and ldc_val > 0 then
						idc_cambio2=0
						
						SELECT	"valuta"."cambio"
						INTO		:idc_cambio2
						FROM		"dba"."listino", "dba"."valuta", "dba"."variazione"  
						WHERE		("valuta"."id_valuta" = "listino"."id_valuta") 
						AND		("variazione"."id_listino" = "listino"."id_listino") 
						AND		("variazione"."id_variazione" = :astr_az.l_idvar)
						USING SQLCA;
					
						if (idc_cambio1=0) or (idc_cambio2=0) then
							idc_cambio1 = 1
							idc_cambio2 = 1
						end if
							
						if ls_tipo='5' then
							
							if (not isnull(astr_az.d_percento)) then  
								ldc_val = ldc_val * (1 + astr_az.d_percento/100.0)
							else
								ldc_val = ldc_val
							end if
								
						else
							
							if (not isnull(astr_az.d_importo)) then	
								ldc_val = ldc_val + astr_az.d_importo
							else
								ldc_val = ldc_val 
							end if
	
						end if
							
							ldc_val = ldc_val * idc_cambio2 / idc_cambio1
							adw_1.setItem(ll_row,"cstato","S")
					else
						ldc_val = adw_1.GetItemNumber(ll_row,"prezzo_prezzo")
						adw_1.setItem(ll_row,"cstato","N")
					end if

				end if
			case '7'
				
				
				ll_iduc1 = adw_1.GetItemNumber(ll_row,"id_unita_confezione")
				if isNull (ll_iduc1) then ll_iduc1=0
				
				ll_id_articolo=adw_1.getItemNumber(ll_row,"id_articolo")
				
				SELECT fn_ultimo_costo(1, :ll_id_articolo, 0, YEAR(TODAY(*)), MONTH(TODAY(*)), :ll_id_valuta)
				INTO	 :ldc_val
				FROM	 SYS.DUMMY, 
				;					
				
				
				
				
				
				
				ll_id_cif = 0
				
				select articolo.id_cif
				into :ll_id_cif
				from articolo
				where id_articolo=:ll_id_articolo;
				
				
				if (ll_id_cif > 0) then
					
					select cambio, coefficiente
					into :ld_cambio_cif, :ld_coef_cif
					from cif
					where id_cif=:ll_id_cif;
	
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
					end if
				end if					
				select costo_aggiuntivo
				into :ld_costo_aggiuntivo
				from articolo
				where id_articolo=:ll_id_articolo;
				if ld_costo_aggiuntivo > 0 then
					ldc_val=ldc_val+ld_costo_aggiuntivo
					ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
				else
					ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
				end if
				if (ldc_val > 0 and ld_coef_cif > 0) then ldc_val=ldc_val*ld_coef_cif
			
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
						select costo_aggiuntivo
						into :ld_costo_aggiuntivo
						from articolo
						where id_articolo=:ll_id_articolo;
						if ld_costo_aggiuntivo > 0 then
							ldc_val=ldc_val+ld_costo_aggiuntivo
							ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
						else
							ldc_val=ldc_val*(1 + astr_az.d_percento/100.0)
						end if
						if ldc_val>0 then ldc_val=ldc_val*ld_coef_cif
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
				else
					ldc_val=-1
				end if
				
			case else
				
				ldc_val = -99
		end choose
		
		
		
		if IsNull(astr_az.d_prmin) then astr_az.d_prmin=0
		if (ldc_val<astr_az.d_prmin) then ldc_val = astr_az.d_prmin
		if (isNull(astr_az.d_arrot)) and (isNull(astr_az.s_tipoarr)) then
			
			f_cerca_arrotondamento(ldc_val,astr_az.l_idvalu,astr_az.d_arrot,astr_az.s_tipoarr)
		end if
		if (Not IsNull(astr_az.d_arrot)) and (astr_az.d_arrot>0) then
			ldc_val = f_arrotonda(ldc_val,astr_az.s_tipoarr,astr_az.d_arrot)
		end if
		adw_1.setItem(ll_row,as_nomeout,ldc_val)
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



ll_nrows = adw_1.rowcount()
if ll_nrows <=0 then
	return -1
end if
for ll_row = ll_nrows to 1 step -1
	ldc_p = adw_1.GetItemNumber(ll_row,"prezzo_prezzo")
	if not IsNull(ldc_p) then
		ldc_p = adw_1.GetItemDecimal(ll_row,"prezzo_prezzo")
	else
		ldc_p=0
	end if
	if (ldc_p<adc_p1) or (ldc_p>adc_p2) then
		adw_1.deleterow(ll_row)
	end if
next

return 0
end function

on w_listino_automatico_wz.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_esci=create cb_esci
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_esci
this.Control[iCurrent+3]=this.cb_salva
this.Control[iCurrent+4]=this.cb_inserisci
this.Control[iCurrent+5]=this.cb_cancella
end on

on w_listino_automatico_wz.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_esci)
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
end on

event open;call super::open;long					ll_row
DataWindowChild	dwc_drop
string				ls_sql

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

type tab_1 from tab within w_listino_automatico_wz
int X=23
int Y=120
int Width=2688
int Height=1660
int TabOrder=50
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
int X=18
int Y=104
int Width=2651
int Height=1540
long BackColor=79741120
string Text="Selezioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
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
int X=27
int Y=256
int Width=2615
int Height=1260
int TabOrder=10
string DataObject="d_sel_listino_2_wz"
end type

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_cat_codifica"
is_colonne_drop[2] = "id_cat_com_articolo"
is_colonne_drop[3] = "id_cat_merceologica"
is_colonne_drop[4] = "id_cat_fiscale"
is_colonne_drop[5] = "id_gruppo"
is_colonne_drop[6] = "id_old_lis"
is_colonne_drop[7] = "id_old_var"
is_colonne_drop[8] = "id_old_valuta"

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

event ue_use_search;call super::ue_use_search;

choose case as_nomecol
	case "cod_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_art1", is_ricpar.s_ausil_value[1])
		
		
		
		
	case "des_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_art1", is_ricpar.s_ausil_value[1])
		
		
		
		
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
			
			
		

      CASE 'cod_art1'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art1"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art1"
			ls_dbc[3] = "codice"
			ls_dwc[3] = "cod_art2"
			ls_dbc[4] = "descrizione"
			ls_dwc[4] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"codice", "A", data, & 
											ls_sql_cond, 4, &
											ls_dbc, ls_dbv, ls_dwc)
											
											
											
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE 'des_art1'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art1"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art1"
			ls_dbc[3] = "codice"
			ls_dwc[3] = "cod_art2"
			ls_dbc[4] = "descrizione"
			ls_dwc[4] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 4, &
											ls_dbc, ls_dbv, ls_dwc)
																			
							
							
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		


      CASE 'cod_art2'
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

	END CHOOSE
END IF

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

type dw_sel1 from u_dw_ext_main within tabpage_1
int X=27
int Y=16
int Width=2217
int Height=220
int TabOrder=5
string DataObject="d_sel_listino_1_wz"
end type

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_listino"
is_colonne_drop[2] = "id_variazione"
is_colonne_drop[3] = "id_valuta"

end event

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

type cb_procedi from commandbutton within tabpage_1
int X=2267
int Y=76
int Width=283
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Procedi..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

	
	tab_1.tabpage_2.dw_tabella.reset()
	li_val1 = wf_check_sel()
	if li_val1 = 0 then
		wf_selez_uc()
		cb_cancella.enabled = true
		cb_inserisci.enabled = true
		cb_salva.enabled = true
		
		ii_dwi = 3
		wf_dwsetfocus()
	end if
	close (iw_wait)
	
	
	

end if

end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2651
int Height=1540
long BackColor=79741120
string Text="Risultati"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
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
int X=27
int Y=36
int Width=2592
int Height=1480
int TabOrder=2
string DataObject="d_listino_aut_risult_gd"
boolean HScrollBar=true
boolean VScrollBar=true
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

type cb_esci from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
int X=23
int Y=20
int Width=283
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)
end event

type cb_salva from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
int X=2345
int Y=20
int Width=283
int Height=84
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer li_ret
li_ret = tab_1.tabpage_2.dw_tabella.update()

if (li_ret = -1) then
	messagebox("", "Errore nel salvataggio dei dati ...")
end if
end event

type cb_inserisci from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
int X=1691
int Y=20
int Width=283
int Height=84
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_insert")

end event

type cb_cancella from commandbutton within w_listino_automatico_wz
event clicked pbm_bnclicked
int X=2011
int Y=20
int Width=283
int Height=84
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_delete")

end event

