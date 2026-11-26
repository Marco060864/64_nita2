forward
global type w_log_dati from w_base
end type
type cb_2 from commandbutton within w_log_dati
end type
type dw_2 from udw_000 within w_log_dati
end type
type dw_4 from udw_000 within w_log_dati
end type
type dw_3 from udw_000 within w_log_dati
end type
type dw_5 from udw_000 within w_log_dati
end type
type dw_1 from udw_000 within w_log_dati
end type
type cb_1 from commandbutton within w_log_dati
end type
type pipeline_2 from pipeline within w_log_dati
end type
type pipeline_1 from pipeline within w_log_dati
end type
end forward

global type w_log_dati from w_base
integer width = 4910
integer height = 2524
cb_2 cb_2
dw_2 dw_2
dw_4 dw_4
dw_3 dw_3
dw_5 dw_5
dw_1 dw_1
cb_1 cb_1
pipeline_2 pipeline_2
pipeline_1 pipeline_1
end type
global w_log_dati w_log_dati

type variables
string is_report_type
end variables

forward prototypes
public function string wf_build_dw_syntax (transaction a_transobj)
end prototypes

public function string wf_build_dw_syntax (transaction a_transobj);string	ls_dw_err,	ls_dw_syntax, ls_style,	ls_sql_syntax

ls_style = "style(type=grid) datawindow(units=2 )"

ls_dw_err = ""

ls_sql_syntax =  "select * from commesse"
If ls_sql_syntax = "" Then
	return ""
Else
	ls_dw_syntax = SyntaxFromSQL(a_transobj,ls_sql_syntax, ls_style, ls_dw_err)
	if ls_dw_err <> "" then
		MessageBox("Errore!", ls_dw_err)
	end if
	return ls_dw_syntax
End If
end function

on w_log_dati.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.dw_2=create dw_2
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_5=create dw_5
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pipeline_2=create pipeline_2
this.pipeline_1=create pipeline_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_1
end on

on w_log_dati.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_5)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pipeline_2)
destroy(this.pipeline_1)
end on

event open;call super::open;dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
end event

type cb_2 from commandbutton within w_log_dati
integer x = 494
integer y = 1776
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "PIPELINE"
end type

event clicked;//pipeline_1.DataObject = "pl_commesse"
//iReturn = pipeline_1.Start(SQLCA, SQLCAtarget, dw_1)
integer li_ret
transaction ACCTrans
integer iReturn
pipeline myPipeline
myPipeline = CREATE pipeline

myPipeline.DataObject = "pl_commesse"

ACCTrans = CREATE transaction
ACCTrans.DBMS="ODBC"
ACCTrans.DBParm="ConnectString='DSN=archivio'"
CONNECT USING ACCTrans; 


li_ret = myPipeline.Start(ACCTrans, SQLCA, dw_1)

//li_ret=pipeline_2.start(ACCTrans, sqlca, dw_1)
messagebox("", li_ret)
disconnect USING ACCTrans; 

//SQLCAtarget = CREATE transaction
//SQLCAtarget.DBMS = 'your target dbms name'
//SQLCAtarget.Database = 'your target database login id'
//SQLCAtarget.LogPass = 'your target database password'
//SQLCAtarget.ServerName = 'your target database server'
//SQLCAtarget.LogId = 'your target database login id'
//CONNECT USING SQLCAtarget;
end event

type dw_2 from udw_000 within w_log_dati
integer x = 5
integer y = 560
integer width = 1417
integer height = 472
integer taborder = 10
string dataobject = "d_mdb_commesse"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_4 from udw_000 within w_log_dati
integer x = 2926
integer y = 560
integer width = 1417
integer height = 472
integer taborder = 30
string dataobject = "d_mdb_station"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_3 from udw_000 within w_log_dati
integer x = 1463
integer y = 560
integer width = 1417
integer height = 472
integer taborder = 20
string dataobject = "d_mdb_telai"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_5 from udw_000 within w_log_dati
integer x = 5
integer y = 1092
integer width = 4338
integer height = 472
integer taborder = 20
string dataobject = "d_mdb_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_1 from udw_000 within w_log_dati
integer x = 5
integer y = 36
integer width = 4338
integer height = 472
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_1 from commandbutton within w_log_dati
integer x = 3813
integer y = 1680
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;string ls_az, ls_dw_syntax, ls_style,ls_dw_err, ls_sql_syntax, ls_dns
integer i
transaction ACCTrans
udw_000 ldw_nita

ACCTrans = CREATE TRANSACTION
for i=1 to 4
	if i=1 then 
		ls_dns="archivio"
		ls_sql_syntax =  "select * from commesse"
		ldw_nita=dw_2
	end if
	if i=2 then 
		ls_dns="archivio"
		ls_sql_syntax =  "select * from  telai"
		ldw_nita=dw_3
	end if
	if i=3 then 
		ls_dns="common"
		ls_sql_syntax =  "select * from  station"
		ldw_nita=dw_4
	end if
	if i=4 then 
		ls_dns="log"
		ls_sql_syntax =  "select * from list"
		ldw_nita=dw_5
	end if
	ACCTrans.DBMS="ODBC"
	ACCTrans.DBParm="ConnectString='DSN="+ls_dns+"'"
	CONNECT USING ACCTrans; 
	dw_1.settransobject(ACCTrans)
	ls_style = "style(type=grid) datawindow(units=2 )"
	ls_dw_err = ""
	ls_dw_syntax = SyntaxFromSQL(ACCTrans,ls_sql_syntax, ls_style, ls_dw_err)
	if ls_dw_err <> "" then
		MessageBox("Errore!", ls_dw_err)
	end if
	ls_dw_syntax=wf_build_dw_syntax(ACCTrans)
	dw_1.Create(ls_dw_syntax)
	dw_1.settransobject(ACCTrans)
	dw_1.retrieve()
	dw_1.rowscopy(1, dw_1.rowcount(),primary!, ldw_nita, 1, primary!)
	
	DISCONNECT USING ACCTrans;
next

// Destroy the Transaction object.
DESTROY ACCTrans

end event

type pipeline_2 from pipeline within w_log_dati descriptor "pb_nvo" = "true" 
string dataobject = "pl_commesse"
end type

on pipeline_2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pipeline_2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

type pipeline_1 from pipeline within w_log_dati descriptor "pb_nvo" = "true" 
end type

on pipeline_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pipeline_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

