forward
global type w_sog_com_barre_cx from w_np_single_data
end type
type cb_1 from commandbutton within w_sog_com_barre_cx
end type
type cb_2 from commandbutton within w_sog_com_barre_cx
end type
type cb_3 from commandbutton within w_sog_com_barre_cx
end type
end forward

global type w_sog_com_barre_cx from w_np_single_data
int Width=2565
int Height=1556
boolean TitleBar=true
string Title="Cod. Barre Sog. Commerciali"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_sog_com_barre_cx w_sog_com_barre_cx

on w_sog_com_barre_cx.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on w_sog_com_barre_cx.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

type dw_single from w_np_single_data`dw_single within w_sog_com_barre_cx
int X=41
int Y=144
int Width=2446
int Height=1268
int TabOrder=10
string DataObject="d_sog_com_barre"
boolean HScrollBar=false
end type

event dw_single::ue_set_search;call super::ue_set_search;choose case as_nomecol		
	CASE "sog_com_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "sog_com_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"			
	
end choose
end event

event dw_single::ue_use_search;choose case as_nomecol
	CASE "sog_com_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_com_des", is_ricpar.s_ausil_value[1])
		
	case "sog_com_des"
   	uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale",is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_com_cod", is_ricpar.s_ausil_value[1])			
		
end choose


end event

event dw_single::itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[], ls_tipo_documento, ls_sql, ls_sog_cod, ls_sog_rag
long ll_null
long ll_id_prof_prop

setnull(ll_null)

choose case dwo.name
		
	CASE "sog_com_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"		
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_des"
		ls_dwc[3] = "id_sog_commerciale"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
			
	case "sog_com_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"				
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_des"
		ls_dwc[3] = "id_sog_commerciale"				
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
		
end choose

end event

event dw_single::ue_key;call super::ue_key;this.setcolumn(1)
end event

type cb_1 from commandbutton within w_sog_com_barre_cx
int X=41
int Y=28
int Width=270
int Height=96
int TabOrder=20
boolean BringToTop=true
string Text="&Aggiungi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row
ll_row = dw_single.insertrow(0)
dw_single.setrow(ll_row)
dw_single.setcolumn(1)
dw_single.setfocus()
end event

type cb_2 from commandbutton within w_sog_com_barre_cx
int X=338
int Y=28
int Width=270
int Height=96
int TabOrder=30
boolean BringToTop=true
string Text="&Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_ris, ll_row

ll_ris = messagebox("Attenzione","Eseguo la cancellazione della riga selezionata?",question!,yesno!)
if ll_ris = 1 then
	ll_row = dw_single.getrow()
	dw_single.deleterow(ll_row)
	dw_single.setfocus()	
end if
end event

type cb_3 from commandbutton within w_sog_com_barre_cx
int X=2213
int Y=28
int Width=270
int Height=96
int TabOrder=31
boolean BringToTop=true
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open(w_st_sog_com_barre_cx)
end event

