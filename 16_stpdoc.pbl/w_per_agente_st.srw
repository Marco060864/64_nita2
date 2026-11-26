forward
global type w_per_agente_st from w_001
end type
type dw_1 from u_dw_ext_main within w_per_agente_st
end type
type cb_ok from commandbutton within w_per_agente_st
end type
type dw_scelta from u_dw_ext_main within w_per_agente_st
end type
type dw_2 from u_dw_ext_main within w_per_agente_st
end type
type cb_salva from commandbutton within w_per_agente_st
end type
type cb_cancella from commandbutton within w_per_agente_st
end type
type cb_inserisci from commandbutton within w_per_agente_st
end type
end forward

global type w_per_agente_st from w_001
int X=1577
int Y=964
int Width=2103
int Height=1448
boolean TitleBar=true
string Title="Stampa per Agente"
long BackColor=80269524
dw_1 dw_1
cb_ok cb_ok
dw_scelta dw_scelta
dw_2 dw_2
cb_salva cb_salva
cb_cancella cb_cancella
cb_inserisci cb_inserisci
end type
global w_per_agente_st w_per_agente_st

type variables
udw_figlia idw_corrente
integer ii_dw_corrente
end variables

on w_per_agente_st.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.dw_scelta=create dw_scelta
this.dw_2=create dw_2
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_scelta
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_salva
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_inserisci
end on

on w_per_agente_st.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.dw_scelta)
destroy(this.dw_2)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
end on

event open;call super::open;datawindowchild ldw_agente, ldw_sog
date dt_a_data


dw_1.getchild("id_sog_com",ldw_sog)
ldw_sog.settransobject(sqlca)
ldw_sog.retrieve()

dw_1.getchild("id_agente",ldw_agente)
ldw_agente.settransobject(sqlca)
ldw_agente.retrieve()


dw_scelta.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_scelta.retrieve()
dw_1.insertrow(1)
dt_a_data=dw_1.getitemdate(1, "a_data")
dw_1.setitem(1, "da_data", relativedate(dt_a_data, -30))



end event

type dw_1 from u_dw_ext_main within w_per_agente_st
event type integer ue_tipo_reg ( )
int X=37
int Y=16
int Width=2011
int Height=400
int TabOrder=10
string DataObject="d_st_per_agente"
end type

type cb_ok from commandbutton within w_per_agente_st
int X=1701
int Y=1228
int Width=338
int Height=108
int TabOrder=60
boolean BringToTop=true
string Text="&Stampa"
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_cod_sog_comm, ls_parametri, ls_causale, ls_agente
integer i
date ld_da_data,ld_a_data
s_param_articoli str_param

dw_1.accepttext()

ls_cod_sog_comm = dw_1.Describe( "Evaluate('LookUpDisplay(id_sog_com) ', " + "1" + ")")
str_param.a_sog_comm=string(dw_1.getitemnumber(1, "id_sog_com"))
if ls_cod_sog_comm>'' then ls_parametri=ls_parametri+'Cliente: ' + ls_cod_sog_comm + " - "

str_param.da_cod_art=string(dw_1.getitemnumber(1, "id_agente"))
ls_agente=dw_1.Describe( "Evaluate('LookUpDisplay(id_agente) ', " + "1" + ")")
if ls_agente>'' then ls_parametri=ls_parametri+'Agente: ' + ls_agente + " - "

ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "




If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa statistica","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa Statistiche","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If

str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_sog_comm=ls_cod_sog_comm
str_param.tipo_stampa=dw_1.getitemstring(1, "dw")

for i= 1 to dw_2.rowcount()
	ls_causale=dw_2.Describe( "Evaluate('LookUpDisplay(id_caus_magazzino) ', " + string(i) + ")")
	str_param.li_titolo[i]=dw_2.getitemnumber(i, "id_caus_magazzino")
	if i=1 then
		ls_parametri+=" - Causali Selezionate: " + ls_causale
	else
		ls_parametri+=" - " + ls_causale
	end if
next


str_param.filtro=ls_parametri

OpenWithParm(w_per_agente_rpt, str_param)
end event

type dw_scelta from u_dw_ext_main within w_per_agente_st
event type integer ue_tipo_reg ( )
int X=37
int Y=448
int Width=1024
int Height=764
int TabOrder=50
string DataObject="d_lista_causali"
boolean VScrollBar=true
end type

event getfocus;call super::getfocus;ii_dw_corrente=1
end event

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

type dw_2 from u_dw_ext_main within w_per_agente_st
event type integer ue_tipo_reg ( )
int X=1170
int Y=448
int Width=878
int Height=764
int TabOrder=20
string DataObject="d_sel_causali_gd"
boolean VScrollBar=true
end type

event getfocus;call super::getfocus;ii_dw_corrente=2
end event

event itemchanged;
end event

event itemfocuschanged;call super::itemfocuschanged;



end event

event rowfocuschanged;setrowfocusindicator(hand!)
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

event ue_use_search;
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

type cb_salva from commandbutton within w_per_agente_st
int X=782
int Y=1228
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

type cb_cancella from commandbutton within w_per_agente_st
int X=14
int Y=1228
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

type cb_inserisci from commandbutton within w_per_agente_st
int X=389
int Y=1228
int Width=247
int Height=108
int TabOrder=40
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

