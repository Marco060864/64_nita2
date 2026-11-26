forward
global type w_prezzo_documento_gd from w_np_single_data
end type
end forward

global type w_prezzo_documento_gd from w_np_single_data
int Width=1687
int Height=844
boolean TitleBar=true
string Title="Varia Prezzo Documento"
end type
global w_prezzo_documento_gd w_prezzo_documento_gd

type variables
long Il_id_doc
end variables

on w_prezzo_documento_gd.create
call super::create
end on

on w_prezzo_documento_gd.destroy
call super::destroy
end on

event open;
integer li_ret, ll_righe
datastore ds_prof_prezzo
long ll_id_prof_doc

idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"

this.y = 100
Il_id_doc=message.doubleparm
ll_righe=dw_single.Retrieve(Il_id_doc)
if ll_righe<=0 then
	
	ds_prof_prezzo=create datastore
	ds_prof_prezzo.dataobject="d_trova_id_prof_doc_ds"
	ds_prof_prezzo.settransobject(sqlca)
	ds_prof_prezzo.retrieve(Il_id_doc)
	ll_id_prof_doc=ds_prof_prezzo.getitemnumber(1,"id_prof_documento")
	
	ds_prof_prezzo.dataobject="d_prof_prezzo_documento_ds"
	ds_prof_prezzo.settransobject(sqlca)
	ll_righe=ds_prof_prezzo.retrieve(ll_id_prof_doc)
	if ll_righe>0 then
		li_ret=ds_prof_prezzo.rowscopy(1, ll_righe, primary!, dw_single, 1, primary!)
		for li_ret= 1 to ll_righe
			dw_single.setitem(li_ret, "id_documento", Il_id_doc)
		next
	end if
	destroy ds_prof_prezzo
end if
end event

type p_crescente from w_np_single_data`p_crescente within w_prezzo_documento_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_prezzo_documento_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_prezzo_documento_gd
int X=14
int Y=28
int Width=1600
string DataObject="d_prezzo_documento"
end type

event dw_single::ue_initial;call super::ue_initial;long ll_id_val, ll_row

ll_row=getrow()
setitem(ll_row, 'id_documento',Il_id_doc)
select id_valuta
into :ll_id_val
from documento
where id_documento=:Il_id_doc;
setitem(ll_row, 'id_valuta',ll_id_val)


end event

