forward
global type w_tel_sempl_cx from w_p_data
end type
type dw_sog_commerciale from u_dw_master_main within w_tel_sempl_cx
end type
type dw_tel_sempl_gd from u_dw_master_main within w_tel_sempl_cx
end type
type st_title from statictext within w_tel_sempl_cx
end type
end forward

global type w_tel_sempl_cx from w_p_data
int Width=2447
int Height=1398
boolean TitleBar=true
string Title="Manutenzione telefoni per soggetto commerciale"
dw_sog_commerciale dw_sog_commerciale
dw_tel_sempl_gd dw_tel_sempl_gd
st_title st_title
end type
global w_tel_sempl_cx w_tel_sempl_cx

forward prototypes
public function long uf_update ()
end prototypes

public function long uf_update ();integer li_size, li_counter
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

on w_tel_sempl_cx.create
int iCurrent
call super::create
this.dw_sog_commerciale=create dw_sog_commerciale
this.dw_tel_sempl_gd=create dw_tel_sempl_gd
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sog_commerciale
this.Control[iCurrent+2]=this.dw_tel_sempl_gd
this.Control[iCurrent+3]=this.st_title
end on

on w_tel_sempl_cx.destroy
call super::destroy
destroy(this.dw_sog_commerciale)
destroy(this.dw_tel_sempl_gd)
destroy(this.st_title)
end on

event ue_post_open;call super::ue_post_open;
long ll_row
ll_row	= idw_master.insertRow(0)
idw_master.ScrollToRow(ll_row)
idw_master.ResetUpdate()
cb_nuovo.visible 		= false
cb_ricerca.visible 	= false
end event

event open;call super::open;idw_master						= this.dw_sog_commerciale
idw_master.is_list 			= Message.PowerObjectParm
idw_master.ib_use_scanner	= TRUE
idw_master.is_list.s_sql_ident[1] = "anagrafica.id_anagrafica"

If Upperbound(idw_master.is_list.s_identifica) = 0 then
	idw_master.is_list.s_modo = modo_inserisci
end if

ib_nonmodale = true


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

type p_crescente from w_p_data`p_crescente within w_tel_sempl_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_tel_sempl_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_tel_sempl_cx
boolean BringToTop=true
end type

event cb_ok::clicked;long ll_row, ll_id
string s_col_name
integer li_counter
long ll_size

if isValid(u_freddie.iudw_current) then
	u_freddie.iudw_current.AcceptText()
end if

if parent.uf_Update() > 0 then
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

type cb_annulla from w_p_data`cb_annulla within w_tel_sempl_cx
int X=325
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_tel_sempl_cx
int X=607
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_tel_sempl_cx
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_tel_sempl_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_tel_sempl_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_tel_sempl_cx
int Y=1062
int Width=2355
int Height=202
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
boolean ShowText=false
boolean RaggedRight=false
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=15
int Y=38
int Width=2326
int Height=150
long BackColor=79741120
long TabBackColor=79741120
long PictureMaskColor=553648127
end type

type cb_ricerca from w_p_data`cb_ricerca within w_tel_sempl_cx
int TabOrder=30
boolean BringToTop=true
end type

type dw_sog_commerciale from u_dw_master_main within w_tel_sempl_cx
event itemchanged pbm_dwnitemchange
event ue_init pbm_custom01
event ue_insert pbm_custom02
event ue_update pbm_custom04
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
int X=48
int Y=160
int Width=2333
int Height=202
int TabOrder=20
string DataObject="d_sog_commerciale_sel_ff"
boolean LiveScroll=false
end type

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_anagrafica, ll_id_banca_appoggio
long		 ll_row,ll_ret,ll_temp

ls_sql_cond = ""  

choose case dwo.name
		
	case 'codice'
		ls_sql_cond = ""  
		
		ls_dbc[1]  	= "id_anagrafica"
		ls_dwc[1]  	= "id_anagrafica"
		
		ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
		ll_row = this.GetRow()
		ll_temp = this.GetItemNumber(ll_row,"id_anagrafica")
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
		ls_sql_cond = ""  

		ls_dbc[1]  	= "id_anagrafica"
		ls_dwc[1]  	= "id_anagrafica"
				
		ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
		ll_row = this.GetRow()
		ll_temp = this.GetItemNumber(ll_row,"id_anagrafica")
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
end event

event ue_init;call super::ue_init;
this.iudw_children[1]	= dw_tel_sempl_gd

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
	CASE "rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "rag_soc_1" 		
	
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;integer 	li_id_anagrafica
long 		ll_row,ll_ret

CHOOSE CASE as_nomecol
		
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_anagrafica", is_ricpar.s_ausil_value[4])

		if not isNull(is_ricpar.s_id_seg_value[1]) then
			ll_row = this.GetRow()
			this.event rowfocuschanged(ll_row)
		end if
		this.ResetUpdate()

	CASE "rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_anagrafica", is_ricpar.s_ausil_value[4])
				
		if not isNull(is_ricpar.s_id_seg_value[1]) then
			ll_row = this.GetRow()
			this.event rowfocuschanged(ll_row)
		end if
		this.ResetUpdate()
	
END CHOOSE

end event

type dw_tel_sempl_gd from u_dw_master_main within w_tel_sempl_cx
event ue_init pbm_custom01
int X=48
int Y=461
int Width=2333
int Height=800
int TabOrder=10
string DataObject="d_tel_sempl_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_anagrafica"



end event

type st_title from statictext within w_tel_sempl_cx
int X=48
int Y=381
int Width=2333
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Numeri di telefono"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

