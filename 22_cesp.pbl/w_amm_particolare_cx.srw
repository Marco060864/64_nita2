forward
global type w_amm_particolare_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_amm_particolare_cx
end type
type tab_1 from tab within w_amm_particolare_cx
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from u_dw_ext_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_remove_all from commandbutton within tabpage_2
end type
type cb_remove_many from commandbutton within tabpage_2
end type
type cb_drop_many from commandbutton within tabpage_2
end type
type cb_drop_all from commandbutton within tabpage_2
end type
type dw_3 from u_dw_ext_main within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type em_1 from editmask within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type cb_salva from commandbutton within tabpage_2
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
cb_remove_all cb_remove_all
cb_remove_many cb_remove_many
cb_drop_many cb_drop_many
cb_drop_all cb_drop_all
dw_3 dw_3
dw_2 dw_2
em_1 em_1
st_1 st_1
cb_salva cb_salva
end type
type tab_1 from tab within w_amm_particolare_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_amm_particolare_cx from w_wiz_main
int X=430
int Y=224
int Width=2647
int Height=1584
WindowType WindowType=response!
boolean TitleBar=true
string Title="Ammortamenti Particolari"
long BackColor=78748035
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_chiudi cb_chiudi
tab_1 tab_1
end type
global w_amm_particolare_cx w_amm_particolare_cx

type variables
datawindow idw_filtro, idw_param, idw_source, idw_target
long il_id_sog_commerciale
Boolean ib_removing, ib_down_source, ib_down_target

long il_array[] 

s_list_main is_insoluti 
date ld_data_reg
end variables

forward prototypes
public subroutine uf_drop (long al_row_source)
public subroutine uf_drop_all ()
public subroutine uf_drop_many ()
public subroutine uf_remove (long al_row_target)
public subroutine uf_remove_all ()
public subroutine uf_remove_many ()
end prototypes

public subroutine uf_drop (long al_row_source);long ll_id_cespite, ll_find
string ls_search
ll_id_cespite         = idw_source.GetItemNumber(al_row_source, "id_cespite")
ls_search = "id_cespite = " + string(ll_id_cespite)
ll_find = idw_target.find(ls_search, 1, idw_target.RowCount())

IF ll_find = 0  THEN
	tab_1.tabpage_2.dw_2.RowsCopy(al_row_source, al_row_source, Primary!, tab_1.tabpage_2.dw_3, 1, Primary!)
end if
end subroutine

public subroutine uf_drop_all ();

long ll_Rows, ll_i, ll_CurrRow

ll_Rows = idw_source.RowCount()

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	uf_drop(ll_i)
NEXT

idw_target.Sort()

ib_removing = FALSE
end subroutine

public subroutine uf_drop_many ();

long ll_Rows, ll_i

ll_Rows = idw_source.RowCount()
ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_source.IsSelected(ll_i) THEN
		uf_drop(ll_i)
	END IF
NEXT

idw_target.Sort()

ib_removing = FALSE
end subroutine

public subroutine uf_remove (long al_row_target);
idw_target.SetRow(al_row_target)
idw_target.DeleteRow(0)
end subroutine

public subroutine uf_remove_all ();

long ll_Rows, ll_i

ll_Rows = idw_target.RowCount()

ib_removing = TRUE
FOR ll_i = ll_Rows TO 1 STEP -1
	uf_remove(ll_i)
NEXT
idw_source.Sort()
ib_removing = FALSE
end subroutine

public subroutine uf_remove_many ();

long ll_Rows, ll_i

ll_Rows = idw_target.RowCount()

ib_removing = TRUE
FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_target.IsSelected(ll_i) THEN
		uf_remove(ll_i)
	END IF
NEXT


idw_source.Sort()

idw_target.SelectRow(0, FALSE)
idw_target.Sort()
ib_removing = FALSE
end subroutine

on w_amm_particolare_cx.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.tab_1
end on

on w_amm_particolare_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.tab_1)
end on

event open;call super::open;
integer li_ret
long ll_valuta
il_HelpTopic = 276


idw_filtro = tab_1.tabpage_1.dw_1
idw_source = tab_1.tabpage_2.dw_2
idw_target = tab_1.tabpage_2.dw_3

IF idw_filtro.GetRow() = 0 THEN idw_filtro.InsertRow(0)

idw_source.SetTransObject(SQLCA)
idw_source.retrieve()
idw_target.SetTransObject(SQLCA)
end event

type cb_chiudi from commandbutton within w_amm_particolare_cx
int X=2354
int Y=28
int Width=247
int Height=84
int TabOrder=20
string Text="&Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type tab_1 from tab within w_amm_particolare_cx
int X=32
int Y=152
int Width=2574
int Height=1312
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
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

event selectionchanging;
IF newindex = 2 THEN
		tab_1.tabpage_1.dw_1.Event ue_setup_filter()	
END IF	


end event

type tabpage_1 from userobject within tab_1
int X=18
int Y=104
int Width=2537
int Height=1192
long BackColor=78748035
string Text="Parametri"
long TabBackColor=78748035
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_ext_main within tabpage_1
event ue_setup_filter ( )
int X=32
int Y=40
int Width=2459
int Height=1128
string DataObject="d_amm_part_ff"
boolean TitleBar=true
string Title="Filtro Cespiti"
end type

event ue_setup_filter;integer li_RetVal
long ll_currrow
string ls_filter, ls_da_cespite, ls_a_cespite, ls_da_cat, ls_a_cat

constant string LCS_AND = " AND "

ll_CurrRow = THIS.GetRow()
THIS.AcceptText()
ls_filter = ""

IF ll_CurrRow > 0 THEN
	
	ls_da_cespite = THIS.GetItemstring(ll_CurrRow, "da_cod")
	IF IsNull(ls_da_cespite) THEN	ls_da_cespite='AAAAAAAA'
	ls_a_cespite = THIS.GetItemstring(ll_CurrRow, "a_cod")
	IF IsNull(ls_a_cespite)  THEN	ls_a_cespite='ZZZZZZZZ'		
	ls_da_cat = THIS.GetItemstring(ll_CurrRow, "da_cod_cat")
	IF IsNull(ls_da_cat) THEN	ls_da_cat='AAAAAAAA'
	ls_a_cat = THIS.GetItemstring(ll_CurrRow, "a_cod_cat")
	IF IsNull(ls_a_cat)  THEN	ls_a_cat='ZZZZZZZZ'		
	
	ls_filter = "(codice >='" + ls_da_cespite + "')" + lcs_and + "(codice <='" + ls_a_cespite + "')"
	ls_filter = ls_filter + lcs_and + "(cat_codice >='" + ls_da_cat + "')" + lcs_and + "(cat_codice <='" + ls_a_cat + "')"	
	
	li_RetVal = idw_source.SetFilter(ls_filter)
	li_RetVal = idw_source.Filter()
END IF
end event

event itemchanged;string ls_filtro, ls_colonna
integer li_ok
long ll_es
date ld_d1, ld_d2
string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

setnull(ls_null)

CHOOSE CASE dwo.name
		
	CASE "da_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_cod", Data)			
           This.SetItem(1, "a_des", This.GetItemString(1, "da_des"))
         end if
			RETURN 2
		END IF
		
		
	case "da_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_des", Data)			
           This.SetItem(1, "a_cod", This.GetItemString(1, "da_cod"))
         end if
			RETURN 2
		END IF

	case "a_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "da_cod_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
       	  This.SetItem(1, "a_cod_cat", Data)			
           This.SetItem(1, "a_des_cat", This.GetItemString(1, "da_des_cat"))
         end if
			RETURN 2
		END IF
		
		
	case "da_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
       	  This.SetItem(1, "a_des_cat", Data)			
           This.SetItem(1, "a_cod_cat", This.GetItemString(1, "da_cod_cat"))
         end if
			RETURN 2
		END IF

	case "a_cod_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose

end event

event ue_set_search;string ls_cond

CHOOSE CASE as_nomecol
	CASE "a_cod", "a_des"
		is_search_window = "w_cespite_sw"

		IF as_nomecol = "a_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
		END IF

	CASE "da_cod", "da_des"
		is_search_window = "w_cespite_sw"

		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
		END IF
		
	CASE "a_cod_cat", "a_des_cat"
		is_search_window = "w_cat_int_cespite_sw"

		IF as_nomecol = "a_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_codice"
		ELSEIF as_nomecol = "a_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_descrizione"
		END IF

	CASE "da_cod_cat", "da_des_cat"
		is_search_window = "w_cat_int_cespite_sw"

		IF as_nomecol = "da_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_codice"
		ELSEIF as_nomecol = "da_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_descrizione"
		END IF

END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)

		uf_set_colval("a_des", is_ricpar.s_ausil_value[1])

	CASE "a_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)

		uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	
	CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)

		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_cod', is_ricpar.s_main_value)
        uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
	   end if
	
	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_des', is_ricpar.s_main_value)
        uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	   end if		

	CASE "a_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])

	CASE "a_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])
	
	CASE "da_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_des_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
        uf_set_colval('a_cod_cat', is_ricpar.s_main_value)
        uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])
	   end if
	
	CASE "da_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
        uf_set_colval('a_des_cat', is_ricpar.s_main_value)
        uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])
	   end if		

END CHOOSE








end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2537
int Height=1192
long BackColor=78748035
string Text="Cespiti"
long TabBackColor=78748035
long TabTextColor=33554432
long PictureMaskColor=553648127
cb_remove_all cb_remove_all
cb_remove_many cb_remove_many
cb_drop_many cb_drop_many
cb_drop_all cb_drop_all
dw_3 dw_3
dw_2 dw_2
em_1 em_1
st_1 st_1
cb_salva cb_salva
end type

on tabpage_2.create
this.cb_remove_all=create cb_remove_all
this.cb_remove_many=create cb_remove_many
this.cb_drop_many=create cb_drop_many
this.cb_drop_all=create cb_drop_all
this.dw_3=create dw_3
this.dw_2=create dw_2
this.em_1=create em_1
this.st_1=create st_1
this.cb_salva=create cb_salva
this.Control[]={this.cb_remove_all,&
this.cb_remove_many,&
this.cb_drop_many,&
this.cb_drop_all,&
this.dw_3,&
this.dw_2,&
this.em_1,&
this.st_1,&
this.cb_salva}
end on

on tabpage_2.destroy
destroy(this.cb_remove_all)
destroy(this.cb_remove_many)
destroy(this.cb_drop_many)
destroy(this.cb_drop_all)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_salva)
end on

type cb_remove_all from commandbutton within tabpage_2
event clicked pbm_bnclicked
int X=1170
int Y=756
int Width=178
int Height=88
int TabOrder=13
string Text="<<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_remove_all()
end event

type cb_remove_many from commandbutton within tabpage_2
event clicked pbm_bnclicked
int X=1170
int Y=616
int Width=178
int Height=88
int TabOrder=12
string Text="<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_remove_many()
end event

type cb_drop_many from commandbutton within tabpage_2
event clicked pbm_bnclicked
int X=1170
int Y=436
int Width=178
int Height=88
int TabOrder=11
string Text=">"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_drop_many()
end event

type cb_drop_all from commandbutton within tabpage_2
event clicked pbm_bnclicked
int X=1170
int Y=296
int Width=178
int Height=88
int TabOrder=31
string Text=">>"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_drop_all()
end event

type dw_3 from u_dw_ext_main within tabpage_2
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
int X=1381
int Y=40
int Width=1120
int Height=1000
int TabOrder=10
string DataObject="d_amm_part_gd"
boolean TitleBar=true
string Title="Selezionate"
boolean HScrollBar=true
boolean VScrollBar=true
string Icon="None!"
end type

event ue_buttonup;call super::ue_buttonup;ib_down_target = FALSE
end event

event ue_buttondown;call super::ue_buttondown;ib_down_target = TRUE
end event

event ue_mousemove;call super::ue_mousemove;IF idw_target.GetRow () > 0 AND &
	ib_down_target = TRUE THEN
	idw_target.Drag (begin!)
	idw_target.DragIcon = 'Application!'
END IF

end event

event clicked;call super::clicked;long ll_RetVal

IF KeyDown(KeyControl!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

IF KeyDown(KeyShift!) OR (row = THIS.GetRow()) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event dragdrop;call super::dragdrop;DragObject ldo_source
DataWindow ldw_source

ldo_source = DraggedObject()

CHOOSE CASE TypeOf(ldo_source)
	CASE DataWindow!
		ldw_source = ldo_source
		IF ldw_source.DataObject = "d_insoluti_scadenze_gd" AND (ib_down_source = TRUE) THEN
			
			uf_drop_many()
		END IF
END CHOOSE

end event

event dragenter;call super::dragenter;IF ib_down_source = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF
end event

event dragleave;call super::dragleave;IF ib_down_source = TRUE THEN
	idw_source.DragIcon = 'Application!'
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;

IF ib_removing = FALSE THEN
	IF NOT KeyDown(KeyControl!) AND NOT KeyDown(KeyShift!) THEN
		SelectRow(0,FALSE)
		SelectRow(currentrow, TRUE)
	END IF
	
	IF KeyDown(KeyShift!) THEN
		SelectRow(currentrow, NOT THIS.IsSelected(currentrow))
	END IF
END IF
end event

type dw_2 from datawindow within tabpage_2
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
int X=23
int Y=40
int Width=1111
int Height=992
int TabOrder=1
string DataObject="d_amm_part_gd"
boolean TitleBar=true
string Title="Disponibili"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="None!"
end type

event ue_buttonup;ib_down_source = FALSE
end event

event ue_buttondown;ib_down_source = TRUE
end event

event ue_mousemove;IF idw_source.GetRow () > 0 AND &
	ib_down_source = TRUE THEN
	idw_source.Drag (begin!)
	idw_source.DragIcon = 'Application!'
END IF

end event

event clicked;long ll_RetVal

IF KeyDown(KeyControl!) OR KeyDown(KeyShift!) OR (row = THIS.GetRow()) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event dragdrop;IF ib_down_target = TRUE THEN
	uf_remove_many()
END IF

end event

event dragenter;IF ib_down_source = TRUE THEN
	idw_source.DragIcon = 'Application!'
END IF

IF ib_down_target = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF
end event

event dragleave;IF ib_down_target = TRUE THEN
	idw_source.DragIcon = 'Application!'
END IF
end event

event rowfocuschanged;

IF ib_removing = FALSE THEN
	IF NOT KeyDown(KeyControl!) AND NOT KeyDown(KeyShift!) THEN
		SelectRow(0,FALSE)
		SelectRow(currentrow, TRUE)
	END IF
	
	IF KeyDown(KeyShift!) THEN
		SelectRow(currentrow, NOT THIS.IsSelected(currentrow))
	END IF
END IF
end event

type em_1 from editmask within tabpage_2
int X=837
int Y=1064
int Width=325
int Height=96
int TabOrder=23
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="#,0.00"
boolean Spin=true
string MinMax="0~~100"
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within tabpage_2
int X=32
int Y=1076
int Width=791
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="% ammortamento particolare:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_salva from commandbutton within tabpage_2
int X=1385
int Y=1056
int Width=1115
int Height=108
int TabOrder=33
boolean BringToTop=true
string Text="Salva Ammortamento Particolare"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row, ll_cespite
integer i, li_ret
decimal ld_perc

ll_row=dw_3.rowcount()
ld_perc=dec(em_1.text)

FOR i=1 TO ll_row
	dw_3.setitemstatus(i,0, primary!, datamodified!)
	dw_3.setitem(i,"cespite_amm_particolare", ld_perc)
NEXT
li_ret=dw_3.update()
if li_ret=1 then
	commit;
	messagebox("OK!", "Ammortamento particolare salvato correttamente!")
else
	messagebox("Errore!", "Ammortamento non salvato!")
	rollback;
end if
end event

