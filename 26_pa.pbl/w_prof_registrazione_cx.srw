forward
global type w_prof_registrazione_cx from w_p_data
end type
type dw_prof_mov_contabile_gd from u_dw_master_main within tabpage_1
end type
type dw_prof_mov_contabile_gd from u_dw_master_main within tabpage_1
end type
type tabpage_wizard from userobject within tab_1
end type
type dw_wiz_profilo_gd from u_dw_master_main within tabpage_wizard
end type
type dw_prof_registrazione_ff from u_dw_master_main within w_prof_registrazione_cx
end type
type cb_1 from commandbutton within w_prof_registrazione_cx
end type
type cb_m from commandbutton within w_prof_registrazione_cx
end type
type cb_n from commandbutton within w_prof_registrazione_cx
end type
type cb_d from commandbutton within w_prof_registrazione_cx
end type
type cb_r from commandbutton within w_prof_registrazione_cx
end type
type cb_c from commandbutton within w_prof_registrazione_cx
end type
type cb_f from commandbutton within w_prof_registrazione_cx
end type
type cb_s from commandbutton within w_prof_registrazione_cx
end type
type st_0 from statictext within w_prof_registrazione_cx
end type
type st_1 from statictext within w_prof_registrazione_cx
end type
type st_2 from statictext within w_prof_registrazione_cx
end type
type st_3 from statictext within w_prof_registrazione_cx
end type
type st_4 from statictext within w_prof_registrazione_cx
end type
type st_5 from statictext within w_prof_registrazione_cx
end type
type st_6 from statictext within w_prof_registrazione_cx
end type
type st_7 from statictext within w_prof_registrazione_cx
end type
type cb_p from commandbutton within w_prof_registrazione_cx
end type
type st_8 from statictext within w_prof_registrazione_cx
end type
type tabpage_wizard from userobject within tab_1
dw_wiz_profilo_gd dw_wiz_profilo_gd
end type
end forward

global type w_prof_registrazione_cx from w_p_data
int X=343
int Y=260
int Width=2798
int Height=1860
boolean TitleBar=true
string Title="Profilo Registrazione"
dw_prof_registrazione_ff dw_prof_registrazione_ff
cb_1 cb_1
cb_m cb_m
cb_n cb_n
cb_d cb_d
cb_r cb_r
cb_c cb_c
cb_f cb_f
cb_s cb_s
st_0 st_0
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
cb_p cb_p
st_8 st_8
end type
global w_prof_registrazione_cx w_prof_registrazione_cx

type variables
uo_msg_log	iuo_msglog
u_debug		iu_debug
integer                      il_wind
end variables

forward prototypes
public subroutine uf_proteggi_campi (string as_data)
public subroutine uf_filtra_registro (string as_data)
public subroutine uf_clicked ()
end prototypes

public subroutine uf_proteggi_campi (string as_data);

CHOOSE CASE as_data
	CASE "P"
		f_displayonly(dw_prof_registrazione_ff, "prof_registrazione_tipo_fattura", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "tab_iva_codice", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "tab_iva_descrizione", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "conto_codice", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "conto_descrizione", TRUE)
	CASE "M"
		f_displayonly(dw_prof_registrazione_ff, "prof_registrazione_tipo_fattura", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "tab_iva_codice", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "tab_iva_descrizione", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "conto_codice", TRUE)
		f_displayonly(dw_prof_registrazione_ff, "conto_descrizione", TRUE)
	CASE "A"
		f_displayonly(dw_prof_registrazione_ff, "prof_registrazione_tipo_fattura", FALSE)
		f_displayonly(dw_prof_registrazione_ff, "tab_iva_codice", FALSE)
		f_displayonly(dw_prof_registrazione_ff, "tab_iva_descrizione", FALSE)
		f_displayonly(dw_prof_registrazione_ff, "conto_codice", FALSE)
		f_displayonly(dw_prof_registrazione_ff, "conto_descrizione", FALSE)
	CASE "V"
		f_displayonly(dw_prof_registrazione_ff, "prof_registrazione_tipo_fattura", FALSE)
		f_displayonly(dw_prof_registrazione_ff, "tab_iva_codice", FALSE)

		f_displayonly(dw_prof_registrazione_ff, "tab_iva_descrizione", FALSE)
		f_displayonly(dw_prof_registrazione_ff, "conto_codice", FALSE)
		f_displayonly(dw_prof_registrazione_ff, "conto_descrizione", FALSE)
END CHOOSE

end subroutine

public subroutine uf_filtra_registro (string as_data);

string ls_filtro
DataWindowChild ldwc_registro

CHOOSE CASE as_data
	CASE "P"
		ls_filtro = "mod_registro_tipo_registro = 'PN'"
	CASE "M"
		ls_filtro = "mod_registro_tipo_registro = 'MN'"
	CASE "A"
		ls_filtro = "mod_registro_tipo_registro = 'IA'"
	CASE "V"
		ls_filtro = "mod_registro_tipo_registro = 'IV' OR mod_registro_tipo_registro = 'IC'"
END CHOOSE

dw_prof_registrazione_ff.GetChild("prof_registrazione_id_mod_registro", ldwc_registro)
ldwc_registro.SetFilter(ls_filtro)
ldwc_registro.Filter()

end subroutine

public subroutine uf_clicked ();
end subroutine

event open;call super::open;il_helptopic = 76

idw_master = dw_prof_registrazione_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "prof_registrazione.id_prof_registrazione"

iuo_msglog = create uo_msg_log
IF IsValid(w_msg_log) THEN
	w_msg_log.x = 900
	w_msg_log.width = 2700
	w_msg_log.height = 400
END IF

	
	
il_wind=1
end event

on w_prof_registrazione_cx.create
int iCurrent
call super::create
this.dw_prof_registrazione_ff=create dw_prof_registrazione_ff
this.cb_1=create cb_1
this.cb_m=create cb_m
this.cb_n=create cb_n
this.cb_d=create cb_d
this.cb_r=create cb_r
this.cb_c=create cb_c
this.cb_f=create cb_f
this.cb_s=create cb_s
this.st_0=create st_0
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.cb_p=create cb_p
this.st_8=create st_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_prof_registrazione_ff
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_m
this.Control[iCurrent+4]=this.cb_n
this.Control[iCurrent+5]=this.cb_d
this.Control[iCurrent+6]=this.cb_r
this.Control[iCurrent+7]=this.cb_c
this.Control[iCurrent+8]=this.cb_f
this.Control[iCurrent+9]=this.cb_s
this.Control[iCurrent+10]=this.st_0
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.cb_p
this.Control[iCurrent+19]=this.st_8
end on

on w_prof_registrazione_cx.destroy
call super::destroy
destroy(this.dw_prof_registrazione_ff)
destroy(this.cb_1)
destroy(this.cb_m)
destroy(this.cb_n)
destroy(this.cb_d)
destroy(this.cb_r)
destroy(this.cb_c)
destroy(this.cb_f)
destroy(this.cb_s)
destroy(this.st_0)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cb_p)
destroy(this.st_8)
end on

event close;call super::close;
end event

type p_msg_log from w_p_data`p_msg_log within w_prof_registrazione_cx
int X=2354
int Y=40
boolean Visible=true
end type

type p_crescente from w_p_data`p_crescente within w_prof_registrazione_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_prof_registrazione_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_prof_registrazione_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_prof_registrazione_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_prof_registrazione_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_prof_registrazione_cx
int X=1440
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_prof_registrazione_cx
int X=1746
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_prof_registrazione_cx
int X=2048
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_prof_registrazione_cx
int X=18
int Y=1064
int Width=2738
int Height=684
int TabOrder=80
boolean BringToTop=true
long BackColor=79741120
tabpage_wizard tabpage_wizard
end type

on tab_1.create
this.tabpage_wizard=create tabpage_wizard
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_wizard
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_wizard)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2702
int Height=564
long BackColor=79741120
string Text="Profili Movimento Contabile"
long TabBackColor=79741120
dw_prof_mov_contabile_gd dw_prof_mov_contabile_gd
end type

on tabpage_1.create
this.dw_prof_mov_contabile_gd=create dw_prof_mov_contabile_gd
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_prof_mov_contabile_gd
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_prof_mov_contabile_gd)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_prof_registrazione_cx
boolean Visible=false
boolean BringToTop=true
end type

type dw_prof_mov_contabile_gd from u_dw_master_main within tabpage_1
event itemchanged pbm_dwnitemchange
event rowfocuschanged pbm_dwnrowchange
event ue_init pbm_custom01
event ue_initial ( )
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
int X=27
int Y=40
int Width=2656
int Height=508
int TabOrder=1
string DataObject="d_prof_mov_contabile_gd"
boolean VScrollBar=true
end type

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[]
long      ll_ok

CHOOSE CASE dwo.name
	
	CASE 'conto_codice'
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "conto_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", "codice", "A", data, "", 3,&
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'conto_descrizione'
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "conto_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", "descrizione", "A", data, "", 3,&
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE


end event

event rowfocuschanged;call super::rowfocuschanged;string ls_codice, ls_descrizione
long ll_conto, ll_row, ll_sog_comm

ll_row = GetRow()

if RowCount() > 0 then
	
	
	
	
	ll_conto = long(uf_get_colval("id_conto"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_conto)   ;

	
	uf_set_colval("conto_codice",ls_codice)
	uf_set_colval("conto_descrizione",ls_descrizione)
	
	
	setitemstatus(ll_row, "conto_codice", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "conto_descrizione", PRIMARY!, NotModified!)



end if
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_prof_registrazione"
end event

event ue_initial;call super::ue_initial;long ll_rownumber, ll_row_count, ll_max = 0, ll_rowvalue


ll_rownumber = RowCount()
for ll_row_count = 1 to ll_rownumber
	ll_rowvalue = GetItemNumber( ll_row_count, "num_riga")
	if not IsNull(ll_rowvalue) then ll_max = Max(ll_max, ll_rowvalue)
next
SetItem( GetRow(), "num_riga", ll_max + 1)
	
	
end event

event ue_set_search;

CHOOSE CASE as_nomecol
	CASE "conto_codice"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_codice"

	CASE "conto_descrizione"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_descrizione"

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])
	CASE "conto_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event getfocus;call super::getfocus;

long ll_CurrRow
char lc_insoluti

ll_CurrRow = dw_prof_registrazione_ff.GetRow()

IF ll_CurrRow > 0 THEN
	lc_insoluti = dw_prof_registrazione_ff.GetItemString(ll_CurrRow, "prof_registrazione_usa_insoluti")
	IF lc_insoluti = "S" THEN
		iuo_msglog.uf_show_msg_log()
		iuo_msglog.uf_new_text("Per la memorizzazione di un profilo da utilizzare per la registrazione di insoluti immettere:", 2)
		iuo_msglog.uf_new_text("Riga 1: Conto attivo patrimoniale di registrazione delle ricevute bancarie.", 3)
		iuo_msglog.uf_new_text("Riga 2: Conto Oneri Bancari.", 3)
		iuo_msglog.uf_new_text("Riga 3: Conto Banca.", 3)
	END IF
END IF
end event

event updatestart;
long ll_totrows, ll_id_prof
int i

ll_id_prof = dw_prof_registrazione_ff.getitemnumber(1,"id_prof_registrazione")
ll_totrows = tab_1.tabpage_1.dw_prof_mov_contabile_gd.rowcount()
for i=1 to ll_totrows
	tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(i,"id_prof_registrazione",ll_id_prof)
next
end event

event clicked;call super::clicked;
il_wind=2

cb_f.visible=false; st_5.visible=false
cb_m.visible=true; st_7.visible=true	
end event

type tabpage_wizard from userobject within tab_1
int X=18
int Y=104
int Width=2702
int Height=564
long BackColor=79741120
string Text="Generazioni Automatiche"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_wiz_profilo_gd dw_wiz_profilo_gd
end type

on tabpage_wizard.create
this.dw_wiz_profilo_gd=create dw_wiz_profilo_gd
this.Control[]={this.dw_wiz_profilo_gd}
end on

on tabpage_wizard.destroy
destroy(this.dw_wiz_profilo_gd)
end on

type dw_wiz_profilo_gd from u_dw_master_main within tabpage_wizard
int X=27
int Y=36
int Width=2089
int Height=512
string DataObject="d_wiz_profilo_gd"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_prof_registrazione"
is_title = "Wizard"
end event

event ue_default;call super::ue_default;

long ll_CurrRow, ll_max_numero

CHOOSE CASE string(adwo_current.name)
	CASE "num_ordine"
		ll_CurrRow = dw_wiz_profilo_gd.GetRow()
		ll_max_numero = dw_wiz_profilo_gd.GetItemNumber(ll_CurrRow, "max_numero")
		IF IsNull(ll_max_numero) THEN ll_max_numero = 0
		dw_wiz_profilo_gd.SetItem(ll_CurrRow, "num_ordine", (ll_max_numero + 1))
END CHOOSE

end event

event updatestart;
long ll_totrows, ll_id_prof
int i

ll_id_prof = dw_prof_registrazione_ff.getitemnumber(1,"id_prof_registrazione")
ll_totrows = tab_1.tabpage_wizard.dw_wiz_profilo_gd.rowcount()
for i=1 to ll_totrows
	tab_1.tabpage_wizard.dw_wiz_profilo_gd.setitem(i,"id_prof_registrazione",ll_id_prof)
next
end event

event clicked;call super::clicked;
il_wind=3
end event

type dw_prof_registrazione_ff from u_dw_master_main within w_prof_registrazione_cx
int X=18
int Y=164
int Width=2222
int Height=880
int TabOrder=10
string DataObject="d_prof_registrazione_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_prof_registrazione"
iudw_children[1] = tab_1.tabpage_1.dw_prof_mov_contabile_gd
iudw_children[2] = tab_1.tabpage_wizard.dw_wiz_profilo_gd
is_title = "Profilo Registrazione"
end event

event itemfocuschanged;call super::itemfocuschanged;


end event

event ue_initial;call super::ue_initial;
end event

event ue_set_search;
long ll_id_c1,ll_id_c2,ll_id_c3,ll_id_c4
select id_conto_iva_sospesa,id_conto_iva_IA,id_conto_iva_IV,id_conto_iva_ND
into :ll_id_c1,:ll_id_c2,:ll_id_c3,:ll_id_c4
from par_sistema;
CHOOSE CASE as_nomecol
	CASE "conto_codice"
		is_search_window = "w_conto_sw" 
		
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		
		is_ricpar.s_sql_cond=''
	CASE "conto_descrizione"
		is_search_window = "w_conto_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond=''
		
END CHOOSE

CHOOSE CASE as_nomecol

	CASE "id_valuta"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "des_valuta"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "des_valuta"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
		
	CASE "des_contabile"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_des_contabile_gd"
		is_ricpar.s_titolo_finestra = "Descrizioni Contabili"
		
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])
	CASE "conto_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_des
long      ll_ok, ll_pos

CHOOSE CASE string(dwo.name)

	CASE "tipo_registrazione"
		if data='P' and dw_prof_registrazione_ff.getitemstring(1,'prof_registrazione_crea_partita')='S' then
			dw_prof_registrazione_ff.setitem(1,"prof_registrazione_tipo_fattura",'C')
		end if	
		uf_proteggi_campi(data)
		uf_filtra_registro(data)
		THIS.SetItem(row, "prof_registrazione_id_mod_registro", u_freddie.gl_null)
		if data='A' or data='V' then 
			cb_f.visible=true; st_5.visible=true
		else	
			cb_f.visible=false; st_5.visible=false
			ls_des=this.getitemstring(1,'descrizione')
			ll_pos=pos(ls_des,'@F',1)
			if ll_pos>0 then ls_des=Replace(ls_des,ll_pos,2,'' )
			this.setitem(1,'descrizione', ls_des)
		end if	
	CASE 'conto_codice'
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto_iva"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "conto_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", "codice", "A", data, "", 3,&
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'conto_descrizione'
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto_iva"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "conto_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", "descrizione", "A", data, "", 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "prof_registrazione_crea_partita"
		if data='S' and dw_prof_registrazione_ff.getitemstring(1,'tipo_registrazione')='P' then
			dw_prof_registrazione_ff.setitem(1,"prof_registrazione_tipo_fattura",'C')
		end if		

END CHOOSE


end event

event rowfocuschanged;call super::rowfocuschanged;string ls_codice, ls_descrizione
long ll_conto, ll_row, ll_sog_comm

ll_row = GetRow()

if RowCount() > 0 then
	
	
	
	
	ll_conto = long(uf_get_colval("id_conto_iva"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_conto)   ;

	
	uf_set_colval("conto_codice",ls_codice)
	uf_set_colval("conto_descrizione",ls_descrizione)
	
	
	setitemstatus(ll_row, "conto_codice", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "conto_descrizione", PRIMARY!, NotModified!)



end if
end event

event ue_retrieve;call super::ue_retrieve;

long ll_CurrRow
char lc_tipo_fattura

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	lc_tipo_fattura = THIS.GetItemString(ll_CurrRow, "tipo_registrazione")
	uf_proteggi_campi(lc_tipo_fattura)
	uf_filtra_registro(lc_tipo_fattura)
END IF
end event

event clicked;call super::clicked;
il_wind=1

if this.getitemstring(1,'tipo_registrazione')='A' or this.getitemstring(1,'tipo_registrazione')='V' then 
	cb_f.visible=true; st_5.visible=true
	cb_d.visible=true; st_2.visible=true
	cb_n.visible=true; st_1.visible=true
else
	cb_f.visible=false; st_5.visible=false
	cb_d.visible=false; st_2.visible=false
	cb_n.visible=false; st_1.visible=false
end if	
cb_m.visible=false; st_7.visible=false	
cb_s.visible=false; st_6.visible=false		
end event

type cb_1 from commandbutton within w_prof_registrazione_cx
int X=1111
int Y=40
int Width=279
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="&Duplica..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
Long   ll_id_prof, ll_null, ll_totrows
String ls_cod, ls_null
int i


setnull(ll_null)
ls_null=""

dw_prof_registrazione_ff.setitem(1,"id_prof_registrazione",ll_null)

dw_prof_registrazione_ff.setitem(1,"codice",ls_null)
dw_prof_registrazione_ff.setitemstatus(1,0,primary!,newmodified!)

ll_totrows = tab_1.tabpage_1.dw_prof_mov_contabile_gd.rowcount()
for i=1 to ll_totrows
	tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(i,"id_prof_registrazione",ll_null)
	tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitemstatus(i,0,primary!,newmodified!)
next

ll_totrows = tab_1.tabpage_wizard.dw_wiz_profilo_gd.rowcount()
for i=1 to ll_totrows
	tab_1.tabpage_wizard.dw_wiz_profilo_gd.setitem(i,"id_prof_registrazione",ll_null)
	tab_1.tabpage_wizard.dw_wiz_profilo_gd.setitemstatus(i,0,primary!,newmodified!)
next

dw_prof_registrazione_ff.setfocus()
end event

type cb_m from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=880
int Width=105
int Height=80
int TabOrder=30
boolean BringToTop=true
string Text="@M"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row
string ls_des

if il_wind=2 then 
  ll_row=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getrow()	
  ls_des=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getitemstring(ll_row,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@M'
  else
	  ls_des=ls_des + ', @M'
  end if
  tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(ll_row,'des_contabile',ls_des)
end if
end event

type cb_n from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=280
int Width=105
int Height=80
int TabOrder=40
boolean BringToTop=true
string Text="@N"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row
string ls_des

if il_wind=1 then 
  ls_des=dw_prof_registrazione_ff.getitemstring(1,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@N'
  else
	  ls_des=ls_des + ', @N'
  end if
  dw_prof_registrazione_ff.setitem(1,'des_contabile',ls_des)
end if 

if il_wind=2 then 
  ll_row=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getrow()	
  ls_des=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getitemstring(ll_row,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@N'
  else
	  ls_des=ls_des + ', @N'
  end if
  tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(ll_row,'des_contabile',ls_des)
end if
end event

type cb_d from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=380
int Width=105
int Height=80
int TabOrder=50
boolean BringToTop=true
string Text="@D"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_des
long ll_row

if il_wind=1 then 
  ls_des=dw_prof_registrazione_ff.getitemstring(1,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@D'
  else
	  ls_des=ls_des + ', @D'
  end if
  dw_prof_registrazione_ff.setitem(1,'des_contabile',ls_des)
end if 

if il_wind=2 then 
  ll_row=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getrow()	
  ls_des=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getitemstring(ll_row,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@D'
  else
	  ls_des=ls_des + ', @D'
  end if
  tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(ll_row,'des_contabile',ls_des)
end if
end event

type cb_r from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=580
int Width=105
int Height=80
int TabOrder=60
boolean BringToTop=true
string Text="@R"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_des
long ll_row

if il_wind=1 then 
  ls_des=dw_prof_registrazione_ff.getitemstring(1,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@R'
  else
	  ls_des=ls_des + ', @R'
  end if
  dw_prof_registrazione_ff.setitem(1,'des_contabile',ls_des)
end if 

if il_wind=2 then 
  ll_row=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getrow()	
  ls_des=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getitemstring(ll_row,'des_contabile') 	
  if isnull(ls_des) then
	  ls_des='@R'
  else
	  ls_des=ls_des + ', @R'
  end if
  tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(ll_row,'des_contabile',ls_des)
end if
end event

type cb_c from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=680
int Width=105
int Height=80
int TabOrder=70
boolean BringToTop=true
string Text="@C"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_des
long ll_row

if il_wind=1 then 
  ls_des=dw_prof_registrazione_ff.getitemstring(1,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@C'
  else
	  ls_des=ls_des + ', @C'
  end if
  dw_prof_registrazione_ff.setitem(1,'des_contabile',ls_des)
end if 

if il_wind=2 then 
  ll_row=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getrow()	
  ls_des=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getitemstring(ll_row,'des_contabile') 	
  if isnull(ls_des) then
	  ls_des='@C'
  else
	  ls_des=ls_des + ', @C'
  end if
  tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(ll_row,'des_contabile',ls_des)
end if
end event

type cb_f from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=780
int Width=105
int Height=80
int TabOrder=90
boolean BringToTop=true
string Text="@F"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_des

if il_wind=1 then 
  ls_des=dw_prof_registrazione_ff.getitemstring(1,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@F'
  else
	  ls_des=ls_des + ', @F'
  end if
  dw_prof_registrazione_ff.setitem(1,'des_contabile',ls_des)
end if 
end event

type cb_s from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=980
int Width=105
int Height=80
int TabOrder=100
boolean BringToTop=true
string Text="@S"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_des
long ll_row

if il_wind=2 then 
  ll_row=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getrow()	
  ls_des=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getitemstring(ll_row,'des_contabile') 	
  if isnull(ls_des) then
	  ls_des='@S'
  else
	  ls_des=ls_des + ', @S'
  end if
  tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(ll_row,'des_contabile',ls_des)
end if
end event

type st_0 from statictext within w_prof_registrazione_cx
int X=2267
int Y=156
int Width=402
int Height=116
boolean Enabled=false
boolean BringToTop=true
string Text="Composizione descrizione"
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

type st_1 from statictext within w_prof_registrazione_cx
int X=2400
int Y=284
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Num. Doc."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_prof_registrazione_cx
int X=2400
int Y=384
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Data Doc."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_prof_registrazione_cx
int X=2400
int Y=588
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Data Reg."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_prof_registrazione_cx
int X=2395
int Y=692
int Width=261
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Data Comp."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_prof_registrazione_cx
int X=2395
int Y=792
int Width=261
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Sog. Com."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_prof_registrazione_cx
int X=2395
int Y=992
int Width=261
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Data Scad."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_prof_registrazione_cx
int X=2395
int Y=888
int Width=261
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Conto mov."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_p from commandbutton within w_prof_registrazione_cx
int X=2263
int Y=480
int Width=105
int Height=80
int TabOrder=60
boolean BringToTop=true
string Text="@P"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_des
long ll_row

if il_wind=1 then 
  ls_des=dw_prof_registrazione_ff.getitemstring(1,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@P'
  else
	  ls_des=ls_des + ', @P'
  end if
  dw_prof_registrazione_ff.setitem(1,'des_contabile',ls_des)
end if 

if il_wind=2 then 
  ll_row=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getrow()	
  ls_des=tab_1.tabpage_1.dw_prof_mov_contabile_gd.getitemstring(ll_row,'des_contabile')
  if isnull(ls_des) then
	  ls_des='@P'
  else
	  ls_des=ls_des + ', @P'
  end if
  tab_1.tabpage_1.dw_prof_mov_contabile_gd.setitem(ll_row,'des_contabile',ls_des)
end if
end event

type st_8 from statictext within w_prof_registrazione_cx
int X=2400
int Y=484
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Num.Prog."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

