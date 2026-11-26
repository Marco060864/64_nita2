forward
global type w_con_lis_sempl_cx from w_p_data
end type
type dw_acq_articoli_gd from u_dw_master_main within tabpage_1
end type
type dw_ven_articoli_gd from u_dw_master_main within tabpage_1
end type
type st_acquisti from statictext within tabpage_1
end type
type st_vendite from statictext within tabpage_1
end type
type dw_acq_articoli_gd from u_dw_master_main within tabpage_1
end type
type dw_ven_articoli_gd from u_dw_master_main within tabpage_1
end type
type st_acquisti from statictext within tabpage_1
end type
type st_vendite from statictext within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type st_acquisti_ccart from statictext within tabpage_2
end type
type st_vendite_ccart from statictext within tabpage_2
end type
type dw_acq_ccart_gd from u_dw_master_main within tabpage_2
end type
type dw_ven_ccart_gd from u_dw_master_main within tabpage_2
end type
type dw_sel_sog_commerciale_ff from u_dw_master_main within w_con_lis_sempl_cx
end type
type tabpage_2 from userobject within tab_1
st_acquisti_ccart st_acquisti_ccart
st_vendite_ccart st_vendite_ccart
dw_acq_ccart_gd dw_acq_ccart_gd
dw_ven_ccart_gd dw_ven_ccart_gd
end type
end forward

global type w_con_lis_sempl_cx from w_p_data
int Width=3031
int Height=1821
boolean TitleBar=true
string Title="Condizioni speciali "
dw_sel_sog_commerciale_ff dw_sel_sog_commerciale_ff
end type
global w_con_lis_sempl_cx w_con_lis_sempl_cx

forward prototypes
public function integer uf_update ()
end prototypes

public function integer uf_update ();integer li_size, li_counter
long ll_to_update
u_dw_main ldw_item

ll_to_update = 0

if not idw_master.ib_dw_shared then
	li_size = UpperBound(idw_master.iudw_children)
	for li_counter = 1 to li_size
		ldw_item = idw_master.iudw_children[li_counter]
		ll_to_update = ll_to_update + ldw_item.uf_To_Update()
	next
end if
return ll_to_update

end function

on w_con_lis_sempl_cx.create
int iCurrent
call w_p_data::create
this.dw_sel_sog_commerciale_ff=create dw_sel_sog_commerciale_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_sel_sog_commerciale_ff
end on

on w_con_lis_sempl_cx.destroy
call w_p_data::destroy
destroy(this.dw_sel_sog_commerciale_ff)
end on

event open;call super::open;il_HelpTopic 			= 379
idw_master 				= dw_sel_sog_commerciale_ff
idw_master.is_list 	= Message.PowerObjectParm

If Upperbound(idw_master.is_list.s_identifica) = 0 then
	idw_master.is_list.s_modo = modo_inserisci
end if


end event

event ue_post_open;call super::ue_post_open;
long ll_row
ll_row	= idw_master.insertRow(0)
idw_master.ScrollToRow(ll_row)
idw_master.ResetUpdate()
end event

event closequery;

long			ll_mods
integer		li_ync, li_retval
u_dw_main	ludw_1
boolean		lb_ok

ludw_1 = u_freddie.iudw_current
lb_ok = true
if not IsNull (ludw_1) then
	if ludw_1.acceptText()>0 then lb_ok = true else lb_ok = false
end if
if not lb_ok then return 1
if idw_master.acceptText() >0 then lb_ok = true else lb_ok = false
if not lb_ok then return 1

idw_master.ResetUpdate()

if uf_update() > 0 then
	li_ync = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
		"finestra.~n~rVuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			
			THIS.triggerevent("ue_update")
			ll_mods = uf_update()
			if ll_mods = 0 then 
				li_retval = 0
			else
				li_retval = 1
			end if
			
		CASE 2
			
			li_retval = 0
			
		CASE 3
			
			li_retval = 1
			
	END CHOOSE
else
	
	li_retval = 0
	
end if

return li_retval

end event

type p_crescente from w_p_data`p_crescente within w_con_lis_sempl_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_con_lis_sempl_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_con_lis_sempl_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_con_lis_sempl_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_con_lis_sempl_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_con_lis_sempl_cx
int X=2081
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_con_lis_sempl_cx
int X=2378
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_con_lis_sempl_cx
int X=2675
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_con_lis_sempl_cx
int X=46
int Y=361
int Width=2926
int Height=1341
boolean BringToTop=true
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2890
int Height=1221
long BackColor=79741120
string Text="Articoli"
long TabBackColor=79741120
dw_acq_articoli_gd dw_acq_articoli_gd
dw_ven_articoli_gd dw_ven_articoli_gd
st_acquisti st_acquisti
st_vendite st_vendite
end type

on tabpage_1.create
this.dw_acq_articoli_gd=create dw_acq_articoli_gd
this.dw_ven_articoli_gd=create dw_ven_articoli_gd
this.st_acquisti=create st_acquisti
this.st_vendite=create st_vendite
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_acq_articoli_gd
this.Control[iCurrent+2]=dw_ven_articoli_gd
this.Control[iCurrent+3]=st_acquisti
this.Control[iCurrent+4]=st_vendite
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_acq_articoli_gd)
destroy(this.dw_ven_articoli_gd)
destroy(this.st_acquisti)
destroy(this.st_vendite)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_con_lis_sempl_cx
int X=1783
boolean BringToTop=true
end type

type dw_acq_articoli_gd from u_dw_master_main within tabpage_1
int X=28
int Y=97
int Width=2835
int Height=461
int TabOrder=1
string DataObject="d_con_lis_sempl_art_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql

ls_sql_cond = "con_lis_articolo.applicazione = 'A'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol

	CASE "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;
CHOOSE CASE as_nomecol

	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_lis_articolo_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_lis_articolo_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'articolo_codice'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "con_lis_articolo_id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'articolo_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "con_lis_articolo_id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_validate_row;call super::ue_validate_row;long	ll_id_articolo
ll_id_articolo = this.GetItemNumber( this.GetRow(),"con_lis_articolo_id_articolo" )

if isNull(ll_id_articolo) then
	as_error_text = "Non è stata specificato un articolo !!!"
	return 1
else
	SetItem(al_row,"con_lis_articolo_applicazione",'A')
end if	
return 0

end event

event ue_init;call super::ue_init;is_title 					= "Articoli - Acquisti"
is_list.s_identifica[1] = "id_sog_commerciale"
is_list.s_win_chiave[1] = "con_lis_articolo_id_con_lis_articolo"
is_list.s_win_zoom 		= "w_con_lis_sempl_ff"

end event

event ue_initial;call super::ue_initial;
long		ll_id_valuta,ll_row
decimal	ldc_cambio

select par_sistema.id_valuta
	into :ll_id_valuta
	from par_sistema
	where par_sistema.id_azienda = 1
	using SQLCA;
	
if SQLCA.SQLCode = 0 then
	ll_row	= this.GetRow()
	this.SetItem( ll_row,"con_lis_articolo_id_valuta",ll_id_valuta )
	
	select valuta.cambio
		into :ldc_cambio	
		from valuta
		where valuta.id_valuta = :ll_id_valuta
		using SQLCA;
		
	if SQLCA.SQLCode = 0 then	
		this.SetItem( ll_row,"con_lis_articolo_cambio",ldc_cambio )
	end if	
		
end if

this.SetItem( ll_row,"con_lis_articolo_data_inizio",Today() )

this.SetColumn("articolo_codice")
end event

type dw_ven_articoli_gd from u_dw_master_main within tabpage_1
int X=28
int Y=657
int Width=2835
int Height=541
int TabOrder=3
string DataObject="d_con_lis_sempl_art_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql

ls_sql_cond = "con_lis_articolo.applicazione = 'V'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol

	CASE "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;
CHOOSE CASE as_nomecol

	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_lis_articolo_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_lis_articolo_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'articolo_codice'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "con_lis_articolo_id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'articolo_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "con_lis_articolo_id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_validate_row;call super::ue_validate_row;long	ll_id_articolo
ll_id_articolo = this.GetItemNumber( this.GetRow(),"con_lis_articolo_id_articolo" )

if isNull(ll_id_articolo) then
	as_error_text = "Non è stata specificato un articolo !!!"
	return 1
else
	SetItem(al_row,"con_lis_articolo_applicazione",'V')
end if	
return 0

end event

event ue_init;call super::ue_init;is_title 					= "Cat. Comm. Articoli - Vendite"
is_list.s_identifica[1] = "id_sog_commerciale"
is_list.s_win_chiave[1] = "con_lis_articolo_id_con_lis_articolo"
is_list.s_win_zoom 		= "w_con_lis_sempl_ff"

end event

event ue_initial;call super::ue_initial;
long		ll_id_valuta,ll_row
decimal	ldc_cambio

select par_sistema.id_valuta
	into :ll_id_valuta
	from par_sistema
	where par_sistema.id_azienda = 1
	using SQLCA;
	
if SQLCA.SQLCode = 0 then
	ll_row	= this.GetRow()
	this.SetItem( ll_row,"con_lis_articolo_id_valuta",ll_id_valuta )
	
		
	select valuta.cambio
		into :ldc_cambio	
		from valuta
		where valuta.id_valuta = :ll_id_valuta
		using SQLCA;
		
	if SQLCA.SQLCode = 0 then	
		this.SetItem( ll_row,"con_lis_articolo_cambio",ll_id_valuta )
	end if	

	
end if

this.SetItem( ll_row,"con_lis_articolo_data_inizio",Today() )

this.SetColumn("articolo_codice")
end event

type st_acquisti from statictext within tabpage_1
int X=28
int Y=17
int Width=2835
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Acquisti"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_vendite from statictext within tabpage_1
int X=28
int Y=577
int Width=2835
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Vendite"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_2 from userobject within tab_1
int X=19
int Y=105
int Width=2890
int Height=1221
long BackColor=79741120
string Text="Categoria Commerciale Articolo"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
st_acquisti_ccart st_acquisti_ccart
st_vendite_ccart st_vendite_ccart
dw_acq_ccart_gd dw_acq_ccart_gd
dw_ven_ccart_gd dw_ven_ccart_gd
end type

on tabpage_2.create
this.st_acquisti_ccart=create st_acquisti_ccart
this.st_vendite_ccart=create st_vendite_ccart
this.dw_acq_ccart_gd=create dw_acq_ccart_gd
this.dw_ven_ccart_gd=create dw_ven_ccart_gd
this.Control[]={ this.st_acquisti_ccart,&
this.st_vendite_ccart,&
this.dw_acq_ccart_gd,&
this.dw_ven_ccart_gd}
end on

on tabpage_2.destroy
destroy(this.st_acquisti_ccart)
destroy(this.st_vendite_ccart)
destroy(this.dw_acq_ccart_gd)
destroy(this.dw_ven_ccart_gd)
end on

type st_acquisti_ccart from statictext within tabpage_2
int X=28
int Y=17
int Width=2835
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Acquisti"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_vendite_ccart from statictext within tabpage_2
int X=28
int Y=577
int Width=2835
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Vendite"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_acq_ccart_gd from u_dw_master_main within tabpage_2
int X=28
int Y=97
int Width=2835
int Height=441
int TabOrder=3
string DataObject="d_con_lis_sempl_ccart_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql

ls_sql_cond = "con_lis_articolo.applicazione = 'A'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event ue_validate_row;call super::ue_validate_row;long	ll_id_cat_com_articolo
ll_id_cat_com_articolo = this.GetItemNumber( this.GetRow(),"id_cat_com_articolo" )

if isNull(ll_id_cat_com_articolo) then
	as_error_text = "Non è stata specificata la categoria commerciale !!!"
	return 1
else
	SetItem(al_row,"applicazione",'A')
end if	
return 0

end event

event ue_init;call super::ue_init;is_title 					= "Cat. Comm. Articoli - Acquisti"
is_list.s_identifica[1] = "id_sog_commerciale"
is_list.s_win_chiave[1] = "con_lis_articolo_id_con_lis_articolo"
is_list.s_win_zoom 		= "w_con_lis_sempl_ff"

end event

event ue_initial;call super::ue_initial;
long		ll_id_valuta,ll_row
decimal	ldc_cambio

select par_sistema.id_valuta
	into :ll_id_valuta
	from par_sistema
	where par_sistema.id_azienda = 1
	using SQLCA;
	
if SQLCA.SQLCode = 0 then
	ll_row	= this.GetRow()
	this.SetItem( ll_row,"id_valuta",ll_id_valuta )

	
	select valuta.cambio
		into :ldc_cambio	
		from valuta
		where valuta.id_valuta = :ll_id_valuta
		using SQLCA;
		
	if SQLCA.SQLCode = 0 then	
		this.SetItem( ll_row,"cambio",ll_id_valuta )
	end if	
	
end if

this.SetItem( ll_row,"data_inizio",Today() )

this.SetColumn("id_cat_com_articolo")
end event

type dw_ven_ccart_gd from u_dw_master_main within tabpage_2
int X=28
int Y=657
int Width=2835
int Height=541
int TabOrder=4
string DataObject="d_con_lis_sempl_ccart_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql

ls_sql_cond = "con_lis_articolo.applicazione = 'V'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event ue_validate_row;call super::ue_validate_row;long	ll_id_cat_com_articolo
ll_id_cat_com_articolo = this.GetItemNumber( this.GetRow(),"id_cat_com_articolo" )

if isNull(ll_id_cat_com_articolo) then
	as_error_text = "Non è stata specificata la categoria commerciale !!!"
	return 1
else
	SetItem(al_row,"applicazione",'V')
end if	
return 0

end event

event ue_init;call super::ue_init;is_title 					= "Cat. Comm. Articoli - Vendite"
is_list.s_identifica[1] = "id_sog_commerciale"
is_list.s_win_chiave[1] = "con_lis_articolo_id_con_lis_articolo"
is_list.s_win_zoom 		= "w_con_lis_sempl_ff"

end event

event ue_initial;call super::ue_initial;
long		ll_id_valuta,ll_row
decimal	ldc_cambio

select par_sistema.id_valuta
	into :ll_id_valuta
	from par_sistema
	where par_sistema.id_azienda = 1
	using SQLCA;
	
if SQLCA.SQLCode = 0 then
	ll_row	= this.GetRow()
	this.SetItem( ll_row,"id_valuta",ll_id_valuta )
	
	select valuta.cambio
		into :ldc_cambio	
		from valuta
		where valuta.id_valuta = :ll_id_valuta
		using SQLCA;
		
	if SQLCA.SQLCode = 0 then	
		this.SetItem( ll_row,"con_lis_articolo_cambio",ll_id_valuta )
	end if	
	
end if

this.SetItem( ll_row,"data_inizio",Today() )

this.SetColumn("id_cat_com_articolo")
end event

type dw_sel_sog_commerciale_ff from u_dw_master_main within w_con_lis_sempl_cx
int X=46
int Y=161
int Width=2903
int Height=181
int TabOrder=10
string DataObject="d_scelta_sog_commerciale_ff"
end type

event ue_insert;
end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "codice" 
		
	CASE "rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "rag_soc_1" 		
	   
		
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;integer 	li_id_sog_commerciale
long 		ll_row,ll_ret

CHOOSE CASE as_nomecol
		
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])

		if not isNull(is_ricpar.s_id_seg_value[1]) then
			ll_row = this.GetRow()
			this.event rowfocuschanged(ll_row)
		end if
		this.ResetUpdate()
		
	CASE "rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
				
		if not isNull(is_ricpar.s_id_seg_value[1]) then
			ll_row = this.GetRow()
			this.event rowfocuschanged(ll_row)
		end if
		this.ResetUpdate()
		
END CHOOSE

end event

event itemchanged;call super::itemchanged;
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_sog_commerciale, ll_id_banca_appoggio
long		 ll_row, ll_ret, ll_temp

ls_sql_cond = ""  

choose case dwo.name
		
	case 'codice'
		ls_dbc[1]  	= "id_sog_commerciale"
		ls_dwc[1]  	= "id_sog_commerciale"
		ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
		ll_row = this.GetRow()
		ll_temp = this.GetItemNumber(ll_row,"id_sog_commerciale")
		if (ll_ok>0) then	
			this.event rowfocuschanged(ll_row)
			this.ResetUpdate()
			return 2
		else
			if isNull(ll_temp) then
				this.event rowfocuschanged(ll_row)				
			end if
		end if

	case 'rag_soc_1'
		
		
		ls_dbc[1]  	= "id_sog_commerciale"
		ls_dwc[1]  	= "id_sog_commerciale"
      ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		
		ll_row = this.GetRow()
		ll_temp = this.GetItemNumber(ll_row,"id_sog_commerciale")
		if (ll_ok>0) then	
			this.event rowfocuschanged(ll_row)
			this.ResetUpdate()
			return 2
		else
			if isNull(ll_temp) then
				this.event rowfocuschanged(ll_row)				
			end if
		end if
		

end choose

this.ResetUpdate()

end event

event ue_init;call super::ue_init;
is_title						= "Condizioni speciali"
is_list.s_identifica[1] = "id_sog_commerciale"

iudw_children[1]	= tab_1.tabpage_1.dw_acq_articoli_gd
iudw_children[2]	= tab_1.tabpage_1.dw_ven_articoli_gd
iudw_children[3]	= tab_1.tabpage_2.dw_acq_ccart_gd
iudw_children[4]	= tab_1.tabpage_2.dw_ven_ccart_gd



end event

