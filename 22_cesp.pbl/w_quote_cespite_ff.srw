forward
global type w_quote_cespite_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_quote_cespite_ff
end type
type cb_annulla from commandbutton within w_quote_cespite_ff
end type
type dw_1 from u_dw_ext_main within w_quote_cespite_ff
end type
end forward

global type w_quote_cespite_ff from w_wiz_main
int Width=2391
int Height=1076
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Riepilogo Movimenti"
long BackColor=78748035
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_quote_cespite_ff w_quote_cespite_ff

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
boolean lb_ges_periodo
long ll_valuta
end variables

on w_quote_cespite_ff.create
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

on w_quote_cespite_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;


dw_1.settransobject(sqlca)
dw_1.insertrow(1)

date ld_data

dw_1.setitem(1, 'a_data', today())	
ld_data=date('01/01/'+string(year(today())))
dw_1.setitem(1, 'da_data', ld_data)	

end event

event closequery;
end event

type cb_ok from commandbutton within w_quote_cespite_ff
event clicked pbm_bnclicked
int X=50
int Y=36
int Width=270
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stampa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

s_cespiti str_parametri  

string  ls_conto, ls_conto2, ls_cat, ls_cat2
decimal ld_cambio
long ll_apertura, ll_id_registro, ll_ides, ll_chiusura, ll_cifre_decimali
date  da_data, a_data
integer li_d_day, li_d_fine , i

da_data  = dw_1.getitemdate(1, 'da_data')
a_data = dw_1.getitemdate(1, 'a_data')


ls_conto=dw_1.getitemstring(1, 'da_cod') 
if isnull(ls_conto) then ls_conto='aaaaaaaa'

ls_conto2=dw_1.getitemstring(1, 'a_cod') 
if isnull(ls_conto2) then ls_conto2='zzzzzzzz'


IF ls_conto > ls_conto2 THEN
	messagebox ('Attenzione', 'Il conto iniziale è maggiore del conto finale')
	return
end if	

ls_cat=dw_1.getitemstring(1, 'da_cod_cat') 
if isnull(ls_cat) then ls_cat='aaaaaaaa'

ls_cat2=dw_1.getitemstring(1, 'a_cod_cat') 
if isnull(ls_cat2) then ls_cat2='zzzzzzzz'


IF ls_cat > ls_cat2 THEN
	messagebox ('Attenzione', 'La categoria iniziale è maggiore del conto finale')
	return
end if	

if isnull(a_data) or isnull(da_data)then
	messagebox ('Attenzione', 'Inserire le date di stampa')
end if


IF da_data > a_data THEN
	messagebox ('Attenzione', 'Verificare date inserite')
	return
end if



str_parametri.da_data=da_data
str_parametri.a_data=a_data
str_parametri.da_cespite=ls_conto
str_parametri.a_cespite=ls_conto2
str_parametri.da_cat=ls_cat
str_parametri.a_cat=ls_cat2


openwithparm(w_stp_mov_cespite_rpt, str_parametri)




end event

type cb_annulla from commandbutton within w_quote_cespite_ff
int X=338
int Y=36
int Width=256
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
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

type dw_1 from u_dw_ext_main within w_quote_cespite_ff
int X=50
int Y=140
int Width=2258
int Height=784
int TabOrder=10
boolean BringToTop=true
string DataObject="d_quote_ff"
end type

event itemchanged;string ls_filtro, ls_colonna
integer li_ok
long ll_es
date ld_d1, ld_d2
string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

setnull(ls_null)

CHOOSE CASE dwo.name
		
	CASE "da_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_cod", Data)			
           This.SetItem(1, "a_des", This.GetItemString(1, "da_des"))
         end if
			RETURN 2
		END IF
		
		
	case "da_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_des", Data)			
           This.SetItem(1, "a_cod", This.GetItemString(1, "da_cod"))
         end if
			RETURN 2
		END IF

	case "a_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "da_cod_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
       	  This.SetItem(1, "a_cod_cat", Data)			
           This.SetItem(1, "a_des_cat", This.GetItemString(1, "da_des_cat"))
         end if
			RETURN 2
		END IF
		
		
	case "da_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
       	  This.SetItem(1, "a_des_cat", Data)			
           This.SetItem(1, "a_cod_cat", This.GetItemString(1, "da_cod_cat"))
         end if
			RETURN 2
		END IF

	case "a_cod_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_int_cespite", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose

end event

event ue_set_search;string ls_cond

CHOOSE CASE as_nomecol
	CASE "a_cod", "a_des"
		is_search_window = "w_cespite_sw"

		IF as_nomecol = "a_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
		END IF

	CASE "da_cod", "da_des"
		is_search_window = "w_cespite_sw"

		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
		END IF
		
	CASE "a_cod_cat", "a_des_cat"
		is_search_window = "w_cat_int_cespite_sw"

		IF as_nomecol = "a_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_codice"
		ELSEIF as_nomecol = "a_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_descrizione"
		END IF

	CASE "da_cod_cat", "da_des_cat"
		is_search_window = "w_cat_int_cespite_sw"

		IF as_nomecol = "da_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_codice"
		ELSEIF as_nomecol = "da_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_int_cespite_descrizione"
		END IF

END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)

		uf_set_colval("a_des", is_ricpar.s_ausil_value[1])

	CASE "a_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)

		uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	
	CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)

		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_cod', is_ricpar.s_main_value)
        uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
	   end if
	
	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_des', is_ricpar.s_main_value)
        uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	   end if		

	CASE "a_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])

	CASE "a_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])
	
	CASE "da_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_des_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
        uf_set_colval('a_cod_cat', is_ricpar.s_main_value)
        uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])
	   end if
	
	CASE "da_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
        uf_set_colval('a_des_cat', is_ricpar.s_main_value)
        uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])
	   end if		

END CHOOSE








end event

