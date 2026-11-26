forward
global type w_db_unload from w_data_main
end type
type sle_appl from singlelineedit within w_db_unload
end type
type cb_ok from commandbutton within w_db_unload
end type
type cb_cancel from commandbutton within w_db_unload
end type
type cb_exit from commandbutton within w_db_unload
end type
type dw_pipediag from datawindow within w_db_unload
end type
type sle_dataset from singlelineedit within w_db_unload
end type
type cb_dataset from commandbutton within w_db_unload
end type
end forward

global type w_db_unload from w_data_main
int X=1134
int Y=1029
int Width=906
int Height=393
boolean TitleBar=true
string Title="PbUser Gestione Utenti "
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_pipe_setup ( )
event ue_pipe_setoff ( )
event ue_pipe_check ( )
sle_appl sle_appl
cb_ok cb_ok
cb_cancel cb_cancel
cb_exit cb_exit
dw_pipediag dw_pipediag
sle_dataset sle_dataset
cb_dataset cb_dataset
end type
global w_db_unload w_db_unload

type variables
s_application istr_application
s_database   istr_database
uo_pipe1      iuo_pipe1
transaction itrans_source
transaction itrans_destination

end variables

forward prototypes
public function boolean uf_connect_transapp (transaction uf_connect_arg_trans, string uf_connect_arg_app)
public subroutine uf_wait (boolean uf_wait_argbool)
end prototypes

event ue_pipe_setup;call super::ue_pipe_setup;


itrans_source = CREATE transaction	
uf_connect_transapp(itrans_source, "Utenti.ini")
itrans_destination = CREATE transaction
uf_connect_transapp(itrans_destination, sle_appl.Text)
iuo_pipe1 = CREATE uo_pipe1

end event

event ue_pipe_setoff;call super::ue_pipe_setoff;
DESTROY iuo_pipe1
DISCONNECT USING itrans_source;
IF itrans_source.SQLCode = -1 THEN
	MessageBox("ERR.DISCONNECT", "Close w_db_unload Source")
END IF
DESTROY itrans_source
DISCONNECT USING itrans_destination;
IF itrans_destination.SQLCode = -1 THEN
	MessageBox("ERR.DISCONNECT", "Close w_db_unload Destination")
END IF
DESTROY itrans_destination

end event

event ue_pipe_check;call super::ue_pipe_check;

integer    li_rc1, li_rc2, li_rc3, li_rc4

iuo_pipe1.dataobject = "pl_check_menu"
uf_wait(True)
li_rc1 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc1 <> -4 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Tabella Menu gia esistente")
	uf_wait(True)
END IF
iuo_pipe1.dataobject = "pl_check_oggetti"
li_rc2 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc2 <> -4 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Tabella Oggetti gia esistente")
	uf_wait(True)
END IF
iuo_pipe1.dataobject = "pl_check_utenti"
li_rc3 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc3 <> -4 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Tabella Utenti gia esistente")
	uf_wait(True)
END IF
iuo_pipe1.dataobject = "pl_check__voci_menu"
li_rc4 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc4 <> -4 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Tabella Voci_Menu gia esistente")
	uf_wait(True)
END IF
uf_wait(False)
IF li_rc1 <> -4 OR li_rc2 <> -4 OR li_rc3 <> -4 OR li_rc4 <> -4 THEN
   This.TriggerEvent("ue_pipe_setoff")
	This.cb_exit.TriggerEvent(Clicked!)
END IF



end event

public function boolean uf_connect_transapp (transaction uf_connect_arg_trans, string uf_connect_arg_app);



   integer          n
   string           ls_userid, ls_password, ls_vendor, ls_database
	string           ls_connect, ls_worka, ls_servername
	transaction      ltrans_worka   
	
ltrans_worka = uf_connect_arg_trans
ls_worka = uf_connect_arg_app
ls_userid=profilestring (ls_worka, "database","userID",istr_database.user )
ls_password=profilestring (ls_worka, "database","password",istr_database.password)
ls_vendor=profilestring (ls_worka, "database","vendor",istr_database.vendor)
ls_database = profilestring (ls_worka, "database","database",istr_database.name)
ls_servername = profilestring (ls_worka, "database","servername","DBTOTO")
ls_connect="ConnectString='DSN=" + ls_database + ";" + &
		"UID=" + ls_userid + ";PSW=" + ls_password + ";'"
ltrans_worka.dbms = ls_vendor
ltrans_worka.dbparm = ls_connect
ltrans_worka.ServerName = ls_servername
CONNECT USING ltrans_worka;
IF ltrans_worka.SQLCode < 0  THEN
	MessageBox("ERR.CONNECT DB " + ls_worka + " uf_connect_transapp ", ltrans_worka.SQLErrText + &
	           "~n" + "UserID:" + ls_userid + &
				  "~n" + "Password:" + ls_password + & 
				  "~n" + "Tipo Connessione:" + ls_vendor + & 
				  "~n" + "Database Name(DSN):" + ls_database + & 
				  "~n" + "ServerName:" + ls_servername )
	HALT CLOSE
	RETURN(FALSE)
END IF

RETURN(TRUE)



end function

public subroutine uf_wait (boolean uf_wait_argbool);

if uf_wait_argbool then
	Open(w_wait)
else
	close(w_wait)
end if
end subroutine

on w_db_unload.create
int iCurrent
call w_data_main::create
this.sle_appl=create sle_appl
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_exit=create cb_exit
this.dw_pipediag=create dw_pipediag
this.sle_dataset=create sle_dataset
this.cb_dataset=create cb_dataset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=sle_appl
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=cb_cancel
this.Control[iCurrent+4]=cb_exit
this.Control[iCurrent+5]=dw_pipediag
this.Control[iCurrent+6]=sle_dataset
this.Control[iCurrent+7]=cb_dataset
end on

on w_db_unload.destroy
call w_data_main::destroy
destroy(this.sle_appl)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_exit)
destroy(this.dw_pipediag)
destroy(this.sle_dataset)
destroy(this.cb_dataset)
end on

event close;if isvalid(u_freddie.iudw_current) then
	if u_freddie.iudw_current.ib_query_mode then
		m_app_frame.uf_enable_modifica(true)
	end if	
end if

end event

event resize;call super::resize;dw_pipediag.width = newwidth - 100
dw_pipediag.height = newheight - 400
end event

event open;call super::open;string ls_pathname, ls_filename
integer li_ret_code

is_wintype = "W_DB_UNLOAD"
cb_cancel.TriggerEvent(Clicked!)
																	
end event

type p_crescente from w_data_main`p_crescente within w_db_unload
boolean BringToTop=true
end type

type p_decrescente from w_data_main`p_decrescente within w_db_unload
boolean BringToTop=true
end type

type sle_appl from singlelineedit within w_db_unload
int X=1189
int Y=41
int Width=595
int Height=81
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_db_unload
int X=46
int Y=181
int Width=353
int Height=85
int TabOrder=60
boolean BringToTop=true
string Text="&Avvia"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

integer    li_rc1, li_rc2, li_rc3, li_rc4

IF IsNull(sle_appl.Text) THEN
	Parent.cb_cancel.TriggerEvent(Clicked!)
	RETURN
END IF
Parent.cb_exit.Enabled = False
Parent.TriggerEvent("ue_pipe_setup")
Parent.TriggerEvent("ue_pipe_check")
iuo_pipe1.dataobject = "pl_menu"
uf_wait(True)
li_rc1 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc1 < 1 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Errore Pipe Menu")
	uf_wait(True)
END IF
iuo_pipe1.dataobject = "pl_oggetti"
li_rc2 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc2 < 1 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Errore Pipe Oggetti")
	uf_wait(True)
END IF
iuo_pipe1.dataobject = "pl_utenti"
li_rc3 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc3 < 1 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Errore Pipe Utenti")
	uf_wait(True)
END IF
iuo_pipe1.dataobject = "pl_voci_menu"
li_rc4 = iuo_pipe1.Start(itrans_source, itrans_destination, dw_pipediag)
IF li_rc4 < 1 THEN
	uf_wait(False)
	MessageBox("Diagnostica","Errore Pipe Voci_Menu")
	uf_wait(True)
END IF
uf_wait(False)
Parent.TriggerEvent("ue_pipe_setoff")
IF li_rc1 = 1 AND li_rc2 = 1 AND li_rc3 = 1 AND li_rc4 = 1 THEN
   Parent.cb_exit.Enabled = True
	Parent.cb_exit.Visible = True
	Parent.cb_ok.Enabled = False
ELSE
	Parent.cb_exit.TriggerEvent(Clicked!)
END IF



end event

type cb_cancel from commandbutton within w_db_unload
int X=2081
int Y=41
int Width=389
int Height=81
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string Text="A&nnulla"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
SetNull(Parent.sle_appl.Text)

end event

type cb_exit from commandbutton within w_db_unload
int X=481
int Y=181
int Width=353
int Height=85
int TabOrder=10
boolean BringToTop=true
string Text="Esci"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type dw_pipediag from datawindow within w_db_unload
int X=1143
int Y=161
int Width=1395
int Height=301
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type sle_dataset from singlelineedit within w_db_unload
int X=46
int Y=41
int Width=503
int Height=81
int TabOrder=40
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_dataset from commandbutton within w_db_unload
int X=595
int Y=41
int Width=225
int Height=89
int TabOrder=31
boolean BringToTop=true
string Text="Scelta"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_pathname, ls_filename
integer li_ret_code

li_ret_code = GetFileOpenName("Scegli il File *.INI", &
                              + ls_pathname, &
										+ ls_filename, &
										+ "INI", &
										+ "INI Files (*.INI), *.INI")
sle_dataset.Text = ls_filename											
sle_appl.Text = ls_filename																				
end event

