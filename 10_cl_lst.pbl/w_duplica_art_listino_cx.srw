forward
global type w_duplica_art_listino_cx from w_semplice_gd
end type
type dw_2 from udw_base within w_duplica_art_listino_cx
end type
end forward

global type w_duplica_art_listino_cx from w_semplice_gd
integer width = 5280
integer height = 2052
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_2 dw_2
end type
global w_duplica_art_listino_cx w_duplica_art_listino_cx

forward prototypes
public subroutine wf_post (long al_riga)
end prototypes

public subroutine wf_post (long al_riga);//

dw_1.post setcolumn("articolo_codice")
end subroutine

on w_duplica_art_listino_cx.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_duplica_art_listino_cx.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;s_dw_ritorna s_ds

dw_1.settransobject(sqlca)
s_ds=message.powerobjectparm
s_ds.ds.rowscopy(1, 1, primary!, dw_1, 1, Primary!)
dw_1.setitemstatus(1, 0, Primary!, notModified!)

dw_2.settransobject(sqlca)



end event

type cb_stampa from w_semplice_gd`cb_stampa within w_duplica_art_listino_cx
integer x = 905
integer y = 1784
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_duplica_art_listino_cx
integer x = 1435
integer y = 1784
end type

type cb_primo from w_semplice_gd`cb_primo within w_duplica_art_listino_cx
integer x = 974
integer y = 1652
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_duplica_art_listino_cx
integer x = 1390
integer y = 1652
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_duplica_art_listino_cx
integer x = 1134
integer y = 1652
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_duplica_art_listino_cx
integer x = 1262
integer y = 1652
end type

type dw_1 from w_semplice_gd`dw_1 within w_duplica_art_listino_cx
integer width = 4736
integer height = 1280
string dataobject = "d_duplica_art_listino_silver"
end type

event dw_1::rbuttondown;call super::rbuttondown;long  ll_null

setnull(ll_null)

rowscopy(row, row, primary!, dw_1, dw_1.rowcount()+1, Primary!)
setitem(row+1, "prezzo_id_unita_confezione", ll_null)
setitem(row+1, "id_articolo", ll_null)
//setitem(row+1, "articolo_codice", "")

post scrolltorow(row+1)
post setcolumn(13)
//post wf_post(row+1)



end event

event dw_1::itemchanged;call super::itemchanged;string ls_new_codice
long ll_id_old_art, ll_null, ll_id_uc, ll_id_new_art
integer li_ret

setnull(ll_null)

if dwo.name="articolo_codice" and row>1 then
	ls_new_codice=data
	ll_id_old_art=getitemnumber(row - 1, "id_articolo")
	dw_2.reset()
	dw_2.retrieve(ll_id_old_art)
	dw_2.setitem(1, "codice", ls_new_codice)
	dw_2.setitem(1, "id_articolo", ll_null)
	dw_2.setitemstatus(1, 0, Primary!, NewModified!)
	li_ret=dw_2.update()
	if li_ret=1 then
		ll_id_new_art=dw_2.getitemnumber(1, "id_articolo")
		setitem(row, "id_articolo", ll_id_new_art)
		ll_id_uc=0
		select id_unita_confezione
		into :ll_id_uc
		from dba.unita_confezione
		where id_articolo=:ll_id_new_art
		and unita_base='S'
		;
		if ll_id_uc>0 then
			setitem(row, "prezzo_id_unita_confezione", ll_id_uc)
			
		end if
	end if
end if
	
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_duplica_art_listino_cx
integer x = 55
integer y = 1636
end type

type cb_salva from w_semplice_gd`cb_salva within w_duplica_art_listino_cx
integer x = 338
integer y = 1636
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_duplica_art_listino_cx
integer x = 626
integer y = 1636
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_duplica_art_listino_cx
integer x = 1728
integer y = 1640
end type

type cb_ok from w_semplice_gd`cb_ok within w_duplica_art_listino_cx
integer x = 2021
integer y = 1640
end type

type dw_2 from udw_base within w_duplica_art_listino_cx
boolean visible = false
integer x = 1934
integer y = 1420
integer width = 3191
integer height = 280
integer taborder = 50
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

