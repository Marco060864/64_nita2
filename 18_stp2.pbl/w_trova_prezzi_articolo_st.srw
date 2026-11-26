forward
global type w_trova_prezzi_articolo_st from w_wiz_main
end type
type st_1 from statictext within w_trova_prezzi_articolo_st
end type
type cb_4 from commandbutton within w_trova_prezzi_articolo_st
end type
type cb_3 from commandbutton within w_trova_prezzi_articolo_st
end type
type dw_3 from u_dw_ext_main within w_trova_prezzi_articolo_st
end type
type dw_2 from u_dw_ext_main within w_trova_prezzi_articolo_st
end type
type cb_2 from commandbutton within w_trova_prezzi_articolo_st
end type
type cb_1 from commandbutton within w_trova_prezzi_articolo_st
end type
type cb_trova_in_riga_doc from commandbutton within w_trova_prezzi_articolo_st
end type
type cb_ok from commandbutton within w_trova_prezzi_articolo_st
end type
type cb_annulla from commandbutton within w_trova_prezzi_articolo_st
end type
type dw_1 from u_dw_ext_main within w_trova_prezzi_articolo_st
end type
end forward

global type w_trova_prezzi_articolo_st from w_wiz_main
integer width = 2386
integer height = 1372
string title = "Trova Prezzi"
st_1 st_1
cb_4 cb_4
cb_3 cb_3
dw_3 dw_3
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
cb_trova_in_riga_doc cb_trova_in_riga_doc
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_trova_prezzi_articolo_st w_trova_prezzi_articolo_st

type variables

end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
public subroutine wf_setta_a_titolo (integer ai_flag)
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

public subroutine wf_setta_a_titolo (integer ai_flag);string ls_da, ls_a
long ll_id_tit
ll_id_tit=dw_1.getitemnumber(1, "a_titolo")
if isnull(ll_id_tit) then
	ll_id_tit=dw_1.getitemnumber(1, "da_titolo")
	dw_1.setitem(1, "a_titolo", ll_id_tit)
end if

ls_a=dw_1.Describe("Evaluate('LookUpDisplay(a_titolo) ', " + "1" + ")")
ls_da=dw_1.Describe("Evaluate('LookUpDisplay(da_titolo) ', " + "1" + ")")

if ls_da> ls_a or left(ls_da, 2)<> left(ls_a, 2) then
	messagebox("Attenzione!", "Il titolo di inizio è maggiore di quello di fine~r~no si sono scelti due metalli diversi")
	setnull(ll_id_tit)
	if ai_flag=1 then
		dw_1.setitem(1, "da_titolo", ll_id_tit)
	else
		dw_1.setitem(1, "a_titolo", ll_id_tit)
	end if
end if
end subroutine

on w_trova_prezzi_articolo_st.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_trova_in_riga_doc=create cb_trova_in_riga_doc
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_trova_in_riga_doc
this.Control[iCurrent+9]=this.cb_ok
this.Control[iCurrent+10]=this.cb_annulla
this.Control[iCurrent+11]=this.dw_1
end on

on w_trova_prezzi_articolo_st.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_trova_in_riga_doc)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;datawindowchild ldw_articolo, ldw_registro, ldw_tipo_registro, ldw_prof, ldwc_cl_fo
integer li_anno

dw_1.getchild("cod_articolo", ldw_articolo)
ldw_articolo.settransobject(sqlca)
ldw_articolo.retrieve()
dw_1.getchild("id_registro", ldw_registro)
ldw_registro.settransobject(sqlca)
ldw_registro.retrieve()

dw_1.getchild("tipo_registro", ldw_tipo_registro)
ldw_tipo_registro.settransobject(sqlca)
ldw_tipo_registro.retrieve()
dw_1.getchild("id_prof_doc", ldw_prof)
ldw_prof.settransobject(sqlca)
ldw_prof.retrieve()

dw_1.getchild("cl_fo", ldwc_cl_fo)
ldwc_cl_fo.settransobject(sqlca)
ldwc_cl_fo.retrieve()

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_2.insertrow(1)
select codice into :li_anno from dba.esercizio where codice = year(today());
dw_2.setitem(1, "anno", li_anno)









//datawindowchild ldw_da_cat_merceologica, ldw_a_cat_merceologica, ldw_data_inizio_es, ldw_locazione
//datawindowchild ldw_da_titolo, ldw_a_titolo, ldw_valuta, ldw_cliente
//date ldt_data_inzio
//LONG LL_ID_VAL
//String ls_par 
//
//dw_1.getchild("da_cod_sog_comm", ldw_cliente)
//ldw_cliente.settransobject(sqlca)
//ldw_cliente.retrieve()
//
//dw_1.getchild("valuta",ldw_valuta)
//ldw_valuta.settransobject(sqlca)
//ldw_valuta.retrieve()
//
//
//dw_1.getchild("ll_magazzino",ldw_locazione)
//ldw_locazione.settransobject(sqlca)
//ldw_locazione.retrieve()
//
//dw_1.getchild("da_titolo",ldw_da_titolo)
//ldw_da_titolo.settransobject(sqlca)
//ldw_da_titolo.retrieve()
//dw_1.getchild("a_titolo",ldw_a_titolo)
//ldw_a_titolo.settransobject(sqlca)
//ldw_a_titolo.retrieve()
//
//dw_1.getchild("da_cod_cat",ldw_da_cat_merceologica)
//ldw_da_cat_merceologica.settransobject(sqlca)
//ldw_da_cat_merceologica.retrieve()
//dw_1.getchild("a_cod_cat",ldw_a_cat_merceologica)
//ldw_a_cat_merceologica.settransobject(sqlca)
//ldw_a_cat_merceologica.retrieve()
//
//dw_1.getchild("da_des_cat",ldw_da_cat_merceologica)
//ldw_da_cat_merceologica.settransobject(sqlca)
//ldw_da_cat_merceologica.retrieve()
//
//dw_1.getchild("a_des_cat",ldw_a_cat_merceologica)
//ldw_a_cat_merceologica.settransobject(sqlca)
//ldw_a_cat_merceologica.retrieve()
//
//dw_1.getchild("data_inizio_esercizio",ldw_data_inizio_es)
//ldw_data_inizio_es.settransobject(sqlca)
//ldw_data_inizio_es.retrieve()

dw_1.insertrow(1)

//long ll_riga
//date ld_data
//ld_data=today()
//ll_riga=dw_1.getrow()
//dw_1.setitem(ll_riga, "a_data", ld_data)
//select data_inizio, ID_VALUTA
//into :ldt_data_inzio, :LL_ID_VAL
//from esercizio e, azienda a
//where e.id_esercizio=a.id_esercizio_proposto
//and a.id_azienda=1;
//if sqlca.sqlcode=0 then
//	dw_1.setitem(1, "data_inizio_esercizio", ldt_data_inzio)	
//	dw_1.setitem(1, "da_data", ldt_data_inzio)
//	DW_1.SETITEM(1, "VALUTA", LL_ID_VAL)
//	DW_1.SETITEM(1, "CAMBIO", 1)
//else
//	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio proposto in dati azienda")
//end if
//







end event

event ue_post_open;call super::ue_post_open;long ll_riga_inserita
//dw_1.setitem(1, "ll_magazzino", 28)

ll_riga_inserita=dw_3.insertrow(0)
dw_3.setitem(ll_riga_inserita, "id_prof_documento", 47)
ll_riga_inserita=dw_3.insertrow(0)
dw_3.setitem(ll_riga_inserita, "id_prof_documento", 183)
ll_riga_inserita=dw_3.insertrow(0)
dw_3.setitem(ll_riga_inserita, "id_prof_documento", 182)
ll_riga_inserita=dw_3.insertrow(0)
dw_3.setitem(ll_riga_inserita, "id_prof_documento", 54)
ll_riga_inserita=dw_3.insertrow(0)
dw_3.setitem(ll_riga_inserita, "id_prof_documento", 158)

end event

type st_1 from statictext within w_trova_prezzi_articolo_st
integer x = 1518
integer y = 912
integer width = 759
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Se VUOI vedere solo le PRO LASCIA SOLO quelle nell~'ID_prof"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_trova_prezzi_articolo_st
integer x = 1851
integer y = 1128
integer width = 439
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ND-NC TUTTI ART"
end type

event clicked;long ll_id_art
string ls_cod_art
s_array s_dati
integer i

dw_1.accepttext()  //20241022 stampa di tutti gli articoli del giorno in fila per risparmiare carta
s_dati.as_string[2]=string( dw_1.getitemnumber(1, "id_articolo"))
s_dati.as_string[4]= dw_1.getitemstring(1, "tipo_registro")
s_dati.as_string[6]= dw_1.getitemstring(1, "cod_cliente")
s_dati.as_string[7]= ""

//questo sotto è id_prof_doc, quello sotto ancora id_registro
s_dati.ll_id_doc[1]=dw_1.getitemnumber(1, "id_prof_doc")
s_dati.ll_id_doc[2]=dw_1.getitemnumber(1, "id_registro")
for i= 1 to dw_3.rowcount()
	s_dati.ll_id_prof[i]=dw_3.getitemnumber(i, "id_prof_documento")
next
for i= 1 to dw_2.rowcount()
	s_dati.li_anno[i]=dw_2.getitemnumber(i, "anno")
next

s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
//if string( dw_1.getitemnumber(1, "id_articolo"))> " " then
//	s_dati.as_string[5]= "d_trova_prezzi_in_riga_tutti_ndnc_rpt"
//else
	s_dati.as_string[5]="d_trova_prezzi_articolo_in_riga_tutti_rpt" // "d_trova_prezzi_in_riga_tutti_ndnc_rpt"  // d_trova_prezzi_articolo_in_riga_tutti_rpt "d_trova_prezzi_articolo_in_riga_tutti_ndnc_rpt" 
//end if
s_dati.as_string[10]=string(dw_1.getitemdate(1, "da_data"), "yyyy/mm/dd")
s_dati.as_string[11]=string(dw_1.getitemdate(1, "a_data"),  "yyyy/mm/dd")
//IF ISNULL(s_dati.as_string[10]) OR ISNULL(s_dati.as_string[11]) THEN
//	messagebox("Attenzione!", "Le date sono obbligatorie!")
//	return
//END IF

OpenWithParm(w_trova_prezzi_articolo_in_riga_doc_rpt, s_dati)

end event

type cb_3 from commandbutton within w_trova_prezzi_articolo_st
integer x = 1559
integer y = 752
integer width = 210
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ONE"
end type

event clicked;s_array s_dati

s_dati.as_string[1]=string(dw_1.getitemnumber(1, "cod_articolo"))
s_dati.as_string[2]=string( dw_1.getitemnumber(1, "id_articolo"))
s_dati.as_string[10]= string(dw_1.getitemdate(1, "da_data"), "yyyy/mm/dd")
s_dati.as_string[11]= string(dw_1.getitemdate(1, "a_data"),  "yyyy/mm/dd")
s_dati.as_string[5]= "d_mov_art_gd"
 s_dati.ll_id_doc[1]=0
 s_dati.ll_id_doc[2]=0
//for i= 1 to dw_3.rowcount()
//	s_dati.ll_id_prof[i]=dw_3.getitemnumber(i, "id_prof_documento")
//next
//for i= 1 to dw_2.rowcount()
//	s_dati.li_anno[i]=dw_2.getitemnumber(i, "anno")
//next


OpenWithParm(w_trova_prezzi_articolo_in_riga_doc_rpt, s_dati)

end event

type dw_3 from u_dw_ext_main within w_trova_prezzi_articolo_st
event type integer ue_tipo_reg ( )
integer x = 736
integer y = 776
integer width = 736
integer height = 416
integer taborder = 20
string dataobject = "d_scegli_prof_doc"
end type

event itemchanged;long ll_null

setnull(ll_null)
CHOOSE CASE dwo.name
	CASE "cod_articolo"
		if data > " " then
			setitem(row, "id_articolo", ll_null)
		end if
	case "id_articolo"
		if long(data)>0 then
			setitem(row, "cod_articolo", ll_null)
			cb_trova_in_riga_doc.postevent(clicked!)
		end if
	
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;



end event

event ue_set_search;string ls_sql_cond 
CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo"
		is_search_window = "w_articolo_coddes_per_silver_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
		is_ricpar.b_imm_retrieve = TRUE

END CHOOSE	
end event

event ue_use_search;CHOOSE CASE as_nomecol

	CASE "da_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
	
		



END CHOOSE

end event

event ue_key;call super::ue_key;long ll_riga
choose case key
case Keyadd!	
	if (keyFlags=2) then
		triggerevent("ue_insert")
	end if
case KeySubtract!
if (keyFlags=2) then
		ll_riga=getrow()
		if ll_riga>0 then
			deleterow(ll_riga)
		end if
	end if
end choose

end event

type dw_2 from u_dw_ext_main within w_trova_prezzi_articolo_st
event type integer ue_tipo_reg ( )
integer x = 18
integer y = 776
integer width = 663
integer height = 416
integer taborder = 20
string dataobject = "d_scegli_anno_profilo"
end type

event itemchanged;long ll_null

setnull(ll_null)
CHOOSE CASE dwo.name
	CASE "cod_articolo"
		if data > " " then
			setitem(row, "id_articolo", ll_null)
		end if
	case "id_articolo"
		if long(data)>0 then
			setitem(row, "cod_articolo", ll_null)
			cb_trova_in_riga_doc.postevent(clicked!)
		end if
	
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;



end event

event ue_set_search;string ls_sql_cond 
CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo"
		is_search_window = "w_articolo_coddes_per_silver_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
		is_ricpar.b_imm_retrieve = TRUE

END CHOOSE	
end event

event ue_use_search;CHOOSE CASE as_nomecol

	CASE "da_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
	
		



END CHOOSE

end event

event ue_key;call super::ue_key;long ll_riga
choose case key
case Keyadd!	
	if (keyFlags=2) then
		triggerevent("ue_insert")
	end if
case KeySubtract!
	if (keyFlags=2) then
		ll_riga=getrow()
		if ll_riga>0 then
			deleterow(ll_riga)
		end if
	end if
end choose

end event

type cb_2 from commandbutton within w_trova_prezzi_articolo_st
integer x = 1221
integer y = 24
integer width = 512
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trova Prezzo ND-NC"
end type

event clicked;long ll_id_art
string ls_cod_art
s_array s_dati
integer i

dw_1.accepttext()
s_dati.as_string[1]=string(dw_1.getitemnumber(1, "cod_articolo"))
s_dati.as_string[2]=string( dw_1.getitemnumber(1, "id_articolo"))
s_dati.as_string[4]= dw_1.getitemstring(1, "tipo_registro")
s_dati.as_string[6]= dw_1.getitemstring(1, "cod_cliente")
s_dati.as_string[7]= ""
//questo sotto è id_prof_doc, quello sotto ancora id_registro
s_dati.ll_id_doc[1]=dw_1.getitemnumber(1, "id_prof_doc")
s_dati.ll_id_doc[2]=dw_1.getitemnumber(1, "id_registro")
for i= 1 to dw_3.rowcount()
	s_dati.ll_id_prof[i]=dw_3.getitemnumber(i, "id_prof_documento")
next
for i= 1 to dw_2.rowcount()
	s_dati.li_anno[i]=dw_2.getitemnumber(i, "anno")
next

if isnull(s_dati.as_string[1]) and isnull(s_dati.as_string[2]) then
	messagebox("Attenzione!", "Almeno un valore fra cod_articolo e id_articolo DEVE essere valorizzato!")
else	
	s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
	s_dati.as_string[5]= "d_trova_prezzi_in_riga_ndnc_rpt"
	OpenWithParm(w_trova_prezzi_articolo_in_riga_doc_rpt, s_dati)
end if
//s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
//OpenWithParm(w_trova_prezzi_articolo_in_riga_doc_rpt, s_dati)
//else
//messagebox("Attenzione!", "Articolo non trovato!")
//end if

end event

type cb_1 from commandbutton within w_trova_prezzi_articolo_st
integer x = 41
integer y = 24
integer width = 603
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Trova Prezzo e DES2"
end type

event clicked;long ll_id_art


dw_1.accepttext()
ll_id_art=dw_1.getitemnumber(1, "cod_articolo")
if isnull(ll_id_art) or ll_id_art=0 then ll_id_art=dw_1.getitemnumber(1, "id_articolo")
if isnull(ll_id_art)  then
	messagebox("Attenzione!", "Almeno un valore fra cod_articolo e id_articolo DEVE essere valorizzato!")
else	
	
	OpenWithParm(w_trova_prezzo_des_2_art, ll_id_art)
end if
end event

type cb_trova_in_riga_doc from commandbutton within w_trova_prezzi_articolo_st
integer x = 695
integer y = 24
integer width = 517
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trova Prezzo in Doc"
end type

event clicked;long ll_id_art
string ls_cod_art
s_array s_dati
integer i

dw_1.accepttext()
s_dati.as_string[1]=string(dw_1.getitemnumber(1, "cod_articolo"))
s_dati.as_string[2]=string( dw_1.getitemnumber(1, "id_articolo"))
s_dati.as_string[4]= dw_1.getitemstring(1, "tipo_registro")
s_dati.as_string[5]= "d_trova_prezzi_articolo_in_riga_rpt"
s_dati.as_string[6]= dw_1.getitemstring(1, "cod_cliente")
s_dati.as_string[7]= string(dw_1.getitemnumber(1, "cl_fo"))  //Fornitore per filtro 20230428
//questo sotto è id_prof_doc, quello sotto ancora id_registro
s_dati.ll_id_doc[1]=dw_1.getitemnumber(1, "id_prof_doc")
s_dati.ll_id_doc[2]=dw_1.getitemnumber(1, "id_registro")

for i= 1 to dw_3.rowcount()
	s_dati.ll_id_prof[i]=dw_3.getitemnumber(i, "id_prof_documento")
next
for i= 1 to dw_2.rowcount()
	s_dati.li_anno[i]=dw_2.getitemnumber(i, "anno")
next
if isnull(s_dati.as_string[1]) and isnull(s_dati.as_string[2]) then
	if s_dati.as_string[6]> " " then
		s_dati.as_string[5]="d_trova_prezzi_cliente_in_riga_rpt"
		s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
		OpenWithParm(w_trova_prezzi_articolo_in_riga_doc_rpt, s_dati)
	else
		messagebox("Attenzione!", "Almeno un valore fra cod_articolo e id_articolo DEVE essere valorizzato!")
	end if
else	
	s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
	OpenWithParm(w_trova_prezzi_articolo_in_riga_doc_rpt, s_dati)
end if
//s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
//OpenWithParm(w_trova_prezzi_articolo_in_riga_doc_rpt, s_dati)
//else
//messagebox("Attenzione!", "Articolo non trovato!")
//end if

end event

type cb_ok from commandbutton within w_trova_prezzi_articolo_st
event clicked pbm_bnclicked
integer x = 1742
integer y = 24
integer width = 338
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Trova"
boolean cancel = true
end type

event clicked;
s_array s_dati
dw_1.accepttext()
s_dati.as_string[1]=string(dw_1.getitemnumber(1, "cod_articolo"))
s_dati.as_string[2]=string( dw_1.getitemnumber(1, "id_articolo"))
if isnull(s_dati.as_string[1]) and isnull(s_dati.as_string[2]) then
	messagebox("Attenzione!", "Almeno un valore fra cod_articolo e id_articolo DEVE essere valorizzato!")
else	
	s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
	OpenWithParm(w_trova_prezzi_articolo_rpt, s_dati)
end if

end event

event rbuttondown;s_array s_dati
dw_1.accepttext()
s_dati.as_string[1]=string(dw_1.getitemnumber(1, "cod_articolo"))
s_dati.as_string[2]=string( dw_1.getitemnumber(1, "id_articolo"))
s_dati.as_string[3]="9"  //serve per capire che deve caricare la dw corrispondente al rbutton del mouse 20230126
if isnull(s_dati.as_string[1]) and isnull(s_dati.as_string[2]) then
	messagebox("Attenzione!", "Almeno un valore fra cod_articolo e id_articolo DEVE essere valorizzato!")
else	
	s_dati.as_string[3]= dw_1.getitemstring(1, "tipo_ddt")
	OpenWithParm(w_trova_prezzi_articolo_rpt, s_dati)
end if
end event

type cb_annulla from commandbutton within w_trova_prezzi_articolo_st
integer x = 2098
integer y = 24
integer width = 210
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Chiudi"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_trova_prezzi_articolo_st
event type integer ue_tipo_reg ( )
integer x = 23
integer y = 152
integer width = 2267
integer height = 524
integer taborder = 10
string dataobject = "d_trova_prezzi_articolo_new_st"
end type

event ue_use_search;CHOOSE CASE as_nomecol

	CASE "da_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
	
		



END CHOOSE

end event

event ue_set_search;string ls_sql_cond 
CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo"
		is_search_window = "w_articolo_coddes_per_silver_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
		is_ricpar.b_imm_retrieve = TRUE

END CHOOSE	
end event

event itemchanged;long ll_null

setnull(ll_null)
CHOOSE CASE dwo.name
	CASE "cod_articolo"
		if data > " " then
			setitem(row, "id_articolo", ll_null)
		end if
	case "id_articolo"
		if long(data)>0 then
			setitem(row, "cod_articolo", ll_null)
			//cb_trova_in_riga_doc.postevent(clicked!)  //20220913  provo a commentare, ritengo sia ppiù fastdioso che utile ...vediamo...
		end if
	
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;



end event

