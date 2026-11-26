forward
global type w_m_az_cx from w_p_data
end type
type dw_m_az_standard_ff from u_dw_master_main within tabpage_1
end type
type dw_m_az_standard_ff from u_dw_master_main within tabpage_1
end type
type tabpage_avanzate from userobject within tab_1
end type
type dw_m_az_avanzate_ff from u_dw_master_main within tabpage_avanzate
end type
type tabpage_server from userobject within tab_1
end type
type dw_m_az_server_ff from u_dw_master_main within tabpage_server
end type
type tabpage_avanzate from userobject within tab_1
dw_m_az_avanzate_ff dw_m_az_avanzate_ff
end type
type tabpage_server from userobject within tab_1
dw_m_az_server_ff dw_m_az_server_ff
end type
end forward

global type w_m_az_cx from w_p_data
int Width=2295
int Height=1417
boolean TitleBar=true
string Title="Azienda"
end type
global w_m_az_cx w_m_az_cx

on w_m_az_cx.create
int iCurrent
call w_p_data::create
iCurrent=UpperBound(this.Control)
end on

on w_m_az_cx.destroy
call w_p_data::destroy
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_m_az_standard_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "m_az.id_m_az"
end event

event ue_post_open;call super::ue_post_open;long 		ll_row
string	ls_value
ll_row 	= this.tab_1.tabpage_1.dw_m_az_standard_ff.GetRow()
ls_value	= this.tab_1.tabpage_1.dw_m_az_standard_ff.GetItemString( ll_row,"odbc_datasrc" )

if not IsNull( ls_value ) then
	this.title = "Azienda - Fonte dati : " + ls_value
else
	this.title = "Azienda"
end if	

end event

type p_crescente from w_p_data`p_crescente within w_m_az_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_m_az_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_m_az_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_m_az_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_m_az_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_m_az_cx
int X=1349
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_m_az_cx
int X=1646
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_m_az_cx
int X=1943
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_m_az_cx
int Width=2195
int Height=1121
boolean BringToTop=true
tabpage_avanzate tabpage_avanzate
tabpage_server tabpage_server
end type

on tab_1.create
this.tabpage_avanzate=create tabpage_avanzate
this.tabpage_server=create tabpage_server
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_avanzate
this.Control[iCurrent+2]=tabpage_server
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_avanzate)
destroy(this.tabpage_server)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2158
int Height=1001
long BackColor=79741120
string Text="Standard"
long TabBackColor=79741120
dw_m_az_standard_ff dw_m_az_standard_ff
end type

on tabpage_1.create
this.dw_m_az_standard_ff=create dw_m_az_standard_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_m_az_standard_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_m_az_standard_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_m_az_cx
boolean BringToTop=true
end type

type dw_m_az_standard_ff from u_dw_master_main within tabpage_1
event ue_change_protect ( )
int X=28
int Y=37
int Width=2103
int Height=941
int TabOrder=1
string DataObject="d_m_az_standard_ff"
end type

event ue_change_protect;call super::ue_change_protect;long		ll_row
string	ls_agent

ll_row = GetRow()
if ll_row > 0 then
	ls_agent = This.GetItemString(ll_row, "odbc_agent")
	if ls_agent = "engine" then
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_DBFile", False)
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_engine", True)
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_DBName", True)
	elseif ls_agent = "client" then
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_DBFile", True)
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_engine", False)
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_DBName", False)
	else
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_DBFile", False)
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_engine", False)
		f_displayonly(tab_1.tabpage_1.dw_m_az_standard_ff, "odbc_DBName", False)
	end if
end if

end event

event itemchanged;call super::itemchanged;long		ll_row
string	ls_value
window   lw_temp

lw_temp = u_freddie.iw_current

CHOOSE CASE dwo.name
	CASE "odbc_agent"
		Post Event ue_change_protect()
		
	CASE "odbc_datasrc"
		
		
		if not IsNull(data) and data <> "" then
			if not isNull( lw_temp ) then
				lw_temp.title = "Azienda - Fonte dati : " + data
			end if				
		else
			if not isNull( lw_temp ) then
				lw_temp.title = "Azienda"
			end if				
		end if	
	
END CHOOSE

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_m_az"
iudw_children[1] = tab_1.tabpage_avanzate.dw_m_az_avanzate_ff
iudw_children[2] = tab_1.tabpage_server.dw_m_az_server_ff

end event

event rowfocuschanged;call super::rowfocuschanged;Event ue_change_protect()
end event

type tabpage_avanzate from userobject within tab_1
int X=19
int Y=105
int Width=2158
int Height=1001
long BackColor=79741120
string Text="Avanzate"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_m_az_avanzate_ff dw_m_az_avanzate_ff
end type

on tabpage_avanzate.create
this.dw_m_az_avanzate_ff=create dw_m_az_avanzate_ff
this.Control[]={ this.dw_m_az_avanzate_ff}
end on

on tabpage_avanzate.destroy
destroy(this.dw_m_az_avanzate_ff)
end on

type dw_m_az_avanzate_ff from u_dw_master_main within tabpage_avanzate
int X=28
int Y=37
int Width=2103
int Height=941
string DataObject="d_m_az_avanzate_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

type tabpage_server from userobject within tab_1
int X=19
int Y=105
int Width=2158
int Height=1001
long BackColor=79741120
string Text="Server"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_m_az_server_ff dw_m_az_server_ff
end type

on tabpage_server.create
this.dw_m_az_server_ff=create dw_m_az_server_ff
this.Control[]={ this.dw_m_az_server_ff}
end on

on tabpage_server.destroy
destroy(this.dw_m_az_server_ff)
end on

type dw_m_az_server_ff from u_dw_master_main within tabpage_server
int X=28
int Y=37
int Width=2103
int Height=941
int TabOrder=1
string DataObject="d_m_az_server_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

