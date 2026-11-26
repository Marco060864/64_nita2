forward
global type w_crea_prezzi_cx from w_testa_righe_cx
end type
type cb_carica_prezzi from commandbutton within w_crea_prezzi_cx
end type
type dw_3 from u_dw_ext_main within w_crea_prezzi_cx
end type
type cb_seleziona from commandbutton within w_crea_prezzi_cx
end type
type cb_stampa from commandbutton within w_crea_prezzi_cx
end type
type dw_4 from datawindow within w_crea_prezzi_cx
end type
type ole_1 from olecontrol within w_crea_prezzi_cx
end type
type cb_carica from commandbutton within w_crea_prezzi_cx
end type
type cb_cancella_righe_vuote from commandbutton within w_crea_prezzi_cx
end type
type cb_2 from commandbutton within w_crea_prezzi_cx
end type
type cb_prezzo_oro from commandbutton within w_crea_prezzi_cx
end type
type em_prezzo_oro from editmask within w_crea_prezzi_cx
end type
type cb_catica_tutto from commandbutton within w_crea_prezzi_cx
end type
type cb_cod_new from commandbutton within w_crea_prezzi_cx
end type
type cbx_vedi_foto from checkbox within w_crea_prezzi_cx
end type
type cb_1 from commandbutton within w_crea_prezzi_cx
end type
type cb_carica_peso from commandbutton within w_crea_prezzi_cx
end type
type cb_3 from commandbutton within w_crea_prezzi_cx
end type
type r_1 from rectangle within w_crea_prezzi_cx
end type
type dw_5 from udw_base within w_crea_prezzi_cx
end type
type cb_azzera_scatola from commandbutton within w_crea_prezzi_cx
end type
type cbx_vedi_liste from checkbox within w_crea_prezzi_cx
end type
end forward

global type w_crea_prezzi_cx from w_testa_righe_cx
integer width = 4343
integer height = 2300
boolean minbox = true
boolean maxbox = true
cb_carica_prezzi cb_carica_prezzi
dw_3 dw_3
cb_seleziona cb_seleziona
cb_stampa cb_stampa
dw_4 dw_4
ole_1 ole_1
cb_carica cb_carica
cb_cancella_righe_vuote cb_cancella_righe_vuote
cb_2 cb_2
cb_prezzo_oro cb_prezzo_oro
em_prezzo_oro em_prezzo_oro
cb_catica_tutto cb_catica_tutto
cb_cod_new cb_cod_new
cbx_vedi_foto cbx_vedi_foto
cb_1 cb_1
cb_carica_peso cb_carica_peso
cb_3 cb_3
r_1 r_1
dw_5 dw_5
cb_azzera_scatola cb_azzera_scatola
cbx_vedi_liste cbx_vedi_liste
end type
global w_crea_prezzi_cx w_crea_prezzi_cx

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public function long wf_trova_uc (string as_dato, long a)
public function integer wf_costo_da_distinta ()
end prototypes

public subroutine wf_ricerca (long al_riga_corrente, string as_data);long ll_id_uc, ll_id_art
decimal ldc_peso

s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"

select id_articolo, codice
into :ll_id_art, :ls_ric_param.s_main_value
from articolo
where codice=:as_data;
if isnull(ll_id_art) or ll_id_art<1 then
	openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
	ls_ric_param=message.powerobjectparm
	if upperbound(ls_ric_param.s_id_seg_value)>0 then
		ll_id_art=long(ls_ric_param.s_id_seg_value[1])
	end if
end if
//dw_2.setitem(al_riga_corrente, "lista_art_key_id_articolo",ll_id_art)
dw_2.post setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
//dw_2.setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
select id_unita_confezione, peso_netto
into :ll_id_uc, :ldc_peso
from unita_confezione
where id_articolo=:ll_id_art
and unita_base='S'
;
dw_2.post setitem(al_riga_corrente, "id_unita_confezione",ll_id_uc)
dw_2.post setitem(al_riga_corrente, "q_oro",ldc_peso)

end subroutine

public function long wf_trova_uc (string as_dato, long a);string ls_new_codice
long ll_iduc, ll_ret

datastore ds_trova_articolo

as_dato=upper(as_dato)
as_dato=trim(as_dato)
//messagebox("dato!",as_dato)
ds_trova_articolo=create datastore
ds_trova_articolo.dataobject="d_cerca_codice_kati"
ds_trova_articolo.settransobject(sqlca)
ll_ret=ds_trova_articolo.retrieve(as_dato)
if ll_ret<=0 then
	ds_trova_articolo.dataobject=""
	ds_trova_articolo.dataobject="d_cerca_old_codice_kati"
	ds_trova_articolo.settransobject(sqlca)
	ll_ret=ds_trova_articolo.retrieve(as_dato)
	if ll_ret<=0 then
		messagebox("Attenzione!", "Articolo: "+as_dato+" non trovato!")
		destroy ds_trova_articolo
		return 0
	end if
end if

ll_iduc=ds_trova_articolo.getitemnumber(1, "id_unita_confezione")
as_dato=ds_trova_articolo.getitemstring(1, "codice")
dw_2.setitem(a, "articolo_codice", as_dato)
dw_2.setitem(a, "id_unita_confezione", ll_iduc)		


destroy ds_trova_articolo

return ll_iduc
end function

public function integer wf_costo_da_distinta ();//datastore ds_trova_costo
//STRING LS_COD_ART, ls_tipo_um
decimal ldc_costo, ldc_peso
//integer i, li_ret
//
//ds_trova_costo=create datastore
//ds_trova_costo.dataobject="d_val_costo_da_distinta"
//ds_trova_costo.settransobject(sqlca)
//
//for i = 1 to dw_2.ROWCOUNT()
//	LS_COD_ART=dw_2.GETITEMstring(I, "articolo_codice")
//	li_ret=ds_trova_costo.retrieve(LS_COD_ART)
//	if li_ret>=1 then
//		ldc_costo=ds_trova_costo.getitemdecimal(1, "c_sum_costo")
//		ls_tipo_um=ds_trova_costo.getitemstring(1, "tipo")
//		if ls_tipo_um='P' then
//			ldc_peso=ds_trova_costo.getitemdecimal(1, "peso_netto")
//			if ldc_peso>0 then
//				ldc_costo /=ldc_peso
//			end if
//			dw_2.setitem(i, "tipo_prezzo", "M")
//		end if
//		//dw_2.setitem(i, "p_costo", ldc_costo)
//	else
//		messagebox("Attenzione!", "Articolo "+LS_COD_ART+ " non ha righe distinta!")
//	end if
//next
//setfocus(dw_2)
//destroy ds_trova_costo
return ldc_costo
end function

on w_crea_prezzi_cx.create
int iCurrent
call super::create
this.cb_carica_prezzi=create cb_carica_prezzi
this.dw_3=create dw_3
this.cb_seleziona=create cb_seleziona
this.cb_stampa=create cb_stampa
this.dw_4=create dw_4
this.ole_1=create ole_1
this.cb_carica=create cb_carica
this.cb_cancella_righe_vuote=create cb_cancella_righe_vuote
this.cb_2=create cb_2
this.cb_prezzo_oro=create cb_prezzo_oro
this.em_prezzo_oro=create em_prezzo_oro
this.cb_catica_tutto=create cb_catica_tutto
this.cb_cod_new=create cb_cod_new
this.cbx_vedi_foto=create cbx_vedi_foto
this.cb_1=create cb_1
this.cb_carica_peso=create cb_carica_peso
this.cb_3=create cb_3
this.r_1=create r_1
this.dw_5=create dw_5
this.cb_azzera_scatola=create cb_azzera_scatola
this.cbx_vedi_liste=create cbx_vedi_liste
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_carica_prezzi
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_seleziona
this.Control[iCurrent+4]=this.cb_stampa
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.ole_1
this.Control[iCurrent+7]=this.cb_carica
this.Control[iCurrent+8]=this.cb_cancella_righe_vuote
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.cb_prezzo_oro
this.Control[iCurrent+11]=this.em_prezzo_oro
this.Control[iCurrent+12]=this.cb_catica_tutto
this.Control[iCurrent+13]=this.cb_cod_new
this.Control[iCurrent+14]=this.cbx_vedi_foto
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.cb_carica_peso
this.Control[iCurrent+17]=this.cb_3
this.Control[iCurrent+18]=this.r_1
this.Control[iCurrent+19]=this.dw_5
this.Control[iCurrent+20]=this.cb_azzera_scatola
this.Control[iCurrent+21]=this.cbx_vedi_liste
end on

on w_crea_prezzi_cx.destroy
call super::destroy
destroy(this.cb_carica_prezzi)
destroy(this.dw_3)
destroy(this.cb_seleziona)
destroy(this.cb_stampa)
destroy(this.dw_4)
destroy(this.ole_1)
destroy(this.cb_carica)
destroy(this.cb_cancella_righe_vuote)
destroy(this.cb_2)
destroy(this.cb_prezzo_oro)
destroy(this.em_prezzo_oro)
destroy(this.cb_catica_tutto)
destroy(this.cb_cod_new)
destroy(this.cbx_vedi_foto)
destroy(this.cb_1)
destroy(this.cb_carica_peso)
destroy(this.cb_3)
destroy(this.r_1)
destroy(this.dw_5)
destroy(this.cb_azzera_scatola)
destroy(this.cbx_vedi_liste)
end on

event open;call super::open;dw_3.settransobject(sqlca)
dw_5.settransobject(sqlca)

dw_3.insertrow(1)
end event

event close;call super::close;if isvalid(w_mostra_imm_ocx) then
	close(w_mostra_imm_ocx)
end if
end event

type st_1 from w_testa_righe_cx`st_1 within w_crea_prezzi_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_crea_prezzi_cx
integer y = 20
integer width = 4215
integer height = 620
boolean titlebar = true
string title = "Liste di articoli da prezzare"
string dataobject = "d_padre_prezzi_calcola_cx"
end type

event dw_1::itemchanged;call super::itemchanged;decimal ldc_precisione
string ls_tipo_arr, ls_testo, ls_prec

if row>0 and (dwo.name="tipo_arrotondamento" or dwo.name="num_dec_prezzo")  then
	if dwo.name="tipo_arrotondamento" then
		ls_tipo_arr=data
		ldc_precisione=getitemdecimal(row,"num_dec_prezzo")
		ls_prec=f_cambia_virgola_in_punto(string(ldc_precisione))
	else
		ls_tipo_arr=getitemstring(row, "tipo_arrotondamento")
		ls_prec=f_cambia_virgola_in_punto(data)
	end if
	if isnull(ls_tipo_arr) or isnull(ldc_precisione) then
		
		ls_testo="((if(isnull( min_lav_esterna * p_min_lav_esterna), 0,min_lav_esterna"+  &
		"* p_min_lav_esterna ))+ (if(isnull( manif_x_peso ),0, manif_x_peso * q_oro )"+  &
		" - if(isnull(sconto) or sconto=0,0, if(isnull( manif_x_peso ),0, manif_x_peso * q_oro )*sconto/100))" + &
		"+(if(isnull( brillante ), 0,  brillante )) "+  &
		"+(if(isnull( p_costo ), 0,  p_costo ))+(if(isnull( profilo ), 0,  profilo ))"+  &
		"+(if(isnull( min_lav_interna) , 0,  min_lav_interna ))) "+ &
		"+(if(isnull(varie), 0, varie))+if(isnull( q_oro * p_oro ),0,  q_oro * p_oro)) " 
		
		
//		ls_testo="(if(isnull( q_oro * p_oro ),0,  q_oro * p_oro))"+  &
//		"+ (if(isnull( min_lav_esterna * p_min_lav_esterna), "+  &
//		"0,min_lav_esterna * p_min_lav_esterna ))+ "+  &
//		"(if(isnull( brillante ), 0,  brillante )) "+  &
//		"+(if(isnull( p_costo ), 0,  p_costo ))+"+  &
//		"(if(isnull( profilo ), 0,  profilo ))+(if(isnull( min_lav_interna) , 0,  "+  &
//		"min_lav_interna ))"
	else
		ls_testo="truncate(((if(isnull( min_lav_esterna * p_min_lav_esterna), 0,min_lav_esterna"+  &
		"* p_min_lav_esterna ))+ (if(isnull( manif_x_peso ),0, manif_x_peso * q_oro ) - " + &
		"if(isnull(sconto) or sconto=0,0, if(isnull( manif_x_peso ),0, manif_x_peso * q_oro )*sconto/100))" + &
		"+(if(isnull( brillante ), 0,  brillante )) "+  &
		"+(if(isnull( p_costo ), 0,  p_costo ))+(if(isnull( profilo ), 0,  profilo ))"+  &
		"+(if(isnull( min_lav_interna) , 0,  min_lav_interna )*(if(isnull(sconto) "+  &
		"or sconto=0,1, sconto/100))) + (if(isnull(varie), 0, varie)) + if(isnull( q_oro * p_oro ),0,  q_oro * p_oro))/" +ls_prec
		
//		ls_testo="truncate(((if(isnull( q_oro * p_oro ),0,  q_oro * p_oro)) "+  & 
//	"+ (if(isnull( min_lav_esterna * p_min_lav_esterna), "+  &
//	"0,min_lav_esterna * p_min_lav_esterna ))+ "+  &
//	"(if(isnull( brillante ), 0,  brillante )) "+  &
//	"+(if(isnull( p_costo ), 0,  p_costo ))+"+  &
//	"(if(isnull( profilo ), 0,  profilo ))+(if(isnull( min_lav_interna) , 0, "+  & 
//	"min_lav_interna )))/"+ls_prec
//		
		
		if ls_tipo_arr='M' then
			ls_testo+= " + 0.499999 , 0 )"
		ELSEIF ls_tipo_arr='S' THEN
			ls_testo+= " + 0.999999 , 0)"
		else
			ls_testo+=" ,0 ) "
		END IF
		ls_testo+="* "+ls_prec
		
	end if
	//MESSAGEBOX("w", LS_TESTO)
	setitem(row, "formula", ls_testo)
		
		
end if
end event

event dw_1::rbuttondown;call super::rbuttondown;string ls_tip
if dwo.type="column" then
	if len(string(dwo.tag))>2 then
		ls_tip=dwo.name+"|"+dwo.tag
		openwithparm(w_tip, ls_tip)
	end if
end if
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;string ls_arr

if currentrow>0 then
	ls_arr=getitemstring(currentrow, "tipo_arrotondamento")
	trigger event itemchanged(currentrow, dw_1.object.tipo_arrotondamento, ls_arr)
end if
end event

type dw_2 from w_testa_righe_cx`dw_2 within w_crea_prezzi_cx
integer y = 640
integer width = 4224
integer height = 872
boolean titlebar = true
string title = "Articoli da prezzare (METTI SEMPRE ~"1~" SU RICARICO E RIC.2!)"
string dataobject = "d_prezzi_calcolo_tb"
end type

event dw_2::ue_insert;call super::ue_insert;long ll_riga, ll_id_crea_prezzi
decimal ldc_val_oro, ldc_val_cl, ldc_val_ricarico, ldc_sconto, ldc_ric_2

	ll_riga=dw_1.getrow()
	if ll_riga>0 then
		ldc_val_cl=dw_1.getitemdecimal(ll_riga, "val_man_centro_lavoro")
		ldc_val_ricarico=dw_1.getitemdecimal(ll_riga, "val_ricarico")
		ldc_val_oro=dw_1.getitemdecimal(ll_riga, "val_oro")
		ll_id_crea_prezzi=dw_1.getitemnumber(ll_riga, "id_crea_prezzi")
		ldc_sconto=dw_1.getitemdecimal(ll_riga, "sconto")
		ldc_ric_2=dw_1.getitemdecimal(ll_riga, "ricarico_2")
		if ll_id_crea_prezzi>0 then
			dw_2.setitem(Ancestorreturnvalue, "p_min_lav_esterna", ldc_val_cl)
			dw_2.setitem(Ancestorreturnvalue, "ricarico", ldc_val_ricarico)
			dw_2.setitem(Ancestorreturnvalue, "p_oro", ldc_val_oro)
			dw_2.setitem(Ancestorreturnvalue, "id_crea_prezzi", ll_id_crea_prezzi)
			dw_2.setitem(Ancestorreturnvalue, "sconto", ldc_sconto)
			dw_2.setitem(Ancestorreturnvalue, "ricarico_2", ldc_ric_2)
		else
			Messagebox("Attenzione!", "Prima di inserire righe salvare la tabella principale!")
		end if
	end if
	return Ancestorreturnvalue
	


end event

event dw_2::retrieveend;call super::retrieveend;  
long ll_riga_dw_1
string ls_tipo,ls_testo, Ls_RET
if rowcount>0 then
	ll_riga_dw_1=dw_1.getrow()
 	ls_testo=dw_1.getitemstring(ll_riga_dw_1, "formula")
	if  ls_testo>" " then
		//messagebox("Attenzione! Nuova Formula!" , ls_testo)
		Ls_RET=dw_2.modify("c_costo.expression='"+ls_testo+"'")
		IF Ls_RET<>"" THEN 
			messagebox(Ls_RET , ls_testo)
		end if
	else
		//Ls_RET=dw_2.modify("c_prezzo_vendita.expression='"+ls_testo+" * ricarico'")
		ls_testo=dw_2.describe("c_costo.expression")
		dw_1.setitem(ll_riga_dw_1, "formula", ls_testo)
	end if
	setfocus(dw_2)
	setfocus(dw_1)
end if
end event

event dw_2::itemchanged;call super::itemchanged;if dwo.name='articolo_codice' then
	post wf_ricerca(row, data)
	
end if
end event

event dw_2::dragdrop;call super::dragdrop;datawindow ldw_drag
integer li_n_colonna, li_righe, i, a
string ls_dato, ls_new_codice
decimal ldc_dato
long ll_iduc
i_dw_corrente=2
STRING LS_DATO_1, ls_new_codice1



if source.TypeOf()=Datawindow! then
	ldw_drag=source
	li_n_colonna=ldw_drag.getcolumn()
	
	li_righe=ldw_drag.rowcount()
	
	for i= 2 to li_righe
		ls_dato=ldw_drag.getitemstring(i, li_n_colonna)
		if string(dwo.name) = 'articolo_codice' and isnull(ls_dato)then 
			
			
			continue
			
		else
			
			IF LEFT(LS_DATO, 1)="?" THEN
				LS_DATO=RIGHT(LS_DATO, LEN(LS_DATO) - 1)
			END IF
			a++
			
		end if
	
		if dw_2.rowcount()< a then
			cb_inserisci.triggerevent("clicked")
		end if
		if string(dwo.name) = 'articolo_codice' then
			//aggiunta per codicei vecchi memorizzati in cod_intrastat (kati 2008)
			wf_trova_uc(LS_DATO, a)
			
		else
			ldc_dato=dec(ls_dato)
			dw_2.setitem(a, string(dwo.name), ldc_dato)
		
		end if
	next
	
	
end if
end event

event dw_2::dragleave;call super::dragleave;
	drag(end!)

end event

event dw_2::doubleclicked;call super::doubleclicked;string ls_etichetta
ls_etichetta=dwo.name

choose case ls_etichetta
	CASE "articolo_t"
		setsort("articolo_codice")
		sort()
end choose
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;string ls_imm
setrowfocusindicator(hand!)

if currentrow>0 and cbx_vedi_foto.checked then
	ls_imm=getitemstring(currentrow, "articolo_codice")
	select immagine
	into :ls_imm
	from articolo
	where codice=:ls_imm;
	if ls_imm>"" then
		if isvalid(w_mostra_imm_ocx) then
			w_mostra_imm_ocx.wf_mostra(ls_imm)
		else
			openwithparm(w_mostra_imm_ocx, ls_imm, "w_mostra_imm_ocx", parent)
		end if
	end if
end if
end event

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_crea_prezzi_cx
integer x = 50
integer y = 1536
integer width = 251
integer height = 100
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_crea_prezzi_cx
integer x = 594
integer y = 1536
integer width = 238
integer height = 100
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_crea_prezzi_cx
integer x = 325
integer y = 1536
integer width = 247
integer height = 100
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_crea_prezzi_cx
integer x = 50
integer y = 1776
integer width = 343
integer height = 100
integer weight = 700
string text = "Esci"
boolean cancel = false
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_crea_prezzi_cx
integer x = 443
integer y = 1776
integer width = 343
integer height = 100
end type

type cb_carica_prezzi from commandbutton within w_crea_prezzi_cx
integer x = 3442
integer y = 1556
integer width = 517
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica prezzi in listino"
end type

event clicked;long ll_id_var, ll_id_uc
decimal ldc_prezzo
string ls_tipo_prezzo, ls_colonna_prezzo
datastore ds_agg_prezzo

integer i, li_righe, li_riga_trovata

ll_id_var=dw_3.getitemnumber(1, "id_variazione")
if ll_id_var>0 then
	ds_agg_prezzo=create datastore
	ds_agg_prezzo.dataobject="ds_agg_prezzo"
	ds_agg_prezzo.settransobject(sqlca)
	li_righe=ds_agg_prezzo.retrieve(ll_id_var)
	for i= 1 to dw_2.rowcount()
		ls_tipo_prezzo=dw_2.getitemstring(i, "tipo_prezzo")
		if isnull(ls_tipo_prezzo) then ls_tipo_prezzo='P'
		ldc_prezzo=dw_2.getitemdecimal(i, "c_prezzo_vendita")
		ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
//		messagebox("id uc", string(ll_id_uc))
//		messagebox("prezzo", string(ldc_prezzo))
		
		li_riga_trovata=ds_agg_prezzo.find("id_unita_confezione="+string(ll_id_uc),1, li_righe)
		
//		messagebox("riga trovata aggiornare", li_riga_trovata)
		
		if li_riga_trovata<=0 then 
			
			li_riga_trovata=ds_agg_prezzo.insertrow(0)
			ds_agg_prezzo.setitem(li_riga_trovata, "id_variazione", ll_id_var)
			ds_agg_prezzo.setitem(li_riga_trovata,"id_unita_confezione", ll_id_uc)
		end if
		if ls_tipo_prezzo='P' then
			ds_agg_prezzo.setitem(li_riga_trovata, "prezzo", ldc_prezzo)
		elseif ls_tipo_prezzo='M' then
			ds_agg_prezzo.setitem(li_riga_trovata, "prezzo_manifattura", ldc_prezzo)
		else
			ds_agg_prezzo.setitem(li_riga_trovata, "prezzo", ldc_prezzo)
			ds_agg_prezzo.setitem(li_riga_trovata, "prezzo_manifattura", ldc_prezzo)
		end if
		
	next
	if ds_agg_prezzo.update()=1 then
		commit;
		messagebox("OK!", "Prezzi salvati correttamente!")
	else
		rollback;
		messagebox("Errore!", "Il salvataggio dei dati non è andato a buon fine!")
	end if
	
	destroy ds_agg_prezzo
	
else
	messagebox("Attenzione!", "Per aggiungere i prezzi occorre indicare un listino!")
end if
end event

type dw_3 from u_dw_ext_main within w_crea_prezzi_cx
integer x = 2583
integer y = 1564
integer width = 859
integer height = 180
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_id_var_ext"
boolean border = false
end type

event getfocus;//
end event

event losefocus;//
end event

type cb_seleziona from commandbutton within w_crea_prezzi_cx
integer x = 2130
integer y = 1536
integer width = 416
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona"
end type

event clicked;s_dw_ritorna st_p
integer li_righe, i, ll_riga
long ll_id_lista
string ls_cod_art

li_righe=dw_1.getrow()
ll_id_lista=dw_1.getitemnumber(li_righe, "id_crea_prezzi")
IF ll_id_lista>0 THEN

	openwithparm(w_auto_aggiunta_cx, ll_id_lista)
	
	
	st_p=message.powerobjectparm
	
	if isvalid(st_p) then
		for i=1 to st_p.ds.rowcount()
			ls_cod_art=st_p.ds.getitemstring(i, "articolo_codice")
			ll_riga=dw_2.trigger event ue_insert(0)
			dw_2.setitem(ll_riga, 1, ll_id_lista)
			dw_2.trigger event itemchanged(ll_riga, dw_2.object.articolo_codice, ls_cod_art)
			
			
		next
//		st_p.ds.rowscopy(1, st_p.ds.rowcount(), primary!, dw_2, li_righe, primary!)
	end if
	dw_2.sort()
	if dw_2.rowcount()>0 then
		if messagebox("Attenzione!", "Salvare la lista corrente?", stopsign!,yesno!)=1 then
			post wf_salva_dw(dw_1,dw_2,2)
		end if
	end if
else
	messagebox("Attenzione!", "Salvare la lista corrente prima di effettuare la selezione!")
end if
	
end event

type cb_stampa from commandbutton within w_crea_prezzi_cx
integer x = 855
integer y = 1536
integer width = 343
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;long ll_id

printsetup()
dw_2.print()

end event

type dw_4 from datawindow within w_crea_prezzi_cx
integer x = 46
integer y = 1896
integer width = 3918
integer height = 416
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_imp_excel_ext"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event clicked;drag(begin!)
end event

type ole_1 from olecontrol within w_crea_prezzi_cx
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
integer x = 3726
integer y = 1816
integer width = 201
integer height = 188
integer taborder = 20
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean isdragtarget = true
string binarykey = "w_crea_prezzi_cx.win"
string displayname = "Prova"
boolean resizable = true
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayasactivexdocument!
omcontentsallowed contentsallowed = containsany!
end type

type cb_carica from commandbutton within w_crea_prezzi_cx
integer x = 2130
integer y = 1776
integer width = 416
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica File Excel"
end type

event clicked;
integer li_ret
string ls_path, ls_file, ls_name
long ll_rigains, ll_max
	
getfileopenname("Cerca report", ls_path, ls_name)
if  not(trim(ls_name)="" or isnull(ls_name)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+".txt"
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_4.reset()
	dw_4.importfile(Text!,ls_file)
	parent.height=2450
	ole_1.object.close(False)
	messagebox("Attenzione!", "Creo un nuovo insieme di prezzi.")

	ll_rigains=dw_1.insertrow(0)
	
	dw_1.setitem(ll_rigains, "codice", "EXC_"+left(ls_name, 12))
	dw_1.setitem(ll_rigains, "descrizione", "EXC_"+left(ls_path, 36))
	dw_1.scrolltorow(ll_rigains)
	if dw_2.rowcount()<1 then 
		i_dw_corrente=2
		cb_inserisci.triggerevent("clicked")
	end if
	messagebox("Attenzione!", "Prima di recuperare i dati riempire correttamente la testata con codice: "+"EXC_"+left(ls_name, 12))
end if	 

cb_cancella_righe_vuote.triggerevent(clicked!)



end event

type cb_cancella_righe_vuote from commandbutton within w_crea_prezzi_cx
integer x = 1595
integer y = 1776
integer width = 517
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella Righe Vuote"
end type

event clicked;


string ls_cod_art
long i, ll_righe

ll_righe=dw_2.rowcount()
//messagebox("W", ll_righe)
for i = ll_righe to 1 step -1
	ls_cod_art=dw_2.getitemstring(i, "articolo_codice")
	//messagebox("W", "dentro for")
	//messagebox("W", ls_cod_art)
	if isnull(ls_cod_art) then
		dw_2.deleterow(i)
		//messagebox("W", "dentro del")
	else
		exit
	end if
next 
end event

type cb_2 from commandbutton within w_crea_prezzi_cx
integer x = 1298
integer y = 1536
integer width = 357
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Articoli Doppi"
end type

event clicked;integer i, li_riga_trovata, li_righe
string ls_art_codice

li_righe=dw_2.rowcount()
for i= 1 to li_righe - 1
	ls_art_codice=dw_2.getitemstring(i, "articolo_codice")
	
	li_riga_trovata=dw_2.find("articolo_codice ='"+ls_art_codice+"'", i+1, li_righe)
	if li_riga_trovata>0 then
		dw_2.scrolltorow(li_riga_trovata)
		messagebox("Attenzione!", "Articolo "+ls_art_codice+&
		" è presente alla riga n. "+string(i) + " e alla riga n. "+string(li_riga_trovata))
		exit
		
	end if
next

end event

type cb_prezzo_oro from commandbutton within w_crea_prezzi_cx
integer x = 841
integer y = 1776
integer width = 466
integer height = 100
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo prezzo ORO"
end type

event clicked;decimal ldc_prezzo_oro
integer i, a


ldc_prezzo_oro=dec(em_prezzo_oro.text)
if ldc_prezzo_oro>0 then
	if messagebox("Attenzione!" , "Il prezzo attuale del metallo verrà cambiato nel seguente: "+&
					  string(ldc_prezzo_oro)+" su tutte le liste create. Se siete sicuri di volerlo "+&
					  " fare scegliete SI, altrimenti annullate con NO.", stopsign!, yesno!)= 1	then
		for i= 1 to dw_1.rowcount()
			dw_1.scrolltorow(i)
			dw_1.setitem(i, "val_oro", ldc_prezzo_oro)
			for a= 1 to dw_2.rowcount()
				dw_2.setitem(a, "p_oro", ldc_prezzo_oro)
				
			next
		next
	end if
else
	messagebox("Attenzione!", "Indicare il nuovo prezzo dell'ORO nell' EDIT accanto a questo bottone.") 
end if
end event

type em_prezzo_oro from editmask within w_crea_prezzi_cx
integer x = 1307
integer y = 1776
integer width = 261
integer height = 104
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_catica_tutto from commandbutton within w_crea_prezzi_cx
integer x = 3442
integer y = 1656
integer width = 517
integer height = 88
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica tutte le liste"
end type

event clicked;integer i
long ll_id_var

ll_id_var=dw_3.getitemnumber(1, "id_variazione")
if ll_id_var>0 then
	if messagebox("Attenzione!" , "Verrà aggiornato il listino scelto con i prezzi attuali di tutte"+&
					"le liste presenti in questa finestra. Se siete sicuri di volerlo "+&
						  " fare scegliete SI, altrimenti annullate con NO.", stopsign!, yesno!)= 1	then
		for i= 1 to dw_1.rowcount()
			dw_1.scrolltorow(i)
			cb_carica_prezzi.triggerevent(CLICKED!)
		next
	end if
else
	
end if
end event

type cb_cod_new from commandbutton within w_crea_prezzi_cx
integer x = 1678
integer y = 1536
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Codici Nuovi"
end type

event clicked;string ls_art, ls_art_old
integer i
for i= 1 to dw_2.rowcount()
	ls_art_old=dw_2.getitemstring(i, "articolo_codice")
	
		select codice
		into :ls_art
		from dba.articolo
		where cod_intrastat=:ls_art_old;
		if ls_art> "" then
			dw_2.setitem(i, "articolo_codice", ls_art)
			ls_art=""
		end if
next
end event

type cbx_vedi_foto from checkbox within w_crea_prezzi_cx
integer x = 2185
integer y = 1668
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Foto"
boolean lefttext = true
end type

type cb_1 from commandbutton within w_crea_prezzi_cx
integer x = 55
integer y = 1656
integer width = 562
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica costo da distinta"
end type

event clicked;datastore ds_trova_costo
STRING LS_COD_ART, ls_tipo_um
decimal ldc_costo, ldc_peso
integer i, li_ret

ds_trova_costo=create datastore
ds_trova_costo.dataobject="d_val_costo_da_distinta"
ds_trova_costo.settransobject(sqlca)

for i = 1 to dw_2.ROWCOUNT()
	LS_COD_ART=dw_2.GETITEMstring(I, "articolo_codice")
	li_ret=ds_trova_costo.retrieve(LS_COD_ART)
	if li_ret>=1 then
		ldc_costo=ds_trova_costo.getitemdecimal(1, "c_sum_costo")
		ls_tipo_um=ds_trova_costo.getitemstring(1, "tipo")
		if ls_tipo_um='P' then
			ldc_peso=ds_trova_costo.getitemdecimal(1, "peso_netto")
			if ldc_peso>0 then
				ldc_costo /=ldc_peso
			end if
			dw_2.setitem(i, "tipo_prezzo", "M")
		end if
		dw_2.setitem(i, "varie", ldc_costo)
	else
		messagebox("Attenzione!", "Articolo "+LS_COD_ART+ " non ha righe distinta!")
	end if
next
setfocus(dw_2)
destroy ds_trova_costo
end event

type cb_carica_peso from commandbutton within w_crea_prezzi_cx
integer x = 645
integer y = 1656
integer width = 498
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica Peso Articoli "
end type

event clicked;integer i, li_test
decimal ldc_peso
string ls_cod_art

li_test=messagebox("ATTENZIONE!", "Vuoi mantenere eventuali valori esistenti?", stopsign!, yesno!)
for i= 1 to dw_2.ROWCOUNT()
	if li_test=1 then
		ldc_peso=dw_2.getitemdecimal(i, "q_oro")
		if ldc_peso>0 then continue
	end if
	ls_cod_art=dw_2.getitemstring(i, "articolo_codice")
	WF_ricerca(i, ls_cod_art)
	
NEXT


end event

type cb_3 from commandbutton within w_crea_prezzi_cx
integer x = 1170
integer y = 1656
integer width = 576
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Car. Prezzo Lis V. Base"
end type

event clicked;long ll_id_uc, ll_id_listino, ll_id_var,ll_id_um
decimal ld_prezzo_manifattura, ldc_prezzo_pz
string ls_pref_fornitore, ls_cod_soggetto, ls_cod_listino,ls_tipo_um
integer i

select id_listino
into :ll_id_listino
from listino
where lis_base='S'
and tipo= 'V'
;
select id_variazione
into :ll_id_var
from variazione
where id_listino=:ll_id_listino
and (data_inizio<=today() 
and (data_fine>=today() or data_fine is null));

for i = 1 to dw_2.ROWCOUNT()
	ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
	ls_tipo_um=dw_2.getitemstring(i, "tipo_prezzo")

	select prezzo_manifattura, prezzo
	into :ld_prezzo_manifattura, :ldc_prezzo_pz
	from prezzo
	where id_unita_confezione=:ll_id_uc
	and id_variazione=:ll_id_var
	;

	
	if ls_tipo_um='P' and ldc_prezzo_pz >0 then
		dw_2.setitem(i, "manif_x_peso", ldc_prezzo_pz)
	else
		dw_2.setitem(i, "manif_x_peso", ld_prezzo_manifattura)
	end if
next

end event

type r_1 from rectangle within w_crea_prezzi_cx
integer linethickness = 6
long fillcolor = 134217752
integer x = 2565
integer y = 1540
integer width = 1413
integer height = 220
end type

type dw_5 from udw_base within w_crea_prezzi_cx
boolean visible = false
integer x = 55
integer y = 640
integer width = 4224
integer height = 872
integer taborder = 20
string dataobject = "d_prezzi_calcolo_st"
end type

type cb_azzera_scatola from commandbutton within w_crea_prezzi_cx
integer x = 1769
integer y = 1652
integer width = 389
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Azzera Scatola"
end type

event clicked;integer i

if messagebox("Attenzione!", "Vuoi davvero cancellare tutti i valori sul campo SCATOLA?", stopsign!, yesno!)=1 then
	for i= 1 to dw_2.rowcount()
		dw_2.setitem(i, "p_costo", 0)
	next
end if
end event

type cbx_vedi_liste from checkbox within w_crea_prezzi_cx
integer x = 2610
integer y = 1796
integer width = 521
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi tutte le Liste"
end type

event clicked;messagebox("OCCHIO!", "TU non vedi le liste che hanno 'ricarico 2' nullo perché sono quelle del vecchio crea prezzi!")


if checked then
	dw_1.setfilter("")
	dw_1.filter()
else
	dw_1.setfilter("ricarico_2 > 0")
	dw_1.filter()
end if
end event

