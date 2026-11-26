forward
global type w_contropartita_wz from w_wiz_main
end type
type cb_annulla from commandbutton within w_contropartita_wz
end type
type cb_ok from commandbutton within w_contropartita_wz
end type
type dw_contropartita_ext_gd from u_dw_ext_main within w_contropartita_wz
end type
end forward

global type w_contropartita_wz from w_wiz_main
int X=833
int Y=373
int Width=2743
int Height=1181
WindowType WindowType=response!
boolean TitleBar=true
string Title="Righe concorrenti alla Contropartita"
event ue_load_righe ( )
event ue_set_title ( )
cb_annulla cb_annulla
cb_ok cb_ok
dw_contropartita_ext_gd dw_contropartita_ext_gd
end type
global w_contropartita_wz w_contropartita_wz

type variables
s_contropartita		istr_contropartita
end variables

event ue_load_righe;
long 		ll_row, ll_nr_row, ll_id_conto, ll_nr_riga
string	ls_conto_codice, ls_conto_descrizione, ls_rigadoc_spesa, ls_codice,ls_descrizione

ls_conto_codice= istr_contropartita.s_codice
ls_conto_descrizione=istr_contropartita.s_descrizione
ll_nr_row=UpperBound(istr_contropartita.str_riga)
FOR ll_row= 1 to ll_nr_row
	dw_contropartita_ext_gd.InsertRow(ll_row)
	ls_rigadoc_spesa=istr_contropartita.str_riga[ll_row].s_rigadoc_spesa
	dw_contropartita_ext_gd.SetItem(ll_row ,"rigadoc_spesa"  , ls_rigadoc_spesa)

	ll_id_conto	=istr_contropartita.str_riga[ll_row].l_id_conto
	dw_contropartita_ext_gd.SetItem(ll_row ,"id_conto"  , ll_id_conto)
	dw_contropartita_ext_gd.SetItem(ll_row ,"conto_codice"  , ls_conto_codice)
	dw_contropartita_ext_gd.SetItem(ll_row ,"conto_descrizione"  , ls_conto_descrizione)

	ll_nr_riga=istr_contropartita.str_riga[ll_row].l_nr_riga
	dw_contropartita_ext_gd.SetItem(ll_row ,"nr_riga" , ll_nr_riga)

	ls_codice= istr_contropartita.str_riga[ll_row].s_codice
	dw_contropartita_ext_gd.SetItem(ll_row ,"codice"  , ls_codice)

	ls_descrizione= istr_contropartita.str_riga[ll_row].s_descrizione
	dw_contropartita_ext_gd.SetItem(ll_row ,"descrizione"  , ls_descrizione)

	dw_contropartita_ext_gd.SetItem(ll_row ,"conto_codice"  , ls_conto_codice)

	dw_contropartita_ext_gd.SetItem(ll_row ,"conto_descrizione"  , ls_conto_descrizione)
NEXT
if not istr_contropartita.b_predefinito then 
	f_DisplayOnly(dw_contropartita_ext_gd, "conto_codice", TRUE)
	f_DisplayOnly(dw_contropartita_ext_gd, "conto_descrizione", TRUE)
end if


end event

event ue_set_title;
string		ls_title, ls_codice, ls_descrizione

ls_codice= istr_contropartita.s_codice
If IsNull(ls_codice) then ls_codice=""
ls_descrizione= istr_contropartita.s_descrizione
If IsNull(ls_descrizione) then 
	ls_descrizione=""
else
	ls_descrizione= " - " + ls_descrizione
end if
ls_title= "Righe concorrenti alla Contropartita " + ls_codice + ls_descrizione
this.title= ls_title
end event

on w_contropartita_wz.create
int iCurrent
call w_wiz_main::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_contropartita_ext_gd=create dw_contropartita_ext_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_annulla
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=dw_contropartita_ext_gd
end on

on w_contropartita_wz.destroy
call w_wiz_main::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_contropartita_ext_gd)
end on

event open;call super::open;
istr_contropartita= Message.PowerObjectParm
TriggerEvent("ue_load_righe")
TriggerEvent("ue_set_title")

end event

event closequery;long ll_null
SetNull(ll_null)
If not istr_contropartita.b_predefinito then istr_contropartita.l_id_conto= ll_null
Message.PowerObjectParm= istr_contropartita
end event

type cb_annulla from commandbutton within w_contropartita_wz
int X=481
int Y=41
int Width=261
int Height=85
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_null
SetNull(ll_null)
istr_contropartita.l_id_conto=ll_null
Close(Parent)
end event

type cb_ok from commandbutton within w_contropartita_wz
int X=46
int Y=41
int Width=261
int Height=85
int TabOrder=20
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long 		ll_row, ll_nr_row, ll_id_conto, ll_nr_riga
string	ls_conto_codice, ls_conto_descrizione, ls_rigadoc_spesa, ls_codice,ls_descrizione

ll_nr_row=dw_contropartita_ext_gd.RowCount()
FOR ll_row= 1 to ll_nr_row
	istr_contropartita.str_riga[ll_row].s_rigadoc_spesa=dw_contropartita_ext_gd.GetItemString(ll_row ,"rigadoc_spesa"  )
	istr_contropartita.str_riga[ll_row].l_nr_riga=dw_contropartita_ext_gd.GetItemNumber(ll_row ,"nr_riga")
	istr_contropartita.str_riga[ll_row].l_id_conto=	dw_contropartita_ext_gd.GetItemNumber(ll_row ,"id_conto" )
	istr_contropartita.str_riga[ll_row].s_codice=	""
	istr_contropartita.str_riga[ll_row].s_descrizione=	""
NEXT
Close(Parent)
end event

type dw_contropartita_ext_gd from u_dw_ext_main within w_contropartita_wz
int X=46
int Y=161
int Width=2629
int Height=901
int TabOrder=10
string DataObject="d_contropartita_ext_gd"
boolean HScrollBar=true
end type

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
CHOOSE CASE as_nomecol
	CASE "conto_codice"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "conto_descrizione"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol

	CASE "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])
		
	CASE "conto_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

