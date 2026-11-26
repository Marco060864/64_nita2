forward
global type w_cod_parte_ff from w_p_data
end type
type dw_cod_parte_ff from u_dw_master_main within tabpage_1
end type
type dw_cod_parte_ff from u_dw_master_main within tabpage_1
end type
type tabpage_scelta_parte from userobject within tab_1
end type
type dw_scelta_parte_gd from u_dw_master_main within tabpage_scelta_parte
end type
type tabpage_scelta_parte from userobject within tab_1
dw_scelta_parte_gd dw_scelta_parte_gd
end type
end forward

global type w_cod_parte_ff from w_p_data
int Height=1105
boolean TitleBar=true
string Title="Parametri della sezione del Codice"
end type
global w_cod_parte_ff w_cod_parte_ff

type variables
String 	is_maschera
end variables

event open;call super::open;il_helpTopic = 106
idw_master = tab_1.tabpage_1.dw_cod_parte_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "cod_parte.id_cod_parte"
end event

on w_cod_parte_ff.create
int iCurrent
call w_p_data::create
iCurrent=UpperBound(this.Control)
end on

on w_cod_parte_ff.destroy
call w_p_data::destroy
end on

type p_crescente from w_p_data`p_crescente within w_cod_parte_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_cod_parte_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_cod_parte_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_cod_parte_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_cod_parte_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_cod_parte_ff
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_cod_parte_ff
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_cod_parte_ff
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_cod_parte_ff
int X=1
int Y=165
int Width=2350
int Height=837
boolean BringToTop=true
long BackColor=79741120
tabpage_scelta_parte tabpage_scelta_parte
end type

on tab_1.create
this.tabpage_scelta_parte=create tabpage_scelta_parte
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_scelta_parte
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_scelta_parte)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2314
int Height=717
long BackColor=79741120
string Text="Parametri Sezione"
long TabBackColor=79741120
dw_cod_parte_ff dw_cod_parte_ff
end type

on tabpage_1.create
this.dw_cod_parte_ff=create dw_cod_parte_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_cod_parte_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_cod_parte_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_cod_parte_ff
boolean BringToTop=true
end type

type dw_cod_parte_ff from u_dw_master_main within tabpage_1
event ue_setta_nullo ( )
int X=23
int Y=37
int Width=2259
int Height=661
int TabOrder=3
boolean BringToTop=true
string DataObject="d_cod_parte_ff"
end type

event ue_setta_nullo;call super::ue_setta_nullo;string ls_scelta
integer i
setnull(ls_scelta)
i=setitem(getrow(), "val_proposto", ls_scelta)
if i<>1 then messagebox("W", "riga 42")
setcolumn("val_proposto")
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_cod_parte"
iudw_children[1] = tab_1.tabpage_scelta_parte.dw_scelta_parte_gd
is_title = "Codifica Parte"


end event

event retrieveend;call super::retrieveend;long ll_row, ll_size, ll_count
string ls_mask, ls_mask_input
integer li_len, li_pos

ll_row = GetRow()
if ll_row > 0 then
	ll_size = GetItemNumber(ll_row, "parte_regola_lunghezza")
	for ll_count = 1 to ll_size
		ls_mask = ls_mask + "!"
	next
	this.object.mas_input.editmask.mask = ls_mask
	ls_mask_input = GetItemString(ll_row, "mas_input")
	ls_mask = ""
	li_len = Len(ls_mask_input)
	for li_pos = 1 to li_len
		CHOOSE CASE Mid(ls_mask_input,li_pos, 1)
			CASE "A"
				ls_mask = ls_mask + "!"
			CASE "N"
				ls_mask = ls_mask + "#"
			CASE "M"
				ls_mask = ls_mask + "a"
			CASE "X"
				ls_mask = ls_mask + "X"
			CASE ELSE
		END CHOOSE
	next
	this.object.val_proposto.editmask.mask = ls_mask
	tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.object.scelta.editmask.mask = ls_mask
end if
end event

event itemchanged;call super::itemchanged;string ls_mask_input, ls_mask
long ll_row
integer li_len, li_pos, i
string  ls_scelta

ll_row = GetRow()
CHOOSE CASE string(dwo.name)
	CASE "mas_input"
		ls_mask_input = GetItemString(ll_row, "mas_input")
		ls_mask = ""
		li_len = Len(ls_mask_input)
		for li_pos = 1 to li_len
			CHOOSE CASE Mid(ls_mask_input,li_pos, 1)
				CASE "A"
					ls_mask = ls_mask + "!"
				CASE "N"
					ls_mask = ls_mask + "#"
				CASE "M"
					ls_mask = ls_mask + "a"
				CASE "X"
					ls_mask = ls_mask + "X"
				CASE ELSE
			END CHOOSE
		next
		this.object.val_proposto.editmask.mask = ls_mask
		tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.object.scelta.editmask.mask = ls_mask
	
	
	case "val_proposto"
		if tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.rowcount()>0 then
			for i = 1 to tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.rowcount()
				ls_scelta=tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.getitemstring(i, "scelta")
				if data=ls_scelta then
					ls_scelta="OK"
					exit
				end if
			next
			if ls_scelta<>"OK" then 
				messagebox("Errore!", "Il valore proposto non esiste nell'elenco delle scelte")
				post event ue_setta_nullo()
			end if
		end if
		
END CHOOSE

is_maschera = This.object.mas_input.editmask.mask
end event

event updatestart;call super::updatestart;
long 		ll_riga_corrente
integer	li_lunghezza
string  	ls_val_proposto, ls_scelta
char		lc_car_riempimento
integer i

ll_riga_corrente		= tab_1.tabpage_1.dw_cod_parte_ff.getrow()
ls_val_proposto		= getitemstring(getrow(), "val_proposto")
lc_car_riempimento	= getitemstring(getrow(), "car_riempimento")
if isnull(lc_car_riempimento) then lc_car_riempimento = '0'
li_lunghezza			= getitemnumber(getrow(), "parte_regola_lunghezza") 

	if tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.rowcount()>0 then
		tab_1.tabpage_1.dw_cod_parte_ff.setitem(ll_riga_corrente, "solo_in_elenco", 'S')
		if trim(ls_val_proposto)="" or isnull(ls_val_proposto) then
			ls_scelta=tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.getitemstring(1, "scelta")
			tab_1.tabpage_1.dw_cod_parte_ff.setitem(ll_riga_corrente, "val_proposto", ls_scelta)
		end if
	else
		ls_scelta = ls_val_proposto
		if trim(ls_scelta)="" or isnull(ls_scelta) then
				ls_scelta = fill(lc_car_riempimento, li_lunghezza)
		end if
		tab_1.tabpage_1.dw_cod_parte_ff.setitem(ll_riga_corrente, "solo_in_elenco", 'N')
	end if

end event

type tabpage_scelta_parte from userobject within tab_1
int X=19
int Y=105
int Width=2314
int Height=717
long BackColor=79741120
string Text="Valori assegnabili"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scelta_parte_gd dw_scelta_parte_gd
end type

on tabpage_scelta_parte.create
this.dw_scelta_parte_gd=create dw_scelta_parte_gd
this.Control[]={ this.dw_scelta_parte_gd}
end on

on tabpage_scelta_parte.destroy
destroy(this.dw_scelta_parte_gd)
end on

type dw_scelta_parte_gd from u_dw_master_main within tabpage_scelta_parte
event ue_post_itemchange ( )
int X=33
int Y=37
int Width=2241
int Height=641
int TabOrder=3
string DataObject="d_scelta_parte_gd"
boolean VScrollBar=true
end type

event ue_post_itemchange;call super::ue_post_itemchange;integer len_reale
integer len_data
integer c
string prova	
string riempimento
long id_appoggio
long row

row = tab_1.tabpage_1.dw_cod_parte_ff.getrow()

	
Len_reale = tab_1.tabpage_1.dw_cod_parte_ff.getitemdecimal(row,"parte_regola_lunghezza")
riempimento = 	tab_1.tabpage_1.dw_cod_parte_ff.getitemstring(row,"car_riempimento")

row = tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.getrow()
	
	
	if (isnull(riempimento)) or &
		(riempimento = '') then riempimento = '0'
	
	prova = tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.getitemstring(row,"scelta")
	len_data = len(prova)
	for c = len_data to len_reale - 1 
		prova = riempimento+prova
	NEXT
	
	
	
	tab_1.tabpage_scelta_parte.dw_scelta_parte_gd.setitem(row,"scelta",prova) 
	
	

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_cod_parte"
is_title = "Codifica Parte"

this.object.scelta.editmask.mask = is_maschera
end event

event itemchanged;call super::itemchanged;
if dwo.name = "scelta" then
	this.event post ue_post_itemchange()
end if
end event

