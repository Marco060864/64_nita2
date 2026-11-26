forward
global type w_scomposizione_cx from w_p_data
end type
type dw_parte_regola_gd from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_cat_codifica_lt_scomp from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_cat_codifica_lt_scomp dw_cat_codifica_lt_scomp
end type
type dw_scomposizione_ff from u_dw_master_main within w_scomposizione_cx
end type
end forward

global type w_scomposizione_cx from w_p_data
integer width = 2432
string title = "Tipi di Codice"
dw_scomposizione_ff dw_scomposizione_ff
end type
global w_scomposizione_cx w_scomposizione_cx

on w_scomposizione_cx.create
int iCurrent
call super::create
this.dw_scomposizione_ff=create dw_scomposizione_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scomposizione_ff
end on

on w_scomposizione_cx.destroy
call super::destroy
destroy(this.dw_scomposizione_ff)
end on

event open;call super::open;il_HelpTopic = 166

idw_master = dw_scomposizione_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "scomposizione.id_scomposizione"

end event

type p_msg_log from w_p_data`p_msg_log within w_scomposizione_cx
end type

type p_crescente from w_p_data`p_crescente within w_scomposizione_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_scomposizione_cx
end type

type cb_ok from w_p_data`cb_ok within w_scomposizione_cx
end type

type cb_annulla from w_p_data`cb_annulla within w_scomposizione_cx
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scomposizione_cx
end type

type cb_inserisci from w_p_data`cb_inserisci within w_scomposizione_cx
end type

event cb_inserisci::clicked;if tab_1.tabpage_1.dw_parte_regola_gd.rowcount()<9 then
	super::event clicked()
end if
end event

type cb_cancella from w_p_data`cb_cancella within w_scomposizione_cx
end type

type cb_salva from w_p_data`cb_salva within w_scomposizione_cx
end type

type tab_1 from w_p_data`tab_1 within w_scomposizione_cx
integer x = 46
integer y = 340
integer width = 2309
integer height = 1120
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
integer width = 2272
integer height = 1000
long backcolor = 79741120
string text = "Sezioni del Codice"
long tabbackcolor = 79741120
dw_parte_regola_gd dw_parte_regola_gd
end type

on tabpage_1.create
this.dw_parte_regola_gd=create dw_parte_regola_gd
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parte_regola_gd
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_parte_regola_gd)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_scomposizione_cx
end type

type dw_parte_regola_gd from u_dw_master_main within tabpage_1
event ue_post_itemchanged ( long row,  datawindow dw )
integer x = 27
integer y = 36
integer width = 2217
integer height = 940
integer taborder = 1
string dataobject = "d_parte_regola_gd"
end type

event ue_post_itemchanged;call super::ue_post_itemchanged;dw.setitem(row, "lunghezza", 0)
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_scomposizione"
is_title = "Parti di Regola"
end event

event ue_initial;call super::ue_initial;
long		ll_nrow, ll_row, ll_sez, ll_sez_1
integer	li_count

ll_sez =	0
ll_nrow =	this.rowcount()	
if ll_nrow>0 then 
	for li_count=	1 to ll_nrow
		ll_sez_1 =	getitemnumber(li_count, "num_sezione")
		if ll_sez <	ll_sez_1 then ll_sez =	ll_sez_1
	next
	ll_sez= ll_sez+1
	ll_row =		this.getrow()
	setitem(ll_row,"num_sezione",ll_sez)
end if
end event

event itemchanged;call super::itemchanged;
integer i, li_tot_lunghezza
if dwo.name="lunghezza" then
	for i = 1 to rowcount()
		if i=rowcount() then 
			li_tot_lunghezza+=integer(data) 
		else
			li_tot_lunghezza+=getitemnumber(i, "lunghezza")
		end if
		if li_tot_lunghezza> 64 then
			messagebox("Errore!", "La lunghezza massima del codice è 64 caratteri")
			post event ue_post_itemchanged(row, this)
			
			exit
		end if
	next
end if	
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2272
integer height = 1000
long backcolor = 79741120
string text = "Categorie di Codifica"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cat_codifica_lt_scomp dw_cat_codifica_lt_scomp
end type

on tabpage_2.create
this.dw_cat_codifica_lt_scomp=create dw_cat_codifica_lt_scomp
this.Control[]={this.dw_cat_codifica_lt_scomp}
end on

on tabpage_2.destroy
destroy(this.dw_cat_codifica_lt_scomp)
end on

type dw_cat_codifica_lt_scomp from u_dw_master_main within tabpage_2
integer x = 27
integer y = 36
integer width = 2203
integer height = 932
integer taborder = 1
string dataobject = "d_cat_codifica_lt_scomp"
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_scomposizione"
is_title = "Categorie di Codifica"

is_list.s_win_chiave[1] = "id_cat_codifica"
is_list.s_win_parametri = "da scompensi"
is_resp_window = "w_cat_codifica_cx"

end event

event ue_retrieve;call super::ue_retrieve;is_list.s_par_name[1] = "id_scomposizione"

end event

event ue_insert;call super::ue_insert;is_list.s_par_name[1] = "id_scomposizione"

end event

type dw_scomposizione_ff from u_dw_master_main within w_scomposizione_cx
integer x = 46
integer y = 160
integer width = 2309
integer height = 140
integer taborder = 10
string dataobject = "d_scomposizione_ff"
end type

event ue_init;call super::ue_init;
iudw_children[1] = tab_1.tabpage_1.dw_parte_regola_gd
iudw_children[2] = tab_1.tabpage_2.dw_cat_codifica_lt_scomp
is_title = "Scomposizioni"

end event

