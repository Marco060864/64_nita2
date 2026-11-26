forward
global type w_sel_stampa_ec_agenti_ff from Window
end type
type dw_1 from u_dw_ext_main within w_sel_stampa_ec_agenti_ff
end type
type cb_2 from commandbutton within w_sel_stampa_ec_agenti_ff
end type
type cb_1 from commandbutton within w_sel_stampa_ec_agenti_ff
end type
end forward

global type w_sel_stampa_ec_agenti_ff from Window
int X=832
int Y=360
int Width=2021
int Height=712
boolean TitleBar=true
string Title="Stampa E/C Agenti"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_sel_stampa_ec_agenti_ff w_sel_stampa_ec_agenti_ff

on w_sel_stampa_ec_agenti_ff.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_sel_stampa_ec_agenti_ff.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;dw_1.insertrow(1)
end event

type dw_1 from u_dw_ext_main within w_sel_stampa_ec_agenti_ff
int X=27
int Y=144
int Width=1934
int Height=432
int TabOrder=3
string DataObject="d_sel_agente_stp_ff"
end type

event ue_set_search;choose case as_nomecol
	case "rag_soc"
		is_search_window="w_agenti_stampa_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
	case "rag_soc2"
		is_search_window="w_agenti_stampa_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
	case "codice"
		is_search_window="w_agenti_stampa_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
	case "codice2"
		is_search_window="w_agenti_stampa_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"	
		
end choose
		
end event

event ue_use_search;choose case as_nomecol
	case "rag_soc"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_soggetto_commerciale",is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "codice2")) or This.GetItemString(1, "codice2")='' then
		    	uf_set_colval("rag_soc2",is_ricpar.s_main_value)
				uf_set_colval("codice2",is_ricpar.s_ausil_value[1]) 
		end if		
		
	case "rag_soc2"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_soggetto_commerciale",is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice2",is_ricpar.s_ausil_value[1])
		
	
	case "codice"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_soggetto_commerciale",is_ricpar.s_id_seg_value[1])
		uf_set_colval("rag_soc",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "codice2")) or This.GetItemString(1, "codice2")='' then
		    	uf_set_colval("codice2",is_ricpar.s_main_value)
				uf_set_colval("rag_soc2",is_ricpar.s_ausil_value[1]) 
		end if		
		
	case "codice2"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_soggetto_commerciale",is_ricpar.s_id_seg_value[1])
		uf_set_colval("rag_soc2",is_ricpar.s_ausil_value[1])	
		
end choose


end event

event itemchanged;


integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
CHOOSE CASE dwo.name
	CASE "codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "rag_soc"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "codice2")) or This.GetItemString(1, "codice2")='' then
           This.SetItem(1, "codice2", Data)			
           This.SetItem(1, "rag_soc2", This.GetItemString(1, "rag_soc"))
		   end if	
			RETURN 2
		END IF
		
		
	CASE "rag_soc"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "rag_soc"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	

		IF (li_ok > 0) THEN
			 if isnull(This.GetItemString(1, "codice2")) or This.GetItemString(1, "codice2")='' then
             This.SetItem(1, "codice2", This.GetItemString(1, "codice"))			
             This.SetItem(1, "rag_soc2", data)	
		   end if
			RETURN 2
		END IF

	CASE "codice2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "codice2"
		ls_dwc[2] = "rag_soc2"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
	

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	CASE "rag_soc2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "codice2"
		ls_dwc[2] = "rag_soc2"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

   

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE


end event

type cb_2 from commandbutton within w_sel_stampa_ec_agenti_ff
int X=1678
int Y=36
int Width=279
int Height=88
int TabOrder=20
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_sel_stampa_ec_agenti_ff
int X=1385
int Y=36
int Width=256
int Height=88
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_da_agente,ls_a_agente
sel_agente str_param
ls_da_agente=dw_1.getitemstring(1,"codice")
ls_a_agente=dw_1.getitemstring(1,"codice2")
if ls_da_agente>ls_a_agente then
	messagebox("Attenzione","Il codice iniziale è maggiore del codice finale",exclamation!)
else
str_param.da_agente=ls_da_agente
str_param.a_agente=ls_a_agente

openwithparm(w_stampa_agenti_gd,str_param)
end if

end event

