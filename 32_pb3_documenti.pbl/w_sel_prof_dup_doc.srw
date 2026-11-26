forward
global type w_sel_prof_dup_doc from Window
end type
type dw_1 from u_dw_ext_main within w_sel_prof_dup_doc
end type
end forward

global type w_sel_prof_dup_doc from Window
int X=1051
int Y=480
int Width=1573
int Height=228
boolean TitleBar=true
string Title="Selezione Profilo Documento"
long BackColor=79211420
boolean ControlMenu=true
WindowType WindowType=response!
dw_1 dw_1
end type
global w_sel_prof_dup_doc w_sel_prof_dup_doc

type variables
long il_id_esercizio
end variables

on w_sel_prof_dup_doc.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_sel_prof_dup_doc.destroy
destroy(this.dw_1)
end on

event close;long ll_id_prof_doc, ll_id_registro, ll_id_caus_mag, ll_id_mod_reg
str_dup_doc str

ll_id_prof_doc = dw_1.getitemnumber(dw_1.getrow(),"id_prof_doc")
if isnull(ll_id_prof_doc) then ll_id_prof_doc = 0

select id_mod_registro_prop, id_caus_magazzino_prop
into :ll_id_mod_reg, :ll_id_caus_mag
from prof_documento
where id_prof_documento = :ll_id_prof_doc;
if isnull(ll_id_caus_mag) then ll_id_caus_mag = 0

select id_registro
into :ll_id_registro
from registro
where id_mod_registro = :ll_id_mod_reg
and id_esercizio = :il_id_esercizio;
if isnull(ll_id_registro) then ll_id_registro = 0

str.id_prof_doc = ll_id_prof_doc
str.id_registro = ll_id_registro
str.id_caus_mag = ll_id_caus_mag

closewithreturn(this,str)

end event

event open;
dw_1.settransobject(sqlca)
dw_1.insertrow(0)

il_id_esercizio = message.doubleparm
end event

type dw_1 from u_dw_ext_main within w_sel_prof_dup_doc
int X=37
int Y=24
int Width=1477
int Height=104
int TabOrder=10
string DataObject="d_dup_doc_prof"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

