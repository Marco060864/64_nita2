forward
global type w_articolo_coddes_sw from w_search_main
end type
type cb_filtra from commandbutton within w_articolo_coddes_sw
end type
type dw_1 from datawindow within w_articolo_coddes_sw
end type
type cb_classe from commandbutton within w_articolo_coddes_sw
end type
type dw_2 from datawindow within w_articolo_coddes_sw
end type
type cb_reset from commandbutton within w_articolo_coddes_sw
end type
end forward

global type w_articolo_coddes_sw from w_search_main
string title = "Ricerca Articolo"
cb_filtra cb_filtra
dw_1 dw_1
cb_classe cb_classe
dw_2 dw_2
cb_reset cb_reset
end type
global w_articolo_coddes_sw w_articolo_coddes_sw

forward prototypes
public subroutine wf_filtra (long al_id_classe, long al_id_sottoclasse, long al_id_lista)
end prototypes

public subroutine wf_filtra (long al_id_classe, long al_id_sottoclasse, long al_id_lista);string ls_sql, ls_sql_appoggio, ls_cond_sql, ls_appoggio,ls_and
long ll_pos, ll_righe, ll_id_classe
integer i
ls_sql=lower(dw_lista.getsqlselect())

ll_righe=dw_2.rowcount()
for i=1 to ll_righe
	ll_id_classe=dw_2.getitemnumber(i, "id_classe")
	
	ls_cond_sql+=", CLASSE_ARTICOLO AS CL_ART_"+STRING(i)+" "

	
	
	if i>1 then ls_and=" and " 
	ls_appoggio+=ls_and+" CL_ART_"+STRING(i)+".ID_ARTICOLO=ARTICOLO.ID_ARTICOLO "+&
		 " AND CL_ART_"+STRING(i)+".ID_CLASSE="+STRING(ll_id_classe)+" "
next 
if ll_righe>0 then
	ll_pos=pos(ls_sql, "where")
	if ll_pos>0 then
		ls_sql_appoggio=left(ls_sql, ll_pos - 1)+ls_cond_sql + mid(ls_sql, ll_pos, len(ls_sql))
		ls_sql_appoggio+= " and " + ls_appoggio
	else
		ls_sql_appoggio=ls_sql+ ls_cond_sql+" where "+ls_appoggio
	end if
	
	dw_lista.setsqlselect(ls_sql_appoggio)
end if

if al_id_lista>0 then
	ls_sql=lower(dw_lista.getsqlselect())
	ll_pos=pos(ls_sql, "lista_art_key.id_lista_articoli =")
	if ll_pos>0 then
		ls_sql_appoggio=left(ls_sql, ll_pos - 1)
		ls_sql_appoggio+="lista_art_key.id_lista_articoli ="+string(al_id_lista)
	else
		ll_pos=pos(ls_sql, "where")
		if ll_pos>0 then
			ls_sql_appoggio=left(ls_sql, ll_pos - 1)+", lista_art_key " + mid(ls_sql, ll_pos, len(ls_sql))
			ls_sql_appoggio+=" and articolo.id_articolo = lista_art_key.id_articolo "+&
									" and lista_art_key.id_lista_articoli =" + string(al_id_lista)
		else
			ls_sql_appoggio=ls_sql+ " , lista_art_key "+&
								" where articolo.id_articolo = lista_art_key.id_articolo and "+&
								" lista_art_key.id_lista_articoli = " + string(al_id_lista) 									
		end if
		
	end if
	dw_lista.setsqlselect(ls_sql_appoggio)
end if
end subroutine

on w_articolo_coddes_sw.create
int iCurrent
call super::create
this.cb_filtra=create cb_filtra
this.dw_1=create dw_1
this.cb_classe=create cb_classe
this.dw_2=create dw_2
this.cb_reset=create cb_reset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_filtra
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_classe
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_reset
end on

on w_articolo_coddes_sw.destroy
call super::destroy
destroy(this.cb_filtra)
destroy(this.dw_1)
destroy(this.cb_classe)
destroy(this.dw_2)
destroy(this.cb_reset)
end on

event open;
string		ls_tmp1

ii_min_x = 1578
ii_min_y = 1257
dw_lista.ii_tipo_sel = 1
istr_ric = Message.PowerObjectParm
ib_may_close = false
u_freddie.center_window(this)


dw_lista.is_ricpar = istr_ric
If istr_ric.b_asneeded then
	dw_lista.Object.DataWindow.Retrieve.AsNeeded = "Yes"
else
	dw_lista.Object.DataWindow.Retrieve.AsNeeded = "No"
end if
dw_lista.is_last_column = istr_ric.s_filter_name
ls_tmp1 = istr_ric.s_filter_name+"_t"							

dw_lista.is_last_coldesc = string(dw_lista.describe(ls_tmp1+".text"))		
dw_lista.is_last_sort = "A"
dw_lista.is_last_dbname = string(dw_lista.Describe(istr_ric.s_filter_name+".dbName"))
dw_lista.is_last_coltype = string(dw_lista.Describe(istr_ric.s_filter_name+".coltype"))

if Left(dw_lista.is_last_coltype ,4) <> "char" then
	ddlb_tiposel.DeleteItem(1)
	ddlb_tiposel.InsertItem("Maggiore o uguale a ",1)
	ddlb_tiposel.DeleteItem(2)
	ddlb_tiposel.InsertItem("Uguale a",2)
	ddlb_tiposel.DeleteItem(3)
	ddlb_tiposel.InsertItem("Minore o uguale a ",3)
end if
ddlb_tiposel.SelectItem(1)
dw_lista.setcolumn(istr_ric.s_filter_name)
if istr_ric.s_filter_value>"" then
	sle_filtro.text = istr_ric.s_filter_value
	dw_lista.is_val_sel = istr_ric.s_filter_value
	dw_lista.trigger event ue_change_col (false)
end if

if ((istr_ric.b_imm_insert) and (dw_lista.is_resp_window <> ""))  then
	sle_filtro.text = ""
	cb_nuovo.postevent(clicked!)
else
	if ((istr_ric.b_imm_maint) and (dw_lista.is_resp_window <> ""))then
		cb_cerca.postevent(clicked!)
		cb_modi.postevent(clicked!)
	else
		if ((istr_ric.b_imm_retrieve) or (istr_ric.s_sql_cond>" ") or (istr_ric.s_filter_value>" ") )then
			cb_cerca.postevent(clicked!)
		end if
	end if
end if
	
if dw_lista.is_resp_window = "" then
	cb_modi.enabled = false
	cb_modi.visible = false
	cb_nuovo.enabled = false
	cb_nuovo.visible = false
end if

sle_filtro.setfocus()



DataWindowChild   ldw_lista
long ll_null
dw_1.insertrow(1)
setnull(ll_null)

dw_1.GetChild("id_lista_art_key", ldw_lista)


ldw_lista.settransobject(sqlca)


ldw_lista.retrieve()


dw_1.setitem(1, "id_lista_art_key", ll_null)

dw_2.settransobject(sqlca)
end event

type cb_cerca from w_search_main`cb_cerca within w_articolo_coddes_sw
integer y = 140
end type

type dw_lista from w_search_main`dw_lista within w_articolo_coddes_sw
integer y = 244
integer width = 1189
integer height = 580
string dataobject = "d_articolo_lt"
end type

event dw_lista::ue_init;
	is_resp_window = "w_orafo_articolo_cx"
is_list.s_win_chiave[1] = "id_articolo"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_articolo")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "id_articolo"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
	CASE "articolo_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
	CASE "articolo_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_codice")
END CHOOSE
is_ricpar.s_id_seg_value[2] = THIS.uf_get_colval("unita_confezione_id_unita_confezione")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("unita_confezione_codice")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_confezione_descrizione")
end event

event dw_lista::doubleclicked;string ls_column

if row = 0 then 
	if not (dwo.Name = "datawindow") then
		
	 	ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 2)
		if ls_column = is_last_column then 
			if is_last_sort = "D" then
				this.SetSort(ls_column + " A")
				is_last_sort = "A"
			else
				this.SetSort(ls_column + " D")
				is_last_sort = "D"
			end if
		else 
			this.SetSort(ls_column + " A")
			is_last_column = ls_column
			is_last_sort = "A"
			is_last_dbname = string(Describe(ls_column+".dbName"))
			is_last_coltype = string(Describe(ls_column+".coltype"))
			is_last_coldesc = dwo.text
			trigger event ue_change_col (true)
		end if
		this.Sort()
	end if
else
	
	
	triggerevent("ue_return_values")
	CloseWithReturn (parent,is_ricpar)	
end if 


end event

event dw_lista::ue_change_col;

string		ls_temp, ls_car
integer		li_i

if ib_reset then sle_filtro.text = ""

sle_ricerca.setfocus()
ls_temp = ""
for li_i = 1 to len(dw_lista.is_last_coldesc)
	ls_car = mid(dw_lista.is_last_coldesc,li_i,1)
	if asc(ls_car) < 32 then
		ls_temp = ls_temp+" "
	else
		ls_temp = ls_temp+ls_car
	end if
next

sle_showsort.text = ls_temp+ " "+ ddlb_tiposel.text+" "+sle_filtro.text

end event

event dw_lista::ue_retrieve;


string	ls_sql, ls_where_cond, ls_sql_cond 
pointer	lp_oldp
long		ll_retval, a
long ll_id_classe, ll_id_sottocl, ll_id_lista

ll_retval = 0
lp_oldp = setpointer(Hourglass!)

if ib_havetoscan then
	
	this.object.datawindow.table.select = ius_scanner.f_getinitial()
	
	
		
		
		ls_sql_cond = ""
		
		
		if is_last_dbname<>"" and is_val_sel>'' then
		
			ll_retval = uf_get_where_cond(is_last_dbname,is_val_sel,ii_tipo_sel,ls_sql_cond)
			if upper(left(ls_sql_cond, 6))="CODICE" or upper(left(ls_sql_cond, 11))="DESCRIZIONE" or upper(left(ls_sql_cond, 11))="ID_ARTICOLO" then 
				if is_last_column="des_articolo_codice" then
					ls_sql_cond="des_articolo."+ls_sql_cond
				else
					ls_sql_cond="articolo."+ls_sql_cond
				end if
			else
				
				
			end if
		end if
		if is_ricpar.s_sql_cond <> "" then
			ls_sql_cond = "( "+ ls_sql_cond + " ) AND ( " + is_ricpar.s_sql_cond + " )"
		end if
		
		a=pos(ls_sql_cond, 'NULL')
		if ls_sql_cond > "" and  a=0 then
		
			ius_scanner.f_reset_cur_as_ini()
			ius_scanner.f_add_where_condition(ls_sql_cond)
			ls_sql = ius_scanner.f_getcurrent()
			this.object.datawindow.table.select = ls_sql
			ib_havetoscan = false
		end if
	
end if

ls_sql=this.object.datawindow.table.select
dw_1.accepttext()
ll_id_classe= dw_1.getitemnumber(1, "id_classe")
ll_id_sottocl= dw_1.getitemnumber(1, "id_sottoclasse")
ll_id_lista= dw_1.getitemnumber(1, "id_lista_art_key")

wf_filtra(ll_id_classe, ll_id_sottocl, ll_id_lista)


retrieve()
if rowcount() > 0 then
	this.SetSort(is_last_column + " A")
	is_last_sort = "A"
	this.sort()
	this.ScrollToRow(0)
	il_last_row = getrow()
	this.SelectRow(0, false)
	this.SelectRow(il_last_row, true)
end if
lp_oldp = setpointer(lp_oldp)
return(ll_retval)

end event

type sle_showsort from w_search_main`sle_showsort within w_articolo_coddes_sw
end type

type cb_modi from w_search_main`cb_modi within w_articolo_coddes_sw
integer x = 645
integer taborder = 80
end type

type cb_nuovo from w_search_main`cb_nuovo within w_articolo_coddes_sw
integer x = 334
end type

type cb_annulla from w_search_main`cb_annulla within w_articolo_coddes_sw
integer taborder = 130
end type

type cb_ok from w_search_main`cb_ok within w_articolo_coddes_sw
integer taborder = 120
end type

type st_3 from w_search_main`st_3 within w_articolo_coddes_sw
integer y = 236
end type

type sle_ricerca from w_search_main`sle_ricerca within w_articolo_coddes_sw
integer y = 140
end type

type sle_filtro from w_search_main`sle_filtro within w_articolo_coddes_sw
integer y = 32
end type

type st_2 from w_search_main`st_2 within w_articolo_coddes_sw
end type

type st_1 from w_search_main`st_1 within w_articolo_coddes_sw
integer y = 148
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_articolo_coddes_sw
integer y = 32
end type

type cb_filtra from commandbutton within w_articolo_coddes_sw
integer x = 55
integer y = 300
integer width = 247
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtra"
end type

event clicked;s_key_articoli st_chiavi
string ls_sql, ls_sql_appoggio
long ll_pos

st_chiavi=f_lista_articoli()
if isvalid(st_chiavi) then
	if st_chiavi.sn_applica_lista then
		ls_sql=lower(dw_lista.getsqlselect())
		ll_pos=pos(ls_sql, "lista_art_key.id_lista_articoli =")
		if ll_pos>0 then
			ls_sql_appoggio=left(ls_sql, ll_pos - 1)
			ls_sql_appoggio+="lista_art_key.id_lista_articoli ="+string(st_chiavi.id_lista_articoli)
		else
			ll_pos=pos(ls_sql, "where")
			if ll_pos>0 then
				ls_sql_appoggio=left(ls_sql, ll_pos - 1)+", lista_art_key " + mid(ls_sql, ll_pos, len(ls_sql))
				ls_sql_appoggio+=" and articolo.id_articolo = lista_art_key.id_articolo "+&
										" and lista_art_key.id_lista_articoli =" + string(st_chiavi.id_lista_articoli)
			else
				ls_sql_appoggio=ls_sql+ " , lista_art_key "+&
									" where articolo.id_articolo = lista_art_key.id_articolo and "+&
									" lista_art_key.id_lista_articoli = " + string(st_chiavi.id_lista_articoli) 									
			end if
		end if
		
		dw_lista.setsqlselect(ls_sql_appoggio)
		dw_lista.retrieve()
		dw_1.setitem(1, "id_lista_art_key", st_chiavi.id_lista_articoli)
	end if
end if
end event

type dw_1 from datawindow within w_articolo_coddes_sw
integer x = 14
integer y = 392
integer width = 311
integer height = 164
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_filtra_cl_e_liste_ext"
boolean border = false
boolean livescroll = true
end type

event itemchanged;datawindowchild ldw_sottoclasse


if dwo.name="id_classe" then
	dw_1.GetChild("id_sottoclasse", ldw_sottoclasse)
	ldw_sottoclasse.settransobject(sqlca)
	ldw_sottoclasse.retrieve(long(data))
end if
	
end event

type cb_classe from commandbutton within w_articolo_coddes_sw
integer x = 50
integer y = 564
integer width = 247
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Classe"
end type

event clicked;long ll_riga
s_recupera_classe s_classe
integer i
open(w_classe_struttura_cx)
s_classe=message.powerobjectparm
if isvalid(s_classe) then
	dw_2.reset()
	for i=upperbound(s_classe.id_classe) to 1 step -1 
		ll_riga=dw_2.insertrow(0)
		dw_2.setitem(ll_riga, "id_classe", s_classe.id_classe[i])
		dw_2.setitem(ll_riga, "cod_classe", s_classe.cod_classe[i])
		dw_2.setitem(ll_riga, "classe_livello", i)
	next
	dw_2.sort()
end if
end event

type dw_2 from datawindow within w_articolo_coddes_sw
integer y = 660
integer width = 315
integer height = 376
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_classe_art_lt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_reset from commandbutton within w_articolo_coddes_sw
integer y = 1040
integer width = 315
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Canc. Classi"
end type

event clicked;dw_2.reset()
end event

