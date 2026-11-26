forward
global type w_partita_a_pz from w_001
end type
type dw_1 from datawindow within w_partita_a_pz
end type
end forward

global type w_partita_a_pz from w_001
boolean visible = false
integer x = 2222
integer y = 1752
integer width = 919
integer height = 200
boolean titlebar = false
boolean controlmenu = false
event ue_postopen ( )
dw_1 dw_1
end type
global w_partita_a_pz w_partita_a_pz

type variables
long il_esercizio
end variables

forward prototypes
public subroutine w_leggi_saldo (long al_id_art)
end prototypes

public subroutine w_leggi_saldo (long al_id_art);date ld_a_data, ld_da_data=date("1900-01-02")
date ld_data_in_esercizio
string ls_filtro, ls_cod_sog, ls_saldi_in_esercizio
long ll_id_doc, ll_id_art, ll_riga,ll_id_sog
decimal ldc_saldo
integer i
w_orafo_documento_ordine_cx w_doc
w_orafo_ordini_cx w_ord
w_doc = this.parentwindow()
ll_id_sog=w_doc.idw_gen.getitemNUMBER(1, "ID_SOG_COMMERCIALE")
if al_id_art>0 then
	
	ll_riga=w_doc.idw_riga.getrow()
	if ll_riga>0 then
		//ll_id_art=w_doc.idw_riga.getitemNUMBER(ll_riga, "riga_documento_id_articolo")
		ld_a_data=w_doc.idw_gen.getitemdate(1, "data_documento")
		//if isnull(ld_a_data) then ld_a_data=date('2100-01-01')
		
		//ls_filtro="Sog. Commerciale: "+ls_cod_sog
		//correzione da correggere ;-))))
		
//		ld_data_in_esercizio=ld_da_data
//		select data_Inizio
//			into :ld_data_in_esercizio
//			from esercizio
//			where data_inizio<= :ld_a_data
//			and data_fine>= :ld_a_data;
//correzione corretta
		select data_Calc_saldi
		into :ld_data_in_esercizio
		from dba.orafo_par_sistema;
		if isnull(ld_data_in_esercizio) then ld_data_in_esercizio=date('2000-01-01')
		dw_1.retrieve(ld_data_in_esercizio,ld_a_data, al_id_art, ll_id_sog)
		
		
	end if
else
	dw_1.reset()
end if
end subroutine

on w_partita_a_pz.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_partita_a_pz.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;long ll_id_art

ll_id_art=message.doubleparm

dw_1.settransobject(sqlca)
 
post w_leggi_saldo(ll_id_art)
end event

type st_1 from w_001`st_1 within w_partita_a_pz
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

type dw_1 from datawindow within w_partita_a_pz
integer x = 5
integer width = 850
integer height = 184
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_orafo_giacenza_art_2"
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
end event

