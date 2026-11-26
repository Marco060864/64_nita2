forward
global type w_articolo_coddes_documento_sw from w_search_main
end type
type cb_filtra from commandbutton within w_articolo_coddes_documento_sw
end type
type dw_1 from datawindow within w_articolo_coddes_documento_sw
end type
type dw_2 from datawindow within w_articolo_coddes_documento_sw
end type
type cb_classe from commandbutton within w_articolo_coddes_documento_sw
end type
type cb_reset from commandbutton within w_articolo_coddes_documento_sw
end type
end forward

global type w_articolo_coddes_documento_sw from w_search_main
integer height = 1292
string title = "Ricerca Articolo"
cb_filtra cb_filtra
dw_1 dw_1
dw_2 dw_2
cb_classe cb_classe
cb_reset cb_reset
end type
global w_articolo_coddes_documento_sw w_articolo_coddes_documento_sw

forward prototypes
public subroutine wf_filtra (long al_id_classe, long al_id_sottoclasse, long al_id_lista)
public subroutine wf_filtra_per_metallo (string as_metallo)
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
//15-03-2014  per paolo silverdreams filtro i "KARP"
if istr_ric.s_titolo_finestra='PAOLO' then
	ls_sql_appoggio=ls_sql+ "and reparto.codice = 'PAOL'"
	dw_lista.setsqlselect(ls_sql_appoggio)
end if
//fine 15-03-2014 

end subroutine

public subroutine wf_filtra_per_metallo (string as_metallo);string ls_sql, ls_sql_appoggio
long ll_pos



ls_sql=lower(dw_lista.getsqlselect())
ll_pos=pos(ls_sql, "where")
if ll_pos>0 then
	ls_sql_appoggio=left(ls_sql, ll_pos + 5)+" articolo.id_titolo in (Select id_titolo from dba.orafo_titolo t, dba.orafo_metallo m where m.id_metallo=t.id_metallo "&
							+" and m.codice= '"+as_metallo+"') AND " +right(ls_sql, len(ls_sql) - (ll_pos + 5))
else
	ls_sql_appoggio=ls_sql + " where articolo.id_titolo in (Select id_titolo from dba.orafo_titolo t, dba.orafo_metallo m where m.id_metallo=t.id_metallo "&
							+" and m.codice= '"+as_metallo+"') "						
end if
	
dw_lista.setsqlselect(ls_sql_appoggio)
dw_lista.retrieve()

end subroutine

on w_articolo_coddes_documento_sw.create
int iCurrent
call super::create
this.cb_filtra=create cb_filtra
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_classe=create cb_classe
this.cb_reset=create cb_reset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_filtra
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_classe
this.Control[iCurrent+5]=this.cb_reset
end on

on w_articolo_coddes_documento_sw.destroy
call super::destroy
destroy(this.cb_filtra)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_classe)
destroy(this.cb_reset)
end on

event open;string ls_cod_azienda, ls_cod_prof
long ll_id_lista


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
//ddlb_tiposel.SelectItem(1) //inizia per
ddlb_tiposel.SelectItem(2)
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




DataWindowChild ldw_classe,  ldw_lista
long ll_null
dw_1.insertrow(1)
setnull(ll_null)
dw_1.GetChild("id_classe", ldw_classe)
dw_1.GetChild("id_lista_art_key", ldw_lista)

ldw_classe.settransobject(sqlca)
ldw_lista.settransobject(sqlca)


ldw_classe.retrieve()
ldw_lista.retrieve()

dw_1.setitem(1, "id_classe", ll_null)

dw_1.setitem(1, "id_lista_art_key", ll_null)



//Inserito per samy il 02-12-09 (con bollo gestisce stampa disponibilità-esistenza per clienti)
select codice 
into :ls_cod_azienda
from azienda
;
if ls_cod_azienda='SILVERDR' then
	select p.codice
	into :ls_cod_prof
	from documento d, prof_documento p
	where d.id_documento= :istr_ric.l_id_doc
	and d.id_prof_documento=p.id_prof_documento
	;
	//oggi non lo vuole più: se ACLC niente filtro
	if upper(ls_cod_prof)='ACLC' then 
//		select id_lista_articoli
//		into :ll_id_lista
//		from lista_art_def
//		where cod_lista_articoli='CO10'
//		;
		ll_id_lista=0
	else
		select id_lista_articoli
		into :ll_id_lista
		from lista_art_def
		where cod_lista_articoli='2O10'
		;
	end if
	
	if ll_id_lista>0 then
		dw_1.setitem(1, "id_lista_art_key",ll_id_lista )
		cb_cerca.triggerevent("clicked")
	end if
	if istr_ric.metallo> " " then
		wf_filtra_per_metallo(istr_ric.metallo)
	end if
	
end if


end event

type cb_cerca from w_search_main`cb_cerca within w_articolo_coddes_documento_sw
integer y = 124
end type

event cb_cerca::clicked;call super::clicked;//wf_filtra()
end event

type dw_lista from w_search_main`dw_lista within w_articolo_coddes_documento_sw
integer x = 315
integer y = 228
integer width = 1189
integer height = 580
string dataobject = "d_articolo_lt"
end type

event dw_lista::ue_init;is_resp_window = "w_orafo_articolo_cx"
is_list.s_win_chiave[1] = "id_articolo"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
u_setta_campi_documento uol_trova_unita_conf
long ll_confezione,ll_id_documento
datastore ds_rec_uc
ll_id_documento=	is_ricpar.l_id_doc

is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_articolo")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "id_articolo"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("articolo_stato")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_misura_simbolo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_descrizione")
		
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_b_simbolo")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_b_descrizione")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("unita_misura_conversione")
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("unita_misura_b_conversione")
		
			
		
		is_ricpar.s_ausil_value[15] = THIS.uf_get_colval("id_titolo")
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("lunghezza")
		is_ricpar.s_ausil_value[11] = THIS.uf_get_colval("conv_misura_peso")
		is_ricpar.s_ausil_value[12] = THIS.uf_get_colval("coef_calo")
		
		is_ricpar.s_ausil_value[13] = THIS.uf_get_colval("unita_misura_c_simbolo_um")
		is_ricpar.s_ausil_value[14] = THIS.uf_get_colval("unita_misura_c_tipo_um")
		
	CASE "articolo_codice", "des_articolo_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("articolo_stato")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_misura_simbolo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_descrizione")
		
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_b_simbolo")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_b_descrizione")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("unita_misura_conversione")
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("unita_misura_b_conversione")
		
		
		
		is_ricpar.s_ausil_value[15] = THIS.uf_get_colval("id_titolo")
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("lunghezza")
		is_ricpar.s_ausil_value[11] = THIS.uf_get_colval("conv_misura_peso")
		is_ricpar.s_ausil_value[12] = THIS.uf_get_colval("coef_calo")
		
		is_ricpar.s_ausil_value[13] = THIS.uf_get_colval("unita_misura_c_simbolo_um")
		is_ricpar.s_ausil_value[14] = THIS.uf_get_colval("unita_misura_c_tipo_um")
		
	CASE "articolo_descrizione", "des_articolo_descrizione", "des_articolo_des_estesa"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("articolo_stato")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_misura_simbolo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_descrizione")
		
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_b_simbolo")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_b_descrizione")
		
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("unita_misura_conversione")
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("unita_misura_b_conversione")
		
		
		
		is_ricpar.s_ausil_value[15] = THIS.uf_get_colval("id_titolo")
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("lunghezza")
		is_ricpar.s_ausil_value[11] = THIS.uf_get_colval("conv_misura_peso")
		is_ricpar.s_ausil_value[12] = THIS.uf_get_colval("coef_calo")
		
		is_ricpar.s_ausil_value[13] = THIS.uf_get_colval("unita_misura_c_simbolo_um")
		is_ricpar.s_ausil_value[14] = THIS.uf_get_colval("unita_misura_c_tipo_um")
	
END CHOOSE
is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("unita_confezione_id_unita_confezione")


uol_trova_unita_conf=create u_setta_campi_documento
ll_confezione=uol_trova_unita_conf.of_trova_uc(long(is_ricpar.s_id_seg_value[1]), ll_id_documento)
destroy uol_trova_unita_conf
if long(is_ricpar.s_ausil_value[9])<>ll_confezione then
	is_ricpar.s_ausil_value[9]=string(ll_confezione)
	ds_rec_uc=create datastore
	ds_rec_uc.dataobject='d_recupera_uc_da_ricerca'
	ds_rec_uc.settransobject(sqlca)
	ll_id_documento=ds_rec_uc.retrieve(ll_confezione)
	if ll_id_documento>0 then
		is_ricpar.s_ausil_value[3] = ds_rec_uc.getitemstring(1, "simbolo_peso")
		is_ricpar.s_ausil_value[4] = ds_rec_uc.getitemstring(1, "descrizione_peso")
		
		is_ricpar.s_ausil_value[5] = ds_rec_uc.getitemstring(1, "simbolo_volume")
		is_ricpar.s_ausil_value[6] = ds_rec_uc.getitemstring(1, "descrizione_volume")
		
		is_ricpar.s_ausil_value[10] = string(ds_rec_uc.getitemdecimal(1, "lunghezza"))
		is_ricpar.s_ausil_value[11] = string(ds_rec_uc.getitemdecimal(1, "conv_misura_peso"))
		
		
		is_ricpar.s_ausil_value[13] = ds_rec_uc.getitemstring(1, "simbolo")
		is_ricpar.s_ausil_value[14] = ds_rec_uc.getitemstring(1, "tipo")
	end if
	
	destroy ds_rec_uc
end if


		





end event

event dw_lista::ue_retrieve;


string	ls_sql, ls_where_cond, ls_sql_cond 
pointer	lp_oldp
long		ll_retval, a
long 		ll_id_classe, ll_id_sottocl, ll_id_lista

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

type sle_showsort from w_search_main`sle_showsort within w_articolo_coddes_documento_sw
integer y = 896
end type

type cb_modi from w_search_main`cb_modi within w_articolo_coddes_documento_sw
integer x = 649
integer y = 1024
integer taborder = 90
end type

type cb_nuovo from w_search_main`cb_nuovo within w_articolo_coddes_documento_sw
integer x = 352
integer y = 1024
end type

type cb_annulla from w_search_main`cb_annulla within w_articolo_coddes_documento_sw
integer y = 1024
integer taborder = 130
end type

type cb_ok from w_search_main`cb_ok within w_articolo_coddes_documento_sw
integer y = 1024
integer taborder = 120
end type

type st_3 from w_search_main`st_3 within w_articolo_coddes_documento_sw
integer y = 220
end type

type sle_ricerca from w_search_main`sle_ricerca within w_articolo_coddes_documento_sw
integer y = 124
end type

type sle_filtro from w_search_main`sle_filtro within w_articolo_coddes_documento_sw
integer y = 20
end type

type st_2 from w_search_main`st_2 within w_articolo_coddes_documento_sw
integer y = 28
end type

type st_1 from w_search_main`st_1 within w_articolo_coddes_documento_sw
integer y = 132
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_articolo_coddes_documento_sw
integer y = 20
end type

type cb_filtra from commandbutton within w_articolo_coddes_documento_sw
integer x = 50
integer y = 300
integer width = 247
integer height = 80
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

type dw_1 from datawindow within w_articolo_coddes_documento_sw
integer y = 380
integer width = 311
integer height = 148
integer taborder = 80
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

type dw_2 from datawindow within w_articolo_coddes_documento_sw
integer y = 640
integer width = 315
integer height = 380
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_classe_art_lt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_classe from commandbutton within w_articolo_coddes_documento_sw
integer x = 41
integer y = 544
integer width = 247
integer height = 92
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

type cb_reset from commandbutton within w_articolo_coddes_documento_sw
integer y = 1024
integer width = 315
integer height = 84
integer taborder = 100
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

