forward
global type u_freddie from nonvisualobject
end type
end forward

global type u_freddie from nonvisualobject
end type
global u_freddie u_freddie

type variables

s_application	istr_application

s_database	istr_database

w_data_main	iw_current	
u_dw_main	iudw_current	
integer		ii_par_sp		
string		is_par_st[]	

string		is_imm_dir	

integer		ii_ID_Utenti
integer		ii_ID_Menu
s_login		s_utenti
boolean		ib_enable_menu	

long		gl_null
integer		gi_null
string		gs_null
char		gc_null
date		gd_null
datetime		gdt_null

long		il_sqlcode[]
string		is_mytext[]
integer		ii_numargs[]
integer		ii_maxerr

s_menu_ric	istr_menu

string		is_helpfile = "NITATRON.html"

//uo_print_crw	iuo_stampa
integer		ii_tipo_gest
CONSTANT integer ici_gest_std = 0
//CONSTANT integer ici_gest_prd = 1
//CONSTANT integer ici_gest_Fedrizzi = 2
//CONSTANT integer ici_gest_Iret = 3
//CONSTANT integer ici_gest_TrPk = 4

long ll_id_voci_menu[]
end variables

forward prototypes
public function integer login ()
public subroutine splashscreen (boolean ab_show)
public subroutine center_window (window aw_window)
public subroutine dberror (integer ai_severity, string as_message)
public subroutine create_not_existing (string as_filename)
public function integer ask_for_save (u_dw_main audw_dw)
public subroutine openmenu ()
public function boolean sp_topval (ref string as_lista[])
public function boolean sp_push (string as_lista[])
public function boolean sp_drop ()
public function integer sp_count ()
public function boolean sp_dataexist ()
public function boolean sp_tagistop (string as_tag)
public function boolean sp_clear ()
public function boolean sp_pop (ref string as_lista[])
public function string select_azienda (boolean ab_frame)
public function integer dbconnect (boolean ab_connect, string as_pwd)
public function string uf_extract_exe_name (string url)
end prototypes

public function integer login ();

string	ls_utente, ls_azienda, ls_nome_programma
string	ls_menu_type
integer 	il_retValue

if istr_application.enable_login then
	
	Open(w_login)
	s_utenti = Message.PowerObjectParm
	IF s_utenti.i_idutente = -1 THEN
		
		il_retValue = -1
		ib_enable_menu = false
	ELSE
		Il_retValue = 0
		ls_utente=s_utenti.s_utente
		
		select menu_type
		into :ls_menu_type
		from utenti
		WHERE ID_UTENTi=:s_utenti.i_idutente;
		if ls_menu_type='B' then
			OpenSheetWithParm(w_menu_big, s_utenti.i_idmenu, w_app_frame, 0,Original!)
		else
			OpenSheetWithParm(w_menu, s_utenti.i_idmenu, w_app_frame, 0,Original!)
		end if
			ib_enable_menu = true
	END IF
else
	
	ib_enable_menu = false
	//m_mdi_frame.m_file.m_aprimenu.Enabled = FALSE
	Il_retValue = 0
end if

SELECT  "azienda"."rag_soc_1"  
	INTO :ls_azienda   
	FROM "dba"."azienda"  
	WHERE "azienda"."id_azienda" = 1   ;

If IsNull(ls_azienda) OR ls_azienda="" then 
	u_freddie.istr_application.az_descr=u_freddie.istr_database.name
else
	u_freddie.istr_application.az_descr=ls_azienda
end if

if isValid(w_app_frame) then 
	w_app_frame.Title= u_freddie.istr_application.name + " - " + &
   u_freddie.istr_database.name + " - " + u_freddie.istr_application.az_descr
	if not IsNull (ls_utente) then
	
		ls_nome_programma="NITATRON 1.0"
		w_app_frame.title = "NITATRON 1.0 - Software Freeware" 
		
		
	end if
end if

return Il_retValue
end function

public subroutine splashscreen (boolean ab_show);

if ab_show then
	OpenWithParm(w_splash, istr_application.splash)
else
	close(w_splash)
end if
end subroutine

public subroutine center_window (window aw_window);long ll_screenw, ll_screenh
environment le_env

GetEnvironment(le_env)
ll_screenw = PixelsToUnits(le_env.screenwidth,XPixelsToUnits!)
ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
aw_window.x = (ll_screenw - aw_window.width) / 2
if (aw_window=w_splash) then
	aw_window.y = (ll_screenh - aw_window.height) / 2
elseif (aw_window=w_login) then
	aw_window.y = (ll_screenh - aw_window.height) / 3	
else
	aw_window.y = 0
end if
end subroutine

public subroutine dberror (integer ai_severity, string as_message);

string ls_mes_type

CHOOSE CASE ai_severity
	CASE gci_err_critical
		ls_mes_type = "Errore critico:"
	CASE gci_err_warning
		ls_mes_type = "Attenzione:"
END CHOOSE

Messagebox(THIS.istr_application.name, ls_mes_type+"~n"+as_message, Exclamation!)
end subroutine

public subroutine create_not_existing (string as_filename);

if not fileexists(as_filename) then
	FileClose(FileOpen(as_filename,LineMode!,Write!))
end if
end subroutine

public function integer ask_for_save (u_dw_main audw_dw);

integer li_ync

if audw_dw.uf_changes() then
	li_ync = MessageBox(audw_dw.title, "Ci sono modifiche non salvate in " + audw_dw.title + ".~n~r" + &
		"Vuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			
			audw_dw.triggerevent("ue_update")
			RETURN 0
		CASE 2
			
			RETURN 0
		CASE 3
			
			RETURN 1
	END CHOOSE
else
	
	RETURN 0
end if


end function

public subroutine openmenu ();


end subroutine

public function boolean sp_topval (ref string as_lista[]);
boolean	lb_ok
integer	li_i

lb_ok = true
if ii_par_sp > 0 then
	
	for li_i = 1 to 10
		as_lista[li_i] = is_par_st[ii_par_sp - 10 + li_i]
	next
else
	lb_ok = false
end if

return lb_ok

end function

public function boolean sp_push (string as_lista[]);
boolean	lb_ok
integer	li_i, li_max

lb_ok = true

if isNull(as_lista) then
	lb_ok = false
else
	li_max = upperbound(as_lista)
	lb_ok = false
	if li_max<=10 then
		for li_i = 1 to li_max
			if not isNull(as_lista[li_i]) then
				is_par_st[ii_par_sp+li_i] = as_lista[li_i]
				lb_ok = true
			else
				is_par_st[ii_par_sp+li_i] = ""				
			end if
		next
		for li_i = li_max+1 to 10
			is_par_st[ii_par_sp+li_i] = ""
		next
	end if
end if

if lb_ok then
	ii_par_sp = ii_par_sp + 10
end if

return lb_ok

end function

public function boolean sp_drop ();

if ii_par_sp>0 then
	ii_par_sp = ii_par_sp - 10
	return true
else
	return false
end if

end function

public function integer sp_count ();

return (ii_par_sp / 10)

end function

public function boolean sp_dataexist ();
if ii_par_sp>0 then
	return true
else
	return false
end if



end function

public function boolean sp_tagistop (string as_tag);
string	ls_1
boolean	lb_1

lb_1 = false
if ii_par_sp>0 then
	ls_1 = is_par_st[ii_par_sp - 10 + 1]
	if ls_1 = as_tag then lb_1 = true
end if

return lb_1

end function

public function boolean sp_clear ();
if ii_par_sp>0 then
	ii_par_sp = 0
	return true
else
	return false
end if


end function

public function boolean sp_pop (ref string as_lista[]);
boolean	lb_ok
integer	li_i

if ii_par_sp>0 then
	for li_i = 1 to 10
		as_lista[li_i] = is_par_st[ii_par_sp - 10 + li_i]
	next
	ii_par_sp = ii_par_sp - 10
	lb_ok = true
else
	lb_ok = false
end if

return lb_ok

end function

public function string select_azienda (boolean ab_frame);


string 				ls_file, ls_ret
window				wa_window


if ab_frame then
	Open(wa_window, "w_sel_azienda_wz", w_app_frame)
else
	Open(wa_window, "w_sel_azienda_wz")
end if
ls_ret = message.stringparm

return ls_ret

end function

public function integer dbconnect (boolean ab_connect, string as_pwd);
string		ls_userid, ls_password, ls_vendor, ls_database, ls_connect
integer		li_retv

li_retv = 0

if ab_connect then

	ls_userid = "dba"
	ls_password = as_pwd
	ls_vendor = istr_database.vendor
	ls_database = istr_database.name
	
	ls_connect = "ConnectString='DSN=" + ls_database + ";" + &
					 "UID=" + ls_userid + ";PWD=" + ls_password + ";'"
	SQLCA.dbms=ls_vendor
	
	SQLCA.dbparm=ls_connect
	
	CONNECT USING SQLCA;
	if SQLCA.SQLCode<0 then
		
		THIS.dberror(gci_err_critical,"Impossibile connettersi al DataBase")
		li_retv = -1
	end if
else
	
	DISCONNECT USING SQLCA;
end if

return li_retv

end function

public function string uf_extract_exe_name (string url);long ll_last_slash, ll_pos

ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(url,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0
return mid(url,ll_last_slash+1, len(url) - ll_last_slash - 4)
end function

on u_freddie.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_freddie.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//iuo_stampa = create uo_print_crw

SetNull(gc_null)
SetNull(gi_null)
SetNull(gl_null)
SetNull(gs_null)
SetNull(gd_null)
SetNull(gdt_null)
ii_par_sp = 0

il_sqlcode[1] = -209
il_sqlcode[2] = -198
il_sqlcode[3] = -196
il_sqlcode[4] = -195
il_sqlcode[5] = -194
il_sqlcode[6] = -193
il_sqlcode[7] = -158
il_sqlcode[8] = -157
il_sqlcode[9] = -17001	
il_sqlcode[10] = -17002	

ii_numargs[1] = 2
ii_numargs[2] = 1
ii_numargs[3] = 2
ii_numargs[4] = 2
ii_numargs[5] = 2
ii_numargs[6] = 1
ii_numargs[7] = 0
ii_numargs[8] = 0
ii_numargs[9] = 0			
ii_numargs[10] = 0		

is_mytext[1] = "Il valore del campo $$$$ della tabella $$$$ non è valido"
is_mytext[2] = "Impossibile cancellare o modificare il record, vi è almeno un dato nella tabella $$$$ che dipende da questo"
is_mytext[3] = "Si sta tentando di inserire un dato per il quale l'indice $$$$ della tabella $$$$ non risulterebbe univoco"
is_mytext[4] = "Il valore del campo $$$$ della tabella $$$$ non può essere nullo."
is_mytext[5] = "Non ci sono valori per la chiave $$$$ nella tabella $$$$"
is_mytext[6] = "Dato non duplicabile nella tabella $$$$"
is_mytext[7] = "Valore introdotto troppo grande"
is_mytext[8] = "Errore di conversione, possibili problemi nel tipo di dato o nella grandezza"
is_mytext[9] = "Verificare gli intervalli di importi inseriti. Devono essere sequenziali senza sovrapporsi"	
is_mytext[10] = "Il valore della percentuale deve essere coerente con il tipo di importo specificato"			

ii_maxerr = 10

ii_tipo_gest = ici_gest_std



end event

event destructor;//destroy iuo_stampa
end event

