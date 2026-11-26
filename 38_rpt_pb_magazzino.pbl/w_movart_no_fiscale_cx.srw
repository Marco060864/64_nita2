forward
global type w_movart_no_fiscale_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_movart_no_fiscale_cx
end type
type cb_ok from commandbutton within w_movart_no_fiscale_cx
end type
type dw_1 from u_dw_ext_main within w_movart_no_fiscale_cx
end type
end forward

global type w_movart_no_fiscale_cx from w_wiz_main
int Width=2926
int Height=1068
boolean TitleBar=true
string Title="Stampa elenco articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_movart_no_fiscale_cx w_movart_no_fiscale_cx

on w_movart_no_fiscale_cx.create
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

on w_movart_no_fiscale_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;
dw_1.insertrow(1)

String	ls_da_caus_cod, ls_a_caus_cod, ls_da_num_doc, ls_a_num_doc
String	ls_da_mag_cod, ls_a_mag_cod


datawindowchild ldw_da_caus_cod, ldw_da_caus_des, ldw_a_caus_cod, ldw_a_caus_des
datawindowchild ldw_da_mag_cod, ldw_da_mag_des, ldw_a_mag_cod, ldw_a_mag_des

dw_1.GetChild("da_caus_cod", ldw_da_caus_cod)
dw_1.GetChild("da_caus_des", ldw_da_caus_des)

dw_1.GetChild("a_caus_cod", ldw_a_caus_cod)
dw_1.GetChild("a_caus_des", ldw_a_caus_des)

dw_1.GetChild("da_mag_cod", ldw_da_mag_cod)
dw_1.GetChild("da_mag_des", ldw_da_mag_des)

dw_1.GetChild("a_mag_cod", ldw_a_mag_cod)
dw_1.GetChild("a_mag_des", ldw_a_mag_des)

dw_1.Accepttext()

ldw_da_caus_cod.SetTransObject(SQLCA)
ldw_da_caus_cod.Retrieve()

ldw_da_caus_des.SetTransObject(SQLCA)
ldw_da_caus_des.Retrieve()

ldw_a_caus_cod.SetTransObject(SQLCA)
ldw_a_caus_cod.Retrieve()

ldw_a_caus_des.SetTransObject(SQLCA)
ldw_a_caus_des.Retrieve()

ldw_da_mag_cod.SetTransObject(SQLCA)
ldw_da_mag_cod.Retrieve()

ldw_da_mag_des.SetTransObject(SQLCA)
ldw_da_mag_des.Retrieve()

ldw_a_mag_cod.SetTransObject(SQLCA)
ldw_a_mag_cod.Retrieve()

ldw_a_mag_des.SetTransObject(SQLCA)
ldw_a_mag_des.Retrieve()


end event

type cb_annulla from commandbutton within w_movart_no_fiscale_cx
int X=2629
int Y=20
int Width=229
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

type cb_ok from commandbutton within w_movart_no_fiscale_cx
int X=2359
int Y=20
int Width=242
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stam&pa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
String  ls_seleziona_stampa

                                    

dw_1.Accepttext()

ls_seleziona_stampa = dw_1.getitemstring(1,"seleziona_stampa")
if ls_seleziona_stampa = 'F' then 
	OpenWithParm(w_movart_fiscale_rpt, dw_1)
   else
   if ls_seleziona_stampa = 'P' then 
	  OpenWithParm(w_movart_personale_rpt, dw_1)	
     else 
		OpenWithParm(w_movart_no_fiscale_rpt, dw_1)		
   end if
end if	


end event

type dw_1 from u_dw_ext_main within w_movart_no_fiscale_cx
int X=32
int Y=124
int Width=2825
int Height=800
int TabOrder=2
string DataObject="d_movart_no_fiscale_cx"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
END CHOOSE






end event

event ue_use_search;choose case as_nomecol
	case "da_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
				uf_set_colval("a_articolo",is_ricpar.s_main_value)
				uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])
			end if	
	case "da_des_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
				uf_set_colval("a_des_articolo",is_ricpar.s_main_value)
				uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
			end if	
			
	case "a_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])	
	case "a_des_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
	end choose
	
	
	
	

end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
CHOOSE CASE dwo.name
	CASE "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	 

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
          This.SetItem(1, "a_articolo", Data)			
          This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))	
	      end if  
			RETURN 2
		END IF
		
		
	CASE "da_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
	       This.SetItem(1, "a_des_articolo", Data)			
          This.SetItem(1, "a_articolo", This.GetItemString(1, "da_articolo"))
	      end if 
			RETURN 2
		END IF

	CASE "a_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE

	
end event

