forward
global type w_saldo_doc_pop from w_001
end type
type dw_1 from datawindow within w_saldo_doc_pop
end type
type dw_2 from datawindow within w_saldo_doc_pop
end type
end forward

global type w_saldo_doc_pop from w_001
integer x = 1200
integer y = 1812
integer width = 1106
integer height = 240
boolean titlebar = false
boolean controlmenu = false
event ue_postopen ( )
dw_1 dw_1
dw_2 dw_2
end type
global w_saldo_doc_pop w_saldo_doc_pop

type variables
long il_esercizio
end variables

forward prototypes
public subroutine w_leggi_saldo ()
end prototypes

public subroutine w_leggi_saldo ();date ld_a_data, ld_da_data=date("1900-01-02")
date ld_data_in_esercizio, ldt_da_data_saldi
string ls_filtro, ls_cod_sog, ls_saldi_in_esercizio
long ll_id_doc, ll_id_sog
decimal ldc_saldo
integer i
w_orafo_documento_ordine_cx w_doc

w_doc = this.parentwindow()
ll_id_doc=w_doc.idw_gen.getitemnumber(1, "id_documento")
ll_id_sog=w_doc.idw_gen.getitemNUMBER(1, "ID_SOG_COMMERCIALE")
ld_a_data=w_doc.idw_gen.getitemdate(1, "data_documento")
//if isnull(ld_a_data) then ld_a_data=date('2100-01-01')

//ls_filtro="Sog. Commerciale: "+ls_cod_sog
//190213 reucpero la data inizio saldi dai parametri di sistema
select data_calc_saldi
into :ldt_da_data_saldi
from orafo_par_sistema
;
if ldt_da_data_saldi> date("2000-01-01") then
	ld_data_in_esercizio=ldt_da_data_saldi
else
	ld_data_in_esercizio=ld_da_data
	select saldi_in_esercizio
	into :ls_saldi_in_esercizio
	from orafo_par_sistema
	;
	if ls_saldi_in_esercizio='S' then
		select data_Inizio
		into :ld_data_in_esercizio
		from esercizio
		where data_inizio<= :ld_a_data
		and data_fine>= :ld_a_data;
		if isnull(ld_data_in_esercizio) then ld_data_in_esercizio=ld_da_data
	end if
end if
dw_1.retrieve(ll_id_sog, ld_a_data, ld_data_in_esercizio )

dw_2.retrieve(ll_id_doc)

end subroutine

on w_saldo_doc_pop.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_saldo_doc_pop.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
post w_leggi_saldo()
end event

type st_1 from w_001`st_1 within w_saldo_doc_pop
integer x = 247
integer y = 236
integer width = 859
integer height = 64
boolean bringtotop = true
integer weight = 700
long textcolor = 16777215
long backcolor = 8388608
string text = "  Saldo Documento"
boolean border = false
end type

type dw_1 from datawindow within w_saldo_doc_pop
integer x = 5
integer y = 4
integer width = 1065
integer height = 212
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_orafo_riga_pop"
boolean vscrollbar = true
boolean livescroll = true
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

type dw_2 from datawindow within w_saldo_doc_pop
integer x = 1458
integer width = 1435
integer height = 140
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_orafo_doc_pop"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

