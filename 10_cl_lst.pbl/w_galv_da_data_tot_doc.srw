forward
global type w_galv_da_data_tot_doc from w_stampa
end type
type cbx_1 from checkbox within w_galv_da_data_tot_doc
end type
type dw_2 from udw_stampa within w_galv_da_data_tot_doc
end type
type dw_3 from udw_stampa within w_galv_da_data_tot_doc
end type
end forward

global type w_galv_da_data_tot_doc from w_stampa
integer width = 3438
integer height = 1764
cbx_1 cbx_1
dw_2 dw_2
dw_3 dw_3
end type
global w_galv_da_data_tot_doc w_galv_da_data_tot_doc

type variables
string as_filtro, as_flag
long il_id_prof_doc
date idt_da_data2, idt_a_data2
end variables

on w_galv_da_data_tot_doc.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
end on

on w_galv_da_data_tot_doc.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;s_date_e_sog s_date
string ls_data, ls_tipo
DataWindowChild ldwc, ldwc2
integer li_ret, li_num_reg
long ll_di_ese, ll_id_reg_prec

s_date=message.powerobjectparm
as_filtro=s_date.filtro
if s_date.id_sog_com>1 then
	dw_1.dataobject="d_galv_da_data_tutti_doc"
	il_id_prof_doc= s_date.id_sog_com
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(s_date.da_data, s_date.a_data)
if s_date.flag="S" then
	as_flag="S"
	dw_2.visible=true
	this.width=5321
	dw_2.settransobject(sqlca)
	ls_data=string(year(s_date.da_data) - 1)+"/"+string(month(s_date.da_data))+"/"+string(day(s_date.da_data))
	idt_da_data2=date(ls_data)
	ls_data=string(year(s_date.a_data) - 1)+"/"+string(month(s_date.a_data))+"/"+string(day(s_date.a_data))
	idt_a_data2=date(ls_data)
	dw_1.retrieve(s_date.da_data, s_date.a_data)
	dw_2.retrieve(idt_da_data2, idt_a_data2)
	dw_2.modify("t_periodo.text='Dal "+string(idt_da_data2, "dd/mm/yy")+" al "+string(idt_a_data2, "dd/mm/yy")+"'")
	dw_2.modify("t_periodo.text='Dal "+string(idt_da_data2, "dd/mm/yy")+" al "+string(idt_a_data2, "dd/mm/yy")+"'")
	
//	li_ret=dw_3.GetChild("dw_1", ldwc)
//	ldwc.settransobject(sqlca)
//	ldwc.retrieve(s_date.da_data, s_date.a_data)
//	li_ret=dw_3.GetChild("dw_2", ldwc2)
//	ldwc2.settransobject(sqlca)
//	ldwc2.retrieve(idt_da_data2, idt_a_data2)
	dw_3.settransobject(sqlca)	
	dw_3.retrieve(s_date.da_data, s_date.a_data, idt_da_data2, idt_a_data2)
	//ldwc.modify("t_periodo.text='Dal "+string(s_date.da_data, "dd/mm/yy")+" al "+string(s_date.a_data, "dd/mm/yy")+"'")
elseif s_date.id_sog_com>1 then
	ls_data=string(year(s_date.da_data) - 1)+"/"+string(month(s_date.da_data))+"/"+string(day(s_date.da_data))
	idt_da_data2=date(ls_data)
	ls_data=string(year(s_date.a_data) - 1)+"/"+string(month(s_date.a_data))+"/"+string(day(s_date.a_data))
	idt_a_data2=date(ls_data)
	dw_1.dataobject="d_confronto_nested"
	dw_1.settransobject(sqlca)
	//trovo registro anno precedente
	select id_esercizio into :ll_di_ese from dba.esercizio where data_inizio<=:idt_da_data2 and data_fine>=:idt_da_data2;
	select tipo_registro, numero into :ls_tipo, :li_num_reg from dba.registro where id_registro=: s_date.id_sog_com;
	select id_registro into :ll_id_reg_prec from dba.registro where id_esercizio=:ll_di_ese and tipo_registro=:ls_tipo and numero=:li_num_reg;
	dw_1.Retrieve(s_date.id_sog_com, s_date.id_sog_com, s_date.da_data, s_date.a_data, ll_id_reg_prec,ll_id_reg_prec,idt_da_data2, idt_a_data2)
end if

dw_1.modify("t_periodo.text='Dal "+string(s_date.da_data, "dd/mm/yy")+" al "+string(s_date.a_data, "dd/mm/yy")+"'")


end event

type pb_1 from w_stampa`pb_1 within w_galv_da_data_tot_doc
integer x = 2368
end type

type cb_preview from w_stampa`cb_preview within w_galv_da_data_tot_doc
integer x = 1765
end type

type dw_1 from w_stampa`dw_1 within w_galv_da_data_tot_doc
integer width = 2574
string dataobject = "d_galv_da_data_tot_doc"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i, li_pos

if as_filtro> " " then
	//"GROUP BY"
	ls_sql=sqlsyntax
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1) + " and  galvanica.lavorazione = '"+as_filtro+"' "+right(ls_sql, len(ls_sql)+ 1 - li_pos)
	
end if
if il_id_prof_doc> 0 then
	if ls_sql <=" " then
		ls_sql=sqlsyntax
	end if
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1) + " and  documento.id_prof_documento = "+string(il_id_prof_doc)+" "+right(ls_sql, len(ls_sql)+ 1 - li_pos)
end if

if len(ls_sql)>len(sqlsyntax) then
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if	
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_galv_da_data_tot_doc
integer x = 2171
end type

type pb_stampa from w_stampa`pb_stampa within w_galv_da_data_tot_doc
integer x = 1961
end type

event pb_stampa::clicked;string ls_num_doc, ls_data, ls_h_footer
long ll_job, li_righe
integer  li_num_copie
datawindowchild dwc_1, dwc_2
if as_flag="S" then
	
	
	li_righe=dw_3.rowcount()  
	if li_righe>0 then
		ls_num_doc=parent.classname()
		IF is_doc_per_stampa>" " then
			ls_num_doc=	is_doc_per_stampa
		else
			ls_data=string(today(), "dd-mm-yy")
			ls_num_doc+="_"+ls_data
		end if		
		//dw_3.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
	//	long jobjob = PrintOpen( )// Each DataWindow starts printing on a new page.PrintDataWindow(job, dw_EmpHeader)PrintDataWindow(job, dw_EmpDetail)PrintDataWindow(job, dw_EmpDptSum)PrintClose(job)
		//dw_1.print(false, true)
//		dw_3.object.dw_1.
		dw_3.print(true, true)
		
		
	else
		messagebox("Attenzione!", "Non c'è nulla da stampare!")
	end if
else
	li_righe=dw_1.rowcount()
	if li_righe>0 then
		ls_num_doc=parent.classname()
		IF is_doc_per_stampa>" " then
			ls_num_doc=	is_doc_per_stampa
		else
			ls_data=string(today(), "dd-mm-yy")
			ls_num_doc+="_"+ls_data
		end if
			
		iudw_corrente.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
		iudw_corrente.print(false, true)
			
	else
		messagebox("Attenzione!", "Non c'è nulla da stampare!")
	end if
end if
end event

type sle_pg from w_stampa`sle_pg within w_galv_da_data_tot_doc
integer x = 1353
integer y = 44
end type

type st_1 from w_stampa`st_1 within w_galv_da_data_tot_doc
integer x = 1074
integer y = 52
end type

type st_2 from w_stampa`st_2 within w_galv_da_data_tot_doc
integer y = 52
end type

type sle_copie from w_stampa`sle_copie within w_galv_da_data_tot_doc
integer y = 44
end type

type sle_zoom from w_stampa`sle_zoom within w_galv_da_data_tot_doc
integer y = 44
end type

type cb_7 from w_stampa`cb_7 within w_galv_da_data_tot_doc
integer y = 44
end type

type cb_6 from w_stampa`cb_6 within w_galv_da_data_tot_doc
integer y = 44
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_galv_da_data_tot_doc
integer y = 44
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_galv_da_data_tot_doc
integer y = 44
end type

type cb_esci from w_stampa`cb_esci within w_galv_da_data_tot_doc
integer y = 44
end type

type cbx_1 from checkbox within w_galv_da_data_tot_doc
integer x = 2592
integer y = 48
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
string text = "Vedi Righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height=78")
else
	dw_1.modify("datawindow.detail.height=0")
end if
end event

type dw_2 from udw_stampa within w_galv_da_data_tot_doc
boolean visible = false
integer x = 2656
integer y = 176
integer width = 2574
integer height = 1372
integer taborder = 28
boolean bringtotop = true
string dataobject = "d_galv_da_data_tot_doc"
end type

event sqlpreview;call super::sqlpreview;string ls_sql
integer i, li_pos

if as_filtro> " " then
	//"GROUP BY"
	ls_sql=sqlsyntax
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1) + " and  galvanica.lavorazione = '"+as_filtro+"' "+right(ls_sql, len(ls_sql)+ 1 - li_pos)
	
end if
if il_id_prof_doc> 0 then
	if ls_sql <=" " then
		ls_sql=sqlsyntax
	end if
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1) + " and  documento.id_prof_documento = "+string(il_id_prof_doc)+" "+right(ls_sql, len(ls_sql)+ 1 - li_pos)
end if

if len(ls_sql)>len(sqlsyntax) then
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if	
end if
end event

type dw_3 from udw_stampa within w_galv_da_data_tot_doc
boolean visible = false
integer x = 50
integer y = 1592
integer width = 2555
integer height = 1372
integer taborder = 38
boolean bringtotop = true
string dataobject = "d_galv_da_data_tot_nested"
end type

event sqlpreview;call super::sqlpreview;string ls_sql
integer i, li_pos

if as_filtro> " " then
	//"GROUP BY"
	ls_sql=sqlsyntax
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1) + " and  galvanica.lavorazione = '"+as_filtro+"' "+right(ls_sql, len(ls_sql)+ 1 - li_pos)
	
end if
if il_id_prof_doc> 0 then
	if ls_sql <=" " then
		ls_sql=sqlsyntax
	end if
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1) + " and  documento.id_prof_documento = "+string(il_id_prof_doc)+" "+right(ls_sql, len(ls_sql)+ 1 - li_pos)
end if

if len(ls_sql)>len(sqlsyntax) then
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if	
end if
end event

