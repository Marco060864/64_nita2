forward
global type w_stampe_distinta_ff from w_p_data
end type
type dw_distinta_base_ff from u_dw_master_main within w_stampe_distinta_ff
end type
type cb_1 from commandbutton within w_stampe_distinta_ff
end type
type sle_1 from singlelineedit within w_stampe_distinta_ff
end type
type st_1 from statictext within w_stampe_distinta_ff
end type
type cb_2 from commandbutton within w_stampe_distinta_ff
end type
type cb_3 from commandbutton within w_stampe_distinta_ff
end type
type cb_4 from commandbutton within w_stampe_distinta_ff
end type
type cb_5 from commandbutton within w_stampe_distinta_ff
end type
end forward

global type w_stampe_distinta_ff from w_p_data
int Width=2802
int Height=1688
boolean TitleBar=true
string Title="Stampe Distinta"
dw_distinta_base_ff dw_distinta_base_ff
cb_1 cb_1
sle_1 sle_1
st_1 st_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
end type
global w_stampe_distinta_ff w_stampe_distinta_ff

on w_stampe_distinta_ff.create
int iCurrent
call super::create
this.dw_distinta_base_ff=create dw_distinta_base_ff
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_distinta_base_ff
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_5
end on

on w_stampe_distinta_ff.destroy
call super::destroy
destroy(this.dw_distinta_base_ff)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
end on

event open;call super::open;idw_master = dw_distinta_base_ff
idw_master.is_list = Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_distinta"
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "distinta.id_distinta"
ib_nonmodale=true
end event

type p_crescente from w_p_data`p_crescente within w_stampe_distinta_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_stampe_distinta_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_stampe_distinta_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_stampe_distinta_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_stampe_distinta_ff
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;cb_1.enabled=false
cb_2.enabled=false
cb_3.enabled=false
cb_4.enabled=false
cb_5.enabled=false
end event

type cb_inserisci from w_p_data`cb_inserisci within w_stampe_distinta_ff
int X=1897
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_stampe_distinta_ff
int X=2194
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_stampe_distinta_ff
int X=2491
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_stampe_distinta_ff
int X=891
int Y=20
int Width=366
int Height=320
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=329
int Height=200
end type

type cb_ricerca from w_p_data`cb_ricerca within w_stampe_distinta_ff
int X=1600
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;w_search_main lw_sm
long ll_id_distinta
s_ric_param ls_ricpar
idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_distinta_base_sw")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	if dw_distinta_base_ff.ModifiedCount () + & 
	   dw_distinta_base_ff.DeletedCount()>0 then &
		dw_distinta_base_ff.event trigger ue_update(0,0)
	
		
	ll_id_distinta = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_distinta"
	idw_master.is_list.l_identifica[1] = ll_id_distinta
	idw_master.Event ue_retrieve(0, 0)
	cb_1.enabled=true
	cb_2.enabled=true
	cb_3.enabled=true
	cb_4.enabled=true
	cb_5.enabled=true
	
END IF
idw_master.SetFocus()
end event

type dw_distinta_base_ff from u_dw_master_main within w_stampe_distinta_ff
int X=23
int Y=160
int Width=2738
int Height=1416
int TabOrder=60
string DataObject="d_distinta_base_val_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_distinta"
end event

type cb_1 from commandbutton within w_stampe_distinta_ff
int X=2080
int Y=772
int Width=626
int Height=88
int TabOrder=10
boolean Enabled=false
boolean BringToTop=true
string Text="Esplosione a Singolo Livello"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_anno
dati dat
date ld_1,ld_2
decimal ld_qta
long ll_distinta
li_anno=year(today())
open(w_data_val_ff)
dat=message.powerobjectparm
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
dat.data_inizio=ld_1
dat.data_fine=ld_2
dat.quantita=dec(sle_1.text)
dat.id_distinta=dw_distinta_base_ff.getitemnumber(1,"id_distinta")
openwithparm(w_stampa_singolo_livello_gd,dat)

end event

type sle_1 from singlelineedit within w_stampe_distinta_ff
int X=2459
int Y=660
int Width=247
int Height=92
int TabOrder=50
boolean BringToTop=true
boolean AutoHScroll=false
string Text="1"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_stampe_distinta_ff
int X=2162
int Y=668
int Width=270
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Quantità:"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_stampe_distinta_ff
int X=2080
int Y=876
int Width=626
int Height=88
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text="Esplosione Riepilogativa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_anno
dati dat
s_fabbisogno s_stampa
date ld_1,ld_2
decimal ld_qta
long ll_distinta
li_anno=year(today())
open(w_data_val_ff)
dat=message.powerobjectparm
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
s_stampa.data_inizio=ld_1
s_stampa.data_fine=ld_2
s_stampa.quantita=dec(sle_1.text)
s_stampa.id_distinta=dw_distinta_base_ff.getitemnumber(1,"id_distinta")
s_stampa.tipo_applicazione=dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
s_stampa.tipo_cal_valore=dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
openwithparm(w_esplosione_riepilogativa,s_stampa)

end event

type cb_3 from commandbutton within w_stampe_distinta_ff
int X=2080
int Y=980
int Width=626
int Height=88
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text="Esplosione a Scalare"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_anno
dati dat
s_fabbisogno s_stampa
date ld_1,ld_2
decimal ld_qta
long ll_distinta
li_anno=year(today())
open(w_data_val_ff)
dat=message.powerobjectparm
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
s_stampa.data_inizio=ld_1
s_stampa.data_fine=ld_2
s_stampa.quantita=dec(sle_1.text)
s_stampa.id_distinta=dw_distinta_base_ff.getitemnumber(1,"id_distinta")
s_stampa.tipo_applicazione=dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
s_stampa.tipo_cal_valore=dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
openwithparm(w_esplosione_scalare_lt,s_stampa)

end event

type cb_4 from commandbutton within w_stampe_distinta_ff
int X=2080
int Y=1084
int Width=626
int Height=88
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="Implosione Scalare"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_anno
dati dat
s_fabbisogno s_stampa
date ld_1,ld_2
decimal ld_qta
long ll_distinta
li_anno=year(today())
open(w_data_val_ff)
dat=message.powerobjectparm
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
s_stampa.data_inizio=ld_1
s_stampa.data_fine=ld_2
s_stampa.quantita=dec(sle_1.text)
s_stampa.id_distinta=dw_distinta_base_ff.getitemnumber(1,"id_distinta")
s_stampa.tipo_applicazione=dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
s_stampa.tipo_cal_valore=dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
openwithparm(w_implosione_scalare_lt,s_stampa)

end event

type cb_5 from commandbutton within w_stampe_distinta_ff
int X=2080
int Y=1188
int Width=626
int Height=88
int TabOrder=14
boolean Enabled=false
boolean BringToTop=true
string Text="Implosione Riepilogativa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_anno
dati dat
s_fabbisogno s_stampa
date ld_1,ld_2
decimal ld_qta
long ll_distinta
li_anno=year(today())
open(w_data_val_ff)
dat=message.powerobjectparm
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
s_stampa.data_inizio=ld_1
s_stampa.data_fine=ld_2
s_stampa.quantita=dec(sle_1.text)
s_stampa.id_distinta=dw_distinta_base_ff.getitemnumber(1,"id_distinta")
s_stampa.tipo_applicazione=dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
s_stampa.tipo_cal_valore=dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
openwithparm(w_implosione_riepilogativa_lt,s_stampa)

end event

