forward
global type w_stp_fatturato_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_stp_fatturato_cx
end type
type cb_ok from commandbutton within w_stp_fatturato_cx
end type
type dw_1 from u_dw_ext_main within w_stp_fatturato_cx
end type
end forward

global type w_stp_fatturato_cx from w_wiz_main
int Width=3035
int Height=872
boolean TitleBar=true
string Title="Stampa elenco articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_stp_fatturato_cx w_stp_fatturato_cx

on w_stp_fatturato_cx.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_stp_fatturato_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)
dw_1.setitem(1,"ordine","R")
dw_1.setitem(1,"iva",'N')


end event

type cb_annulla from commandbutton within w_stp_fatturato_cx
int X=2738
int Y=32
int Width=229
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="&Esci"
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

type cb_ok from commandbutton within w_stp_fatturato_cx
int X=2395
int Y=32
int Width=242
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
string ls_filtro,ls_da_cliente,ls_a_cliente,ls_iva,ls_parametri,ls_ordinamento
date ld_da_data,ld_a_data
str_fil_flag str_param
dw_1.accepttext()

ls_da_cliente=dw_1.getitemstring(1,"da_cliente_cod")
ls_a_cliente=dw_1.getitemstring(1,"a_cliente_cod")
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
ls_iva=dw_1.getitemstring(1,"iva")
ls_ordinamento=dw_1.getitemstring(1,"ordine")
if isnull(ls_da_cliente)or isnull(ls_a_cliente) then
	messagebox("attenzione","Il cliente iniziale e quello finale sono obbligatori")
else

if isnull(ld_da_data)or isnull(ld_a_data) then
	messagebox("Attenzione","Le date di inizio e fine sono obbligatorie",exclamation!)
else
if ld_da_data>ld_a_data then
	messagebox("Stampa Fatturato Clienti","la data iniziale è maggiore di quella finale",exclamation!)
else

if ls_da_cliente>ls_a_cliente then
	messagebox("Stampa fatturato clienti","Il codice del cliente iniziale è maggiore di quello finale",exclamation!)
else
	


	ls_parametri=ls_parametri+'Da cliente:'+ls_da_cliente
	str_param.da_cod=ls_da_cliente



	ls_parametri=ls_parametri+'- A cliente:'+ls_a_cliente
	str_param.a_cod=ls_a_cliente


	ls_parametri=ls_parametri+' - Da data:'+string(ld_da_data)
	str_param.da_data=ld_da_data
	ls_parametri=ls_parametri+' - A data:'+string(ld_da_data)
	str_param.a_data=ld_a_data
	

if ls_iva='S' then
	ls_parametri=ls_parametri+'   Fatturato con IVA'
else
	ls_parametri=ls_parametri+'   Fatturato senza iva IVA'
end if


str_param.flag=ls_iva

str_param.filtro=ls_filtro
str_param.parametri=ls_parametri
choose case ls_ordinamento
	case 'R'
	openwithparm(w_stp_fatturato_ragsoc_gd,str_param)
	case 'C'
	openwithparm(w_stp_fatturato_tcl_gd,str_param)
	case 'F'
	openwithparm(w_stp_fatturato_dec_fat_gd,str_param)
end choose
end if 
end if
end if 
end if
end event

type dw_1 from u_dw_ext_main within w_stp_fatturato_cx
int X=32
int Y=128
int Width=2935
int Height=612
int TabOrder=2
string DataObject="d_stp_fatturato_ff"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cliente_cod","a_cliente_cod"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo='C' "
	CASE "da_cliente_des","a_cliente_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo='C' "
END CHOOSE
end event

event ue_use_search;choose case as_nomecol
	case "da_cliente_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale_gen",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cliente_des",is_ricpar.s_ausil_value[1])
		   if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
			  uf_set_colval("a_cliente_cod",is_ricpar.s_main_value)
		     uf_set_colval("a_cliente_des",is_ricpar.s_ausil_value[1])
	      end if	
	case "da_cliente_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("da_cliente_cod",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
				uf_set_colval("a_cliente_des",is_ricpar.s_main_value)
				uf_set_colval("a_cliente_cod",is_ricpar.s_ausil_value[1])
			end if	
	case "a_cliente_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("a_cliente_des",is_ricpar.s_ausil_value[1])	
	case "a_cliente_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("a_cliente_cod",is_ricpar.s_ausil_value[1])
	end choose
end event

event itemchanged;
integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_cliente_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cliente_cod"
		ls_dwc[2] = "da_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
						
      
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
          This.SetItem(1, "a_cliente_cod", Data)			
          This.SetItem(1, "a_cliente_des", This.GetItemString(1, "da_cliente_des"))
	      end if
			RETURN 2
		END IF
		
		
	CASE "da_cliente_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cliente_cod"
		ls_dwc[2] = "da_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
          This.SetItem(1, "a_cliente_des", Data)			
          This.SetItem(1, "a_cliente_cod", This.GetItemString(1, "da_cliente_cod"))
	      end if	
			RETURN 2
		END IF

	CASE "a_cliente_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cliente_cod"
		ls_dwc[2] = "a_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_cliente_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cliente_cod"
		ls_dwc[2] = "a_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose
end event

