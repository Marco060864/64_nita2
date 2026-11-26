forward
global type uo_cpt_sconti from nonvisualobject
end type
end forward

global type uo_cpt_sconti from nonvisualobject
end type
global uo_cpt_sconti uo_cpt_sconti

forward prototypes
public function long uf_cpt_sconti (string as_sc_finanziario, decimal adc_sc_incondizionato, decimal adc_sc_fin_cassa, string as_sconto, decimal adc_sconto_merce, decimal adc_sconto_riga, decimal adc_sconto_unit_riga, long al_id_sog_commerciale, long al_id_articolo)
end prototypes

public function long uf_cpt_sconti (string as_sc_finanziario, decimal adc_sc_incondizionato, decimal adc_sc_fin_cassa, string as_sconto, decimal adc_sconto_merce, decimal adc_sconto_riga, decimal adc_sconto_unit_riga, long al_id_sog_commerciale, long al_id_articolo);string ls_tipo_sconto, ls_tipo_sconto_2, ls_app
long ll_id_cpt, ll_id_cpt_om, ll_id_cat_com_sc, ll_id_cc_art
integer li_ret

setnull(ll_id_cpt_om)


if isnull(as_sc_finanziario) then as_sc_finanziario = ""
if isnull(adc_sc_incondizionato) then adc_sc_incondizionato = 0
if isnull(adc_sc_fin_cassa) then adc_sc_fin_cassa = 0
if as_sc_finanziario = "" and adc_sc_incondizionato = 0 and adc_sc_fin_cassa = 0 then 
	ls_app = "ST"
else
	ls_app = ""
end if


select id_cat_com_sc
into :ll_id_cat_com_sc
from sog_commerciale
where sog_commerciale.id_sog_commerciale = :al_id_sog_commerciale;

select id_cat_com_articolo
into :ll_id_cc_art
from articolo
where id_articolo = :al_id_articolo;

 declare cur_cpt cursor for 
   select id_conto, descrizione
   from con_cpt_sconti
   where(con_cpt_sconti.id_sog_com= :al_id_sog_commerciale or con_cpt_sconti.id_sog_com is null)
   and(con_cpt_sconti.id_cat_com_sc= :ll_id_cat_com_sc or con_cpt_sconti.id_cat_com_sc is null)
	
	
   and(con_cpt_sconti.id_articolo= :al_id_articolo or con_cpt_sconti.id_articolo is null)			
   and(con_cpt_sconti.id_cat_com_art= :ll_id_cc_art or con_cpt_sconti.id_cat_com_art is null)	
	
	
	and con_cpt_sconti.descrizione <> :ls_app
	
	order by con_cpt_sconti.priorita asc;

   open cur_cpt;
	
	DO WHILE SQLCA.SQLCODE = 0
  		fetch cur_cpt 
		into :ll_id_cpt, :ls_tipo_sconto;
		
		if ls_tipo_Sconto = "OM" then ll_id_cpt_om = ll_id_cpt
	loop
	
   close cur_cpt;
	
ls_tipo_sconto = trim(ls_tipo_Sconto)
if as_Sconto = "100" and isnull(ll_id_cpt_om) = false then 
	ls_tipo_sconto = "OM"
	ll_id_cpt = ll_id_cpt_om
end if

if not isnull(as_sc_finanziario) and as_sc_finanziario <> "" and as_sc_finanziario <> "0" then 
	ls_tipo_sconto_2 = ls_tipo_sconto_2 + "ST"
elseif not isnull(adc_sc_incondizionato) and adc_sc_incondizionato <> 0 then
	ls_tipo_sconto_2 = ls_tipo_sconto_2 + "ST"
elseif not isnull(adc_sc_fin_cassa) and adc_sc_fin_cassa <> 0 then
	ls_tipo_sconto_2 = ls_tipo_sconto_2 + "ST"		
end if

if not isnull(as_sconto) and as_sconto <> "" and as_sconto <> "0" then 
	if as_sconto = "100" then
		ls_tipo_sconto_2 = ls_tipo_sconto_2 + "OM"
	else 
		ls_tipo_sconto_2 = ls_tipo_sconto_2 + "SG"
	end if
end if

if not isnull(adc_sconto_merce) and adc_sconto_merce <> 0 then 
	ls_tipo_sconto_2 = ls_tipo_sconto_2 + "SR"
elseif not isnull(adc_sconto_riga) and adc_sconto_riga <> 0 then
	ls_tipo_sconto_2 = ls_tipo_sconto_2 + "SR"
end if 

if not isnull(adc_sconto_unit_riga) and adc_sconto_unit_riga <> 0 then ls_tipo_sconto_2 = ls_tipo_sconto_2 + "SI"

li_ret = Pos(ls_tipo_sconto_2, ls_tipo_sconto)
if li_ret = 0 then setnull(ll_id_cpt)

return ll_id_cpt
end function

on uo_cpt_sconti.create
TriggerEvent( this, "constructor" )
end on

on uo_cpt_sconti.destroy
TriggerEvent( this, "destructor" )
end on

