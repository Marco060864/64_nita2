forward
global type w_sit_agente_cx from w_p_data
end type
type dw_sog_commerciale_ag_ff from u_dw_master_main within w_sit_agente_cx
end type
type dw_sit_agente_ff from u_dw_master_main within w_sit_agente_cx
end type
type st_title from statictext within w_sit_agente_cx
end type
end forward

global type w_sit_agente_cx from w_p_data
int Width=2451
int Height=1465
boolean TitleBar=true
string Title="Situazione agente"
dw_sog_commerciale_ag_ff dw_sog_commerciale_ag_ff
dw_sit_agente_ff dw_sit_agente_ff
st_title st_title
end type
global w_sit_agente_cx w_sit_agente_cx

forward prototypes
public function integer uf_update ()
end prototypes

public function integer uf_update ();integer li_size, li_counter
long ll_to_update
u_dw_main ldw_item

ll_to_update = 0

if not idw_master.ib_dw_shared then
	li_size = UpperBound(idw_master.iudw_children)
	for li_counter = 1 to li_size
		ldw_item = idw_master.iudw_children[li_counter]
		ll_to_update = ll_to_update + ldw_item.uf_To_Update()
	next
end if
return ll_to_update

end function

on w_sit_agente_cx.create
int iCurrent
call w_p_data::create
this.dw_sog_commerciale_ag_ff=create dw_sog_commerciale_ag_ff
this.dw_sit_agente_ff=create dw_sit_agente_ff
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_sog_commerciale_ag_ff
this.Control[iCurrent+2]=dw_sit_agente_ff
this.Control[iCurrent+3]=st_title
end on

on w_sit_agente_cx.destroy
call w_p_data::destroy
destroy(this.dw_sog_commerciale_ag_ff)
destroy(this.dw_sit_agente_ff)
destroy(this.st_title)
end on

event open;call super::open;idw_master						= this.dw_sog_commerciale_ag_ff 
idw_master.is_list 			= Message.PowerObjectParm

idw_master.ib_use_scanner	= TRUE
idw_master.is_list.s_sql_ident[1] ="sog_commerciale_gen.id_sog_commerciale"   

If Upperbound(idw_master.is_list.s_identifica) = 0 then
	idw_master.is_list.s_modo = modo_inserisci
end if

ib_nonmodale = true


end event

event ue_post_open;call super::ue_post_open;
long ll_row
ll_row	= idw_master.insertRow(0)
idw_master.ScrollToRow(ll_row)
idw_master.ResetUpdate()
cb_nuovo.visible 		= false
cb_ricerca.visible 	= false
end event

event closequery;
long			ll_mods
integer		li_ync, li_retval
u_dw_main	ludw_1
boolean		lb_ok

ludw_1 = u_freddie.iudw_current
lb_ok = true
if not IsNull (ludw_1) then
	if ludw_1.acceptText()>0 then lb_ok = true else lb_ok = false
end if
if not lb_ok then return 1
if idw_master.acceptText() >0 then lb_ok = true else lb_ok = false
if not lb_ok then return 1

idw_master.ResetUpdate()

if uf_update() > 0 then
	li_ync = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
		"finestra.~n~rVuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			
			THIS.triggerevent("ue_update")
			ll_mods = uf_update()
			if ll_mods = 0 then 
				li_retval = 0
			else
				li_retval = 1
			end if
			
		CASE 2
			
			li_retval = 0
			
		CASE 3
			
			li_retval = 1
			
	END CHOOSE
else
	
	li_retval = 0
	
end if

return li_retval

end event

type p_crescente from w_p_data`p_crescente within w_sit_agente_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_sit_agente_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_sit_agente_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_sit_agente_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_sit_agente_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_sit_agente_cx
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_sit_agente_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_sit_agente_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_sit_agente_cx
int Y=701
int Width=2355
int Height=641
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
boolean ShowText=false
boolean RaggedRight=false
Alignment Alignment=Center!
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=49
int Width=2318
int Height=577
end type

type cb_ricerca from w_p_data`cb_ricerca within w_sit_agente_cx
boolean BringToTop=true
end type

type dw_sog_commerciale_ag_ff from u_dw_master_main within w_sit_agente_cx
event itemchanged pbm_dwnitemchange
event ue_init pbm_custom01
event ue_insert pbm_custom02
event ue_update pbm_custom04
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
int X=46
int Y=161
int Width=2332
int Height=181
int TabOrder=20
string DataObject="d_sog_commerciale_sel_ff"
end type

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_sog_commerciale, ll_id_banca_appoggio
long		 ll_row, ll_ret, ll_temp

ls_sql_cond = ""  

choose case dwo.name
		
	case 'codice'
		ls_dbc[1]  	= "id_sog_commerciale"
		ls_dwc[1]  	= "id_sog_commerciale"
		ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
		ll_row = this.GetRow()
		ll_temp = this.GetItemNumber(ll_row,"id_sog_commerciale")
		if (ll_ok>0) then	
			this.event rowfocuschanged(ll_row)
			this.ResetUpdate()
			return 2
		else
			if isNull(ll_temp) then
				this.event rowfocuschanged(ll_row)				
			end if
		end if

	case 'rag_soc_1'
		
		ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ls_dbc[1]  	= "id_sog_commerciale"
		ls_dwc[1]  	= "id_sog_commerciale"
      ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		
		ll_row = this.GetRow()
		ll_temp = this.GetItemNumber(ll_row,"id_sog_commerciale")
		if (ll_ok>0) then	
			this.event rowfocuschanged(ll_row)
			this.ResetUpdate()
			return 2
		else
			if isNull(ll_temp) then
				this.event rowfocuschanged(ll_row)				
			end if
		end if		
		
end choose
this.ResetUpdate()

end event

event ue_init;call super::ue_init;
iudw_children[1]	= dw_sit_agente_ff
is_list.s_identifica[1] ="id_sog_commerciale"

end event

event ue_insert;
end event

event ue_update;
This.ResetUpdate()
Super ::event ue_update(0,0)


end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"
	CASE "rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "rag_soc_1" 		
	   is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;integer 	li_id_sog_commerciale
long 		ll_row,ll_ret

CHOOSE CASE as_nomecol
		
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])

		if not isNull(is_ricpar.s_id_seg_value[1]) then
			ll_row = this.GetRow()
			this.event rowfocuschanged(ll_row)
		end if
		this.ResetUpdate()
		
	CASE "rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
				
		if not isNull(is_ricpar.s_id_seg_value[1]) then
			ll_row = this.GetRow()
			this.event rowfocuschanged(ll_row)
		end if
		this.ResetUpdate()
END CHOOSE

end event

type dw_sit_agente_ff from u_dw_master_main within w_sit_agente_cx
event ue_init pbm_custom01
event ue_retrieve pbm_custom07
event ue_modify ( )
int X=46
int Y=441
int Width=2332
int Height=881
int TabOrder=10
string DataObject="d_sit_agente_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_title = "Provvigioni"
is_list.s_identifica[1] ="id_sog_commerciale"
is_resp_window = "w_riep_provvigione_ff"
is_list.s_win_chiave[1] = "id_riep_provvigioni"
is_list.s_par_name[1] = "id_sog_commerciale"

end event

event ue_retrieve;call super::ue_retrieve;
long			ll_row,	ll_nrows,		ll_id_documento,		ll_id_cliente
string		ls_cod_esercizio,			ls_tipo_registro,		ls_num_documento 
string		ls_codice_sog_comm,		ls_rag_soc_sog_comm
decimal		ldc_num_registro,			ldc_num_progressivo 
date			ld_data_registrazione,	ld_data_documento,	ld_data_competenza
integer		prova

string 		ls_tip_reg,	ls_doc_dat_doc,	ls_sg_rs
integer		li_eser,		li_reg_num, 		li_doc_num_doc,	li_sg_cod 


ll_nrows = this.rowcount()
if ll_nrows>0 then
	for ll_row = 1 to ll_nrows
		
		ll_id_documento = this.GetItemNumber(ll_row,"id_documento")
		if not isNull(ll_id_documento) then
			
			select	"esercizio"."codice",					"registro"."tipo_registro",
						"registro"."numero",						"documento"."num_progressivo",
						"documento"."data_registrazione",	"documento"."num_documento",
						"documento"."data_documento",			"documento"."data_competenza",
						"sog_commerciale_gen"."codice",		"sog_commerciale_gen"."rag_soc_1"
				into	:ls_cod_esercizio,			:ls_tipo_registro,
						:ldc_num_registro,			:ldc_num_progressivo,
						:ld_data_registrazione,		:ls_num_documento,
						:ld_data_documento,			:ld_data_competenza,
						:ls_codice_sog_comm,			:ls_rag_soc_sog_comm
				from	"dba"."documento",	"dba"."esercizio",
						"dba"."registro",		"dba"."sog_commerciale_gen"
				where	("registro"."id_esercizio" = "esercizio"."id_esercizio") and
						("registro"."id_registro" = "documento"."id_registro") and
						("documento"."id_sog_commerciale" = "sog_commerciale_gen"."id_sog_commerciale") and
						("documento"."id_documento" = :ll_id_documento);

			if SQLCA.SQLCode = 0 then
				this.SetItem(ll_row,"c_codice_esercizio_doc",ls_cod_esercizio)
				this.SetItem(ll_row,"c_tipo_registro_doc",ls_tipo_registro)
				this.SetItem(ll_row,"c_numero_registro_doc",ldc_num_registro)
				this.SetItem(ll_row,"c_num_progressivo_doc",ldc_num_progressivo)
				this.SetItem(ll_row,"c_data_registrazione_doc",ld_data_registrazione)
				this.SetItem(ll_row,"c_num_documento_doc",ls_num_documento)
				this.SetItem(ll_row,"c_data_documento_doc",ld_data_documento)
				this.SetItem(ll_row,"c_data_competenza_doc",ld_data_competenza)
				this.SetItem(ll_row,"c_codice_cliente_doc",ls_codice_sog_comm)
				this.SetItem(ll_row,"c_rag_soc_cliente_doc",ls_rag_soc_sog_comm)
			end if
		else
			ll_id_cliente = this.GetItemNumber(ll_row,"id_cliente")
			select "sog_commerciale_gen"."codice", "sog_commerciale_gen"."rag_soc_1"
				into   :ls_codice_sog_comm,			:ls_rag_soc_sog_comm				
				from   "dba"."sog_commerciale_gen"
				where  "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_cliente;
				
			if SQLCA.SQLCode = 0 then
				this.SetItem(ll_row,"c_codice_cliente_doc",ls_codice_sog_comm)
				this.SetItem(ll_row,"c_rag_soc_cliente_doc",ls_rag_soc_sog_comm)
			end if	
			ldc_num_progressivo = this.GetItemNumber(ll_row,"num_progressivo")
			this.SetItem (ll_row,"c_num_progressivo_doc",ldc_num_progressivo)
			ld_data_registrazione = this.GetItemDate(ll_row,"data_registrazione")
			this.SetItem(ll_row,"c_data_registrazione_doc",ld_data_registrazione)
			ls_num_documento = this.getItemString(ll_row,"num_documento")
			this.SetItem(ll_row,"c_num_documento_doc",ls_num_documento)
			ld_data_documento = this.GetItemDate(ll_row,"data_documento")
			this.SetItem(ll_row,"c_data_documento_doc",ld_data_documento)
			ld_data_competenza = this.GetItemDate(ll_row,"data_competenza")
			this.SetItem(ll_row,"c_data_competenza_doc",ld_data_competenza)
		end if
		this.SetItemStatus (ll_row,0,primary!,NotModified!)
	next
	
	selectrow(1,true)
	scrolltorow(1)
end if



end event

event ue_modify;
long		ll_id_documento, ll_row
string	ls_msg

ll_row = getRow()
ll_id_documento = this.GetItemNumber(ll_row,"id_documento")
if isNull(ll_id_documento) then
	super::event ue_modify()
else
	ls_msg = "Questa provvigione proviene da un calcolo automatico~r"
	ls_msg += "e non è possibile modificarla; modificare invece il~r"
	ls_msg += "documento associato."
	messageBox ("Attenzione!",ls_msg)
end if

end event

type st_title from statictext within w_sit_agente_cx
int X=46
int Y=361
int Width=2332
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Situazioni"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

