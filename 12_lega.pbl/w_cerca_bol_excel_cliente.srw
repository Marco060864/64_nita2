forward
global type w_cerca_bol_excel_cliente from w_stampa
end type
type dw_2 from udw_000 within w_cerca_bol_excel_cliente
end type
end forward

global type w_cerca_bol_excel_cliente from w_stampa
integer width = 5627
integer height = 1816
dw_2 dw_2
end type
global w_cerca_bol_excel_cliente w_cerca_bol_excel_cliente

type variables

end variables

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.insertrow(1)
end event

on w_cerca_bol_excel_cliente.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_cerca_bol_excel_cliente.destroy
call super::destroy
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;dw_2.setitem(1, "data_inizio", datetime('2024-01-01 00:00:00'))
end event

type pb_1 from w_stampa`pb_1 within w_cerca_bol_excel_cliente
integer x = 3369
integer y = 24
end type

type cb_preview from w_stampa`cb_preview within w_cerca_bol_excel_cliente
integer x = 2766
integer y = 24
end type

type dw_1 from w_stampa`dw_1 within w_cerca_bol_excel_cliente
integer width = 5504
string dataobject = "d_bol_excel_ra_cliente"
end type

event dw_1::sqlpreview;call super::sqlpreview;//string ls_sql, ls_sql_2, ls_sql_unione
//integer i, li_pos
//
//
//if sqltype<>PreviewUpdate!	then
//	ls_sql=sqlsyntax
//	if idt_data_inizio_retrieve> dateTIME("1901-01-01") then
//		ls_sql_unione=ls_sql+" and data>= '"+string(idt_data_inizio_retrieve)+"' "
//	
//		i=SetSQLPreview(ls_sql_unione)
//		if i<>1 then
//			messagebox("Errore!", "Filtro non applicato!")
//		end if
//	end if
//	
//end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_cerca_bol_excel_cliente
integer x = 3173
integer y = 24
end type

type pb_stampa from w_stampa`pb_stampa within w_cerca_bol_excel_cliente
integer x = 2962
integer y = 24
end type

type sle_pg from w_stampa`sle_pg within w_cerca_bol_excel_cliente
boolean visible = false
integer x = 2871
integer y = 212
end type

type st_1 from w_stampa`st_1 within w_cerca_bol_excel_cliente
boolean visible = false
integer x = 2592
integer y = 220
end type

type st_2 from w_stampa`st_2 within w_cerca_bol_excel_cliente
end type

type sle_copie from w_stampa`sle_copie within w_cerca_bol_excel_cliente
end type

type sle_zoom from w_stampa`sle_zoom within w_cerca_bol_excel_cliente
end type

type cb_7 from w_stampa`cb_7 within w_cerca_bol_excel_cliente
end type

type cb_6 from w_stampa`cb_6 within w_cerca_bol_excel_cliente
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_cerca_bol_excel_cliente
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_cerca_bol_excel_cliente
end type

type cb_esci from w_stampa`cb_esci within w_cerca_bol_excel_cliente
integer x = 3607
integer y = 28
end type

type dw_2 from udw_000 within w_cerca_bol_excel_cliente
integer x = 1088
integer width = 1573
integer height = 164
integer taborder = 23
boolean bringtotop = true
string dataobject = "D_CErca_bol_excel_cliente"
end type

event itemchanged;call super::itemchanged;string ls_cliente
datetime ldt_data_inizio

if dwo.name="cliente" then
	ldt_data_inizio=dw_2.getitemdatetime(1, "data_inizio")
	if ldt_data_inizio> datetime("01/01/1901 00:00:00") then
		dw_1.retrieve(data, ldt_data_inizio)
	else
		messagebox("Attenzione!", "Occorre scegliere anche una data di inizio!")
	end if
elseif dwo.name="des_libera" then
	if dw_1.rowcount()>0 then
		dw_1.setfilter ("Des_libera like '%"+upper(data)+"%' ")
		dw_1.filter()
	else
		messagebox("Attenzione!", "Occorre prima scegliere un cliente! Solo dopo puoi filtrare per des_libera!")
	end if
elseif dwo.name="solo_con_accessorio" then
	if data='S' then
		dw_1.setfilter ("Accessorio> ' '")
	else
		dw_1.setfilter ("")
	end if
	dw_1.filter()
elseif dwo.name="data_inizio" then
	
	ls_cliente=dw_2.getitemstring(1, "cliente")
	if ls_cliente>" " then
		dw_1.retrieve(ls_cliente, dateTIME(data))
	else
		messagebox("Attenzione!", "Occorre prima scegliere un cliente!")
	end if
end if
end event

