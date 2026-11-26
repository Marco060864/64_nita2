forward
global type w_liquidazione_provvigioni_ff from Window
end type
type cb_esegui from commandbutton within w_liquidazione_provvigioni_ff
end type
type cb_1 from commandbutton within w_liquidazione_provvigioni_ff
end type
type dw_liquidazione_provvigioni_ff from u_dw_ext_main within w_liquidazione_provvigioni_ff
end type
end forward

global type w_liquidazione_provvigioni_ff from Window
int X=832
int Y=360
int Width=2450
int Height=1032
boolean TitleBar=true
string Title="Liquidazione Provvigioni Agenti"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_esegui cb_esegui
cb_1 cb_1
dw_liquidazione_provvigioni_ff dw_liquidazione_provvigioni_ff
end type
global w_liquidazione_provvigioni_ff w_liquidazione_provvigioni_ff

on w_liquidazione_provvigioni_ff.create
this.cb_esegui=create cb_esegui
this.cb_1=create cb_1
this.dw_liquidazione_provvigioni_ff=create dw_liquidazione_provvigioni_ff
this.Control[]={this.cb_esegui,&
this.cb_1,&
this.dw_liquidazione_provvigioni_ff}
end on

on w_liquidazione_provvigioni_ff.destroy
destroy(this.cb_esegui)
destroy(this.cb_1)
destroy(this.dw_liquidazione_provvigioni_ff)
end on

event open;dw_liquidazione_provvigioni_ff.insertrow(1)
dw_liquidazione_provvigioni_ff.setfocus()
dw_liquidazione_provvigioni_ff.setcolumn('elaborazione')
end event

type cb_esegui from commandbutton within w_liquidazione_provvigioni_ff
int X=2121
int Y=28
int Width=261
int Height=88
int TabOrder=10
string Text="&Esegui"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
datastore lds_rip_provv
u_liq_provvigioni l_u_liq
s_budget ls_budget[]

string 	ls_da_agente,ls_a_agente,ls_periodo,ls_pagamenti,ls_definitiva
date 		ld_data,ld_data_registrazione,ld_data_incassi
integer 	li_righe
long 		ll_id_reg_pd,ll_id_registro,ll_num_progressivo,i,ll_id_documento,ll_id_agente
long 		ll_id_riep_provvigioni
boolean 	lb_ritorno
long	   ll_id_gruppo_agenti 


dw_liquidazione_provvigioni_ff.accepttext()
ld_data=dw_liquidazione_provvigioni_ff.getitemdate(1,"elaborazione")
ls_da_agente=dw_liquidazione_provvigioni_ff.getitemstring(1,"da_agente")
ls_a_agente=dw_liquidazione_provvigioni_ff.getitemstring(1,"a_agente")
ld_data_incassi=dw_liquidazione_provvigioni_ff.getitemdate(1,"incassi")
ls_periodo=dw_liquidazione_provvigioni_ff.getitemstring(1,"periodo")
ls_pagamenti=dw_liquidazione_provvigioni_ff.getitemstring(1,"premi_penalita")
ls_definitiva=dw_liquidazione_provvigioni_ff.getitemstring(1,"definitiva")

If ld_data > ld_data_incassi Then
	MessageBox("Liquidazione provvigioni Agenti", "Specificare una Data incassi superiore o uguale a quella di elaborazione")
	Return
End If

open(w_attesa)
COMMIT USING SQLCA;
l_u_liq=create u_liq_provvigioni
lds_rip_provv=create datastore
lds_rip_provv.dataobject='d_riep_provvigioni_liq_lt'
lds_rip_provv.settransobject(sqlca)
if ls_definitiva='S' then
	l_u_liq.ib_definitiva=true
else
	l_u_liq.ib_definitiva=false
end if
if ls_pagamenti='S' then
	l_u_liq.ib_pagamenti=true
else
	l_u_liq.ib_pagamenti=false
end if
if (isnull(ls_da_agente) or ls_da_agente = '') then 
	SELECT MIN(s.codice)
	INTO	 :ls_da_agente
	FROM	 sog_commerciale s, riep_provvigioni r
	WHERE  s.id_sog_commerciale=r.id_agente
	;
end if
if (isnull(ls_a_agente) or ls_a_agente = '') then 
	SELECT MAX(s.codice)
	INTO	 :ls_a_agente
	FROM	 sog_commerciale s, riep_provvigioni r
	WHERE  s.id_sog_commerciale=r.id_agente
	;
end if
li_righe=lds_rip_provv.retrieve(ls_da_agente,ls_a_agente,ld_data)

if li_righe>0 then
	
	
	for i= 1 to li_righe	
		ll_num_progressivo=lds_rip_provv.getitemnumber(i,"documento_num_progressivo")
		ll_id_registro=lds_rip_provv.getitemnumber(i,"documento_id_registro")
		ld_data_registrazione=lds_rip_provv.getitemdate(i,"documento_data_registrazione")
		ll_id_documento=lds_rip_provv.getitemnumber(i,"documento_id_documento")
		ll_id_agente=lds_rip_provv.getitemnumber(i,"riep_provvigioni_id_agente")
		ll_id_riep_provvigioni=lds_rip_provv.getitemnumber(i,"riep_provvigioni_id_riep_provvigioni")
		ll_id_gruppo_agenti = lds_rip_provv.getitemnumber(i,"riep_provvigioni_id_gruppo_agenti")
		
		SELECT reg_pd.id_reg_pd
		INTO :ll_id_reg_pd
		FROM reg_pd
		WHERE (reg_pd.num_progressivo    = :ll_num_progressivo)    AND
				(reg_pd.data_registrazione = :ld_data_registrazione) AND
				(reg_pd.id_registro        = :ll_id_registro);
		if sqlca.sqlcode=0 then
			
			lb_ritorno=l_u_liq.uf_liquidazione_provvigioni(ll_id_reg_pd,ll_id_documento,&
			ld_data_incassi,ll_id_agente,ll_id_riep_provvigioni,ld_data,ls_periodo,ls_budget,ls_definitiva,ll_id_gruppo_agenti)
		else
			messagebox("Errore","Si è verificato un errore nel recupero della registrazione contabile!",stopsign!)
		end if
	next
	
	l_u_liq.uf_budget(ls_budget,ld_data)
else
	Messagebox("Informazione!","Non è possibile recuperare nessun record con questi parametri!")
	Close(w_attesa)	
	Return
end if

String ls_filtro, ls_parametri, ls_tipo_stampa
Date	 ld_fino_al
	
str_liq_prov str_param

ls_parametri = ' Elaborazione fino al: ' + String(ld_data) + ' Incassi fino al: ' + String(ld_data_incassi)

ls_filtro="documento.data_registrazione <= " + "'" + String(ld_data, 'yyyy-mm-dd') + "'"

If not isnull(ls_da_agente) and ls_da_agente <> '' then
	ls_filtro=ls_filtro+" AND sog_commerciale.codice >= " + "'" + String(ls_da_agente) + "'"
	ls_parametri=ls_parametri + ' Da Agente:' + ls_da_agente
End If

if not isnull(ls_da_agente) and ls_a_agente <> '' then
	ls_filtro=ls_filtro + " AND sog_commerciale.codice <= " + "'" + String(ls_a_agente) + "'"
	ls_parametri=ls_parametri + ' A Agente:' + ls_a_agente
End If

str_param.filtro=ls_filtro
str_param.parametri=ls_parametri

If ls_definitiva='N' then 
	
	Close(w_attesa)
	str_param.flag='P'
	OpenWithParm(w_liq_prov_agenti_rpt, str_param)
	ROLLBACK USING SQLCA;
	
Else
	
	Close(w_attesa)
	COMMIT USING SQLCA;
	
	Integer li_ret 
	str_param.flag='D'
	li_ret = MessageBox("Liquidazione provvigioni Agenti", "Vuoi stampare i dati elaborati ?", Question!, YesNo!)
	If li_ret = 1 Then
		OpenWithParm(w_liq_prov_agenti_rpt, str_param)		
	End If
	
End if

Destroy l_u_liq
Destroy lds_rip_provv
end event

type cb_1 from commandbutton within w_liquidazione_provvigioni_ff
int X=37
int Y=28
int Width=265
int Height=88
int TabOrder=20
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_liquidazione_provvigioni_ff from u_dw_ext_main within w_liquidazione_provvigioni_ff
int X=23
int Y=160
int Width=2359
int Height=740
int TabOrder=30
string DataObject="d_liquidazione_provvigioni_ff"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_agente",  "a_agente"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"
	CASE "da_rag_soc_1", "a_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"		
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_agente"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_rag_soc_1", is_ricpar.s_ausil_value[1])
		if isnull(This.getitemstring(1,"a_agente")) or This.getitemstring(1,"a_agente")='' then
		  uf_set_colval("a_agente", is_ricpar.s_main_value)
  		  uf_set_colval("a_rag_soc_1", is_ricpar.s_ausil_value[1])
	   end if	
		
	CASE "da_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_agente", is_ricpar.s_ausil_value[1])
		if isnull(This.getitemstring(1,"a_agente")) or This.getitemstring(1,"a_agente")='' then
		  uf_set_colval("a_rag_soc_1", is_ricpar.s_main_value)
  		  uf_set_colval("a_agente", is_ricpar.s_ausil_value[1])
	   end if	
		
	CASE "a_agente"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_rag_soc_1", is_ricpar.s_ausil_value[1])		
	CASE "a_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_agente", is_ricpar.s_ausil_value[1])		
END CHOOSE

end event

event itemchanged;String	ls_null
Long		ll_null
String	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
Long     ll_ok

SetNull(ll_null) 
ls_null = ""

CHOOSE CASE dwo.name
	CASE 'da_agente'
		IF IsNull(data) OR (data = ls_null) THEN
 		   This.SetItem(row, "da_agente", ls_null)
			This.SetItem(row, "da_rag_soc_1", ls_null)
		ELSE
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (ll_ok > 0) THEN
			if isnull(This.getitemstring(1,"a_agente")) or This.getitemstring(1,"a_agente")='' then
		 This.SetItem(1, "a_agente", Data)
		  This.SetItem(1, "a_rag_soc_1", This.Object.da_rag_soc_1[1])
	   end if
			RETURN 2
		END IF

	 END IF
	 
	 CASE 'da_rag_soc_1'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "da_agente", ls_null)
			This.SetItem(row, "da_rag_soc_1", ls_null)
		ELSE
			
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)								
										
		IF (ll_ok > 0) THEN
			if isnull(This.getitemstring(1,"a_agente")) or This.getitemstring(1,"a_agente")='' then
		  This.SetItem(1, "a_rag_soc_1", Data)
		  This.SetItem(1, "a_agente", This.Object.da_agente[1])
	   end if
			RETURN 2
		END IF
	END IF
	
	CASE 'a_agente'
		IF IsNull(data) OR (data = ls_null) THEN
 		   This.SetItem(row, "a_agente", ls_null)
			This.SetItem(row, "a_rag_soc_1", ls_null)
		ELSE
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	 END IF
	 
	 CASE 'a_rag_soc_1'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "a_agente", ls_null)
			This.SetItem(row, "a_rag_soc_1", ls_null)
		ELSE
			
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	END IF	
END CHOOSE
end event

