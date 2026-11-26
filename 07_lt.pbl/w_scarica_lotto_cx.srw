forward
global type w_scarica_lotto_cx from w_wiz_main
end type
type dw_scarica_lotto_ff from u_dw_pura within w_scarica_lotto_cx
end type
type dw_scarica_lotto_gd from u_dw_pura within w_scarica_lotto_cx
end type
type cb_ok from commandbutton within w_scarica_lotto_cx
end type
type cb_annulla from commandbutton within w_scarica_lotto_cx
end type
end forward

global type w_scarica_lotto_cx from w_wiz_main
int Width=3118
int Height=1360
WindowType WindowType=response!
boolean TitleBar=true
string Title="Scelta Lotto Materia Prima da scaricare"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_scarica_lotto_ff dw_scarica_lotto_ff
dw_scarica_lotto_gd dw_scarica_lotto_gd
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_scarica_lotto_cx w_scarica_lotto_cx

type variables
s_scar_lotto 	is_scar_lotto
boolean		 ib_close_return = false
end variables

on w_scarica_lotto_cx.create
int iCurrent
call super::create
this.dw_scarica_lotto_ff=create dw_scarica_lotto_ff
this.dw_scarica_lotto_gd=create dw_scarica_lotto_gd
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scarica_lotto_ff
this.Control[iCurrent+2]=this.dw_scarica_lotto_gd
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_annulla
end on

on w_scarica_lotto_cx.destroy
call super::destroy
destroy(this.dw_scarica_lotto_ff)
destroy(this.dw_scarica_lotto_gd)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;s_list_main 	lstr_for_win
long				ll_articolo, ll_row
decimal			ld_peso_netto, ld_quantita
string			ls_tipo



lstr_for_win = Message.PowerObjectParm
if Upperbound(lstr_for_win.s_identifica)=0 then close(this)

ll_articolo = lstr_for_win.l_identifica[1]
ld_quantita = dec(lstr_for_win.s_par_value[1])
ld_peso_netto = dec(lstr_for_win.s_par_value[2])

if (ll_articolo > 0) then 
	dw_scarica_lotto_ff.settransobject(sqlca)
	dw_scarica_lotto_ff.retrieve(ll_articolo)
end if
ll_row = dw_scarica_lotto_ff.getrow()
if ll_row <= 0 then close(this)

ls_tipo = dw_scarica_lotto_ff.getitemstring(ll_row, "unita_misura_tipo")

if (ls_tipo = 'P') then
	dw_scarica_lotto_ff.setitem(ll_row, "val_da_scaricare", ld_peso_netto)
else
	dw_scarica_lotto_ff.setitem(ll_row, "val_da_scaricare", ld_quantita)
end if
dw_scarica_lotto_gd.settransobject(sqlca)
dw_scarica_lotto_gd.retrieve(ll_articolo)
end event

event closequery;
message.powerobjectparm=is_scar_lotto
end event

type dw_scarica_lotto_ff from u_dw_pura within w_scarica_lotto_cx
int X=32
int Y=128
int Width=3045
int Height=304
int TabOrder=10
boolean BringToTop=true
string DataObject="d_scarica_lotto_ff"
end type

type dw_scarica_lotto_gd from u_dw_pura within w_scarica_lotto_cx
event ue_modify ( )
int X=32
int Y=460
int Width=3045
int Height=792
int TabOrder=30
boolean BringToTop=true
string DataObject="d_scarica_lotto_gd"
boolean VScrollBar=true
end type

event clicked;
boolean lb_result
decimal ld_val_sca, 	ld_val_sel, ld_val_row
string  ls_tipo
long	  li_i, ll_rows

if (row <= 0) then return

ls_tipo 		= dw_scarica_lotto_ff.getitemstring(1, "unita_misura_tipo")
ld_val_sca 	= dw_scarica_lotto_ff.getitemnumber(1, "val_da_scaricare")
ld_val_sel	= dw_scarica_lotto_ff.getitemnumber(1, "val_selezionato")

if ls_tipo = 'P' then
	ld_val_row = this.getitemnumber(row, "peso_rimasto")
else
	ld_val_row = this.getitemnumber(row, "qta_rimasta")
end if

if (row <= 0) then return
lb_result = this.isselected(row)
if lb_result = TRUE then
	
	this.selectrow(row, FALSE)		
	ld_val_row = this.getitemnumber(row, "val_sel")
	ld_val_sel = ld_val_sel - ld_val_row
	dw_scarica_lotto_ff.setitem(1, "val_selezionato", ld_val_sel)
	this.setitem(row, "val_sel", 0)
else
	
	ll_rows = this.rowcount()
	if ll_rows > 0 then
		for li_i = 1 to ll_rows
			if (li_i <> row and this.isselected(li_i)=TRUE) then 
				this.selectrow(li_i, FALSE)		
				ld_val_row = this.getitemnumber(li_i, "val_sel")
				ld_val_sel = ld_val_sel - ld_val_row
				this.setitem(li_i, "val_sel", 0)				
			end if
		next
	end if
	dw_scarica_lotto_ff.setitem(1, "val_selezionato", 0)	
	
	
	this.selectrow(row, TRUE)		
	if (ld_val_sel + ld_val_row > ld_val_sca) then 
		ld_val_row = ld_val_sca   - ld_val_sel
	end if
	ld_val_sel = ld_val_sel + ld_val_row
	setitem(row, "val_sel", ld_val_row)
	
	dw_scarica_lotto_ff.setitem(1, "val_selezionato", ld_val_sel)
	

end if
end event

event sqlpreview;
string   ls_tipo
string	ls_sqlsyntax
integer  li_row

li_row  = dw_scarica_lotto_ff.getrow()
ls_tipo = dw_scarica_lotto_ff.getitemstring(li_row, "unita_misura_tipo")

ls_sqlsyntax = sqlsyntax

if (ls_tipo = 'P') then
	ls_sqlsyntax = ls_sqlsyntax + " AND (peso_netto_iniziale - IFNULL(peso_netto_scaricato, 0, peso_netto_scaricato)) > 0 "
else
	ls_sqlsyntax = ls_sqlsyntax + " AND (qta_iniziale - IFNULL(qta_scaricata, 0, qta_scaricata)) > 0 "
end if

setsqlpreview(ls_sqlsyntax)
end event

type cb_ok from commandbutton within w_scarica_lotto_cx
int X=219
int Y=32
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

integer 	li_rows   	
integer	li_i		 	
integer	li_j=0		

li_rows = dw_scarica_lotto_gd.rowcount()

is_scar_lotto.tipo_mov = dw_scarica_lotto_ff.getitemstring(1, "unita_misura_tipo")

for li_i = 1 to li_rows
	if dw_scarica_lotto_gd.isselected(li_i) = TRUE then
		li_j++
		is_scar_lotto.id_lotto[li_j] = dw_scarica_lotto_gd.getitemnumber(li_i, "id_lotto")
		is_scar_lotto.val_da_sca[li_j] = dw_scarica_lotto_gd.getitemnumber(li_i, "val_sel")		
	end if
next
Close(parent)
end event

type cb_annulla from commandbutton within w_scarica_lotto_cx
int X=512
int Y=32
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
Close(parent)

end event

