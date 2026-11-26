forward
global type w_compenso_ff from w_p_data
end type
type dw_compenso_ff from u_dw_master_main within w_compenso_ff
end type
end forward

global type w_compenso_ff from w_p_data
int Width=2355
int Height=1453
boolean TitleBar=true
string Title="Compenso"
dw_compenso_ff dw_compenso_ff
end type
global w_compenso_ff w_compenso_ff

on w_compenso_ff.create
int iCurrent
call w_p_data::create
this.dw_compenso_ff=create dw_compenso_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_compenso_ff
end on

on w_compenso_ff.destroy
call w_p_data::destroy
destroy(this.dw_compenso_ff)
end on

event open;call super::open;idw_master = dw_compenso_ff
idw_master.is_list = Message.PowerObjectParm



end event

event ue_post_open;call super::ue_post_open;

long ll_CurrRow, ll_id_reg_pd

ll_CurrRow = dw_compenso_ff.GetRow()
ll_id_reg_pd = dw_compenso_ff.GetItemNumber(ll_CurrRow, "compenso_id_reg_pd")

IF NOT IsNull(ll_id_reg_pd) THEN
	f_DisplayOnly(dw_compenso_ff, "conto_codice", TRUE)
	f_DisplayOnly(dw_compenso_ff, "conto_descrizione", TRUE)
	f_DisplayOnly(dw_compenso_ff, "compenso_num_reg_progressivo", TRUE)
	f_DisplayOnly(dw_compenso_ff, "compenso_data_registrazione", TRUE)
	f_DisplayOnly(dw_compenso_ff, "compenso_data_competenza", TRUE)
	f_DisplayOnly(dw_compenso_ff, "compenso_num_documento", TRUE)
	f_DisplayOnly(dw_compenso_ff, "compenso_data_documento", TRUE)
END IF
end event

type p_crescente from w_p_data`p_crescente within w_compenso_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_compenso_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_compenso_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_compenso_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_compenso_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_compenso_ff
int X=1441
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_compenso_ff
int X=1738
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_compenso_ff
int X=2035
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_compenso_ff
int X=1052
int Y=21
int Width=275
int Height=121
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=238
int Height=1
end type

type dw_compenso_ff from u_dw_master_main within w_compenso_ff
int X=46
int Y=161
int Width=2250
int Height=1173
int TabOrder=3
string DataObject="d_compenso_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "compenso_id_compenso"
is_title = "Compenso"



end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol

	CASE "compenso_id_tributo_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tributo_gd"
		is_ricpar.s_titolo_finestra = "Tributi"
		is_ricpar.s_ausil_value[1] = "compenso_id_tributo_des"
		is_ricpar.i_width = 2917
		is_ricpar.i_height = 869
	CASE "compenso_id_tributo_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tributo_gd"
		is_ricpar.s_titolo_finestra = "Tributi"
		is_ricpar.s_ausil_value[1] = "compenso_id_tributo_cod"
		is_ricpar.i_width = 2917
		is_ricpar.i_height = 869

END CHOOSE


end event

