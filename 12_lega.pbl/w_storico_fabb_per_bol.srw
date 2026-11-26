forward
global type w_storico_fabb_per_bol from w_stampa
end type
type dw_3 from udw_base within w_storico_fabb_per_bol
end type
end forward

global type w_storico_fabb_per_bol from w_stampa
dw_3 dw_3
end type
global w_storico_fabb_per_bol w_storico_fabb_per_bol

type variables
string is_num_doc
end variables

on w_storico_fabb_per_bol.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_storico_fabb_per_bol.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
end event

type pb_1 from w_stampa`pb_1 within w_storico_fabb_per_bol
integer x = 2258
end type

type cb_preview from w_stampa`cb_preview within w_storico_fabb_per_bol
integer x = 1655
end type

type dw_1 from w_stampa`dw_1 within w_storico_fabb_per_bol
string dataobject = "d_storico_fabb_per_bol"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer li_pos
long ll_id_riga_bol

ls_sql=sqlsyntax
if is_num_doc>" " then
	is_num_doc=right(is_num_doc, 5)
	select id_riga_documento
	into :ll_id_riga_bol
	from dba.documento d, dba.riga_documento r
	where d.id_documento=r.id_documento
	and num_documento like '%'+:is_num_doc
	;
	
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1)+" and fabbisogno_accessori_k.id_riga_bol_provenienza =" +string(ll_id_riga_bol)+" "+right(ls_sql, len(ls_sql) - li_pos + 1)
	li_pos=setsqlpreview(ls_sql)
	if li_pos<>1 then messagebox("A", "A")
//	
end if
//
//if s_par.da_sog_comm> " " then
//	if left(s_par.da_sog_comm, 1)="-" then
//		ls_sql+=" and documento.num_documento like '%"+right(s_par.da_sog_comm, 5)+"' "
//	else
//		ls_sql+=" and documento.num_documento like '"+s_par.da_sog_comm+"%' "
//	end if
//end if
//
//if s_par.id_variazione>0 then
//	ls_sql+=" and documento.id_prof_documento="+string(s_par.id_variazione)+" "
//	
//end if
//if s_par.id_cat_codifica> 0 then
//	ls_sql+=" and documento.num_progressivo="+string(s_par.id_cat_codifica)+" "
//end if
//
//

end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_storico_fabb_per_bol
integer x = 2062
end type

type pb_stampa from w_stampa`pb_stampa within w_storico_fabb_per_bol
integer x = 1851
end type

type sle_pg from w_stampa`sle_pg within w_storico_fabb_per_bol
integer x = 1312
end type

type st_1 from w_stampa`st_1 within w_storico_fabb_per_bol
integer x = 1033
end type

type st_2 from w_stampa`st_2 within w_storico_fabb_per_bol
end type

type sle_copie from w_stampa`sle_copie within w_storico_fabb_per_bol
end type

type sle_zoom from w_stampa`sle_zoom within w_storico_fabb_per_bol
end type

type cb_7 from w_stampa`cb_7 within w_storico_fabb_per_bol
end type

type cb_6 from w_stampa`cb_6 within w_storico_fabb_per_bol
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_storico_fabb_per_bol
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_storico_fabb_per_bol
end type

type cb_esci from w_stampa`cb_esci within w_storico_fabb_per_bol
end type

type dw_3 from udw_base within w_storico_fabb_per_bol
integer x = 2464
integer y = 4
integer width = 896
integer height = 168
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ins_barcode_plurimo_ext"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;
if dwo.name="cod_barre"  then
	if len(data)=7   then
	
		is_num_doc=mid(data, 3, 5)
		dw_1.retrieve()
	
		
	end if
end if


end event

