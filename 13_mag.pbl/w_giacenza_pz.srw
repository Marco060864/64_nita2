forward
global type w_giacenza_pz from w_001
end type
type dw_1 from datawindow within w_giacenza_pz
end type
end forward

global type w_giacenza_pz from w_001
integer x = 1349
integer y = 1752
integer width = 905
integer height = 284
boolean titlebar = false
boolean controlmenu = false
event ue_postopen ( )
dw_1 dw_1
end type
global w_giacenza_pz w_giacenza_pz

type variables
long il_esercizio
string is_bollo
end variables

forward prototypes
public subroutine w_leggi_saldo (long al_id_art)
end prototypes

public subroutine w_leggi_saldo (long al_id_art);date ld_a_data, ld_da_data=date("1900-01-02")
date ld_data_in_esercizio
string ls_filtro, ls_cod_sog, ls_saldi_in_esercizio, ls_bollo
long ll_id_doc, ll_id_art, ll_riga,ll_id_sog, ll_id_ese
decimal ldc_saldo
integer i
w_orafo_documento_ordine_cx w_doc
w_orafo_ordini_cx w_ord
if al_id_art>0 then
	w_doc = this.parentwindow()
	ll_riga=w_doc.idw_riga.getrow()
	if ll_riga>0 then
		//ll_id_art=w_doc.idw_riga.getitemNUMBER(ll_riga, "riga_documento_id_articolo")
		ld_a_data=w_doc.idw_gen.getitemdate(1, "data_documento")
		//if isnull(ld_a_data) then ld_a_data=date('2100-01-01')
		
		//ls_filtro="Sog. Commerciale: "+ls_cod_sog
		//correzione da correggere ;-))))
		
		//ld_data_in_esercizio=ld_da_data
		select data_calc_saldi
		into :ld_data_in_esercizio
		from dba.orafo_par_sistema
		;
		if isnull(ld_data_in_esercizio) then
				select data_Inizio
				into :ld_data_in_esercizio
				from esercizio
				where data_inizio<= :ld_a_data
				and data_fine>= :ld_a_data;
		end if
		dw_1.retrieve(ld_data_in_esercizio,ld_a_data, al_id_art)
		
		
	end if
elseif al_id_art=0 then
	return
else
	w_ord=this.parentwindow()
	ll_riga=w_ord.tab_1.tabpage_3.dw_righe_gruppo.getrow()
	if ll_riga>0 then
		al_id_art=w_ord.tab_1.tabpage_3.dw_righe_gruppo.getitemnumber(ll_riga,"id_articolo")
		ll_id_doc=w_ord.tab_1.tabpage_3.dw_righe_gruppo.getitemnumber(ll_riga,"id_documento")
		//130612 gestione bollo
		is_bollo=w_ord.tab_1.tabpage_3.dw_righe_gruppo.getitemstring(ll_riga,"sigla_prezzo")
		//lo uso nel setsqlpreview per filtrare per bollo
		//fine 130612
		//ll_id_sog=w_ord.tab_1.tabpage_1.dw_testa.getitemNUMBER(, "ID_SOG_COMMERCIALE")
		select d.data_documento, r.id_esercizio
		into :ld_a_data, :ll_id_ese
		from dba.documento d, dba.registro r
		where id_documento=:ll_id_doc
		AND d.id_registro=r.id_registro
		;
		
		select data_calc_saldi
		into :ld_data_in_esercizio
		from dba.orafo_par_sistema
		;
		if isnull(ld_data_in_esercizio) then
			select data_Inizio
			into :ld_data_in_esercizio
			from esercizio
			where id_esercizio=:ll_id_ese;
		end if
		ld_a_data=date(today())
		dw_1.retrieve(ld_data_in_esercizio,ld_a_data, al_id_art)
		
		
	end if
end if
end subroutine

on w_giacenza_pz.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_giacenza_pz.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;long ll_id_art
string LS_azienda

ll_id_art=message.doubleparm

select codice 
into :LS_azienda
from dba.azienda
;
if ls_azienda="VENER" then
	dw_1.dataobject="d_orafo_giacenza_peso_articolo"
	
	
end if

dw_1.settransobject(sqlca)
 
post w_leggi_saldo(ll_id_art)
end event

type st_1 from w_001`st_1 within w_giacenza_pz
integer x = 242
integer y = 320
integer width = 859
integer height = 64
boolean bringtotop = true
integer weight = 700
long textcolor = 16777215
long backcolor = 8388608
string text = "  Saldo Documento"
boolean border = false
end type

type dw_1 from datawindow within w_giacenza_pz
integer width = 869
integer height = 256
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_orafo_giacenza_articolo"
borderstyle borderstyle = stylelowered!
end type

event scrollvertical;

end event

event sqlpreview;date ldt_data_inizio
string ls_sql
integer i

if il_esercizio>0 then
	select data_inizio
	into :ldt_data_inizio
	from esercizio
	where id_esercizio=:il_esercizio;
	if ls_sql="" then ls_sql=sqlsyntax
	ls_sql+=" and (documento.data_documento>='"+string(ldt_data_inizio, "yyyy/mm/dd")+"')"
	i=SetSQLPreview(ls_sql)
end if
if is_bollo>"" then
	
	if ls_sql="" then ls_sql=sqlsyntax
	ls_sql+=" and (riga_documento.sigla_prezzo='"+string(is_bollo)+"')"
	i=SetSQLPreview(ls_sql)
end if
end event

