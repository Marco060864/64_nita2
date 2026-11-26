forward
global type w_sog_commerciale_cx from w_p_data
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_master_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from u_dw_master_main within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from u_dw_master_main within tabpage_4
end type
type dw_5 from u_dw_master_main within tabpage_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_6 from u_dw_master_main within tabpage_5
end type
type tabpage_6 from userobject within tab_1
end type
type cb_4 from commandbutton within tabpage_6
end type
type cb_1 from commandbutton within tabpage_6
end type
type cb_2 from commandbutton within tabpage_6
end type
type cb_3 from commandbutton within tabpage_6
end type
type dw_7 from u_dw_master_main within tabpage_6
end type
type cb_5 from commandbutton within tabpage_6
end type
type cb_provv from commandbutton within w_sog_commerciale_cx
end type
type cb_6 from commandbutton within w_sog_commerciale_cx
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
dw_5 dw_5
end type
type tabpage_5 from userobject within tab_1
dw_6 dw_6
end type
type tabpage_6 from userobject within tab_1
cb_4 cb_4
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_7 dw_7
cb_5 cb_5
end type
end forward

global type w_sog_commerciale_cx from w_p_data
int X=320
int Y=0
int Width=2967
int Height=1780
boolean TitleBar=true
string Title="a"
event ue_provvigioni ( )
cb_provv cb_provv
cb_6 cb_6
end type
global w_sog_commerciale_cx w_sog_commerciale_cx

type variables
string 		is_buffer_tipo, is_buffer_item
string 		is_title_modifica
boolean		ib_codice_cambiato
string		is_tipo

end variables

forward prototypes
public function long uf_trova_smastro_x_codice (string as_codice, string as_tipo, long al_id_conto)
public function long uf_aggiorna_conto (long al_id_conto, long al_id_sog_comm, long al_id_sottomastro, string as_codice, string as_tipo, string as_descrizione)
public function long wf_autofind_ragsoc (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_valori[], string as_dwcol[])
public function integer uf_ricerca ()
public function integer uf_retrieve_campi_calcolati ()
end prototypes

event ue_provvigioni;call super::ue_provvigioni;s_list_main			lstr_for_win
String				s_win_to_open
datawindow			ldw_curr
Long					ll_row, ll_id_gruppo_agenti

s_win_to_open = "w_scag_prov_sog_comm_cx"
ldw_curr = tab_1.tabpage_2.dw_2
ll_row = ldw_curr.GetRow()
lstr_for_win.s_modo = modo_modifica
lstr_for_win.s_identifica[1] = "id_gruppo_agenti"
lstr_for_win.s_identifica[2] = "id_sog_commerciale"
lstr_for_win.l_identifica[2] = ldw_curr.GetItemNumber(ll_row,  "id_sog_commerciale")
SELECT "sog_commerciale"."id_gruppo_agenti" 
	  	INTO :lstr_for_win.l_identifica[1]
     	FROM "sog_commerciale" 
	 	WHERE ( "sog_commerciale"."id_sog_commerciale"  = :lstr_for_win.l_identifica[2] );
ll_id_gruppo_agenti = lstr_for_win.l_identifica[1]
IF (IsNull(ll_id_gruppo_agenti)) THEN
	RETURN
END IF	
OpenWithParm(w_p_data, lstr_for_win, s_win_to_open)
end event

public function long uf_trova_smastro_x_codice (string as_codice, string as_tipo, long al_id_conto);

long 		ll_Id_Sottomastro, ll_conto
string 	ls_mastro, ls_sottomastro

if IsNull(al_id_conto) then
	
  SELECT Max("conto"."id_conto") INTO :ll_conto
   FROM "conto"  
   WHERE ( "conto"."codice" = :as_codice )  ;
else
	
  SELECT Max("conto"."id_conto") INTO :ll_conto
    FROM "conto"  
   WHERE ( "conto"."codice" = :as_codice ) AND  
         ( "conto"."id_conto" <> :al_id_conto )   ;

end if

if IsNull(ll_conto)  then
	ls_mastro= Mid(as_codice,1,2)
	ls_sottomastro=Mid(as_codice,3,2)
	 
	 if not(as_tipo='') then
		  SELECT "sottomastro"."id_sottomastro"  
			 INTO :ll_Id_Sottomastro  
			 FROM "mastro",   
					"sottomastro"  
			WHERE ( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
					( ( "mastro"."codice" = :ls_mastro ) AND  
					( "sottomastro"."codice" = :ls_sottomastro ) AND  
					( "sottomastro"."uso" = :as_Tipo ) )  ; 
	 else
		 SELECT "sottomastro"."id_sottomastro"  
			 INTO :ll_Id_Sottomastro  
			 FROM "mastro",   
					"sottomastro"  
			WHERE ( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
					( ( "mastro"."codice" = :ls_mastro ) AND  
					( "sottomastro"."codice" = :ls_sottomastro )) ;  
	 end if
end if
If SQLCA.SQLCode < 0 OR  SQLCA.SQLCode = 100 then SetNull(ll_Id_Sottomastro)
return ll_Id_Sottomastro
end function

public function long uf_aggiorna_conto (long al_id_conto, long al_id_sog_comm, long al_id_sottomastro, string as_codice, string as_tipo, string as_descrizione);
long ll_id_sog_comm, ll_Ret_Value

ll_Ret_Value= 0
  if IsNull(al_id_conto) then
		
    INSERT INTO "conto"  
					( "codice",   
					  "id_sottomastro",   
					  "descrizione",   
					  "ges_par_aperte")  
		  VALUES ( :as_codice,   
					  :al_id_sottomastro,   
					  :as_descrizione,   
					  'S')  ;
	  SELECT Max("conto"."id_conto" )
		 INTO :al_id_conto  
		 FROM "conto"  
		WHERE ( "conto"."codice" = :as_codice ) AND  
				( "conto"."id_sottomastro" = :al_id_sottomastro ) AND  
				( "conto"."descrizione" = :as_descrizione ) AND  
				( "conto"."ges_par_aperte" = 'S' )   ;

  else
		
    SELECT Max("sog_commerciale"."id_sog_commerciale"  )
			 INTO :ll_id_sog_comm  
			 FROM "sog_commerciale"  
			WHERE "sog_commerciale"."id_conto" = :al_id_conto   ;

	if SQLCA.SQLCode = 100 then
      
      UPDATE "conto"  
			  SET "codice" = :as_codice,   
					"id_sottomastro" = :al_id_sottomastro,   
					"descrizione" = :as_descrizione  
			WHERE "conto"."id_conto" = :al_id_conto   ;
    else
	al_id_conto=-1
    end if
  end if
  
  return al_id_conto

end function

public function long wf_autofind_ragsoc (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_valori[], string as_dwcol[]);

integer			li_size, li_counter
long				ll_retval
boolean			lb_ok
s_list_main		lstr_name

if idw_master.ib_during_f4 then
	return 0
else
	li_size = ai_ncol
	if isNull(as_valric) or as_valric = "" then
		
		
		
		
		for li_counter = 1 to li_size
			idw_master.uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
		next
		ll_retval = 0
		
	else
		
		
		
		lb_ok = idw_master.uf_autofind(as_tabella,as_campo,as_tiporic,as_valric,as_sql_add,ai_ncol,as_dbcampi,as_valori)
		if lb_ok then
			
			for li_counter = 1 to li_size
				idw_master.uf_set_colval(as_dwcol[li_counter],as_valori[li_counter])
			next
			ll_retval = 1
		else
			lstr_name.s_identifica[1] = as_valric
			OpenWithParm(w_anag_sempl_wz, lstr_name)
			lstr_name = Message.PowerObjectParm
			if lstr_name.l_identifica[1] > 0 then
				ll_retval = lstr_name.l_identifica[1]
				
				lb_ok = idw_master.uf_autofind(as_tabella,as_campo,as_tiporic,lstr_name.s_identifica[1],as_sql_add,ai_ncol,as_dbcampi,as_valori)
				if lb_ok then
					
					for li_counter = 1 to li_size
						idw_master.uf_set_colval(as_dwcol[li_counter],as_valori[li_counter])
					next
					ll_retval = 1
				else
					MessageBox("Avviso", "Problemi con autofind")
					ll_retval = 0
				end if
				
			else
				
				for li_counter = 1 to li_size
					idw_master.uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
				next
				
				idw_master.post event ue_setcolumn (as_dwoname)
				if lstr_name.l_identifica[1] = -1 then
					
					idw_master.post event ue_key (KeyF4!,0)
				end if
				ll_retval = 0
			end if
		end if
		
	end if
	return ll_retval
end if

end function

public function integer uf_ricerca ();
w_search_main 	lw_sm
string 			ls_filtro, ls_registro, ls_sog_commerciale_tipo, ls_sog_commerciale_codice
string 			ls_rag_sociale
s_ric_param		ls_ric_param	
date				ld_data
integer			li_risposta, li_retvalue
long				ll_id_sog_commerciale, ll_row
u_dw_master_main		ldw_gen


ldw_gen=Tab_1.tabpage_1.dw_1
ll_row= ldw_gen.GetRow()
If ldw_gen.AcceptText() > 0 AND ll_row>0 then
	If ib_codice_cambiato then
		ls_sog_commerciale_codice= ldw_gen.GetItemString(ll_row,"sog_commerciale_codice")
		If not (IsNull(ls_sog_commerciale_codice) OR ls_sog_commerciale_codice ="") then
			idw_master.is_ricpar.s_filter_value= ls_sog_commerciale_codice
			idw_master.is_ricpar.s_filter_name="codice"
		else
			ls_rag_sociale= ldw_gen.GetItemString(ll_row,"anagrafica_rag_soc_1")
			idw_master.is_ricpar.s_filter_value= ls_rag_sociale
			idw_master.is_ricpar.s_filter_name="rag_soc_1"
		end if
	else
		ls_sog_commerciale_tipo= ldw_gen.GetItemString(ll_row,"sog_commerciale_tipo")
		If not (IsNull(ls_sog_commerciale_tipo) OR ls_sog_commerciale_tipo ="") then
			idw_master.is_ricpar.s_filter_value= ls_sog_commerciale_tipo
			idw_master.is_ricpar.s_filter_name= "tipo"
		else
			ls_rag_sociale= ldw_gen.GetItemString(ll_row,"anagrafica_rag_soc_1")
			idw_master.is_ricpar.s_filter_value= ls_rag_sociale
			idw_master.is_ricpar.s_filter_name="rag_soc_1"
		end if
	end if
	
	idw_master.is_ricpar.s_SQL_cond = ls_filtro
	idw_master.is_ricpar.b_asneeded= TRUE
	OpenWithParm(lw_sm, idw_master.is_ricpar, "w_sog_commerciale_gen_coddes_sw")
	
	ls_ric_param= Message.PowerObjectParm
	if not IsNull(ls_ric_param) then 
		idw_master.is_ricpar=ls_ric_param
		IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
			
			if idw_master.uf_to_update() > 0 then
				li_risposta = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
					"finestra.~n~rVuoi salvarle?", Question!, YesNo!,1)
				CHOOSE CASE li_risposta
					CASE 1
						
						li_retvalue=idw_master.event ue_update (0,0)
					CASE 2
						
						li_retvalue=0
				END CHOOSE
			end if
			If li_retvalue=0 then
				ll_id_sog_commerciale = long(idw_master.is_ricpar.s_id_seg_value[1])
				idw_master.is_list.s_modo = modo_modifica
				idw_master.is_list.s_identifica[1] = "id_sog_commerciale"
				idw_master.is_list.l_identifica[1] = ll_id_sog_commerciale
				SetPointer(HourGlass!)
				
				this.enabled= FALSE
				SetNull(is_buffer_tipo)
				SetNull(is_buffer_item)
				SetNull(is_tipo)
				idw_master.Event ue_retrieve(0, 0)
				uf_retrieve_campi_calcolati()
				this.enabled= TRUE
				SetPointer(Arrow!)
				
			end if
		END IF
	END IF
END IF
RETURN 0

end function

public function integer uf_retrieve_campi_calcolati ();long 			ll_id_sog_commerciale
long			ll_id_magazzino
long			ll_id_pagamento
long			ll_id_banca
long			ll_banca_appoggio
long			ll_vettore
long			ll_Row
string 		ls_codice_magazzino,ls_descrizione_magazzino
string 		ls_codice_pagamento,ls_descrizione_pagamento
string 		ls_den_abi,ls_den_cab
string		ls_conto_corrente,ls_cin
string 		ls_codice_vettore,ls_descrizione_vettore

				
ll_Row = this.tab_1.tabpage_1.dw_1.GetRow()
if IsNull(ll_Row) or ll_Row = 0 then
	ll_Row = this.tab_1.tabpage_1.dw_1.RowCount()
end if	

ll_id_sog_commerciale 	= this.tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,"id_sog_commerciale")
ll_id_magazzino			= this.tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,"sog_commerciale_id_magazzino")
ll_id_pagamento			= this.tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,"sog_commerciale_id_con_pagamento")
ll_id_banca					= this.tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,"sog_commerciale_id_banca_sog_commerciale")	
ll_vettore					= this.tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,"sog_commerciale_id_sog_com_vettore")
select "magazzino"."codice" , "magazzino"."descrizione" 
	into : ls_codice_magazzino,:ls_descrizione_magazzino
	from "dba"."magazzino"
	where ( "magazzino"."id_magazzino" = :ll_id_magazzino );
	
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"cc_magazzino_cod",ls_codice_magazzino )
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"cc_magazzino_des",ls_descrizione_magazzino )

select "con_pagamento"."codice" , "con_pagamento"."descrizione" 
	into : ls_codice_pagamento,:ls_descrizione_pagamento
	from "dba"."con_pagamento"
	where ( "con_pagamento"."id_con_pagamento" = :ll_id_pagamento );
	
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"id_con_pagamento_cod",ls_codice_pagamento )
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"id_con_pagamento_des",ls_descrizione_pagamento )

select "banca_sog_commerciale"."id_banca_appoggio" , "banca_sog_commerciale"."conto_corrente" ,"banca_sog_commerciale"."cin" 
	into : ll_banca_appoggio,:ls_conto_corrente,:ls_cin
	from "dba"."banca_sog_commerciale"
	where ( "banca_sog_commerciale"."id_banca_sog_commerciale" = :ll_id_banca );

select "banca_appoggio"."den_abi","banca_appoggio"."den_cab"
	into :ls_den_abi,:ls_den_cab
	from "dba"."banca_appoggio"
	where ( "banca_appoggio"."id_banca_appoggio" = :ll_banca_appoggio );
	
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"cc_abi_cab_des", ls_den_abi + " - " + ls_den_cab )
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"cc_conto_corrente", ls_conto_corrente )
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"cc_cin", ls_cin )

select "sog_commerciale_gen"."codice" ,"sog_commerciale_gen"."rag_soc_1"
	into : ls_codice_vettore,:ls_descrizione_vettore
	from "dba"."sog_commerciale_gen"
	where ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_vettore );

this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"cc_vettore_cod", ls_codice_vettore )
this.tab_1.tabpage_2.dw_2.SetItem( ll_row,"cc_vettore_des", ls_descrizione_vettore )
string ls_cod,ls_mastro,ls_sottomastro
long ll_id_sottomastro
ls_cod=tab_1.tabpage_1.dw_1.getitemstring(1,"sog_commerciale_codice")
ls_mastro=mid(ls_cod,1,2)
ls_cod=right(ls_cod,6)
ls_sottomastro=mid(ls_cod,1,2)
select id_sottomastro
into :ll_id_sottomastro
from mastro,sottomastro
where mastro.codice=:ls_mastro
and mastro.id_mastro=sottomastro.id_mastro
and sottomastro.codice=:ls_sottomastro;
if sqlca.sqlcode=0 then
	tab_1.tabpage_1.dw_1.setitem(1,"csm",ll_id_sottomastro)
else
	long ll_null
	setnull(ll_null)
	tab_1.tabpage_1.dw_1.setitem(1,"csm",ll_null)
end if



return 0
end function

on w_sog_commerciale_cx.create
int iCurrent
call super::create
this.cb_provv=create cb_provv
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_provv
this.Control[iCurrent+2]=this.cb_6
end on

on w_sog_commerciale_cx.destroy
call super::destroy
destroy(this.cb_provv)
destroy(this.cb_6)
end on

event open;call super::open;

string ls_tipo

idw_master = tab_1.tabpage_1.dw_1
idw_master.is_list = Message.PowerObjectParm
is_tipo= idw_master.is_list.s_win_parametri
choose case is_tipo
	case "C"
		il_HelpTopic = 13
	case "F"
		il_HelpTopic = 14
	case "A"	
		il_HelpTopic = 15
		Tab_1.TabPage_6.Visible = TRUE
	case "V"	
		il_HelpTopic = 16
	case "P"
		il_HelpTopic = 17
	case else	
		il_HelpTopic = 555
end choose		

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "sog_commerciale.id_sog_commerciale"

If Upperbound(idw_master.is_list.s_identifica) = 0 then
	idw_master.is_list.s_modo= modo_inserisci
end if

ib_nonmodale = TRUE


end event

event ue_post_open;call super::ue_post_open;STRING ls_a,ls_b,ls_c,ls_d,ls_e,ls_f,ls_prval
long ll_filtro,q
SELECT par_sistema.pref_cod_cliente, par_sistema.pref_cod_fornitore,
	 par_sistema.pref_cod_agente, par_sistema.pref_cod_vettore,
	 par_sistema.pref_cod_cliente_potenziale, par_sistema.pref_cod_altro
INTO :ls_a, :ls_b, :ls_c, :ls_d, :ls_e, :ls_f
FROM par_sistema
WHERE par_sistema.id_azienda = 1
USING SQLCA;
if SQLCA.SQLCode = 0 then
string ls_cod
ls_cod=tab_1.tabpage_1.dw_1.getitemstring(1,"sog_commerciale_tipo")
CHOOSE CASE ls_cod
	case "C"
		ls_prval = ls_a
	case "F"
		ls_prval = ls_b
	case "A"
		ls_prval = ls_c
	case "V"
		ls_prval = ls_d
	case "P"
		ls_prval = ls_e
	case "Z"
		ls_prval = ls_f
END CHOOSE
select id_mastro
into :ll_filtro
from mastro
where codice=:ls_prval;
datawindowchild ldwc_dddw
tab_1.tabpage_1.dw_1.GetChild('csm',ldwc_dddw )
ldwc_dddw.setfilter("sottomastro_id_mastro="+string(ll_filtro))
ldwc_dddw.filter()

end if



IF (UpperBound(idw_master.is_list.s_par_name) < 1) THEN
	RETURN
END IF
IF NOT (idw_master.is_list.s_par_name[1] = "id_anagrafica") THEN
	RETURN
ELSE
	idw_master.Modify("anagrafica_rag_soc_1.Background.Mode = 1 ")
	idw_master.Modify("anagrafica_rag_soc_1.Protect = 1 ")
END IF





end event

event ue_master_delete;call super::ue_master_delete;if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false
	if (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()

end event

type p_crescente from w_p_data`p_crescente within w_sog_commerciale_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_sog_commerciale_cx
int X=50
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_sog_commerciale_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_sog_commerciale_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_sog_commerciale_cx
int X=640
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;
end event

type cb_inserisci from w_p_data`cb_inserisci within w_sog_commerciale_cx
int X=2048
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_sog_commerciale_cx
int X=2341
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_sog_commerciale_cx
int X=2661
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_sog_commerciale_cx
int X=14
int Width=2912
int Height=1520
int TabOrder=40
boolean BringToTop=true
Alignment Alignment=Center!
long BackColor=79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_5
this.Control[iCurrent+5]=this.tabpage_6
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event tab_1::selectionchanging;call super::selectionchanging; dwItemStatus l_status

 
 l_status = tab_1.tabpage_2.dw_2.GetItemStatus(tab_1.tabpage_2.dw_2.GetRow(), 0, Primary!)
 IF (l_status = New! OR l_status = NewModified!) THEN 
		RETURN
 END IF		
 IF (newindex = 2) THEN
		Parent.cb_provv.Visible = TRUE
      Parent.cb_provv.Enabled = FALSE
 ELSE	
		Parent.cb_provv.Visible = FALSE
      Parent.cb_provv.Enabled = FALSE
 END IF

 

long ll_row , ll_banca_id , ll_banca_app
integer li_giorni_f
If NewIndex = 6 THEN
	ll_row = Tab_1.TabPage_2.dw_2.GetRow()
	ll_banca_id = Tab_1.TabPage_2.dw_2.GetItemNumber &
		(ll_row,'sog_commerciale_id_banca_sog_commerciale')
	
	SELECT id_banca_appoggio
	INTO :ll_banca_app
	FROM banca_sog_commerciale
	WHERE id_banca_sog_commerciale = :ll_banca_id;
	
	SELECT giorni_franchigia
	INTO :li_giorni_f
	FROM banca_appoggio
	WHERE id_banca_appoggio=:ll_banca_app;
	
	ll_row = Tab_1.TabPage_6.dw_7.GetRow()
	ll_banca_id = Tab_1.TabPage_6.dw_7.GetItemNumber(ll_row,'sog_commerciale_giorni_franchigia')
	
	IF ll_banca_id <= 0 or isnull(ll_banca_id) THEN
		Tab_1.TabPage_6.dw_7.SetItem(ll_row,'sog_commerciale_giorni_franchigia',li_giorni_f)
	END If
integer li_valuta

SELECT id_valuta
INTO :li_valuta
FROM par_sistema;

ll_row = Tab_1.TabPage_6.dw_7.GetRow()
Tab_1.TabPage_6.dw_7.SetItem(ll_row,'cid_valuta',li_valuta)


END IF
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2875
int Height=1400
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_sog_commerciale_cx
int X=1723
int Width=302
int TabOrder=10
boolean BringToTop=true
string Text="&Ricerca ..."
end type

event cb_ricerca::clicked;call super::clicked;
uf_ricerca()
STRING ls_a,ls_b,ls_c,ls_d,ls_e,ls_f,ls_prval
long ll_filtro,q
SELECT par_sistema.pref_cod_cliente, par_sistema.pref_cod_fornitore,
	 par_sistema.pref_cod_agente, par_sistema.pref_cod_vettore,
	 par_sistema.pref_cod_cliente_potenziale, par_sistema.pref_cod_altro
INTO :ls_a, :ls_b, :ls_c, :ls_d, :ls_e, :ls_f
FROM par_sistema
WHERE par_sistema.id_azienda = 1
USING SQLCA;
if SQLCA.SQLCode = 0 then
string ls_cod
ls_cod=tab_1.tabpage_1.dw_1.getitemstring(1,"sog_commerciale_tipo")
CHOOSE CASE ls_cod
	case "C"
		ls_prval = ls_a
	case "F"
		ls_prval = ls_b
	case "A"
		ls_prval = ls_c
	case "V"
		ls_prval = ls_d
	case "P"
		ls_prval = ls_e
	case "Z"
		ls_prval = ls_f
END CHOOSE
select id_mastro
into :ll_filtro
from mastro
where codice=:ls_prval;
datawindowchild ldwc_dddw
tab_1.tabpage_1.dw_1.GetChild('csm',ldwc_dddw )
ldwc_dddw.setfilter("sottomastro_id_mastro="+string(ll_filtro))
ldwc_dddw.filter()

end if

cb_6.enabled=true


String ls_tipo
Long ll_row

ll_row = Tab_1.TabPage_1.dw_1.GetRow()
ls_tipo = Tab_1.TabPage_1.dw_1.GetItemString(ll_row,'sog_commerciale_tipo')
IF ls_tipo = 'A' THEN
	Tab_1.TabPage_6.Visible = TRUE
ELSE
	Tab_1.TabPage_6.Visible = FALSE
END IF

end event

type dw_1 from u_dw_master_main within tabpage_1
event ue_put_info ( )
event type string ue_crea_cod_sc ( string as_codice )
event ue_set_cc_conto_presente ( string as_tipo )
event type integer ue_convalida_cod ( string as_codice )
event type string ue_crea_titolo_finestra ( string as_codice,  string as_rag_soc_1,  string as_tipo )
event ue_setta_testata ( )
event ue_reset ( )
int X=41
int Y=32
int Width=2770
int Height=1320
int TabOrder=3
boolean BringToTop=true
string DataObject="d_sog_commerciale_gen_ff"
end type

event ue_put_info;call super::ue_put_info;

long 		ll_row, ll_id_anagrafica
string	ls_info

ll_row = GetRow()
ll_id_anagrafica = GetItemNumber(ll_row, "sog_commerciale_id_anagrafica")
ls_info = f_info_anagra(ll_id_anagrafica)
SetItem(ll_row, "cinfo", ls_info)
end event

event ue_crea_cod_sc;call super::ue_crea_cod_sc;

string		ls_a, ls_b, ls_c, ls_d, ls_e, ls_f, ls_prval, ls_lastcode, ls_new1, &
				ls_value, ls_cod_sc, ls_rag_soc_1
integer		li_prlen
long			ll_value, ll_row


If len(as_codice) = 0 then
	
	SELECT par_sistema.pref_cod_cliente, par_sistema.pref_cod_fornitore,
			 par_sistema.pref_cod_agente, par_sistema.pref_cod_vettore,
			 par_sistema.pref_cod_cliente_potenziale, par_sistema.pref_cod_altro
	INTO :ls_a, :ls_b, :ls_c, :ls_d, :ls_e, :ls_f
	FROM par_sistema
	WHERE par_sistema.id_azienda = 1
	USING SQLCA;
	
	if SQLCA.SQLCode = 0 then
		
		CHOOSE CASE is_tipo
			case "C"
				ls_prval = ls_a
			case "F"
				ls_prval = ls_b
			case "A"
				ls_prval = ls_c
			case "V"
				ls_prval = ls_d
			case "P"
				ls_prval = ls_e
			case "Z"
				ls_prval = ls_f
		END CHOOSE
		
		long ll_id
		string ls_sm
		ll_id=this.getitemnumber(1,'csm')
		select codice
		into :ls_sm
		from sottomastro
		where id_sottomastro=:ll_id;
		ls_prval=ls_prval+ls_sm
		
	else
		
		
		MessageBox("Attenzione", "Problemi con tabella 'Parametri di Sistema'", Information!)
		Return "NO!"
	end if
else
	ls_prval = as_codice
end if
if not isnull(ls_prval) then li_prlen = len(ls_prval) else li_prlen = 0
SELECT max(sog_commerciale.codice)
	INTO :ls_lastcode
	FROM sog_commerciale
	WHERE left (sog_commerciale.codice,:li_prlen) = :ls_prval AND Substr (sog_commerciale.codice , 5, 4) <= '9999'
	USING SQLCA;

if (isnull(ls_lastcode)) or (ls_lastcode="") then
	ls_lastcode = ls_prval+"00000000"
end if
ls_new1 = mid(ls_lastcode,(li_prlen+1),(8 - li_prlen))
if isnumber(ls_new1) then
	ll_value = long (ls_new1)+1
	ls_value = string(ll_value)
	if len(ls_value) > (8 - li_prlen) then
	
		ls_value = ""
		MessageBox(is_title ,"Impossibile assegnare automaticamente un codice:~r" + &
		"è presente il codice " + ls_prval + "9999", Information!)
	else
	
		ls_value = ls_prval + f_lpad(ls_value,'0',(8 - li_prlen))
		uf_set_colval("",ls_value) 
	end if
else
	ls_value = ""
end if
if is_tipo = "C" OR is_tipo = "F" then
	if f_valida_pre_codice(ls_prval, is_tipo) < 0 then ls_value= ""
end if
uf_set_colval("sog_commerciale_codice",ls_value) 

ll_row = GetRow()
ls_cod_sc = GetItemString(ll_Row, "sog_commerciale_codice")
ls_rag_soc_1 = GetItemString(ll_Row, "anagrafica_rag_soc_1")
Event ue_crea_titolo_finestra(ls_cod_sc, ls_rag_soc_1, is_tipo)

Return ls_value
end event

event ue_set_cc_conto_presente;call super::ue_set_cc_conto_presente;
long	ll_row

ll_row = GetRow()

if (as_tipo = "C") or (as_tipo = "F") then
	this.SetItem(ll_row, "cc_conto_presente", "S")
else
	this.SetItem(ll_row, "cc_conto_presente", "N")
end if

end event

event ue_convalida_cod;call super::ue_convalida_cod;

long 		ll_return = 0, ll_row, ll_sottomastro, ll_codice, ll_id_sc, ll_id_sog_conto
string	ls_tipo, ls_codice

ll_row = GetRow()
ls_tipo= GetItemString(ll_row, "sog_commerciale_tipo")
ll_id_sog_conto = GetItemNumber(ll_row, "sog_commerciale_id_conto")
ll_id_sc = GetItemNumber(ll_row, "id_sog_commerciale")

If Len(as_codice) <> 8 And Len(as_codice) <> 4 then
	
	MessageBox("Convalida del Codice","Codice non valido.~rImmettere un codice di 4 o 8 caratteri.", Exclamation!)
	ll_return = -1
end if

if ll_return >= 0 then
	ll_sottomastro = f_controlla_conto(as_codice, 1)
	CHOOSE CASE ll_sottomastro
		CASE -100
			if ls_tipo = "C" OR ls_tipo = "F" then
				MessageBox("Convalida del Codice / Sottomastro","Il Mastro e il Sottomastro devono esistere nel Piano dei Conti.", Exclamation!)
				ll_return = -1
			else
				
				if GetItemString(ll_row, "cc_conto_presente") = "S" then
					MessageBox("Convalida del Codice / Sottomastro","Il Sottomastro " + Mid(as_codice,3,2) + "NON esiste nel Piano dei Conti." + &
							"~rSe si vuole procedere bisogna prima crearlo.", Exclamation!)
					ll_return = -1
				end if
			end if
		CASE -1
			MessageBox("Convalida del Codice / Sottomastro","Errore di accesso al database.", Exclamation!)
			ll_return = -1
		CASE -2
			MessageBox("Convalida del Codice / Sottomastro","Codice non valido.", Exclamation!)
			ll_return = -1
		CASE 0
			ll_return = -1	
	END CHOOSE
end if

if ll_return = 0 then
	If ls_tipo = "C" OR ls_tipo = "F" then 
		
		If f_valida_pre_codice(as_codice, ls_tipo) < 0 then
			
			MessageBox("Convalida del Codice / Sottomastro / Uso","Codice non valido.~rIl Sottomastro suggerito non ha un utilizzo giusto.", Exclamation!)
			ll_return = -1
		else
			
			If f_esiste_conto(as_codice, ll_id_sog_conto) > 0 then
				MessageBox("Convalida del Codice / Sottomastro / Uso","Codice non valido.~rIl Conto proposto esiste nel P.D.C.", Exclamation!)
				ll_return = -1
			end if
		end if
	else
		
		if ls_tipo = "A" Or ls_tipo = "V" then
			If f_valida_pre_codice(as_codice, "G") < 0 then
				MessageBox("Convalida del Codice / Sottomastro / Uso","Codice non valido.~rIl Sottomastro suggerito non ha un utilizzo giusto.", Exclamation!)
				ll_return = -1
			else
				
				If f_esiste_conto(as_codice, ll_id_sog_conto) > 0 then
					MessageBox("Convalida del Codice / Sottomastro / Uso","Codice non valido - eiste già uno uguale.~rIl Conto proposto esiste nel P.D.C.", Exclamation!)
					ll_return = -1
				end if
			end if
		else
			
			
			SELECT "dba"."sog_commerciale"."codice"  
			 INTO :ls_codice  
			 FROM "dba"."sog_commerciale"
			 WHERE "dba"."sog_commerciale"."codice" = :as_codice ;
			if Not IsNull(ls_codice) And ls_codice <> "" then
				MessageBox("Convalida del Codice - doppio","Codice già esistente.", Exclamation!)
				ll_return = -1
			end if
		end if
	end if
end if

Return ll_return
end event

event ue_crea_titolo_finestra;call super::ue_crea_titolo_finestra;

long		ll_row
string	ls_title
window 	lw_parent
tab    	lw_tab

if IsNull(as_rag_soc_1) And IsNull(as_codice) then
	ls_title = " "
elseif IsNull(as_codice) then
		ls_title = as_rag_soc_1
elseif IsNull(as_rag_soc_1) then
	ls_title = as_codice
else
	ls_title = as_codice + " - " + as_rag_soc_1
end if

ll_row = GetRow()
if IsNull(as_tipo) Or as_tipo = "" then
	
	as_tipo = is_list.s_win_parametri
end if
CHOOSE CASE as_tipo
	CASE "C"
		is_title = "Cliente"
	CASE "F"
		is_title = "Fornitore"
	CASE "A"
		is_title = "Agente"
	CASE "V"
		is_title = "Vettore"
	CASE "P"
		is_title = "Cliente Potenziale"
	CASE "Z", ""
		is_title = "Altro"
END CHOOSE
is_title_modifica = "Gestione " + is_title
lw_tab = Parent.GetParent()
lw_parent = lw_tab.GetParent()
lw_parent.Title = is_title_modifica + " " + ls_title

Return is_title_modifica + " " + ls_title
end event

event ue_setta_testata;call super::ue_setta_testata;long 				ll_CurrRow
string 			ls_title, ls_codice, ls_rag_soc_1, ls_tipo
window 			lw_parent
tab    			lw_tab

ll_CurrRow = GetRow()
ls_tipo = is_list.s_win_parametri
if IsNull(ls_tipo) Or ls_tipo = "" then
	
	ls_tipo = GetItemString(ll_CurrRow, "sog_commerciale_tipo")
end if

ls_codice = GetItemString(ll_CurrRow, "sog_commerciale_codice")
IF (ll_CurrRow > 0) THEN
	
	Post Event ue_put_info()
	
	if ls_tipo = "C" OR ls_tipo = "F" then
		f_displayonly(dw_1, "sog_commerciale_tipo", True)
		f_displayonly(dw_1, "sog_commerciale_codice", True)
	else
		
		if f_esiste_conto(ls_codice, GetItemNumber(ll_CurrRow, "sog_commerciale_id_conto")) > 0 then
			f_displayonly(dw_1, "sog_commerciale_codice", True)
		end if
	end if
	
	ls_rag_soc_1 = GetItemString(ll_CurrRow, "anagrafica_rag_soc_1")
	Event ue_crea_titolo_finestra(ls_codice, ls_rag_soc_1, ls_tipo)
END IF
end event

event ue_reset;call super::ue_reset;
integer 			li_size, li_counter
long 				ll_row
datawindow		ldw_item

SetNull(is_buffer_tipo)
SetNull(is_buffer_item)
SetNull(is_tipo)
f_displayonly(this, "sog_commerciale_tipo", FALSE)
f_displayonly(this, "sog_commerciale_codice", FALSE)
li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.Reset()
next
end event

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_sog_commerciale"
iudw_children[1] = tab_1.tabpage_2.dw_2
iudw_children[2] = tab_1.tabpage_3.dw_3
iudw_children[3] = tab_1.tabpage_4.dw_4
iudw_children[4] = tab_1.tabpage_4.dw_5
iudw_children[5] = tab_1.tabpage_5.dw_6

iudw_children[6] = tab_1.tabpage_6.dw_7


end event

event itemchanged;
	 
string    		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      		ll_return, ll_ok, ll_row, ll_id_sc, ll_id_conto, ll_sottomastro, &
					ll_id_conto_sc, ll_id_anagrafica
string 	 		ls_title, ls_comm_codice, ls_rag_soc_1, ls_tipo, ls_codice, ls_cod_sc
dwItemStatus	ls_status
STRING ls_a,ls_b,ls_c,ls_d,ls_e,ls_f,ls_prval
				long ll_filtro,q
string ls_cod1, ls_desc1 

ls_sql_cond = ""  
ll_row = GetRow()
ls_status = THIS.GetItemStatus(ll_row, 0, Primary!)
ll_id_sc = GetItemNumber(ll_row, "id_sog_commerciale")

CHOOSE CASE dwo.name		
	CASE 'csm'
		
		
		
		
		
		dw_1.accepttext()
 	   SELECT "dba"."sog_commerciale"."tipo", "dba"."sog_commerciale"."codice"  
			 INTO :ls_tipo, :ls_cod_sc  
			 FROM "dba"."sog_commerciale"
			 WHERE "dba"."sog_commerciale"."id_sog_commerciale" = :ll_id_sc ;
		ls_rag_soc_1 = GetItemString(ll_row, "anagrafica_rag_soc_1")
		if ls_status <> NewModified! And ls_status <> New! And ls_tipo <> 'Z' then
			
			if ls_tipo = 'P' then
				
				if data <> 'C' then
					
					if data = "P" then
						
						
						Post SetItem(ll_row, "sog_commerciale_codice", ls_cod_sc)
						Event ue_crea_titolo_finestra(ls_cod_sc, ls_rag_soc_1, "P")
					else
						MessageBox("Attenzione!", "Un Cliente Potenziale può essere modificato solo in un Cliente!")
					end if
					ll_return = -1
				else
					
					is_tipo = "C"
					ls_comm_codice = Event ue_crea_cod_sc("")
					Event ue_set_cc_conto_presente("C")
				end if
			else
				
				MessageBox("Attenzione", "Impossibile cambiare il tipo per questo soggetto commerciale.")
				ll_return = -1
			end if
		else
			
			
			if data = "Z" AND ls_tipo = "Z" then
				
				Post SetItem(ll_row, "sog_commerciale_codice", ls_cod_sc)
				Event ue_set_cc_conto_presente("Z")
				Event ue_crea_titolo_finestra(ls_cod_sc, ls_rag_soc_1, "Z")
			else
				is_tipo =dw_1.getitemstring(1,'sog_commerciale_tipo') 
				ls_comm_codice = Event ue_crea_cod_sc("")
				Event ue_set_cc_conto_presente(is_tipo)
			end if
		end if
		
		
		
		if ll_return < 0 then
			if Not IsNull(ls_tipo) then
				Post SetItem(ll_row, "sog_commerciale_tipo", ls_tipo)
				Post SetItem(ll_row, "sog_commerciale_codice", ls_cod_sc)
			else
				Post SetItem(ll_row, "sog_commerciale_tipo", data)
			end if
			Return 0
		end if
		
	CASE 'sog_commerciale_codice'
		
		
		
		SELECT "dba"."sog_commerciale"."codice", "dba"."sog_commerciale"."tipo"
			 INTO :ls_codice, :ls_tipo
			 FROM "dba"."sog_commerciale"
			 WHERE "dba"."sog_commerciale"."id_sog_commerciale" = :ll_id_sc ;
		if IsNull(ls_codice) then ls_codice = data
		
		
		ls_cod_sc = GetItemString(ll_row, "sog_commerciale_codice")
		ll_id_conto_sc = GetItemNumber(ll_row, "sog_commerciale_id_conto")
		ll_id_conto = f_esiste_conto(ls_cod_sc, ll_id_conto_sc)
		if ll_id_conto < 0 then
			
			if Event ue_convalida_cod(data) < 0 then
				
				ll_return = -1
			else
				if len(data) = 4 then
					Post Event ue_crea_cod_sc(data)
				end if
				
			end if
		else
			
			MessageBox("Attenzione", "Impossibile cambiare un codice abbinato ad un conto.")
			ll_return = -1
		end if
		
		if ll_return < 0 then
			
			if (IsNull(ls_tipo) Or ls_tipo = "") then
				ls_tipo = GetItemString(ll_row, "sog_commerciale_tipo")
			end if
			Post SetItem(ll_row, "sog_commerciale_tipo", ls_tipo)
			
			if (IsNull(ls_codice) Or ls_codice = "") then ls_codice = ls_cod_sc
			Post SetItem(ll_row, "sog_commerciale_codice", ls_codice)
			RETURN 0
		end if
	CASE 'sog_commerciale_tipo'
		
				
		SELECT par_sistema.pref_cod_cliente, par_sistema.pref_cod_fornitore,
			 par_sistema.pref_cod_agente, par_sistema.pref_cod_vettore,
			 par_sistema.pref_cod_cliente_potenziale, par_sistema.pref_cod_altro
		INTO :ls_a, :ls_b, :ls_c, :ls_d, :ls_e, :ls_f
		FROM par_sistema
		WHERE par_sistema.id_azienda = 1
		USING SQLCA;
		
		if SQLCA.SQLCode = 0 then
			
			string ls_cod			
			ls_cod=data
			CHOOSE CASE ls_cod
				case "C"
					ls_prval = ls_a
				case "F"
					ls_prval = ls_b
				case "A"
					ls_prval = ls_c
				case "V"
					ls_prval = ls_d
				case "P"
					ls_prval = ls_e
				case "Z"
					ls_prval = ls_f
			END CHOOSE
			select id_mastro
			into :ll_filtro
			from mastro
			where codice=:ls_prval;
			datawindowchild ldwc_dddw
			dw_1.GetChild('csm',ldwc_dddw )
			ldwc_dddw.setfilter("sottomastro_id_mastro="+string(ll_filtro))
			ldwc_dddw.filter()
			setnull(q)
			ls_prval=""
			dw_1.setitem(1,"csm",q)
			dw_1.setitem(1,"sog_commerciale_codice",ls_prval)
		end if

		
		if data='A' then
			tab_1.tabpage_6.visible=true
		else
			tab_1.tabpage_6.visible=false
		end if
		setnull(q)
		ls_prval=""
		dw_1.setitem(1,"csm",q)
		dw_1.setitem(1,"sog_commerciale_codice",ls_prval)
		string ls_cl,ls_fo
		select pref_cod_cliente,pref_cod_fornitore
		into :ls_cl,:ls_fo
		from par_sistema;
		if string(data)<>ls_cl and string(data)<>ls_fo then
			dw_1.accepttext()
			SELECT "dba"."sog_commerciale"."tipo", "dba"."sog_commerciale"."codice"  
				 INTO :ls_tipo, :ls_cod_sc  
				 FROM "dba"."sog_commerciale"
				 WHERE "dba"."sog_commerciale"."id_sog_commerciale" = :ll_id_sc ;
			ls_rag_soc_1 = GetItemString(ll_row, "anagrafica_rag_soc_1")
			if ls_status <> NewModified! And ls_status <> New! And ls_tipo <> 'Z' then
				
				if ls_tipo = 'P' then
					
					if data <> 'C' then
						
						if data = "P" then
							
							
							Post SetItem(ll_row, "sog_commerciale_codice", ls_cod_sc)
							Event ue_crea_titolo_finestra(ls_cod_sc, ls_rag_soc_1, "P")
						else
							MessageBox("Attenzione!", "Un Cliente Potenziale può essere modificato solo in un Cliente!")
						end if
						ll_return = -1
					else
						
						is_tipo = "C"
						ls_comm_codice = Event ue_crea_cod_sc("")
						Event ue_set_cc_conto_presente("C")
					end if
				else
					
					MessageBox("Attenzione", "Impossibile cambiare il tipo per questo soggetto commerciale.")
					ll_return = -1
				end if
			else
				
				
				if data = "Z" AND ls_tipo = "Z" then
					
					Post SetItem(ll_row, "sog_commerciale_codice", ls_cod_sc)
					Event ue_set_cc_conto_presente("Z")
					Event ue_crea_titolo_finestra(ls_cod_sc, ls_rag_soc_1, "Z")
				else
					is_tipo =dw_1.getitemstring(1,'sog_commerciale_tipo') 
					ls_comm_codice = Event ue_crea_cod_sc("")
					Event ue_set_cc_conto_presente(is_tipo)
				end if
			end if
			
			
			
			if ll_return < 0 then
				if Not IsNull(ls_tipo) then
					Post SetItem(ll_row, "sog_commerciale_tipo", ls_tipo)
					Post SetItem(ll_row, "sog_commerciale_codice", ls_cod_sc)
				else
					Post SetItem(ll_row, "sog_commerciale_tipo", data)
				end if
				Return 0
			end if
		end if		
	CASE 'sog_commerciale_codice'
		
		
		
		SELECT "dba"."sog_commerciale"."codice", "dba"."sog_commerciale"."tipo"
			 INTO :ls_codice, :ls_tipo
			 FROM "dba"."sog_commerciale"
			 WHERE "dba"."sog_commerciale"."id_sog_commerciale" = :ll_id_sc ;
		if IsNull(ls_codice) then ls_codice = data
		
		
		ls_cod_sc = GetItemString(ll_row, "sog_commerciale_codice")
		ll_id_conto_sc = GetItemNumber(ll_row, "sog_commerciale_id_conto")
		ll_id_conto = f_esiste_conto(ls_cod_sc, ll_id_conto_sc)
		if ll_id_conto < 0 then
			
			if Event ue_convalida_cod(data) < 0 then
				
				ll_return = -1
			else
				if len(data) = 4 then
					Post Event ue_crea_cod_sc(data)
				end if
				
			end if
		else
			
			MessageBox("Attenzione", "Impossibile cambiare un codice abbinato ad un conto.")
			ll_return = -1
		end if
		
		if ll_return < 0 then
			
			if (IsNull(ls_tipo) Or ls_tipo = "") then
				ls_tipo = GetItemString(ll_row, "sog_commerciale_tipo")
			end if
			Post SetItem(ll_row, "sog_commerciale_tipo", ls_tipo)
			
			if (IsNull(ls_codice) Or ls_codice = "") then ls_codice = ls_cod_sc
			Post SetItem(ll_row, "sog_commerciale_codice", ls_codice)
			RETURN 0
		end if

	CASE 'anagrafica_rag_soc_1'
		ll_id_anagrafica = GetItemNumber(ll_row, "sog_commerciale_id_anagrafica")
 	   SELECT "anagrafica"."rag_soc_1" INTO :ls_rag_soc_1  
			 FROM "dba"."anagrafica"
			 WHERE "anagrafica"."id_anagrafica" = :ll_id_anagrafica ;
		
		
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_anagrafica"
		ls_dwc[1] = "sog_commerciale_id_anagrafica"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "anagrafica_rag_soc_1"
		ll_ok = wf_autofind_ragsoc(dwo.Name, "anagrafica", &
										"rag_soc_1", "A", data, &
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) Or data <> GetItemString(ll_row, "anagrafica_rag_soc_1") THEN
			
			ls_comm_codice = GetItemString(ll_Row, "sog_commerciale_codice")
			ls_tipo = GetItemString(ll_Row, "sog_commerciale_tipo")
			Event ue_crea_titolo_finestra(ls_comm_codice, data, ls_tipo)
			
			Event ue_put_info()
			Return 2
		else
			Post SetItem(ll_row, "anagrafica_rag_soc_1", ls_rag_soc_1)
		END IF
		
		
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;long			ll_Row, ll_id_anagrafica
string 	 	ls_title, ls_comm_codice, ls_rag_soc_1, ls_info, ls_tipo

ll_Row = This.GetRow()

CHOOSE CASE as_nomecol
	CASE "anagrafica_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_id_anagrafica", is_ricpar.s_id_seg_value[1])
		
		
		ll_id_anagrafica = GetItemNumber(ll_row, "sog_commerciale_id_anagrafica")
		ls_info = f_info_anagra(ll_id_anagrafica)
		SetItem(ll_row, "cinfo", ls_info)
		
		ls_comm_codice = GetItemString(ll_Row, "sog_commerciale_codice")
		ls_rag_soc_1 = This.GetText()
		ls_tipo = GetItemString(ll_Row, "sog_commerciale_tipo")
		Event ue_crea_titolo_finestra(ls_comm_codice, ls_rag_soc_1, ls_tipo)
END CHOOSE


end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "anagrafica_rag_soc_1"
		is_search_window = "w_anagrafica_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc" 
END CHOOSE

CHOOSE CASE as_nomecol
	CASE "sog_commerciale_id_linguaggio_2"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "sog_commerciale_id_linguaggio"
	CASE "sog_commerciale_id_linguaggio"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "sog_commerciale_id_linguaggio_2"
END CHOOSE


end event

event ue_itemerror;call super::ue_itemerror;long 		ll_sottomastro, ll_return
string 	ls_nomecampo, ls_a, ls_b, ls_c, ls_d, ls_sql_cond, ls_tipo, ls_data
long    	ll_row, ll_id_sog_conto, ll_par1, ll_a, ll_b, ll_c, ll_d
boolean  lb_isnew

ls_nomecampo = adwo_dwo.name
ls_data = as_data
ls_sql_cond = ""  
ll_par1 = long (as_data)
ll_row = GetRow()
ll_id_sog_conto= GetItemNumber(ll_row, "sog_commerciale_id_conto")

CHOOSE CASE adwo_dwo.name
	case "sog_commerciale_id_anagrafica"
		SELECT anagrafica.id_linguaggio, anagrafica.id_tipo_trasporto,
			  anagrafica.id_tributo, anagrafica.id_att_svolta
		INTO :ls_a, :ls_b, :ls_c, :ls_d
		FROM anagrafica
		WHERE anagrafica.id_anagrafica = :ll_par1
		USING SQLCA;

		
		lb_isnew = (GetItemStatus(al_row, 0, Primary!) = New!) OR (GetItemStatus(al_row, 0, Primary!) = NewModified!)
		if lb_isnew then
			if SQLCA.SQLCode = 0 then
				SetItem (al_row,"sog_commerciale_id_linguaggio",ll_a)
				SetItem (al_row,"sog_commerciale_id_tipo_trasporto",ll_b)
				SetItem (al_row,"sog_commerciale_id_tributo",ll_c)
				SetItem (al_row,"sog_commerciale_id_att_svolta",ll_d)
			else
				MessageBox ("Errore!",SQLCA.SQLErrText,Exclamation!)
			end if
		end if
			RETURN ll_return
		case else
			return u_freddie.gl_null
END CHOOSE

end event

event ue_initial;call super::ue_initial;string 			ls_tipo, ls_rag_soc_1
long				ll_id_anagrafica, ll_CurrentRow
dwItemStatus 	ldws_st
			
ll_CurrentRow = THIS.GetRow()

SetItem(ll_CurrentRow,"sog_commerciale_data_acquisizione",Today())
tab_1.tabpage_1.dw_1.SetItemStatus ( 1, 0,Primary!, NotModified! )

ls_tipo = is_list.s_win_parametri
if not isNull(ls_tipo) then
	SetItem(ll_CurrentRow, "sog_commerciale_tipo", ls_tipo)
	tab_1.tabpage_1.dw_1.SetItemStatus ( 1, 0,Primary!, NotModified! )
	
	Event ue_crea_cod_sc("")
	
	Event ue_set_cc_conto_presente(ls_tipo)
end if

IF (UpperBound(idw_master.is_list.s_par_name) < 1) THEN
	RETURN
END IF

IF NOT (idw_master.is_list.s_par_name[1] = "id_anagrafica") THEN
	RETURN
END IF

ldws_st = THIS.GetItemStatus(ll_CurrentRow, 0, Primary!)
IF NOT (ldws_st = New! OR ldws_st = NewModified!) THEN
	RETURN
END IF

ll_id_anagrafica = Long(idw_master.is_list.s_par_value[1])
SetItem(ll_CurrentRow, "sog_commerciale_id_anagrafica", ll_id_anagrafica)
tab_1.tabpage_1.dw_1.SetItemStatus ( 1, 0,Primary!, NotModified! )
SELECT "dba"."anagrafica"."rag_soc_1"
	INTO   :ls_rag_soc_1
	FROM "dba"."anagrafica"
	WHERE "dba"."anagrafica"."id_anagrafica" = :ll_id_anagrafica ;
IF SQLCA.SQLCode = 0 THEN
	SetItem(ll_CurrentRow, "anagrafica_rag_soc_1", ls_rag_soc_1)
	tab_1.tabpage_1.dw_1.SetItemStatus ( 1, 0,Primary!, NotModified! )
	Event ue_put_info()
END IF

end event

event itemfocuschanged;call super::itemfocuschanged;long 		ll_row, ll_sottomastro, ll_return, ll_value
string 	ls_lastcode, ls_prval, ls_new1, ls_value
integer 	li_prlen

ll_row = GetRow()

CHOOSE CASE dwo.name
	case "sog_commerciale_tipo"
		is_buffer_tipo = GetItemString(ll_row, "sog_commerciale_tipo")
END CHOOSE	
CHOOSE CASE is_buffer_item
		case "sog_commerciale_tipo"
			is_buffer_tipo = GetItemString(ll_row, "sog_commerciale_tipo")
			Event ue_set_cc_conto_presente(is_buffer_tipo)
END CHOOSE			
is_buffer_item = dwo.name

	
end event

event ue_insert;call super::ue_insert;
string ls_tipo

event ue_setta_testata()
ls_tipo = is_list.s_win_parametri

if IsNull(ls_tipo) OR ls_tipo = "C" OR ls_tipo = "F" then
	f_displayonly(dw_1, "sog_commerciale_codice", False)
end if


long ll_row

ll_row = tab_1.tabPage_6.dw_7.getrow()
tab_1.tabPage_6.dw_7.setitem(ll_row,'crea_gruppo_agenti','S')

integer li_valuta

SELECT id_valuta
INTO :li_valuta
FROM par_sistema;

ll_row = tab_1.tabpage_6.dw_7.getrow()
tab_1.tabpage_6.dw_7.setitem(ll_row,'cid_valuta',li_valuta)


Long	ll_tipo_agente , ll_imp_fisso

SELECT id_tipo_agente,imp_fisso
INTO :ll_tipo_agente,:ll_imp_fisso
FROM par_sistema;

ll_row = tab_1.tabpage_6.dw_7.GetRow()

tab_1.tabpage_6.dw_7.SetItem(ll_row,'sog_commerciale_id_tipo_agente',ll_tipo_agente)
tab_1.tabpage_6.dw_7.SetItem(ll_row,'sog_commerciale_imp_fisso',ll_imp_fisso)
tab_1.tabpage_6.dw_7.SetItemStatus(ll_row,0,Primary!,NotModified!)





end event

event ue_retrieve;call super::ue_retrieve;event ue_setta_testata()


end event

event ue_update;call super::ue_update;

long				ll_CurrRow, ll_IDConto_sc, ll_IDConto, ll_IDSog_Commerciale
string			ls_codice_sc, ls_codice_conto
dwItemStatus	ldwis_status

ll_CurrRow 		= this.GetRow()

if ll_CurrRow > 0 then
	
	ls_codice_sc	= this.GetItemString(ll_CurrRow, "sog_commerciale_codice")
	ldwis_status	= this.GetItemStatus(ll_CurrRow, "id_sog_commerciale", Primary!)
	
	
	
	
	
	
	
	SELECT "dba"."sog_commerciale"."id_sog_commerciale"
		INTO :ll_IDSog_Commerciale
		FROM "dba"."sog_commerciale"
		WHERE "dba"."sog_commerciale"."codice" = :ls_codice_sc AND
			"dba"."sog_commerciale"."id_azienda" = 1 ;
	
	choose case SQLCA.SQLCode
		case 0
			
			
			
			this.SetItem(ll_CurrRow,"id_sog_commerciale",ll_IDSog_Commerciale)
			this.SetItemStatus(ll_CurrRow, "id_sog_commerciale", Primary!, ldwis_status)
		
			
			
			
			
			
			IF ls_codice_sc <> "" THEN
				SELECT "dba"."conto"."id_conto"
					INTO :ll_IDConto
					FROM "dba"."conto"
					WHERE "dba"."conto"."codice" = :ls_codice_sc AND
							"dba"."conto"."id_azienda" = 1 ;
			
				CHOOSE CASE SQLCA.SQLCode
					CASE 0
						IF IsNull(ll_IDConto_sc) OR ll_IDConto_sc = 0 THEN
							
							UPDATE "sog_commerciale"  
								SET "id_conto" = :ll_IDConto  
								WHERE "sog_commerciale"."id_sog_commerciale" = :ll_IDSog_Commerciale   ;
						END IF
						return 0
					CASE -1
						MessageBox("Errore sul DataBase", "dw_sog_commercaile_gen / retrieveend / 1")
						return 1
				END CHOOSE
				
			END IF
			
			
			
			
			
		case -1
			MessageBox("Errore sul DataBase", "dw_sog_commerciale_gen / retrieveend / -1")
			return 1
		case 100
			
			
			
			Messagebox ("Errore sul DataBase", "Attenzione, inserite il Linguaggio")
			return 1
	end choose
			
end if

return 1
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2875
int Height=1400
long BackColor=79741120
string Text="Commerciale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw_master_main within tabpage_2
int X=27
int Y=36
int Width=2811
int Height=1340
int TabOrder=4
string DataObject="d_sog_commerciale_comm_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_cat_attivita_cod"
is_list.s_colonne_drop[2] = "id_cat_attivita_des"
is_list.s_colonne_drop[3] = "id_cat_com_sc_cod"
is_list.s_colonne_drop[4] = "id_cat_com_sc_des"
is_list.s_colonne_drop[5] = "id_cat_zona_cod"
is_list.s_colonne_drop[6] = "id_cat_zona_des"
is_list.s_colonne_drop[7] = "id_magazzino"
is_list.s_colonne_drop[8] = "sog_commerciale_id_listino_cod"
is_list.s_colonne_drop[9] = "sog_commerciale_id_listino_des"
is_list.s_colonne_drop[10] = "id_gruppo_agenti_cod"
is_list.s_colonne_drop[11] = "id_gruppo_agenti_des"
is_list.s_colonne_drop[12] = "id_tipo_trasporto_cod"
is_list.s_colonne_drop[13] = "id_tipo_trasporto_des"
is_list.s_colonne_drop[14] = "id_sog_com_vettore"


end event

event ue_set_search;call super::ue_set_search;long ll_CurrRow, ll_id_anagrafica

CHOOSE CASE as_nomecol

	CASE "cc_magazzino_cod"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "cc_magazzino_des"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "cc_abi_cab_des"
		is_search_window = "w_banca_sog_commerciale_gen_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_den_abi_cab" 
		ll_CurrRow = THIS.GetRow()
		IF ll_CurrRow > 0 THEN
			ll_id_anagrafica = THIS.GetItemNumber(ll_CurrRow, "id_anagrafica")
			is_ricpar.s_sql_cond = "banca_sog_commerciale_gen.id_anagrafica = " + string(ll_id_anagrafica)
		END IF

	CASE "id_con_pagamento_cod"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "id_con_pagamento_des"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 


	CASE "cc_vettore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
	CASE "cc_vettore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

	CASE "id_cat_attivita_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "id_cat_attivita_des"
	CASE "id_cat_attivita_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "id_cat_attivita_cod"

	CASE "id_cat_com_sc_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "id_cat_com_sc_des"
	CASE "id_cat_com_sc_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "id_cat_com_sc_cod"

	CASE "id_cat_zona_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "id_cat_zona_des"
	CASE "id_cat_zona_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "id_cat_zona_cod"

	CASE "id_tipo_trasporto_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto_des"
		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873
	CASE "id_tipo_trasporto_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto_cod"
		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873

END CHOOSE


end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_anagrafica, ll_id_banca_appoggio

ls_sql_cond = ""  
CHOOSE CASE dwo.name
	CASE 'cc_magazzino_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "cc_magazzino_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "cc_magazzino_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'cc_magazzino_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "cc_magazzino_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "cc_magazzino_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE 'cc_vettore_cod'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_vettore"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "cc_agente_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "cc_vettore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'cc_vettore_des'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_vettore"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "cc_vettore_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "cc_vettore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'cc_abi_cab_des'
  
		ls_sql_cond = "banca_sog_commerciale_gen.id_anagrafica = "+ uf_get_colval("id_anagrafica")	
		ls_dbc[1] = "id_banca_sog_commerciale"
		ls_dwc[1] = "sog_commerciale_id_banca_sog_commerciale"
		ls_dbc[2] = "conto_corrente"
		ls_dwc[2] = "cc_conto_corrente"
		ls_dbc[3] = "cin"
		ls_dwc[3] = "cc_cin"
		ls_dbc[4] = "den_abi"
		ls_dwc[4] = "cc_abi_cab_des"
		ll_ok = uf_autofind_col(dwo.Name, "banca_sog_commerciale_gen", &  
										"den_abi" + ' - ' + "den_cab", "A", data, & 
										ls_sql_cond, 4, &
										ls_dbc, ls_dbv, ls_dwc)
		
		
		Integer li_giorni_fr
		Long ll_num_row
		SELECT "banca_appoggio"."giorni_franchigia"
		INTO :li_giorni_fr
		FROM banca_appoggio
		WHERE "banca_appoggio"."den_abi" = :ls_dbc[4];
		ll_num_row = Tab_1.TabPage_6.dw_7.RowCount()
		Tab_1.TabPage_6.dw_7.SetItem(ll_num_row,'Sog_commerciale_giorni_franchigia', & 
			String(li_giorni_fr))
		

		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'id_con_pagamento_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_con_pagamento"
		ls_dwc[1] = "id_con_pagamento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "id_con_pagamento_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "id_con_pagamento_des"
		ll_ok = uf_autofind_col(dwo.Name, "con_pagamento", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'id_con_pagamento_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_con_pagamento"
		ls_dwc[1] = "id_con_pagamento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "id_con_pagamento_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "id_con_pagamento_des"
		ll_ok = uf_autofind_col(dwo.Name, "con_pagamento", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "cc_magazzino_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cc_magazzino_des", is_ricpar.s_ausil_value[1])
	CASE "cc_magazzino_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cc_magazzino_cod", is_ricpar.s_ausil_value[1])

	CASE "id_con_pagamento_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_con_pagamento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("id_con_pagamento_des", is_ricpar.s_ausil_value[1])
	CASE "id_con_pagamento_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_con_pagamento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("id_con_pagamento_cod", is_ricpar.s_ausil_value[1])

	CASE "cc_abi_cab_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_id_banca_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cc_conto_corrente", is_ricpar.s_ausil_value[1])
		uf_set_colval("cc_cin", is_ricpar.s_ausil_value[2])


	CASE "cc_vettore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cc_vettore_des", is_ricpar.s_ausil_value[1])
	CASE "cc_vettore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cc_vettore_cod", is_ricpar.s_ausil_value[1])


END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;
string 	ls_codice, ls_descrizione, ls_cc
long 		ll_magazzino, ll_id_con_pagamento, ll_row, ll_sog_comm, ll_banca_sog_comm

ll_row = GetRow()

if RowCount() > 0 then
	

	
	
	ll_magazzino = long(uf_get_colval("id_magazzino"))

	
	SELECT "magazzino"."codice" , "magazzino"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "magazzino" 
	 	WHERE ( "magazzino"."id_magazzino" = :ll_magazzino )   ;

	
	uf_set_colval("cc_magazzino_cod",ls_codice)
	uf_set_colval("cc_magazzino_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "cc_magazzino_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "cc_magazzino_des", PRIMARY!, NotModified!)

	
	
	ll_id_con_pagamento = long(uf_get_colval("id_con_pagamento"))

	
	SELECT "con_pagamento"."codice" , "con_pagamento"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "con_pagamento" 
	 	WHERE ( "con_pagamento"."id_con_pagamento" = :ll_id_con_pagamento )   ;

	
	uf_set_colval("id_con_pagamento_cod",ls_codice)
	uf_set_colval("id_con_pagamento_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "cc_magazzino_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "cc_magazzino_des", PRIMARY!, NotModified!)


ls_codice = ""
ls_descrizione = ""
ll_sog_comm = long(uf_get_colval("id_sog_com_vettore"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm)   ;
	
	uf_set_colval("cc_vettore_cod",ls_codice)
	uf_set_colval("cc_vettore_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "cc_vettore_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "cc_vettore_des", PRIMARY!, NotModified!)
	
ls_codice = ""
ls_cc = ""
ls_descrizione = ""
ll_banca_sog_comm = long(uf_get_colval("sog_commerciale_id_banca_sog_commerciale"))

	
	   SELECT "banca_sog_commerciale_gen"."den_abi"+' - '+"banca_sog_commerciale_gen"."den_cab",   
         "banca_sog_commerciale_gen"."conto_corrente", "banca_sog_commerciale_gen"."cin"
   	INTO : ls_codice, :ls_cc, :ls_descrizione
      FROM "banca_sog_commerciale_gen"
	   WHERE ( "banca_sog_commerciale_gen"."id_banca_sog_commerciale" = :ll_banca_sog_comm )   ;
	
   
	
	
	uf_set_colval("cc_abi_cab_des",ls_codice)
	uf_set_colval("cc_conto_corrente",ls_cc)
	uf_set_colval("cc_cin",ls_descrizione)
	
	
	setitemstatus(ll_row, "cc_abi_cab_des", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "cc_conto_corrente", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "cc_cin", PRIMARY!, NotModified!)
	
end if
end event

event itemfocuschanged;call super::itemfocuschanged;CHOOSE CASE dwo.name
	CASE 'id_gruppo_agenti_cod', 'id_gruppo_agenti_des'
		IF (cb_provv.Visible = TRUE) THEN
			cb_provv.Enabled = TRUE
		END IF
	CASE ELSE
			cb_provv.Enabled = FALSE
END CHOOSE		
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2875
int Height=1400
long BackColor=79741120
string Text="Destinazioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw_master_main within tabpage_3
int X=27
int Y=36
int Width=2811
int Height=1340
int TabOrder=4
string DataObject="d_destinazione_lt"
end type

event ue_init;call super::ue_init;is_title = "Destinazione"
is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window = "w_destinazione_ff"
is_list.s_win_chiave[1] = "id_destinazione"
is_list.s_par_name[1] = "id_sog_commerciale"
end event

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=2875
int Height=1400
long BackColor=79741120
string Text="Altro"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_4 dw_4
dw_5 dw_5
end type

on tabpage_4.create
this.dw_4=create dw_4
this.dw_5=create dw_5
this.Control[]={this.dw_4,&
this.dw_5}
end on

on tabpage_4.destroy
destroy(this.dw_4)
destroy(this.dw_5)
end on

type dw_4 from u_dw_master_main within tabpage_4
int X=27
int Y=36
int Width=2811
int Height=840
int TabOrder=3
string DataObject="d_sog_commerciale_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_tab_iva_cod"
is_list.s_colonne_drop[2] = "id_tab_iva_des"
is_list.s_colonne_drop[3] = "id_prof_registrazione_cod"
is_list.s_colonne_drop[4] = "id_prof_registrazione_des"
is_list.s_colonne_drop[5] = "id_tributo_cod"
is_list.s_colonne_drop[6] = "id_tributo_des"
is_list.s_colonne_drop[7] = "id_att_svolta_cod"
is_list.s_colonne_drop[8] = "id_att_svolta_des"



end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_tributo_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tributo_gd"
		is_ricpar.s_titolo_finestra = "Tributi"
		is_ricpar.s_ausil_value[1] = "id_tributo_des"
		is_ricpar.i_width = 2917
		is_ricpar.i_height = 869
	CASE "id_tributo_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tributo_gd"
		is_ricpar.s_titolo_finestra = "Tributi"
		is_ricpar.s_ausil_value[1] = "id_tributo_cod"
		is_ricpar.i_width = 2917
		is_ricpar.i_height = 869

	CASE "id_att_svolta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_att_svolta_gd"
		is_ricpar.s_titolo_finestra = "Attività Svolte"
		is_ricpar.s_ausil_value[1] = "id_att_svolta_des"
	CASE "id_att_svolta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_att_svolta_gd"
		is_ricpar.s_titolo_finestra = "Attività Svolte"
		is_ricpar.s_ausil_value[1] = "id_att_svolta_cod"
		
END CHOOSE


end event

type dw_5 from u_dw_master_main within tabpage_4
int X=27
int Y=916
int Width=2811
int Height=460
int TabOrder=3
string DataObject="d_spesa_sog_commerciale_gd"
end type

event ue_init;call super::ue_init;is_title	= "Spesa Sogg. Commerciale"
is_list.s_identifica[1] = "id_sog_commerciale"
end event

type tabpage_5 from userobject within tab_1
int X=18
int Y=104
int Width=2875
int Height=1400
long BackColor=79741120
string Text="Annotazioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_6 dw_6
end type

on tabpage_5.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_5.destroy
destroy(this.dw_6)
end on

type dw_6 from u_dw_master_main within tabpage_5
int X=27
int Y=36
int Width=2811
int Height=1340
int TabOrder=4
string DataObject="d_annotazione_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title = "Annotazioni"
is_list.s_identifica[1] = "id_sog_commerciale"

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_tipo_annotazione"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_annotazione_gd"
		is_ricpar.s_titolo_finestra = "Tipi Annotazione"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 873

END CHOOSE

end event

type tabpage_6 from userobject within tab_1
int X=18
int Y=104
int Width=2875
int Height=1400
boolean Visible=false
long BackColor=79741120
string Text="Dati Agente"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_4 cb_4
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_7 dw_7
cb_5 cb_5
end type

on tabpage_6.create
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_7=create dw_7
this.cb_5=create cb_5
this.Control[]={this.cb_4,&
this.cb_1,&
this.cb_2,&
this.cb_3,&
this.dw_7,&
this.cb_5}
end on

on tabpage_6.destroy
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_7)
destroy(this.cb_5)
end on

type cb_4 from commandbutton within tabpage_6
int X=101
int Y=572
int Width=599
int Height=88
int TabOrder=11
boolean BringToTop=true
string Text="Star del credere"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Long ll_row , ll_star_credere , ll_sog_commerciale
Integer li_ret_message
String ls_cod_sog_comm , ls_cod

ll_row = tab_1.tabpage_1.dw_1.GetRow()
ls_cod_sog_comm = tab_1.tabpage_1.dw_1.GetItemString(ll_row,'sog_commerciale_codice')
ll_sog_commerciale = tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,'id_sog_commerciale')

SELECT "sog_commerciale"."codice"
INTO :ls_cod	
FROM "sog_commerciale"
WHERE "sog_commerciale"."codice" = :ls_cod_sog_comm;

SELECT "star_credere"."id_star_credere"
INTO :ll_star_credere
FROM "star_credere","sog_commerciale"
WHERE ( "sog_commerciale"."id_sog_commerciale" = "star_credere"."id_sog_commerciale" ) &
		and ( ( "sog_commerciale"."codice" = :ls_cod ) );

IF IsNull(ll_star_credere) OR ll_star_credere = 0 THEN
	li_ret_message = MessageBox ( "Star del credere" , &
						"Importare i dati dei parametri di sistema ?" ,Exclamation! ,YesNo! ,1)
	IF li_ret_message = 1 THEN
  		INSERT INTO star_credere ( id_sog_commerciale , data_inizio , data_fine , &
  						star_credere , id_azienda )  
  		SELECT 		:ll_sog_commerciale , data_inizio , data_fine , star_credere , id_azienda
		FROM			star_credere
		WHERE			star_credere.id_sog_commerciale IS NULL;
	END IF
END IF


long ll_sog_com
ll_row=tab_1.tabpage_1.dw_1.getrow()
ll_sog_com=tab_1.tabpage_1.dw_1.getitemnumber(ll_row,"id_sog_commerciale")
if ll_sog_com>0 then
	Openwithparm(w_star_credere_sog_comm_lt,ll_sog_com)
end if


end event

type cb_1 from commandbutton within tabpage_6
int X=101
int Y=176
int Width=599
int Height=88
int TabOrder=31
boolean BringToTop=true
string Text="Premi / Penalità"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Long ll_row , ll_premi_penalita , ll_sog_commerciale
Integer li_ret_message
String ls_cod_sog_comm , ls_cod

ll_row = tab_1.tabpage_1.dw_1.GetRow()
ls_cod_sog_comm = tab_1.tabpage_1.dw_1.GetItemString(ll_row,'sog_commerciale_codice')
ll_sog_commerciale = tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,'id_sog_commerciale')

SELECT "sog_commerciale"."codice"
INTO :ls_cod	
FROM "sog_commerciale"
WHERE "sog_commerciale"."codice" = :ls_cod_sog_comm;

SELECT "premi_penalita"."id_premi_penalita"
INTO :ll_premi_penalita
FROM "premi_penalita","sog_commerciale"
WHERE ( "sog_commerciale"."id_sog_commerciale" = "premi_penalita"."id_sog_commerciale" ) &
		and ( ( "sog_commerciale"."codice" = :ls_cod ) )   ;

IF IsNull(ll_premi_penalita) OR ll_premi_penalita = 0 THEN
	li_ret_message = MessageBox ( "Premi e penalità" , &
						"Importare i dati dei parametri di sistema ?" ,Exclamation! ,YesNo! ,1)
	IF li_ret_message = 1 THEN
		INSERT INTO premi_penalita (id_sog_commerciale , data_inizio , data_fine , &
						giorni , percentuale , id_azienda)
						
		SELECT 		:ll_sog_commerciale , data_inizio , data_fine , giorni , &
						percentuale , id_azienda
		FROM 			premi_penalita
		WHERE 		id_sog_commerciale IS NULL;
	END IF
END IF
	

long ll_sog_com
ll_row=tab_1.tabpage_1.dw_1.getrow()
ll_sog_com=tab_1.tabpage_1.dw_1.getitemnumber(ll_row,"id_sog_commerciale")
if ll_sog_com>0 then
	Openwithparm(w_premi_penalita_sog_comm_lt,ll_sog_com)
end if
end event

type cb_2 from commandbutton within tabpage_6
int X=101
int Y=308
int Width=599
int Height=88
int TabOrder=32
boolean BringToTop=true
string Text="Budget / Premio a Importo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Long ll_row , ll_budget , ll_sog_commerciale
Integer li_ret_message
String ls_cod_sog_comm , ls_cod

ll_row = tab_1.tabpage_1.dw_1.GetRow()
ls_cod_sog_comm = tab_1.tabpage_1.dw_1.GetItemString(ll_row,'sog_commerciale_codice')
ll_sog_commerciale = tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,'id_sog_commerciale')

SELECT "sog_commerciale"."codice"
INTO :ls_cod	
FROM "sog_commerciale"
WHERE "sog_commerciale"."codice" = :ls_cod_sog_comm;

SELECT "budget"."id_budget"
INTO :ll_budget
FROM "budget","sog_commerciale"
WHERE ( "sog_commerciale"."id_sog_commerciale" = "budget"."id_sog_commerciale" ) &
		and ( ( "sog_commerciale"."codice" = :ls_cod ) );

IF IsNull(ll_budget) OR ll_budget = 0 THEN
	li_ret_message = MessageBox ( "Budget" , &
						"Importare i dati dei parametri di sistema ?" ,Exclamation! ,YesNo! ,1)
	IF li_ret_message = 1 THEN
		INSERT INTO budget (	 id_sog_commerciale , anno , mese , importo , id_valuta , premio)
		SELECT 					:ll_sog_commerciale , anno , mese , importo , id_valuta , premio
		FROM budget 
		WHERE id_sog_commerciale IS NULL;
	END IF
END IF




long ll_sog_com
ll_row=tab_1.tabpage_1.dw_1.getrow()
ll_sog_com=tab_1.tabpage_1.dw_1.getitemnumber(ll_row,"id_sog_commerciale")
if ll_sog_com>0 then
	Openwithparm(w_budget_sog_comm_lt,ll_sog_com)
end if
end event

type cb_3 from commandbutton within tabpage_6
int X=101
int Y=440
int Width=599
int Height=88
int TabOrder=33
boolean BringToTop=true
string Text="L. Provvigioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Long ll_row , ll_liq_provvigioni , ll_sog_commerciale
Integer li_ret_message
String ls_cod_sog_comm , ls_cod

ll_row = tab_1.tabpage_1.dw_1.GetRow()
ls_cod_sog_comm = tab_1.tabpage_1.dw_1.GetItemString(ll_row,'sog_commerciale_codice')
ll_sog_commerciale = tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,'id_sog_commerciale')

SELECT "sog_commerciale"."codice"
INTO :ls_cod	
FROM "sog_commerciale"
WHERE "sog_commerciale"."codice" = :ls_cod_sog_comm;

SELECT "liq_provvigioni"."id_liq_provvigioni"
INTO :ll_liq_provvigioni
FROM "liq_provvigioni","sog_commerciale"
WHERE ( "sog_commerciale"."id_sog_commerciale" = "liq_provvigioni"."id_sog_commerciale" ) &
		and ( ( "sog_commerciale"."codice" = :ls_cod ) );

IF IsNull(ll_liq_provvigioni) OR ll_liq_provvigioni = 0 THEN
	li_ret_message = MessageBox ( "Liquidazione provvigioni" , &
						"Importare i dati dei parametri di sistema ?" ,Exclamation! ,YesNo! ,1)
	IF li_ret_message = 1 THEN
		INSERT INTO liq_provvigioni (id_sog_commerciale , data_inizio , data_fine , &
						importo , id_azienda , id_valuta)
		SELECT 		:ll_sog_commerciale , data_inizio , data_fine , importo , &
						id_azienda , id_valuta
		FROM 			liq_provvigioni 
		WHERE 		id_sog_commerciale IS NULL;
	END IF
END IF
	

long ll_sog_com
ll_row=tab_1.tabpage_1.dw_1.getrow()
ll_sog_com=tab_1.tabpage_1.dw_1.getitemnumber(ll_row,"id_sog_commerciale")
if ll_sog_com>0 then
	Openwithparm(w_liq_provvigione_sog_comm_lt,ll_sog_com)
end if
end event

type dw_7 from u_dw_master_main within tabpage_6
int X=23
int Y=36
int Width=2811
int Height=1336
int TabOrder=3
string DataObject="d_sog_commerciale_age_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared=true
is_list.s_colonne_drop[1] = "sog_commerciale_id_tipo_agente"
is_list.s_colonne_drop[2] = "cid_valuta"
is_list.s_colonne_drop[3] = "copia"


end event

type cb_5 from commandbutton within tabpage_6
int X=101
int Y=876
int Width=599
int Height=88
int TabOrder=12
boolean BringToTop=true
string Text="Gruppo Agenti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_gruppo
string ls_cod
s_list_main ls_list_app
ls_cod=tab_1.tabpage_1.dw_1.getitemstring(1,"sog_commerciale_codice")
select id_gruppo_agenti
into :ll_gruppo
from gruppo_agenti
where codice=:ls_cod;
if sqlca.sqlcode=0 then
	ls_list_app.s_identifica[1]="id_gruppo_agenti"
	ls_list_app.s_sql_ident[1]="id_gruppo_agenti"
	ls_list_app.s_win_chiave[1]="id_gruppo_agenti"
	ls_list_app.l_win_chiave[1]=ll_gruppo
	ls_list_app.l_identifica[1]=ll_gruppo
	ls_list_app.s_modo=modo_modifica
end if
OpenSheetWithParm( w_gruppo_agenti_cx, ls_list_app, w_app_frame, 0, Original!)	
end event

type cb_provv from commandbutton within w_sog_commerciale_cx
int X=2501
int Y=1040
int Width=325
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Provvigioni..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.TriggerEvent("ue_provvigioni")
end event

type cb_6 from commandbutton within w_sog_commerciale_cx
int X=2341
int Y=36
int Width=261
int Height=84
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="Elimina"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


long ll_row
integer li_id_conto, li_id_sog
string ls_codice, ls_rag

ll_row = tab_1.tabpage_1.dw_1.getrow()
ls_codice = tab_1.tabpage_1.dw_1.GetItemString(ll_row,"sog_commerciale_codice")
li_id_conto=tab_1.tabpage_1.dw_1.GetItemNumber(ll_row,"sog_commerciale_id_conto")
ls_rag = tab_1.tabpage_1.dw_1.GetItemstring (ll_row, "anagrafica_rag_soc_1")

select id_sog_commerciale
into :li_id_sog
from sog_commerciale
where id_conto = :li_id_conto
AND id_conto not in (select id_conto from mov_contabile)
AND id_sog_commerciale not in (select id_sog_commerciale from documento);
	
IF sqlca.sqlcode = 100  THEN
	messagebox ('Attenzione', 'Ci sono Registrazioni ~r~no Documenti con questo soggetto')
ELSE

	DELETE FROM DESTINAZIONE
	WHERE id_sog_commerciale =  :li_id_sog;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Soggetti Commerciali - cancellazione destinazioni", SQLCA.SQLERRTEXT)
		return
	End If
	
	DELETE FROM SPESA_SOG_COMMERCIALE
	WHERE id_sog_commerciale =  :li_id_sog;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Soggetti Commerciali - cancellazione spese", SQLCA.SQLERRTEXT)
		return
	End If	
	
	DELETE FROM ANNOTAZIONE
	WHERE id_sog_commerciale =  :li_id_sog;

	If SQLCA.SQLCODE = -1 Then
		MessageBox("Soggetti Commerciali - cancellazione annotazioni", SQLCA.SQLERRTEXT)
		return
	End If
	
	DELETE FROM saldo_mensile
	WHERE	id_conto = :li_id_conto
	;
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Soggetti Commerciali - cancellazione Saldo mensile", SQLCA.SQLERRTEXT)
		return
	End If	
	
	DELETE FROM sog_commerciale 
	where id_conto = :li_id_conto
	AND id_conto not in (select id_conto from mov_contabile);
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Soggetti Commerciali - cancellazione Sogg. Commerciale", SQLCA.SQLERRTEXT)
		return
	End If	
	
	DELETE FROM conto
	WHERE id_conto = :li_id_conto
	AND id_conto not in (select id_conto from sog_commerciale);
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Soggetti Commerciali - cancellazione conto", SQLCA.SQLERRTEXT)
		return
	else
		tab_1.tabpage_1.dw_1.insertrow(1)
		messagebox ('Attenzione', 'Soggetto Commerciale ' +ls_codice+ '~r~n' + ls_rag +' eliminato')
	end if
END IF
end event

