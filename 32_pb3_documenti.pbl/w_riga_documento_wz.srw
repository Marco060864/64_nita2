forward
global type w_riga_documento_wz from w_wiz_main
end type
type tab_1 from tab within w_riga_documento_wz
end type
type tabpage_1 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_riga_documento_ext_gen_ff from u_dw_ext_main within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_1 cb_1
dw_riga_documento_ext_gen_ff dw_riga_documento_ext_gen_ff
cb_2 cb_2
end type
type tabpage_2 from userobject within tab_1
end type
type dw_riga_documento_ext_altro_ff from u_dw_ext_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_riga_documento_ext_altro_ff dw_riga_documento_ext_altro_ff
end type
type tabpage_3 from userobject within tab_1
end type
type dw_riga_documento_ext_agenti_ff from u_dw_ext_main within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_riga_documento_ext_agenti_ff dw_riga_documento_ext_agenti_ff
end type
type tab_1 from tab within w_riga_documento_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type cb_annulla from commandbutton within w_riga_documento_wz
end type
type cb_ok from commandbutton within w_riga_documento_wz
end type
end forward

global type w_riga_documento_wz from w_wiz_main
integer x = 552
integer y = 451
integer width = 2267
integer height = 1994
string title = "Riga Documento"
windowtype windowtype = response!
event ue_ges_ric_riga ( )
tab_1 tab_1
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_riga_documento_wz w_riga_documento_wz

type variables
string	 ls_array[]
char 	 ic_ric_riga[]
s_any_array istr_array
string is_ges_loc
string is_ges_locazioni

decimal id_peso_netto
decimal id_peso_lordo
decimal id_dim_l
decimal id_dim_h
decimal id_dim_p
 
end variables

forward prototypes
public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
public function integer uf_ric_riga (string as_value, string as_field, u_dw_ext_main adw_datawindow)
public subroutine wf_abilita_locazioni (string ls_mag_par, string ls_mag_des)
public subroutine wf_inf_gruppo (string ls_gruppo, integer ai_num_gruppo)
public subroutine wf_gruppo_agenti (integer ai_row)
end prototypes

event ue_ges_ric_riga;

u_dw_ext_main 	ldw_riga_gen, ldw_riga_altro

ldw_riga_gen= tab_1.tabpage_1.dw_riga_documento_ext_gen_ff
ldw_riga_altro= tab_1.tabpage_2.dw_riga_documento_ext_altro_ff
uf_ric_riga( ic_ric_riga[1], "c_uni_conf_cod", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[1], "c_uni_conf_des", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[2], "quantita", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[5], "id_caus_magazzino_cod", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[5], "id_caus_magazzino_des", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[6], "c_locazione_1", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[7], "c_locazione_2", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[8], "data_prev_consegna", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[14], "prezzo", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[15], "sconto", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[17], "sconto_riga", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[18], "id_tab_iva_cod", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[18], "id_tab_iva_des", ldw_riga_gen)
uf_ric_riga( ic_ric_riga[19], "id_gruppo_agenti", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[19], "id_gruppo_agenti_des", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[20], "provv_agente", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[20], "provv_subage", ldw_riga_altro)
uf_ric_riga( ic_ric_riga[20], "provv_carea", ldw_riga_altro)


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

public subroutine wf_abilita_locazioni (string ls_mag_par, string ls_mag_des);if ls_mag_par='N' then
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_1.protect=1
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_1.background.color=12632256
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_1_sw.visible=false
	
else
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_1.protect=0
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_1.background.color=16777215
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_1_sw.visible=true	
	
end if
if ls_mag_des='N' then
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_2.protect=1
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_2.background.color=12632256
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_2_sw.visible=false
	
else
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_2.protect=0
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_2.background.color=16777215
	tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.object.c_locazione_2_sw.visible=true	

end if
end subroutine

public subroutine wf_inf_gruppo (string ls_gruppo, integer ai_num_gruppo);
string ls_codice,ls_rag_soc_1
long ll_agente, ll_sub_agente, ll_capo
if ls_gruppo<>"" and not isnull(ls_gruppo) then
	select id_sog_com_agente, id_sog_com_sub_agente, id_sog_com_capo_area
	into :ll_agente, :ll_sub_agente, :ll_capo
	from gruppo_agenti
	where id_gruppo_agenti=:ls_gruppo;
	
	
	select codice,rag_soc_1
	into :ls_codice,:ls_rag_soc_1
	from sog_commerciale_gen
	where id_sog_commerciale=:ll_agente;
	
	if (ai_num_gruppo = 1 ) Then
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"codice_agente",ls_codice)
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"rag_agente",ls_rag_soc_1)
	else
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"codice_agente_2",ls_codice)
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"rag_agente_2",ls_rag_soc_1)
	end if
	
	ls_codice=""
	ls_rag_soc_1=""
	
	
	select codice,rag_soc_1
	into :ls_codice,:ls_rag_soc_1
	from sog_commerciale_gen
	where id_sog_commerciale=:ll_sub_agente;

	if (ai_num_gruppo = 1 ) Then
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"codice_sub_agente",ls_codice)
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"rag_sub_agente",ls_rag_soc_1)	
	else
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"codice_sub_agente_2",ls_codice)
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"rag_sub_agente_2",ls_rag_soc_1)	
	end if		

	ls_codice=""
	ls_rag_soc_1=""
	
	
	select codice,rag_soc_1
	into :ls_codice,:ls_rag_soc_1
	from sog_commerciale_gen
	where id_sog_commerciale=:ll_capo;
	
	if (ai_num_gruppo = 1 ) Then
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"codice_capo",ls_codice)
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"rag_capo",ls_rag_soc_1)	
	else
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"codice_capo_2",ls_codice)
		tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(1,"rag_capo_2",ls_rag_soc_1)	
	end if
end if
end subroutine

public subroutine wf_gruppo_agenti (integer ai_row);

long 	ll_id_gruppo_agenti, ll_id_gruppo_agenti_2, ll_id_documento
date	ldt_data_reg
s_con_provvigione ls_con_provvigione			

ll_id_gruppo_agenti 	 = long(tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemstring(1,"id_gruppo_agenti"))
ll_id_gruppo_agenti_2 = tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemnumber(1,"id_gruppo_agenti_2")	
	
if ( ll_id_gruppo_agenti > 0 or ll_id_gruppo_agenti_2 > 0 ) then
	ll_id_documento=long(ls_array[51])
	
	SELECT data_registrazione
	INTO	 :ldt_data_reg
	FROM	 documento
	WHERE  id_documento = :ll_id_documento
	;


ls_con_provvigione.id_sog_commerciale  = long(istr_array.s_array[40])
ls_con_provvigione.id_unita_confezione = long(istr_array.s_array[1])
ls_con_provvigione.id_articolo = long(istr_array.s_array[12])
ls_con_provvigione.data = ldt_data_reg
ls_con_provvigione.sconto_perc = tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemstring(ai_row, "sconto")
ls_con_provvigione.sconto_imp = tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemnumber(ai_row, "sconto_riga")
ls_con_provvigione.id_valuta = long(istr_array.s_array[22])
ls_con_provvigione.id_con_lis_articolo = long(istr_array.s_array[52])

if (ll_id_gruppo_agenti > 0) then
	ls_con_provvigione.id_gruppo_agenti = ll_id_gruppo_agenti
	f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff, ai_row, 1, "R")
end if

if (ll_id_gruppo_agenti_2 > 0) then
	ls_con_provvigione.id_gruppo_agenti = ll_id_gruppo_agenti_2
	f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff, ai_row, 2, "R")
end if
end if
end subroutine

on w_riga_documento_wz.create
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

on w_riga_documento_wz.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;long				ll_row
s_any_array 	lstr_array
string			ls_tb, ls_cp, ls_vr, ls_tr, ls_locazione,ls_descrizione, ls_codice
string			ls_dbc[], ls_dbv[], ls_dwc[]
integer			li_ok
long 				ll_nr_column= 48, ll_count, ll_id_riga_documento_padre
string 			ls_nome, ls_agente_codice, ls_agente_descrizione
date				ld_data_vergine
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.TriggerEvent("ue_insert")
ll_row= tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.GetRow()
lstr_array= Message.PowerObjectParm
Message.Processed = TRUE
ls_array= lstr_array.s_array
istr_array= lstr_array
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_unita_confezione", ls_array[1])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("quantita", ls_array[2])
if not (IsNull(ls_array[3]) OR  ls_array[3]=String(ld_data_vergine) OR  ls_array[3]="") then tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("data_prev_consegna",ls_array[3])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prezzo", ls_array[4])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("sconto", ls_array[5])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prezzo_netto", ls_array[6])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("sconto_riga", ls_array[7])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_tab_iva_cod", ls_array[8])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("forza_chius_evasione", ls_array[9])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("sospesa", ls_array[10])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_riga_doc_provenienza", ls_array[11])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_articolo", ls_array[12])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("qta_evasa", ls_array[13])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_gruppo_agenti", ls_array[14])

if ls_array[14]<>"" and not isnull(ls_array[14]) then post wf_inf_gruppo(ls_array[14], 1)

tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_gruppo_agenti_2", ls_array[44])
if ls_array[44]<>"" and not isnull(ls_array[44]) then post wf_inf_gruppo(ls_array[44], 2)

tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("provv_agente_2", ls_array[45])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("provv_subage_2", ls_array[46])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("provv_carea_2", ls_array[47])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prov_imp_agente_2", ls_array[48])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prov_imp_sub_agente_2", ls_array[49])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prov_imp_capo_2", ls_array[50])

//250713 per prezzi confermati e mail e stampato
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("da_stampare",ls_array[53])
//fine 250713

tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("provv_agente", ls_array[15])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("qta_sconto_merce", ls_array[16])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_locazione_1",ls_array[17])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_locazione_2",ls_array[18])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_caus_magazzino_cod",ls_array[19])
ic_ric_riga= ls_array[20]
if isNull(ls_array[21]) OR ls_array[21]="" then ls_array[21]= "0"
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_articolo",ls_array[21])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_valuta_cod",ls_array[22])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("cambio",ls_array[23])
If IsNull(ls_array[24]) then tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.event ue_set_not_new ()
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("provv_subage",ls_array[25])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("provv_carea",ls_array[26])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("id_conto",ls_array[27])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("num_colli",ls_array[30])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("peso_netto",ls_array[31])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("peso_lordo",ls_array[32])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("unita_simbolo",ls_array[33])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("unita_descrizione",ls_array[34])


tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("dim_l",ls_array[35])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("dim_h",ls_array[36])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("dim_p",ls_array[37])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("unita_v_simbolo",ls_array[38])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("unita_v_descrizione",ls_array[39])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prov_imp_agente",ls_array[41])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prov_imp_sub_agente",ls_array[42])
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("prov_imp_capo",ls_array[43])




if dec(ls_array[2]) > 0 then
	id_peso_netto 	= dec(ls_array[31]) / dec(ls_array[2])
	id_peso_lordo 	= dec(ls_array[32]) / dec(ls_array[2])
end if




tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.postevent("ue_post_open")
tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.postevent("ue_post_open")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.postevent("ue_post_open")


ls_dbc[1] = "descrizione"
ls_dbc[2] = "id_unita_confezione"
ls_dbc[3] = "codice"
ls_dwc[1] = "c_uni_conf_des"
ls_dwc[2] = "id_unita_confezione"
ls_dwc[3] = "c_uni_conf_cod"
li_ok = tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_autofind_col ("id_unita_confezione","unita_confezione","id_unita_confezione","A",ls_array[1],"",3,ls_dbc,ls_dbv,ls_dwc)

ls_codice= ""
ls_descrizione= ""
SELECT "conto"."codice",   
	"conto"."descrizione"  
	INTO :ls_codice,   
	:ls_descrizione
	FROM "dba"."conto"  
	WHERE "conto"."id_conto" = :ls_array[27] ;
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("c_conto_cod", ls_codice)
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_set_colval("c_conto_des", ls_descrizione)


ll_id_riga_documento_padre = long(ls_array[11])
ls_descrizione=""
SELECT 'Riga Nr. ' +  Cast( "riga_documento"."num_riga" as Char(8)) + ' - Reg. ' + "registro"."tipo_registro" + ' Nr. ' + Cast("registro"."numero" as Char(8)) + ' - Nr.Progr. ' +  Cast("documento"."num_progressivo" as Char(8)) + ' del ' + Cast("documento"."data_registrazione" as Char(10))  as c_descrizione
	INTO :ls_descrizione  
	FROM "dba"."documento" , "dba"."registro", "dba"."riga_documento"
	WHERE ("riga_documento"."id_riga_documento" = :ll_id_riga_documento_padre ) AND 
			("documento"."id_registro" = "registro"."id_registro" ) AND 
			("documento"."id_documento" = "riga_documento"."id_documento" ) ;

tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.uf_set_colval("c_riga_doc_prov",ls_descrizione)

PostEvent("ue_ges_ric_riga")

end event

event closequery;
Message.PowerObjectParm=istr_array


end event

event ue_post_open;call super::ue_post_open;
string ls_ges_locazioni, ls_mag_par, ls_mag_des, ls_verifica, ls_locazione,ll_null
integer li_ok
long ll_riga_corrente, ll_id_caus_mag, ll_id_mag, ll_ret, ll_id_loc,ll_causale,ll_riga,i
long ll_articolo
decimal ld_qta, ld_sc_riga
setnull(ll_null)
ll_riga_corrente=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getrow()
if ll_riga_corrente>0 then
	
	
	
	
	long ll_id_unita_confezione
	ll_id_unita_confezione=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemnumber&
							(1, "id_unita_confezione")
	ll_causale=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemnumber&
							(1, "id_caus_magazzino_cod")
	select mag_par_richiesto,mag_des_richiesto
	into :ls_mag_par, :ls_mag_des
	from caus_magazzino
	where id_caus_magazzino=:ll_causale;
	
	if (sqlca.sqlcode<>0) and ll_id_unita_confezione<>0 and (not isnull(ll_id_unita_confezione)) then messagebox("Errore","Si è verificato un errore recuperando i dati della cuausale",stopsign!)
	post wf_abilita_locazioni(ls_mag_par,ls_mag_des)
	
	select ges_locazioni
	into :is_ges_loc
	from par_sistema;
	
	ll_riga_corrente=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getrow()
	if ll_riga_corrente <1 then ll_riga_corrente=1
	datastore ds_locazione_mag_lt
	ds_locazione_mag_lt=create datastore
	ds_locazione_mag_lt.dataobject="d_locazione_mag_lt"
	ds_locazione_mag_lt.settransobject(sqlca)
	ds_locazione_mag_lt.retrieve()
	
	
	if is_ges_loc="N" or isnull(is_ges_loc) then
		ls_ges_locazioni=ds_locazione_mag_lt.getitemstring(1, "cc_locazione_mag")
		if ls_mag_par='S' then
	
	
			SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
				INTO :ls_locazione  
				FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
						"dba"."magazzino"   
				WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
						( ( "locazione"."id_locazione" = :ls_array[17] ) );
			if (IsNull(ls_locazione) OR ls_locazione="") AND not IsNull(ls_array[17]) then
				tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.uf_set_colval("c_locazione_1","Locazione di Default")
			else
				tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.uf_set_colval("c_locazione_1", ls_locazione)
			end if
		end if
		if ls_mag_des='S' then
	
	
			SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
				INTO :ls_locazione  
				FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
						"dba"."magazzino"   
				WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
						( ( "locazione"."id_locazione" = :ls_array[18] ) );
			if (IsNull(ls_locazione) OR ls_locazione="") AND not IsNull(ls_array[18]) then
				tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.uf_set_colval("c_locazione_2","Locazione di Default")
			else
				tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.uf_set_colval("c_locazione_2", ls_locazione)
			end if		
		end if
		
		
	else
		ll_id_caus_mag=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemnumber&
							(1, "id_caus_magazzino_cod")
		select mag_par_richiesto, mag_des_richiesto
		into :ls_mag_par, :ls_mag_des
		from caus_magazzino
		where id_caus_magazzino= :ll_id_caus_mag;
		if sqlca.sqlcode=0 then
			
			if ls_mag_par='S' then
				ls_verifica=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getitemstring &
				(ll_riga_corrente, "c_locazione_1")
				
				if ls_verifica="" or isnull(ls_verifica) then
	
	
					select id_magazzino 
					into :ll_id_mag
					from locazione 
					where id_locazione=:ls_array[17];
					ds_locazione_mag_lt.setfilter("locazione_id_magazzino="+string(ll_id_mag))
					ll_ret=ds_locazione_mag_lt.filter()
					if ll_ret<>1 then messagebox("Errore!", "Filtro non corretto")
					ll_riga=0
					for i=1 to ds_locazione_mag_lt.rowcount()
						ll_id_loc=ds_locazione_mag_lt.getitemnumber(i,"locazione_id_locazione")
						ll_articolo=long(ls_array[21])
						select id_articolo
						into :ll_articolo
						from loc_predefinita
						where id_locazione=:ll_id_loc 
						and id_articolo=:ll_articolo;
						if sqlca.sqlcode=0 then ll_riga=i
					next
					if ll_riga>0 then
						ls_locazione=ds_locazione_mag_lt.getitemstring(ll_riga, "cc_locazione_mag")
						
						ll_id_loc=ds_locazione_mag_lt.getitemnumber(ll_riga, "locazione_id_locazione")
					else
						SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
						INTO :ls_locazione  
						FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
								"dba"."magazzino"   
						WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
								( ( "locazione"."id_locazione" = :ls_array[17] ) );
					end if
					tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.setitem&
					(ll_riga_corrente, "id_locazione_1", ll_id_loc)
					
					tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.setitem&
					(ll_riga_corrente, "c_locazione_1", ls_locazione) 
					ds_locazione_mag_lt.setfilter("")
					ds_locazione_mag_lt.filter()
				end if
			end if
			
			if ls_mag_des='S' then
				ls_verifica=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getitemstring &
				(ll_riga_corrente, "c_locazione_2")
				if ls_verifica="" or isnull(ls_verifica) then
	
	
					ll_id_mag=long(ls_array[29])
					ds_locazione_mag_lt.setfilter("locazione_id_magazzino="+string(ll_id_mag))
					ll_ret=ds_locazione_mag_lt.filter()				
					if ll_ret<>1 then messagebox("Errore!", "Filtro non corretto")
					ll_riga=0
					for i=1 to ds_locazione_mag_lt.rowcount()
						ll_id_loc=ds_locazione_mag_lt.getitemnumber(i,"locazione_id_locazione")
						ll_articolo=long(ls_array[21])
						select id_articolo
						into :ll_articolo
						from loc_predefinita
						where id_locazione=:ll_id_loc 
						and id_articolo=:ll_articolo;
						if sqlca.sqlcode=0 then ll_riga=i
					next
					if ll_riga>0 then
						ls_locazione=ds_locazione_mag_lt.getitemstring(1, "cc_locazione_mag")
						ll_id_loc=ds_locazione_mag_lt.getitemnumber(1, "locazione_id_locazione")
					else
						SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
						INTO :ls_locazione  
						FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",   
								"dba"."magazzino"   
						WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and  
								( ( "locazione"."id_locazione" = :ls_array[18] ) );
					end if
					tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.setitem&
					(ll_riga_corrente, "id_locazione_2", ll_id_loc)
					
					tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.setitem&
					(ll_riga_corrente, "c_locazione_2", ls_locazione)
					ds_locazione_mag_lt.setfilter("")
					ds_locazione_mag_lt.filter()
				end if
			else
				ls_verifica=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getitemstring &
				(ll_riga_corrente, "c_locazione_2")
				if ls_verifica>"" then
					setnull(ls_verifica)
					tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.setitem &
					(ll_riga_corrente, "c_locazione_2", ls_verifica)
				end if
			end if
		end if
		
	end if
	
	destroy ds_locazione_mag_lt
end if
ll_riga_corrente=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getrow()
ld_qta=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemdecimal&
			(ll_riga_corrente, "quantita")
			if ld_qta<=0 or isnull(ld_qta) then ld_qta=1
ld_sc_riga=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getitemdecimal&
				(ll_riga_corrente, "sconto_riga")
if(ld_sc_riga>0) then
	if (ld_qta > 0) then ld_sc_riga = ld_sc_riga / ld_qta
	tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(ll_riga_corrente, "c_sconto_unit_riga", ld_sc_riga)
end if

long		ll_id_valuta
string	ls_mask
ll_id_valuta = long(ls_array[22])

ls_mask = f_valu_edit(ll_id_valuta)

tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.Modify("prezzo.format = '" + ls_mask + "'")
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.Modify("prezzo.edit.format = '" + ls_mask + "'")
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.Modify("prezzo_netto.format = '" + ls_mask + "'")
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.Modify("prezzo_netto.edit.format = '" + ls_mask + "'")

ls_mask = f_valu_mask(ll_id_valuta)

tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.Modify("sconto_riga.format = '" + ls_mask + "'")
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.Modify("sconto_riga.edit.format = '" + ls_mask + "'")
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.Modify("c_sconto_unit_riga.format = '" + ls_mask + "'")

tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_capo.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_capo.edit.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_agente.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_agente.edit.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_sub_agente.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_sub_agente.edit.format = '" + ls_mask + "'")

tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_capo_2.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_capo_2.edit.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_agente_2.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_agente_2.edit.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_sub_agente_2.format = '" + ls_mask + "'")
tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.Modify("prov_imp_sub_agente_2.edit.format = '" + ls_mask + "'")

end event

type tab_1 from tab within w_riga_documento_wz
integer y = 160
integer width = 2198
integer height = 1699
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
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 15
integer y = 90
integer width = 2169
integer height = 1597
long backcolor = 79741120
string text = "Dati Articolo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_1 cb_1
dw_riga_documento_ext_gen_ff dw_riga_documento_ext_gen_ff
cb_2 cb_2
end type

on tabpage_1.create
this.cb_1=create cb_1
this.dw_riga_documento_ext_gen_ff=create dw_riga_documento_ext_gen_ff
this.cb_2=create cb_2
this.Control[]={this.cb_1,&
this.dw_riga_documento_ext_gen_ff,&
this.cb_2}
end on

on tabpage_1.destroy
destroy(this.cb_1)
destroy(this.dw_riga_documento_ext_gen_ff)
destroy(this.cb_2)
end on

type cb_1 from commandbutton within tabpage_1
integer x = 110
integer y = 554
integer width = 296
integer height = 80
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Peso_Netto"
end type

event clicked;boolean lb_controllo
string ls_prova
char lc_rit[255]
long	ll_row
lc_rit=space(255)
ls_prova='Mettler 16'
lb_controllo=GetWeight(ls_prova,lc_rit)
ll_row = tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getrow()
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(ll_row,"peso_netto",dec(string(lc_rit)))


end event

type dw_riga_documento_ext_gen_ff from u_dw_ext_main within tabpage_1
event ue_set_not_new ( )
event ue_post_itemchanged ( long al_riga,  string as_colonna,  string as_message )
integer y = 19
integer width = 2154
integer height = 1546
string dataobject = "d_riga_documento_ext_gen_ff"
end type

event ue_post_itemchanged;call super::ue_post_itemchanged;
decimal ld_qta=0

messagebox("Attenzione!", as_message)

setitem(al_riga, as_colonna, ld_qta)
setcolumn(as_colonna)

end event

event constructor;call super::constructor;this.ShareData(tab_1.tabpage_2.dw_riga_documento_ext_altro_ff)
this.ShareData(tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff)

f_displayonly(this, "prezzo_netto",true)
f_displayonly(this, "id_riga_doc_provenienza",TRUE)
f_displayonly(this, "qta_evasa",true)


end event

event itemchanged;string		ls_tb, ls_cp, ls_vr, ls_tr,ls_gruppo,ls_null
string		ls_dbc[], ls_dbv[], ls_dwc[]
integer		li_ok
long 			ll_row, ll_id_locazione, ll_id_valuta, ll_id_unita_conf
decimal 		ldc_cambio, ld_qta, ld_sc_riga, ld_sc_unit_riga,ld_null
string 		ls_message, ls_tipo

setnull(ld_null)
setnull(ls_null)
ll_row= GetRow()

CHOOSE CASE dwo.name
	
	CASE "c_uni_conf_cod"
		
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_unita_confezione"
		ls_dbc[3] = "codice"

		
		ls_dwc[1] = "c_uni_conf_des"
		ls_dwc[2] = "id_unita_confezione"
		ls_dwc[3] = "c_uni_conf_cod"

		li_ok = uf_autofind_col (string(dwo.name),"unita_confezione","codice","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_articolo")),3,ls_dbc,ls_dbv,ls_dwc)

		if li_ok > 0 then
			return 2 
		end if
	
	CASE "c_uni_conf_des"

		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_unita_confezione"
		ls_dbc[3] = "codice"
		ls_dwc[1] = "c_uni_conf_des"
		ls_dwc[2] = "id_unita_confezione"
		ls_dwc[3] = "c_uni_conf_cod"
		li_ok = uf_autofind_col (string(dwo.name),"unita_confezione","descrizione","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_articolo")),3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE "c_locazione_1"

		ls_dbc[1] = "cc_locazione_mag"
		ls_dbc[2] = "id_locazione"
		
		ls_dwc[1] = "c_locazione_1"
		ls_dwc[2] = "id_locazione_1"
		
		li_ok = uf_autofind_col (string(dwo.name),"locazione","cc_locazione_mag","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_locazione_1")),2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
	
	CASE "c_locazione_2"

		ls_dbc[1] = "cc_locazione_mag"
		ls_dbc[2] = "id_locazione"
		
		ls_dwc[1] = "c_locazione_2"
		ls_dwc[2] = "id_locazione_2"
		
		li_ok = uf_autofind_col (string(dwo.name),"locazione","cc_locazione_mag","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_locazione_2")),2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE "id_valuta_cod", "id_valuta_des"
		ll_id_valuta= Long(data)
		SELECT "valuta"."cambio"  
			INTO :ldc_cambio  
			FROM "valuta"  
			WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
		SetItem(ll_row, "cambio",ldc_cambio)
CASE "c_conto_cod"

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "c_conto_cod"
		ls_dwc[2] = "c_conto_des"

		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col (string(dwo.name),"conto_azienda","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

CASE "c_conto_des"

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "c_conto_cod"
		ls_dwc[2] = "c_conto_des"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col (string(dwo.name),"conto_azienda","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
CASE "quantita"
		setitem(row,"peso_netto",dec(data)*id_peso_netto)
		setitem(row,"peso_lordo",dec(data)*id_peso_lordo)
		ld_sc_riga=getitemdecimal(row, "sconto_riga")
		if(ld_sc_riga>0) then
			setitem(getrow(), "c_sconto_unit_riga", ld_sc_riga/dec(data))
		else
			ld_sc_unit_riga=getitemdecimal(getrow(), "c_sconto_unit_riga")
			if ld_sc_unit_riga>0 then setitem(getrow(), "sconto_riga", ld_sc_unit_riga*dec(data))
		end if
		
		if (dec(data) > 0) then
			long ll_colli
			ll_id_unita_conf=getitemnumber(row, "id_unita_confezione")			
			
			SELECT num_colli
			INTO	 :ll_colli
			FROM	 unita_confezione
			WHERE  id_unita_confezione = :ll_id_unita_conf
			;
			if (SQLCA.SQLCODE = -1) then messagebox("DBError", SQLCA.SQLERRTEXT)
			ll_colli = ll_colli * dec(data)
			setitem(row, "num_colli", ll_colli)
		end if
CASE "c_sconto_unit_riga", "sconto_riga"
		ll_id_unita_conf=getitemnumber(row, "id_unita_confezione")
		select  tipo
		into    :ls_tipo
		from    unita_confezione, unita_misura
		where   (unita_confezione.id_unita_confezione=:ll_id_unita_conf) 
		and     (unita_confezione.id_unita_misura=unita_misura.id_unita_misura)
		;
		choose case ls_tipo
		case "P"
			ld_qta=getitemdecimal(row, "peso_netto")
		case else 
			ld_qta=getitemdecimal(row, "quantita")
		end choose
		
		if ld_qta=0 or isnull(ld_qta) then ld_qta=1
		if dwo.name="c_sconto_unit_riga" then
			setitem(getrow(), "sconto_riga", dec(data)*ld_qta)
		else
			setitem(getrow(), "c_sconto_unit_riga", dec(data)/ld_qta)
		end if
		
		

		
		
		
		
		
		
CASE "sconto"
		setitem(getrow(),"c_sconto_unit_riga",ld_null)
		
		
		
		ls_gruppo=getitemstring(getrow(),"id_gruppo_agenti")
		
		
		
		
		
		

case "qta_sconto_merce"
		if dec(data)< 0 then 
			ls_message="La quantità sconto merce deve essere~r~n"+&
		"positiva!"
			post event ue_post_itemchanged(row, string(dwo.name), ls_message)
			return
		end if
		
END CHOOSE

if (dwo.name = "sconto" or dwo.name = "c_sconto_unit_riga" or dwo.name = "sconto_riga") then
	post wf_gruppo_agenti(row)
end if

end event

event itemerror;call super::itemerror;decimal ldc_prezzo

CHOOSE CASE dwo.name
	CASE "sconto"
		ldc_prezzo= uf_calcola_prezzo(string(data), 100, 1)
		if IsNull(ldc_prezzo) then
			MessageBox("Riga Documento", "Ricontrollare lo sconto immesso.")
			RETURN 1
		else
			RETURN 2
		end if
END CHOOSE
end event

event ue_init;call super::ue_init;is_colonne_drop[1]="id_tab_iva_cod"
is_colonne_drop[2]="id_tab_iva_des"
is_colonne_drop[3]="unita_simbolo"
is_colonne_drop[4]="unita_descrizione"


end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
CHOOSE CASE as_nomecol
	CASE "c_uni_conf_des"
		is_search_window = "w_unita_confezione_coddes_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "unita_confezione_descrizione" 
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + String(uf_get_colval("id_articolo"))

	CASE "c_uni_conf_cod"
		is_search_window = "w_unita_confezione_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "unita_confezione_codice" 
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + String(uf_get_colval("id_articolo"))

	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;long ll_row, ll_ret_value
decimal	ld_qta
date ld_comp
u_dw_main ldw_doc

ll_row= GetRow()


ld_qta = getitemdecimal(ll_row,"quantita")
CHOOSE CASE as_nomecol

	CASE "c_uni_conf_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_uni_conf_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("peso_netto",is_ricpar.s_ausil_value[2])
		uf_set_colval("peso_lordo",is_ricpar.s_ausil_value[3])
		uf_set_colval("unita_simbolo",is_ricpar.s_ausil_value[4])
		uf_set_colval("unita_descrizione",is_ricpar.s_ausil_value[5])
		uf_set_colval("unita_v_simbolo",is_ricpar.s_ausil_value[6])
		uf_set_colval("unita_v_descrizione",is_ricpar.s_ausil_value[7])
		uf_set_colval("num_colli",string (dec (is_ricpar.s_ausil_value[8]) *ld_qta) )
	CASE "c_uni_conf_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_uni_conf_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("peso_netto",is_ricpar.s_ausil_value[2])
		uf_set_colval("peso_lordo",is_ricpar.s_ausil_value[3])
		uf_set_colval("unita_simbolo",is_ricpar.s_ausil_value[4])
		uf_set_colval("unita_descrizione",is_ricpar.s_ausil_value[5])
		uf_set_colval("unita_v_simbolo",is_ricpar.s_ausil_value[6])
		uf_set_colval("unita_v_descrizione",is_ricpar.s_ausil_value[7])
		uf_set_colval("num_colli",string (dec (is_ricpar.s_ausil_value[8]) *ld_qta) )
	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
		
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

type cb_2 from commandbutton within tabpage_1
integer x = 1152
integer y = 554
integer width = 311
integer height = 80
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Peso_Lordo"
end type

event clicked;boolean lb_controllo
string ls_prova
char lc_rit[255]
long	ll_row
lc_rit=space(255)
ls_prova='Mettler 16'
lb_controllo=GetWeight(ls_prova,lc_rit)
ll_row = tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.getrow()
tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.setitem(ll_row,"peso_lordo",dec(string(lc_rit)))

end event

type tabpage_2 from userobject within tab_1
integer x = 15
integer y = 90
integer width = 2169
integer height = 1597
long backcolor = 79741120
string text = "Info"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_riga_documento_ext_altro_ff dw_riga_documento_ext_altro_ff
end type

on tabpage_2.create
this.dw_riga_documento_ext_altro_ff=create dw_riga_documento_ext_altro_ff
this.Control[]={this.dw_riga_documento_ext_altro_ff}
end on

on tabpage_2.destroy
destroy(this.dw_riga_documento_ext_altro_ff)
end on

type dw_riga_documento_ext_altro_ff from u_dw_ext_main within tabpage_2
event ue_set_not_new ( )
integer x = 7
integer y = 16
integer width = 2143
integer height = 1549
string dataobject = "d_riga_documento_ext_altro_ff"
end type

event ue_set_not_new;call super::ue_set_not_new;

f_displayonly(this, "cambio", TRUE)

end event

event constructor;call super::constructor;f_displayonly(this, "c_agente_cod",TRUE)
f_displayonly(this, "c_agente_des",TRUE)

end event

event itemchanged;string		ls_tb, ls_cp, ls_vr, ls_tr
string		ls_dbc[], ls_dbv[], ls_dwc[]
integer		li_ok
long 			ll_row, ll_id_locazione, ll_id_valuta
decimal 		ldc_cambio

ll_row= GetRow()
CHOOSE CASE dwo.name
	
	CASE "c_uni_conf_cod"
		
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_unita_confezione"
		ls_dbc[3] = "codice"
		ls_dwc[1] = "c_uni_conf_des"
		ls_dwc[2] = "riga_documento_id_articolo"
		ls_dwc[3] = "c_uni_conf_cod"
		li_ok = uf_autofind_col (string(dwo.name),"unita_confezione","codice","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_articolo")),3,ls_dbc,ls_dbv,ls_dwc)

		if li_ok > 0 then
			return 2 
		end if
	
	CASE "c_uni_conf_des"

		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_unita_confezione"
		ls_dbc[3] = "codice"
		ls_dwc[1] = "c_uni_conf_des"
		ls_dwc[2] = "riga_documento_id_articolo"
		ls_dwc[3] = "c_uni_conf_cod"
		li_ok = uf_autofind_col (string(dwo.name),"unita_confezione","descrizione","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_articolo")),3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE "c_locazione_1"

		ls_dbc[1] = "cc_locazione_mag"
		ls_dbc[2] = "id_locazione"
		
		ls_dwc[1] = "c_locazione_1"
		ls_dwc[2] = "id_locazione_1"
		
		li_ok = uf_autofind_col (string(dwo.name),"locazione","cc_locazione_mag","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_locazione_1")),2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
	
	CASE "c_locazione_2"

		ls_dbc[1] = "cc_locazione_mag"
		ls_dbc[2] = "id_locazione"
		
		ls_dwc[1] = "c_locazione_2"
		ls_dwc[2] = "id_locazione_2"
		
		li_ok = uf_autofind_col (string(dwo.name),"locazione","cc_locazione_mag","A",data,"unita_confezione.id_articolo = " + String(uf_get_colval("id_locazione_2")),2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE "id_valuta_cod", "id_valuta_des"
		ll_id_valuta= Long(data)
		SELECT "valuta"."cambio"  
			INTO :ldc_cambio  
			FROM "valuta"  
			WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
		SetItem(ll_row, "cambio",ldc_cambio)
END CHOOSE
end event

event itemerror;call super::itemerror;decimal ldc_prezzo

CHOOSE CASE dwo.name
	CASE "sconto"
		ldc_prezzo= uf_calcola_prezzo(string(data), 100, 1)
		if IsNull(ldc_prezzo) then
			MessageBox("Riga Documento", "Ricontrollare lo sconto immesso.")
			RETURN 1
		else
			RETURN 2
		end if
END CHOOSE
end event

event ue_init;is_colonne_drop[1]="id_unita_confezione"
is_colonne_drop[2]="id_tab_iva_cod"
is_colonne_drop[3]="id_tab_iva_des"
is_colonne_drop[4]="id_caus_magazzino_cod"
is_colonne_drop[5]="id_caus_magazzino_des"
is_colonne_drop[6]="id_valuta_cod"
is_colonne_drop[7]="id_valuta_des"
is_colonne_drop[8]="id_gruppo_agenti"
is_colonne_drop[9]="id_gruppo_agenti_des"

is_colonne_drop[10]="id_gruppo_agenti_2"
is_colonne_drop[11]="id_gruppo_agenti_2_des"
is_colonne_drop[12]="da_stampare"

end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol

	CASE "c_locazione_1"
		is_search_window = "w_locazione_art_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 
		is_ricpar.s_main_value  = ls_array[12]
	CASE "c_locazione_2"
		is_search_window = "w_locazione_art_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 
		is_ricpar.s_main_value  = ls_array[12]
	CASE "c_riga_doc_prov"
		is_search_window = "w_riga_documento_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_descrizione" 

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;long ll_row, ll_ret_value

date ld_comp
u_dw_main ldw_doc
ll_row= GetRow()
CHOOSE CASE as_nomecol
	CASE "c_locazione_1"
		if (IsNull(is_ricpar.s_main_value) OR  is_ricpar.s_main_value="") AND not IsNull(is_ricpar.s_id_seg_value[1]) then
			uf_set_colval(as_nomecol, "Locazione di Default")
		else
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		end if
		uf_set_colval("id_locazione_1", is_ricpar.s_id_seg_value[1])
		
	CASE "c_locazione_2"
		if (IsNull(is_ricpar.s_main_value) OR  is_ricpar.s_main_value="") AND not IsNull(is_ricpar.s_id_seg_value[1]) then
			uf_set_colval(as_nomecol, "Locazione di Default")
		else
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		end if
		uf_set_colval("id_locazione_2", is_ricpar.s_id_seg_value[1])

	CASE "c_riga_doc_prov"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_riga_doc_provenienza", is_ricpar.s_id_seg_value[1])
END CHOOSE

end event

type tabpage_3 from userobject within tab_1
integer x = 15
integer y = 90
integer width = 2169
integer height = 1597
long backcolor = 79741120
string text = "Gestione Agenti"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_riga_documento_ext_agenti_ff dw_riga_documento_ext_agenti_ff
end type

on tabpage_3.create
this.dw_riga_documento_ext_agenti_ff=create dw_riga_documento_ext_agenti_ff
this.Control[]={this.dw_riga_documento_ext_agenti_ff}
end on

on tabpage_3.destroy
destroy(this.dw_riga_documento_ext_agenti_ff)
end on

type dw_riga_documento_ext_agenti_ff from u_dw_ext_main within tabpage_3
integer x = 7
integer y = 16
integer width = 2128
integer height = 1549
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_riga_documento_ext_agenti_ff"
end type

event ue_init;is_colonne_drop[1]="id_gruppo_agenti"
is_colonne_drop[2]="id_gruppo_agenti_des"
is_colonne_drop[3]="id_gruppo_agenti_2"
is_colonne_drop[4]="id_gruppo_agenti_2_des"

end event

event itemchanged;

string		ls_tb, ls_cp, ls_vr, ls_tr
string		ls_dbc[], ls_dbv[], ls_dwc[]
integer		li_ok
long 			ll_row, ll_id_locazione, ll_id_valuta
decimal 		ldc_cambio

long					ll_id_gruppo_agenti, ll_id_documento
date					ldt_data_reg
s_con_provvigione ls_con_provvigione

ll_row= GetRow()
CHOOSE CASE dwo.name
	case "id_gruppo_agenti"
		
		
		post f_gruppo_agenti(tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff, 1, 1, "R")
		
	case "id_gruppo_agenti_2"
		
		
		post f_gruppo_agenti(tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff, 1, 2, "R")
		
END CHOOSE


if (dwo.name = "id_gruppo_agenti" or dwo.name = "id_gruppo_agenti_2" ) then
	ll_id_gruppo_agenti 	 = long(data)
	
	if ( ll_id_gruppo_agenti > 0 ) then
		ll_id_documento=long(ls_array[51])
	
		SELECT data_registrazione
		INTO	 :ldt_data_reg
		FROM	 documento
		WHERE  id_documento = :ll_id_documento
		;	
		
		ls_con_provvigione.id_gruppo_agenti = ll_id_gruppo_agenti
		ls_con_provvigione.id_sog_commerciale  = long(istr_array.s_array[40])
		ls_con_provvigione.id_unita_confezione = long(istr_array.s_array[1])
		ls_con_provvigione.id_articolo = long(istr_array.s_array[12])
		ls_con_provvigione.data = ldt_data_reg
		ls_con_provvigione.sconto_perc = this.getitemstring(row, "sconto")		
		ls_con_provvigione.sconto_imp = this.getitemnumber(row, "sconto_riga")		
		ls_con_provvigione.id_valuta = long(istr_array.s_array[22])
		ls_con_provvigione.id_con_lis_articolo = long(istr_array.s_array[52])		
	end if
end if		

if (dwo.name = "id_gruppo_agenti") then
	if (ll_id_gruppo_agenti > 0) then
		post f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff, row, 1, "R")
	end if
end if

if (dwo.name = "id_gruppo_agenti_2") then
	if (ll_id_gruppo_agenti > 0) then
		post f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff, row, 2, "R")
	end if
end if
end event

type cb_annulla from commandbutton within w_riga_documento_wz
integer x = 329
integer y = 32
integer width = 260
integer height = 83
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

type cb_ok from commandbutton within w_riga_documento_wz
integer x = 37
integer y = 32
integer width = 260
integer height = 83
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;long ll_accept

long  ll_id_caus_mag
string ls_verifica, ls_mag_par, ls_mag_des
if is_ges_loc='S' then
	ll_accept=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getrow()
	ll_id_caus_mag=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getitemnumber&
	(ll_accept,"id_caus_magazzino_cod")
	select mag_par_richiesto, mag_des_richiesto
	into :ls_mag_par, :ls_mag_des
	from caus_magazzino
	where id_caus_magazzino= :ll_id_caus_mag;
	if sqlca.sqlcode=0 then
		if ls_mag_par='S' then
			ls_verifica=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getitemstring &
			(ll_accept, "c_locazione_1")
			if ls_verifica="" or isnull(ls_verifica) then
				messagebox("Errore!", "Non è stata specificata la locazione di partenza!")
				return
			end if
		end if
		if ls_mag_des='S' then
			ls_verifica=tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.getitemstring &
			(ll_accept, "c_locazione_2")
			if ls_verifica="" or isnull(ls_verifica) then
				messagebox("Errore!", "Non è stato specificato la locazione di destinazione!")
				return
			end if
		end if
	end if
end if

ll_accept=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.AcceptText()
ll_accept=ll_accept + tab_1.tabpage_2.dw_riga_documento_ext_altro_ff.AcceptText()
ll_accept=ll_accept + tab_1.tabpage_3.dw_riga_documento_ext_agenti_ff.AcceptText()
if ll_accept > 1 then
	ls_array[1]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_unita_confezione")
	ls_array[2]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("quantita")
	ls_array[3]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("data_prev_consegna")
	ls_array[4]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prezzo")
	ls_array[5]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("sconto" )
	ls_array[6]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prezzo_netto")
	ls_array[7]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("sconto_riga")
	ls_array[8]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_tab_iva_cod" )
	ls_array[9]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("forza_chius_evasione" )
	ls_array[10]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("sospesa" )
	ls_array[11]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_riga_doc_provenienza")
	ls_array[12]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_articolo")
	ls_array[13]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("qta_evasa")
	ls_array[14]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_gruppo_agenti")
	ls_array[15]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("provv_agente")
	ls_array[16]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("qta_sconto_merce")
	ls_array[17]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_locazione_1")
	ls_array[18]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_locazione_2")
	ls_array[19]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_caus_magazzino_cod")
	ls_array[22]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_valuta_cod")
	ls_array[23]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("cambio")
	ls_array[25]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("provv_subage")
	ls_array[26]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("provv_carea")
	ls_array[27]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_conto")
	ls_array[30]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("num_colli")
	ls_array[31]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("peso_netto")
	ls_array[32]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("peso_lordo")
	
	
	
	ls_array[35]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("dim_l")
	ls_array[36]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("dim_h")
	ls_array[37]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("dim_p")
	
	
	
	ls_array[41]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prov_imp_agente")
	ls_array[42]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prov_imp_sub_agente")
	ls_array[43]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prov_imp_capo")
	
	
	
	
	
	ls_array[44]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("id_gruppo_agenti_2")
	ls_array[45]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("provv_agente_2")
	ls_array[46]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("provv_subage_2")
	ls_array[47]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("provv_carea_2")
	ls_array[48]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prov_imp_agente_2")
	ls_array[49]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prov_imp_sub_agente_2")
	ls_array[50]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("prov_imp_capo_2")
	//250713 per prezzi confermati e stamp mail
	ls_array[53]=tab_1.tabpage_1.dw_riga_documento_ext_gen_ff.uf_get_colval("da_stampare")
	
	
	istr_array.s_array = ls_array
	Close(parent)
end if
end event

