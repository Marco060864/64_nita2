forward
global type w_acconto_agente_gd from w_001
end type
type cb_salva from commandbutton within w_acconto_agente_gd
end type
type cb_inserisci from commandbutton within w_acconto_agente_gd
end type
type dw_1 from udw_base within w_acconto_agente_gd
end type
type cb_1 from commandbutton within w_acconto_agente_gd
end type
type cb_2 from commandbutton within w_acconto_agente_gd
end type
type cb_stampa from commandbutton within w_acconto_agente_gd
end type
end forward

global type w_acconto_agente_gd from w_001
integer width = 3529
integer height = 1080
boolean minbox = true
windowtype windowtype = popup!
cb_salva cb_salva
cb_inserisci cb_inserisci
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_stampa cb_stampa
end type
global w_acconto_agente_gd w_acconto_agente_gd

type variables
s_param_articoli s_parametri
end variables

event open;call super::open;long ll_id_gruppo_agenti, ll_riga_periodo_attuale, ll_righe, ll_riga_periodo_precedente
date  ldt_fine_precedente, ldt_inizio_precedente

decimal ldc_prov_inc_precedente
integer li_mese, li_anno
datastore ds_prov



dw_1.settransobject(sqlca)

s_parametri=message.powerobjectparm



ldt_fine_precedente = relativedate(s_parametri.da_data, -1)

ll_righe=dw_1.retrieve(s_parametri.ll_magazzino, ldt_fine_precedente )

ll_riga_periodo_attuale=dw_1.find("data_riferimento = date("+ string(s_parametri.a_data, "yyyy-mm-dd")+")", 1, ll_righe)
if ll_riga_periodo_attuale>0 then
	if s_parametri.prov_incassato>0 then
		dw_1.setitem(ll_riga_periodo_attuale, "provv_incassato",s_parametri.prov_incassato)
	end if
	dw_1.setitem(ll_riga_periodo_attuale, "provvigioni",s_parametri.provvigione)
end if
//ll_riga_periodo_precedente=dw_1.find("data_riferimento = date("+ string(ldt_fine_precedente, "yyyy-mm-dd")+")", 1, ll_righe)
//if ll_riga_periodo_precedente>0 then
//	//trovo il periodo precedente per il quale calcolare provvigione
//	li_mese=month(ldt_inizio_precedente)
//	li_mese -= 2
//	li_anno=year(ldt_inizio_precedente)
//	if li_mese<=0 then
//		li_mese=12 - li_mese
//		li_anno -=1
//	end if
//	
//  ldt_inizio_precedente=date(string(li_anno, "0000")+"-"+string(li_mese, "00")+"-"+"01")
//  //con il periodo e l'id gruppo agente trovo provv incassato
//  ds_prov=create datastore
//  ds_prov.dataobject="ds_provv_rpt"
//  ds_prov.settransobject(sqlca)
//  ds_prov.retrieve(s_parametri.ll_magazzino, ldt_inizio_precedente, ldt_fine_precedente,ldt_inizio_precedente, ldt_fine_precedente)
//  ldc_prov_inc_precedente=ds_prov.getitemdecimal(1, "c_tot_prov_inc")
//  dw_1.setitem(ll_riga_periodo_precedente, "c_provv_incassato", ldc_prov_inc_precedente)
//  destroy ds_prov
//	end if
end event

on w_acconto_agente_gd.create
int iCurrent
call super::create
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva
this.Control[iCurrent+2]=this.cb_inserisci
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_stampa
end on

on w_acconto_agente_gd.destroy
call super::destroy
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_stampa)
end on

type st_1 from w_001`st_1 within w_acconto_agente_gd
end type

type cb_salva from commandbutton within w_acconto_agente_gd
integer x = 2386
integer y = 20
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_1.trigger event ue_update()
end event

type cb_inserisci from commandbutton within w_acconto_agente_gd
integer x = 1664
integer y = 20
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
string text = "Inserisci"
end type

event clicked;long ll_riga_inserita

ll_riga_inserita=dw_1.trigger event ue_insert(0)
if ll_riga_inserita>0 then
	dw_1.setitem(ll_riga_inserita, "id_gruppo_agenti", s_parametri.ll_magazzino)
	dw_1.setitem(ll_riga_inserita, "data_riferimento", s_parametri.a_data)
	if s_parametri.prov_incassato>0 then
		dw_1.setitem(ll_riga_inserita, "provv_incassato",s_parametri.prov_incassato)
	end if
	dw_1.setitem(ll_riga_inserita, "provvigioni",s_parametri.provvigione)
end if

end event

type dw_1 from udw_base within w_acconto_agente_gd
integer x = 41
integer y = 136
integer width = 3415
integer height = 816
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_acc_agente_gd"
end type

type cb_1 from commandbutton within w_acconto_agente_gd
integer x = 2025
integer y = 20
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
string text = "Cancella"
end type

event clicked;long ll_riga
ll_riga=dw_1.getrow()
if ll_riga>0 then
	dw_1.trigger event ue_delete(ll_riga)
end if
end event

type cb_2 from commandbutton within w_acconto_agente_gd
integer x = 3109
integer y = 20
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
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_acconto_agente_gd
integer x = 2747
integer y = 16
integer width = 343
integer height = 100
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

event clicked;long ll_riga_inserita

ll_riga_inserita=dw_1.rowcount()
if ll_riga_inserita>0 then
	printsetup()
	dw_1.print()
end if

end event

