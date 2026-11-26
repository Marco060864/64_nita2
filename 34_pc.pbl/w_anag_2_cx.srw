forward
global type w_anag_2_cx from w_p_data
end type
type dw_anag_gen_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_scom_gen_ff from u_dw_master_main within tabpage_2
end type
type dw_dest_scom_lt from u_dw_master_main within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_scom_gen_ff dw_scom_gen_ff
dw_dest_scom_lt dw_dest_scom_lt
cb_1 cb_1
end type
type tabpage_3 from userobject within tab_1
end type
type dw_scom_comm_ff from u_dw_master_main within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_scom_comm_ff dw_scom_comm_ff
end type
type tabpage_4 from userobject within tab_1
end type
type dw_spesa_scom_gd from u_dw_master_main within tabpage_4
end type
type dw_scom_fatt_ff from u_dw_master_main within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_spesa_scom_gd dw_spesa_scom_gd
dw_scom_fatt_ff dw_scom_fatt_ff
end type
type tabpage_5 from userobject within tab_1
end type
type dw_banca_sog_commerciale_gd_t from statictext within tabpage_5
end type
type dw_con_spec_scadenza_gd_t from statictext within tabpage_5
end type
type dw_banca_anag_gd from u_dw_master_main within tabpage_5
end type
type dw_scad_anag_gd from u_dw_master_main within tabpage_5
end type
type dw_scom_pag_ff from u_dw_master_main within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_banca_sog_commerciale_gd_t dw_banca_sog_commerciale_gd_t
dw_con_spec_scadenza_gd_t dw_con_spec_scadenza_gd_t
dw_banca_anag_gd dw_banca_anag_gd
dw_scad_anag_gd dw_scad_anag_gd
dw_scom_pag_ff dw_scom_pag_ff
end type
type tabpage_6 from userobject within tab_1
end type
type dw_anag_rit_ff from u_dw_master_main within tabpage_6
end type
type dw_scom_rit_ff from u_dw_master_main within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_anag_rit_ff dw_anag_rit_ff
dw_scom_rit_ff dw_scom_rit_ff
end type
type tabpage_7 from userobject within tab_1
end type
type dw_telefono_lt_t from statictext within tabpage_7
end type
type dw_ann_anag_gd_t from statictext within tabpage_7
end type
type dw_tel_anag_lt from u_dw_master_main within tabpage_7
end type
type dw_ann_scom_gd from u_dw_master_main within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_telefono_lt_t dw_telefono_lt_t
dw_ann_anag_gd_t dw_ann_anag_gd_t
dw_tel_anag_lt dw_tel_anag_lt
dw_ann_scom_gd dw_ann_scom_gd
end type
type tabpage_8 from userobject within tab_1
end type
type dw_scom_age_ff from u_dw_master_main within tabpage_8
end type
type cb_premi_penalita from commandbutton within tabpage_8
end type
type cb_budget from commandbutton within tabpage_8
end type
type cb_liq_provvigioni from commandbutton within tabpage_8
end type
type cb_gruppo_agenti from commandbutton within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_scom_age_ff dw_scom_age_ff
cb_premi_penalita cb_premi_penalita
cb_budget cb_budget
cb_liq_provvigioni cb_liq_provvigioni
cb_gruppo_agenti cb_gruppo_agenti
end type
type dw_scom_anag_lt from u_dw_master_main within w_anag_2_cx
end type
type st_1 from statictext within w_anag_2_cx
end type
type cb_cond_lis from commandbutton within w_anag_2_cx
end type
type cb_2 from commandbutton within w_anag_2_cx
end type
end forward

global type w_anag_2_cx from w_p_data
integer width = 3145
integer height = 1932
string title = "Anagrafica"
dw_scom_anag_lt dw_scom_anag_lt
st_1 st_1
cb_cond_lis cb_cond_lis
cb_2 cb_2
end type
global w_anag_2_cx w_anag_2_cx

type variables
string    is_win_title
string    is_buffer_tipo, is_buffer_item
string   is_tipo
long il_contropartita[], il_riga_conto[]
end variables

forward prototypes
public subroutine uf_ricerca ()
public function integer uf_retrieve_campi_calcolati ()
public function string wf_proposta_codice (string as_cod, string as_tipo)
public function integer uf_provvigioni ()
public subroutine uf_titolo (string as_dati)
public subroutine uf_spese (string ls_spesa, integer ll_row, string ls_dwo)
public subroutine wf_valu_edit ()
public subroutine wf_ges_ute_ana (string ac_operazione)
end prototypes

public subroutine uf_ricerca ();

w_search_main		lw_sm
long					ll_id_anagrafica, ll_row
string				ls_SQL_cond = "", ls_dwcol[], ls_dbfield[]
integer				li_risposta,li_retvalue
s_ric_param			ls_ricpar

ll_row = idw_master.GetRow()
idw_master.is_ricpar.s_filter_name = "rag_soc_1"

ls_dwcol[1] = "rag_soc_1"
ls_dwcol[2] = "rag_soc_2"
ls_dwcol[3] = "cod_fiscale"
ls_dwcol[4] = "par_iva"

ls_dbfield[1] = "rag_soc_1"
ls_dbfield[2] = "rag_soc_2"
ls_dbfield[3] = "cod_fiscale"
ls_dbfield[4] = "par_iva"

ls_SQL_cond = f_get_SQL_cond (idw_master, ll_row,ls_dwcol,ls_dbfield)
idw_master.is_ricpar.s_SQL_cond = ls_SQL_cond

OpenWithParm (lw_sm, idw_master.is_ricpar, "w_anagrafica_sw")
idw_master.is_ricpar = Message.PowerObjectParm



if not IsNull(idw_master.is_ricpar) then 
	
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
			ll_id_anagrafica = long(idw_master.is_ricpar.s_id_seg_value[1])
			idw_master.is_list.s_modo = modo_modifica
			idw_master.is_list.s_identifica[1] = "id_anagrafica"
			idw_master.is_list.l_identifica[1] = ll_id_anagrafica
			SetPointer(HourGlass!)
			
			this.enabled= FALSE
			SetNull(is_buffer_tipo)
			SetNull(is_buffer_item)
			SetNull(is_tipo)
			idw_master.Event ue_retrieve(0, 0)
			
			
			
			
			
			
			
			this.enabled= TRUE
			SetPointer(Arrow!)
		end if
	END IF
END IF
idw_master.SetFocus()



end subroutine

public function integer uf_retrieve_campi_calcolati ();long 			ll_id_sog_commerciale
long			ll_id_magazzino
long			ll_id_pagamento
long			ll_id_banca
long			ll_banca_appoggio
long			ll_vettore
long			ll_vettore_2		
long			ll_Row
string 		ls_codice_magazzino,ls_descrizione_magazzino
string 		ls_codice_pagamento,ls_descrizione_pagamento
string 		ls_den_abi,ls_den_cab
string		ls_conto_corrente,ls_cin, ls_cod, ls_des
string 		ls_codice_vettore,ls_descrizione_vettore
string		ls_codice_vettore_2,ls_descrizione_vettore_2		
long 			ll_id_contropartita
string      ls_cod_abi, ls_cod_cab
				
for ll_row= 1 to tab_1.tabpage_3.dw_scom_comm_ff.rowcount()
		ll_id_sog_commerciale 	= this.tab_1.tabpage_3.dw_scom_comm_ff.GetItemNumber(ll_row,"id_sog_commerciale")
		ll_id_magazzino			= this.tab_1.tabpage_3.dw_scom_comm_ff.GetItemNumber(ll_row,"id_magazzino")
		ll_id_pagamento			= this.tab_1.tabpage_3.dw_scom_comm_ff.GetItemNumber(ll_row,"id_con_pagamento")
		ll_id_banca					= this.tab_1.tabpage_3.dw_scom_comm_ff.GetItemNumber(ll_row,"id_banca_sog_commerciale")	
		ll_vettore					= this.tab_1.tabpage_3.dw_scom_comm_ff.GetItemNumber(ll_row,"id_sog_com_vettore")	
		ll_vettore_2				= this.tab_1.tabpage_3.dw_scom_comm_ff.GetItemNumber(ll_row,"id_sog_com_vettore_2")	
		ll_id_contropartita				=tab_1.tabpage_3.dw_scom_comm_ff.GetItemNumber(ll_row,"con_movimento_id_conto")
		
		
		
		
		
		select "magazzino"."codice" , "magazzino"."descrizione" 
			into : ls_codice_magazzino,:ls_descrizione_magazzino
			from "dba"."magazzino", "dba"."locazione"
			where ( "magazzino"."id_magazzino" = "locazione"."id_magazzino"
			and 	"locazione"."id_locazione"=:ll_id_magazzino );
			
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_magazzino_cod",ls_codice_magazzino )
		this.tab_1.tabpage_3.dw_scom_comm_ff.setitem( ll_row,"c_magazzino_des",ls_descrizione_magazzino )
		
		
		
		
		select "con_pagamento"."codice" , "con_pagamento"."descrizione" 
			into : ls_codice_pagamento,:ls_descrizione_pagamento
			from "dba"."con_pagamento"
			where ( "con_pagamento"."id_con_pagamento" = :ll_id_pagamento );
			
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_condpag_cod",ls_codice_pagamento )
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_condpag_des",ls_descrizione_pagamento )
		
		
		
		
		
		
		setnull(ll_banca_appoggio)
		ls_conto_corrente = ""
		ls_cin = ""
		ls_den_abi = ""
		ls_den_cab = ""
		
		ls_cod_abi=''
		ls_cod_cab=''
		select "banca_sog_commerciale"."id_banca_appoggio" , "banca_sog_commerciale"."conto_corrente" ,"banca_sog_commerciale"."cin" 
			into :ll_banca_appoggio,:ls_conto_corrente,:ls_cin
			from "dba"."banca_sog_commerciale"
			where ( "banca_sog_commerciale"."id_banca_sog_commerciale" = :ll_id_banca );
		
		select "banca_appoggio"."den_abi","banca_appoggio"."den_cab","banca_appoggio"."cod_abi", "banca_appoggio"."cod_cab"
			into :ls_den_abi,:ls_den_cab, :ls_cod_abi, :ls_cod_cab
			from "dba"."banca_appoggio"
			where ( "banca_appoggio"."id_banca_appoggio" = :ll_banca_appoggio );
			
		

		
		if (isnull(ls_den_abi)) then
			ls_den_abi = ""
		end if

		if (isnull(ls_den_cab)) then
			ls_den_cab = ""
		end if
		if (isnull(ls_cod_cab)) then
			ls_cod_cab = ""
		end if
		if (isnull(ls_cod_abi)) then
			ls_cod_abi = ""
		end if
		
		
		
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_abi_cab_des", ls_cod_abi+"-"+ls_cod_cab+"-"+&
		ls_den_abi + " - " + ls_den_cab )
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_conto_corrente", ls_conto_corrente )
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_cin", ls_cin )
		
		
		
		
		select "sog_commerciale_gen"."codice" ,"sog_commerciale_gen"."rag_soc_1"
			into : ls_codice_vettore,:ls_descrizione_vettore
			from "dba"."sog_commerciale_gen"
			where ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_vettore );
		
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_vettore_cod", ls_codice_vettore )
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_vettore_des", ls_descrizione_vettore )

		
		
		
		
		select "sog_commerciale_gen"."codice" ,"sog_commerciale_gen"."rag_soc_1"
			into : ls_codice_vettore_2,:ls_descrizione_vettore_2
			from "dba"."sog_commerciale_gen"
			where ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_vettore_2 );
		
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_vettore_2_cod", ls_codice_vettore_2 )
		this.tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"c_vettore_2_des", ls_descrizione_vettore_2 )

		
		
		
		
		select codice, descrizione into :ls_cod,:ls_des from Conto where id_conto=:ll_id_contropartita;
		if SQLCA.SQLcode=0 then
			tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"cod_contropartita", ls_cod)
			tab_1.tabpage_3.dw_scom_comm_ff.SetItem( ll_row,"des_contropartita", ls_des)
		end if
next

return 0
end function

public function string wf_proposta_codice (string as_cod, string as_tipo);

long 		ll_row
string	ls_codice, ls_cod
integer	li_count

ls_codice =	as_cod
ll_row =	dw_scom_anag_lt.rowcount()

if ll_row >	0 then
	for li_count =	1 to ll_row
		ls_cod =	dw_scom_anag_lt.getitemstring(li_count, "codice")
		if Lower(left (ls_cod, 2)) = Lower(left (as_tipo,2)) then
			if Lower(right(ls_cod, 6)) > Lower(right (as_cod,6)) then ls_codice = ls_cod
		end if
	next
end if
return ls_codice

end function

public function integer uf_provvigioni ();

s_list_main			lstr_for_win
datawindow			ldw_curr
string				s_win_to_open
long					ll_row

s_win_to_open	=	"w_scag_prov_sog_comm_cx"
ldw_curr			=	tab_1.tabpage_3.dw_scom_comm_ff
ll_row			=	ldw_curr.GetRow()
lstr_for_win.s_modo = modo_modifica
lstr_for_win.s_identifica[1]	= "id_gruppo_agenti"
lstr_for_win.l_identifica[1]	= ldw_curr.GetItemNumber(ll_row,  "id_gruppo_agenti_cod")
lstr_for_win.s_identifica[2]	= "id_sog_commerciale"
lstr_for_win.l_identifica[2]	= ldw_curr.GetItemNumber(ll_row,  "id_sog_commerciale")

OpenWithParm(w_p_data, lstr_for_win, s_win_to_open)
return 0
end function

public subroutine uf_titolo (string as_dati);
long      	ll_CurrRow
string   	ls_Persona, ls_msg
string 		ls_title, ls_space, ls_minus, ls_rag_soc_1

ls_space = " "
ls_minus = " - "
ll_CurrRow = tab_1.tabpage_1.dw_anag_gen_ff.GetRow()

IF ll_CurrRow > 0 THEN
	ls_Persona = tab_1.tabpage_1.dw_anag_gen_ff.GetItemString(ll_CurrRow, "nat_giuridica")
	
	
		
		
	
		tab_1.tabpage_6.Enabled = TRUE
		tab_1.tabpage_6.Visible = TRUE
	
	
	if as_dati ="nuovo" then this.title = "<Nuova Anagrafica>"
	if as_dati= "" then	
		ls_rag_soc_1 = tab_1.tabpage_1.dw_anag_gen_ff.GetItemString(ll_CurrRow, "rag_soc_1")
		ls_title = ls_rag_soc_1
		if IsNull(ls_title) then 
			ls_title = ls_space
		end if
		this.Title = "Anagrafica - " + ls_title
	end if
end if




end subroutine

public subroutine uf_spese (string ls_spesa, integer ll_row, string ls_dwo);
DECIMAL LD_PERC, LD_IMP
LONG LL_ID
IF ls_dwo="id_spesa_cod" THEN
	LL_ID=LONG(ls_spesa)
	SELECT PERCENTUALE, IMPORTO INTO :LD_PERC, :LD_IMP
	FROM SPESA WHERE ID_SPESA=:LL_ID;
	tab_1.tabpage_4.dw_spesa_scom_gd.SETITEM(ll_ROW,'percentuale',LD_PERC)
	tab_1.tabpage_4.dw_spesa_scom_gd.SETITEM(ll_ROW,'importo',LD_IMP)
END IF

end subroutine

public subroutine wf_valu_edit ();
long	   ll_id_valuta
string	 ls_valu_edit

ll_id_valuta = tab_1.tabpage_1.dw_anag_gen_ff.getitemnumber(1, "id_valuta_cod")
ls_valu_edit = f_valu_edit(ll_id_valuta)
tab_1.tabpage_4.dw_spesa_scom_gd.modify("spesa_sog_commerciale_importo.edit.format ='" + ls_valu_edit + "'")
tab_1.tabpage_4.dw_spesa_scom_gd.modify("da_imponibile.edit.format ='" + ls_valu_edit + "'")
tab_1.tabpage_4.dw_spesa_scom_gd.modify("a_imponibile.edit.format ='" + ls_valu_edit + "'")

end subroutine

public subroutine wf_ges_ute_ana (string ac_operazione);long ll_id_ana

ll_id_ana= tab_1.tabpage_1.dw_anag_gen_ff.getitemnumber(1, "id_anagrafica")
if ac_operazione> " " and ll_id_ana > 0 and u_freddie.s_utenti.i_IDUtente > 0 then
	
	INSERT INTO dba.ute_ana_cl_fo (id_utente, id_anagrafica, operazione, data_ora)
	VALUES (:u_freddie.s_utenti.i_IDUtente, :ll_id_ana, :ac_operazione, NOW())
	;
	
	if sqlca.sqlcode = 0 then
		
		commit;
		
	else
		messagebox("dberror", sqlca.sqlerrtext)
		rollback;
	end if
end if
end subroutine

on w_anag_2_cx.create
int iCurrent
call super::create
this.dw_scom_anag_lt=create dw_scom_anag_lt
this.st_1=create st_1
this.cb_cond_lis=create cb_cond_lis
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scom_anag_lt
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cond_lis
this.Control[iCurrent+4]=this.cb_2
end on

on w_anag_2_cx.destroy
call super::destroy
destroy(this.dw_scom_anag_lt)
destroy(this.st_1)
destroy(this.cb_cond_lis)
destroy(this.cb_2)
end on

event open;call super::open;
long			ll_screenh
environment	le_env

this.il_HelpTopic = 11

idw_master = tab_1.tabpage_1.dw_anag_gen_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "anagrafica.id_anagrafica"
ib_NonModale = TRUE
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	
	ib_NonModale = TRUE
	idw_master.is_list.s_modo = modo_inserisci
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

end event

event ue_post_open;call super::ue_post_open;idw_tree[1]	= tab_1.tabpage_1.dw_anag_gen_ff
idw_tree[2]	= dw_scom_anag_lt
idw_tree[3]	= tab_1.tabpage_2.dw_scom_gen_ff
idw_tree[4]	= tab_1.tabpage_2.dw_dest_scom_lt
idw_tree[5]	= tab_1.tabpage_3.dw_scom_comm_ff
idw_tree[6]	= tab_1.tabpage_4.dw_scom_fatt_ff
idw_tree[7]	= tab_1.tabpage_4.dw_spesa_scom_gd
idw_tree[8]	= tab_1.tabpage_5.dw_banca_anag_gd
idw_tree[9]	= tab_1.tabpage_5.dw_scad_anag_gd
idw_tree[10]= tab_1.tabpage_5.dw_scom_pag_ff
idw_tree[11]= tab_1.tabpage_6.dw_anag_rit_ff
idw_tree[12]= tab_1.tabpage_6.dw_scom_rit_ff
idw_tree[13]= tab_1.tabpage_7.dw_tel_anag_lt
idw_tree[14]= tab_1.tabpage_7.dw_ann_scom_gd
end event

event ue_update;call super::ue_update;uf_titolo("")




end event

event ue_master_delete;call super::ue_master_delete;
if (idw_master.Event ue_delete(0, 0) = 0) then
	idw_master.insertrow(0)
	ib_AskForSave = false
	idw_master.Event ue_update(0, 0)
	tab_1.tabpage_1.dw_anag_gen_ff.event trigger ue_initial()


end if
	
idw_master.SetFocus()
uf_titolo("nuovo")

end event

type p_msg_log from w_p_data`p_msg_log within w_anag_2_cx
end type

type p_crescente from w_p_data`p_crescente within w_anag_2_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_anag_2_cx
end type

type cb_ok from w_p_data`cb_ok within w_anag_2_cx
integer y = 44
end type

type cb_annulla from w_p_data`cb_annulla within w_anag_2_cx
integer y = 44
end type

type cb_nuovo from w_p_data`cb_nuovo within w_anag_2_cx
integer y = 44
end type

event cb_nuovo::clicked;call super::clicked;u_freddie.iw_current.triggerevent('ue_initial')
uf_titolo("nuovo")


cb_2.PostEvent(Clicked!)
end event

type cb_inserisci from w_p_data`cb_inserisci within w_anag_2_cx
integer x = 1920
integer y = 44
end type

type cb_cancella from w_p_data`cb_cancella within w_anag_2_cx
integer x = 2217
integer y = 44
end type

type cb_salva from w_p_data`cb_salva within w_anag_2_cx
integer x = 2514
integer y = 44
end type

type tab_1 from w_p_data`tab_1 within w_anag_2_cx
integer x = 626
integer y = 208
integer width = 2464
integer height = 1576
integer taborder = 40
integer weight = 700
fontcharset fontcharset = ansi!
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_5
this.Control[iCurrent+5]=this.tabpage_6
this.Control[iCurrent+6]=this.tabpage_7
this.Control[iCurrent+7]=this.tabpage_8
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
end on

event tab_1::selectionchanging;call super::selectionchanging;
if newindex=2 then setfocus(tab_1.tabpage_2.dw_scom_gen_ff)
end event

event tab_1::selectionchanged;call super::selectionchanged;string ls_rag_soc_azienda
select rag_soc_1 into :ls_rag_soc_azienda from dba.azienda;
if newindex=4 and pos(upper(ls_rag_soc_azienda), "BUCC")>0 then
	tab_1.tabpage_4.dw_scom_fatt_ff.object.uff_iva_t.text="Delivery:"
end if
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Anagrafica"
long tabbackcolor = 79741120
dw_anag_gen_ff dw_anag_gen_ff
end type

on tabpage_1.create
this.dw_anag_gen_ff=create dw_anag_gen_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_anag_gen_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_anag_gen_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_anag_2_cx
integer x = 1216
integer y = 44
end type

event cb_ricerca::clicked;uf_ricerca()
end event

type dw_anag_gen_ff from u_dw_master_main within tabpage_1
integer x = 55
integer y = 48
integer width = 2240
integer height = 1372
integer taborder = 1
string dataobject = "d_ac_anag_gen_ff"
end type

event ue_init;call super::ue_init;is_title = "Anagrafica"
is_list.s_identifica[1] = "id_anagrafica"

iudw_children[1] = dw_scom_anag_lt
iudw_children[2] = tab_1.tabpage_5.dw_banca_anag_gd
iudw_children[3] = tab_1.tabpage_5.dw_scad_anag_gd
iudw_children[4] = tab_1.tabpage_6.dw_anag_rit_ff
iudw_children[5] = tab_1.tabpage_7.dw_tel_anag_lt
end event

event ue_initial;call super::ue_initial;
long	ll_CurRow, ll_Valuta_Par_Sistema, ll_id_azienda, ll_lingua, ll_lingua_Par_Sistema
long  ll_linguaggio_Par_Sistema, ll_linguaggio

ll_id_azienda = 1
select	"par_sistema"."id_valuta"
	into	:ll_Valuta_Par_Sistema
	from	"dba"."par_sistema"
	where	"par_sistema"."id_azienda" = :ll_id_azienda;
	
if sqlca.SQLCode = 0 then
	ll_CurRow = this.GetRow()
	this.SetItem (ll_CurRow, "id_valuta_cod", ll_Valuta_Par_Sistema)
end if

this.SetItemStatus (ll_CurRow, 0, Primary!, DataModified!)
this.SetItemStatus (ll_CurRow, 0, Primary!, NotModified!)
this.SetItemStatus (ll_CurRow, 0, Primary!, New!)


select	"par_sistema"."id_lingua"
	into	:ll_lingua_Par_Sistema
	from	"dba"."par_sistema"
	where	"par_sistema"."id_azienda" = :ll_id_azienda;
	
if sqlca.SQLCode = 0 then
	ll_CurRow = this.GetRow()
	this.SetItem (ll_CurRow, "id_lingua_cod", ll_lingua_Par_Sistema)
end if

this.SetItemStatus (ll_CurRow, 0, Primary!, NotModified!)

long	ll_codice

SELECT MAX(codice) + 1
INTO	 :ll_codice
FROM	 anagrafica
;

if isnull(ll_codice) then ll_codice = 1

this.setitem(getrow(), "codice", ll_codice)

end event

event itemchanged;long	   li_rows 
integer	li_i


long 	 			ll_CurrRow
string 			ls_Nazione, ls_CF, ls_PI, ls_Persona,  ls_piva,  ls_valu_edit  , ls_cod_fisc
string 			ls_title, ls_space, ls_minus,  ls_codice, ls_rag_soc_1,flag, ls_colonna
window 			lw_parent
tab    			lw_tab
string    		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, ls_rag_soc
long      		ll_return, ll_ok, ll_row, ll_id_sc, ll_id_conto, ll_sottomastro, 	ll_id_conto_sc, ll_id_anagrafica
string 	 		ls_comm_codice, ls_rag_soc_2, ls_tipo, ls_codice_1, ls_cod_sc
dwItemStatus	ls_status
string ll_tipo

ls_space = " "
ls_minus = " - "
ll_CurrRow = GetRow()
CHOOSE CASE dwo.name
	case "nazione"
		if data<>'IT' then // 	
			messagebox("Attenzione!", "Se la nazione è <> 'IT' la provincia deve essere vuota  e il campo CAP andrà compilato con il valore generico 00000. Si potrà utilizzare l’indirizzo per indicare il CAP straniero.")
			setitem(row, "provincia", "")
			setitem(row, "cap", "00000")
		end if
	CASE "cod_fiscale"
		ls_Nazione = GetItemString(ll_CurrRow, "nazione")
		ls_CF = data
		
		ls_CF = trim(ls_CF) 
		
		if ls_Nazione = "IT" AND ls_CF <> "" AND not IsNull(ls_CF) then
			if GetItemString( ll_CurrRow,"nat_giuridica") = "G" then
				IF f_controlla_partita_iva(ls_CF, ls_Nazione) = 1 THEN
					MessageBox(is_title, "Codice Fiscale non valido.", Exclamation!)
				END IF
			else
				IF f_controlla_codice_fiscale(ls_CF, ls_Nazione) = 1 THEN
					MessageBox(is_title, "Codice Fiscale non valido.", Exclamation!)
				END IF
			END IF	
		end if
 
      select "anagrafica"."cod_fiscale","anagrafica"."rag_soc_1"
		into   :ls_cod_fisc,:ls_rag_soc_1
		from   "anagrafica"
		where  "anagrafica"."cod_fiscale"=:ls_CF;
		
		ls_cod_fisc = trim(ls_cod_fisc) 
		
		
		IF ls_cod_fisc=ls_CF AND (NOT ISNULL(ls_CF)) AND (NOT (ls_CF='')) THEN 
   		messagebox("Controllo","Attenzione! Il Codice Fiscale "+ls_cod_fisc+"~nè già presente in archivio ed appartiene a:~n"+ls_rag_soc_1);
         ls_colonna="cod_fiscale"
         POST F_SET_COLUMN(DW_ANAG_GEN_FF,LS_COLONNA)
      END IF
		
				
	CASE "par_iva"
		ls_Nazione = GetItemString(ll_CurrRow, "nazione")
		ls_PI = data
		
		ls_PI = trim(ls_PI) 
		
		if ls_Nazione = "IT"  AND ls_PI <> "" AND not IsNull(ls_PI) then
			IF f_controlla_partita_iva(ls_PI, ls_Nazione) = 1 or len(data)<11 THEN
				return 2
				MessageBox(is_title, "Partita IVA non valida.", Exclamation!)
			END IF
		end if		
      select "anagrafica"."par_iva","anagrafica"."rag_soc_1"
		into   :ls_piva,:ls_rag_soc_1
		from   "anagrafica"
		where  "anagrafica"."par_iva"=:ls_PI;
		
		ls_piva = trim(ls_piva) 
		
		IF ls_piva=ls_PI AND (NOT ISNULL(ls_PI) ) AND (NOT (ls_PI='')) THEN 
		   messagebox("Controllo","Attenzione! La Partita Iva "+ls_piva+"~nè già presente in archivio ed appartiene a:~n"+ls_rag_soc_1);
         ls_colonna="par_iva"
         POST F_SET_COLUMN(DW_ANAG_GEN_FF,LS_COLONNA)
      END IF
	
	CASE "rag_soc_1" 
		ls_rag_soc=data
		
		ls_rag_soc = trim(ls_rag_soc) 
		
      select "anagrafica"."rag_soc_1"
		into   :ls_rag_soc_1
		from   "anagrafica"
		where  "anagrafica"."rag_soc_1"=:ls_rag_soc;
		
		ls_rag_soc_1 = trim(ls_rag_soc_1) 
		
		IF ls_rag_soc=ls_rag_soc_1 THEN 
         messagebox("Controllo","Attenzione! La Ragione Sociale "+ls_rag_soc+"~nè già presente in archivio!");
	     	ls_colonna="rag_soc_1"
			POST F_SET_COLUMN(DW_ANAG_GEN_FF,LS_COLONNA)
		END IF
	
	CASE 'id_valuta_cod'
		

		li_rows = tab_1.tabpage_4.dw_spesa_scom_gd.rowcount()
		if (li_rows > 0) then
			for li_i = 1 to li_rows
				tab_1.tabpage_4.dw_spesa_scom_gd.setitem(li_i, "anagrafica_id_valuta", long(data))
			next
		end if	
				
		wf_valu_edit()
	
END CHOOSE

end event

event ue_default;call super::ue_default;string ls_cod_fiscale

CHOOSE CASE adwo_current.name
	CASE "par_iva"
		ls_cod_fiscale = GetItemString( al_row,"cod_fiscale")
		IF f_controlla_partita_iva(ls_cod_fiscale, "IT") = 0 THEN
			SetItem(al_row, "par_iva", ls_cod_fiscale)
		END IF
END CHOOSE
end event

event ue_retrieve;call super::ue_retrieve;uf_titolo("")
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_lingua_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_des"
		
	CASE "id_lingua_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_cod"
				
	CASE "id_titolo"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_titolo_gd"
		is_ricpar.s_titolo_finestra = "Titoli"
		
	CASE "id_valuta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
		
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_cod"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861

END CHOOSE

end event

event updatestart;string ls_cod_fiscale, ls_piva,ls_riga1,ls_riga2
dwitemstatus ldw_status
ldw_status=dw_anag_gen_ff.getitemstatus(1,0,primary!)
if ldw_status<>new! and ldw_status<>notmodified! then
	ls_cod_fiscale=dw_anag_gen_ff.getitemstring(1,"Cod_Fiscale")
	ls_piva=dw_anag_gen_ff.getitemstring(1,"Par_Iva")

string ls_prov_contabile
ls_prov_contabile = dw_anag_gen_ff.getitemstring(1,"prov_contabile")

	if isnull(ls_cod_fiscale) and ls_prov_contabile = 'I' then
		ls_riga1="Il Codice Fiscale deve essere inserito!~n"
	end if
	
	if isnull(ls_piva)and ls_prov_contabile = 'I'then
		ls_riga2="La Partita Iva deve essere inserita!~n"
	end if
	
	if (isnull(ls_cod_fiscale) or isnull(ls_piva)) and ls_prov_contabile = 'I'  then
		messagebox("Controllo", "ATTENZIONE!~n"+ls_riga1+ls_riga2) 
	end if
	
	
	integer	li_codice
	li_codice = this.getitemnumber(this.getrow(), "codice")
	SELECT codice
	INTO	 :li_codice
	FROM	 anagrafica
	WHERE	 codice = :li_codice
	;
	
	if (sqlca.sqlcode = 0) then
		SELECT max(codice)
		INTO	 :li_codice
		FROM	 anagrafica
		;
		
		this.setitem(this.getrow(), "codice", li_codice + 1)
	end if
	
end if


end event

event updateend;long ll_codice, ll_id_ana
if getrow()>0 then
	ll_codice=getitemnumber(1, "codice")
	select id_anagrafica
	into :ll_id_ana
	from anagrafica
	where codice=:ll_codice;
	if ll_id_ana>0 then
		setitem(1, "id_anagrafica", ll_id_ana)
	end if
end if


if rowsinserted>0 then
	wf_ges_ute_ana("I")
elseif rowsupdated>0 then
	wf_ges_ute_ana("U")
elseif rowsdeleted>0 then
	wf_ges_ute_ana("D")
end if
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Sogg. Comm."
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_scom_gen_ff dw_scom_gen_ff
dw_dest_scom_lt dw_dest_scom_lt
cb_1 cb_1
end type

on tabpage_2.create
this.dw_scom_gen_ff=create dw_scom_gen_ff
this.dw_dest_scom_lt=create dw_dest_scom_lt
this.cb_1=create cb_1
this.Control[]={this.dw_scom_gen_ff,&
this.dw_dest_scom_lt,&
this.cb_1}
end on

on tabpage_2.destroy
destroy(this.dw_scom_gen_ff)
destroy(this.dw_dest_scom_lt)
destroy(this.cb_1)
end on

type dw_scom_gen_ff from u_dw_master_main within tabpage_2
event type integer ue_convalida_cod ( string as_codice )
event type string ue_crea_cod_sc ( string as_codice )
event ue_set_cc_conto_presente ( string as_tipo )
event type integer ue_reset ( )
event type integer ue_setta_testata ( )
event ue_setta_sottomastro ( )
integer x = 50
integer y = 32
integer width = 2336
integer height = 532
integer taborder = 3
string dataobject = "d_ac_scom_gen_ff"
end type

event ue_convalida_cod;call super::ue_convalida_cod;
long 		ll_return, ll_row, ll_sottomastro, ll_codice, ll_id_sc, ll_id_sog_conto
string	ls_tipo, ls_codice

ll_return 			= 0
ll_row 				= GetRow()
ls_tipo				= GetItemString(ll_row, "tipo")
ll_id_sog_conto 	= GetItemNumber(ll_row, "id_conto")
ll_id_sc 			= GetItemNumber(ll_row, "id_sog_commerciale")

If Len(as_codice) <> 8 And Len(as_codice) <> 4 then
	
	MessageBox("Convalida del Codice","Codice non valido.~rImmettere un codice di 4 o 8 caratteri.", Exclamation!)
	ll_return = -1
end if

if ll_return = 0 then
	
	ll_sottomastro = f_controlla_conto(as_codice,1)
	
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

event ue_crea_cod_sc;call super::ue_crea_cod_sc;

string		ls_a, ls_b, ls_c, ls_d, ls_e, ls_f, ls_prval, ls_lastcode, ls_new1, &
				ls_value, ls_cod_sc, ls_rag_soc_1, ls_prval_1
integer		li_prlen
long			ll_value, ll_row


If len(as_codice) = 0 then
	
	
	SELECT par_sistema.pref_cod_cliente, par_sistema.pref_cod_fornitore,
			 par_sistema.pref_cod_agente, par_sistema.pref_cod_vettore,
			 par_sistema.pref_cod_cliente_potenziale, par_sistema.pref_cod_altro
		INTO	:ls_a, :ls_b, :ls_c, :ls_d, :ls_e, :ls_f
		FROM	par_sistema
		WHERE	par_sistema.id_azienda = 1
		USING	SQLCA;
	
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
		ls_prval_1 = ls_prval
	else
		MessageBox("Attenzione", "Problemi con tabella 'Parametri di Sistema'", Information!)
		Return "NO!"
	end if
else
	ls_prval 	= 	as_codice
	ls_prval_1	=	left(as_codice,2) 
end if
if not isnull(ls_prval) then li_prlen = len(ls_prval) else li_prlen = 0

if is_tipo='C' or is_tipo='F' then
	li_prlen=4
	long ll_sm2
	tab_1.tabpage_2.dw_scom_gen_ff.accepttext()
	ll_row=tab_1.tabpage_2.dw_scom_gen_ff.getrow()
	ll_sm2=tab_1.tabpage_2.dw_scom_gen_ff.getitemnumber(ll_row,"sm")
	string ls_cod2
	select codice
	into :ls_cod2
	from sottomastro
	where id_sottomastro=:ll_sm2;
	ls_prval=ls_prval+ls_cod2
end if
SELECT max(sog_commerciale.codice)
	INTO :ls_lastcode
	FROM sog_commerciale
	WHERE left (sog_commerciale.codice,:li_prlen) = :ls_prval AND Substr (sog_commerciale.codice , 5, 4) <= '9999'
	USING SQLCA;
	
	
ls_lastcode = wf_proposta_codice(ls_lastcode,ls_prval_1 )	
	
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
		
	end if
else
	
	ls_value = ""
end if

if is_tipo = "C" OR is_tipo = "F" then
	
	long ll_ret,ll_sm
	tab_1.tabpage_2.dw_scom_gen_ff.accepttext()
	ll_row=tab_1.tabpage_2.dw_scom_gen_ff.getrow()
	ll_sm=tab_1.tabpage_2.dw_scom_gen_ff.getitemnumber(ll_row,"sm")
	string ls_cod
	select codice
	into :ls_cod
	from sottomastro
	where id_sottomastro=:ll_sm;
	ls_prval=ls_prval+ls_cod

	ll_ret=f_valida_pre_codice(ls_prval, is_tipo)
	if ll_ret<0 then ls_value= ""
end if

uf_set_colval("codice",ls_value) 

Return ls_value

end event

event ue_set_cc_conto_presente;call super::ue_set_cc_conto_presente;
long	ll_row

ll_row = GetRow()
if (as_tipo = "C") or (as_tipo = "F") then
	this.SetItem(ll_row, "c_conto_presente", "S")
else
	this.SetItem(ll_row, "c_conto_presente", "N")
end if
end event

event ue_reset;call super::ue_reset;
integer 			li_size, li_counter
long 				ll_row
datawindow		ldw_item

SetNull(is_buffer_tipo)
SetNull(is_buffer_item)
SetNull(is_tipo)
f_displayonly(this, "tipo", FALSE)
f_displayonly(this, "codice", FALSE)
li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.Reset()
next

return 0

end event

event ue_setta_testata;call super::ue_setta_testata;
long 				ll_CurrRow
string 			ls_codice,ls_tipo
window 			lw_parent
tab    			lw_tab

ls_tipo = is_list.s_win_parametri
ll_CurrRow = GetRow()
IF (ll_CurrRow > 0) THEN
	
	if ls_tipo = "C" OR ls_tipo = "F" then
		f_displayonly(dw_scom_gen_ff, "tipo", True)
		f_displayonly(dw_scom_gen_ff, "codice", True)
	else
	
		if f_esiste_conto(ls_codice, GetItemNumber(ll_CurrRow, "id_conto")) > 0 then
			f_displayonly(dw_scom_gen_ff, "codice", True)
	   end if
   end if
END IF
return 0
end event

event ue_setta_sottomastro;long ll_row
ll_row=tab_1.tabpage_2.dw_scom_gen_ff.getrow()
if ll_row>0 then
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
		tab_1.tabpage_2.dw_scom_gen_ff.accepttext()
		ls_cod=tab_1.tabpage_2.dw_scom_gen_ff.getitemstring(ll_row,"tipo")
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
		tab_1.tabpage_2.dw_scom_gen_ff.GetChild('sm',ldwc_dddw )
		ldwc_dddw.setfilter("sottomastro_id_mastro="+string(ll_filtro))
		ldwc_dddw.filter()
		dwitemstatus ldw_stato
		ldw_stato=tab_1.tabpage_2.dw_scom_gen_ff.getitemstatus(ll_row,0,Primary!)
		if ldw_stato=NewModified! or ldw_stato=new! then
			setnull(q)
			ls_prval=""
			tab_1.tabpage_2.dw_scom_gen_ff.setitem(ll_row,"sm",q)
			tab_1.tabpage_2.dw_scom_gen_ff.setitem(ll_row,"codice",ls_prval)
		else
			string ls_app
			long ll_riga_trovata,ll_id
			ls_app=tab_1.tabpage_2.dw_scom_gen_ff.getitemstring(ll_row,"codice")
			ls_app=mid(ls_app,3,2)
			ll_riga_trovata=ldwc_dddw.find("sottomastro_codice='"+ls_app+"'",1,ldwc_dddw.rowcount())
			if ll_riga_trovata>0 then
				ll_id=ldwc_dddw.getitemnumber(ll_riga_trovata,"sottomastro_id_sottomastro")
				tab_1.tabpage_2.dw_scom_gen_ff.setitem(ll_row,"sm",ll_id)
			end if
		end if
	end if
end if	
	

end event

event ue_init;call super::ue_init;ib_dw_shared = true
is_title = "Soggetto Commerciale"

is_list.s_colonne_drop[1] = "id_linguaggio_cod"
is_list.s_colonne_drop[2] = "id_linguaggio_des"
is_list.s_colonne_drop[3] = "sm"
end event

event rowfocuschanged;

long		ll_row, ll_row_parent


ll_row_parent = iudw_parent.getRow()
ll_row = this.getRow()
if ll_row <> ll_row_parent then
	scrolltorow(ll_row_parent)
end if

end event

event itemchanged;
string    		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      		ll_return, ll_ok, ll_row, ll_id_sc, ll_id_conto, ll_sottomastro, &
					ll_id_conto_sc, ll_id_anagrafica
string 	 		ls_title, ls_comm_codice, ls_rag_soc_1, ls_tipo, ls_codice, ls_cod_sc
dwItemStatus	ls_status

ls_sql_cond = ""  
ll_row 		= GetRow()
ls_status 	= THIS.GetItemStatus(ll_row, 0, Primary!)
ll_id_sc 	= GetItemNumber(ll_row, "id_sog_commerciale")

CHOOSE CASE dwo.name
	CASE 'tipo'
		long q
		string ls_prval
		setnull(q)
		ls_prval=""
		tab_1.tabpage_2.dw_scom_gen_ff.setitem(row,"sm",q)
		tab_1.tabpage_2.dw_scom_gen_ff.setitem(row,"codice",ls_prval)
		string ls_cl,ls_fo
		select pref_cod_cliente,pref_cod_fornitore
		into :ls_cl,:ls_fo
		from par_sistema;
		if string(data)<>ls_cl and string(data)<>ls_fo then
 	   SELECT "dba"."sog_commerciale"."tipo", "dba"."sog_commerciale"."codice"  
			 INTO :ls_tipo, :ls_cod_sc  
			 FROM "dba"."sog_commerciale"
			 WHERE "dba"."sog_commerciale"."id_sog_commerciale" = :ll_id_sc ;

		
		if ls_status <> NewModified! And ls_status <> New! And ls_tipo <> 'Z' then
							
			if ls_tipo = 'P' then
				
				if data <> 'C' then
					
					if data = "P" then
						
						Post SetItem(ll_row, "codice", ls_cod_sc)
					else
						MessageBox("Attenzione!", "Un Cliente Potenziale può essere modificato solo in un Cliente!")
						ll_return = -1
					end if
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
				
				Post SetItem(ll_row, "codice", ls_cod_sc)
				Event ue_set_cc_conto_presente("Z")
			else
				if data = 'A' Then
					
					Long ll_id_tipo_agente, ll_id_valuta
					Decimal ld_imp_fisso
					
					tab_1.tabpage_8.visible = TRUE
					SELECT id_tipo_agente, imp_fisso, id_valuta
					INTO	 :ll_id_tipo_agente, :ld_imp_fisso, :ll_id_valuta
					FROM	 par_sistema
					;
					
					if SQLCA.SQLCODE = 0 then
						tab_1.tabpage_8.dw_scom_age_ff.Setitem(ll_row, "id_tipo_agente", ll_id_tipo_agente)
						tab_1.tabpage_8.dw_scom_age_ff.Setitem(ll_row, "imp_fisso", ld_imp_fisso)
						tab_1.tabpage_8.dw_scom_age_ff.Setitem(ll_row, "id_val_prov_agente", ll_id_valuta)						
						tab_1.tabpage_8.dw_scom_age_ff.Setitem(ll_row, "crea_gruppo_agenti", "S")												
					end if
				End If
				
				is_tipo = data
				ls_comm_codice = Event ue_crea_cod_sc("")
				Event ue_set_cc_conto_presente(data)
			end if
		end if
		if ll_return < 0 then
			if Not IsNull(ls_tipo) then
				Post SetItem(ll_row, "tipo", ls_tipo)
				Post SetItem(ll_row, "codice", ls_cod_sc)
			else
				Post SetItem(ll_row, "tipo", data)
			end if
			Return 0
		end if
	end if
	
	
	
	string ll_tipo

	ll_Row = tab_1.tabpage_2.dw_scom_gen_ff.GetRow()

	if ll_row <> 0 then	
		ll_tipo 	= tab_1.tabpage_2.dw_scom_gen_ff.GetItemString(ll_row,"tipo")
   	If ll_tipo = 'F' then
			tab_1.tabpage_6.dw_scom_rit_ff.Enabled = TRUE
			tab_1.tabpage_6.dw_scom_rit_ff.Visible = TRUE
		else
			tab_1.tabpage_6.dw_scom_rit_ff.Enabled = FALSE
			tab_1.tabpage_6.dw_scom_rit_ff.Visible = FALSE
		END IF
		
	end if

	CASE 'sm'
		string ls_tipo2
		
		ls_tipo2=tab_1.tabpage_2.dw_scom_gen_ff.getitemstring(row,"tipo")		
 	   SELECT "dba"."sog_commerciale"."tipo", "dba"."sog_commerciale"."codice"  
			 INTO :ls_tipo2, :ls_cod_sc  
			 FROM "dba"."sog_commerciale"
			 WHERE "dba"."sog_commerciale"."id_sog_commerciale" = :ll_id_sc ;

		
		if ls_status <> NewModified! And ls_status <> New! And ls_tipo2 <> 'Z' then
							
			if ls_tipo2 = 'P' then
				
				if ls_tipo2 <> 'C' then
					
					if ls_tipo2 = "P" then
						
						is_tipo = "C"
						ls_comm_codice = Event ue_crea_cod_sc("")
						Event ue_set_cc_conto_presente("C")
						
						
						
						
					else
						MessageBox("Attenzione!", "Un Cliente Potenziale può essere modificato solo in un Cliente!")
						ll_return = -1
					end if
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
			if ls_tipo2 = "Z" AND ls_tipo2 = "Z" then
				
				Post SetItem(ll_row, "codice", ls_cod_sc)
				Event ue_set_cc_conto_presente("Z")
			else
				is_tipo = ls_tipo2
				ls_comm_codice = Event ue_crea_cod_sc("")
				Event ue_set_cc_conto_presente(ls_tipo2)
			end if
		end if
		if ll_return < 0 then
			if Not IsNull(ls_tipo2) then
				Post SetItem(ll_row, "tipo", ls_tipo2)
				Post SetItem(ll_row, "codice", ls_cod_sc)
			else
				Post SetItem(ll_row, "tipo", ls_tipo2)
			end if
			Return 0
		end if
		
	CASE 'codice'

		SELECT "dba"."sog_commerciale"."codice", "dba"."sog_commerciale"."tipo"
			 INTO :ls_codice, :ls_tipo
			 FROM "dba"."sog_commerciale"
			 WHERE "dba"."sog_commerciale"."id_sog_commerciale" = :ll_id_sc ;

		if IsNull(ls_codice) then ls_codice = data

		ls_cod_sc 		= GetItemString(ll_row, "codice")
		ll_id_conto_sc = GetItemNumber(ll_row, "id_conto")
		ll_id_conto 	= f_esiste_conto(ls_cod_sc, ll_id_conto_sc)
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
				ls_tipo = GetItemString(ll_row, "tipo")
			end if
			Post SetItem(ll_row, "tipo", ls_tipo)
			if (IsNull(ls_codice) Or ls_codice = "") then ls_codice = ls_cod_sc
			Post SetItem(ll_row, "codice", ls_codice)
			RETURN 0
		end if
END CHOOSE		


end event

event itemfocuschanged;call super::itemfocuschanged;




end event

event ue_initial;call super::ue_initial;long ll_linguaggio_Par_Sistema, ll_id_azienda, ll_CurRow

SetItem(THIS.GetRow(),"data_acquisizione",Today())

ll_id_azienda = 1
select	"par_sistema"."id_linguaggio"
	into	:ll_linguaggio_Par_Sistema
	from	"dba"."par_sistema"
	where	"par_sistema"."id_azienda" = :ll_id_azienda;
	
if sqlca.SQLCode = 0 then
	ll_CurRow = this.GetRow()
	this.SetItem (ll_CurRow, "id_linguaggio_cod", ll_linguaggio_Par_Sistema)
end if

this.SetItemStatus (ll_CurRow, 0, Primary!, DataModified!)
this.SetItemStatus (ll_CurRow, 0, Primary!, NotModified!)
this.SetItemStatus (ll_CurRow, 0, Primary!, New!)




end event

event ue_itemerror;call super::ue_itemerror;long 		ll_sottomastro, ll_return
long    	ll_row, ll_id_sog_conto, ll_par1, ll_a
string 	ls_nomecampo, ls_a, ls_sql_cond, ls_tipo, ls_data
boolean  lb_isnew

ls_nomecampo 	= adwo_dwo.name
ls_data 			= as_data
ls_sql_cond 	= ""  
ll_par1 			= long (as_data)
ll_row 			= GetRow()
ll_id_sog_conto = GetItemNumber(ll_row, "id_conto")
ll_return 		= 0

CHOOSE CASE adwo_dwo.name
		
	case "id_anagrafica"
		
		lb_isnew = (GetItemStatus(al_row, 0, Primary!) = New!) OR (GetItemStatus(al_row, 0, Primary!) = NewModified!)
		
		
		if lb_isnew then
			
			select anagrafica.id_linguaggio	  
				into :ls_a
				from anagrafica
				where anagrafica.id_anagrafica = :ll_par1
				using SQLCA;	
			
			if SQLCA.SQLCode = 0 then
				SetItem (al_row,"id_linguaggio",ll_a)
			else
				MessageBox ("Errore!",SQLCA.SQLErrText,Exclamation!)
				ll_return	= 1
			end if
			
		end if
			RETURN ll_return
			
	case else
			return u_freddie.gl_null
			
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "id_linguaggio"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio_des"
	CASE "id_linguaggio_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio"
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;event ue_setta_testata()
end event

event ue_insert;call super::ue_insert;
event ue_setta_testata()
 
if IsNull(is_tipo) OR is_tipo = "C" OR is_tipo = "F" then
	f_displayonly(dw_scom_gen_ff, "codice", False)
end if


end event

event ue_core_update;

long				ll_nrows, ll_row, ll_id_sog_commerciale
long				ll_errors, ll_id_conto
dwItemStatus	ldwis_stat1, ldwis_stat2
string			ls_codice_sc, ls_tipo_sc




ll_errors = super::EVENT ue_core_update (0,0)

if ll_errors=0 then
	ll_nrows = this.rowcount()
	for ll_row = 1 to ll_nrows
		ls_codice_sc	= this.GetItemString(ll_row, "codice")
		ls_tipo_sc		= this.GetItemString(ll_row, "tipo")
		ldwis_stat1 	= this.GetItemStatus(ll_row, 0, Primary!)
		ldwis_stat2		= this.GetItemStatus(ll_row, "id_sog_commerciale", Primary!)
		if ldwis_stat1 = NewModified! or ldwis_stat1 = DataModified! then
			
			SELECT	"dba"."sog_commerciale"."id_sog_commerciale"
				INTO	:ll_id_sog_commerciale
				FROM	"dba"."sog_commerciale"
				WHERE	"dba"."sog_commerciale"."codice" = :ls_codice_sc AND
						"dba"."sog_commerciale"."id_azienda" = 1 ;
			if sqlca.sqlcode=0 then
				this.SetItem(ll_row,"id_sog_commerciale",ll_id_sog_commerciale)
				this.SetItemStatus(ll_row, "id_sog_commerciale", Primary!, ldwis_stat2)
				if (ls_tipo_sc =	"C" or  ls_tipo_sc =	"F") then
					IF ls_codice_sc <> "" THEN
						SELECT	"dba"."conto"."id_conto"
							INTO	:ll_id_conto
							FROM	"dba"."conto"
							WHERE	"dba"."conto"."codice" = :ls_codice_sc AND
									"dba"."conto"."id_azienda" = 1 ;
					
						if SQLCA.SQLCode = 0 then
							UPDATE "sog_commerciale" SET "id_conto" = :ll_id_conto
							WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale;
						else
							MessageBox("Errore sul DataBase", "dw_scom_gen / ue_core_update-Problemi per trovare il conto")
							ll_errors ++
						end if
					end if
				end if
			else
				MessageBox("Errore sul DataBase", "dw_scom_gen / ue_core_update- Problemi per trovare id sog commerciale")
				ll_errors ++
			end if
		else
			if ldwis_stat1 <> New! then
				if (ls_tipo_sc =	"C" or  ls_tipo_sc =	"F") then
					IF ls_codice_sc <> "" THEN
						SELECT	"dba"."conto"."id_conto"
							INTO	:ll_id_conto
							FROM	"dba"."conto"
							WHERE	"dba"."conto"."codice" = :ls_codice_sc AND
									"dba"."conto"."id_azienda" = 1 ;
					
						if SQLCA.SQLCode = 0 then
							UPDATE "sog_commerciale" SET "id_conto" = :ll_id_conto
							WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale;
						else
							MessageBox("Errore sul DataBase", "dw_scom_gen / ue_core_update-Problemi per trovare il conto vecchio")
							ll_errors ++
						end if
					end if
				end if	
			else
				MessageBox("","Riga completamente nulla")
				ll_errors ++
			end if
		end if
		
	next
	long ll_id_anagrafica
ll_id_anagrafica = idw_master.getitemnumber(1,"id_anagrafica")

this.post retrieve(ll_id_anagrafica)
post uf_retrieve_campi_calcolati()

end if



return ll_errors

end event

event clicked;call super::clicked;CHOOSE CASE dwo.name
	CASE 'sm'	
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
			long ll_row
			ll_row=tab_1.tabpage_2.dw_scom_gen_ff.getrow()
			
			tab_1.tabpage_2.dw_scom_gen_ff.accepttext()
			ls_cod=tab_1.tabpage_2.dw_scom_gen_ff.getitemstring(ll_row,"tipo")
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
			tab_1.tabpage_2.dw_scom_gen_ff.GetChild('sm',ldwc_dddw )
			ldwc_dddw.setfilter("sottomastro_id_mastro="+string(ll_filtro))
			ldwc_dddw.filter()
			dwitemstatus ldw_stato
			ldw_stato=tab_1.tabpage_2.dw_scom_gen_ff.getitemstatus(ll_row,0,Primary!)
			if ldw_stato=NewModified! or ldw_stato=new! then
				setnull(q)
				ls_prval=""
				tab_1.tabpage_2.dw_scom_gen_ff.setitem(ll_row,"sm",q)
				tab_1.tabpage_2.dw_scom_gen_ff.setitem(ll_row,"codice",ls_prval)
			end if
		end if
end choose


end event

event getfocus;call super::getfocus;this.event post ue_setta_sottomastro()
end event

type dw_dest_scom_lt from u_dw_master_main within tabpage_2
integer x = 41
integer y = 596
integer width = 2341
integer height = 840
integer taborder = 3
boolean titlebar = true
string title = "Destinazioni"
string dataobject = "d_ac_dest_scom_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Destinazioni"
is_list.s_identifica[1] = "id_sog_commerciale"
is_resp_window =           "w_destinazione_ff"
is_list.s_win_chiave[1] =  "id_destinazione"
is_list.s_par_name[1] =    "id_sog_commerciale"
end event

type cb_1 from commandbutton within tabpage_2
integer x = 2071
integer y = 68
integer width = 197
integer height = 124
integer taborder = 20
string dragicon = "Question!"
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Saldi"
end type

event clicked;long ll_sogg

ll_sogg=dw_scom_gen_ff.getitemnumber(1,'id_sog_commerciale')

if not isnull(ll_sogg) then
  openwithparm(w_sit_sogg_comm_wz,ll_sogg)
  
  dw_scom_anag_lt.SetFocus ( )
end if  


end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Commerciale"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_scom_comm_ff dw_scom_comm_ff
end type

on tabpage_3.create
this.dw_scom_comm_ff=create dw_scom_comm_ff
this.Control[]={this.dw_scom_comm_ff}
end on

on tabpage_3.destroy
destroy(this.dw_scom_comm_ff)
end on

type dw_scom_comm_ff from u_dw_master_main within tabpage_3
integer x = 50
integer y = 52
integer width = 2331
integer height = 1372
integer taborder = 4
string dataobject = "d_ac_scom_comm_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = true
is_title = "Soggetto Commerciale"

is_list.s_colonne_drop[1] = "id_cat_attivita_cod"
is_list.s_colonne_drop[2] = "id_cat_attivita_des"
is_list.s_colonne_drop[3] = "id_cat_com_sc_cod"
is_list.s_colonne_drop[4] = "id_cat_com_sc_des"
is_list.s_colonne_drop[5] = "id_cat_zona_cod"
is_list.s_colonne_drop[6] = "id_cat_zona_des"
is_list.s_colonne_drop[7] = "id_listino_cod"
is_list.s_colonne_drop[8] = "id_listino_des_sl"
is_list.s_colonne_drop[9] = "id_tipo_trasporto_cod"
is_list.s_colonne_drop[10] = "id_tipo_trasporto_des"
is_list.s_colonne_drop[11] = "id_gruppo_agenti_cod"
is_list.s_colonne_drop[12] = "id_gruppo_agenti_des"
is_list.s_colonne_drop[13] = "id_gruppo_agenti_2"
is_list.s_colonne_drop[14] = "id_gruppo_agenti_2_des"

end event

event rowfocuschanged;

long		ll_row, ll_row_parent


ll_row_parent = iudw_parent.getRow()
ll_row = this.getRow()
if ll_row <> ll_row_parent then
	scrolltorow(ll_row_parent)
end if

end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol

	CASE "c_magazzino_cod"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_magazzino_des"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_vettore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
	CASE "c_vettore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
		
	
	CASE "c_vettore_2_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
	CASE "c_vettore_2_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
	
	
	CASE "id_cat_attivita"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "id_cat_attivita_des"
	CASE "id_cat_attivita_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "id_cat_attivita"

	CASE "id_cat_com_sc"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "id_cat_com_sc_des"
	CASE "id_cat_com_sc_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "id_cat_com_sc"

	CASE "id_cat_zona"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "id_cat_zona_des"
	CASE "id_cat_zona_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "id_cat_zona"

	CASE "id_tipo_trasporto"
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
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto"
		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873

		
END CHOOSE

end event

event ue_use_search;
  Choose case as_nomecol
	case "c_magazzino_cod"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_magazzino_des", is_ricpar.s_ausil_value[1])
				
				uf_set_colval( "id_magazzino", is_ricpar.s_ausil_value[2])
	case "c_magazzino_des"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_magazzino_cod", is_ricpar.s_ausil_value[1])
				
				uf_set_colval( "id_magazzino", is_ricpar.s_ausil_value[2])
				
	case "c_vettore_cod"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_vettore_des", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_sog_com_vettore", is_ricpar.s_id_seg_value[1])
				
	case "c_vettore_des"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_vettore_cod", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_sog_com_vettore", is_ricpar.s_id_seg_value[1])

	
	case "c_vettore_2_cod"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_vettore_2_des", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_sog_com_vettore_2", is_ricpar.s_id_seg_value[1])
				
	case "c_vettore_2_des"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_vettore_2_cod", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_sog_com_vettore_2", is_ricpar.s_id_seg_value[1])
end choose
end event

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_anagrafica, ll_id_banca_appoggio,ll_id_loc

ls_sql_cond = ""                              
CHOOSE CASE dwo.name
	CASE 'c_magazzino_cod'
      ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_magazzino_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_magazzino_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		if upperbound(ls_dbv) >0 then
			ll_id_loc=	long(ls_dbv[1])
			
			
			select min(id_locazione) 
			into :ll_id_loc
			from locazione
			where locazione.id_magazzino=:ll_id_loc;
			setitem(getrow(), "id_magazzino", ll_id_loc)
		end if

	CASE 'c_magazzino_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_magazzino_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_magazzino_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		if upperbound(ls_dbv) >0 then
			ll_id_loc=	long(ls_dbv[1])
			
			
			select min(id_locazione) 
			into :ll_id_loc
			from locazione
			where locazione.id_magazzino=:ll_id_loc;
			setitem(getrow(), "id_magazzino", ll_id_loc)
		end if

	CASE 'c_vettore_cod'
      ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_vettore"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_vettore_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_vettore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_vettore_des'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_vettore"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_vettore_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_vettore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE 'c_vettore_2_cod'
      ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_vettore_2"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_vettore_2_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_vettore_2_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_vettore_2_des'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_vettore_2"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_vettore_2_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_vettore_2_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE


end event

event clicked;call super::clicked;string		ls_nomedwo, ls_tipodwo

ls_nomedwo = dwo.name
ls_tipodwo = dwo.type

if ls_nomedwo = "cb_provvi" then
	uf_provvigioni()
end if
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Fatt.ne/Spese"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_spesa_scom_gd dw_spesa_scom_gd
dw_scom_fatt_ff dw_scom_fatt_ff
end type

on tabpage_4.create
this.dw_spesa_scom_gd=create dw_spesa_scom_gd
this.dw_scom_fatt_ff=create dw_scom_fatt_ff
this.Control[]={this.dw_spesa_scom_gd,&
this.dw_scom_fatt_ff}
end on

on tabpage_4.destroy
destroy(this.dw_spesa_scom_gd)
destroy(this.dw_scom_fatt_ff)
end on

type dw_spesa_scom_gd from u_dw_master_main within tabpage_4
integer x = 50
integer y = 828
integer width = 2336
integer height = 592
integer taborder = 3
string dataobject = "d_ac_spesa_scom_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Spese del Soggetto commerciale"
is_list.s_identifica[1] = "id_sog_commerciale"
is_list.s_colonne_drop[1] = "id_spesa_cod"
is_list.s_colonne_drop[2] = "id_spesa_des"

end event

event rowfocuschanged;call super::rowfocuschanged;

end event

event itemchanged;

integer  li_found
string	ls_tipo_importo
long		ll_id_spesa


CHOOSE CASE dwo.name
	CASE "id_spesa_cod", "id_spesa_des", "importo", "percentuale"
		if (dwo.name = "id_spesa_cod" or dwo.name = "id_spesa_des") then
			ll_id_spesa = long(data)
		else
			ll_id_spesa = this.getitemnumber(row, "id_spesa_cod")
		end if
		
		SELECT tipo_importo
		INTO	 :ls_tipo_importo
		FROM	 spesa
		WHERE  id_spesa = :ll_id_spesa
		;
END CHOOSE

CHOOSE CASE dwo.name
	CASE "id_spesa_cod", "id_spesa_des"
		this.setitem(row, "c_tipo_importo", ls_tipo_importo)
		
	CASE "importo", "percentuale"
		if (ls_tipo_importo = 'F' and this.getitemnumber(row, "percentuale") > 0) then
			messagebox("Attenzione", "Con tipo importo 'Fisso' i valori in percentuale non sono validi")
		elseif (ls_tipo_importo = 'P' and this.getitemnumber(row, "importo") > 0) then
			messagebox("Attenzione", "Con tipo importo 'Percentuale' i valori ad importo non sono validi")
		end if
END CHOOSE

end event

type dw_scom_fatt_ff from u_dw_master_main within tabpage_4
integer x = 50
integer y = 48
integer width = 2331
integer height = 764
integer taborder = 13
string dataobject = "d_ac_scom_fatt_ff"
end type

event rowfocuschanged;

long		ll_row, ll_row_parent


ll_row_parent = iudw_parent.getRow()
ll_row = this.getRow()
if ll_row <> ll_row_parent then
	scrolltorow(ll_row_parent)
end if

end event

event ue_init;call super::ue_init;ib_dw_shared = true
is_title = "Soggetto Commerciale"

is_list.s_colonne_drop[1] = "id_tab_iva"
is_list.s_colonne_drop[2] = "id_tab_iva_des"


end event

event ue_set_search;long		ll_id_azienda, ll_row


CHOOSE CASE as_nomecol

CASE "cod_contropartita"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		

CASE "des_contropartita"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		
end choose
end event

event ue_use_search;

CHOOSE CASE as_nomecol
   CASE "cod_contropartita"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_movimento_id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_contropartita", is_ricpar.s_ausil_value[1])
	CASE "des_contropartita"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_movimento_id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_contropartita", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_anagrafica, ll_id_banca_appoggio

ls_sql_cond = ""                              

CHOOSE CASE dwo.name
	CASE 'cod_contropartita'
		ls_sql_cond = "codice='"+data+"'"  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "con_movimento_id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "cod_contropartita"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "des_contropartita"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'des_contropartita'
		ls_sql_cond = "descrizione='"+data+"'"  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "con_movimento_id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "cod_contropartita"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "des_contropartita"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Pagamenti"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_banca_sog_commerciale_gd_t dw_banca_sog_commerciale_gd_t
dw_con_spec_scadenza_gd_t dw_con_spec_scadenza_gd_t
dw_banca_anag_gd dw_banca_anag_gd
dw_scad_anag_gd dw_scad_anag_gd
dw_scom_pag_ff dw_scom_pag_ff
end type

on tabpage_5.create
this.dw_banca_sog_commerciale_gd_t=create dw_banca_sog_commerciale_gd_t
this.dw_con_spec_scadenza_gd_t=create dw_con_spec_scadenza_gd_t
this.dw_banca_anag_gd=create dw_banca_anag_gd
this.dw_scad_anag_gd=create dw_scad_anag_gd
this.dw_scom_pag_ff=create dw_scom_pag_ff
this.Control[]={this.dw_banca_sog_commerciale_gd_t,&
this.dw_con_spec_scadenza_gd_t,&
this.dw_banca_anag_gd,&
this.dw_scad_anag_gd,&
this.dw_scom_pag_ff}
end on

on tabpage_5.destroy
destroy(this.dw_banca_sog_commerciale_gd_t)
destroy(this.dw_con_spec_scadenza_gd_t)
destroy(this.dw_banca_anag_gd)
destroy(this.dw_scad_anag_gd)
destroy(this.dw_scom_pag_ff)
end on

type dw_banca_sog_commerciale_gd_t from statictext within tabpage_5
integer x = 9
integer y = 36
integer width = 2226
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Banche"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_con_spec_scadenza_gd_t from statictext within tabpage_5
integer x = 9
integer y = 444
integer width = 2226
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Condizioni Speciali per Scadenze"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_banca_anag_gd from u_dw_master_main within tabpage_5
integer x = 9
integer y = 116
integer width = 2418
integer height = 292
integer taborder = 3
string dataobject = "d_ac_banca_anag_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Banche dell'anagrafica"
is_list.s_identifica[1] = "id_anagrafica"

end event

event ue_set_search;call super::ue_set_search;
string ls_modo_uso
long ll_row

ll_row = dw_banca_anag_gd.getrow()
if dw_banca_anag_gd.rowcount() > 0 then
	ls_modo_uso = dw_banca_anag_gd.getitemstring(ll_row,"modo_uso")
	if isnull(ls_modo_uso) then ls_modo_uso = 'S'
else
	ls_modo_uso = 'S'
end if

CHOOSE CASE as_nomecol
	CASE "cc_den_abi_cab"
		

		
		
		
		
    
	   if ls_modo_uso = 'S' then
			is_search_window = "w_banca_appoggio_sw" 
			is_ricpar.s_filter_value = as_valcol 
			is_ricpar.s_filter_name = "den_abi" 
			is_ricpar.b_AsNeeded = TRUE
		else
			is_search_window = "w_banca_azienda_sw" 
			is_ricpar.s_filter_value = as_valcol 
			is_ricpar.s_filter_name = "banca_appoggio_den_abi" 
			is_ricpar.b_AsNeeded = TRUE			
		end if
		
END CHOOSE
end event

event ue_use_search; 
string ls_modo_uso
long ll_row

ll_row = dw_banca_anag_gd.getrow()
if dw_banca_anag_gd.rowcount() > 0 then
	ls_modo_uso = dw_banca_anag_gd.getitemstring(ll_row,"modo_uso")
	if isnull(ls_modo_uso) then ls_modo_uso = 'S'
else
	ls_modo_uso = 'S'
end if

 Choose case as_nomecol
    case "cc_den_abi_cab"
		
	
		
		if ls_modo_uso = 'S' then
	         
				uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1]+" - "+&
				is_ricpar.s_ausil_value[3]+" - "+is_ricpar.s_main_value)
				uf_set_colval("id_banca_appoggio", is_ricpar.s_id_seg_value[1])
		else
	         
				uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[2]+" - "+is_ricpar.s_ausil_value[3]+&
				" - "+is_ricpar.s_main_value)
				uf_set_colval("id_banca_appoggio", is_ricpar.s_ausil_value[4])
				
		end if
	

 end choose
end event

type dw_scad_anag_gd from u_dw_master_main within tabpage_5
integer x = 9
integer y = 524
integer width = 2226
integer height = 372
integer taborder = 3
string dataobject = "d_ac_csscad_anag_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Condizioni speciali per scadenze"
is_list.s_identifica[1] = "id_anagrafica"
end event

event ue_validate_row;call super::ue_validate_row;

datawindow ld_con_spec_scad
long ll_CurrRow, li_g_inizio, li_m_inizio, li_g_fine, li_m_fine, li_g_app, li_m_app
boolean lb_Data_Inizio, lb_Data_Fine, lb_Data_App

ll_CurrRow 			= tab_1.tabpage_5.dw_scad_anag_gd.GetRow()
ld_con_spec_scad 	= tab_1.tabpage_5.dw_scad_anag_gd

li_g_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_inizio_periodo")
li_m_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_inizio_periodo")
li_g_fine 	= ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_fine_periodo")
li_m_fine 	= ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_fine_periodo")
li_g_app 	= ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_applicazione")
li_m_app 	= ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_applicazione")


lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
lb_Data_Fine 	= f_controlla_data_gm(li_g_fine, li_m_fine)
lb_Data_App 	= f_controlla_data_gm(li_g_app, li_m_app)


IF NOT lb_Data_Inizio THEN 
	
	as_error_text = "Il Giorno e il Mese Inizio non appartengono ad una data valida."
	RETURN 1
END IF

IF NOT lb_Data_Fine THEN 
	
	as_error_text = "Il Giorno e il Mese Fine non appartengono ad una data valida."
	RETURN 1
END IF

IF NOT lb_Data_App THEN 
	
	as_error_text = "Il Giorno e il Mese Applicazione non appartengono ad una data valida."
	RETURN 1
END IF

RETURN 0
end event

event itemchanged;call super::itemchanged;
datawindow ld_con_spec_scad
long ll_CurrRow, li_g_inizio, li_m_inizio, li_g_fine, li_m_fine, li_g_app, li_m_app
boolean lb_Data_Inizio, lb_Data_Fine, lb_Data_App

ll_CurrRow = GetRow()
ld_con_spec_scad = this
CHOOSE CASE dwo.name
	CASE "giorno_inizio_periodo"
		li_m_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_inizio_periodo")
		li_g_inizio = LONG(data)
		
		lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
		IF NOT lb_Data_Inizio THEN 
			MessageBox(is_title, "Il Giorno e il Mese Inizio non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "mese_inizio_periodo"
		li_g_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_inizio_periodo")
		li_m_inizio = LONG(data)
		
		lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
		IF NOT lb_Data_Inizio THEN 
			MessageBox(is_title, "Il Giorno e il Mese Inizio non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "giorno_fine_periodo"
		li_m_fine = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_fine_periodo")
		li_g_fine = LONG(data)
		
		lb_Data_Fine = f_controlla_data_gm(li_g_fine, li_m_fine)
	
		IF NOT lb_Data_Fine THEN 
			MessageBox(is_title, "Il Giorno e il Mese Fine non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "mese_fine_periodo"
		li_g_fine = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_fine_periodo")
		li_m_fine = LONG(data)
		
		lb_Data_Fine = f_controlla_data_gm(li_g_fine, li_m_fine)
	
		IF NOT lb_Data_Fine THEN 
			MessageBox(is_title, "Il Giorno e il Mese Fine non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "giorno_applicazione"	
		li_m_app = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_applicazione")
		li_g_app = LONG(data)
		
		lb_Data_App = f_controlla_data_gm(li_g_app, li_m_app)
		IF NOT lb_Data_App THEN 
			MessageBox(is_title, "Il Giorno e il Mese Applicazione non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "mese_applicazione"	
		li_g_app = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_applicazione")
		li_m_app = LONG(data)
		
		lb_Data_App = f_controlla_data_gm(li_g_app, li_m_app)
		IF NOT lb_Data_App THEN 
			MessageBox(is_title, "Il Giorno e il Mese Applicazione non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
END CHOOSE

end event

type dw_scom_pag_ff from u_dw_master_main within tabpage_5
integer x = 9
integer y = 924
integer width = 2226
integer height = 372
integer taborder = 3
string dataobject = "d_ac_scom_pag_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = true
is_title = "Soggetto Commerciale"


end event

event rowfocuschanged;

long		ll_row, ll_row_parent


ll_row_parent = iudw_parent.getRow()
ll_row = this.getRow()
if ll_row <> ll_row_parent then
	scrolltorow(ll_row_parent)
end if

end event

event ue_set_search;call super::ue_set_search;
long ll_id_anagrafica
ll_id_anagrafica=tab_1.tabpage_1.dw_anag_gen_ff.getitemnumber(1,"id_anagrafica")

Choose case as_nomecol

	CASE "c_condpag_cod"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_condpag_des"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	CASE "c_abi_cab_des"
		is_search_window = "w_banca_sog_commerciale_gen_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_den_abi_cab" 
		
		is_ricpar.s_sql_cond="banca_sog_commerciale_gen.id_anagrafica="+string(ll_id_anagrafica)
end choose
end event

event ue_use_search;
 Choose case as_nomecol
	case "c_condpag_cod"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_condpag_des", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_con_pagamento", is_ricpar.s_id_seg_value[1])
	case  "c_condpag_des"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "c_condpag_cod", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_con_pagamento", is_ricpar.s_id_seg_value[1])
    case "c_abi_cab_des"
	         uf_set_colval( as_nomecol, is_ricpar.s_ausil_value[3]+" - "+is_ricpar.s_ausil_value[5]+" - "+&
				is_ricpar.s_main_value)
				uf_set_colval( "id_banca_sog_commerciale", is_ricpar.s_id_seg_value[1])
				uf_set_colval( "c_conto_corrente", is_ricpar.s_ausil_value[1])
				uf_set_colval( "c_cin", is_ricpar.s_ausil_value[2])				
				
 end choose
 

end event

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_anagrafica, ll_id_banca_appoggio

ls_sql_cond = ""                              
CHOOSE CASE dwo.name

CASE 'c_abi_cab_des'
	
		ls_sql_cond = "banca_sog_commerciale_gen.id_anagrafica = "+ uf_get_colval("id_anagrafica")	
		ls_dbc[1] = "id_banca_sog_commerciale"
		ls_dwc[1] = "id_banca_sog_commerciale"
		ls_dbc[2] = "conto_corrente"
		ls_dwc[2] = "c_conto_corrente"
		ls_dbc[3] = "cin"
		ls_dwc[3] = "c_cin"
		ls_dbc[4] = "den_abi"
		ls_dwc[4] = "c_abi_cab_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "banca_sog_commerciale_gen", &  
										"den_abi" + ' - ' + "den_cab", "A", data, & 
										ls_sql_cond, 4, &
					               ls_dbc, ls_dbv, ls_dwc)	
		IF (ll_ok > 0) THEN
			
			RETURN 2
		END IF

	CASE 'c_condpag_cod'
		
      ls_sql_cond = ""  
		ls_dbc[1] = "id_con_pagamento"
		ls_dwc[1] = "id_con_pagamento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_condpag_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_condpag_des"
		ll_ok = uf_autofind_col(dwo.Name, "con_pagamento", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_condpag_des'

		ls_sql_cond = ""  
		ls_dbc[1] = "id_con_pagamento"
		ls_dwc[1] = "id_con_pagamento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_condpag_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_condpag_des"
		ll_ok = uf_autofind_col(dwo.Name, "con_pagamento", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


	
	




end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Ritenute"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_anag_rit_ff dw_anag_rit_ff
dw_scom_rit_ff dw_scom_rit_ff
end type

on tabpage_6.create
this.dw_anag_rit_ff=create dw_anag_rit_ff
this.dw_scom_rit_ff=create dw_scom_rit_ff
this.Control[]={this.dw_anag_rit_ff,&
this.dw_scom_rit_ff}
end on

on tabpage_6.destroy
destroy(this.dw_anag_rit_ff)
destroy(this.dw_scom_rit_ff)
end on

type dw_anag_rit_ff from u_dw_master_main within tabpage_6
event ue_proteggi_percentuali ( )
integer x = 55
integer y = 44
integer width = 2345
integer height = 932
integer taborder = 3
string dataobject = "d_ac_anag_compl_rit_ff"
end type

event ue_proteggi_percentuali;call super::ue_proteggi_percentuali;




return 
end event

event ue_init;call super::ue_init;ib_dw_shared = true
is_title = "Anagrafica - Ritenute"
end event

event itemfocuschanged;call super::itemfocuschanged;integer li_RetVal

CHOOSE CASE string(dwo.name)
	CASE "con_previdenziale", "cassa_previdenza", "rit_previdenziale"
		THIS.PostEvent("ue_Proteggi_Percentuali")
END CHOOSE

li_RetVal = Super::Event ItemFocusChanged(row, dwo)
RETURN li_RetVal
end event

event ue_retrieve;call super::ue_retrieve;THIS.Event ue_Proteggi_Percentuali()
end event

type dw_scom_rit_ff from u_dw_master_main within tabpage_6
integer x = 50
integer y = 1004
integer width = 2350
integer height = 432
integer taborder = 3
string dataobject = "d_ac_scom_rit_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = true
is_title = "Soggetto Commerciale"

is_list.s_colonne_drop[1] = "id_tributo"
is_list.s_colonne_drop[2] = "id_tributo_des"
is_list.s_colonne_drop[3] = "id_att_svolta"
is_list.s_colonne_drop[4] = "id_att_svolta_des"
end event

event rowfocuschanged;

long		ll_row, ll_row_parent

ll_row_parent = iudw_parent.getRow()
ll_row = this.getRow()
if ll_row <> ll_row_parent then
	scrolltorow(ll_row_parent)
end if

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_att_svolta"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_att_svolta_gd"
		is_ricpar.s_titolo_finestra = "Attività Svolte"
		is_ricpar.s_ausil_value[1] = "id_att_svolta_des"
		
		
	CASE "id_att_svolta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_att_svolta_gd"
		is_ricpar.s_titolo_finestra = "Attività Svolte"
		is_ricpar.s_ausil_value[1] = "id_att_svolta"
		
		
	CASE "id_tributo"
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
		is_ricpar.s_ausil_value[1] = "id_tributo"
		is_ricpar.i_width = 2917                     
		is_ricpar.i_height = 869
		
END CHOOSE

end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Altro"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_telefono_lt_t dw_telefono_lt_t
dw_ann_anag_gd_t dw_ann_anag_gd_t
dw_tel_anag_lt dw_tel_anag_lt
dw_ann_scom_gd dw_ann_scom_gd
end type

on tabpage_7.create
this.dw_telefono_lt_t=create dw_telefono_lt_t
this.dw_ann_anag_gd_t=create dw_ann_anag_gd_t
this.dw_tel_anag_lt=create dw_tel_anag_lt
this.dw_ann_scom_gd=create dw_ann_scom_gd
this.Control[]={this.dw_telefono_lt_t,&
this.dw_ann_anag_gd_t,&
this.dw_tel_anag_lt,&
this.dw_ann_scom_gd}
end on

on tabpage_7.destroy
destroy(this.dw_telefono_lt_t)
destroy(this.dw_ann_anag_gd_t)
destroy(this.dw_tel_anag_lt)
destroy(this.dw_ann_scom_gd)
end on

type dw_telefono_lt_t from statictext within tabpage_7
integer x = 50
integer y = 44
integer width = 2345
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = "Telefoni dell~'anagrafica"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_ann_anag_gd_t from statictext within tabpage_7
integer x = 50
integer y = 660
integer width = 2345
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = "Annotazioni del soggetto commerciale"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_tel_anag_lt from u_dw_master_main within tabpage_7
integer x = 50
integer y = 124
integer width = 2341
integer height = 500
integer taborder = 3
string dataobject = "d_ac_tel_anag_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Telefoni"
is_resp_window = "w_telefono_ff"
is_list.s_identifica[1] = "id_anagrafica"
is_list.s_win_chiave[1] = "id_telefono"
is_list.s_par_name[1] = "id_anagrafica"


end event

type dw_ann_scom_gd from u_dw_master_main within tabpage_7
integer x = 50
integer y = 740
integer width = 2345
integer height = 688
integer taborder = 3
string dataobject = "d_annotazione_anag_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Annotazioni"
is_list.s_identifica[1] = "id_sog_commerciale"
is_list.s_colonne_drop[1] = "id_tipo_annotazione"


end event

event rowfocuschanged;call super::rowfocuschanged;

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

type tabpage_8 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 104
integer width = 2427
integer height = 1456
long backcolor = 79741120
string text = "Liq. provv."
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_scom_age_ff dw_scom_age_ff
cb_premi_penalita cb_premi_penalita
cb_budget cb_budget
cb_liq_provvigioni cb_liq_provvigioni
cb_gruppo_agenti cb_gruppo_agenti
end type

on tabpage_8.create
this.dw_scom_age_ff=create dw_scom_age_ff
this.cb_premi_penalita=create cb_premi_penalita
this.cb_budget=create cb_budget
this.cb_liq_provvigioni=create cb_liq_provvigioni
this.cb_gruppo_agenti=create cb_gruppo_agenti
this.Control[]={this.dw_scom_age_ff,&
this.cb_premi_penalita,&
this.cb_budget,&
this.cb_liq_provvigioni,&
this.cb_gruppo_agenti}
end on

on tabpage_8.destroy
destroy(this.dw_scom_age_ff)
destroy(this.cb_premi_penalita)
destroy(this.cb_budget)
destroy(this.cb_liq_provvigioni)
destroy(this.cb_gruppo_agenti)
end on

type dw_scom_age_ff from u_dw_master_main within tabpage_8
integer x = 27
integer y = 44
integer width = 2345
integer height = 1384
integer taborder = 3
string dataobject = "d_scom_age_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = true
is_title = "Dati Agente"

is_list.s_colonne_drop[1] = "id_tipo_agente"
is_list.s_colonne_drop[2] = "id_valuta"
is_list.s_colonne_drop[3] = "id_val_prov_agente"
is_list.s_colonne_drop[4] = "id_tab_iva_fat_prov"
end event

type cb_premi_penalita from commandbutton within tabpage_8
boolean visible = false
integer x = 1568
integer y = 496
integer width = 649
integer height = 84
integer taborder = 4
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Premi Penalità"
end type

event clicked;
Long	ll_id_sog_commerciale, ll_row

ll_row = tab_1.tabpage_8.dw_scom_age_ff.GetRow()

ll_id_sog_commerciale = tab_1.tabpage_8.dw_scom_age_ff.Object.id_sog_commerciale[ll_row]
if not(IsNull(ll_id_sog_commerciale)) And (ll_id_sog_commerciale <> 0) then
	Openwithparm(w_premi_penalita_sog_comm_lt, ll_id_sog_commerciale)
end if
end event

type cb_budget from commandbutton within tabpage_8
boolean visible = false
integer x = 1568
integer y = 672
integer width = 649
integer height = 84
integer taborder = 5
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Budget e Premi ad Importo"
end type

event clicked;
Long	ll_id_sog_commerciale, ll_row

ll_row = tab_1.tabpage_8.dw_scom_age_ff.GetRow()
ll_id_sog_commerciale = tab_1.tabpage_8.dw_scom_age_ff.Object.id_sog_commerciale[ll_row]

if not(IsNull(ll_id_sog_commerciale)) And (ll_id_sog_commerciale <> 0) then
	Openwithparm(w_budget_sog_comm_lt, ll_id_sog_commerciale)
end if
end event

type cb_liq_provvigioni from commandbutton within tabpage_8
boolean visible = false
integer x = 1568
integer y = 848
integer width = 649
integer height = 84
integer taborder = 6
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importi di &Liq. provv."
end type

event clicked;
Long	ll_id_sog_commerciale, ll_row

ll_row = tab_1.tabpage_8.dw_scom_age_ff.GetRow()
ll_id_sog_commerciale = tab_1.tabpage_8.dw_scom_age_ff.Object.id_sog_commerciale[ll_row]

if not(IsNull(ll_id_sog_commerciale)) And (ll_id_sog_commerciale <> 0) then
	Openwithparm(w_liq_provvigione_sog_comm_lt, ll_id_sog_commerciale)
end if
end event

type cb_gruppo_agenti from commandbutton within tabpage_8
integer x = 1568
integer y = 320
integer width = 649
integer height = 84
integer taborder = 4
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Gruppo Agenti"
end type

event clicked;
String	ls_codice
Integer	li_Row


li_Row = tab_1.tabpage_8.dw_scom_age_ff.GetRow()


ls_codice = tab_1.tabpage_8.dw_scom_age_ff.Object.codice[li_Row]
if not(IsNull(ls_codice)) then
	long 		ll_gruppo
	string 	ls_cod

	s_list_main ls_list_app
	
	SELECT id_gruppo_agenti
	INTO	 :ll_gruppo
	FROM 	 gruppo_agenti
	WHERE	 codice=:ls_codice
	;
	
	CHOOSE CASE SQLCA.SQLCODE 
		CASE -1 
			MessageBox("Anagrafiche Condivise", SQLCA.SQLERRTEXT)
		CASE 0
			ls_list_app.s_identifica[1]="id_gruppo_agenti"
			ls_list_app.s_sql_ident[1]="id_gruppo_agenti"
			ls_list_app.s_win_chiave[1]="id_gruppo_agenti"
			ls_list_app.l_win_chiave[1]=ll_gruppo
			ls_list_app.l_identifica[1]=ll_gruppo
			ls_list_app.s_modo=modo_modifica

			OpenSheetWithParm( w_gruppo_agenti_cx, ls_list_app, w_app_frame, 0, Original!)	
		END CHOOSE
End If				



end event

type dw_scom_anag_lt from u_dw_master_main within w_anag_2_cx
integer x = 23
integer y = 260
integer width = 571
integer height = 1508
integer taborder = 10
string dataobject = "d_ac_scom_anag_lt"
boolean hscrollbar = true
end type

event ue_init;call super::ue_init;is_title 					= "Soggetto Commerciale"
is_list.s_identifica[1] = "id_anagrafica"

iudw_children[1] = tab_1.tabpage_2.dw_scom_gen_ff
iudw_children[2] = tab_1.tabpage_2.dw_dest_scom_lt
iudw_children[3] = tab_1.tabpage_3.dw_scom_comm_ff
iudw_children[4] = tab_1.tabpage_4.dw_scom_fatt_ff
iudw_children[5] = tab_1.tabpage_4.dw_spesa_scom_gd
iudw_children[6] = tab_1.tabpage_5.dw_scom_pag_ff
iudw_children[7] = tab_1.tabpage_6.dw_scom_rit_ff
iudw_children[8] = tab_1.tabpage_7.dw_ann_scom_gd
iudw_children[9] = tab_1.tabpage_8.dw_scom_age_ff



end event

event rowfocuschanged;call super::rowfocuschanged;
long ll_row
long ll_id_con_pagamento,ll_row_pag
string ls_codice_pagamento,ls_descrizione_pagamento
ll_row = GetRow()
ll_row_pag=tab_1.tabpage_5.dw_scom_pag_ff.getrow()
if ll_row <> ll_row_pag then ll_row = ll_row_pag

SelectRow(0, false)
SelectRow(ll_row, true)
ll_row_pag=tab_1.tabpage_5.dw_scom_pag_ff.getrow()

tab_1.tabpage_2.dw_scom_gen_ff.event post ue_setta_sottomastro()
if ll_row_pag>0 then
	ll_id_con_pagamento=tab_1.tabpage_5.dw_scom_pag_ff.getitemnumber(ll_row_pag,"id_con_pagamento")
	

	select "con_pagamento"."codice" , "con_pagamento"."descrizione" 
	into 	 :ls_codice_pagamento,:ls_descrizione_pagamento
	from   "dba"."con_pagamento"
	where  ("con_pagamento"."id_con_pagamento" = :ll_id_con_pagamento);
		
	tab_1.tabpage_5.dw_scom_pag_ff.SetItem( ll_row_pag,"c_condpag_cod",ls_codice_pagamento )
	tab_1.tabpage_5.dw_scom_pag_ff.SetItem( ll_row_pag,"c_condpag_des",ls_descrizione_pagamento)
	
	String ls_tipo
	ls_tipo = This.GetItemString(ll_row, "tipo")

	If ls_tipo = 'A' Then
		tab_1.tabpage_8.Visible = TRUE
	Else
		tab_1.tabpage_8.Visible = FALSE
	End If
end if 
end event

event ue_delete;call super::ue_delete;triggerevent("rowfocuschanged")
end event

event ue_retrieve;call super::ue_retrieve;triggerevent("rowfocuschanged")
end event

event ue_insert;call super::ue_insert;

long ll_id_linguaggio
string ls_colonna

 	  SELECT "par_sistema"."id_linguaggio"  
		 INTO :ll_id_linguaggio  
		 FROM "par_sistema"  ;
		
		TAB_1.TABPAGE_2.dw_scom_gen_ff.SetItem(TAB_1.TABPAGE_2.dw_scom_gen_ff.GETROW(),"id_linguaggio_cod",ll_id_linguaggio)
		ls_colonna="tipo"
		SETFOCUS(TAB_1.TABPAGE_2.dw_scom_gen_ff)
		POST F_SET_COLUMN(TAB_1.TABPAGE_2.dw_scom_gen_ff,LS_COLONNA)
end event

event updateend;string rs_tipo,ls_applicazione, rs_chiave
long ll_righe,ll_conto,ll_row,ll_id_sog_com, ll_id_contropartita
DATASTORE con_movimento


con_movimento=CREATE DATASTORE
con_movimento.DataObject="d_con_movimento_gd"
con_movimento.SetTransObject(SQLCA)

for ll_row= 1 to upperbound(il_contropartita)
		
			ll_id_sog_com=GetItemNumber(il_riga_conto[ll_row],"id_sog_commerciale")
			rs_chiave="0-0-"+string(ll_id_sog_com)+"-0-0-0"
			rs_tipo=GetItemString(il_riga_conto[ll_row],"Tipo")
			
			CHOOSE CASE rs_tipo
				CASE "C"
					ls_applicazione="V"
				CASE "F"
					ls_applicazione="A"
			END CHOOSE
	
		ll_righe=con_movimento.Retrieve(rs_chiave, ls_applicazione)
		
	
		if  ll_righe>0 then
				
				if isnull(il_contropartita[ll_row]) then
					con_movimento.deleterow(ll_righe)
				else
					con_movimento.SetItem(ll_righe,"applicazione",ls_applicazione)
					con_movimento.SetItem(ll_row,"id_conto",il_contropartita[ll_row])
					con_movimento.SetItem(ll_righe,"id_sog_commerciale",ll_id_sog_com)
					con_movimento.SetItem(ll_righe,"chiave",rs_chiave)
				end if
				ll_righe=con_movimento.update()
				if(ll_righe<>1) then MessageBox("Errore","Conto del soggetto commerciale non salvato")
		else
				if il_contropartita[ll_row]>0 then 
					ll_righe=con_movimento.InsertRow(0)
					con_movimento.SetItem(ll_righe,"applicazione",ls_applicazione)
					con_movimento.SetItem(ll_righe,"id_conto",il_contropartita[ll_row])
					con_movimento.SetItem(ll_righe,"id_sog_commerciale",ll_id_sog_com)
					con_movimento.SetItem(ll_righe,"chiave",rs_chiave)
					ll_righe=con_movimento.update()
					if(ll_righe<>1) then MessageBox("Errore","Conto del soggetto commerciale non salvato")
				end if
		end if
next
destroy(con_movimento)   

end event

event updatestart;
long ll_row
integer li_contatore
for ll_row= 1 to rowcount()
	CHOOSE CASE getitemstatus(LL_ROW, "con_movimento_id_conto", primary!)
		CASE datamodified! , newmodified!
			li_contatore++
			il_contropartita[li_contatore]=getitemnumber(ll_row, "con_movimento_id_conto")
			il_riga_conto[li_contatore]=ll_row
	end choose
next
end event

event retrieveend;
uf_retrieve_campi_calcolati()

end event

type st_1 from statictext within w_anag_2_cx
integer x = 23
integer y = 180
integer width = 571
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = "Seleziona / Inserisci"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_cond_lis from commandbutton within w_anag_2_cx
integer x = 1536
integer y = 48
integer width = 329
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cond. Listino"
end type

event clicked;
string ls_filtro,ls_codice
long ll_seg_value
w_search_main lw_sm

ls_codice=""
ls_codice = dw_scom_anag_lt.getitemstring(1, "codice")
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="sog_commerciale_gen_codice"
idw_master.is_ricpar.s_SQL_cond = ""	
openwithparm(lw_sm, idw_master.is_ricpar, "w_conlisarticolo_sw")

end event

type cb_2 from commandbutton within w_anag_2_cx
boolean visible = false
integer x = 992
integer y = 48
integer width = 128
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "??"
end type

event clicked;
dw_scom_anag_lt.deleterow(0)

end event

