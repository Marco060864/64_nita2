forward
global type w_search_main from window
end type
type cb_cerca from commandbutton within w_search_main
end type
type dw_lista from u_dw_search_main within w_search_main
end type
type sle_showsort from singlelineedit within w_search_main
end type
type cb_modi from commandbutton within w_search_main
end type
type cb_nuovo from commandbutton within w_search_main
end type
type cb_annulla from commandbutton within w_search_main
end type
type cb_ok from commandbutton within w_search_main
end type
type st_3 from statictext within w_search_main
end type
type sle_ricerca from singlelineedit within w_search_main
end type
type sle_filtro from singlelineedit within w_search_main
end type
type st_2 from statictext within w_search_main
end type
type st_1 from statictext within w_search_main
end type
type ddlb_tiposel from dropdownlistbox within w_search_main
end type
end forward

global type w_search_main from window
integer x = 832
integer y = 360
integer width = 3200
integer height = 1800
boolean titlebar = true
string title = "Ricerca generica (da istanziare!)"
boolean resizable = true
windowtype windowtype = response!
long backcolor = 79741120
event ue_posiziona ( integer ai_come )
event ue_help ( helpcommand ae_hcom,  long al_helpid,  string as_helpkey )
event ue_comment ( )
cb_cerca cb_cerca
dw_lista dw_lista
sle_showsort sle_showsort
cb_modi cb_modi
cb_nuovo cb_nuovo
cb_annulla cb_annulla
cb_ok cb_ok
st_3 st_3
sle_ricerca sle_ricerca
sle_filtro sle_filtro
st_2 st_2
st_1 st_1
ddlb_tiposel ddlb_tiposel
end type
global w_search_main w_search_main

type variables
long		il_helptopic = 0
integer		ii_min_x, ii_min_y	
boolean		ib_may_close	
s_ric_param 	istr_ric
string		is_Helpkey

end variables

forward prototypes
public function string wf_scan_filtro (string as_value)
end prototypes

event ue_posiziona;string ls_findpar, ls_testo, ls_coltype
long ll_maxrows, ll_curRow, ll_newRow


ls_coltype = dw_lista.describe(dw_lista.is_last_column+".coltype")
ls_testo = sle_ricerca.text
CHOOSE CASE Mid(ls_coltype,1,5)
	CASE "char("
		ls_findpar = dw_lista.is_last_column+" >= "+char(39)+ls_testo+char(39)
	CASE "long"
		if ls_testo = "" then ls_testo = "0"
		ls_findpar = dw_lista.is_last_column+" >= "+ ls_testo
	CASE "date"
		ls_findpar = " "
	CASE "datet"
		ls_findpar = " "
	CASE "decim"
		if ls_testo = "" then ls_testo = "0"
		ls_findpar = dw_lista.is_last_column+" >= "+ ls_testo
	CASE ELSE
		ls_findpar = " "
END CHOOSE

ll_maxrows = dw_lista.RowCount()
ll_curRow = dw_lista.il_last_row
ll_curRow = 0
ll_newRow = dw_lista.find(ls_findpar,ll_curRow,ll_maxrows)
if ll_newRow > 0 then
	dw_lista.ScrollToRow(ll_newRow)
	dw_lista.il_last_row = ll_newRow
end if

end event

event ue_help;if ae_Hcom = Keyword! then
	ShowHelp(u_freddie.is_helpfile, Keyword!, as_HelpKey)
else
	if ae_Hcom = Topic! then
		ShowHelp(u_freddie.is_helpfile, Topic!, al_HelpId)
	end if
end if

end event

public function string wf_scan_filtro (string as_value);
long		ll_pos
char		lc_array[]
integer	li_i,li_size
string	ls_value 

ls_value	= as_value

ll_pos	= Pos( ls_value,"'" )

if ll_pos > 0 then
	ls_value	= Mid( ls_value,0,ll_pos - 1 )
	if ls_value <> as_value then
		sle_filtro.text = ls_value
	end if
end if	

return ls_value

end function

on w_search_main.create
this.cb_cerca=create cb_cerca
this.dw_lista=create dw_lista
this.sle_showsort=create sle_showsort
this.cb_modi=create cb_modi
this.cb_nuovo=create cb_nuovo
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.st_3=create st_3
this.sle_ricerca=create sle_ricerca
this.sle_filtro=create sle_filtro
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_tiposel=create ddlb_tiposel
this.Control[]={this.cb_cerca,&
this.dw_lista,&
this.sle_showsort,&
this.cb_modi,&
this.cb_nuovo,&
this.cb_annulla,&
this.cb_ok,&
this.st_3,&
this.sle_ricerca,&
this.sle_filtro,&
this.st_2,&
this.st_1,&
this.ddlb_tiposel}
end on

on w_search_main.destroy
destroy(this.cb_cerca)
destroy(this.dw_lista)
destroy(this.sle_showsort)
destroy(this.cb_modi)
destroy(this.cb_nuovo)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.st_3)
destroy(this.sle_ricerca)
destroy(this.sle_filtro)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_tiposel)
end on

event open;
string		ls_tmp1

ii_min_x = 1578
ii_min_y = 1257
dw_lista.ii_tipo_sel = 1

istr_ric = Message.PowerObjectParm
ib_may_close = false
u_freddie.center_window(this)


dw_lista.is_ricpar = istr_ric
If istr_ric.b_asneeded then
	dw_lista.Object.DataWindow.Retrieve.AsNeeded = "Yes"
else
	dw_lista.Object.DataWindow.Retrieve.AsNeeded = "No"
end if
dw_lista.is_last_column = istr_ric.s_filter_name
ls_tmp1 = istr_ric.s_filter_name+"_t"							

dw_lista.is_last_coldesc = string(dw_lista.describe(ls_tmp1+".text"))		
dw_lista.is_last_sort = "A"
dw_lista.is_last_dbname = string(dw_lista.Describe(istr_ric.s_filter_name+".dbName"))
dw_lista.is_last_coltype = string(dw_lista.Describe(istr_ric.s_filter_name+".coltype"))

if Left(dw_lista.is_last_coltype ,4) <> "char" then
	ddlb_tiposel.DeleteItem(1)
	ddlb_tiposel.InsertItem("Maggiore o uguale a ",1)
	ddlb_tiposel.DeleteItem(2)
	ddlb_tiposel.InsertItem("Uguale a",2)
	ddlb_tiposel.DeleteItem(3)
	ddlb_tiposel.InsertItem("Minore o uguale a ",3)
end if
ddlb_tiposel.SelectItem(1)
dw_lista.setcolumn(istr_ric.s_filter_name)
if istr_ric.s_filter_value>"" then
	sle_filtro.text = istr_ric.s_filter_value
	dw_lista.is_val_sel = istr_ric.s_filter_value
	dw_lista.trigger event ue_change_col (false)
end if

if ((istr_ric.b_imm_insert) and (dw_lista.is_resp_window <> ""))  then
	sle_filtro.text = ""
	cb_nuovo.postevent(clicked!)
else
	if ((istr_ric.b_imm_maint) and (dw_lista.is_resp_window <> ""))then
		cb_cerca.postevent(clicked!)
		cb_modi.postevent(clicked!)
	else
		if ((istr_ric.b_imm_retrieve) or (istr_ric.s_sql_cond>" ") or (istr_ric.s_filter_value>" ") )then
			cb_cerca.postevent(clicked!)
		end if
	end if
end if
	
if dw_lista.is_resp_window = "" then
	cb_modi.enabled = false
	cb_modi.visible = false
	cb_nuovo.enabled = false
	cb_nuovo.visible = false
end if

sle_filtro.setfocus()

end event

event resize;// 20261111 i controlli si dispongono sulla area interna (newwidth/newheight),
// non su width/height che comprendono bordi e barra del titolo: con PB 2025
// e lo zoom di Windows i bordi sono piu grossi e la finestra tagliava a destra e sotto
long ll_dx
if newwidth<ii_min_x then width = ii_min_x
if newheight<ii_min_y then height = ii_min_y
ll_dx = newwidth - 40
dw_lista.width = ll_dx - dw_lista.x
sle_showsort.width = ll_dx - sle_showsort.x
cb_annulla.x = ll_dx - cb_annulla.width
cb_cerca.x = cb_annulla.x
sle_ricerca.width = cb_cerca.x - 30 - sle_ricerca.x
sle_filtro.width = ll_dx - sle_filtro.x
cb_ok.x = cb_annulla.x - cb_ok.width - 30
cb_nuovo.y = newheight - cb_nuovo.height - 30
cb_annulla.y = cb_nuovo.y
cb_ok.y = cb_nuovo.y
cb_modi.y = cb_nuovo.y
sle_showsort.y = cb_nuovo.y - sle_showsort.height - 30
dw_lista.height = sle_showsort.y - 30 - dw_lista.y
end event

event key;
GraphicObject		which_control
SingleLineEdit		sle_which
int					li_come
string				ls_nome


if ((key=KeyF12!) and (keyflags=3)) then
	ls_nome = this.ClassName()
	MessageBox ("ClassName",ls_nome)
else
	
	if (key = KeyF1!) then 
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			This.Event ue_help(Topic!, il_HelpTopic, "")
		end if
	end if

	
	if ((key=Keyadd!) and (keyFlags=2)) then
		if dw_lista.is_resp_window<>"" then
			Triggerevent("ue_insert")
		end if
	else
		which_control = GetFocus( ) 
		CHOOSE CASE TypeOf(which_control)
			CASE SingleLineEdit!
				sle_which = which_control
				li_come = 0
				if sle_which = sle_ricerca then
					if ((key=keyback!) or (key=keydelete!)) then
						li_come = 1
						
						
						
						post event ue_posiziona (li_come)
					elseif (key=keyuparrow!) then
						dw_lista.ScrollPriorRow()
					elseif (key=keydownarrow!) then
						dw_lista.ScrollNextRow()
					elseif (key=keypagedown!) then
						dw_lista.ScrollNextPage()
					elseif (key=keypageup!) then
						dw_lista.ScrollPriorPage()
					elseif (key=keyhome!) then
						dw_lista.ScrollToRow(1)
					elseif (key=keyend!) then
						dw_lista.ScrollToRow(dw_lista.RowCount())
					elseif (key=keyenter!) then
						cb_ok.postevent(Clicked!)
						
					else 
						post event ue_posiziona (li_come)
					end if
				end if
				if sle_which = sle_filtro then
					if (key=keyenter!) then cb_cerca.triggerevent(Clicked!)
				end if
		END CHOOSE
	end if
end if

return 0

end event

event closequery;if ib_may_close then return 0 else return 1
end event

type cb_cerca from commandbutton within w_search_main
integer x = 1257
integer y = 180
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerca"
end type

event clicked;long		ll_retval   
string	ls_value

ll_retval = 0
dw_lista.ib_havetoscan = true

ls_value	= sle_filtro.text
sle_showsort.text = dw_lista.is_last_coldesc+ " "+ ddlb_tiposel.text+" "+ls_value

dw_lista.is_val_sel = ls_value

ll_retval = dw_lista.event ue_retrieve()
if ll_retval < 0 then
	sle_filtro.text = ""
	sle_showsort.text = ""
end if
sle_ricerca.text = ""
sle_ricerca.setfocus()

end event

type dw_lista from u_dw_search_main within w_search_main
integer x = 320
integer y = 280
integer width = 1175
integer height = 592
integer taborder = 50
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_change_col;call super::ue_change_col;

string		ls_temp, ls_car
integer		li_i

if ib_reset then sle_filtro.text = ""

sle_ricerca.setfocus()
ls_temp = ""
for li_i = 1 to len(dw_lista.is_last_coldesc)
	ls_car = mid(dw_lista.is_last_coldesc,li_i,1)
	if asc(ls_car) < 32 then
		ls_temp = ls_temp+" "
	else
		ls_temp = ls_temp+ls_car
	end if
next

sle_showsort.text = ls_temp+ " "+ ddlb_tiposel.text+" "+sle_filtro.text

end event

event ue_return_values;call super::ue_return_values;
parent.ib_may_close = true

end event

event ue_insert;call super::ue_insert;sle_ricerca.setfocus()
return 0

end event

event ue_modify;call super::ue_modify;sle_ricerca.setfocus()

end event

type sle_showsort from singlelineedit within w_search_main
integer x = 320
integer y = 900
integer width = 1184
integer height = 84
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "SELEZIONA PRIMA UNA COLONNA!"
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_modi from commandbutton within w_search_main
integer x = 617
integer y = 1040
integer width = 302
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Modifica..."
end type

event clicked;dw_lista.Triggerevent("ue_modify")

end event

type cb_nuovo from commandbutton within w_search_main
integer x = 320
integer y = 1040
integer width = 270
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Nuovo..."
end type

event clicked;dw_lista.Triggerevent("ue_insert")
end event

type cb_annulla from commandbutton within w_search_main
integer x = 1257
integer y = 1040
integer width = 247
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;

s_ric_param lstr_ric
istr_ric = lstr_ric

parent.ib_may_close = true
CloseWithReturn (parent,istr_ric)

end event

type cb_ok from commandbutton within w_search_main
integer x = 983
integer y = 1040
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;
if (dw_lista.rowcount()>0) then
	
	
	
	
	
	if dw_lista.getrow()>0 then 
		dw_lista.triggerevent("ue_return_values")
		istr_ric = dw_lista.is_ricpar
	   
	   CloseWithReturn (parent,istr_ric)
	
   else
	  messagebox('Attenzione', 'Nessuna riga è stata selezionata')
   end if
end if
end event

type st_3 from statictext within w_search_main
integer x = 46
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Lista:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_ricerca from singlelineedit within w_search_main
integer x = 320
integer y = 180
integer width = 910
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_filtro from singlelineedit within w_search_main
integer x = 891
integer y = 60
integer width = 613
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_search_main
integer x = 46
integer y = 68
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Selezione:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_search_main
integer x = 46
integer y = 188
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ricerca:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_tiposel from dropdownlistbox within w_search_main
integer x = 320
integer y = 60
integer width = 544
integer height = 384
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Inizia per","Contiene","Termina per","Uguale"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
dw_lista.ii_tipo_sel = index

sle_showsort.text = dw_lista.is_last_coldesc+ " "+ this.text+" "+sle_filtro.text
sle_filtro.setfocus()

end event

