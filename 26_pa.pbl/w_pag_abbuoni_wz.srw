forward
global type w_pag_abbuoni_wz from w_p_data
end type
type dw_testa from u_dw_master_main within w_pag_abbuoni_wz
end type
type dw_tot from u_dw_master_main within w_pag_abbuoni_wz
end type
type dw_fil from u_dw_master_main within w_pag_abbuoni_wz
end type
type cb_1 from commandbutton within w_pag_abbuoni_wz
end type
type dw_dett from u_dw_master_main within w_pag_abbuoni_wz
end type
type cb_registra from commandbutton within w_pag_abbuoni_wz
end type
end forward

global type w_pag_abbuoni_wz from w_p_data
int X=434
int Y=428
int Width=2583
int Height=1956
boolean TitleBar=true
string Title="Riscossioni e Pagamenti"
event ue_genera ( )
dw_testa dw_testa
dw_tot dw_tot
dw_fil dw_fil
cb_1 cb_1
dw_dett dw_dett
cb_registra cb_registra
end type
global w_pag_abbuoni_wz w_pag_abbuoni_wz

type variables
long 	il_conto
string is_cli, is_fo
end variables

on w_pag_abbuoni_wz.create
int iCurrent
call super::create
this.dw_testa=create dw_testa
this.dw_tot=create dw_tot
this.dw_fil=create dw_fil
this.cb_1=create cb_1
this.dw_dett=create dw_dett
this.cb_registra=create cb_registra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_testa
this.Control[iCurrent+2]=this.dw_tot
this.Control[iCurrent+3]=this.dw_fil
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_dett
this.Control[iCurrent+6]=this.cb_registra
end on

on w_pag_abbuoni_wz.destroy
call super::destroy
destroy(this.dw_testa)
destroy(this.dw_tot)
destroy(this.dw_fil)
destroy(this.cb_1)
destroy(this.dw_dett)
destroy(this.cb_registra)
end on

event closequery;
RETURN 0

end event

event open;call super::open;long ll_id_es
date ld_data

dw_dett.settransobject(sqlca)
dw_testa.settransobject(sqlca)
dw_fil.settransobject(sqlca)
dw_tot.settransobject(sqlca)

dw_testa.insertrow(0)
dw_fil.insertrow(0)
dw_tot.insertrow(0)


datawindowchild ldc_es
dw_testa.getchild('id_esercizio',ldc_es)
ldc_es.settransobject(sqlca)
ldc_es.retrieve()

ld_data=today()
dw_testa.setitem(1,'data_reg_pd',ld_data)
select id_esercizio into :ll_id_es
from esercizio where data_inizio<=:ld_data 
and data_fine>=:ld_data;

dw_testa.setitem(1,'id_esercizio',ll_id_es)


end event

event ue_post_open;
end event

event close;
end event

type p_crescente from w_p_data`p_crescente within w_pag_abbuoni_wz
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_pag_abbuoni_wz
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_pag_abbuoni_wz
int TabOrder=20
boolean BringToTop=true
boolean Default=true
end type

type cb_annulla from w_p_data`cb_annulla within w_pag_abbuoni_wz
int TabOrder=80
boolean BringToTop=true
boolean Cancel=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_pag_abbuoni_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_pag_abbuoni_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_pag_abbuoni_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_pag_abbuoni_wz
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_pag_abbuoni_wz
int X=1097
int Y=44
int Width=251
int Height=124
int TabOrder=60
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=215
int Height=4
end type

type cb_ricerca from w_p_data`cb_ricerca within w_pag_abbuoni_wz
int X=0
int Y=0
int Width=41
int Height=40
boolean BringToTop=true
string Text="&Registra..."
end type

type dw_testa from u_dw_master_main within w_pag_abbuoni_wz
event type long ue_abilita_controlli ( decimal adc_imp_contanti )
int X=32
int Y=152
int Width=2482
int Height=564
int TabOrder=10
string DataObject="d_pag_abbuoni_ff"
end type

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol

	CASE "prof_registrazione_cod"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.usa_pagamenti = 'S'"
	CASE "prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.usa_pagamenti = 'S'"		
			
	CASE "abbuono_cod", "abbuono_des"
	
      is_search_window = "w_conti_pd_sw"
		IF as_nomecol = "abbuono_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "abbuono_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
		is_ricpar.b_imm_retrieve = TRUE
		
	CASE "contropartita_cod", "contropartita_des"
	
      is_search_window = "w_conti_pd_sw"
		IF as_nomecol = "contropartita_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "contropartita_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
		is_ricpar.b_imm_retrieve = TRUE
	
END CHOOSE


end event

event ue_use_search;

CHOOSE CASE as_nomecol
	CASE "prof_registrazione_cod"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_des", is_ricpar.s_ausil_value[1])		
	CASE "prof_registrazione_des"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_cod", is_ricpar.s_ausil_value[1])				

	CASE "abbuono_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_abbuono", is_ricpar.s_id_seg_value[1])
		uf_set_colval("abbuono_des", is_ricpar.s_ausil_value[1])

	CASE "abbuono_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_abbuono", is_ricpar.s_id_seg_value[1])
		uf_set_colval("abbuono_cod", is_ricpar.s_ausil_value[1])

	CASE "contropartita_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_contropartita", is_ricpar.s_id_seg_value[1])
		uf_set_colval("contropartita_des", is_ricpar.s_ausil_value[1])

	CASE "contropartita_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_contropartita", is_ricpar.s_id_seg_value[1])
		uf_set_colval("contropartita_cod", is_ricpar.s_ausil_value[1])
		
END CHOOSE
end event

event itemchanged;STRING ls_dbc[], ls_dwc[], ls_dbv[]
LONG   li_ok, ll_esercizio
DATE ld_in, ld_fn, ld_data
BOOLEAN lb_continue


CHOOSE CASE dwo.name

	CASE "prof_registrazione_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "prof_registrazione_cod"
		ls_dwc[2] = "prof_registrazione_des"
		ls_dwc[3] = "id_prof_registrazione"

		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "prof_registrazione_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "prof_registrazione_cod"
		ls_dwc[2] = "prof_registrazione_des"
		ls_dwc[3] = "id_prof_registrazione"
		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "id_esercizio"
		ll_esercizio=long(data)
		select data_inizio, data_fine into :ld_in, :ld_fn 
		from esercizio where id_esercizio=:ll_esercizio;
		ld_data=dw_testa.getitemdate(1,'data_reg_pd')
		if ld_data<ld_in or ld_data>ld_fn then
			dw_testa.setitem(1,'data_reg_pd',ld_in)
		end if	

	CASE "data_reg_pd"
		ld_data=date(data)
		ll_esercizio=dw_testa.getitemnumber(1,'id_esercizio')
		select data_inizio, data_fine into :ld_in, :ld_fn 
		from esercizio where id_esercizio=:ll_esercizio;
		ld_data=dw_testa.getitemdate(1,'data_reg_pd')
		if ld_data<ld_in or ld_data>ld_fn then
			dw_testa.setitem(1,'data_reg_pd',ld_in)
		end if	
		if ld_data<ld_in or ld_data>ld_fn then
			MessageBox("Registrazioni Contabili", "La data registrazione deve essere compresa tra~rla data di inizio (" + string(ld_in) + ") e la data di fine (" + string(ld_fn) + ")~rdell'esercizio selezionato")
			THIS.SetColumn("data_reg_pd")
			lb_continue = FALSE
		END IF
		
	CASE "abbuono_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "abbuono_cod"
		ls_dwc[2] = "abbuono_des"
		ls_dwc[3] = "id_abbuono"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "abbuono_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "abbuono_cod"
		ls_dwc[2] = "abbuono_des"
		ls_dwc[3] = "id_abbuono"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF

	CASE "contropartita_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "contropartita_cod"
		ls_dwc[2] = "contropartita_des"
		ls_dwc[3] = "id_contropartita"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "contropartita_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "contropartita_cod"
		ls_dwc[2] = "contropartita_des"
		ls_dwc[3] = "id_contropartita"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF


END CHOOSE


end event

type dw_tot from u_dw_master_main within w_pag_abbuoni_wz
event type long ue_abilita_controlli ( decimal adc_imp_contanti )
int X=32
int Y=1716
int Width=2482
int Height=136
int TabOrder=30
string DataObject="d_totali_abbuoni_ff"
end type

type dw_fil from u_dw_master_main within w_pag_abbuoni_wz
event type long ue_abilita_controlli ( decimal adc_imp_contanti )
int X=32
int Y=740
int Width=2482
int Height=284
int TabOrder=40
string DataObject="d_filtro_abbuoni_ff"
end type

event itemchanged;STRING ls_dbc[], ls_dwc[], ls_dbv[]
LONG   li_ok

CHOOSE CASE dwo.name
			
	CASE "conto_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_cod"
		ls_dwc[2] = "conto_des"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "conto_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_cod"
		ls_dwc[2] = "conto_des"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF

END CHOOSE


end event

event ue_use_search;CHOOSE CASE as_nomecol

	CASE "conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_des", is_ricpar.s_ausil_value[1])

	CASE "conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_cod", is_ricpar.s_ausil_value[1])
		
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
			
	CASE "abbuono_cod", "abbuono_des"
	
      is_search_window = "w_conti_pd_sw"
		IF as_nomecol = "conto_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_cod"
		ELSEIF as_nomecol = "conto_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_des"
		END IF
		is_ricpar.b_imm_retrieve = TRUE
	
END CHOOSE


end event

type cb_1 from commandbutton within w_pag_abbuoni_wz
int X=1765
int Y=44
int Width=366
int Height=84
int TabOrder=70
boolean BringToTop=true
string Text="&Carica Partite"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_in, ld_fn
long ll_esercizio, ll_val

dw_fil.accepttext()

ll_esercizio=dw_testa.getitemnumber(1,'id_esercizio') 
select id_valuta into :ll_val
from esercizio where id_esercizio=:ll_esercizio;


is_fo=dw_fil.getitemstring(1,'fo')
is_cli=dw_fil.getitemstring(1,'cli')
il_conto=dw_fil.getitemnumber(1,'id_conto')
if is_fo='N' and is_cli='N' then 
	messagebox('Attenzione','Selezionare Clienti, Fornitori prima di caricare le partite!')
	RETURN
end if	
ld_in=dw_fil.getitemdate(1,'da_data')
ld_fn=dw_fil.getitemdate(1,'a_data')

if isnull(ld_in) then ld_in=date('01/01/1999')
if isnull(ld_fn) then ld_fn=date('01/01/2111')
dw_dett.retrieve(ld_in, ll_val, ld_fn) 

end event

type dw_dett from u_dw_master_main within w_pag_abbuoni_wz
event type long ue_abilita_controlli ( decimal adc_imp_contanti )
int X=32
int Y=1056
int Width=2482
int Height=636
int TabOrder=50
boolean BringToTop=true
string DataObject="d_dett_abbuoni_ff"
boolean VScrollBar=true
end type

event sqlpreview;string ls_sql_1,ls_sql_2
string ls_cli, ls_fo
long ll_pos, ll_len

SELECT pref_cod_cliente, pref_cod_fornitore
INTO :ls_cli, :ls_fo FROM par_sistema;

IF NOT ISNULL(il_conto) THEN
	ll_pos=POS(sqlsyntax, 'order' )
	ll_len=LEN(sqlsyntax)
	ls_sql_1=Left (sqlsyntax, (ll_pos - 1) )
	ls_sql_2=Right(sqlsyntax, (ll_len - ( ll_pos - 1) ) )
   ls_sql_1=ls_sql_1 + "AND id_conto="+ string(il_conto) + " " +ls_sql_2
	setsqlpreview(ls_sql_1)
ELSE	
	IF is_cli='S' THEN
		ll_pos=POS(sqlsyntax, 'order' )
		ll_len=LEN(sqlsyntax)
		ls_sql_1=Left (sqlsyntax, (ll_pos - 1) )
		ls_sql_2=Right(sqlsyntax, (ll_len - ( ll_pos - 1) ) )
  		 ls_sql_1=ls_sql_1 + "AND codice like '"+ ls_cli + "%' " +ls_sql_2
		setsqlpreview(ls_sql_1)
	ELSE	
		ll_pos=POS(sqlsyntax, 'order' )
		ll_len=LEN(sqlsyntax)
		ls_sql_1=Left (sqlsyntax, (ll_pos - 1) )
		ls_sql_2=Right(sqlsyntax, (ll_len - ( ll_pos - 1) ) )
  		ls_sql_1=ls_sql_1 + "AND codice like '"+ ls_fo + "%' " +ls_sql_2
		setsqlpreview(ls_sql_1)
	END IF
END IF

end event

event itemchanged;decimal ld_imp, ld_tot, ld_test

IF dwo.name='abbuono' THEN 
	ld_imp=dec(data)
   ld_test=dw_dett.getitemdecimal(row,'tot_reg')
	if isnull(ld_test) then ld_test=0
	if (ld_imp + ld_test)>0 then
		dw_dett.setitem(row,'test',1)
	else
		dw_dett.setitem(row,'test',0)
	end if	
	this.accepttext()
	ld_tot=dw_dett.getitemdecimal(1,'sum_abbuoni')
	if isnull(ld_tot) then ld_tot=0
	dw_tot.setitem(1,'tot_abbuoni',ld_tot)
END IF

IF dwo.name='tot_reg' THEN
   ld_imp=dec(data)
	ld_test=dw_dett.getitemdecimal(row,'abbuono')
	if isnull(ld_test) then ld_test=0
	if (ld_imp + ld_test)>0 then
		dw_dett.setitem(row,'test',1)
	else
		dw_dett.setitem(row,'test',0)
	end if
	this.accepttext()
	ld_tot=dw_dett.getitemdecimal(1,'sum_reg')
	if isnull(ld_tot) then ld_tot=0
	dw_tot.setitem(1,'tot_saldo',ld_tot)
END IF	

end event

type cb_registra from commandbutton within w_pag_abbuoni_wz
int X=2176
int Y=44
int Width=338
int Height=84
int TabOrder=70
boolean BringToTop=true
string Text="&Registra..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;constant long   LCL_ID_AZIENDA = 1
constant string LCS_DARE       = "D"
constant string LCS_AVERE      = "A"


long ll_id_prof_reg, ll_conto_abb, ll_contropartita, ll_ret
long ll_esercizio, ll_row, i, ll_id_conto_mc[], ll_id_par_aperta[]
char lc_segno_mc[]
boolean lb_mc_iva[]
decimal ld_tot_abb, ld_tot_reg, ldc_importo_mc[], ld_abb, ld_reg
date ld_data_reg

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd



dw_testa.accepttext()
dw_dett.accepttext()

ll_conto_abb     = dw_testa.GetItemNumber(1, "id_abbuono")
ll_contropartita = dw_testa.GetItemNumber(1, "id_contropartita")
ll_esercizio     = dw_testa.GetItemNumber(1, "id_esercizio")
ll_id_prof_reg   = dw_testa.GetItemNumber(1, "id_prof_registrazione")
ld_data_reg      = dw_testa.GetItemDate(1, "data_reg_pd")

IF IsNull(ll_id_prof_reg) OR IsNull(ll_conto_abb) OR IsNull(ll_esercizio) OR IsNull(ll_contropartita) THEN
	MessageBox("Riscossioni e Pagamenti", "Alcuni dati non sono stati inseriti correttamente!")
	dw_testa.SetColumn("prof_registrazione_cod")
	dw_testa.SetFocus()
	RETURN
END IF


dw_dett.setfilter("test=1")
dw_dett.filter()

ld_tot_abb=dw_tot.getitemnumber(1,'tot_abbuoni')
ld_tot_reg=dw_tot.getitemnumber(1,'tot_saldo')
if isnull(ld_tot_abb) then ld_tot_abb=0
if isnull(ld_tot_reg) then ld_tot_reg=0
ll_row=dw_dett.rowcount()

IF ll_row<=0 THEN	
	messagebox('ATTENZIONE','Non è stata selezionata nessuna partita.~r~nVerificare lo stato dei flag o degli importi')
	RETURN
END IF	
	
FOR i=1 TO ll_row

	 ll_id_conto_mc[i] = dw_dett.getitemnumber(i,'id_conto') 
    IF IS_CLI='S' THEN 
		lc_segno_mc[i] = LCS_AVERE
	 ELSE	
		lc_segno_mc[i] = LCS_DARE
	 END IF	
	 ld_abb=dw_dett.getitemnumber(i,'abbuono')
	 ld_reg=dw_dett.getitemnumber(i,'tot_reg')
	 if isnull(ld_abb) then ld_abb=0
	 if isnull(ld_reg) then ld_reg=0
	 ldc_importo_mc[i] = ld_abb + ld_reg
	 ll_id_par_aperta[i] = dw_dett.getitemnumber(i,'id_par_aperta')
    lb_mc_iva[i] = FALSE
	
NEXT

ll_id_conto_mc[ll_row + 1] = ll_conto_abb
IF IS_CLI='S' THEN 
	lc_segno_mc[ll_row + 1] = LCS_DARE
ELSE	
	lc_segno_mc[ll_row + 1] = LCS_AVERE
END IF	
ldc_importo_mc[ll_row + 1] = ld_tot_abb
SetNull(ll_id_par_aperta[ll_row + 1])
lb_mc_iva[ll_row + 1] = FALSE

ll_id_conto_mc[ll_row + 2] = ll_contropartita
IF IS_CLI='S' THEN 
	lc_segno_mc[ll_row + 2] = LCS_DARE
ELSE	
	lc_segno_mc[ll_row + 2] = LCS_AVERE
END IF	
ldc_importo_mc[ll_row + 2] = ld_tot_reg
SetNull(ll_id_par_aperta[ll_row + 2])
lb_mc_iva[ll_row + 2] = FALSE

lu_reg_pd.uf_DisplayMode(2)
lu_reg_pd.uf_Reset()
lu_reg_pd.uf_id_prof_registrazione(ll_id_prof_reg)
lu_reg_pd.uf_id_esercizio(ll_esercizio)
lu_reg_pd.uf_data_registrazione(ld_data_reg)
lu_reg_pd.uf_data_competenza(ld_data_reg)
lu_reg_pd.uf_id_azienda(lcl_id_azienda)

lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
lu_reg_pd.uf_segno_mc(lc_segno_mc)
lu_reg_pd.uf_importo_mc(ldc_importo_mc)
lu_reg_pd.uf_id_par_aperta(ll_id_par_aperta)
lu_reg_pd.uf_crea_mov_partita(TRUE)
lu_reg_pd.uf_mc_iva(lb_mc_iva)
		
ll_Ret = lu_reg_pd.uf_crea()
IF ll_ret>0 then 
	close(parent)
else
	messagebox('Errore','Non è stata generata nessuna registrazione / '+string(ll_ret))
	messagebox('Errore','Verificare lo stato dei flag o degli importi')
end if	





end event

