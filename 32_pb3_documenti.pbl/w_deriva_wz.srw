forward
global type w_deriva_wz from w_wiz_main
end type
type cb_2 from commandbutton within w_deriva_wz
end type
type cb_annulla from commandbutton within w_deriva_wz
end type
type cb_ok from commandbutton within w_deriva_wz
end type
type dw_1 from u_dw_ext_main within w_deriva_wz
end type
type st_1 from statictext within w_deriva_wz
end type
type st_acconti from statictext within w_deriva_wz
end type
type st_2 from statictext within w_deriva_wz
end type
type tv_1 from treeview within w_deriva_wz
end type
end forward

type s_doc from structure
	integer		i_tipo
	long		l_id
	string		s_tipo
	string		s_valore
	string		s_stato
	long		l_id_caus
	decimal {0}	d_imp_acconto
	string		s_test
	boolean		b_gia_scalato
end type

type s_tipidoc from structure
	string		s_tipireg
	long		l_handle
	string		s_label
	integer		i_pict
	integer		i_selpict
end type

global type w_deriva_wz from w_wiz_main
int X=833
int Y=359
int Width=3062
int Height=1492
WindowType WindowType=response!
boolean TitleBar=true
string Title="Derivazione Documenti..."
cb_2 cb_2
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
st_1 st_1
st_acconti st_acconti
st_2 st_2
tv_1 tv_1
end type
global w_deriva_wz w_deriva_wz

type variables
s_par_der_doc	is_pardoc
public s_tipidoc		is_tipidoc[]
integer		ii_scuns, ii_scsel, ii_scxxx
integer		ii_tpuns, ii_tpsel, ii_tpxxx
integer		ii_dcuns, ii_dcsel, ii_dcxxx
integer		ii_lnuns, ii_lnsel, ii_lnxxx, ii_lnnot
integer		ii_dcpar
public s_doc                              is_doc

long		il_id_prof_der

long		il_cur_handle
string		is_cur_tipo_doc
long		il_cur_id_sog, il_cur_id_doc
long		il_cur_id_riga
boolean		ib_down
decimal                    id_acconto
string                        is_test
end variables

forward prototypes
public subroutine wf_init ()
public function long wf_ins_doc (treeview atv_1, string as_label, long al_handle, s_doc as_doc)
public function integer wf_clear_tree (treeview atv_1)
public function long wf_select_sogg (long al_id, string as_ragsoc, treeview atv_1)
public function long wf_select_tipo (long al_sogg, string as_ragsoc, string as_tiporeg, treeview atv_1)
public subroutine wf_load_docs (treeview atv_1, s_par_der_doc astr_par)
public function string wf_set_where_clause (s_par_der_doc astr_par)
public function long wf_ins_riga (treeview atv_1, string as_label, long al_handle, s_doc astr_doc)
public function long wf_load_righe (treeview atv_1, long al_handle, s_doc astr_doc)
public function boolean wf_posso_inserire_riga (s_doc astr_doc, boolean ab_interactive)
public function long wf_check_deriva (ref long al_cambi[])
public function long wf_check_leave ()
public function long wf_set_ret_par (ref s_par_der_doc astr_par)
end prototypes

public subroutine wf_init ();


datawindowchild		ldwc_1
integer					li_ret

ii_scuns = 1		
ii_scsel = 1
ii_scxxx = 10
ii_tpuns = 2		
ii_tpsel = 2
ii_tpxxx = 11
ii_dcuns = 3		
ii_dcsel = 4
ii_dcxxx = 12
ii_dcpar	= 8
ii_lnuns = 5		
ii_lnsel = 6
ii_lnxxx = 13
ii_lnnot = 7

is_tipidoc[1].s_tipireg = "---"
is_tipidoc[1].s_label = "<Non specificato>"
is_tipidoc[1].l_handle = 0
is_tipidoc[1].i_pict = ii_tpuns
is_tipidoc[1].i_selpict = ii_tpsel

is_tipidoc[2].s_tipireg = "PA PV"
is_tipidoc[2].s_label = "Preventivi"
is_tipidoc[2].l_handle = 0
is_tipidoc[2].i_pict = ii_tpuns
is_tipidoc[2].i_selpict = ii_tpsel

is_tipidoc[3].s_tipireg = "OA OV"
is_tipidoc[3].s_label = "Ordini"
is_tipidoc[3].l_handle = 0
is_tipidoc[3].i_pict = ii_tpuns
is_tipidoc[3].i_selpict = ii_tpsel

is_tipidoc[4].s_tipireg = "LA LV"
is_tipidoc[4].s_label = "Liste di Prelievo"
is_tipidoc[4].l_handle = 0
is_tipidoc[4].i_pict = ii_tpuns
is_tipidoc[4].i_selpict = ii_tpsel

is_tipidoc[5].s_tipireg = "DA DV"
is_tipidoc[5].s_label = "Bolle / DDT"
is_tipidoc[5].l_handle = 0
is_tipidoc[5].i_pict = ii_tpuns
is_tipidoc[5].i_selpict = ii_tpsel

is_tipidoc[6].s_tipireg = "IA IV IC"
is_tipidoc[6].s_label = "Fatture"
is_tipidoc[6].l_handle = 0
is_tipidoc[6].i_pict = ii_tpuns
is_tipidoc[6].i_selpict = ii_tpsel

is_tipidoc[7].s_tipireg = "GA GV"
is_tipidoc[7].s_label = "Documenti generici"
is_tipidoc[7].l_handle = 0
is_tipidoc[7].i_pict = ii_tpuns
is_tipidoc[7].i_selpict = ii_tpsel

SetNull(il_cur_id_doc)
SetNull(il_cur_id_riga)
SetNull(il_cur_id_sog)
is_cur_tipo_doc = ""

dw_1.setTransObject(sqlca)
dw_1.reset()

end subroutine

public function long wf_ins_doc (treeview atv_1, string as_label, long al_handle, s_doc as_doc);

integer           li_NewItem
TreeViewItem      ltvi_Item

as_doc.s_stato = "S"
ltvi_Item.label = as_label
ltvi_Item.PictureIndex = ii_dcuns
ltvi_Item.SelectedPictureIndex = ii_dcsel
ltvi_Item.Data = as_doc
li_NewItem = atv_1.InsertItemLast(al_handle, ltvi_Item)
Return(li_NewItem)

end function

public function integer wf_clear_tree (treeview atv_1);


long			ll_handle

ll_handle = atv_1.FindItem(RootTreeItem!,0)
do while ll_handle <> -1
	atv_1.deleteitem(ll_handle)
	ll_handle = atv_1.FindItem(RootTreeItem!,0)
loop



return 0
end function

public function long wf_select_sogg (long al_id, string as_ragsoc, treeview atv_1);

long				ll_handle, ll_id1, ll_hd1
boolean			lb_finito, lb_trovato
treeViewItem	ltvi_1
s_doc				ls_doc



ll_handle = atv_1.FindItem(RootTreeItem!,0)

if (ll_handle<0) then
	
	
	ltvi_1.PictureIndex = ii_scuns
	ltvi_1.SelectedPictureIndex = ii_scsel
	ltvi_1.label = as_Ragsoc
	ls_doc.i_tipo = 0
	ls_doc.s_valore = as_Ragsoc
	ls_doc.l_id = al_id
	ls_doc.s_stato = "S"
	ltvi_1.data = ls_doc
	ll_handle = atv_1.InsertItemSort (0, ltvi_1)		
	atv_1.expandItem(ll_handle)
else
	
	lb_finito = false
	lb_trovato = false
	ll_hd1 = 0
	do while not lb_finito
		atv_1.GetItem (ll_handle, ltvi_1)
		ls_doc = ltvi_1.data
		ll_id1 = ls_doc.l_id
		if ll_id1 = al_ID then
			lb_finito = true
			lb_trovato = true
			
		else
			ll_handle = atv_1.FindItem(NextTreeItem!,ll_handle)
			if ll_handle <0 then
				lb_finito = true
				lb_trovato = false
			end if
		end if
	loop
	
	if lb_trovato then
		
		atv_1.expandItem(ll_handle)
	else
		
		ltvi_1.PictureIndex = ii_scuns
		ltvi_1.SelectedPictureIndex = ii_scsel
		ltvi_1.label = as_Ragsoc
		ls_doc.i_tipo = 0
		ls_doc.s_valore = as_Ragsoc
		ls_doc.l_id = al_id
		ls_doc.s_stato = "S"
		ltvi_1.data = ls_doc
		ll_handle = atv_1.InsertItemSort (0, ltvi_1)		
		atv_1.expandItem(ll_handle)
	end if
end if

return ll_handle

end function

public function long wf_select_tipo (long al_sogg, string as_ragsoc, string as_tiporeg, treeview atv_1);

long				ll_handle, ll_sogg, ll_han2
string			ls_ctipo
integer			li_count, li_size, li_pos
boolean			lb_finito, lb_trovato, lb_havetipo
TreeViewItem	ltvi_1
s_doc				ls_doc



li_size = UpperBound (is_tipidoc)
li_pos = 0
for li_count = 2 to li_size
	if pos(is_tipidoc[li_count].s_tipireg,as_tiporeg) > 0 then
		li_pos = li_count
	end if
next
if li_pos>0 then
	
	ls_ctipo = string(li_pos - 1)
else
	
	ls_ctipo = "0"
	li_pos = 1
end if

ll_sogg = wf_select_sogg (al_sogg, as_ragsoc, atv_1)
lb_havetipo = false
ll_handle = atv_1.FindItem (ChildTreeItem!, ll_sogg)
ll_han2 = -1
if ll_handle<> -1 then
	ll_han2 = ll_handle
	
	
	
	lb_finito = false
	lb_trovato = false
	do while not lb_finito
		atv_1.GetItem(ll_handle,ltvi_1)
		ls_doc = ltvi_1.data
		if ls_doc.s_tipo = ls_ctipo then
			
			lb_trovato = true
			lb_finito = true
		else
			if ls_doc.s_tipo < ls_ctipo then
				
				ll_han2 = ll_handle
				lb_havetipo = true
				ll_handle = atv_1.FindItem (NextTreeItem!, ll_handle)
				if ll_handle = -1 then
					lb_finito = true
					lb_trovato = false
					ll_handle = ll_han2
				end if
			else
				
				
				
				lb_finito = true
				lb_trovato = false
				ll_handle = ll_han2
			end if
		end if
	loop
	
	if lb_trovato then
		
	else
		
		ltvi_1.PictureIndex = is_tipidoc[li_pos].i_pict
		ltvi_1.SelectedPictureIndex = is_tipidoc[li_pos].i_selpict
		ltvi_1.label = is_tipidoc[li_pos].s_label
		ls_doc.i_tipo = 1
		ls_doc.s_tipo = ls_ctipo
		ls_doc.s_valore = as_tiporeg
		ls_doc.s_stato = "S"
		ltvi_1.data = ls_doc
		if lb_havetipo then
			ll_handle = atv_1.InsertItem(ll_sogg, ll_handle, ltvi_1)
		else
			ll_handle = atv_1.InsertItemFirst(ll_sogg, ltvi_1)
		end if
		atv_1.expandItem(ll_handle)
	end if
else
	
	ltvi_1.PictureIndex = is_tipidoc[li_pos].i_pict
	ltvi_1.SelectedPictureIndex = is_tipidoc[li_pos].i_selpict
	ltvi_1.label = is_tipidoc[li_pos].s_label
	ls_doc.i_tipo = 1
	ls_doc.s_tipo = ls_ctipo
	ls_doc.s_valore = as_tiporeg
	ls_doc.s_stato = "S"
	ltvi_1.data = ls_doc
	ll_handle = atv_1.InsertItemFirst(ll_sogg, ltvi_1)
	atv_1.expandItem(ll_handle)
end if

return ll_handle

end function

public subroutine wf_load_docs (treeview atv_1, s_par_der_doc astr_par);
long 			ll_evaso
string		ls_select, ls_from, ls_where, ls_wh2
string		ls_sql, ls_d1, ls_d2

integer		li_k
integer 		C			

string		ls_tiporeg, ls_ragsoc, ls_data_doc
string		ls_appoggio
decimal		ll_numreg, ll_num_progr
decimal	   ll_appoggio
decimal 		ll_imp_acconto
date			ldt_reg, ldt_1, ldt_2, ld_data_doc
long			ll_iddoc, ll_idsogg

long			ll_id_profilo, ll_row, ll_id_sogg
integer		li_sqlerr

long			ll_tdhandle, ll_newdoc
string		ls_label, ls_num_doc
s_doc			ls_doc



atv_1.SetRedraw ( false )

wf_clear_tree(atv_1)

ls_select = "SELECT DISTINCT registro.tipo_registro, registro.numero, documento.num_progressivo, "
ls_select = ls_select + "documento.data_registrazione, documento.id_documento, "
ls_select = ls_select + "documento.num_documento, documento.data_documento, "
ls_select = ls_select + "documento.id_sog_commerciale, sog_commerciale_gen.rag_soc_1, "
ls_select = ls_select + "documento.imp_acconto, documento.id_tipo_pag_acconto, documento.id_tab_iva_acconto, documento.id_val_acconto, "
ls_select = ls_select + "documento.id_banca_sog_commerciale, documento.id_destinazione, documento.id_con_pagamento, documento.id_valuta, "
ls_select = ls_select + "documento.sconto_finanziario, documento.sconto_fin_cassa, documento.id_gruppo_agenti "
ls_from = " FROM dba.documento, dba.der_profilo, dba.registro, dba.sog_commerciale_gen"
ls_where = " WHERE ( documento.id_prof_documento = der_profilo.id_prof_documento_padre ) AND"
ls_where = ls_where + " ( documento.id_Azienda = 1 ) AND"
ls_where = ls_where + " ( documento.sospeso <> 'S') AND ( documento.bloccato <> 'S') AND"
ls_where = ls_where + " ( documento.evaso_totalmente <> 'S') AND"
ls_where = ls_where + " ( registro.id_registro = documento.id_registro ) AND"
ls_where = ls_where + " ( documento.id_sog_commerciale = sog_commerciale_gen.id_sog_commerciale )"

ls_wh2 = wf_set_where_clause(astr_par)
ls_sql = ls_select + ls_from + ls_where
if ls_wh2 > " " then ls_sql = ls_sql + " AND (" + ls_wh2 + ")"

ll_imp_acconto = 0

prepare sqlsa from :ls_sql ;
li_sqlerr = sqlca.sqlcode
if li_sqlerr = 0 then
	describe sqlsa into sqlda;
end if
li_sqlerr = sqlca.sqlcode
if li_sqlerr = 0 then
	declare lcur_doc dynamic cursor for sqlsa;
end if
li_sqlerr = sqlca.sqlcode
if li_sqlerr = 0 then
	open dynamic lcur_doc using descriptor sqlda ;
	do while li_sqlerr = 0
		fetch lcur_doc using descriptor sqlda ;
		
		li_sqlerr = sqlca.sqlcode
		if li_sqlerr = 0 then
			
			ll_appoggio = 0
			ls_tiporeg = GetDynamicString(sqlda, 1)
			ll_numreg = GetDynamicNumber(sqlda, 2)
			ll_num_progr = GetDynamicNumber(sqlda, 3)
			ldt_reg = GetDynamicDate(sqlda,4)
			ll_iddoc = GetDynamicNumber(sqlda, 5)
			ls_num_doc = GetDynamicString(sqlda, 6)
			If IsNull(ls_num_doc) OR ls_num_doc="" then ls_num_doc="__"
			ld_data_doc = GetDynamicDate(sqlda, 7)
			If IsNull(ld_data_doc) then 
				ls_data_doc="__/__/____"
			else
				ls_data_doc=String(ld_data_doc)
			end if
			ll_idsogg = GetDynamicNumber(sqlda, 8)
			ls_ragsoc = GetDynamicString(sqlda, 9)
			
			ll_appoggio = GetDynamicNumber(sqlda, 10)
			if isnull(ll_appoggio) then ll_appoggio = 0 
			ll_imp_acconto = ll_imp_acconto + ll_appoggio
	

			ll_tdhandle = wf_select_tipo (ll_idsogg, ls_ragsoc, ls_tiporeg, atv_1)
			atv_1.ExpandItem(ll_tdhandle)
			ls_label = ls_tiporeg+"/"+string(ll_numreg,"#0")+" - "+string(ll_num_progr,"#0")+" del "+string(ldt_reg)+" (Nr. "+ls_num_doc+" del "+ls_data_doc+") An."+String(truncate(ll_appoggio,0))
			ls_doc.i_tipo = 2		
			ls_doc.l_id = ll_iddoc
			ls_doc.l_id_caus = 0
			ls_doc.s_tipo = ls_tiporeg
			ls_doc.d_imp_acconto = ll_appoggio
			
			ls_doc.s_test = ""
			
			for c = 11 to 20 
				ls_appoggio = String(GetDynamicNumber(sqlda, C))
				if isnull(ls_appoggio) or (ls_appoggio = "0") then ls_appoggio = GetDynamicString(sqlda, C)
				if isnull(ls_appoggio) or (ls_appoggio = "0") then ls_appoggio = "00"
				ls_doc.s_test = ls_doc.s_test +"("+ls_appoggio+")"
			next
			ls_doc.b_gia_scalato = false
			st_2.text = ls_doc.s_test
			
			select sum(isnull(quantita,0,quantita) + isnull(qta_sconto_merce,0,qta_sconto_merce) - isnull(qta_evasa,0,qta_evasa))
			into:ll_evaso
			from riga_documento
			where id_documento=:ll_iddoc;
			if ll_evaso<>0 then
				ll_NewDoc = wf_ins_Doc(atv_1, ls_label, ll_tdhandle, ls_doc)
			end if
			
		end if
	loop
end if

close lcur_doc;


IS_TEST = "PRIMO"


atv_1.SetRedraw ( true )

end subroutine

public function string wf_set_where_clause (s_par_der_doc astr_par);
integer		li_size, li_count
boolean		lb_doit
string		ls_ret, ls_temp

ls_ret = ""

li_size = upperbound(astr_par.s_dbn)
for li_count = 1 to li_size
	lb_doit = true
	if isNull(astr_par.s_dbn[li_count]) then lb_doit = false
	if astr_par.s_dbn[li_count] <= " " then lb_doit = false
	if isNull(astr_par.s_op[li_count]) then lb_doit = false
	if astr_par.s_op[li_count] <= " " then lb_doit = false
	if isNull(astr_par.s_dbv[li_count]) then lb_doit = false
	if astr_par.s_dbv[li_count] <= " " then lb_doit = false
	if lb_doit then
		ls_temp = " (" + astr_par.s_dbn[li_count] + " " + astr_par.s_op[li_count] + " "
		choose case astr_par.s_dbt[li_count]
			case "N"
				ls_temp = ls_temp + astr_par.s_dbv[li_count] + ") "
			case "S"
				ls_temp = ls_temp + "'" + astr_par.s_dbv[li_count] + "') "
			case "D"
				
				ls_temp = ls_temp +  astr_par.s_dbv[li_count] + ") "
			case else
				ls_temp = ls_temp + astr_par.s_dbn[li_count] + ") "
		end choose
		ls_ret = ls_ret + " AND " + ls_temp
	end if
next
ls_ret = mid(ls_ret,5)

return ls_ret

end function

public function long wf_ins_riga (treeview atv_1, string as_label, long al_handle, s_doc astr_doc);

integer           li_NewItem
TreeViewItem      ltvi_Item
long					ll_hnd_parent
string				ls_valore, ls_stato
string				ls_db, ls_ds, ls_dc, ls_rs, ls_rc, ls_te, ls_nd, ls_de

s_doc				ls_doc				

ls_valore = astr_doc.s_valore

ls_db = mid (ls_valore,1,1)	
ls_ds = mid (ls_valore,2,1)	
ls_dc = mid (ls_valore,3,1)	
ls_rs = mid (ls_valore,4,1)	
ls_rc = mid (ls_valore,5,1)	
ls_te = mid (ls_valore,6,1)	
ls_nd = mid (ls_valore,7,1)	
ls_de = mid (ls_valore,8,1)	

ls_stato = "S"
if ls_de = "N" then
	ls_stato = "S"
else
	if ls_te = "S" then
		ls_stato = "T"
	else
		if (ls_db="S") or (ls_ds="S") or (ls_rs="S") then
			ls_stato = "X"
		else
			if (ls_dc="S") or (ls_rc="S") then
				ls_stato = "F"
			else
				if (ls_nd="S") then
					ls_stato = "C"
				end if
			end if
		end if
	end if
end if

ltvi_Item.label = ls_stato+":"+as_label
if ls_stato = "S" then
	ltvi_Item.PictureIndex = ii_lnuns
	ltvi_Item.SelectedPictureIndex = ii_lnsel
else
	ltvi_Item.PictureIndex = ii_lnnot
	ltvi_Item.SelectedPictureIndex = ii_lnnot
end if
astr_doc.s_stato = ls_stato
ltvi_Item.Data = astr_doc
li_NewItem = atv_1.InsertItemLast(al_handle, ltvi_Item)
if ls_stato = 'T' then
	ll_hnd_parent = al_handle
	atv_1.getitem(ll_hnd_parent, ltvi_Item)
	ls_doc = ltvi_item.data	
	ls_doc.d_imp_acconto = 0
	ltvi_item.data = ls_doc
	ltvi_Item.SelectedPictureIndex = ii_dcpar
	atv_1.setitem(ll_hnd_parent, ltvi_Item)
end if

Return(li_NewItem)

end function

public function long wf_load_righe (treeview atv_1, long al_handle, s_doc astr_doc);
long		ll_id_doc, ll_newDoc
long		ll_id_riga, ll_num, ll_count, ll_id_caus_der
string	ls_codice, ls_descr, ls_label
string	ls_dblo, ls_dsos, ls_dchi, ls_rsos, ls_rchi
string	ls_esse
decimal	ld_quant, ld_qtasm, ld_qtaeva
s_doc		lstr_doc


ll_id_doc = astr_doc.l_id
ls_codice = ""
ls_descr = ""
ls_label = ""
ll_count = 0


declare lcur_riga cursor for
 
	select "riga_documento"."id_riga_documento",  "riga_documento"."num_riga",
          "articolo"."codice",                   "riga_documento"."descrizione",
          "riga_documento"."quantita",           "riga_documento"."qta_sconto_merce",
			 "riga_documento"."qta_evasa",			 "documento"."bloccato",
			 "documento"."sospeso",                 "documento"."chius_forzata",
			 "riga_documento"."sospesa",  			 "riga_documento"."forza_chius_evasione"
	from {oj "dba"."riga_documento"  LEFT OUTER JOIN "dba"."articolo"  on 
			"riga_documento"."id_articolo" = "articolo"."id_articolo"},
			"dba"."documento"
	where ( "documento"."id_documento" = "riga_documento"."id_documento" ) and
	      ( "riga_documento"."id_documento" = :ll_id_doc ) ;

if sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
	return -1
end if

open lcur_riga;
do while sqlca.sqlcode = 0
	ls_esse = "F"
	fetch lcur_riga into :ll_id_riga, :ll_num, :ls_codice, :ls_descr, :ld_quant,
								:ld_qtasm, :ld_qtaeva, :ls_dblo, :ls_dsos, :ls_dchi,
								:ls_rsos, :ls_rchi;
	choose case sqlca.sqlcode
		
		case 0
			if isNull(ls_codice) then ls_codice = " "
			if IsNull(ls_descr) then ls_descr = " "
			if IsNull(ls_dblo) then ls_dblo = "N"
			if IsNull(ls_dsos) then ls_dsos = "N"
			if IsNull(ls_dchi) then ls_dchi = "N"
			if IsNull(ls_rsos) then ls_rsos = "N"
			if IsNull(ls_rchi) then ls_rchi = "N"
			if isNull(ld_quant) then ld_quant = 0
			if isNull(ld_qtasm) then ld_qtasm = 0
			if isNull(ld_qtaeva) then ld_qtaeva = 0
			ls_label = string(ll_num)+"- "+ls_codice+" "+ls_descr+" - "+string(ld_quant+ld_qtasm)
			lstr_doc.i_tipo = 3		
			lstr_doc.l_id = ll_id_riga
			lstr_doc.s_tipo = ""
			
			lstr_doc.s_valore = ls_dblo+ls_dsos+ls_dchi+ls_rsos+ls_rchi
			
			if (ld_quant + ld_qtasm - ld_qtaeva) > 0 then
				lstr_doc.s_valore = lstr_doc.s_valore + "N"
			else
				lstr_doc.s_valore = lstr_doc.s_valore + "S"
			end if
			
			sqlca.sp_caus_der(il_id_prof_der,ll_id_riga, ll_id_caus_der)
			if ll_id_caus_der>=0 then
				lstr_doc.s_valore = lstr_doc.s_valore + "N"
			else
				lstr_doc.s_valore = lstr_doc.s_valore + "S"
			end if
			
			if ( (isNull(ls_codice) or ls_codice <=" ") ) and (ld_quant+ld_qtasm = 0) then
				lstr_doc.s_valore = lstr_doc.s_valore + "N"
			else
				lstr_doc.s_valore = lstr_doc.s_valore + "S"
			end if
			lstr_doc.l_id_caus = ll_id_caus_der
			ll_NewDoc = wf_ins_riga(atv_1, ls_label, al_handle, lstr_doc)
			ll_count ++
		
		case is < 0
			MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
			exit
		case else
			
			exit
	end choose
loop

close lcur_riga;
return ll_count

end function

public function boolean wf_posso_inserire_riga (s_doc astr_doc, boolean ab_interactive);
string		ls_stato, ls_mex
boolean		lb_posso

ls_stato = astr_doc.s_stato

choose case ls_stato
	case "S"
		lb_posso = true
	case "C"
		lb_posso = true
		ls_mex = "Manca la causale di derivazione!"
	case "T"
		lb_posso = false
		ls_mex = "La riga è già totalmente evasa!"
	case "X"
		lb_posso = false
		ls_mex = "La riga è bloccata o sospesa!"
	case "N"
		lb_posso = false
		ls_mex = "Riga già presente di sotto!"
	case else
		lb_posso = false
		ls_mex = "Non posso inserire questa riga"
end choose

if (ls_mex <> "") and (ab_interactive) then
	messageBox("Errore",ls_mex, Exclamation!)
end if

return lb_posso


end function

public function long wf_check_deriva (ref long al_cambi[]);




long		ll_size, ll_row, ll_id_riga, ll_sqlc
integer	li_erc
boolean	lb_uguali

long		ll_idar0, ll_iduc0, ll_idcm0, ll_idlp0, ll_idld0, ll_idva0
decimal	ld_qta0, ld_qtsm0, ld_qtev0

long		ll_idar1, ll_iduc1, ll_idcm1, ll_idlp1, ll_idld1, ll_idva1
decimal	ld_qta1, ld_qtsm1, ld_qtev1, ld_qta2, ld_qtsm2

long		ll_cambi[]
long		ll_idxc

string	ls_testo

ll_size = dw_1.RowCount()		
ll_idxc = 0

for ll_row = 1 to ll_size
	
	
	ll_idar1 = dw_1.GetItemNumber(ll_row,"cc_id_arti")
	ll_iduc1 = dw_1.GetItemNumber(ll_row,"cc_id_un_conf")
	ll_idcm1 = dw_1.GetItemNumber(ll_row,"cc_id_caus_orig")
	ll_idlp1 = dw_1.GetItemNumber(ll_row,"cc_id_loc1")
	ll_idld1 = dw_1.GetItemNumber(ll_row,"cc_id_loc2")
	ll_idva1 = dw_1.GetItemNumber(ll_row,"cc_id_valu")
	ld_qta1  = dw_1.uf_GetItemDecimal(ll_row,"riga_documento_quantita")
	ld_qtsm1 = dw_1.uf_GetItemDecimal(ll_row,"riga_documento_qta_sconto_merce")
	ld_qtev1 = dw_1.uf_GetItemDecimal(ll_row,"riga_documento_qta_evasa")
	ld_qta2  = dw_1.uf_GetItemDecimal(ll_row,"cc_qta_ev")
	ld_qtsm2 = dw_1.uf_GetItemDecimal(ll_row,"cc_qtasm_ev")
	
	
	ll_id_riga = dw_1.GetItemNumber (ll_row,"cc_id_riga")
	
	
	SELECT "riga_documento"."id_articolo",     "riga_documento"."id_unita_confezione",
          "riga_documento"."quantita",        "riga_documento"."qta_sconto_merce",
          "riga_documento"."qta_evasa",       "riga_documento"."id_caus_magazzino",
          "riga_documento"."id_locazione_1",  "riga_documento"."id_locazione_2",   
          "riga_documento"."id_valuta"
   INTO :ll_idar0,  :ll_iduc0,  :ld_qta0,  :ld_qtsm0,  :ld_qtev0,  :ll_idcm0,
        :ll_idlp0,  :ll_idld0,  :ll_idva0
   FROM "dba"."riga_documento"
   WHERE "riga_documento"."id_riga_documento" = :ll_id_riga
	USING SQLCA;
	
	
	if isNull(ll_idar0) then ll_idar0 = 0
	if isNull(ll_idar1) then ll_idar1 = 0
	if isNull(ld_qta0) then ld_qta0=0
	if isNull(ld_qta2) then ld_qta2=0
	if isNull(ld_qtsm0) then ld_qtsm0=0
	if isNull(ld_qtsm2) then ld_qtsm2=0

	
	li_erc = 0
	ll_sqlc = sqlca.sqlcode
	choose case ll_sqlc
		case is<0
			
			li_erc = -1
		case 100
			
			li_erc = 1
		case 0
			
	end choose

	
	
	if li_erc = 0 then
		lb_uguali = true
		if (ll_idar0=0 and ll_idar1=0 and ld_qta0=0 and ld_qtsm0=0 and ld_qta2=0 and ld_qtsm2=0) then 
			lb_uguali = true
		else
			if ll_idar0 <> ll_idar1 or ll_iduc0 <> ll_iduc1 then lb_uguali = false
			if ll_idcm0 <> ll_idcm1 or ll_idva0 <> ll_idva1 then lb_uguali = false
			if ll_idlp0 <> ll_idlp1 or ll_idld0 <> ll_idld1 then lb_uguali = false
			
			if (ld_qta0 + ld_qtsm0 - ld_qtev0 - ld_qta2 - ld_qtsm2) <0 then lb_uguali = false
		end if
	end if

	
	
	
	
	
	if not lb_uguali then
		ll_idxc ++
		ll_cambi[ll_idxc] = ll_row
	end if
		
next


al_cambi = ll_cambi

return li_erc

end function

public function long wf_check_leave ();

long		ll_chg[], ll_riga
integer	li_size, li_count

wf_check_deriva(ll_chg)

li_size = upperBound(ll_chg)
if li_size>0 then
	
	
	for li_count = 1 to li_size
		ll_riga = ll_chg[li_count]
		dw_1.SetItem(ll_riga,"cc_cambiato","S")
	next
	dw_1.SetRow(ll_chg[1])
	dw_1.SetColumn("cc_qta_ev")
	
	
end if

return li_size

end function

public function long wf_set_ret_par (ref s_par_der_doc astr_par);

long		ll_size, ll_count, ll_row
long		ll_idr1, ll_idc2
decimal	ld_qta, ld_qtasm


ll_size = dw_1.RowCount()
astr_par.a_optional[1] = id_acconto
astr_par.a_optional[2] = is_test
for ll_count = 1 to ll_size
	ll_idr1 = dw_1.GetItemNumber(ll_count,"cc_id_riga")
	ll_idc2 = dw_1.GetItemNumber(ll_count,"riga_documento_id_caus_magazzino")
	ld_qta = dw_1.uf_getItemDecimal(ll_count,"cc_qta_ev")
	ld_qtasm = dw_1.uf_getItemDecimal(ll_count,"cc_qtasm_ev")
	astr_par.s_dbn[ll_count] = string(ll_idr1)
	astr_par.s_op[ll_count] = string(ld_qta)
	astr_par.s_dbv[ll_count] = string(ld_qtasm)
	astr_par.s_dbt[ll_count] = string(ll_idc2)
	astr_par.s_mio[ll_count] = dw_1.getitemstring(ll_count,"riga_documento_forza_chius_evasione")
next

return ll_size




end function

on w_deriva_wz.create
int iCurrent
call w_wiz_main::create
this.cb_2=create cb_2
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.st_1=create st_1
this.st_acconti=create st_acconti
this.st_2=create st_2
this.tv_1=create tv_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_2
this.Control[iCurrent+2]=cb_annulla
this.Control[iCurrent+3]=cb_ok
this.Control[iCurrent+4]=dw_1
this.Control[iCurrent+5]=st_1
this.Control[iCurrent+6]=st_acconti
this.Control[iCurrent+7]=st_2
this.Control[iCurrent+8]=tv_1
end on

on w_deriva_wz.destroy
call w_wiz_main::destroy
destroy(this.cb_2)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_acconti)
destroy(this.st_2)
destroy(this.tv_1)
end on

event open;call super::open;

integer	li_size, li_count

wf_init()

is_pardoc = Message.PowerObjectParm

li_size = upperbound (is_pardoc.s_dbn)
il_id_prof_der = 0
for li_count = 1 to li_size
	if (is_pardoc.s_dbn[li_count] = "der_profilo.id_prof_documento_derivato") then
		il_id_prof_der = long(is_pardoc.s_dbv[li_count])
	end if
next

wf_load_docs(tv_1, is_pardoc)

end event

type cb_2 from commandbutton within w_deriva_wz
int X=1906
int Y=109
int Width=744
int Height=93
int TabOrder=20
boolean Visible=false
boolean Enabled=false
string Text="Deriva... (copiare in Doc.)"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
end event

type cb_annulla from commandbutton within w_deriva_wz
int X=2646
int Y=20
int Width=338
int Height=87
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetNull(message.PowerObjectParm)
close (parent)
end event

type cb_ok from commandbutton within w_deriva_wz
int X=2283
int Y=20
int Width=338
int Height=87
int TabOrder=40
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long				ll_errori
s_par_der_doc	lstr_der

ll_errori = 0
if dw_1.acceptText() > 0 then
	ll_errori = wf_check_leave()				
	if ll_errori = 0 then
		wf_set_ret_par(lstr_der)				
		Message.PowerObjectParm = lstr_der
		SetPointer(HourGlass!)
		closewithreturn (parent, lstr_der)
	else
		dw_1.setFocus()
	end if
end if

end event

type dw_1 from u_dw_ext_main within w_deriva_wz
event type long ue_insert_riga ( long al_id_riga,  long al_handle,  treeview atv_1,  long al_row )
event type long ue_insert_doc ( long al_id_riga,  long al_handle,  treeview atv_1,  boolean ab_riga,  long al_id_unico )
event type long ue_insert_tipo ( long al_id_riga,  long al_handle,  treeview atv_1 )
event type long ue_insert_sogg ( long al_id_riga,  long al_handle,  treeview atv_1 )
event type long ue_reset_riga ( treeview atv_1,  long al_handle )
event ue_mdown pbm_lbuttondown
event ue_mup pbm_lbuttonup
event ue_mmove pbm_mousemove
int X=18
int Y=580
int Width=2966
int Height=801
int TabOrder=50
string DragIcon="Rectangle!"
string DataObject="d_deriva_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_insert_riga;call super::ue_insert_riga;
long				ll_id_riga, ll_row, ll_dbcode, ll_ritorna

string				ls_tr, ls_ca, ls_da
long				ll_idd, ll_iduc, ll_idcm, ll_idl1, ll_idl2, ll_idv, ll_ida, ll_id_r_lotto
decimal			ld_nr, ld_np, ld_q1, ld_q2, ld_qe, ld_rg, ld_netto
decimal			ld_qde
date				ldt_dr
char				lc_forza_chius_evasione
long				ll_id_riga_documento

treeviewItem	ltvi_1
s_doc				ls_doc

ll_ritorna = 0
ll_id_riga = al_id_riga

  SELECT "registro"."tipo_registro",          	"registro"."numero",
         "documento"."num_progressivo",      	"documento"."data_registrazione",
         "articolo"."codice",                 	"riga_documento"."descrizione",
         "riga_documento"."quantita",         	"riga_documento"."qta_sconto_merce",
         "riga_documento"."qta_evasa",       	"riga_documento"."num_riga",
			"riga_documento"."id_caus_magazzino",	"riga_documento"."id_unita_confezione",
			"riga_documento"."id_locazione_1",		"riga_documento"."id_locazione_2",
			"riga_documento"."id_valuta",				"riga_documento"."id_articolo",
			"documento"."id_documento",				"riga_documento"."forza_chius_evasione",
			"riga_documento"."id_riga_documento", "riga_documento"."peso_netto",
			"riga_documento"."id_riga_lotto"
    INTO :ls_tr,   :ld_nr,   :ld_np,   :ldt_dr,   
         :ls_ca,   :ls_da,   :ld_q1,   :ld_q2,   
         :ld_qe,   :ld_rg,   :ll_idcm, :ll_iduc,
			:ll_idl1, :ll_idl2, :ll_idv,  :ll_ida,  :ll_idd, :lc_forza_chius_evasione,
			:ll_id_riga_documento, :ld_netto, :ll_id_r_lotto

	from {oj "dba"."riga_documento"  LEFT OUTER JOIN "dba"."articolo"  on 
			"riga_documento"."id_articolo" = "articolo"."id_articolo"},
			"dba"."documento", "dba"."registro"
	where ( "documento"."id_documento" = "riga_documento"."id_documento" ) and
			( "registro"."id_registro" = "documento"."id_registro" ) and
			( "riga_documento"."id_riga_documento" = :ll_id_riga );
			
	ll_dbcode = sqlca.sqlcode
	choose case ll_dbcode
		case is < 0
			MessageBox ("Errore nel Database!",sqlca.sqlerrtext)
		case 0
			
			if al_row=0 then
				ll_row = insertRow(0)
			else
				ll_row = al_row
			end if
			
			if ll_row > 0 then
				scrolltorow(ll_row)
				if isNull(ld_q1) then ld_q1 = 0
				if IsNull(ld_q2) then ld_q2 = 0
				if isNull(ld_qe) then ld_qe = 0
				atv_1.GetItem(al_handle,ltvi_1)
				ls_doc = ltvi_1.data
				setItem(ll_row,"registro_tipo_registro",ls_tr)
				setItem(ll_row,"registro_numero",ld_nr)
				setItem(ll_row,"documento_num_progressivo",ld_np)
				setItem(ll_row,"documento_data_registrazione",ldt_dr)
				setItem(ll_row,"riga_documento_num_riga",ld_rg)
				setItem(ll_row,"articolo_codice",ls_ca)
				setItem(ll_row,"riga_documento_descrizione",ls_da)
				setItem(ll_row,"riga_documento_quantita",ld_q1)
				setItem(ll_row,"riga_documento_qta_sconto_merce",ld_q2)
				setItem(ll_row,"riga_documento_qta_evasa",ld_qe)
				setItem(ll_row,"riga_documento_peso_netto",ld_netto)
				setItem(ll_row,"riga_documento_id_riga_lotto",ll_id_r_lotto)
				setitem(ll_row,"riga_documento_forza_chius_evasione",lc_forza_chius_evasione )
				setitem(ll_row,"riga_documento_id_riga_documento",ll_id_riga_documento )
				setItem(ll_row,"cc_id_riga",ll_id_riga)
				
				setItem(ll_row,"cc_id_arti",ll_ida)
				
				setItem(ll_row,"cc_id_un_conf",ll_iduc)
				
				setItem(ll_row,"cc_id_caus_orig",ll_idcm)
				setItem(ll_row,"cc_handle",al_handle)
				
				setItem(ll_row,"riga_documento_id_caus_magazzino",ls_doc.l_id_caus)
				
				
				
				
				setItem(ll_row,"cc_id_valu",ll_idv)
				
				
				
				
				
				
				
				
				
				ld_qde = ld_q1 + ld_q2 - ld_qe
				if ld_qde < ld_q2 then
					setItem(ll_row,"cc_qta_ev",0)
					setItem(ll_row,"cc_qtasm_ev",ld_qde)
				else
					setItem(ll_row,"cc_qta_ev",ld_qde - ld_q2)
					setItem(ll_row,"cc_qtasm_ev",ld_q2)
				end if
				setItem(ll_row,"cc_cambiato","N")
				
				
				sort()
				groupcalc()
				
				atv_1.GetItem(al_handle,ltvi_1)
				ltvi_1.PictureIndex = ii_lnxxx
				ltvi_1.SelectedPictureIndex = ii_lnxxx
				ls_doc = ltvi_1.data
				ls_doc.s_stato = "N"
				ltvi_1.data = ls_doc
				atv_1.SetItem(al_handle,ltvi_1)

			else
				messageBox ("Errore!","Non riesco ad inserire la riga "+string (ll_id_riga))
			end if
		case 100
			messageBox ("Errore!","Pare che la riga " + string (ll_id_riga) + "non esista! ")
		case else
	end choose

return ll_ritorna

end event

event ue_insert_doc;call super::ue_insert_doc;

treeViewItem	l_tvi
boolean			lb_posso
boolean			lb_almeno_una_riga
boolean			lb_gia_scalato
s_doc				ls_doc
long				ll_hnd, ll_handle
integer			li_ret
decimal			ld_appoggio
decimal			ld_salva_acconto
string			ls_salva_test


if al_id_riga > 0 then atv_1.setRedraw(false)

atv_1.GetItem(al_handle, l_tvi)
if l_tvi.expandedOnce = FALSE then
	ls_doc = l_tvi.data
	wf_load_righe(atv_1, al_handle, ls_doc)
	atv_1.ExpandItem(al_handle)
else
	ls_doc = l_tvi.data
end if
ll_handle = al_handle

lb_gia_scalato   = ls_doc.b_gia_scalato
ld_salva_acconto = ls_doc.d_imp_acconto
ls_salva_test    = ls_doc.s_test

if ls_salva_test = is_test or is_test = "PRIMO" then
	is_test = ls_salva_test
	st_2.text = ls_salva_test
	
	
	
	lb_almeno_una_riga = false
	ll_hnd = atv_1.FindItem(ChildTreeItem!, al_handle)
	do while ll_hnd>0
		
		atv_1.GetItem(ll_hnd, l_tvi)
		ls_doc = l_tvi.data
		lb_posso = wf_posso_inserire_riga(ls_doc, false)
		if (ab_riga = false ) or (ab_riga = true And ls_doc.l_id = al_id_unico) then
				if lb_posso then
					lb_almeno_una_riga = true
					li_ret = event ue_insert_riga (ls_doc.l_id, ll_hnd, tv_1, 0)
				end if
			end if

		ll_hnd = atv_1.FindItem(NextTreeItem!, ll_hnd)
	loop

	if lb_almeno_una_riga = true and not lb_gia_scalato then
		if isnull(id_acconto) then id_acconto = 0
		id_acconto = id_acconto + ld_salva_acconto
		st_acconti.text 	= string(id_acconto)
		
		atv_1.GetItem(ll_handle, l_tvi)
		ls_doc = l_tvi.data
		ls_doc.b_gia_scalato = true
		l_tvi.data = ls_doc
		atv_1.SetItem(ll_handle, l_tvi)
	end if
else
	messagebox("ERRORE","Non si possono derivare documenti ~r~n con Parametri Diversi! ", StopSign! )
end if

if al_id_riga > 0 then atv_1.setRedraw(true)

return 0

end event

event ue_insert_tipo;call super::ue_insert_tipo;

treeViewItem	l_tvi
boolean			lb_posso
s_doc				ls_doc
string			ls_last_test, ls_cur_test
long				ll_hnd
integer			li_ret


if al_id_riga > 0 then atv_1.setRedraw(false)


ll_hnd = atv_1.FindItem(ChildTreeItem!, al_handle)


if is_test = "PRIMO" then
	atv_1.GetItem(ll_hnd, l_tvi)
	ls_doc = l_tvi.data
	ls_cur_test = ls_doc.s_test
else
	ls_cur_test = is_test
end if

do while ll_hnd>0
	
	atv_1.GetItem(ll_hnd, l_tvi)
	ls_doc = l_tvi.data
	ls_last_test = ls_doc.s_test
	
	
	if ls_last_test = ls_cur_test then
		li_ret = event ue_insert_doc (-1, ll_hnd, tv_1, false, 0)
		ll_hnd = atv_1.FindItem(NextTreeItem!, ll_hnd)
	else
		
		
		messagebox("ERRORE","Non si possono derivare documenti ~r~n con Parametri diversi ! ", StopSign! )
		ll_hnd = 0
	end if
loop

if al_id_riga > 0 then atv_1.setRedraw(true)

return 0

end event

event ue_insert_sogg;call super::ue_insert_sogg;

treeViewItem	l_tvi
boolean			lb_posso
s_doc				ls_doc
long				ll_hnd
integer			li_ret


if al_id_riga > 0 then atv_1.setRedraw(false)


ll_hnd = atv_1.FindItem(ChildTreeItem!, al_handle)
do while ll_hnd>0
	
	atv_1.GetItem(ll_hnd, l_tvi)
	ls_doc = l_tvi.data
	li_ret = event ue_insert_tipo (-1, ll_hnd, tv_1)
	ll_hnd = atv_1.FindItem(NextTreeItem!, ll_hnd)
loop

if al_id_riga > 0 then atv_1.setRedraw(true)

return 0

end event

event ue_reset_riga;call super::ue_reset_riga;

TreeViewItem		ltvi_1
s_doc					ls_doc

atv_1.SetRedraw(false)
atv_1.GetItem(al_handle,ltvi_1)
ltvi_1.PictureIndex = ii_lnuns
ltvi_1.SelectedPictureIndex = ii_lnsel
ls_doc = ltvi_1.data
ls_doc.s_stato = "S"
ltvi_1.data = ls_doc
atv_1.SetItem(al_handle,ltvi_1)
atv_1.SetRedraw(true)

return 0

end event

event ue_mdown;call super::ue_mdown;ib_down = true


long			ll_row, ll_pos
string		ls_dati, ls_riga

ll_row = 0
if ib_down then
	ls_dati = this.GetObjectAtPointer()
	ll_pos = pos(ls_dati,"~t")
	if ll_pos>0 then
		ls_riga = mid(ls_dati,ll_pos+1)
		ll_row = long(ls_riga)
	end if
	
	
	il_cur_id_riga = ll_row

	if (il_cur_id_riga > 0 ) then
		This.Drag(begin!)
		il_cur_handle = GetItemNumber(il_cur_id_riga,"cc_handle")
	else
		this.drag(end!)
	end if
end if

end event

event ue_mup;call super::ue_mup;ib_down = false

end event

event ue_mmove;call super::ue_mmove;

end event

event dragdrop;call super::dragdrop;

DragObject		ldo_control
treeviewItem	ltv_1
long				ll_res, ll_row, ll_handle_riga, ll_id_riga
s_doc				ls_doc
boolean			lb_posso
integer			li_ret


ldo_control = DraggedObject()

if ldo_control = tv_1 then
	ll_res = tv_1.getItem(il_cur_handle, ltv_1)
	ls_doc = ltv_1.data
	choose case ls_doc.i_tipo
		case 0	
			li_ret = event ue_insert_sogg (ls_doc.l_id, il_cur_handle, tv_1)
		case 1	
			li_ret = event ue_insert_tipo (ls_doc.l_id, il_cur_handle, tv_1)
		case 2	
			li_ret = event ue_insert_doc (ls_doc.l_id, il_cur_handle, tv_1, false, 0)
		case 3	
			ll_handle_riga = il_cur_handle
			ll_id_riga 		= ls_doc.l_id
			il_cur_handle  = tv_1.finditem(ParentTreeItem!, il_cur_handle )
			ll_res = tv_1.getItem(il_cur_handle, ltv_1)
			ls_doc = ltv_1.data
			li_ret = event ue_insert_doc (ls_doc.l_id, il_cur_handle, tv_1, true, ll_id_riga)	
			
		case else
	end choose
end if

if ldo_control = this then
	this.drag(End!)
end if

return 0
end event

event doubleclicked;call super::doubleclicked;

string		ls_chg
long			ll_row, ll_idriga, ll_handle

ll_row = row
ls_chg = GetItemString(ll_row,"cc_cambiato")
if ls_chg <>"N" then
	
	ll_idriga = getItemNumber(ll_row,"cc_id_riga")
	ll_handle = getItemNumber(ll_row,"cc_handle")
	trigger event ue_insert_riga(ll_idriga, ll_handle, tv_1, ll_row)
	ls_chg = "N"
else
	
	ls_chg = "S"
end if

setItem(ll_row,"cc_cambiato", ls_chg)

end event

event itemchanged;call super::itemchanged;string	ls_column
decimal	ld_q1, ld_q2
long		ll_row, ll_han
long		ll_id_riga_documento	

ls_column = dwo.name
ll_row = GetRow()

choose case ls_column
	case "cc_qta_ev"
		ld_q1 = long(data)
		ld_q2 = uf_getItemDecimal(ll_row,"cc_qtasm_ev")
	case "cc_qtasm_ev"
		ld_q1 = uf_getItemDecimal(ll_row,"cc_qta_ev")
		ld_q2 = long(data)
	case "riga_documento_forza_chius_evasione"
end choose
ll_han = getItemNumber(ll_row,"cc_handle")


end event

event ue_key;call super::ue_key;long			ll_row, ll_handle


choose case key
	
	
	
	case KeySubtract!
		if (keyFlags=2) then
				ll_row = getRow()
				ll_handle = GetItemNumber(ll_row,"cc_handle")
				event ue_reset_riga(tv_1,ll_handle)
				DeleteRow(ll_row)
				ScrollToRow(0)
				
				sort()
				groupcalc()
		end if
end choose

end event

event clicked;call super::clicked;
if this.rowcount() = 0 then 
		is_test = "PRIMO"
		st_2.text = is_test
end if
end event

type st_1 from statictext within w_deriva_wz
int X=2401
int Y=161
int Width=584
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Totale Acconto Documenti"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_acconti from statictext within w_deriva_wz
int X=2283
int Y=257
int Width=697
int Height=84
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_deriva_wz
int X=82
int Y=484
int Width=40
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10

int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tv_1 from treeview within w_deriva_wz
int X=11
int Y=29
int Width=2219
int Height=532
int TabOrder=10
boolean DragAuto=true
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean DisableDragDrop=false
boolean HasButtons=false
int Indent=10
string PictureName[]={"Custom076!",&
"SingletonReturn!",&
"Custom017!",&
"Custom023!",&
"BorderShadowBox!",&
"Border3DLowered!",&
"RunWindow!",&
"RunWindow!",&
"RunWindow!",&
"NotFound!",&
"NotFound!",&
"NotFound!",&
"NotFound!"}
long PictureMaskColor=79741120
long StatePictureMaskColor=553648127
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event begindrag;
il_cur_handle = handle

end event

event doubleclicked;
treeViewItem	l_tvi
boolean			lb_exp
s_doc				ls_doc

if handle <> 0 then
	GetItem(handle, l_tvi)
	ls_doc = l_tvi.data
	choose case ls_doc.i_tipo
		case 0		
			lb_exp = l_tvi.expanded
			if (lb_exp) then
				collapseItem(handle)
			else
				ExpandItem(handle)
			end if
		case 1		
			lb_exp = l_tvi.expanded
			if (lb_exp) then
				collapseItem(handle)
			else
				ExpandItem(handle)
			end if
		case 2		
			if l_tvi.expandedOnce = FALSE then
				
				
				wf_load_righe(this, handle, ls_doc)
				ExpandItem(handle)
			else
				lb_exp = l_tvi.expanded
				if (lb_exp) then
					collapseItem(handle)
				else
					ExpandItem(handle)
				end if
			end if
		case 3		
	end choose
end if

return 1

end event

event key;long				ll_tvi
boolean			lb_exp

if (key=KeyEnter!) and (keyflags=0) then
	ll_tvi = FindItem(CurrentTreeItem!,0)
	trigger event doubleclicked (ll_tvi)
	return 1
else
	return 0
end if
end event

event dragdrop;

DragObject		ldo_control
treeviewItem	ltv_1
long				ll_res, ll_row, ll_n_row, ll_hnd
s_doc				ls_doc
boolean			lb_posso
integer			li_ret
string			ls_appoggio

ldo_control = DraggedObject()

if ldo_control = dw_1 then
	dw_1.event ue_reset_riga(this,il_cur_handle)
	
	ll_row = dw_1.getrow()
	ls_appoggio = dw_1.getitemstring(ll_row,"cc_testa_doc")
	
	dw_1.DeleteRow(il_cur_id_riga)
	dw_1.ScrollToRow(0)
	dw_1.sort()
	dw_1.groupcalc()
	
	
	
	
	
	if dw_1.rowcount() <= 0 then
		st_2.text = "PRIMO"
		is_test = "PRIMO"
		id_acconto = 0
		st_acconti.text = "0"
	else
		ll_row = dw_1.Find("cc_testa_doc = '"+ls_appoggio+"'", 0, dw_1.rowcount() )
		if ll_row = 0 then
			ll_hnd = tv_1.finditem (ParentTreeItem!,il_cur_handle)
			tv_1.getitem(ll_hnd,ltv_1)
			ls_doc = ltv_1.data
			id_acconto = id_acconto - ls_doc.d_imp_acconto
			ls_doc.b_gia_scalato = false
			ltv_1.data = ls_doc
			tv_1.setitem(ll_hnd,ltv_1)
			st_acconti.text = string(id_acconto)
		end if
	end if
	
else
	this.drag(End!)
end if

end event

