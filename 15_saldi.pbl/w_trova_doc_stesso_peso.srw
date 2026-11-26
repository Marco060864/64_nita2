forward
global type w_trova_doc_stesso_peso from w_stampa
end type
type dw_2 from udw_000 within w_trova_doc_stesso_peso
end type
end forward

global type w_trova_doc_stesso_peso from w_stampa
integer height = 1992
dw_2 dw_2
end type
global w_trova_doc_stesso_peso w_trova_doc_stesso_peso

on w_trova_doc_stesso_peso.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_trova_doc_stesso_peso.destroy
call super::destroy
destroy(this.dw_2)
end on

event resize;iudw_corrente.setredraw(false)
iudw_corrente.height=newheight - 250 - 200
iudw_corrente.width=newwidth - 75
iudw_corrente.setredraw(true)
end event

event open;call super::open;string ls_anno

dw_2.insertrow(1)

dw_1.settransobject(sqlca)

datawindowchild ldw_profilo, ldw_soggetto


dw_2.getchild("id_profilo",ldw_profilo)
ldw_profilo.settransobject(sqlca)
ldw_profilo.retrieve()

dw_2.getchild("id_sog",ldw_soggetto)
ldw_soggetto.settransobject(sqlca)
ldw_soggetto.retrieve()

ls_anno=string(year(today()))
dw_2.setitem(1, "da_data", date("01/01/"+ls_anno))

end event

type pb_1 from w_stampa`pb_1 within w_trova_doc_stesso_peso
end type

type cb_preview from w_stampa`cb_preview within w_trova_doc_stesso_peso
end type

type dw_1 from w_stampa`dw_1 within w_trova_doc_stesso_peso
integer y = 400
string dataobject = "d_trova_doc_stesso_peso"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_trova_doc_stesso_peso
end type

type pb_stampa from w_stampa`pb_stampa within w_trova_doc_stesso_peso
end type

type sle_pg from w_stampa`sle_pg within w_trova_doc_stesso_peso
end type

type st_1 from w_stampa`st_1 within w_trova_doc_stesso_peso
end type

type st_2 from w_stampa`st_2 within w_trova_doc_stesso_peso
end type

type sle_copie from w_stampa`sle_copie within w_trova_doc_stesso_peso
end type

type sle_zoom from w_stampa`sle_zoom within w_trova_doc_stesso_peso
end type

type cb_7 from w_stampa`cb_7 within w_trova_doc_stesso_peso
end type

type cb_6 from w_stampa`cb_6 within w_trova_doc_stesso_peso
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_trova_doc_stesso_peso
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_trova_doc_stesso_peso
end type

type cb_esci from w_stampa`cb_esci within w_trova_doc_stesso_peso
end type

type dw_2 from udw_000 within w_trova_doc_stesso_peso
integer x = 37
integer y = 176
integer width = 3310
integer height = 220
integer taborder = 18
boolean bringtotop = true
string dataobject = "d_2_date_prof_soggetto"
end type

event clicked;call super::clicked;date ldt_da_data, ldt_a_data
long ll_id_prof, ll_id_sog

if dwo.name='b_trova' then
	ldt_da_data=dw_2.getitemdate(1, "da_data")
	ldt_a_data=dw_2.getitemdate(1, "a_data")
	ll_id_prof=dw_2.getitemnumber(1, "id_profilo")
	ll_id_sog=dw_2.getitemnumber(1, "id_sog")
	dw_1.retrieve(ldt_da_data, ldt_a_data, ll_id_sog, ll_id_prof)
end if
end event

