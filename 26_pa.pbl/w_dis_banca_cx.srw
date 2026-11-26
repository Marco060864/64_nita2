forward
global type w_dis_banca_cx from w_p_data
end type
type dw_dis_banca_esercizio_ff from u_dw_master_main within w_dis_banca_cx
end type
type dw_dis_banca_gd from u_dw_master_main within w_dis_banca_cx
end type
end forward

global type w_dis_banca_cx from w_p_data
integer x = 357
integer y = 236
integer width = 2990
integer height = 2612
string title = "Distinte Banca Esercizio"
dw_dis_banca_esercizio_ff dw_dis_banca_esercizio_ff
dw_dis_banca_gd dw_dis_banca_gd
end type
global w_dis_banca_cx w_dis_banca_cx

type variables
boolean ib_attiva_passiva
s_distinta is_distinta
end variables

forward prototypes
public subroutine wf_set_edit_format (long al_id_valuta)
end prototypes

public subroutine wf_set_edit_format (long al_id_valuta);
long		ll_row
string	ls_format

ll_row = dw_dis_banca_esercizio_ff.getrow()
if (ll_row > 0) then 
	ls_format = f_valu_edit(al_id_valuta)
	
	dw_dis_banca_gd.modify("tot_distinta.edit.format = '" + ls_format + "'")
end if

end subroutine

on w_dis_banca_cx.create
int iCurrent
call super::create
this.dw_dis_banca_esercizio_ff=create dw_dis_banca_esercizio_ff
this.dw_dis_banca_gd=create dw_dis_banca_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dis_banca_esercizio_ff
this.Control[iCurrent+2]=this.dw_dis_banca_gd
end on

on w_dis_banca_cx.destroy
call super::destroy
destroy(this.dw_dis_banca_esercizio_ff)
destroy(this.dw_dis_banca_gd)
end on

event open;call super::open;string	ls_Parametro

idw_master = dw_dis_banca_esercizio_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "esercizio.id_esercizio"

ls_Parametro = idw_master.is_list.s_win_parametri

CHOOSE CASE ls_Parametro
		
	CASE "A"
		il_HelpTopic = 331
		This.Title = "Distinte Banca Attive"
	CASE "P"		
		il_HelpTopic = 336
		This.Title = "Distinte Banca Passive"

END CHOOSE



end event

event ue_post_open;

string ls_Filtro, ls_Parametro

ls_filtro = ""
ls_Parametro = idw_master.is_list.s_win_parametri

CHOOSE CASE ls_Parametro
	CASE "A"
		ib_attiva_passiva = TRUE
	CASE "P"		
		ib_attiva_passiva = FALSE
	CASE ELSE
		MessageBox("UE_RETRIEVE DIS_BANCA_ESERCIZIO_FF", "Errore Chiamata Menu") 
END CHOOSE
ls_filtro = "dis_banca.tipo = '" + ls_parametro + "'"
dw_dis_banca_gd.iu_scan.f_reset_cur_as_ini()
if ls_filtro <> "" then
	dw_dis_banca_gd.iu_scan.f_add_where_condition(ls_filtro)
end if
dw_dis_banca_gd.object.datawindow.table.select = dw_dis_banca_gd.iu_scan.f_getcurrent()
cb_nuovo.Visible = FALSE

TriggerEvent("ue_retrieve")
TriggerEvent("ue_modify")
uf_buildtree(idw_master)
ii_dwcurr = 1
idw_master.SetFocus()
call super::ue_post_open 

idw_tree[1] = dw_dis_banca_gd
idw_tree[1].is_list.s_win_parametri = ls_parametro

long	ll_id_valuta, ll_id_esercizio
ll_id_esercizio=dw_dis_banca_esercizio_ff.getitemnumber(dw_dis_banca_esercizio_ff.getrow(),"id_esercizio")

SELECT	id_valuta
INTO	 	:ll_id_valuta
FROM	   esercizio
WHERE		id_esercizio = :ll_id_esercizio;
if isnull(ll_id_valuta) then ll_id_valuta = 0

if (ll_id_valuta > 0) then 	
	dw_dis_banca_esercizio_ff.setitem(1, "id_valuta", ll_id_valuta)
	
	idw_master.is_list.s_par_name[1]  = "id_valuta"
	idw_master.is_list.s_par_value[1] = string(ll_id_valuta)
	
	idw_master.is_list.s_identifica[1] = "id_esercizio"
	idw_master.is_list.l_identifica[1] = ll_id_esercizio	
	idw_master.is_list.s_identifica[2] = "id_valuta"
	idw_master.is_list.l_identifica[2] = ll_id_valuta
	dw_dis_banca_gd.retrieve(ll_id_esercizio,ll_id_valuta)
	wf_set_edit_format(ll_id_valuta)
end if


end event

type p_msg_log from w_p_data`p_msg_log within w_dis_banca_cx
end type

type p_crescente from w_p_data`p_crescente within w_dis_banca_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_dis_banca_cx
end type

type cb_ok from w_p_data`cb_ok within w_dis_banca_cx
end type

type cb_annulla from w_p_data`cb_annulla within w_dis_banca_cx
end type

type cb_nuovo from w_p_data`cb_nuovo within w_dis_banca_cx
end type

type cb_inserisci from w_p_data`cb_inserisci within w_dis_banca_cx
integer x = 2034
end type

type cb_cancella from w_p_data`cb_cancella within w_dis_banca_cx
integer x = 2331
end type

event cb_cancella::clicked;
long ll_row, ll_id_riga_dis, ll_id_dis, ll_num_righe
integer i


ll_row=dw_dis_banca_gd.getrow()
if ll_row>0 then
	
	ll_id_dis=dw_dis_banca_gd.getitemnumber(ll_row, "id_distinta_banca")
	
	datastore ds_riga_distinta
	ds_riga_distinta=create datastore
	ds_riga_distinta.dataobject='ds_riga_dis_banca'
	ds_riga_distinta.settransobject(sqlca)
	ll_num_righe=ds_riga_distinta.retrieve(ll_id_dis)
	for i= ll_num_righe to 1 step -1
		ll_id_riga_dis=ds_riga_distinta.getitemnumber(i, "id_riga_distinta_banca")
		update scadenza
		set esito_pagamento='E'
		where id_riga_distinta_banca=:ll_id_riga_dis;
		
		commit;  
		
		
	next
	
	
destroy ds_riga_distinta
Super::EVENT Clicked()

end if

end event

type cb_salva from w_p_data`cb_salva within w_dis_banca_cx
integer x = 2629
end type

type tab_1 from w_p_data`tab_1 within w_dis_banca_cx
boolean visible = false
integer y = 1440
integer width = 2354
integer height = 20
integer taborder = 30
boolean enabled = false
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 2318
integer height = -100
end type

type cb_ricerca from w_p_data`cb_ricerca within w_dis_banca_cx
end type

type dw_dis_banca_esercizio_ff from u_dw_master_main within w_dis_banca_cx
integer x = 46
integer y = 180
integer width = 2857
integer height = 176
integer taborder = 20
string dataobject = "d_dis_banca_esercizio_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_esercizio"
is_list.s_identifica[2] = "id_valuta"	

iudw_children[1] = dw_dis_banca_gd
is_list.s_win_chiave[1] = "id_distinta_banca"

is_title = "Esercizio"

end event

event itemchanged;
CHOOSE CASE dwo.name
	CASE "id_esercizio"
			This.SetItem(row,  "id_esercizio", Long(data))
			dw_dis_banca_gd.is_list.l_identifica[1] = Long(data)
			
			
			long	ll_id_valuta
			
			SELECT	id_valuta
			INTO	 	:ll_id_valuta
			FROM	   esercizio
			WHERE		id_esercizio = :data
			;
			
			this.setitem(row, "id_valuta", ll_id_valuta)
			dw_dis_banca_gd.is_list.l_identifica[2] = ll_id_valuta	
			Post wf_set_edit_format(ll_id_valuta)						
			
			
			dw_dis_banca_gd.PostEvent("ue_retrieve")	
		CASE "id_valuta", "id_valuta_des"
			
			dw_dis_banca_gd.is_list.s_identifica[1] = "id_esercizio"
			dw_dis_banca_gd.is_list.s_identifica[2] = "id_valuta"
			dw_dis_banca_gd.is_list.l_identifica[1] = this.getitemnumber(row, "id_esercizio") 
			dw_dis_banca_gd.is_list.l_identifica[2] = Long(data)
			dw_dis_banca_gd.PostEvent("ue_retrieve")
			Post wf_set_edit_format(long(Data))			
			
	Case ELSE	
		
END CHOOSE


end event

type dw_dis_banca_gd from u_dw_master_main within w_dis_banca_cx
integer x = 46
integer y = 380
integer width = 2857
integer height = 2092
integer taborder = 10
boolean titlebar = true
string title = "Distinte Banca per Esercizio"
string dataobject = "d_dis_banca_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_esercizio"
is_list.s_identifica[2] = "id_valuta"	
is_title = "Distinte Banca per Esercizio"

is_list.s_win_chiave[1] = "id_distinta_banca"

is_list.s_win_zoom = "w_riga_dis_banca_cx"
is_list.s_par_name[1]  = "id_valuta"	

end event

event ue_insert;

long ll_CurrRow, ll_id_esercizio
long	ll_id_valuta	

ll_CurrRow = dw_dis_banca_esercizio_ff.GetRow()
ll_id_esercizio = dw_dis_banca_esercizio_ff.GetItemNumber(ll_CurrRow, "id_esercizio")
ll_id_valuta	 = dw_dis_banca_esercizio_ff.GetItemNumber(ll_CurrRow, "id_valuta")	

is_distinta.l_id_esercizio  = ll_id_esercizio
is_distinta.c_tipo_scadenza = idw_master.is_list.s_win_parametri
is_distinta.l_id_dis_banca  = 0
is_distinta.l_righe         = 0

OpenWithParm(w_distinta_ff, is_distinta)

SELECT	id_valuta
INTO	 	:ll_id_valuta
FROM	   esercizio
WHERE		id_esercizio = :ll_id_esercizio;
if isnull(ll_id_valuta) then ll_id_valuta = 0


this.retrieve(ll_id_esercizio, ll_id_valuta) 
end event

event ue_modify;call super::ue_modify;long	ll_id_valuta, ll_id_esercizio, ll_riga_corrente

ll_id_esercizio=dw_dis_banca_esercizio_ff.getitemnumber(dw_dis_banca_esercizio_ff.getrow(),"id_esercizio")

SELECT	id_valuta
INTO	 	:ll_id_valuta
FROM	   esercizio
WHERE		id_esercizio = :ll_id_esercizio;
if isnull(ll_id_valuta) then ll_id_valuta = 0

if (ll_id_valuta > 0) then 	
	dw_dis_banca_esercizio_ff.setitem(1, "id_valuta", ll_id_valuta)
	
	idw_master.is_list.s_par_name[1]  = "id_valuta"
	idw_master.is_list.s_par_value[1] = string(ll_id_valuta)
	
	idw_master.is_list.s_identifica[1] = "id_esercizio	"
	idw_master.is_list.s_identifica[2] = "id_valuta"	
	idw_master.is_list.l_identifica[1] = ll_id_esercizio	
	idw_master.is_list.l_identifica[2] = ll_id_valuta
	//mm inserisco per tornare alla riga selezionata
	ll_riga_corrente=dw_dis_banca_gd.getrow()
	
	dw_dis_banca_gd.retrieve(ll_id_esercizio,ll_id_valuta)
	dw_dis_banca_gd.post scrolltorow(ll_riga_corrente)
	//mm fine inserisco per tornare alla riga selezionata
	wf_set_edit_format(ll_id_valuta)
end if
end event

