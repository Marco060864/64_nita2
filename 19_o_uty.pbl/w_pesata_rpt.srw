forward
global type w_pesata_rpt from w_stampa
end type
type cbx_1 from checkbox within w_pesata_rpt
end type
end forward

global type w_pesata_rpt from w_stampa
integer width = 5294
integer height = 1728
cbx_1 cbx_1
end type
global w_pesata_rpt w_pesata_rpt

type variables
string is_data_filtro
integer ii_da_prog, ii_a_prog
long il_id_operatore
end variables

on w_pesata_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_pesata_rpt.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;s_array s_dati

dw_1.settransobject(sqlca)
s_dati=message.powerobjectparm


is_data_filtro=s_dati.as_string[1]
ii_da_prog=s_dati.li_anno[1]
ii_a_prog=s_dati.li_anno[2]
il_id_operatore=s_dati.ll_id_doc[1]


dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_pesata_rpt
end type

type cb_preview from w_stampa`cb_preview within w_pesata_rpt
end type

type dw_1 from w_stampa`dw_1 within w_pesata_rpt
integer width = 5111
string dataobject = "d_pesata_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;date ldt_data_filtro
string ls_data,ls_sql
integer i

ls_sql=sqlsyntax
if request = PreviewFunctionRetrieve! then
	
	if is_data_filtro>" " then
		ldt_data_filtro=date(is_data_filtro)
		ls_data= string(ldt_data_filtro, "yyyy-mm-dd")
		ls_sql+=" where pesata.data='" +ls_data+"' "
		//ls_sql=sqlsyntax + ls_sql
	end if
		
	if ii_da_prog>0 then
		if pos(ls_sql, "where") >0 then
			ls_sql+=" and pesata.num_progressivo>=" +string(ii_da_prog)
		else
			ls_sql+=" where pesata.num_progressivo>=" +string(ii_da_prog)
		end if
	end if
	if ii_a_prog>0 then
		if pos(ls_sql, "where") >0 then
			ls_sql+=" and pesata.num_progressivo<=" +string(ii_a_prog)
		else
			ls_sql+=" where pesata.num_progressivo<=" +string(ii_a_prog)
		end if
	end if
	if is_data_filtro>" "  or ii_da_prog>0 then
		i=SetSQLPreview(ls_sql)
		if i<>1 then
			messagebox("Errore!", "Filtro data non applicato!")
		end if
	end if
	
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_pesata_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_pesata_rpt
end type

type sle_pg from w_stampa`sle_pg within w_pesata_rpt
end type

type st_1 from w_stampa`st_1 within w_pesata_rpt
end type

type st_2 from w_stampa`st_2 within w_pesata_rpt
end type

type sle_copie from w_stampa`sle_copie within w_pesata_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_pesata_rpt
end type

type cb_7 from w_stampa`cb_7 within w_pesata_rpt
end type

type cb_6 from w_stampa`cb_6 within w_pesata_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_pesata_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_pesata_rpt
end type

type cb_esci from w_stampa`cb_esci within w_pesata_rpt
end type

type cbx_1 from checkbox within w_pesata_rpt
integer x = 4645
integer y = 84
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lista Cieca"
end type

event clicked;//vpeso lordo=0, tara=0 operatore=0, num_doc=0
integer i

for i= 1 to dw_1.rowcount()
	dw_1.setitem(i, "peso_lordo", 0)
	dw_1.setitem(i, "tara", 0)
	dw_1.setitem(i, "num_documento", "0")
	dw_1.setitem(i, "id_operatore", 0)
next
end event

