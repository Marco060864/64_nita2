forward
global type w_des_articolo_coddes_documento_sw from w_search_main
end type
type cb_filtra from commandbutton within w_des_articolo_coddes_documento_sw
end type
type dw_1 from datawindow within w_des_articolo_coddes_documento_sw
end type
end forward

global type w_des_articolo_coddes_documento_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Articolo"
cb_filtra cb_filtra
dw_1 dw_1
end type
global w_des_articolo_coddes_documento_sw w_des_articolo_coddes_documento_sw

forward prototypes
public subroutine wf_filtra (long al_id_classe, long al_id_sottoclasse, long al_id_lista)
end prototypes

public subroutine wf_filtra (long al_id_classe, long al_id_sottoclasse, long al_id_lista);string ls_sql, ls_sql_appoggio
long ll_pos
ls_sql=lower(dw_lista.getsqlselect())
if al_id_sottoclasse>0 then
	ll_pos=pos(ls_sql, "where")
	if ll_pos>0 then
		ls_sql_appoggio=left(ls_sql, ll_pos - 1)+", art_sottoclasse " + mid(ls_sql, ll_pos, len(ls_sql))
		ls_sql_appoggio+=" and articolo.id_articolo = art_sottoclasse.id_articolo "+&
								" and art_sottoclasse.id_sottoclasse =" + string(al_id_sottoclasse)
	else
		ls_sql_appoggio=ls_sql+ " , art_sottoclasse "+&
							" where articolo.id_articolo = art_sottoclasse.id_articolo "+&
								" and art_sottoclasse.id_sottoclasse =" + string(al_id_sottoclasse)								
	end if
	
	dw_lista.setsqlselect(ls_sql_appoggio)
	
elseif al_id_classe>0 then
	ll_pos=pos(ls_sql, "where")
	if ll_pos>0 then
		ls_sql_appoggio=left(ls_sql, ll_pos - 1)+", art_sottoclasse, sottoclasse, classe " + mid(ls_sql, ll_pos, len(ls_sql))
		ls_sql_appoggio+=" and articolo.id_articolo = art_sottoclasse.id_articolo "+&
								" and art_sottoclasse.id_sottoclasse =sottoclasse.id_sottoclasse "+&
								" and sottoclasse.id_classe=classe.id_classe "+&
								" and classe.id_classe= " + string(al_id_classe)
	else
		ls_sql_appoggio=ls_sql+ " , art_sottoclasse , classe "+&
							" where articolo.id_articolo = art_sottoclasse.id_articolo "+&
								" and art_sottoclasse.id_sottoclasse =sottoclasse.id_sottoclasse "+&
								" and sottoclasse.id_classe=classe.id_classe "+&
								" and classe.id_classe= " + string(al_id_classe)					
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

on w_des_articolo_coddes_documento_sw.create
int iCurrent
call super::create
this.cb_filtra=create cb_filtra
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_filtra
this.Control[iCurrent+2]=this.dw_1
end on

on w_des_articolo_coddes_documento_sw.destroy
call super::destroy
destroy(this.cb_filtra)
destroy(this.dw_1)
end on

event open;call super::open;DataWindowChild ldw_classe,  ldw_lista
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

end event

type dw_lista from w_search_main`dw_lista within w_des_articolo_coddes_documento_sw
int Width=1189
int Height=580
string DataObject="d_des_articolo_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_orafo_articolo_cx"
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
long ll_id_classe, ll_id_sottocl, ll_id_lista

ll_retval = 0
lp_oldp = setpointer(Hourglass!)

if ib_havetoscan then
	
	
		
		
		ls_sql_cond = ""
		if is_last_dbname<>"" then
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

type cb_modi from w_search_main`cb_modi within w_des_articolo_coddes_documento_sw
int TabOrder=80
end type

type cb_annulla from w_search_main`cb_annulla within w_des_articolo_coddes_documento_sw
int TabOrder=100
end type

type cb_ok from w_search_main`cb_ok within w_des_articolo_coddes_documento_sw
int TabOrder=90
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_des_articolo_coddes_documento_sw
int Height=268
boolean BringToTop=true
long BackColor=1090519039
FontCharSet FontCharSet=Ansi!
end type

type cb_filtra from commandbutton within w_des_articolo_coddes_documento_sw
int X=55
int Y=392
int Width=247
int Height=108
int TabOrder=70
boolean BringToTop=true
string Text="Filtra"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type dw_1 from datawindow within w_des_articolo_coddes_documento_sw
int X=9
int Y=524
int Width=297
int Height=580
int TabOrder=80
boolean BringToTop=true
string DataObject="d_filtra_cl_e_liste_ext"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;datawindowchild ldw_sottoclasse


if dwo.name="id_classe" then
	dw_1.GetChild("id_sottoclasse", ldw_sottoclasse)
	ldw_sottoclasse.settransobject(sqlca)
	ldw_sottoclasse.retrieve(long(data))
end if
	
end event

