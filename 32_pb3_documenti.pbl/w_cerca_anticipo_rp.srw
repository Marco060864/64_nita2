forward
global type w_cerca_anticipo_rp from Window
end type
type cb_esci from commandbutton within w_cerca_anticipo_rp
end type
type cb_ok from commandbutton within w_cerca_anticipo_rp
end type
type dw_cerca_anticipo from datawindow within w_cerca_anticipo_rp
end type
end forward

global type w_cerca_anticipo_rp from Window
int X=1074
int Y=484
int Width=2848
int Height=908
boolean TitleBar=true
string Title="Anticipi di: "
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_esci cb_esci
cb_ok cb_ok
dw_cerca_anticipo dw_cerca_anticipo
end type
global w_cerca_anticipo_rp w_cerca_anticipo_rp

type variables
decimal id_cambio_doc
datastore ids_anticipi
long il_id_doc_corrente, il_id_valuta_saldo
s_anticipi is_anticipi
end variables

on w_cerca_anticipo_rp.create
this.cb_esci=create cb_esci
this.cb_ok=create cb_ok
this.dw_cerca_anticipo=create dw_cerca_anticipo
this.Control[]={this.cb_esci,&
this.cb_ok,&
this.dw_cerca_anticipo}
end on

on w_cerca_anticipo_rp.destroy
destroy(this.cb_esci)
destroy(this.cb_ok)
destroy(this.dw_cerca_anticipo)
end on

event open;s_anticipi s_ant
s_ant=message.powerobjectparm
ids_anticipi=s_ant.sds_anticipi
id_cambio_doc=s_ant.s_ld_cambio_doc
il_id_doc_corrente=s_ant.s_ll_id_doc

il_id_valuta_saldo=s_ant.s_id_valuta


DataWindowChild sog_comm, prof_doc, iva

decimal ld_residuo, ld_valore
integer i
long ll_id_doc_scar, ll_riga_trovata, ll_righe, ll_id_doc_che_scarica

i = dw_cerca_anticipo.GetChild('id_tipo_pagamento', sog_comm)
IF i = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
	
i = dw_cerca_anticipo.GetChild('id_prof_documento', prof_doc)
IF i = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")	
	
i = dw_cerca_anticipo.GetChild('id_tab_iva', iva)
IF i = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")	

CONNECT USING SQLCA;	

sog_comm.SetTransObject(SQLCA)
prof_doc.SetTransObject(SQLCA)
iva.SetTransObject(SQLCA)

sog_comm.Retrieve()
prof_doc.Retrieve()
iva.Retrieve()


dw_cerca_anticipo.settransobject(sqlca)
ll_righe=dw_cerca_anticipo.retrieve(s_ant.s_ll_id_tipo_pagamento)


for i=1 to ll_righe
	ld_residuo=0
	ll_id_doc_scar=dw_cerca_anticipo.getitemnumber(i, "id_documento")
	ll_riga_trovata=ids_anticipi.find("id_doc_scaricato="+string(ll_id_doc_scar), 1, ids_anticipi.rowcount())
	do while ll_riga_trovata>0
		ll_id_doc_che_scarica=ids_anticipi.getitemnumber(ll_riga_trovata, "id_doc_scar_ant")
		if ll_id_doc_che_scarica <> s_ant.s_ll_id_doc then
			ld_residuo=ld_residuo + ids_anticipi.getitemdecimal(ll_riga_trovata, "valore")
		ELSE
			ld_valore=ids_anticipi.getitemdecimal(ll_riga_trovata, "valore")
			ids_anticipi.Setitem(ll_riga_trovata, "valore", 0)
			dw_cerca_anticipo.setitem(i, "ripristina", ld_valore)
		end if
		if ll_riga_trovata=ids_anticipi.rowcount() then exit
		ll_riga_trovata=ids_anticipi.find("id_doc_scaricato="+string(ll_id_doc_scar), ll_riga_trovata+1, ids_anticipi.rowcount())
	loop
	ld_residuo=dw_cerca_anticipo.getitemdecimal(i, "imp_acconto") - ld_residuo
	dw_cerca_anticipo.setitem(i, "da_scaricare", ld_residuo)
	dw_cerca_anticipo.setitem(i, "controllo", ld_residuo)
next
dw_cerca_anticipo.setfilter("da_scaricare>0")
dw_cerca_anticipo.filter()




end event

type cb_esci from commandbutton within w_cerca_anticipo_rp
int X=379
int Y=700
int Width=283
int Height=108
int TabOrder=20
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_anticipi s_ant
 integer i
long ll_trovata, ll_id_doc_scaricato, ll_riga_anticipo
decimal ld_valore

	ll_trovata=dw_cerca_anticipo.find("ripristina > 0", ll_trovata+1, dw_cerca_anticipo.rowcount())
	do while LL_trovata>0 
		ll_id_doc_scaricato=dw_cerca_anticipo.getitemnumber(LL_trovata, "id_documento")
		ld_valore=dw_cerca_anticipo.getitemnumber(LL_trovata, "ripristina")
		ll_riga_anticipo=ids_anticipi.find("id_doc_scar_ant="+string(il_id_doc_corrente)+&
		" and id_doc_scaricato="+string(ll_id_doc_scaricato), 1, ids_anticipi.rowcount())
		if ll_riga_anticipo>0 then
			ids_anticipi.setitem(ll_riga_anticipo, "valore", ld_valore)
		end if
		if ll_trovata=dw_cerca_anticipo.rowcount() then exit
		ll_trovata=dw_cerca_anticipo.find("ripristina > 0", ll_trovata+1, dw_cerca_anticipo.rowcount())
	loop
	s_ant.sds_anticipi=ids_anticipi
closewithreturn(parent, s_ant)
end event

type cb_ok from commandbutton within w_cerca_anticipo_rp
int X=27
int Y=700
int Width=283
int Height=108
int TabOrder=10
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_anticipi s_ant
decimal ld_acconto_parz, ld_fattore_cambio
long row, ll_id_doc, ll_riga_trovata, ll_id_val_euro, ll_id_cambio_anticipo
integer ret


select id_val_euro
into :ll_id_val_euro
from par_sistema
;
if sqlca.sqlcode<>0 then
	Messagebox("Errore!", "Inserire la valuta Euro in Parametri di Sistema")
	return
end if

dw_cerca_anticipo.accepttext()
row=dw_cerca_anticipo.getselectedrow(0)
if row<1 then
	ret=messagebox("Attenzione!", "Nessuna riga selezionata! Vuoi uscire lo stesso?")
	if ret=1 then	
		cb_esci.triggerevent(clicked!)
		return
	else
		return
	end if
end if
if row>0 then
	s_ant.s_ll_id_iva_acconto=dw_cerca_anticipo.getitemdecimal(row, "id_tab_iva")
	s_ant.s_ll_id_tipo_pagamento=dw_cerca_anticipo.getitemdecimal(row, "id_tipo_pagamento")
end if
s_ant.s_ld_imp_acconto=0
do while row > 0
	
	s_ant.s_ll_id_val_acconto=dw_cerca_anticipo.getitemnumber(row, "id_valuta")
	
	if s_ant.s_ll_id_val_acconto<>il_id_valuta_saldo then
		messagebox("Errore!", "Non si possono scalare anticipi in valuta diversa dal saldo!")
		return
	end if
	
	ll_id_doc=dw_cerca_anticipo.getitemnumber(row, "id_documento")
	ld_acconto_parz=dw_cerca_anticipo.getitemdecimal(row, "da_scaricare")
	
	
	if isnull(ld_acconto_parz) or ld_acconto_parz=0 then
		ll_riga_trovata=ids_anticipi.find("id_doc_scaricato="+string(ll_id_doc)+"and id_doc_scar_ant="+string(il_id_doc_corrente), 1, ids_anticipi.RowCount( ))
		if ll_riga_trovata>0 then
			ids_anticipi.deleterow(ll_riga_trovata)
			
			dw_cerca_anticipo.selectrow(row, false)
			row=dw_cerca_anticipo.getselectedrow(0)
			continue
		end if
	end if
	
	
	
	long		ll_id_valuta
	integer	li_dec_significativi
	string	ls_tipo_arrotondamento
	
	 
	s_ant.s_ld_imp_val_doc += ld_acconto_parz
	s_ant.s_ld_imp_acconto = s_ant.s_ld_imp_val_doc * id_cambio_doc


	
	select v.dec_significativi, v.tipo_arrotondamento
	into	 :li_dec_significativi, :ls_tipo_arrotondamento
	from	 valuta v
	where  v.id_valuta = :s_ant.s_ll_id_val_acconto	
	;
   s_ant.s_ld_imp_acconto = f_round(s_ant.s_ld_imp_acconto, li_dec_significativi, ls_tipo_arrotondamento)


	select v.id_valuta, v.dec_significativi, v.tipo_arrotondamento
	into	 :ll_id_valuta, :li_dec_significativi, :ls_tipo_arrotondamento
	from	 valuta v, documento d
	where  d.id_documento = :il_id_doc_corrente
	and	 v.id_valuta = d.id_valuta
	;
	if (sqlca.sqlcode = -1) then &
		messagebox("dberror", sqlca.sqlerrtext)

	if (ll_id_valuta <> s_ant.s_ll_id_val_acconto) then
		select fn_conv_valuta(:s_ant.s_ll_id_val_acconto, :s_ant.s_ld_imp_val_doc, :ll_id_valuta)
		into	 :s_ant.s_ld_imp_val_doc
		from	 sys.dummy
		;

		if (sqlca.sqlcode = -1) then &
			messagebox("dberror", sqlca.sqlerrtext)
		
		s_ant.s_ld_imp_val_doc = f_round(s_ant.s_ld_imp_val_doc, li_dec_significativi, ls_tipo_arrotondamento)
		
	end if

	ll_riga_trovata=ids_anticipi.find("id_doc_scaricato="+string(ll_id_doc)+"and id_doc_scar_ant="+string(il_id_doc_corrente), 1, ids_anticipi.RowCount( ))
	if ll_riga_trovata<1 then
		ll_riga_trovata=ids_anticipi.insertrow(0)
		ids_anticipi.setitem(ll_riga_trovata, "id_doc_scaricato", ll_id_doc)
	end if
	
	
	ld_acconto_parz = f_round(ld_acconto_parz, li_dec_significativi, ls_tipo_arrotondamento)		
	ids_anticipi.setitem(ll_riga_trovata, "valore", ld_acconto_parz)
	
	
	
	
	
	if s_ant.s_ll_id_val_acconto<>ll_id_val_euro then
		s_ant.s_ld_cambio_doc=dw_cerca_anticipo.getitemnumber(row, "cambio")
		s_ant.s_ld_avanzo_cambio += &
			 f_round((ld_acconto_parz*s_ant.s_ld_cambio_doc),&
			li_dec_significativi, ls_tipo_arrotondamento)&
			- f_round((ld_acconto_parz*id_cambio_doc),&
			li_dec_significativi, ls_tipo_arrotondamento)
	end if
	
	ids_anticipi.setitem(ll_riga_trovata, "id_doc_scar_ant", il_id_doc_corrente)
	dw_cerca_anticipo.selectrow(row, false)
	row=dw_cerca_anticipo.getselectedrow(0)
loop 

ret=ids_anticipi.update() 
if ret=1 then
	commit;
else
	messagebox("Errore!", "Anticipi non scaricati!")
	rollback;
end if
s_ant.sds_anticipi=ids_anticipi
closewithreturn(parent, s_ant)
end event

type dw_cerca_anticipo from datawindow within w_cerca_anticipo_rp
int X=27
int Y=28
int Width=2770
int Height=644
int TabOrder=30
string DataObject="d_cerca_fat_anticipo"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;
end event

event clicked;long ll_id_iva, ll_trovata, ll_id_pag, ll_id_pag_2, ll_id_iva_2

if row<1 then return
ll_id_iva=getitemnumber(row, "id_tab_iva")
if isnull(ll_id_iva) then ll_id_iva=0
ll_id_pag=getitemnumber(row, "id_tipo_pagamento")
if isnull(ll_id_pag) then ll_id_pag=0
ll_trovata=getselectedrow(0)
if ll_trovata<1 then
	selectrow(row, not isselected(row))
	return
else
	ll_id_pag_2=getitemnumber(ll_trovata, "id_tipo_pagamento")
	if isnull(ll_id_pag_2) then ll_id_pag_2=0
	ll_id_iva_2=getitemnumber(ll_trovata, "id_tab_iva")
	if isnull(ll_id_iva_2) then ll_id_iva=0
	if not((ll_id_iva_2=ll_id_iva) and (ll_id_pag=ll_id_pag_2)) then
		messagebox("Errore!", "Devi selezionare righe con identico tipo di pagamento e stessa aliquota iva!")
	else
		selectrow(row, not isselected(row))
	end if
end if

 
 
end event

event itemchanged;decimal ld_controllo


ld_controllo=dw_cerca_anticipo.getitemdecimal(row, "controllo")
if dec(data) > ld_controllo then return 1
end event

