forward
global type w_fat_sospensione_wz from w_p_data
end type
type dw_fat_sospensione_wz from u_dw_master_main within w_fat_sospensione_wz
end type
end forward

global type w_fat_sospensione_wz from w_p_data
int X=430
int Y=425
int Width=2785
int Height=1001
boolean TitleBar=true
string Title="Fatture in Sospensione"
dw_fat_sospensione_wz dw_fat_sospensione_wz
end type
global w_fat_sospensione_wz w_fat_sospensione_wz

on w_fat_sospensione_wz.create
int iCurrent
call w_p_data::create
this.dw_fat_sospensione_wz=create dw_fat_sospensione_wz
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_fat_sospensione_wz
end on

on w_fat_sospensione_wz.destroy
call w_p_data::destroy
destroy(this.dw_fat_sospensione_wz)
end on

type p_crescente from w_p_data`p_crescente within w_fat_sospensione_wz
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_fat_sospensione_wz
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_fat_sospensione_wz
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_fat_sospensione_wz
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_fat_sospensione_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_fat_sospensione_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_fat_sospensione_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_fat_sospensione_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_fat_sospensione_wz
int X=1052
int Y=41
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

type dw_fat_sospensione_wz from u_dw_master_main within w_fat_sospensione_wz
int X=46
int Y=161
int Width=2684
int Height=713
int TabOrder=3
string DataObject="d_fat_sospensione_wz"
end type

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "prof_registrazione_cod"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.ges_oper_intracomunitarie = 'S'"
	CASE "prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.ges_oper_intracomunitarie = 'S'"		
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;


CHOOSE CASE as_nomecol
	CASE "prof_registrazione_cod"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_des", is_ricpar.s_ausil_value[1])		
	CASE "prof_registrazione_des"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_cod", is_ricpar.s_ausil_value[1])				
END CHOOSE
end event

event ue_init;call super::ue_init;is_title = "Fatture in Sospensione"
end event

