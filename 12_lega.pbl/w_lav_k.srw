forward
global type w_lav_k from w_semplice_gd
end type
type cb_car_da_excel from commandbutton within w_lav_k
end type
type ole_1 from olecontrol within w_lav_k
end type
type dw_2 from udw_000 within w_lav_k
end type
type cb_save_xls from commandbutton within w_lav_k
end type
type cb_1 from commandbutton within w_lav_k
end type
type dw_3 from udw_001 within w_lav_k
end type
end forward

global type w_lav_k from w_semplice_gd
integer width = 3424
integer height = 1500
boolean maxbox = false
windowtype windowtype = popup!
cb_car_da_excel cb_car_da_excel
ole_1 ole_1
dw_2 dw_2
cb_save_xls cb_save_xls
cb_1 cb_1
dw_3 dw_3
end type
global w_lav_k w_lav_k

type variables
integer ii_click_ok

end variables

forward prototypes
public subroutine wf_maggiorazione (decimal adc_maggiorazione, string as_tipo)
end prototypes

public subroutine wf_maggiorazione (decimal adc_maggiorazione, string as_tipo);integer i
decimal ldc_prezzo
string ls_campo

for i = 1 to dw_1.rowcount()
	ldc_prezzo=0
	ls_campo=""
	ldc_prezzo=dw_1.getitemdecimal(i, "pr_pz")
	if ldc_prezzo>0 then 
		ls_campo="pr_pz"
	else
		ldc_prezzo=dw_1.getitemdecimal(i, "pr_man")
		if ldc_prezzo>0 then
			ls_campo="pr_man"
		end if
	end if
	if ls_campo> " " then
		if as_tipo="P" then
			ldc_prezzo=ldc_prezzo+ldc_prezzo*adc_maggiorazione/100
		else
			ldc_prezzo=ldc_prezzo+adc_maggiorazione
		end if
		dw_1.setitem(i, ls_campo,ldc_prezzo)
	end if
next
end subroutine

on w_lav_k.create
int iCurrent
call super::create
this.cb_car_da_excel=create cb_car_da_excel
this.ole_1=create ole_1
this.dw_2=create dw_2
this.cb_save_xls=create cb_save_xls
this.cb_1=create cb_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_car_da_excel
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_save_xls
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_3
end on

on w_lav_k.destroy
call super::destroy
destroy(this.cb_car_da_excel)
destroy(this.ole_1)
destroy(this.dw_2)
destroy(this.cb_save_xls)
destroy(this.cb_1)
destroy(this.dw_3)
end on

event resize;call super::resize;

cb_car_da_excel.y=cb_ok.y
cb_car_da_excel.x=cb_annulla.x - 420

cb_save_xls.x=cb_car_da_excel.x - cb_car_da_excel.width -10
cb_save_xls.y=cb_ok.y
dw_3.y=cb_ok.y
dw_3.x=cb_save_xls.x -  dw_3.width -10
end event

event open;call super::open;dw_3.settransobject(sqlca)
dw_3.insertrow(1)
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_lav_k
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_lav_k
end type

type cb_primo from w_semplice_gd`cb_primo within w_lav_k
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_lav_k
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_lav_k
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_lav_k
end type

type dw_1 from w_semplice_gd`dw_1 within w_lav_k
integer x = 27
integer width = 3287
integer height = 912
string dataobject = "d_lav_k"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_lav_k
integer x = 27
integer width = 224
end type

type cb_salva from w_semplice_gd`cb_salva within w_lav_k
integer x = 261
integer width = 201
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_lav_k
integer x = 471
integer width = 224
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_lav_k
integer x = 1632
end type

type cb_ok from w_semplice_gd`cb_ok within w_lav_k
integer x = 1925
end type

type cb_car_da_excel from commandbutton within w_lav_k
integer x = 2217
integer y = 984
integer width = 389
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica da Excel"
end type

event clicked;string ls_path, ls_file, ls_colonna
string ls_des_1, ls_tipo_prezzo, ls_des_2, ls_k
decimal ldc_prezzo
integer i
long ll_riga_inserita

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+"txt"
	if fileexists(ls_file) then FileDelete(ls_file)
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_2.importfile(Text!,ls_file)
	for i=1 to dw_2.rowcount()
		ls_k=dw_2.getitemstring(i, "k")
		ls_des_1=dw_2.getitemstring(i, "des_11")
		ls_tipo_prezzo=dw_2.getitemstring(i, "des_22")
		ldc_prezzo=dw_2.getitemdecimal(i, "prezzo2")
		ls_des_2=dw_2.getitemstring(i, "des_2")
		ll_riga_inserita=dw_1.insertrow(0)
		dw_1.setitem(ll_riga_inserita, "lavorazione",ls_k )
		ls_colonna="pr_pz"
		if pos(ls_tipo_prezzo, "g")> 0 or pos(ls_tipo_prezzo, "G")> 0 then ls_colonna="pr_man"
		dw_1.setitem(ll_riga_inserita, ls_colonna,ldc_prezzo )
		dw_1.setitem(ll_riga_inserita, "descrizione", ls_des_1)
		dw_1.setitem(ll_riga_inserita, "des_aggiuntiva", ls_des_2)
	next
end if
end event

type ole_1 from olecontrol within w_lav_k
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
integer x = 1728
integer y = 1344
integer width = 320
integer height = 176
integer taborder = 60
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_lav_k.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type dw_2 from udw_000 within w_lav_k
boolean visible = false
integer x = 219
integer y = 1520
integer width = 2871
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_imp_lav_k"
end type

type cb_save_xls from commandbutton within w_lav_k
integer x = 2267
integer y = 1192
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva in XLS"
end type

event clicked;
string ls_filename

ls_filename=""
dw_1.saveas(ls_filename, Excel!, true)      // il true vuol dire con intestazione


end event

type cb_1 from commandbutton within w_lav_k
boolean visible = false
integer x = 366
integer y = 1136
integer width = 343
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;//per creare il fle in base ad un modello (xlt)
//set wb = workbooks.add("x:\mytemplate.xls") allows you to create a NEW doc and specify the file to be used as a template.

int li_rtn
long ll_excel_rows
string ls_range
oleobject lole_excel, lole_workbook, lole_worksheet, lole_range

lole_excel = create oleobject
li_rtn = lole_excel.ConnectToNewObject("excel.application")
if li_rtn <> 0 then
      MessageBox( "Error", 'Error running MS Excel api.')
      destroy lole_Excel
else
	lole_excel.workbooks.add("c:\nita\exp_doc\miomodello.xls")
  lole_excel.WorkBooks.Open("C:\nita\excel\prova.xls") 

  lole_workbook = lole_excel.application.workbooks(1)
  lole_worksheet = lole_workbook.worksheets(1)

  // Set the cell value
lole_worksheet.cells(20,3).value = "AU750" //string(ldt_data, "gg/mm/yyyy") //it is cells(line, column)
lole_worksheet.cells(20,2).value = "4" //it is cells(line, column)
lole_worksheet.cells(20,4).value = "descrizione articolo venduto" //it is cells(line, column)
lole_worksheet.cells(20,6).value = "5,30" //it is cells(line, column)
//lole_worksheet.cells(20,2).value = "Some value" //it is cells(line, column)
  
ll_excel_rows=3
  //example to work on a range of cells
//  ls_range = "A1:F"+string(ll_excel_rows)
//  lole_range = lole_worksheet.Range(ls_range)
//  lole_range.Select
//  lole_range.Locked = True

  // Save
  lole_workbook.saveas("c:\nita\excel\prova01.xls", 43)
  // Quit
  lole_excel.application.quit()
  lole_excel.DisconnectObject()

  destroy lole_Excel
end if

//Dim abc: abc = testDataPath & "\output\report.csv"
//
//Runs my application and Excel file opens.
//
//Call SaveAsExcelAndCloseFile3(abc ) 
//
//Public Function SaveAsExcelAndCloseFile3(abc )
//
//str1 = "Set x1 = GetObject(,""Excel.Application"")"
//Execute str1
//Set a1 = x1.Worksheets(1)
//
//'Set objWB = x1.ActiveWorkbook
//'objWB.SaveAs(abc)
//



//a1.SaveAs abc
//x1.ActiveWorkbook.Close True
//x1.Application.Quit
//
//Set a1 = nothing
//Set x1 = nothing
//End Function


end event

type dw_3 from udw_001 within w_lav_k
integer x = 791
integer y = 956
integer width = 704
integer height = 160
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_aumento_perc_importo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;decimal ldc_perc, ldc_imp
if dwo.name="b_ok" then
	ii_click_ok++
	if ii_click_ok=1 then
		accepttext()
		ldc_perc=getitemdecimal(row, "percentuale")
		if ldc_perc>0 then 
			wf_maggiorazione(ldc_perc, "P")
		else
			ldc_imp=getitemdecimal(row, "importo")
			wf_maggiorazione(ldc_imp, "I")
		end if
	end if
	
end if
end event

