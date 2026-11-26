forward
global type w_stp_doc_ragg_vari_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stp_doc_ragg_vari_cx
end type
type cb_annulla from commandbutton within w_stp_doc_ragg_vari_cx
end type
type dw_1 from u_dw_ext_main within w_stp_doc_ragg_vari_cx
end type
end forward

global type w_stp_doc_ragg_vari_cx from w_wiz_main
int Width=2720
int Height=1168
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Documenti per raggruppamento"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stp_doc_ragg_vari_cx w_stp_doc_ragg_vari_cx

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE

long il_id_esercizio
date il_data_da
date il_data_a
integer ii_tab_seq
integer ii_tab_seq_num
date il_data_da_esr
date il_data_a_esr
string is_tipo_reg

end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
end prototypes

public function string uf_controlla_dati ();


string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret,ls_st_reg_iva,ls_st_reg2_iva
long ll_row,ll_n_registro
date ld_dalla_data,ld_alla_data

ll_row=dw_1.getrow()
ls_tipo_registro=dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=dw_1.getitemstring(ll_row,"elab_prova")




ls_ret='OK'
if ls_flag_registri='N' then
	
DECLARE ws_registri_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and  
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri_iva_cur;

FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri_iva_cur;


DECLARE ws_registri2_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and 
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri2_iva_cur ;

FETCH ws_registri2_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri2_iva_cur;
return ls_ret
else
	
	
	
	
	
DECLARE ws_registri3_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri3_iva_cur;

FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri3_iva_cur;


DECLARE ws_registri4_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri4_iva_cur ;

FETCH ws_registri4_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri4_iva_cur;
return ls_ret
end if

end function

public function date uf_prossimo_mese (readonly date data_attuale);integer mese,anno,day,giorni_mese
date nuova_data
anno=year(data_attuale)
mese=month(data_attuale)
if mese=12 then
	mese=1
	anno=anno+1
else
mese=mese+1
end if
day=day(data_attuale)


giorni_mese=f_gmese(mese,anno)
if day>giorni_mese then
	day=giorni_mese
end if

nuova_data=date(string(day)+"/"+string(mese)+"/"+string(anno))
return nuova_data
end function

on w_stp_doc_ragg_vari_cx.create
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

on w_stp_doc_ragg_vari_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;call super::open;dw_1.insertrow(1)




dw_1.setitem(1,"ragg",'P')
dw_1.object.da_cod_t.visible=0
		dw_1.object.a_cod_t.visible=0
		dw_1.object.da_cod.visible=0
		dw_1.object.a_cod.visible=0
		dw_1.object.da_des.visible=0
		dw_1.object.a_des.visible=0
		dw_1.object.da_cod_sw.visible=0
		dw_1.object.a_cod_sw.visible=0
		dw_1.object.da_des_sw.visible=0
		dw_1.object.a_des_sw.visible=0

long ll_null
setnull(ll_null)
dw_1.setitem(1,"da_cod",'')
dw_1.setitem(1,"da_des",'')
dw_1.setitem(1,"a_cod",'')
dw_1.setitem(1,"a_des",'')
dw_1.setitem(1,"dalla_data",'')
dw_1.setitem(1,"alla_data",'')
dw_1.setITEM(1,"da_prot",LL_NULL)
dw_1.setITEM(1,"a_prot",LL_NULL)


end event

type cb_ok from commandbutton within w_stp_doc_ragg_vari_cx
event clicked pbm_bnclicked
int X=2117
int Y=32
int Width=242
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stam&pa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_da_prof,ls_a_prof,ls_da_cod,ls_a_cod,ls_inevaso,ls_evaso,ls_consegnata
string ls_ragg,ls_filtro,ls_flag,ls_parametri
string ls_da_prot, ls_a_prot
date ld_da_data,ld_a_data
str_fil_flag str_param


dw_1.accepttext()
ls_flag='X'
ls_inevaso=dw_1.getitemstring(1,"inevaso")
ls_evaso=dw_1.getitemstring(1,"evaso")
ls_consegnata=dw_1.getitemstring(1,"consegnato")

ls_da_prot=dw_1.getitemstring(1,"da_prot")
ls_a_prot=dw_1.getitemstring(1,"a_prot")

ls_da_prof=dw_1.getitemstring(1,"da_prof_cod")
ls_a_prof=dw_1.getitemstring(1,"a_prof_cod")
ls_da_cod=dw_1.getitemstring(1,"da_cod")
ls_a_cod=dw_1.getitemstring(1,"a_cod")
ld_da_data=dw_1.getitemdate(1,"dalla_data")
ld_a_data=dw_1.getitemdate(1,"alla_data")
ls_ragg=dw_1.getitemstring(1,"ragg")

if isnull(ls_da_cod) or isnull(ls_a_cod)  then
choose case ls_ragg
	case 'A'
	messagebox("Attenzione","I codici di inizio e fine dell'articolo sono obbligatori",exclamation!)
	case 'S'
	messagebox("Attenzione","I codici di inizio e fine del soggetto commerciale sono obbligatori",exclamation!)	
end choose		
else
if ls_da_prof>ls_a_prof then
	messagebox("Stampa documenti per raggruppamento","Il codice del profilo iniziale è maggiore di quello finale",exclamation!)
else 
if ls_da_cod>ls_a_cod then
	messagebox("Stampa documenti per raggruppamento","Il codice dell Sogg.Comm/articolo iniziale è maggiore di quello finale",exclamation!)
else 


if not isnull(ld_da_data) and ls_filtro='' then
	ls_filtro='documento_data_documento>=date("'+string(ld_da_data)+'")'
	ls_parametri='Da data:'+string(ld_da_data)
else

if not isnull(ld_da_data) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and documento_data_documento>=date("'+string(ld_da_data)+'")'
	ls_parametri='Da data:'+string(ld_da_data)
end if
end if
if not isnull(ld_da_data) and ls_filtro='' then
	ls_filtro='documento_data_documento<=date("'+string(ld_a_data)+'")'
	ls_parametri=ls_parametri+' A data:'+string(ld_a_data)
else

if not isnull(ld_da_data) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and documento_data_documento<=date("'+string(ld_a_data)+'")'
	ls_parametri=ls_parametri+' A data:'+string(ld_a_data)
end if
end if

if ls_da_prof<>''and ls_filtro='' then
	ls_filtro='prof_documento_codice>='+'"'+string(ls_da_prof)+'"'
	ls_parametri=ls_parametri+'- Da profilo:'+string(ls_da_prof)
else
if ls_da_prof<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and prof_documento_codice>='+'"'+string(ls_da_prof)+'"'
	ls_parametri=ls_parametri+'- Da profilo:'+string(ls_da_prof)
end if
end if
if ls_a_prof<>''and ls_filtro='' then
	ls_filtro='prof_documento_codice<='+'"'+string(ls_a_prof)+'"'
	ls_parametri=ls_parametri+'- A profilo:'+string(ls_a_prof)
else
if ls_a_prof<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and prof_documento_codice<='+'"'+string(ls_a_prof)+'"'
	ls_parametri=ls_parametri+'- A profilo:'+string(ls_a_prof)
end if
end if
if ls_da_prot<>'' and ls_filtro='' then
	ls_filtro='documento_num_documento>='+ '"'+ ls_da_prot + '"'
	ls_parametri=ls_parametri+'- Da N. doc.:' + ls_da_prot
else
if ls_da_prot <> '' and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and documento_num_documento >= ' + '"' + ls_da_prot + '"'
	ls_parametri=ls_parametri+'- Da N. doc.:' + ls_da_prot 
end if
end if
if ls_a_prot<>'' and ls_filtro='' then
	ls_filtro='documento_num_documento<='+ '"' + ls_a_prot + '"'
	ls_parametri=ls_parametri+'- A N. doc.:'+ ls_a_prot
else
if ls_a_prot <> '' and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (documento_num_documento<=' + '"' + ls_a_prot + '"'
	ls_parametri=ls_parametri+'- A N. doc.:' + ls_a_prot
end if
end if

choose case ls_ragg
	case 'A'

	ls_parametri=ls_parametri+'- Da articolo:'+ls_da_cod

case 'S'

	ls_parametri=ls_parametri+'- Da Sogg.Commerciale:'+string(ls_da_cod)

end choose
choose case ls_ragg
	case 'A'

	ls_parametri=ls_parametri+'- A articolo:'+string(ls_a_cod)

	case 'S'

	ls_parametri=ls_parametri+'- A Sogg.Commerciale:'+string(ls_a_cod)

end choose
if ls_inevaso='S' and ls_filtro='' then
	ls_filtro=' riga_documento_quantita - riga_documento_qta_evasa >0'
	ls_flag='I'
	ls_parametri=ls_parametri+'Raggruppamento:INEVASO'
else
if ls_inevaso ='S'and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and ( riga_documento_quantita - riga_documento_qta_evasa >0)'
	ls_flag='I'
	ls_parametri=ls_parametri+'  Raggruppamento:INEVASO'
end if
end if
if ls_evaso='S' and ls_filtro='' then
	ls_filtro=' riga_documento_quantita - riga_documento_qta_evasa <=0'
	ls_flag='E'
	ls_parametri=ls_parametri+'   Raggruppamento:EVASO'
else
if ls_evaso='S' and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and ( riga_documento_quantita - riga_documento_qta_evasa <=0)'
ls_flag='E'
ls_parametri=ls_parametri+'   Raggruppamento:EVASO'
end if
end if

if ls_consegnata='S' and ls_filtro='' then
	ls_filtro=' riga_documento_quantita - riga_documento_qta_evasa >0'
ls_flag='C'
ls_parametri=ls_parametri+'   Raggruppamento:CONSEGNATA'
else
if ls_consegnata='S'and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and ( riga_documento_quantita - riga_documento_qta_evasa >0)'
ls_flag='C'
ls_parametri=ls_parametri+'   Raggruppamento:CONSEGNATA'
end if
end if


str_param.filtro=ls_filtro
str_param.flag=ls_flag
str_param.parametri=ls_parametri
str_param.da_cod=ls_da_cod
str_param.a_cod=ls_a_cod



choose case ls_ragg
	case 'A'
openwithparm(w_stp_doc_art_gd,str_param)
case 'S'
openwithparm(w_stp_doc_sogg_gd,str_param)	
case 'P'
openwithparm(w_stp_doc_prot_gd,str_param)
end choose

end if
end if 
end if
end event

type cb_annulla from commandbutton within w_stp_doc_ragg_vari_cx
int X=2409
int Y=32
int Width=242
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="&Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_stp_doc_ragg_vari_cx
event type integer ue_tipo_reg ( )
int X=32
int Y=152
int Width=2633
int Height=896
int TabOrder=10
string DataObject="d_doc_grup_var_cx"
end type

event itemchanged;
string ls_ragg,ls_app,ls_max_cod,ls_min_cod,ls_max_des,ls_min_des
LONG LL_NULL
dw_1.accepttext()
dw_1.object.evaso.protect=0
dw_1.object.consegnato.protect=0
dw_1.object.inevaso.protect=0
SETNULL(LL_NULL)
integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
SETNULL(LL_NULL)
choose case dwo.name
	case "ragg"
		
		dw_1.setitem(1,"da_cod",'')
		dw_1.setitem(1,"da_des",'')
		dw_1.setitem(1,"a_cod",'')
		dw_1.setitem(1,"a_des",'')
		dw_1.setitem(1,"dalla_data",'')
		dw_1.setitem(1,"alla_data",'')
		dw_1.setITEM(1,"da_prot",LL_NULL)
		dw_1.setITEM(1,"a_prot",LL_NULL)
		ls_ragg=dw_1.getitemstring(1,"ragg")
		choose case ls_ragg
		case 'S'
		dw_1.object.da_cod_t.text='Da Sogg.Comm.:'
		dw_1.object.a_cod_t.text='A Sogg.Comm.:'
		select max(sog_commerciale_gen.codice),min(sog_commerciale_gen.codice)
		into :ls_max_cod,:ls_min_cod
		from sog_commerciale_gen;
		
		select sog_commerciale_gen.rag_soc_1
		into :ls_min_des
		from sog_commerciale_gen
		where sog_commerciale_gen.codice=:ls_min_cod;
		
		select sog_commerciale_gen.rag_soc_1
		into :ls_max_des
		from sog_commerciale_gen
		where sog_commerciale_gen.codice=:ls_max_cod;
		dw_1.setitem(1,"da_cod",ls_min_cod)
		dw_1.setitem(1,"da_des",ls_min_des)
		dw_1.setitem(1,"a_cod",ls_max_cod)
		dw_1.setitem(1,"a_des",ls_max_des)
				
		dw_1.object.da_prot.visible=0
		dw_1.object.a_prot.visible=0
		dw_1.object.da_prot_t.visible=0
		dw_1.object.a_prot_t.visible=0
		dw_1.object.da_cod_t.visible=1
		dw_1.object.a_cod_t.visible=1
		dw_1.object.da_cod.visible=1
		dw_1.object.a_cod.visible=1
		dw_1.object.da_des.visible=1
		dw_1.object.a_des.visible=1
		dw_1.object.da_cod_sw.visible=1
		dw_1.object.a_cod_sw.visible=1
		dw_1.object.da_des_sw.visible=1
		dw_1.object.a_des_sw.visible=1
		case 'A'
		dw_1.object.da_cod_t.text='Da Articolo:'
		dw_1.object.a_cod_t.text='A Articolo:'
		select max(articolo.codice),min(articolo.codice)
		into :ls_max_cod,:ls_min_cod
		from articolo;
		
		
		select articolo.descrizione
		into:ls_max_des
		from articolo
		where articolo.codice=:ls_max_cod;
		
		select articolo.descrizione
		into :ls_min_des
		from articolo
		where articolo.codice=:ls_min_cod;
		dw_1.setitem(1,"da_cod",ls_min_cod)
		dw_1.setitem(1,"da_des",ls_min_des)
		dw_1.setitem(1,"a_cod",ls_max_cod)
		dw_1.setitem(1,"a_des",ls_max_des)
		
		
		dw_1.object.da_prot.visible=0
		dw_1.object.a_prot.visible=0
		dw_1.object.da_prot_t.visible=0
		dw_1.object.a_prot_t.visible=0
		dw_1.object.da_cod_t.visible=1
		dw_1.object.a_cod_t.visible=1
		dw_1.object.da_cod.visible=1
		dw_1.object.a_cod.visible=1
		dw_1.object.da_des.visible=1
		dw_1.object.a_des.visible=1
		dw_1.object.da_cod_sw.visible=1
		dw_1.object.a_cod_sw.visible=1
		dw_1.object.da_des_sw.visible=1
		dw_1.object.a_des_sw.visible=1
		case 'P'
			dw_1.object.da_prot.visible=1
		dw_1.object.a_prot.visible=1
		dw_1.object.da_prot_t.visible=1
		dw_1.object.a_prot_t.visible=1
		dw_1.object.da_cod_t.visible=0
		dw_1.object.a_cod_t.visible=0
		dw_1.object.da_cod.visible=0
		dw_1.object.a_cod.visible=0
		dw_1.object.da_des.visible=0
		dw_1.object.a_des.visible=0
		dw_1.object.da_cod_sw.visible=0
		dw_1.object.a_cod_sw.visible=0
		dw_1.object.da_des_sw.visible=0
		dw_1.object.a_des_sw.visible=0

end choose
	case "inevaso"
			dw_1.setitem(1,"evaso",'N')
			dw_1.setitem(1,"consegnato",'N')
		
	case "evaso"
		dw_1.setitem(1,"inevaso",'N')
		dw_1.setitem(1,"consegnato",'N')
	case "consegnato"
		dw_1.setitem(1,"inevaso",'N')
		dw_1.setitem(1,"evaso",'N')
		
		
case "da_prof_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_prof_cod"
		ls_dwc[2] = "da_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_prof_cod")) or This.GetItemString(1, "a_prof_cod")='' then 
		     this.setitem(1,"a_prof_cod",data)
           this.setitem(1,"a_prof_des",This.GetItemString(1, "da_prof_des"))
	      end if  	
			RETURN 2
		END IF
		
	case "da_prof_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_prof_cod"
		ls_dwc[2] = "da_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)		

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_prof_cod")) or This.GetItemString(1, "a_prof_cod")='' then 
		    this.setitem(1,"a_prof_cod",data)
          this.setitem(1,"a_prof_des",This.GetItemString(1, "da_prof_des"))
	      end if  
			RETURN 2
		END IF
		
	case "a_prof_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_prof_cod"
		ls_dwc[2] = "a_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_prof_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_prof_cod"
		ls_dwc[2] = "a_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "da_cod"
		ls_ragg=this.getitemstring(1,'ragg')
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_cod',data)
				 this.setitem(1,'a_des',this.getitemstring(1,'da_des'))
			end if
			RETURN 2
		END IF
		
	else
		
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_cod',data)
				 this.setitem(1,'a_des',this.getitemstring(1,'da_des'))
			end if
			RETURN 2
		END IF
	end if	
		
		
		
		
		
		
	case "da_des"
		ls_ragg=this.getitemstring(1,'ragg')
		
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_des',data)
				 this.setitem(1,'a_cod',this.getitemstring(1,'da_cod'))
			end if
			RETURN 2
		END IF
		
	else
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_des',data)
				 this.setitem(1,'a_cod',this.getitemstring(1,'da_cod'))
			end if
			RETURN 2
		END IF
				
			end if	
		
		
		
		
		
		case "a_cod"
		ls_ragg=this.getitemstring(1,'ragg')
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	else
		
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	end if	
		
		
		
		
		
		
	case "a_des"
		ls_ragg=this.getitemstring(1,'ragg')
		
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	else
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
				
			end if	
		
		
	
end choose



end event

event itemfocuschanged;call super::itemfocuschanged;
end event

event ue_set_search;call super::ue_set_search;string ls_ragg
ls_ragg=dw_1.getitemstring(1,"ragg")







choose case as_nomecol
	case "da_prof_cod"
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"
	case "da_prof_des" 
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
	case "a_prof_cod"
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"	
	case "a_prof_des" 
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"

	case "da_cod"
		choose case ls_ragg
			case 'A'
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
			case 'S'
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
		end choose
	case "da_des"
		choose case ls_ragg
			case 'A'
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	      case 'S'
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
		end choose
	case "a_cod"
		choose case ls_ragg
			case 'A'
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
			case 'S'
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
		end choose
case "a_des"
	choose case ls_ragg
		case 'A'
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	   case 'S'
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
		end choose
end choose
end event

event ue_use_search;string ls_ragg
ls_ragg=dw_1.getitemstring(1,"ragg")
choose case as_nomecol
		case "da_prof_cod"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_prof_des",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_prof_cod")) or This.GetItemString(1, "a_prof_cod")='' then 
		  uf_set_colval("a_prof_cod",is_ricpar.s_main_value)
        uf_set_colval("a_prof_des",is_ricpar.s_ausil_value[1])
	   end if  	
		
	case "da_prof_des"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_prof_cod",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_prof_cod")) or This.GetItemString(1, "a_prof_cod")='' then 
		  uf_set_colval("a_prof_des",is_ricpar.s_main_value)
        uf_set_colval("a_prof_cod",is_ricpar.s_ausil_value[1])
	   end if  	 	
		
	case "a_prof_cod"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_prof_des",is_ricpar.s_ausil_value[1])
	case "a_prof_des"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_prof_cod",is_ricpar.s_ausil_value[1])
		
		
	case "da_cod"
		choose case ls_ragg
			case 'A'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_cod', is_ricpar.s_main_value)
			    uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
			end if
		case 'S'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_cod', is_ricpar.s_main_value)
			    uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
		   end if
	end choose
	case "da_des"
		
		choose case ls_ragg
			case 'A'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cod",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_des', is_ricpar.s_main_value)
			    uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
			end if
			case 'S'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cod",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_des', is_ricpar.s_main_value)
			    uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
			end if
		end choose
	case "a_cod"
			choose case ls_ragg
			case 'A'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_des",is_ricpar.s_ausil_value[1])
			case 'S'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_des",is_ricpar.s_ausil_value[1])
			end choose
	case "a_des"
			choose case ls_ragg
			case 'A'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])

			uf_set_colval("a_cod",is_ricpar.s_ausil_value[1])
			case 'S'
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_cod",is_ricpar.s_ausil_value[1])
			end choose
	end choose
end event

