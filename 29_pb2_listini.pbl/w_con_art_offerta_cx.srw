forward
global type w_con_art_offerta_cx from w_p_data
end type
type dw_con_art_offerta_gd from u_dw_master_main within tabpage_1
end type
type dw_con_art_offerta_gd from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_con_catcomart_offerta_gd from u_dw_master_main within tabpage_2
end type
type dw_dummy_ff from u_dw_master_main within w_con_art_offerta_cx
end type
type dw_con_art_offerta_ff from u_dw_ext_main within w_con_art_offerta_cx
end type
type cb_duplica from commandbutton within w_con_art_offerta_cx
end type
type tabpage_2 from userobject within tab_1
dw_con_catcomart_offerta_gd dw_con_catcomart_offerta_gd
end type
end forward

global type w_con_art_offerta_cx from w_p_data
int Width=3483
int Height=1808
boolean TitleBar=true
string Title="Condizioni Articolo"
dw_dummy_ff dw_dummy_ff
dw_con_art_offerta_ff dw_con_art_offerta_ff
cb_duplica cb_duplica
end type
global w_con_art_offerta_cx w_con_art_offerta_cx

type variables

end variables

on w_con_art_offerta_cx.create
int iCurrent
call super::create
this.dw_dummy_ff=create dw_dummy_ff
this.dw_con_art_offerta_ff=create dw_con_art_offerta_ff
this.cb_duplica=create cb_duplica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dummy_ff
this.Control[iCurrent+2]=this.dw_con_art_offerta_ff
this.Control[iCurrent+3]=this.cb_duplica
end on

on w_con_art_offerta_cx.destroy
call super::destroy
destroy(this.dw_dummy_ff)
destroy(this.dw_con_art_offerta_ff)
destroy(this.cb_duplica)
end on

event open;call super::open;il_HelpTopic = 379
idw_master = dw_dummy_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_modo = modo_modifica

end event

event ue_post_open;call super::ue_post_open;dw_con_art_offerta_ff.insertrow(0)
dw_con_art_offerta_ff.setfocus()

DataWindowChild ldw_id_cat_com_sc

dw_con_art_offerta_ff.GetChild("id_cat_com_sc", ldw_id_cat_com_sc)
ldw_id_cat_com_sc.SetTransObject(SQLCA)
ldw_id_cat_com_sc.Retrieve()
end event

type p_crescente from w_p_data`p_crescente within w_con_art_offerta_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_con_art_offerta_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_con_art_offerta_cx
int X=37
int Y=32
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_con_art_offerta_cx
int X=329
int Y=32
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_con_art_offerta_cx
int X=622
int Y=32
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_con_art_offerta_cx
int X=2597
int Y=32
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_con_art_offerta_cx
int X=2889
int Y=32
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_con_art_offerta_cx
int X=3182
int Y=32
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_con_art_offerta_cx
int X=32
int Y=608
int Width=3410
int Height=1092
int TabOrder=30
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

event tab_1::clicked;if (index = 1) then 
	tab_1.tabpage_1.dw_con_art_offerta_gd.retrieve()
elseif (index = 2) then 
	tab_1.tabpage_2.dw_con_catcomart_offerta_gd.retrieve()
end if
	
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3374
int Height=972
long BackColor=79741120
string Text="Articoli"
long TabBackColor=79741120
dw_con_art_offerta_gd dw_con_art_offerta_gd
end type

on tabpage_1.create
this.dw_con_art_offerta_gd=create dw_con_art_offerta_gd
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_art_offerta_gd
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_con_art_offerta_gd)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_con_art_offerta_cx
int X=2304
int Y=32
boolean BringToTop=true
end type

type dw_con_art_offerta_gd from u_dw_master_main within tabpage_1
int X=18
int Y=24
int Width=3337
int Height=932
int TabOrder=10
boolean BringToTop=true
string DataObject="d_con_art_offerta_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event sqlpreview;integer li_row
string ls_sqlsyntax, ls_tipo, ls_tipo_applicazione
date ldt_data_validita
long ll_id_cat_com_sc			
long ll_id_sog_commerciale		

ls_sqlsyntax = sqlsyntax

li_row = dw_con_art_offerta_ff.getrow()
if (li_row > 0) and (request=PreviewFunctionRetrieve!) then
	dw_con_art_offerta_ff.accepttext()
	ls_tipo = dw_con_art_offerta_ff.object.tipo[li_row]
	ldt_data_validita = dw_con_art_offerta_ff.object.data_validita[li_row]
	ls_tipo_applicazione = dw_con_art_offerta_ff.object.tipo_applicazione[li_row]
	
	ll_id_cat_com_sc = dw_con_art_offerta_ff.object.id_cat_com_sc[li_row]
	ll_id_sog_commerciale = dw_con_art_offerta_ff.object.id_sog_commerciale[li_row]
	
	
	if (not isnull(ls_tipo)) then
		ls_sqlsyntax = ls_sqlsyntax + " AND con_lis_articolo.applicazione = '" + ls_tipo + "'"
	end if
	
	if (not isnull(ls_tipo_applicazione)) then
		ls_sqlsyntax = ls_sqlsyntax + " AND con_lis_articolo.tipo_applicazione = '" + ls_tipo_applicazione + "'"
	end if	
	
	if (not isnull(ldt_data_validita)) then
		ls_sqlsyntax = ls_sqlsyntax + " AND ( con_lis_articolo.data_inizio IS NULL OR con_lis_articolo.data_inizio <= '" + string(ldt_data_validita, 'yyyy-mm-dd') + "')"
		ls_sqlsyntax = ls_sqlsyntax + " AND ( con_lis_articolo.data_fine IS NULL OR con_lis_articolo.data_fine >= '" + string(ldt_data_validita, 'yyyy-mm-dd') + "')"
	end if
	
	
	if (ll_id_cat_com_sc > 0) then
		ls_sqlsyntax = ls_sqlsyntax + " AND ( (con_lis_articolo.id_cat_com_sc IS NULL AND cat_com_sc.id_cat_com_sc = " + string(ll_id_cat_com_sc) + ") OR con_lis_articolo.id_cat_com_sc = " + string(ll_id_cat_com_sc) + " OR (con_lis_articolo.id_cat_com_sc IS NULL AND con_lis_articolo.id_sog_commerciale IS NULL))"
	end if

	if (ll_id_sog_commerciale > 0) then
		ls_sqlsyntax = ls_sqlsyntax + " AND ( con_lis_articolo.id_sog_commerciale = " + string(ll_id_sog_commerciale) + ")"
	end if
	
	
	
	ls_sqlsyntax = ls_sqlsyntax + ' ORDER BY "con_lis_articolo"."tipo_applicazione" ASC, ' + &
						' "con_lis_articolo"."priorita" DESC, ' + &
						' "articolo_a"."codice" ASC '
						
	setsqlpreview(ls_sqlsyntax)
end if
end event

event doubleclicked;call super::doubleclicked;long ll_id_con_lis_articolo

if (this.DeletedCount() + this.ModifiedCount()) > 0 then
	cb_salva.trigger event clicked()
end if

if (row > 0) then
	ll_id_con_lis_articolo = this.getitemnumber(row, "id_con_lis_articolo")
	if (ll_id_con_lis_articolo > 0) and ( not (this.DeletedCount() + this.ModifiedCount()) > 0) then
		this.SelectRow(row, TRUE)
		openwithparm(w_scag_art_offerta_lt, ll_id_con_lis_articolo)
		this.SelectRow(row, FALSE)		
	end if
end if


end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "articolo_a_codice"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_codice"
	CASE "articolo_b_codice"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_codice"
	
	CASE "sog_commerciale_gen_codice"
		   is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "sog_commerciale_gen_rag_soc_1"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
			is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"
	
END CHOOSE



end event

event ue_use_search;long ll_row
string ls_null 
setnull(ls_null)

ll_row = this.getrow()

CHOOSE CASE as_nomecol
	CASE "articolo_a_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_art_da", is_ricpar.s_id_seg_value[1])
		
      
		if isnull(This.GetItemString(ll_row, "articolo_b_codice")) or This.GetItemString(ll_row, "articolo_b_codice")='' then
			uf_set_colval("a_cod_articolo",is_ricpar.s_main_value)
			uf_set_colval("id_art_a", is_ricpar.s_id_seg_value[1])
		end if 		
		
		
	CASE "articolo_b_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_art_a", is_ricpar.s_id_seg_value[1])
	
	CASE "sog_commerciale_gen_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		
	CASE "sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_codice", is_ricpar.s_ausil_value[1])
	
END CHOOSE
end event

event itemchanged;long ll_null
string ls_verifica, ls_appoggio
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_priorita, ll_riga_corrente, ll_id_riga, ll_id_da_art,ll_id_art
string ls_null
setnull(ls_null)
setnull(ll_null)
ls_sql_cond = ""
CHOOSE CASE dwo.name
	CASE "articolo_a_codice"
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_art_da"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "articolo_a_codice"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)

      
		IF (ll_ok > 0) THEN
			if isnull(This.GetItemString(row, "articolo_b_codice")) or This.GetItemString(row, "articolo_b_codice")='' then
				ll_id_art = this.getitemnumber(row,"id_art_da")
           This.SetItem(row, "articolo_b_codice", Data)
			  This.SetItem(row, "id_art_a", ll_id_art)
			  
         end if 
			RETURN 2
		END IF										
										
		
		
		
      
		
	CASE "articolo_b_codice"
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_art_a"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "articolo_b_codice"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
		
	CASE "percentuali", "spesa"
		integer li_flag

		if (f_verifica_percentuali(data) = 0 ) then
			messagebox("Attenzione!", "Prima di ogni valore pecentuale va specificato il segno!" &
			+"~r~nIl formato deve essere del seguente tipo: +13+5+10 ")
			return 2
		end if
		
	CASE 'sog_commerciale_gen_codice'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'C'"
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "sog_commerciale_gen_rag_soc_1"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_rag_soc_1"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_codice"

		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE
end event

event ue_insert;call super::ue_insert;integer li_row
long    ll_id_valuta
string  ls_applicazione

li_row = getrow()

ls_applicazione = dw_con_art_offerta_ff.object.tipo[1]

this.object.applicazione[li_row] = ls_applicazione


this.object.data_inizio[li_row] = date("01/01/" + string(year(today())))

SELECT 	id_valuta
INTO		:ll_id_valuta
FROM 		par_sistema
;

if (SQLCA.SQLCODE = 0) then
	this.object.id_valuta[li_row] = ll_id_valuta
end if

long ll_id_cat_com_sc, ll_id_sog_commerciale
string ls_codice, ls_rag_soc_1
string ls_tipo_applicazione

ll_id_cat_com_sc = dw_con_art_offerta_ff.object.id_cat_com_sc[1]
ll_id_sog_commerciale = dw_con_art_offerta_ff.object.id_sog_commerciale[1]
ls_tipo_applicazione = dw_con_art_offerta_ff.object.tipo_applicazione[1]

if (not isnull( ls_tipo_applicazione )) then
	this.object.tipo_applicazione[li_row] = ls_tipo_applicazione
end if

if (ll_id_cat_com_sc > 0) then
	this.object.id_cat_com_sc[li_row] = ll_id_cat_com_sc
end if

if (ll_id_sog_commerciale > 0) then
	this.object.id_sog_commerciale[li_row] = ll_id_sog_commerciale
	SELECT codice, rag_soc_1
	INTO	 :ls_codice, :ls_rag_soc_1
	FROM	 sog_commerciale_gen
	WHERE  id_sog_commerciale = :ll_id_sog_commerciale
	;
	this.object.sog_commerciale_gen_codice[li_row] = ls_codice
	this.object.sog_commerciale_gen_rag_soc_1[li_row] = ls_rag_soc_1	
end if
end event

event updateend;

this.retrieve()
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=3374
int Height=972
long BackColor=79741120
string Text="Cat. comm. articoli"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_con_catcomart_offerta_gd dw_con_catcomart_offerta_gd
end type

on tabpage_2.create
this.dw_con_catcomart_offerta_gd=create dw_con_catcomart_offerta_gd
this.Control[]={this.dw_con_catcomart_offerta_gd}
end on

on tabpage_2.destroy
destroy(this.dw_con_catcomart_offerta_gd)
end on

type dw_con_catcomart_offerta_gd from u_dw_master_main within tabpage_2
int X=18
int Y=20
int Width=3337
int Height=932
int TabOrder=12
boolean BringToTop=true
string DataObject="d_con_catcomart_offerta_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event doubleclicked;call super::doubleclicked;long ll_id_con_lis_articolo

if (this.DeletedCount() + this.ModifiedCount()) > 0 then
	cb_salva.trigger event clicked()
end if

if (row > 0) then
	ll_id_con_lis_articolo = this.getitemnumber(row, "id_con_lis_articolo")
	if (ll_id_con_lis_articolo > 0) and ( not (this.DeletedCount() + this.ModifiedCount()) > 0) then
		this.SelectRow(row, TRUE)
		openwithparm(w_scag_art_offerta_lt, ll_id_con_lis_articolo)
		this.SelectRow(row, FALSE)		
	end if
end if


end event

event itemchanged;long ll_null
string ls_verifica, ls_appoggio
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_priorita, ll_riga_corrente, ll_id_riga, ll_id_da_art
string ls_null
setnull(ls_null)
setnull(ll_null)
ls_sql_cond = ""
CHOOSE CASE dwo.name
	CASE "percentuali", "spesa"
		integer li_flag

		li_flag=f_verifica_percentuali(data)
		if li_flag=0 then
			messagebox("Attenzione!", "Prima di ogni valore pecentuale va specificato il segno!" &
			+"~r~nIl formato deve essere del seguente tipo: +13+5+10 ")
			setitem(row, data, ls_null) 		
		end if
	CASE 'sog_commerciale_gen_codice'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'C'"
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "sog_commerciale_gen_rag_soc_1"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_rag_soc_1"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_codice"

		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE
end event

event sqlpreview;integer li_row
string ls_sqlsyntax, ls_tipo, ls_tipo_applicazione
date ldt_data_validita
long ll_id_cat_com_sc			
long ll_id_sog_commerciale		


ls_sqlsyntax = sqlsyntax

li_row = dw_con_art_offerta_ff.getrow()
if (li_row > 0) and (request=PreviewFunctionRetrieve!) then
	dw_con_art_offerta_ff.accepttext()
	ls_tipo = dw_con_art_offerta_ff.object.tipo[li_row]
	ldt_data_validita = dw_con_art_offerta_ff.object.data_validita[li_row]
	ls_tipo_applicazione = dw_con_art_offerta_ff.object.tipo_applicazione[li_row]
	
	ll_id_cat_com_sc = dw_con_art_offerta_ff.object.id_cat_com_sc[li_row]
	ll_id_sog_commerciale = dw_con_art_offerta_ff.object.id_sog_commerciale[li_row]
	
	
	if (not isnull(ls_tipo)) then
		ls_sqlsyntax = ls_sqlsyntax + " AND con_lis_articolo.applicazione = '" + ls_tipo + "'"
	end if
	
	if (not isnull(ls_tipo_applicazione)) then
		ls_sqlsyntax = ls_sqlsyntax + " AND con_lis_articolo.tipo_applicazione = '" + ls_tipo_applicazione + "'"
	end if	
	
	if (not isnull(ldt_data_validita)) then
		ls_sqlsyntax = ls_sqlsyntax + " AND ( con_lis_articolo.data_inizio IS NULL OR con_lis_articolo.data_inizio <= '" + string(ldt_data_validita, 'yyyy-mm-dd') + "')"
		ls_sqlsyntax = ls_sqlsyntax + " AND ( con_lis_articolo.data_fine IS NULL OR con_lis_articolo.data_fine >= '" + string(ldt_data_validita, 'yyyy-mm-dd') + "')"
	end if
	
	if (ll_id_cat_com_sc > 0) then
		ls_sqlsyntax = ls_sqlsyntax + " AND ( (con_lis_articolo.id_cat_com_sc IS NULL AND cat_com_sc.id_cat_com_sc = " + string(ll_id_cat_com_sc) + ") OR con_lis_articolo.id_cat_com_sc = " + string(ll_id_cat_com_sc) + " OR (con_lis_articolo.id_cat_com_sc IS NULL AND con_lis_articolo.id_sog_commerciale IS NULL))"
	end if

	if (ll_id_sog_commerciale > 0) then
		ls_sqlsyntax = ls_sqlsyntax + " AND ( con_lis_articolo.id_sog_commerciale = " + string(ll_id_sog_commerciale) + ")"
	end if
	
	
	ls_sqlsyntax = ls_sqlsyntax + ' ORDER BY "con_lis_articolo"."tipo_applicazione" ASC, ' + &
						' "con_lis_articolo"."priorita" DESC, ' + &
						' "cat_com_articolo"."descrizione" ASC '
	
	setsqlpreview(ls_sqlsyntax)
end if
end event

event ue_insert;call super::ue_insert;integer li_row
long    ll_id_valuta
string  ls_applicazione

li_row = getrow()

ls_applicazione = dw_con_art_offerta_ff.object.tipo[1]

this.object.applicazione[li_row] = ls_applicazione

this.object.data_inizio[li_row] = date("01/01" + string(year(today())))

SELECT 	id_valuta
INTO		:ll_id_valuta
FROM 		par_sistema
;

if (SQLCA.SQLCODE = 0) then
	this.object.id_valuta[li_row] = ll_id_valuta
end if

long ll_id_cat_com_sc, ll_id_sog_commerciale
string ls_codice, ls_rag_soc_1
string ls_tipo_applicazione

ll_id_cat_com_sc = dw_con_art_offerta_ff.object.id_cat_com_sc[1]
ll_id_sog_commerciale = dw_con_art_offerta_ff.object.id_sog_commerciale[1]
ls_tipo_applicazione = dw_con_art_offerta_ff.object.tipo_applicazione[1]

if (not isnull( ls_tipo_applicazione )) then
	this.object.tipo_applicazione[li_row] = ls_tipo_applicazione
end if

if (ll_id_cat_com_sc > 0) then
	this.object.id_cat_com_sc[li_row] = ll_id_cat_com_sc
end if

if (ll_id_sog_commerciale > 0) then
	this.object.id_sog_commerciale[li_row] = ll_id_sog_commerciale
	SELECT codice, rag_soc_1
	INTO	 :ls_codice, :ls_rag_soc_1
	FROM	 sog_commerciale_gen
	WHERE  id_sog_commerciale = :ll_id_sog_commerciale
	;
	this.object.sog_commerciale_gen_codice[li_row] = ls_codice
	this.object.sog_commerciale_gen_rag_soc_1[li_row] = ls_rag_soc_1	
end if
end event

event updateend;

this.retrieve()
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	
	CASE "sog_commerciale_gen_codice"
		   is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "sog_commerciale_gen_rag_soc_1"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
			is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"
	
END CHOOSE



end event

event ue_use_search;string ls_null 
setnull(ls_null)
CHOOSE CASE as_nomecol
	
	CASE "sog_commerciale_gen_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		
	CASE "sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_codice", is_ricpar.s_ausil_value[1])
	
END CHOOSE
end event

type dw_dummy_ff from u_dw_master_main within w_con_art_offerta_cx
int X=2107
int Y=176
int Width=850
int Height=140
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="d_dummy_ff"
end type

event ue_init;call super::ue_init;iudw_children[1] = tab_1.tabpage_1.dw_con_art_offerta_gd
iudw_children[2] = tab_1.tabpage_2.dw_con_catcomart_offerta_gd

end event

type dw_con_art_offerta_ff from u_dw_ext_main within w_con_art_offerta_cx
int X=37
int Y=156
int Width=3406
int Height=424
int TabOrder=10
boolean BringToTop=true
string DataObject="d_con_art_offerta_ff"
end type

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_priorita, ll_riga_corrente, ll_id_riga
ls_sql_cond = ""

CHOOSE CASE dwo.name
	CASE 'sog_commerciale_gen_codice'
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "sog_commerciale_gen_rag_soc_1"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_rag_soc_1"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_codice"

		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "sog_commerciale_gen_codice"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "sog_commerciale_gen_rag_soc_1"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
	CASE "id_cat_com_sc"
		is_search_window = "w_mod_single_data"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categoria Commerciale dei Soggetti Commerciali"			
END CHOOSE
end event

event ue_use_search;string ls_null
setnull(ls_null)
CHOOSE CASE as_nomecol
	CASE "sog_commerciale_gen_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		
	CASE "sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event losefocus;call super::losefocus;tab_1.tabpage_1.dw_con_art_offerta_gd.post event ue_retrieve(0, 0)
tab_1.tabpage_2.dw_con_catcomart_offerta_gd.post event ue_retrieve(0, 0)
end event

type cb_duplica from commandbutton within w_con_art_offerta_cx
int X=914
int Y=32
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="&Duplica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_row

CHOOSE CASE ii_dwcurr
	CASE 2
		li_row = tab_1.tabpage_1.dw_con_art_offerta_gd.getrow()
		if (li_row > 0) then openwithparm(w_duplica_offerta_wz, tab_1.tabpage_1.dw_con_art_offerta_gd)
	CASE 3
		li_row = tab_1.tabpage_2.dw_con_catcomart_offerta_gd.getrow()
		if (li_row > 0) then openwithparm(w_duplica_offerta_wz, tab_1.tabpage_2.dw_con_catcomart_offerta_gd)
END CHOOSE

end event

