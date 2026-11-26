forward
global type w_movimenti_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_movimenti_cx
end type
type cb_ok from commandbutton within w_movimenti_cx
end type
type dw_1 from u_dw_ext_main within w_movimenti_cx
end type
end forward

global type w_movimenti_cx from w_wiz_main
int X=46
int Y=468
int Width=2853
int Height=1576
boolean TitleBar=true
string Title="Stampa movimenti di magazzino"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_movimenti_cx w_movimenti_cx

type variables

end variables

on w_movimenti_cx.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_movimenti_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;
dw_1.insertrow(1)

String ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des

datawindowchild ldw_da_mag, ldw_da_mag_des, ldw_a_mag, ldw_a_mag_des

dw_1.GetChild("da_magazzino", ldw_da_mag)
dw_1.GetChild("da_magazzino_des", ldw_da_mag_des)

dw_1.GetChild("a_magazzino", ldw_a_mag)
dw_1.GetChild("a_magazzino_des", ldw_a_mag_des)

dw_1.accepttext()

ldw_da_mag.settransobject(sqlca)
ldw_da_mag.retrieve()

ldw_da_mag_des.settransobject(sqlca)
ldw_da_mag_des.retrieve()
	
ldw_a_mag.settransobject(sqlca)
ldw_a_mag.retrieve()

ldw_a_mag_des.settransobject(sqlca)
ldw_a_mag_des.retrieve()
end event

event ue_post_open;call super::ue_post_open;
long	ll_id_valuta
Datawindowchild ldw_id_valuta, ldw_id_valuta_des

dw_1.GetChild("id_valuta", ldw_id_valuta)
dw_1.GetChild("id_valuta_des", ldw_id_valuta_des)

ldw_id_valuta.SetTransObject(SQLCA)
ldw_id_valuta.Retrieve()

ldw_id_valuta_des.SetTransObject(SQLCA)
ldw_id_valuta_des.Retrieve()

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

dw_1.setitem(1, "id_valuta", ll_id_valuta)
end event

type cb_annulla from commandbutton within w_movimenti_cx
int X=2523
int Y=24
int Width=261
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="&Esci"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type cb_ok from commandbutton within w_movimenti_cx
int X=2194
int Y=24
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stam&pa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

String 	ls_filtro, ls_parametri
String	ls_da_articolo, ls_a_articolo, ls_raggruppa
String 	ls_da_mag, ls_a_mag, ls_da_area, ls_a_area, ls_da_loc, ls_a_loc
string	ls_da_num_doc, ls_a_num_doc
date		ldt_da_data, ldt_a_data
Long		ll_id_valuta	

s_rpt_mag str_param

dw_1.accepttext()

ldt_da_data = dw_1.getitemdate(1, "da_data_doc")
ldt_a_data = dw_1.getitemdate(1, "a_data_doc")

ls_da_num_doc = dw_1.getitemstring(1, "da_num_doc")
ls_a_num_doc = dw_1.getitemstring(1, "a_num_doc")

ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
ls_a_articolo = dw_1.GetItemString(1, "a_articolo")

ls_raggruppa=dw_1.GetItemString(1,"raggruppa")

ls_da_mag=dw_1.GetItemString(1,"da_magazzino")
ls_a_mag=dw_1.GetItemString(1,"a_magazzino")
if (ls_raggruppa = 'L') then
	ls_da_area=dw_1.GetItemString(1,"da_area")
	ls_a_area=dw_1.GetItemString(1,"a_area")
	
	ls_da_loc=dw_1.GetItemString(1,"da_locazione")
	ls_a_loc=dw_1.GetItemString(1,"a_locazione")
end if

ll_id_valuta	= dw_1.GetItemNumber(1,"id_valuta")	

ls_filtro = ''

if (not isnull(ldt_da_data) and string(ldt_da_data) <> '') then
	ls_filtro = " AND documento.data_documento >= '" + string(ldt_da_data, 'yyyy-mm-dd') + "'"
end if

if (not isnull(ldt_a_data) and string(ldt_a_data) <> '') then
	ls_filtro = ls_filtro + " AND documento.data_documento <= '" + string(ldt_a_data, 'yyyy-mm-dd') + "'"
end if

if (not isnull(ls_da_num_doc) and ls_da_num_doc <> '') then
	ls_filtro = ls_filtro + " AND documento.num_documento >= '" + ls_da_num_doc + "'"
end if

if (not isnull(ls_a_num_doc) and ls_a_num_doc <> '') then
	ls_filtro = ls_filtro + " AND documento.num_documento <= '" + ls_a_num_doc + "'"
end if

if (not isnull(ls_da_articolo) and ls_da_articolo <> '') then
	ls_filtro = ls_filtro + " AND articolo.codice >= '" + ls_da_articolo + "'"
end if

if (not isnull(ls_a_articolo) and ls_a_articolo <> '') then
	ls_filtro = ls_filtro + " AND articolo.codice <= '" + ls_a_articolo + "'"
end if

if (ls_raggruppa = 'M') then
	if (not isnull(ls_da_mag) and ls_da_mag <> '') then
		ls_filtro = ls_filtro + " AND magazzino.codice >= '" + ls_da_mag + "'"
	end if
	if (not isnull(ls_a_mag) and ls_a_mag <> '') then
		ls_filtro = ls_filtro + " AND magazzino.codice <= '" + ls_a_mag + "'"
	end if
else
	if (not isnull(ls_da_loc) and ls_da_loc <> '') then
		ls_filtro = ls_filtro + " AND c_locazione_mag >= '" + ls_da_loc + "'"		
	else
		if (not isnull(ls_da_mag) and ls_da_mag <> '') then
			ls_filtro = ls_filtro + " AND magazzino.codice >= '" + ls_da_mag + "'"
		end if

		if (not isnull(ls_da_area) and ls_da_area <> '') then
			ls_filtro = ls_filtro + " AND area.codice >= '" + ls_da_area + "'"
		end if
	end if
	if (not isnull(ls_a_loc) and ls_a_loc <> '') then
		ls_filtro = ls_filtro + " AND c_locazione_mag <= '" + ls_a_loc + "'"
	else
		if (not isnull(ls_a_mag) and ls_a_mag <> '') then
			ls_filtro = ls_filtro + " AND magazzino.codice <= '" + ls_a_mag + "'"
		end if
		
		if (not isnull(ls_a_area) and ls_a_area <> '') then
			ls_filtro = ls_filtro + " AND area.codice <= '" + ls_a_area + "'"
		end if		
	end if
end if

str_param.filtro 		= 	ls_filtro 
str_param.flag 		= 	ls_raggruppa	
str_param.id_valuta	=	ll_id_valuta	


OpenWithParm(w_movimenti_rpt, str_param)

end event

type dw_1 from u_dw_ext_main within w_movimenti_cx
int X=27
int Y=128
int Width=2757
int Height=1316
int TabOrder=2
string DataObject="d_movimenti_ext"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_des",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           uf_set_colval("a_articolo",is_ricpar.s_main_value)			
           uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])			
	      end if
	CASE "da_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           uf_set_colval("a_articolo_des",is_ricpar.s_main_value)			
           uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])			
	      end if
	CASE "a_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])	
	CASE "a_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
END CHOOSE 
end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
Long		ll_id_listino
String 	ls_listino
Date 	 ld_data_fine
			

CHOOSE CASE dwo.name
	CASE "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
          This.SetItem(1, "a_articolo", Data)			
          This.SetItem(1, "a_articolo_des", This.GetItemString(1, "da_articolo_des"))			
	      end if
			RETURN 2
		END IF
		
		
	CASE "da_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
          This.SetItem(1, "a_articolo_des", Data)			
          This.SetItem(1, "a_articolo", This.GetItemString(1, "da_articolo"))			
	      end if
			RETURN 2
		END IF

	CASE "a_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "a_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "da_magazzino", "da_magazzino_des"
		datawindowchild ldw_da_area, ldw_da_area_des

		dw_1.GetChild("da_area", ldw_da_area)
		dw_1.GetChild("da_area_des", ldw_da_area_des)

		ldw_da_area.settransobject(sqlca)
		ldw_da_area.retrieve(data)
		
		ldw_da_area.settransobject(sqlca)
		ldw_da_area.retrieve(data)		
		
	CASE "a_magazzino", "a_magazzino_des"
		datawindowchild ldw_a_area, ldw_a_area_des

		
			dw_1.GetChild("a_area", ldw_a_area)
			ldw_a_area.settransobject(sqlca)
			ldw_a_area.retrieve(data)
			
			dw_1.GetChild("a_area_des", ldw_a_area_des)
			ldw_a_area.settransobject(sqlca)
			ldw_a_area.retrieve(data)							
		
		
	CASE "da_area", "a_area"
		datawindowchild ldw_da_loc, ldw_a_loc
		
		
			string ls_da_mag, ls_a_mag

			ls_da_mag = this.getitemstring(row, "da_magazzino")
			ls_a_mag = this.getitemstring(row, "a_magazzino")

			dw_1.GetChild("da_locazione", ldw_da_loc)
			dw_1.GetChild("a_locazione", ldw_a_loc)

			ldw_da_loc.settransobject(sqlca)
			ldw_da_loc.retrieve(ls_da_mag, data)

			ldw_a_loc.settransobject(sqlca)
			ldw_a_loc.retrieve(ls_a_mag, data)
		
END CHOOSE

end event

