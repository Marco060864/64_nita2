forward
global type w_par_stampa_cx from w_p_data
end type
type dw_parametri_report_ff from u_dw_master_main within tabpage_1
end type
type dw_parametri_report_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_parametri_default from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_parametri_default dw_parametri_default
end type
end forward

global type w_par_stampa_cx from w_p_data
boolean TitleBar=true
string Title="Parametri di stampa"
end type
global w_par_stampa_cx w_par_stampa_cx

on w_par_stampa_cx.create
int iCurrent
call w_p_data::create
iCurrent=UpperBound(this.Control)
end on

on w_par_stampa_cx.destroy
call w_p_data::destroy
end on

event open;call super::open;idw_master = This.tab_1.tabpage_1.dw_parametri_report_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "par_stampa.id_par_stampa"

end event

event ue_post_open;call super::ue_post_open;string	ls_title
long 		ll_row 

u_freddie.iw_current = this

ll_row	= this.tab_1.tabpage_1.dw_parametri_report_ff.GetRow()
ls_title = this.tab_1.tabpage_1.dw_parametri_report_ff.GetItemString( ll_row,"titolo_finestra" )

if not isNull( ls_title ) then
	this.Title = "Stampa : " + ls_title
end if	
end event

type p_crescente from w_p_data`p_crescente within w_par_stampa_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_par_stampa_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_par_stampa_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_par_stampa_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_par_stampa_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_par_stampa_cx
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_par_stampa_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_par_stampa_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_par_stampa_cx
int Y=181
int Width=2355
int Height=1301
boolean BringToTop=true
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

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2318
int Height=1181
long BackColor=79741120
string Text="Report"
long TabBackColor=79741120
dw_parametri_report_ff dw_parametri_report_ff
end type

on tabpage_1.create
this.dw_parametri_report_ff=create dw_parametri_report_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_parametri_report_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_parametri_report_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_par_stampa_cx
boolean BringToTop=true
end type

type dw_parametri_report_ff from u_dw_master_main within tabpage_1
int X=51
int Y=57
int Width=2218
int Height=1081
int TabOrder=1
string DataObject="d_parametri_report_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_par_stampa"

is_title = "Parametri di Stampa"

iudw_children[1] = tab_1.tabpage_2.dw_parametri_default


end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case "titolo_finestra"
		u_freddie.iw_current.Title = "Stampa : " + data
end choose
end event

type tabpage_2 from userobject within tab_1
int X=19
int Y=105
int Width=2318
int Height=1181
long BackColor=79741120
string Text="Default"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_parametri_default dw_parametri_default
end type

on tabpage_2.create
this.dw_parametri_default=create dw_parametri_default
this.Control[]={ this.dw_parametri_default}
end on

on tabpage_2.destroy
destroy(this.dw_parametri_default)
end on

type dw_parametri_default from u_dw_master_main within tabpage_2
int X=51
int Y=57
int Width=2218
int Height=1081
string DataObject="d_parametri_report_def_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

