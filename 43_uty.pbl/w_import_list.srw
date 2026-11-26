forward
global type w_import_list from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_import_list
end type
type cb_1 from commandbutton within w_import_list
end type
type cb_2 from commandbutton within w_import_list
end type
type cb_import from commandbutton within w_import_list
end type
end forward

global type w_import_list from w_wiz_main
int Width=2487
int Height=1440
boolean TitleBar=true
string Title="Importazione Listini Fornitori"
long BackColor=80133307
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_import cb_import
end type
global w_import_list w_import_list

type variables
string is_path
end variables

forward prototypes
public function integer wf_aggiorna (long al_id_listino, long al_id_articolo, long al_id_variazione, datastore ads_prz, decimal ad_prz)
public subroutine wf_inserisci (datawindow adw_1, string as_codart, string as_desart, decimal ad_prz)
end prototypes

public function integer wf_aggiorna (long al_id_listino, long al_id_articolo, long al_id_variazione, datastore ads_prz, decimal ad_prz);integer li_ret

ads_prz.reset()
li_ret = ads_prz.retrieve(al_id_listino, al_id_articolo, al_id_variazione)
if li_ret > 0 then
	ads_prz.setitem(li_ret,"prezzo_prezzo",ad_prz)
	ads_prz.update()
	return 1
end if

return 0
end function

public subroutine wf_inserisci (datawindow adw_1, string as_codart, string as_desart, decimal ad_prz);date ld_data
string ls_stato, ls_listino
integer ll_id_azienda
long ll_row, ll_id_listino, ll_id_forn,ll_id_cat_cod, ll_id_cat_com_art, ll_id_tab_iva, ll_id_uc, ll_id_variazione
long ll_id_articolo

ld_data = today()
ls_stato = "P"
ll_id_azienda = 1
ll_row = adw_1.getrow()

ls_listino = adw_1.getitemstring(ll_row,"listino")
SELECT id_listino
INTO	 :ll_id_listino
FROM	 listino
WHERE	 codice = :ls_listino;
ll_id_forn = adw_1.getitemnumber(ll_row,"id_forn")
ll_id_cat_cod = adw_1.getitemnumber(ll_row,"id_cat_cod")
ll_id_cat_com_art = adw_1.getitemnumber(ll_row,"id_cat_com_art")
ll_id_tab_iva = adw_1.getitemnumber(ll_row,"id_tab_iva")

ll_id_variazione = dw_1.getitemnumber(ll_row,"id_variazione")

INSERT INTO articolo (id_cat_codifica, codice, descrizione, id_cat_com_articolo, id_sog_commerciale, id_tab_iva, &
							 data_ora_creazione, data_ora_ult_cambiamento, data_ora_ult_var_stato, stato, id_azienda)
VALUES (:ll_id_cat_cod, :as_codart, :as_desart, :ll_id_cat_com_art, :ll_id_forn, :ll_id_tab_iva, 
		  :ld_data, :ld_data, :ld_data, :ls_stato, :ll_id_azienda) ;

commit;

select id_articolo
into :ll_id_articolo
from articolo
where codice = :as_codart;

select id_unita_confezione
into :ll_id_uc
from unita_confezione
where id_articolo = :ll_id_articolo
and unita_base = 'S';
if sqlca.sqlcode = 0 then
	insert into prezzo (id_unita_confezione, id_variazione, prezzo)
	values (:ll_id_uc, :ll_id_variazione, :ad_prz);
	commit;
end if
end subroutine

event open;call super::open;dw_1.SetTransObject(SQLCA)
dw_1.insertrow(0)
dw_1.setfocus()

DataWindowChild ldw_id_cat_com, ldw_listino, ldw_id_cat_cod, ldw_id_tab_iva, ldw_uc

dw_1.GetChild("id_cat_com_art", ldw_id_cat_com)
dw_1.GetChild("listino", ldw_listino)
dw_1.GetChild("id_cat_cod", ldw_id_cat_cod)
dw_1.GetChild("id_tab_iva", ldw_id_tab_iva)

dw_1.accepttext()

ldw_id_cat_com.SetTransObject(SQLCA)
ldw_id_cat_com.Retrieve()

ldw_listino.SetTransObject(SQLCA)
ldw_listino.Retrieve()

ldw_id_cat_cod.SetTransObject(SQLCA)
ldw_id_cat_cod.Retrieve()

ldw_id_tab_iva.SetTransObject(SQLCA)
ldw_id_tab_iva.Retrieve()

select dir_export
into :is_path
from par_sistema;

end event

on w_import_list.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_import=create cb_import
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_import
end on

on w_import_list.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_import)
end on

type dw_1 from u_dw_ext_main within w_import_list
int X=37
int Y=36
int Width=2359
int Height=1104
int TabOrder=10
boolean BringToTop=true
string DataObject="d_import_list"
end type

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
Long		ll_id_listino
String 	ls_listino, ls_filt
Date 	 ld_data_fine
			
CHOOSE CASE dwo.name

		CASE "cod_forn"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"		
		
		ls_dwc[1] = "cod_forn"
		ls_dwc[2] = "rag_forn"
		ls_dwc[3] = "id_forn"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
	
	case "rag_forn"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"				
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_rag"
		ls_dwc[3] = "id_forn"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
	CASE "listino"
		If Not IsNull(Data) and data <> "" Then					
			ls_listino = data
			
			SELECT id_listino
			INTO	 :ll_id_listino
			FROM	 listino
			WHERE	 codice = :ls_listino;

			If SQLCA.SQLCODE = 0 Then			
				
				datawindowchild ldw_variazione
				dw_1.getchild("id_variazione", ldw_variazione)
				ldw_variazione.settransobject(sqlca)				
				ldw_variazione.retrieve()
				ls_filt = "id_listino = " + string(ll_id_listino)
				ldw_variazione.setfilter(ls_filt)
				ldw_variazione.filter()
				
				
				Long ll_id_variazione
				
				DECLARE c_variazione CURSOR FOR 
					SELECT id_variazione
					FROM	 variazione
					WHERE	 id_listino = :ll_id_listino
					AND	 data_inizio <= today(*)
					AND	 (data_fine >= today(*) OR data_fine IS NULL)
					;
					
			   OPEN c_variazione;
					FETCH NEXT c_variazione INTO :ll_id_variazione;
				CLOSE c_variazione;
				
				dw_1.SetItem(1, "id_variazione", ll_id_variazione)
			End If			
		Else
			String ls_null
			
			SetNull(ls_null)
			dw_1.SetItem(1, "id_variazione", '')

		End If
END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "cod_forn"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	CASE "rag_forn"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"			
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol			
	CASE "cod_forn"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_forn", is_ricpar.s_id_seg_value[1])
		uf_set_colval("rag_forn", is_ricpar.s_ausil_value[1])
				
	case "rag_forn"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_forn",is_ricpar.s_id_seg_value[1])
			uf_set_colval("cod_forn", is_ricpar.s_ausil_value[1])			
END CHOOSE 
end event

type cb_1 from commandbutton within w_import_list
int X=37
int Y=1184
int Width=407
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Parametri Listino"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_fab

ls_fab = dw_1.getitemstring(1,"cod_fab")
if not isnull(ls_fab) and ls_fab <> "" then
	openwithparm(w_imp_list_par,ls_fab)
end if
end event

type cb_2 from commandbutton within w_import_list
int X=530
int Y=108
int Width=407
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Lista Fabbricanti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_nomefile
long ll_row
integer li_pos

open(w_imp_list_fab)
ls_nomefile = message.stringparm
if not isnull(ls_nomefile) and ls_nomefile <> "" then
	li_pos = pos(ls_nomefile,".")
	ls_nomefile = left(ls_nomefile, (li_pos - 1))
	ll_row = dw_1.getrow()
	dw_1.setitem(ll_row,"cod_fab",ls_nomefile)
end if
end event

type cb_import from commandbutton within w_import_list
int X=2144
int Y=1180
int Width=251
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="IMPORTA"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_fab, ls_riga, ls_agg, ls_msg, ls_codice, ls_listino
integer li_app, li_eof, li_pos, li_len, li_ret
boolean lb_esiste
string ls_nomefile, ls_codart_pos, ls_codart_num, ls_desart_pos, ls_desart_num, ls_prz_pos, ls_prz_num, ls_iva_pos, ls_iva_num
integer li_codart_pos, li_codart_num, li_desart_pos, li_desart_num, li_prz_pos, li_prz_num, li_iva_pos, li_iva_num
string ls_codart, ls_desart, ls_prz, ls_iva, ls_stato
long ll_row, ll_id_listino, ll_id_articolo, ll_id_forn, ll_id_cat_cod, ll_id_cat_com_art, ll_id_tab_iva,ll_id_azienda
long ll_id_uc, ll_id_variazione
dec ld_prz
date ld_data

ll_row = dw_1.getrow()
ls_fab = dw_1.getitemstring(ll_row,"cod_fab")
ls_agg = dw_1.getitemstring(ll_row,"agg_sn")
ls_listino = dw_1.getitemstring(ll_row,"listino")
SELECT id_listino
INTO	 :ll_id_listino
FROM	 listino
WHERE	 codice = :ls_listino;
if isnull(ll_id_listino) then 
	messagebox("ATTENZIONE!","Specificare un listino")
	return
end if
ll_id_forn = dw_1.getitemnumber(ll_row,"id_forn")
if isnull(ll_id_forn) then 
	messagebox("ATTENZIONE!","Specificare un Fornitore contabile")
	return
end if
ll_id_cat_cod = dw_1.getitemnumber(ll_row,"id_cat_cod")
if isnull(ll_id_cat_cod) then 
	messagebox("ATTENZIONE!","Specificare una Categoria di codifica articoli")
	return
end if
ll_id_cat_com_art = dw_1.getitemnumber(ll_row,"id_cat_com_art")
if isnull(ll_id_cat_com_art) then 
	messagebox("ATTENZIONE!","Specificare una Categoria commerciale articoli")
	return
end if
ll_id_tab_iva = dw_1.getitemnumber(ll_row,"id_tab_iva")
if isnull(ll_id_tab_iva) then 
	messagebox("ATTENZIONE!","Specificare una Aliquota IVA")
	return
end if

select id_unita_conf_base
into :ll_id_uc
from par_sistema;
if isnull(ll_id_uc) then 
	messagebox("ATTENZIONE!","Specificare una Unità Confezione articoli")
	return
end if
ll_id_variazione = dw_1.getitemnumber(ll_row,"id_variazione")
if isnull(ll_id_variazione) then 
	messagebox("ATTENZIONE!","Specificare una Variazione listino articoli")
	return
end if

if not isnull(ls_fab) and ls_fab <> "" then
	
	open (w_attesa)
	ls_fab = "c:\cometa\" + ls_fab + ".prl"

	lb_esiste=fileexists(ls_fab)
	if lb_esiste=true then
		li_app=fileopen(ls_fab)	
		li_eof=0	
	
		do while li_eof<>-100 
			li_eof=fileread(li_app,ls_nomefile)
			li_eof=fileread(li_app,ls_codart)		
			li_eof=fileread(li_app,ls_desart)		
			li_eof=fileread(li_app,ls_prz)		
			li_eof=fileread(li_app,ls_iva)		
		loop
	
		fileclose(li_app)	
	
		li_pos = pos(ls_codart,"-")
		li_len = len(ls_codart)
		if li_pos <= 0 then
			ls_codart_pos = " "
			ls_codart_num = " "
		else
			ls_codart_pos = left  (ls_codart,(li_pos - 1))
			ls_codart_num = right (ls_codart,(li_len - li_pos))
		end if
	
		li_pos = pos(ls_desart,"-")
		li_len = len(ls_desart)
		if li_pos <= 0 then
			ls_desart_pos = " "
			ls_desart_num = " "
		else
			ls_desart_pos = left  (ls_desart,(li_pos - 1))
			ls_desart_num = right (ls_desart,(li_len - li_pos))
		end if	
	
		li_pos = pos(ls_prz,"-")
		li_len = len(ls_prz)
		if li_pos <= 0 then
			ls_prz_pos = " "
			ls_prz_num = " "
		else
			ls_prz_pos = left  (ls_prz,(li_pos - 1))
			ls_prz_num = right (ls_prz,(li_len - li_pos))
		end if		
		
		li_pos = pos(ls_iva,"-")
		li_len = len(ls_iva)
		if li_pos <= 0 then
			ls_iva_pos = " "
			ls_iva_num = " "
		else
			ls_iva_pos = left  (ls_iva,(li_pos - 1))
			ls_iva_num = right (ls_iva,(li_len - li_pos))
		end if	
	else
		close(w_attesa)	
		messagebox("ATTENZIONE!","Parametrizzazione non definita per il Fabbricante")
	end if
	
	
	ls_nomefile = "c:\cometa\" + ls_nomefile
	lb_esiste=fileexists(ls_nomefile)
	if lb_esiste=true then
		li_app=fileopen(ls_nomefile)	
		li_eof=0	
		
		
		li_codart_pos = integer(ls_codart_pos)
		li_codart_num = integer(ls_codart_num)
		li_desart_pos = integer(ls_desart_pos)
		li_desart_num = integer(ls_desart_num)
		li_prz_pos    = integer(ls_prz_pos)
		li_prz_num    = integer(ls_prz_num)
		li_iva_pos    = integer(ls_iva_pos)
		li_iva_num    = integer(ls_iva_num)
		
		DATASTORE ds_prz  
		ds_prz = CREATE DATASTORE
		ds_prz.DATAOBJECT = "ds_imp_upd_prz"
		ds_prz.SETTRANSOBJECT(SQLCA)		
	
		do while li_eof<>-100 
			li_eof=fileread(li_app,ls_riga)
			if li_eof <>-100 then
				ls_codart = mid(ls_riga,li_codart_pos,li_codart_num)
				ls_desart = mid(ls_riga,li_desart_pos,li_desart_num)
				ld_prz     = dec(mid(ls_riga,li_prz_pos,li_prz_num))
				ls_iva     = mid(ls_riga,li_iva_pos,li_iva_num)	
								
				ls_codart = trim(ls_codart)				
				DO
					li_pos = pos(ls_codart," ")
					if li_pos<>0 then ls_codart = replace(ls_codart,li_pos,1,"")
				LOOP UNTIL li_pos=0
				
				if ls_agg = 'S' then
					select id_articolo
					into :ll_id_articolo
					from articolo
					where codice = :ls_codart;
					if not isnull(ll_id_articolo) and sqlca.sqlcode = 0 then	
						wf_aggiorna(ll_id_listino, ll_id_articolo, ll_id_variazione, ds_prz, ld_prz)

					end if
				else
					select id_articolo
					into :ll_id_articolo
					from articolo
					where codice = :ls_codart;
					if not isnull(ll_id_articolo) and sqlca.sqlcode = 0 then	
						li_ret = wf_aggiorna(ll_id_listino, ll_id_articolo, ll_id_variazione, ds_prz, ld_prz)
						if li_ret = 0 then wf_inserisci(dw_1, ls_codart, ls_desart, ld_prz)
					else
						wf_inserisci(dw_1, ls_codart, ls_desart, ld_prz)		
					end if
				end if
			end if
		loop
	
	   destroy ds_prz
		
		fileclose(li_app)	

	else
		close(w_attesa)	
		ls_msg = "Non trovo il file listino " + ls_nomefile 
		messagebox("ATTENZIONE!",ls_msg)
	end if
	close(w_attesa)	
end if
end event

