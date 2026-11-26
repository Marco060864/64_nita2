forward
global type w_tipo_pagamento_ff from w_p_data
end type
type dw_tipo_pagamento_ff from u_dw_master_main within w_tipo_pagamento_ff
end type
end forward

global type w_tipo_pagamento_ff from w_p_data
int Width=2707
int Height=1457
boolean TitleBar=true
string Title="Tipi Pagamento"
dw_tipo_pagamento_ff dw_tipo_pagamento_ff
end type
global w_tipo_pagamento_ff w_tipo_pagamento_ff

event open;call super::open;
il_HelpTopic = 99

idw_master = dw_tipo_pagamento_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "tipo_pagamento.id_tipo_pagamento"
end event

on w_tipo_pagamento_ff.create
int iCurrent
call w_p_data::create
this.dw_tipo_pagamento_ff=create dw_tipo_pagamento_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_tipo_pagamento_ff
end on

on w_tipo_pagamento_ff.destroy
call w_p_data::destroy
destroy(this.dw_tipo_pagamento_ff)
end on

type p_crescente from w_p_data`p_crescente within w_tipo_pagamento_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_tipo_pagamento_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_tipo_pagamento_ff
int X=37
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_tipo_pagamento_ff
int X=330
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_tipo_pagamento_ff
int X=618
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_tipo_pagamento_ff
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_tipo_pagamento_ff
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_tipo_pagamento_ff
int X=2414
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_tipo_pagamento_ff
int X=1692
int Y=1101
int Width=686
int Height=381
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=650
int Height=261
end type

type cb_ricerca from w_p_data`cb_ricerca within w_tipo_pagamento_ff
int X=1207
boolean BringToTop=true
end type

type dw_tipo_pagamento_ff from u_dw_master_main within w_tipo_pagamento_ff
int X=37
int Y=161
int Width=2638
int Height=1189
int TabOrder=10
string DataObject="d_tipo_pagamento_ff"
end type

event ue_init;call super::ue_init;is_title = "Tipo Pagamento"
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_gruppo_esp_sospeso"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_gruppo_esp_sospeso_gd"
		is_ricpar.s_titolo_finestra = "Gruppo Esposizione Sospeso"
		is_ricpar.s_ausil_value[1] = "id_gruppo_esp_sospeso_des"
	CASE "id_gruppo_esp_sospeso_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_gruppo_esp_sospeso_gd"
		is_ricpar.s_titolo_finestra = "Gruppo Esposizione Sospeso"
		is_ricpar.s_ausil_value[1] = "id_gruppo_esp_sospeso"

		
END CHOOSE
end event

event ue_key;call super::ue_key;string ls_spesa, ls_int_cons
long ll_count, ll_len, ll_row
string 			ls_nomedwo, ls_tipodwo, la_array[]
s_list_main lstr_list


ll_row = GetRow()

if key=KeyF4! and ll_row > 0 AND GetColumnName( ) = "spese_gestite" then
	AcceptText()
	lstr_list.s_win_parametri = GetItemString(ll_row,"spese_gestite")
	OpenWithParm(w_spesa_scelta_lt,lstr_list)
	u_freddie.sp_pop(la_array)
	SetItem(ll_row,"spese_gestite", la_array[1])
	u_freddie.sp_drop()
	
end if

end event

event clicked;call super::clicked;string ls_spesa, ls_int_cons
long ll_count, ll_len
string 			ls_nomedwo, ls_tipodwo, la_array[]
s_list_main lstr_list
w_search_main	lw_sm

ls_nomedwo = dwo.name
ls_tipodwo = dwo.type
if ls_nomedwo="spese_gestite_msw" then
	AcceptText()
	lstr_list.s_win_parametri = GetItemString(row,"spese_gestite")
	OpenWithParm(w_spesa_scelta_lt,lstr_list)
	u_freddie.sp_pop(la_array)
	SetItem(row,"spese_gestite", la_array[1])
	ScrollToRow(row)
	u_freddie.sp_drop()
	
end if

end event

