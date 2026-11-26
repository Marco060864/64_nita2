forward
global type w_orafo_stampa_parametrica from Window
end type
type cbx_causale from checkbox within w_orafo_stampa_parametrica
end type
type cb_5 from commandbutton within w_orafo_stampa_parametrica
end type
type cb_canc_sog from commandbutton within w_orafo_stampa_parametrica
end type
type dw_sog_stampa from u_dw_ext_main within w_orafo_stampa_parametrica
end type
type dw_data from u_dw_ext_main within w_orafo_stampa_parametrica
end type
type cb_4 from commandbutton within w_orafo_stampa_parametrica
end type
type st_1 from statictext within w_orafo_stampa_parametrica
end type
type sle_configurazione from singlelineedit within w_orafo_stampa_parametrica
end type
type cb_preview from commandbutton within w_orafo_stampa_parametrica
end type
type dw_salva_conf from datawindow within w_orafo_stampa_parametrica
end type
type cb_salva_conf from commandbutton within w_orafo_stampa_parametrica
end type
type cb_stampa from commandbutton within w_orafo_stampa_parametrica
end type
type cb_2 from commandbutton within w_orafo_stampa_parametrica
end type
type cb_1 from commandbutton within w_orafo_stampa_parametrica
end type
type dw_caus_scarico from datawindow within w_orafo_stampa_parametrica
end type
type dw_caus_carico from datawindow within w_orafo_stampa_parametrica
end type
type dw_causali from datawindow within w_orafo_stampa_parametrica
end type
type dw_stampa_scarico from datawindow within w_orafo_stampa_parametrica
end type
type dw_stampa_carico from datawindow within w_orafo_stampa_parametrica
end type
type gb_1 from groupbox within w_orafo_stampa_parametrica
end type
end forward

global type w_orafo_stampa_parametrica from Window
int X=5
int Y=236
int Width=3689
int Height=1928
boolean TitleBar=true
string Title="Stampa parametrica"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
cbx_causale cbx_causale
cb_5 cb_5
cb_canc_sog cb_canc_sog
dw_sog_stampa dw_sog_stampa
dw_data dw_data
cb_4 cb_4
st_1 st_1
sle_configurazione sle_configurazione
cb_preview cb_preview
dw_salva_conf dw_salva_conf
cb_salva_conf cb_salva_conf
cb_stampa cb_stampa
cb_2 cb_2
cb_1 cb_1
dw_caus_scarico dw_caus_scarico
dw_caus_carico dw_caus_carico
dw_causali dw_causali
dw_stampa_scarico dw_stampa_scarico
dw_stampa_carico dw_stampa_carico
gb_1 gb_1
end type
global w_orafo_stampa_parametrica w_orafo_stampa_parametrica

type variables
string is_sql_caus_car, is_sql_caus_scar
end variables

forward prototypes
public subroutine wf_stampa (datawindow dw_caus, datawindow dw_stampa)
public subroutine wf_allinea_dw_stampa (datawindow dw_stampa_2, datawindow dw_stampa)
public subroutine wf_salva_conf (string ls_codice)
end prototypes

public subroutine wf_stampa (datawindow dw_caus, datawindow dw_stampa);string ls_sql, ls_data_da, ls_data_a
integer li_pos_and, i
long ll_id_caus_mag, ll_id_sog
date ldt_da_data, ldt_a_data

ls_sql=dw_stampa.getsqlselect()
li_pos_and=pos(ls_sql, "and (riga_documento.id_caus_magazzino=")
if li_pos_and>0 then
ls_sql=left(ls_sql, li_pos_and - 1)
end if
if dw_caus.rowcount()<1 then return
for i = 1 to dw_caus.rowcount()
	ll_id_caus_mag=dw_caus.getitemnumber(i, "caus_magazzino_id_caus_magazzino")
	if i=1 then
		ls_sql= ls_sql+" and (riga_documento.id_caus_magazzino="+string(ll_id_caus_mag)
	else
		ls_sql= ls_sql+" or riga_documento.id_caus_magazzino="+string(ll_id_caus_mag)
	end if
	if i=dw_caus.rowcount() then
		ls_sql= ls_sql+")"
	end if
next
ldt_da_data=dw_data.getitemdate(1, "da_data")
ldt_a_data=dw_data.getitemdate(1, "a_data")
if not isnull(ldt_da_data) then
	ls_data_da=string(ldt_da_data, 'yy/mm/dd')
	ls_sql=ls_sql+" and dateformat(documento.data_documento, 'yy/mm/dd') >='" + ls_data_da+"'"
	if not isnull(ldt_a_data) then
		ls_data_a=string(ldt_a_data, 'yy/mm/dd')
		ls_sql=ls_sql+" and dateformat(documento.data_documento, 'yy/mm/dd') <='" + ls_data_a+"'"
	end if
end if
ll_id_sog=dw_sog_stampa.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog>0 then
	ls_sql=ls_sql+" and (documento.id_sog_commerciale="+string(ll_id_sog)+")"
else
end if
	
	
ls_sql=ls_sql+' ORDER BY "orafo_titolo"."titolo" ASC'
dw_stampa.setsqlselect(ls_sql)
dw_stampa.retrieve()
end subroutine

public subroutine wf_allinea_dw_stampa (datawindow dw_stampa_2, datawindow dw_stampa);
integer i, li_ret, a
long ll_riga_gruppo
decimal{2} ld_titolo

string ls_met_tit

for i=1 to dw_stampa.rowcount()
	if i=1 then
		ls_met_tit=dw_stampa.getitemstring(i, "c_met_tit")
		ll_riga_gruppo=1
	else
		ll_riga_gruppo=dw_stampa.findgroupchange(ll_riga_gruppo+1, 2)
		if ll_riga_gruppo=0 then exit
		
		ls_met_tit=dw_stampa.getitemstring(ll_riga_gruppo, "c_met_tit")
	end if
	for a=1 to dw_stampa_2.rowcount()
		
		if dw_stampa_2.GETITEMstring(a, "c_met_tit")=ls_met_tit then
			li_ret=1
			exit
		end if
	next
	if li_ret<>1 then
		dw_stampa_2.insertrow(1)
		
		dw_stampa_2.setitem(1, "c_met_tit", ls_met_tit)
		dw_stampa_2.setitem(1, "orafo_metallo_codice", left(ls_met_tit, 2))
		
	end if
	li_ret=0
next
if dw_stampa_2.rowcount()>0 then
	dw_stampa_2.setsort("c_met_tit")
	dw_stampa_2.sort()
	dw_stampa_2.groupcalc()
end if
end subroutine

public subroutine wf_salva_conf (string ls_codice);
integer i,  li_ret
long ll_id_caus, ll_id_codice, ll_id_sog_com
date ldt_da_data, ldt_a_data

datastore ds_salva_righe
ds_salva_righe=create datastore
ds_salva_righe.dataobject="ds_salva_configurazione"
ds_salva_righe.settransobject(sqlca)
ds_salva_righe.retrieve()

li_ret=dw_salva_conf.find("codice='"+ls_codice+"'", 1, dw_salva_conf.rowcount())
if li_ret >0 then
	ll_id_codice=dw_salva_conf.getitemnumber(li_ret, "id_codice")
	i=messagebox("Attenzione!", "Codice esistente: sovrascriverlo?", stopsign!, yesno!)
	if i=1 then
		i=ds_salva_righe.find("id_codice="+string(ll_id_codice), 1, ds_salva_righe.rowcount())
		do while i > 0
			ds_salva_righe.deleterow(i)
			i=ds_salva_righe.find("id_codice="+string(ll_id_codice), 1,ds_salva_righe.rowcount())
		loop
		dw_salva_conf.deleterow(li_ret)
	else
		setfocus(sle_configurazione)
		return
	end if
end if

li_ret=ds_salva_righe.update()
if li_ret<>1 then 
	messagebox("Errore!", "Cancellazione righe non effettuata!")
	return
end if

dw_salva_conf.insertrow(1)
dw_salva_conf.setitem(1, "codice", ls_codice)
ldt_da_data=dw_data.getitemdate(1, "da_data")
ldt_a_data=dw_data.getitemdate(1, "a_data")
ll_id_sog_com=dw_sog_stampa.getitemnumber(1, "id_sog_commerciale")
if not isnull(ldt_da_data) then
	dw_salva_conf.setitem(1, "da_data", ldt_da_data)
	if not isnull(ldt_a_data) then
		dw_salva_conf.setitem(1, "a_data", ldt_a_data)
	end if
end if
dw_salva_conf.setitem(1, "id_sog_commerciale", ll_id_sog_com)
li_ret=dw_salva_conf.update()
if li_ret<>1 then 
	messagebox("Errore!", "Salvataggio Testa non effettuato!")
	return
end if
ll_id_codice=dw_salva_conf.getitemnumber(1, "id_codice")
for i = 1 to dw_caus_carico.rowcount()
	ll_id_caus=dw_caus_carico.getitemnumber(i, "caus_magazzino_id_caus_magazzino")
	ds_salva_righe.insertrow(1)
	ds_salva_righe.setitem(1, "id_caus_magazzino", ll_id_caus)
	ds_salva_righe.setitem(1, "carico_scarico", "C")
	ds_salva_righe.setitem(1, "id_codice", ll_id_codice)
next
for i = 1 to dw_caus_scarico.rowcount()
	ll_id_caus=dw_caus_scarico.getitemnumber(i, "caus_magazzino_id_caus_magazzino")
	ds_salva_righe.insertrow(1)
	ds_salva_righe.setitem(1, "id_caus_magazzino", ll_id_caus)
	ds_salva_righe.setitem(1, "carico_scarico", "S")
	ds_salva_righe.setitem(1, "id_codice", ll_id_codice)
next

li_ret=ds_salva_righe.update()
if li_ret<>1 then 
	messagebox("Errore!", "Configurazione non salvata!")
else
	
end if
destroy ds_salva_righe

end subroutine

on w_orafo_stampa_parametrica.create
this.cbx_causale=create cbx_causale
this.cb_5=create cb_5
this.cb_canc_sog=create cb_canc_sog
this.dw_sog_stampa=create dw_sog_stampa
this.dw_data=create dw_data
this.cb_4=create cb_4
this.st_1=create st_1
this.sle_configurazione=create sle_configurazione
this.cb_preview=create cb_preview
this.dw_salva_conf=create dw_salva_conf
this.cb_salva_conf=create cb_salva_conf
this.cb_stampa=create cb_stampa
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_caus_scarico=create dw_caus_scarico
this.dw_caus_carico=create dw_caus_carico
this.dw_causali=create dw_causali
this.dw_stampa_scarico=create dw_stampa_scarico
this.dw_stampa_carico=create dw_stampa_carico
this.gb_1=create gb_1
this.Control[]={this.cbx_causale,&
this.cb_5,&
this.cb_canc_sog,&
this.dw_sog_stampa,&
this.dw_data,&
this.cb_4,&
this.st_1,&
this.sle_configurazione,&
this.cb_preview,&
this.dw_salva_conf,&
this.cb_salva_conf,&
this.cb_stampa,&
this.cb_2,&
this.cb_1,&
this.dw_caus_scarico,&
this.dw_caus_carico,&
this.dw_causali,&
this.dw_stampa_scarico,&
this.dw_stampa_carico,&
this.gb_1}
end on

on w_orafo_stampa_parametrica.destroy
destroy(this.cbx_causale)
destroy(this.cb_5)
destroy(this.cb_canc_sog)
destroy(this.dw_sog_stampa)
destroy(this.dw_data)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.sle_configurazione)
destroy(this.cb_preview)
destroy(this.dw_salva_conf)
destroy(this.cb_salva_conf)
destroy(this.cb_stampa)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_caus_scarico)
destroy(this.dw_caus_carico)
destroy(this.dw_causali)
destroy(this.dw_stampa_scarico)
destroy(this.dw_stampa_carico)
destroy(this.gb_1)
end on

event open;s_list_main s_list
s_list=message.powerobjectparm
if isvalid(s_list) then
	if s_list.s_win_parametri='C' then
		dw_stampa_carico.dataobject='d_orafo_stampa_par_caus2'
		dw_stampa_scarico.dataobject='d_orafo_stampa_par_caus2'
	end if
end if


dw_caus_carico.settransobject(sqlca)
dw_caus_scarico.settransobject(sqlca)
dw_causali.settransobject(sqlca)
dw_stampa_carico.settransobject(sqlca)
dw_stampa_scarico.settransobject(sqlca)
dw_causali.post retrieve()

dw_salva_conf.settransobject(sqlca)
dw_salva_conf.retrieve()
dw_data.insertrow(1)
date ldt_da_data
string ls_anno
ls_anno=string(year(today()))
ls_anno='01/01/'+ls_anno
ldt_da_data= date(ls_anno)
dw_data.setitem(1, "da_data", ldt_da_data)
dw_data.setitem(1, "a_data",today())


dw_sog_stampa.insertrow(1)
end event

event show;is_sql_caus_car=dw_caus_carico.getsqlselect()
is_sql_caus_scar=dw_caus_scarico.getsqlselect()
end event

type cbx_causale from checkbox within w_orafo_stampa_parametrica
int X=736
int Y=8
int Width=471
int Height=76
string Text="Per Causale"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if checked then
	dw_stampa_carico.dataobject="d_orafo_stampa_par_caus2"
	dw_stampa_scarico.dataobject="d_orafo_stampa_par_caus2"
	dw_stampa_carico.settransobject(sqlca)
	dw_stampa_scarico.settransobject(sqlca)
	
else
	dw_stampa_carico.dataobject="d_orafo_stampa_parametrica2"
	dw_stampa_scarico.dataobject="d_orafo_stampa_parametrica2"
	dw_stampa_carico.settransobject(sqlca)
	dw_stampa_scarico.settransobject(sqlca)
end if
end event

type cb_5 from commandbutton within w_orafo_stampa_parametrica
int X=2898
int Y=252
int Width=247
int Height=108
int TabOrder=71
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer li_message
long ll_row
li_message=messagebox("Cancellazione"," Continuare la cancellazione", Exclamation!,Okcancel!,2)
if li_message= 1 then
      ll_row = dw_salva_conf.getrow()
      if ll_row > 0 then
         	dw_salva_conf.deleterow(ll_row)
	         dw_salva_conf.update()
	         dw_salva_conf.retrieve()
            dw_caus_carico.reset()
            dw_caus_scarico.reset()
            dw_stampa_carico.reset()
            dw_stampa_scarico.reset()
				sle_configurazione.text=" "
      end if
else
	return 0
end if
end event

type cb_canc_sog from commandbutton within w_orafo_stampa_parametrica
int X=713
int Y=104
int Width=503
int Height=108
int TabOrder=80
string Text="Cancella Sog. Comm."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_sog_stampa.reset()
dw_sog_stampa.insertrow(1)
wf_stampa(dw_caus_carico, dw_stampa_carico)
wf_stampa(dw_caus_scarico, dw_stampa_scarico)
wf_allinea_dw_stampa(dw_stampa_scarico, dw_stampa_carico)

wf_allinea_dw_stampa(dw_stampa_carico, dw_stampa_scarico)

end event

type dw_sog_stampa from u_dw_ext_main within w_orafo_stampa_parametrica
int X=9
int Y=228
int Width=1207
int Height=168
int TabOrder=60
string DataObject="d_orafo_sog_st_par"
end type

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	
CASE "codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
end  choose
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])
			
			wf_stampa(dw_caus_carico, dw_stampa_carico)
			wf_stampa(dw_caus_scarico, dw_stampa_scarico)
			wf_allinea_dw_stampa(dw_stampa_scarico, dw_stampa_carico)
			
			wf_allinea_dw_stampa(dw_stampa_carico, dw_stampa_scarico)
end choose




end event

type dw_data from u_dw_ext_main within w_orafo_stampa_parametrica
int X=9
int Y=28
int Width=690
int Height=184
int TabOrder=90
string DataObject="d_da_data_a_data"
end type

event itemchanged;date ldt_da_data
string ls_anno
if dwo.name='da_data' then
	if isnull(data) or data<=' ' then
		ls_anno=string(year(today()))
		ls_anno='01/01/'+ls_anno
		ldt_da_data= date(ls_anno)
		messagebox("Attenzione!", "La data di inizio è OBBLIGATORIA!")
		post setitem(1, "da_data", ldt_da_data)
		post setcolumn('da_data')
		return 1
	end if
end if
end event

type cb_4 from commandbutton within w_orafo_stampa_parametrica
int X=2624
int Y=252
int Width=247
int Height=108
int TabOrder=70
string Text="Applica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
wf_stampa(dw_caus_carico, dw_stampa_carico)
wf_stampa(dw_caus_scarico, dw_stampa_scarico)
wf_allinea_dw_stampa(dw_stampa_carico,dw_stampa_scarico)
wf_allinea_dw_stampa(dw_stampa_scarico,dw_stampa_carico)
end event

type st_1 from statictext within w_orafo_stampa_parametrica
int X=2345
int Y=72
int Width=1093
int Height=64
boolean Enabled=false
string Text="Inserisci codice della configurazione da salvare:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_configurazione from singlelineedit within w_orafo_stampa_parametrica
int X=2345
int Y=136
int Width=1065
int Height=92
int TabOrder=100
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_preview from commandbutton within w_orafo_stampa_parametrica
int X=2350
int Y=252
int Width=247
int Height=108
int TabOrder=110
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_sql_carico, ls_sql_scarico, ls_car_scar, ls_codice, ls_cod, ls_rag_1
long ll_id_caus, ll_id_codice,ll_id_sog_com
integer li_pos_and, i=0, a=0
date ldt_da_data, ldt_a_data


ls_sql_carico=dw_caus_carico.getsqlselect()
ls_sql_scarico=dw_caus_scarico.getsqlselect()

dw_caus_carico.reset()
dw_caus_scarico.reset()
dw_stampa_carico.reset()
dw_stampa_scarico.reset()

ll_id_codice=dw_salva_conf.getitemnumber(dw_salva_conf.getrow(), "id_codice")
declare recupera_config  cursor for
select id_caus_magazzino, carico_scarico
from orafo_stampa_par_righe
where id_codice=:ll_id_codice;



li_pos_and=pos(ls_sql_carico, "where")
if li_pos_and>0 then
	ls_sql_carico=left(ls_sql_carico, li_pos_and - 1)
end if
li_pos_and=pos(ls_sql_scarico, "where")
if li_pos_and>0 then
	ls_sql_scarico=left(ls_sql_scarico, li_pos_and - 1)
end if
open recupera_config;
do while sqlca.sqlcode=0  
	fetch recupera_config into :ll_id_caus, :ls_car_scar;
	if sqlca.sqlcode=0 then
		if ls_car_scar="C" then
			i++
			if i=1 then
				ls_sql_carico= ls_sql_carico+" where caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			else
				ls_sql_carico= ls_sql_carico+" or caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			end if
		else
			a++
			if a=1 then
				ls_sql_scarico= ls_sql_scarico+" where caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			else
				ls_sql_scarico= ls_sql_scarico+" or caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			end if
		end if
	end if
	li_pos_and=dw_causali.find("caus_magazzino_id_caus_magazzino="+string(ll_id_caus), 1,dw_causali.rowcount())
	if li_pos_and>0 then
		dw_causali.deleterow(li_pos_and)
	end if
loop
close recupera_config;
if i>0 then 
	
	dw_caus_carico.setsqlselect(ls_sql_carico)
	dw_caus_carico.retrieve()
end if
if a>0 then 
	
	dw_caus_scarico.setsqlselect(ls_sql_scarico)
	dw_caus_scarico.retrieve()
end if

select da_data, a_data, id_sog_commerciale
into :ldt_da_data, :ldt_a_data, :ll_id_sog_com
from orafo_stampa_parametrica
where id_codice=:ll_id_codice;
if sqlca.sqlcode=0 then
	dw_data.setitem(1, "da_data", ldt_da_data)
	if isnull(ldt_a_data) then ldt_a_data=today()
	dw_data.setitem(1, "a_data", ldt_a_data)
	if isnull(ll_id_sog_com) then
		
		dw_sog_stampa.reset()
		dw_sog_stampa.insertrow(1)
	else
		select codice, rag_soc_1
		into :ls_cod, :ls_rag_1
		from sog_commerciale_gen
		where id_sog_commerciale=:ll_id_sog_com;
		if sqlca.sqlcode=0 then
			dw_sog_stampa.setitem(1, "id_sog_commerciale", ll_id_sog_com)
			dw_sog_stampa.setitem(1, "codice", ls_cod)
			dw_sog_stampa.setitem(1, "rag_soc_1", ls_rag_1)
		else
			
		end if
	end if
else
	Messagebox("Attenzione!", "Periodo di riferimento non trovato!")
end if



end event

type dw_salva_conf from datawindow within w_orafo_stampa_parametrica
int X=1298
int Y=68
int Width=1024
int Height=312
int TabOrder=160
string DataObject="d_gruppo_config"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;SetrowFOCUSINDICATOR(HAND!)
scrolltorow(currentrow)
end event

type cb_salva_conf from commandbutton within w_orafo_stampa_parametrica
int X=3433
int Y=120
int Width=169
int Height=108
int TabOrder=50
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_codice
integer li_ret
if sle_configurazione.text<>"" or not(isnull(sle_configurazione.text)) then
	ls_codice=trim(sle_configurazione.text)
	wf_salva_conf(ls_codice)
else
	messagebox("Attenzione!", "Specificare il nome della configurazione!")
end if
end event

type cb_stampa from commandbutton within w_orafo_stampa_parametrica
int X=1047
int Y=416
int Width=233
int Height=108
int TabOrder=120
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_sql[2]

s_stampa s_dati_stampa
if dw_stampa_carico.dataobject='d_orafo_stampa_par_caus2' then
	s_dati_stampa.s_tit_caus='C'
end if
s_dati_stampa.dw_s_carico=dw_stampa_carico
s_dati_stampa.dw_s_scarico=dw_stampa_scarico
s_dati_stampa.dw_caus_car=dw_caus_carico
s_dati_stampa.dw_caus_scar=dw_caus_scarico
s_dati_stampa.data_inizio=dw_data.getitemdate(1, "da_data")
s_dati_stampa.data_fine=dw_data.getitemdate(1, "a_data")
openwithparm(w_orafo_stampa_preview, s_dati_stampa)
end event

type cb_2 from commandbutton within w_orafo_stampa_parametrica
int X=2363
int Y=980
int Width=233
int Height=108
int TabOrder=130
string Text="< Resetta"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_caus_scarico.rowsmove(1, dw_caus_scarico.rowcount(), primary!, dw_causali, 1, primary!)
dw_stampa_scarico.reset()


dw_caus_scarico.setsqlselect(is_sql_caus_scar)
end event

type cb_1 from commandbutton within w_orafo_stampa_parametrica
int X=1056
int Y=980
int Width=233
int Height=108
int TabOrder=30
string Text="Resetta >"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_caus_carico.rowsmove(1, dw_caus_carico.rowcount(), primary!, dw_causali, 1, primary!)
dw_stampa_carico.reset()
end event

type dw_caus_scarico from datawindow within w_orafo_stampa_parametrica
int X=2619
int Y=416
int Width=1019
int Height=676
int TabOrder=40
string DragIcon="S:\pb\commonframework\cometa.ico"
string DataObject="d_caus_mag_formule2"
boolean TitleBar=true
string Title="Scarichi"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;
long ll_riga_sorgente, ll_id_caus_mag,ll_riga_gruppo
string ls_sql
integer li_pos_and, i, a, li_ret
decimal{2} ld_titolo
datawindow dw_sorgente
dw_sorgente=source

dw_sorgente.drag(end!)
if dw_sorgente=this then
	return
end if
ll_riga_sorgente=dw_sorgente.getrow()
dw_sorgente.rowsmove(ll_riga_sorgente,ll_riga_sorgente, primary!, this, 1, primary!)

if dw_sorgente=dw_caus_carico then
	if dw_caus_carico.rowcount()>0 then
		wf_stampa(dw_caus_carico, dw_stampa_carico)
	else
		dw_stampa_carico.reset()
	end if
end if

wf_stampa(this, dw_stampa_scarico)

wf_allinea_dw_stampa(dw_stampa_carico,dw_stampa_scarico)
wf_allinea_dw_stampa(dw_stampa_scarico,dw_stampa_carico)

end event

event clicked;if row>0 then
	this.drag(begin!)
end if
end event

type dw_caus_carico from datawindow within w_orafo_stampa_parametrica
int X=5
int Y=416
int Width=1029
int Height=676
int TabOrder=20
string DragIcon="S:\pb\commonframework\cometa.ico"
string DataObject="d_caus_mag_formule2"
boolean TitleBar=true
string Title="Carichi"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;long ll_riga_sorgente, ll_id_caus_mag
string ls_sql
integer li_pos_and, i
datawindow dw_sorgente
dw_sorgente=source
dw_sorgente.drag(end!)
if dw_sorgente=this then
	return
end if
ll_riga_sorgente=dw_sorgente.getrow()
dw_sorgente.rowsmove(ll_riga_sorgente,ll_riga_sorgente, primary!, this, 1, primary!)

if  dw_sorgente=dw_caus_scarico then
	if dw_caus_scarico.rowcount()>0 then
		wf_stampa(dw_caus_scarico, dw_stampa_scarico)
	else
		dw_stampa_scarico.reset()
	end if
end if



wf_stampa(this, dw_stampa_carico)

wf_allinea_dw_stampa(dw_stampa_carico,dw_stampa_scarico)
wf_allinea_dw_stampa(dw_stampa_scarico,dw_stampa_carico)


end event

event clicked;if row>0 then
	this.drag(begin!)
end if
end event

type dw_causali from datawindow within w_orafo_stampa_parametrica
int X=1312
int Y=416
int Width=1029
int Height=676
int TabOrder=140
string DragIcon="S:\pb\commonframework\cometa.ico"
string DataObject="d_caus_mag_formule2"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="Asterisk!"
end type

event clicked;if row>0 then
	this.drag(begin!)
end if
end event

event dragdrop;datawindow dw_sorgente
dw_sorgente=source
if dw_sorgente=this then return
long ll_riga_sorgente
dw_sorgente.drag(end!)
if dw_sorgente=this then
	return
end if
ll_riga_sorgente=dw_sorgente.getrow()
dw_sorgente.rowsmove(ll_riga_sorgente, ll_riga_sorgente, primary!, this, 1, primary!)

if dw_sorgente=dw_caus_carico then
	if dw_caus_carico.rowcount()>0 then
		wf_stampa(dw_caus_carico, dw_stampa_carico)
	else
		dw_stampa_carico.reset()
	end if
	if dw_caus_scarico.rowcount()>0 then
		wf_stampa(dw_caus_scarico, dw_stampa_scarico)
	end if
elseif  dw_sorgente=dw_caus_scarico then
	if dw_caus_scarico.rowcount()>0 then
		wf_stampa(dw_caus_scarico, dw_stampa_scarico)
	else
		dw_stampa_scarico.reset()
	end if
	if dw_caus_carico.rowcount()>0 then
		wf_stampa(dw_caus_carico, dw_stampa_carico)
	end if
end if
if dw_caus_scarico.rowcount()>0 then
	wf_allinea_dw_stampa(dw_stampa_carico, dw_stampa_scarico)
else
	
end if
if  dw_caus_carico.rowcount()>0 then
	wf_allinea_dw_stampa(dw_stampa_scarico, dw_stampa_carico)
else
	
end if

end event

type dw_stampa_scarico from datawindow within w_orafo_stampa_parametrica
int X=1847
int Y=1116
int Width=1797
int Height=716
int TabOrder=170
string DataObject="d_orafo_stampa_parametrica2"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_stampa_carico from datawindow within w_orafo_stampa_parametrica
int Y=1116
int Width=1833
int Height=716
int TabOrder=150
string DataObject="d_orafo_stampa_parametrica2"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type gb_1 from groupbox within w_orafo_stampa_parametrica
int X=1234
int Y=16
int Width=2400
int Height=380
int TabOrder=10
string Text="Richiama/Salva Configurazione"
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

