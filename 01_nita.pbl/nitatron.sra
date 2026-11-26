//objectcomments Generated Application Object
forward
global type nitatron from application
end type
global uo_sp_trans sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
// errori sul database
constant integer gci_err_critical=0
constant integer gci_err_warning=1

constant string modo_elimina = "E"
constant string modo_modifica = "M"
constant string modo_visualizza = "V"
constant string modo_inserisci = "I"

constant integer max_retrieval_argument = 3

s_list_main gs_list_null


n_application gn_app
n_wininet gn_ftp
w_catalogo_2018_cx  gw_frame
end variables

global type nitatron from application
string appname = "nitatron"
integer highdpimode = 0
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 25.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "25.1.0.6464"
boolean manualsession = false
boolean unsupportedapierror = false
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global nitatron nitatron

type prototypes
function long PRP_GetDC (long job) library "pbvm90.dll"
Function long  GetDeviceCaps (  Long hdc, long nIndex) library  "GDI32"    
function boolean  GetWeight(string  pippo,ref char ritorno[255]) library"PaCaBi02.dll" 
function ulong GetTempPathA ( ulong cchBuffer, ref char lpszTempPath[255]) library  "Kernel32.dll"  
Function uint  GetTempFileNameA ( ref char DriveLetter[255], ref char PrefixString[255], uint Unique, ref char TempFileName[255]) library  "Kernel32.dll"    
Subroutine PrintPage (string NomeFile) library  "PaCaGr02.dll"
Function long SetTextColor(long dc, long color) library "GDI32"
Function long CreatePen(integer stile, integer spessore, long color) library "GDI32"
Function long SelectObject (long dc, long object) library "GDI32"
Function long DeleteDC(long dc) library "GDI32"
Function Integer DeleteObject(long object) library "GDI32"
//Function String Licenza() library "stlo001.dll"

function ulong GetDC( ulong hWnd1 )  Library "USER32.DLL"
function long ReleaseDC(ulong hWnd1, long hDC) Library "USER32.DLL"
function boolean TextOutA( ulong hdc,long nXStart, &
long nYStart, ref string lpString, &
long cbString ) Library "GDI32.DLL"
function ulong CreateFontA( long nHeight, &
long nWidth,  long nEscapement, &
long nOrientation, long fnWeight, &
ulong fdwItalic,ulong fdwUnderline, ulong fdwStrikeOut, &
ulong fdwCharSet, ulong fdwOutputPrecision, &
ulong fdwClipPrecision, ulong fdwQuality, &
ulong fdwPitchAndFamily, ref string lpszFace ) Library "GDI32.dll"
function long B30XferRx (ref string command)  Library "B30win32.dll" 
function boolean MoveFileA(ref string old, ref string new) Library "Kernel32.dll"
function ulong GetModuleFileNameA(ulong module, ref string buffer, ulong lenght) Library "Kernel32.dll" ALIAS FOR "GetModuleFileNameA;ansi"
function int GetModuleHandleA (string as_ModuleName) library "kernel32.dll"

function long  RunSync(ref string Comando) library"RunSync.dll" 

SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"

//per inviare ftp
function BOOLean  CloseHandle(int hObject) library "kernel32.dll"
//per 10.5 in poi unicode quindi aggiungi  'ALIAS FOR "MoveFileA;ansi"'
//FUNCTION BOOLEAN MoveFileA(STRING oldfile, STRING newfile) &
//LIBRARY "KERNEL32.DLL" ALIAS FOR "MoveFileA;ansi"
FUNCTION decimal fn_rec_prezzo_filo_rame(string value, date value) RPCFUNC
end prototypes

type variables
s_application istr_application
long il_error_counter
end variables

forward prototypes
public subroutine uf_type_error ()
public function string uf_extract_path (string url)
public function string uf_extract_exe_name (string url)
end prototypes

public subroutine uf_type_error ();// --------------------------------------------------------------------------------
// Funzione che scrive su un file di testo di tipo INI le informazioni relative
// all'errore verificatosi.
// --------------------------------------------------------------------------------


string ls_error_voice, ls_user, ls_error_report, ls_error_counter

il_error_counter = il_error_counter +1
ls_error_counter = string(il_error_counter)
if not IsNull(u_freddie.s_utenti.s_utente) then
	ls_user = u_freddie.s_utenti.s_utente
else
	ls_user = "Sconosciuto"
end if
ls_error_voice = "Report sull'errore del: " + string(Today()) + "; Ora Inizio: " + string(Now())+ "; Utente: " + ls_user + " ."

if not FileExists(istr_application.error_file) then
	FileClose(FileOpen(istr_application.error_file,LineMode!,Write!))
end if

SetProfileString(istr_application.error_file, istr_application.error_header,ls_error_counter + " Informazioni  " , string(Today()) + "; Ora Inizio: " + string(Now())+ "; Utente: " + ls_user + " .")
SetProfileString(istr_application.error_file, istr_application.error_header,ls_error_counter + " Numero          " , " " + string(error.Number) + "~r")
SetProfileString(istr_application.error_file, istr_application.error_header,ls_error_counter + " Verificatosi in " , " " +error.WindowMenu + "~r")
SetProfileString(istr_application.error_file, istr_application.error_header,ls_error_counter + " Oggetto         " , " " +error.Object + "~r")
SetProfileString(istr_application.error_file, istr_application.error_header,ls_error_counter + " Evento          " , " " +error.ObjectEvent + "~r")
SetProfileString(istr_application.error_file, istr_application.error_header,ls_error_counter + " Linea           " , " " +string(error.Line) + "~n pipo")

end subroutine

public function string uf_extract_path (string url);//Routine intelligentissima ma utile che data un path con filename terminale ne estrae il path
//es: uf_extract_path("c:\mammiferi\bovini\camilla.cow") ritorna "c:\mammiferi\bovini\"
long ll_last_slash, ll_pos

ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(url,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0

return mid(url,1,ll_last_slash)
end function

public function string uf_extract_exe_name (string url);//Routine intelligentissima ma utile che dato un path con nome di applicazione in fondo terminale ne estrae il nome
//privato del .exe
//es: uf_extract_exe_name("c:\mammiferi\bovini\camilla.exe") ritorna "camilla"
long ll_last_slash, ll_pos

ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(url,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0
// Come direbbe Giuliani: "(Fault) Tollerance: Zero!"
return mid(url,ll_last_slash+1, len(url) - ll_last_slash - 4)
end function

on nitatron.create
appname="nitatron"
message=create message
sqlca=create uo_sp_trans
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on nitatron.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// --------------------------------------------------------------------------------
//	Avvio dell'applicazione con la gestione mista multiaziendale e monoaziendale
// la selezione tra il mono e il multi deve essere semplice.
// --------------------------------------------------------------------------------
// Tutto deve passare attraverso il registry, per lo meno a 32 bit
// --------------------------------------------------------------------------------
//	Nella versione multiaziendale esiste un database caricato che è sempre quello e
//	che serve a scegliere i vari database. Si tratta di un database semplicissimo e
//	piccolo che contiene solo i profili ODBC dei vari database che già esistono.
// Una procedura a parte potrà gestire la manutenzione aziende.
// --------------------------------------------------------------------------------
// Nella versione monoaziendale il registry, oltre a specificare che l'azienda è
//	una sola (mono) deve contenere gli eventuali dati di sessione, che sono pochi.
// --------------------------------------------------------------------------------
// In ognuno dei due casi si dovrà verificare la possibilità di avviare la configu-
//	razione selezionata (mono o multi)
// --------------------------------------------------------------------------------
//
// Più specificatamente l'evento OPEN dell'applicazione ha il diritto di impostare
// alcuni parametri ed avviare la funzione f_open che si occupa di (quasi) tutto.
// --------------------------------------------------------------------------------



// --------------------------------------------------------------------------------
// Dichiarazione delle variabili
// --------------------------------------------------------------------------------
s_application	lstr_application		// struttura applicazione locale tmp
s_database		lstr_database			// struttura database locale tmp
boolean			lb_leggi, lb_scrivi	// forza la scrittura sul registry
integer li_AppHandle

// --------------------------------------------------------------------------------
// impostazione di S_APPLICATION
// --------------------------------------------------------------------------------
// Queste variabili non andrebbero mai toccate poiché servono come entry del registro
// Si va infatti a comporre registry_base+"\"+name+"\"+version
// Per i multiazioendali si avrà version+"\Multi_db"
// Per i monoaziendali si avrà version+"\Database"
// In ogni caso per la parte di S_Application si avrà version+"\Application"
//
// --------------------------------------------------------------------------------
// Per scegliere il monoaziendale porre "No" su multiaz
// Per scegliere il multiaziendale porre "Yes" su multiaz
// --------------------------------------------------------------------------------
lstr_application.registry_base	= "HKEY_LOCAL_MACHINE\SOFTWARE\MARK"
lstr_application.name				= "NITATRON"
lstr_application.version			= "1.0"
lstr_application.multiaz			= "No"
//
// --------------------------------------------------------------------------------
// Questi valori possono essere modificati con più tranquillità
// --------------------------------------------------------------------------------
lstr_application.error_header		= "Sessione di lavoro del " + String(Today()) + " " + string(Now()) + " ."
lstr_application.error_message	= 1	// 1|2
lstr_application.error_file		= ".\PbErrLog.txt"
lstr_application.description		= "NITATRON"
lstr_application.icon				= "c:\nita\nita.ico"
lstr_application.splash				= "c:\nita\nita.jpg"
//
// --------------------------------------------------------------------------------
// Qui i parametri multiaziendali per segliere da quale database scegliere la
// giusta azienda
// --------------------------------------------------------------------------------
lstr_application.az_vendor       = "ODBC"
lstr_application.az_nome         = "Aziende"
lstr_application.az_descr        = "Database delle aziende"
//
// --------------------------------------------------------------------------------
// bisognerebbe sempre avere TRUE!
// --------------------------------------------------------------------------------
lstr_application.enable_login 	= true

//---------------------------------------------------------------------------------
// Andiamo al leggere nel file .ini
//---------------------------------------------------------------------------------
string path
//Cassini docet: "rende più stabile il sistema"
//li_AppHandle = getmodulehandlea ("nita.exe")

//path=Space (256)
path=fill("*",256)
//path="c:\nita\nita.exe"
GetModuleFileNameA(0, path, 256) 
//messagebox("path",path)
//messagebox("path",uf_extract_path(path))
//messagebox("path",uf_extract_exe_name(path))
string sl_file_ini, sl_result
//commento per ora (14092017
sl_file_ini = uf_extract_path(path)+uf_extract_exe_name(path)+".ini"
//sl_file_ini = "c:\nita\"+uf_extract_exe_name(path)+".ini"
//sl_file_ini = "c:\nita\nita.ini"
sl_result = ProfileString ( sl_file_ini, "Database", "Nome", "Error!" )

if sl_result = "Error!" then
	OpenWithParm(w_ini_creation, sl_file_ini)
	sl_result = message.stringparm 
end if

lstr_database.key				= sl_result
lstr_database.name			=  sl_result

// --------------------------------------------------------------------------------
// impostazione di S_DATABASE
// --------------------------------------------------------------------------------
// Nel monoaziendale la struttura s_database è fissa, mentre nel multiaziendale è
// varibile. Tuttavia, visti i risvolti, si crede che in ogni caso non si possa
// avere un sistema monoaziendale siffatto altro che con Sybase Anywhere. Per ora
// dunque l'unico che si implementa è quello, poi si vedrà. Nel caso di multi-
// aziendale con ID_AZIENDA non c'è il problema.
// --------------------------------------------------------------------------------
//lstr_database.key				= "bucci"
//lstr_database.name			= "bucci"
//
lstr_database.vendor			= "ODBC"
lstr_database.description	= "Database NITATRON"
//
lstr_database.user		= "dba"
lstr_database.password	= "sql"

// --------------------------------------------------------------------------------
// Impostazioni varie applicazione (APPlication SETtings), tra cui registry
// se lb_scrivi è a true significa che verrà comunque riscritta l'informazione
// conservata nel registry.
// --------------------------------------------------------------------------------
lb_leggi = true
lb_scrivi = false

f_appset(lstr_application,lstr_database,lb_leggi,lb_scrivi)
//// --------------------------------------------------------------------------------
//// Apertura vera e propria dell'applicazione
//// --------------------------------------------------------------------------------
//istr_application = lstr_application
//f_open(lstr_application,lstr_database)
//lstr_application = u_freddie.istr_application
//lstr_database = u_freddie.istr_database
// --------------------------------------------------------------------------------
// scrittura forzata del registry in ogni caso
// --------------------------------------------------------------------------------
lstr_application.enable_login 	= true
f_appset(lstr_application,lstr_database,false,true)
//// Apertura vera e propria dell'applicazione
//// --------------------------------------------------------------------------------
istr_application = lstr_application
f_open(lstr_application,lstr_database)
lstr_application = u_freddie.istr_application
lstr_database = u_freddie.istr_database


end event

event systemerror;// per chiamare un errore di sistema
//f_system_error()
CHOOSE CASE istr_application.error_message 
	CASE 1
		Open(w_sys_error)
	CASE 2
		uf_type_error()
	CASE ELSE
END CHOOSE

end event

event close;// chiude l'applicazione
f_close()
end event

