forward
global type w_approvvigionamento_ff from w_p_data
end type
type dw_approvvigionamento_ff from u_dw_master_main within tabpage_1
end type
type dw_approvvigionamento_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_approvvigionamento_ann_gd from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_approvvigionamento_ann_gd dw_approvvigionamento_ann_gd
end type
end forward

global type w_approvvigionamento_ff from w_p_data
int Width=2679
int Height=1200
boolean TitleBar=true
string Title="Approvvigionamento Articolo"
end type
global w_approvvigionamento_ff w_approvvigionamento_ff

type variables
long il_id_articolo
end variables

event open;call super::open;

idw_master = tab_1.tabpage_1.dw_approvvigionamento_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "approvvigionamento_id_approvvigionamento"
	idw_master.is_list.s_modo=modo_modifica
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "approvvigionamento.id_approvvigionamento"
end event

on w_approvvigionamento_ff.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_approvvigionamento_ff.destroy
call super::destroy
end on

type p_crescente from w_p_data`p_crescente within w_approvvigionamento_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_approvvigionamento_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_approvvigionamento_ff
boolean BringToTop=true
end type

event cb_ok::clicked;long ll_row, ll_id
string s_col_name
integer li_counter
long ll_size

if isValid(u_freddie.iudw_current) then
	u_freddie.iudw_current.AcceptText()
end if
if parent.idw_master.uf_To_Update() > 0 then
	parent.TriggerEvent("ue_update")
end if
ll_row = idw_master.GetRow()

is_filter = ""
ll_size = UpperBound(idw_master.is_list.s_identifica)
if ll_row>0 then
	for  li_counter = 1 to ll_size
		s_col_name = idw_master.is_list.s_identifica[li_counter]
		is_filter = is_filter + " AND " + s_col_name + " = " + string(idw_master.GetItemNumber(ll_row, s_col_name))
	next
	is_filter = Mid(is_filter,5)
end if
ib_close_query = FALSE

parent.TriggerEvent("ue_close")

end event

type cb_annulla from w_p_data`cb_annulla within w_approvvigionamento_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_approvvigionamento_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_approvvigionamento_ff
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_approvvigionamento_ff
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_approvvigionamento_ff
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_approvvigionamento_ff
int X=37
int Y=156
int Width=2606
int Height=940
boolean BringToTop=true
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2569
int Height=820
long BackColor=79741120
string Text="Approvvigionamento"
long TabBackColor=79741120
dw_approvvigionamento_ff dw_approvvigionamento_ff
end type

on tabpage_1.create
this.dw_approvvigionamento_ff=create dw_approvvigionamento_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_approvvigionamento_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_approvvigionamento_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_approvvigionamento_ff
boolean BringToTop=true
end type

type dw_approvvigionamento_ff from u_dw_master_main within tabpage_1
int X=32
int Y=52
int Width=2496
int Height=740
int TabOrder=30
string DataObject="d_approvvigionamento_ff"
end type

event ue_init;call super::ue_init;is_title = "Approvvigionamento Articolo"
is_list.s_identifica[1] = "approvvigionamento_id_approvvigionamento"
iudw_children[1] = tab_1.tabpage_2.dw_approvvigionamento_ann_gd

end event

event ue_set_search;call super::ue_set_search;
long ll_row,ll_id_unita

ll_row 		= this.GetRow()
ll_id_unita	= this.GetItemNumber( ll_row,"unita_confezione_id_unita_confezione" )

select id_articolo
into   :il_id_articolo
from 	 unita_confezione
where  id_unita_confezione = :ll_id_unita
;
	
if SQLCA.SQLCode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SqlErrText,StopSign! )
end if	

choose case as_nomecol
	case "sog_commerciale_gen_codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "codice" 							
				
	case "sog_commerciale_gen_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "rag_soc_1" 						
		
	case "unita_confezione_codice"
		is_search_window = "w_unita_confezione_coddes_sw" 		
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "unita_confezione_codice" 	
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(il_id_articolo)
				
	case "unita_confezione_descrizione"
		is_search_window = "w_unita_confezione_coddes_sw" 			
		is_ricpar.s_filter_value = as_valcol 							
		is_ricpar.s_filter_name = "unita_confezione_descrizione" 
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(il_id_articolo)
end choose


end event

event ue_use_search;call super::ue_use_search;

choose case as_nomecol	
	case "sog_commerciale_gen_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("riordino_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		
	case "sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_gen_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("riordino_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		
	case "unita_confezione_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("unita_confezione_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("riordino_id_unita_confezione", is_ricpar.s_id_seg_value[1])
		
	case "unita_confezione_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("unita_confezione_codice", is_ricpar.s_ausil_value[1])		
		uf_set_colval("riordino_id_unita_confezione", is_ricpar.s_id_seg_value[1])
		
end choose

end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2569
int Height=820
long BackColor=79741120
string Text="Annotazioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_approvvigionamento_ann_gd dw_approvvigionamento_ann_gd
end type

on tabpage_2.create
this.dw_approvvigionamento_ann_gd=create dw_approvvigionamento_ann_gd
this.Control[]={this.dw_approvvigionamento_ann_gd}
end on

on tabpage_2.destroy
destroy(this.dw_approvvigionamento_ann_gd)
end on

type dw_approvvigionamento_ann_gd from u_dw_master_main within tabpage_2
int X=41
int Y=44
int Width=2501
int Height=740
int TabOrder=12
boolean BringToTop=true
string DataObject="d_approvvigionamento_ann_gd"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "approvvigionamento_id_approvvigionamento"
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "id_tipo_annotazione"
		is_search_window = "w_mod_single_data"
		is_ricpar.i_width = 3100
		is_ricpar.i_height = 1500
		is_ricpar.s_datawindow = "d_tipo_annotazione_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Annotazione"
END CHOOSE
end event

