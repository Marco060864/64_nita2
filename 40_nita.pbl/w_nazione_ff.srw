forward
global type w_nazione_ff from w_p_data
end type
type dw_nazione_ff from u_dw_master_main within w_nazione_ff
end type
end forward

global type w_nazione_ff from w_p_data
int Width=2387
int Height=845
boolean TitleBar=true
string Title="Nazioni"
dw_nazione_ff dw_nazione_ff
end type
global w_nazione_ff w_nazione_ff

on w_nazione_ff.create
int iCurrent
call w_p_data::create
this.dw_nazione_ff=create dw_nazione_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_nazione_ff
end on

on w_nazione_ff.destroy
call w_p_data::destroy
destroy(this.dw_nazione_ff)
end on

event open;call super::open;idw_master = dw_nazione_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_nazione"
end event

type p_crescente from w_p_data`p_crescente within w_nazione_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_nazione_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_nazione_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_nazione_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_nazione_ff
int X=641
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_nazione_ff
int X=1463
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_nazione_ff
int X=1761
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_nazione_ff
int X=2058
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_nazione_ff
int X=69
int Y=601
int Width=435
int Height=101
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=398
end type

type dw_nazione_ff from u_dw_master_main within w_nazione_ff
int X=46
int Y=161
int Width=2286
int Height=561
int TabOrder=1
string DataObject="d_nazione_ff"
end type

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_valuta"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta"

	CASE "id_lingua"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_des"
	CASE "id_lingua_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua"
		
END CHOOSE

end event

event ue_init;call super::ue_init;is_title = "Nazioni"
end event

