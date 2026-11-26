forward
global type w_orafo_riepilogo_pesi from window
end type
type dw_riepilogo_pesi from datawindow within w_orafo_riepilogo_pesi
end type
end forward

global type w_orafo_riepilogo_pesi from window
integer x = 1074
integer y = 484
integer width = 3749
integer height = 828
boolean titlebar = true
string title = "Riepilogo Pesi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
dw_riepilogo_pesi dw_riepilogo_pesi
end type
global w_orafo_riepilogo_pesi w_orafo_riepilogo_pesi

on w_orafo_riepilogo_pesi.create
this.dw_riepilogo_pesi=create dw_riepilogo_pesi
this.Control[]={this.dw_riepilogo_pesi}
end on

on w_orafo_riepilogo_pesi.destroy
destroy(this.dw_riepilogo_pesi)
end on

event open;integer rtncode
u_dw_master_main dw_1
dw_1=create u_dw_master_main
dw_1=message.powerobjectparm

dw_1.rowscopy(1, dw_1.rowcount(), primary!, dw_riepilogo_pesi, 1, primary!)

DataWindowChild dw_met



rtncode = dw_riepilogo_pesi.GetChild('metallo', dw_met)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")

CONNECT USING SQLCA;	

dw_met.SetTransObject(SQLCA)

dw_met.Retrieve()



dw_riepilogo_pesi.post sort()
dw_riepilogo_pesi.post groupcalc()

end event

type dw_riepilogo_pesi from datawindow within w_orafo_riepilogo_pesi
integer x = 32
integer y = 28
integer width = 3634
integer height = 700
integer taborder = 1
string dataobject = "d_orafo_riepilogo_pesi"
boolean vscrollbar = true
boolean livescroll = true
end type

