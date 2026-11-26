forward
global type w_dati_articolo_cx from w_p_data
end type
type dw_dati_articolo_uc_gd from u_dw_master_main within w_dati_articolo_cx
end type
type dw_dati_articolo_pv_gd from u_dw_master_main within w_dati_articolo_cx
end type
type dw_dati_articolo_clv_gd from u_dw_master_main within w_dati_articolo_cx
end type
type cb_sit_articolo from commandbutton within w_dati_articolo_cx
end type
type cb_riepilogo from commandbutton within w_dati_articolo_cx
end type
type cb_prezzi_acq from commandbutton within w_dati_articolo_cx
end type
type dw_dati_articolo_data_ext from u_dw_ext_main within w_dati_articolo_cx
end type
type cb_aggiorna from commandbutton within w_dati_articolo_cx
end type
type cbx_cod_barre from checkbox within w_dati_articolo_cx
end type
type cb_esci from commandbutton within w_dati_articolo_cx
end type
type dw_dati_articolo_ext from u_dw_ext_main within w_dati_articolo_cx
end type
type dw_dati_articolo_ff from u_dw_master_main within w_dati_articolo_cx
end type
type cb_1 from commandbutton within w_dati_articolo_cx
end type
type cb_2 from commandbutton within w_dati_articolo_cx
end type
end forward

global type w_dati_articolo_cx from w_p_data
int Width=3451
int Height=1616
boolean TitleBar=true
string Title="Informazioni Articolo"
dw_dati_articolo_uc_gd dw_dati_articolo_uc_gd
dw_dati_articolo_pv_gd dw_dati_articolo_pv_gd
dw_dati_articolo_clv_gd dw_dati_articolo_clv_gd
cb_sit_articolo cb_sit_articolo
cb_riepilogo cb_riepilogo
cb_prezzi_acq cb_prezzi_acq
dw_dati_articolo_data_ext dw_dati_articolo_data_ext
cb_aggiorna cb_aggiorna
cbx_cod_barre cbx_cod_barre
cb_esci cb_esci
dw_dati_articolo_ext dw_dati_articolo_ext
dw_dati_articolo_ff dw_dati_articolo_ff
cb_1 cb_1
cb_2 cb_2
end type
global w_dati_articolo_cx w_dati_articolo_cx

type variables
long il_id_art
integer ii_ricerca_art_fornitore
end variables

forward prototypes
public subroutine wf_retrieve_master ()
end prototypes

public subroutine wf_retrieve_master ();long		ll_id_articolo
integer	li_row

li_row = dw_dati_articolo_ext.getrow()

if li_row > 0 then
	ll_id_articolo = dw_dati_articolo_ext.getitemnumber(1, "id_articolo")
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_articolo"
	idw_master.is_list.l_identifica[1]=ll_id_articolo
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if

end subroutine

on w_dati_articolo_cx.create
int iCurrent
call super::create
this.dw_dati_articolo_uc_gd=create dw_dati_articolo_uc_gd
this.dw_dati_articolo_pv_gd=create dw_dati_articolo_pv_gd
this.dw_dati_articolo_clv_gd=create dw_dati_articolo_clv_gd
this.cb_sit_articolo=create cb_sit_articolo
this.cb_riepilogo=create cb_riepilogo
this.cb_prezzi_acq=create cb_prezzi_acq
this.dw_dati_articolo_data_ext=create dw_dati_articolo_data_ext
this.cb_aggiorna=create cb_aggiorna
this.cbx_cod_barre=create cbx_cod_barre
this.cb_esci=create cb_esci
this.dw_dati_articolo_ext=create dw_dati_articolo_ext
this.dw_dati_articolo_ff=create dw_dati_articolo_ff
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dati_articolo_uc_gd
this.Control[iCurrent+2]=this.dw_dati_articolo_pv_gd
this.Control[iCurrent+3]=this.dw_dati_articolo_clv_gd
this.Control[iCurrent+4]=this.cb_sit_articolo
this.Control[iCurrent+5]=this.cb_riepilogo
this.Control[iCurrent+6]=this.cb_prezzi_acq
this.Control[iCurrent+7]=this.dw_dati_articolo_data_ext
this.Control[iCurrent+8]=this.cb_aggiorna
this.Control[iCurrent+9]=this.cbx_cod_barre
this.Control[iCurrent+10]=this.cb_esci
this.Control[iCurrent+11]=this.dw_dati_articolo_ext
this.Control[iCurrent+12]=this.dw_dati_articolo_ff
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.cb_2
end on

on w_dati_articolo_cx.destroy
call super::destroy
destroy(this.dw_dati_articolo_uc_gd)
destroy(this.dw_dati_articolo_pv_gd)
destroy(this.dw_dati_articolo_clv_gd)
destroy(this.cb_sit_articolo)
destroy(this.cb_riepilogo)
destroy(this.cb_prezzi_acq)
destroy(this.dw_dati_articolo_data_ext)
destroy(this.cb_aggiorna)
destroy(this.cbx_cod_barre)
destroy(this.cb_esci)
destroy(this.dw_dati_articolo_ext)
destroy(this.dw_dati_articolo_ff)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;il_HelpTopic = 43

idw_master = dw_dati_articolo_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_articolo"
ib_NonModale = TRUE

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_articolo"
	idw_master.is_list.s_modo=modo_inserisci
end if

il_id_art = message.doubleparm 

string ls_rch

select rch
into :ls_rch
from pers_par_sistema;

if ls_rch = 'S' then cb_1.visible = true
end event

event ue_post_open;call super::ue_post_open;cb_ricerca.visible=true
dw_dati_articolo_data_ext.insertrow(0)
dw_dati_articolo_ext.insertrow(0)

DataWindowChild ldw_id_cat_com_articolo

dw_dati_articolo_ext.getchild("id_cat_com_articolo", ldw_id_cat_com_articolo)
ldw_id_cat_com_articolo.settransobject(SQLCA)
ldw_id_cat_com_articolo.retrieve()

if not isnull(il_id_art) and il_id_Art <> 0 then
	string ls_cod, ls_des
	
	select codice, descrizione
	into :ls_cod, :ls_des
	from articolo
	where id_articolo = :il_id_Art;
	
	dw_dati_articolo_ext.setitem(1,"id_articolo",il_id_art)
	dw_dati_articolo_ext.setitem(1,"codice",ls_cod)
	dw_dati_articolo_ext.setitem(1,"descrizione",ls_des)
	post wf_retrieve_master()
end if
end event

type p_crescente from w_p_data`p_crescente within w_dati_articolo_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_dati_articolo_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_dati_articolo_cx
int X=3547
int Y=20
boolean BringToTop=true
string Text="&Esci"
end type

type cb_annulla from w_p_data`cb_annulla within w_dati_articolo_cx
int Y=32
boolean Visible=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_dati_articolo_cx
int Y=32
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;integer li_null

setnull(li_null)

dw_dati_articolo_ext.setitem(1, "codice", "")
dw_dati_articolo_ext.setitem(1, "descrizione", "")
dw_dati_articolo_ext.setitem(1, "id_cat_com_articolo", li_null)
dw_dati_articolo_ext.setitem(1, "id_articolo", li_null)

end event

type cb_inserisci from w_p_data`cb_inserisci within w_dati_articolo_cx
int X=2560
int Y=32
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_dati_articolo_cx
int X=2853
int Y=32
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_dati_articolo_cx
int X=3145
int Y=32
boolean Visible=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_dati_articolo_cx
int X=137
int Y=2096
int Height=120
int TabOrder=90
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
int Height=0
end type

type cb_ricerca from w_p_data`cb_ricerca within w_dati_articolo_cx
int X=329
int Y=28
boolean BringToTop=true
end type

event cb_ricerca::clicked;
w_search_main 	lw_sm
string 			ls_filtro, ls_codice
long 				ll_seg_value, ll_id_articolo
long				li_i
s_ric_param		ls_ric_param


ll_id_articolo = dw_dati_articolo_ext.getitemnumber(1, "id_articolo")
ls_codice      = dw_dati_articolo_ext.getitemstring(1, "codice")

idw_master.is_ricpar.s_filter_value = ls_codice
idw_master.is_ricpar.s_filter_name  = "articolo_codice"

if (ll_id_articolo > 0) then &
	ls_filtro = ls_filtro  + "articolo.id_articolo = " + string(ll_id_articolo)

idw_master.is_ricpar.s_SQL_cond = ls_filtro
openwithparm(lw_sm, idw_master.is_ricpar, "w_articolo_coddes_sw")

idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_articolo"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if

end event

type dw_dati_articolo_uc_gd from u_dw_master_main within w_dati_articolo_cx
int X=37
int Y=428
int Width=3369
int Height=420
int TabOrder=60
boolean BringToTop=true
string DataObject="d_dati_articolo_uc_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
end event

type dw_dati_articolo_pv_gd from u_dw_master_main within w_dati_articolo_cx
int X=37
int Y=856
int Width=1618
int Height=524
int TabOrder=70
boolean BringToTop=true
string DataObject="d_dati_articolo_pv_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
end event

event sqlpreview;string  ls_sqlsyntax
date    ldt_data
integer li_row

ls_sqlsyntax = sqlsyntax

li_row = dw_dati_articolo_data_ext.getrow()
if li_row > 0 then ldt_data = dw_dati_articolo_data_ext.getitemdate(li_row, "data_corrente")

if isnull(ldt_data) or li_row = 0 then ldt_data = today()

ls_sqlsyntax = ls_sqlsyntax + " AND variazione.data_inizio <= '" + string(ldt_data, 'yyyy-mm-dd') + "'"
ls_sqlsyntax = ls_sqlsyntax + " AND ( variazione.data_fine >= '" + string(ldt_data, 'yyyy-mm-dd') + "' OR variazione.data_fine IS NULL) "
ls_sqlsyntax = ls_sqlsyntax + " ORDER BY listino.codice"

setsqlpreview(ls_sqlsyntax)
end event

type dw_dati_articolo_clv_gd from u_dw_master_main within w_dati_articolo_cx
int X=1659
int Y=856
int Width=1746
int Height=524
int TabOrder=80
boolean BringToTop=true
string DataObject="d_dati_articolo_clv_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
end event

event sqlpreview;string  ls_sqlsyntax
date    ldt_data
integer li_row

ls_sqlsyntax = sqlsyntax

li_row = dw_dati_articolo_data_ext.getrow()
if li_row > 0 then ldt_data = dw_dati_articolo_data_ext.getitemdate(li_row, "data_corrente")

if isnull(ldt_data) or li_row = 0 then ldt_data = today()

ls_sqlsyntax = ls_sqlsyntax + " AND data_inizio <= '" + string(ldt_data, 'yyyy-mm-dd') + "'"
ls_sqlsyntax = ls_sqlsyntax + " AND ( data_fine >= '" + string(ldt_data, 'yyyy-mm-dd') + "' OR data_fine IS NULL) "
ls_sqlsyntax = ls_sqlsyntax + " ORDER BY priorita"

setsqlpreview(ls_sqlsyntax)
end event

type cb_sit_articolo from commandbutton within w_dati_articolo_cx
int X=955
int Y=1408
int Width=489
int Height=84
int TabOrder=100
boolean BringToTop=true
string Text="&Situazione Articolo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long 				ll_id_articolo, ll_id_magazzino, ll_id_profilo
integer			li_row
s_list_main		lstr_list

li_row 			= dw_dati_articolo_ff.getrow()
if li_row > 0 then ll_id_articolo = dw_dati_articolo_ff.GetItemNumber (1,"id_articolo")
if ll_id_articolo > 0 then	
	lstr_list.s_win_parametri='D'
	lstr_list.l_identifica[1]	= ll_id_articolo
	
	
	setnull(ll_id_magazzino)
	lstr_list.l_identifica[2]  = ll_id_magazzino		
	
	SELECT id_magazzino
	INTO	 :ll_id_magazzino
	FROM	 par_sistema
	;
	
	lstr_list.l_identifica[3]  = ll_id_magazzino
	
	
	
	if Upperbound(idw_master.is_list.l_identifica) > 1 then
		if (idw_master.is_list.l_identifica[3] > 0) then
			SELECT id_magazzino
			INTO	 :ll_id_magazzino
			FROM	 locazione
			WHERE	 id_locazione = :idw_master.is_list.l_identifica[3]
			;
		else
			ll_id_magazzino = 0
		end if
		lstr_list.l_identifica[2]	= idw_master.is_list.l_identifica[2]
		lstr_list.l_identifica[3]	= ll_id_magazzino
		if not isNull(ll_id_profilo) then
			lstr_list.s_par_name[1]		= "id_prof_documento"
			lstr_list.s_par_value[1]	= idw_master.is_list.s_par_value[1]
		end if	
		lstr_list.s_win_parametri='D'
	end if
	
	w_wiz_main lw_sm
	OpenWithParm(lw_sm, lstr_list, "w_sit_articolo_wz")
end if
end event

type cb_riepilogo from commandbutton within w_dati_articolo_cx
int X=1477
int Y=1408
int Width=297
int Height=84
int TabOrder=110
boolean BringToTop=true
string Text="&Riepiloghi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long 				ll_id_articolo
integer			li_row
string			ls_tipo
s_list_main		lstr_list

li_row 			= dw_dati_articolo_ff.getrow()
if li_row > 0 then ll_id_articolo = dw_dati_articolo_ff.GetItemNumber (1,"id_articolo")
if ll_id_articolo > 0 then	
	lstr_list.l_identifica[1]	= ll_id_articolo
	
	long ll_found
	ll_found = dw_dati_articolo_uc_gd.Find("unita_confezione_unita_base = 'S'", 0, dw_dati_articolo_uc_gd.RowCount())
	
	if ll_found > 0 then 
		ls_tipo = dw_dati_articolo_uc_gd.getitemstring(ll_found, "unita_misura_tipo")
		lstr_list.s_provenienza = ls_tipo
	end if
	OpenWithParm(w_stampa_riep_art_ff, lstr_list)
end if

end event

type cb_prezzi_acq from commandbutton within w_dati_articolo_cx
int X=1806
int Y=1408
int Width=425
int Height=84
int TabOrder=120
boolean BringToTop=true
string Text="&Prezzi Acquisto"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long 				ll_id_articolo
integer			li_row
s_list_main		ls_list_main
date				ldt_data
w_p_data			iw_support

li_row 			= dw_dati_articolo_ff.getrow()
if li_row > 0 then ll_id_articolo = dw_dati_articolo_ff.GetItemNumber (1,"id_articolo")
if ll_id_articolo > 0 then	
	li_row = dw_dati_articolo_data_ext.getrow()
	if li_row > 0 then ldt_data = dw_dati_articolo_data_ext.getitemdate(li_row, "data_corrente") 
	if isnull(ldt_data) then ldt_data = today()

	ls_list_main.s_modo=modo_modifica
	ls_list_main.s_identifica[1]="id_articolo"
	ls_list_main.l_identifica[1]=ll_id_articolo
	
	
	if Upperbound(idw_master.is_list.l_identifica) > 1 then
		ls_list_main.l_identifica[2]=idw_master.is_list.l_identifica[3] 
	end if
	ls_list_main.s_provenienza=string(ldt_data)
			
	openwithparm(w_dati_articolo_pa_cx, ls_list_main)
end if
end event

type dw_dati_articolo_data_ext from u_dw_ext_main within w_dati_articolo_cx
int X=2194
int Y=20
int Width=773
int Height=124
int TabOrder=10
boolean BringToTop=true
string DataObject="d_dati_articolo_data_ext"
end type

type cb_aggiorna from commandbutton within w_dati_articolo_cx
int X=3035
int Y=28
int Width=279
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="&Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;idw_master.event ue_retrieve(0,0)
end event

type cbx_cod_barre from checkbox within w_dati_articolo_cx
int X=1024
int Y=32
int Width=407
int Height=76
boolean BringToTop=true
string Text="Codice a barre:"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_esci from commandbutton within w_dati_articolo_cx
int X=37
int Y=28
int Width=261
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_dati_articolo_ext from u_dw_ext_main within w_dati_articolo_cx
int X=37
int Y=160
int Width=3369
int Height=260
int TabOrder=30
boolean BringToTop=true
string DataObject="d_dati_articolo_ext"
end type

event ue_use_search;string ls_null 
setnull(ls_null)

uf_set_colval(as_nomecol, is_ricpar.s_main_value)
uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])

CHOOSE CASE as_nomecol
	CASE "codice"
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])		
	CASE "descrizione"
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
END CHOOSE

post wf_retrieve_master()
end event

event ue_set_search;
if (ii_ricerca_art_fornitore = 1) then
	is_search_window = "w_des_articolo_coddes_documento_sw" 
else
	if (cbx_cod_barre.checked) then
		is_search_window = "w_articolo_codbarre_sw"
	else
		is_search_window = "w_articolo_coddes_sw"
	end if
end if


is_ricpar.s_filter_value = as_valcol

CHOOSE CASE as_nomecol
	CASE "codice"
		
		
		if (ii_ricerca_art_fornitore = 1) then		
			is_ricpar.s_filter_name = "des_articolo_codice"			
		else
			if (cbx_cod_barre.checked) then
				is_ricpar.s_filter_name ="cod_barre_codice"
			else
				is_ricpar.s_filter_name ="articolo_codice"			
			end if
		end if
			
	CASE "descrizione"
		
		
		if (ii_ricerca_art_fornitore = 1) then
			is_ricpar.s_filter_name = "des_articolo_descrizione"			
		else 
			is_ricpar.s_filter_name ="articolo_descrizione"
		end if
		

END CHOOSE

end event

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, ls_cod_articolo
long      ll_ok
ls_sql_cond = ""

CHOOSE CASE dwo.name
	CASE 'codice', 'descrizione'
   if ii_ricerca_art_fornitore = 0 then
		if (dwo.name = 'codice' and cbx_cod_barre.checked) then
			SELECT a.codice
			INTO	 :ls_cod_articolo
			FROM	 cod_barre c, unita_confezione u, articolo a
			WHERE	 c.codice = :Data
			AND	 u.id_unita_confezione = c.id_unita_confezione
			AND	 a.id_articolo = u.id_articolo;
			
			choose case SQLCA.SQLCODE
				case -1
					messagebox("", SQLCA.SQLERRTEXT)
				case 100
					messagebox("", "Il codice a barre acquisito non è stato codificato ")
					return 2
				case 0
					this.Post setitem(row,"codice", ls_cod_articolo)
					data = ls_cod_articolo
			end choose			
		end if
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "descrizione"
			
		if (dwo.name = 'codice') then
	
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
		else
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &
											"descrizione", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
		end if			
			
		IF (ll_ok > 0) THEN
			post wf_retrieve_master()
			RETURN 2
		END IF
	end if		
END CHOOSE
end event

event clicked;string ls_test, ls_campo

dw_dati_articolo_ext.accepttext()
ls_campo=dwo.name
if right(ls_campo,3)='_sw' then
	ls_campo=left(ls_campo,len(ls_campo) - 3)
	ls_test=dw_dati_articolo_ext.getitemstring(1,ls_campo)
	if isnull(ls_test) or ls_test='' then 
		call super::clicked
	end if
end if	

end event

event ue_key;call super::ue_key;long ll_row, ll_art, ll_id_cat_com_art
string ls_cod, ls_des

string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval
w_search_main		lw_sm

ii_ricerca_art_fornitore = 0		

choose case key

		
	CASE KeyF!
		CHOOSE CASE keyflags
			CASE 2
					ii_ricerca_art_fornitore = 1				
   			   this.accepttext()
				   ll_row=this.getrow()
				   ls_cod=trim(this.getitemstring(ll_row,'codice'))
					select id_articolo 
					into :ll_Art
					from des_articolo
					where codice = :ls_cod;
					if sqlca.sqlcode=0 then
						select  codice, descrizione 
						into :ls_cod, :ls_des , :ll_id_cat_com_art
						from articolo 
						where id_articolo = :ll_art;
						
						this.setitem(ll_row,'codice', ls_cod)
						this.setitem(ll_row,'id_articolo', ll_art)
						this.setitem(ll_row,'descrizione', ls_des)
						this.setitem(ll_row,'id_cat_com_articolo', ll_id_cat_com_art)
						ii_ricerca_art_fornitore = 1	
						return 
					else	
						trigger event ue_key(KeyF4!, 0)
					end if	
			END CHOOSE		
end choose
end event

type dw_dati_articolo_ff from u_dw_master_main within w_dati_articolo_cx
int X=3662
int Y=272
int Height=288
int TabOrder=20
boolean BringToTop=true
string DataObject="d_dati_articolo_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
iudw_children[1] = dw_dati_articolo_uc_gd
iudw_children[2] = dw_dati_articolo_pv_gd
iudw_children[3] = dw_dati_articolo_clv_gd
end event

event retrieveend;integer li_row
li_row = this.getrow()

dw_dati_articolo_ext.setitem(1, "codice", this.getitemstring(li_row, "codice"))
dw_dati_articolo_ext.setitem(1, "descrizione", this.getitemstring(li_row, "descrizione"))
dw_dati_articolo_ext.setitem(1, "id_cat_com_articolo", this.getitemnumber(li_row, "id_cat_com_articolo"))

end event

type cb_1 from commandbutton within w_dati_articolo_cx
int X=2629
int Y=1408
int Width=165
int Height=84
int TabOrder=130
boolean Visible=false
boolean BringToTop=true
string Text="RCH"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_articolo, ll_row

ll_row = dw_dati_articolo_ext.getrow()
ll_id_articolo = dw_dati_articolo_ext.getitemnumber(ll_row,"id_articolo")

//if not isnull(ll_id_articolo) then openwithparm(w_rch_scn_mag_art_cx,ll_id_articolo)
	
end event

type cb_2 from commandbutton within w_dati_articolo_cx
int X=2263
int Y=1408
int Width=329
int Height=84
int TabOrder=130
boolean BringToTop=true
string Text="Des. Articolo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_articolo, ll_row

ll_row = dw_dati_articolo_ext.getrow()
ll_id_articolo = dw_dati_articolo_ext.getitemnumber(ll_row,"id_articolo")

if not isnull(ll_id_articolo) then openwithparm(w_dati_art_desart_cx,ll_id_articolo)
end event

