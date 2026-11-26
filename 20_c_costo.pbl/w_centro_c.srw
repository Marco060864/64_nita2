forward
global type w_centro_c from w_p_data
end type
type dw_1 from u_dw_master_main within w_centro_c
end type
type dw_2 from u_dw_master_main within w_centro_c
end type
type st_1 from statictext within w_centro_c
end type
type dw_3 from u_dw_master_main within w_centro_c
end type
type cb_1 from commandbutton within w_centro_c
end type
end forward

global type w_centro_c from w_p_data
int Width=2469
int Height=1608
boolean TitleBar=true
string Title="Gestione centri di costo"
dw_1 dw_1
dw_2 dw_2
st_1 st_1
dw_3 dw_3
cb_1 cb_1
end type
global w_centro_c w_centro_c

type variables

end variables

event open;call super::open;
idw_master= dw_1
idw_master.is_list= Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_cen_cos_t"
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner=true
idw_master.is_list.s_sql_ident[1]="id_cen_cos_t"
ib_nonmodale=true


end event

on w_centro_c.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_1
end on

on w_centro_c.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_1)
end on

type p_crescente from w_p_data`p_crescente within w_centro_c
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_centro_c
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_centro_c
int X=23
int Width=238
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_centro_c
int X=274
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_centro_c
int X=549
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_centro_c
int X=1600
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_centro_c
int X=1874
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_centro_c
int X=2149
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_centro_c
int Width=389
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=16
int Width=352
int Height=1288
boolean Visible=false
long BackColor=79741120
long TabBackColor=79741120
end type

type cb_ricerca from w_p_data`cb_ricerca within w_centro_c
int X=1326
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;

string ls_filtro, ls_codice
long ll_id_cen_cos_t
w_search_main lw_sm
idw_master.is_ricpar.s_filter_value= ls_codice
idw_master.is_ricpar.s_filter_name="id_cen_cos_t"

openwithparm(lw_sm,idw_master.is_ricpar,"w_centro_c_r_SW")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value) >0 then
	LL_id_cen_cos_t=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo= modo_modifica
	
	idw_master.is_list.s_identifica[1]="id_cen_cos_t"
	idw_master.is_list.l_identifica[1]=LL_id_cen_cos_t
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if	


end event

type dw_1 from u_dw_master_main within w_centro_c
int X=23
int Y=336
int Width=2400
int Height=204
int TabOrder=30
string DataObject="d_centro_cost_testa"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_cen_cos_t"
iudw_children[1]=dw_2
iudw_children[2] = dw_3


end event

event ue_set_search;call super::ue_set_search;choose case as_nomecol
		case "conto_codice"
		Is_search_window="w_pdc1cenr_sw"
     	is_ricpar.s_filter_value= as_valcol
		is_ricpar.s_filter_name= "conto_codice"
		is_ricpar.b_imm_retrieve = TRUE 
	
	case "conto_descrizione"
		Is_search_window="w_pdc1cenr_sw"
		is_ricpar.s_filter_value= as_valcol
		is_ricpar.s_filter_name= "conto_descrizione"
		is_ricpar.b_imm_retrieve = TRUE 
end choose

is_ricpar.b_imm_retrieve=true 
Super::Event ue_set_search(as_nomecol, as_valcol) 
	
end event

event ue_use_search;call super::ue_use_search;choose case as_nomecol
	case "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
   	uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])
		
	case "conto_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
   	uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
end choose



end event

event itemchanged;



string   	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long 		 	ll_ok
ls_sql_cond = ""

CHOOSE CASE string(dwo.name)
   CASE 'conto_codice'
      ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "conto_codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)		
		
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

CASE 'conto_descrizione'

		ls_sql_cond = ''	
		ls_dbc[1] = "codice"
		ls_dwc[1] = "conto_codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
		
end choose		
end event

type dw_2 from u_dw_master_main within w_centro_c
int X=37
int Y=652
int Width=2400
int Height=844
int TabOrder=20
string DataObject="d_centro_cost_righe"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_cen_cos_t"

end event

event ue_set_search;call super::ue_set_search;choose case as_nomecol
	case "conto_codice"
		Is_search_window= "w_pdc1r_sw"
		is_ricpar.s_filter_value= as_valcol
		is_ricpar.s_filter_name= "conto_codice"
		is_ricpar.b_imm_retrieve=true
	case "conto_descrizione"
		Is_search_window= "w_pdc1r_sw"
		is_ricpar.s_filter_value= as_valcol
		is_ricpar.s_filter_name= "conto_descrizione"
		is_ricpar.b_imm_retrieve=true
end choose


end event

event ue_use_search;call super::ue_use_search;choose case as_nomecol
	case "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])
   case "conto_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
end choose

end event

event updateend;call super::updateend;

end event

event updatestart;call super::updatestart;

integer li_perc
long ll_riga
string ls_tipo_aggrega

ll_riga=dw_2.rowcount()

IF ll_riga>0 THEN
	li_perc=dw_2.getitemnumber(ll_riga,"centro_costo_righe_base_perc")
		
	if isnull(li_perc) then
      dw_2.setitem(ll_riga,"centro_costo_righe_base_perc",100)	
	end if

END IF

end event

event ue_insert;call super::ue_insert;

integer li_perc
long ll_riga
string ls_tipo_aggrega

ll_riga=dw_2.getrow()

IF ll_riga>1 THEN
	li_perc=dw_2.getitemnumber(ll_riga - 1,"centro_costo_righe_base_perc")
		
	if isnull(li_perc) then
      dw_2.setitem(ll_riga - 1,"centro_costo_righe_base_perc",100)	
		
	end if

END IF

end event

event itemchanged;

string   	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long 		 	ll_ok
ls_sql_cond = ""

CHOOSE CASE string(dwo.name)
   CASE 'conto_codice'
      ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "conto_codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)		
		
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

CASE 'conto_descrizione'

		ls_sql_cond = ''	
		ls_dbc[1] = "codice"
		ls_dwc[1] = "conto_codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
		
end choose		
end event

type st_1 from statictext within w_centro_c
int X=27
int Y=548
int Width=645
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="Aggregazione Conti"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_3 from u_dw_master_main within w_centro_c
int X=23
int Y=144
int Width=2400
int Height=184
int TabOrder=10
string DataObject="d_az_cen_costo_ff"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

type cb_1 from commandbutton within w_centro_c
int X=2098
int Y=560
int Width=329
int Height=84
int TabOrder=1
boolean BringToTop=true
string Text="Controllo  %"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

open(w_attesa)
open(w_controllo_perc)


end event

