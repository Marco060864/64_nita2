forward
global type w_ricalcolo_provv_proposte_wz from w_wiz_main
end type
type dw_ricalcolo_provvigioni_ext from u_dw_ext_main within w_ricalcolo_provv_proposte_wz
end type
type st_1 from statictext within w_ricalcolo_provv_proposte_wz
end type
type st_3 from statictext within w_ricalcolo_provv_proposte_wz
end type
type st_2 from statictext within w_ricalcolo_provv_proposte_wz
end type
type st_4 from statictext within w_ricalcolo_provv_proposte_wz
end type
type cb_proponi_provv from commandbutton within w_ricalcolo_provv_proposte_wz
end type
type dw_1 from u_dw_ext_main within w_ricalcolo_provv_proposte_wz
end type
type cb_salva from commandbutton within w_ricalcolo_provv_proposte_wz
end type
type st_6 from statictext within w_ricalcolo_provv_proposte_wz
end type
type cb_visualizza from commandbutton within w_ricalcolo_provv_proposte_wz
end type
end forward

global type w_ricalcolo_provv_proposte_wz from w_wiz_main
int Width=3177
int Height=1636
boolean TitleBar=true
string Title="Ricalcolo provvigioni proposte"
dw_ricalcolo_provvigioni_ext dw_ricalcolo_provvigioni_ext
st_1 st_1
st_3 st_3
st_2 st_2
st_4 st_4
cb_proponi_provv cb_proponi_provv
dw_1 dw_1
cb_salva cb_salva
st_6 st_6
cb_visualizza cb_visualizza
end type
global w_ricalcolo_provv_proposte_wz w_ricalcolo_provv_proposte_wz

type variables
w_wait_01	iw_wait
end variables

on w_ricalcolo_provv_proposte_wz.create
int iCurrent
call super::create
this.dw_ricalcolo_provvigioni_ext=create dw_ricalcolo_provvigioni_ext
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
this.st_4=create st_4
this.cb_proponi_provv=create cb_proponi_provv
this.dw_1=create dw_1
this.cb_salva=create cb_salva
this.st_6=create st_6
this.cb_visualizza=create cb_visualizza
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ricalcolo_provvigioni_ext
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.cb_proponi_provv
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_salva
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.cb_visualizza
end on

on w_ricalcolo_provv_proposte_wz.destroy
call super::destroy
destroy(this.dw_ricalcolo_provvigioni_ext)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.cb_proponi_provv)
destroy(this.dw_1)
destroy(this.cb_salva)
destroy(this.st_6)
destroy(this.cb_visualizza)
end on

event open;call super::open;
dw_ricalcolo_provvigioni_ext.insertrow(0)
end event

type dw_ricalcolo_provvigioni_ext from u_dw_ext_main within w_ricalcolo_provv_proposte_wz
int X=32
int Y=128
int Width=3081
int Height=452
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ricalcolo_provv_proposte_ext"
end type

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "prof_documento_codice", "prof_documento_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"		
		
		ls_dwc[1] = "prof_documento_codice"
		ls_dwc[2] = "prof_documento_descrizione"
		ls_dwc[3] = "id_prof_documento"				

		if dwo.name = "prof_documento_codice" then
			li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 3, &
				ls_dbc, ls_dbv, ls_dwc)
		else
			li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 3, &
				ls_dbc, ls_dbv, ls_dwc)
		end if
	
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE	"prof_documento_codice", "prof_documento_descrizione"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		
		if as_nomecol = "prof_documento_codice" then		
			is_ricpar.s_filter_name="prof_documento_codice"
		else
			is_ricpar.s_filter_name="prof_documento_descrizione"			
		end if
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE	"prof_documento_codice"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("prof_documento_descrizione",is_ricpar.s_ausil_value[1])
	CASE	"prof_documento_descrizione"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("prof_documento_codice",is_ricpar.s_ausil_value[1])		
END CHOOSE
end event

type st_1 from statictext within w_ricalcolo_provv_proposte_wz
int X=594
int Y=32
int Width=165
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Inizio:"
Alignment Alignment=Right!
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

type st_3 from statictext within w_ricalcolo_provv_proposte_wz
int X=768
int Y=32
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
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

type st_2 from statictext within w_ricalcolo_provv_proposte_wz
int X=1253
int Y=32
int Width=133
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Fine:"
Alignment Alignment=Right!
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

type st_4 from statictext within w_ricalcolo_provv_proposte_wz
int X=1394
int Y=32
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
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

type cb_proponi_provv from commandbutton within w_ricalcolo_provv_proposte_wz
int X=2341
int Y=24
int Width=494
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="&Proponi Provvigioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer  	li_i, li_ret = 0
string		ls_select, ls_select_ini
decimal {0}	ld_da_num_progressivo, ld_a_num_progressivo
date			ldt_da_data_registrazione, ldt_a_data_registrazione
long			ll_id_documento, ll_id_gruppo_agenti
time 			lt_i, lt_f
char			lc_selezionato
s_con_provvigione ls_con_provvigione			

open(iw_wait,"w_wait_01")

iw_wait.st_wait.text = "Ricalcolo delle provvigioni Agente"
iw_wait.st_wait_b.text = ""
lt_i = Now()
st_3.text = string(lt_i)

li_ret = dw_1.rowcount()

for li_i = 1 to li_ret
	ll_id_documento = dw_1.getitemnumber(li_i, "id_documento")
	lc_selezionato = dw_1.getitemstring(li_i, "selezionato")
	if (lc_selezionato = 'S') then
		ls_con_provvigione.id_sog_commerciale  = dw_1.getitemnumber(li_i, "documento_id_sog_commerciale")
		ls_con_provvigione.id_unita_confezione = dw_1.getitemnumber(li_i, "riga_documento_id_unita_confezione")
		ls_con_provvigione.id_articolo = dw_1.getitemnumber(li_i, "riga_documento_id_articolo")
		ls_con_provvigione.data = dw_1.getitemdate(li_i, "documento_data_registrazione")
		ls_con_provvigione.sconto_perc = dw_1.getitemstring(li_i, "riga_documento_sconto")
		ls_con_provvigione.sconto_imp = dw_1.getitemnumber(li_i, "riga_documento_sconto_riga")
		ls_con_provvigione.id_valuta = dw_1.getitemnumber(li_i, "riga_documento_id_valuta")
		ls_con_provvigione.id_con_lis_articolo = dw_1.getitemnumber(li_i, "riga_documento_id_con_lis_articolo")
		
		ll_id_gruppo_agenti = dw_1.getitemnumber(li_i, "riga_documento_id_gruppo_agenti")
		if (ll_id_gruppo_agenti > 0) then
			ls_con_provvigione.id_gruppo_agenti = ll_id_gruppo_agenti
			f_provvigioni_agenti(ls_con_provvigione, dw_1, li_i, 1, "M")
		end if
		ll_id_gruppo_agenti = dw_1.getitemnumber(li_i, "riga_documento_id_gruppo_agenti_2")
		if (ll_id_gruppo_agenti > 0) then
			ls_con_provvigione.id_gruppo_agenti = ll_id_gruppo_agenti
			f_provvigioni_agenti(ls_con_provvigione, dw_1, li_i, 2, "M")
		end if
	end if
next

lt_f = Now()
st_4.text = string(lt_f)

close(iw_wait)

end event

type dw_1 from u_dw_ext_main within w_ricalcolo_provv_proposte_wz
int X=32
int Y=664
int Width=3081
int Height=848
int TabOrder=20
boolean BringToTop=true
string DataObject="ds_ricalcolo_provv_proposte_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event sqlpreview;
string		ls_select
decimal {0}	ld_da_num_progressivo, ld_a_num_progressivo
date			ldt_da_data_registrazione, ldt_a_data_registrazione
long			ll_id_prof_documento
decimal{4}	ld_quantita

if (request = PreviewFunctionRetrieve!) then
	ld_da_num_progressivo = dw_ricalcolo_provvigioni_ext.getitemnumber(1, "da_num_progressivo")
	ld_a_num_progressivo	 = dw_ricalcolo_provvigioni_ext.getitemnumber(1, "a_num_progressivo")
	
	ldt_da_data_registrazione = dw_ricalcolo_provvigioni_ext.getitemdate(1, "da_data_registrazione")
	ldt_a_data_registrazione  = dw_ricalcolo_provvigioni_ext.getitemdate(1, "a_data_registrazione")
	
	ll_id_prof_documento = dw_ricalcolo_provvigioni_ext.getitemnumber(1, "id_prof_documento")
	ld_quantita 			= dw_ricalcolo_provvigioni_ext.getitemnumber(1, "quantita")	
	
	
	ls_select = sqlsyntax
	
	if (ld_da_num_progressivo > 0) then
		ls_select = ls_select + " AND documento.num_progressivo >= " + string(ld_da_num_progressivo)
	end if
	if (ld_a_num_progressivo > 0) then
		ls_select = ls_select + " AND documento.num_progressivo <= " + string(ld_a_num_progressivo)
	end if
	
	if (not isnull(ldt_da_data_registrazione)) then
		ls_select = ls_select + " AND documento.data_registrazione >= '" + string(ldt_da_data_registrazione, 'yyyy-mm-dd') + "' "
	end if
	if (not isnull(ldt_a_data_registrazione)) then
		ls_select = ls_select + " AND documento.data_registrazione <= '" + string(ldt_a_data_registrazione, 'yyyy-mm-dd') + "' "
	end if
	
	if (ll_id_prof_documento > 0) then
		ls_select = ls_select + " AND documento.id_prof_documento = " + string(ll_id_prof_documento)
	end if
	
	if (ld_quantita > 0) then
		ls_select = ls_select + " AND riga_documento.quantita = CONVERT(NUMERIC(18,4),"+string(ld_quantita)+") " 
	end if
	
	setsqlpreview(ls_select)
	
end if
end event

type cb_salva from commandbutton within w_ricalcolo_provv_proposte_wz
int X=2853
int Y=24
int Width=261
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="&Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
	
integer li_ret

li_ret = dw_1.update()

if (li_ret = -1) then
	messagebox("Ricalcolo Provv. Proposte", "Il salvataggio non è andato a buon fine")
end if

end event

type st_6 from statictext within w_ricalcolo_provv_proposte_wz
int X=32
int Y=584
int Width=3081
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Elenco Fatture"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_visualizza from commandbutton within w_ricalcolo_provv_proposte_wz
int X=1833
int Y=24
int Width=475
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="&Visualizza Fatture"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
	
dw_1.settransobject(sqlca)
dw_1.retrieve()		

end event

