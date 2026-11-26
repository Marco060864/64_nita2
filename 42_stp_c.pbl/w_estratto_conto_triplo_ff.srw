forward
global type w_estratto_conto_triplo_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_estratto_conto_triplo_ff
end type
type cb_annulla from commandbutton within w_estratto_conto_triplo_ff
end type
type dw_1 from u_dw_ext_main within w_estratto_conto_triplo_ff
end type
end forward

global type w_estratto_conto_triplo_ff from w_wiz_main
integer width = 2432
integer height = 906
string title = "Estratto Conto"
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_estratto_conto_triplo_ff w_estratto_conto_triplo_ff

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
boolean lb_ges_periodo
long ll_valuta
end variables

forward prototypes
public subroutine wf_trova_fido (string as_conto)
end prototypes

public subroutine wf_trova_fido (string as_conto);decimal ldc_fido, ldc_cas_effetti, ldc_fido_old, ldc_cas_effetti_old
long ll_id_conto, ll_id_banca

ldc_fido_old=dw_1.getitemdecimal(1, "fido")
ldc_cas_effetti_old=dw_1.getitemdecimal(1, "cas_effetti")
if ldc_fido_old=0 or isnull(ldc_fido_old) or ldc_cas_effetti_old=0 or isnull(ldc_cas_effetti_old)  then

	select id_conto
	into :ll_id_conto
	from conto
	where codice=:as_conto;
	
	select id_banca_azienda
	into :ll_id_banca
	from banca_azienda
	where id_conto=:ll_id_conto;
	
	
	select fido, cas_effetti
	into :ldc_fido, :ldc_cas_effetti
	from con_banca_azienda
	where id_banca_azienda=:ll_id_banca;
	
	if isnull(ldc_cas_effetti_old) or ldc_cas_effetti_old=0 then
		if ldc_cas_effetti>0 then
			dw_1.setitem(1, "cas_effetti", ldc_cas_effetti)
		end if
	end if
	if isnull(ldc_fido_old) or ldc_fido_old=0 then
		if ldc_fido>0 then
			dw_1.setitem(1, "fido", ldc_fido)
		end if
	end if
end if
	
	
end subroutine

on w_estratto_conto_triplo_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_estratto_conto_triplo_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;

long ll_conto
string ls_codice, ls_descrizione

datawindowchild ldc_es
dw_1.getchild('id_esercizio',ldc_es)
ldc_es.settransobject(sqlca)
ldc_es.retrieve()


IF dw_1.GetRow() = 0 THEN
  dw_1.InsertRow(0)

  ll_conto = Message.doubleparm
  if not isnull(ll_conto) then
   	select codice , descrizione
   	into :ls_codice,:ls_descrizione
   	from conto
   	where id_conto=:ll_conto;
   	dw_1.setitem(1, 'da_cod', ls_codice )
   	dw_1.setitem(1, 'da_des', ls_descrizione)	
  end if	
	
   date dat2, dat1
   long ll_id_es

	select id_esercizio
	into :ll_id_es
	from azienda;
	
	select data_inizio, data_fine, id_valuta
	into :dat1, :dat2, :ll_valuta
	from esercizio where id_esercizio=:ll_id_es;
	
	if dat2>today() then dat2=today()
		
	dw_1.setitem(1,'id_esercizio',ll_id_es)	
	dw_1.setitem(1, 'd_in', dat1 )
	dw_1.setitem(1, 'd_fin', dat2)	
	
END IF



datawindowchild ldw_sottomastro 
dw_1.getchild("sottomastro",ldw_sottomastro)
ldw_sottomastro.settransobject(sqlca)
ldw_sottomastro.retrieve()

datawindowchild ldw_valuta 
dw_1.getchild("valuta",ldw_valuta)
ldw_valuta.settransobject(sqlca)
ldw_valuta.retrieve()

dw_1.setitem(1,'valuta',ll_valuta)
dw_1.setitem(1, 'data_stampa', today())	

end event

event closequery;
end event

type cb_ok from commandbutton within w_estratto_conto_triplo_ff
event clicked pbm_bnclicked
integer x = 48
integer y = 35
integer width = 271
integer height = 83
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean cancel = true
end type

event clicked;

s_passa_date str_parametri  

string  ls_conto, ls_conto2, ls_mastro, ls_sottomastro, ls_valuta, ls_mm, ls_tipo_mm, ls_bloc
decimal ld_cambio, ld_saldo
long ll_apertura, ll_id_registro, ll_ides, ll_chiusura, ll_cifre_decimali, ll_id_conto, ll_id_conto2
date  ld_inizio,ld_fine, ld_data_competenza, d_dat_in, d_dat_fin
integer li_d_day, li_d_fine , i, li_ret
string ls_data_inizio, ls_conto3
long lc_valuta, ll_val_lire, ll_id_conto3
select id_val_lire into :ll_val_lire from par_sistema;


datastore ds_stampa
ds_stampa=create datastore


li_ret=0
ll_ides   = dw_1.getitemnumber(1, 'id_esercizio')
d_dat_in  = dw_1.getitemdate(1, 'd_in')
d_dat_fin = dw_1.getitemdate(1, 'd_fin')
str_parametri.data_stampa = dw_1.getitemdate(1, 'data_stampa')

ls_conto2=dw_1.getitemstring(1, 'da_cod') 

ls_conto=dw_1.getitemstring(1, 'a_cod')

ls_conto3=dw_1.getitemstring(1, 'conto3')

ls_mm=Left(ls_conto2, 2)
select tipo into :ls_tipo_mm from mastro where codice=:ls_mm;

select id_conto
into :ll_id_conto2
from conto
where codice=:ls_conto2;
if isnull(ls_conto2) then ls_conto2=''

select id_conto
into :ll_id_conto
from conto
where codice=:ls_conto;
if isnull(ls_conto) then ls_conto=''

select id_conto
into :ll_id_conto3
from conto
where codice=:ls_conto3;
if isnull(ls_conto3) then ls_conto3=''


lc_valuta=dw_1.getitemnumber(1,'valuta')


IF d_dat_in > d_dat_fin THEN
	messagebox ('Attenzione', 'Verificare date inserite')
	return
end if
if isnull(d_dat_fin) then
	messagebox ('Attenzione', 'Inserire = fino a data')
	return
end if



open (W_attesa)


if ll_valuta=ll_val_lire then
	select descrizione, cambio, dec_significativi
	into :ls_valuta, :ld_cambio, :ll_cifre_decimali
	from valuta where id_valuta=:lc_valuta;
else	
	select descrizione, parita_euro, dec_significativi
	into :ls_valuta, :ld_cambio, :ll_cifre_decimali
	from valuta where id_valuta=:lc_valuta;
end if


IF isnull(ls_conto2) then 
	messagebox ('Attenzione', 'Non è stato inserito nessun conto')
   return
end if	
str_parametri.da_conto=ls_conto2
str_parametri.a_conto=ls_conto
str_parametri.data_inizio_estratto= d_dat_in
str_parametri.data_fine_estratto= d_dat_fin
str_parametri.valuta=ls_valuta
str_parametri.cambio=ld_cambio
str_parametri.decimali=ll_cifre_decimali
str_parametri.id_valuta=lc_valuta

select data_inizio into :ld_inizio from esercizio where id_esercizio=:ll_ides;
ld_fine=relativedate(ld_inizio, -1)
select bloccato into :ls_bloc from esercizio where data_fine=:ld_fine;

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_apertura, :ll_chiusura
from par_sistema;

long ll_utile_sp
string ls_filter
select id_conto_utile_sp into :ll_utile_sp from par_sistema;
ls_filter="id_prof_reg<>"+string(ll_chiusura)

str_parametri.prof_apertura= ll_apertura
str_parametri.prof_chiusura= ll_chiusura

if ls_bloc='S' then 
	if ld_inizio=d_dat_in then 
		li_ret=-1
		str_parametri.saldo_iniziale=0
	else
		str_parametri.data_saldo_iniziale=ld_inizio
	end if	
else
	if ls_tipo_mm='C' or ls_tipo_mm='R' or ls_tipo_mm='E' then
		if ld_inizio=d_dat_in then 
			li_ret=-1
			str_parametri.saldo_iniziale=0
		else
			str_parametri.data_saldo_iniziale=ld_inizio
		end if	
	else	
				
		select max(data_competenza)
		into :ld_data_competenza
		from reg_pd
		where id_prof_registrazione=:ll_apertura 
		and data_COMPETENZA < :d_dat_in;

		if sqlca.sqlcode=100 then
			
 			select min(data_COMPETENZA)
  			into :ld_data_competenza
  			from reg_pd;
		end if

		str_parametri.data_saldo_iniziale= ld_data_competenza
	end if
end if		
select max(data_competenza)
into :ld_data_competenza
from reg_pd
where id_prof_registrazione=:ll_apertura;

if sqlca.sqlcode=100 or isnull(ld_data_competenza) then 
	select min(data_COMPETENZA)
	into :ld_data_competenza
	from reg_pd;	
end if	
if ld_data_competenza<d_dat_in and (ls_tipo_mm='C' or ls_tipo_mm='R' or ls_tipo_mm='E') then
	ld_data_competenza=d_dat_in
end if
str_parametri.data_saldo_fine=ld_data_competenza


if li_ret<>-1 then
	ds_stampa.dataobject='ds_calc_saldo_iniziale_2'
	ds_stampa.reset()	
	ds_stampa.settransobject(sqlca)
	li_ret=ds_stampa.retrieve(ll_id_conto,str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali,lc_valuta )
	
	if ll_id_conto=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
	end if	
	
	if li_ret>0 then 
		str_parametri.saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
	else	
	   str_parametri.saldo_iniziale=0
	end if
	//110614 aggiunto per calcolare il saldo del secondo conto
	li_ret=ds_stampa.retrieve(ll_id_conto2,str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali,lc_valuta )
	
	if ll_id_conto=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
	end if	
	
	if li_ret>0 then 
		str_parametri.saldo_iniziale2=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
	else	
	   str_parametri.saldo_iniziale2=0
	end if
	//fine 110614
	
	//180614 aggiunto per calcolare il saldo del terzo conto
	li_ret=ds_stampa.retrieve(ll_id_conto3,str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali,lc_valuta )
	
	if ll_id_conto3=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
	end if	
	
	if li_ret>0 then 
		str_parametri.saldo_iniziale3=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
	else	
	   str_parametri.saldo_iniziale3=0
	end if
	//fine 180614
	
	
	
end if 	

ds_stampa.dataobject='ds_calc_saldo_attuale_2'
ds_stampa.reset()
ds_stampa.settransobject(sqlca)
li_ret=ds_stampa.retrieve(ll_id_conto,str_parametri.data_saldo_fine,str_parametri.cambio,str_parametri.decimali,lc_valuta )
if ll_id_conto=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
end if	
if li_ret>0 then str_parametri.saldo_finale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
//110614 aggiunto per calcolare il saldo del secondo conto
li_ret=ds_stampa.retrieve(ll_id_conto2,str_parametri.data_saldo_fine,str_parametri.cambio,str_parametri.decimali,lc_valuta )
if ll_id_conto=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
end if	
if li_ret>0 then str_parametri.saldo_finale2=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
//fine 110614
//180614 aggiunto per calcolare il saldo del secondo conto
li_ret=ds_stampa.retrieve(ll_id_conto3,str_parametri.data_saldo_fine,str_parametri.cambio,str_parametri.decimali,lc_valuta )
if ll_id_conto=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
end if	
if li_ret>0 then str_parametri.saldo_finale3=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
//fine180614



//110614 aggiungo anche il fido ...
str_parametri.fido=dw_1.getitemdecimal(1,"fido")
str_parametri.cas_effetti=dw_1.getitemdecimal(1,"cas_effetti")
str_parametri.conto3=ls_conto3
//fine 110614
close (w_attesa)
openwithparm(w_stampa_estratto_triplo_ff, str_parametri)




end event

type cb_annulla from commandbutton within w_estratto_conto_triplo_ff
integer x = 336
integer y = 35
integer width = 256
integer height = 83
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_estratto_conto_triplo_ff
integer x = 51
integer y = 154
integer width = 2289
integer height = 605
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_estratto_conto_triplo"
end type

event itemchanged;string ls_filtro, ls_colonna
integer li_ok
long ll_es
string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
date ld_d1, ld_d2

setnull(ls_null)

CHOOSE CASE dwo.name
	
	
	CASE "id_esercizio"
		select data_inizio,data_fine
		into :ld_d1,:ld_d2
		from esercizio
		where id_esercizio=:data;
		dw_1.setitem(1,"d_in",ld_d1)
		dw_1.setitem(1,"d_fin",ld_d2)		
		
		
	CASE "d_in"
		LS_COLONNA="d_in"
		ll_es=dw_1.getitemnumber(1,'id_esercizio')
		select data_inizio,data_fine
		into :ld_d1,:ld_d2
		from esercizio
		where id_esercizio=:ll_es;
		if date(data)<ld_d1 or date(data)>ld_d2 then
				messagebox("Controllo", "Attenzione, la Data Iniziale non rientra~nnell'Esercizio selezionato!")
      		ls_colonna="d_in"
      		POST F_SET_COLUMN(DW_1,LS_COLONNA)
		end if
	
	CASE "d_fin"
		LS_COLONNA="d_fin"
		ll_es=dw_1.getitemnumber(1,'id_esercizio')
		select data_inizio,data_fine
		into :ld_d1,:ld_d2
		from esercizio
		where id_esercizio=:ll_es;
		if date(data)<ld_d1 or date(data)>ld_d2 then
  				messagebox("Controllo", "Attenzione, la Data Finale non rientra~nnell'Esercizio selezionato!")
   		   ls_colonna="d_fin"
      		POST F_SET_COLUMN(DW_1,LS_COLONNA)
   	end if	
	
		
	CASE "da_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			wf_trova_fido(ls_dbv[1])
			RETURN 2
		END IF
		
	CASE "conto3"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "conto3"
		ls_dwc[2] = "des_conto3"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			wf_trova_fido(ls_dbv[1])
			RETURN 2
		END IF
		
	case "des_conto3"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "conto3"
		ls_dwc[2] = "des_conto3"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			wf_trova_fido(ls_dbv[1])
			RETURN 2
		END IF
		
	case "da_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			wf_trova_fido(ls_dbv[1])
			RETURN 2
		END IF
		
	CASE "a_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			wf_trova_fido(ls_dbv[1])
			RETURN 2
		END IF
		
		
	case "a_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			wf_trova_fido(ls_dbv[1])
			RETURN 2
		END IF



		
end choose

end event

event ue_set_search;string ls_cond

CHOOSE CASE as_nomecol
	CASE "a_cod", "a_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "a_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "a_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF

	CASE "da_cod", "da_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "da_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
	CASE "conto3", "des_conto3"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "conto3" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "des_conto3" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
		
	case "mastro"
		is_search_window = "w_mastro_sw"
      is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"

 

END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
		wf_trova_fido(is_ricpar.s_main_value)

	CASE "a_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
		wf_trova_fido(is_ricpar.s_ausil_value[1])
	CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])
		wf_trova_fido(is_ricpar.s_main_value)
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_cod', is_ricpar.s_main_value)
        uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
	   end if
		

	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		wf_trova_fido(is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_des', is_ricpar.s_main_value)
        uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	   end if	
		
	CASE "conto3"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_conto3", is_ricpar.s_ausil_value[1])
		wf_trova_fido(is_ricpar.s_main_value)
		if isnull(This.GetItemString(1, "conto3")) or This.GetItemString(1, "conto3")='' then
        uf_set_colval('conto3', is_ricpar.s_main_value)
        uf_set_colval("des_conto3", is_ricpar.s_ausil_value[1])
		  
	   end if
		

	CASE "des_conto3"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto3", is_ricpar.s_ausil_value[1])
		wf_trova_fido(is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "conto3")) or This.GetItemString(1, "conto3")='' then
        uf_set_colval('des_conto3', is_ricpar.s_main_value)
        uf_set_colval("conto3", is_ricpar.s_ausil_value[1])
	   end if		

   Case "mastro"
      uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_mastro", is_ricpar.s_id_seg_value[1])
		if isnull(as_nomecol) then 
		   this.setitem(1,"sottomastro",ls_null)
		else	
			this.setitem(1,"a_des",ls_null)
			this.setitem(1,"a_cod",ls_null)
	      this.setitem(1,"da_des",ls_null)
			this.setitem(1,"da_cod",ls_null)
			ls_filtro=is_ricpar.s_id_seg_value[1]
			if not isnull(ls_filtro) then
		     datawindowchild ldwc_dddw
		     this.GetChild('sottomastro',ldwc_dddw )
		     ldwc_dddw.setfilter("sottomastro_id_mastro="+ls_filtro)
		     ldwc_dddw.filter()
		   end if
		end if
		
	
	


END CHOOSE








end event

