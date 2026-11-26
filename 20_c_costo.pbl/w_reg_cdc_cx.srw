forward
global type w_reg_cdc_cx from w_p_data
end type
type dw_2 from u_dw_master_main within tabpage_1
end type
type dw_2 from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from u_dw_master_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_4 from u_dw_master_main within tabpage_3
end type
type dw_1 from u_dw_master_main within w_reg_cdc_cx
end type
type cb_2 from commandbutton within w_reg_cdc_cx
end type
type dw_5 from u_dw_master_main within w_reg_cdc_cx
end type
type cb_ass_reg from commandbutton within w_reg_cdc_cx
end type
type dw_6 from datawindow within w_reg_cdc_cx
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_3 from userobject within tab_1
dw_4 dw_4
end type
end forward

global type w_reg_cdc_cx from w_p_data
int X=9
int Y=12
int Width=2487
int Height=1768
long BackColor=80263581
dw_1 dw_1
cb_2 cb_2
dw_5 dw_5
cb_ass_reg cb_ass_reg
dw_6 dw_6
end type
global w_reg_cdc_cx w_reg_cdc_cx

type variables
long il_canc_mov[]
end variables

forward prototypes
public subroutine uf_riempi_cdc (integer ll_testa)
public subroutine uf_nuova_reg ()
end prototypes

public subroutine uf_riempi_cdc (integer ll_testa);long ll_conto, ll_perc, ll_importo, ll_tot, ll_imp2, ll_imp3, ll_testa2
string cod,des

ll_testa2=dw_1.getitemnumber(1,'id_reg_pdc')

ll_importo=truncate(dw_1.getitemnumber(1,'valore'),0)
ll_perc=0
ll_tot=0
ll_imp3=0
ll_imp2=0
DECLARE lcur_cdc CURSOR FOR  
   SELECT "conto"."codice",   
         "conto"."descrizione",   
         "centro_costo_righe"."id_conto",   
         "centro_costo_righe"."base_perc"    
    FROM "dba"."conto",   
         "dba"."centro_costo_righe"  
   WHERE ( "conto"."id_conto" = "centro_costo_righe"."id_conto" ) and  
         ( ( "centro_costo_righe"."id_cen_cos_t" = :ll_testa ) )  ; 
   OPEN lcur_cdc;
	
	FETCH lcur_cdc into 	:cod,&
									:des,&
									:ll_conto,&
									:ll_perc; 
									
		
   

   do while (sqlca.sqlcode = 0)
		ll_tot=ll_tot + ll_perc
		if ll_tot=100 then
			ll_imp2=ll_importo - ll_imp3
		else
			ll_imp2=Truncate(ll_importo*ll_perc/100, 0)
			ll_imp3=ll_imp3 + ll_imp2
		end if	
		tab_1.tabpage_1.dw_2.setitem(tab_1.tabpage_1.dw_2.getrow(),'cid_conto',ll_conto)
		tab_1.tabpage_1.dw_2.setitem(tab_1.tabpage_1.dw_2.getrow(),'cdescrizione',des)
		tab_1.tabpage_1.dw_2.setitem(tab_1.tabpage_1.dw_2.getrow(),'ccodice',cod)
		
		if dw_1.getitemnumber(1,'segno')=-1 then 
			tab_1.tabpage_1.dw_2.setitem(tab_1.tabpage_1.dw_2.getrow(),'avere',ll_imp2)
		else
			tab_1.tabpage_1.dw_2.setitem(tab_1.tabpage_1.dw_2.getrow(),'dare',ll_imp2)
		end if	
	   FETCH lcur_cdc into 	:cod,&
									:des,&
									:ll_conto,&
									:ll_perc;      
		   
		if (sqlca.sqlcode = 0) then tab_1.tabpage_1.dw_2.TriggerEvent("ue_insert")						
		
	loop 
	CLOSE lcur_cdc;
	
end subroutine

public subroutine uf_nuova_reg ();long ll_num, ll_ret, ll_esercizio
date ld_data

ld_data=today()

ll_ret=year(ld_data)

select id_esercizio
into :ll_esercizio
from esercizio
where year(data_fine)=:ll_ret;

select max(num_prog)
into :ll_num
from reg_pdc
where id_esercizio=:ll_esercizio;
if isnull(ll_num) then ll_num=0


dw_1.setitem(1,'num_prog',ll_num + 1)
dw_1.setitem(1,'cdata',ld_data)
dw_1.setitem(1,'esercizio',ll_esercizio)
dw_1.setitem(1,'segno',1)
dw_1.setitem(1,'liv_provvisorieta','D')
end subroutine

on w_reg_cdc_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.dw_5=create dw_5
this.cb_ass_reg=create cb_ass_reg
this.dw_6=create dw_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_5
this.Control[iCurrent+4]=this.cb_ass_reg
this.Control[iCurrent+5]=this.dw_6
end on

on w_reg_cdc_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.dw_5)
destroy(this.cb_ass_reg)
destroy(this.dw_6)
end on

event open;call super::open;long ll_testa, ll_reg_pd, ll_doc, ll_reg_pdc

idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_reg_pdc"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master = dw_1
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_reg_pdc"

dw_6.settransobject(sqlca)
if idw_master.is_list.l_id_provenienza<>0  and not isnull(idw_master.is_list.l_id_provenienza)  then
	ll_reg_pd=idw_master.is_list.l_id_provenienza
	dw_6.retrieve(ll_reg_pd)
	idw_master.is_list.s_modo=modo_modifica
	ib_nonmodale = false
else
	idw_master.is_list.s_modo=modo_inserisci
	ib_nonmodale = true
end if	


end event

event ue_post_open;call super::ue_post_open;long ll_doc, ll_reg_pdc,ll_reg_pd,ll_mov_contabile, ll_ret, i
idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm
if idw_master.is_list.l_id_provenienza<>0  and not isnull(idw_master.is_list.l_id_provenienza)  then
	ll_reg_pd=idw_master.is_list.l_id_provenienza
	dw_5.retrieve(ll_reg_pd)
	dw_6.visible=false
	ll_reg_pdc=dw_6.getitemnumber(1,'id_reg_pdc')
	idw_master.is_list.s_identifica[1] = "id_reg_pdc"
	idw_master.is_list.l_identifica[1] = ll_reg_pdc
	SetPointer(HourGlass!)														
	idw_master.Event ue_retrieve(0, 0)
	setPointer(Arrow!)
	ll_mov_contabile=dw_1.getitemnumber(1,'id_mov_contabile')
	ll_doc=dw_1.getitemnumber(1,'id_documento')
	if isnull(ll_doc) then
      tab_1.tabpage_2.visible=false
	else
		tab_1.tabpage_2.dw_3.retrieve(ll_doc)
	end if
	ll_ret=tab_1.tabpage_3.dw_4.retrieve(ll_reg_pd)
	for i=1 to ll_ret
		if tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')= ll_mov_contabile then tab_1.tabpage_3.dw_4.SelectRow ( i, true )
	next	
	cb_ass_reg.visible=false
	dw_1.Object.valore.Protect=1
	dw_1.Object.segno.Protect=1
	dw_1.Object.codice.Protect=1
	dw_1.Object.descrizione.Protect=1
else
	if Upperbound(idw_master.is_list.s_identifica)<>0 then 
		if idw_master.is_list.l_identifica[1]<>0 and not isnull(idw_master.is_list.l_identifica[1])  then
		ll_reg_pdc=idw_master.is_list.l_identifica[1]
		idw_master.is_list.s_identifica[1] = "id_reg_pdc"
	   idw_master.is_list.l_identifica[1] = ll_reg_pdc
		SetPointer(HourGlass!)														
	   idw_master.Event ue_retrieve(0, 0)
	   setPointer(Arrow!)
		ll_reg_pd=dw_1.getitemnumber(1,'id_reg_pd')
		dw_5.retrieve(ll_reg_pd)
		ll_doc=dw_1.getitemnumber(1,'id_documento')
		ll_mov_contabile=dw_1.getitemnumber(1,'id_mov_contabile')	
		if isnull(ll_doc) then
     		 tab_1.tabpage_2.visible=false
		else
			 tab_1.tabpage_2.dw_3.retrieve(ll_doc)
		end if
		ll_ret=tab_1.tabpage_3.dw_4.retrieve(ll_reg_pd)
		for i=1 to ll_ret
			if tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')= ll_mov_contabile then tab_1.tabpage_3.dw_4.SelectRow ( i, true )
		next	
		cb_ass_reg.visible=false
		dw_1.Object.valore.Protect=1
		dw_1.Object.segno.Protect=1
		dw_1.Object.codice.Protect=1
		dw_1.Object.descrizione.Protect=1
		end if
	 else  
		tab_1.tabpage_2.visible=false
		tab_1.tabpage_3.visible=false
		uf_nuova_reg()
		
		
	 end if
end if 	 

end event

event ue_master_delete;long  ll_testa
ll_testa=dw_1.getitemnumber(1,'id_reg_pdc')

delete from reg_pdc where id_reg_pdc=:ll_testa;
delete from mov_centri_costo where id_reg_pdc=:ll_testa;
commit;

cb_nuovo.triggerevent(clicked!)


end event

type p_crescente from w_p_data`p_crescente within w_reg_cdc_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_reg_cdc_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_reg_cdc_cx
int X=27
int Y=24
int Width=215
int Height=80
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_reg_cdc_cx
int X=265
int Y=24
int Width=238
int Height=80
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_reg_cdc_cx
int X=667
int Y=24
int Width=238
int Height=80
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;dw_5.reset()
tab_1.tabpage_1.dw_2.reset()
tab_1.tabpage_2.dw_3.reset()
tab_1.tabpage_3.dw_4.reset()
dw_1.Object.valore.Protect=0
dw_1.Object.segno.Protect=0
dw_1.Object.codice.Protect=0
dw_1.Object.descrizione.Protect=0

uf_nuova_reg()
end event

type cb_inserisci from w_p_data`cb_inserisci within w_reg_cdc_cx
int X=1298
int Y=24
int Width=238
int Height=80
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_reg_cdc_cx
int X=1559
int Y=24
int Width=238
int Height=80
boolean BringToTop=true
end type

event cb_cancella::clicked;call super::clicked;

end event

type cb_salva from w_p_data`cb_salva within w_reg_cdc_cx
int X=1966
int Y=24
int Width=238
int Height=80
boolean BringToTop=true
end type

event cb_salva::clicked;call super::clicked;
end event

type tab_1 from w_p_data`tab_1 within w_reg_cdc_cx
int X=27
int Y=1040
int Width=2418
int Height=636
int TabOrder=40
boolean BringToTop=true
long BackColor=80263581
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2382
int Height=516
long BackColor=80263581
string Text="Suddivisione costi"
long TabBackColor=80263581
dw_2 dw_2
end type

on tabpage_1.create
this.dw_2=create dw_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_2)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_reg_cdc_cx
int X=919
int Y=24
int Width=238
int Height=80
boolean BringToTop=true
end type

event cb_ricerca::clicked;w_search_main lw_sm
long ll_reg_pdc,ll_testa,ll_doc,ll_reg_pd, ll_ret, ll_mov_contabile, ll_row, i
s_ric_param ls_ricpar

idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "esercizio_codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_reg_pdc_sw")

idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
ll_reg_pdc=long(idw_master.is_ricpar.s_id_seg_value[1])
idw_master.is_list.s_identifica[1] = "id_reg_pdc"
idw_master.is_list.l_identifica[1] = ll_reg_pdc
SetPointer(HourGlass!)
idw_master.Event ue_retrieve(0, 0)
setPointer(Arrow!)
if idw_master.is_ricpar.s_ausil_value[1]<>'' and not isnull(idw_master.is_ricpar.s_ausil_value[1]) then
		ll_reg_pd=long(idw_master.is_ricpar.s_ausil_value[1])
		ll_ret=dw_6.retrieve(ll_reg_pd)
		ll_mov_contabile=dw_1.getitemnumber(1,'id_mov_contabile')	
		ll_row=tab_1.tabpage_3.dw_4.retrieve(ll_reg_pd)
		dw_1.Object.valore.Protect=1
    	dw_1.Object.segno.Protect=1
	   dw_1.Object.codice.Protect=1
	   dw_1.Object.descrizione.Protect=1
		for i=1 to ll_row
			if tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')= ll_mov_contabile then tab_1.tabpage_3.dw_4.SelectRow ( i, true )
		next	
		
		dw_5.retrieve(ll_reg_pd)
		tab_1.tabpage_3.visible=true
else
		tab_1.tabpage_3.visible=false
		dw_5.insertrow(1)
end if		
if idw_master.is_ricpar.s_ausil_value[2]<>'' and not isnull(idw_master.is_ricpar.s_ausil_value[2]) then
		ll_doc=long(idw_master.is_ricpar.s_ausil_value[2])
		tab_1.tabpage_2.dw_3.retrieve(ll_doc)
		tab_1.tabpage_2.visible=true
else		
      tab_1.tabpage_2.visible=false
end if

end if
end event

type dw_2 from u_dw_master_main within tabpage_1
int X=0
int Y=16
int Width=2382
int Height=480
int TabOrder=10
boolean BringToTop=true
string DataObject="d_centro_costi_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_set_search;string ls_cond, ls_controllo
long ll_pdc


select id_pdc_cen_costo
into :ll_pdc
from azienda;
ls_controllo=string (ll_pdc)

CHOOSE CASE as_nomecol
	CASE "ccodice", "cdescrizione"
		is_search_window = "W_CONTI_IN_PDC_SW"
		IS_RICPAR.S_SQL_COND="PDC.ID_PDC='"+ls_controllo+"'" 

		IF as_nomecol = "ccodice" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "cdescrizione" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF


END CHOOSE	





end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "ccodice"
		uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[2])
		uf_set_colval("cdescrizione", is_ricpar.s_ausil_value[1])
	CASE "cdescrizione"
	 	uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("ccodice", is_ricpar.s_ausil_value[2])
END CHOOSE

end event

event itemchanged;string ls_filtro
integer li_ok

string ls_sql_cond, ls_null, ls_cond, ls_controllo
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_testa_cdc, ll_conto, ll_pdc

setnull(ls_null)

select id_pdc_cen_costo
into :ll_pdc
from azienda;
ls_controllo=string (ll_pdc)	


CHOOSE CASE dwo.name
		
	CASE "ccodice"
		ls_sql_cond = "PDC.ID_PDC='"+ls_controllo+"'"
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "ccodice"
		ls_dwc[2] = "cdescrizione"
		ls_dwc[3] = "cid_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "cdescrizione"
		ls_sql_cond = "PDC.ID_PDC='"+ls_controllo+"'"
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "ccodice"
		ls_dwc[2] = "cdescrizione"
		ls_dwc[3] = "cid_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_reg_pdc"
end event

event ue_insert;call super::ue_insert;
if tab_1.tabpage_1.dw_2.rowcount()=1 then	uf_riempi_cdc(dw_1.getitemnumber(1,'id_cen_cos_t'))	
	


end event

event ue_update;if this.rowcount()>0 then
if this.getitemnumber(1,'sum') <> dw_1.getitemnumber(1,'valore') then
  if 	messagebox('Attenzione','La ripartizione è diversa dal valore totale della registrazione! Vuoi proseguire?',Information!,YesNo!)=2 then return 1  
end if
end if

Super::Event ue_update(wparam,lparam)


end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2382
int Height=516
long BackColor=80263581
string Text="Righe documento"
long TabBackColor=80263581
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_3 dw_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw_master_main within tabpage_2
int X=14
int Y=20
int Width=2345
int Height=480
int TabOrder=10
boolean BringToTop=true
string DataObject="d_riga_documento_cdc_gd"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2382
int Height=516
long BackColor=80263581
string Text="Contropartita"
long TabBackColor=80263581
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_4 dw_4
end type

on tabpage_3.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_3.destroy
destroy(this.dw_4)
end on

type dw_4 from u_dw_master_main within tabpage_3
int X=0
int Y=16
int Width=2368
int Height=492
int TabOrder=10
boolean BringToTop=true
string DataObject="d_mov_contabile_cdc_gd"
boolean VScrollBar=true
end type

type dw_1 from u_dw_master_main within w_reg_cdc_cx
int X=18
int Y=568
int Width=2432
int Height=464
int TabOrder=10
boolean BringToTop=true
string DataObject="d_reg_pd_cdc_ff"
boolean TitleBar=true
string Title="Movimento Centro di Costo"
boolean LiveScroll=false
end type

event ue_set_search;string ls_cond, ls_controllo
integer i


CHOOSE CASE as_nomecol
	CASE "codice", "descrizione"
		is_search_window = "w_cerca_cdc_sw"
		if tab_1.tabpage_3.dw_4.rowcount()>0 then 
			for i=1 to tab_1.tabpage_3.dw_4.rowcount()
			if isnull(ls_controllo) or ls_controllo='' then	
				ls_controllo='conto.id_conto='+string(tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto'))
			else	
				ls_controllo=ls_controllo +' or conto.id_conto='+ string(tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto'))
			end if	
			next	
			
			
			IS_RICPAR.S_SQL_COND=ls_controllo
			
		end if	

		IF as_nomecol = "codice" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "descrizione" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF


END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro
long ll_testa, ll_conto, i, ll_mov

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "codice"
		uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[2])
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_cen_cos_t", is_ricpar.s_id_seg_value[1])
		ll_conto=long(is_ricpar.s_main_value)
		if tab_1.tabpage_3.dw_4.rowcount()>0 then 
			for i=1 to tab_1.tabpage_3.dw_4.rowcount()
				if ll_conto=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto') then
					ll_mov=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')
					dw_1.setitem(1,'id_mov_contabile',ll_mov)
					tab_1.tabpage_3.dw_4.selectrow(i,true)
				end if
			next
		end if
		if tab_1.tabpage_1.dw_2.rowcount()>0 then
			tab_1.tabpage_1.dw_2.reset()
			tab_1.tabpage_1.dw_2.TriggerEvent("ue_insert")	
		end if	
		
		
	CASE "descrizione"
	 	uf_set_colval("id_conto", is_ricpar.s_main_value)
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("codice", is_ricpar.s_ausil_value[2])
		uf_set_colval("id_cen_cos_t", is_ricpar.s_id_seg_value[1])
		ll_conto=long(is_ricpar.s_main_value)
		if tab_1.tabpage_3.dw_4.rowcount()>0 then 
			for i=1 to tab_1.tabpage_3.dw_4.rowcount()
				if ll_conto=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto') then
					ll_mov=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')
					dw_1.setitem(1,'id_mov_contabile',ll_mov)
					tab_1.tabpage_3.dw_4.selectrow(i,true)
				end if
			next
		end if
		if tab_1.tabpage_1.dw_2.rowcount()>0 then
			tab_1.tabpage_1.dw_2.reset()
			tab_1.tabpage_1.dw_2.TriggerEvent("ue_insert")	
		end if	
		
		
END CHOOSE






end event

event itemchanged;string ls_filtro, ls_controllo
integer li_ok
integer i, li_test

string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_testa_cdc, ll_conto, ll_pdc, ll_mov

setnull(ls_null)
li_test=0

ls_controllo=""
if tab_1.tabpage_3.dw_4.rowcount()>0 then 
		for i=1 to tab_1.tabpage_3.dw_4.rowcount()
		li_test=1
		if isnull(ls_controllo) or ls_controllo='' then	
			ls_controllo='conto.id_conto='+string(tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto'))
		else	
			ls_controllo=ls_controllo +' or conto.id_conto='+ string(tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto'))
		end if	
	next		
end if




CHOOSE CASE dwo.name
		
	
		
	CASE "codice"
		ls_sql_cond = ls_controllo
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "descrizione"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			ll_conto=long(ls_dbv[3])
			if li_test=1 then 
				for i=1 to tab_1.tabpage_3.dw_4.rowcount()
					if ll_conto=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto') then
						ll_mov=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')
						dw_1.setitem(1,'id_mov_contabile',ll_mov)
						tab_1.tabpage_3.dw_4.selectrow(i,true)
					end if
				next
			end if			
			select id_cen_cos_t
			into :ll_testa_cdc
			from centro_costo_testa
			where id_conto=:ll_conto;
			dw_1.setitem(1,'id_cen_cos_t',ll_testa_cdc)
			if tab_1.tabpage_1.dw_2.rowcount()>0 then
			  tab_1.tabpage_1.dw_2.reset()
			  tab_1.tabpage_1.dw_2.TriggerEvent("ue_insert")	
		   end if	
			
			RETURN 2
		END IF
		
		
	case "descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		
		ls_dwc[1] = "codice"
		ls_dwc[2] = "descrizione"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			ll_conto=long(ls_dbv[3])
			if li_test=1 then 
				for i=1 to tab_1.tabpage_3.dw_4.rowcount()
					if ll_conto=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_conto') then
						ll_mov=tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')
						dw_1.setitem(1,'id_mov_contabile',ll_mov)
						tab_1.tabpage_3.dw_4.selectrow(i,true)
					end if
				next
			end if	
			select id_cen_cos_t
			into :ll_testa_cdc
			from centro_costo_testa
			where id_conto=:ll_conto;
			dw_1.setitem(1,'id_cen_cos_t',ll_testa_cdc)
			if tab_1.tabpage_1.dw_2.rowcount()>0 then
				tab_1.tabpage_1.dw_2.reset()
				tab_1.tabpage_1.dw_2.TriggerEvent("ue_insert")	
			end if	
			
			RETURN 2
		END IF
		
	CASE "valore"
		if tab_1.tabpage_1.dw_2.rowcount()>0 then
			tab_1.tabpage_1.dw_2.reset()
			tab_1.tabpage_1.dw_2.TriggerEvent("ue_insert")	
		end if
		
	case "segno"
		decimal ld_dare, ld_avere
		if tab_1.tabpage_1.dw_2.rowcount()>0 then
		for i=1 to tab_1.tabpage_1.dw_2.rowcount()
			ld_dare= tab_1.tabpage_1.dw_2.getitemdecimal(i,'dare')
			if isnull(ld_dare) then ld_dare=0
			ld_avere=tab_1.tabpage_1.dw_2.getitemdecimal(i,'avere')
			if isnull(ld_avere) then ld_avere=0
			tab_1.tabpage_1.dw_2.setitem(i,'dare',ld_avere)
			tab_1.tabpage_1.dw_2.setitem(i,'avere',ld_dare)
		next
		end if
		
end choose

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_reg_pdc"
iudw_children[1] = tab_1.tabpage_1.dw_2
end event

type cb_2 from commandbutton within w_reg_cdc_cx
int X=2354
int Y=28
int Width=87
int Height=72
int TabOrder=50
boolean BringToTop=true
string Text="<"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_6.rowcount()>1 then dw_6.visible=true
end event

type dw_5 from u_dw_master_main within w_reg_cdc_cx
int X=27
int Y=136
int Width=2414
int Height=424
int TabOrder=20
boolean BringToTop=true
string DataObject="d_reg_pd_ff_2"
end type

type cb_ass_reg from commandbutton within w_reg_cdc_cx
int X=1819
int Y=232
int Width=512
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Associa registrazione"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;w_search_main lw_sm
long ll_reg_pd, ll_imp , ll_seg, ll_null
s_ric_param ls_ricpar
setnull(ll_null)

idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "esercizio_codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_reg_pd_cdc_sw")

idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
    ll_reg_pd=long(idw_master.is_ricpar.s_id_seg_value[1])
    dw_5.retrieve(ll_reg_pd)
	 dw_1.setitem(1,'id_reg_pd',ll_reg_pd)
    tab_1.tabpage_3.dw_4.retrieve(ll_reg_pd)
	 tab_1.tabpage_3.visible=true
	 dw_1.setitem(1,'codice','')
	 dw_1.setitem(1,'descrizione','')
	 dw_1.setitem(1,'id_conto',ll_null)
	 ll_imp=dw_5.getitemnumber(1,'importo')
	 ll_seg=dw_5.getitemnumber(1,'segno')
	 
	 If not isnull(dw_5.getitemnumber(1,'importo')) then
	 	dw_1.setitem(1,'valore',ll_imp)
	 	dw_1.setitem(1,'segno',dw_5.getitemnumber(1,'segno'))
	 	dw_1.object.valore.protect=1
		
	 end if
end if

end event

type dw_6 from datawindow within w_reg_cdc_cx
int X=731
int Y=24
int Width=1595
int Height=652
int TabOrder=30
boolean Visible=false
string DataObject="d_conti_interessati_gd"
boolean TitleBar=true
string Title="Movimenti CDC associati alla registrazione"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;long ll_reg_pdc, ll_mov_contabile, i
if row>0 then
	dw_6.SelectRow ( 0, false )
	dw_6.SelectRow ( row, true )
	ll_reg_pdc=dw_6.getitemnumber(row,'id_reg_pdc')
	idw_master.is_list.s_identifica[1] = "id_reg_pdc"
	idw_master.is_list.l_identifica[1] = ll_reg_pdc
	SetPointer(HourGlass!)
	idw_master.Event ue_retrieve(0, 0)
	setPointer(Arrow!)
	ll_mov_contabile=dw_1.getitemnumber(1,'id_mov_contabile')	
	for i=1 to tab_1.tabpage_3.dw_4.rowcount()
		tab_1.tabpage_3.dw_4.SelectRow ( 0, false )
		if tab_1.tabpage_3.dw_4.getitemnumber(i,'id_mov_contabile')= ll_mov_contabile then tab_1.tabpage_3.dw_4.SelectRow ( i, true )
	next	
end if 
dw_6.visible=false
end event

