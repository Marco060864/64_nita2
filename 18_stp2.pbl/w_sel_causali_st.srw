forward
global type w_sel_causali_st from w_wiz_main
end type
type cb_ok from commandbutton within w_sel_causali_st
end type
type cb_annulla from commandbutton within w_sel_causali_st
end type
type dw_2 from u_dw_ext_main within w_sel_causali_st
end type
type cb_cancella from commandbutton within w_sel_causali_st
end type
type cb_inserisci from commandbutton within w_sel_causali_st
end type
type cb_salva from commandbutton within w_sel_causali_st
end type
type dw_scelta from u_dw_ext_main within w_sel_causali_st
end type
end forward

global type w_sel_causali_st from w_wiz_main
int Width=2034
int Height=1212
WindowType WindowType=response!
boolean TitleBar=true
string Title="Filtra per Causali"
long BackColor=81324524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_2 dw_2
cb_cancella cb_cancella
cb_inserisci cb_inserisci
cb_salva cb_salva
dw_scelta dw_scelta
end type
global w_sel_causali_st w_sel_causali_st

type variables
integer ii_dw_corrente
end variables

on w_sel_causali_st.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_2=create dw_2
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.dw_scelta=create dw_scelta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.cb_salva
this.Control[iCurrent+7]=this.dw_scelta
end on

on w_sel_causali_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_2)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.dw_scelta)
end on

event open;call super::open;datawindowchild ldw_da_cat_merceologica, ldw_a_cat_merceologica, ldw_data_inizio_es, ldw_locazione
datawindowchild ldw_da_titolo, ldw_a_titolo, ldw_valuta
date ldt_data_inzio,ld_da_data_doc, ld_a_data_doc
LONG LL_ID_VAL
String ls_par 





dw_scelta.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_scelta.retrieve()

end event

event ue_post_open;call super::ue_post_open;
end event

type cb_ok from commandbutton within w_sel_causali_st
event clicked pbm_bnclicked
int X=41
int Y=940
int Width=338
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="&Stampa"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
s_param_articoli str_param
dw_2.accepttext()

for i = 1 to dw_2.rowcount()
	str_param.li_titolo[i]= dw_2.getitemnumber(i, "id_caus_magazzino")
next
closewithreturn(parent,str_param) 
end event

type cb_annulla from commandbutton within w_sel_causali_st
int X=549
int Y=940
int Width=338
int Height=108
int TabOrder=60
boolean BringToTop=true
string Text="&Chiudi"
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

type dw_2 from u_dw_ext_main within w_sel_causali_st
event type integer ue_tipo_reg ( )
int X=1093
int Y=36
int Width=878
int Height=1068
int TabOrder=10
string DataObject="d_sel_causali_gd"
boolean VScrollBar=true
end type

event ue_use_search;
end event

event ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo", "da_des_articolo"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "da_cod_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "da_des_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE
	CASE "a_cod_articolo", "a_des_articolo"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "a_cod_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "a_des_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF
		
			
	CASE "da_cod_sog_comm", "da_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF

	CASE "a_cod_sog_comm", "a_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF






END CHOOSE	
end event

event itemchanged;
end event

event itemfocuschanged;call super::itemfocuschanged;



end event

event ue_key;call super::ue_key;choose case key
	case keyadd!
		if keyflags=2 then
			cb_inserisci.triggerevent(clicked!)
		end if
	case keysubtract!
		if keyflags=2 then
			cb_cancella.triggerevent(clicked!)
		end if
end choose
end event

event rowfocuschanged;setrowfocusindicator(hand!)
end event

event getfocus;call super::getfocus;ii_dw_corrente=2
end event

event ue_insert;call super::ue_insert;string ls_config
integer li_riga

li_riga=dw_scelta.getrow()
if li_riga>0 then
	ls_config=dw_scelta.getitemstring(li_riga, "configurazione")
	if ls_config>'' then
		li_riga=getrow()
		setitem(li_riga, "configurazione", ls_config)
	else
		deleterow(getrow())
	end if
else
	deleterow(getrow())
end if
end event

type cb_cancella from commandbutton within w_sel_causali_st
int X=46
int Y=28
int Width=247
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_riga
li_riga=dw_2.getrow()
if li_riga>0 then
	dw_2.deleterow(li_riga)
end if
end event

type cb_inserisci from commandbutton within w_sel_causali_st
int X=649
int Y=28
int Width=247
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_riga






if ii_dw_corrente=1 then
	li_riga=dw_scelta.insertrow(0)
	dw_scelta.scrolltorow(li_riga)
else
	dw_2.triggerevent("ue_insert")
end if
end event

type cb_salva from commandbutton within w_sel_causali_st
int X=347
int Y=28
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if ii_dw_corrente=1 then
	if dw_scelta.update()=1 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Salvataggio Fallito! Non creata Lista causali!")
	end if
else
	
	if dw_2.update()=1 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Salvataggio Fallito nell'inserimento delle causali!")
	end if
end if
end event

type dw_scelta from u_dw_ext_main within w_sel_causali_st
event type integer ue_tipo_reg ( )
int X=46
int Y=160
int Width=1015
int Height=764
int TabOrder=11
string DataObject="d_lista_causali"
boolean VScrollBar=true
end type

event itemchanged;integer li_ok, li_null
long ll_id_titolo
string ls_sql_cond, ls_null
string ls_dbc[], ls_dwc[], ls_dbv[]
decimal ldc_cambio

CHOOSE CASE dwo.name
	CASE "da_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
           This.SetItem(1, "a_cod_articolo", Data)			
           This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc) 
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
		    This.SetItem(1, "a_des_articolo", Data)			
          This.SetItem(1, "a_cod_articolo", This.GetItemString(1, "da_cod_articolo"))
	      end if 
			RETURN 2
		END IF

	case "a_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

	
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF



		CASE "da_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
           This.SetItem(1, "a_cod_sog_comm", Data)			
           This.SetItem(1, "a_sog_comm_des", This.GetItemString(1, "da_sog_comm_des"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
		    This.SetItem(1, "a_sog_comm_des", Data)			
          This.SetItem(1, "a_cod_sog_comm", This.GetItemString(1, "da_cod_sog_comm"))
	      end if
			RETURN 2
		END IF

	case "a_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	CASE "da_cod_cat"
case "st_art_sog"
		setnull(ls_null)
		setnull(li_null)
		if data='A' or data='P' then
			setitem(row, "da_cod_sog_comm", ls_null)
			setitem(row, "a_cod_sog_comm", ls_null)
			setitem(row, "da_sog_comm_des", ls_null)
			setitem(row, "a_sog_comm_des", ls_null)
		elseif data='S' then
			setitem(row, "da_cod_articolo", ls_null)
			setitem(row, "a_cod_articolo", ls_null)
			setitem(row, "da_des_articolo", ls_null)
			setitem(row, "a_des_articolo", ls_null)
		end if
		
	case "valuta"
		ll_id_titolo=long(data)
		select cambio into :ldc_cambio
		from valuta
		where id_valuta=:ll_id_titolo
		;
		setitem(row, "cambio", ldc_cambio)
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;



end event

event rowfocuschanged;setrowfocusindicator(hand!)

string ls_config
if currentrow>0 then
	ls_config=dw_scelta.getitemstring(currentrow, "configurazione")
	if ls_config>'' then
		dw_2.retrieve(ls_config)
	else
		dw_2.reset()
	end if
else
	dw_2.reset()
end if
end event

event ue_key;call super::ue_key;choose case key
	case keyadd!
		if keyflags=2 then
			cb_inserisci.triggerevent(clicked!)
		end if
	case keysubtract!
		if keyflags=2 then
			cb_cancella.triggerevent(clicked!)
		end if
end choose
end event

event ue_set_search;
end event

event ue_use_search;

end event

event getfocus;call super::getfocus;ii_dw_corrente=1
end event

