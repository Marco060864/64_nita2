forward
global type w_ric_art_inf_sempl from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_ric_art_inf_sempl
end type
type cb_1 from commandbutton within w_ric_art_inf_sempl
end type
type cb_2 from commandbutton within w_ric_art_inf_sempl
end type
end forward

global type w_ric_art_inf_sempl from w_wiz_main
int Width=2519
int Height=1108
boolean TitleBar=true
string Title="Informazione Articoli"
long BackColor=80133307
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_ric_art_inf_sempl w_ric_art_inf_sempl

on w_ric_art_inf_sempl.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_ric_art_inf_sempl.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(0)
end event

type dw_1 from u_dw_ext_main within w_ric_art_inf_sempl
int X=37
int Y=160
int Width=2395
int Height=800
int TabOrder=10
boolean BringToTop=true
string DataObject="d_sel_art_inf"
end type

event ue_set_search;string ls_sn_dist

ls_sn_dist = this.getitemstring(1,"sn_dist")

CHOOSE CASE as_nomecol
		
	CASE "da_articolo"		
		if ls_sn_dist = 'S' then
			is_search_window="w_distinta_base_sw"
			is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
			is_ricpar.s_filter_name="codice"			
		else
			is_search_window="w_articolo_coddes_sw"
			is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
			is_ricpar.s_filter_name="articolo_codice"
		end if
		
	CASE "da_des_articolo"
		if ls_sn_dist = 'S' then		
			is_search_window="w_distinta_base_sw"
			is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
			is_ricpar.s_filter_name="descrizione"
		else
			is_search_window="w_articolo_coddes_sw"
			is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
			is_ricpar.s_filter_name="articolo_descrizione"			
		end if
		
	CASE "a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
		
	CASE "a_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"		
				
	CASE "da_cliente_cod"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo='F' "
	CASE "da_cliente_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo='F' "
END CHOOSE

end event

event ue_use_search;string ls_sn_dist

ls_sn_dist = this.getitemstring(1,"sn_dist")

choose case as_nomecol
	case "da_articolo"		
		if ls_sn_dist = 'S' then
			uf_set_colval(as_nomecol,is_ricpar.s_ausil_value[1])
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des_articolo",is_ricpar.s_ausil_value[2])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
            uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])	
            uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[2])
	      end if  			
		else
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
            uf_set_colval("a_articolo",is_ricpar.s_main_value)	
            uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])
	      end if  
		end if
	case "da_des_articolo"
		if ls_sn_dist = 'S' then		
			uf_set_colval(as_nomecol,is_ricpar.s_ausil_value[1])
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[2])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
            uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])	
            uf_set_colval("a_articolo",is_ricpar.s_ausil_value[2])
	      end if  							
		else
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
            uf_set_colval("a_des_articolo",is_ricpar.s_main_value)	
            uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
	      end if  										
		end if
	case "a_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])	
	case "a_des_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])	
			
	case "da_cliente_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sog_com",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cliente_des",is_ricpar.s_ausil_value[1])

	case "da_cliente_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sog_com",is_ricpar.s_id_seg_value[1])			
			uf_set_colval("da_cliente_cod",is_ricpar.s_ausil_value[1])

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
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
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
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
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
		
	CASE "da_cliente_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"		
		
		ls_dwc[1] = "da_cliente_cod"
		ls_dwc[2] = "da_cliente_des"
		ls_dwc[3] = "id_sog_com"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
						
      
	
	CASE "da_cliente_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"				
		
		ls_dwc[1] = "da_cliente_cod"
		ls_dwc[2] = "da_cliente_des"
		ls_dwc[3] = "id_sog_com"				
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)


	case "sn_dist"
		if data = "S" then
			dw_1.object.a_articolo.visible = 0
			dw_1.object.a_des_articolo.visible = 0
			dw_1.object.a_articolo_sw.visible = 0			
			dw_1.object.a_des_articolo_sw.visible = 0						
			dw_1.object.a_art_t.visible = 0
			dw_1.object.id_cat_com.visible = 0
			dw_1.object.stringa.visible = 0
			dw_1.object.tipo_str.visible = 0
			dw_1.object.da_cliente_cod.visible = 0
			dw_1.object.da_cliente_des.visible = 0			
			dw_1.object.da_cliente_cod_sw.visible = 0
			dw_1.object.da_cliente_des_sw.visible = 0
			dw_1.object.forn_t.visible = 0
			dw_1.object.cat_com_t.visible = 0
			dw_1.object.str_t.visible = 0			
		else
			dw_1.object.a_articolo.visible = 1
			dw_1.object.a_des_articolo.visible = 1
			dw_1.object.a_articolo_sw.visible = 1
			dw_1.object.a_des_articolo_sw.visible = 1			
			dw_1.object.a_art_t.visible = 1
			dw_1.object.id_cat_com.visible = 1		
			dw_1.object.stringa.visible = 1	
			dw_1.object.tipo_str.visible = 1			
			dw_1.object.da_cliente_cod.visible = 1
			dw_1.object.da_cliente_des.visible = 1						
			dw_1.object.da_cliente_cod_sw.visible = 1
			dw_1.object.da_cliente_des_sw.visible = 1
			dw_1.object.forn_t.visible = 1	
			dw_1.object.cat_com_t.visible = 1			
			dw_1.object.str_t.visible = 1			
		end if
		
end choose
end event

type cb_1 from commandbutton within w_ric_art_inf_sempl
int X=2181
int Y=28
int Width=247
int Height=104
int TabOrder=20
boolean BringToTop=true
string Text="&Ricerca"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_sog_com, ll_id_cat_com
string ls_da_art, ls_a_art, ls_stringa, ls_tipo, ls_sn_dist

ls_da_art = dw_1.getitemstring(1,"da_articolo")
ls_a_art = dw_1.getitemstring(1,"a_articolo")
ls_stringa = dw_1.getitemstring(1,"stringa")
ls_tipo = dw_1.getitemstring(1,"tipo_str")
ls_sn_dist = dw_1.getitemstring(1,"sn_dist")

s_ric_art str

ll_id_sog_com = dw_1.getitemnumber(1,"id_sog_com")
ll_id_cat_com = dw_1.getitemnumber(1,"id_cat_com")

str.s_da_art = ls_da_art
str.s_a_art  = ls_a_art
str.s_id_sog_com  = ll_id_sog_com
str.s_id_cat_com  = ll_id_cat_com
str.stringa = ls_stringa
str.tipo_str = ls_tipo
str.sn_dist = ls_sn_dist

openwithparm(w_sel_art_inf_sempl,str)

end event

type cb_2 from commandbutton within w_ric_art_inf_sempl
int X=37
int Y=28
int Width=247
int Height=104
int TabOrder=20
boolean BringToTop=true
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

