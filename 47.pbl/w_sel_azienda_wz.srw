forward
global type w_sel_azienda_wz from Window
end type
type dw_1 from datawindow within w_sel_azienda_wz
end type
type cb_ok from commandbutton within w_sel_azienda_wz
end type
type cb_annulla from commandbutton within w_sel_azienda_wz
end type
end forward

global type w_sel_azienda_wz from Window
int X=833
int Y=361
int Width=1751
int Height=641
boolean TitleBar=true
string Title="Senza file"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_postopen ( )
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_sel_azienda_wz w_sel_azienda_wz

type variables
boolean		ib_ok = false
transaction	it_trans
//uo_connect	iuo_conn


end variables

event ue_postopen;
datawindowchild		dwc_drop	
long						ll_row

if ib_ok then
	dw_1.GetChild ("id_azienda", dwc_drop)
	dwc_drop.SetTransObject(it_trans)
	dwc_drop.Retrieve ()
end if

ll_row = dw_1.insertRow(0)
dw_1.setitem(ll_row,"password","sql")
end event

event open;


string			ls_uid, ls_pwd, ls_vendor, ls_database
string			ls_connect, ls_msg
long				ll_sqcode


//iuo_conn = create uo_connect

it_trans = create transaction
ls_uid = u_freddie.istr_database.user
ls_pwd = u_freddie.istr_database.password
ls_vendor = u_freddie.istr_database.vendor
ls_database = u_freddie.istr_database.name
ls_connect = "ConnectString='DSN=" + ls_database + ";" + &
				 "UID=" + ls_uid + ";PWD=" + ls_pwd + ";'"
it_trans.dbms = ls_vendor
it_trans.dbparm = ls_connect

ib_ok = true
	connect using it_trans;
	ll_sqcode = it_trans.sqlcode
	choose case ll_sqcode
		case is <0
			ls_msg = "Impossibile collegarsi al database delle aziende.~r"
			ls_msg = ls_msg+ "Si passerà al monoaziendale"
			u_freddie.dberror(gci_err_critical,ls_msg)
			ib_ok = false
			close (this)
		case 0
			postevent("ue_postopen")
		case else
			ls_msg = "Errore sconosciuto "+string(ll_sqcode)+".~r"
			ls_msg = ls_msg+ "Si passerà al monoaziendale"
			u_freddie.dberror(gci_err_critical,ls_msg)
			ib_ok = false
			close (this)
	end choose
	
return 0

end event

on w_sel_azienda_wz.create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.Control[]={ this.dw_1,&
this.cb_ok,&
this.cb_annulla}
end on

on w_sel_azienda_wz.destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event close;if ib_ok then
	disconnect using it_trans;
end if

destroy it_trans
//destroy iuo_conn


end event

type dw_1 from datawindow within w_sel_azienda_wz
int X=46
int Y=41
int Width=1637
int Height=281
int TabOrder=1
string DataObject="d_sel_az_wz"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_ok from commandbutton within w_sel_azienda_wz
event clicked pbm_bnclicked
int X=915
int Y=421
int Width=343
int Height=101
int TabOrder=10
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long			ll_id_azienda,ll_row
string		ls_azi, ls_desc, ls_usrpwd
string		ls_uid, ls_pwd, ls_odb, ls_parm
string		ls_sdbf, ls_sdbn
s_odbcinfo	lstr_odbc
boolean		lb_conn
integer		li_prerr, li_ret

ll_row = dw_1.getRow()
if ll_row>0 then
	dw_1.accepttext()
	ll_id_azienda = dw_1.GetItemNumber(ll_row,"id_azienda")
	ls_usrpwd = dw_1.GetItemString(ll_row,"password")

	
	select	"m_az"."odbc_datasrc",			"m_az"."odbc_agent",
				"m_az"."odbc_autostop",			"m_az"."odbc_dbfile",
				"m_az"."odbc_dbname",			"m_az"."odbc_dbswitches",
				"m_az"."odbc_descr",				"m_az"."odbc_driver",
				"m_az"."odbc_engine",			"m_az"."odbc_isolation",
				"m_az"."odbc_keysinsql",		"m_az"."odbc_lazy",
				"m_az"."odbc_prevnotcap",		"m_az"."odbc_pwd",
				"m_az"."odbc_start",				"m_az"."odbc_transdll",
				"m_az"."odbc_transname",		"m_az"."odbc_transopt",
				"m_az"."odbc_uid",				"m_az"."server_dbf",
				"m_az"."server_dbn",
				"m_az"."odbc_tipo"

		into 	:lstr_odbc.name,						:lstr_odbc.agent,
				:lstr_odbc.autostop,					:lstr_odbc.databasefile,
				:lstr_odbc.databasename,			:lstr_odbc.databaseswitches,
				:lstr_odbc.description,				:lstr_odbc.driver,
				:lstr_odbc.enginename,				:lstr_odbc.isolationlevel,
				:lstr_odbc.keysinsqlstatistics,	:lstr_odbc.lazyautocommit,
				:lstr_odbc.preventnotcapable,		:lstr_odbc.pwd,
				:lstr_odbc.start_client,			:lstr_odbc.translationdll,
				:lstr_odbc.translationname,		:lstr_odbc.translationoption,
				:lstr_odbc.uid,
				:ls_sdbf, :ls_sdbn, :lstr_odbc.tipo

		from "dba"."m_az"
		where "m_az"."id_m_az" = :ll_id_azienda
		using	it_trans;

	
	choose case it_trans.sqlcode
		case 0
			
			
			lstr_odbc.uid = u_freddie.istr_database.user
			lstr_odbc.pwd = u_freddie.istr_database.password
//			lb_conn = iuo_conn.uf_regodbcset(lstr_odbc)
			
			
			ls_uid="dba"
			ls_pwd = "sql"
			ls_parm = "UID="+ls_uid+";PWD="+ls_pwd+";DBF="+ls_sdbf+";DBN="+ls_sdbn
			li_prerr = 1
//			li_ret = iuo_conn.uf_dbstart(ls_parm, li_prerr)
			
			
			u_freddie.istr_database.name = lstr_odbc.name
			u_freddie.istr_database.description = lstr_odbc.description
			ls_azi = u_freddie.istr_database.name + "," + ls_usrpwd
			
		case 100
			
			ls_azi = ""
		case is < 0
			
			ls_azi = ""
	end choose

end if

CloseWithReturn (parent,ls_azi)

end event

type cb_annulla from commandbutton within w_sel_azienda_wz
event clicked pbm_bnclicked
int X=1326
int Y=421
int Width=343
int Height=101
int TabOrder=20
string Text="Annulla"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)
end event

