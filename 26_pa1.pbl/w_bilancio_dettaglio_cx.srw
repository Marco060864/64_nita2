forward
global type w_bilancio_dettaglio_cx from Window
end type
type cb_1 from commandbutton within w_bilancio_dettaglio_cx
end type
type cb_2 from commandbutton within w_bilancio_dettaglio_cx
end type
type dw_1 from u_dw_ext_main within w_bilancio_dettaglio_cx
end type
end forward

global type w_bilancio_dettaglio_cx from Window
int X=832
int Y=360
int Width=2537
int Height=1072
boolean TitleBar=true
string Title="Bilancio"
long BackColor=80263581
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_bilancio_dettaglio_cx w_bilancio_dettaglio_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4
long ll_val_es
end variables

event open;
dw_1.insertrow(0)
dw_1.setfocus()
datawindowchild ldc_es,ldc_es1,ldc_es2,ldc_val,ldc_azienda

string ls_cod,ls_des
dw_1.getchild('id_esercizio',ldc_es)
ldc_es.settransobject(sqlca)
ldc_es.retrieve()
dw_1.getchild('id_azienda',ldc_azienda)
ldc_azienda.settransobject(sqlca)
ldc_azienda.retrieve()
dw_1.getchild('valuta',ldc_val)
ldc_val.settransobject(sqlca)
ldc_val.retrieve()
dw_1.setitem(1,'tipo_mov','P')
datawindowchild ldw_sottomastro 
dw_1.getchild("sottomastro",ldw_sottomastro)
ldw_sottomastro.settransobject(sqlca)
ldw_sottomastro.retrieve()


long ll_con
select id_conto_utile_sp,id_conto_utile_ce,id_conto_perdite_sp,id_conto_perdite_ce
into :ll_id1,:ll_id2,:ll_id3,:ll_id4
from par_sistema;
ll_con=ll_id1+ll_id2+ll_id3+ll_id4
if isnull(ll_con) then 
	cb_1.enabled=false
	messagebox('Errore',"Errore in parametri di sistema ~r~n Inserire i conti Utile e Perdita")
end if

date ld_data, ld_d1, ld_d2
long ll_es
ld_data=today()
dw_1.setitem(1,"da_data",ld_data)
select id_esercizio, data_inizio,data_fine, id_valuta
into :ll_es, :ld_d1,:ld_d2, :ll_val_es
from esercizio
where data_inizio<=:ld_data and data_fine>=:ld_data;
dw_1.setitem(1,"da",ld_d1)
dw_1.setitem(1,"a",ld_d2)	
dw_1.setitem(1,"valuta",ll_val_es)

dw_1.setitem(1,'id_azienda',1)

end event

on w_bilancio_dettaglio_cx.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_bilancio_dettaglio_cx.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_1 from commandbutton within w_bilancio_dettaglio_cx
int X=2213
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.accepttext()

delete from chiusura_apertura;
long ll_esercizio
string ls_apertura, ls_mastro, ls_sottomastro, ls_conto, ls_conto2
long ll_id_es,ll_id_azienda, ll_test, ll_id_val
decimal ld_dec_sign, ld_cambio
string ls_bloc
uo_bilancio_parziale lo_sp
long ll_val_lire
select id_val_lire into :ll_val_lire from par_sistema;

ls_apertura=dw_1.getitemstring(1,'apertura')
ls_mastro=dw_1.getitemstring(1,"mastro")
ls_sottomastro=dw_1.getitemstring(1,"sottomastro")
ls_conto=dw_1.getitemstring(1, 'a_cod') 
if isnull(ls_conto) then ls_conto=''
ls_conto2=dw_1.getitemstring(1, 'da_cod') 
if isnull(ls_conto2) then ls_conto2=''
IF ls_conto2 > ls_conto THEN
	messagebox ('Attenzione', 'Il conto iniziale è maggiore del conto finale')
	return
end if	

open (W_attesa)
if isnull(ls_mastro) then 
   IF isnull(ls_conto2) then
	   SELECT min(codice)
		INTO :ls_conto2
		FROM conto;
	end if
	if isnull (ls_conto) then 
		SELECT max(codice)
		INTO :ls_conto
		FROM conto;
	end if
else
	IF isnull(ls_sottomastro) then 
	   SELECT min(codice), max(codice)
		INTO :ls_conto2, :ls_conto
		FROM conto
		where left(codice,2)=:ls_mastro;
	else
		SELECT min(codice), max(codice)
		INTO :ls_conto2, :ls_conto
		FROM conto
		where left(codice,4)=:ls_mastro+:ls_sottomastro;
		
	end if
end if

ll_id_val=dw_1.getitemnumber(1,"valuta")
if ll_val_es=ll_val_lire then
	SELECT dec_significativi, cambio
	INTO :ld_dec_sign  ,:ld_cambio
	FROM valuta WHERE id_valuta = :ll_id_val;
else	
	SELECT dec_significativi, parita_euro
	INTO :ld_dec_sign  ,:ld_cambio
	FROM valuta WHERE id_valuta = :ll_id_val;
end if
ld_dec_sign=abs(ld_dec_sign)
ll_id_azienda=dw_1.getitemnumber(1,"id_azienda")

if isnull(ll_id_azienda) then
	messagebox("Informazione","Non è stato inserita l'azienda")
	return
end if	
date ld_da,ld_a
ld_da=dw_1.getitemdate(1,"da")
ld_a=dw_1.getitemdate(1,"a")	
if isnull(ld_a) then	ld_a=today()	
if isnull(ld_da) then	ld_da=date(string('01/01/1995',"yyyy-mm-dd"))

if dw_1.getitemstring(1,'tipo_mov')='P' or dw_1.getitemstring(1,'tipo_mov')='T' then
	
IF ls_apertura='S' then
	 if ((ld_cambio<>0) and (not isnull(ld_cambio))) then
			open(w_attesa)
			lo_sp= create uo_bilancio_parziale 
			ll_test=1
			lo_sp.of_conti_sp_periodo(ld_da,ld_a,ls_conto2, ls_conto, ll_id_val)
			
			lo_sp.of_conti_ce_parz(ld_da,ld_a,ls_conto2, ls_conto, ll_id_val)
			if dw_1.getitemstring(1,'tipo_mov')='P' then destroy lo_sp
			close(w_attesa)
	end if
	
ELSE	  

	
	
	
	
	
	
	date ld_data_fine_bloccata
	long ll_primo_eser_bloccato
	select id_esercizio, data_fine into :ll_primo_eser_bloccato, :ld_data_fine_bloccata
	from esercizio where bloccato='s' and data_fine<:ld_da;
	if sqlca.sqlcode=0 then 
		ld_da=RelativeDate(ld_data_fine_bloccata, 1 )
	else 
		ld_da=date('1990-01-01')
	end if	
		
	if ((ld_cambio<>0) and (not isnull(ld_cambio))) then
		open(w_attesa)
		
		lo_sp= create uo_bilancio_parziale 
		ll_test=1	
		lo_sp.of_conti_sp_parz(ld_da,ld_a,ls_conto2, ls_conto, ll_id_val)
		
		lo_sp.of_conti_ce_parz(ld_da,ld_a,ls_conto2, ls_conto, ll_id_val)
		if dw_1.getitemstring(1,'tipo_mov')='P' then destroy lo_sp
		close(w_attesa)
	end if
		
	

END IF 
end if


if dw_1.getitemstring(1,'tipo_mov')='M' or dw_1.getitemstring(1,'tipo_mov')='T' then
	if ll_test=0 then lo_sp= create uo_bilancio_parziale 
	lo_sp.of_conti_sp_parz_man(ld_da,ld_a,ls_conto2, ls_conto, ll_id_val)
	lo_sp.of_conti_ce_parz_man(ld_da,ld_a,ls_conto2, ls_conto, ll_id_val)
	
	destroy lo_sp
end if

if ((ld_cambio<>0) and (not isnull(ld_cambio))) then
	
		
		
		date ld_data_in, ld_data_fin
		string ls_stp
		ls_stp=dw_1.getitemstring(1,'tipo_stp')
		ld_data_in=dw_1.getitemdate(1,"da")
		ld_data_fin=dw_1.getitemdate(1,"a")
		s_param ls_param
		ls_param.cambio=ld_cambio
		ls_param.dec_significativi=ld_dec_sign
		ls_param.id_azienda=ll_id_azienda
		ls_param.data_in=ld_data_in
		ls_param.data_fin=ld_data_fin
		ls_param.tipo_stp=ls_stp

   	openwithparm(w_stampa_bilancio_gd,ls_param) 

else
	messagebox("Informazione","Non sono state inserite tutte le informazioni necessarie")
end if

end event

type cb_2 from commandbutton within w_bilancio_dettaglio_cx
event clicked pbm_bnclicked
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_bilancio_dettaglio_cx
int X=27
int Y=160
int Width=2469
int Height=804
int TabOrder=30
string DataObject="d_bilancio_dett_ff"
end type

event itemchanged;string ls_filtro
integer li_ok
long ll_valuta
string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

setnull(ls_null)

CHOOSE CASE dwo.name
			
	
	CASE "da_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_cod", Data)			
           This.SetItem(1, "a_des", This.GetItemString(1, "da_des"))
         end if
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
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_des", Data)			
           This.SetItem(1, "a_cod", This.GetItemString(1, "da_cod"))
         end if
			RETURN 2
		END IF

	case "a_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
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
			RETURN 2
		END IF
		
	case "mastro"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "id_mastro"
		
		ls_dwc[1] = "mastro"
		ls_dwc[2] = "id_mastro"
		
		li_ok = uf_autofind_col(dwo.Name, "mastro", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) or li_ok=0 THEN 
        if isnull(data) or trim(data)='' then
		    this.setitem(row,"sottomastro",ls_null)	
		  elseif li_ok>0 then	
			 this.setitem(row,"a_des",ls_null)
			 this.setitem(row,"a_cod",ls_null)
	       this.setitem(row,"da_des",ls_null)
			 this.setitem(row,"da_cod",ls_null)	
			 ls_filtro=ls_dbv[2]
			 if not isnull(ls_filtro) then
		      datawindowchild ldwc_dddw
		      this.GetChild('sottomastro',ldwc_dddw )
		      ldwc_dddw.setfilter("sottomastro_id_mastro="+ls_filtro)
		      ldwc_dddw.filter()
		    end if  
		  end if
	   end if  
		
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

	CASE "a_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	
	CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_cod', is_ricpar.s_main_value)
        uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
	   end if
		

	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_des', is_ricpar.s_main_value)
        uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
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

