forward
global type w_esistenza_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_esistenza_cx
end type
type tab_1 from tab within w_esistenza_cx
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
type cb_genera from commandbutton within w_esistenza_cx
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
cb_2 cb_2
end type
type tab_1 from tab within w_esistenza_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_esistenza_cx from w_wiz_main
int X=434
int Y=348
int Width=3264
int Height=1776
WindowType WindowType=response!
boolean TitleBar=true
string Title="Variazione dati Articolo"
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
tab_1 tab_1
cb_genera cb_genera
end type
global w_esistenza_cx w_esistenza_cx

type variables
DataWindow idw_source, idw_target,idw_modifica
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
Decimal idc_imp_max_distinta
integer li_status

end variables

forward prototypes
public function decimal wf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
public function decimal wf_trova_prezzo (long aid_unita_conf, decimal ad_qta, decimal ad_peso, decimal ad_prezzo)
end prototypes

public function decimal wf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita);
char		lch_sconto[], lch_item[]
long 		ll_char_size, ll_char_count, ll_item_count
decimal  ldc_parte,ldc_tot_riga
string  ls_parte
long ll_row, ll_pos_plus,ll_pos_minus, ll_pos
boolean lb_non_calcolabile, lb_minus
string ls_tot_riga

lb_minus= FALSE
lch_item = ""
ll_item_count=0
if IsNull(adc_prezzo) then adc_prezzo = 0
if not (IsNull(as_sconto) OR as_sconto= "") then
	lch_sconto= Trim(as_sconto)
	ll_char_size= UpperBound(lch_sconto)
	For ll_char_count= 1 to ll_char_size
		CHOOSE CASE lch_sconto[ll_char_count]
			CASE "-"
				If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if  ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = TRUE
			CASE "+"
					If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = FALSE
			CASE ELSE
				ll_item_count ++
				lch_item[ll_item_count]= lch_sconto[ll_char_count]
		END CHOOSE
	next


	If not(lch_item = "") then
		ldc_parte= Dec(lch_item)
		if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
		
			SetNull(ldc_parte)	
			RETURN ldc_parte
		else
			if lb_minus then
				adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
			else
				adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
			end if
		end if
	end if
end if

RETURN adc_prezzo

end function

public function decimal wf_trova_prezzo (long aid_unita_conf, decimal ad_qta, decimal ad_peso, decimal ad_prezzo);string ls_um, ls_tipo
decimal ld_prezzo

select simbolo, tipo
into :ls_um, :ls_tipo
from unita_confezione, unita_misura
where (unita_confezione.id_unita_confezione=:aid_unita_conf) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
choose case ls_tipo
	case "P"
		ld_prezzo=ad_peso*ad_prezzo
	case else 
		ld_prezzo=ad_qta*ad_prezzo
end choose
return ld_prezzo
end function

on w_esistenza_cx.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.tab_1=create tab_1
this.cb_genera=create cb_genera
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.cb_genera
end on

on w_esistenza_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.tab_1)
destroy(this.cb_genera)
end on

event open;call super::open;datawindowchild ldw_esercizio,ldw_attivita, ldw_magazzino, ldw_da_cat_com, ldw_a_cat_com
datawindowchild ldw_da_cat_com_2, ldw_a_cat_com_2

string maxcod,mincod,maxdes,mindes
long ll_select

tab_1.tabpage_2.dw_2.settransobject(sqlca)

tab_1.tabpage_1.dw_1.getchild("esercizio",ldw_esercizio)
ldw_esercizio.settransobject(sqlca)
ldw_esercizio.retrieve()

tab_1.tabpage_1.dw_1.getchild("attivita",ldw_attivita)
ldw_attivita.settransobject(sqlca)
ldw_attivita.retrieve()

tab_1.tabpage_1.dw_1.getchild("locazione",ldw_attivita)
ldw_magazzino.settransobject(sqlca)
ldw_magazzino.retrieve()

tab_1.tabpage_1.dw_1.GetChild("da_cat_com",ldw_da_cat_com)
tab_1.tabpage_1.dw_1.GetChild("a_cat_com",ldw_a_cat_com)

tab_1.tabpage_1.dw_1.GetChild("da_cat_com_2",ldw_da_cat_com_2)
tab_1.tabpage_1.dw_1.GetChild("a_cat_com_2",ldw_a_cat_com_2)

ldw_da_cat_com.SetTransObject(SQLCA)
ldw_da_cat_com.Retrieve()
ldw_a_cat_com.SetTransObject(SQLCA)
ldw_a_cat_com.Retrieve()

ldw_da_cat_com_2.SetTransObject(SQLCA)
ldw_da_cat_com_2.Retrieve()
ldw_a_cat_com_2.SetTransObject(SQLCA)
ldw_a_cat_com_2.Retrieve()


tab_1.tabpage_1.dw_1.insertrow(1)

select max(articolo.codice)
into :maxcod
from articolo;

select min(articolo.codice)
into :mincod
from articolo;

select descrizione
into :maxdes
from articolo
where articolo.codice=:maxcod;
select descrizione
into :mindes
from articolo
where articolo.codice=:mincod;


tab_1.tabpage_1.dw_1.setitem(1,'da_articolo',mincod)
tab_1.tabpage_1.dw_1.setitem(1,'da_articolo_des',mindes)
tab_1.tabpage_1.dw_1.setitem(1,'a_articolo',maxcod)
tab_1.tabpage_1.dw_1.setitem(1,'a_articolo_des',maxdes)

tab_1.tabpage_1.dw_1.setitem(1,'a_data',Today())
select id_esercizio
into :ll_select
from esercizio
where data_inizio<today() and data_fine>today();
tab_1.tabpage_1.dw_1.setitem(1,'esercizio',ll_select)

select id_attivita
into :ll_select
from azienda
where id_azienda=1;
tab_1.tabpage_1.dw_1.setitem(1,'attivita',ll_select)

li_status=1
end event

type cb_chiudi from commandbutton within w_esistenza_cx
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

type tab_1 from tab within w_esistenza_cx
event create ( )
event destroy ( )
int X=23
int Y=116
int Width=3182
int Height=1536
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

event selectionchanged;date ld_data
long ll_attivita, ll_esercizio, ll_locazione, ll_anno, ll_mese, ll_giorno, ll_primo, ll_secondo
string ls_da_articolo,ls_a_articolo
string ls_da_cat_com, ls_a_cat_com
long  ll_id_prof_doc, ll_magazzino, ll_id_art, ll_qta
string dw_filter, ls_esistenza, ls_locazione, ls_filter
decimal ld_esi_fisica, ld_esi_fiscale, ld_disp
integer ll_row, i, li_ret





if newindex=1 and (oldindex=2 or oldindex=3) then li_status=0
	  

if newindex=2 and oldindex=1 then
	   
		
				
		
			tab_1.tabpage_1.dw_1.accepttext()
			ls_da_articolo=tab_1.tabpage_1.dw_1.getitemstring(1,"da_articolo")
			ls_a_articolo=tab_1.tabpage_1.dw_1.getitemstring(1,"a_articolo")
			ld_data=tab_1.tabpage_1.dw_1.getitemdate(1,"a_data")
			ll_attivita=tab_1.tabpage_1.dw_1.getitemnumber(1,"attivita")
			ll_esercizio=tab_1.tabpage_1.dw_1.getitemnumber(1,"esercizio")
			ll_locazione=tab_1.tabpage_1.dw_1.getitemnumber(1,"id_locazione")
			ls_locazione=tab_1.tabpage_1.dw_1.getitemstring(1,"locazione")
			
			
			ls_da_cat_com=tab_1.tabpage_1.dw_1.getitemstring(1,"da_cat_com")
			ls_a_cat_com=tab_1.tabpage_1.dw_1.getitemstring(1,"a_cat_com")						
			
			
			if isnull(ls_da_articolo) or isnull(ls_a_articolo) then
				messagebox("Attenzione","Gli articoli di inizio e fine sono obbligatori")
				tab_1.SelectTab ( 1 )
				return
			end if
				
			if ls_da_articolo>ls_a_articolo then
				messagebox("","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
				tab_1.SelectTab ( 1 )
				return
			end if
			
			
			if ls_da_cat_com>ls_a_cat_com then
				messagebox("","Il codice cat.com. iniziale è maggiore di quello finale",exclamation!)
				tab_1.SelectTab ( 1 )
				return
			end if
			
			
			if isnull(ld_data) then
				messagebox("","La data non può essere nulla",exclamation!)
				tab_1.SelectTab ( 1 )
				return
			end if
			
			if isnull(ll_esercizio) then
				messagebox("","Non è stato selezionato nessun esercizio",exclamation!)
				tab_1.SelectTab ( 1 )
				return
			end if	
			
			if isnull(ll_attivita) then
				messagebox("","Non è stata selezionata nessuna attività",exclamation!)
				tab_1.SelectTab ( 1 )
				return
			end if	
			
			
			if isnull(ls_locazione) then
				messagebox("","Non è stata selezionata nessun magazzino",exclamation!)
				tab_1.SelectTab ( 1 )
				return
			end if
			
		    
			if li_status=1 then 
			 
			ll_anno=year(ld_data)
			ll_mese=Month (ld_data)
			ll_giorno=Day(ld_data)


			
         
			li_ret=tab_1.tabpage_2.dw_2.Retrieve(ls_a_articolo, ls_da_articolo, ll_anno, ll_attivita, ll_locazione, ls_da_cat_com, ls_a_cat_com)						

		
			ll_primo=0
			ll_row=tab_1.tabpage_2.dw_2.rowcount()
			
			if ll_row>0 then
				
				cb_genera.enabled = true 
				
				for i=1 to ll_row 
					ll_secondo=tab_1.tabpage_2.dw_2.getitemnumber(i,"id_articolo")
					if ll_primo=ll_secondo then 
						
						ll_qta=tab_1.tabpage_2.dw_2.getitemnumber(i,'qta_ord_clienti') + tab_1.tabpage_2.dw_2.getitemnumber(i - 1,'qta_ord_clienti')
						tab_1.tabpage_2.dw_2.setitem(i - 1,'qta_ord_clienti',ll_qta)
						ll_qta=tab_1.tabpage_2.dw_2.getitemnumber(i,'qta_ord_fornitori') + tab_1.tabpage_2.dw_2.getitemnumber(i - 1,'qta_ord_fornitori')
						tab_1.tabpage_2.dw_2.setitem(i - 1,'qta_ord_fornitori',ll_qta)
						tab_1.tabpage_2.dw_2.deleterow(i)
						ll_row=ll_row - 1
						i=i - 1
			      else
						SELECT fn_esi_disp(1, :ll_secondo, :ll_locazione, :ll_anno, :ll_mese, :ll_id_prof_doc) AS esistenza, CAST(SUBSTR(esistenza, 1, 20) AS NUMERIC(18,4)), CAST(SUBSTR(esistenza, 21, 20) AS NUMERIC(18,4)), CAST(SUBSTR(esistenza, 41, 20) AS NUMERIC(18,4))
						INTO	 :ls_esistenza, :ld_esi_fisica, :ld_esi_fiscale, :ld_disp
						FROM	 SYS.DUMMY
						;
						
						If SQLCA.SQLCODE = 100 Then
							Return
						ElseIf SQLCA.SQLCODE = -1 Then
							MessageBox("", SQLCA.SQLErrText)
							Return
						End if	
						tab_1.tabpage_2.dw_2.SetItem(i, "c_esistenza", ld_esi_fiscale)
						tab_1.tabpage_2.dw_2.SetItem(i, "c_esistenza_fisica", ld_esi_fisica)
						tab_1.tabpage_2.dw_2.SetItem(i, "c_disponibilita", ld_disp)	
						ll_primo=ll_secondo
					end if	
				next
			else 	
				cb_genera.enabled = false 
			end if
			
			
		ls_filter= 'c_esistenza_fisica > 0'
		tab_1.tabpage_2.dw_2.setfilter(ls_filter)
		li_ret=tab_1.tabpage_2.dw_2.filter()

	end if

end if


			
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3145
int Height=1416
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
int X=69
int Y=76
int Width=2597
int Height=1300
int TabOrder=20
boolean BringToTop=true
string DataObject="d_filtra_esistenza_cx"
end type

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[], ls_tipo_documento, ls_sql, ls_sog_cod, ls_sog_rag
long ll_null
long ll_id_prof_prop

setnull(ll_null)
ls_tipo_documento = "D"

choose case dwo.name
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
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_magazzino"		
		ls_dwc[1] = "id_locazione"
		
		li_ok = uf_autofind_col(dwo.Name, "magazzino", "id_magazzino", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	CASE 'c_prof_doc_cod'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "c_prof_doc_cod"
		ls_dwc[2] = "c_prof_doc_des"
		ls_dwc[3] = "id_prof_documento"

		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"codice","A",data,ls_sql,3,ls_dbc,ls_dbv,ls_dwc)
		
	CASE 'c_prof_doc_des'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "c_prof_doc_cod"
		ls_dwc[2] = "c_prof_doc_des"
		ls_dwc[3] = "id_prof_documento"
		
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"descrizione","A",data,ls_sql,3,ls_dbc,ls_dbv,ls_dwc)
		
	CASE "sog_com_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
			
	case "sog_com_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
end choose


li_status=1
end event

event ue_set_search;string ls_tipo_documento

ls_tipo_documento = 'D'

choose case as_nomecol
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
		
	CASE "c_prof_doc_cod"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
		
	CASE "c_prof_doc_des"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_descrizione" 
		
		
	CASE "sog_com_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"
	CASE "sog_com_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"			
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"		
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
		
	CASE "c_prof_doc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_doc_des", is_ricpar.s_ausil_value[1])
	
	CASE "c_prof_doc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_doc_cod", is_ricpar.s_ausil_value[1])
	
	CASE "sog_com_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_com_des", is_ricpar.s_ausil_value[1])
		
	case "sog_com_des"
   	uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale",is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_com_cod", is_ricpar.s_ausil_value[1])			
		
end choose

li_status=1
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3145
int Height=1416
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
int Height=1272
int TabOrder=30
boolean BringToTop=true
string DataObject="d_st_esistenza"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;
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

type cb_genera from commandbutton within w_esistenza_cx
int X=2226
int Y=16
int Width=608
int Height=88
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text="Genera Doc. di CARICO..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_reg_car, ll_id_reg_scar, ll_id_prof_car, ll_id_prof_scar, ll_num_prog, ll_id_sog_com, ll_id_valuta
long ll_id_art, ll_id_doc, ll_id_u_conf, ll_riga, i, ll_id_caus_car, ll_id_caus_scar, ll_id_locazione, ll_totrows
long ll_id_eser, ll_id_tab_iva, ll_id_sog_com_2, ll_id_mod_reg
long ll_id_con_pag, ll_id_banca_sc
decimal{2} ld_quantita
date ld_data_reg=Today()
string ls_des_art, ls_tipo_registro, ls_num_documento
boolean errore=false
integer cont

string 			ls_tipo_applicazione		
STRING			LS_SQL_SCRIPT				
STRING			ls_app						
string 			ls_quantita
long 				ll_riga_corrente
date 				ldt_data_attuale			
long				ll_id_U_C_in_esame		
long 				ll_sog_com					
decimal{4}		ld_prezzo, ld_prezzo_app					
string    		ls_sconto	
decimal{4}		ld_sconto_riga
long 				ll_listino					
string			ls_percentuali				
long				ll_id_cat_com_sc			
long				ll_id_art_in_esame		
long 				ll_id_cat_com_articolo	
decimal{4}		ld_qta						
long           ll_sog_com_fornitore		
long 				ll_id_produttore			
long				ll_id_listino				
string			ls_qta
long				ll_pos
long 				ll_id_registro
string 			ls_cod_art_in_esame		
long 				ll_id_magazzino
Long				ll_id_destinazione		
String			ls_con_listino				
Integer			li_pos_cond					
Long				ll_con_listino				
date				ldt_data_documento

decimal		ld_QTA_SM, ld_Sconti, ld_Totale_Riga
decimal		ld_Cambio, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
decimal		ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val,ld_peso
string		ls_tipoconv, ls_tipo_arrotondamento
decimal		ld_fatconv,  ld_molt, ld_cambio_riga, ld_cambio_documento
long			ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot, ll_id_valuta_prop, ll_id_locaz1, ll_id_locaz2
long ll_id_magazzino_1_prop, ll_id_magazzino_2_prop
decimal{4} ldc_totale_riga, ldc_val_attribuito, ldc_Totale_Riga_Lire, ld_fatglob, ld_QTA_UB, ld_Prezzo_Netto 
string ls_prezzo
long ll_valuta, ll_id_var
integer li_pos
string ls_lis_variazione, ls_tras_mezzo				

ll_totrows = tab_1.tabpage_2.dw_2.rowcount()
if ll_totrows > 0 then

	
	
	

	w_search_main		lw_sm
	long					ll_i_fronte, ll_row
	s_ric_param			ls_ricpar

	ls_ricpar.s_filter_name = "cc_locazione_mag"
	ls_ricpar.s_filter_value=""
	OpenWithParm (lw_sm, ls_ricpar, "w_locazione_sw")
	ls_ricpar = Message.PowerObjectParm

	IF UpperBound(ls_ricpar.s_id_seg_value) > 0 THEN
		ll_id_locazione = long(ls_ricpar.s_id_seg_value[1])
		
		
		
		
		
		
		
	end if
	
	
	if isnull(ll_id_locazione) or ll_id_locazione = 0 then return 

	ll_id_prof_car  = tab_1.tabpage_1.dw_1.getitemnumber(1,"id_prof_documento")    
	ll_id_eser      = tab_1.tabpage_1.dw_1.getitemnumber(1,"esercizio")
	ll_id_sog_com   = tab_1.tabpage_1.dw_1.getitemnumber(1,"id_sog_commerciale") 
	
	select tipo_registro, id_sog_comm_prop, id_caus_magazzino_prop, id_mod_registro_prop, id_valuta_prop,
	       id_locazione_1_prop, id_locazione_2_prop
	into :ls_tipo_registro, :ll_id_sog_com_2, :ll_id_caus_car, :ll_id_mod_reg, :ll_id_valuta_prop,
	     :ll_id_locaz1, :ll_id_locaz2
	from prof_documento
	where prof_documento.id_prof_documento=:ll_id_prof_car;
	
	
	setnull(ll_id_magazzino_1_prop)
	select id_magazzino
	into :ll_id_magazzino_1_prop
	from locazione
	where id_locazione=:ll_id_locaz1;
	if isnull(ll_id_magazzino_1_prop) then setnull(ll_id_magazzino_1_prop)
	setnull(ll_id_magazzino_2_prop)
	select id_magazzino
	into :ll_id_magazzino_2_prop
	from locazione
	where id_locazione=:ll_id_locaz2;
	if isnull(ll_id_magazzino_2_prop) then setnull(ll_id_magazzino_2_prop)
	
	if not isnull(ll_id_magazzino_1_prop) then 
		ll_id_magazzino = ll_id_magazzino_1_prop
	else
		ll_id_magazzino = ll_id_magazzino_2_prop		
	end if

	
	SELECT Max("registro"."id_registro")
	INTO :ll_id_reg_car  
	FROM "dba"."registro"  
	WHERE ( "registro"."id_esercizio" = :ll_id_eser ) AND  
	( "registro"."id_mod_registro" = :ll_id_mod_reg )   ;
	
	if IsNull(ll_id_sog_com) or (ll_id_sog_com=0) then ll_id_sog_com = ll_id_sog_com_2
	
	if IsNull(ll_id_prof_car)or(ll_id_prof_car=0) then
		messagebox('Errore!', 'Impossibile trovare Profilo di Carico')		
		return
	end if
	
	if IsNull(ll_id_reg_car)or(ll_id_reg_car=0) then 
		messagebox('Errore!', 'Impossibile trovare Registro di Carico')
		return
	end if

	if IsNull(ll_id_caus_car)or(ll_id_caus_car=0) then
		messagebox('Errore!', 'Impossibile trovare Causale di Carico')				
		return
	end if
	
	if IsNull(ll_id_sog_com)or(ll_id_sog_com=0) then
		messagebox('Errore!', 'Impossibile trovare Sogg. Comm. ')				
		return
	end if
	
	if isnull(ll_id_valuta_prop) or ll_id_valuta_prop =0 then
		
		select id_valuta
		into :ll_id_valuta
		from esercizio
		where id_esercizio = :ll_id_eser;
		if IsNull(ll_id_valuta)or(ll_id_valuta=0) then
			messagebox('Errore!', 'Impossibile trovare Valuta Esercizio')		
			return
		end if		
		
	else 
		ll_id_valuta = ll_id_valuta_prop
	end if
	
	SELECT "valuta"."cifra_arrotondamento",
	"valuta"."tipo_arrotondamento"
	INTO :ll_nr_cifre_arrot ,
	  	  :ls_tipo_arrotondamento
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta;
	
	
	select id_con_pagamento, id_banca_sog_commerciale
	into :ll_id_con_pag, :ll_id_banca_sc
	from sog_commerciale
	where id_sog_commerciale = :ll_id_sog_com;
	
	
	select id_cat_com_sc, id_listino
	into :ll_id_cat_com_sc, :ll_id_listino
	from sog_commerciale
	where id_sog_commerciale = :ll_id_sog_com;
	if isnull(ll_id_cat_com_sc) then ll_id_cat_com_sc=0
	if isnull(ll_id_listino) then ll_id_listino=0	
	
	
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	
	where documento.id_registro=:ll_id_reg_car;
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	
	
	If right(ls_tipo_registro, 1)="V" or right(ls_tipo_registro, 1)="C" then
		ls_num_documento = f_Proponi_Num_Documento_Anno(ll_id_reg_car, Year(ld_data_reg))
	else
		ls_num_documento = ""
	end if	
	
	
	insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
							documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino, documento.id_locazione_1,
							documento.id_con_pagamento, documento.id_banca_sog_commerciale, documento.num_documento, documento.data_documento,
							documento.stampato, documento.contabilizzato, documento.evaso_totalmente, documento.chius_forzata, 
							documento.sospeso, documento.creato_in_esenzione, documento.bloccato, documento.tipo_fattura,
							documento.id_magazzino)
	values (:ll_id_prof_car, :ll_id_reg_car, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus_car, :ll_id_locazione,
   	     :ll_id_con_pag, :ll_id_banca_sc, :ls_num_documento, :ld_data_reg, 
			  'N','N','N','N','N','N','N', 'N',:ll_id_magazzino);	
		
	if sqlca.sqlcode<>0 then
		messagebox("Errore", "Documento di carico non creato")
		errore=true		
		rollback;
		return
	else
		commit;
	end if

	select Max(id_documento)
	into :ll_id_doc
	from documento;

	FOR i=1 TO ll_totrows
		ll_id_art   = tab_1.tabpage_2.dw_2.getitemnumber(i,"articolo_id_articolo")
		ls_des_art  = tab_1.tabpage_2.dw_2.getitemstring(i,"articolo_descrizione")		
		ld_quantita = tab_1.tabpage_2.dw_2.getitemnumber(i,"c_esistenza_fisica")
		ll_id_tab_iva = tab_1.tabpage_2.dw_2.getitemnumber(i,"id_tab_iva") 
		
		
		ls_app= right(ls_tipo_registro, 1)
		
		
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
	
		select id_unita_confezione
		into :ll_id_u_conf
		from unita_confezione
		where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');	
		
		
		SELECT fat_conversione, molteplicita, tipo_conversione
		INTO	 :ld_fatconv, :ld_molt, :ls_tipoconv
		FROM	 unita_confezione
		WHERE  id_unita_confezione = :ll_id_u_conf;
		
	
		for cont = 1 to 5
			if cont=1 then ls_tipo_applicazione="P"
			if cont=2 then ls_tipo_applicazione="R"
			if cont=3 then ls_tipo_applicazione="S"
			if cont=4 then ls_tipo_applicazione="D"
			if cont=5 then ls_tipo_applicazione="U"
	
			ll_id_var=0
			ll_id_destinazione=0
			ls_tras_mezzo = ''
					
			ls_prezzo=f_recupera_prezzo_listino(ls_app, ll_id_u_conf, ll_id_sog_com,ll_id_cat_com_sc, ls_cod_art_in_esame, & 
							ll_id_cat_com_articolo,	ll_sog_com_fornitore, ll_id_produttore,& 
							ld_quantita, ls_tipo_applicazione, ll_id_art, ll_id_locazione, ll_id_valuta, ll_id_listino, ll_id_var, &
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
					
			if cont=1  then 
				ld_prezzo_app=dec(ls_prezzo)
				if ld_prezzo_app > 0 then ld_prezzo=ld_prezzo_app
				
	
			elseif cont=2 then
				ld_prezzo_app=dec(ls_prezzo)				
				if ld_prezzo_app > 0 then ld_sconto_riga = ld_prezzo_app * ld_quantita
				
			elseif cont=3 then
				ls_sconto = ls_prezzo

			elseif cont=4 then

			elseif cont=5 then
				ld_prezzo_app=dec(ls_prezzo)
				if ld_prezzo_app > 0 then ld_prezzo=ld_prezzo_app
			end if
		next		
		
		
		if ld_quantita > 0 then
			
			ll_row= i
			SetNull(lcd_null)

			if ls_tipoconv = "D" then
				if ld_fatconv <> 0 then
					ld_fatglob = 1/ld_fatconv
				else
					ld_fatglob = 0
				end if
			else
				ld_fatglob = ld_fatconv
			end if
			ld_fatglob = ld_fatglob * ld_molt

			ld_QTA = ld_quantita
			if IsNull(ld_QTA) then ld_QTA=0
			ld_QTA_UB= ld_QTA * ld_Fatglob
			if IsNull(ld_Prezzo) then ld_prezzo = 0

			if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
			ld_cambio_riga = 1
			ld_Prezzo_Netto= wf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)
			ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
			if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0

			if not IsNull(ld_Prezzo_Netto) then 
				ld_qta_Effettiva= ld_quantita 
				ldc_Totale_Riga= wf_trova_prezzo(ll_id_u_conf, ld_qta_Effettiva, 0, ld_Prezzo_Netto)

				ldc_Totale_Riga= f_Round(ldc_Totale_Riga ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
	         ldc_val_attribuito = ldc_Totale_Riga / ld_qta_Effettiva

				ldc_Totale_Riga_Lire= ldc_Totale_Riga * ld_Cambio_riga 
			else
				ld_Prezzo_Netto=0
				ldc_totale_riga = 0
				ldc_totale_riga_lire = 0			
			end if
					
			insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
							riga_documento.id_articolo, riga_documento.quantita,
							riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.id_locazione_1, 
							riga_documento.id_caus_magazzino, riga_documento.fat_con_unita_base,
							riga_documento.fat_con_globale, riga_documento.qta_un_base, riga_documento.id_tab_iva,
							riga_documento.id_listino, riga_documento.id_con_lis_articolo, riga_documento.prezzo,
							riga_documento.sconto, riga_documento.sconto_riga, 
							riga_documento.prezzo_netto, riga_documento.tot_riga_val_riga,
							riga_documento.val_attribuito, riga_documento.tot_riga_val_az, riga_documento.tot_riga_val_doc)
			values (:ll_id_doc, :i, :ll_id_valuta, :ll_id_art, :ld_quantita, :ls_des_art, 
					:ll_id_u_conf, :ll_id_locazione, :ll_id_caus_car, 1, :ld_fatglob, :ld_QTA_UB, :ll_id_tab_iva, :ll_id_var,
					:ll_con_listino, :ld_prezzo, :ls_sconto, :ld_sconto_riga, :ld_prezzo_netto, :ldc_Totale_Riga,
					:ldc_val_attribuito, :ldc_Totale_Riga_Lire, :ldc_Totale_Riga);		

	   end if
	NEXT				
	
	if sqlca.sqlcode<>0 then
		
		messagebox("Errore", "Riga documento di carico non creato")
		errore=true		
		rollback;
	else
		commit;
		
		messagebox("Informazione","Generato Doc. di Carico N. " + string(ll_num_prog) + " del " + string(ld_data_reg))
	end if

	
end if	


end event

