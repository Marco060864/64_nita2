forward
global type w_excel from window
end type
type dw_2 from datawindow within w_excel
end type
type dw_1 from datawindow within w_excel
end type
type cb_carica from commandbutton within w_excel
end type
type ole_1 from olecontrol within w_excel
end type
end forward

global type w_excel from window
integer width = 3858
integer height = 2104
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_2 dw_2
dw_1 dw_1
cb_carica cb_carica
ole_1 ole_1
end type
global w_excel w_excel

on w_excel.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_carica=create cb_carica
this.ole_1=create ole_1
this.Control[]={this.dw_2,&
this.dw_1,&
this.cb_carica,&
this.ole_1}
end on

on w_excel.destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_carica)
destroy(this.ole_1)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.insertrow(1)


end event

type dw_2 from datawindow within w_excel
integer x = 37
integer y = 172
integer width = 3771
integer height = 760
integer taborder = 30
string title = "none"
string dataobject = "d_imp_excel_ext"
boolean resizable = true
boolean livescroll = true
end type

event clicked;drag(begin!)
end event

type dw_1 from datawindow within w_excel
integer x = 27
integer y = 948
integer width = 3771
integer height = 940
integer taborder = 30
string title = "none"
string dataobject = "d_prezzi_calcolo_tb"
boolean resizable = true
boolean livescroll = true
end type

event dragleave;drag(end!)
end event

event dragdrop;datawindow ldw_drag
integer li_n_colonna, li_righe, i
string ls_dato
decimal ldc_dato


if source.TypeOf()=Datawindow! then
	ldw_drag=source
	li_n_colonna=ldw_drag.getcolumn()
	
	li_righe=ldw_drag.rowcount()
	for i= 2 to li_righe
		ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
		if dw_1.rowcount()< i - 1 then
			dw_1.insertrow(0)
		end if
		if left(string(dwo.coltype), 3)='cha' then
			dw_1.setitem(i - 1, string(dwo.name), ls_dato)
		else
			ldc_dato=dec(ls_dato)
			dw_1.setitem(i - 1, string(dwo.name), ldc_dato)
		
		end if
	next
	//ldw_drag.Object.Data[ 2, li_n_colonna, li_righe, li_n_colonna ] 
	
end if
end event

type cb_carica from commandbutton within w_excel
integer x = 50
integer y = 36
integer width = 416
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica File Excel"
end type

event clicked;
integer li_ret
string ls_path, ls_file
	
getfileopenname("Cerca report", ls_path, ls_file)
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+".txt"
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_2.importfile(Text!,ls_file)

end if	 



end event

type ole_1 from olecontrol within w_excel
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
boolean visible = false
integer x = 2775
integer y = 36
integer width = 398
integer height = 684
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean isdragtarget = true
string binarykey = "w_excel.win"
string displayname = "Prova"
boolean resizable = true
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayasactivexdocument!
omcontentsallowed contentsallowed = containsany!
end type

