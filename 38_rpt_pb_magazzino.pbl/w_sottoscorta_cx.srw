forward
global type w_sottoscorta_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_sottoscorta_cx
end type
type tab_1 from tab within w_sottoscorta_cx
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from u_dw_ext_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from datawindow within tabpage_3
end type
type cb_meno from commandbutton within tabpage_3
end type
type cb_selziona from commandbutton within tabpage_3
end type
type cb_piu from commandbutton within tabpage_3
end type
type em_varia_qta from editmask within tabpage_3
end type
type cb_1 from commandbutton within tabpage_3
end type
type cb_elimina from commandbutton within tabpage_3
end type
type dw_4 from datawindow within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
cb_2 cb_2
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
cb_meno cb_meno
cb_selziona cb_selziona
cb_piu cb_piu
em_varia_qta em_varia_qta
cb_1 cb_1
cb_elimina cb_elimina
dw_4 dw_4
st_1 st_1
end type
type tab_1 from tab within w_sottoscorta_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_sottoscorta_cx from w_wiz_main
int X=434
int Y=348
int Width=3264
int Height=1672
WindowType WindowType=response!
boolean TitleBar=true
string Title="Variazione dati Articolo"
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
tab_1 tab_1
end type
global w_sottoscorta_cx w_sottoscorta_cx

type variables
DataWindow idw_source, idw_target,idw_modifica
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
Decimal idc_imp_max_distinta
integer li_status

end variables

forward prototypes
public subroutine wf_multisel (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg)
end prototypes

public subroutine wf_multisel (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg);long i, ll_righe, ll_row
string ls_filter,ls_sql
boolean lb_filter




if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
   
		ll_righe=adw_origine.RowCount()
		ll_row=row
		
		for i = 1 to ll_righe
			if i=ll_row then continue
			if adw_origine.IsSelected(i) then adw_origine.SelectRow(i,false)
		next

	
	adw_origine.SelectRow(ll_row, not (adw_origine.isselected(ll_row)))
	if adw_origine=tab_1.tabpage_3.dw_3 then
		if adw_origine.isselected(ll_row) then 
			lb_filter=true 
		else 
			lb_filter=false	
		end if
	else
		lb_filter=false
	end if
	
elseif KeyDown(KeyShift!) then
		ll_row=row
		adw_origine.SelectRow(ll_row,true)
		ll_righe=adw_origine.RowCount()
		ll_row=ll_righe
		
		for i= 1 to ll_row
			if adw_origine.IsSelected(i) then ll_row=i
		next
		
		for i=ll_row+1 to ll_righe
			if adw_origine.IsSelected(i) then ll_righe=i
		next
		
		for i = ll_row to ll_righe
			adw_origine.SelectRow(i,true)
			if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '					
		next
	elseif KeyDown(KeyControl!) then
		
		ll_row=row
		adw_origine.SelectRow(ll_row,Not adw_origine.IsSelected(ll_row))
		
		ll_righe=adw_origine.RowCount()
		for i = 1 to ll_righe
			if adw_origine.IsSelected(i) then
				if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '	
			end if
		next
end if
end subroutine

on w_sottoscorta_cx.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.tab_1
end on

on w_sottoscorta_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.tab_1)
end on

event open;call super::open;

string maxcod,mincod,maxdes,mindes
long ll_select

tab_1.tabpage_2.dw_2.settransobject(sqlca)
tab_1.tabpage_3.dw_4.settransobject(sqlca)
tab_1.tabpage_3.dw_3.settransobject(sqlca)
tab_1.tabpage_3.dw_4.insertrow(0)



tab_1.tabpage_1.dw_1.insertrow(1)




tab_1.tabpage_1.dw_1.setitem(1,'a_data',Today())

long 		ll_id_magazzino
string	ls_cod_magazzino

SELECT p.id_magazzino, m.codice
INTO	 :ll_id_magazzino, :ls_cod_magazzino
FROM	 par_sistema p, magazzino m
WHERE  m.id_magazzino = p.id_magazzino
;

if (ll_id_magazzino > 0) then 
	tab_1.tabpage_1.dw_1.setitem(1, "id_locazione", ll_id_magazzino)
	tab_1.tabpage_1.dw_1.setitem(1, "locazione", ls_cod_magazzino)
end if


li_status=1
end event

type cb_chiudi from commandbutton within w_sottoscorta_cx
int X=2880
int Y=16
int Width=270
int Height=88
int TabOrder=10
string Text="Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type tab_1 from tab within w_sottoscorta_cx
event create ( )
event destroy ( )
int X=18
int Y=112
int Width=3182
int Height=1440
int TabOrder=20
boolean RaggedRight=true
Alignment Alignment=Center!
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
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;date 		ld_data
long 		ll_locazione, ll_anno, ll_mese, ll_giorno, ll_primo, ll_secondo
string 	ls_da_articolo,ls_a_articolo
long  	ll_id_prof_doc, ll_magazzino, ll_id_art, ll_qta
string 	dw_filter, ls_locazione
integer  ll_row, i, li_ret


string	ls_parametri

if newindex=1 and (oldindex=2 or oldindex=3) then li_status=0
	  

if newindex=2 and oldindex=1 then
	
	tab_1.tabpage_3.dw_3.reset()
	tab_1.tabpage_1.dw_1.accepttext()
			
	ls_da_articolo=tab_1.tabpage_1.dw_1.getitemstring(1,"da_articolo")
	ls_a_articolo=tab_1.tabpage_1.dw_1.getitemstring(1,"a_articolo")
	

	ld_data=tab_1.tabpage_1.dw_1.getitemdate(1,"a_data")
	ll_locazione=tab_1.tabpage_1.dw_1.getitemnumber(1,"id_locazione")
	ls_locazione=tab_1.tabpage_1.dw_1.getitemstring(1,"locazione")
			
			
	if isnull(ld_data) then
		messagebox("Sottoscorta","La data non può essere nulla",exclamation!)
		tab_1.SelectTab ( 1 )
		return
	end if

	
			


	
			
		    
	if li_status<>1 then return
			 
	ll_anno=year(ld_data)
	ll_mese=Month (ld_data)
	ll_giorno=Day(ld_data)

	
	

	ls_parametri = ""
	
	if (not isnull(ls_da_articolo) and ls_da_articolo <> '') then &
		ls_parametri = ls_parametri + "Da Articolo:" + ls_da_articolo + "  -  "
		
	if (not isnull(ls_a_articolo) and ls_a_articolo <> '') then &
		ls_parametri = ls_parametri + " A Articolo:" + ls_a_articolo + "  -  "
		
	if (not isnull(ls_locazione) and ls_locazione <> '') then &
		ls_parametri = ls_parametri + " Magazzino:" + ls_locazione + "  - "

	if (ll_locazione > 0) then
		li_ret=tab_1.tabpage_2.dw_2.Retrieve(ls_parametri, ll_anno, ll_mese, ll_giorno, ll_locazione)
	else
		li_ret=tab_1.tabpage_2.dw_2.Retrieve(ls_parametri, ll_anno, ll_mese, ll_giorno, 0)
	end if
		
	
	if (li_ret > 0) then
		tab_1.tabpage_2.dw_2.SetSort("articolo_codice")
		tab_1.tabpage_2.dw_2.sort()
	end if
	

			
	if (tab_1.tabpage_1.dw_1.object.esi_negativa[1] = 'S') then
		dw_filter="sottoscorta <=0 and c_esistenza_fisica < 0"
		tab_1.tabpage_2.dw_2.setfilter(dw_filter)
		tab_1.tabpage_2.dw_2.filter()
	else
		dw_filter="sottoscorta <=0"
		tab_1.tabpage_2.dw_2.setfilter(dw_filter)
		tab_1.tabpage_2.dw_2.filter()
	end if		
	
end if

if newindex=3 then
long ll_conf, ll_sogg, ll_data
date ld_data_scad
   ll_row=tab_1.tabpage_3.dw_3.rowcount()
	if ll_row=0 then
		ll_row=tab_1.tabpage_2.dw_2.rowcount()
		tab_1.tabpage_2.dw_2.RowsCopy(1,ll_row,Primary!,tab_1.tabpage_3.dw_3,1,Primary!)
		if (ll_row > 0) then
			for i=1 to ll_row
				
				setnull(ll_data)
				ll_qta=(tab_1.tabpage_3.dw_3.getitemnumber(i,'sottoscorta')) * (- 1)
				tab_1.tabpage_3.dw_3.setitem(i,'c_ordinato',ll_qta)
				
				ll_conf=tab_1.tabpage_3.dw_3.getitemnumber(i,'id_unita_confezione')
				ll_sogg=tab_1.tabpage_3.dw_3.getitemnumber(i,'id_sog_commerciale')
				select giorni_consegna into :ll_data
				from approvvigionamento where id_sog_commerciale=:ll_sogg and id_unita_confezione=:ll_conf;
				ld_data_scad=today()
				if not isnull(ll_data) then ld_data_scad=relativedate(Today(),ll_data)
				tab_1.tabpage_3.dw_3.setitem(i,'data_scadenza',ld_data_scad)
				
			next	
		end if
	end if
end if

end event

event selectionchanging;string ls_aghi

ls_aghi=tab_1.tabpage_1.dw_1.getitemstring(1,"chk_aghi")

if ls_aghi='S' then
	tab_1.tabpage_2.dw_2.dataobject="d_st_sottoscorta2"	
	tab_1.tabpage_2.dw_2.settransobject(sqlca)
else
	tab_1.tabpage_2.dw_2.dataobject="d_st_sottoscorta"
	tab_1.tabpage_2.dw_2.settransobject(sqlca)
end if


end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3145
int Height=1320
long BackColor=79741120
string Text="Filtra"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_ext_main within tabpage_1
int X=73
int Y=76
int Width=2597
int Height=1132
int TabOrder=20
boolean BringToTop=true
string DataObject="d_filtra_sottoscorta_cx"
end type

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_null

setnull(ll_null)

choose case dwo.name
		
	
	case "locazione"
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_magazzino"		
		ls_dwc[1] = "id_locazione"
		
		li_ok = uf_autofind_col(dwo.Name, "magazzino", "id_magazzino", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
      
		
		
	case "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           This.SetItem(1, "a_articolo", Data)			
           This.SetItem(1, "a_articolo_des", This.GetItemString(1, "da_articolo_des"))	
	      end if
			RETURN 2
		END IF
		
		
	case "da_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
            This.SetItem(1, "a_articolo_des", Data)			
            This.SetItem(1, "a_articolo", This.GetItemString(1, "da_articolo"))	
	      end if
			RETURN 2
		END IF
		

	case "a_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	
	
	case "locazione"
		if isnull(data) then 
			this.setitem(1,"id_locazione",ll_null)
		else
		end if
		
end choose


li_status=1
end event

event ue_set_search;choose case as_nomecol
	case "da_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	case "da_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	case "a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	case "a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
		
	CASE "locazione"
		is_search_window = "w_magazzino_coddes_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	
		
end choose
end event

event ue_use_search;choose case as_nomecol
	case "da_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_des",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           uf_set_colval("a_articolo",is_ricpar.s_main_value)		
           uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])
	      end if

	case "da_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           uf_set_colval("a_articolo_des",is_ricpar.s_main_value)		
           uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
	      end if
			
	case "a_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])	
	case "a_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
	
	CASE "locazione"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_locazione", is_ricpar.s_id_seg_value[1])
		
	
end choose

li_status=1
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3145
int Height=1320
long BackColor=79741120
string Text="Visiona"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
cb_2 cb_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.Control[]={this.dw_2,&
this.cb_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.cb_2)
end on

type dw_2 from datawindow within tabpage_2
int X=14
int Y=128
int Width=3081
int Height=1164
int TabOrder=30
boolean BringToTop=true
string DataObject="d_st_sottoscorta"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;
string	ls_sqlsyntax
string	ls_da_articolo, ls_a_articolo

ls_da_articolo	= tab_1.tabpage_1.dw_1.getitemstring(1,"da_articolo")
ls_a_articolo	= tab_1.tabpage_1.dw_1.getitemstring(1,"a_articolo")

ls_sqlsyntax = sqlsyntax

if (not isnull(ls_da_articolo) and ls_da_articolo <> '') then
	ls_sqlsyntax =	ls_sqlsyntax + " AND articolo.codice >= '" + ls_da_articolo + "'"
end if

if (not isnull(ls_a_articolo) and ls_a_articolo <> '') then
	ls_sqlsyntax =	ls_sqlsyntax + " AND articolo.codice <= '" + ls_a_articolo + "'"
end if


setsqlpreview(ls_sqlsyntax)


end event

event retrieveend;
end event

type cb_2 from commandbutton within tabpage_2
int X=2857
int Y=24
int Width=247
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.print()
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3145
int Height=1320
long BackColor=79741120
string Text="Quantita"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_3 dw_3
cb_meno cb_meno
cb_selziona cb_selziona
cb_piu cb_piu
em_varia_qta em_varia_qta
cb_1 cb_1
cb_elimina cb_elimina
dw_4 dw_4
st_1 st_1
end type

on tabpage_3.create
this.dw_3=create dw_3
this.cb_meno=create cb_meno
this.cb_selziona=create cb_selziona
this.cb_piu=create cb_piu
this.em_varia_qta=create em_varia_qta
this.cb_1=create cb_1
this.cb_elimina=create cb_elimina
this.dw_4=create dw_4
this.st_1=create st_1
this.Control[]={this.dw_3,&
this.cb_meno,&
this.cb_selziona,&
this.cb_piu,&
this.em_varia_qta,&
this.cb_1,&
this.cb_elimina,&
this.dw_4,&
this.st_1}
end on

on tabpage_3.destroy
destroy(this.dw_3)
destroy(this.cb_meno)
destroy(this.cb_selziona)
destroy(this.cb_piu)
destroy(this.em_varia_qta)
destroy(this.cb_1)
destroy(this.cb_elimina)
destroy(this.dw_4)
destroy(this.st_1)
end on

type dw_3 from datawindow within tabpage_3
int Y=188
int Width=3109
int Height=1068
int TabOrder=40
boolean BringToTop=true
string DataObject="d_ordina_scorta_tab"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;


string ls_codice
long ll_id_sog_com, ll_id_articolo
integer li_ret

s_ric_param ls_ric_param
w_search_main lw_sm




if string(dwo.name)= "rag_soc_1_sw" then
	select pref_cod_fornitore
	into :ls_codice
	from par_sistema;
	ls_ric_param.s_filter_value=ls_codice
	ls_ric_param.s_filter_name="codice"
	ls_ric_param.i_height=this.GetItemNumber(row,"id_unita_confezione")
	ls_ric_param.i_width=this.GetItemNumber(row,"id_articolo")
	openwithparm(lw_sm,ls_ric_param,"w_sog_com_approv_sw")
	
	ls_ric_param=message.powerobjectparm
	if upperbound(ls_ric_param.s_id_seg_value)>0 then
		LL_id_sog_com=long(ls_ric_param.s_id_seg_value[1])
		ls_codice=ls_ric_param.s_ausil_value[1]
		li_ret=setitem(row, "rag_soc_1", ls_codice)
		setitem(row, "data_scadenza", relativedate(Today(),long(ls_ric_param.s_ausil_value[10])))
		if li_ret<>1 then messagebox("Errore!", "Setitem fallito codice fornitore")
		li_ret=setitem(row, "id_sog_commerciale", LL_id_sog_com)
		if li_ret<>1 then messagebox("Errore!", "Setitem fallito id_sog_commerciale")
		setsort("rag_soc_1")
		sort()
		groupcalc()
	end if
else
	if row>0 then
	  wf_multisel(row,this,"",this,"","")
   end if
end if	
end event

type cb_meno from commandbutton within tabpage_3
int X=2999
int Y=64
int Width=73
int Height=52
int TabOrder=30
boolean BringToTop=true
string Text="-"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
long ll_focus, ll_qta, ll_varia

ll_focus=dw_3.GetSelectedRow ( 0 )
if ll_focus=0 then 
	messagebox('Controllare','Nessuna linea è stata selezionata')
else
	ll_varia= integer(tab_1.tabpage_3.em_varia_qta.text)
	if ll_varia=0 or isnull(ll_varia) then
		messagebox('Controllare','La quantita da sottrarre è nulla')
	else	
		DO UNTIL ll_focus=0
	   	ll_qta=dw_3.getitemnumber(ll_focus,'c_ordinato')
			dw_3.setitem(ll_focus,'c_ordinato',ll_qta - ll_varia)
	   	ll_focus=dw_3.GetSelectedRow ( ll_focus )
   	LOOP
   end if
end if
end event

type cb_selziona from commandbutton within tabpage_3
int X=27
int Y=48
int Width=288
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Sel/Desel"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_focus

ll_focus=dw_3.GetSelectedRow ( 0 )
if ll_focus=0 then 
	dw_3.SelectRow ( 0, true )
else	
   dw_3.SelectRow ( 0, false )
end if	
end event

type cb_piu from commandbutton within tabpage_3
int X=2999
int Y=116
int Width=73
int Height=52
int TabOrder=40
boolean BringToTop=true
string Text="+"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
long ll_focus, ll_qta, ll_varia

ll_focus=dw_3.GetSelectedRow ( 0 )
if ll_focus=0 then 
	messagebox('Controllare','Nessuna linea è stata selezionata')
else
	ll_varia= integer(tab_1.tabpage_3.em_varia_qta.text)
	if ll_varia=0 or isnull(ll_varia) then
		messagebox('Controllare','La quantita da maggiorare è nulla')
	else	
		DO UNTIL ll_focus=0
	   	ll_qta=dw_3.getitemnumber(ll_focus,'c_ordinato')
			dw_3.setitem(ll_focus,'c_ordinato',ll_qta + ll_varia)
	   	ll_focus=dw_3.GetSelectedRow ( ll_focus )
   	LOOP
   end if
end if
end event

type em_varia_qta from editmask within tabpage_3
int X=2825
int Y=72
int Width=165
int Height=88
int TabOrder=30
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within tabpage_3
int X=745
int Y=48
int Width=434
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Componi ordine"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datastore ds_esplose
ds_esplose = create datastore
ds_esplose.Dataobject="d_ordini_riga_documento_gd"
ds_esplose.SetTransObject(sqlca)
long i, ll_row, ll_appoggio, ll_qta1, ll_primo, ll_secondo, ll_riga, ll_conto_pred, ll_id_tab_iva, ll_ret
string ls_appoggio, ls_tipo_iva
decimal ld_appoggio

keycode key

tab_1.tabpage_3.dw_3.accepttext()

ll_row=tab_1.tabpage_3.dw_3.rowcount()
if ll_row>0 then
for i= 1 to ll_row
 ll_primo=tab_1.tabpage_3.dw_3.getItemNumber(i,"id_sog_commerciale")
 ll_qta1=tab_1.tabpage_3.dw_3.getItemNumber(i,"c_ordinato")
	if IsNull(ll_primo) then
		messagebox('Attenzione!','Non è specificato nessun fornitore per la riga '+string(i)+'!'+char(13)+'Impossibile procedere!')
		
		dw_3.SelectRow ( 0, false )
		
		dw_3.SelectRow ( i, true )
		dw_3.setrow(i)
		return
	end if
	if IsNull(ll_qta1) or ll_qta1<=0 then
		messagebox('Attenzione!',"La quantita descritta nella riga "+string(i)+" non è un dato accettabile per procedere con l'ordine! ~r~nEliminre la riga o variare la quantita.")
		
		dw_3.SelectRow ( 0, false )
		
		dw_3.SelectRow ( i, true )
		dw_3.setrow(i)
		return
	end if
next




for i=1 to ll_row
ll_primo=0
ll_secondo=0
    DO UNTIL (ll_primo<>ll_secondo) or i>ll_row
         ll_riga=ds_esplose.insertrow(0)
	      ll_qta1=tab_1.tabpage_3.dw_3.getitemnumber(i,"c_ordinato")			
			
			ll_appoggio=tab_1.tabpage_3.dw_3.getitemnumber(i,"id_articolo")
			ds_esplose.setitem(i,"id_articolo",ll_appoggio)
			
			
			string	ls_tipo_mov
			SELECT m.tipo
			INTO	 :ls_tipo_mov
			FROM	 unita_confezione u, unita_misura m
			WHERE  u.id_articolo = :ll_appoggio
			AND	 unita_base = 'S'
			AND	 m.id_unita_misura = u.id_unita_misura 
			;
			
			if (ls_tipo_mov = 'P') then
				ds_esplose.setitem(ll_riga,"riga_documento_peso_netto",ll_qta1)
			else
				ds_esplose.setitem(ll_riga,"quantita",ll_qta1)
			end if
			
			
			ll_primo=tab_1.tabpage_3.dw_3.getitemnumber(i,"id_sog_commerciale")
			ds_esplose.setitem(ll_riga,"id_sog_commerciale",ll_appoggio)
			ls_appoggio=tab_1.tabpage_3.dw_3.getitemstring(i,"rag_soc_1")	
			ds_esplose.setitem(ll_riga,"rag_soc_1",ls_appoggio)
			ls_appoggio=tab_1.tabpage_3.dw_3.getitemstring(i,"articolo_codice")
			ds_esplose.setitem(ll_riga,"c_articolo_cod",ls_appoggio)
			ls_appoggio=tab_1.tabpage_3.dw_3.getitemstring(i,"articolo_descrizione")
			ds_esplose.setitem(ll_riga,"riga_documento_descrizione",ls_appoggio)
			
			select id_conto_predefinito
         into :ll_conto_pred
         from par_sistema;
	      ds_esplose.setitem(i,"riga_documento_id_conto",ll_conto_pred)
			
			

			SELECT "tab_iva"."tipo_iva", "tab_iva"."id_tab_iva"
			INTO :ls_tipo_iva, :ll_id_tab_iva
			FROM "dba"."sog_commerciale", "dba"."tab_iva"  
			WHERE ( "tab_iva"."id_tab_iva" = "sog_commerciale"."id_tab_iva" ) and  
					( ( "sog_commerciale"."id_sog_commerciale" = :ll_primo ) ) ;

			if ls_tipo_iva > '' then
				
				ds_esplose.setitem(i,"riga_documento_id_tab_iva",ll_id_tab_iva)
			else
				
				SELECT "articolo"."id_tab_iva"  
				INTO :ll_id_tab_iva  
				FROM "dba"."articolo"
				WHERE "articolo"."id_articolo" = :ll_appoggio ;

				if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
					
					SELECT "cat_com_articolo"."id_tab_iva"  
					INTO :ll_id_tab_iva  
					FROM "dba"."articolo",   
					"cat_com_articolo"  
					WHERE ( "cat_com_articolo"."id_cat_com_articolo" = "articolo"."id_cat_com_articolo" ) and  
						( ( "articolo"."id_articolo" = :ll_appoggio ) )   ;
				end if
				if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
						ds_esplose.setitem(i,"riga_documento_id_tab_iva",ll_id_tab_iva)
				end if
			end if
			
			
		   ll_appoggio=tab_1.tabpage_1.dw_1.getitemnumber(1,"id_locazione")
			if isnull(ll_appoggio) then
				select id_locazione
				into :ll_appoggio
		      from par_sistema;
			end if
			if isnull(ll_appoggio) then
			end if
			ds_esplose.setitem(ll_riga,"id_locazione_1",ll_appoggio)
		
			ll_appoggio=tab_1.tabpage_3.dw_3.getitemnumber(i,"id_unita_confezione")
			ds_esplose.setitem(ll_riga,"riga_documento_id_unita_confezione",ll_appoggio)
			


			
	

i=i + 1 
if i<=ll_row then ll_secondo=tab_1.tabpage_3.dw_3.getitemnumber(i,"id_sog_commerciale")
loop	
i=i -1


if key=keyEscape! then return 1





s_list_main ls_dati
long ll_group, ll_next_group,  ll_num_righe, ll_id_sog_com, k
long ll_id_riga_doc
w_documento_ordine_cx lw_doc
string ls_codice, ls_prod
date ld_data_scad
integer li_ant_scad, li_conta=0





		


			ls_dati.ds_righe_ordine = ds_esplose
			ll_id_sog_com=tab_1.tabpage_3.dw_3.getitemnumber(i,"id_sog_commerciale")
		      
				ld_data_scad=dw_4.getitemdate(1,"data_scad")
				
				if isnull(ld_data_scad) then ld_data_scad=dw_3.getitemdate(i,"data_scadenza")
				ls_appoggio=string(ld_data_scad,'dd/mm/yyyy')
				
				select codice
				into :ls_dati.s_aux[1]
				from sog_commerciale_gen
				where id_sog_commerciale=:ll_id_sog_com;
				ls_dati.s_aux[2]=ds_esplose.GetItemString(1,"rag_soc_1")
				ls_dati.s_aux[3]=string(ll_id_sog_com)
				ls_dati.s_aux[4]=''
				ls_dati.s_aux[5]=ls_appoggio

				ll_ret=openwithparm(lw_doc, ls_dati, "w_documento_ordine_cx")
				
             
				
				




ds_esplose.reset()


next	
end if
destroy ds_esplose
end event

type cb_elimina from commandbutton within tabpage_3
int X=320
int Y=48
int Width=425
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Elimina dall'ordine"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
long ll_focus, ll_qta, ll_varia

ll_focus=dw_3.GetSelectedRow ( 0 )
if ll_focus=0 then 
	messagebox('Controllare','Nessuna linea è stata selezionata')
else
	DO UNTIL ll_focus=0
	   	dw_3.deleterow(ll_focus)
	   	ll_focus=dw_3.GetSelectedRow ( ll_focus )
   	LOOP

end if
end event

type dw_4 from datawindow within tabpage_3
int X=2190
int Y=68
int Width=251
int Height=88
int TabOrder=40
boolean BringToTop=true
string DataObject="d_data_scad"
boolean Border=false
boolean LiveScroll=true
end type

type st_1 from statictext within tabpage_3
int X=1810
int Y=88
int Width=379
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Data scadenza:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

