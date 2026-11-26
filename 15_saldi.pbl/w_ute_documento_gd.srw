forward
global type w_ute_documento_gd from w_stampa_001
end type
type dw_2 from udw_001 within w_ute_documento_gd
end type
end forward

global type w_ute_documento_gd from w_stampa_001
integer width = 3616
string title = "Controlla Documenti Magazzino"
dw_2 dw_2
end type
global w_ute_documento_gd w_ute_documento_gd

type variables
string as_ultimo_ordinamento
end variables

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()


dw_2.settransobject(sqlca)
dw_2.insertrow(1)

end event

on w_ute_documento_gd.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ute_documento_gd.destroy
call super::destroy
destroy(this.dw_2)
end on

type dw_1 from w_stampa_001`dw_1 within w_ute_documento_gd
integer taborder = 60
string dataobject = "d_ute_doc_tb"
end type

event dw_1::doubleclicked;call super::doubleclicked;string ls_colonna

if dwo.type="text" then
	ls_colonna=left(dwo.name, len(string(dwo.name)) -2)
	if as_ultimo_ordinamento='A' then
		as_ultimo_ordinamento='D'
	else
		as_ultimo_ordinamento='A'
	end if
	dw_1.setsort(ls_colonna+" , "+as_ultimo_ordinamento)
	dw_1.sort()
end if

end event

type sle_pg from w_stampa_001`sle_pg within w_ute_documento_gd
integer x = 1221
integer width = 229
integer taborder = 80
end type

type st_1 from w_stampa_001`st_1 within w_ute_documento_gd
integer x = 955
end type

type st_2 from w_stampa_001`st_2 within w_ute_documento_gd
integer x = 2144
end type

type sle_copie from w_stampa_001`sle_copie within w_ute_documento_gd
integer x = 2290
integer taborder = 90
end type

type sle_zoom from w_stampa_001`sle_zoom within w_ute_documento_gd
integer x = 667
integer taborder = 70
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_ute_documento_gd
integer x = 2990
integer width = 288
integer taborder = 50
string text = "Salva &File"
end type

type cb_7 from w_stampa_001`cb_7 within w_ute_documento_gd
integer x = 818
integer taborder = 40
end type

type cb_6 from w_stampa_001`cb_6 within w_ute_documento_gd
integer x = 549
integer taborder = 120
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_ute_documento_gd
integer x = 2693
integer taborder = 30
end type

type cb_stampa from w_stampa_001`cb_stampa within w_ute_documento_gd
end type

type cb_preview from w_stampa_001`cb_preview within w_ute_documento_gd
integer x = 2469
integer width = 224
integer taborder = 100
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_ute_documento_gd
integer taborder = 110
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_ute_documento_gd
integer taborder = 130
end type

type cb_1 from w_stampa_001`cb_1 within w_ute_documento_gd
integer taborder = 140
end type

type dw_2 from udw_001 within w_ute_documento_gd
integer x = 1467
integer y = 16
integer width = 658
integer height = 112
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_anno_data"
end type

event itemchanged;call super::itemchanged;date ldt_data_inizio
integer li_anno
string ls_filtro

setnull(ldt_data_inizio)
setnull(li_anno)
if dwo.name="anno" then
	li_anno=integer(data)
	setitem(1, "data_inizio", ldt_data_inizio)
	ls_filtro="documento_data_documento >= date('01/01/"+string(li_anno)+"') and documento_data_documento <= date('31/12/"+string(li_anno)+"')"
	
//	if isnumber(li_anno)
elseif dwo.name="data_inizio" then
	setitem(1, "anno", li_anno)
	ldt_data_inizio=date(data)
	ls_filtro="documento_data_documento >=date('"+ string(date(data))+ "')"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
dw_1.sort()
end event

