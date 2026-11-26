forward
global type w_ric_anagrafica_wz from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_ric_anagrafica_wz
end type
type cb_1 from commandbutton within w_ric_anagrafica_wz
end type
type cb_2 from commandbutton within w_ric_anagrafica_wz
end type
end forward

global type w_ric_anagrafica_wz from w_wiz_main
int Width=2231
int Height=680
boolean TitleBar=true
string Title="Informazione Articoli"
long BackColor=80133307
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_ric_anagrafica_wz w_ric_anagrafica_wz

on w_ric_anagrafica_wz.create
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

on w_ric_anagrafica_wz.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(0)
end event

type dw_1 from u_dw_ext_main within w_ric_anagrafica_wz
int X=37
int Y=160
int Width=2126
int Height=388
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ric_anagrafica_ff"
end type

event ue_set_search;CHOOSE CASE as_nomecol
			
	CASE "da_cod_sog_commerciale"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"

	CASE "da_des_sog_commerciale"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"

END CHOOSE

end event

event ue_use_search;choose case as_nomecol
			
	case "da_cod_sog_commerciale"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("da_des_sog_commerciale",is_ricpar.s_ausil_value[1])
			uf_set_colval("id_sog_commerciale",is_ricpar.s_id_seg_value[1])

	case "a_cod_sog_commerciale"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("a_des_sog_commerciale",is_ricpar.s_ausil_value[1])
			uf_set_colval("id_sog_commerciale",is_ricpar.s_id_seg_value[1])

end choose
end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_cod_sog_commerciale"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"
		
		ls_dwc[1] = "da_cod_sog_commerciale"
		ls_dwc[2] = "da_des_sog_commerciale"
		ls_dwc[3] = "id_sog_commerciale"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
	CASE "da_des_sog_commerciale"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"
		
		ls_dwc[1] = "da_cod_sog_commerciale"
		ls_dwc[2] = "da_des_sog_commerciale"
		ls_dwc[3] = "id_sog_commerciale"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)

end choose
end event

type cb_1 from commandbutton within w_ric_anagrafica_wz
int X=1902
int Y=28
int Width=261
int Height=84
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

event clicked;long	ll_id_sog_commerciale

ll_id_sog_commerciale = dw_1.getitemnumber(1,"id_sog_commerciale")


string 			ls_filtro, ls_codice
long 	 			ll_seg_value
s_ric_param		lst
w_search_main 	lw_sm

ls_codice = ""

lst.s_filter_value	=	ls_codice
lst.s_filter_name		=	"rag_soc_1"
lst.s_sql_cond 		= 	"sog_commerciale_gen.id_sog_commerciale = " + string(ll_id_sog_commerciale)

openwithparm(lw_sm, lst, "w_sog_commerciale_gen_coddes_sw")

end event

type cb_2 from commandbutton within w_ric_anagrafica_wz
int X=37
int Y=28
int Width=261
int Height=84
int TabOrder=30
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

