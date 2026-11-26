forward
global type w_dati_articolo_pa_cx from w_p_data
end type
type dw_dati_articolo_ff from u_dw_master_main within w_dati_articolo_pa_cx
end type
type dw_dati_articolo_pa_gd from u_dw_master_main within w_dati_articolo_pa_cx
end type
type dw_dati_articolo_costi_ext from u_dw_ext_main within w_dati_articolo_pa_cx
end type
end forward

global type w_dati_articolo_pa_cx from w_p_data
int Width=2862
int Height=1356
boolean TitleBar=true
string Title="Prezzi di Acquisto Articolo"
dw_dati_articolo_ff dw_dati_articolo_ff
dw_dati_articolo_pa_gd dw_dati_articolo_pa_gd
dw_dati_articolo_costi_ext dw_dati_articolo_costi_ext
end type
global w_dati_articolo_pa_cx w_dati_articolo_pa_cx

type variables

end variables

forward prototypes
public subroutine wf_calcola_costi ()
end prototypes

public subroutine wf_calcola_costi ();long 		ll_rows, ll_id_valuta , ll_id_locazione, ll_id_magazzino
long		ll_id_articolo
string	ls_select
integer	li_row
decimal	ld_ult_costo, ld_costo_medio
date		ldt_data_ult_costo
decimal	ld_cmc
date		ldt_data_cmc

ll_id_articolo = idw_master.is_list.l_identifica[1]
if Upperbound(idw_master.is_list.l_identifica) > 1 then
	ll_id_locazione = idw_master.is_list.l_identifica[2]
end if

li_row = dw_dati_articolo_costi_ext.getrow()
ll_id_valuta = dw_dati_articolo_costi_ext.getitemnumber(1, "id_valuta")	

if (ll_id_valuta = 0 or isnull(ll_id_valuta)) then
	messagebox("attenzione", "indicare la valuta di visualizzazione dei costi")
	return
end if

string	ls_c_ult_costo_data, ls_c_cmc_data, ls_data_costo_ultimo, ls_data_cmc

if (ll_id_locazione > 0) then
	SELECT id_magazzino
	INTO	 :ll_id_magazzino
	FROM	 locazione
	WHERE  id_locazione = :ll_id_locazione
	;
	
	SELECT CAST(FN_ULTIMO_COSTO_DATA(1, :ll_id_articolo, :ll_id_magazzino, YEAR(TODAY(*)), MONTH(TODAY(*)) , :ll_id_valuta)  AS CHAR(32) ) AS c_ult_costo_data,
			 CAST(FN_CMC_DATA(1, :ll_id_articolo, :ll_id_magazzino, :ll_id_valuta)  AS CHAR(32) ) AS c_cmc_data,
			 CAST(FN_COSTO_MEDIO(1, :ll_id_articolo, :ll_id_magazzino, YEAR(TODAY(*)), MONTH(TODAY(*)), :ll_id_valuta)  AS DECIMAL(20,6) ) AS costo_medio,
			 CAST(SUBSTR(c_cmc_data, 1, 22) as numeric(20,6)) as cmc,
			 CAST(SUBSTR(c_ult_costo_data, 1, 22) as numeric(20,6)) as costo_ultimo,
			 CAST(SUBSTR(c_ult_costo_data, 23, 10) as CHAR(10)) as data_costo_ultimo,
			 CAST(SUBSTR(c_cmc_data, 23, 10) as CHAR(10)) as data_cmc
	INTO   :ls_c_ult_costo_data, :ls_c_cmc_data, :ld_costo_medio,
			 :ld_cmc, :ld_ult_costo, :ls_data_costo_ultimo, :ls_data_cmc
	FROM 	 SYS.DUMMY
	;
		
	if (sqlca.sqlcode = -1) then
		messagebox("DBError", sqlca.sqlerrtext)
	end if	
else
	SELECT CAST(FN_ULTIMO_COSTO_DATA(1, :ll_id_articolo, 0, YEAR(TODAY(*)), MONTH(TODAY(*)) , :ll_id_valuta)  AS CHAR(32) ) AS c_ult_costo_data,
			 CAST(FN_CMC_DATA(1, :ll_id_articolo, 0, :ll_id_valuta)  AS CHAR(32) ) AS c_cmc_data,
			 CAST(FN_COSTO_MEDIO(1, :ll_id_articolo, 0, YEAR(TODAY(*)), MONTH(TODAY(*)), :ll_id_valuta)  AS DECIMAL(20,6) ) AS costo_medio,
			 CAST(SUBSTR(c_cmc_data, 1, 22) as numeric(20,6)) as cmc,
			 CAST(SUBSTR(c_ult_costo_data, 1, 22) as numeric(20,6)) as costo_ultimo,
			 CAST(SUBSTR(c_ult_costo_data, 23, 10) as CHAR(10)) as data_costo_ultimo,
			 CAST(SUBSTR(c_cmc_data, 23, 10) as CHAR(10)) as data_cmc
	INTO   :ls_c_ult_costo_data, :ls_c_cmc_data, :ld_costo_medio,
			 :ld_cmc, :ld_ult_costo, :ls_data_costo_ultimo, :ls_data_cmc
	FROM 	 SYS.DUMMY
	;
		
	if (sqlca.sqlcode = -1) then
		messagebox("DBError", sqlca.sqlerrtext)
	end if
end if

decimal ld_null
setnull(ld_null)
	
string ls_null
setnull(ls_null)

if (ld_ult_costo > 0) then
	dw_dati_articolo_costi_ext.setitem(li_row, "ult_costo", ld_ult_costo)
else
	dw_dati_articolo_costi_ext.setitem(li_row, "ult_costo", ld_null)
end if
	
if (not isnull(ls_data_costo_ultimo)) then
	dw_dati_articolo_costi_ext.setitem(li_row, "data_ult_costo", date(ls_data_costo_ultimo))
else
	dw_dati_articolo_costi_ext.setitem(li_row, "data_ult_costo", ls_null)
end if	

if (ld_costo_medio > 0) then
	dw_dati_articolo_costi_ext.setitem(li_row, "costo_medio", ld_costo_medio)
else
	dw_dati_articolo_costi_ext.setitem(li_row, "costo_medio", ld_null)
end if

if (ll_id_locazione > 0) then
	dw_dati_articolo_costi_ext.object.cmc.visible = 1
	dw_dati_articolo_costi_ext.object.data_cmc.visible = 1		
	dw_dati_articolo_costi_ext.object.gb_cmc.visible = 1				
	
	if (ld_cmc > 0) then
		dw_dati_articolo_costi_ext.setitem(li_row, "cmc", ld_cmc)
	else
		dw_dati_articolo_costi_ext.setitem(li_row, "cmc", ld_null)
	end if
	
	if (not isnull(ldt_data_cmc)) then
		dw_dati_articolo_costi_ext.setitem(li_row, "data_cmc", date(ls_data_cmc))
	else
		dw_dati_articolo_costi_ext.setitem(li_row, "data_cmc", ls_null)
	end if	
end if



end subroutine

on w_dati_articolo_pa_cx.create
int iCurrent
call super::create
this.dw_dati_articolo_ff=create dw_dati_articolo_ff
this.dw_dati_articolo_pa_gd=create dw_dati_articolo_pa_gd
this.dw_dati_articolo_costi_ext=create dw_dati_articolo_costi_ext
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dati_articolo_ff
this.Control[iCurrent+2]=this.dw_dati_articolo_pa_gd
this.Control[iCurrent+3]=this.dw_dati_articolo_costi_ext
end on

on w_dati_articolo_pa_cx.destroy
call super::destroy
destroy(this.dw_dati_articolo_ff)
destroy(this.dw_dati_articolo_pa_gd)
destroy(this.dw_dati_articolo_costi_ext)
end on

event open;call super::open;

idw_master = dw_dati_articolo_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_articolo"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_articolo"


end event

event ue_post_open;call super::ue_post_open;long	ll_id_valuta
datawindowchild ldw_valuta

dw_dati_articolo_costi_ext.insertrow(0)

dw_dati_articolo_costi_ext.GetChild("id_valuta", ldw_valuta)
ldw_valuta.SetTransObject(sqlca)
ldw_valuta.Retrieve()

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

dw_dati_articolo_costi_ext.setitem(1, "Id_valuta", ll_id_valuta)	


wf_calcola_costi()


end event

type p_crescente from w_p_data`p_crescente within w_dati_articolo_pa_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_dati_articolo_pa_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_dati_articolo_pa_cx
int X=110
int Y=32
boolean BringToTop=true
string Text="&Esci"
end type

type cb_annulla from w_p_data`cb_annulla within w_dati_articolo_pa_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_dati_articolo_pa_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_dati_articolo_pa_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_dati_articolo_pa_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_dati_articolo_pa_cx
boolean Visible=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_dati_articolo_pa_cx
int Y=1404
int Height=76
int TabOrder=30
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
end type

type cb_ricerca from w_p_data`cb_ricerca within w_dati_articolo_pa_cx
boolean Visible=false
boolean BringToTop=true
end type

type dw_dati_articolo_ff from u_dw_master_main within w_dati_articolo_pa_cx
int X=37
int Y=160
int Width=2784
int Height=296
int TabOrder=10
boolean BringToTop=true
string DataObject="d_dati_articolo_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
iudw_children[1] = dw_dati_articolo_pa_gd


end event

type dw_dati_articolo_pa_gd from u_dw_master_main within w_dati_articolo_pa_cx
int X=37
int Y=480
int Width=1687
int Height=772
int TabOrder=20
boolean BringToTop=true
string DataObject="d_dati_articolo_pa_gd"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
end event

event sqlpreview;string  ls_sqlsyntax
date    ldt_data
integer li_row

ls_sqlsyntax = sqlsyntax
ldt_data = date(idw_master.is_list.s_provenienza)

if isnull(ldt_data) then ldt_data = today()

ls_sqlsyntax = ls_sqlsyntax + " AND variazione.data_inizio <= '" + string(ldt_data, 'yyyy-mm-dd') + "'"
ls_sqlsyntax = ls_sqlsyntax + " AND ( variazione.data_fine >= '" + string(ldt_data, 'yyyy-mm-dd') + "' OR variazione.data_fine IS NULL) "
ls_sqlsyntax = ls_sqlsyntax + " ORDER BY listino.codice"

setsqlpreview(ls_sqlsyntax)
end event

type dw_dati_articolo_costi_ext from u_dw_ext_main within w_dati_articolo_pa_cx
int X=1755
int Y=480
int Width=1065
int Height=772
int TabOrder=11
boolean BringToTop=true
string DataObject="d_dati_articolo_costi_ext"
end type

event itemchanged;CHOOSE CASE dwo.name
	CASE "id_valuta"
		Post wf_calcola_costi()
END CHOOSE
end event

