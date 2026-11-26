forward
global type w_ges_articoli_b from w_semplice_gd
end type
end forward

global type w_ges_articoli_b from w_semplice_gd
integer width = 4914
integer height = 2712
end type
global w_ges_articoli_b w_ges_articoli_b

on w_ges_articoli_b.create
call super::create
end on

on w_ges_articoli_b.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_ges_articoli_b
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_ges_articoli_b
end type

type cb_primo from w_semplice_gd`cb_primo within w_ges_articoli_b
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_ges_articoli_b
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_ges_articoli_b
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_ges_articoli_b
end type

type dw_1 from w_semplice_gd`dw_1 within w_ges_articoli_b
integer width = 4805
string dataobject = "d_ges_articoli_b"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindowchild dwc_cartellino
integer li_ret
string ls_cod_art, ls_azienda
long ll_riga_trovata,ll_id_cat_merc

select rag_soc_1 into :ls_azienda from dba.azienda;
if pos(upper(ls_azienda), "BUCCI" )>0 then

	if dwo.name="id_cat_merceologica" then //campo cartellino
		li_ret=getchild("cartellino", dwc_cartellino)
		CONNECT USING SQLCA;
		// Set the transaction object for the 
		dwc_cartellino.SetTransObject(SQLCA)  
		// Populate with values for eastern 
		ls_cod_art=getitemstring(row, "articolo_codice")
		dwc_cartellino.Retrieve()
		ll_riga_trovata=dwc_cartellino.find("articolo_codice= '"+ls_cod_art+"'", 1, 1000000)
		if ll_riga_trovata>0 then
			ll_id_cat_merc=dwc_cartellino.getitemnumber(ll_riga_trovata, "id_cat_merceologica")
			setitem(row, "id_cat_merceologica",ll_id_cat_merc)
		end if
	end if
end if
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_ges_articoli_b
end type

type cb_salva from w_semplice_gd`cb_salva within w_ges_articoli_b
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_ges_articoli_b
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_ges_articoli_b
end type

type cb_ok from w_semplice_gd`cb_ok within w_ges_articoli_b
end type

