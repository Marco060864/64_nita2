forward
global type w_riga_dis_banca_ff from w_p_data
end type
type dw_riga_dis_banca_ff from u_dw_master_main within w_riga_dis_banca_ff
end type
end forward

global type w_riga_dis_banca_ff from w_p_data
int Width=2039
int Height=860
boolean TitleBar=true
string Title="Riga Distinta Banca"
dw_riga_dis_banca_ff dw_riga_dis_banca_ff
end type
global w_riga_dis_banca_ff w_riga_dis_banca_ff

forward prototypes
public subroutine wf_set_format (long al_id_valuta)
end prototypes

public subroutine wf_set_format (long al_id_valuta);
string	ls_format

ls_format = f_valu_edit(al_id_valuta)
dw_riga_dis_banca_ff.modify("imp_totale.edit.format = '" + ls_format + "'")

ls_format = f_valu_mask(al_id_valuta)
dw_riga_dis_banca_ff.modify("imp_totale.format = '" + ls_format + "'")

end subroutine

on w_riga_dis_banca_ff.create
int iCurrent
call super::create
this.dw_riga_dis_banca_ff=create dw_riga_dis_banca_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_riga_dis_banca_ff
end on

on w_riga_dis_banca_ff.destroy
call super::destroy
destroy(this.dw_riga_dis_banca_ff)
end on

event open;call super::open;string ls_param

idw_master = dw_riga_dis_banca_ff
idw_master.is_list = Message.PowerObjectParm

ls_param	= idw_master.is_list.s_win_parametri

choose case ls_param
	case "A"
		il_HelpTopic = 331
	case "P"
		il_HelpTopic = 336
end choose

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "riga_dis_banca.id_riga_distinta_banca"
Post wf_set_format(long(idw_master.is_list.s_par_value[1]))
end event

type p_crescente from w_p_data`p_crescente within w_riga_dis_banca_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_riga_dis_banca_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_riga_dis_banca_ff
int X=37
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_riga_dis_banca_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_riga_dis_banca_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_riga_dis_banca_ff
int X=1120
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_riga_dis_banca_ff
int X=1417
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_riga_dis_banca_ff
int X=1714
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_riga_dis_banca_ff
int X=2149
int Y=220
int Width=183
int Height=100
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=146
end type

type cb_ricerca from w_p_data`cb_ricerca within w_riga_dis_banca_ff
boolean BringToTop=true
end type

type dw_riga_dis_banca_ff from u_dw_master_main within w_riga_dis_banca_ff
int X=37
int Y=160
int Width=1920
int Height=560
int TabOrder=1
string DataObject="d_riga_dis_banca_ff"
end type

