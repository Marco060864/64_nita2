forward
global type w_stampa_bil_cee_bidone_lt from w_p_data
end type
type dw_1 from u_dw_master_main within w_stampa_bil_cee_bidone_lt
end type
end forward

global type w_stampa_bil_cee_bidone_lt from w_p_data
int Width=3361
int Height=1381
boolean TitleBar=true
string Title="Stampa Bilancio Cee Bidone"
dw_1 dw_1
end type
global w_stampa_bil_cee_bidone_lt w_stampa_bil_cee_bidone_lt

type variables

end variables

on w_stampa_bil_cee_bidone_lt.create
int iCurrent
call w_p_data::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_stampa_bil_cee_bidone_lt.destroy
call w_p_data::destroy
destroy(this.dw_1)
end on

event open;call super::open;idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	ib_NonModale = TRUE
	idw_master.is_list.s_modo = modo_inserisci
	idw_master.ias_key_name[1] = "id_conto"
END IF

dw_1.retrieve()
end event

type p_crescente from w_p_data`p_crescente within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_stampa_bil_cee_bidone_lt
int X=33
int Y=1269
int Width=449
int Height=209
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=17
int Width=412
int Height=177
boolean Visible=false
long BackColor=79741120
long TabBackColor=79741120
long PictureMaskColor=553648127
end type

type cb_ricerca from w_p_data`cb_ricerca within w_stampa_bil_cee_bidone_lt
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;
end event

type dw_1 from u_dw_master_main within w_stampa_bil_cee_bidone_lt
int X=42
int Y=145
int Width=3297
int Height=1137
int TabOrder=1
string DataObject="d_bil_cee_bidone_lt"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_conto"
is_list.s_colonne_drop[1]="descrizione_bilancio_cee"

end event

event ue_set_search;call super::ue_set_search;long ll_desc_bil_cee
string ls_des
long ll_current
ll_current=dw_1.getrow()
ll_desc_bil_cee=dw_1.getitemnumber(ll_current, "bilancio_cee_id_bilancio_cee") 
select descrizione
into :ls_des
from bilancio_cee
where id_bilancio_cee=:ll_desc_bil_cee;

CHOOSE CASE as_nomecol
	CASE "conto_descrizione"
		is_search_window = "w_conto1_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_descrizione"  
		is_ricpar.s_sql_cond="bilancio_cee.descrizione='"+ls_des+"'"
		
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE

end event

event ue_insert;call super::ue_insert;long ll_riga 
ll_riga = dw_1.getrow()

end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "conto_descrizione"
		uf_set_colval("conto_descrizione", is_ricpar.s_main_value)
		uf_set_colval("chiusura_apertura_id_conto", is_ricpar.s_id_seg_value[1])
END CHOOSE



end event

event updateend;call super::updateend;
end event

