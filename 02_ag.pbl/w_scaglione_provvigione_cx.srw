forward
global type w_scaglione_provvigione_cx from w_p_data
end type
type dw_scag_provvigione_2_ff from u_dw_master_main within tabpage_1
end type
type dw_scag_provvigione_2_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_scag_prov_condizione from u_dw_master_main within tabpage_2
end type
type cb_1 from commandbutton within w_scaglione_provvigione_cx
end type
type cb_2 from commandbutton within w_scaglione_provvigione_cx
end type
type tabpage_2 from userobject within tab_1
dw_scag_prov_condizione dw_scag_prov_condizione
end type
end forward

global type w_scaglione_provvigione_cx from w_p_data
int Width=3081
int Height=1900
boolean TitleBar=true
string Title="Scaglione Provvigione"
cb_1 cb_1
cb_2 cb_2
end type
global w_scaglione_provvigione_cx w_scaglione_provvigione_cx

type variables
long il_id_gruppo_agenti
long il_priorita
long il_id_con_provvigioni
string is_dw_ff_text
string is_dw_ff_text_ga
end variables

forward prototypes
public function string wf_select_sogg (long id_sogg_commerciale, integer scelta)
public subroutine wf_controlla ()
public function boolean wf_controlla_update ()
public subroutine wf_dati_gruppo (long al_gruppo)
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

public subroutine wf_controlla ();decimal li_per,li_app,li_imp
long ll_row,i
string ls_sconto
ll_row=tab_1.tabpage_2.dw_scag_prov_condizione.getrow()
ls_sconto=tab_1.tabpage_2.dw_scag_prov_condizione.gettext()
if ls_sconto='P' then
	li_per=-1
	for i=1 to tab_1.tabpage_2.dw_scag_prov_condizione.rowcount()
		li_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(i,"scag_provvigione_a_per_sconto")
		if li_app>li_per then li_per=li_app
	next
	li_per++
	if li_per=0 then li_per=1
	ll_row=tab_1.tabpage_2.dw_scag_prov_condizione.getrow()
	if li_per>=100 then setnull(li_per)
	tab_1.tabpage_2.dw_scag_prov_condizione.setitem(ll_row,"scag_provvigione_da_per_sconto",li_per)
elseif ls_sconto='I' then
	li_imp=-1
	for i=1 to tab_1.tabpage_2.dw_scag_prov_condizione.rowcount()
		li_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(i,"a_imp_sconto")
		if li_app>li_imp then li_imp=li_app
	next
	li_imp++
	ll_row=tab_1.tabpage_2.dw_scag_prov_condizione.getrow()
	tab_1.tabpage_2.dw_scag_prov_condizione.setitem(ll_row,"da_imp_sconto",li_imp)
end if
end subroutine

public function boolean wf_controlla_update ();long ll_rows,i,j
decimal ld_imp_riga,ld_per_riga,ld_imp_cont,ld_per_cont,ld_imp_app,ld_per_app,ld_null
string ls_tipo_sconto
boolean lb_ritorno
integer li_null
lb_ritorno=true
li_null=0
setnull(ld_null)
ll_rows=tab_1.tabpage_2.dw_scag_prov_condizione.rowcount()
for i=1 to ll_rows
	ls_tipo_sconto=tab_1.tabpage_2.dw_scag_prov_condizione.getitemstring(i,"tipo_sconto")
	if ls_tipo_sconto='P' then
		ld_per_cont= -1
		ld_per_riga=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(i,"scag_provvigione_da_per_sconto")
		if not isnull(ld_per_riga) then
			if i>1 then
				for j=i -1 to 1 step -1
					ld_per_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(j,"scag_provvigione_a_per_sconto")
					if ld_per_app>ld_per_cont then ld_per_cont=ld_per_app
				next
				if ld_per_cont<99 or li_null>1 then 
					if ld_per_riga<=ld_per_cont then
						tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"scag_provvigione_da_per_sconto",ld_per_cont+1)
						ld_per_riga=ld_per_cont+1
					end if
					ld_per_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(i,"scag_provvigione_a_per_sconto")
					if ld_per_app<=ld_per_riga  or isnull(ld_per_app) then
						tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"scag_provvigione_a_per_sconto",ld_per_riga +1)
					end if
				else
					lb_ritorno=false
				end if
			else
				
				if isnull(tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(1,"scag_provvigione_a_per_sconto")) then
					ld_per_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(1,"scag_provvigione_da_per_sconto")
					tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"scag_provvigione_a_per_sconto",ld_per_riga +1)
				end if
			end if
			
		else
			li_null++
			if li_null<=1 then
				tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"scag_provvigione_a_per_sconto",ld_null)
			else
				return false
			end if
		end if
	elseif ls_tipo_sconto='I' then
		li_null=0
		ld_imp_cont= -1
		ld_imp_riga=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(i,"da_imp_sconto")
		if not isnull(ld_imp_riga) then
			if i>1 then
				for j=i -1 to 1 step -1
					ld_imp_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(j,"a_imp_sconto")
					if ld_imp_app>ld_imp_cont then ld_imp_cont=ld_imp_app
				next
				if ld_imp_riga<=ld_imp_cont then 
					tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"da_imp_sconto",ld_imp_cont+1)
					ld_imp_riga=ld_imp_cont+1
				end if
				ld_imp_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(i,"a_imp_sconto")
				if ld_imp_app<=ld_imp_riga or isnull(ld_imp_app)then
					tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"a_imp_sconto",ld_imp_riga +1)
				end if
			else
				if isnull(tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(1,"a_imp_sconto")) then
					ld_imp_app=tab_1.tabpage_2.dw_scag_prov_condizione.getitemnumber(1,"da_imp_sconto") 
					tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"a_imp_sconto",ld_imp_riga +1 )
				end if
			end if
		else
			li_null++
			if li_null<=1 then
				tab_1.tabpage_2.dw_scag_prov_condizione.setitem(i,"a_imp_sconto",ld_null)
			else
				return false
			end if
		end if
	end if
next

return lb_ritorno

end function

public subroutine wf_dati_gruppo (long al_gruppo);long ll_agente,ll_capo,ll_sub
string ls_cod,ls_des
select id_sog_com_capo_area,id_sog_com_agente,id_sog_com_sub_agente,codice,descrizione
into :ll_capo,:ll_agente,:ll_sub,:ls_cod,:ls_des
from gruppo_agenti
where id_gruppo_agenti=:al_gruppo;
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"gruppo_agenti_codice",ls_cod)
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"gruppo_agenti_descrizione",ls_des)	
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"capo_area_codice",wf_select_sogg (ll_capo , 1 ) )
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"capo_area_descrizione",wf_select_sogg (ll_capo, 2 ) )
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"agente_codice",wf_select_sogg (ll_agente, 1 ) )
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"agente_descrizione",wf_select_sogg ( ll_agente, 2 ) )
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"sub_agente_codice",wf_select_sogg (ll_sub, 1 ) )
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"sub_agente_descrizione",wf_select_sogg ( ll_sub, 2 ) )
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"cid_sog_com_capo_area",ll_capo)
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"cid_sog_com_agente",ll_agente)
tab_1.tabpage_1.dw_scag_provvigione_2_ff.setitem(1,"cid_sog_com_sub_agente", ll_sub)
end subroutine

on w_scaglione_provvigione_cx.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_scaglione_provvigione_cx.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_scag_provvigione_2_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_con_provvigione"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_con_provvigione"
ib_nonmodale=true


end event

event ue_master_delete;


if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false
	IF (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()

end event

type p_crescente from w_p_data`p_crescente within w_scaglione_provvigione_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_scaglione_provvigione_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_scaglione_provvigione_cx
int X=37
int Y=20
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_scaglione_provvigione_cx
int X=329
int Y=20
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scaglione_provvigione_cx
int X=622
int Y=20
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_scaglione_provvigione_cx
int X=2194
int Y=20
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_scaglione_provvigione_cx
int X=2487
int Y=20
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_scaglione_provvigione_cx
int X=2779
int Y=20
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_scaglione_provvigione_cx
int X=32
int Y=152
int Width=3008
int Height=1644
int TabOrder=10
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
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2971
int Height=1524
long BackColor=79741120
string Text="Condizioni"
long TabBackColor=79741120
dw_scag_provvigione_2_ff dw_scag_provvigione_2_ff
end type

on tabpage_1.create
this.dw_scag_provvigione_2_ff=create dw_scag_provvigione_2_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scag_provvigione_2_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_scag_provvigione_2_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_scaglione_provvigione_cx
int X=1426
int Y=20
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long ll_seg_value
s_ric_param ls_ric_param
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="gruppo_agenti_codice"
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

type dw_scag_provvigione_2_ff from u_dw_master_main within tabpage_1
int X=14
int Y=20
int Width=2930
int Height=1480
int TabOrder=50
boolean BringToTop=true
string DataObject="d_scag_provvigione_ff"
end type

event itemchanged;string ls_null,ls_cod,ls_des
string ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok
long ll_id
setnull(ls_null)
choose case dwo.name
	case "cid_cat_com_articolo","cid_cat_com_articolo2"
		uf_set_colval("cdescrizione", ls_null)
		uf_set_colval("cid_articolo", ls_null)
		uf_set_colval("ccodice", ls_null)
		uf_set_colval("codice", ls_null)
		uf_set_colval("descrizione",ls_null)
		uf_set_colval("id_unita_confezione", ls_null)
	case "cid_cat_com_sc","cid_cat_com_sc2"
		uf_set_colval("sog_commerciale_codice", ls_null)
		uf_set_colval("sog_commerciale_descrizione", ls_null)
		uf_set_colval("cid_sog_commerciale", ls_null)
	case "ccodice"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "cid_articolo"
		ls_dwc[2] = "ccodice"
		ls_dwc[3] = "cdescrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	case "cdescrizione"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "cid_articolo"
		ls_dwc[2] = "ccodice"
		ls_dwc[3] = "cdescrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	
	case "ccodice_b"
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo_a"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "ccodice_b"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "cdescrizione_b"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	case "cdescrizione"
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo_a"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "ccodice_b"		
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "cdescrizione_b"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)		
	
	case "codice"
		ls_dbc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dwc[2] = "codice"
		ls_dwc[3] = "descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"unita_confezione","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	case "descrizione"
		ls_dbc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dwc[2] = "codice"
		ls_dwc[3] = "descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"unita_confezione","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	case "sog_commerciale_codice"
		ls_dbc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[1] = "cid_sog_commerciale"
		ls_dwc[2] = "sog_commerciale_codice"
		ls_dwc[3] = "sog_commerciale_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	case "sog_commerciale_descrizione"
		ls_dbc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[1] = "cid_sog_commerciale"
		ls_dwc[2] = "sog_commerciale_codice"
		ls_dwc[3] = "sog_commerciale_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)	
	case "gruppo_agenti_codice"
		ls_dbc[1] = "id_gruppo_agenti"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dbc[4] = "id_sog_com_capo_area"
		ls_dbc[5] = "id_sog_com_agente"
		ls_dbc[6] = "id_sog_com_sub_agente"
		ls_dwc[1] = "id_gruppo_agenti"
		ls_dwc[2] = "gruppo_agenti_codice"
		ls_dwc[3] = "gruppo_agenti_descrizione"
		ls_dwc[4] = "cid_sog_com_capo_area"
		ls_dwc[5] = "cid_sog_com_agente"
		ls_dwc[6] = "cid_sog_com_sub_agente"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti","codice","A",data,"",6,ls_dbc,ls_dbv,ls_dwc)
		ll_id=this.getitemnumber(1,"cid_sog_com_capo_area")
		uf_set_colval("capo_area_codice",wf_select_sogg (ll_id, 1 ) )
		uf_set_colval("capo_area_descrizione",wf_select_sogg (ll_id, 2 ) )
		ll_id=this.getitemnumber(1,"cid_sog_com_agente")
		uf_set_colval("agente_codice",wf_select_sogg (ll_id, 1 ) )
		uf_set_colval("agente_descrizione",wf_select_sogg (ll_id, 2 ) )
		ll_id=this.getitemnumber(1,"cid_sog_com_sub_agente")
		uf_set_colval("sub_agente_codice",wf_select_sogg (ll_id, 1 ) )
		uf_set_colval("sub_agente_descrizione",wf_select_sogg (ll_id, 2 ) )
	case "gruppo_agenti_descrizione"
		ls_dbc[1] = "id_gruppo_agenti"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dbc[4] = "id_sog_com_capo_area"
		ls_dbc[5] = "id_sog_com_agente"
		ls_dbc[6] = "id_sog_com_sub_agente"
		ls_dwc[1] = "id_gruppo_agenti"
		ls_dwc[2] = "gruppo_agenti_codice"
		ls_dwc[3] = "gruppo_agenti_descrizione"
		ls_dwc[4] = "cid_sog_com_capo_area"
		ls_dwc[5] = "cid_sog_com_agente"
		ls_dwc[6] = "cid_sog_com_sub_agente"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti","descrizione","A",data,"",6,ls_dbc,ls_dbv,ls_dwc)		
		ll_id=this.getitemnumber(1,"cid_sog_com_capo_area")
		uf_set_colval("capo_area_codice",wf_select_sogg (ll_id, 1 ) )
		uf_set_colval("capo_area_descrizione",wf_select_sogg (ll_id, 2 ) )
		ll_id=this.getitemnumber(1,"cid_sog_com_agente")
		uf_set_colval("agente_codice",wf_select_sogg (ll_id, 1 ) )
		uf_set_colval("agente_descrizione",wf_select_sogg (ll_id, 2 ) )
		ll_id=this.getitemnumber(1,"cid_sog_com_sub_agente")
		uf_set_colval("sub_agente_codice",wf_select_sogg (ll_id, 1 ) )
		uf_set_colval("sub_agente_descrizione",wf_select_sogg (ll_id, 2 ) )
	
	CASE "rag_soc_1"
		ls_dbc[1] = "id_anagrafica"
		ls_dwc[1] = "id_anagrafica"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "rag_soc_1"
		li_ok = uf_autofind_col(dwo.Name, "anagrafica", &
										"rag_soc_1", "A", data, & 
										'', 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF		
		
end choose
end event

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_con_provvigione"
iudw_children[1] = tab_1.tabpage_2.dw_scag_prov_condizione





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
	CASE "codice"
			
			is_search_window = "w_unita_confezione_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			
			is_ricpar.s_filter_name = "unita_confezione_codice"
	CASE "descrizione"
			
			is_search_window = "w_unita_confezione_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			
			is_ricpar.s_filter_name = "unita_confezione_descrizione"
	CASE "ccodice"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "cdescrizione"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
	
	CASE "ccodice_b"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "cdescrizione_b"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"	
	
	
	CASE "rag_soc_1"
			is_search_window = "w_anagrafica_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="rag_soc_1"
	
END CHOOSE

end event

event ue_use_search;string ls_null
setnull(ls_null)
choose case as_nomecol   
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
		
	CASE "sog_commerciale_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("cid_cat_com_sc",ls_null)
		uf_set_colval("cid_cat_com_sc", ls_null)			
	CASE "sog_commerciale_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("cid_cat_com_sc",ls_null)
		uf_set_colval("cid_cat_com_sc2", ls_null)		


	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("ccodice", ls_null)
		uf_set_colval("cdescrizione",ls_null)
		uf_set_colval("cid_articolo", ls_null)
		uf_set_colval("cid_cat_com_articolo",ls_null)
		uf_set_colval("cid_cat_com_articolo2", ls_null)		
	CASE "descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("ccodice", ls_null)
		uf_set_colval("cdescrizione",ls_null)
		uf_set_colval("cid_articolo", ls_null)
		uf_set_colval("cid_cat_com_articolo",ls_null)
		uf_set_colval("cid_cat_com_articolo2", ls_null)
	CASE "ccodice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cdescrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("codice", ls_null)
		uf_set_colval("descrizione",ls_null)
		uf_set_colval("id_unita_confezione", ls_null)
		uf_set_colval("cid_cat_com_articolo",ls_null)
		uf_set_colval("cid_cat_com_articolo2", ls_null)
	CASE "cdescrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cid_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("ccodice", is_ricpar.s_ausil_value[1])
		uf_set_colval("codice", ls_null)
		uf_set_colval("descrizione",ls_null)
		uf_set_colval("id_unita_confezione", ls_null)
		uf_set_colval("cid_cat_com_articolo",ls_null)
		uf_set_colval("cid_cat_com_articolo2", ls_null)
	
	CASE "ccodice_b"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo_a", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cdescrizione_b", is_ricpar.s_ausil_value[1])
		uf_set_colval("codice", ls_null)
		uf_set_colval("descrizione",ls_null)
		uf_set_colval("id_unita_confezione", ls_null)
		uf_set_colval("cid_cat_com_articolo",ls_null)
		uf_set_colval("cid_cat_com_articolo2", ls_null)
	CASE "cdescrizione_b"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo_a", is_ricpar.s_id_seg_value[1])
		uf_set_colval("ccodice_b", is_ricpar.s_ausil_value[1])
		uf_set_colval("codice_b", ls_null)
		uf_set_colval("descrizione",ls_null)
		uf_set_colval("id_unita_confezione", ls_null)
		uf_set_colval("cid_cat_com_articolo",ls_null)
		uf_set_colval("cid_cat_com_articolo2", ls_null)	
	
	
	CASE "rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_anagrafica", is_ricpar.s_id_seg_value[1])
	
end choose


end event

event updatestart;
end event

event ue_insert;call super::ue_insert;long li_row

li_row = getrow()
this.object.data_inizio[li_row] = date(string(year(today())) + "/01/01")



end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2971
int Height=1524
long BackColor=79741120
string Text="Provvigioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scag_prov_condizione dw_scag_prov_condizione
end type

on tabpage_2.create
this.dw_scag_prov_condizione=create dw_scag_prov_condizione
this.Control[]={this.dw_scag_prov_condizione}
end on

on tabpage_2.destroy
destroy(this.dw_scag_prov_condizione)
end on

type dw_scag_prov_condizione from u_dw_master_main within tabpage_2
int X=18
int Y=24
int Width=2930
int Height=1392
int TabOrder=12
boolean BringToTop=true
string DataObject="d_scag_prov_condizione"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event getfocus;call super::getfocus;this.object.ret1.brush.color = "10789024"
this.object.ret2.brush.color = "10789024"
long i,ll_capo,ll_agente,ll_sub_agente
if tab_1.tabpage_1.dw_scag_provvigione_2_ff.rowcount()>0 then
	ll_capo=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_sog_com_capo_area")
	ll_agente=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_sog_com_agente")
	ll_sub_agente=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_sog_com_sub_agente")
	for i= 1 to rowcount()	
		this.setitem(i,"ccon_capo",ll_capo)
		this.setitem(i,"cagente",ll_agente)
		this.setitem(i,"csub_agente",ll_sub_agente)
	next
end if
	



end event

event itemchanged;string ls_per,ls_imp
decimal ld_null
setnull(ld_null)
if dwo.name="tipo_sconto" then
	wf_controlla()
	if data='P' then
		select tipo_prov_per_sconto
		into :ls_per
		from par_sistema;
		if sqlca.sqlcode=0 then
			this.setitem(row,"scag_provvigione_tipo_applicazione",ls_per)
		else
			messagebox("Errore","Errore di impostazione nei parametri di sistema",stopsign!)
			this.deleterow(row)
		end if
		dw_scag_prov_condizione.setitem(row,"da_imp_sconto",ld_null)
		dw_scag_prov_condizione.setitem(row,"a_imp_sconto",ld_null)	
	else
		select tipo_prov_imp_sconto
		into :ls_imp
		from par_sistema;
		if sqlca.sqlcode=0 then
			this.setitem(row,"scag_provvigione_tipo_applicazione",ls_imp)
		else
			messagebox("Errore","Errore di impostazione nei parametri di sistema",stopsign!)
			this.deleterow(row)
		end if		
		dw_scag_prov_condizione.setitem(row,"scag_provvigione_da_per_sconto",ld_null)
		dw_scag_prov_condizione.setitem(row,"scag_provvigione_a_per_sconto",ld_null)
	end if
end if


end event

event losefocus;call super::losefocus;this.object.ret1.brush.color = "79741120"
this.object.ret2.brush.color = "79741120"

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_con_provvigione"
									
end event

event ue_insert;call super::ue_insert;
long ll_valuta, ll_capo,ll_agente,ll_sub_agente
wf_controlla()
select id_valuta
into:ll_valuta
from par_sistema;
this.setitem(getrow(),"scag_provvigione_id_valuta",ll_valuta)
ll_capo=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_sog_com_capo_area")
ll_agente=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_sog_com_agente")
ll_sub_agente=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_sog_com_sub_agente")
this.setitem(getrow(),"ccon_capo",ll_capo)
this.setitem(getrow(),"cagente",ll_agente)
this.setitem(getrow(),"csub_agente",ll_sub_agente)
string ls_tipo_applicazione
select tipo_prov_per_sconto
into :ls_tipo_applicazione
from par_sistema
;
if sqlca.sqlcode=0 then
	this.setitem(getrow(),"tipo_sconto",'P')
		this.setitem(getrow(),"scag_provvigione_tipo_applicazione",ls_tipo_applicazione)
else
	messagebox("Errore","Errore di impostazione nei parametri di sistema!",stopsign!)
end if
end event

event updatestart;long ll_row
boolean lb_con
ll_row=this.getrow()
this.sort()
this.setrow(ll_row)
lb_con=wf_controlla_update()
if lb_con=false then 
	Messagebox("Errore","I dati inseriti non sono validi impossibile salvare!",Stopsign!)
	return 1
END IF
end event

type cb_1 from commandbutton within w_scaglione_provvigione_cx
int X=1879
int Y=20
int Width=283
int Height=88
int TabOrder=20
boolean BringToTop=true
string Text="Provvigioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;opensheet(w_scaglione_provvigione_lt,w_app_frame)
end event

type cb_2 from commandbutton within w_scaglione_provvigione_cx
int X=1134
int Y=20
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_grup_ag,ls_sog_com,ls_cat_com_sc,ls_uni_conf,ls_articolo,ls_cat_com_art,ls_filtro
long ll_cat_com_sc,ll_cat_com_art
tab_1.tabpage_1.dw_scag_provvigione_2_ff.accepttext()
ls_grup_ag=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemstring(1,"gruppo_agenti_codice")
ls_sog_com=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemstring(1,"sog_commerciale_codice")
ll_cat_com_sc=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_cat_com_sc")
ls_uni_conf=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemstring(1,"codice")
ls_articolo=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemstring(1,"ccodice")
ll_cat_com_art=tab_1.tabpage_1.dw_scag_provvigione_2_ff.getitemnumber(1,"cid_cat_com_articolo")


select cat_com_sc.codice
into :ls_cat_com_sc
from cat_com_sc
where cat_com_sc.id_cat_com_sc=:ll_cat_com_sc;


select cat_com_articolo.codice
into :ls_cat_com_art
from cat_com_articolo
where cat_com_articolo.id_cat_com_articolo=:ll_cat_com_art;




if not isnull(ls_grup_ag) and ls_filtro='' then
	ls_filtro='gruppo_agenti_codice='+'"'+string(ls_grup_ag)+'" or isnull(gruppo_agenti_codice) '
else
if not isnull(ls_grup_ag)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (gruppo_agenti_codice='+'"'+string(ls_grup_ag)+'"'+' or isnull(gruppo_agenti_codice))'
end if
end if

if not isnull( ls_sog_com) and ls_filtro='' then
	ls_filtro='sog_commerciale_codice="'+string(ls_sog_com)+'" or isnull(sog_commerciale_codice)'
else
if not isnull( ls_sog_com)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (sog_commerciale_codice="'+string(ls_sog_com)+'" or isnull(sog_commerciale_codice))'
end if
end if


if not isnull(ls_uni_conf) and ls_filtro='' then
	ls_filtro='unita_confezione_codice='+'"'+string(ls_uni_conf)+'" or isnull(unita_confezione_codice)'
else
if not isnull(ls_uni_conf) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (unita_confezione_codice='+'"'+string(ls_uni_conf)+'"'+' or isnull(unita_confezione_codice))'
end if
end if

if not isnull(ls_articolo)and ls_filtro='' then
	ls_filtro='(articolo_codice='+'"'+string(ls_articolo)+'" or isnull(articolo_codice))'
else
if not isnull(ls_articolo) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (articolo_codice='+'"'+string(ls_articolo)+'"'+' or isnull(articolo_codice))'
end if
end if

if ls_cat_com_art<>'' and ls_filtro='' then
	ls_filtro='(cat_com_articolo_codice='+'"'+string(ls_cat_com_art)+'" or isnull(cat_com_articolo_codice))'
else
if ls_cat_com_art<>'' and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (cat_com_articolo_codice='+'"'+string(ls_cat_com_art)+'"'+' or isnull(cat_com_articolo_codice))'
end if
end if

if ls_cat_com_sc<>'' and ls_filtro='' then
	ls_filtro='(cat_com_sc_codice='+'"'+string(ls_cat_com_sc)+'" or isnull(cat_com_sc_codice))'
else
if ls_cat_com_sc<>'' and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (cat_com_sc_codice='+'"'+string(ls_cat_com_sc)+'"'+' or isnull(cat_com_sc_codice))'
end if
end if
openwithparm(w_stp_sc_provv_gen_gd,ls_filtro)









end event

