forward
global type w_filtro_stampa_esistenza_wz from Window
end type
type st_esercizio from statictext within w_filtro_stampa_esistenza_wz
end type
type cb_stampa from commandbutton within w_filtro_stampa_esistenza_wz
end type
type cb_ok from commandbutton within w_filtro_stampa_esistenza_wz
end type
type dw_external from u_dw_ext_main within w_filtro_stampa_esistenza_wz
end type
type r_1 from rectangle within w_filtro_stampa_esistenza_wz
end type
end forward

shared variables

end variables

global type w_filtro_stampa_esistenza_wz from Window
int X=330
int Y=377
int Width=3036
int Height=1573
boolean TitleBar=true
string Title="Filtro Esistenza"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_esercizio st_esercizio
cb_stampa cb_stampa
cb_ok cb_ok
dw_external dw_external
r_1 r_1
end type
global w_filtro_stampa_esistenza_wz w_filtro_stampa_esistenza_wz

type variables
string flag_date
end variables

on w_filtro_stampa_esistenza_wz.create
this.st_esercizio=create st_esercizio
this.cb_stampa=create cb_stampa
this.cb_ok=create cb_ok
this.dw_external=create dw_external
this.r_1=create r_1
this.Control[]={ this.st_esercizio,&
this.cb_stampa,&
this.cb_ok,&
this.dw_external,&
this.r_1}
end on

on w_filtro_stampa_esistenza_wz.destroy
destroy(this.st_esercizio)
destroy(this.cb_stampa)
destroy(this.cb_ok)
destroy(this.dw_external)
destroy(this.r_1)
end on

event open; datawindowchild dw_esercizio
 long ll_id,row,i,appoggio,ret,ll_id_esercizio
 string ls_codice,ls_bloccato
 date ld_data_i,ld_data_f
 
 
dw_external.insertrow(0)
dw_external.setfocus()
dw_external.getchild("id_esercizio",dw_esercizio)
dw_esercizio.settransobject(sqlca)
dw_esercizio.retrieve()
select azienda.id_esercizio_proposto
into :ll_id
from azienda
where azienda.id_azienda=1;


dw_external.setitem(1,"id_esercizio",ll_id)
dw_external.accepttext()
		ll_id_esercizio=dw_external.getitemnumber(1,"id_esercizio")
		select esercizio.codice,esercizio.data_inizio,esercizio.data_fine,esercizio.bloccato
		into :ls_codice,:ld_data_i,:ld_data_f,:ls_bloccato
		from esercizio
		where esercizio.id_esercizio=:ll_id_esercizio;
		
		if ll_id_esercizio > 0 then
	st_esercizio.text = 	" ESERCIZIO   "+ls_codice+" ~r~n "+&
							" DATA INIZIO "+string(ld_data_i)+" ~r~n "+&
							" DATA  FINE  "+string(ld_data_f)+"~r~n "+&
							"BLOCCATO> "+ls_bloccato 
			end if
		

end event

type st_esercizio from statictext within w_filtro_stampa_esistenza_wz
int X=1093
int Y=237
int Width=1084
int Height=305
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_stampa from commandbutton within w_filtro_stampa_esistenza_wz
int X=2442
int Y=33
int Width=243
int Height=85
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long 		ll_row	
ll_row = dw_external.getrow()
string 	ls_parametri,ls_parsel
string 	ls_appoggio
str_fil_flag str_param

if flag_date='S' then 
	messagebox("Attenzione","Il mese e l'anno specificato non rientrano nel periodo compreso dall'esercizio")
else

ls_appoggio  = string(dw_external.getitemnumber(ll_row,"id_esercizio"))
if isnull(ls_appoggio) then ls_appoggio = "1"
ls_parametri = "("+ls_appoggio+")"

ls_appoggio  = string(dw_external.getitemnumber(ll_row,"mese"))
if isnull(ls_appoggio) then ls_appoggio = "12"
ls_parametri = ls_parametri + "("+ls_appoggio+")"

ls_appoggio = string(dw_external.getitemnumber(ll_row,"anno"))
if isnull(ls_appoggio) then ls_appoggio = "4000"
if len ( ls_appoggio ) < 4 then ls_appoggio = left ( string(year(today())), 4 - len(ls_appoggio) ) + ls_appoggio
ls_parametri = ls_parametri + "("+ls_appoggio+")"

ls_appoggio = string(dw_external.getitemstring(ll_row,"articolo_da_codice"))
if isnull(ls_appoggio) then 
	ls_appoggio = "0"
else
ls_parsel='Da articolo: '+ls_appoggio	
end if
ls_parametri = ls_parametri + "("+ls_appoggio+")"


ls_appoggio = string(dw_external.getitemstring(ll_row,"articolo_a_codice"))
if isnull(ls_appoggio) then
	ls_appoggio = "Z"
else
ls_parsel=ls_parsel+' - A articolo: '+ls_appoggio	
end if
ls_parametri = ls_parametri + "("+ls_appoggio+")"

ls_appoggio = string(dw_external.getitemstring(ll_row,"produttore_da_codice"))
if isnull(ls_appoggio) then
	ls_appoggio = "0"
else
ls_parsel=ls_parsel+' - Da produttore: '+ls_appoggio	
end if
ls_parametri = ls_parametri + "("+ls_appoggio+")"

ls_appoggio = string(dw_external.getitemstring(ll_row,"produttore_a_codice"))
if isnull(ls_appoggio) then 
	ls_appoggio = "Z"
else
ls_parsel=ls_parsel+' - A produttore: '+ls_appoggio	
end if
ls_parametri = ls_parametri + "("+ls_appoggio+")"

ls_appoggio = string(dw_external.getitemstring(ll_row,"magazzino_da_codice"))
if isnull(ls_appoggio) then 
	ls_appoggio = "0"
else
ls_parsel=ls_parsel+' - Da magazzino: '+ls_appoggio	
end if
ls_parametri = ls_parametri + "("+ls_appoggio+")"

ls_appoggio = "("+string(dw_external.getitemstring(ll_row,"magazzino_a_codice"))
if isnull(ls_appoggio) then 
	ls_appoggio = "Z"
else
ls_parsel=ls_parsel+' - A magazzino: '+ls_appoggio	
end if
ls_parametri = ls_parametri + "("+ls_appoggio+")"
str_param.filtro=ls_parametri
str_param.parametri=ls_parsel

OpenWithParm ( w_stampa_esistenza_cx, str_param )
end if
end event

type cb_ok from commandbutton within w_filtro_stampa_esistenza_wz
int X=2757
int Y=33
int Width=243
int Height=85
int TabOrder=20
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_external from u_dw_ext_main within w_filtro_stampa_esistenza_wz
int X=23
int Y=145
int Width=2963
int Height=1321
int TabOrder=30
string DataObject="d_filtro_stampa_esistenza_wz"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "articolo_da_codice"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice"
	CASE "articolo_da_descrizione"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	CASE "articolo_a_codice"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice"
	CASE "articolo_a_descrizione"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	CASE "produttore_da_codice"
		is_search_window = "w_anagrafica_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1"
		
	CASE "produttore_a_codice"
		is_search_window = "w_anagrafica_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1"
		
	CASE "magazzino_da_codice"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice"
		
	CASE "magazzino_da_codice"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione"
	
	CASE "magazzino_a_codice"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice"
		
	CASE "magazzino_a_codice"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione"
	
End Choose
end event

event ue_use_search;call super::ue_use_search;
choose CASE as_nomecol
	CASE "articolo_da_codice"
		uf_set_colval ( "articolo_da_codice", 			is_ricpar.s_main_value )
		uf_set_colval ( "articolo_da_descrizione",	is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_articolo_da",				is_ricpar.s_id_seg_value[1] )
		
	CASE "articolo_da_descrizione"
		uf_set_colval ( "articolo_da_descrizione", 	is_ricpar.s_main_value )
		uf_set_colval ( "articolo_da_codice",			is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_articolo_da",				is_ricpar.s_id_seg_value[1] )
		
	CASE "articolo_a_codice"
		uf_set_colval ( "articolo_a_codice", 			is_ricpar.s_main_value )
		uf_set_colval ( "articolo_a_descrizione",		is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_articolo_a",					is_ricpar.s_id_seg_value[1] )
		
	CASE "articolo_a_descrizione"
		uf_set_colval ( "articolo_a_descrizione", 	is_ricpar.s_main_value )
		uf_set_colval ( "articolo_a_codice",			is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_articolo_a",					is_ricpar.s_id_seg_value[1] )
		
	CASE "produttore_da_codice"
		uf_set_colval ( "produttore_da_codice",	 	is_ricpar.s_main_value )
		uf_set_colval ( "produttore_da_descrizione",	is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_anagrafica_da",				is_ricpar.s_id_seg_value[1] )
		
	CASE "produttore_a_codice"
		uf_set_colval ( "produttore_a_codice",	 		is_ricpar.s_main_value )
		uf_set_colval ( "produttore_a_descrizione",	is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_anagrafica_a",				is_ricpar.s_id_seg_value[1] )
		
	CASE "magazzino_da_codice"
		uf_set_colval ( "magazzino_da_codice", 			is_ricpar.s_main_value )
		uf_set_colval ( "magazzino_da_descrizione",		is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_magazzino_da",					is_ricpar.s_id_seg_value[1] )
		
	CASE "magazzino_da_descrizione"
		uf_set_colval ( "magazzino_da_descrizione", 	is_ricpar.s_main_value )
		uf_set_colval ( "magazzino_da_codice",			is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_magazzino_da",				is_ricpar.s_id_seg_value[1] )
		
	CASE "magazzino_a_codice"
		uf_set_colval ( "magazzino_a_codice", 				is_ricpar.s_main_value )
		uf_set_colval ( "magazzino_a_descrizione",		is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_magazzino_a",					is_ricpar.s_id_seg_value[1] )
		
	CASE "magazzino_a_descrizione"
		uf_set_colval ( "magazzino_a_descrizione", 	is_ricpar.s_main_value )
		uf_set_colval ( "magazzino_a_codice",			is_ricpar.s_ausil_value[1] )
		uf_set_colval ( "id_magazzino_a",				is_ricpar.s_id_seg_value[1] )
end choose
end event

event itemchanged;call super::itemchanged;long ll_anno, ll_mese
long ll_id_esercizio
long ll_esercizio
string ls_appoggio,ls_bloccato
string ls_data, ls_codice
date ld_data, ld_data_i, ld_data_f
integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
this.accepttext()
ll_anno = this.getitemnumber(row,"anno")
ll_mese = this.getitemnumber(row,"mese")

		ll_id_esercizio=this.getitemnumber(row,"id_esercizio")
		select esercizio.codice,esercizio.data_inizio,esercizio.data_fine,esercizio.bloccato
		into :ls_codice,:ld_data_i,:ld_data_f,:ls_bloccato
		from esercizio
		where esercizio.id_esercizio=:ll_id_esercizio;
		
choose case dwo.name
	case "id_esercizio"
		
		if ll_id_esercizio > 0 then
	st_esercizio.text = 	" ESERCIZIO   "+ls_codice+" ~r~n "+&
							" DATA INIZIO "+string(ld_data_i)+" ~r~n "+&
							" DATA  FINE  "+string(ld_data_f)+"~r~n "+&
							"BLOCCATO> "+ls_bloccato 
			end if
		
		
		
		
	case "mese"
		if not isnull(ll_anno) then
			ls_appoggio = string(ll_anno)			
			if len ( ls_appoggio ) < 4 then ls_appoggio = left ( string(year(today())), 4 - len(ls_appoggio) ) + ls_appoggio
			ls_data = "01/"+string(data)+"/"+ls_appoggio
			ld_data = date(ls_data)
			end if
		
			
	case "anno"
		if not isnull(ll_mese) then
			ls_appoggio = data			
			if len ( ls_appoggio ) < 4 then ls_appoggio = left ( string(year(today())), 4 - len(ls_appoggio) ) + ls_appoggio
			ls_data = "01/"+string(ll_mese)+"/"+ls_appoggio
			ld_data = date(ls_data)
		end if
	
	case "articolo_da_codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "articolo_da_codice"
		ls_dwc[2] = "articolo_da_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "articolo_a_codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "articolo_a_codice"
		ls_dwc[2] = "articolo_a_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		case "articolo_da_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "articolo_da_codice"
		ls_dwc[2] = "articolo_da_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "articolo_a_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "articolo_a_codice"
		ls_dwc[2] = "articolo_a_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
		
		
		
	case "produttore_da_codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "produttore_da_codice"
		ls_dwc[2] = "produttore_da_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "anagrafica", "rag_soc1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "produttore_da_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "produttore_da_codice"
		ls_dwc[2] = "produttore_da_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "anagrafica", "rag_soc2", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		case "produttore_a_codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "produttore_a_codice"
		ls_dwc[2] = "produttore_a_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "anagrafica", "rag_soc1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "produttore_a_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "produttore_a_codice"
		ls_dwc[2] = "produttore_a_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "anagrafica", "rag_soc2", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "magazzino_da_codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "magazzino_da_codice"
		ls_dwc[2] = "magazzino_da_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "magazzino", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "magazzino_da_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "magazzino_da_codice"
		ls_dwc[2] = "magazzino_da_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "magazzino", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		case "magazzino_a_codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "magazzino_a_codice"
		ls_dwc[2] = "magazzino_a_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "magazzino", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "magazzino_a_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "magazzino_a_codice"
		ls_dwc[2] = "magazzino_a_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "magazzino", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose
if not isnull(ll_anno)and not isnull(ll_mese)and not(ld_data>=ld_data_i and ld_data<=ld_data_f) then 
	messagebox("Attenzione","Il mese e l'anno specificato non rientrano nel periodo compreso dall'esercizio")
flag_date='S'
else
	flag_date='N'
end if
end event

type r_1 from rectangle within w_filtro_stampa_esistenza_wz
int X=2309
int Y=361
int Width=165
int Height=145
boolean Enabled=false
int LineThickness=5
long LineColor=15793151
end type

