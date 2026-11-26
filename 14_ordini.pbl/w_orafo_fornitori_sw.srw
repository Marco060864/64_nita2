forward
global type w_orafo_fornitori_sw from w_search_main
end type
end forward

global type w_orafo_fornitori_sw from w_search_main
int X=427
int Y=564
int Width=2792
int Height=1281
boolean TitleBar=true
string Title="Ricerca fornitori preferiti"
end type
global w_orafo_fornitori_sw w_orafo_fornitori_sw

on w_orafo_fornitori_sw.create
call w_search_main::create
end on

on w_orafo_fornitori_sw.destroy
call w_search_main::destroy
end on

type cb_cerca from w_search_main`cb_cerca within w_orafo_fornitori_sw
int X=2443
end type

type dw_lista from w_search_main`dw_lista within w_orafo_fornitori_sw
event ue_post_retrieveend ( )
int Width=2372
string DataObject="d_orafo_ric_fornitori_lt"
end type

event dw_lista::ue_post_retrieveend;call super::ue_post_retrieveend;long ll_articolo, ll_pos, rowcount
string ls_articolo, ls_rag_soc

rowcount=this.Rowcount()
if rowcount=0 then
	ll_pos=Pos(istr_ric.s_sql_cond,'=')
	ls_articolo=right(istr_ric.s_sql_cond,Len(istr_ric.s_sql_cond)-ll_pos)
	ll_articolo=long(ls_articolo)
	OpenwithParm(w_orafo_sel_fornitore_pref_lt,ll_articolo)
	ll_articolo=Message.DoubleParm
	if Not(IsNull(ll_articolo)) then
		select codice, rag_soc_1
		into :ls_articolo, :ls_rag_soc
		from sog_commerciale_gen
		where id_sog_commerciale=:ll_articolo;
		insertrow(0)
		SetItem(1,"id_sog_commerciale",ll_articolo)
		SetItem(1,"codice",ls_articolo)
		SetItem(1,"anagrafica_rag_soc_1",ls_rag_soc)
		cb_ok.event post clicked()
	end if
end if
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("anagrafica_rag_soc_1")
end event

event dw_lista::retrieveend;call super::retrieveend;this.event post ue_post_retrieveend()
end event

type sle_showsort from w_search_main`sle_showsort within w_orafo_fornitori_sw
int Width=2372
end type

type cb_annulla from w_search_main`cb_annulla within w_orafo_fornitori_sw
int X=2443
end type

type cb_ok from w_search_main`cb_ok within w_orafo_fornitori_sw
int X=2169
end type

type sle_ricerca from w_search_main`sle_ricerca within w_orafo_fornitori_sw
int Width=2098
end type

type sle_filtro from w_search_main`sle_filtro within w_orafo_fornitori_sw
int X=1017
int Width=1672
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_orafo_fornitori_sw
int Width=676
end type

