forward
global type w_documento_cx from w_p_data
end type
type dw_documento_gen_ff from u_dw_master_main within tabpage_1
end type
type dw_documento_gen_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_documento_comm_ff from u_dw_master_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_documento_note_ff from u_dw_master_main within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_riga_documento_lt from u_dw_master_main within tabpage_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_elem_pac_list_lt from u_dw_master_main within tabpage_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_documento_trasp_ff from u_dw_master_main within tabpage_6
end type
type tabpage_7 from userobject within tab_1
end type
type dw_spesa_documento_gd from u_dw_master_main within tabpage_7
end type
type dw_documento_totali_ff from u_dw_master_main within tabpage_7
end type
type cb_1 from commandbutton within w_documento_cx
end type
type tabpage_2 from userobject within tab_1
dw_documento_comm_ff dw_documento_comm_ff
end type
type tabpage_3 from userobject within tab_1
dw_documento_note_ff dw_documento_note_ff
end type
type tabpage_4 from userobject within tab_1
dw_riga_documento_lt dw_riga_documento_lt
end type
type tabpage_5 from userobject within tab_1
dw_elem_pac_list_lt dw_elem_pac_list_lt
end type
type tabpage_6 from userobject within tab_1
dw_documento_trasp_ff dw_documento_trasp_ff
end type
type tabpage_7 from userobject within tab_1
dw_spesa_documento_gd dw_spesa_documento_gd
dw_documento_totali_ff dw_documento_totali_ff
end type
end forward

global type w_documento_cx from w_p_data
int Width=2821
int Height=1737
boolean TitleBar=true
string Title="Documenti"
cb_1 cb_1
end type
global w_documento_cx w_documento_cx

type variables

string	is_more, is_rest, is_gdco, is_gcau
string	is_rmar, is_gdcn, is_gplt, is_rcol
string	is_gpes, is_gdim, is_rttr, is_rctr
string	is_rasb, is_rmtr, is_rvet, is_rvt2
string	is_rdtr, is_rsfi, is_gacc, is_stam
string	is_gchf, is_gsdo
string 	is_ritr, is_geag, is_fipa, is_fili
s_service iastr_service[]
end variables

forward prototypes
public function boolean uf_imposta_dati_profilo_documento (long al_row, dwobject adwo_dwo, string as_data)
public function integer uf_gestione_testata ()
public function long uf_val_str_fields (ref string as_err_text)
public function powerobject uf_get_object (string as_name, powerobject awo_current)
end prototypes

public function boolean uf_imposta_dati_profilo_documento (long al_row, dwobject adwo_dwo, string as_data);
long		ll_idprof
string	is_pres, is_iscd, is_idma, is_idli, is_idcp, is_ggco, is_noin, is_prab
string	is_prtr, is_tire, is_intc

ll_idprof = long(as_data)

SELECT prof_documento.mod_registro,        prof_documento.ric_estensione,
		 prof_documento.ges_date_competenza, prof_documento.ges_causale,
		 prof_documento.ric_mag_arrivo,      prof_documento.ges_data_consegna,
		 prof_documento.ges_pac_list,        prof_documento.ric_colli_documento,
		 prof_documento.ges_pesi,            prof_documento.ges_dimensioni,
		 prof_documento.ric_tipo_trasporto,  prof_documento.ric_caus_trasporto,
		 prof_documento.ric_asp_beni,        prof_documento.ric_mezzo_trasporto,
		 prof_documento.ric_vettore,         prof_documento.ric_sec_vettore,
		 prof_documento.ric_data_trasporto,  prof_documento.ric_sconti_finanziari,
		 prof_documento.ges_acconti,         prof_documento.stampabile,
		 prof_documento.ges_chius_forzata,   prof_documento.ges_stato_documento,
		 prof_documento.ric_trasporto,       prof_documento.ges_agente,
		 prof_documento.fis_pagamento,       prof_documento.fis_listino,
		 
		 prof_documento.prop_estensione,     prof_documento.id_sog_commerciale_documento,
		 prof_documento.id_magazzino,        prof_documento.id_linguaggio,
		 prof_documento.id_con_pagamento,    prof_documento.gg_consegna,
		 prof_documento.Note_intestazione,   prof_documento.prop_aspetto_beni,
		 prof_documento.prop_trasporto,
		 
		 prof_documento.tipo_registro,       prof_documento.int_consentiti
		 
	INTO :is_more, :is_rest, :is_gdco, :is_gcau, :is_rmar, :is_gdcn, :is_gplt, :is_rcol,
		  :is_gpes, :is_gdim, :is_rttr, :is_rctr, :is_rasb, :is_rmtr, :is_rvet, :is_rvt2,
		  :is_rdtr, :is_rsfi, :is_gacc, :is_stam, :is_gchf, :is_gsdo, :is_ritr, :is_geag,
		  :is_fipa, :is_fili,
		  :is_pres, :is_iscd, :is_idma, :is_idli, :is_idcp, :is_ggco, :is_noin, :is_prab,
		  :is_prtr,
		  :is_tire, :is_intc
		  
	FROM prof_documento
	WHERE prof_documento.id_prof_documento = :ll_idprof 
	USING SQLCA;
	
if SQLCA.SQLCode<>0 then
	MessageBox ("Attenzione!","Vi sono stati errori nella selezione del profilo",Exclamation!)
	return false
end if


if is_more = "S" then tab_1.tabpage_1.dw_documento_gen_ff.Object.c_registro_des.Protect = 0 else tab_1.tabpage_1.dw_documento_gen_ff.Object.c_registro_des.Protect = 1
if is_rest = "S" then tab_1.tabpage_1.dw_documento_gen_ff.Object.estensione.Protect = 0 else tab_1.tabpage_1.dw_documento_gen_ff.Object.estensione.Protect = 1
if is_gdco = "S" then
	tab_1.tabpage_1.dw_documento_gen_ff.Object.data_inizio_competenza.Protect = 0
	tab_1.tabpage_1.dw_documento_gen_ff.Object.data_fine_competenza.Protect = 0
else
	tab_1.tabpage_1.dw_documento_gen_ff.Object.data_inizio_competenza.Protect = 1
	tab_1.tabpage_1.dw_documento_gen_ff.Object.data_fine_competenza.Protect = 1
end if
if is_gcau = "S" then
	tab_1.tabpage_1.dw_documento_gen_ff.Object.id_caus_magazzino_cod.Protect = 0
	tab_1.tabpage_1.dw_documento_gen_ff.Object.id_caus_magazzino_des.Protect = 0
else
	tab_1.tabpage_1.dw_documento_gen_ff.Object.id_caus_magazzino_cod.Protect = 1
	tab_1.tabpage_1.dw_documento_gen_ff.Object.id_caus_magazzino_des.Protect = 1
end if
if is_rmar = "S" then
	tab_1.tabpage_1.dw_documento_gen_ff.Object.c_mag_dest_cod.Protect = 0
	tab_1.tabpage_1.dw_documento_gen_ff.Object.c_mag_dest_des.Protect = 0
else
	tab_1.tabpage_1.dw_documento_gen_ff.Object.c_mag_dest_cod.Protect = 1
	tab_1.tabpage_1.dw_documento_gen_ff.Object.c_mag_dest_des.Protect = 1
end if

if is_gdcn = "S" then tab_1.tabpage_2.dw_documento_comm_ff.Object.data_prev_consegna.Protect = 0 else tab_1.tabpage_2.dw_documento_comm_ff.Object.data_prev_consegna.Protect = 1

if is_gplt = "S" then tab_1.tabpage_5.enabled = true else tab_1.tabpage_5.enabled = false
	
if is_rcol = "S" then tab_1.tabpage_6.dw_documento_trasp_ff.Object.num_colli.Protect = 0 else tab_1.tabpage_6.dw_documento_trasp_ff.Object.num_colli.Protect = 1
if is_gpes = "S" then
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_unita_misura_peso_cod.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.peso_netto.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.peso_lordo.Protect = 0
else
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_unita_misura_peso_cod.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.peso_netto.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.peso_lordo.Protect = 1
end if
if is_gdim = "S" then
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_unita_misura_dimensione.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.dim_l.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.dim_h.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.dim_p.Protect = 0
else
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_unita_misura_dimensione.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.dim_l.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.dim_h.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.dim_p.Protect = 1
end if
if is_rttr = "S" then
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_tipo_trasporto.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_tipo_trasporto_des.Protect = 0
else
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_tipo_trasporto.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_tipo_trasporto_des.Protect = 1
end if
if is_rctr = "S" then
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_caus_trasporto.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_caus_trasporto_des.Protect = 0
else
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_caus_trasporto.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.id_caus_trasporto_des.Protect = 1
end if
if is_rasb = "S" then tab_1.tabpage_6.dw_documento_trasp_ff.Object.asp_beni.Protect = 0 else tab_1.tabpage_6.dw_documento_trasp_ff.Object.asp_beni.Protect = 1
if is_rmtr = "S" then
	
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.tras_mezzo.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.mezzo_trasporto.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.targa_mezzo_trasporto.Protect = 0
else
	
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.tras_mezzo.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.mezzo_trasporto.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.targa_mezzo_trasporto.Protect = 1
end if
if is_rvet = "S" then 
	
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.c_sog_commerciale_codice.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.c_anagrafica_rag_soc_1.Protect = 0
else 
	
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.c_sog_commerciale_codice.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.c_anagrafica_rag_soc_1.Protect = 1
end if
if is_rvt2 = "S" then
	
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.cc_vettore_cod.Protect = 0
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.c_vettore_des.Protect = 0
else
	
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.c_vettore_cod.Protect = 1
	tab_1.tabpage_6.dw_documento_trasp_ff.Object.c_vettore_des.Protect = 1
end if
if is_rdtr = "S" then tab_1.tabpage_6.dw_documento_trasp_ff.Object.data_trasporto.Protect = 0 else tab_1.tabpage_6.dw_documento_trasp_ff.Object.data_trasporto.Protect = 1

if is_rsfi = "S" then
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_1.Protect = 0
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_2.Protect = 0
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_incondizionato.Protect = 0
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_cassa.Protect = 0
else
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_1.Protect = 1
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_2.Protect = 1
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_incondizionato.Protect = 1
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sconto_fin_cassa.Protect = 1
end if
if is_gacc = "S" then
	tab_1.tabpage_7.dw_documento_totali_ff.Object.imp_acconto.Protect = 0
	tab_1.tabpage_7.dw_documento_totali_ff.Object.id_tipo_pagamento.Protect = 0
	tab_1.tabpage_7.dw_documento_totali_ff.Object.id_tipo_pagamento_des.Protect = 0
else
	tab_1.tabpage_7.dw_documento_totali_ff.Object.imp_acconto.Protect = 1
	tab_1.tabpage_7.dw_documento_totali_ff.Object.id_tipo_pagamento.Protect = 1
	tab_1.tabpage_7.dw_documento_totali_ff.Object.id_tipo_pagamento_des.Protect = 1
end if
if is_stam = "S" then tab_1.tabpage_7.dw_documento_totali_ff.Object.stampato.Protect = 0 else tab_1.tabpage_7.dw_documento_totali_ff.Object.stampato.Protect = 1
if is_gchf = "S" then tab_1.tabpage_7.dw_documento_totali_ff.Object.chius_forzata.Protect = 0 else tab_1.tabpage_7.dw_documento_totali_ff.Object.chius_forzata.Protect = 1
if (is_gsdo = "D") OR (is_gsdo = "R") then 
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sospeso.Protect = 0
else
	tab_1.tabpage_7.dw_documento_totali_ff.Object.sospeso.Protect = 1
END IF





return true


end function

public function integer uf_gestione_testata ();long ll_row
datawindow ldw_gen

ldw_gen= tab_1.tabpage_1.dw_documento_gen_ff
ll_row= ldw_gen.GetRow()

if not(ldw_gen.GetItemStatus(ll_row, 0, Primary!)= New! OR ldw_gen.GetItemStatus(ll_row, 0, Primary!)= NewModified!) then
	f_displayonly(ldw_gen, "c_prof_documento_cod", TRUE)
	f_displayonly(ldw_gen, "c_prof_documento_des", TRUE)
	f_displayonly(ldw_gen, "c_registro_cod", TRUE)
	f_displayonly(ldw_gen, "c_registro_des", TRUE)
	f_displayonly(ldw_gen, "num_progressivo", TRUE)
end if
return 0
end function

public function long uf_val_str_fields (ref string as_err_text);
return 0
end function

public function powerobject uf_get_object (string as_name, powerobject awo_current);long ll_size, ll_count
windowobject lwo_array[], ldwo_item 
object ldwo1
window lw_instance
tab ltab_instance

CHOOSE CASE awo_current.TypeOf()
	CASE Window!
		lw_instance= awo_current
		lwo_array=lw_instance.control
	CASE Tab!
		ltab_instance= awo_current
		lwo_array=ltab_instance.control
END CHOOSE

ll_size= UpperBound(lwo_array)
for ll_count= 1 to ll_size
	ldwo_item= lwo_array[ll_count]
	ldwo1=ldwo_item.TypeOf()
	CHOOSE CASE ldwo_item.TypeOf()
		CASE Tab!
			uf_get_object(as_name,ldwo_item)
			
	END CHOOSE
	ldwo1=ldwo_item.typeof()
	
next
return ldwo_item
end function

event open;call super::open;integer li_a 
string ls_a

idw_master = tab_1.tabpage_1.dw_documento_gen_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "documento.id_documento"

ls_a = tab_1.tabpage_1.dw_documento_gen_ff.Object.c_registro_des.Protect
li_a = integer(ls_a)


end event

on w_documento_cx.create
int iCurrent
call w_p_data::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_1
end on

on w_documento_cx.destroy
call w_p_data::destroy
destroy(this.cb_1)
end on

type p_crescente from w_p_data`p_crescente within w_documento_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_documento_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_documento_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_documento_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_documento_cx
int X=641
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_documento_cx
int X=1898
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_documento_cx
int X=2195
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_documento_cx
int X=2492
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_documento_cx
int X=46
int Width=2721
int Height=1441
int TabOrder=20
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_2
this.Control[iCurrent+2]=tabpage_3
this.Control[iCurrent+3]=tabpage_4
this.Control[iCurrent+4]=tabpage_5
this.Control[iCurrent+5]=tabpage_6
this.Control[iCurrent+6]=tabpage_7
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2684
int Height=1321
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
dw_documento_gen_ff dw_documento_gen_ff
end type

on tabpage_1.create
this.dw_documento_gen_ff=create dw_documento_gen_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_documento_gen_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_documento_gen_ff)
end on

type dw_documento_gen_ff from u_dw_master_main within tabpage_1
event ue_set_calc_fields ( )
event ue_setta_profilo ( )
int X=28
int Y=37
int Width=2620
int Height=1249
int TabOrder=3
string DataObject="d_documento_gen_ff"
end type

event ue_set_calc_fields;call super::ue_set_calc_fields;
string ls_codice, ls_descrizione, ls_tipo_registro 
long ll_row, ll_magazzino, ll_magazzino_2, ll_sog_comm, ll_registro, ll_prof_documento,&
	  ll_numero, ll_destinazione

ll_row = GetRow()

IF RowCount() > 0 THEN
	
	
	
	ll_magazzino = long(uf_get_colval("id_magazzino"))

	
	SELECT "magazzino"."codice" , "magazzino"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "magazzino" 
	 	WHERE ( "magazzino"."id_magazzino" = :ll_magazzino )   ;

	
	uf_set_colval("c_mag_partenza_cod",ls_codice)
	uf_set_colval("c_mag_partenza_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_mag_partenza_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_mag_partenza_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

	
	
	ll_magazzino_2 = long(uf_get_colval("id_magazzino_2"))

	
	SELECT "magazzino"."codice" , "magazzino"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "magazzino" 
	 	WHERE ( "magazzino"."id_magazzino" = :ll_magazzino_2 )   ;

	
	uf_set_colval("c_mag_dest_cod",ls_codice)
	uf_set_colval("c_mag_dest_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_mag_dest_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_mag_dest_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

ll_sog_comm = long(uf_get_colval("id_sog_commerciale"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm )   ;
	
	uf_set_colval("c_intestatario_cod",ls_codice)
	uf_set_colval("c_intestatario_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_intestatario_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_intestatario_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

ll_destinazione = long(uf_get_colval("id_destinazione"))

	
	SELECT "destinazione"."rag_soc_1" 
	  	INTO :ls_descrizione
     	FROM "destinazione"
	 	WHERE ( "destinazione"."id_destinazione" = :ll_destinazione )   ;
	
	uf_set_colval("c_destinazione_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_destinazione_des", PRIMARY!, NotModified!)
ls_descrizione = ""

ll_registro = long(uf_get_colval("id_registro"))

	
	  SELECT "registro"."tipo_registro",   
				"registro"."numero", 
				"registro"."descrizione", 
				"esercizio"."codice"  
			 INTO :ls_tipo_registro, :ll_numero, :ls_descrizione, :ls_codice  
			 FROM "esercizio", "registro"  
			 WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
					 ( ( "registro"."id_registro" = :ll_registro ) )   ;
					 
	
	uf_set_colval("c_registro_cod",ls_descrizione)
	uf_set_colval("c_registro_des", "Esercizio: " + ls_codice + " - " + &
							  "Tipo: " + ls_tipo_registro + " - " + &
							  "Numero: " + string(ll_numero))
	
	setitemstatus(ll_row, "c_registro_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_registro_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

	
	
	ll_prof_documento = long(uf_get_colval("id_prof_documento"))

	
	SELECT "prof_documento"."codice" , "prof_documento"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "prof_documento" 
	 	WHERE ( "prof_documento"."id_prof_documento" = :ll_prof_documento )   ;

	
	uf_set_colval("c_prof_documento_cod",ls_codice)
	uf_set_colval("c_prof_documento_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_prof_documento_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_prof_documento_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

END IF
end event

event ue_setta_profilo;call super::ue_setta_profilo;long ll
ll=GetRow()
ll=GetItemNumber(GetRow(), "id_prof_documento")
u_service.event ue_profilo(GetItemNumber(GetRow(), "id_prof_documento"))
u_service.uf_forn_servizio("dw_documento_gen_ff", this)
this.event ue_set_calc_fields()

u_service.uf_forn_servizio("dw_documento_comm_ff",iudw_children[1])
tab_1.tabpage_2.dw_documento_comm_ff.event ue_set_calc_fields()
u_service.uf_forn_servizio("dw_documento_trasp_ff",iudw_children[5])
tab_1.tabpage_6.dw_documento_trasp_ff.event ue_set_calc_fields()
u_service.uf_forn_servizio("dw_documento_totali_ff",iudw_children[6])
tab_1.tabpage_7.dw_documento_totali_ff.event ue_set_calc_fields()
end event

event ue_init;call super::ue_init;is_title= "Documento"
iudw_children[1] = tab_1.tabpage_2.dw_documento_comm_ff
iudw_children[2] = tab_1.tabpage_3.dw_documento_note_ff
iudw_children[3] = tab_1.tabpage_4.dw_riga_documento_lt
iudw_children[4] = tab_1.tabpage_5.dw_elem_pac_list_lt
iudw_children[5] = tab_1.tabpage_6.dw_documento_trasp_ff
iudw_children[6] = tab_1.tabpage_7.dw_documento_totali_ff
iudw_children[7] = tab_1.tabpage_7.dw_spesa_documento_gd



end event

event ue_set_search;call super::ue_set_search;string ls_intestatari

CHOOSE CASE as_nomecol

	CASE "c_prof_documento_cod"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_codice" 
	CASE "c_prof_documento_des"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_descrizione" 
		

	CASE "c_registro_cod"
		is_search_window = "w_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "registro_descrizione" 
	
	CASE "c_intestatario_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "c_intestatario_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		

	CASE "c_mag_partenza_cod"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "c_mag_partenza_des"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		

	CASE "c_mag_dest_cod"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "c_mag_dest_des"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		

CASE "c_destinazione_des"
		ls_intestatari = uf_get_colval("id_sog_commerciale")
		is_search_window = "w_destinazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "c_prof_documento_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_documento_des", is_ricpar.s_ausil_value[1])
		this.event ue_setta_profilo()

	CASE "c_prof_documento_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_documento_cod", is_ricpar.s_ausil_value[1])
		this.event ue_setta_profilo()

	CASE "c_registro_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_registro_des", "Esercizio: " + string(is_ricpar.s_ausil_value[1]) + " - " + &
					  "Tipo: " + string(is_ricpar.s_ausil_value[2]) + " - " + &
					  "Numero: " + string(is_ricpar.s_ausil_value[3]))


	CASE "c_intestatario_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_intestatario_des", is_ricpar.s_ausil_value[1])
	CASE "c_intestatario_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_intestatario_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_mag_partenza_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mag_partenza_des", is_ricpar.s_ausil_value[1])
	CASE "c_mag_partenza_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mag_partenza_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_mag_dest_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mag_dest_des", is_ricpar.s_ausil_value[1])
	CASE "c_mag_dest_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mag_dest_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_destinazione_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_destinazione", is_ricpar.s_id_seg_value[1])
END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, ls_tipo_registro, ls_descrizione, ls_codice
string ls_rag_soc
long      ll_ok, ll_Cur_IDRegistro, ll_row, ll_numero, ll_num_succ, ll_num_prec, ll_id_registro
long ll_id_esercizio
date ld_data_succ, ld_data_prec, ld_data
s_service lstr_service
s_par_service lstr_par_service[]
ls_sql_cond = ""
ll_row= GetRow()

CHOOSE CASE dwo.name
	
		
	CASE "data_competenza"
		ll_id_registro= GetItemNumber(ll_row, "id_registro")
		ld_data= Date(data)
		if not(IsNull(ll_id_registro)) then
			   SELECT "esercizio"."data_inizio",   
							"esercizio"."data_fine"  
					 INTO :ld_data_prec,   
							:ld_data_succ  
					 FROM "esercizio",   
							"registro"  
					WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
							( ( "registro"."id_registro" = :ll_id_registro ) )   ;
			if not (IsNull(ld_data_prec)) then 
				If DaysAfter(ld_data, ld_data_prec) > 0 then 
					MessageBox("Documento", "++La data immessa non è compresa tra la data di inizio ~r e la data di fine dell'esercizio.", Exclamation!)
					RETURN 1
				end if
			end if
			if not (IsNull(ld_data_succ)) then 
				ll_numero= DaysAfter(ld_data, ld_data_succ)
				If ll_numero < 0 then 
					MessageBox("Documento", "++La data immessa non è compresa tra la data di inizio ~r e la data di fine dell'esercizio.", Exclamation!)
					RETURN 1
				end if
			end if
		end if
	
	CASE "data_registrazione"
		ll_numero = GetItemNumber(ll_row, "num_progressivo")
		ll_id_registro= GetItemNumber(ll_row, "id_registro")
		if not(IsNull(ll_numero) OR ll_numero < 0 OR IsNull(ll_id_registro)) then
			lstr_service = u_service.uf_forn_value("con", "data_registrazione", "dw_documento_gen_ff")
			if lstr_service.s_value= 'S' then
				  SELECT Max("documento"."num_progressivo")
					 INTO :ll_num_prec
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" < :ll_numero )   ;
	  			  SELECT Max("documento"."data_registrazione" )
					 INTO :ld_data_prec  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" = :ll_num_prec )   ;
				If DaysAfter(Date(data), ld_data_prec) <= 0 then
  				  SELECT Min("documento"."num_progressivo")
					 INTO :ll_num_succ
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" > :ll_numero )   ;
	  			  SELECT Min("documento"."data_registrazione" )
					 INTO :ld_data_succ  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" = :ll_num_succ )   ;
					If DaysAfter(Date(data), ld_data_succ) < 0 then RETURN 1
				else
					RETURN 1
				end if
			end if
		end if
END CHOOSE

CHOOSE CASE dwo.name
	CASE 'c_prof_documento_cod'
		ls_dbc[1] = "id_prof_documento"
		ls_dwc[1] = "id_prof_documento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_prof_documento_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_prof_documento_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		this.event ue_setta_profilo()
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_prof_documento_des'
		ls_dbc[1] = "id_prof_documento"
		ls_dwc[1] = "id_prof_documento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_prof_documento_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_prof_documento_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		this.event ue_setta_profilo()
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	
	

	CASE 'c_registro_cod'
		ls_dbc[1] = "id_registro"
		ls_dwc[1] = "id_registro"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "c_registro_cod"
		ll_ok = uf_autofind_col(dwo.Name, "registro", &
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			ll_Cur_IDRegistro= GetItemNumber(ll_row, "id_registro")
			if not IsNull(ll_Cur_IDRegistro) then
					  SELECT "registro"."tipo_registro",   
								"registro"."numero", 
								 "registro"."descrizione", 
								"esercizio"."codice"  
						 INTO :ls_tipo_registro,   
								:ll_numero, 
								:ls_descrizione,  
								:ls_codice  
						 FROM "esercizio",   
								"registro"  
						WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
								( ( "registro"."id_registro" = :ll_Cur_IDRegistro ) )   ;
						uf_set_colval("c_registro_des", "Esercizio: " + ls_codice + " - " + &
							  "Tipo: " + ls_tipo_registro + " - " + &
							  "Numero: " + string(ll_numero))
			end if
			RETURN 2
		END IF

	CASE 'c_intestatario_cod'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_intestatario_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_intestatario_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		lstr_par_service[1].s_column_name="intestatario"
		lstr_par_service[1].dw_datawindow= this
		lstr_par_service[1].a_in=Long(data)
		lstr_par_service[2].s_column_name="id_destinazione"
		lstr_par_service[2].dw_datawindow= this
		lstr_par_service[3].s_column_name="id_sog_commerciale_fattura"
		lstr_par_service[3].dw_datawindow= tab_1.tabpage_2.dw_documento_comm_ff
		lstr_par_service[4].s_column_name="id_lingua_des"
		lstr_par_service[4].dw_datawindow= tab_1.tabpage_2.dw_documento_comm_ff
		lstr_par_service[5].s_column_name="id_linguaggio_des"
		lstr_par_service[5].dw_datawindow= tab_1.tabpage_2.dw_documento_comm_ff
		u_service.uf_richiesta("trigger", lstr_par_service)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_intestatario_des'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_intestatario_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_intestatario_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_destinazione_des'
		ls_dbc[1] = "id_destinazione"
		ls_dwc[1] = "id_destinazione"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "c_destinazione_des"
		ll_ok = uf_autofind_col(dwo.Name, "destinazione", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_mag_partenza_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_mag_partenza_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_mag_partenza_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	CASE 'c_mag_partenza_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_mag_partenza_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_mag_partenza_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
	
		CASE 'c_mag_dest_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino_destinazione"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_mag_dest_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_mag_dest_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	CASE 'c_mag_dest_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_magazzino"
		ls_dwc[1]  = "id_magazzino_destinazione"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_mag_dest_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_mag_dest_des"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
	
END CHOOSE


end event

event ue_default;call super::ue_default;

string ls_codice, ls_Par_Menu_Cod, ls_tipo_registro, ls_descrizione
long ll_id_registro, ll_numero, ll_Cur_IDRegistro, ll_ID_Prof_Doc, ll_Ultimo_Num_Reg, ll_id_tipo_trasporto
long ll_id_intestatario, ll_id_con_pagam, ll_gg_prev_cons, ll_id_attivita, ll_id_esercizio
date ld_Ultima_Data_Reg


ls_Par_Menu_Cod = trim(THIS.is_list.s_win_parametri)


ll_Cur_IDRegistro = GetItemNumber(al_row, "id_registro")
ll_ID_Prof_Doc = GetItemNumber(al_row, "id_prof_documento")
ll_id_intestatario=GetItemNumber(al_row, "id_sog_commerciale")

CHOOSE CASE string(adwo_current.name)
			
	CASE "cc_registro", "registro_descrizione"
		IF NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN
		  SELECT "registro"."id_registro"  
			 INTO :ll_id_registro  
			 FROM "prof_documento",   
					"registro"  
			WHERE ( "registro"."id_registro" = "prof_documento"."id_registro_prop" ) and  
					( ( "prof_documento"."id_prof_documento" = :ll_ID_Prof_Doc ) )   ;
		
			CHOOSE CASE SQLCA.SQLCode
				CASE 0
					  SELECT "registro"."tipo_registro",   
								"registro"."numero", 
								 "registro"."descrizione", 
								"esercizio"."codice"  
						 INTO :ls_tipo_registro,   
								:ll_numero, 
								:ls_descrizione,  
								:ls_codice  
						 FROM "esercizio",   
								"registro"  
						WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
								( ( "registro"."id_registro" = :ll_id_registro ) )   ;
						SetItem(al_row, "id_registro", ll_id_registro)
						SetItem(al_row, "registro_descrizione", ls_descrizione)
						uf_set_colval("cc_registro", "Esercizio: " + ls_codice + " - " + &
							  "Tipo: " + ls_tipo_registro + " - " + &
							  "Numero: " + string(ll_numero))
					
				CASE 100
				CASE -1
					
				CASE ELSE
					
			END CHOOSE
	end if

	CASE "num_progressivo"
		
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) THEN
			SELECT MAX("documento"."num_progressivo")
				INTO :ll_Ultimo_Num_Reg
				FROM "documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
	
			
			IF IsNull(ll_Ultimo_Num_Reg) THEN ll_Ultimo_Num_Reg = 0
			SetItem(al_row, "num_progressivo", (ll_Ultimo_Num_Reg+1))
		END IF
	CASE "data_registrazione"
		
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) THEN
			SELECT MAX("documento"."data_documento")
				INTO :ld_Ultima_Data_Reg
				FROM "documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
			
			
			IF IsNull(ld_Ultima_Data_Reg) THEN ld_Ultima_Data_Reg = Today()
			SetItem(al_row, "data_registrazione", ld_Ultima_Data_Reg)
			

		END IF
		CASE "data_prev_consegna"
			IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN

				ld_Ultima_Data_Reg=GetItemDate(al_row, "documento_data")
				SELECT "prof_documento"."gg_consegna"  
					INTO :ll_gg_prev_cons  
					FROM "prof_documento"  
					WHERE "prof_documento"."id_prof_documento" = :ll_ID_Prof_Doc   ;
				
				SetItem(al_row, "data_prev_consegna", RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
			END IF	
		
		
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;u_service = CREATE u_service

this.event ue_setta_profilo()

uf_gestione_testata()
end event

event ue_itemerror;call super::ue_itemerror;long ll_id_registro, ll_numero, ll_num_prec, ll_num_succ, ll_ret_value
date ld_data_prec, ld_data_succ, ld_data
s_service lstr_service
SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name
		
	CASE "data_competenza"
		ll_id_registro= GetItemNumber(al_row, "id_registro")
		ld_data= Date(as_data)
		if not(IsNull(ll_id_registro)) then
			   SELECT "esercizio"."data_inizio",   
							"esercizio"."data_fine"  
					 INTO :ld_data_prec,   
							:ld_data_succ  
					 FROM "esercizio",   
							"registro"  
					WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
							( ( "registro"."id_registro" = :ll_id_registro ) )   ;
			if not (IsNull(ld_data_prec)) then 
				If DaysAfter(ld_data, ld_data_prec) > 0 then 
					MessageBox("Documento", "La data immessa non è compresa tra la data di inizio ~r e la data di fine dell'esercizio.", Exclamation!)
					ll_ret_value= 1
				end if
			end if
			if not (IsNull(ld_data_succ)) then 
				ll_numero= DaysAfter(ld_data, ld_data_succ)
				If ll_numero < 0 then 
					MessageBox("Documento", "La data immessa non è compresa tra la data di inizio ~r e la data di fine dell'esercizio.", Exclamation!)
					ll_ret_value= 1
				end if
			end if
		end if
	
	CASE "data_registrazione"
		ll_numero = GetItemNumber(al_row, "num_progressivo")
		ll_id_registro= GetItemNumber(al_row, "id_registro")
		if not(IsNull(ll_numero) OR ll_numero < 0 OR IsNull(ll_id_registro)) then
			lstr_service = u_service.uf_forn_value("con", "data_registrazione", "dw_documento_gen_ff")
			if lstr_service.s_value= 'S' then
				  SELECT Max("documento"."num_progressivo")
					 INTO :ll_num_prec
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" < :ll_numero )   ;
	  			  SELECT Max("documento"."data_registrazione" )
					 INTO :ld_data_prec  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" = :ll_num_prec )   ;
				If DaysAfter(Date(as_data), ld_data_prec) <= 0 then
  				  SELECT Min("documento"."num_progressivo")
					 INTO :ll_num_succ
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" > :ll_numero )   ;
	  			  SELECT Min("documento"."data_registrazione" )
					 INTO :ld_data_succ  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" = :ll_num_succ )   ;
					If DaysAfter(Date(as_data), ld_data_succ) < 0 then ll_ret_value= 1
				else
					ll_ret_value= 1
				end if
			end if
		end if
END CHOOSE
RETURN ll_ret_value
end event

event ue_update;call super::ue_update;uf_gestione_testata()
end event

event rowfocuschanged;call super::rowfocuschanged;
end event

event ue_validate_row;call super::ue_validate_row;long ll_ret_value
datawindow ldw_comm, ldw_trasp, ldw_totali
ldw_comm = tab_1.tabpage_2.dw_documento_comm_ff
ldw_trasp= tab_1.tabpage_6.dw_documento_trasp_ff
ldw_totali= tab_1.tabpage_7.dw_documento_totali_ff
as_error_text=""
ll_ret_value =ll_ret_value + u_service.uf_valida_dw("dw_documento_gen_ff", this,as_error_text)
ll_ret_value =ll_ret_value + u_service.uf_valida_dw("dw_documento_comm_ff", ldw_comm,as_error_text)
ll_ret_value =ll_ret_value + u_service.uf_valida_dw("dw_documento_totali_ff", ldw_totali,as_error_text)
ll_ret_value =ll_ret_value + u_service.uf_valida_dw("dw_documento_trasp_ff", ldw_trasp,as_error_text)

RETURN ll_ret_value


end event

type tabpage_2 from userobject within tab_1
int X=19
int Y=105
int Width=2684
int Height=1321
long BackColor=79741120
string Text="Commerciale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_documento_comm_ff dw_documento_comm_ff
end type

on tabpage_2.create
this.dw_documento_comm_ff=create dw_documento_comm_ff
this.Control[]={ this.dw_documento_comm_ff}
end on

on tabpage_2.destroy
destroy(this.dw_documento_comm_ff)
end on

type dw_documento_comm_ff from u_dw_master_main within tabpage_2
event ue_set_calc_fields ( )
int X=28
int Y=37
int Width=2620
int Height=1249
int TabOrder=1
string DataObject="d_documento_comm_ff"
end type

event ue_set_calc_fields;call super::ue_set_calc_fields;
string ls_descrizione, ls_codice
long ll_sog_commerciale, ll_row, ll_gruppo_agenti

ll_row = GetRow()

if RowCount() > 0 then
	
ll_sog_commerciale = long(uf_get_colval("id_sog_commerciale_fattura"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_commerciale )   ;
	
	uf_set_colval("c_fattura_cod",ls_codice)
	uf_set_colval("c_fattura_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_fattura_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_fattura_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""
	
	

	ll_gruppo_agenti = long(uf_get_colval("id_gruppo_agenti"))

	
	SELECT "gruppo_agenti"."codice" , "gruppo_agenti"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "gruppo_agenti" 
	 	WHERE ( "gruppo_agenti"."id_gruppo_agenti" = :ll_gruppo_agenti )   ;

	
	uf_set_colval("c_gruppo_agenti_cod",ls_codice)
	uf_set_colval("c_gruppo_agenti_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_gruppo_agenti_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_gruppo_agenti_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""
	
end if
end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE

is_list.s_colonne_drop[1] = "id_lingua_cod"
is_list.s_colonne_drop[2] = "id_lingua_des"
is_list.s_colonne_drop[3] = "id_linguaggio"
is_list.s_colonne_drop[4] = "id_linguaggio_des"
is_list.s_colonne_drop[5] = "id_valuta"
is_list.s_colonne_drop[6] = "id_valuta_des"
is_list.s_colonne_drop[7] = "id_listino"
is_list.s_colonne_drop[8] = "id_listino_des"
is_list.s_colonne_drop[9] = "id_con_pagamento"
is_list.s_colonne_drop[10] = "id_con_pagamento_des"
is_list.s_colonne_drop[11] = "id_banca_appoggio"
end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "c_gruppo_agenti_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_des", is_ricpar.s_ausil_value[1])
		If tab_1.tabpage_4.dw_riga_documento_lt.RowCount() > 0 then MessageBox("Documento","Attenzione esistono già righe di documento.", Information!)

	CASE "c_gruppo_agenti_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_cod", is_ricpar.s_ausil_value[1])
		If tab_1.tabpage_4.dw_riga_documento_lt.RowCount() > 0 then MessageBox("Documento","Attenzione esistono già righe di documento.", Information!)

	CASE "c_fattura_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fattura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_fattura_des", is_ricpar.s_ausil_value[1])
	CASE "c_fattura_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fattura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_fattura_cod", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "c_gruppo_agenti_cod"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		

	CASE "c_gruppo_agenti_des"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		
		
	CASE "c_fattura_cod"
		is_search_window = "w_sog_commerciale_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "sog_commerciale_codice" 
		
	CASE "c_fattura_des"
		is_search_window = "w_sog_commerciale_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "anagrafica_rag_soc_1" 
		


END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_lingua_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingua"
		is_ricpar.s_ausil_value[1] = "id_lingua_des"
	CASE "id_lingua_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingua"
		is_ricpar.s_ausil_value[1] = "id_lingua_cod"
		
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
		
	CASE "id_valuta"
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
		is_ricpar.s_ausil_value[1] = "id_valuta"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861


END CHOOSE


end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""


CHOOSE CASE dwo.name
		
	CASE 'c_gruppo_agenti_cod'

		ls_dbc[1] = "id_gruppo_agenti"
		ls_dwc[1] = "id_gruppo_agenti"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_gruppo_agenti_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		ll_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		If tab_1.tabpage_4.dw_riga_documento_lt.RowCount() > 0 then MessageBox("Documento","Attenzione esistono già righe di documento.", Information!)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_gruppo_agenti_des'
	
		ls_dbc[1] = "id_gruppo_agenti"
		ls_dwc[1] = "id_gruppo_agenti"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_gruppo_agenti_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		ll_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		If tab_1.tabpage_4.dw_riga_documento_lt.RowCount() > 0 then MessageBox("Documento","Attenzione esistono già righe di documento.", Information!)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
		
	CASE 'c_fattura_cod'
		ls_sql_cond = ""		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale_fattura"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_fattura_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_fattura_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
		
	CASE 'c_fattura_des'
		ls_sql_cond = ""		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale_fattura"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_fattura_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_fattura_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
		
END CHOOSE

end event

event ue_default;call super::ue_default;

string ls_codice, ls_Par_Menu_Cod, ls_tipo_registro, ls_descrizione
long ll_id_registro, ll_numero, ll_Cur_IDRegistro, ll_ID_Prof_Doc, ll_Ultimo_Num_Reg, ll_id_tipo_trasporto
long ll_id_intestatario, ll_id_con_pagam, ll_gg_prev_cons, ll_id_attivita, ll_id_esercizio
date ld_Ultima_Data_Reg


ll_Cur_IDRegistro = GetItemNumber(al_row, "id_registro")
ll_ID_Prof_Doc = GetItemNumber(al_row, "id_prof_documento")
ll_id_intestatario=GetItemNumber(al_row, "id_sog_commerciale")

CHOOSE CASE string(adwo_current.name)
	CASE "id_con_pagamento"
		SELECT "sog_commerciale"."id_con_pagamento"  
			 INTO :ll_id_con_pagam  
			 FROM "sog_commerciale"  
			WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario   ;

		IF NOT (IsNull(ll_id_con_pagam) OR ll_id_con_pagam = 0) THEN SetItem(al_row, "id_con_pagamento", ll_id_con_pagam)


	CASE "data_prev_consegna"
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN
			ld_Ultima_Data_Reg=GetItemDate(al_row, "data_registrazione")
			SELECT "prof_documento"."gg_consegna"  
				INTO :ll_gg_prev_cons  
				FROM "prof_documento"  
				WHERE "prof_documento"."id_prof_documento" = :ll_ID_Prof_Doc   ;
			SetItem(al_row, "data_prev_consegna", RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
		END IF	
	
END CHOOSE

end event

type tabpage_3 from userobject within tab_1
int X=19
int Y=105
int Width=2684
int Height=1321
long BackColor=79741120
string Text="Note"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_documento_note_ff dw_documento_note_ff
end type

on tabpage_3.create
this.dw_documento_note_ff=create dw_documento_note_ff
this.Control[]={ this.dw_documento_note_ff}
end on

on tabpage_3.destroy
destroy(this.dw_documento_note_ff)
end on

type dw_documento_note_ff from u_dw_master_main within tabpage_3
int X=28
int Y=37
int Width=2620
int Height=1249
int TabOrder=3
string DataObject="d_documento_note_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

type tabpage_4 from userobject within tab_1
int X=19
int Y=105
int Width=2684
int Height=1321
long BackColor=79741120
string Text="Righe Documento"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_riga_documento_lt dw_riga_documento_lt
end type

on tabpage_4.create
this.dw_riga_documento_lt=create dw_riga_documento_lt
this.Control[]={ this.dw_riga_documento_lt}
end on

on tabpage_4.destroy
destroy(this.dw_riga_documento_lt)
end on

type dw_riga_documento_lt from u_dw_master_main within tabpage_4
int X=28
int Y=37
int Width=2620
int Height=1249
int TabOrder=3
string DataObject="d_riga_documento_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_documento"
is_resp_window = "w_riga_documento_cx"
is_list.s_win_chiave[1] = "id_riga_documento"
is_list.s_par_name[1] = "id_documento"
end event

type tabpage_5 from userobject within tab_1
int X=19
int Y=105
int Width=2684
int Height=1321
long BackColor=79741120
string Text="Packing List"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_elem_pac_list_lt dw_elem_pac_list_lt
end type

on tabpage_5.create
this.dw_elem_pac_list_lt=create dw_elem_pac_list_lt
this.Control[]={ this.dw_elem_pac_list_lt}
end on

on tabpage_5.destroy
destroy(this.dw_elem_pac_list_lt)
end on

type dw_elem_pac_list_lt from u_dw_master_main within tabpage_5
int X=28
int Y=37
int Width=2620
int Height=1249
int TabOrder=3
string DataObject="d_elem_pac_list_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_documento"
is_resp_window = "w_elem_pac_list_ff"
is_list.s_win_chiave[1] = "id_elem_pac_list"
is_list.s_par_name[1] = "id_documento"
end event

type tabpage_6 from userobject within tab_1
int X=19
int Y=105
int Width=2684
int Height=1321
long BackColor=79741120
string Text="Trasporto"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_documento_trasp_ff dw_documento_trasp_ff
end type

on tabpage_6.create
this.dw_documento_trasp_ff=create dw_documento_trasp_ff
this.Control[]={ this.dw_documento_trasp_ff}
end on

on tabpage_6.destroy
destroy(this.dw_documento_trasp_ff)
end on

type dw_documento_trasp_ff from u_dw_master_main within tabpage_6
event ue_set_calc_fields ( )
int X=28
int Y=37
int Width=2620
int Height=1249
int TabOrder=3
string DataObject="d_documento_trasp_ff"
end type

event ue_set_calc_fields;call super::ue_set_calc_fields;
string ls_descrizione, ls_codice
long ll_sog_commerciale, ll_row

ll_row = GetRow()

if RowCount() > 0 then
	
	
	
	ll_sog_commerciale = long(uf_get_colval("id_sog_commerciale_vettore"))

	

 	 SELECT "sog_commerciale_gen"."codice",   
				"sog_commerciale_gen"."rag_soc_1"  
		 INTO :ls_codice,   
				:ls_descrizione  
		 FROM "sog_commerciale_gen"  
		WHERE "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_commerciale   ;

	
	uf_set_colval("c_vettore_cod",ls_codice)
	
	
	setitemstatus(ll_row, "c_vettore_cod", PRIMARY!, NotModified!)

	
	uf_set_colval("c_vettore_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_vettore_des", PRIMARY!, NotModified!)	

	ls_codice=""
	ls_descrizione=""


	
	
	ll_sog_commerciale = long(uf_get_colval("id_sog_commerciale_vettore_2"))

	

  SELECT "sog_commerciale_gen"."codice",   
         "sog_commerciale_gen"."rag_soc_1"  
    INTO :ls_codice,   
         :ls_descrizione  
    FROM "sog_commerciale_gen"  
   WHERE "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_commerciale   ;

	
	uf_set_colval("c_vettore_2_cod",ls_codice)
	
	
	setitemstatus(ll_row, "c_vettore_2_cod", PRIMARY!, NotModified!)

	
	uf_set_colval("c_vettore_2_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_vettore_2_des", PRIMARY!, NotModified!)	
		
end if
end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE

is_list.s_colonne_drop[1] = "id_unita_misura_peso_cod"
is_list.s_colonne_drop[2] = "id_tipo_trasporto_des"
is_list.s_colonne_drop[3] = "id_tipo_trasporto"
is_list.s_colonne_drop[4] = "id_caus_trasporto_des"
is_list.s_colonne_drop[5] = "id_caus_trasporto"

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "c_vettore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_des", is_ricpar.s_ausil_value[1])
	CASE "c_vettore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_cod", is_ricpar.s_ausil_value[1])
	CASE "c_vettore_2_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_2_des", is_ricpar.s_ausil_value[1])
	CASE "c_vettore_2_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_2_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "c_vettore_cod"
		is_search_window = "w_sog_commerciale_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "sog_commerciale_codice" 
		
		is_ricpar.s_sql_cond = "sog_commerciale.tipo = 'V'"
	CASE "c_vettore_des"
		is_search_window = "w_sog_commerciale_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "anagrafica_rag_soc_1" 
		
		is_ricpar.s_sql_cond = "sog_commerciale.tipo = 'V'"
		
	CASE "c_vettore_2_cod"
		is_search_window = "w_sog_commerciale_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "sog_commerciale_codice" 
		
		is_ricpar.s_sql_cond = "sog_commerciale.tipo = 'V'"
	CASE "c_vettore_2_des"
		is_search_window = "w_sog_commerciale_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "anagrafica_rag_soc_1" 
		
		is_ricpar.s_sql_cond = "sog_commerciale.tipo = 'V'"

END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_unita_misura_dimensione"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869

	CASE "id_unita_misura_peso_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869

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

	CASE "id_caus_trasporto"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_caus_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Causali Trasporto"
		is_ricpar.s_ausil_value[1] = "id_caus_trasporto_des"
	CASE "id_caus_trasporto_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_caus_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Causali Trasporto"
		is_ricpar.s_ausil_value[1] = "id_caus_trasporto"

END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name
		
	CASE 'c_vettore_cod'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'V'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale_vettore"
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
		ls_dwc[1] = "id_sog_commerciale_vettore"
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
		ls_dwc[1] = "id_sog_commerciale_vettore_2"
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
		ls_dwc[1] = "id_sog_commerciale_vettore_2"
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

event ue_default;call super::ue_default;

string  ls_Par_Menu_Cod, ls_tipo_registro, ls_descrizione
long ll_id_registro, ll_numero, ll_Cur_IDRegistro, ll_ID_Prof_Doc, ll_Ultimo_Num_Reg, ll_id_tipo_trasporto
long ll_id_intestatario


ll_Cur_IDRegistro = GetItemNumber(al_row, "id_registro")
ll_ID_Prof_Doc = GetItemNumber(al_row, "id_prof_documento")
ll_id_intestatario=GetItemNumber(al_row, "id_sog_commerciale")

CHOOSE CASE string(adwo_current.name)
	CASE "id_tipo_trasporto"
		SELECT "sog_commerciale"."id_con_pagamento"  
			 INTO :ll_id_tipo_trasporto
			 FROM "sog_commerciale"  
			WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario   ;
		IF NOT (IsNull(ll_id_tipo_trasporto) OR ll_id_tipo_trasporto = 0) THEN SetItem(al_row, "id_tipo_trasporto", ll_id_tipo_trasporto)
	
END CHOOSE

end event

type tabpage_7 from userobject within tab_1
int X=19
int Y=105
int Width=2684
int Height=1321
long BackColor=79741120
string Text="Totali"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_spesa_documento_gd dw_spesa_documento_gd
dw_documento_totali_ff dw_documento_totali_ff
end type

on tabpage_7.create
this.dw_spesa_documento_gd=create dw_spesa_documento_gd
this.dw_documento_totali_ff=create dw_documento_totali_ff
this.Control[]={ this.dw_spesa_documento_gd,&
this.dw_documento_totali_ff}
end on

on tabpage_7.destroy
destroy(this.dw_spesa_documento_gd)
destroy(this.dw_documento_totali_ff)
end on

type dw_spesa_documento_gd from u_dw_master_main within tabpage_7
int X=28
int Y=897
int Width=2620
int Height=381
int TabOrder=3
string DataObject="d_spesa_documento_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_documento"
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_spesa_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_spesa_gd"
		is_ricpar.s_titolo_finestra = "Spese"
		is_ricpar.s_ausil_value[1] = "id_spesa_des"
	CASE "id_spesa_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_spesa_gd"
		is_ricpar.s_titolo_finestra = "Spese"
		is_ricpar.s_ausil_value[1] = "id_spesa_cod"

END CHOOSE

end event

type dw_documento_totali_ff from u_dw_master_main within tabpage_7
event ue_set_calc_fields ( )
int X=28
int Y=37
int Width=2620
int Height=821
string DataObject="d_documento_totali_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_tipo_pagamento"
is_list.s_colonne_drop[2] = "id_tipo_pagamento_des"

end event

type cb_1 from commandbutton within w_documento_cx
int X=1189
int Y=41
int Width=458
int Height=85
boolean BringToTop=true
string Text="Blocco Documento"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long		ll_row, ll_id_documento, ll_id_azienda, ll_id_prof_documento
dwItemStatus l_itemstatus
s_any_array lstr_array

ll_row = tab_1.tabpage_7.dw_documento_totali_ff.GetRow()
l_itemstatus = tab_1.tabpage_7.dw_documento_totali_ff.GetItemStatus(ll_row, 0, Primary!)
IF (l_itemstatus = New! OR l_itemstatus = NewModified!) THEN
	Return
END IF	
lstr_array.s_array[1] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemNumber(ll_row, "id_documento")
lstr_array.s_array[2] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemNumber(ll_row, "id_prof_documento")
lstr_array.s_array[3] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemNumber(ll_row, "id_azienda")
lstr_array.s_array[4] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemstring(ll_row, "stampato")
lstr_array.s_array[5] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemstring(ll_row, "contabilizzato")
lstr_array.s_array[6] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemstring(ll_row, "evaso_totalmente")
lstr_array.s_array[7] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemstring(ll_row, "chius_forzata")
lstr_array.s_array[8] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemstring(ll_row, "sospeso")
lstr_array.s_array[9] = tab_1.tabpage_1.dw_documento_gen_ff.GetItemstring(ll_row, "bloccato")

OpenWithParm(w_blocco_docum_wz, lstr_array)

lstr_array= Message.PowerObjectParm
tab_1.tabpage_1.dw_documento_gen_ff.SetItem(ll_row, "stampato",lstr_array.s_array[1])
tab_1.tabpage_1.dw_documento_gen_ff.SetItem(ll_row, "bloccato",lstr_array.s_array[2])
tab_1.tabpage_1.dw_documento_gen_ff.SetItem(ll_row, "contabilizzato",lstr_array.s_array[3])
tab_1.tabpage_1.dw_documento_gen_ff.SetItem(ll_row, "sospeso",lstr_array.s_array[4])
tab_1.tabpage_1.dw_documento_gen_ff.SetItem(ll_row, "evaso_totalmente",lstr_array.s_array[5])
tab_1.tabpage_1.dw_documento_gen_ff.SetItem(ll_row, "chius_forzata",lstr_array.s_array[6])









end event

