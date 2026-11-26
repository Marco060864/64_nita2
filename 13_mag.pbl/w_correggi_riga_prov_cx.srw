forward
global type w_correggi_riga_prov_cx from w_001
end type
type dw_1 from udw_base within w_correggi_riga_prov_cx
end type
type cb_1 from commandbutton within w_correggi_riga_prov_cx
end type
type cb_annulla from commandbutton within w_correggi_riga_prov_cx
end type
type st_doc from statictext within w_correggi_riga_prov_cx
end type
type st_val_originali from statictext within w_correggi_riga_prov_cx
end type
type st_num_bollettina from statictext within w_correggi_riga_prov_cx
end type
end forward

global type w_correggi_riga_prov_cx from w_001
integer width = 3730
integer height = 944
string title = "Correggi riga di provenienza"
windowtype windowtype = response!
dw_1 dw_1
cb_1 cb_1
cb_annulla cb_annulla
st_doc st_doc
st_val_originali st_val_originali
st_num_bollettina st_num_bollettina
end type
global w_correggi_riga_prov_cx w_correggi_riga_prov_cx

type variables

string is_search_window
boolean ib_during_f4=false
end variables

forward prototypes
public subroutine wf_setta_fino_calo (integer row, decimal ad_peso, decimal ad_coef_calo)
public function decimal wf_converti_in_fino (decimal ad_qta_legato, long al_id_titolo)
end prototypes

public subroutine wf_setta_fino_calo (integer row, decimal ad_peso, decimal ad_coef_calo);decimal{2} ld_fino, ld_coef_calo, ld_peso_non_prezioso, ld_calo
		long ll_id_titolo
		integer li_ret
		
		ll_id_titolo=dw_1.getitemnumber(row, "id_titolo")
		ld_peso_non_prezioso=dw_1.getitemdecimal(row, "peso_non_prezioso")
		if isnull(ld_peso_non_prezioso) then ld_peso_non_prezioso=0
		ad_peso=ad_peso - ld_peso_non_prezioso
		
		
			
		ld_fino=wf_converti_in_fino(ad_peso, ll_id_titolo)
		li_ret=dw_1.setitem(row, "fino", ld_fino)
		if li_ret<>1 then messagebox("Errore!", "Fino non settato")
		
		if ad_coef_calo>=0 and not isnull(ad_coef_calo) then
			ld_coef_calo=ad_coef_calo 
		else
			ld_coef_calo=dw_1.getitemdecimal(row, "coef_calo")
		end if
		if ld_coef_calo>0 and not isnull(ld_coef_calo) then
				ld_calo=f_round(ad_peso*(ld_coef_calo)/1000, -2, 'M')
				ld_calo= f_round(ld_calo - ld_fino, -2, 'M')
				li_ret=dw_1.setitem(row, "calo",ld_calo) 
				if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
		elseif ld_coef_calo=0 then 
			
			
			
			li_ret=dw_1.setitem(row, "calo",0)
				if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
		else
				

		end if
		
end subroutine

public function decimal wf_converti_in_fino (decimal ad_qta_legato, long al_id_titolo);
decimal{4} ld_fino, ld_titolo
if al_id_titolo=0 then return 0
select titolo
into :ld_titolo
from orafo_titolo
where id_titolo=:al_id_titolo;
if ld_titolo>0 then
	ld_fino=f_round(ad_qta_legato*ld_titolo/1000, -2, 'M')
else
	ld_fino=0
	if isnull(al_id_titolo) then 
		al_id_titolo=0
		
	end if
end if
return ld_fino
end function

on w_correggi_riga_prov_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_annulla=create cb_annulla
this.st_doc=create st_doc
this.st_val_originali=create st_val_originali
this.st_num_bollettina=create st_num_bollettina
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.st_doc
this.Control[iCurrent+5]=this.st_val_originali
this.Control[iCurrent+6]=this.st_num_bollettina
end on

on w_correggi_riga_prov_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_annulla)
destroy(this.st_doc)
destroy(this.st_val_originali)
destroy(this.st_num_bollettina)
end on

event open;call super::open;s_correggi_provenienza s_cor
long ll_riga, ll_id_riga_bollettina
long ll_num_prog
string ls_num_doc, ls_val_originali, ls_num_bollettina
date ldt_data_reg, ldt_data_doc

s_cor=message.powerobjectparm

select num_progressivo, num_documento, data_registrazione, data_documento
into :ll_num_prog, :ls_num_doc, :ldt_data_reg, :ldt_data_doc
from documento d, riga_documento r
where r.id_documento=d.id_documento
and r.id_riga_documento=:s_cor.l_id_riga_provenienza
;

dw_1.settransobject(sqlca)
ll_riga=dw_1.retrieve(s_cor.l_id_riga_provenienza)
st_doc.text="Doc. Num. Prog. "+string(ll_num_prog)+ " del "+string(ldt_data_reg)+&
					" - Num. Doc. "+ls_num_doc+" del "+string(ldt_data_doc)
if ll_riga=1 then
	//prendo i valori orignali di peso. fino e calo a memoria e li pubblico
	//in un text
	ls_val_originali="LEGATO: "+string(dw_1.getitemdecimal(ll_riga, "riga_documento_peso_netto"))
	ls_val_originali+=" - FINO: "+string(dw_1.getitemdecimal(ll_riga, "fino"))
	ls_val_originali+=" - CALO: "+string(dw_1.getitemdecimal(ll_riga, "calo"))
	ls_val_originali+=" - F+C: "+string(dw_1.getitemdecimal(ll_riga, "fino")+dw_1.getitemdecimal(ll_riga, "calo"))
	st_val_originali.text=ls_val_originali
	if s_cor.s_campo='quantita' then
		dw_1.setitem(ll_riga, "quantita", s_cor.dc_qta_peso)
		dw_1.post event itemchanged(ll_riga, dw_1.object.quantita , string(s_cor.dc_qta_peso))
	else
		dw_1.setitem(ll_riga, "riga_documento_peso_netto", s_cor.dc_qta_peso)
		dw_1.post event itemchanged(ll_riga, dw_1.object.riga_documento_peso_netto , string(s_cor.dc_qta_peso))
	
	end if
	ll_id_riga_bollettina=dw_1.getitemdecimal(ll_riga, "id_riga_doc_provenienza")
	select num_documento
	into :ls_num_bollettina
	from dba.documento d, dba.riga_documento r
	where r.id_riga_documento=:ll_id_riga_bollettina
	and r.id_documento=d.id_documento
	;
	if ls_num_bollettina> " " then st_num_bollettina.text="Bollettina N. "+ls_num_bollettina
		
else
	messagebox("Attenzione!", "La riga modificata ha più di una riga madre! Modificare "+&
				" peso o pezzi manualmente")		
end if
	

end event

type st_1 from w_001`st_1 within w_correggi_riga_prov_cx
end type

type dw_1 from udw_base within w_correggi_riga_prov_cx
integer x = 27
integer y = 128
integer width = 3648
integer height = 556
boolean bringtotop = true
string dataobject = "d_correggi_riga_prov_gd"
end type

event itemchanged;call super::itemchanged;decimal ldc_coef_calo


choose case string(dwo.name)
	case "quantita"
		setitem(row, "qta_un_base", dec(data))
		
	case "riga_documento_peso_netto"
		ldc_coef_calo=getitemdecimal(row, "coef_calo")
		wf_setta_fino_calo(row, dec(data), ldc_coef_calo)
		case "coef_calo"
			ldc_coef_calo=getitemdecimal(row, "riga_documento_peso_netto")
			wf_setta_fino_calo(row,  ldc_coef_calo, dec(data))
end choose

end event

event clicked;call super::clicked;string ls_nome_oggetto, ls_tipo_oggetto, ls_cod_articolo
w_search_main lw_sm
long ll_id_articolo, ll_id_unita_conf
decimal ldc_conv_peso, ldc_conv_volume
s_RIC_PARAM is_ricpar

ls_nome_oggetto = dwo.name
ls_tipo_oggetto = dwo.type
if ((ls_tipo_oggetto="bitmap") and (ls_nome_oggetto="c_articolo_cod_sw")) then
	ls_cod_articolo=getitemstring(row, "c_articolo_cod")
	is_ricpar.s_filter_value = trim(ls_cod_articolo) 
	is_ricpar.l_id_doc=getitemnumber(row, "id_documento")
	is_search_window = "w_articolo_coddes_documento_sw" 
	is_ricpar.s_filter_name = "articolo_codice" 

	
	is_ricpar.b_asneeded=TRUE

	ib_during_f4 = true
	OpenWithParm (lw_sm,is_ricpar,is_search_window)
	ib_during_f4 = false
	is_ricpar=message.powerobjectparm
//messagebox("(" , is_ricpar.s_main_value)
				//select per recuperare tutti i valori di sotto 
				
				select a.id_articolo, a.descrizione, a.stato, 
				m1.simbolo, m1.descrizione,
				m2.simbolo, m2.descrizione,
				m1.conversione, m2.conversione,
				u.id_unita_confezione
							
				into :ll_id_articolo, :is_ricpar.s_ausil_value[1],:is_ricpar.s_ausil_value[2],
						:is_ricpar.s_ausil_value[3],:is_ricpar.s_ausil_value[4],
						:is_ricpar.s_ausil_value[5], :is_ricpar.s_ausil_value[6],
						:ldc_conv_peso, :ldc_conv_volume,
						:ll_id_unita_conf
				
				
				from dba.articolo a, dba.unita_confezione u, unita_misura m1, unita_misura m2
				where a.codice=:is_ricpar.s_main_value
				and a.id_articolo=u.id_articolo
				and u.unita_base='S'
				and u.id_unita_misura=m1.id_unita_misura
				and u.id_unita_mis_volume=m2.id_unita_misura;
				is_ricpar.s_id_seg_value[1]=string(ll_id_articolo)
				is_ricpar.s_ausil_value[7]=string(ldc_conv_peso)
				is_ricpar.s_ausil_value[8]=string(ldc_conv_volume)
				is_ricpar.s_ausil_value[9]=string(ll_id_unita_conf)
		
			ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
			
		
		setitem(row, "c_articolo_cod", is_ricpar.s_main_value)
		setitem(row, "riga_documento_id_articolo", ll_id_articolo)
		setitem(row, "riga_documento_descrizione", is_ricpar.s_ausil_value[1])
		setitem(row, "c_articolo_des", is_ricpar.s_ausil_value[1])
		setitem(row, "articolo_stato", is_ricpar.s_ausil_value[2])
		setitem(row, "usimbolo", is_ricpar.s_ausil_value[3])
		setitem(row, "udescrizione", is_ricpar.s_ausil_value[4])
		setitem(row, "unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
		setitem(row, "unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
		setitem(row, "conversione_peso_comune", dec(is_ricpar.s_ausil_value[7]))
		setitem(row, "conversione_volume_comune", dec(is_ricpar.s_ausil_value[8]))
		setitem(row, "riga_documento_id_unita_confezione", long(is_ricpar.s_ausil_value[9]))
		

end if
end event

type cb_1 from commandbutton within w_correggi_riga_prov_cx
integer x = 73
integer y = 704
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;string ls_cod_art
dw_1.accepttext()
dw_1.triggerevent("ue_update")
ls_cod_art=dw_1.getitemstring(1, "c_articolo_cod")
closewithreturn(parent, ls_cod_art)
end event

type cb_annulla from commandbutton within w_correggi_riga_prov_cx
integer x = 567
integer y = 704
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
string text = "Annulla"
end type

event clicked;close(parent)
end event

type st_doc from statictext within w_correggi_riga_prov_cx
integer x = 32
integer y = 28
integer width = 2725
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_val_originali from statictext within w_correggi_riga_prov_cx
integer x = 1170
integer y = 716
integer width = 1778
integer height = 132
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_num_bollettina from statictext within w_correggi_riga_prov_cx
integer x = 2779
integer y = 28
integer width = 878
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

