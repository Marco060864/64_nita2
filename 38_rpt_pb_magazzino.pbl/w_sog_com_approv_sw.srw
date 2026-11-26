forward
global type w_sog_com_approv_sw from w_search_main
end type
type st_4 from statictext within w_sog_com_approv_sw
end type
type cbx_1 from checkbox within w_sog_com_approv_sw
end type
end forward

global type w_sog_com_approv_sw from w_search_main
boolean TitleBar=true
string Title="Selezione Soggetto Commerciale"
long BackColor=80263581
st_4 st_4
cbx_1 cbx_1
end type
global w_sog_com_approv_sw w_sog_com_approv_sw

type variables
long il_conf, il_id_art
end variables

forward prototypes
public function decimal uf_prezzo (long ll_id_art, integer ll_row, integer ll_id_sog_com)
end prototypes

public function decimal uf_prezzo (long ll_id_art, integer ll_row, integer ll_id_sog_com);long  ll_valuta
long ll_id_u_conf,ll_id_locazione
long ll_id_eser
decimal{2} ld_quantita
date ld_data_reg=Today()
string  ls_tipo_registro
integer cont

string 			ls_tipo_applicazione		
STRING			ls_app						
string 			ls_quantita
decimal{4}		ld_prezzo, ld_prezzo_app					
string    		ls_sconto	
decimal{4}		ld_sconto_riga
long 				ll_listino					
long				ll_id_cat_com_sc			
long				ll_id_art_in_esame		
long 				ll_id_cat_com_articolo	
long           ll_sog_com_fornitore		
long 				ll_id_produttore			
long				ll_id_listino				
long				ll_pos
long 				ll_id_registro
string 			ls_cod_art_in_esame		
Long				ll_id_destinazione		
String			ls_con_listino				
Integer			li_pos_cond				
Long				ll_con_listino				




	



   
ls_app='A'   
	
select id_unita_confezione
into :ll_id_u_conf
from unita_confezione
where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');	


select id_cat_com_sc, id_listino
into :ll_id_cat_com_sc, :ll_id_listino
from sog_commerciale
where id_sog_commerciale = :ll_id_sog_com;
if isnull(ll_id_cat_com_sc) then ll_id_cat_com_sc=0
if isnull(ll_id_listino) then ll_id_listino=0	


select id_cat_com_articolo, codice
into :ll_id_cat_com_articolo, :ls_cod_art_in_esame
from articolo
where id_articolo= :ll_id_art;
if isnull(ll_id_cat_com_articolo) then ll_id_cat_com_articolo=0

select id_sog_commerciale, id_anagrafica
into :ll_sog_com_fornitore, :ll_id_produttore
from articolo
where id_articolo= :ll_id_art;
if isnull(ll_sog_com_fornitore) then ll_sog_com_fornitore=0	
if isnull(ll_id_produttore) then ll_id_produttore=0	

if isnull(ld_quantita) then ld_quantita=0
ls_quantita=string(ld_quantita)
ll_pos = Pos(ls_quantita, ",", 1)
ls_quantita=replace(ls_quantita, ll_pos, 1, ".")	

select id_locazione, id_val_lire
into :ll_id_locazione, :ll_valuta
from par_sistema;


for cont = 1 to 2		
	if cont=1 then ls_tipo_applicazione="P"
	if cont=2 then ls_tipo_applicazione="I"

	
	string ls_prezzo
	long  ll_id_var
	integer li_pos
	string ls_lis_variazione, ls_tras_mezzo
	
	
	ll_id_var=0
	ll_id_destinazione=0
	ls_tras_mezzo = ''
	
	ls_prezzo=f_recupera_prezzo_listino(ls_app, ll_id_u_conf, ll_id_sog_com,ll_id_cat_com_sc, ls_cod_art_in_esame, & 
		ll_id_cat_com_articolo,	ll_sog_com_fornitore, ll_id_produttore,& 
		ld_quantita, ls_tipo_applicazione, ll_id_art, ll_id_locazione, ll_valuta, ll_id_listino, ll_id_var, &
		ll_id_destinazione, ls_tras_mezzo, ld_data_reg, 0)
							
	
	li_pos=pos(ls_prezzo, "!")
	li_pos_cond=pos(ls_prezzo, "!", li_pos + 1)
		
	if li_pos>0 then
		ls_lis_variazione=mid(ls_prezzo, li_pos + 1, (li_pos_cond - li_pos - 1) )
		ll_id_var=long(ls_lis_variazione)
		ls_con_listino=right(ls_prezzo, len(ls_prezzo) - li_pos_cond)
		ll_con_listino=long(ls_con_listino)
		ls_prezzo=left(ls_prezzo, li_pos - 1)
		
		if ll_id_var<=0 then setnull(ll_id_var)
	   if ll_con_listino<=0 then 	setnull(ll_con_listino) 
	end if
					
	if cont=1 or cont=2  then 
		ld_prezzo_app=dec(ls_prezzo)
		if ld_prezzo_app > 0 then ld_prezzo=ld_prezzo_app
	end if	
				
	

next		
	
return ld_prezzo		

end function

on w_sog_com_approv_sw.create
int iCurrent
call super::create
this.st_4=create st_4
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.cbx_1
end on

on w_sog_com_approv_sw.destroy
call super::destroy
destroy(this.st_4)
destroy(this.cbx_1)
end on

event open;
string		ls_tmp1

ii_min_x = 1578
ii_min_y = 1257
dw_lista.ii_tipo_sel = 1
istr_ric = Message.PowerObjectParm
ib_may_close = false
u_freddie.center_window(this)



il_conf=istr_ric.i_height
il_id_art=istr_ric.i_width

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
	ddlb_tiposel.InsertItem("Uguale a ",2)
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

cbx_1.checked=true
string ls_filter
ls_filter="id_unita_confezione=" +string(il_conf) 
dw_lista.Setfilter(ls_filter)  
dw_lista.filter()
cbx_1.postEvent(Clicked!)
end event

type dw_lista from w_search_main`dw_lista within w_sog_com_approv_sw
int Y=356
string DataObject="d_sog_approv_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_anag_2_cx"
is_list.s_win_chiave[1] = "id_anagrafica"
end event

event dw_lista::ue_return_values;call super::ue_return_values;CHOOSE CASE is_ricpar.s_filter_name
	CASE "tipo"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("id_anagrafica")
	CASE "codice"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("id_anagrafica")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("id_banca_sog_commerciale")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("banca_appoggio_den_abi")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("indirizzo")		
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("localita")		
		is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("provincia")		
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("giorni_consegna")	
		
	CASE "rag_soc_1"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("id_anagrafica")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("id_banca_sog_commerciale")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("banca_appoggio_den_abi")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("indirizzo")		
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("localita")		
		is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("provincia")		
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("giorni_consegna")	
		
END CHOOSE

end event

type sle_showsort from w_search_main`sle_showsort within w_sog_com_approv_sw
int Y=984
int Height=72
end type

type cb_modi from w_search_main`cb_modi within w_sog_com_approv_sw
int Y=1092
end type

type cb_nuovo from w_search_main`cb_nuovo within w_sog_com_approv_sw
int Y=1092
end type

type cb_annulla from w_search_main`cb_annulla within w_sog_com_approv_sw
int Y=1092
end type

type cb_ok from w_search_main`cb_ok within w_sog_com_approv_sw
int Y=1092
end type

type st_3 from w_search_main`st_3 within w_sog_com_approv_sw
int Y=356
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_sog_com_approv_sw
boolean BringToTop=true
end type

type st_4 from statictext within w_sog_com_approv_sw
int X=411
int Y=280
int Width=475
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Fornitori principali"
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

type cbx_1 from checkbox within w_sog_com_approv_sw
int X=315
int Y=268
int Width=69
int Height=76
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_filter

if this.Checked = TRUE then
	ls_filter="id_unita_confezione=" +string(il_conf) 
	dw_lista.Setfilter(ls_filter)  
	dw_lista.filter()
	long i, ll_id_sog_com
	decimal ld_prezzo
	for i= 1 to dw_lista.rowcount()
		ll_id_sog_com=dw_lista.getitemnumber(i,"id_sog_commerciale")
		ld_prezzo=uf_prezzo(il_id_art,i, ll_id_sog_com)
		if ld_prezzo<>0 and not isnull(ld_prezzo) then dw_lista.setitem(i,'prezzo', ld_prezzo)
	next	
else
	ls_filter="isNull(id_unita_confezione)"
	dw_lista.Setfilter(ls_filter)  
	dw_lista.filter()
end if	

end event

