forward
global type w_cod_barre from Window
end type
type st_filename from statictext within w_cod_barre
end type
type st_1 from statictext within w_cod_barre
end type
type cb_2 from commandbutton within w_cod_barre
end type
type rb_com4 from radiobutton within w_cod_barre
end type
type rb_com3 from radiobutton within w_cod_barre
end type
type rb_com2 from radiobutton within w_cod_barre
end type
type rb_com1 from radiobutton within w_cod_barre
end type
type rb_9600 from radiobutton within w_cod_barre
end type
type rb_4800 from radiobutton within w_cod_barre
end type
type rb_2400 from radiobutton within w_cod_barre
end type
type rb_1200 from radiobutton within w_cod_barre
end type
type st_5 from statictext within w_cod_barre
end type
type sle_termid from singlelineedit within w_cod_barre
end type
type dw_1 from datawindow within w_cod_barre
end type
type cb_1 from commandbutton within w_cod_barre
end type
type gb_2 from groupbox within w_cod_barre
end type
type gb_1 from groupbox within w_cod_barre
end type
type r_1 from rectangle within w_cod_barre
end type
end forward

global type w_cod_barre from Window
int X=5
int Y=16
int Width=3282
int Height=1420
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_filename st_filename
st_1 st_1
cb_2 cb_2
rb_com4 rb_com4
rb_com3 rb_com3
rb_com2 rb_com2
rb_com1 rb_com1
rb_9600 rb_9600
rb_4800 rb_4800
rb_2400 rb_2400
rb_1200 rb_1200
st_5 st_5
sle_termid sle_termid
dw_1 dw_1
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
r_1 r_1
end type
global w_cod_barre w_cod_barre

type prototypes
function ulong GetDC( ulong hWnd1 )  Library "USER32.DLL"
function long ReleaseDC(ulong hWnd1, long hDC) Library "USER32.DLL"

function boolean TextOutA( ulong hdc,long nXStart, long nYStart, ref string lpString,long cbString ) Library "GDI32.DLL" alias for "TextOutA;Ansi"
function long GetDeviceCaps(long hdc, long nIndex) Library "gdi32.dll"
function ulong CreateFontA( long nHeight, &
 long nWidth,  long nEscapement, &
  long nOrientation, long fnWeight, &
  ulong fdwItalic,ulong fdwUnderline, ulong fdwStrikeOut, &
  ulong fdwCharSet, ulong fdwOutputPrecision, &
ulong fdwClipPrecision, ulong fdwQuality, &
 ulong fdwPitchAndFamily, ref string lpszFace ) Library "GDI32.dll" alias for "CreateFontA;Ansi"

Function boolean DeleteObject(ulong hObjec ) Library "GDI32.dll"

function ulong SelectObject( ulong hdc, ulong hgdiobj ) Library "GDI32.dll"
Function boolean sndPlaySoundA (string SoundName, uint Flags) Library "WINMM.DLL" alias for "sndPlaySoundA;Ansi"
Function uint waveOutGetNumDevs () Library "WINMM.DLL"

Function ulong GetSysColor (int index) Library "USER32.DLL"

Function int GetSystemMetrics (int index) Library "USER32.DLL"


Function Boolean KillTimer (long handle, uint id ) library "USER32.DLL"
Function uint SetTimer (long handle, uint id, uint time, long addr ) library "USER32.DLL"

Function long GetModuleHandleA(string modname) Library "KERNEL32.DLL" alias for "GetModuleHandleA;Ansi"

Function boolean FlashWindow (long handle, boolean flash) Library "USER32.DLL"
Function uint GetWindow (long handle,uint relationship) Library "USER32.DLL"
Function int GetWindowTextA(long handle, ref string wintext, int length) Library "USER32.DLL" alias for "GetWindowTextA;Ansi"
Function boolean IsWindowVisible (long handle) Library "USER32.DLL"
Function uint GetWindowsDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetWindowsDirectoryA;Ansi"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetSystemDirectoryA;Ansi"
Function uint GetDriveTypeA (string drive) library "KERNEL32.DLL" alias for "GetDriveTypeA;Ansi"
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "KERNEL32.DLL" alias for "GetCurrentDirectoryA;Ansi"

Function boolean GetUserNameA (ref string name, ref ulong len) library "ADVAPI32.DLL" alias for "GetUserNameA;Ansi"
Function ulong GetTickCount ( ) Library "KERNEL32.DLL"


function long B30XferRx (ref string command)  Library "B30win32.dll" alias for "B30XferRx;Ansi" 
function boolean MoveFileA(ref string old, ref string new) Library "Kernel32.dll" alias for "MoveFileA;Ansi"
function ulong GetModuleFileNameA(ulong module, ref string buffer, ulong lenght) Library "Kernel32.dll" alias for "GetModuleFileNameA;Ansi"
end prototypes

type variables
transaction barCode_TransObj
transaction parameter_TransObj
string  port, baud, idterm, filename, path
integer offset
boolean aperto
end variables

forward prototypes
public subroutine restorebaudvalues ()
public subroutine restoreportvalues ()
end prototypes

public subroutine restorebaudvalues ();CHOOSE CASE baud
	CASE "1200"
		rb_1200.checked=TRUE
			CASE "2400"
		rb_2400.checked=TRUE
		CASE "4800"
		rb_4800.checked=TRUE
		CASE "9600"
		rb_9600.checked=TRUE
	CASE ELSE
		MessageBox("Error",  &
	"Incorrect baud rate: "+ baud)
END CHOOSE
end subroutine

public subroutine restoreportvalues ();CHOOSE CASE port
	CASE "1"
		rb_COM1.checked=TRUE
			CASE "2"
		rb_COM2.checked=TRUE
		CASE "3"
		rb_COM3.checked=TRUE
		CASE "4"
		rb_COM4.checked=TRUE
	CASE ELSE
		MessageBox("Error",  &
	"Incorrect port number: "+ port)
END CHOOSE
end subroutine

on w_cod_barre.create
this.st_filename=create st_filename
this.st_1=create st_1
this.cb_2=create cb_2
this.rb_com4=create rb_com4
this.rb_com3=create rb_com3
this.rb_com2=create rb_com2
this.rb_com1=create rb_com1
this.rb_9600=create rb_9600
this.rb_4800=create rb_4800
this.rb_2400=create rb_2400
this.rb_1200=create rb_1200
this.st_5=create st_5
this.sle_termid=create sle_termid
this.dw_1=create dw_1
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.r_1=create r_1
this.Control[]={this.st_filename,&
this.st_1,&
this.cb_2,&
this.rb_com4,&
this.rb_com3,&
this.rb_com2,&
this.rb_com1,&
this.rb_9600,&
this.rb_4800,&
this.rb_2400,&
this.rb_1200,&
this.st_5,&
this.sle_termid,&
this.dw_1,&
this.cb_1,&
this.gb_2,&
this.gb_1,&
this.r_1}
end on

on w_cod_barre.destroy
destroy(this.st_filename)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.rb_com4)
destroy(this.rb_com3)
destroy(this.rb_com2)
destroy(this.rb_com1)
destroy(this.rb_9600)
destroy(this.rb_4800)
destroy(this.rb_2400)
destroy(this.rb_1200)
destroy(this.st_5)
destroy(this.sle_termid)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.r_1)
end on

event open;









Aperto=FALSE
offset = 632
barCode_TransObj = CREATE transaction

barCode_TransObj.DBMS = "ODBC"
barCode_TransObj.AutoCommit = False
barCode_TransObj.DBParm = "ConnectString='DSN=Bancolini;UID=;PWD='"
CONNECT USING barCode_TransObj;




IF barCode_TransObj.SQLCode <> 0 THEN
  MessageBox("Connect Failed",  &
	"Cannot connect to ODBC source Bancolini." + SQLCA.SQLErrText)
  RETURN
END IF






  SELECT "par_lettore"."port",   
         "par_lettore"."baud",   
         "par_lettore"."id_term",   
         "par_lettore"."filename"  
    INTO :port,   
         :baud,   
         :idterm,   
         :filename  
    FROM "par_lettore"  ;

IF SQLCA.SQLCode <> 0 THEN
  MessageBox("Error",  &
	"Errore nella lettura dei parametri di comunicazione" + SQLCA.SQLErrText)
  RETURN
END IF

path=fill("*",4)
GetModuleFileNameA(0,path,4)


RestoreBaudValues()


RestorePortValues()


sle_termid.text=idTerm


st_filename.text=path+filename
end event

event close;DISCONNECT USING barCode_TransObj;
Destroy barCode_TransObj
end event

type st_filename from statictext within w_cod_barre
int X=2267
int Y=1716
int Width=672
int Height=76
boolean Enabled=false
string Text=" "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_cod_barre
int X=1902
int Y=1724
int Width=283
int Height=76
boolean Enabled=false
string Text="Filename:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_cod_barre
int X=37
int Y=1148
int Width=521
int Height=108
int TabOrder=60
string Text="Mostra Dettagli"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

if aperto then
	aperto= not(aperto)
	this.text="Mostra dettagli"
	parent.Height = parent.Height - offset
else
	aperto= not(aperto)
	this.text="Nascondi dettagli"
	parent.Height = parent.Height + offset
end if

end event

type rb_com4 from radiobutton within w_cod_barre
int X=1307
int Y=1736
int Width=251
int Height=76
string Text="COM4"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if port<>"4" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
		port = "4"
	 update par_lettore
	  set port = '4'
	  ;
	  IF SQLCA.SQLNRows <> 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestorePortValues()
	END IF
end if
end event

type rb_com3 from radiobutton within w_cod_barre
int X=951
int Y=1724
int Width=251
int Height=76
string Text="COM3"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if port<>"3" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
		port = "3"
	  update par_lettore
	  set port = '3'
	  ;
	  IF SQLCA.SQLNRows <> 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestorePortValues()
	END IF
end if
end event

type rb_com2 from radiobutton within w_cod_barre
int X=512
int Y=1720
int Width=251
int Height=76
string Text="COM2"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if port<>"2" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
		port = "2"
	  update par_lettore
	  set port = '2'
	  ;
	  IF SQLCA.SQLNRows <> 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestorePortValues()
	END IF
end if
end event

type rb_com1 from radiobutton within w_cod_barre
int X=155
int Y=1720
int Width=251
int Height=76
string Text="COM1"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if port<>"1" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
		port = "1"
	  update par_lettore
	  set port = '1'
	  ;
	  IF SQLCA.SQLNRows <> 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestorePortValues()
	END IF
end if
end event

type rb_9600 from radiobutton within w_cod_barre
int X=1312
int Y=1464
int Width=247
int Height=76
string Text="9600"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if baud<>"9600" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
		baud = "9600"
	  update par_lettore
	  set Baud = '9600'
	  ;
	  IF SQLCA.SQLNRows <> 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestoreBaudValues()
	END IF
end if
end event

type rb_4800 from radiobutton within w_cod_barre
int X=951
int Y=1464
int Width=247
int Height=76
string Text="4800"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if baud<>"4800" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
		baud = "4800"
	  update par_lettore
	  set Baud = '4800'
	  ;
	  IF SQLCA.SQLNRows < 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestoreBaudValues()
	END IF
end if
end event

type rb_2400 from radiobutton within w_cod_barre
int X=512
int Y=1460
int Width=247
int Height=76
string Text="2400"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if baud<>"2400" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
		baud = "2400"
	  update par_lettore
	  set Baud = '2400'
	  ;
	  IF SQLCA.SQLNRows <> 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestoreBaudValues()
	END IF
end if
end event

type rb_1200 from radiobutton within w_cod_barre
int X=146
int Y=1464
int Width=247
int Height=76
string Text="1200"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer Net

if baud<>"1200" then
	Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
	Exclamation!, OKCancel!, 2)
	IF Net = 1 THEN
	  baud = "1200"
	  update par_lettore
	  set Baud = '1200'
	  ;
	  IF SQLCA.SQLNRows <> 1 THEN
		MessageBox("Error", "Errore nella registrazione dei parametri")
		end if
	ELSE
	 RestoreBaudValues()
	END IF
end if
end event

type st_5 from statictext within w_cod_barre
int X=1893
int Y=1504
int Width=329
int Height=76
boolean Enabled=false
string Text="Terminal ID:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_termid from singlelineedit within w_cod_barre
int X=2272
int Y=1496
int Width=247
int Height=92
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;integer Net



if IsNumber(sle_termid.text) then
	if Integer(sle_termid.text) <> Integer(idterm) and &
	Integer(sle_termid.text) >= 0 and Integer(sle_termid.text) <= 255 then
			Net = MessageBox("Modifica parametri", "Vuoi davvero modificare questo parametro?", &
			Exclamation!, OKCancel!, 2)
			IF Net = 1 THEN
				idterm = sle_termid.text
			  update par_lettore
			  set id_term = :sle_termid.text
			  ;
			  IF SQLCA.SQLNRows <> 1 THEN
				MessageBox("Error", "Errore nella registrazione dei parametri")
				end if
			ELSE
				
			 sle_termid.text=idterm
			END IF	
		else
			if Integer(sle_termid.text) <> Integer(idterm) then
				MessageBox("Error", "Inserire un numero tra 0 e 255")
				sle_termid.text=idterm
			end if
			
	end if
	
else
	MessageBox("Error", "Inserire un numero tra 0 e 255")
	sle_termid.text=idterm
end if
end event

type dw_1 from datawindow within w_cod_barre
int X=41
int Y=268
int Width=3086
int Height=796
int TabOrder=50
string DataObject="dw_bancolini"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_cod_barre
int X=1495
int Y=68
int Width=247
int Height=108
int TabOrder=30
string Text="Ricevi"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string command
long result, ll_rows

if fileExists(path+filename) then
	fileDelete(path+filename)
end if
if fileExists(path+"mode_3_4.txt") then
	fileDelete(path+"mode_3_4.txt")
end if
command="p="+port+",b="+baud+",i="+idterm+",f="+filename+",path="+path
result = B30XferRx (command)

if result = 0 then
	
integer li_FileNum
string linea

li_FileNum = FileOpen(path + fileName, lineMode!, Read!, LockRead!)

if li_FileNum <> -1 then
FileRead(li_FileNum, linea)
FileClose(li_FileNum)
integer start = 1
integer trovato = 0 
integer count=-1

DO
	count++
	trovato = pos(linea,";",start)
	start=trovato + 1
	 
LOOP WHILE trovato<>0



if count=3 then
		string vecchio_nome
		vecchio_nome = path + "mode_1_2.txt"
		
		string nuovo_nome
		nuovo_nome = path + "mode_3_4.txt"
		
		if not(MoveFileA(vecchio_nome,nuovo_nome)) then
			MessageBox("Alert", "Impossibile rinominare il file")
		end if
		dw_1.dataobject="dw_bancolini_3_4"
	
else
	
	dw_1.dataobject="dw_bancolini_1_2"
	
	end if
	





else
	MessageBox("Alert", "File dei dati non trovato")
END IF



dw_1.SetTransObject( barCode_TransObj )
	
	ll_rows = dw_1.Retrieve( )
ELSE
	
  MessageBox("Error", "Problemi nella lettura dati")
end if
end event

type gb_2 from groupbox within w_cod_barre
int X=55
int Y=1640
int Width=1605
int Height=212
int TabOrder=10
string Text="Porta"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_cod_barre
int X=55
int Y=1384
int Width=1609
int Height=208
int TabOrder=20
string Text="Baud"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within w_cod_barre
int X=649
int Y=1196
int Width=2528
int Height=20
boolean Enabled=false
int LineThickness=4
long LineColor=79741120
long FillColor=33554432
end type

