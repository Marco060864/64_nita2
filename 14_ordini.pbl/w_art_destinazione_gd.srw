forward
global type w_art_destinazione_gd from w_np_single_data
end type
type cb_stampa from commandbutton within w_art_destinazione_gd
end type
type cbx_riproponi_dest from checkbox within w_art_destinazione_gd
end type
type cbx_riproponi_articolo from checkbox within w_art_destinazione_gd
end type
end forward

global type w_art_destinazione_gd from w_np_single_data
integer width = 5111
integer height = 2096
string title = "Associa Articoli a Destinazioni"
cb_stampa cb_stampa
cbx_riproponi_dest cbx_riproponi_dest
cbx_riproponi_articolo cbx_riproponi_articolo
end type
global w_art_destinazione_gd w_art_destinazione_gd

forward prototypes
public subroutine wf_nome_imm_automatico (long al_riga)
public subroutine wf_filtra_righe_distinta (long al_id_art)
public subroutine wf_controlla_doppi (long al_riga_corrente)
public subroutine wf_riempi (string as_flag, long al_id, long al_row)
end prototypes

public subroutine wf_nome_imm_automatico (long al_riga);string ls_conto, ls_imm_base, ls_imm, ls_cod_ana
if al_riga>0 then
	if al_riga<>dw_single.getrow() then al_riga=dw_single.getrow()
	ls_conto=dw_single.getitemstring(al_riga, "sog_commerciale_codice")
	select a.codice
	into :ls_cod_ana
	from anagrafica a, sog_commerciale s
	where a.id_anagrafica=s.id_anagrafica
	and s.codice=:ls_conto;
	ls_imm_base=dw_single.getitemstring(al_riga, "articolo_immagine")
	ls_imm=left(ls_imm_base, len(ls_imm_base) - 4) +"_"+ ls_cod_ana+right(ls_imm_base, 4)
	dw_single.setitem(al_riga, "immagini_cliente_nome_immagine", ls_imm)
end if
end subroutine

public subroutine wf_filtra_righe_distinta (long al_id_art);//
DataWindowChild dwc_riga

integer rtncode

rtncode = dw_single.GetChild('id_riga_distinta', dwc_riga)

IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_riga.SetTransObject(SQLCA)

// Populate with values for eastern states
dwc_riga.setfilter("distinta_id_articolo= "+string(al_id_art))
dwc_riga.filter()

dwc_riga.Retrieve()
end subroutine

public subroutine wf_controlla_doppi (long al_riga_corrente);long ll_id_destinazione, ll_riga_trovata, ll_id_articolo

ll_id_destinazione=dw_single.getitemnumber(al_riga_corrente, "id_destinazione")
ll_id_articolo=dw_single.getitemnumber(al_riga_corrente, "id_articolo")

ll_riga_trovata=dw_single.find("id_destinazione="+string(ll_id_destinazione)+" and id_articolo="+string(ll_id_articolo), 1, dw_single.rowcount())
if ll_riga_trovata>0 and ll_riga_trovata<> al_riga_corrente then
	messagebox("Attenzione!", "Coppia articolo-destinazione già inserita alla riga n. "+string(ll_riga_trovata))
end if
end subroutine

public subroutine wf_riempi (string as_flag, long al_id, long al_row);string ls_codice

if as_flag='A' then
	select codice
	into :ls_codice
	from dba.articolo
	where id_articolo=:al_id
	;
	dw_single.setitem(al_row, "articolo_codice", ls_codice)
else
	select rag_soc_1
	into :ls_codice
	from dba.destinazione
	where id_destinazione=:al_id
	;
	dw_single.setitem(al_row, "destinazione_rag_soc_1", ls_codice)
end if
end subroutine

on w_art_destinazione_gd.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
this.cbx_riproponi_dest=create cbx_riproponi_dest
this.cbx_riproponi_articolo=create cbx_riproponi_articolo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
this.Control[iCurrent+2]=this.cbx_riproponi_dest
this.Control[iCurrent+3]=this.cbx_riproponi_articolo
end on

on w_art_destinazione_gd.destroy
call super::destroy
destroy(this.cb_stampa)
destroy(this.cbx_riproponi_dest)
destroy(this.cbx_riproponi_articolo)
end on

event resize;
end event

type p_msg_log from w_np_single_data`p_msg_log within w_art_destinazione_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_art_destinazione_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_art_destinazione_gd
end type

type dw_single from w_np_single_data`dw_single within w_art_destinazione_gd
integer x = 41
integer y = 132
integer width = 4978
integer height = 1784
integer taborder = 30
string dataobject = "d_art_destinazione_gd"
end type

event dw_single::itemchanged;integer li_ok

string ls_sql_cond,  ls_campo_filtro
string ls_dbc[], ls_dwc[], ls_dbv[]


choose case string(dwo.name)

	
//	CASE "sog_commerciale_codice", "anagrafica_rag_soc_1"
//			ls_sql_cond = ""
//			
//			ls_dbc[1] = "codice"
//			ls_dbc[2] = "rag_soc_1"
//			ls_dbc[3]= "id_sog_commerciale"
//			
//			ls_dwc[1] = "sog_commerciale_codice"
//			ls_dwc[2] = "anagrafica_rag_soc_1"
//			ls_dwc[3] = "immagini_cliente_id_sog_commerciale"
//			
//			if string(dwo.name)="sog_commerciale_codice" then
//				ls_campo_filtro="codice"
//			else
//				ls_campo_filtro="rag_soc_1"
//			end if
//			
//			li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", ls_campo_filtro, "A", data, ls_sql_cond, 3, &
//				ls_dbc, ls_dbv, ls_dwc)
//				
//			IF (li_ok > 0) THEN
//				RETURN 
//			else
//				
//			END IF
	CASE "id_articolo"
		wf_filtra_righe_distinta(long(data))
		post wf_controlla_doppi(row)
		post wf_riempi("A", long(data), row)
	case "id_destinazione"
		post wf_controlla_doppi(row)
		post wf_riempi("D", long(data), row)
//			ls_sql_cond = ""
//			
//			ls_dbc[1] = "codice"
//			ls_dbc[2] = "descrizione"
//			ls_dbc[3] = "id_articolo"
//			ls_dbc[4] = "immagine"
//			
//			ls_dwc[1] = "articolo_codice"
//			ls_dwc[2] = "articolo_descrizione"
//			ls_dwc[3] = "immagini_cliente_id_articolo"
//			ls_dwc[4] = "articolo_immagine"
//			
//			li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 4, &
//				ls_dbc, ls_dbv, ls_dwc)
//				
//			
//			// if cbx_automatico.checked then 	post wf_nome_imm_automatico(row)
//			IF (li_ok > 0) THEN
//				RETURN 2
//			else
//				
//			END IF
//			wf_filtra_righe_distinta(long(is_ricpar.s_id_seg_value[1]))
end choose
end event

event dw_single::ue_insert;long ll_riga, ll_id_sog, ll_id_articolo
string ls_codice, ls_rag_soc, ls_articolo, ls_des_articolo, ls_immagine

ll_riga=insertrow(0)
scrolltorow(ll_riga)

if ll_riga>1 then
	if cbx_riproponi_dest.checked then
		
		ll_id_sog=dw_single.getitemnumber(ll_riga - 1, "id_destinazione")
		dw_single.setitem(ll_riga,  "id_destinazione", ll_id_sog)
		setcolumn("id_articolo")
	end if
	if	cbx_riproponi_articolo.checked then
		ll_id_articolo=dw_single.getitemnumber(ll_riga - 1, "id_articolo")
		dw_single.setitem(ll_riga,  "id_articolo", ll_id_articolo)
		setcolumn("id_destinazione")
	end if
	
	scrolltorow(ll_riga)
end if
post setcolumn("id_articolo")

end event

event dw_single::rowfocuschanged;setrowfocusindicator(hand!)


end event

event dw_single::ue_set_search;call super::ue_set_search;if as_nomecol= "sog_commerciale_codice" or as_nomecol = "anagrafica_rag_soc_1" then
	is_search_window = "w_sog_commerciale_gen_coddes_sw"
	IF as_nomecol = "sog_commerciale_codice" THEN
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	ELSEIF as_nomecol = "anagrafica_rag_soc_1" THEN
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
	END IF
end if
if as_nomecol= "articolo_codice" then
	is_search_window = "w_articolo_coddes_sw"
	is_ricpar.s_filter_value = as_valcol
	is_ricpar.s_filter_name = "articolo_codice"
end if
	
end event

event dw_single::ue_use_search;string ls_imm

if as_nomecol="sog_commerciale_codice" then
	uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	uf_set_colval("immagini_cliente_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
	uf_set_colval("anagrafica_rag_soc_1", is_ricpar.s_ausil_value[1])
elseif 	as_nomecol="anagrafica_rag_soc_1" then
	uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	uf_set_colval("immagini_cliente_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
	uf_set_colval("sog_commerciale_codice", is_ricpar.s_ausil_value[1])
end if  

if as_nomecol="articolo_codice" then
	uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	uf_set_colval("immagini_cliente_id_articolo", is_ricpar.s_id_seg_value[1])
	uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
	select immagine
	into :ls_imm
	from articolo
	where id_articolo=:is_ricpar.s_id_seg_value[1];
	uf_set_colval("articolo_immagine", ls_imm)
	wf_filtra_righe_distinta(long(is_ricpar.s_id_seg_value[1]))
	
	//if cbx_automatico.checked then 	post wf_nome_imm_automatico(getrow())
end if
end event

event dw_single::doubleclicked;call super::doubleclicked;if dwo.name='id_articolo_t' then
	dw_single.setsort("articolo_codice")
elseif dwo.name='id_destinazione_t' then
	dw_single.setsort("destinazione_rag_soc_1")
end if
dw_single.sort()
end event

type cb_stampa from commandbutton within w_art_destinazione_gd
integer x = 46
integer y = 12
integer width = 247
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;datastore ds_stampa

dw_single.triggerevent("ue_update")

//ds_stampa=create datastore
//ds_stampa.dataobject="d_immagini_cliente_rpt"
//dw_single.rowscopy(1, dw_single.rowcount(), primary!, ds_stampa, 1, primary!)
printsetup()
//ds_stampa.sort()
//ds_stampa.print()
//destroy (ds_stampa)
dw_single.print()

end event

type cbx_riproponi_dest from checkbox within w_art_destinazione_gd
integer x = 2254
integer y = 28
integer width = 622
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
string text = "Riproponi destinazione"
boolean lefttext = true
end type

type cbx_riproponi_articolo from checkbox within w_art_destinazione_gd
integer x = 2958
integer y = 28
integer width = 498
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
string text = "Riproponi articolo"
boolean lefttext = true
end type

