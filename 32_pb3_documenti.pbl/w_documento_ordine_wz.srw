forward
global type w_documento_ordine_wz from w_wiz_main
end type
type tab_1 from tab within w_documento_ordine_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_documento_ordine_ext_gen_ff from u_dw_ext_main within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_documento_ordine_ext_gen_ff dw_documento_ordine_ext_gen_ff
end type
type tabpage_2 from userobject within tab_1
end type
type dw_documento_ordine_ext_altro_ff from u_dw_ext_main within tabpage_2
end type
type cb_annotazione from commandbutton within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_documento_ordine_ext_altro_ff dw_documento_ordine_ext_altro_ff
cb_annotazione cb_annotazione
cb_1 cb_1
end type
type tab_1 from tab within w_documento_ordine_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_annulla from commandbutton within w_documento_ordine_wz
end type
type cb_ok from commandbutton within w_documento_ordine_wz
end type
end forward

global type w_documento_ordine_wz from w_wiz_main
integer x = 370
integer y = 36
integer width = 2299
integer height = 1672
string title = "Documento"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_ges_ric_riga ( )
tab_1 tab_1
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_documento_ordine_wz w_documento_ordine_wz

type variables
string	 	ls_array[]
char 	 	ic_ric_riga[]
s_any_array 	istr_array
date		id_data_doc
end variables

forward prototypes
public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
public function integer uf_ric_riga (string as_value, string as_field, u_dw_ext_main adw_datawindow)
private subroutine uf_error_message (readonly integer errore, string campo, string id_mag)
end prototypes

event ue_ges_ric_riga;
u_dw_ext_main 	ldw_documento_gen, ldw_documento_altro

ldw_documento_gen= tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff
ldw_documento_altro= tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff
if UpperBound(ic_ric_riga) >= 10 then
	uf_ric_riga( ic_ric_riga[1], "id_caus_magazzino_cod", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[1], "id_caus_magazzino_des", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[2], "c_magazzino_1_cod", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[2], "c_magazzino_1_des", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[3], "c_magazzino_2_cod", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[3], "c_magazzino_2_des", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[4], "c_fattura_cod", ldw_documento_altro)
	uf_ric_riga( ic_ric_riga[4], "c_fattura_des", ldw_documento_altro)
	uf_ric_riga( ic_ric_riga[5], "id_listino_cod", ldw_documento_altro)
	uf_ric_riga( ic_ric_riga[5], "id_listino_des", ldw_documento_altro)
	uf_ric_riga( ic_ric_riga[6], "c_gruppo_agenti_cod", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[6], "c_gruppo_agenti_des", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[7], "id_tipo_trasporto_cod", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[7], "id_tipo_trasporto_des", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[8], "c_vettore_cod", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[8], "c_vettore_des", ldw_documento_gen)
	uf_ric_riga( ic_ric_riga[9], "c_doc_padre", ldw_documento_altro)
	uf_ric_riga( ic_ric_riga[10], "data_scadenza", ldw_documento_gen)	
end if












end event

public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita);

decimal  ldc_parte,ldc_tot_riga
string  ls_parte
long ll_row, ll_pos
boolean lb_non_calcolabile
string ls_tot_riga

if IsNull(adc_prezzo) then adc_prezzo = 0
if not (IsNull(as_sconto) OR as_sconto= "") then
	as_sconto= Trim(as_sconto)
	ll_pos=Pos(as_sconto,"+")
	DO WHILE ll_pos > 0
			
			ls_parte= Mid(as_sconto,1,ll_pos - 1)

			ldc_parte= Dec(ls_parte)
			if ldc_parte = 0 OR ldc_parte > 100 OR ldc_parte <= 0 then 
			
				SetNull(ldc_parte)	
				RETURN ldc_parte
			else
				adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
			end if
			
			as_sconto= Mid(as_sconto,ll_pos+1,Len(as_sconto))
			ll_pos=Pos(as_sconto,"+")
	LOOP
	ls_parte= as_sconto
	ldc_parte= Dec(ls_parte)
	if ldc_parte = 0  OR ldc_parte > 100 OR ldc_parte <= 0 then 
		
			SetNull(ldc_parte)	
			RETURN ldc_parte
		else
			adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
	end if
end if

adc_prezzo=Truncate(adc_prezzo, 0)
RETURN adc_prezzo

end function

public function integer uf_ric_riga (string as_value, string as_field, u_dw_ext_main adw_datawindow);

string ls_color
CHOOSE CASE as_value
	CASE "N"
		f_displayonly(adw_datawindow, as_field, TRUE)
		
		ls_color = "276856960"
		adw_datawindow.Modify(as_field + ".color = " + ls_color)
	CASE "L"
		f_displayonly(adw_datawindow, as_field, TRUE)
		ls_color= f_get_dwo_property(adw_datawindow.Describe(as_field + ".color"), "0", "")
		adw_datawindow.Modify(as_field + ".color = " + ls_color)
		
		adw_datawindow.Modify(as_field + ".color = 0")

	CASE "M"
		f_displayonly(adw_datawindow, as_field, FALSE)
		ls_color= f_get_dwo_property(adw_datawindow.Describe(as_field + ".color"), "0", "")
		adw_datawindow.Modify(as_field + ".color = " + ls_color)

		CHOOSE CASE String(adw_datawindow.Describe(as_field + ".edit.style"))
			CASE "edit"
				adw_datawindow.Modify(as_field + ".edit.nilisnull = FALSE")
				adw_datawindow.Modify(as_field + ".edit.required = FALSE")
			CASE "dddw"
				adw_datawindow.Modify(as_field + ".dddw.required = FALSE")

			CASE "ddlb"
				adw_datawindow.Modify(as_field + ".ddlb.required = FALSE")
			CASE "editmask"
				adw_datawindow.Modify(as_field + ".editmask.required = FALSE")
			CASE ELSE
		END CHOOSE
	CASE "O"
		CHOOSE CASE String(adw_datawindow.Describe(as_field + ".edit.style"))
			CASE "edit"
				adw_datawindow.Modify(as_field + ".edit.nilisnull = TRUE")
				adw_datawindow.Modify(as_field + ".edit.required = TRUE")
			CASE "dddw"
				adw_datawindow.Modify(as_field + ".dddw.required = TRUE")

			CASE "ddlb"
				adw_datawindow.Modify(as_field + ".ddlb.required = TRUE")
			CASE "editmask"
				adw_datawindow.Modify(as_field + ".editmask.required = TRUE")
			CASE ELSE
		END CHOOSE
END CHOOSE
return 0
end function

private subroutine uf_error_message (readonly integer errore, string campo, string id_mag);
long Null_value, row

setNull(Null_value)
choose case errore
	case 0 
		
	case 1 
		messagebox ( "Attenzione!", "Il magazzino è bloccato")
		row = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getrow()
		tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.setItem(row,campo+"_cod","")
		tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.setItem(row,campo+"_des","")
		tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.setItem(row,id_mag,Null_value)
	case 2 
		
	case 3 
		messagebox ( "Attenzione!", "La data non è valida")
end choose
end subroutine

on w_documento_ordine_wz.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.cb_ok
end on

on w_documento_ordine_wz.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;long				ll_row
s_any_array 	lstr_array
string			ls_tb, ls_cp, ls_vr, ls_tr, ls_locazione
string			ls_dbc[], ls_dbv[], ls_dwc[], ls_c_info
integer			li_ok
long 				ll_count
string 			ls_nome, ls_agente_codice, ls_agente_descrizione, ls_tipo_registro, ls_title
date				ld_data_vergine
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.TriggerEvent("ue_insert")
ll_row= tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.GetRow()
lstr_array= Message.PowerObjectParm
Message.Processed = TRUE
ls_array= lstr_array.s_array
istr_array= lstr_array
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_documento", ls_array[2])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_prof_documento",ls_array[3])   
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_registro", ls_array[4])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("num_progressivo", ls_array[5])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("data_registrazione", ls_array[6])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("num_documento", ls_array[7])
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("data_documento", ls_array[8])  
id_data_doc=date(ls_array[8])
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("data_competenza", ls_array[9])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_sog_commerciale", ls_array[10])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_caus_magazzino_cod",ls_array[12])   
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_locazione", ls_array[13])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_locazione_2", ls_array[14])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_sog_commerciale_fattura", ls_array[15])
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_lingua", ls_array[16])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_linguaggio",ls_array[17])   
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_listino_cod", ls_array[21])
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_con_pagamento", ls_array[22])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_banca_sog_commerciale", ls_array[23])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_gruppo_agenti", ls_array[24])  

tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("interlocutore",ls_array[26])   

tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("note_intestazione", ls_array[28])  
//cambio id_tipo_trasporto_cod n id_tipo_trasporto_des 070709
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_tipo_trasporto_des",ls_array[35])   
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_caus_trasporto", ls_array[36])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_sog_commerciale_vettore", ls_array[39])  
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_sog_commerciale_vettore_2", ls_array[40])  


tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("data_scadenza", ls_array[56])  

tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_documento_padre",ls_array[65])
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("id_prof_registrazione", ls_array[66])
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("des_contabile", ls_array[67])
ic_ric_riga=ls_array[71]
this.Title= ls_array[72]
If IsNull(ls_array[73]) then ls_array[73]=""
If IsNull(ls_array[74]) then ls_array[74]=""
If IsNull(ls_array[75]) then ls_array[75]=""
If IsNull(ls_array[76]) then ls_array[76]=""


ls_c_info= "Prof.: " + ls_array[73] + "(" + ls_array[74] + ") ~n Reg.: " + ls_array[75] + "(" + ls_array[76] + ")"
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_info", ls_c_info)

tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.Triggerevent("ue_calc_fields")
tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff.Triggerevent("ue_calc_fields")
TriggerEvent("ue_ges_ric_riga")
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.postevent("ue_post_open")
tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff.postevent("ue_post_open")

SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_locazione  
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
         "dba"."magazzino"   
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
			( ( "locazione"."id_locazione" = :ls_array[13] ) );
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_1_cod", ls_locazione)

ls_locazione=""
SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_locazione  
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
         "dba"."magazzino"   
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
			( ( "locazione"."id_locazione" = :ls_array[14] ) );
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_2_cod", ls_locazione)

tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff.uf_set_colval("id_listino_cod",ls_array[85])
tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff.uf_set_colval("id_listino_des",ls_array[85])
datawindowchild dwc_variazione

tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff.getchild("id_variazione",dwc_variazione)
dwc_variazione.Settransobject(sqlca)
dwc_variazione.Retrieve(long(ls_array[85]))
tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff.uf_set_colval("id_variazione",ls_array[86])   

tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("data_ric_consegna",ls_array[87]) 


end event

event closequery;Message.PowerObjectParm=istr_array


end event

event ue_post_open;call super::ue_post_open;

uf_error_message ( uf_controlla_blocco ( long(ls_array[13]), date(ls_array[6])),"c_magazzino_1","id_magazzino" )
uf_error_message ( uf_controlla_blocco ( long(ls_array[14]), date(ls_array[6])),"c_magazzino_2","id_magazzino_2" )


long ll_loc1,ll_loc2,ll_prof,ll_controllo,ll_controllo2
string ls_locazione
ll_prof=long(ls_array[3])
select id_locazione_1_prop,id_locazione_2_prop
into :ll_loc1,:ll_loc2
from prof_documento
where id_prof_documento=:ll_prof;
ll_controllo=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getitemnumber(1,"id_locazione")
ll_controllo2=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getitemnumber(1,"id_locazione_2")
if isnull(ll_controllo) and isnull(ll_controllo2)then
	SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_locazione  
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
			"dba"."magazzino"   
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
			( ( "locazione"."id_locazione" = :ll_loc1 ) );
	tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_1_cod", ls_locazione)

	ls_locazione=""

	SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_locazione  
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
			"dba"."magazzino"   
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
			( ( "locazione"."id_locazione" = :ll_loc2 ) );
	tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_2_cod", ls_locazione)
end if
end event

type tab_1 from tab within w_documento_ordine_wz
integer x = 37
integer y = 156
integer width = 2199
integer height = 1388
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2162
integer height = 1268
long backcolor = 79741120
string text = "Trasporto / Magazzino"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_documento_ordine_ext_gen_ff dw_documento_ordine_ext_gen_ff
end type

on tabpage_1.create
this.dw_documento_ordine_ext_gen_ff=create dw_documento_ordine_ext_gen_ff
this.Control[]={this.dw_documento_ordine_ext_gen_ff}
end on

on tabpage_1.destroy
destroy(this.dw_documento_ordine_ext_gen_ff)
end on

type dw_documento_ordine_ext_gen_ff from u_dw_ext_main within tabpage_1
event ue_calc_fields ( )
integer x = 18
integer y = 24
integer width = 2121
integer height = 1224
integer taborder = 21
string dataobject = "d_documento_ordine_ext_gen_ff"
end type

event ue_calc_fields;call super::ue_calc_fields;long 		ll_id_magazzino, ll_row, ll_banca_sog_comm, ll_id_prof_registrazione
string 	ls_info, ls_esercizio, ls_cc
string 	ls_codice, ls_descrizione, ls_tipo_registro
long 		ll_destinazione, ll_registro, ll_numero, ll_prof_documento, ll_sog_comm
long		ll_sog_comm_vettore, ll_id_gruppo_agenti, ll_sog_comm_fattura, ll_id_documento_padre
string ls_locazione
long ll_locazione
ll_row= GetRow()
if RowCount() > 0 then

ls_codice = ""
ls_descrizione = ""

ll_sog_comm_vettore = long(uf_get_colval("id_sog_commerciale_vettore"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."sog_commerciale_gen" 
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm_vettore )   ;

	
	uf_set_colval("c_vettore_cod",ls_codice)
	uf_set_colval("c_vettore_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_vettore_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_vettore_des", PRIMARY!, NotModified!)

ls_codice = ""
ls_descrizione = ""

ls_descrizione = ""

ll_id_gruppo_agenti = long(uf_get_colval("id_gruppo_agenti"))

	
  SELECT "gruppo_agenti"."codice",   
         "gruppo_agenti"."descrizione"  
    INTO :ls_codice,   
         :ls_descrizione  
    FROM "dba"."gruppo_agenti"  
   WHERE "gruppo_agenti"."id_gruppo_agenti" = :ll_id_gruppo_agenti   ;

	
	uf_set_colval("c_gruppo_agenti_cod",ls_codice)
	uf_set_colval("c_gruppo_agenti_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_gruppo_agenti_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_gruppo_agenti_des", PRIMARY!, NotModified!)

ls_codice = ""
ls_descrizione = ""
ll_id_prof_registrazione = long(uf_get_colval("id_prof_registrazione"))

	
  SELECT "prof_registrazione"."codice",   
         "prof_registrazione"."descrizione"  
    INTO :ls_codice,   
         :ls_descrizione  
    FROM "dba"."prof_registrazione"  
   WHERE "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_registrazione   ;

	
	uf_set_colval("c_prof_registrazione_cod",ls_codice)
	uf_set_colval("c_prof_registrazione_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_prof_registrazione_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_prof_registrazione_des", PRIMARY!, NotModified!)

ls_codice = ""
ls_descrizione = ""


ll_locazione=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getitemnumber(1,"id_locazione")
SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_locazione  
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
         "dba"."magazzino"   
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
			( ( "locazione"."id_locazione" = :ll_locazione ) );
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_1_cod", ls_locazione)
ls_locazione=""
ll_locazione=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getitemnumber(1,"id_locazione_2")
SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
	INTO :ls_locazione  
	FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
         "dba"."magazzino"   
	WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
			( ( "locazione"."id_locazione" = :ll_locazione ) );
tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_2_cod", ls_locazione)

end if

end event

event itemchanged;
long 			ll_id_sog_commerciale, ll_row, ll_id_valuta, ll_id_tipo_trasporto, ll_Cur_IDRegistro, ll_ID_Prof_Doc
long			ll_gg_prev_cons,ll_numero, ll_num_succ, ll_num_prec, ll_id_con_pagamento
long 			ll_id_magazzino, ll_id_locazione, ll_nr_righe, ll_count_righe
string		ls_sc_fin, ls_tipo_registro, ls_descrizione, ls_codice, ls_info
date			ld_Ultima_Data_Reg, ld_Data, ld_data_succ, ld_data_prec
string		ls_tb, ls_cp, ls_vr, ls_tr, ls_rag_soc, ls_sql
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_null
integer		li_ok
decimal 		ldc_tot_righe, ldc_sc_1, ldc_sc_2, ldc_tot_scontato, ldc_sconto_cassa, ldc_null
long			ll_sc_imp,ll_null

SetNull(ls_null)
SetNull(ldc_null)
setnull(ll_null)
ll_row = GetRow()
CHOOSE CASE dwo.name

	CASE 'c_vettore_cod'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'c_vettore_des'

		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
	CASE 'c_gruppo_agenti_cod'
		ls_dbc[1] = "codice"
		ls_dwc[1] = "c_gruppo_agenti_cod"
		ls_dbc[2] = "id_gruppo_agenti"
		ls_dwc[2] = "id_gruppo_agenti"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'c_gruppo_agenti_des'

		ls_dbc[1] = "descrizione"
		ls_dwc[1] = "c_gruppo_agenti_cod"
		ls_dbc[2] = "id_gruppo_agenti"
		ls_dwc[2] = "id_gruppo_agenti"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
	CASE 'c_prof_registrazione_cod'
		ls_dbc[1] = "id_prof_registrazione"
		ls_dwc[1] = "id_prof_registrazione"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "c_prof_registrazione_des"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_prof_registrazione_cod"
		li_ok = uf_autofind_col (string(dwo.name),"prof_registrazione",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
	CASE 'c_prof_registrazione_des'
		ls_dbc[1] = "id_prof_registrazione"
		ls_dwc[1] = "id_prof_registrazione"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "c_prof_registrazione_des"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_prof_registrazione_cod"
		li_ok = uf_autofind_col (string(dwo.name),"prof_registrazione",&
										"descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
	
	
	case "c_locazione_1_cod"
		if isnull(data) or data="" then this.setitem(row,"id_locazione",ll_null)
	case "c_locazione_2_cod"
		if isnull(data) or data="" then this.setitem(row,"id_locazione_2",ll_null)

END CHOOSE

end event

event ue_init;this.ShareData(tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff)
is_colonne_drop[1]="id_caus_magazzino_cod"
is_colonne_drop[2]="id_caus_magazzino_des"
is_colonne_drop[3]="id_tipo_trasporto_cod"
is_colonne_drop[4]="id_tipo_trasporto_des"
is_colonne_drop[5]="id_lingua"
is_colonne_drop[6]="id_lingua_des"
is_colonne_drop[7]="id_linguaggio"
is_colonne_drop[8]="id_linguaggio_des"



end event

event ue_set_search;call super::ue_set_search;
string 	ls_id_sog_commerciale
CHOOSE CASE as_nomecol



	CASE "c_fattura_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	
	CASE "c_fattura_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
	

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

	CASE "c_gruppo_agenti_cod"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		

	CASE "c_gruppo_agenti_des"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		
	
	CASE "c_prof_registrazione_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		

	CASE "c_prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		
	CASE "c_locazione_1_cod"
		is_search_window = "w_locazione_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 

	CASE "c_locazione_2_cod"
		is_search_window = "w_locazione_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 

END CHOOSE
CHOOSE CASE as_nomecol
		
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

event ue_use_search;call super::ue_use_search;
long ll_id_valuta , ll_id_tipo_trasporto, ll_id_sog_commerciale, ll_row, ll_id_magazzino
string ls_locazione

ll_row= GetRow()
CHOOSE CASE as_nomecol
	CASE "c_prof_registrazione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_registrazione_des", is_ricpar.s_ausil_value[1])

	CASE "c_prof_registrazione_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_registrazione_cod", is_ricpar.s_ausil_value[1])

	CASE "c_fattura_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fattura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_fattura_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_fattura_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fattura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_fattura_cod", is_ricpar.s_ausil_value[1])

	CASE "c_vettore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_vettore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_cod", is_ricpar.s_ausil_value[1])

	CASE "c_gruppo_agenti_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_gruppo_agenti_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_cod", is_ricpar.s_ausil_value[1])
	CASE "c_locazione_1_cod"
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("id_locazione", is_ricpar.s_id_seg_value[1])
		
		SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
			INTO :ls_locazione  
			FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
					"dba"."magazzino"   
			WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
					( ( "locazione"."id_locazione" = :is_ricpar.s_id_seg_value[1] ) );
		tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_1_cod", ls_locazione)
		
	CASE "c_locazione_2_cod"
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("id_locazione_2", is_ricpar.s_id_seg_value[1])
		SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
			INTO :ls_locazione  
			FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
					"dba"."magazzino"   
			WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
					( ( "locazione"."id_locazione" = :is_ricpar.s_id_seg_value[1] ) );
		tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_set_colval("c_locazione_2_cod", ls_locazione)


END CHOOSE



end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2162
integer height = 1268
long backcolor = 79741120
string text = "Fatturazione"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_documento_ordine_ext_altro_ff dw_documento_ordine_ext_altro_ff
cb_annotazione cb_annotazione
cb_1 cb_1
end type

on tabpage_2.create
this.dw_documento_ordine_ext_altro_ff=create dw_documento_ordine_ext_altro_ff
this.cb_annotazione=create cb_annotazione
this.cb_1=create cb_1
this.Control[]={this.dw_documento_ordine_ext_altro_ff,&
this.cb_annotazione,&
this.cb_1}
end on

on tabpage_2.destroy
destroy(this.dw_documento_ordine_ext_altro_ff)
destroy(this.cb_annotazione)
destroy(this.cb_1)
end on

type dw_documento_ordine_ext_altro_ff from u_dw_ext_main within tabpage_2
event ue_calc_fields ( )
event ue_resetta_listino ( long al_listino,  long al_variazione )
integer x = 18
integer y = 24
integer width = 2121
integer height = 1224
integer taborder = 22
string dataobject = "d_documento_ordine_ext_altro_ff"
end type

event ue_calc_fields;call super::ue_calc_fields;long 		ll_id_magazzino, ll_row, ll_banca_sog_comm
string 	ls_info, ls_esercizio, ls_cc
string 	ls_codice, ls_descrizione, ls_tipo_registro
long 		ll_destinazione, ll_registro, ll_numero, ll_prof_documento, ll_sog_comm
long		ll_sog_comm_vettore, ll_id_gruppo_agenti, ll_sog_comm_fattura, ll_id_documento_padre

ll_row= GetRow()
if RowCount() > 0 then
ll_sog_comm_fattura = long(uf_get_colval("id_sog_commerciale_fattura"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen" 
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm_fattura )   ;

	
	uf_set_colval("c_fattura_cod",ls_codice)
	uf_set_colval("c_fattura_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_fattura_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_fattura_des", PRIMARY!, NotModified!)

ls_codice = ""
ls_descrizione = ""


ll_banca_sog_comm = long(uf_get_colval("id_banca_sog_commerciale"))

	
	   SELECT "banca_sog_commerciale_gen"."den_abi"+' - '+"banca_sog_commerciale_gen"."den_cab",   
         "banca_sog_commerciale_gen"."conto_corrente", "banca_sog_commerciale_gen"."cin"
   	INTO : ls_codice, :ls_cc, :ls_descrizione
      FROM "banca_sog_commerciale_gen"
	   WHERE ( "banca_sog_commerciale_gen"."id_banca_sog_commerciale" = :ll_banca_sog_comm )   ;
	
	
	uf_set_colval("c_banca_abi_cab_des",ls_codice)
	uf_set_colval("c_conto_corrente",ls_cc)
	uf_set_colval("c_cin",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_banca_abi_cab_des", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_conto_corrente", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_cin", PRIMARY!, NotModified!)

ls_codice = ""
ls_descrizione = ""
ll_id_documento_padre = long(uf_get_colval("id_documento_padre"))

	
	SELECT "registro"."tipo_registro" + ' Nr. ' + Cast("registro"."numero" as Char(8)) + ' - Nr.Progr. ' +  Cast("documento"."num_progressivo" as Char(8)) + ' del ' + Cast("documento"."data_registrazione" as Char(10))  as c_descrizione  
		INTO :ls_descrizione  
		FROM "documento" , "registro"
		WHERE ("documento"."id_documento" = :ll_id_documento_padre ) AND 
				("documento"."id_registro" = "registro"."id_registro" ) ;
	
	
	uf_set_colval("c_doc_padre",ls_descrizione)

	
	
	setitemstatus(ll_row, "c_doc_padre", PRIMARY!, NotModified!)


end if

end event

event ue_resetta_listino;call super::ue_resetta_listino;datawindowchild dwc_variazione

SetItem(1,"id_listino_cod",al_listino)
SetItem(1,"id_listino_des",al_listino)
getchild("id_variazione",dwc_variazione)
dwc_variazione.retrieve(al_listino)
SetItem(1,"id_variazione",al_variazione)
end event

event itemchanged;call super::itemchanged;
long 			ll_id_sog_commerciale, ll_row, ll_id_valuta, ll_id_tipo_trasporto, ll_Cur_IDRegistro, ll_ID_Prof_Doc
long			ll_gg_prev_cons,ll_numero, ll_num_succ, ll_num_prec, ll_id_con_pagamento
long 			ll_id_magazzino, ll_id_locazione, ll_nr_righe, ll_count_righe
string		ls_sc_fin, ls_tipo_registro, ls_descrizione, ls_codice, ls_info
date			ld_Ultima_Data_Reg, ld_Data, ld_data_succ, ld_data_prec
string		ls_tb, ls_cp, ls_vr, ls_tr, ls_rag_soc, ls_sql
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_null
integer		li_ok
decimal 		ldc_tot_righe, ldc_sc_1, ldc_sc_2, ldc_tot_scontato, ldc_sconto_cassa, ldc_null
long			ll_sc_imp

SetNull(ls_null)
SetNull(ldc_null)
ll_row = GetRow()
CHOOSE CASE dwo.name

	CASE 'c_fattura_cod'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_fattura_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale_fattura"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_fattura_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'c_fattura_des'

		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_fattura_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale_fattura"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_fattura_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE "id_listino_cod", "id_listino_des"
		datawindowchild dwc_variazione
		long ll_riga, old_lis, old_var
		date ld_dd
		
		old_lis=getItemNumber(1,"id_listino_cod")
		old_var=getitemnumber(1,"id_variazione")
		ld_dd=id_data_doc
				
		this.getchild("id_variazione",dwc_variazione)
		dwc_variazione.Settransobject(sqlca)
		if dwc_variazione.Retrieve(long(data))>0 then
			ll_riga=dwc_variazione.find("(data_inizio <= date('"+string(id_data_doc)+"')) AND (data_fine >= date('"+string(id_data_doc)+"') OR IsNull(data_fine))",1,dwc_variazione.rowcount())
			if ll_riga>0 then
				this.Setitem(1,"id_variazione",dwc_variazione.GetItemNumber(ll_riga,"id_variazione"))
			else
				messagebox('Attenzione!','Non ci sono variazioni valide per la data del documento nel listino richiesto!')
				post event ue_resetta_listino(old_lis, old_var)
				
			end if
		end if
		
END CHOOSE

end event

event ue_init;call super::ue_init;

is_colonne_drop[1]="id_listino_cod"
is_colonne_drop[2]="id_listino_des"

is_colonne_drop[3]="des_contabile"


end event

event ue_set_search;call super::ue_set_search;string 	ls_id_sog_commerciale
long		ll_id_sog_commerciale_fatt, ll_id_anagrafica,ll_id_sog_commerciale

CHOOSE CASE as_nomecol
	
	CASE "c_fattura_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	
	CASE "c_fattura_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
	CASE "c_doc_padre"
		ls_id_sog_commerciale= uf_get_colval("id_sog_commerciale") 
		is_search_window = "w_documento_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_descrizione" 
		If not(IsNull(ls_id_sog_commerciale) OR ls_id_sog_commerciale ="") then is_ricpar.s_sql_cond = "sog_commerciale_gen.id_sog_commerciale = " + ls_id_sog_commerciale + " AND "
		is_ricpar.s_sql_cond =is_ricpar.s_sql_cond + "prof_documento.contabilizzabile = 'S'"
		
END CHOOSE
CHOOSE CASE as_nomecol
		
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

event ue_use_search;call super::ue_use_search;
long ll_id_valuta , ll_id_tipo_trasporto, ll_id_sog_commerciale, ll_row, ll_id_magazzino

ll_row= GetRow()
CHOOSE CASE as_nomecol
	
	CASE "c_fattura_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fattura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_fattura_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_fattura_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fattura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_fattura_cod", is_ricpar.s_ausil_value[1])

	CASE "c_doc_padre"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_documento_padre", is_ricpar.s_id_seg_value[1])

END CHOOSE

end event

type cb_annotazione from commandbutton within tabpage_2
integer x = 119
integer y = 596
integer width = 306
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annotazioni"
end type

event clicked;string ls_nota
openwithparm(w_annotazione_gd, istr_array)
ls_nota=message.stringparm
if not isnull(ls_nota) and ls_nota>'' then
	dw_documento_ordine_ext_altro_ff.setitem(dw_documento_ordine_ext_altro_ff.getrow(),&
	'note_intestazione', ls_nota)
end if
end event

type cb_1 from commandbutton within tabpage_2
integer x = 123
integer y = 684
integer width = 302
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Annot. sog."
end type

event clicked;string ls_nota
long ll_id_sog_commerciale
openwithparm(w_annotazione_gd,ls_array[10])
ls_nota=message.stringparm
if not isnull(ls_nota) and ls_nota>'' then
	dw_documento_ordine_ext_altro_ff.setitem(dw_documento_ordine_ext_altro_ff.getrow(),&
	'note_intestazione', ls_nota)
end if
dw_documento_ordine_ext_altro_ff.retrieve(ll_id_sog_commerciale)
end event

type cb_annulla from commandbutton within w_documento_ordine_wz
integer x = 329
integer y = 44
integer width = 261
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;Close(parent)
end event

type cb_ok from commandbutton within w_documento_ordine_wz
integer x = 37
integer y = 44
integer width = 261
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;
long ll_accept

ll_accept=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.AcceptText()
ll_accept= ll_accept + tab_1.tabpage_2.dw_documento_ordine_ext_altro_ff.AcceptText()

long ll_id_caus_mag, ll_riga_corrente
string ls_mag_par, ls_mag_des, ls_verifica

ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getrow()
ll_id_caus_mag=long(tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getitemnumber(ll_riga_corrente,"id_caus_magazzino_cod"))
if ll_id_caus_mag<1 or isnull(ll_id_caus_mag) then
	messagebox("Attenzione!", "Non è stata definita la causale!")
	tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.setcolumn("id_caus_magazzino_cod")
	return
end if
select mag_par_richiesto, mag_des_richiesto
into :ls_mag_par, :ls_mag_des
from caus_magazzino
where id_caus_magazzino= :ll_id_caus_mag;
if sqlca.sqlcode=0 then
	
	
	if ls_mag_par='S' then
		ls_verifica=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getitemstring &
			(ll_riga_corrente, "c_locazione_1_cod")
		if ls_verifica="" or isnull(ls_verifica) then
			messagebox("Errore!", "Non è stata specificata la locazione di partenza!")
			return
		end if
	end if
	if ls_mag_des='S' then
		ls_verifica=tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.getitemstring &
			(ll_riga_corrente, "c_locazione_2_cod")
		if ls_verifica="" or isnull(ls_verifica) then
			messagebox("Errore!", "Non è stata specificata la locazione di destinazione!")
			return
		end if
	end if
end if

if ll_accept > 1 then
	ls_array[1] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_unita_confezione")
	ls_array[2] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_documento")  
	ls_array[3] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_prof_documento")   
	ls_array[4] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_registro")  
	ls_array[5] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("num_progressivo")  
	ls_array[6] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_registrazione")  
	ls_array[7] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("num_documento")
	ls_array[8] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_documento")  
	ls_array[9] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_competenza")  
	ls_array[10] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_sog_commerciale")  
	ls_array[11] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_destinazione")  
	ls_array[12] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_caus_magazzino_cod")   
	ls_array[13] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_locazione")  
	ls_array[14] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_locazione_2")  
	ls_array[15] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_sog_commerciale_fattura")    
	ls_array[16] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_lingua")  
	ls_array[17] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_linguaggio")   
	ls_array[18] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_valuta")  
	ls_array[19] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("cambio") 
	ls_array[21] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_listino_cod")
	ls_array[22] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_con_pagamento")  
	ls_array[23] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_banca_sog_commerciale")  
	ls_array[24] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_gruppo_agenti")  
	ls_array[25] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("origine")  
	ls_array[26] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("interlocutore")   
	ls_array[27] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_prev_consegna")  
	ls_array[28] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("note_intestazione")  
	ls_array[29] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("num_colli") 
	ls_array[30] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_unita_misura_peso")   
	ls_array[31] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("peso_netto")   
	ls_array[32] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("peso_lordo")   
	ls_array[33] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_unita_misura_volume")  
	ls_array[34] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("volume")
	//cambio id_tipo_trasporto_cod in id_tipo_trasporto_des 070709
	ls_array[35] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_tipo_trasporto_des")   
	ls_array[36] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_caus_trasporto")  
	ls_array[37] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("asp_beni")  
	ls_array[38] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("tras_mezzo")  
	ls_array[39] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_sog_commerciale_vettore")  
	ls_array[40] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_sog_commerciale_vettore_2")  
	
	ls_array[41] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("mezzo_trasporto")  
	ls_array[42] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("targa_mezzo_trasporto")  
	ls_array[43] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_trasporto")  
	ls_array[44] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("ora_trasporto")  
	ls_array[45] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("sconto_finanziario")  
	ls_array[46] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("sconto_fin_incondizionato")  
	ls_array[47] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("sconto_fin_cassa")  
	ls_array[48] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_dec_pagamento")  
	ls_array[49] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("imp_acconto")  
	ls_array[50] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_tipo_pagamento")  
	ls_array[51] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("stampato") 
	ls_array[52] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("contabilizzato")  
	ls_array[53] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("evaso_totalmente")  
	ls_array[54] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("chius_forzata")  
	ls_array[55] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("sospeso")   
	ls_array[56] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_scadenza")  
	ls_array[57] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("creato_in_esenzione")  
	ls_array[58] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("bloccato")  
	ls_array[59] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("prog_globale")  
	ls_array[60] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("doc_globale") 
	ls_array[61] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_azienda" )
	ls_array[62] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_banca_appoggio")   
	ls_array[63] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("tipo_fattura") 
	ls_array[64] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("segno_iva")  
	ls_array[65] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_documento_padre")
	ls_array[66] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_prof_registrazione")  
	ls_array[67] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("des_contabile")

	ls_array[73] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_prof_doc_cod" )
	ls_array[74] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_prof_doc_des" )
	ls_array[75] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_registro_des" )
	ls_array[76] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_registro" )
	ls_array[77] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_sog_comm_cod" )
	ls_array[78] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_sog_comm_des" )
	ls_array[79] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_destinazione_des" )
	ls_array[80] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_vettore_cod" )
	ls_array[81] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_vettore_des" )
	ls_array[82] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_gruppo_agenti_cod" )
	ls_array[83] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_gruppo_agenti_des" )
	
	
	ls_array[84] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("c_esercizio" )

	
	ls_array[85] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_listino_cod" )	
	ls_array[86] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("id_variazione" )
	
	
	ls_array[87] = tab_1.tabpage_1.dw_documento_ordine_ext_gen_ff.uf_get_colval("data_ric_consegna" )
	
	istr_array.s_array = ls_array
	Close(parent)
end if
end event

