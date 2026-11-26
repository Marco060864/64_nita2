forward
global type w_rbol_non_derivati from w_stampa
end type
type cbx_solo_imp from checkbox within w_rbol_non_derivati
end type
end forward

global type w_rbol_non_derivati from w_stampa
integer width = 3561
cbx_solo_imp cbx_solo_imp
end type
global w_rbol_non_derivati w_rbol_non_derivati

type variables
s_param_articoli s_par
end variables

on w_rbol_non_derivati.create
int iCurrent
call super::create
this.cbx_solo_imp=create cbx_solo_imp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_solo_imp
end on

on w_rbol_non_derivati.destroy
call super::destroy
destroy(this.cbx_solo_imp)
end on

event open;call super::open;




s_par=message.powerobjectparm



dw_1.settransobject(sqlca)

dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_rbol_non_derivati
integer x = 2903
end type

type cb_preview from w_stampa`cb_preview within w_rbol_non_derivati
integer x = 2299
end type

type dw_1 from w_stampa`dw_1 within w_rbol_non_derivati
integer width = 3429
string dataobject = "d_righe_rbol_non_derivate"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql

ls_sql=sqlsyntax

ls_sql+=" and documento.data_documento>= "+string(s_par.da_data, "yyyymmdd")+ " and documento.data_documento<="+string(s_par.a_data,"yyyymmdd")
if s_par.ll_magazzino>0 then
	ls_sql+=" and documento.id_prof_documento="+ string( s_par.ll_magazzino)+" "
end if

setsqlpreview(ls_sql)


end event

event dw_1::doubleclicked;//
long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "documento_id_documento")

if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_rbol_non_derivati
integer x = 2706
end type

type pb_stampa from w_stampa`pb_stampa within w_rbol_non_derivati
integer x = 2496
end type

type sle_pg from w_stampa`sle_pg within w_rbol_non_derivati
integer x = 1298
end type

type st_1 from w_stampa`st_1 within w_rbol_non_derivati
integer x = 1019
end type

type st_2 from w_stampa`st_2 within w_rbol_non_derivati
end type

type sle_copie from w_stampa`sle_copie within w_rbol_non_derivati
end type

type sle_zoom from w_stampa`sle_zoom within w_rbol_non_derivati
end type

type cb_7 from w_stampa`cb_7 within w_rbol_non_derivati
end type

type cb_6 from w_stampa`cb_6 within w_rbol_non_derivati
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_rbol_non_derivati
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_rbol_non_derivati
end type

type cb_esci from w_stampa`cb_esci within w_rbol_non_derivati
integer x = 3205
end type

type cbx_solo_imp from checkbox within w_rbol_non_derivati
integer x = 1650
integer y = 44
integer width = 617
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Imp.>0"
end type

event clicked;string ls_filter

if checked then
	dw_1.setfilter(" tot_riga_val_riga>0")
else
	dw_1.setfilter("")
end if

dw_1.filter()
end event

