forward
global type w_print_excel from w_stampa
end type
type cb_1 from commandbutton within w_print_excel
end type
type dwdatos from udw_000 within w_print_excel
end type
type cb_2 from commandbutton within w_print_excel
end type
type cb_salva_excel from commandbutton within w_print_excel
end type
end forward

global type w_print_excel from w_stampa
integer width = 3831
integer height = 2500
cb_1 cb_1
dwdatos dwdatos
cb_2 cb_2
cb_salva_excel cb_salva_excel
end type
global w_print_excel w_print_excel

on w_print_excel.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dwdatos=create dwdatos
this.cb_2=create cb_2
this.cb_salva_excel=create cb_salva_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dwdatos
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_salva_excel
end on

on w_print_excel.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dwdatos)
destroy(this.cb_2)
destroy(this.cb_salva_excel)
end on

type pb_1 from w_stampa`pb_1 within w_print_excel
end type

type cb_preview from w_stampa`cb_preview within w_print_excel
end type

type dw_1 from w_stampa`dw_1 within w_print_excel
string dataobject = "d_fat_90_alpa2"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_print_excel
end type

type pb_stampa from w_stampa`pb_stampa within w_print_excel
end type

type sle_pg from w_stampa`sle_pg within w_print_excel
end type

type st_1 from w_stampa`st_1 within w_print_excel
end type

type st_2 from w_stampa`st_2 within w_print_excel
end type

type sle_copie from w_stampa`sle_copie within w_print_excel
end type

type sle_zoom from w_stampa`sle_zoom within w_print_excel
end type

type cb_7 from w_stampa`cb_7 within w_print_excel
end type

type cb_6 from w_stampa`cb_6 within w_print_excel
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_print_excel
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_print_excel
end type

type cb_esci from w_stampa`cb_esci within w_print_excel
end type

type cb_1 from commandbutton within w_print_excel
boolean visible = false
integer x = 3351
integer y = 32
integer width = 402
integer height = 112
integer taborder = 28
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;// This function activates CSS in the datawindow to export in Excel format, 
// doing this will maintain the visual appearance of the dw in excel.

// ***********
// TO CONSIDER
// ***********
// - If there are overlapping column or compute type controls (one above the other), 
//   the SaveAs will only record the one above it. Use the setPosition() function if possible:
//     > Example: dw.setPosition( 'campo_t', 'header', true )
// - The objects must be in the Layer: Band
// - HELP to apply special formats:
//     > http://codesnipers.com/?q=excel-compatible-html
//     > https://stigmortenmyre.no/mso/html/excel/xlconformulas.htm

String ls_GenerateCSS
String ls_Border
String ls_NoWrap
String ls_Fila
String ls_Valor
String ls_Temp
String ls_CabeceraHTML
String ls_PieHTML
String ls_NumToStr, spRuta

Long i
Long ll_TRow
Long ll_Pos
Long ll_PosIni
Long ll_PosFin
Long ll_Row
Long ll_Temp

Boolean lb_Actualizar

ls_CabeceraHTML = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">'
ls_PieHTML = '</html>'
ls_NumToStr = 'x:str'

// Save current CSS datawindow format
ls_GenerateCSS = dwDatos.Describe("DataWindow.HTMLTable.GenerateCSS")
ls_Border = dwDatos.Describe("DataWindow.HTMLTable.border")
ls_NoWrap = dwDatos.Describe("DataWindow.HTMLTable.nowrap")

// Apply CSS format to datawindow
dwDatos.Modify("DataWindow.HTMLTable.GenerateCSS='1'")
dwDatos.Modify("DataWindow.HTMLTable.border='0'")
dwDatos.Modify("DataWindow.HTMLTable.nowrap='1'")
spRuta="c:\dati\excelprova.htm"
// Save the .xls file
dwDatos.SaveAs( spRuta, HTMLTable!, TRUE )

// Import the .xls file to "d_FilaFichero"
datastore dsHTML
dsHTML = CREATE datastore
dsHTML.DataObject = "d_FilaFichero"
dsHTML.ImportFile( Text!, spRuta )

// Process line by line for:
//   - Add in the header: <!DOCTYPE html>
//   - Replace "{;" by "{"
//   - If there is "visibility:hidden" replacing its value with spaces, excel does not support this and displays it
//          Example: Original: <TD NOWRAP CLASS=htmldw9C370 Style='visibility:hidden;'>0202002003</TD>
//                  Replaced: <TD NOWRAP CLASS=htmldw9C370 Style='visibility:hidden;'>          </TD>
//   - Number solution in parentheses, excel converts to negative number.
//   - Keep the leading zeros to the left, Excel them to convete numbers.
//   - Remove references to images that are not included:
//       Example: Original: <TD NOWRAP CLASS=htmldw152FC><IMG SRC="" border="0" CLASS=htmldw152FC  onClick="{return htmldw.itemClicked(0,-1,'compute_11',0,-1);}" ></TD>
//                Replaced: <TD NOWRAP CLASS=htmldw152FC></TD>
//   - Prevent text with / convert to date

dsHTML.InsertRow(1)
dsHTML.setItem( 1, 'fila', ls_CabeceraHTML )

dsHTML.InsertRow(0)
ll_TRow = dsHTML.RowCount()
dsHTML.setItem( ll_TRow, 'fila', ls_PieHTML )

For i = 1 to ll_TRow
    lb_Actualizar = False
    ls_Fila = dsHTML.getItemString( i, 'fila' )

    // Activation of CSS that is disabled by default
    If Pos( ls_Fila, '{;' ) > 0 Then
        ls_Fila = f_sostituisci_carattere( ls_Fila, '{;', '{' )
        lb_Actualizar = True
    End If

    // Visibility
    If Pos( ls_Fila, 'visibility:hidden' ) > 0 or Pos( ls_Fila, 'visibility: hidden' ) > 0 Then
        ll_PosIni = Pos( ls_Fila, '>' )
        ll_PosFin = Pos( ls_Fila, '</' )
        If ll_PosIni > 0 and ll_PosFin > 0 Then
            ls_Valor = Mid( ls_Fila, ll_PosIni + 1, (ll_PosFin - ll_PosIni) - 1 )
            If Len( Trim( ls_Valor ) ) > 0 Then
                ls_Fila = f_sostituisci_carattere( ls_Fila, ls_Valor, Space( Len( ls_Valor ) ) )
                lb_Actualizar = True
            End If
        End If
    End If

    // Number solution in parentheses, excel converts to negative number.
    ll_PosIni = Pos( ls_Fila, '>(' )
    ll_PosFin = Pos( ls_Fila, ')</' )
    If ll_PosIni > 0 and ll_PosFin > 0 Then
        ls_Valor = Mid( ls_Fila, ll_PosIni + 2, (ll_PosFin - ll_PosIni) - 2 )
        If isNumber( ls_Valor ) Then
            ls_Fila = f_sostituisci_carattere( ls_Fila, ">(", ">&nbsp;(" )
            lb_Actualizar = True
        End If
    End If

    // Apply formatting to keep leading zeros
    ll_PosIni = Pos( ls_Fila, '>0' )
    ll_PosFin = Pos( ls_Fila, '</' )
    If ll_PosIni > 0 and ll_PosFin > 0 Then
        ls_Valor = Mid( ls_Fila, ll_PosIni + 1, (ll_PosFin - ll_PosIni) - 1 )
        If isNumber( ls_Valor ) Then
            If Dec( ls_Valor ) > 0 Then
                ls_Fila = f_sostituisci_carattere( ls_Fila, ">0", " " + ls_NumToStr + ">0" )
                lb_Actualizar = True
            End If
        End If
    End If

    // Remove reference to images that are not included:
    ll_PosIni = Pos( ls_Fila, '<IMG SRC=""' )
    ll_PosFin = Pos( ls_Fila, '</' )
    If ll_PosIni > 0 and ll_PosFin > 0 Then
        ls_Valor = Mid( ls_Fila, ll_PosIni, (ll_PosFin - ll_PosIni) )
        If Len( Trim( ls_Valor ) ) > 0 Then
            ls_Fila = f_sostituisci_carattere( ls_Fila, ls_Valor, "" )
            lb_Actualizar = True
        End If
    End If

    // Prevent text with / convert to date
    ll_PosIni = Pos( ls_Fila, '>' )
    ll_PosFin = Pos( ls_Fila, '</' )
    If ll_PosIni > 0 and ll_PosFin > 0 Then
        ls_Valor = Mid( ls_Fila, ll_PosIni + 1, (ll_PosFin - ll_PosIni) - 1 )
//        If f_cuenta_char( ls_Valor, '/' ) = 1 Then //da riattivare
//            ls_Fila = f_sostituisci_carattere( ls_Fila, ">"+ls_Valor, " " + ls_NumToStr + ">"+ls_Valor )
//            lb_Actualizar = True
//        End If
    End If

    If lb_Actualizar Then
        dsHTML.setItem( i, 'fila', ls_Fila )
    End If
Next
spRuta="c:\dati\excelprova.xls"
// Save the "d_FilaFichero" as Txt with .xls extension
dsHTML.SaveAs( spRuta, Text!, FALSE )

// Restore the original CSS datawindow format
dwDatos.Modify("DataWindow.HTMLTable.GenerateCSS='" + ls_GenerateCSS + "'")
dwDatos.Modify("DataWindow.HTMLTable.border='" + ls_Border + "'")
dwDatos.Modify("DataWindow.HTMLTable.nowrap='" + ls_NoWrap + "'")

DESTROY dsHTML
Return 
end event

type dwdatos from udw_000 within w_print_excel
integer y = 1588
integer width = 3355
integer height = 792
integer taborder = 28
boolean bringtotop = true
string dataobject = "d_fat_90_alpa2"
end type

type cb_2 from commandbutton within w_print_excel
boolean visible = false
integer x = 2693
integer y = 32
integer width = 402
integer height = 112
integer taborder = 18
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;dwdatos.settransobject(sqlca)
dw_1.settransobject(sqlca)
dwdatos.retrieve(143603)
dw_1.retrieve(143603)
end event

type cb_salva_excel from commandbutton within w_print_excel
integer x = 3355
integer y = 364
integer width = 402
integer height = 112
integer taborder = 28
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salva Excel"
end type

event clicked;int li_rtn
long ll_excel_rows
string ls_range
oleobject lole_excel, lole_workbook, lole_worksheet, lole_range

lole_excel = create oleobject
li_rtn = lole_excel.ConnectToNewObject("excel.application")
if li_rtn <> 0 then
      MessageBox( "Error", 'Error running MS Excel api.')
      destroy lole_Excel
else
  lole_excel.WorkBooks.Open("C:\nita\excel\fat_alpa.xls") 

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
  lole_workbook.saveas("c:\nita\excel\fat_100.xls", 43)
  // Quit
  lole_excel.application.quit()
  lole_excel.DisconnectObject()

  destroy lole_Excel
end if
end event

