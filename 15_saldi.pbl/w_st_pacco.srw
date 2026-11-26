forward
global type w_st_pacco from w_stampa_001
end type
type cb_2 from commandbutton within w_st_pacco
end type
end forward

global type w_st_pacco from w_stampa_001
integer x = 23
integer y = 12
cb_2 cb_2
end type
global w_st_pacco w_st_pacco

on w_st_pacco.create
int iCurrent
call super::create
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
end on

on w_st_pacco.destroy
call super::destroy
destroy(this.cb_2)
end on

event open;call super::open;s_pacco s_pac
integer i

dw_1.settransobject(sqlca)

s_pac=message.powerobjectparm

for i= 1 to upperbound(s_pac.s_id_pacco)
	dw_1.retrieve(s_pac.s_id_pacco[i])
next
end event

type dw_1 from w_stampa_001`dw_1 within w_st_pacco
string dataobject = "d_pacco_bollettina_st"
end type

event dw_1::retrievestart;call super::retrievestart;return 2
end event

type sle_pg from w_stampa_001`sle_pg within w_st_pacco
end type

type st_1 from w_stampa_001`st_1 within w_st_pacco
end type

type st_2 from w_stampa_001`st_2 within w_st_pacco
end type

type sle_copie from w_stampa_001`sle_copie within w_st_pacco
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_pacco
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_pacco
end type

type cb_7 from w_stampa_001`cb_7 within w_st_pacco
end type

type cb_6 from w_stampa_001`cb_6 within w_st_pacco
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_pacco
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_pacco
end type

event cb_stampa::clicked;call super::clicked;string ls_nome_file, ls_giorno
integer li_ret
ls_giorno=string(dw_1.getitemdatetime(1, "pacco_dataora"))
ls_giorno=left(ls_giorno, 10)

ls_giorno=right(ls_giorno,4)+"-"+mid(ls_giorno, 4,2)+"-"+left(ls_giorno, 2)

ls_giorno="Sped_"+ls_giorno

ls_nome_file="c:\start\pacchi\"+ls_giorno+".pdf"
dw_1.Modify ('DataWindow.Printer="Sybase DataWindow PS" ')
dw_1.Modify("Export.PDF.Method = Distill!")
dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
li_ret=dw_1.SaveAs(ls_nome_file, PDF!, FALSE)

end event

type cb_preview from w_stampa_001`cb_preview within w_st_pacco
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_pacco
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_pacco
end type

type cb_1 from w_stampa_001`cb_1 within w_st_pacco
end type

type cb_2 from commandbutton within w_st_pacco
boolean visible = false
integer x = 1083
integer y = 51
integer width = 322
integer height = 93
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;string ls_nome_file, ls_ret
integer li_ret
long job

job = PrintOpen( )

ls_nome_file="c:\start\pacchi2015\"+dw_1.getitemstring(1, "pacco_codice")+".pdf"
//ls_ret=dw_1.Modify ('DataWindow.Printer="Brother HL-1430" ')
//dw_1.Object.DataWindow.Printer="Brother HL-1430"
//dw_1.Modify("Export.PDF.Method = Distill!")
//dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
dw_1.Modify('DataWindow.Print.PrinterName	 = "Brother HL-1430"')
dw_1.Modify ('DataWindow.Print.DocumentName = "'+ls_nome_file+'"')
dw_1.Modify ('DataWindow.Print.FileName = "pippo"')

printdatawindow(job, dw_1)
PrintClose(job)
//li_ret=dw_1.SaveAs(ls_nome_file, PDF!, FALSE)





end event

