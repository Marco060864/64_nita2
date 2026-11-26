forward
global type w_lung_peso_rpt from w_stampa_001
end type
type cb_inserisci from commandbutton within w_lung_peso_rpt
end type
type cb_salva from commandbutton within w_lung_peso_rpt
end type
type cb_cancella from commandbutton within w_lung_peso_rpt
end type
type cb_ordina from commandbutton within w_lung_peso_rpt
end type
end forward

global type w_lung_peso_rpt from w_stampa_001
int Height=1836
boolean TitleBar=true
string Title="Lunghezze Personalizzate"
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_ordina cb_ordina
end type
global w_lung_peso_rpt w_lung_peso_rpt

type variables
long il_id_sog, il_id_lung_da_cancellare[]
end variables

on w_lung_peso_rpt.create
int iCurrent
call super::create
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_ordina=create cb_ordina
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_inserisci
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.cb_cancella
this.Control[iCurrent+4]=this.cb_ordina
end on

on w_lung_peso_rpt.destroy
call super::destroy
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_ordina)
end on

event open;s_param_articoli str_param

str_param=message.powerobjectparm


if str_param.da_sog_comm=str_param.a_sog_comm and str_param.da_sog_comm>"" then
	dw_1.dataobject="d_lung_peso_manuale"
	select id_sog_commerciale
	into :il_id_sog
	from sog_commerciale
	where codice=:str_param.da_cod_art;
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(str_param.da_sog_comm, str_param.a_sog_comm)
end event

event resize;dw_1.height=newheight - 280
dw_1.width=newwidth - 75
end event

type dw_1 from w_stampa_001`dw_1 within w_lung_peso_rpt
event ue_key pbm_dwnkey
int Y=252
int Height=1432
string DataObject="d_lung_peso_rpt"
end type

event dw_1::ue_key;choose case key
case Keyadd!
		
		
		if (keyFlags=2) then
			cb_inserisci.triggerevent(clicked!)	
		end if
	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.triggerevent(clicked!)	
		end if
	case KeyF12!, KeyS!
		cb_salva.triggerevent(clicked!)	
		
end choose
end event

event dw_1::doubleclicked;long ll_riga, ll_id_lung

ll_riga=dw_1.getrow()
if ll_riga>0 then
ll_id_lung=dw_1.getitemnumber(ll_riga, "orafo_lung_peso_id_lung_peso")
	openwithparm(w_dett_lung_peso_rpt, ll_id_lung)
end if
end event

event dw_1::itemchanged;integer li_ok, li_up
long ll_id_sog, ll_id_art, ll_righe

string ls_sql_cond,  ls_campo_filtro, ls_cod_cliente, ls_codice
string ls_dbc[], ls_dwc[], ls_dbv[]
u_dw_main uo_dw

datastore ds_des_articolo

s_ric_param ls_ric_param
w_search_main lw_sm

if dwo.name="articolo" then
	ds_des_articolo=create datastore 
	ds_des_articolo.dataobject="ds_des_articolo"
	ds_des_articolo.settransobject(sqlca)
	
	ls_dbc[1] = "codice"
	ls_dbc[2] = "id_articolo"
		
	ls_dwc[1] = "articolo"
	ls_dwc[2] = "orafo_lung_peso_id_articolo"
	uo_dw=create u_dw_main
	li_ok = uo_dw.uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
				ls_dbc, ls_dbv, ls_dwc)
				
	if li_ok>0 then	
		
	
		ll_id_art=long(ls_dbv[2])
		setitem(row, "orafo_lung_peso_id_articolo",ll_id_art)
		ll_righe=ds_des_articolo.retrieve(il_id_sog, ll_id_art)
		if ll_righe>0 then ls_cod_cliente=ds_des_articolo.getitemstring(1, "codice")
		if ls_cod_cliente>"" then setitem(row, "des_articolo_codice", ls_cod_cliente)
	
	else
		ls_ric_param.s_filter_value=data
		ls_ric_param.s_filter_name="articolo_codice"
		ls_ric_param.s_sql_cond=""
		openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
		ls_ric_param=message.powerobjectparm
		if upperbound(ls_ric_param.s_id_seg_value)>0 then
			ll_id_art=long(ls_ric_param.s_id_seg_value[1])
			setitem(row, "orafo_lung_peso_id_articolo",ll_id_art)
			post setitem(row, "articolo", ls_ric_param.s_main_value)
			ll_righe=ds_des_articolo.retrieve(il_id_sog, ll_id_art)
			if ll_righe>0 then ls_cod_cliente=ds_des_articolo.getitemstring(1, "codice")
			if ls_cod_cliente>"" then setitem(row, "des_articolo_codice", ls_cod_cliente)
		end if		
	end if
	destroy(ds_des_articolo)
	destroy(uo_dw)
	setitem(row, "orafo_lung_peso_simbolo_um", "CM")
end if
if dwo.name="lunghezza" then 
	li_up=upperbound(il_id_lung_da_cancellare)
	il_id_lung_da_cancellare[li_up+1]=getitemnumber(row, "orafo_lung_peso_id_lung_Peso")
end if


end event

event dw_1::updateend;integer i, li_up
long ll_riga_trovata, ll_righe
long ll_null[]

if rowsupdated>0 then
	ll_righe=dw_1.rowcount()
	li_up=upperbound(il_id_lung_da_cancellare)
	for i=1 to li_up
		delete from orafo_lung_peso_righe
		where id_lung_peso=:il_id_lung_da_cancellare[i];
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Erroe!", "Righe non cancellate!")
		end if
	next
end if
il_id_lung_da_cancellare=ll_null
end event

event dw_1::updatestart;integer i, li_up
long ll_riga_trovata, ll_righe
decimal ld_peso_man

ll_righe=dw_1.rowcount()
li_up=upperbound(il_id_lung_da_cancellare)
for i=1 to li_up
	ll_riga_trovata=dw_1.find("orafo_lung_peso_id_lung_peso="+string(il_id_lung_da_cancellare[i]),1, ll_righe)
	ld_peso_man=dw_1.getitemdecimal(ll_riga_trovata, "peso_manuale")
	if ld_peso_man=0 or isnull(ld_peso_man) then
		ld_peso_man=dw_1.getitemdecimal(ll_riga_trovata, "peso_unitario")
		setitem(ll_riga_trovata, "peso_manuale", ld_peso_man)
	end if
next
end event

type sle_pg from w_stampa_001`sle_pg within w_lung_peso_rpt
int TabOrder=100
end type

type sle_copie from w_stampa_001`sle_copie within w_lung_peso_rpt
int TabOrder=110
end type

type sle_zoom from w_stampa_001`sle_zoom within w_lung_peso_rpt
int TabOrder=90
end type

type cb_6 from w_stampa_001`cb_6 within w_lung_peso_rpt
int TabOrder=140
end type

type cb_preview from w_stampa_001`cb_preview within w_lung_peso_rpt
int TabOrder=120
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_lung_peso_rpt
int TabOrder=130
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_lung_peso_rpt
int TabOrder=150
end type

type cb_1 from w_stampa_001`cb_1 within w_lung_peso_rpt
int TabOrder=160
end type

type cb_inserisci from commandbutton within w_lung_peso_rpt
int X=1303
int Y=152
int Width=247
int Height=88
int TabOrder=60
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga, ll_id_sog
ll_riga=dw_1.getrow()

ll_riga=dw_1.insertrow(ll_riga)

dw_1.setitem(ll_riga , "orafo_lung_peso_id_sog_commerciale", il_id_sog)
dw_1.setitem(ll_riga , "ultimo_aggiornamento", datetime(today(), now()))
dw_1.scrolltorow(ll_riga)
end event

type cb_salva from commandbutton within w_lung_peso_rpt
int X=1614
int Y=152
int Width=247
int Height=88
int TabOrder=70
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret

li_ret=dw_1.update()
if li_ret=1 then
	commit;
	
else
	rollback;
	messagebox("Errore!", sqlca.sqlerrtext)
end if
end event

type cb_cancella from commandbutton within w_lung_peso_rpt
int X=1925
int Y=152
int Width=247
int Height=88
int TabOrder=80
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga

ll_riga=dw_1.getrow()
if ll_riga>0 then
	dw_1.deleterow(ll_riga)
end if
end event

type cb_ordina from commandbutton within w_lung_peso_rpt

int X=37
int Y=148
int Width=261
int Height=88
int TabOrder=50
boolean BringToTop=true
string Text="Ordina"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_null
setnull(ls_null)
dw_1.setsort(ls_null)
dw_1.sort()
end event

