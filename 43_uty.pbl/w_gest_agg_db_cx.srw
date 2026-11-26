forward
global type w_gest_agg_db_cx from Window
end type
type tab_1 from tab within w_gest_agg_db_cx
end type
type tabpage_2 from userobject within tab_1
end type
type cb_exp_script from commandbutton within tabpage_2
end type
type dw_gest_agg_db_ff from datawindow within tabpage_2
end type
type cb_aggiorna from commandbutton within tabpage_2
end type
type cb_vis_versioni from commandbutton within tabpage_2
end type
type cb_imp_script from commandbutton within tabpage_2
end type
type tabpage_1 from userobject within tab_1
end type
type dw_script_gd from datawindow within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type cb_imp_menu from commandbutton within tabpage_3
end type
type cb_exp_menu from commandbutton within tabpage_3
end type
type dw_agg_menu_ext from datawindow within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type cb_scegli from commandbutton within tabpage_4
end type
type st_2 from statictext within tabpage_4
end type
type st_1 from statictext within tabpage_4
end type
type cb_2 from commandbutton within tabpage_4
end type
type cb_1 from commandbutton within tabpage_4
end type
type dw_2 from datawindow within tabpage_4
end type
type dw_1 from datawindow within tabpage_4
end type
type tabpage_2 from userobject within tab_1
cb_exp_script cb_exp_script
dw_gest_agg_db_ff dw_gest_agg_db_ff
cb_aggiorna cb_aggiorna
cb_vis_versioni cb_vis_versioni
cb_imp_script cb_imp_script
end type
type tabpage_1 from userobject within tab_1
dw_script_gd dw_script_gd
end type
type tabpage_3 from userobject within tab_1
cb_imp_menu cb_imp_menu
cb_exp_menu cb_exp_menu
dw_agg_menu_ext dw_agg_menu_ext
end type
type tabpage_4 from userobject within tab_1
cb_scegli cb_scegli
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
type tab_1 from tab within w_gest_agg_db_cx
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
end forward

global type w_gest_agg_db_cx from Window
int X=833
int Y=361
int Width=2263
int Height=1045
boolean TitleBar=true
string Title="Gestione Aggiornamento DataBase"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
tab_1 tab_1
end type
global w_gest_agg_db_cx w_gest_agg_db_cx

type variables
String is_dir_sql_script
end variables

forward prototypes
public subroutine wf_ret_script ()
public function integer wf_ver_dir_sql_script ()
public subroutine w_trova_voci (long ll_id_voce)
end prototypes

public subroutine wf_ret_script ();Integer li_app

SELECT 1
INTO	 :li_app
FROM	 sys.systable
WHERE	 table_name = 'script'
;
If Sqlca.Sqlcode = 0 Then
	tab_1.tabpage_1.dw_script_gd.DataObject="d_script_gd"
	tab_1.tabpage_1.dw_script_gd.SetTransObject(sqlca)
	tab_1.tabpage_1.dw_script_gd.Retrieve()
	
	
	datawindowchild ldw_ver_inizio,ldw_ver_fine
	
	tab_1.tabpage_2.dw_gest_agg_db_ff.GetChild("ver_inizio",ldw_ver_inizio)
	ldw_ver_inizio.SetTransObject(sqlca)
	ldw_ver_inizio.Retrieve()
	
	tab_1.tabpage_2.dw_gest_agg_db_ff.GetChild("ver_fine",ldw_ver_fine)
	ldw_ver_fine.SetTransObject(sqlca)
	ldw_ver_fine.Retrieve()
	
End If


end subroutine

public function integer wf_ver_dir_sql_script ();

String 	Ls_ult_car
Integer 	Li_stringlen


tab_1.tabpage_2.dw_gest_agg_db_ff.AcceptText()
is_dir_SQL_Script  = tab_1.tabpage_2.dw_gest_agg_db_ff.GetItemString(1, "dir_sql_script")

If (IsNull(is_dir_SQL_Script) = TRUE) Then
	MessageBox("Gestione Aggiornamento Data Base", "Specificare la Directory degli Script ISQL ...")
	Return 0	
Else	
	
	Li_stringlen = Len (is_dir_SQL_Script)
	Ls_ult_car = Mid (is_dir_SQL_Script, Li_stringlen)
	
	
		
	If ls_ult_car <> '\' Then
		is_dir_SQL_Script = is_dir_SQL_Script + '\'
		tab_1.tabpage_2.dw_gest_agg_db_ff.SetItem(1, "dir_sql_script", is_dir_SQL_Script)
	End If
End If
Return 1	
end function

public subroutine w_trova_voci (long ll_id_voce);long ll_id_voce_menu_copia, ll_riga_per_cerca, ll_id_voce_menu, ll_riga_trovata_voce
datawindow dw_1, dw_2
dw_1=tab_1.tabpage_4.dw_1
dw_2=tab_1.tabpage_4.dw_2
integer li_conta

ll_id_voce_menu_copia=ll_id_voce
		do 
			
			ll_riga_per_cerca=dw_1.find("id_voci_menu_padre= "+string(ll_id_voce_menu_copia), ll_riga_per_cerca+1, dw_1.rowcount())
			if ll_riga_per_cerca<1 then exit
			tab_1.tabpage_4.dw_1.rowscopy(ll_riga_per_cerca, ll_riga_per_cerca, primary!, dw_2, dw_2.rowcount()+1, primary!)
			if li_conta>0 and ll_riga_per_cerca < dw_1.rowcount() then ll_id_voce_menu=dw_1.getitemnumber(ll_riga_per_cerca, "id_voci_menu")
			do while ll_id_voce_menu>0 
				ll_riga_trovata_voce=dw_1.find("id_voci_menu_padre= "+string(ll_id_voce_menu), 1, dw_1.rowcount())
				if ll_riga_trovata_voce>0 then
					dw_1.rowscopy(ll_riga_trovata_voce, ll_riga_trovata_voce, primary!, dw_2, dw_2.rowcount()+1, primary!)
					w_trova_voci(ll_riga_trovata_voce)
					ll_riga_trovata_voce=dw_1.find("id_voci_menu_padre= "+string(ll_id_voce_menu), 1, dw_1.rowcount())
					ll_id_voce_menu=dw_1.getitemnumber(ll_riga_trovata_voce, "id_voci_menu")
				else
					exit
				end if
			loop
			li_conta++
		loop while ll_riga_per_cerca < dw_1.rowcount() and ll_riga_per_cerca>0
end subroutine

event open;tab_1.tabpage_2.dw_gest_agg_db_ff.insertrow(1)
tab_1.tabpage_3.dw_agg_menu_ext.insertrow(1)

tab_1.tabpage_2.dw_gest_agg_db_ff.accepttext()

datawindowchild ldw_ver_inizio, ldw_ver_fine

tab_1.tabpage_2.dw_gest_agg_db_ff.getchild("ver_inizio",ldw_ver_inizio)
tab_1.tabpage_2.dw_gest_agg_db_ff.getchild("ver_fine",ldw_ver_fine)

ldw_ver_inizio.settransobject(sqlca)
ldw_ver_inizio.retrieve()

ldw_ver_fine.settransobject(sqlca)
ldw_ver_fine.retrieve()

tab_1.tabpage_3.dw_agg_menu_ext.accepttext()

datawindowchild ldw_menu, ldw_utente 

tab_1.tabpage_3.dw_agg_menu_ext.getchild("menu",ldw_menu)

ldw_menu.settransobject(sqlca)
ldw_menu.retrieve()

tab_1.tabpage_3.dw_agg_menu_ext.getchild("utenti",ldw_utente)

ldw_utente.settransobject(sqlca)
ldw_utente.retrieve()

end event

on w_gest_agg_db_cx.create
this.tab_1=create tab_1
this.Control[]={ this.tab_1}
end on

on w_gest_agg_db_cx.destroy
destroy(this.tab_1)
end on

event close;long azzera[]
u_freddie.ll_id_voci_menu=azzera
end event

type tab_1 from tab within w_gest_agg_db_cx
event create ( )
event destroy ( )
int X=28
int Y=25
int Width=2204
int Height=905
int TabOrder=50
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={ this.tabpage_2,&
this.tabpage_1,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_2)
destroy(this.tabpage_1)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;if newindex=2 then
	wf_ret_script()
end if
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=105
int Width=2167
int Height=785
long BackColor=79741120
string Text="Aggiornamento DB"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_exp_script cb_exp_script
dw_gest_agg_db_ff dw_gest_agg_db_ff
cb_aggiorna cb_aggiorna
cb_vis_versioni cb_vis_versioni
cb_imp_script cb_imp_script
end type

on tabpage_2.create
this.cb_exp_script=create cb_exp_script
this.dw_gest_agg_db_ff=create dw_gest_agg_db_ff
this.cb_aggiorna=create cb_aggiorna
this.cb_vis_versioni=create cb_vis_versioni
this.cb_imp_script=create cb_imp_script
this.Control[]={ this.cb_exp_script,&
this.dw_gest_agg_db_ff,&
this.cb_aggiorna,&
this.cb_vis_versioni,&
this.cb_imp_script}
end on

on tabpage_2.destroy
destroy(this.cb_exp_script)
destroy(this.dw_gest_agg_db_ff)
destroy(this.cb_aggiorna)
destroy(this.cb_vis_versioni)
destroy(this.cb_imp_script)
end on

type cb_exp_script from commandbutton within tabpage_2
int X=110
int Y=589
int Width=385
int Height=93
int TabOrder=6
boolean BringToTop=true
string Text="&Export Script"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
String 	ls_script
Integer	li_ret


li_ret = wf_ver_dir_SQL_Script()

If li_ret = 1 Then
	ls_script="ISQL READ " + is_dir_SQL_Script + 'export_script.sql' +' ['+is_dir_SQL_Script +']'
	ls_script="ISQL READ " + 'export_script.sql' +' ['+is_dir_SQL_Script +']'	

	Run (ls_script)
End If
end event

type dw_gest_agg_db_ff from datawindow within tabpage_2
int X=19
int Y=29
int Width=2122
int Height=445
int TabOrder=4
string DataObject="d_gest_agg_db_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event clicked;Choose Case "dwo.name"
	Case "ver_inizio", "ver_fine"
		MessageBox("aaa", "")
		wf_ret_script()
End Choose
end event

type cb_aggiorna from commandbutton within tabpage_2
int X=1500
int Y=589
int Width=385
int Height=93
int TabOrder=4
boolean BringToTop=true
string Text="&Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String 	ls_ver_inizio, ls_ver_fine, ls_script
Integer	li_ret

ls_ver_inizio = tab_1.tabpage_2.dw_gest_agg_db_ff.GetItemString(1, "ver_inizio")
ls_ver_fine	  = tab_1.tabpage_2.dw_gest_agg_db_ff.GetItemString(1, "ver_fine")

	If (IsNull(ls_ver_inizio)) Or (IsNull(ls_ver_fine)) Then
		MessageBox("Gestione Aggiornamento Data Base", "Specificare entrambe le versioni ...")
	ElseIf ls_ver_inizio > ls_ver_fine Then
		MessageBox("Gestione Aggiornamento Data Base", "Versione di partenza maggiore di quella di destinazione ...")
	Else
		
		
		Commit;	

		ls_script = "ISQL READ " + "crea_Script_agg.sql" + " '"+ls_ver_inizio+"'" + " '"+ls_ver_fine+"'" + ' [' + is_dir_SQL_Script+']'

		Run (ls_script)
	
	End If
end event

type cb_vis_versioni from commandbutton within tabpage_2
int X=1093
int Y=589
int Width=385
int Height=93
int TabOrder=3
boolean BringToTop=true
string Text="&Versioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

String ls_ver_inizio, ls_ver_fine

SELECT MIN(codice)
INTO	 :ls_ver_inizio
FROM	 script
WHERE	 eseguito = 'N'
OR	    eseguito IS NULL;

If SQLCA.SQLCODE = 0 Then
	
	tab_1.tabpage_2.dw_gest_agg_db_ff.SetItem(1, "ver_inizio", ls_ver_inizio)

End If

SELECT MAX(codice)
INTO	 :ls_ver_fine
FROM	 script
WHERE	 eseguito = 'N'
OR	    eseguito IS NULL;

If SQLCA.SQLCODE = 0 Then
	tab_1.tabpage_2.dw_gest_agg_db_ff.SetItem(1, "ver_fine", ls_ver_fine)
End If

end event

type cb_imp_script from commandbutton within tabpage_2
int X=517
int Y=589
int Width=385
int Height=93
int TabOrder=2
boolean BringToTop=true
string Text="&Import Script"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
 
String ls_script

Integer	li_ret


li_ret = wf_ver_dir_SQL_Script()

If li_ret = 1 Then


	ls_script = "ISQL READ " + 'import_script.sql' +' ['+is_dir_SQL_Script + ']'	
	
	Run (ls_script)
End If
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=105
int Width=2167
int Height=785
long BackColor=79741120
string Text="Script ISQL"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_script_gd dw_script_gd
end type

on tabpage_1.create
this.dw_script_gd=create dw_script_gd
this.Control[]={ this.dw_script_gd}
end on

on tabpage_1.destroy
destroy(this.dw_script_gd)
end on

type dw_script_gd from datawindow within tabpage_1
int X=65
int Y=37
int Width=2026
int Height=729
int TabOrder=5
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type tabpage_3 from userobject within tab_1
int X=19
int Y=105
int Width=2167
int Height=785
long BackColor=79741120
string Text="Aggiornamento Menu"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_imp_menu cb_imp_menu
cb_exp_menu cb_exp_menu
dw_agg_menu_ext dw_agg_menu_ext
end type

on tabpage_3.create
this.cb_imp_menu=create cb_imp_menu
this.cb_exp_menu=create cb_exp_menu
this.dw_agg_menu_ext=create dw_agg_menu_ext
this.Control[]={ this.cb_imp_menu,&
this.cb_exp_menu,&
this.dw_agg_menu_ext}
end on

on tabpage_3.destroy
destroy(this.cb_imp_menu)
destroy(this.cb_exp_menu)
destroy(this.dw_agg_menu_ext)
end on

type cb_imp_menu from commandbutton within tabpage_3
int X=1134
int Y=613
int Width=385
int Height=93
int TabOrder=8
boolean Visible=false
string Text="&Import"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


String 	Ls_ult_car, ls_dir_ascii, ls_menu, ls_utenti, ls_script
Integer 	Li_stringlen


tab_1.tabpage_3.dw_agg_menu_ext.AcceptText()
ls_dir_Ascii  = tab_1.tabpage_3.dw_agg_menu_ext.GetItemString(1, "dir_Ascii")

If (IsNull(ls_dir_ascii) = TRUE) Then
	MessageBox("Gestione Aggiornamento Menu", "Specificare la Directory dei file ascii ...")
	return
End If


Li_stringlen = Len (ls_dir_ascii)
Ls_ult_car = Mid (ls_dir_ascii, Li_stringlen)
		
If ls_ult_car <> '\' Then
	ls_dir_ascii = ls_dir_ascii + '\'
	tab_1.tabpage_3.dw_agg_menu_ext.SetItem(1, "dir_ascii", ls_dir_ascii)
End If

ls_script="ISQL READ " + 'imp_menu.sql' +' ['+ls_dir_ascii +']'

Run (ls_script)

end event

type cb_exp_menu from commandbutton within tabpage_3
int X=618
int Y=613
int Width=385
int Height=93
int TabOrder=7
string Text="&Export"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


String 	Ls_ult_car, ls_dir_ascii, ls_menu, ls_utenti, ls_script
Integer 	Li_stringlen


tab_1.tabpage_3.dw_agg_menu_ext.AcceptText()
ls_dir_Ascii  = tab_1.tabpage_3.dw_agg_menu_ext.GetItemString(1, "dir_Ascii")
ls_menu = tab_1.tabpage_3.dw_agg_menu_ext.GetItemString(1, "menu")
ls_utenti = tab_1.tabpage_3.dw_agg_menu_ext.GetItemString(1, "utenti")


If (IsNull(ls_dir_ascii) = TRUE) Then
	MessageBox("Gestione Aggiornamento Menu", "Specificare la Directory dei file ascii ...")
	return
End If


Li_stringlen = Len (ls_dir_ascii)
Ls_ult_car = Mid (ls_dir_ascii, Li_stringlen)
		
If ls_ult_car <> '\' Then
	ls_dir_ascii = ls_dir_ascii + '\'
	tab_1.tabpage_3.dw_agg_menu_ext.SetItem(1, "dir_ascii", ls_dir_ascii)
End If

If (IsNull(ls_menu) = TRUE) Then
	MessageBox("Gestione Aggiornamento Menu", "Specificare i menu dei quali fare l'Export ...")
	return
End If

If (IsNull(ls_utenti) = TRUE) Then
	MessageBox("Gestione Aggiornamento Menu", "Specificare gli Utenti dei quali fare l'Export ...")
	return
End If

ls_script="ISQL READ " + 'exp_menu.sql' +' ['+ls_dir_ascii +']' +' [('+ls_menu+')]' +' [('+ls_utenti+')]'

Run (ls_script)

end event

type dw_agg_menu_ext from datawindow within tabpage_3
int X=60
int Y=77
int Width=2053
int Height=449
int TabOrder=6
string DataObject="d_agg_menu_ext"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type tabpage_4 from userobject within tab_1
int X=19
int Y=105
int Width=2167
int Height=785
long BackColor=79741120
string Text="Copia Menu"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_scegli cb_scegli
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type

on tabpage_4.create
this.cb_scegli=create cb_scegli
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={ this.cb_scegli,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on tabpage_4.destroy
destroy(this.cb_scegli)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type cb_scegli from commandbutton within tabpage_4
int X=1742
int Y=653
int Width=261
int Height=109
int TabOrder=13
string Text="Seleziona"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.reset()
long ll_riga_trovata, i
for i =1 to upperbound(u_freddie.ll_id_voci_menu)
	ll_riga_trovata=dw_1.find("id_voci_menu= "+string(u_freddie.ll_id_voci_menu[i]), 1, dw_1.rowcount())
	dw_1.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_2, dw_2.rowcount()+1, primary!)
next
st_1.text=string(dw_2.rowcount())
end event

type st_2 from statictext within tabpage_4
int X=42
int Y=285
int Width=247
int Height=73
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within tabpage_4
int X=42
int Y=653
int Width=247
int Height=73
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within tabpage_4
int X=1313
int Y=653
int Width=252
int Height=109
int TabOrder=12
string Text="Salva .txt"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_path

ls_path=tab_1.tabpage_3.dw_agg_menu_ext.getitemstring(1, "dir_ascii")
if isnull(ls_path) then ls_path="" else ls_path=ls_path+"export.txt"
dw_2.saveas(ls_path, text!, false)
end event

type cb_1 from commandbutton within tabpage_4
int X=883
int Y=653
int Width=247
int Height=109
int TabOrder=10
boolean BringToTop=true
string Text="Retrieve"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.retrieve()
st_2.text=string(dw_1.rowcount())
dw_2.settransobject(sqlca)

end event

type dw_2 from datawindow within tabpage_4
int X=19
int Y=365
int Width=2131
int Height=261
int TabOrder=9
string DataObject="d_voci_menu"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_1 from datawindow within tabpage_4
int X=19
int Y=13
int Width=2131
int Height=269
int TabOrder=7
string DataObject="d_voci_menu"
boolean VScrollBar=true
boolean LiveScroll=true
end type

