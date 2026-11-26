forward
global type w_duplica_offerta_wz from w_wiz_main
end type
type dw_duplica_offerta_ext from u_dw_ext_main within w_duplica_offerta_wz
end type
type cb_ok from commandbutton within w_duplica_offerta_wz
end type
end forward

global type w_duplica_offerta_wz from w_wiz_main
int Width=2633
int Height=712
boolean TitleBar=true
string Title="Dati Offerta"
dw_duplica_offerta_ext dw_duplica_offerta_ext
cb_ok cb_ok
end type
global w_duplica_offerta_wz w_duplica_offerta_wz

on w_duplica_offerta_wz.create
int iCurrent
call super::create
this.dw_duplica_offerta_ext=create dw_duplica_offerta_ext
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_duplica_offerta_ext
this.Control[iCurrent+2]=this.cb_ok
end on

on w_duplica_offerta_wz.destroy
call super::destroy
destroy(this.dw_duplica_offerta_ext)
destroy(this.cb_ok)
end on

event ue_post_open;call super::ue_post_open;dw_duplica_offerta_ext.insertrow(0)

datawindowchild ldw_id_cat_com_sc

dw_duplica_offerta_ext.GetChild("id_cat_com_sc", ldw_id_cat_com_sc)
ldw_id_cat_com_sc.SetTransObject(SQLCA)
ldw_id_cat_com_sc.Retrieve()



end event

type dw_duplica_offerta_ext from u_dw_ext_main within w_duplica_offerta_wz
int X=37
int Y=128
int Width=2528
int Height=452
int TabOrder=10
boolean BringToTop=true
string DataObject="d_duplica_offerta_ext"
end type

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_priorita, ll_riga_corrente, ll_id_riga
ls_sql_cond = ""

CHOOSE CASE dwo.name
	CASE 'sog_commerciale_gen_codice'
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "sog_commerciale_gen_rag_soc_1"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_rag_soc_1"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_codice"

		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "sog_commerciale_gen_codice"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "sog_commerciale_gen_rag_soc_1"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
	CASE "id_cat_com_sc"
		is_search_window = "w_mod_single_data"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categoria Commerciale dei Soggetti Commerciali"			
END CHOOSE
end event

event ue_use_search;string ls_null
setnull(ls_null)
CHOOSE CASE as_nomecol
	CASE "sog_commerciale_gen_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		
	CASE "sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

type cb_ok from commandbutton within w_duplica_offerta_wz
int X=1061
int Y=28
int Width=261
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="&OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datawindow 	ldw
integer		li_row, li_currentrow

ldw = message.powerobjectparm

if isvalid(ldw) then
	li_row = ldw.getrow()
	if (li_row > 0) then
		
		li_currentrow = li_row + 1
		ldw.RowsCopy(li_row, li_row, Primary!, ldw, li_currentrow, Primary!)
		ldw.setitem(li_currentrow, "id_sog_commerciale", dw_duplica_offerta_ext.getitemnumber(1, "id_sog_commerciale"))
		ldw.setitem(li_currentrow, "data_inizio", dw_duplica_offerta_ext.getitemdate(1, "data_inizio"))
		ldw.setitem(li_currentrow, "data_fine", dw_duplica_offerta_ext.getitemdate(1, "data_fine"))
		ldw.setitem(li_currentrow, "sog_commerciale_gen_codice", dw_duplica_offerta_ext.getitemstring(1, "sog_commerciale_gen_codice"))
		ldw.setitem(li_currentrow, "sog_commerciale_gen_rag_soc_1", dw_duplica_offerta_ext.getitemstring(1, "sog_commerciale_gen_rag_soc_1"))
		ldw.setitem(li_currentrow, "id_cat_com_sc", dw_duplica_offerta_ext.getitemnumber(1, "id_cat_com_sc"))
		close(parent)
	end if
end if
end event

