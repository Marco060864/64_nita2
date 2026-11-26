forward
global type w_scorta_minima_wz from w_wiz_main
end type
type tab_1 from tab within w_scorta_minima_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_sel2 from u_dw_ext_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tabella from u_dw_ext_main within tabpage_2
end type
type cb_1 from commandbutton within w_scorta_minima_wz
end type
type cb_2 from commandbutton within w_scorta_minima_wz
end type
type cb_4 from commandbutton within w_scorta_minima_wz
end type
type cb_5 from commandbutton within w_scorta_minima_wz
end type
type tabpage_1 from userobject within tab_1
dw_sel2 dw_sel2
end type
type tabpage_2 from userobject within tab_1
dw_tabella dw_tabella
end type
type tab_1 from tab within w_scorta_minima_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_scorta_minima_wz from w_wiz_main
int Width=2715
int Height=1888
boolean TitleBar=true
string Title="Variazione/Inserimento Scorta Minima"
long BackColor=80133307
tab_1 tab_1
cb_1 cb_1
cb_2 cb_2
cb_4 cb_4
cb_5 cb_5
end type
global w_scorta_minima_wz w_scorta_minima_wz

type variables
u_sql_scanner	iu_scan1, iu_scan2, iu_sct
w_wait_01	iw_wait
s_azione_listino	istr_az
integer		ii_dwi
decimal		idc_cambio1, idc_cambio2

end variables

forward prototypes
public subroutine wf_unita_base (long ll_row)
end prototypes

public subroutine wf_unita_base (long ll_row);Long ll_id_unita_confezione, ll_id_articolo
String ls_codice
			
ll_id_articolo = tab_1.tabpage_2.dw_tabella.GetItemNumber(ll_row, "articolo_id_articolo")
			
SELECT id_unita_confezione, codice
INTO 	 :ll_id_unita_confezione, :ls_codice
FROM	 unita_confezione
WHERE	 id_articolo = :ll_id_articolo
AND	 unita_base = 'S'
;
			
CHOOSE CASE SQLCA.SQLCODE 
	CASE -1
		messagebox("", SQLCA.SQLERRTEXT)
	CASE 0
		tab_1.tabpage_2.dw_tabella.SetItem(ll_row, "scorta_id_unita_confezione", ll_id_unita_confezione)
		tab_1.tabpage_2.dw_tabella.SetItem(ll_row, "c_unita_confezione_cod", ls_codice)					
END CHOOSE 			
end subroutine

event close;call super::close;destroy iu_scan1
destroy iu_scan2
destroy iu_sct
end event

event closequery;
end event

event open;call super::open;long					ll_row
DataWindowChild	dwc_drop
string				ls_sql

iu_scan1 = create u_sql_scanner
iu_scan2 = create u_sql_scanner
iu_sct = create u_sql_scanner

tab_1.tabpage_2.dw_tabella.SetTransObject(SQLCA)
ls_sql = tab_1.tabpage_2.dw_tabella.object.datawindow.table.select
iu_sct.f_setinitial(ls_sql)
iu_sct.f_setcurrent(ls_sql)

tab_1.tabpage_1.dw_sel2.event ue_insert()
tab_1.tabpage_1.dw_sel2.event ue_post_open()



end event

on w_scorta_minima_wz.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
end on

on w_scorta_minima_wz.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_5)
end on

event ue_post_open;call super::ue_post_open;datawindowchild ldw_mag, ldw_per_scorta
tab_1.tabpage_1.dw_sel2.GetChild("id_magazzino", ldw_mag)
tab_1.tabpage_1.dw_sel2.GetChild("id_per_scorta", ldw_per_scorta)
tab_1.tabpage_1.dw_sel2.accepttext()


ldw_mag.settransobject(sqlca)
ldw_mag.retrieve()

ldw_per_scorta.settransobject(sqlca)
ldw_per_scorta.retrieve()

tab_1.tabpage_1.dw_sel2.setfocus()
end event

type tab_1 from tab within w_scorta_minima_wz
int X=37
int Y=176
int Width=2597
int Height=1564
int TabOrder=10
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
int X=18
int Y=104
int Width=2560
int Height=1444
long BackColor=80133307
string Text="Selezioni"
long TabBackColor=80133307
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_sel2 dw_sel2
end type

on tabpage_1.create
this.dw_sel2=create dw_sel2
this.Control[]={this.dw_sel2}
end on

on tabpage_1.destroy
destroy(this.dw_sel2)
end on

type dw_sel2 from u_dw_ext_main within tabpage_1
int X=18
int Y=28
int Width=2482
int Height=1084
int TabOrder=20
boolean BringToTop=true
string DataObject="d_sel_scorta_2_wz"
end type

event itemchanged;
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc,ls_tipo,ls_null
date			ld_data_inizio
long			ll_a, ll_ok, ll_row, ll_scode,ll_valuta,ll_null

DataWindowChild	dwc_drop
string				ls_sql, ls_add
setnull(ll_null)
setnull(ls_null)

ll_row = GetRow()
if ll_row > 0 then

	choose case dwo.name
			
			
		

      CASE 'cod_art1'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art1"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art1"
			ls_dbc[3] = "codice"
			ls_dwc[3] = "cod_art2"
			ls_dbc[4] = "descrizione"
			ls_dwc[4] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"codice", "A", data, & 
											ls_sql_cond, 4, &
											ls_dbc, ls_dbv, ls_dwc)
											
											
											
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE 'des_art1'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art1"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art1"
			ls_dbc[3] = "codice"
			ls_dwc[3] = "cod_art2"
			ls_dbc[4] = "descrizione"
			ls_dwc[4] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 4, &
											ls_dbc, ls_dbv, ls_dwc)
																			
							
							
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		


      CASE 'cod_art2'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art2"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"codice", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE 'des_art2'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art2"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

	END CHOOSE
END IF

end event

event ue_set_search;

choose case as_nomecol
	case "cod_art1", "cod_art2"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
	case "des_art1", "des_art2"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		
end choose

end event

event ue_use_search;

choose case as_nomecol
	case "cod_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_art1", is_ricpar.s_ausil_value[1])
		
		
		
		
	case "des_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_art1", is_ricpar.s_ausil_value[1])
		
		
		
		
	case "cod_art2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_art2", is_ricpar.s_ausil_value[1])
	case "des_art2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_art2", is_ricpar.s_ausil_value[1])


end choose

end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2560
int Height=1444
long BackColor=80133307
string Text="Risultati"
long TabBackColor=80133307
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_tabella dw_tabella
end type

on tabpage_2.create
this.dw_tabella=create dw_tabella
this.Control[]={this.dw_tabella}
end on

on tabpage_2.destroy
destroy(this.dw_tabella)
end on

type dw_tabella from u_dw_ext_main within tabpage_2
int X=14
int Y=20
int Width=2528
int Height=1404
int TabOrder=11
boolean BringToTop=true
string DataObject="d_scorta_aut_risult_gd"
boolean VScrollBar=true
end type

event ue_set_search;long ll_row, ll_id_articolo

CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
			
	CASE "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = uf_get_colval("articolo_descrizione")
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	CASE "c_unita_confezione_cod"
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "articolo_id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_codice"
END CHOOSE
end event

event ue_use_search;Integer li_row

CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("articolo_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("scorta_id_unita_confezione", is_ricpar.s_id_seg_value[2])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
				
		li_row = This.GetRow()
		wf_unita_base(li_row)
		
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("articolo_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("scorta_id_unita_confezione", is_ricpar.s_id_seg_value[2])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
				
		li_row = This.GetRow()
		wf_unita_base(li_row)
		
	CASE "c_unita_confezione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("scorta_id_unita_confezione", is_ricpar.s_id_seg_value[1])		
END CHOOSE
end event

event itemchanged;integer li_ok
long ll_id_articolo, ll_row
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	
	CASE 'articolo_codice'
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		
		ls_dwc[1] = "articolo_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		wf_unita_base(row)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'articolo_descrizione'
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		
		ls_dwc[1] = "articolo_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"

		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, &
			3, ls_dbc, ls_dbv, ls_dwc)
			
		wf_unita_base(row)			

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_unita_confezione_cod'
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "articolo_id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		ls_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		ls_dbc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"

		ls_dwc[1] = "scorta_id_unita_confezione"
		ls_dwc[2] = "c_unita_confezione_cod"

		li_ok = uf_autofind_col(dwo.Name, "unita_confezione", "codice", "A", data, &
			ls_sql_cond, 2, ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE
end event

event updatestart;
end event

event retrieverow;long ll_row, ll_id_magazzino, ll_id_per_scorta, ll_id_mag, ll_id_ps
decimal {4} ld_scorta
string ls_voci
boolean lb_ok

ll_row = tab_1.tabpage_1.dw_sel2.getrow()
ld_scorta = tab_1.tabpage_1.dw_sel2.getitemdecimal(ll_row,"valore")
ll_id_magazzino  = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row, "id_magazzino")
ll_id_per_scorta = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row, "id_per_scorta")


if not isnull(ld_scorta) then this.setitem(row,"scorta_scorta_minima",ld_scorta)

ls_voci = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"sn_voci")

lb_ok = true
ll_id_mag = this.getitemnumber(row, "scorta_id_magazzino")
ll_id_ps  = this.getitemnumber(row, "scorta_id_per_scorta")


if isnull(ll_id_mag) then lb_ok = false
if isnull(ll_id_ps)  then lb_ok = false
if ll_id_mag <> ll_id_magazzino then lb_ok = false
if ll_id_ps <> ll_id_per_scorta then lb_ok = false


if lb_ok = false then 
	if ls_voci = 'S' then
		this.setitemstatus(row,0,primary!,newmodified!)
	end if
end if

end event

type cb_1 from commandbutton within w_scorta_minima_wz
int X=37
int Y=28
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="ESCI"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_scorta_minima_wz
int X=2043
int Y=28
int Width=261
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="INSERISCI"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_insert")
end event

type cb_4 from commandbutton within w_scorta_minima_wz
int X=2350
int Y=28
int Width=247
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="SALVA"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
long ll_totrows, ll_id_magazzino, ll_id_per_scorta, ll_row, ll_id_uc, ll_id_scorta, ll_id_azienda
decimal ld_valore, ld_scorta_massima

ll_id_azienda = 1
ld_scorta_massima = 99999
tab_1.tabpage_2.dw_tabella.accepttext()
ll_totrows = tab_1.tabpage_2.dw_tabella.rowcount()
ll_row = tab_1.tabpage_1.dw_sel2.getrow()
ll_id_magazzino  = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row, "id_magazzino")
if isnull(ll_id_magazzino) then
	messagebox("ATTENZIONE!","Non è stato definito un magazzino")
	return 0
end if
ll_id_per_scorta = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row, "id_per_scorta")
if isnull(ll_id_per_scorta) then
	messagebox("ATTENZIONE!","Non è stato definito un periodo di scorta")
	return 0
end if

FOR i=1 TO ll_totrows
	tab_1.tabpage_2.dw_tabella.setitem(i,"scorta_id_per_scorta",ll_id_per_scorta) 
	tab_1.tabpage_2.dw_tabella.setitem(i,"scorta_id_magazzino",ll_id_magazzino)	
	tab_1.tabpage_2.dw_tabella.setitem(i,"scorta_id_azienda",1)		
	ll_id_uc = tab_1.tabpage_2.dw_tabella.getitemnumber(i,"scorta_id_unita_confezione")
	if isnull(ll_id_uc) then 
		ll_id_uc = tab_1.tabpage_2.dw_tabella.getitemnumber(i,"unita_confezione_id_unita_confezione")
		tab_1.tabpage_2.dw_tabella.setitem(i,"scorta_id_unita_confezione",ll_id_uc)
	end if
	
	ll_id_scorta = tab_1.tabpage_2.dw_tabella.getitemnumber(i,"scorta_id_scorta")
	ld_valore = tab_1.tabpage_2.dw_tabella.getitemdecimal(i,"scorta_scorta_minima")
	if not isnull(ll_id_scorta) then
		UPDATE scorta 
		SET scorta_minima = :ld_valore
		WHERE id_scorta  = :ll_id_scorta;	
		
		
	else
		select max(id_scorta)
		into :ll_id_Scorta
		from scorta
		where id_magazzino = :ll_id_magazzino
		and id_per_scorta = :ll_id_per_scorta
		and id_unita_confezione = :ll_id_uc
		and id_azienda = :ll_id_azienda; 
		if sqlca.sqlcode <> 0 or isnull(ll_id_Scorta) then
			INSERT INTO scorta (id_per_scorta, id_magazzino, id_unita_confezione, scorta_minima, id_azienda, scorta_massima)
			VALUES (:ll_id_per_scorta, :ll_id_magazzino, :ll_id_uc, :ld_valore, :ll_id_azienda, :ld_scorta_massima) ;
			
		else
			UPDATE scorta 
			SET scorta_minima = :ld_valore
			WHERE id_scorta  = :ll_id_scorta;				
		end if
		
	end if
NEXT

commit;



end event

type cb_5 from commandbutton within w_scorta_minima_wz
int X=1728
int Y=28
int Width=261
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="PROCEDI"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_da_art, ls_a_art, ls_voci, ls_filter
long ll_row, ll_id_magazzino, ll_id_per_scorta
decimal {4} ld_scorta

ll_row = tab_1.tabpage_1.dw_sel2.getrow()
ls_da_art = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"cod_art1")
ls_a_art  = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"cod_art2")
ld_scorta = tab_1.tabpage_1.dw_sel2.getitemdecimal(ll_row,"valore")
ll_id_magazzino = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row,"id_magazzino")
ll_id_per_scorta = tab_1.tabpage_1.dw_sel2.getitemnumber(ll_row,"id_per_scorta")

if isnull(ll_id_magazzino) then
	messagebox("ATTENZIONE!","Non è stato definito un magazzino")
	return 0
end if
if isnull(ll_id_per_scorta) then
	messagebox("ATTENZIONE!","Non è stato definito un periodo di scorta")
	return 0
end if
tab_1.tabpage_2.dw_tabella.reset()
tab_1.tabpage_2.dw_tabella.retrieve(ls_da_art,ls_a_art,ll_id_magazzino,ll_id_per_scorta)

ls_voci = tab_1.tabpage_1.dw_sel2.getitemstring(ll_row,"sn_voci")
if ls_voci = 'N' then
	ls_filter = "scorta_id_magazzino = " + string(ll_id_magazzino) + " and scorta_id_per_scorta = " + string(ll_id_per_scorta)
	tab_1.tabpage_2.dw_tabella.setfilter(ls_filter)
	tab_1.tabpage_2.dw_tabella.filter()
else
	ls_filter = ""
	tab_1.tabpage_2.dw_tabella.setfilter(ls_filter)
	tab_1.tabpage_2.dw_tabella.filter()	
end if

tab_1.tabpage_2.dw_tabella.setfocus()
end event

