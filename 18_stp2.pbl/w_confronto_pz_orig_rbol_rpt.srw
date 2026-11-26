forward
global type w_confronto_pz_orig_rbol_rpt from w_stampa
end type
end forward

global type w_confronto_pz_orig_rbol_rpt from w_stampa
integer width = 4923
integer height = 1860
end type
global w_confronto_pz_orig_rbol_rpt w_confronto_pz_orig_rbol_rpt

type variables
s_param_articoli s_par
end variables

on w_confronto_pz_orig_rbol_rpt.create
call super::create
end on

on w_confronto_pz_orig_rbol_rpt.destroy
call super::destroy
end on

event open;call super::open;dw_1.settransobject(sqlca)



s_par=message.powerobjectparm

dw_1.dataobject=s_par.tipo_stampa
dw_1.settransobject(sqlca)

dw_1.retrieve(s_par.da_data, s_par.a_data)
end event

type pb_1 from w_stampa`pb_1 within w_confronto_pz_orig_rbol_rpt
end type

type cb_preview from w_stampa`cb_preview within w_confronto_pz_orig_rbol_rpt
end type

type dw_1 from w_stampa`dw_1 within w_confronto_pz_orig_rbol_rpt
integer width = 4809
string dataobject = "d_pz_originali_rbol"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
long ll_len

ls_sql=sqlsyntax
	
if s_par.da_sog_comm>" " then
	ll_len=len(s_par.da_sog_comm)
	if ll_len=3 then
		ls_sql+=" and left(documento.num_documento, 3) ='"+string(s_par.da_sog_comm)+"' "
	elseif ll_len=4 then
		ls_sql+=" and left(documento.num_documento, 4) ='"+string(s_par.da_sog_comm)+"' "
	end if
end if
if s_par.ll_magazzino>0 then
	ls_sql+=" and riga_documento_a.id_articolo ="+string(s_par.ll_magazzino)+" "
end if
if ls_sql> sqlsyntax then
	setsqlpreview(ls_sql)
end if

end event

event dw_1::doubleclicked;call super::doubleclicked;long ll_id_doc

w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if

end event

event dw_1::clicked;call super::clicked;string ls_colonna
if string(dwo.type)="text" then
	ls_colonna=left(dwo.name, len(string(dwo.name)) - 2)
	dw_1.setsort(ls_colonna)
	dw_1.sort()
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_confronto_pz_orig_rbol_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_confronto_pz_orig_rbol_rpt
end type

type sle_pg from w_stampa`sle_pg within w_confronto_pz_orig_rbol_rpt
end type

type st_1 from w_stampa`st_1 within w_confronto_pz_orig_rbol_rpt
end type

type st_2 from w_stampa`st_2 within w_confronto_pz_orig_rbol_rpt
end type

type sle_copie from w_stampa`sle_copie within w_confronto_pz_orig_rbol_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_confronto_pz_orig_rbol_rpt
end type

type cb_7 from w_stampa`cb_7 within w_confronto_pz_orig_rbol_rpt
end type

type cb_6 from w_stampa`cb_6 within w_confronto_pz_orig_rbol_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_confronto_pz_orig_rbol_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_confronto_pz_orig_rbol_rpt
end type

type cb_esci from w_stampa`cb_esci within w_confronto_pz_orig_rbol_rpt
end type

