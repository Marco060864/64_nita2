forward
global type w_dw_from_select from Window
end type
type cb_salva_in from commandbutton within w_dw_from_select
end type
type sle_salva_in from singlelineedit within w_dw_from_select
end type
type tab_1 from tab within w_dw_from_select
end type
type tabpage_1 from userobject within tab_1
end type
type cb_oj from commandbutton within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type cb_clear from commandbutton within tabpage_1
end type
type cb_join from commandbutton within tabpage_1
end type
type lb_join from listbox within tabpage_1
end type
type cb_operator from commandbutton within tabpage_1
end type
type ddlb_operator from dropdownlistbox within tabpage_1
end type
type cb_delete from commandbutton within tabpage_1
end type
type cb_rollback from commandbutton within tabpage_1
end type
type cb_update from commandbutton within tabpage_1
end type
type cb_set from commandbutton within tabpage_1
end type
type cb_commit from commandbutton within tabpage_1
end type
type cb_order from commandbutton within tabpage_1
end type
type cb_sort from commandbutton within tabpage_1
end type
type cb_group from commandbutton within tabpage_1
end type
type cb_having from commandbutton within tabpage_1
end type
type cb_where from commandbutton within tabpage_1
end type
type cb_from from commandbutton within tabpage_1
end type
type cb_select from commandbutton within tabpage_1
end type
type dw_new from datawindow within tabpage_1
end type
type mle_1 from multilineedit within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type dw_tables from datawindow within tabpage_1
end type
type dw_columns from datawindow within tabpage_1
end type
type rb_tabular from radiobutton within tabpage_1
end type
type rb_freeform from radiobutton within tabpage_1
end type
type rb_grid from radiobutton within tabpage_1
end type
type rb_sql from radiobutton within tabpage_1
end type
type rb_dwsyntax from radiobutton within tabpage_1
end type
type cb_reset from commandbutton within tabpage_1
end type
type cb_create from commandbutton within tabpage_1
end type
type cb_setup from commandbutton within tabpage_1
end type
type cb_stampa from commandbutton within tabpage_1
end type
type cb_inserisci from commandbutton within tabpage_1
end type
type cb_canc from commandbutton within tabpage_1
end type
type cb_salva from commandbutton within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_dwtype from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_new2 from datawindow within tabpage_2
end type
type tabpage_1 from userobject within tab_1
cb_oj cb_oj
st_1 st_1
cb_clear cb_clear
cb_join cb_join
lb_join lb_join
cb_operator cb_operator
ddlb_operator ddlb_operator
cb_delete cb_delete
cb_rollback cb_rollback
cb_update cb_update
cb_set cb_set
cb_commit cb_commit
cb_order cb_order
cb_sort cb_sort
cb_group cb_group
cb_having cb_having
cb_where cb_where
cb_from cb_from
cb_select cb_select
dw_new dw_new
mle_1 mle_1
st_4 st_4
st_3 st_3
st_2 st_2
dw_tables dw_tables
dw_columns dw_columns
rb_tabular rb_tabular
rb_freeform rb_freeform
rb_grid rb_grid
rb_sql rb_sql
rb_dwsyntax rb_dwsyntax
cb_reset cb_reset
cb_create cb_create
cb_setup cb_setup
cb_stampa cb_stampa
cb_inserisci cb_inserisci
cb_canc cb_canc
cb_salva cb_salva
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_dwtype gb_dwtype
gb_1 gb_1
end type
type tabpage_2 from userobject within tab_1
dw_new2 dw_new2
end type
type tab_1 from tab within w_dw_from_select
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_dw_from_select from Window
int X=0
int Y=0
int Width=3451
int Height=2428
boolean TitleBar=true
string Title="SQL SELECT GENERATOR"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
string Icon="WinLogo!"
cb_salva_in cb_salva_in
sle_salva_in sle_salva_in
tab_1 tab_1
end type
global w_dw_from_select w_dw_from_select

type variables
string is_report_type, is_table, is_operator, is_column
long il_row, id_doc


end variables

forward prototypes
public function string wf_build_sql_syntax ()
public function string wf_build_dw_syntax ()
public subroutine wf_insert_sql (string as_key)
end prototypes

public function string wf_build_sql_syntax ();


string	ls_columns, ls_column, ls_sql_syntax, ls_table, ls_tables
long	ll_rows, ll_index

ll_rows = tab_1.tabpage_1.dw_columns.RowCount ( )

For ll_index = 1 to ll_rows
	If tab_1.tabpage_1.dw_columns.IsSelected(ll_index) Then 
		If ls_columns <> "" Then ls_columns = ls_columns + ", "

      
      ls_table = tab_1.tabpage_1.dw_columns.GetItemString(ll_index, "systable_table_name")
		
		ls_column = tab_1.tabpage_1.dw_columns.GetItemString(ll_index, 1)

		
		ls_columns = ls_columns + ls_table + "." + ls_column
    	
				
	End If
Next

ll_rows = tab_1.tabpage_1.dw_tables.RowCount ( )
For ll_index = 1 to ll_rows
	If tab_1.tabpage_1.dw_tables.IsSelected(ll_index) Then 
		If ls_tables <> "" Then ls_tables = ls_tables + ", "
		ls_table = tab_1.tabpage_1.dw_tables.GetItemString(ll_index, 1)
		ls_tables = ls_tables + ls_table
	End If
Next

If ls_columns <> "" Then		
	
	
	
	
	ls_sql_syntax = " SELECT " + ls_columns + " FROM " + ls_tables
	
	
	
	return ls_sql_syntax
Else
	return ""
End If
end function

public function string wf_build_dw_syntax ();


string	ls_dw_err,	ls_dw_syntax, ls_style,	ls_sql_syntax

ls_style = "style(type=" + is_report_type + ") datawindow(units=2 )"

ls_dw_err = ""

ls_sql_syntax =  wf_build_sql_syntax()
If ls_sql_syntax = "" Then
	return ""
Else
	ls_dw_syntax = SyntaxFromSQL(sqlca, wf_build_sql_syntax(), ls_style, ls_dw_err)
	if ls_dw_err <> "" then
		MessageBox("Errore!", ls_dw_err)
	end if
	return ls_dw_syntax
End If

end function

public subroutine wf_insert_sql (string as_key);string ls_key

tab_1.tabpage_1.mle_1.SelectText(1, Len(tab_1.tabpage_1.mle_1.Text))

ls_key = trim(tab_1.tabpage_1.mle_1.SelectedText ( ))

ls_key = ' ' + ls_key + ' ' + as_key + ' '

tab_1.tabpage_1.mle_1.text = ls_key

tab_1.tabpage_1.mle_1.setfocus()
tab_1.tabpage_1.mle_1.SelectText((Len(tab_1.tabpage_1.mle_1.Text)+1), 0)
end subroutine

event open;s_crea_dw s_c_dw
if isvalid(message.powerobjectparm) then
	s_c_dw=message.powerobjectparm
	tab_1.tabpage_1.mle_1.text=s_c_dw.ls_dw_sintax
	id_doc=s_c_dw.ll_id_doc
end if



tab_1.tabpage_1.cb_salva.enabled    =false
tab_1.tabpage_1.cb_canc.enabled     =false
tab_1.tabpage_1.cb_inserisci.enabled=false
tab_1.tabpage_1.cb_stampa.enabled   =false
tab_1.tabpage_2.enabled  =false

long	ll_ret

is_report_type = "tabular"


sqlca.AutoCommit = True

tab_1.tabpage_1.dw_columns.SetTransObject(sqlca)
tab_1.tabpage_1.dw_tables.SetTransObject(sqlca)


ll_ret = tab_1.tabpage_1.dw_tables.Retrieve( )
if ll_ret < 1 then
	MessageBox ("Il codice di ritorno della Retrieve è:", ll_ret)
end if


end event

on w_dw_from_select.create
this.cb_salva_in=create cb_salva_in
this.sle_salva_in=create sle_salva_in
this.tab_1=create tab_1
this.Control[]={this.cb_salva_in,&
this.sle_salva_in,&
this.tab_1}
end on

on w_dw_from_select.destroy
destroy(this.cb_salva_in)
destroy(this.sle_salva_in)
destroy(this.tab_1)
end on

event close;

sqlca.AutoCommit = False

message.stringparm=tab_1.tabpage_1.mle_1.text


end event

type cb_salva_in from commandbutton within w_dw_from_select
int X=846
int Y=12
int Width=247
int Height=108
int TabOrder=10
string Text="Salva in"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string dwsyntax, ErrorBuffer,ls_commento, ls_nome_dw, ls_salva_in
integer rtncode


ls_commento="DW "+string(today())

ls_nome_dw="d_cast_iva_1"
dwsyntax = tab_1.tabpage_2.dw_new2.Describe("DataWindow.Syntax")
ls_salva_in=sle_salva_in.text
rtncode = LibraryImport(ls_salva_in, ls_nome_dw, ImportDataWindow!, dwsyntax, ErrorBuffer, ls_commento)
end event

type sle_salva_in from singlelineedit within w_dw_from_select
int X=1426
int Y=16
int Width=1207
int Height=92
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="s:\orafo_base\orafo_lega.pbl"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tab_1 from tab within w_dw_from_select
event create ( )
event destroy ( )
int X=23
int Y=20
int Width=3383
int Height=2300
int TabOrder=10
boolean FixedWidth=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=112
int Width=3346
int Height=2172
long BackColor=79741120
string Text="SQL Select"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Custom079!"
cb_oj cb_oj
st_1 st_1
cb_clear cb_clear
cb_join cb_join
lb_join lb_join
cb_operator cb_operator
ddlb_operator ddlb_operator
cb_delete cb_delete
cb_rollback cb_rollback
cb_update cb_update
cb_set cb_set
cb_commit cb_commit
cb_order cb_order
cb_sort cb_sort
cb_group cb_group
cb_having cb_having
cb_where cb_where
cb_from cb_from
cb_select cb_select
dw_new dw_new
mle_1 mle_1
st_4 st_4
st_3 st_3
st_2 st_2
dw_tables dw_tables
dw_columns dw_columns
rb_tabular rb_tabular
rb_freeform rb_freeform
rb_grid rb_grid
rb_sql rb_sql
rb_dwsyntax rb_dwsyntax
cb_reset cb_reset
cb_create cb_create
cb_setup cb_setup
cb_stampa cb_stampa
cb_inserisci cb_inserisci
cb_canc cb_canc
cb_salva cb_salva
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_dwtype gb_dwtype
gb_1 gb_1
end type

on tabpage_1.create
this.cb_oj=create cb_oj
this.st_1=create st_1
this.cb_clear=create cb_clear
this.cb_join=create cb_join
this.lb_join=create lb_join
this.cb_operator=create cb_operator
this.ddlb_operator=create ddlb_operator
this.cb_delete=create cb_delete
this.cb_rollback=create cb_rollback
this.cb_update=create cb_update
this.cb_set=create cb_set
this.cb_commit=create cb_commit
this.cb_order=create cb_order
this.cb_sort=create cb_sort
this.cb_group=create cb_group
this.cb_having=create cb_having
this.cb_where=create cb_where
this.cb_from=create cb_from
this.cb_select=create cb_select
this.dw_new=create dw_new
this.mle_1=create mle_1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_tables=create dw_tables
this.dw_columns=create dw_columns
this.rb_tabular=create rb_tabular
this.rb_freeform=create rb_freeform
this.rb_grid=create rb_grid
this.rb_sql=create rb_sql
this.rb_dwsyntax=create rb_dwsyntax
this.cb_reset=create cb_reset
this.cb_create=create cb_create
this.cb_setup=create cb_setup
this.cb_stampa=create cb_stampa
this.cb_inserisci=create cb_inserisci
this.cb_canc=create cb_canc
this.cb_salva=create cb_salva
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_dwtype=create gb_dwtype
this.gb_1=create gb_1
this.Control[]={this.cb_oj,&
this.st_1,&
this.cb_clear,&
this.cb_join,&
this.lb_join,&
this.cb_operator,&
this.ddlb_operator,&
this.cb_delete,&
this.cb_rollback,&
this.cb_update,&
this.cb_set,&
this.cb_commit,&
this.cb_order,&
this.cb_sort,&
this.cb_group,&
this.cb_having,&
this.cb_where,&
this.cb_from,&
this.cb_select,&
this.dw_new,&
this.mle_1,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_tables,&
this.dw_columns,&
this.rb_tabular,&
this.rb_freeform,&
this.rb_grid,&
this.rb_sql,&
this.rb_dwsyntax,&
this.cb_reset,&
this.cb_create,&
this.cb_setup,&
this.cb_stampa,&
this.cb_inserisci,&
this.cb_canc,&
this.cb_salva,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_dwtype,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.cb_oj)
destroy(this.st_1)
destroy(this.cb_clear)
destroy(this.cb_join)
destroy(this.lb_join)
destroy(this.cb_operator)
destroy(this.ddlb_operator)
destroy(this.cb_delete)
destroy(this.cb_rollback)
destroy(this.cb_update)
destroy(this.cb_set)
destroy(this.cb_commit)
destroy(this.cb_order)
destroy(this.cb_sort)
destroy(this.cb_group)
destroy(this.cb_having)
destroy(this.cb_where)
destroy(this.cb_from)
destroy(this.cb_select)
destroy(this.dw_new)
destroy(this.mle_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_tables)
destroy(this.dw_columns)
destroy(this.rb_tabular)
destroy(this.rb_freeform)
destroy(this.rb_grid)
destroy(this.rb_sql)
destroy(this.rb_dwsyntax)
destroy(this.cb_reset)
destroy(this.cb_create)
destroy(this.cb_setup)
destroy(this.cb_stampa)
destroy(this.cb_inserisci)
destroy(this.cb_canc)
destroy(this.cb_salva)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_dwtype)
destroy(this.gb_1)
end on

type cb_oj from commandbutton within tabpage_1
int X=2679
int Y=288
int Width=366
int Height=80
int TabOrder=60
string Text="&Outer Join"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_key, ls_join, ls_item1, ls_item2, ls_table1, ls_table2

IF lb_join.TotalItems() < 2 THEN return

tab_1.tabpage_1.mle_1.SelectText(1, Len(tab_1.tabpage_1.mle_1.Text))
ls_key = trim(tab_1.tabpage_1.mle_1.SelectedText ( ))

ls_item1 = lb_join.text(1)
ls_item2 = lb_join.text(2)
ls_table1 = Left (ls_item1, (Pos (ls_item1,".")-1)) 
ls_table2 = Left (ls_item2, (Pos (ls_item2,".")-1))

ls_join = "FROM {oj " + ls_table1 + " LEFT OUTER JOIN " + ls_table2 + " ON " + ls_item1 + " = " + ls_item2 + "} "
ls_join = ls_join + "WHERE (" + ls_item1 + " = " + ls_item2 + ") " 

ls_key = replace (ls_key,Pos (ls_key,"FROM"),(Len(ls_key)-(Pos (ls_key,"FROM")-1)),ls_join)


tab_1.tabpage_1.mle_1.text = ls_key

tab_1.tabpage_1.mle_1.setfocus()
tab_1.tabpage_1.mle_1.SelectText((Len(tab_1.tabpage_1.mle_1.Text)+1), 0)


end event

type st_1 from statictext within tabpage_1
int X=27
int Y=48
int Width=594
int Height=60
string Text="Seleziona la Tabella"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_clear from commandbutton within tabpage_1
int X=3067
int Y=288
int Width=229
int Height=80
int TabOrder=50
string Text="C&lear"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;lb_join.reset()
end event

type cb_join from commandbutton within tabpage_1
int X=2290
int Y=288
int Width=366
int Height=80
int TabOrder=20
string Text="&Join"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_key, ls_join, ls_item1, ls_item2

IF lb_join.TotalItems() < 2 THEN return

tab_1.tabpage_1.mle_1.SelectText(1, Len(tab_1.tabpage_1.mle_1.Text))

ls_key = trim(tab_1.tabpage_1.mle_1.SelectedText ( ))


ls_item1 = lb_join.text(1)
ls_item2 = lb_join.text(2)

ls_join = "WHERE (" + ls_item1 + " = " + ls_item2 + ") " 

ls_key = ' ' + ls_key + ' ' + ls_join + ' '

tab_1.tabpage_1.mle_1.text = ls_key

tab_1.tabpage_1.mle_1.setfocus()
tab_1.tabpage_1.mle_1.SelectText((Len(tab_1.tabpage_1.mle_1.Text)+1), 0)


end event

type lb_join from listbox within tabpage_1
int X=2290
int Y=148
int Width=1006
int Height=120
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event dragdrop;IF lb_join.TotalItems() < 2 THEN
	lb_join.additem(is_table + "." + is_column)
END IF



end event

type cb_operator from commandbutton within tabpage_1
int X=2793
int Y=1188
int Width=503
int Height=80
int TabOrder=40
string Text="O&peratore"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql(is_operator)








end event

type ddlb_operator from dropdownlistbox within tabpage_1
int X=2793
int Y=808
int Width=503
int Height=360
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
boolean AllowEdit=true
boolean ShowList=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"=",&
"<",&
">",&
"<=",&
">=",&
"<>",&
"BETWEEN",&
"EXISTS",&
"IN",&
"LIKE",&
"NOT BETWEEN",&
"NOT EXISTS",&
"NOT IN",&
"NOT LIKE",&
"IS",&
"IS NOT",&
"= ALL",&
"!= ALL",&
"< ALL",&
"> ALL",&
"<= ALL",&
">= ALL",&
"= ANY",&
"< ANY",&
"> ANY",&
"<= ANY",&
">= ANY",&
"!= ANY"}
end type

event selectionchanged;is_operator = ddlb_operator.Text(index) 
                                        
													 


end event

type cb_delete from commandbutton within tabpage_1
int X=2427
int Y=1128
int Width=297
int Height=60
int TabOrder=50
string Text="DELETE"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('DELETE')
end event

type cb_rollback from commandbutton within tabpage_1
int X=2427
int Y=1208
int Width=302
int Height=60
int TabOrder=60
string Text="ROLLBACK"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('ROLLBACK')
end event

type cb_update from commandbutton within tabpage_1
int X=2107
int Y=1128
int Width=297
int Height=60
int TabOrder=60
string Text="UPDATE"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('UPDATE')
end event

type cb_set from commandbutton within tabpage_1
int X=2427
int Y=1048
int Width=297
int Height=60
int TabOrder=50
string Text="SET"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('SET')
end event

type cb_commit from commandbutton within tabpage_1
int X=2107
int Y=1208
int Width=297
int Height=60
int TabOrder=50
string Text="COMMIT"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('COMMIT')
end event

type cb_order from commandbutton within tabpage_1
int X=2107
int Y=1048
int Width=302
int Height=60
int TabOrder=50
string Text="ORDER BY"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('ORDER BY')
end event

type cb_sort from commandbutton within tabpage_1
int X=2427
int Y=968
int Width=297
int Height=60
int TabOrder=40
string Text="SORT"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('SORT')
end event

type cb_group from commandbutton within tabpage_1
int X=2107
int Y=968
int Width=297
int Height=60
int TabOrder=30
string Text="GROUP"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('GROUP')
end event

type cb_having from commandbutton within tabpage_1
int X=2427
int Y=888
int Width=297
int Height=60
int TabOrder=40
string Text="HAVING"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('HAVING')
end event

type cb_where from commandbutton within tabpage_1
int X=2107
int Y=888
int Width=297
int Height=60
int TabOrder=30
string Text="WHERE"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('WHERE')
end event

type cb_from from commandbutton within tabpage_1
int X=2427
int Y=808
int Width=297
int Height=60
int TabOrder=30
string Text="FROM"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('FROM')
end event

type cb_select from commandbutton within tabpage_1
int X=2107
int Y=808
int Width=297
int Height=60
int TabOrder=20
string Text="SELECT"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_insert_sql('SELECT')
end event

type dw_new from datawindow within tabpage_1
int X=27
int Y=1368
int Width=3291
int Height=660
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type mle_1 from multilineedit within tabpage_1
int X=27
int Y=768
int Width=2034
int Height=520
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
string Pointer="arrow!"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within tabpage_1
int X=27
int Y=1308
int Width=389
int Height=60
boolean Enabled=false
string Text="DataWindow:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_1
int X=27
int Y=708
int Width=251
int Height=60
boolean Enabled=false
string Text="Sintassi:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tabpage_1
int X=805
int Y=48
int Width=594
int Height=60
string Text="Seleziona le Colonne"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_tables from datawindow within tabpage_1
int X=27
int Y=108
int Width=754
int Height=580
int TabOrder=60
string DataObject="d_table_list"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
end type

event clicked;
long ll_idtable, ll_found, ll_selected
string ls_tablename, ls_table
boolean lb_selected
integer li_conta,li_conta2, li_righe

If row = 0 Then Return



ls_tablename = dw_tables.getitemstring(row, "table_name")
ll_found  = 1
li_conta  = 0
li_conta2 = 0

If dw_tables.IsSelected(row) then       
	dw_tables.SelectRow(row, False)      
	
	
	ls_Table = dw_tables.GetItemString(row, 1)
	
	
	
	
	
   li_righe=dw_columns.rowcount()	    
	FOR li_conta=1 TO li_righe
  		ll_found = dw_columns.Find("systable_table_name = '" + ls_table + "'",1, li_righe)
	   if ll_found > 0 then dw_columns.deleterow(ll_found)
   NEXT

Else
	
	
	lb_selected = false
	li_righe=dw_columns.rowcount()
	    DO WHILE ll_found > 0 and li_conta2 < li_righe
	      ll_found = dw_columns.Find("systable_table_name = '" + is_table + "'",li_conta +1, dw_columns.rowcount())
		   if ll_found > 0 and dw_columns.isselected(ll_found) = false then 
				dw_columns.deleterow(ll_found)
			else
				li_conta++
				lb_selected = true
			end if
			li_conta2++
       LOOP
		 
 
       
      lb_selected = false
      li_righe=dw_columns.rowcount()	    
		FOR li_conta=1 TO li_righe
	  		ll_found = dw_columns.Find("systable_table_name = '" + is_table + "'",1, li_righe)
		   if ll_found > 0 then lb_selected = true
	   NEXT

 
      
      if lb_selected = false then		 
			li_righe=dw_tables.rowcount()	    
			FOR li_conta=1 TO li_righe
	  			ll_found = dw_tables.Find("table_name = '" + is_table + "'",1, li_righe)
			   if ll_found > 0 then dw_tables.SelectRow(ll_found, False)
		   NEXT
		end if
		
	   dw_tables.SelectRow(row, True)
	   is_Table = dw_tables.GetItemString(row, 1)   
      ll_idtable = dw_tables.getitemnumber(row, "table_id") 
      dw_columns.Retrieve(ll_idtable)	

End If



end event

event getfocus;dw_tables.Object.table_name.Background.Color = RGB(255, 255, 128)
end event

event losefocus;dw_tables.Object.table_name.Background.Color = RGB(255, 255, 255)
end event

type dw_columns from datawindow within tabpage_1
int X=805
int Y=108
int Width=1440
int Height=580
int TabOrder=70
string DragIcon="WinLogo!"
string DataObject="d_column_list"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
end type

event clicked;
If row = 0 Then Return	

If dw_columns.IsSelected(row) then
	dw_columns.SelectRow(row, False)
Else
	dw_columns.SelectRow(row, True)
End If

If rb_sql.checked Then
	mle_1.text = wf_build_sql_syntax()
else
	mle_1.text = wf_build_dw_syntax()
End If

il_row = row

IF lb_join.TotalItems() < 2 and dw_columns.isselected(row) = true THEN dw_columns.drag(begin!)

is_Column = dw_columns.GetItemString(il_row, "syscolumn_column_name")
end event

event retrievestart;return 2    
            
end event

event getfocus;dw_columns.Object.systable_table_name.Background.Color = RGB(255, 255, 128)
dw_columns.Object.syscolumn_column_name.Background.Color = RGB(255, 255, 128)
end event

event losefocus;dw_columns.Object.systable_table_name.Background.Color = RGB(255, 255, 255)
dw_columns.Object.syscolumn_column_name.Background.Color = RGB(255, 255, 255)
end event

type rb_tabular from radiobutton within tabpage_1
int X=2290
int Y=528
int Width=274
int Height=60
string Text="&Tabular"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;


if this.checked then is_report_type = "tabular"

If rb_dwsyntax.checked Then
	rb_dwsyntax.triggerevent("clicked")
End If
end on

type rb_freeform from radiobutton within tabpage_1
int X=2290
int Y=448
int Width=297
int Height=60
string Text="&Free Form"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;


if this.checked then is_report_type = "form"

If rb_dwsyntax.checked Then
	rb_dwsyntax.triggerevent("clicked")
End If
end on

type rb_grid from radiobutton within tabpage_1
int X=2290
int Y=608
int Width=251
int Height=60
string Text="&Grid"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;


if this.checked then is_report_type = "grid"

If rb_dwsyntax.checked Then
	rb_dwsyntax.triggerevent("clicked")
End If
end on

type rb_sql from radiobutton within tabpage_1
int X=2679
int Y=468
int Width=183
int Height=60
string Text="S&QL"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
cb_select.enabled=true
cb_where.enabled=true
cb_from.enabled=true
cb_group.enabled=true
cb_set.enabled=true
cb_update.enabled=true
cb_sort.enabled=true
cb_rollback.enabled=true
cb_commit.enabled=true
cb_having.enabled=true
cb_delete.enabled=true
cb_order.enabled=true


mle_1.text = wf_build_sql_syntax ()

end event

type rb_dwsyntax from radiobutton within tabpage_1
int X=2679
int Y=588
int Width=183
int Height=60
string Text="D&W"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;cb_select.enabled=false
cb_where.enabled=false
cb_from.enabled=false
cb_group.enabled=false
cb_set.enabled=false
cb_update.enabled=false
cb_sort.enabled=false
cb_rollback.enabled=false
cb_commit.enabled=false
cb_having.enabled=false
cb_delete.enabled=false
cb_order.enabled=false


mle_1.text = wf_build_dw_syntax()


end event

type cb_reset from commandbutton within tabpage_1
int X=2930
int Y=408
int Width=389
int Height=100
int TabOrder=10
string Text="&Reset"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;mle_1.SelectText(1, Len(mle_1.Text))  
mle_1.cut()  

dw_new.dataobject = ""  
dw_columns.reset()      
dw_tables.reset()
dw_tables.retrieve()

cb_salva.enabled        = false
cb_canc.enabled         = false
cb_inserisci.enabled		= false
cb_stampa.enabled   		= false
tab_1.tabpage_2.enabled	= false
lb_join.reset()

end event

type cb_create from commandbutton within tabpage_1
int X=2930
int Y=528
int Width=389
int Height=160
int TabOrder=20
string Text="Crea &DW"
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
	string 	ls_sql_syntax, ls_style, ls_dw_syntax, ls_dw_err

if id_doc>0 then
	ls_dw_syntax =mle_1.text 
	dw_new.Create(ls_dw_syntax)
	tab_1.tabpage_2.dw_new2.Create(ls_dw_syntax)
else

	
	
	
	
	
	if mle_1.text = "" then
		MessageBox("Attenzione!", "Sintassi non valida. Inserire una sintassi SQL o DW corretta " &
		+ "o selezionare la tabella, le colonne e cliccare su Crea DW")
		Return
	end if
	
	
	
	ls_style = "style(type=" + is_report_type + ")"
	
	
	
	
	If rb_sql.checked Then
		ls_sql_syntax = mle_1.text
		ls_dw_err = ""
		ls_dw_syntax = SyntaxFromSQL(sqlca, ls_sql_syntax, ls_style, ls_dw_err)
		If ls_dw_err <> "" Then
			MessageBox("Attenzione!", ls_dw_err)
			Return
		End If
		dw_new.Create(ls_dw_syntax)
		tab_1.tabpage_2.dw_new2.Create(ls_dw_syntax)
	Else
		dw_new.Create(mle_1.text)
		tab_1.tabpage_2.dw_new2.Create(mle_1.text)	
	End If
end if
	
dw_new.SetTransObject(sqlca)
dw_new.Retrieve( )

dw_new.RowsCopy(1, dw_new.RowCount(), Primary!, tab_1.tabpage_2.dw_new2, 1, Primary!)
tab_1.tabpage_2.dw_new2.Object.DataWindow.Print.preview = "YES"  

cb_salva.enabled    =true
cb_canc.enabled     =true
cb_inserisci.enabled=true
cb_stampa.enabled   =true
tab_1.tabpage_2.enabled  =true

mle_1.setfocus()  

end event

type cb_setup from commandbutton within tabpage_1
int X=2839
int Y=2048
int Width=480
int Height=100
int TabOrder=130
string Text="S&etup stampante..."
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup() 
end event

type cb_stampa from commandbutton within tabpage_1
int X=987
int Y=2048
int Width=297
int Height=100
int TabOrder=120
string Text="Sta&mpa"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer li_risp

li_risp = MessageBox("Richiesta di stampa...","Confermi la stampa?"  , &
Question!, YesNo!, 1)


if li_risp = 1 then dw_new.print()  
                                    
                                            
								 
end event

type cb_inserisci from commandbutton within tabpage_1
int X=667
int Y=2048
int Width=297
int Height=100
int TabOrder=110
string Text="&Inserisci"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_CurRow

ll_CurRow = dw_new.insertrow(0)
dw_new.scrolltorow(ll_currow)
dw_new.setcolumn(1)
dw_new.Setfocus()
end event

type cb_canc from commandbutton within tabpage_1
int X=347
int Y=2048
int Width=297
int Height=100
int TabOrder=100
string Text="&Cancella"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int li_risp, li_current

li_current = dw_new.getrow()

IF li_current > 0 THEN

   li_risp = messagebox("Conferma cancellazione","Vuoi cancellare la riga?",question!,yesnocancel!,3)

	CHOOSE CASE li_risp
		CASE 1
			dw_new.deleterow(dw_new.getrow())   
			                                        
															 
		   dw_new.update()                       
		
		CASE 3
			return 1
	END CHOOSE


END IF
end event

type cb_salva from commandbutton within tabpage_1
int X=27
int Y=2048
int Width=297
int Height=100
int TabOrder=90
string Text="&Salva"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_new.accepttext()
dw_new.update()

end event

type gb_4 from groupbox within tabpage_1
int X=2267
int Y=88
int Width=1051
int Height=300
int TabOrder=30
string Text="Join"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within tabpage_1
int X=2770
int Y=748
int Width=549
int Height=540
int TabOrder=50
string Text="Lista Operatori"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within tabpage_1
int X=2085
int Y=748
int Width=663
int Height=540
int TabOrder=80
string Text="SQL Key Words"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_dwtype from groupbox within tabpage_1
int X=2267
int Y=388
int Width=366
int Height=300
int TabOrder=30
string Text="DW"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within tabpage_1
int X=2656
int Y=388
int Width=251
int Height=300
int TabOrder=40
string Text="Tipo"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_2 from userobject within tab_1
int X=18
int Y=112
int Width=3346
int Height=2172
long BackColor=79741120
string Text="Preview"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Custom001!"
dw_new2 dw_new2
end type

on tabpage_2.create
this.dw_new2=create dw_new2
this.Control[]={this.dw_new2}
end on

on tabpage_2.destroy
destroy(this.dw_new2)
end on

type dw_new2 from datawindow within tabpage_2
int X=27
int Y=28
int Width=3291
int Height=2100
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

