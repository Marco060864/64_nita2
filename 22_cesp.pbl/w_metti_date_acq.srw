forward
global type w_metti_date_acq from w_p_data
end type
type dw_1 from u_dw_main within w_metti_date_acq
end type
type dw_2 from u_dw_main within w_metti_date_acq
end type
type cb_1 from commandbutton within w_metti_date_acq
end type
type cb_2 from commandbutton within w_metti_date_acq
end type
end forward

global type w_metti_date_acq from w_p_data
integer width = 3301
integer height = 2108
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
end type
global w_metti_date_acq w_metti_date_acq

on w_metti_date_acq.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_metti_date_acq.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.retrieve()
end event

event ue_post_open;//
end event

event closequery;//
end event

type p_msg_log from w_p_data`p_msg_log within w_metti_date_acq
end type

type p_crescente from w_p_data`p_crescente within w_metti_date_acq
end type

type p_decrescente from w_p_data`p_decrescente within w_metti_date_acq
end type

type cb_ok from w_p_data`cb_ok within w_metti_date_acq
end type

type cb_annulla from w_p_data`cb_annulla within w_metti_date_acq
end type

type cb_nuovo from w_p_data`cb_nuovo within w_metti_date_acq
end type

type cb_inserisci from w_p_data`cb_inserisci within w_metti_date_acq
end type

type cb_cancella from w_p_data`cb_cancella within w_metti_date_acq
end type

type cb_salva from w_p_data`cb_salva within w_metti_date_acq
end type

event cb_salva::clicked;if dw_2.update()=1 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "Salvataggio non riuscito!")
end if
end event

type tab_1 from w_p_data`tab_1 within w_metti_date_acq
integer x = 2199
integer y = 1780
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
boolean visible = false
end type

type cb_ricerca from w_p_data`cb_ricerca within w_metti_date_acq
end type

type dw_1 from u_dw_main within w_metti_date_acq
integer x = 64
integer y = 164
integer width = 2990
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_metti_date_acquisto"
end type

type dw_2 from u_dw_main within w_metti_date_acq
integer x = 64
integer y = 1004
integer width = 2990
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_metti_date_acquisto"
end type

type cb_1 from commandbutton within w_metti_date_acq
integer x = 512
integer y = 1820
integer width = 357
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica da TXT"
end type

event clicked;integer i=0
string null_str

SetNull(null_str)



i=dw_1.ImportFile(null_str)
//i=dw_1.ImportFile("C:\DATI\date_acq.csv")

end event

type cb_2 from commandbutton within w_metti_date_acq
integer x = 1083
integer y = 1820
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;date ldt_data
string ls_data
integer i
long ll_id_cespite, ll_riga_trovata

for i=1 to dw_1.rowcount()
	ls_data=dw_1.getitemstring(i, "matricola")
	ldt_data=date(right(ls_data, 8))
	if ldt_data>date('1900-01-01') then
		ll_id_cespite=dw_1.getitemnumber(i, "id_cespite")
		ll_riga_trovata=dw_2.find("id_cespite="+string(ll_id_cespite), 1, dw_2.rowcount())
		if ll_riga_trovata>0  then
			dw_2.setitem(ll_riga_trovata, "data_inizio_utilizzo", ldt_data)
			dw_2.setitem(ll_riga_trovata, "data_inizio_amm", ldt_data)
		end if
	end if
next
end event

