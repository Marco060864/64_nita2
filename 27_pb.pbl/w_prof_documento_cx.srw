forward
global type w_prof_documento_cx from w_p_data
end type
type dw_prof_documento_gen_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_prof_documento_mag_ff from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_prof_documento_mag_ff dw_prof_documento_mag_ff
end type
type tabpage_3 from userobject within tab_1
end type
type dw_prof_documento_fatt_ff from u_dw_master_main within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_prof_documento_fatt_ff dw_prof_documento_fatt_ff
end type
type tabpage_4 from userobject within tab_1
end type
type dw_prof_documento_comm_ff from u_dw_master_main within tabpage_4
end type
type dw_prof_documento_trasp_ff from u_dw_master_main within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_prof_documento_comm_ff dw_prof_documento_comm_ff
dw_prof_documento_trasp_ff dw_prof_documento_trasp_ff
end type
type tabpage_6 from userobject within tab_1
end type
type dw_prof_documento_riga_ff from u_dw_master_main within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_prof_documento_riga_ff dw_prof_documento_riga_ff
end type
type tabpage_7 from userobject within tab_1
end type
type dw_prof_documento_deriv_gd from u_dw_master_main within tabpage_7
end type
type dw_prof_documento_altro_ff from u_dw_master_main within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_prof_documento_deriv_gd dw_prof_documento_deriv_gd
dw_prof_documento_altro_ff dw_prof_documento_altro_ff
end type
type cb_1 from commandbutton within w_prof_documento_cx
end type
type cb_righe_automatiche from commandbutton within w_prof_documento_cx
end type
end forward

global type w_prof_documento_cx from w_p_data
integer x = 329
integer width = 2971
integer height = 1676
string title = "Profili Documenti"
cb_1 cb_1
cb_righe_automatiche cb_righe_automatiche
end type
global w_prof_documento_cx w_prof_documento_cx

type variables
string is_last_field
end variables

forward prototypes
public function integer wf_proponi_locazione ()
public subroutine wf_riempi_campi_calcolati ()
public subroutine wf_cerca_file (integer row)
end prototypes

public function integer wf_proponi_locazione ();

Long	ll_locazione
Long	ll_row
String	ls_codice



ll_row = Tab_1.TabPage_2.dw_prof_documento_mag_ff.GetRow()

ll_locazione= Tab_1.TabPage_2.dw_prof_documento_mag_ff.getItemnumber(ll_row,'id_locazione_1_prop')
if ll_locazione<1 or isnull(ll_locazione) then
	
	SELECT par_sistema.id_locazione
	INTO	:ll_locazione
	FROM	par_sistema;
	
	SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_codice
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",
			"dba"."magazzino"
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and
			( ( "locazione"."id_locazione" = :ll_locazione ) );
	
	
	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_locazione_1_cod',ls_codice)
	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'id_locazione_1_prop',ll_locazione)
end if
RETURN 0
end function

public subroutine wf_riempi_campi_calcolati ();

Long 		ll_id_mod_registro
String	ls_des_mod_registro 

ll_id_mod_registro = tab_1.tabpage_1.dw_prof_documento_gen_ff.GetItemNumber(1, "id_mod_registro_prop")

SELECT descrizione
INTO	 :ls_des_mod_registro
FROM	 mod_registro
WHERE	 id_mod_registro = :ll_id_mod_registro
;

tab_1.tabpage_1.dw_prof_documento_gen_ff.SetItem(1, "c_registro_des", ls_des_mod_registro)


Long 		ll_id_prof_registrazione
String	ls_cod, ls_des
	ll_id_prof_registrazione = tab_1.tabpage_3.dw_prof_documento_fatt_ff.GetItemNumber(1, "id_prof_registrazione")

SELECT codice, descrizione
INTO	 :ls_cod, :ls_des
FROM	 prof_registrazione
WHERE	 id_prof_registrazione = :ll_id_prof_registrazione
;

tab_1.tabpage_3.dw_prof_documento_fatt_ff.SetItem(1, "c_prof_registrazione_cod", ls_cod)
tab_1.tabpage_3.dw_prof_documento_fatt_ff.SetItem(1, "c_prof_registrazione_des", ls_des)

Long 		ll_id_sog_com_vettore_prop

ll_id_sog_com_vettore_prop = tab_1.tabpage_4.dw_prof_documento_trasp_ff.GetItemNumber(1, "id_sog_comm_vettore_1_prop")

SELECT s.codice, a.rag_soc_1
INTO	 :ls_cod, :ls_des
FROM	 sog_commerciale s, anagrafica a
WHERE	 s.id_sog_commerciale = :ll_id_sog_com_vettore_prop
AND	 a.id_anagrafica = s.id_anagrafica
;

if (sqlca.sqlcode = 0) then
	tab_1.tabpage_4.dw_prof_documento_trasp_ff.SetItem(1, "c_sog_comm_vett_cod", ls_cod)
	tab_1.tabpage_4.dw_prof_documento_trasp_ff.SetItem(1, "c_sog_comm_vett_des", ls_des)
end if
	

ll_id_sog_com_vettore_prop = tab_1.tabpage_4.dw_prof_documento_trasp_ff.GetItemNumber(1, "id_sog_comm_vettore_2_prop")

SELECT s.codice, a.rag_soc_1
INTO	 :ls_cod, :ls_des
FROM	 sog_commerciale s, anagrafica a
WHERE	 s.id_sog_commerciale = :ll_id_sog_com_vettore_prop
AND	 a.id_anagrafica = s.id_anagrafica
;

if (sqlca.sqlcode = 0) then
	
	tab_1.tabpage_4.dw_prof_documento_trasp_ff.SetItem(1, "c_sog_comm_vett_cod_2", ls_cod)
	tab_1.tabpage_4.dw_prof_documento_trasp_ff.SetItem(1, "c_sog_comm_vett_des_2", ls_des)
end if

end subroutine

public subroutine wf_cerca_file (integer row);integer li_ret
string ls_path, ls_file
	
getfileopenname("Cerca report", ls_path, ls_file)
if  not(trim(ls_file)="" or isnull(ls_file)) then
	li_ret=messagebox("Richiesta conferma!","Vuoi riportare il solo nome del file?", Information!,yesno! )
	if  li_ret=1 then
		 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_file)
	else
		 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
	end if
end if	 
end subroutine

on w_prof_documento_cx.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_righe_automatiche=create cb_righe_automatiche
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_righe_automatiche
end on

on w_prof_documento_cx.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_righe_automatiche)
end on

event open;call super::open;integer li_test 
il_HelpTopic = 59

idw_master = tab_1.tabpage_1.dw_prof_documento_gen_ff
idw_master.is_list = Message.PowerObjectParm
If upperbound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "prof_documento.id_prof_documento"

select table_id
into :li_test
from systable
where table_name='orafo_par_sistema';
if li_test>0 then
	cb_righe_automatiche.visible=true
end if
end event

event ue_post_open;call super::ue_post_open;
if idw_master.is_list.s_modo = modo_modifica then
	this.tab_1.tabpage_1.dw_prof_documento_gen_ff.Object.tipo_registro.protect 	= 1
	this.tab_1.tabpage_1.dw_prof_documento_gen_ff.Object.c_registro_des.protect 	= 1
end if	




cb_ricerca.Visible = TRUE

wf_proponi_locazione()

end event

event ue_master_delete;call super::ue_master_delete;

if (idw_master.Event ue_delete(0, 0) = 0) then
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

event ue_delete;call super::ue_delete;

end event

type p_msg_log from w_p_data`p_msg_log within w_prof_documento_cx
end type

type p_crescente from w_p_data`p_crescente within w_prof_documento_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_prof_documento_cx
end type

type cb_ok from w_p_data`cb_ok within w_prof_documento_cx
integer x = 37
integer y = 32
end type

type cb_annulla from w_p_data`cb_annulla within w_prof_documento_cx
integer x = 329
integer y = 32
end type

type cb_nuovo from w_p_data`cb_nuovo within w_prof_documento_cx
integer x = 622
integer y = 32
end type

event cb_nuovo::clicked;call super::clicked;

wf_proponi_locazione()

end event

type cb_inserisci from w_p_data`cb_inserisci within w_prof_documento_cx
integer x = 2085
integer y = 32
end type

type cb_cancella from w_p_data`cb_cancella within w_prof_documento_cx
integer x = 2377
integer y = 32
end type

type cb_salva from w_p_data`cb_salva within w_prof_documento_cx
integer x = 2670
integer y = 32
end type

event cb_salva::clicked;string ls_contabilizza, ls_intestatari
integer li_ret

ls_contabilizza=tab_1.tabpage_3.dw_prof_documento_fatt_ff.getitemstring(1,'contabilizzabile')

if ls_contabilizza='S' then
		ls_intestatari=tab_1.tabpage_2.dw_prof_documento_mag_ff.getitemstring(1,'int_consentiti')
		CHOOSE CASE ls_intestatari
			CASE	'FC', 'CF' , 'C' ,'F'
				parent.TriggerEvent("ue_update")

	      CASE ELSE
            li_ret=messagebox('Attenzione','I documenti creati con questo profilo potranno essere contabilizzati~r~n'&
				+'pertanto gli unici intestatari potranno essere C-clienti, F-fornitori.~r~n'&
				+'Premere OK per proseguire il salvataggio o Annulla per modificare il profilo',Information!,OKCancel!)
		      if li_ret=1 then
					  tab_1.tabpage_2.dw_prof_documento_mag_ff.setitem(1,'int_consentiti','CF')
      		     parent.TriggerEvent("ue_update")
		      else 
					return
				end if	
		
		END CHOOSE

else 
	parent.TriggerEvent("ue_update")

end if


end event

type tab_1 from w_p_data`tab_1 within w_prof_documento_cx
integer x = 32
integer y = 148
integer width = 2903
integer height = 1432
long backcolor = 79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_6
this.Control[iCurrent+5]=this.tabpage_7
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 2866
integer height = 1312
long backcolor = 79741120
string text = "Generale"
long tabbackcolor = 79741120
dw_prof_documento_gen_ff dw_prof_documento_gen_ff
end type

on tabpage_1.create
this.dw_prof_documento_gen_ff=create dw_prof_documento_gen_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_prof_documento_gen_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_prof_documento_gen_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_prof_documento_cx
integer x = 1472
integer y = 32
end type

event cb_ricerca::clicked;

string ls_filtro,ls_codice,ls_codice2, ls_codice_sog, ls_rag1_sog
long ll_seg_value, ll_id_sog_com

w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="prof_documento_codice"
openwithparm(lw_sm,idw_master.is_ricpar,"w_prof_documento_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_prof_documento"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()


Long ll_locazione,ll_locazione2 , ll_row, ll_id_sog_com_prop
String ls_cod

ll_row = Tab_1.TabPage_1.dw_prof_documento_gen_ff.GetRow()
ls_cod = tab_1.tabpage_1.dw_prof_documento_gen_ff.GetItemString(ll_row,"codice")


   
	
	SELECT prof_documento.id_locazione_1_prop,prof_documento.id_locazione_2_prop,prof_documento.id_sog_comm_prop
	INTO	:ll_locazione,:ll_locazione2, :ll_id_sog_com_prop
	FROM	prof_documento
	WHERE :ls_cod = prof_documento.codice;	
   
	






	SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_codice
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",
			"dba"."magazzino"
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and
			( ( "locazione"."id_locazione" = :ll_locazione ) );
SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_codice2
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",
			"dba"."magazzino"
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and
			( ( "locazione"."id_locazione" = :ll_locazione2 ) );

ll_row = Tab_1.TabPage_2.dw_prof_documento_mag_ff.GetRow()
Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_locazione_2_cod',ls_codice2)
Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_locazione_1_cod',ls_codice)
Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'id_locazione_2_prop',ll_locazione2)
Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'id_locazione_1_prop',ll_locazione)

select codice, rag_soc_1
into :ls_codice_sog, :ls_rag1_sog
from sog_commerciale_gen
where sog_commerciale_gen.id_sog_commerciale = :ll_id_sog_com_prop;

Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_sog_comm_prop_cod',ls_codice_sog)
Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_sog_comm_prop_des',ls_rag1_sog)

Tab_1.TabPage_1.dw_prof_documento_gen_ff.SetItemStatus(ll_row,0,Primary!,NotModified!)










end if

end event

type dw_prof_documento_gen_ff from u_dw_master_main within tabpage_1
integer x = 23
integer y = 36
integer width = 2811
integer height = 1244
integer taborder = 1
string dataobject = "d_prof_documento_gen_ff"
end type

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, ls_cripted, ls_tipo_reg
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name		
	CASE 'tipo_registro'
		
		if idw_master.is_list.s_modo = modo_inserisci then
			this.SetItem( row,"ric_id_registro","" )
			this.SetItem( row,"c_registro_des","" )
		end if	

	CASE 'c_pas_di_sblocco'
		ls_cripted= f_cripting(string(data))
		uf_set_colval("pas_di_sblocco", ls_cripted)
		
	CASE 'c_pas_chiu_forz'
		ls_cripted= f_cripting(string(data))
		uf_set_colval("pas_chiu_forz", ls_cripted)

	CASE 'c_registro_des'
		if uf_get_colval("tipo_registro") <> "" then
			ls_sql_cond = "mod_registro.tipo_registro = '" + uf_get_colval("tipo_registro") + &
								"'"  
		end if
		ls_dbc[1] = "id_mod_registro"
		ls_dwc[1] = "id_mod_registro_prop"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "c_registro_des"
		ll_ok = uf_autofind_col(dwo.Name, "mod_registro", &
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE

end event

event ue_init;call super::ue_init;long					ll_scode
string				ls_nomerep,ls_values

ls_values					= ""
is_list.s_identifica[1] = "id_prof_documento"

iudw_children[1] = tab_1.tabpage_2.dw_prof_documento_mag_ff
iudw_children[2] = tab_1.tabpage_3.dw_prof_documento_fatt_ff
iudw_children[3] = tab_1.tabpage_4.dw_prof_documento_comm_ff
iudw_children[4] = tab_1.tabpage_4.dw_prof_documento_trasp_ff
iudw_children[5] = tab_1.tabpage_6.dw_prof_documento_riga_ff
iudw_children[6] = tab_1.tabpage_7.dw_prof_documento_altro_ff
iudw_children[7] = tab_1.tabpage_7.dw_prof_documento_deriv_gd


this.object.nome_report.values = ""


declare lcur_sta cursor for
	select	"par_stampa"."nome_report"
		from	"dba"."par_stampa"
		where	"par_stampa"."cat_report" = 'D';

if sqlca.sqlcode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
	return 1
end if

open lcur_sta;
 
ll_scode = 0;
do while ll_scode = 0
	fetch lcur_sta into :ls_nomerep;
	ll_scode = sqlca.sqlcode
	if ll_scode=0 then
		if not isNull(ls_nomerep) and ls_nomerep>"" then
			ls_values = ls_values + ls_nomerep + "~t" + ls_nomerep + "/"
		end if
	end if
loop

if not isNull(ls_values) then
	this.object.nome_report.values = ls_values
end if

close lcur_sta;



end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol

	CASE "c_registro_des"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_descrizione" 

		IF trim(uf_get_colval("tipo_registro")) <> "" Or IsNull(uf_get_colval("tipo_registro")) THEN
			is_ricpar.s_sql_cond = "mod_registro.tipo_registro = '" + uf_get_colval("tipo_registro") + "'"
		END IF


END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "des_contabile"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_des_contabile_gd"
		is_ricpar.s_titolo_finestra = "Descrizioni Contabili"

END CHOOSE


end event

event ue_use_search;call super::ue_use_search;
string	ls_tipo
long		ll_row

ll_row = GetRow()

CHOOSE CASE as_nomecol

	CASE "c_registro_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_mod_registro_prop", is_ricpar.s_id_seg_value[1])
		IF trim(uf_get_colval("tipo_registro")) = "" Or IsNull(uf_get_colval("tipo_registro"))THEN
			uf_set_colval("tipo_registro", is_ricpar.s_main_value)
		END IF		
		uf_set_colval("c_registro_cod", is_ricpar.s_ausil_value[1])
	CASE "c_registro_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_registro_prop_des", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_registro_des", is_ricpar.s_ausil_value[1])
		
END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;
string 	ls_descrizione, ls_cod
long 		ll_registro, ll_row
window 	lw_parent
tab    	lw_tab

ll_row = GetRow()

if ll_row > 0 then
	

	ls_cod = tab_1.tabpage_1.dw_prof_documento_gen_ff.GetItemString(ll_row, "codice")
	if IsNull(ls_cod) then ls_cod = ""
	ls_descrizione = tab_1.tabpage_1.dw_prof_documento_gen_ff.GetItemString(ll_row, "descrizione")
	if IsNull(ls_descrizione) then ls_descrizione = ""
	lw_tab = Parent.GetParent()
	lw_parent = lw_tab.GetParent()
	lw_parent.Title = "Profilo documento: "+ls_cod + " - " + ls_descrizione
	ls_cod = ""
	ls_descrizione = ""
	
	
	
	ll_registro = long(uf_get_colval("id_mod_registro_prop"))

	
	SELECT "mod_registro"."descrizione" 
	  	INTO : ls_descrizione
     	FROM "mod_registro" 
	 	WHERE ( "mod_registro"."id_mod_registro" = :ll_registro )   ;

	
	uf_set_colval("c_registro_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_registro_des", PRIMARY!, NotModified!)

end if
end event

event itemfocuschanged;call super::itemfocuschanged;string	ls_tipo_reg

if is_last_field = "tipo_registro" then
	ls_tipo_reg = GetItemString(GetRow(),"tipo_registro")
	if ls_tipo_reg <> "IA" and ls_tipo_reg <> "IV" and ls_tipo_reg <> "IC" then
		SetItem(GetRow(),"tipo_fattura","N")
	end if
end if
		
is_last_field = dwo.name
	

end event

event ue_insert;call super::ue_insert;long ll_valuta

select id_valuta
into :ll_valuta
from par_sistema;

if sqlca.sqlcode=0 then
	tab_1.tabpage_3.dw_prof_documento_fatt_ff.setitem(1,"id_valuta_prop_cod",ll_valuta)
	tab_1.tabpage_3.dw_prof_documento_fatt_ff.setitem(1,"id_valuta_prop_des",ll_valuta)
end if
end event

event updatestart;call super::updatestart;long ll_causale,ll_riga_corrente,ll_loc1,ll_loc2
string ls_mag_par,ls_mag_des
boolean lb_controllo
if rowcount()>0 then
	lb_controllo=false
	ll_causale=tab_1.tabpage_2.dw_prof_documento_mag_ff.getitemnumber(1, "id_caus_magazzino_prop_cod")
	select mag_par_richiesto,mag_des_richiesto
	into :ls_mag_par, :ls_mag_des
	from caus_magazzino
	where id_caus_magazzino=:ll_causale;
	ll_loc1=tab_1.tabpage_2.dw_prof_documento_mag_ff.getitemnumber(1, "id_locazione_1_prop")
	ll_loc2=tab_1.tabpage_2.dw_prof_documento_mag_ff.getitemnumber(1, "id_locazione_2_prop")
	if ls_mag_par='N' and ll_loc1>0 then lb_controllo=true
	if ls_mag_par='S' and isnull(ll_loc1) then lb_controllo=true
	if ls_mag_des='N' and ll_loc2>0 then lb_controllo=true
	if ls_mag_des='S' and isnull(ll_loc2) then lb_controllo=true
	if lb_controllo=true then
		messagebox("Informazione","Le locazione non sono impostate come richiede la causale!!")
	end if
end if
end event

event retrieveend;call super::retrieveend;post wf_riempi_campi_calcolati()

end event

event clicked;call super::clicked;




string ls_file, ls_path
integer li_ret
if dwo.name='cerca_file' then
  post wf_cerca_file(row)
end if
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2866
integer height = 1312
long backcolor = 79741120
string text = "Magazzino"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prof_documento_mag_ff dw_prof_documento_mag_ff
end type

on tabpage_2.create
this.dw_prof_documento_mag_ff=create dw_prof_documento_mag_ff
this.Control[]={this.dw_prof_documento_mag_ff}
end on

on tabpage_2.destroy
destroy(this.dw_prof_documento_mag_ff)
end on

type dw_prof_documento_mag_ff from u_dw_master_main within tabpage_2
integer x = 27
integer y = 32
integer width = 2811
integer height = 1224
integer taborder = 1
string dataobject = "d_prof_documento_mag_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE


is_list.s_colonne_drop[1] = "id_caus_magazzino_prop_cod"
is_list.s_colonne_drop[2] = "id_caus_magazzino_prop_des"
end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "c_sog_comm_prop_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "c_sog_comm_prop_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
	CASE "c_locazione_1_cod"
		is_search_window = "w_locazione_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 

	CASE "c_locazione_2_cod"
		is_search_window = "w_locazione_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 

	
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "c_sog_comm_prop_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_prop_des", is_ricpar.s_ausil_value[1])
	CASE "c_sog_comm_prop_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_prop_cod", is_ricpar.s_ausil_value[1])
	CASE "c_locazione_1_cod"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_locazione_1_prop", is_ricpar.s_id_seg_value[1])
		
	CASE "c_locazione_2_cod"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_locazione_2_prop", is_ricpar.s_id_seg_value[1])
END CHOOSE

end event

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, ls_null
long      ll_ok,ll_null
setnull(ll_null)
setnull(ls_null)

ls_sql_cond = ""

CHOOSE CASE dwo.name
	

	CASE 'c_sog_comm_prop_cod'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_prop_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_prop_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

	CASE 'c_sog_comm_prop_des'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_prop_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_prop_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	


	case "c_locazione_1_cod"
		if isnull(data) then 
			this.setitem(1,"id_locazione_1_prop",ll_null)
		else
		end if
	case "c_locazione_2_cod"
		if isnull(data) then 
			this.setitem(1,"id_locazione_2_prop",ll_null)
		else
		end if
		
	case "con_scorta_articoli"	
		this.setitem(1,"con_dis_articoli",ls_null)
	
	case "con_dis_articoli"	
	   this.setitem(1,"con_scorta_articoli",ls_null)
	
		
END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;
string ls_codice, ls_descrizione,ls_locazione
long ll_magazzino_1, ll_magazzino_2, ll_row, ll_sog_comm

ll_row = GetRow()

if RowCount() > 0 then
	

ll_sog_comm = long(uf_get_colval("id_sog_comm_prop"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm )   ;
	
	uf_set_colval("c_sog_comm_prop_cod",ls_codice)
	uf_set_colval("c_sog_comm_prop_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_sog_comm_prop_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_sog_comm_prop_des", PRIMARY!, NotModified!)

	long ll_loc1,ll_loc2
	
	ll_loc1=this.getitemnumber(1,"id_locazione_1_prop")
	if not isnull(ll_loc1) then
		SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
			INTO :ls_locazione  
			FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
					"dba"."magazzino"   
			WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
					( ( "locazione"."id_locazione" = :ll_loc1 ) );
		
		
		this.setitem(1,"c_locazione_1_cod",ls_locazione)
	end if
	
	ll_loc2=this.getitemnumber(1,"id_locazione_2_prop")
	if not isnull(ll_loc2) then
		SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
			INTO :ls_locazione  
			FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
					"dba"."magazzino"   
			WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
					( ( "locazione"."id_locazione" = :ll_loc2 ) );
		this.setitem(1,"c_locazione_2_cod",ls_locazione)
	end if
end if
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2866
integer height = 1312
long backcolor = 79741120
string text = "Fatturazione"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prof_documento_fatt_ff dw_prof_documento_fatt_ff
end type

on tabpage_3.create
this.dw_prof_documento_fatt_ff=create dw_prof_documento_fatt_ff
this.Control[]={this.dw_prof_documento_fatt_ff}
end on

on tabpage_3.destroy
destroy(this.dw_prof_documento_fatt_ff)
end on

type dw_prof_documento_fatt_ff from u_dw_master_main within tabpage_3
integer x = 27
integer y = 32
integer width = 2811
integer height = 1224
integer taborder = 1
string dataobject = "d_prof_documento_fatt_ff"
end type

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "c_prof_registrazione_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "c_prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		

	CASE "c_sog_comm_fatt_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "c_sog_comm_fatt_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "des_contabile"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_des_contabile_gd"
		is_ricpar.s_titolo_finestra = "Descrizioni Contabili"

	CASE "id_lingua_prop_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_prop_des"
	CASE "id_lingua_prop_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_prop_cod"

	CASE "id_linguaggio_prop_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio_prop_des"
	CASE "id_linguaggio_prop_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio_prop_cod"
		
	CASE "id_valuta_prop_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_prop_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "id_valuta_prop_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_prop_cod"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
		

END CHOOSE


end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE


is_list.s_colonne_drop[1] = "id_lingua_prop_cod"
is_list.s_colonne_drop[2] = "id_lingua_prop_des"
is_list.s_colonne_drop[3] = "id_linguaggio_prop_cod"
is_list.s_colonne_drop[4] = "id_linguaggio_prop_des"
is_list.s_colonne_drop[5] = "id_valuta_prop_cod"
is_list.s_colonne_drop[6] = "id_valuta_prop_des"
is_list.s_colonne_drop[7] = "id_listino_prop_cod"
is_list.s_colonne_drop[8] = "id_listino_prop_des"
is_list.s_colonne_drop[9] = "id_con_pagamento_prop_cod"
is_list.s_colonne_drop[10] = "id_con_pagamento_prop_des"
is_list.s_colonne_drop[11] = "des_contabile"

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
				
	CASE "c_prof_registrazione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_registrazione_des", is_ricpar.s_ausil_value[1])
	CASE "c_prof_registrazione_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_registrazione_cod", is_ricpar.s_ausil_value[1])
	CASE "c_sog_comm_fatt_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_fattura_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_fatt_des", is_ricpar.s_ausil_value[1])
	CASE "c_sog_comm_fatt_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_fattura_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_fatt_cod", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name
	CASE 'c_prof_registrazione_cod'
		ls_dbc[1] = "id_prof_registrazione"
		ls_dwc[1] = "id_prof_registrazione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_prof_registrazione_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_prof_registrazione_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

	CASE 'c_prof_registrazione_des'
		ls_dbc[1] = "id_prof_registrazione"
		ls_dwc[1] = "id_prof_registrazione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_prof_registrazione_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_prof_registrazione_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

	CASE 'c_sog_comm_fatt_cod'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_fattura_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_fatt_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_fatt_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

	CASE 'c_sog_comm_fatt_des'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_fattura_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_fatt_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_fatt_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;
string ls_codice, ls_descrizione
long ll_row, ll_sog_comm, ll_prof_reg

ll_row = GetRow()

if RowCount() > 0 then
	
ll_prof_reg = long(uf_get_colval("id_prof_registrazione"))

	
	SELECT "prof_registrazione"."codice" , "prof_registrazione"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."prof_registrazione"
	 	WHERE ( "prof_registrazione"."id_prof_registrazione" = :ll_prof_reg )   ;
	
	uf_set_colval("c_prof_registrazione_cod",ls_codice)
	uf_set_colval("c_prof_registrazione_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_prof_registrazione_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_prof_registrazione_des", PRIMARY!, NotModified!)

ll_sog_comm = long(uf_get_colval("id_sog_comm_fattura_prop"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm )   ;
	
	uf_set_colval("c_sog_comm_fatt_cod",ls_codice)
	uf_set_colval("c_sog_comm_fatt_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_sog_comm_fatt_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_sog_comm_fatt_des", PRIMARY!, NotModified!)

end if
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2866
integer height = 1312
long backcolor = 79741120
string text = "Commerciale / Trasporto"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prof_documento_comm_ff dw_prof_documento_comm_ff
dw_prof_documento_trasp_ff dw_prof_documento_trasp_ff
end type

on tabpage_4.create
this.dw_prof_documento_comm_ff=create dw_prof_documento_comm_ff
this.dw_prof_documento_trasp_ff=create dw_prof_documento_trasp_ff
this.Control[]={this.dw_prof_documento_comm_ff,&
this.dw_prof_documento_trasp_ff}
end on

on tabpage_4.destroy
destroy(this.dw_prof_documento_comm_ff)
destroy(this.dw_prof_documento_trasp_ff)
end on

type dw_prof_documento_comm_ff from u_dw_master_main within tabpage_4
integer x = 27
integer y = 32
integer width = 2811
integer height = 616
integer taborder = 10
string dataobject = "d_prof_documento_comm_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE


end event

type dw_prof_documento_trasp_ff from u_dw_master_main within tabpage_4
integer x = 27
integer y = 652
integer width = 2811
integer height = 640
integer taborder = 20
string dataobject = "d_prof_documento_trasp_ff"
end type

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_null

ls_sql_cond = ""

CHOOSE CASE dwo.name

	CASE 'c_sog_comm_vett_cod'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_vettore_1_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_vett_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_vett_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

	CASE 'c_sog_comm_vett_des'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_vettore_1_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_vett_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_vett_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

	
	CASE 'c_sog_comm_vett_cod_2'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_vettore_2_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_vett_cod_2"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_vett_des_2"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

	CASE 'c_sog_comm_vett_des_2'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_comm_vettore_2_prop"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_comm_vett_cod_2"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_comm_vett_des_2"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
		
	
	case 'trasp_mezzo_prop'
		
		
		if data<>'V' then
			setnull(ll_null)
			this.setitem(row,'id_sog_comm_vettore_1_prop',ll_null)
			this.setitem(row,'c_sog_comm_vett_cod',"")
			this.setitem(row,'c_sog_comm_vett_des',"")
			
			
			this.setitem(row,'id_sog_comm_vettore_2_prop',ll_null)
			this.setitem(row,'c_sog_comm_vett_cod_2',"")
			this.setitem(row,'c_sog_comm_vett_des_2',"")
		end if	
	
		

END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;
string ls_codice, ls_descrizione
long ll_row, ll_sog_comm

ll_row = GetRow()

if RowCount() > 0 then
	

ll_sog_comm = long(uf_get_colval("id_sog_comm_vettore_1_prop"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm )   ;
	
	uf_set_colval("c_sog_comm_vett_cod",ls_codice)
	uf_set_colval("c_sog_comm_vett_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_sog_comm_vett_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_sog_comm_vett_des", PRIMARY!, NotModified!)

end if
end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE


is_list.s_colonne_drop[1] = "id_caus_trasporto_prop"

is_list.s_colonne_drop[2] = "aspetto_beni_prop"

end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		

	CASE "c_sog_comm_vett_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
	CASE "c_sog_comm_vett_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
		
	
	CASE "c_sog_comm_vett_cod_2"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
	CASE "c_sog_comm_vett_des_2"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
END CHOOSE

end event

event ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "c_sog_comm_vett_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_vettore_1_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_vett_des", is_ricpar.s_ausil_value[1])
	CASE "c_sog_comm_vett_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_vettore_1_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_vett_cod", is_ricpar.s_ausil_value[1])
		
	
	CASE "c_sog_comm_vett_cod_2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_vettore_2_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_vett_des_2", is_ricpar.s_ausil_value[1])
	CASE "c_sog_comm_vett_des_2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_vettore_2_prop", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_vett_cod_2", is_ricpar.s_ausil_value[1])


END CHOOSE

end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2866
integer height = 1312
long backcolor = 79741120
string text = "Righe"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prof_documento_riga_ff dw_prof_documento_riga_ff
end type

on tabpage_6.create
this.dw_prof_documento_riga_ff=create dw_prof_documento_riga_ff
this.Control[]={this.dw_prof_documento_riga_ff}
end on

on tabpage_6.destroy
destroy(this.dw_prof_documento_riga_ff)
end on

type dw_prof_documento_riga_ff from u_dw_master_main within tabpage_6
integer x = 27
integer y = 32
integer width = 2811
integer height = 1204
integer taborder = 1
string dataobject = "d_prof_documento_riga_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE


end event

event rowfocuschanged;call super::rowfocuschanged;
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2866
integer height = 1312
long backcolor = 79741120
string text = "Profili Derivati"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prof_documento_deriv_gd dw_prof_documento_deriv_gd
dw_prof_documento_altro_ff dw_prof_documento_altro_ff
end type

on tabpage_7.create
this.dw_prof_documento_deriv_gd=create dw_prof_documento_deriv_gd
this.dw_prof_documento_altro_ff=create dw_prof_documento_altro_ff
this.Control[]={this.dw_prof_documento_deriv_gd,&
this.dw_prof_documento_altro_ff}
end on

on tabpage_7.destroy
destroy(this.dw_prof_documento_deriv_gd)
destroy(this.dw_prof_documento_altro_ff)
end on

type dw_prof_documento_deriv_gd from u_dw_master_main within tabpage_7
integer x = 27
integer y = 236
integer width = 2811
integer height = 980
integer taborder = 10
string dataobject = "d_prof_documento_deriv_gd"
boolean hscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Profili Documenti"
is_list.s_identifica[1] = "id_prof_documento"

end event

event updatestart;
long ll_totrows, ll_id_prof
int i

ll_id_prof = tab_1.tabpage_1.dw_prof_documento_gen_ff.getitemnumber(1,"id_prof_documento")
ll_totrows = tab_1.tabpage_7.dw_prof_documento_deriv_gd.rowcount()
for i=1 to ll_totrows
	tab_1.tabpage_7.dw_prof_documento_deriv_gd.setitem(i,"id_prof_documento",ll_id_prof)
next
end event

type dw_prof_documento_altro_ff from u_dw_master_main within tabpage_7
integer x = 27
integer y = 36
integer width = 2811
integer height = 160
integer taborder = 5
string dataobject = "d_prof_documento_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE


end event

type cb_1 from commandbutton within w_prof_documento_cx
integer x = 1774
integer y = 32
integer width = 279
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Duplica..."
end type

event clicked;
Long ll_locazione,ll_locazione2 , ll_row, ll_id_sog_com_prop, ll_id_prof, ll_null, ll_totrows
String ls_cod, ls_null, ls_codice, ls_codice2, ls_codice_sog, ls_rag1_sog
int i

w_search_main lw_sm

s_ric_param ls_ricpar
idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "prof_documento_codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_prof_documento_coddes_sw")
idw_master.is_ricpar = Message.PowerObjectParm


IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	if tab_1.tabpage_1.dw_prof_documento_gen_ff.ModifiedCount () + & 
	   tab_1.tabpage_1.dw_prof_documento_gen_ff.DeletedCount()>0 then &
		tab_1.tabpage_1.dw_prof_documento_gen_ff.event trigger ue_update(0,0)

	ll_id_prof = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_prof_documento"
	idw_master.is_list.l_identifica[1] = ll_id_prof
	idw_master.Event ue_retrieve(0, 0)
		
   
	

	ll_row = Tab_1.TabPage_1.dw_prof_documento_gen_ff.GetRow()
	ls_cod = tab_1.tabpage_1.dw_prof_documento_gen_ff.GetItemString(ll_row,"codice")

	SELECT prof_documento.id_locazione_1_prop,prof_documento.id_locazione_2_prop,prof_documento.id_sog_comm_prop
	INTO	:ll_locazione,:ll_locazione2, :ll_id_sog_com_prop
	FROM	prof_documento
	WHERE :ls_cod = prof_documento.codice;	

	SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_codice
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",
			"dba"."magazzino"
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and
			( ( "locazione"."id_locazione" = :ll_locazione ) );

	SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_codice2
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",
			"dba"."magazzino"
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and
			( ( "locazione"."id_locazione" = :ll_locazione2 ) );

	ll_row = Tab_1.TabPage_2.dw_prof_documento_mag_ff.GetRow()
	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_locazione_2_cod',ls_codice2)
	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_locazione_1_cod',ls_codice)
	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'id_locazione_2_prop',ll_locazione2)
	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'id_locazione_1_prop',ll_locazione)

	select codice, rag_soc_1
	into :ls_codice_sog, :ls_rag1_sog
	from sog_commerciale_gen
	where sog_commerciale_gen.id_sog_commerciale = :ll_id_sog_com_prop;

	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_sog_comm_prop_cod',ls_codice_sog)
	Tab_1.TabPage_2.dw_prof_documento_mag_ff.SetItem(ll_row,'c_sog_comm_prop_des',ls_rag1_sog)
	
		
END IF

idw_master.SetFocus()

setnull(ll_null)
ls_null=""

tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(1,"id_prof_documento",ll_null)
tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(1,"codice",ls_null)
tab_1.tabpage_1.dw_prof_documento_gen_ff.setitemstatus(1,0,primary!,newmodified!)

ll_totrows = tab_1.tabpage_7.dw_prof_documento_deriv_gd.rowcount()
for i=1 to ll_totrows
	tab_1.tabpage_7.dw_prof_documento_deriv_gd.setitem(i,"id_prof_documento",ll_null)
	tab_1.tabpage_7.dw_prof_documento_deriv_gd.setitemstatus(i,0,primary!,newmodified!)
next

end event

type cb_righe_automatiche from commandbutton within w_prof_documento_cx
boolean visible = false
integer x = 905
integer y = 32
integer width = 457
integer height = 84
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Righe Automatiche"
end type

event clicked;long ll_id_prof
ll_id_prof=tab_1.tabpage_1.dw_prof_documento_gen_ff.getitemnumber(1, "id_prof_documento")
if ll_id_prof>0 then
	openwithparm(w_prof_prop_righe_documento_gd, ll_id_prof)
end if
end event

