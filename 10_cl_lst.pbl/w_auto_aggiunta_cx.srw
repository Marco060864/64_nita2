forward
global type w_auto_aggiunta_cx from w_001
end type
type dw_2 from udw_base within w_auto_aggiunta_cx
end type
type ln_1 from line within w_auto_aggiunta_cx
end type
type cb_applica from uo_cb within w_auto_aggiunta_cx
end type
type cb_azzera from uo_cb within w_auto_aggiunta_cx
end type
type cb_riporta from uo_cb within w_auto_aggiunta_cx
end type
type cb_annulla from uo_cb within w_auto_aggiunta_cx
end type
type dw_3 from udw_base within w_auto_aggiunta_cx
end type
type cb_classe from commandbutton within w_auto_aggiunta_cx
end type
type cb_cancella from commandbutton within w_auto_aggiunta_cx
end type
type cb_ripulisci from commandbutton within w_auto_aggiunta_cx
end type
type cb_1 from commandbutton within w_auto_aggiunta_cx
end type
type ln_2 from line within w_auto_aggiunta_cx
end type
type dw_4 from udw_base within w_auto_aggiunta_cx
end type
type dw_5 from udw_base within w_auto_aggiunta_cx
end type
type cb_inserisci from commandbutton within w_auto_aggiunta_cx
end type
type cb_canc_riga_dis from commandbutton within w_auto_aggiunta_cx
end type
type cb_art_sog_com from commandbutton within w_auto_aggiunta_cx
end type
type dw_6 from udw_base within w_auto_aggiunta_cx
end type
type dw_1 from udw_base within w_auto_aggiunta_cx
end type
end forward

global type w_auto_aggiunta_cx from w_001
integer x = 73
integer y = 100
integer width = 2821
integer height = 2100
string title = "Selezione Articoli"
windowtype windowtype = response!
dw_2 dw_2
ln_1 ln_1
cb_applica cb_applica
cb_azzera cb_azzera
cb_riporta cb_riporta
cb_annulla cb_annulla
dw_3 dw_3
cb_classe cb_classe
cb_cancella cb_cancella
cb_ripulisci cb_ripulisci
cb_1 cb_1
ln_2 ln_2
dw_4 dw_4
dw_5 dw_5
cb_inserisci cb_inserisci
cb_canc_riga_dis cb_canc_riga_dis
cb_art_sog_com cb_art_sog_com
dw_6 dw_6
dw_1 dw_1
end type
global w_auto_aggiunta_cx w_auto_aggiunta_cx

type variables
string is_cond_sql, is_sql_originale
long il_id_lista

end variables

forward prototypes
public subroutine wf_verifica_filtri ()
public subroutine wf_crea_sql_cond ()
public subroutine wf_ricerca (long al_riga_corrente, string as_data, datawindow adw)
end prototypes

public subroutine wf_verifica_filtri ();
string ls_a, ls_da, ls_da_tit, ls_a_tit
integer i
decimal ld_da, ld_a

ls_da=dw_1.getitemstring(1, "da_articolo")
ls_a=dw_1.getitemstring(1, "a_articolo")
if ls_da>ls_a then
		messagebox("Errore!", "Dati inseriti non coerenti")
		dw_1.post setfocus()
		dw_1.post setcolumn(2)
		return
end if
for i= 9 to 22 step 2
	if i=17 then continue
	if i<17 then
		ls_da=dw_1.getitemstring(1, i)
		ls_a=dw_1.getitemstring(1, i+1)
		if ls_da>ls_a then
			messagebox("Errore!", "Dati inseriti non coerenti")
			dw_1.post setfocus()
			dw_1.post setcolumn(i+1)
			return
		end if
	else
		ld_da=dw_1.getitemdecimal(1, i)
		ld_a=dw_1.getitemdecimal(1, i+1)
		if ld_da>ld_a then
			messagebox("Errore!", "Dati inseriti non coerenti")
			dw_1.post setfocus()
			dw_1.post setcolumn(i+1)
			return
		end if
	end if
	
next


	

end subroutine

public subroutine wf_crea_sql_cond ();datetime ldt_data_ult_cambiamento, ldt_data_ult_cambiamento2
string ls_a, ls_da, ls_campo[], ls_and, ls_appoggio, LS_LIKE, ls_app
integer i
long ll_id_var, ll_righe, ll_id_classe, ll_id_art,ll_id_tit, ll_id_lista
long ll_id_cat_cod, ll_id_gruppo_art, ll_cat_merc_supr, ll_id_cat_merc

is_cond_sql=""

ll_id_var=dw_1.getitemnumber(1, "variazione")
if ll_id_var>0 then
	is_cond_sql=", unita_confezione, prezzo "
	ls_appoggio=" where articolo.id_articolo=unita_confezione.id_articolo "+&
					" and unita_confezione.unita_base='S' "+&
					"and unita_confezione.id_unita_confezione=prezzo.id_unita_confezione"
	ls_appoggio+= " and prezzo.id_variazione="+string(ll_id_var)
else
	ls_appoggio= " where "
end if

ll_id_lista=dw_1.getitemnumber(1, "id_lista")
if ll_id_lista>0 then
	is_cond_sql+=", lista_art_key "
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" (articolo.id_articolo= lista_art_key.id_articolo "+&
									" and lista_art_key.id_lista_articoli= "+string(ll_id_lista)+") "
	
end if

ll_id_gruppo_art=dw_1.getitemnumber(1, "id_gruppo_articoli")
if ll_id_gruppo_art>0 then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" (articolo.id_gruppo_articoli=  "+string(ll_id_gruppo_art)+") "
	
end if
	
ll_righe=dw_3.rowcount()
for i=1 to ll_righe
	ll_id_classe=dw_3.getitemnumber(i, "id_classe")
	
	is_cond_sql+=", CLASSE_ARTICOLO AS CL_ART_"+STRING(i)+" "

	
	
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" CL_ART_"+STRING(i)+".ID_ARTICOLO=ARTICOLO.ID_ARTICOLO "+&
		 " AND CL_ART_"+STRING(i)+".ID_CLASSE="+STRING(ll_id_classe)+" "
	
next 

	
ls_da=dw_1.getitemstring(1, "da_articolo")
if ls_da>"" then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	
	ls_a=dw_1.getitemstring(1, "a_articolo")
	if ls_a>"" then 
		ls_appoggio+=ls_and+" (articolo.codice >= '"+ls_da+ "' and articolo.codice <= '"+ls_a+"')"
	else	
		ls_appoggio+=ls_and+" (articolo.codice >= '"+ls_da+"')"
	end if
end if

ll_id_tit=dw_1.getitemnumber(1, "da_titolo")
if ll_id_tit>0 then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" (articolo.id_titolo = "+string(ll_id_tit)+")"
	
end if
//aggiunta
ldt_data_ult_cambiamento=dw_1.getitemdatetime(1, "data_ora_ult_cambiamento")
if ldt_data_ult_cambiamento > datetime("1900/01/01 23.59.00") then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" (articolo.data_ora_ult_cambiamento <= datetime('"+string(ldt_data_ult_cambiamento, "yyyy/mm/dd hh:mm:ss")+"'))"
end if
ldt_data_ult_cambiamento2=dw_1.getitemdatetime(1, "data_ora_ult_cambiamento2")
if ldt_data_ult_cambiamento2 > datetime("1900/01/01 23.59.00") then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" (articolo.data_ora_ult_cambiamento >= datetime('"+string(ldt_data_ult_cambiamento2, "yyyy/mm/dd hh:mm:ss")+"'))"
end if

ll_id_cat_cod=dw_1.getitemnumber(1, "id_cat_codifica")
if ll_id_cat_cod>0 then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" (articolo.id_cat_codifica = "+string(ll_id_cat_cod)+")"
end if


LS_LIKE=dw_1.getitemSTRING(1, "LIKE")
IF ls_like> "" then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" "+ls_like+ " "	
end if

ls_app=dw_1.getitemstring(1, "a_cat_merc") 
if ls_app> " " then
	select id_cat_merceologica
	into :ll_cat_merc_supr
	from dba.cat_merceologica
	where codice=:ls_app
	;
	DECLARE Cat_merc CURSOR FOR       
	SELECT id_cat_merceologica        
	FROM dba.cat_merceologica       
	WHERE id_cat_mer_superiore= :ll_cat_merc_supr ;
	
	i=1
	open Cat_merc;
	fetch Cat_merc into :ll_id_cat_merc;
	do while sqlca.sqlcode=0 
		
		if i=1 then
			if ls_appoggio=" where " then 
				ls_and=""
			else
				ls_and=" and "
			end if
			ls_appoggio+=ls_and+" ((articolo.id_cat_merceologica = "+string(ll_id_cat_merc)+")"
			i=2
		else
			ls_and=" or "
			ls_appoggio+=ls_and+" (articolo.id_cat_merceologica = "+string(ll_id_cat_merc)+")"
		end if
		//e se ci fosse un altro livello???? (era meglio aver fatto 2 datastore, si gestiva più facilmente ... ) 12-03-2019
		DECLARE Cat_merc2 CURSOR FOR
		SELECT id_cat_merceologica        
		FROM dba.cat_merceologica       
		WHERE id_cat_mer_superiore= :ll_id_cat_merc ;
			open Cat_merc2;
			fetch Cat_merc2 into :ll_id_cat_merc;
			do while sqlca.sqlcode=0 
				ls_and=" or "
				ls_appoggio+=ls_and+" (articolo.id_cat_merceologica = "+string(ll_id_cat_merc)+")"
				fetch Cat_merc2 into :ll_id_cat_merc;
			loop
			close Cat_merc2;				
		fetch Cat_merc into :ll_id_cat_merc;
	loop
	ls_appoggio+=")"
	close Cat_merc;
end if 

ls_campo[9]="cat_com_articolo.codice"
ls_campo[11]="cat_merceologica.codice"
ls_campo[13]="cat_fiscale.codice"
ls_campo[15]="gruppo_articoli.codice"

for i= 9 to 16 step 2
	ls_da=dw_1.getitemstring(1, i)
	if i=11 then
		ls_a=dw_1.getitemstring(1, i)
	else
		ls_a=dw_1.getitemstring(1, i+1)
	end if
	if ls_da>"" then
		ls_campo[i+1]= left(ls_campo[i], pos(ls_campo[i], ".") - 1)
		is_cond_sql+=", "+ls_campo[i+1]
		if ls_appoggio=" where " then 
			ls_and=""
		else
			ls_and=" and "
		end if
		if ls_a>"" then 
			ls_appoggio+=ls_and+" ("+ ls_campo[i]+" >= '"+ls_da+ "' and "+ls_campo[i]+" <= '"+ls_a+"')"
		else	
			ls_appoggio+=ls_and+" ("+ ls_campo[i]+" >= '"+ls_da+ "')"
		end if
		ls_appoggio+=" and  (articolo.id_"+ls_campo[i+1]+" = "+ls_campo[i+1]+".id_"+ls_campo[i+1]+")"
	end if
next
ls_da=string(dw_1.getitemnumber(1, "da_fornitore"))
if ls_da>"" then
	if 	ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	ls_appoggio+=ls_and+" (articolo.id_sog_commerciale = "+ls_da+ ")"
end if
ls_da=string(dw_1.getitemdecimal(1, "da_peso"))
ls_a=string(dw_1.getitemdecimal(1, "a_peso"))
if ls_da>"" then
	ls_da=f_cambia_virgola_in_punto(ls_da)
	if 	ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	if pos(is_cond_sql, "unita_confezione") <= 0 then
		is_cond_sql+=", unita_confezione "
		ls_appoggio+=ls_and+" (articolo.id_articolo = unita_confezione.id_articolo)"
		ls_and=" and "
	end if
	if ls_a>"" then
		ls_a=f_cambia_virgola_in_punto(ls_a)
		ls_appoggio+=ls_and+" (unita_confezione.peso_netto>="+ls_da+" and " +&
						"unita_confezione.peso_netto<="+ls_a+")"
	else
		ls_appoggio+=ls_and+" (unita_confezione.peso_netto>="+ls_da+")"
	end if
end if
ls_da=string(dw_1.getitemdecimal(1, "da_prezzo"))
ls_a=string(dw_1.getitemdecimal(1, "a_prezzo"))
if ls_da>"" then
	ls_da=f_cambia_virgola_in_punto(ls_da)
	if 	ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	if pos(is_cond_sql, "unita_confezione") <= 0 then
		is_cond_sql+=", unita_confezione "
		ls_appoggio+=ls_and+" (articolo.id_articolo = unita_confezione.id_articolo)"
		ls_and=" and "
	end if
	if pos(is_cond_sql,"prezzo")<=0 then
		is_cond_sql+=", prezzo "
		ls_appoggio+=ls_and+" (unita_confezione.id_unita_confezione=prezzo.id_unita_confezione)"+&
						 " and (prezzo.id_variazione="+string(ll_id_var)+")"		
		ls_and=" and "
	end if
	
	if ls_a>"" then
		ls_a=f_cambia_virgola_in_punto(ls_a)
		ls_appoggio+=ls_and+" (prezzo.prezzo_manifattura>="+ls_da+" and " +&
						"prezzo.prezzo_manifattura<="+ls_a+")"
	else
		ls_appoggio+=ls_and+" (prezzo.prezzo_manifattura>="+ls_da+")"
	end if
end if
ll_righe=dw_5.rowcount()
if ll_righe>0 then
	if ls_appoggio=" where " then 
		ls_and=""
	else
		ls_and=" and "
	end if
	is_cond_sql+=", distinta "
	ls_appoggio+=ls_and+ " articolo.id_articolo=distinta.id_articolo "
	for i=1 to ll_righe
		
		ll_id_art=dw_5.getitemnumber(i, "id_articolo")
		is_cond_sql+=", riga_distinta as riga_dis_"+string(i)
		ls_appoggio+= " and distinta.id_distinta=riga_dis_"+string(i)+".id_distinta"+&
						" and riga_dis_"+string(i)+".id_articolo="+string(ll_id_art)
	next
end if

if ls_appoggio=" where " then ls_appoggio=""
is_cond_sql+=ls_appoggio


end subroutine

public subroutine wf_ricerca (long al_riga_corrente, string as_data, datawindow adw);s_ric_param ls_ric_param
w_search_main lw_sm

if as_data>"" then	
		
	
	ls_ric_param.s_filter_value=adw.getitemstring(al_riga_corrente, as_data)
	if isnull(ls_ric_param.s_filter_value) then ls_ric_param.s_filter_value=""
	if pos(as_data, "des")>0 then
		ls_ric_param.s_filter_name="articolo_descrizione"
	else
		ls_ric_param.s_filter_name="articolo_codice"
	end if
	openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_documento_sw")
	ls_ric_param=message.powerobjectparm
	if upperbound(ls_ric_param.s_id_seg_value)>0 then
		if adw.dataobject="d_lista_art_gd" then
			adw.setitem(al_riga_corrente, "id_articolo",long(ls_ric_param.s_id_seg_value[1]))
			adw.setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
			adw.setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
		else
			if pos(as_data, "da")>0 then
				adw.setitem(al_riga_corrente,"da_articolo", ls_ric_param.s_main_value)
				adw.setitem(al_riga_corrente, "da_des_articolo",ls_ric_param.s_ausil_value[1])
				if isnull(adw.getitemstring(al_riga_corrente,"a_articolo")) then
					adw.setitem(al_riga_corrente,"a_articolo", ls_ric_param.s_main_value)
					adw.setitem(al_riga_corrente, "a_des_articolo",ls_ric_param.s_ausil_value[1])
				end if
			else
				adw.setitem(al_riga_corrente,"a_articolo", ls_ric_param.s_main_value)
				adw.setitem(al_riga_corrente, "a_des_articolo",ls_ric_param.s_ausil_value[1])
			end if
		end if
	end if
end if
end subroutine

on w_auto_aggiunta_cx.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.ln_1=create ln_1
this.cb_applica=create cb_applica
this.cb_azzera=create cb_azzera
this.cb_riporta=create cb_riporta
this.cb_annulla=create cb_annulla
this.dw_3=create dw_3
this.cb_classe=create cb_classe
this.cb_cancella=create cb_cancella
this.cb_ripulisci=create cb_ripulisci
this.cb_1=create cb_1
this.ln_2=create ln_2
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_inserisci=create cb_inserisci
this.cb_canc_riga_dis=create cb_canc_riga_dis
this.cb_art_sog_com=create cb_art_sog_com
this.dw_6=create dw_6
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.ln_1
this.Control[iCurrent+3]=this.cb_applica
this.Control[iCurrent+4]=this.cb_azzera
this.Control[iCurrent+5]=this.cb_riporta
this.Control[iCurrent+6]=this.cb_annulla
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.cb_classe
this.Control[iCurrent+9]=this.cb_cancella
this.Control[iCurrent+10]=this.cb_ripulisci
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.ln_2
this.Control[iCurrent+13]=this.dw_4
this.Control[iCurrent+14]=this.dw_5
this.Control[iCurrent+15]=this.cb_inserisci
this.Control[iCurrent+16]=this.cb_canc_riga_dis
this.Control[iCurrent+17]=this.cb_art_sog_com
this.Control[iCurrent+18]=this.dw_6
this.Control[iCurrent+19]=this.dw_1
end on

on w_auto_aggiunta_cx.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.ln_1)
destroy(this.cb_applica)
destroy(this.cb_azzera)
destroy(this.cb_riporta)
destroy(this.cb_annulla)
destroy(this.dw_3)
destroy(this.cb_classe)
destroy(this.cb_cancella)
destroy(this.cb_ripulisci)
destroy(this.cb_1)
destroy(this.ln_2)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_inserisci)
destroy(this.cb_canc_riga_dis)
destroy(this.cb_art_sog_com)
destroy(this.dw_6)
destroy(this.dw_1)
end on

event open;call super::open;
il_id_lista=message.doubleparm

dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_4.insertrow(1)
dw_6.settransobject(sqlca)
dw_6.insertrow(1)

dw_2.settransobject(sqlca)
is_sql_originale=dw_2.getsqlselect()
dw_1.insertrow(1)

String ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des, ls_tipo_stampa
long  ll_id_valuta

DataWindowChild ldw_da_cat_comm,  ldw_a_cat_comm,  ldw_listino, ldw_listino_des
DataWindowChild ldw_da_cat_merc,   ldw_a_cat_merc
DataWindowChild ldw_da_cat_fisc,  ldw_a_cat_fisc, ldw_da_fornitore, ldw_a_fornitore
DataWindowChild ldw_id_cat_codifica, ldw_id_cat_codifica_des, ldw_da_gruppo, ldw_a_gruppo
DataWindowChild ldw_da_classe, ldw_a_classe
DataWindowChild ldw_titolo, ldw_lista, ldw_gruppo_art
dw_1.GetChild("da_titolo", ldw_titolo)

dw_1.GetChild("id_lista", ldw_lista)


dw_1.GetChild("id_cat_codifica", ldw_id_cat_codifica)
dw_1.GetChild("id_cat_codifica_des", ldw_id_cat_codifica_des)

dw_1.getchild("listino",ldw_listino)
dw_1.getchild("listino_des",ldw_listino_des)

dw_1.GetChild("da_cat_comm", ldw_da_cat_comm)
dw_1.GetChild("a_cat_comm", ldw_a_cat_comm)

dw_1.GetChild("da_cat_merc", ldw_da_cat_merc)
dw_1.GetChild("a_cat_merc", ldw_a_cat_merc)

dw_1.GetChild("da_cat_fisc", ldw_da_cat_fisc)
dw_1.GetChild("a_cat_fisc", ldw_a_cat_fisc)

dw_1.GetChild("da_gruppo", ldw_da_gruppo)
dw_1.GetChild("a_gruppo", ldw_a_gruppo)

dw_1.GetChild("a_classe", ldw_a_classe)


dw_1.GetChild("da_fornitore", ldw_da_fornitore)
dw_1.GetChild("a_fornitore", ldw_a_fornitore)
dw_1.GetChild("id_gruppo_articoli", ldw_gruppo_art)

dw_1.accepttext()

ldw_gruppo_art.SetTransObject(SQLCA)
ldw_gruppo_art.Retrieve()

ldw_titolo.SetTransObject(SQLCA)
ldw_titolo.Retrieve()

ldw_lista.SetTransObject(SQLCA)
ldw_lista.Retrieve()

ldw_id_cat_codifica.SetTransObject(SQLCA)
ldw_id_cat_codifica.Retrieve()
ldw_id_cat_codifica_des.SetTransObject(SQLCA)
ldw_id_cat_codifica_des.Retrieve()

ldw_da_cat_comm.settransobject(sqlca)
ldw_da_cat_comm.retrieve()
ldw_a_cat_comm.settransobject(sqlca)
ldw_a_cat_comm.retrieve()
	
ldw_da_cat_merc.settransobject(sqlca)
ldw_da_cat_merc.retrieve()
ldw_a_cat_merc.settransobject(sqlca)
ldw_a_cat_merc.retrieve()

ldw_da_cat_fisc.settransobject(sqlca)
ldw_da_cat_fisc.retrieve()
ldw_a_cat_fisc.settransobject(sqlca)
ldw_a_cat_fisc.retrieve()
	
ldw_listino.settransobject(sqlca)
ldw_listino.retrieve()
ldw_listino_des.settransobject(sqlca)
ldw_listino_des.retrieve()

ldw_da_gruppo.settransobject(sqlca)
ldw_da_gruppo.retrieve()
ldw_a_gruppo.settransobject(sqlca)
ldw_a_gruppo.retrieve()

ldw_a_classe.retrieve()


ldw_da_fornitore.settransobject(sqlca)
ldw_da_fornitore.retrieve()
ldw_da_fornitore.setsort("rag_soc_1")
ldw_da_fornitore.sort()
ldw_a_fornitore.settransobject(sqlca)
ldw_a_fornitore.retrieve()
ldw_a_fornitore.setsort("rag_soc_1")
ldw_a_fornitore.sort()


end event

type st_1 from w_001`st_1 within w_auto_aggiunta_cx
integer x = 1682
integer y = 524
integer width = 1134
end type

type dw_2 from udw_base within w_auto_aggiunta_cx
integer x = 23
integer y = 1320
integer width = 1673
integer height = 636
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_lista_auto_gd"
boolean border = false
end type

event rowfocuschanged;setrowfocusindicator(hand!)
end event

type ln_1 from line within w_auto_aggiunta_cx
long linecolor = 33554432
integer linethickness = 4
integer beginx = 1714
integer beginy = 1480
integer endx = 2766
integer endy = 1480
end type

type cb_applica from uo_cb within w_auto_aggiunta_cx
string tag = "Applica i filtri"
integer x = 1728
integer y = 1352
integer width = 320
integer taborder = 120
boolean bringtotop = true
string text = "Applica"
end type

event clicked;long ll_righe,i, ll_id_art
decimal ldc_qta

dw_1.accepttext()

wf_verifica_filtri()
wf_crea_sql_cond()
if is_cond_sql>" " then
	
	dw_2.setsqlselect( is_sql_originale+is_cond_sql)
	ll_righe=dw_2.retrieve()
	if il_id_lista=0 or isnull(il_id_lista) then
		il_id_lista=dw_1.getitemnumber(1, "id_lista")
	end if
	for i= 1 to ll_righe
		dw_2.setitem(i, "id_lista", 	il_id_lista)
		ll_id_art=dw_2.getitemnumber(i, "id_articolo")
		select qta
		into :ldc_qta
		from dba.lista_art_key
		where id_lista_articoli=:il_id_lista
		and id_articolo=:ll_id_art
		;
		if ldc_qta>0 then
			dw_2.setitem(i, "qta", 	ldc_qta)
		end if	
	next
	
end if
end event

type cb_azzera from uo_cb within w_auto_aggiunta_cx
string tag = "Cancella i filtri impostati"
integer x = 2080
integer y = 1352
integer width = 320
integer taborder = 110
boolean bringtotop = true
string text = "Cancella Filtri"
end type

event clicked;dw_1.deleterow(1)
dw_1.insertrow(1)
dw_3.reset()
dw_5.reset()
post setfocus(dw_1)
end event

type cb_riporta from uo_cb within w_auto_aggiunta_cx
string tag = "Riporta Lista"
integer x = 1728
integer y = 1848
integer width = 320
integer taborder = 100
boolean bringtotop = true
string text = "Riporta"
end type

event clicked;s_dw_ritorna st_p
integer li_ret

if dw_2.rowcount()<=0 then
	messagebox("Attenzione!", "Non esistono articoli da riportare!")
	return
end if
st_p.ds=create datastore
st_p.ds.dataobject=dw_2.dataobject
li_ret=dw_2.rowscopy(1, dw_2.rowcount(), primary!, st_p.ds, 1, primary!)
closewithreturn(parent, st_p)
end event

type cb_annulla from uo_cb within w_auto_aggiunta_cx
string tag = "Abbandona lista"
integer x = 2432
integer y = 1848
integer width = 320
integer taborder = 90
boolean bringtotop = true
string text = "Annulla"
end type

event clicked;close(parent)
end event

type dw_3 from udw_base within w_auto_aggiunta_cx
integer x = 2345
integer y = 240
integer width = 379
integer height = 328
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_classe_art_lt"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_classe from commandbutton within w_auto_aggiunta_cx
integer x = 2158
integer y = 244
integer width = 183
integer height = 204
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Classe"
end type

event clicked;long ll_riga
s_recupera_classe s_classe
integer i
open(w_classe_struttura_cx)
s_classe=message.powerobjectparm
if isvalid(s_classe) then
	dw_3.reset()
	
	for i=1 to upperbound(s_classe.id_classe)
		if isnull(s_classe.id_classe[i]) then continue
		ll_riga=dw_3.insertrow(0)
		dw_3.setitem(ll_riga, "id_classe", s_classe.id_classe[i])
		dw_3.setitem(ll_riga, "cod_classe", s_classe.cod_classe[i])
		dw_3.setitem(ll_riga, "classe_livello", i)
	next
	
end if
dw_3.sort()
end event

type cb_cancella from commandbutton within w_auto_aggiunta_cx
integer x = 2158
integer y = 460
integer width = 183
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Canc."
end type

event clicked;dw_3.reset()
end event

type cb_ripulisci from commandbutton within w_auto_aggiunta_cx
integer x = 2080
integer y = 1848
integer width = 320
integer height = 108
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci Lista"
end type

event clicked;dw_2.reset()
end event

type cb_1 from commandbutton within w_auto_aggiunta_cx
integer x = 1714
integer y = 1496
integer width = 256
integer height = 156
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Catalogo"
end type

event clicked;s_st_cat_immediato st_cat
long ll_righe, i

ll_righe=dw_2.rowcount()
st_cat.id_sog_commerciale[1]=dw_4.getitemnumber(1, "id_sog_commerciale")
for i= 1 to ll_righe
	st_cat.id_articolo[i]=dw_2.getitemnumber(i, "id_articolo")	
	st_cat.cod_articolo[i]=dw_2.getitemstring(i, "articolo_codice")
next
openwithparm(w_st_foto_articolo_cx, st_cat)
end event

type ln_2 from line within w_auto_aggiunta_cx
long linecolor = 33554432
integer linethickness = 4
integer beginx = 1714
integer beginy = 1832
integer endx = 2766
integer endy = 1832
end type

type dw_4 from udw_base within w_auto_aggiunta_cx
integer x = 1979
integer y = 1492
integer width = 791
integer height = 172
integer taborder = 50
string dataobject = "d_rag_sog_com_ext"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;
end event

type dw_5 from udw_base within w_auto_aggiunta_cx
integer x = 462
integer y = 256
integer width = 1230
integer height = 424
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_lista_art_gd"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;string ls_data


choose case dwo.name
	case "articolo_codice_sw" 
		ls_data=left(dwo.name, len(string(dwo.name)) - 3)	
		wf_ricerca(row, ls_data, this)
	
	
		
		
end choose
end event

event itemchanged;st_ass_art_sottoclasse st_associa
string ls_colonna

choose case dwo.name
case 'articolo_codice'
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		setitem(row, "articolo_descrizione", st_associa.des_articolo)
	else
		post wf_ricerca(row, string(dwo.name), this)
	end if
end choose
end event

type cb_inserisci from commandbutton within w_auto_aggiunta_cx
integer x = 206
integer y = 392
integer width = 247
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;dw_5.insertrow(0)
end event

type cb_canc_riga_dis from commandbutton within w_auto_aggiunta_cx
integer x = 206
integer y = 512
integer width = 247
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;integer li_riga
li_riga=dw_5.getrow()
if li_riga>0 then
	dw_5.deleterow(li_riga)
end if
end event

type cb_art_sog_com from commandbutton within w_auto_aggiunta_cx
integer x = 2153
integer y = 1660
integer width = 603
integer height = 164
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Articoli Venduti al Cliente"
boolean cancel = true
end type

event clicked;datastore ds_art_venduti
long ll_id_cliente, ll_articoli_trovati, i, ll_riga_inserita, ll_id_caus
string ls_cod_art, ls_des_art, ls_ds_da_caricare

ll_id_cliente=dw_4.getitemnumber(1, "id_sog_commerciale")
if ll_id_cliente>0 then
	ll_id_caus=dw_6.getitemnumber(1, "id_caus_magazzino")
	if ll_id_caus>0 then 
		ls_ds_da_caricare="ds_art_ven_e_cv_per_cliente"
	else
		ls_ds_da_caricare="ds_art_venduti_per_cliente"
	end if
	
	ds_art_venduti=create datastore
	ds_art_venduti.dataobject = ls_ds_da_caricare
	ds_art_venduti.settransobject(sqlca)
	if ll_id_caus>0 then 
		ll_articoli_trovati=ds_art_venduti.retrieve(ll_id_cliente,ll_id_caus)
	else
		ll_articoli_trovati=ds_art_venduti.retrieve(ll_id_cliente)
	end if
	
	for i=1 to ll_articoli_trovati
		ls_cod_art=ds_art_venduti.getitemstring(i, "articolo_codice")
		ls_des_art=ds_art_venduti.getitemstring(i, "articolo_descrizione")
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_inserita, "articolo_codice", ls_cod_art)
		dw_2.setitem(ll_riga_inserita, "articolo_descrizione", ls_des_art)
	next
	
	destroy ds_art_venduti
	
end if
end event

type dw_6 from udw_base within w_auto_aggiunta_cx
integer x = 1728
integer y = 1660
integer width = 416
integer height = 164
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_scegli_caus_magazzino_ext"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;
end event

type dw_1 from udw_base within w_auto_aggiunta_cx
integer x = 32
integer y = 16
integer width = 2743
integer height = 1292
string dataobject = "d_sel_art_auto_wz"
boolean vscrollbar = false
end type

event clicked;string ls_data


choose case dwo.name
	case "da_articolo_sw" , "a_articolo_sw", "da_des_articolo_sw", "da_des_articolo_sw"
		ls_data=left(dwo.name, len(string(dwo.name)) - 3)	
		wf_ricerca(row, ls_data, this)
	
		
		
end choose
end event

event itemchanged;string ls_colonna, ls_listino
long ll_id_listino
Long ll_id_variazione
st_ass_art_sottoclasse st_associa
datawindowchild ldw_variazione

choose case DWO.NAME
	case 'da_articolo', "a_articolo"
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		
		setitem(row, dwo.name, st_associa.cod_articolo)
		if pos(string(dwo.name), "da")>0 then
			ls_colonna="da_des_articolo"
		else
			ls_colonna="a_des_articolo"
		end if
		setitem(row, ls_colonna, st_associa.des_articolo)
	else
		post wf_ricerca(row, string(dwo.name), this)
	end if

CASE "listino", "listino_des"
		ls_listino = data
		SELECT id_listino
		INTO	 :ll_id_listino
		FROM	 listino
		WHERE	 codice = :ls_listino;

		If SQLCA.SQLCODE = 0 Then			
			
			dw_1.getchild("variazione", ldw_variazione)
			ldw_variazione.settransobject(sqlca)				
			ldw_variazione.retrieve(ll_id_listino)
			
			
					
			SELECT  id_variazione
			into :ll_id_variazione
			FROM	 variazione
			WHERE	 id_listino = :ll_id_listino
			AND	 data_inizio <= today()
			AND	 (data_fine >= today() OR data_fine IS NULL)
			;
			dw_1.SetItem(1, "variazione", ll_id_variazione)
		else
			setnull(ll_id_variazione)
			dw_1.SetItem(1, "variazione", ll_id_variazione)
		End If			
CASE "da_classe"
	
	select id_classe
	into :ll_id_listino
	from classe
	where cod_classe=:data;
	if ll_id_listino>0 then

		dw_1.getchild("da_sottoclasse", ldw_variazione)
		ldw_variazione.settransobject(sqlca)				
		ldw_variazione.retrieve(ll_id_listino)
	end if
	
	
end choose
end event

event getfocus;call super::getfocus;dw_3.modify("datawindow.color = 10789024")
dw_5.modify("datawindow.color = 10789024")
end event

event losefocus;call super::losefocus;dw_3.modify("datawindow.color = 79741120")
dw_5.modify("datawindow.color = 79741120")
end event

