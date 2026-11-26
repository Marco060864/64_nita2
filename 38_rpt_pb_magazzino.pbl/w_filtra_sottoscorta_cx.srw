forward
global type w_filtra_sottoscorta_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_filtra_sottoscorta_cx
end type
type cb_annulla from commandbutton within w_filtra_sottoscorta_cx
end type
type dw_1 from u_dw_ext_main within w_filtra_sottoscorta_cx
end type
end forward

global type w_filtra_sottoscorta_cx from w_wiz_main
int Width=2738
int Height=984
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Scheda Anagrafica Articoli"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_filtra_sottoscorta_cx w_filtra_sottoscorta_cx

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE

long il_id_esercizio
date il_data_da
date il_data_a
integer ii_tab_seq
integer ii_tab_seq_num
date il_data_da_esr
date il_data_a_esr
string is_tipo_reg

end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
end prototypes

public function string uf_controlla_dati ();


string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret,ls_st_reg_iva,ls_st_reg2_iva
long ll_row,ll_n_registro
date ld_dalla_data,ld_alla_data

ll_row=dw_1.getrow()
ls_tipo_registro=dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=dw_1.getitemstring(ll_row,"elab_prova")




ls_ret='OK'
if ls_flag_registri='N' then
	
DECLARE ws_registri_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and  
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri_iva_cur;

FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri_iva_cur;


DECLARE ws_registri2_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and 
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri2_iva_cur ;

FETCH ws_registri2_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri2_iva_cur;
return ls_ret
else
	
	
	
	
	
DECLARE ws_registri3_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri3_iva_cur;

FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri3_iva_cur;


DECLARE ws_registri4_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri4_iva_cur ;

FETCH ws_registri4_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri4_iva_cur;
return ls_ret
end if

end function

public function date uf_prossimo_mese (readonly date data_attuale);integer mese,anno,day,giorni_mese
date nuova_data
anno=year(data_attuale)
mese=month(data_attuale)
if mese=12 then
	mese=1
	anno=anno+1
else
mese=mese+1
end if
day=day(data_attuale)


giorni_mese=f_gmese(mese,anno)
if day>giorni_mese then
	day=giorni_mese
end if

nuova_data=date(string(day)+"/"+string(mese)+"/"+string(anno))
return nuova_data
end function

on w_filtra_sottoscorta_cx.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_filtra_sottoscorta_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;call super::open;

datawindowchild ldw_esercizio,ldw_attivita, ldw_magazzino

string maxcod,mincod,maxdes,mindes

dw_1.getchild("esercizio",ldw_esercizio)
ldw_esercizio.settransobject(sqlca)
ldw_esercizio.retrieve()

dw_1.getchild("attivita",ldw_attivita)
ldw_attivita.settransobject(sqlca)
ldw_attivita.retrieve()

dw_1.getchild("locazione",ldw_attivita)
ldw_magazzino.settransobject(sqlca)
ldw_magazzino.retrieve()


dw_1.insertrow(1)

select max(articolo.codice),min(articolo.codice)
into :maxcod,:mincod
from articolo;

select descrizione
into :maxdes
from articolo
where articolo.codice=:maxcod;
select descrizione
into :mindes
from articolo
where articolo.codice=:mincod;


dw_1.setitem(1,'da_articolo',mincod)
dw_1.setitem(1,'da_articolo_des',mindes)
dw_1.setitem(1,'a_articolo',maxcod)
dw_1.setitem(1,'a_articolo_des',maxdes)

dw_1.setitem(1,'a_data',Today())



end event

type cb_ok from commandbutton within w_filtra_sottoscorta_cx
event clicked pbm_bnclicked
int X=2181
int Y=28
int Width=229
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stam&pa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
date ld_data
long ll_attivita, ll_esercizio, ll_locazione, ll_anno, ll_mese, ll_giorno
string ls_da_articolo,ls_a_articolo

str_sottoscorta str_param

dw_1.accepttext()
ls_da_articolo=dw_1.getitemstring(1,"da_articolo")
ls_a_articolo=dw_1.getitemstring(1,"a_articolo")
ld_data=dw_1.getitemdate(1,"a_data")
ll_attivita=dw_1.getitemnumber(1,"attivita")
ll_esercizio=dw_1.getitemnumber(1,"esercizio")
ll_locazione=dw_1.getitemnumber(1,"id_locazione")


if isnull(ls_da_articolo) or isnull(ls_a_articolo) then
	messagebox("Attenzione","Gli articoli di inizio e fine sono obbligatori")
	return
end if
	
if ls_da_articolo>ls_a_articolo then
	messagebox("Sottoscorta","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
   return
end if

if isnull(ld_data) then
	messagebox("Sottoscorta","La data non può essere nulla",exclamation!)
   return
end if

if isnull(ll_esercizio) then
	messagebox("Sottoscorta","Non è stato selezionato nessun esercizio",exclamation!)
	return
end if	

if isnull(ll_attivita) then
	messagebox("Sottoscorta","Non è stata selezionata nessuna attività",exclamation!)
	return
end if	

if isnull(ll_locazione) then
	ll_locazione=0
end if	

ll_anno=year(ld_data)
ll_mese=Month (ld_data)
ll_giorno=Day(ld_data)




str_param.da_articolo=ls_da_articolo
str_param.a_articolo=ls_a_articolo
str_param.id_esercizio=ll_esercizio
str_param.id_attivita=ll_attivita
str_param.locazione=ll_locazione
str_param.data_anno=ll_anno
str_param.data_mese=ll_mese
str_param.data_giorno=ll_giorno

openwithparm(w_st_sottoscorta_gd,str_param)
end event

type cb_annulla from commandbutton within w_filtra_sottoscorta_cx
int X=2437
int Y=28
int Width=242
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="&Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_filtra_sottoscorta_cx
event type integer ue_tipo_reg ( )
int X=32
int Y=128
int Width=2661
int Height=728
int TabOrder=10
string DataObject="d_filtra_sottoscorta_cx"
end type

event itemchanged;

integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_null

setnull(ll_null)

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
		if isnull(data) then 
			this.setitem(1,"id_locazione",ll_null)
		else
		end if
		
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;

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
		is_search_window = "w_locazione_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 
	
		
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
end event

