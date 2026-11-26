forward
global type w_inserisci_cdc_ff from w_p_data
end type
type dw_1 from u_dw_master_main within w_inserisci_cdc_ff
end type
type dw_2 from u_dw_master_main within w_inserisci_cdc_ff
end type
end forward

global type w_inserisci_cdc_ff from w_p_data
int Width=2341
int Height=1176
dw_1 dw_1
dw_2 dw_2
end type
global w_inserisci_cdc_ff w_inserisci_cdc_ff

type variables
long il_conto, ll_canc[]


end variables

forward prototypes
public subroutine uf_delete (integer ll_testa)
end prototypes

public subroutine uf_delete (integer ll_testa);delete from centro_costo_righe where id_cen_cos_t=:ll_testa;
delete from centro_costo_testa where id_cen_cos_t=:ll_testa;
dw_1.reset()
dw_2.reset()
dw_1.insertrow(1)

end subroutine

on w_inserisci_cdc_ff.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_inserisci_cdc_ff.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)



idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_cen_cos_t"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "centro_costo_testa.id_cen_cos_t"


s_list_main lstr_list

dw_1.insertrow(0)







idw_master.is_list.s_modo=modo_inserisci
ib_nonmodale = true

integer i
for i=1 to upperbound(ll_canc[])
	setnull(ll_canc[i])
next

end event

event ue_post_open;call super::ue_post_open;cb_ricerca.visible=true
end event

event ue_master_delete;long  ll_testa
ll_testa=dw_1.getitemnumber(1,'id_cen_cos_t')

uf_delete(ll_testa)
end event

type p_crescente from w_p_data`p_crescente within w_inserisci_cdc_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_inserisci_cdc_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_inserisci_cdc_ff
int Width=238
boolean BringToTop=true
end type

event cb_ok::clicked;call super::clicked;
end event

type cb_annulla from w_p_data`cb_annulla within w_inserisci_cdc_ff
int X=306
int Width=242
boolean BringToTop=true
end type

event cb_annulla::clicked;call super::clicked;
end event

type cb_nuovo from w_p_data`cb_nuovo within w_inserisci_cdc_ff
int X=791
int Width=242
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;
end event

type cb_inserisci from w_p_data`cb_inserisci within w_inserisci_cdc_ff
int X=1440
int Width=238
boolean BringToTop=true
end type

event cb_inserisci::clicked;call super::clicked;
end event

type cb_cancella from w_p_data`cb_cancella within w_inserisci_cdc_ff
int X=1696
int Width=238
boolean BringToTop=true
end type

event cb_cancella::clicked;call super::clicked;
end event

type cb_salva from w_p_data`cb_salva within w_inserisci_cdc_ff
int X=2039
int Width=233
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_inserisci_cdc_ff
int X=2208
int Y=776
int Width=69
int Height=36
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
long BackColor=80263581
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=32
long BackColor=80263581
string Text="Deviazione costi"
long TabBackColor=80263581
end type

type cb_ricerca from w_p_data`cb_ricerca within w_inserisci_cdc_ff
int X=1056
int Width=242
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

event cb_ricerca::clicked;w_search_main lw_sm
long ll_cdc_testa
string ls_conto
s_ric_param ls_ricpar

ls_conto=dw_1.getitemstring(1,'ccod')
idw_master.is_ricpar.s_filter_value = ls_conto
idw_master.is_ricpar.s_filter_name = "conto_codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_cerca_cdc_sw")

idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_cdc_testa=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_identifica[1] = "id_cen_cos_t"
	idw_master.is_list.l_identifica[1] = ll_cdc_testa
	SetPointer(HourGlass!)
	idw_master.Event ue_retrieve(0, 0)
	setPointer(Arrow!)
	
end if
end event

type dw_1 from u_dw_master_main within w_inserisci_cdc_ff
int X=46
int Y=148
int Width=2235
int Height=316
int TabOrder=10
boolean BringToTop=true
string DataObject="d_testa_smista_cdc_gd"
end type

event itemchanged;string ls_filtro
integer li_ok

string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_testa_cdc, ll_conto

setnull(ls_null)


CHOOSE CASE dwo.name
		
	CASE "ccod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "ccod"
		ls_dwc[2] = "cdes"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			ll_conto=long(ls_dbv[3])
			select id_cen_cos_t
			into :ll_testa_cdc
			from centro_costo_testa
			where id_conto=:ll_conto;
			IF ll_testa_cdc<>0 and not isnull(ll_testa_cdc) then
				idw_master.is_list.s_identifica[1] = "id_cen_cos_t"
				idw_master.is_list.l_identifica[1] = ll_testa_cdc
				SetPointer(HourGlass!)
				idw_master.Event ue_retrieve(0, 0)
				setPointer(Arrow!)
			
			end if
			RETURN 2
		END IF
		
		
	case "cdes"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "ccod"
		ls_dwc[2] = "cdes"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			ll_conto=long(ls_dbv[3])
			select id_cen_cos_t
			into :ll_testa_cdc
			from centro_costo_testa
			where id_conto=:ll_conto;
			IF ll_testa_cdc<>0 and not isnull(ll_testa_cdc) then
				idw_master.is_list.s_identifica[1] = "id_cen_cos_t"
				idw_master.is_list.l_identifica[1] = ll_testa_cdc
				SetPointer(HourGlass!)
				idw_master.Event ue_retrieve(0, 0)
				setPointer(Arrow!)
			
			end if
			RETURN 2
		END IF
		
end choose

end event

event ue_set_search;string ls_cond

CHOOSE CASE as_nomecol
	CASE "ccod", "cdes"
		is_search_window = "w_CONTI_IN_PDC_SW"
      
		 
		IF as_nomecol = "ccod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "cdes" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF


END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro
long ll_testa, LL_RET

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "ccod"
		dw_2.reset()
		dw_1.reset()
		dw_1.insertrow(1)
		uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[2])
		uf_set_colval("cdes", is_ricpar.s_ausil_value[1])
		LL_ret=LONG(is_ricpar.s_main_value)
		SELECT ID_CEN_COS_T
		INTO :LL_TESTA
		FROM CENTRO_COSTO_TESTA
		WHERE ID_CONTO=:LL_RET;
		IF ll_testa<>0 and not isnull(ll_testa) then
			idw_master.is_list.s_identifica[1] = "id_cen_cos_t"
			idw_master.is_list.l_identifica[1] = ll_testa
			SetPointer(HourGlass!)
			idw_master.Event ue_retrieve(0, 0)
			setPointer(Arrow!)
			
		end if	
	CASE "cdes"
		dw_2.reset()
		dw_1.reset()
		dw_1.insertrow(1)
	 	uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("ccod", is_ricpar.s_ausil_value[2])
		LL_ret=LONG(is_ricpar.s_main_value)
		SELECT ID_CEN_COS_T
		INTO :LL_TESTA
		FROM CENTRO_COSTO_TESTA
		WHERE ID_CONTO=:LL_RET;
		IF ll_testa<>0 and not isnull(ll_testa) then
			idw_master.is_list.s_identifica[1] = "id_cen_cos_t"
			idw_master.is_list.l_identifica[1] = ll_testa
			SetPointer(HourGlass!)
			idw_master.Event ue_retrieve(0, 0)
			setPointer(Arrow!)
			
		end if	
END CHOOSE










end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_cen_cos_t"
iudw_children[1] = dw_2
end event

type dw_2 from u_dw_master_main within w_inserisci_cdc_ff
int X=41
int Y=492
int Width=2235
int Height=572
int TabOrder=20
boolean BringToTop=true
string DataObject="d_smista_costi_cdc2_gd"
end type

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "codice"
		uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[2])
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])
	CASE "descrizione"
	 	uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("codice", is_ricpar.s_ausil_value[2])
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;string ls_cond, ls_controllo
long ll_pdc

select id_pdc_cen_costo
into :ll_pdc
from azienda;
ls_controllo=string (ll_pdc)


CHOOSE CASE as_nomecol
	CASE "codice", "descrizione"
		is_search_window = "W_CONTI_IN_PDC_SW"
		IS_RICPAR.S_SQL_COND="PDC.ID_PDC='"+ls_controllo+"'" 

		IF as_nomecol = "codice" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "descrizione" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF


END CHOOSE	
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_cen_cos_t"
end event

event itemchanged;string ls_filtro, ls_controllo
integer li_ok

string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_testa_cdc, ll_conto, ll_pdc

setnull(ls_null)

select id_pdc_cen_costo
into :ll_pdc
from azienda;
ls_controllo=string (ll_pdc)


CHOOSE CASE dwo.name
		
	CASE "codice"
		ls_sql_cond = "PDC.ID_PDC='"+ls_controllo+"'" 
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "descrizione"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "descrizione"
		ls_sql_cond = "PDC.ID_PDC='"+ls_controllo+"'" 
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "descrizione"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose

end event

event ue_update;


long ll_testa, ll_perc, ll_conto, ll_controllo
integer i

ll_perc=0
if dw_2.rowcount() >0 then
for i =1 to dw_2.rowcount() 
	if isnull(dw_2.getitemnumber(i,'id_conto')) then
		dw_2.deleterow(i)
		i=i - 1
	else	
		ll_perc=ll_perc+dw_2.getitemnumber(i,'base_perc')
	end if
next
if ll_perc<>100 then
  if 	messagebox('Attenzione','La percentuale di assegnazione dei vari centri di costo è diversa dal 100%! Vuoi proseguire?',Information!,YesNo!)=2 then return 1  
end if
end if
Super::Event ue_update(wparam,lparam)
end event

