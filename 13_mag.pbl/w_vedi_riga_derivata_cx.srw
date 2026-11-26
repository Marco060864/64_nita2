forward
global type w_vedi_riga_derivata_cx from w_001
end type
type dw_1 from udw_base within w_vedi_riga_derivata_cx
end type
type cb_1 from commandbutton within w_vedi_riga_derivata_cx
end type
type cb_annulla from commandbutton within w_vedi_riga_derivata_cx
end type
type st_doc from statictext within w_vedi_riga_derivata_cx
end type
type st_val_originali from statictext within w_vedi_riga_derivata_cx
end type
end forward

global type w_vedi_riga_derivata_cx from w_001
integer width = 3730
integer height = 944
string title = "Correggi riga di provenienza"
windowtype windowtype = response!
dw_1 dw_1
cb_1 cb_1
cb_annulla cb_annulla
st_doc st_doc
st_val_originali st_val_originali
end type
global w_vedi_riga_derivata_cx w_vedi_riga_derivata_cx

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

on w_vedi_riga_derivata_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_annulla=create cb_annulla
this.st_doc=create st_doc
this.st_val_originali=create st_val_originali
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.st_doc
this.Control[iCurrent+5]=this.st_val_originali
end on

on w_vedi_riga_derivata_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_annulla)
destroy(this.st_doc)
destroy(this.st_val_originali)
end on

event open;call super::open;
long ll_riga, ll_id_riga
long ll_num_prog
string ls_num_doc, ls_val_nel_derivato
date ldt_data_reg, ldt_data_doc

ll_id_riga=message.doubleparm

//select num_progressivo, num_documento, data_registrazione, data_documento
//into :ll_num_prog, :ls_num_doc, :ldt_data_reg, :ldt_data_doc
//from documento d, riga_documento r
//where r.id_documento=d.id_documento
//and r.id_riga_doc_provenienza=:ll_id_riga
//;

dw_1.settransobject(sqlca)
ll_riga=dw_1.retrieve(ll_id_riga)
//if ll_riga>0 then
////	st_doc.text="Doc. Num. Prog. "+string(ll_num_prog)+ " del "+string(ldt_data_reg)+&
////					" - Num. Doc. "+ls_num_doc+" del "+string(ldt_data_doc)
//	if ll_riga=1 then
//		//prendo i valori nel doc derivato di peso. fino e calo a memoria e li pubblico
//		//in un text
//		ls_val_nel_derivato="LEGATO: "+string(dw_1.getitemdecimal(ll_riga, "riga_documento_peso_netto"))
//		ls_val_nel_derivato+=" - FINO: "+string(dw_1.getitemdecimal(ll_riga, "fino"))
//		ls_val_nel_derivato+=" - CALO: "+string(dw_1.getitemdecimal(ll_riga, "calo"))
//		ls_val_nel_derivato+=" - F+C: "+string(dw_1.getitemdecimal(ll_riga, "fino")+dw_1.getitemdecimal(ll_riga, "calo"))
//		st_val_originali.text=ls_val_nel_derivato
//	end if
//else
if isnull(ll_riga) or ll_riga<=0 then
	close(this)
end if

end event

type st_1 from w_001`st_1 within w_vedi_riga_derivata_cx
end type

type dw_1 from udw_base within w_vedi_riga_derivata_cx
integer y = 128
integer width = 3686
integer height = 538
boolean bringtotop = true
string dataobject = "d_vedi_riga_derivata"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;decimal ldc_coef_calo


choose case string(dwo.name)
	case "quantita"
		setitem(row, "qta_un_base", dec(data))
		
	case "riga_documento_peso_netto"
		ldc_coef_calo=getitemdecimal(row, "coef_calo")
		wf_setta_fino_calo(row, dec(data), ldc_coef_calo)
		
end choose

end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row>0  then 
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	ll_id_doc=getitemnumber(row, "documento_id_documento")
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if
end event

type cb_1 from commandbutton within w_vedi_riga_derivata_cx
boolean visible = false
integer x = 73
integer y = 704
integer width = 344
integer height = 99
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

event clicked;dw_1.accepttext()
dw_1.triggerevent("ue_update")
close(parent)
end event

type cb_annulla from commandbutton within w_vedi_riga_derivata_cx
integer x = 3277
integer y = 691
integer width = 344
integer height = 99
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type st_doc from statictext within w_vedi_riga_derivata_cx
integer x = 33
integer y = 29
integer width = 2725
integer height = 77
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

type st_val_originali from statictext within w_vedi_riga_derivata_cx
integer x = 1170
integer y = 714
integer width = 1777
integer height = 131
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

