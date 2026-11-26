forward
global type w_sit_articolo_wz from w_wiz_main
end type
type tab_1 from tab within w_sit_articolo_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_esidisp from u_dw_master_main within tabpage_1
end type
type dw_scorta_art_gd from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_filtroacq from u_dw_ext_main within tabpage_2
end type
type dw_sitacq from u_dw_ext_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_sitven from u_dw_ext_main within tabpage_3
end type
type dw_filtroven from u_dw_ext_main within tabpage_3
end type
type tabpage_7 from userobject within tab_1
end type
type dw_storico_cli_for_lt from u_dw_ext_main within tabpage_7
end type
type dw_filtrocli from u_dw_ext_main within tabpage_7
end type
type tabpage_4 from userobject within tab_1
end type
type dw_listino_var_base_articolo_lt from u_dw_ext_main within tabpage_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_sostituzione_gd from u_dw_ext_main within tabpage_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_articoli_sostituiti_gd from u_dw_ext_main within tabpage_6
end type
type cb_esci from commandbutton within w_sit_articolo_wz
end type
type dw_selezioni from u_dw_ext_main within w_sit_articolo_wz
end type
type cb_mostra from commandbutton within w_sit_articolo_wz
end type
type tabpage_1 from userobject within tab_1
dw_esidisp dw_esidisp
dw_scorta_art_gd dw_scorta_art_gd
end type
type tabpage_2 from userobject within tab_1
dw_filtroacq dw_filtroacq
dw_sitacq dw_sitacq
end type
type tabpage_3 from userobject within tab_1
dw_sitven dw_sitven
dw_filtroven dw_filtroven
end type
type tabpage_7 from userobject within tab_1
dw_storico_cli_for_lt dw_storico_cli_for_lt
dw_filtrocli dw_filtrocli
end type
type tabpage_4 from userobject within tab_1
dw_listino_var_base_articolo_lt dw_listino_var_base_articolo_lt
end type
type tabpage_5 from userobject within tab_1
dw_sostituzione_gd dw_sostituzione_gd
end type
type tabpage_6 from userobject within tab_1
dw_articoli_sostituiti_gd dw_articoli_sostituiti_gd
end type
type tab_1 from tab within w_sit_articolo_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_7 tabpage_7
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
end forward

global type w_sit_articolo_wz from w_wiz_main
int Width=3150
int Height=1484
WindowType WindowType=response!
boolean TitleBar=true
string Title="Situazione articolo"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
tab_1 tab_1
cb_esci cb_esci
dw_selezioni dw_selezioni
cb_mostra cb_mostra
end type
global w_sit_articolo_wz w_sit_articolo_wz

type variables
Long	il_idart, il_idsc, il_idmag, il_ideser, il_idpard,il_idaz
long	il_id_profilo_documento
String   is_selacq, is_selven,is_selcli
String   is_regacq, is_regven,is_regcli

integer ii_dwi

u_sql_scanner	iuo_scacq, iuo_scven
u_sql_scanner	iuo_sc_stor
string is_conto_vis_scar
end variables

forward prototypes
public function integer wf_check_sel ()
public function integer wf_calcola_esi_disp ()
public function integer wf_calcola_listini ()
public function integer wf_calcola_stor_acq ()
public function integer wf_calcola_stor_ven ()
public function integer uf_calc_eser ()
public function integer uf_iniz ()
public function integer uf_decod_art ()
public function integer uf_decod_sc ()
public function integer uf_decod_all ()
public subroutine wf_dw_set_focus ()
public subroutine wf_calcola_tutto ()
public function integer wf_calcola_storico_cliente ()
public function integer uf_decod_mag ()
public function integer uf_calc_pardisp ()
public subroutine wf_scorta_articolo ()
end prototypes

public function integer wf_check_sel ();

string		ls_msg
long			ll_row
integer		li_ret

il_idart = 0
il_idmag = 0
il_idsc = 0
ls_msg = ""

if (isNull(il_ideser)) or (il_ideser <= 0) then
	ls_msg += "L'esercizio considerato non è valido!~r"
end if


ll_row = dw_selezioni.GetRow()

il_idart = dw_selezioni.GetItemNumber(ll_row,"id_articolo")
il_idmag = dw_selezioni.GetItemNumber(ll_row,"id_magazzino")
il_idsc = dw_selezioni.GetItemNumber(ll_row,"id_sogcom")

if isNull (il_idart) then
	ls_msg += "E' indispensabile un articolo!~r"
end if
if isNull (il_idmag) then il_idmag = 0
if isNull (il_idsc) then il_idsc = 0

if ls_msg>"" then
	MessageBox("Errori!",ls_msg)
	li_ret = -1
else
	li_ret = 0
end if

return li_ret

end function

public function integer wf_calcola_esi_disp ();


Long 		   ll_row, ll_id_attivita
decimal{4}  ld_esi_fisica_mag, ld_esi_fiscale_mag, ld_disp_mag, ld_esi_fisica_tot, ld_esi_fiscale_tot, ld_disp_tot
decimal{0}  ld_anno, ld_mese
String		ls_esi_disp_mag, ls_esi_disp_tot, variabile_stringa
decimal ld_nullo

setnull(ld_nullo)
	ll_row 		= tab_1.tabpage_1.dw_esidisp.getrow()	
	
	if (il_idart =0) then
		
	else
		ld_anno=year(today())
		ld_mese=month(today())
		tab_1.tabpage_1.dw_esidisp.Retrieve(il_idart, il_idmag, ld_anno, ld_mese, il_id_profilo_documento)
	   if (il_idmag=0) then
			tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fisica_mag",ld_nullo)
         tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fiscale_mag",ld_nullo) 
	      tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_disponibilita_mag",ld_nullo)
			select table_name 
			into :variabile_stringa
			from systable
			where table_name='orafo_par_sistema';
			
			
			if sqlca.sqlcode=0 then
				tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fisica_mag_f",ld_nullo)
         	tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fiscale_mag_f",ld_nullo) 
	      	tab_1.tabpage_1.dw_esidisp.setitem(1,"disponibilita_mag_f",ld_nullo)
				tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fisica_mag_c",ld_nullo)
         	tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fiscale_mag_c",ld_nullo) 
	      	tab_1.tabpage_1.dw_esidisp.setitem(1,"disponibilita_mag_c",ld_nullo)
				tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fisica_mag_p",ld_nullo)
         	tab_1.tabpage_1.dw_esidisp.setitem(1,"esi_fiscale_mag_p",ld_nullo) 
	      	tab_1.tabpage_1.dw_esidisp.setitem(1,"disponibilita_mag_p",ld_nullo)
			end if	
		end if	
   end if
return 0

end function

public function integer wf_calcola_listini ();

if il_idart=0 then
	tab_1.tabpage_4.dw_listino_var_base_articolo_lt.reset()
	tab_1.tabpage_5.dw_sostituzione_gd.reset()
	tab_1.tabpage_6.dw_articoli_sostituiti_gd.reset()
	return -1
else
	tab_1.tabpage_4.dw_listino_var_base_articolo_lt.retrieve(il_idart)
	tab_1.tabpage_5.dw_sostituzione_gd.retrieve(il_idart)
	tab_1.tabpage_5.dw_sostituzione_gd.ScrollToRow(1)
	tab_1.tabpage_5.dw_sostituzione_gd.event RowFocusChanged(1)
	tab_1.tabpage_6.dw_articoli_sostituiti_gd.retrieve(il_idart)
	tab_1.tabpage_6.dw_articoli_sostituiti_gd.ScrollToRow(1)
	tab_1.tabpage_6.dw_articoli_sostituiti_gd.event RowFocusChanged(1)
end if

return 0

end function

public function integer wf_calcola_stor_acq ();
string		ls_where, ls_sql
if il_idart = 0 then
	return -1
end if


ls_where = " (riga_documento.id_articolo = "+string(il_idart)+" )"

if is_regacq = "N" then
	ls_where += " AND (registro.tipo_registro = '"+string(is_selacq)+"')"
end if	

ls_where += " AND ( Substr(registro.tipo_registro,2,1) = 'A') "




iuo_scacq.f_reset_cur_as_ini()
iuo_scacq.f_add_where_condition(ls_where)
ls_sql = iuo_scacq.f_getcurrent()
tab_1.tabpage_2.dw_sitacq.object.datawindow.table.select = ls_sql

tab_1.tabpage_2.dw_sitacq.retrieve()
tab_1.tabpage_2.dw_sitacq.ScrollToRow(1)
tab_1.tabpage_2.dw_sitacq.event RowFocusChanged(1)

return 0

end function

public function integer wf_calcola_stor_ven ();
string		ls_where, ls_sql

if il_idart = 0 then
	return -1
end if


ls_where = " (riga_documento.id_articolo = "+string(il_idart)+" )"

if is_regven = "N" then
	ls_where += " AND (registro.tipo_registro = '"+string(is_selven)+"')"
end if	

ls_where += " AND ( Substr(registro.tipo_registro,2,1) = 'V') "	

iuo_scven.f_reset_cur_as_ini()

iuo_scven.f_add_where_condition(ls_where)

ls_sql = iuo_scven.f_getcurrent()

tab_1.tabpage_3.dw_sitven.object.datawindow.table.select = ls_sql

tab_1.tabpage_3.dw_sitven.retrieve()
tab_1.tabpage_3.dw_sitven.ScrollToRow(1)
tab_1.tabpage_3.dw_sitven.event RowFocusChanged(1)

return 0

end function

public function integer uf_calc_eser ();select "azienda"."id_esercizio"
	into: il_ideser
	from "dba"."azienda"
	where "azienda"."id_azienda"=1
using SQLCA;
if SQLCA.SQLCode <>0 then 
	MessageBox("Errore nel database","Errore : "+ SQLCA.SQLErrText)
end if

if not isNull(il_id_profilo_documento) then
	select max("par_disponibilita"."id_par_disponibilita")
		into :il_idpard
		from "dba"."par_disponibilita"
		where ("par_disponibilita"."id_prof_documento" = :il_id_profilo_documento ) and ("par_disponibilita"."id_azienda" =1)
		using SQLCA;
else
	select max("par_disponibilita"."id_par_disponibilita")
		into :il_idpard
		from "dba"."par_disponibilita"
		where ("par_disponibilita"."id_prof_documento" is null) and ("par_disponibilita"."id_azienda" =1)
	using SQLCA;	
end if

if SQLCA.SQLCode = -1 then 
	MessageBox("Errore nel database","Errore : "+ SQLCA.SQLErrText)
end if

return 0
end function

public function integer uf_iniz ();long			ll_row
string		ls_sql,prova

ll_row	= dw_selezioni.InsertRow(0)
dw_selezioni.ScrollToRow(ll_row)

ll_row		= tab_1.tabpage_1.dw_esidisp.InsertRow(0)
tab_1.tabpage_1.dw_esidisp.ScrollToRow(ll_row)

ll_row		= tab_1.tabpage_2.dw_filtroacq.InsertRow(0)
tab_1.tabpage_2.dw_filtroacq.ScrollToRow(ll_row)
tab_1.tabpage_2.dw_filtroacq.SetItem(ll_row, "tipo_registro", "IA")
tab_1.tabpage_2.dw_filtroacq.SetItem(ll_row,"tutti_reg", "N")

ll_row	= tab_1.tabpage_3.dw_filtroven.InsertRow(0)
tab_1.tabpage_3.dw_filtroven.ScrollToRow(ll_row)
tab_1.tabpage_3.dw_filtroven.SetItem(ll_row, "tipo_registro", "IV")
tab_1.tabpage_3.dw_filtroven.SetItem(ll_row, "tutti_reg", "N")

tab_1.tabpage_2.dw_sitacq.SetTransObject(SQLCA)
ls_sql = tab_1.tabpage_2.dw_sitacq.object.datawindow.table.select
iuo_scacq.f_setinitial(ls_sql)
iuo_scacq.f_setcurrent(ls_sql)

tab_1.tabpage_3.dw_sitven.SetTransObject(SQLCA)
ls_sql = tab_1.tabpage_3.dw_sitven.object.datawindow.table.select
iuo_scven.f_setinitial(ls_sql)
iuo_scven.f_setcurrent(ls_sql)


tab_1.tabpage_4.dw_listino_var_base_articolo_lt.SetTransObject(SQLCA)
tab_1.tabpage_5.dw_sostituzione_gd.SetTransObject(SQLCA)
tab_1.tabpage_6.dw_articoli_sostituiti_gd.SetTransObject(SQLCA)

ll_row		= tab_1.tabpage_7.dw_filtrocli.InsertRow(0)
tab_1.tabpage_7.dw_filtrocli.ScrollToRow(ll_row)

tab_1.tabpage_7.dw_storico_cli_for_lt.SetTransObject(SQLCA)
ls_sql = tab_1.tabpage_7.dw_storico_cli_for_lt.object.datawindow.table.select
iuo_sc_stor.f_setinitial(ls_sql)
iuo_sc_stor.f_setcurrent(ls_sql)

return 0
end function

public function integer uf_decod_art ();

string		ls_dbc[], ls_dwc[], ls_dbv[]
string		ls_sql_cond
long			ll_ok

ls_sql_cond = ""
ls_dbc[1]=	"codice"
ls_dwc[1]=	"art_cod"
ls_dbc[2]=	"descrizione"
ls_dwc[2]=	"art_des"
ls_dbc[3]=	"id_articolo"
ls_dwc[3]=	"id_articolo"

ll_ok = dw_selezioni.uf_autofind_col ("id_articolo","articolo","id_articolo", &
												  "N",string(il_idart), ls_sql_cond,3, &
												  ls_dbc, ls_dbv, ls_dwc)

return 0

end function

public function integer uf_decod_sc ();

string		ls_dbc[], ls_dwc[], ls_dbv[]
string		ls_sql_cond
long			ll_ok

ls_sql_cond = ""
ls_dbc[1]=	"codice"
ls_dwc[1]=	"sc_cod"
ls_dbc[2]=	"rag_soc_1"
ls_dwc[2]=	"sc_des"
ls_dbc[3]=	"id_sog_commerciale"
ls_dwc[3]=	"id_sogcom"

ll_ok = dw_selezioni.uf_autofind_col ("id_sog_commerciale","sog_commerciale_gen","id_sog_commerciale", &
												  "N",string(il_idsc), ls_sql_cond,3, &
												  ls_dbc, ls_dbv, ls_dwc)

return 0


end function

public function integer uf_decod_all ();

uf_decod_art()
uf_decod_sc()
uf_decod_mag()

return 0
end function

public subroutine wf_dw_set_focus ();

choose case ii_dwi
	case 1
		dw_selezioni.setfocus()
	case 2
		tab_1.SelectTab(1)
		tab_1.tabpage_1.dw_esidisp.setfocus() 
	case 3
		tab_1.SelectTab(2)
		tab_1.tabpage_2.dw_filtroacq.setfocus()
	case 4
	   tab_1.SelectTab(2)
		tab_1.tabpage_2.dw_sitacq.setfocus()
	case 5
		tab_1.SelectTab(3)
		tab_1.tabpage_3.dw_filtroven.setfocus()
	case 6
		tab_1.SelectTab(3)
		tab_1.tabpage_3.dw_sitven.setfocus()
	case 7
		tab_1.SelectTab(4)
		tab_1.tabpage_7.dw_filtrocli.setfocus()
	case 8	
		tab_1.SelectTab(4)
		tab_1.tabpage_7.dw_storico_cli_for_lt.setfocus()		
	case 9
		tab_1.SelectTab(5)
		tab_1.tabpage_4.dw_listino_var_base_articolo_lt.setfocus()
	case 10
		tab_1.SelectTab(6)
		tab_1.tabpage_5.dw_sostituzione_gd.setfocus()
	case 11
		tab_1.SelectTab(7)
		tab_1.tabpage_6.dw_articoli_sostituiti_gd.setfocus()	

end choose


end subroutine

public subroutine wf_calcola_tutto ();
integer		ii_ret


ii_ret = wf_check_sel()
if ii_ret = 0 then
	
	wf_calcola_esi_disp()
	
	tab_1.tabpage_1.dw_scorta_art_gd.retrieve()
	
	
	
	
	
	
	
	
end if
end subroutine

public function integer wf_calcola_storico_cliente ();
string		ls_where, ls_sql

if il_idart = 0 then
	return -1
end if

il_idsc = dw_selezioni.getitemnumber(1, "id_sogcom")	

if il_idsc = 0 or isnull(il_idsc) then 
	return -1
end if	

ls_where = " (riga_documento.id_articolo = "+string(il_idart)+" )"

ls_where = ls_where + " AND (documento.id_sog_commerciale = "+string(il_idsc)+")"

if is_regcli = "N" then
	ls_where = ls_where + " AND (registro.tipo_registro = '"+string(is_selcli)+"')"
end if	

iuo_sc_stor.f_reset_cur_as_ini()

iuo_sc_stor.f_add_where_condition(ls_where)

ls_sql = iuo_sc_stor.f_getcurrent()

tab_1.tabpage_7.dw_storico_cli_for_lt.object.datawindow.table.select = ls_sql

tab_1.tabpage_7.dw_storico_cli_for_lt.retrieve()
tab_1.tabpage_7.dw_storico_cli_for_lt.ScrollToRow(1)
tab_1.tabpage_7.dw_storico_cli_for_lt.event RowFocusChanged(1)

return 0

end function

public function integer uf_decod_mag ();

string		ls_dbc[], ls_dwc[], ls_dbv[]
string		ls_sql_cond
long			ll_ok

ls_sql_cond = ""
ls_dbc[1]=	"codice"
ls_dwc[1]=	"mag_cod"
ls_dbc[2]=	"descrizione"
ls_dwc[2]=	"mag_des"
ls_dbc[3]=	"id_magazzino"
ls_dwc[3]=	"id_magazzino"

ll_ok = dw_selezioni.uf_autofind_col ("id_magazzino","magazzino","id_magazzino", &
												  "N",string(il_idmag), ls_sql_cond,3, &
												  ls_dbc, ls_dbv, ls_dwc)

return 0

end function

public function integer uf_calc_pardisp ();

long ll_row

if not isNull(il_id_profilo_documento) then
	select max("par_disponibilita"."id_par_disponibilita")
		into :il_idpard
		from "dba"."par_disponibilita"
		where ("par_disponibilita"."id_prof_documento" = :il_id_profilo_documento ) and ("par_disponibilita"."id_azienda" =1)
		using SQLCA;
else
	select max("par_disponibilita"."id_par_disponibilita")
		into :il_idpard
		from "dba"."par_disponibilita"
		where ("par_disponibilita"."id_prof_documento" is null) and ("par_disponibilita"."id_azienda" =1)
	using SQLCA;	
end if

if SQLCA.SQLCode = -1 then 
	MessageBox("Errore nel database","Errore : "+ SQLCA.SQLErrText)
end if

return 0

end function

public subroutine wf_scorta_articolo ();
end subroutine

on w_sit_articolo_wz.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_esci=create cb_esci
this.dw_selezioni=create dw_selezioni
this.cb_mostra=create cb_mostra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_esci
this.Control[iCurrent+3]=this.dw_selezioni
this.Control[iCurrent+4]=this.cb_mostra
end on

on w_sit_articolo_wz.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_esci)
destroy(this.dw_selezioni)
destroy(this.cb_mostra)
end on

event open;call super::open;
long				ll_num, ll_row
string			ls_chiamata
s_list_main		lstr_list


iuo_scacq 	= create u_sql_scanner
iuo_scven 	= create u_sql_scanner
iuo_sc_stor	= create u_sql_scanner

ii_dwi 	= 1

is_selacq =		"IA" 						
is_selven =		"IV"
is_regacq =		"N"
is_regven =		"N"
is_regcli =		"S"

uf_iniz()

uf_calc_eser()

lstr_list	= Message.PowerObjectParm

ll_num 		= UpperBound(lstr_list.l_identifica)
ls_chiamata = lstr_list.s_win_parametri
ll_row 		= dw_selezioni.getRow()

SELECT "par_sistema"."conto_vis_scarico"
INTO :is_conto_vis_scar
FROM "par_sistema";



choose case ls_chiamata
	case "A"	
		
		if ll_num >= 1 then
			il_idart = lstr_list.l_identifica[1]
			uf_decod_art()
			
			wf_calcola_listini()
		end if
	case "S"	
		
		if ll_num >= 1 then
			il_idsc = lstr_list.l_identifica[1]
			uf_decod_sc()												
			dw_selezioni.SetItem(ll_row,"sc_state","P")		
		end if
	case "D"	
		
		if ll_num >= 3 then
			il_idart = lstr_list.l_identifica[1]
			il_idsc  = lstr_list.l_identifica[2]
			il_idmag = lstr_list.l_identifica[3]
			if UpperBound(lstr_list.s_par_name) > 0 then
				il_id_profilo_documento	= long(lstr_list.s_par_value[1])
			else
				SetNull(il_id_profilo_documento)
			end if
			
			uf_decod_all()

			
			
			
			

			wf_calcola_esi_disp()
			
			tab_1.tabpage_1.dw_scorta_art_gd.retrieve()
			
			wf_calcola_listini()
			
			
			
			
			
			
			
		end if
end choose

uf_calc_pardisp()

end event

event key;call super::key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>9 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=9
	end choose
	wf_dw_set_focus()
end if



end event

event close;call super::close;long ll_row

if isValid(iuo_scacq) then
	destroy (iuo_scacq)
end if

if isValid(iuo_scven) then
	destroy (iuo_scven)
end if

if isValid(iuo_sc_stor) then
	destroy (iuo_sc_stor)
end if

ll_row = dw_selezioni.getrow()
dw_selezioni.setitem(ll_row,"art_state","")
dw_selezioni.setitem(ll_row,"sc_state","")
dw_selezioni.setitem(ll_row,"mag_state","")
end event

type tab_1 from tab within w_sit_articolo_wz
int X=23
int Y=400
int Width=3095
int Height=980
int TabOrder=30
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_7 tabpage_7
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_7=create tabpage_7
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_7,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_7)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

type tabpage_1 from userobject within tab_1
int X=18
int Y=104
int Width=3058
int Height=860
long BackColor=79741120
string Text="Dati generali"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_esidisp dw_esidisp
dw_scorta_art_gd dw_scorta_art_gd
end type

on tabpage_1.create
this.dw_esidisp=create dw_esidisp
this.dw_scorta_art_gd=create dw_scorta_art_gd
this.Control[]={this.dw_esidisp,&
this.dw_scorta_art_gd}
end on

on tabpage_1.destroy
destroy(this.dw_esidisp)
destroy(this.dw_scorta_art_gd)
end on

type dw_esidisp from u_dw_master_main within tabpage_1
int X=9
int Y=16
int Width=1810
int Height=480
int TabOrder=3
string DataObject="d_sit_art_esidisp_ff"
end type

type dw_scorta_art_gd from u_dw_master_main within tabpage_1
int X=1829
int Y=16
int Width=1221
int Height=480
int TabOrder=12
boolean BringToTop=true
string DataObject="d_scorta_art_gd"
boolean VScrollBar=true
end type

event sqlpreview;
string	   ls_sqlsyntax

setnull(ls_sqlsyntax)

if (il_idart =0) then
	
else
	ls_sqlsyntax = " AND articolo.id_articolo = " + string(il_idart)
   if (not isnull(il_idmag) and il_idmag > 0) then
		ls_sqlsyntax = ls_sqlsyntax + " AND scorta.id_magazzino = " + string(il_idmag)
	end if	
end if

if not isnull(ls_sqlsyntax) then
	ls_sqlsyntax = sqlsyntax + ls_sqlsyntax
	this.setSQLpreview(ls_sqlsyntax)
end if
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=3058
int Height=860
long BackColor=79741120
string Text="Storico Acquisti"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_filtroacq dw_filtroacq
dw_sitacq dw_sitacq
end type

on tabpage_2.create
this.dw_filtroacq=create dw_filtroacq
this.dw_sitacq=create dw_sitacq
this.Control[]={this.dw_filtroacq,&
this.dw_sitacq}
end on

on tabpage_2.destroy
destroy(this.dw_filtroacq)
destroy(this.dw_sitacq)
end on

type dw_filtroacq from u_dw_ext_main within tabpage_2
int X=5
int Y=16
int Width=2958
int Height=128
int TabOrder=41
string DataObject="d_sit_art_filtro_ex"
end type

event ue_key;call super::ue_key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if


end event

event itemchanged;long		ll_row
string	ls_nomecol

ls_nomecol = dwo.name
choose case ls_nomecol
	case "tipo_registro"
		is_selacq 	= data
	case "tutti_reg"
		this.SetItem( row,"tipo_registro",u_freddie.gs_null )
		is_regacq	= data

end choose
wf_calcola_stor_acq()


end event

event ue_init;call super::ue_init;string		ls_valori


ls_valori = "Preventivi Acquisti~tPA/"
ls_valori += "Ordini Acquisti~tOA/"
ls_valori += "DDT Acquisti~tDA/"
ls_valori += "IVA Acquisti~tIA/"
ls_valori += "Liste Prelievo Acquisti~tLA/"
ls_valori += "Generico Acquisti~tGA"

this.Object.tipo_registro.Values = ls_valori

end event

event getfocus;call super::getfocus;ii_dwi=3
end event

event clicked;call super::clicked;if dwo.name="cb_esegui" then wf_calcola_stor_acq()
	

end event

type dw_sitacq from u_dw_ext_main within tabpage_2
int X=5
int Y=156
int Width=2958
int Height=660
int TabOrder=2
string DataObject="d_sit_art_mov_ex"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_key;call super::ue_key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if

end event

event getfocus;call super::getfocus;ii_dwi=4
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)

end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=3058
int Height=860
long BackColor=79741120
string Text="Storico Vendite"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_sitven dw_sitven
dw_filtroven dw_filtroven
end type

on tabpage_3.create
this.dw_sitven=create dw_sitven
this.dw_filtroven=create dw_filtroven
this.Control[]={this.dw_sitven,&
this.dw_filtroven}
end on

on tabpage_3.destroy
destroy(this.dw_sitven)
destroy(this.dw_filtroven)
end on

type dw_sitven from u_dw_ext_main within tabpage_3
int X=5
int Y=156
int Width=2958
int Height=660
int TabOrder=3
string DataObject="d_sit_art_mov_ex"

boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_key;call super::ue_key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if

end event

event getfocus;call super::getfocus;ii_dwi=6
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)

end event

type dw_filtroven from u_dw_ext_main within tabpage_3
int X=5
int Y=16
int Width=2958
int Height=128
string DataObject="d_sit_art_filtro_ex"
end type

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if


end event

event itemchanged;
long		ll_row
string	ls_nomecol

ls_nomecol = dwo.name
choose case ls_nomecol
	case "tipo_registro"
		is_selven 	= data
	case "tutti_reg"
		this.SetItem( row,"tipo_registro",u_freddie.gs_null )
		
		is_regven	= data
end choose
wf_calcola_stor_ven()




end event

event ue_init;call super::ue_init;string		ls_valori


ls_valori = "Preventivi Vendite~tPV/"
ls_valori += "Ordini Vendite~tOV/"
ls_valori += "DDT Vendite~tDV/"
ls_valori += "IVA Vendite~tIV/"
ls_valori += "Liste Prelievo Vendite~tLV/"
ls_valori += "Generico Vendite~tGV"

this.Object.tipo_registro.Values = ls_valori

end event

event getfocus;call super::getfocus;ii_dwi=5
end event

event clicked;call super::clicked;if dwo.name="cb_esegui" then  wf_calcola_stor_ven()
end event

type tabpage_7 from userobject within tab_1
int X=18
int Y=104
int Width=3058
int Height=860
long BackColor=79741120
string Text="Storico Cli/For"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_storico_cli_for_lt dw_storico_cli_for_lt
dw_filtrocli dw_filtrocli
end type

on tabpage_7.create
this.dw_storico_cli_for_lt=create dw_storico_cli_for_lt
this.dw_filtrocli=create dw_filtrocli
this.Control[]={this.dw_storico_cli_for_lt,&
this.dw_filtrocli}
end on

on tabpage_7.destroy
destroy(this.dw_storico_cli_for_lt)
destroy(this.dw_filtrocli)
end on

type dw_storico_cli_for_lt from u_dw_ext_main within tabpage_7
int X=5
int Y=156
int Width=2953
int Height=660
int TabOrder=3
string DataObject="d_sit_art_mov_ex"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event getfocus;call super::getfocus;ii_dwi=8
end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if

end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)

end event

type dw_filtrocli from u_dw_ext_main within tabpage_7
int X=5
int Y=16
int Width=2953
int Height=128
int TabOrder=42
string DataObject="d_sit_art_filtro_ex"
end type

event itemchanged;call super::itemchanged;long		ll_row
string	ls_nomecol

ls_nomecol = dwo.name
choose case ls_nomecol
	case "tipo_registro"
		is_selcli 	= data
	case "tutti_reg"
		this.SetItem( row,"tipo_registro",u_freddie.gs_null )
		
		is_regcli	= data
end choose
wf_calcola_storico_cliente()

end event

event getfocus;call super::getfocus;ii_dwi=7
end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if

end event

event clicked;call super::clicked;if dwo.name="cb_esegui" then  wf_calcola_storico_cliente()
end event

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=3058
int Height=860
long BackColor=79741120
string Text="Prezzi validi"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_listino_var_base_articolo_lt dw_listino_var_base_articolo_lt
end type

on tabpage_4.create
this.dw_listino_var_base_articolo_lt=create dw_listino_var_base_articolo_lt
this.Control[]={this.dw_listino_var_base_articolo_lt}
end on

on tabpage_4.destroy
destroy(this.dw_listino_var_base_articolo_lt)
end on

type dw_listino_var_base_articolo_lt from u_dw_ext_main within tabpage_4
int X=5
int Y=36
int Width=3045
int Height=780
int TabOrder=2
string DataObject="d_lis_var_articolo_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_key;call super::ue_key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if


end event

event getfocus;call super::getfocus;ii_dwi=9
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)

end event

type tabpage_5 from userobject within tab_1
int X=18
int Y=104
int Width=3058
int Height=860
long BackColor=79741120
string Text="Sostituibile da:"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_sostituzione_gd dw_sostituzione_gd
end type

on tabpage_5.create
this.dw_sostituzione_gd=create dw_sostituzione_gd
this.Control[]={this.dw_sostituzione_gd}
end on

on tabpage_5.destroy
destroy(this.dw_sostituzione_gd)
end on

type dw_sostituzione_gd from u_dw_ext_main within tabpage_5
int X=5
int Y=36
int Width=2629
int Height=780
int TabOrder=3
string DataObject="d_sostituzione_gd"
end type

event doubleclicked;call super::doubleclicked;

long		ll_row, ll_idarts
string 	ls_cod, ls_des

integer ii_return

ll_row =	this.GetRow()
if ll_row>0 then
	ll_idarts = this.GetItemNumber(ll_row,"sostituzione_id_art_sostitutivo")
	ls_cod =	this.GetItemString(ll_row, "c_articolo_codice")
	ls_des =	this.GetItemString(ll_row, "c_articolo_descrizione")
	il_idart = ll_idarts
	
	ll_row = dw_selezioni.GetRow()
	dw_selezioni.SetItem (ll_row, "id_articolo", ll_idarts)
	dw_selezioni.SetItem (ll_row, "art_cod", ls_cod)
	dw_selezioni.SetItem (ll_row, "art_des", ls_des)
	
	
	cb_mostra.triggerevent(Clicked!)
end if
end event

event ue_key;call super::ue_key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if


end event

event constructor;call super::constructor;

tab_1.tabpage_5.dw_sostituzione_gd.Object.c_articolo_codice.Edit.displayonly = "yes"
tab_1.tabpage_5.dw_sostituzione_gd.Object.c_articolo_descrizione.Edit.displayonly = "yes"
tab_1.tabpage_5.dw_sostituzione_gd.Object.sostituzione_tipo_sostituzione.Edit.displayonly = "yes"
tab_1.tabpage_5.dw_sostituzione_gd.Object.sostituzione_quantita.Edit.displayonly = "yes"

end event

event getfocus;call super::getfocus;ii_dwi=10
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)

end event

type tabpage_6 from userobject within tab_1
int X=18
int Y=104
int Width=3058
int Height=860
long BackColor=79741120
string Text="Sostituisce"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_articoli_sostituiti_gd dw_articoli_sostituiti_gd
end type

on tabpage_6.create
this.dw_articoli_sostituiti_gd=create dw_articoli_sostituiti_gd
this.Control[]={this.dw_articoli_sostituiti_gd}
end on

on tabpage_6.destroy
destroy(this.dw_articoli_sostituiti_gd)
end on

type dw_articoli_sostituiti_gd from u_dw_ext_main within tabpage_6
int X=5
int Y=36
int Width=2638
int Height=780
int TabOrder=3
string DataObject="d_articoli_sostituiti_gd"
end type

event doubleclicked;call super::doubleclicked;

long		ll_row, ll_idarts
string 	ls_cod, ls_des

integer ii_return

ll_row =	this.GetRow()
if ll_row > 0 then
	ll_idarts = this.GetItemNumber(ll_row,"id_articolo")
	ls_cod =	this.GetItemString(ll_row, "c_articolo_codice")
	ls_des =	this.GetItemString(ll_row, "c_articolo_descrizione")
	il_idart = ll_idarts
	
	ll_row = dw_selezioni.GetRow()
	dw_selezioni.SetItem (ll_row, "id_articolo", ll_idarts)
	dw_selezioni.SetItem (ll_row, "art_cod", ls_cod)
	dw_selezioni.SetItem (ll_row, "art_des", ls_des)
	
	
	cb_mostra.triggerevent(Clicked!)
end if

end event

event ue_key;call super::ue_key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if


end event

event constructor;call super::constructor;

tab_1.tabpage_6.dw_articoli_sostituiti_gd.Object.c_articolo_codice.Edit.displayonly = "yes"
tab_1.tabpage_6.dw_articoli_sostituiti_gd.Object.c_articolo_descrizione.Edit.displayonly = "yes"
tab_1.tabpage_6.dw_articoli_sostituiti_gd.Object.sostituzione_tipo_sostituzione.Edit.displayonly = "yes"
tab_1.tabpage_6.dw_articoli_sostituiti_gd.Object.sostituzione_quantita.Edit.displayonly = "yes"

end event

event getfocus;call super::getfocus;ii_dwi=11
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)

end event

type cb_esci from commandbutton within w_sit_articolo_wz
int X=2857
int Y=32
int Width=261
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)
end event

type dw_selezioni from u_dw_ext_main within w_sit_articolo_wz
int X=37
int Y=32
int Width=2757
int Height=340
int TabOrder=10
string DataObject="d_sel_sit_art_ex"
end type

event ue_set_search;call super::ue_set_search;Choose case as_nomecol
	case "art_cod"
		is_search_window = "w_articolo_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol           
		is_ricpar.s_filter_name  = "articolo_codice"  
	case "art_des"
		is_search_window = "w_articolo_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "articolo_descrizione"    
	case "sc_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "codice"         
	case "sc_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "rag_soc_1"    
	case "mag_cod"
		is_search_window = "w_magazzino_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "codice"         
	case "mag_des"
		is_search_window = "w_magazzino_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "descrizione"     
end choose			
end event

event ue_use_search;Choose case as_nomecol
	case "art_cod"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_articolo", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("art_des", is_ricpar.s_ausil_value[1])
		
 	case "art_des"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_articolo", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("art_cod", is_ricpar.s_ausil_value[1])
		
	case "sc_cod"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_sogcom", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("sc_des", is_ricpar.s_ausil_value[1])
		il_idsc = long(is_ricpar.s_id_seg_value[1])	
		
 	case "sc_des"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_sogcom", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("sc_cod", is_ricpar.s_ausil_value[1])
		il_idsc = long(is_ricpar.s_id_seg_value[1])	
			
	case "mag_cod"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_magazzino", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("mag_des", is_ricpar.s_ausil_value[1])
		
 	case "mag_des"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_magazzino", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("mag_cod", is_ricpar.s_ausil_value[1])
end choose
		
	
end event

event itemchanged;call super::itemchanged;

string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long		ll_ok

choose case dwo.name
		
		
	
	case 'art_cod'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"art_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"art_des"
		ls_dbc[3]=	"id_articolo"
		ls_dwc[3]=	"id_articolo"
		
		ll_ok = uf_autofind_col(dwo.name,"articolo","codice","A",data,&
		                                ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		if ll_ok>0 then
			return 2
		end if

	case 'art_des'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"art_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"art_des"
		ls_dbc[3]=	"id_articolo"
		ls_dwc[3]=	"id_articolo"

		ll_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		if ll_ok>0 then
			return 2
		end if

	
	case 'sc_cod'
		
		ls_sql_cond=""
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"sc_cod"
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"sc_des"
		ls_dbc[3]=	"id_sog_commerciale"
		ls_dwc[3]=	"id_sogcom"

		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","codice",& 
		                         "A", data, ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
										 
		if ll_ok>0 then
			return 2
		end if
		
		
	 case 'sc_des'
		
		ls_sql_cond=""
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"sc_cod"
		
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"sc_des"
		
		ls_dbc[3]=	"id_sog_commerciale"
		ls_dwc[3]=	"id_sogcom"

		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)

		if ll_ok>0 then
			return 2
		end if

	case 'mag_cod'
		
		ls_sql_cond=""
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"mag_cod"
		
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"mag_des"
		
		ls_dbc[3]=	"id_magazzino"
		ls_dwc[3]=	"id_magazzino"

		ll_ok = uf_autofind_col(dwo.name,"magazzino","codice",& 
		                         "A", data, ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		if ll_ok>0 then
			return 2
		end if
		

	case 'mag_des'
		
		ls_sql_cond=""
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"mag_cod"
		
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"mag_des"
		
		ls_dbc[3]=	"id_magazzino"
		ls_dwc[3]=	"id_magazzino"

		ll_ok = uf_autofind_col(dwo.name,"magazzino","descrizione",& 
		                         "A", data, ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		
		if ll_ok>0 then
			return 2
		end if
		
end choose

end event

event ue_key;call super::ue_key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if


end event

event getfocus;call super::getfocus;ii_dwi = 1


end event

type cb_mostra from commandbutton within w_sit_articolo_wz
int X=2857
int Y=156
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Mostra"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

wf_calcola_tutto()
ii_dwi = 2
wf_dw_set_focus()

end event

