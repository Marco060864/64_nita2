forward
global type w_listino_cx from w_p_data
end type
type dw_listino_ff from u_dw_master_main within w_listino_cx
end type
type dw_variazione_gd from u_dw_master_main within w_listino_cx
end type
type dw_variazione_gd_t from statictext within w_listino_cx
end type
type dw_listino_ff_t from statictext within w_listino_cx
end type
end forward

global type w_listino_cx from w_p_data
int Width=2533
int Height=924
boolean TitleBar=true
string Title="Listini"
dw_listino_ff dw_listino_ff
dw_variazione_gd dw_variazione_gd
dw_variazione_gd_t dw_variazione_gd_t
dw_listino_ff_t dw_listino_ff_t
end type
global w_listino_cx w_listino_cx

type variables
boolean 		ib_fix_id
end variables

event open;call super::open;il_HelpTopic = 43

idw_master = dw_listino_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_listino"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "listino.id_listino"

end event

on w_listino_cx.create
int iCurrent
call super::create
this.dw_listino_ff=create dw_listino_ff
this.dw_variazione_gd=create dw_variazione_gd
this.dw_variazione_gd_t=create dw_variazione_gd_t
this.dw_listino_ff_t=create dw_listino_ff_t
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_listino_ff
this.Control[iCurrent+2]=this.dw_variazione_gd
this.Control[iCurrent+3]=this.dw_variazione_gd_t
this.Control[iCurrent+4]=this.dw_listino_ff_t
end on

on w_listino_cx.destroy
call super::destroy
destroy(this.dw_listino_ff)
destroy(this.dw_variazione_gd)
destroy(this.dw_variazione_gd_t)
destroy(this.dw_listino_ff_t)
end on

event ue_post_open;call super::ue_post_open;cb_ricerca.visible=true

integer li_valuta
long ll_row

SELECT id_valuta
INTO :li_valuta
FROM par_sistema;

ll_row = dw_listino_ff.GetRow()
dw_listino_ff.SetItem(ll_row,'id_valuta',li_valuta)
dw_listino_ff.SetItemStatus(ll_row,0,Primary!,NotModified!)

end event

event ue_master_delete;call super::ue_master_delete;
long ll_riga_corrente
integer ll_ret

if dw_variazione_gd.rowcount()>0 then
	ll_ret=messagebox("Attenzione!", "Esistono righe legate a questo listino,~r~n " &
		+"volete cancellarle tutte?~r~n"&
		+"Non sarà possibile poi recuperare questo dato!", stopsign!,yesno! )
		if ll_ret=1 then
			for ll_ret= 1 to dw_variazione_gd.rowcount()
				dw_variazione_gd.deleterow(ll_ret)
			next
			ib_askforsave=false
			dw_variazione_gd.update()
			ll_riga_corrente=dw_listino_ff.getrow()
			dw_listino_ff.deleterow(ll_riga_corrente)
			cb_nuovo.triggerevent(clicked!)
		end if
else
	dw_listino_ff.deleterow(0)
	cb_nuovo.triggerevent(clicked!)
end if
end event

type p_crescente from w_p_data`p_crescente within w_listino_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_listino_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_listino_cx
int X=37
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_listino_cx
int X=329
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_listino_cx
int X=622
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;

parent.triggerevent("ue_post_open")

end event

type cb_inserisci from w_p_data`cb_inserisci within w_listino_cx
int X=1646
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_listino_cx
int X=1938
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_listino_cx
int X=2231
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_listino_cx
int X=1600
int Y=960
int Width=777
int Height=520
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=741
int Height=400
end type

type cb_ricerca from w_p_data`cb_ricerca within w_listino_cx
int X=1353
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long ll_seg_value
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice

idw_master.is_ricpar.s_filter_name="tipo"

openwithparm(lw_sm,idw_master.is_ricpar,"w_listino_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_listino"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_listino_ff from u_dw_master_main within w_listino_cx
int X=23
int Y=240
int Width=1563
int Height=576
int TabOrder=20
string DataObject="d_listino_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_listino"
iudw_children[1] = dw_variazione_gd

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_valuta"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861

END CHOOSE


end event

event updateend;call super::updateend;
long ll_id_lis_w_error, ll_row, ll_id_listino, ll_counter
string ls_codice

if ib_fix_id then
	ll_row=GetRow()
	ls_codice= GetItemString(ll_row, "codice")
	SELECT Max("listino"."id_listino")  
		INTO :ll_id_listino  
		FROM "dba"."listino"  
		WHERE "listino"."codice" = :ls_codice ;
	If SQLCA.SQLCode = 0 then
		uf_SetItem(ll_row, "id_listino", ll_id_listino, TRUE)
	end if
	
		for ll_counter = 1 to Upperbound(dw_variazione_gd.is_list.s_identifica)
			dw_variazione_gd.is_list.l_identifica[ll_counter] = GetItemNumber(ll_row, dw_variazione_gd.is_list.s_identifica[ll_counter])
		next
		dw_variazione_gd.post TriggerEvent("ue_retrieve")
end if
end event

event updatestart;call super::updatestart;
if GetItemStatus(GetRow(), 0, Primary!) = New! OR GetItemStatus(GetRow(), 0, Primary!) = NewModified! then
	ib_fix_id = TRUE
else
	ib_fix_id = FALSE
end if
end event

type dw_variazione_gd from u_dw_master_main within w_listino_cx
int X=1609
int Y=240
int Width=882
int Height=576
int TabOrder=10
string DataObject="d_variazione_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_listino"
is_list.s_win_chiave[1] = "id_variazione"
is_list.s_win_zoom = "w_variazione_ff"
end event

event itemchanged;call super::itemchanged;
date ldt_data_inizio, ldt_null, ldt_data_fine
integer i
CHOOSE CASE dwo.name
	case "data_fine" 
		ldt_data_inizio=getitemdate(row, "data_inizio")
		if date(data)<=ldt_data_inizio then
			messagebox("Errore!", "La data di fine deve essere successiva~r~n"&
			+"a quella di inizio!")
			setnull(ldt_null)
			setitem(row, "data_fine", ldt_null)
			setcolumn("data_fine")
		end if
	case "data_inizio"
		if (This.GetRow() > 1) then			
			ldt_data_inizio = relativedate(this.getitemdate(row - 1,"data_fine"),1)
			if date(data) < ldt_data_inizio then
				messagebox("Errore!", "Non si può inserire una data iniziale minore~r~n"&
											+"di quella finale della variazione precedente.")
				this.setitem(row,"data_inizio",ldt_data_inizio)
				return 2
			end if
		end if
END CHOOSE




end event

event ue_insert;call super::ue_insert;long 			ll_row
long			ll_this_row
date			ld_data_fine
date			ld_data_old


ll_row = this.rowcount()

if ll_row > 1 then
	ll_this_row = 1
	ld_data_fine = this.getitemdate(ll_this_row, "data_fine")
	ld_data_old = ld_data_fine
	do while not isnull(ld_data_fine) and (ll_this_row <= ll_row)
			ll_this_row = ll_this_row + 1
			ld_data_old = ld_data_fine
			ld_data_fine = this.getitemdate(ll_this_row, "data_fine")
	loop	
	if not isnull ( ld_data_old ) then
		this.setitem(ll_row,"data_inizio",relativedate(ld_data_old,1))
		this.update()
	else
		messagebox("ATTENZIONE","IMPOSSIBILE APRIRE UNA NUOVA VARIAZIONE ~r~n SE NON SI CHIUDE PRIMA QUELLA PRECEDENTE" )
		this.deleterow(ll_row)	
	end if
end if
end event

event ue_modify;long 				ll_row
integer 			li_size, li_counter
string 			ls_filter, ls_colname, ls_colval
s_list_main 	lstr_for_win
s_rit_wp			lstr_rit

ll_row = GetRow()
if ll_row>0 then
	if not(is_resp_window = "") OR not(is_list.s_win_zoom = "") then
	
		is_list.s_modo 					= modo_modifica
		lstr_for_win.s_modo 				= is_list.s_modo
		lstr_for_win.s_identifica 		= is_list.s_win_chiave
		lstr_for_win.l_identifica 		= is_list.l_win_chiave
		lstr_for_win.s_par_name 		= is_list.s_par_name
		lstr_for_win.s_par_value 		= is_list.s_par_value
		lstr_for_win.s_win_parametri 	= is_list.s_win_parametri
		
		li_size = UpperBound(lstr_for_win.s_identifica)		
		for li_counter = 1 to li_size
			lstr_for_win.l_identifica[li_counter] = GetItemNumber( ll_row, lstr_for_win.s_identifica[li_counter])
		next
		
		li_size = UpperBound(lstr_for_win.s_par_name)
		for li_counter = 1 to li_size
			lstr_for_win.s_par_value[li_counter] = string(GetItemNumber(GetRow(), lstr_for_win.s_par_name[li_counter]))
		next

		
		long ll_id_valuta
		ll_id_valuta = dw_listino_ff.getitemnumber(1, "id_valuta")

		lstr_for_win.s_par_name[1] = "id_valuta"
		lstr_for_win.s_par_value[1] = string(ll_id_valuta)
		

		if is_list.s_win_zoom = "" then
			OpenWithParm(iw_support, lstr_for_win, is_resp_window)
		else
			if not ((GetItemStatus(ll_row, 0, Primary!) = New!) OR (GetItemStatus(ll_row, 0, Primary!) = NewModified!)) then
				this.update()
				OpenWithParm(iw_support, lstr_for_win,is_list.s_win_zoom)
			end if
		end if
	
		
		ls_filter = ""
		lstr_rit = Message.PowerObjectParm
		li_size = UpperBound(lstr_rit.s_identifica)
		for  li_counter = 1 to li_size
			ls_colname = lstr_rit.s_identifica[li_counter]
			ls_colval = string(lstr_rit.l_identifica[li_counter])
			ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
		next
		ls_filter = Mid(ls_filter,5)
		
		
		
		
			TriggerEvent("ue_retrieve")
			if (RowCount()>0) and (is_resp_window <> "") then
				selectrow(1,true)
			end if
			ll_row = Find( ls_filter, 1, RowCount( ))
			ScrollToRow(ll_row)
		
		
	else
		
	end if
end if


end event

type dw_variazione_gd_t from statictext within w_listino_cx
int X=1609
int Y=164
int Width=882
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Variazioni"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_listino_ff_t from statictext within w_listino_cx
int X=23
int Y=164
int Width=1563
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Listino"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

