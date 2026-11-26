forward
global type w_scag_provvigione_cx from w_p_data
end type
type dw_scag_provvigione_gen_gd from u_dw_master_main within tabpage_1
end type
type dw_scag_provvigione_gen_gd from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_scag_prov_condizione from u_dw_master_main within tabpage_2
end type
type dw_scag_provvigione_2_ff from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_scag_prov_condizione dw_scag_prov_condizione
dw_scag_provvigione_2_ff dw_scag_provvigione_2_ff
end type
end forward

global type w_scag_provvigione_cx from w_p_data
int Width=3114
int Height=1861
boolean TitleBar=true
string Title="Scaglione Provvigione"
end type
global w_scag_provvigione_cx w_scag_provvigione_cx

type variables
long il_id_gruppo_agenti
long il_priorita
long il_id_con_provvigioni
string is_dw_ff_text
string is_dw_ff_text_ga
end variables

forward prototypes
public function string wf_select_sogg (long id_sogg_commerciale, integer scelta)
public subroutine wf_post_insert ()
end prototypes

public function string wf_select_sogg (long id_sogg_commerciale, integer scelta);string ls_ritorno


choose case scelta
	case 1
		SELECT "sog_commerciale_gen"."codice"
		INTO :ls_ritorno
		FROM	"sog_commerciale_gen"
		WHERE "sog_commerciale_gen"."id_sog_commerciale" = :id_sogg_commerciale;
	case 2
		SELECT "sog_commerciale_gen"."rag_soc_1"
		INTO :ls_ritorno
		FROM	"sog_commerciale_gen"
		WHERE "sog_commerciale_gen"."id_sog_commerciale" = :id_sogg_commerciale;
end choose

return ls_ritorno
end function

public subroutine wf_post_insert ();long ll_row
long ll_sc_Max_row, ll_sc_row

ll_sc_Max_row 		= tab_1.tabpage_2.dw_scag_prov_condizione.rowcount()
ll_row 				= tab_1.tabpage_2.dw_scag_provvigione_2_ff.getrow()

if ll_sc_Max_row > 0 then
	for ll_sc_row = 1 to ll_sc_Max_row 
		tab_1.tabpage_2.dw_scag_prov_condizione.setitem(ll_sc_row, "gruppo_agenti_id_sog_com_agente",&
					tab_1.tabpage_2.dw_scag_provvigione_2_ff.getitemnumber(ll_row,"cid_sog_com_agente") )
		tab_1.tabpage_2.dw_scag_prov_condizione.setitem(ll_sc_row, "gruppo_agenti_id_sog_com_sub_agente",&
					tab_1.tabpage_2.dw_scag_provvigione_2_ff.getitemnumber(ll_row,"cid_sog_com_sub_agente") )
	next
end if
				
end subroutine

on w_scag_provvigione_cx.create
int iCurrent
call w_p_data::create
iCurrent=UpperBound(this.Control)
end on

on w_scag_provvigione_cx.destroy
call w_p_data::destroy
end on

event open;call super::open;il_HelpTopic = 528
ib_nonmodale = true
this.y = 10
idw_master = tab_1.tabpage_2.dw_scag_provvigione_2_ff
idw_master.ias_key_name[1] = "id_con_provvigione"
idw_master.is_list.s_modo=modo_inserisci
idw_master.is_list.s_sql_ident[1] = "con_provvigione.id_con_provvigione"
end event

event ue_post_open;call super::ue_post_open;
end event

type p_crescente from w_p_data`p_crescente within w_scag_provvigione_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_scag_provvigione_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_scag_provvigione_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_scag_provvigione_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scag_provvigione_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_scag_provvigione_cx
int X=2158
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_scag_provvigione_cx
int X=2460
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_scag_provvigione_cx
int X=2780
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_scag_provvigione_cx
int Width=3041
int Height=1581
boolean BringToTop=true
Alignment Alignment=Center!
long BackColor=79741120
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

event tab_1::selectionchanged;call super::selectionchanged;if newindex = 2 then 
	ib_nonmodale = true
	cb_ricerca.visible = true
end if
if newindex = 1 then 
	ib_nonmodale = false
	cb_ricerca.visible = false
end if
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=3004
int Height=1461
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
dw_scag_provvigione_gen_gd dw_scag_provvigione_gen_gd
end type

on tabpage_1.create
this.dw_scag_provvigione_gen_gd=create dw_scag_provvigione_gen_gd
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_scag_provvigione_gen_gd
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_scag_provvigione_gen_gd)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_scag_provvigione_cx
int X=1367
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long ll_seg_value
s_ric_param ls_ric_param
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="id_con_provvigione"
openwithparm(lw_sm,idw_master.is_ricpar,"w_con_provvigione_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_con_provvigione"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_scag_provvigione_gen_gd from u_dw_master_main within tabpage_1
int X=28
int Y=77
int Width=2926
int Height=881
int TabOrder=1
string DataObject="d_scag_prov_gruppo_agenti"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_key;call super::ue_key;if key = keyadd! then 
	tab_1.tabpage_1.dw_scag_provvigione_gen_gd.insertrow(tab_1.tabpage_1.dw_scag_provvigione_gen_gd.rowcount())
end if

end event

event getfocus;call super::getfocus;this.object.ret1.brush.color = "10789024"
this.object.ret2.brush.color = "10789024"

end event

event losefocus;call super::losefocus;this.object.ret1.brush.color = "79741120"
this.object.ret2.brush.color = "79741120"
end event

type tabpage_2 from userobject within tab_1
int X=19
int Y=105
int Width=3004
int Height=1461
long BackColor=79741120
string Text="Condizioni di Provvigione"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scag_prov_condizione dw_scag_prov_condizione
dw_scag_provvigione_2_ff dw_scag_provvigione_2_ff
end type

on tabpage_2.create
this.dw_scag_prov_condizione=create dw_scag_prov_condizione
this.dw_scag_provvigione_2_ff=create dw_scag_provvigione_2_ff
this.Control[]={ this.dw_scag_prov_condizione,&
this.dw_scag_provvigione_2_ff}
end on

on tabpage_2.destroy
destroy(this.dw_scag_prov_condizione)
destroy(this.dw_scag_provvigione_2_ff)
end on

type dw_scag_prov_condizione from u_dw_master_main within tabpage_2
int X=19
int Y=825
int Width=2945
int Height=605
int TabOrder=3
string DataObject="d_scag_prov_condizione"
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_con_provvigione"
									
end event

event ue_insert;call super::ue_insert;post wf_post_insert()
end event

event losefocus;call super::losefocus;this.object.ret1.brush.color = "79741120"
this.object.ret2.brush.color = "79741120"
end event

event getfocus;call super::getfocus;this.object.ret1.brush.color = "10789024"
this.object.ret2.brush.color = "10789024"

end event

type dw_scag_provvigione_2_ff from u_dw_master_main within tabpage_2
int X=23
int Y=33
int Width=2935
int Height=777
int TabOrder=3
string DataObject="d_scag_provvigione_ff"
end type

event losefocus;call super::losefocus;
long		ll_row
string	ls_ws, ls_wt[], ls_wu	 
ll_row = THIS.GetRow()
IF (ll_row < 1) THEN
	RETURN
END IF	
il_id_gruppo_agenti = THIS.GetItemNumber(1 , "id_gruppo_agenti", Primary!, FALSE)
ls_wu = " "
ls_ws = "Gruppo Agenti:"
ls_wt[1] = ls_ws + Fill(ls_wu, (40 - Len(ls_ws)))
ls_ws = THIS.GetItemString(1 , "gruppo_agenti_codice", Primary!, FALSE)
ls_wt[2] = ls_ws + Fill(ls_wu, (40 - Len(ls_ws)))
ls_ws = THIS.GetItemString(1 , "gruppo_agenti_descrizione", Primary!, FALSE)
ls_wt[3] = ls_ws + Fill(ls_wu, (40 - Len(ls_ws)))
is_dw_ff_text_ga = ls_wt[1] + ls_wt[2] + ls_wt[3]
end event

event ue_init;call super::ue_init;iudw_children[1] = tab_1.tabpage_2.dw_scag_prov_condizione
is_list.s_identifica[1]="id_con_provvigione"



end event

event ue_update;call super::ue_update;tab_1.tabpage_1.dw_scag_provvigione_gen_gd.update(true,false)
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	
	CASE "gruppo_agenti_codice"
			is_search_window = "w_gruppo_agenti_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "gruppo_agenti_descrizione"
			is_search_window = "w_gruppo_agenti_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
			
	CASE "sog_commerciale_codice"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "sog_commerciale_descrizione"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
	CASE "ccodice"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
	CASE "cdescrizione"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
end choose
end event

event ue_use_search;call super::ue_use_search;choose case as_nomecol   
	CASE "gruppo_agenti_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cid_sog_com_capo_area", is_ricpar.s_id_seg_value[2])
		uf_set_colval("cid_sog_com_agente", is_ricpar.s_id_seg_value[3])
		uf_set_colval("cid_sog_com_sub_agente", is_ricpar.s_id_seg_value[4])
		uf_set_colval("gruppo_agenti_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("capo_area_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 1 ) )
		uf_set_colval("capo_area_descrizione",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 2 ) )
		uf_set_colval("agente_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 1 ) )
		uf_set_colval("agente_descrizione",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 2 ) )
		uf_set_colval("sub_agente_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 1 ) )
		uf_set_colval("sub_agente_descrizione",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 2 ) )
		post wf_post_insert()
	CASE "gruppo_agenti_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cid_sog_com_capo_area", is_ricpar.s_id_seg_value[2])
		uf_set_colval("cid_sog_com_agente", is_ricpar.s_id_seg_value[3])
		uf_set_colval("cid_sog_com_sub_agente", is_ricpar.s_id_seg_value[4])
		uf_set_colval("gruppo_agenti_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("capo_area_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 1 ) )
		uf_set_colval("capo_area_descrizione",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 2 ) )
		uf_set_colval("agente_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 1 ) )
		uf_set_colval("agente_descrizione",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 2 ) )
		uf_set_colval("sub_agente_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 1 ) )
		uf_set_colval("sub_agente_descrizione",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 2 ) )
		post wf_post_insert()
		
	CASE "sog_commerciale_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_descrizione", is_ricpar.s_ausil_value[1])
			
	CASE "sog_commerciale_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_codice", is_ricpar.s_ausil_value[1])



	CASE "ccodice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cdescrizione", is_ricpar.s_ausil_value[1])

	CASE "cdescrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("ccodice", is_ricpar.s_ausil_value[1])

end choose


end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case "gruppo_agenti_codice", "gruppoagenti_descrizione"
		post wf_post_insert()
end choose
end event

