forward
global type w_acc_statistica_rbol from w_stampa
end type
type cbx_1 from checkbox within w_acc_statistica_rbol
end type
type cbx_2 from checkbox within w_acc_statistica_rbol
end type
end forward

global type w_acc_statistica_rbol from w_stampa
integer width = 3671
cbx_1 cbx_1
cbx_2 cbx_2
end type
global w_acc_statistica_rbol w_acc_statistica_rbol

type variables
s_array s_dati_selezione
end variables

on w_acc_statistica_rbol.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
end on

on w_acc_statistica_rbol.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

event open;call super::open;date ldt_da_data, ldt_a_data 

dw_1.settransobject(sqlca)


s_dati_selezione=message.powerobjectparm
ldt_da_data=date(s_dati_selezione.as_string[1])
ldt_a_data=date(s_dati_selezione.as_string[2])

dw_1.retrieve(ldt_da_data,ldt_a_data)
end event

type pb_1 from w_stampa`pb_1 within w_acc_statistica_rbol
integer x = 2811
end type

type cb_preview from w_stampa`cb_preview within w_acc_statistica_rbol
integer x = 2208
end type

type dw_1 from w_stampa`dw_1 within w_acc_statistica_rbol
integer width = 3493
string dataobject = "d_acc_statistica_rbol"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax
for i= 3 to upperbound(s_dati_selezione.as_string)
	if i=3 then 
		ls_sql+= " and ( cod_accessori_k.descrizione like '%"+s_dati_selezione.as_string[i]+"%' " 
	else
		 ls_sql+= " or  cod_accessori_k.descrizione like '%"+s_dati_selezione.as_string[i]+"%' " 
	end if
next
for i = 1 to upperbound(s_dati_selezione.ll_id_prof)
	ls_sql+= " and ( cod_accessori_k.descrizione like '%"+s_dati_selezione.as_string[i]+"%' " 
next
if ls_sql>sqlsyntax then
	 ls_sql+= " )"
	i=SetSQLPreview(ls_sql)
	if i<>1 then	messagebox("Errore!", "Filtro non applicato!")
end if

end event

event dw_1::retrieveend;call super::retrieveend;dw_1.sort()
dw_1.groupcalc()
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_acc_statistica_rbol
integer x = 2615
end type

type pb_stampa from w_stampa`pb_stampa within w_acc_statistica_rbol
integer x = 2405
end type

type sle_pg from w_stampa`sle_pg within w_acc_statistica_rbol
integer x = 1303
end type

type st_1 from w_stampa`st_1 within w_acc_statistica_rbol
integer x = 1024
end type

type st_2 from w_stampa`st_2 within w_acc_statistica_rbol
end type

type sle_copie from w_stampa`sle_copie within w_acc_statistica_rbol
end type

type sle_zoom from w_stampa`sle_zoom within w_acc_statistica_rbol
end type

type cb_7 from w_stampa`cb_7 within w_acc_statistica_rbol
end type

type cb_6 from w_stampa`cb_6 within w_acc_statistica_rbol
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_acc_statistica_rbol
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_acc_statistica_rbol
end type

type cb_esci from w_stampa`cb_esci within w_acc_statistica_rbol
end type

type cbx_1 from checkbox within w_acc_statistica_rbol
integer x = 1751
integer y = 12
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 80")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

type cbx_2 from checkbox within w_acc_statistica_rbol
integer x = 1751
integer y = 84
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordina"
end type

event clicked;if checked then
	dw_1.setsort("c_gruppo")
	dw_1.sort()
	
else
	
end if
dw_1.groupcalc()
end event

