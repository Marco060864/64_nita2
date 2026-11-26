forward
global type w_mod_registro_pl from w_wiz_main
end type
type cb_cancel from commandbutton within w_mod_registro_pl
end type
type sle_appl from singlelineedit within w_mod_registro_pl
end type
type sle_dataset from singlelineedit within w_mod_registro_pl
end type
type cb_dataset from commandbutton within w_mod_registro_pl
end type
type cb_ok from commandbutton within w_mod_registro_pl
end type
type cb_exit from commandbutton within w_mod_registro_pl
end type
type dw_pipediag from datawindow within w_mod_registro_pl
end type
end forward

global type w_mod_registro_pl from w_wiz_main
int X=833
int Y=361
int Width=1797
int Height=1085
boolean TitleBar=true
string Title="Lancio PipeLine PB"
event ue_pipe_setoff ( )
event ue_pipe_setup ( )
cb_cancel cb_cancel
sle_appl sle_appl
sle_dataset sle_dataset
cb_dataset cb_dataset
cb_ok cb_ok
cb_exit cb_exit
dw_pipediag dw_pipediag
end type
global w_mod_registro_pl w_mod_registro_pl

type variables
s_application istr_application
s_database   istr_database
uo_pipe1      iuo_mod_registro
transaction itrans_source
transaction itrans_destination
end variables

forward prototypes
public function boolean uf_connect_transapp (transaction arg_1, string arg_2)
public function real uf_wait (boolean arg_b, string arg_c)
end prototypes

event ue_pipe_setoff;
DESTROY iuo_mod_registro
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

event ue_pipe_setup;


itrans_source = CREATE transaction	
uf_connect_transapp(itrans_source, sle_appl.Text)
itrans_destination = CREATE transaction
uf_connect_transapp(itrans_destination,"Pipeout.ini")
iuo_mod_registro = CREATE uo_pipe1

end event

public function boolean uf_connect_transapp (transaction arg_1, string arg_2);



   integer          n
   string           ls_userid, ls_password, ls_vendor, ls_database
	string           ls_connect, ls_worka, ls_servername
	transaction      ltrans_worka   
	
ltrans_worka = arg_1
ls_worka = arg_2
ls_userid=profilestring (ls_worka, "database","userID", istr_database.user )
ls_password=profilestring (ls_worka, "database","password", istr_database.password)
ls_vendor=profilestring (ls_worka, "database","vendor", istr_database.vendor)
ls_database = profilestring (ls_worka, "database","database", istr_database.name)
ls_servername = profilestring (ls_worka, "database","servername","DBServer")
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

public function real uf_wait (boolean arg_b, string arg_c);

if arg_b then
	OpenWithParm(w_wait, arg_c)
else
	close(w_wait)
end if
Return 0

end function

on w_mod_registro_pl.create
int iCurrent
call w_wiz_main::create
this.cb_cancel=create cb_cancel
this.sle_appl=create sle_appl
this.sle_dataset=create sle_dataset
this.cb_dataset=create cb_dataset
this.cb_ok=create cb_ok
this.cb_exit=create cb_exit
this.dw_pipediag=create dw_pipediag
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_cancel
this.Control[iCurrent+2]=sle_appl
this.Control[iCurrent+3]=sle_dataset
this.Control[iCurrent+4]=cb_dataset
this.Control[iCurrent+5]=cb_ok
this.Control[iCurrent+6]=cb_exit
this.Control[iCurrent+7]=dw_pipediag
end on

on w_mod_registro_pl.destroy
call w_wiz_main::destroy
destroy(this.cb_cancel)
destroy(this.sle_appl)
destroy(this.sle_dataset)
destroy(this.cb_dataset)
destroy(this.cb_ok)
destroy(this.cb_exit)
destroy(this.dw_pipediag)
end on

event open;call super::open;
dw_pipediag.Visible = FALSE
cb_cancel.TriggerEvent(Clicked!)
																	
end event

event resize;dw_pipediag.width = newwidth - 100
dw_pipediag.height = newheight - 400
end event

type cb_cancel from commandbutton within w_mod_registro_pl
int X=1463
int Y=41
int Width=247
int Height=109
int TabOrder=41
boolean Visible=false
string Text="Cancel"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
SetNull(Parent.sle_appl.Text)

end event

type sle_appl from singlelineedit within w_mod_registro_pl
int X=778
int Y=41
int Width=613
int Height=93
int TabOrder=10
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="Appl"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dataset from singlelineedit within w_mod_registro_pl
int X=46
int Y=41
int Width=590
int Height=93
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="DataSource"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_dataset from commandbutton within w_mod_registro_pl
int X=1468
int Y=821
int Width=247
int Height=109
int TabOrder=30
string Text="Input"
int TextSize=-8
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

type cb_ok from commandbutton within w_mod_registro_pl
int X=732
int Y=821
int Width=257
int Height=109
int TabOrder=40
string Text="Start Pipe"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

integer    li_index
integer    li_rc[]
integer    li_rc_final
string     ls_msg[]
string     ls_pipes[]
string     ls_msgText
string     ls_msgerr

ls_msgText   = "Diagnostica PipeLine"
ls_msg[1]    = "Errore Tabella Mod_Registro:"

ls_pipes[1]  = "pl_mod_registro"

IF IsNull(sle_appl.Text) THEN
	Parent.cb_cancel.TriggerEvent(Clicked!)
	RETURN
END IF
Parent.cb_exit.Enabled = False
Parent.cb_ok.Enabled = False
Parent.cb_dataset.Enabled = False
Parent.TriggerEvent("ue_pipe_setup")
IF IsNull(sle_appl.Text) THEN
	Parent.TriggerEvent("ue_pipe_setoff")
	Parent.cb_cancel.TriggerEvent(Clicked!)
	Parent.cb_exit.Enabled = True
	RETURN
END IF
dw_pipediag.Visible = FALSE
uf_wait(True, "")
FOR li_index = 1 TO UpperBound(ls_pipes) 
	
   iuo_mod_registro.dataobject = ls_pipes[li_index]
	uf_wait(False, "")
   uf_wait(True, ls_pipes[li_index])
   
   li_rc[li_index] = iuo_mod_registro.Start(itrans_source, itrans_destination, dw_pipediag)
   IF li_rc[li_index] < 1 THEN
	   uf_wait(False, "")
	   dw_pipediag.Visible = TRUE
	   ls_msgerr = ls_msg[li_index] + String(li_rc[li_index])
	   MessageBox(ls_msgText, ls_msgerr)
	   uf_wait(True, "")
   END IF
NEXT

uf_wait(False, "")
li_rc_final = 1
FOR li_index = 1 to UpperBound(li_rc)
	IF li_rc[li_index] <> 1 THEN
		li_rc_final = 0
	END IF
NEXT	
IF li_rc_final = 1  THEN
	COMMIT USING itrans_destination;
	COMMIT USING itrans_source;
   Parent.cb_exit.Enabled = True
	Parent.cb_exit.Visible = True
	Parent.cb_ok.Enabled = False
	Parent.TriggerEvent("ue_pipe_setoff")
ELSE
	ROLLBACK USING itrans_destination;
	ROLLBACK USING itrans_source;
	Parent.TriggerEvent("ue_pipe_setoff")
	Parent.cb_exit.TriggerEvent(Clicked!)
END IF



end event

type cb_exit from commandbutton within w_mod_registro_pl
int X=46
int Y=821
int Width=247
int Height=109
int TabOrder=60
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type dw_pipediag from datawindow within w_mod_registro_pl
int X=46
int Y=161
int Width=1669
int Height=601
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

