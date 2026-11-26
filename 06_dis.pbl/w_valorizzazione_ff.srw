forward
global type w_valorizzazione_ff from w_p_data
end type
type dw_distinta_base_ff from u_dw_master_main within tabpage_1
end type
type dw_mag from datawindow within tabpage_1
end type
type cb_10 from commandbutton within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type sle_qta from singlelineedit within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type dw_distinta_base_ff from u_dw_master_main within tabpage_1
end type
type dw_mag from datawindow within tabpage_1
end type
type cb_10 from commandbutton within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type sle_qta from singlelineedit within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_valorizza_tot_ff from u_dw_ext_main within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type tv_2 from u_tv_distinta within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type sle_din from singlelineedit within tabpage_2
end type
type sle_dfin from singlelineedit within tabpage_2
end type
type rb_1 from radiobutton within tabpage_2
end type
type rb_2 from radiobutton within tabpage_2
end type
type rb_3 from radiobutton within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type tv_1 from u_tv_distinta within tabpage_3
end type
type cb_1 from commandbutton within tabpage_3
end type
type sle_1 from singlelineedit within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type gb_1 from groupbox within tabpage_3
end type
type sle_2 from singlelineedit within tabpage_3
end type
type sle_3 from singlelineedit within tabpage_3
end type
type st_7 from statictext within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_4
end type
type cb_3 from commandbutton within tabpage_4
end type
type gb_3 from groupbox within tabpage_4
end type
type sle_5 from singlelineedit within tabpage_4
end type
type sle_6 from singlelineedit within tabpage_4
end type
type cb_6 from commandbutton within tabpage_4
end type
type tabpage_5 from userobject within tab_1
end type
type cb_a from commandbutton within tabpage_5
end type
type gb_5 from groupbox within tabpage_5
end type
type gb_a from groupbox within tabpage_5
end type
type sle_2a from singlelineedit within tabpage_5
end type
type sle_3a from singlelineedit within tabpage_5
end type
type cb_4a from commandbutton within tabpage_5
end type
type cb_7 from commandbutton within tabpage_5
end type
type cb_agg_riga from commandbutton within tabpage_5
end type
type cb_sostituisci from commandbutton within tabpage_5
end type
type cb_elimina from commandbutton within tabpage_5
end type
type cb_8 from commandbutton within tabpage_5
end type
type rb_1a from radiobutton within tabpage_5
end type
type rb_2a from radiobutton within tabpage_5
end type
type rb_3a from radiobutton within tabpage_5
end type
type dw_sost from u_dw_master_main within tabpage_5
end type
type tv_variante from u_tv_distinta within tabpage_5
end type
type lb_1 from listbox within tabpage_5
end type
type st_3 from statictext within tabpage_5
end type
type sle_4 from singlelineedit within tabpage_5
end type
type st_4 from statictext within tabpage_5
end type
type cb_var_comp from commandbutton within tabpage_5
end type
type tabpage_6 from userobject within tab_1
end type
type cb_5 from commandbutton within tabpage_6
end type
type dw_esp from datawindow within tabpage_6
end type
type dw_distinta_base_gd from datawindow within tabpage_6
end type
type dw_distinta_ext_gd from datawindow within tabpage_6
end type
type dw_mag_multi from datawindow within tabpage_6
end type
type cb_9 from commandbutton within tabpage_6
end type
type tabpage_2 from userobject within tab_1
dw_valorizza_tot_ff dw_valorizza_tot_ff
cb_2 cb_2
tv_2 tv_2
gb_4 gb_4
gb_2 gb_2
sle_din sle_din
sle_dfin sle_dfin
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
st_2 st_2
cb_4 cb_4
end type
type tabpage_3 from userobject within tab_1
tv_1 tv_1
cb_1 cb_1
sle_1 sle_1
st_1 st_1
gb_1 gb_1
sle_2 sle_2
sle_3 sle_3
st_7 st_7
end type
type tabpage_4 from userobject within tab_1
dw_1 dw_1
cb_3 cb_3
gb_3 gb_3
sle_5 sle_5
sle_6 sle_6
cb_6 cb_6
end type
type tabpage_5 from userobject within tab_1
cb_a cb_a
gb_5 gb_5
gb_a gb_a
sle_2a sle_2a
sle_3a sle_3a
cb_4a cb_4a
cb_7 cb_7
cb_agg_riga cb_agg_riga
cb_sostituisci cb_sostituisci
cb_elimina cb_elimina
cb_8 cb_8
rb_1a rb_1a
rb_2a rb_2a
rb_3a rb_3a
dw_sost dw_sost
tv_variante tv_variante
lb_1 lb_1
st_3 st_3
sle_4 sle_4
st_4 st_4
cb_var_comp cb_var_comp
end type
type tabpage_6 from userobject within tab_1
cb_5 cb_5
dw_esp dw_esp
dw_distinta_base_gd dw_distinta_base_gd
dw_distinta_ext_gd dw_distinta_ext_gd
dw_mag_multi dw_mag_multi
cb_9 cb_9
end type
end forward

global type w_valorizzazione_ff from w_p_data
int Width=2967
int Height=1852
boolean TitleBar=true
string Title="Valorizzazione Distinta"
end type
global w_valorizzazione_ff w_valorizzazione_ff

type variables
datastore ids_testa,ids_righe
string is_operazione[]
long is_eliminate[]
string is_drag

end variables

forward prototypes
public subroutine wf_esplodi_distinta ()
end prototypes

public subroutine wf_esplodi_distinta ();
dati dat
treeviewitem tvi_esplodi
s_val ls_val
integer li_anno
date ld_1,ld_2
tab_1.tabpage_5.tv_variante.deleteitem(0)
string testa,ls_tipo_applicazione,ls_tipo_calcolo
long ll_root,id,id_art,ll_row,ll_magazzino,ll_handle,ll_id_distinta,ll_valuta,ll_id_sog_commerciale
tab_1.tabpage_5.tv_variante.ib_completa=true
testa=ids_testa.getitemstring(1,"articolo_codice")
id_art=ids_testa.getitemnumber(1,"id_articolo")
id=ids_testa.getitemnumber(1,"id_distinta")
dat.path=ids_testa.getitemstring(1,"articolo_immagine")
if testa<>"" and isnull(testa)=false then
	dat.quantita=1
	dat.id_dis_figlio=id
	dat.id_distinta=id
	dat.id_articolo=id_art
	tvi_esplodi.data=dat
	tvi_esplodi.label=testa
	tvi_esplodi.pictureindex=4
	tvi_esplodi.selectedpictureindex=4
	tvi_esplodi.Expanded=true
end if
treeview t
t=tab_1.tabpage_5.tv_variante
li_anno=year(today())
ld_1=date(tab_1.tabpage_5.sle_2a.text)
ld_2=date(tab_1.tabpage_5.sle_3a.text)
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
ll_row=tab_1.tabpage_1.dw_mag.getrow()
ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
ls_tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
ls_tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
if isnull(ll_valuta) then
	select id_valuta
	into :ll_valuta
	from par_sistema;
end if
ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
ls_val=f_valorizza(tab_1.tabpage_5.tv_variante,ll_handle,true,id,ld_1,ld_2,id,ls_tipo_calcolo,ls_tipo_applicazione,ll_magazzino,false,ll_valuta,ll_id_sog_commerciale)	
tab_1.tabpage_5.sle_4.text=string(ls_val.costo_componenti+ls_val.altri_costi,'#,0.0000')
end subroutine

event open;call super::open;idw_master = tab_1.tabpage_1.dw_distinta_base_ff
idw_master.is_list = Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_distinta"
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "distinta.id_distinta"
ib_nonmodale=true


end event

on w_valorizzazione_ff.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_valorizzazione_ff.destroy
call super::destroy
end on

event ue_post_open;call super::ue_post_open;
datawindowchild ldwc_magazzino
long ll_row,ll_mag
ll_row=tab_1.tabpage_1.dw_mag.rowcount()
if ll_row>0 then
	tab_1.tabpage_1.dw_mag.deleterow(ll_row)
end if
ll_row=tab_1.tabpage_1.dw_mag.insertrow(0)
tab_1.tabpage_1.dw_mag.getchild("magazzino",ldwc_magazzino)
ldwc_magazzino.settransobject(sqlca)
ldwc_magazzino.retrieve()
select id_magazzino
into :ll_mag
from par_sistema;
tab_1.tabpage_1.dw_mag.setitem(ll_row,"magazzino",ll_mag)
long ll_valuta
tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
if isnull(ll_valuta) or ll_valuta<=0 then
	select id_valuta
	into :ll_valuta
	from par_sistema;
	tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"distinta_id_valuta",ll_valuta)
	tab_1.tabpage_1.dw_distinta_base_ff.setitemstatus(1,0,primary!,notmodified!)
end if

datawindowchild ldwc_listino, ldwc_listino_des
datawindowchild ldwc_listino_a, ldwc_listino_des_a

tab_1.tabpage_2.dw_valorizza_tot_ff.getchild("id_listino_2",ldwc_listino_des)
ldwc_listino_des.settransobject(sqlca)
ldwc_listino_des.retrieve()

tab_1.tabpage_2.dw_valorizza_tot_ff.getchild("id_listino",ldwc_listino)
ldwc_listino.settransobject(sqlca)
ldwc_listino.retrieve()

tab_1.tabpage_1.dw_distinta_base_ff.getchild("id_listino_2",ldwc_listino_des_a)
ldwc_listino_des_a.settransobject(sqlca)
ldwc_listino_des_a.retrieve()

tab_1.tabpage_1.dw_distinta_base_ff.getchild("id_listino",ldwc_listino_a)
ldwc_listino_a.settransobject(sqlca)
ldwc_listino_a.retrieve()
end event

event close;call super::close;if isvalid(ids_testa) then destroy(ids_testa)
if isvalid(ids_righe) then destroy(ids_righe)

end event

event ue_update;call super::ue_update;
string ls_check
long ll_id_listino, ll_id_variazione, ll_id_articolo, ll_id_u_conf, ll_id_app, ll_row
decimal ld_vendita

ll_row = tab_1.tabpage_2.dw_valorizza_tot_ff.getrow() 

if ll_row > 0 then 
	ls_check = tab_1.tabpage_2.dw_valorizza_tot_ff.getitemstring(1,"chk_prezzo")
else 
	ls_check = 'N'
end if
if ls_check = 'S' then
	ll_id_listino = tab_1.tabpage_2.dw_valorizza_tot_ff.getitemnumber(1,"id_listino")		
	ld_vendita = tab_1.tabpage_2.dw_valorizza_tot_ff.getitemnumber(1,"vendita")
	ll_id_articolo = tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_articolo")
	
	select id_unita_confezione
	into :ll_id_u_conf
	from unita_confezione
	where id_articolo = :ll_id_articolo;
	
	

	select max(id_variazione)
	into :ll_id_variazione
	from variazione
	where id_listino = :ll_id_listino and year(data_inizio) = year(today());
	
	
	select id_variazione
	into :ll_id_app
	from prezzo 
	where id_variazione = :ll_id_variazione
	and id_unita_confezione = :ll_id_u_conf;	
	
	
	if sqlca.sqlcode = 0 then
		update prezzo
		set prezzo = :ld_vendita
		where id_variazione = :ll_id_variazione
		and id_unita_confezione = :ll_id_u_conf;
	else
		insert into prezzo (prezzo.id_unita_confezione, prezzo.id_variazione, prezzo.prezzo)
		values (:ll_id_u_conf, :ll_id_variazione, :ld_vendita);
	end if
	
	commit;	
	
end if
end event

type p_crescente from w_p_data`p_crescente within w_valorizzazione_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_valorizzazione_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_valorizzazione_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_valorizzazione_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_valorizzazione_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_valorizzazione_ff
int X=2080
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_valorizzazione_ff
int X=2377
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_valorizzazione_ff
int X=2674
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_valorizzazione_ff
int X=32
int Y=176
int Width=2903
int Height=1580
int TabOrder=10
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_5
this.Control[iCurrent+5]=this.tabpage_6
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event tab_1::selectionchanged;call super::selectionchanged;datawindowchild ldwc_magazzino
long ll_mag,ll_row,ll_id_distinta
string ls_cod
choose case newindex
	case 5 
		
		
		tab_1.tabpage_5.lb_1.reset()
		ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
		declare dis cursor for
			select codice
			from distinta
			where id_dis_base=:ll_id_distinta
			and id_distinta<>:ll_id_distinta;
		open dis;
		do while sqlca.sqlcode=0 
			fetch dis into :ls_cod;
			if sqlca.sqlcode=0 then
				tab_1.tabpage_5.lb_1.insertitem(ls_cod,1)
			end if
		loop
		close dis;
	case 6
		tab_1.tabpage_6.dw_distinta_base_gd.settransobject(sqlca)
		tab_1.tabpage_6.dw_distinta_base_gd.retrieve()
		
		ll_row=tab_1.tabpage_6.dw_mag_multi.rowcount()
		if ll_row>0 then
			tab_1.tabpage_6.dw_mag_multi.deleterow(ll_row)
		end if
		ll_row=tab_1.tabpage_6.dw_mag_multi.insertrow(0)
		tab_1.tabpage_6.dw_mag_multi.getchild("magazzino",ldwc_magazzino)
		ldwc_magazzino.settransobject(sqlca)
		ldwc_magazzino.retrieve()
		select id_magazzino
		into :ll_mag
		from par_sistema;
		tab_1.tabpage_6.dw_mag_multi.setitem(ll_row,"magazzino",ll_mag)
end choose
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2866
int Height=1460
long BackColor=79741120
string Text="Distinta"
long TabBackColor=79741120
dw_distinta_base_ff dw_distinta_base_ff
dw_mag dw_mag
cb_10 cb_10
st_5 st_5
sle_qta sle_qta
st_6 st_6
end type

on tabpage_1.create
this.dw_distinta_base_ff=create dw_distinta_base_ff
this.dw_mag=create dw_mag
this.cb_10=create cb_10
this.st_5=create st_5
this.sle_qta=create sle_qta
this.st_6=create st_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_distinta_base_ff
this.Control[iCurrent+2]=this.dw_mag
this.Control[iCurrent+3]=this.cb_10
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.sle_qta
this.Control[iCurrent+6]=this.st_6
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_distinta_base_ff)
destroy(this.dw_mag)
destroy(this.cb_10)
destroy(this.st_5)
destroy(this.sle_qta)
destroy(this.st_6)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_valorizzazione_ff
int X=1783
boolean BringToTop=true
end type

event cb_ricerca::clicked;string ls_tipo_ricarico

w_search_main lw_sm
long ll_id_distinta
s_ric_param ls_ricpar
idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_distinta_base_sw")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
		
	ll_id_distinta = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_distinta"
	idw_master.is_list.l_identifica[1] = ll_id_distinta
	idw_master.Event ue_retrieve(0, 0)
END IF
idw_master.SetFocus()


ls_tipo_ricarico = tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_ricarico")
if isnull(ls_tipo_ricarico) then
   tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"tipo_ricarico",'I')
   tab_1.tabpage_2.dw_valorizza_tot_ff.setitem(1,"tipo_ricarico",'I')
end if
end event

type dw_distinta_base_ff from u_dw_master_main within tabpage_1
int X=23
int Y=36
int Width=2807
int Height=1404
int TabOrder=21
string DataObject="d_distinta_base_val_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_distinta"
iudw_children[1]=tab_1.tabpage_5.dw_sost
end event

event ue_set_search;call super::ue_set_search;choose case as_nomecol
		CASE "ccod_cli"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="codice"
end choose
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "ccod_cli"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
END CHOOSE
end event

event itemchanged;
choose case dwo.name
case "tipo_ricarico"
	tab_1.tabpage_2.dw_valorizza_tot_ff.setitem(1,"tipo_ricarico",data)
end choose
end event

type dw_mag from datawindow within tabpage_1
int X=1623
int Y=676
int Width=1088
int Height=100
int TabOrder=22
boolean BringToTop=true
string DataObject="d_mag_val_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_10 from commandbutton within tabpage_1
int X=2021
int Y=1068
int Width=297
int Height=92
int TabOrder=23
boolean BringToTop=true
string Text="Fabbisogno"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_id_dis
string ls_tipo_applicazione,ls_tipo_cal_valore
s_fabbisogno s_app
ll_id_dis=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
ls_tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
ls_tipo_cal_valore=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
if ll_id_dis>0  and (ls_tipo_cal_valore<>"" or not isnull(ls_tipo_cal_valore ))then
	integer li_anno
	li_anno=year(today())
	
	
	open(w_data_val_ff)
	
	
	
	
	dati dat
	dat=message.powerobjectparm
	date ld_1,ld_2
	ld_1=dat.data_inizio
	ld_2=dat.data_fine
	if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
	if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
	s_app.tipo_applicazione=ls_tipo_applicazione
	s_app.tipo_cal_valore=ls_tipo_cal_valore
	s_app.id_distinta=ll_id_dis
	s_app.data_inizio=ld_1
	s_app.data_fine=ld_2
	s_app.quantita=dec(sle_qta.text)
	openwithparm(w_fabbisogno_distinta_ff,s_app)
else
	messagebox("Informazione","Non è stata selezionata nessuna distinta~r~no non si è scelto il tipo di calcolo!")
end if
end event

type st_5 from statictext within tabpage_1
int X=1623
int Y=852
int Width=1088
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="STAMPA FABBISOGNO"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_qta from singlelineedit within tabpage_1
int X=2011
int Y=948
int Width=311
int Height=92
int TabOrder=24
boolean BringToTop=true
boolean AutoHScroll=false
string Text="1"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within tabpage_1
int X=1737
int Y=956
int Width=265
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Quantità:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2866
int Height=1460
long BackColor=79741120
string Text="Totale / Aggiornamento Costo"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_valorizza_tot_ff dw_valorizza_tot_ff
cb_2 cb_2
tv_2 tv_2
gb_4 gb_4
gb_2 gb_2
sle_din sle_din
sle_dfin sle_dfin
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
st_2 st_2
cb_4 cb_4
end type

on tabpage_2.create
this.dw_valorizza_tot_ff=create dw_valorizza_tot_ff
this.cb_2=create cb_2
this.tv_2=create tv_2
this.gb_4=create gb_4
this.gb_2=create gb_2
this.sle_din=create sle_din
this.sle_dfin=create sle_dfin
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.st_2=create st_2
this.cb_4=create cb_4
this.Control[]={this.dw_valorizza_tot_ff,&
this.cb_2,&
this.tv_2,&
this.gb_4,&
this.gb_2,&
this.sle_din,&
this.sle_dfin,&
this.rb_1,&
this.rb_2,&
this.rb_3,&
this.st_2,&
this.cb_4}
end on

on tabpage_2.destroy
destroy(this.dw_valorizza_tot_ff)
destroy(this.cb_2)
destroy(this.tv_2)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.sle_din)
destroy(this.sle_dfin)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.st_2)
destroy(this.cb_4)
end on

type dw_valorizza_tot_ff from u_dw_ext_main within tabpage_2
int X=23
int Y=36
int Width=2807
int Height=500
int TabOrder=2
string DataObject="d_valorizza_tot_ff"
end type

type cb_2 from commandbutton within tabpage_2
int X=23
int Y=660
int Width=256
int Height=92
int TabOrder=21
boolean BringToTop=true
string Text="Valorizza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_handle,ll_id_distinta,ll_magazzino,ll_valuta,ll_id_sog_commerciale
string ls_cod,tipo_applicazione,tipo_calcolo, tipo_ricarico
decimal ld_ricarico
string ls_codice, ls_descrizione, ls_tipo
string ls_des_listino
long ll_id_listino

s_val ls_val
tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")

tv_2.deleteitem(0)
ll_handle=tv_2.FindItem(RootTreeItem! , 0)
if ll_handle= -1 then
	treeviewitem tvi_esplodi
	ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
	if ll_id_distinta>0 then
		ls_cod=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
		ll_handle=tv_2.FindItem(childTreeItem! , 0)
		tvi_esplodi.label=ls_cod
		integer li_anno
		li_anno=year(today())
		
		
		open(w_data_val_ff)
		
		
		
		
		dati dat
		dat=message.powerobjectparm
		date ld_1,ld_2
		ld_1=dat.data_inizio
		ld_2=dat.data_fine
		if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
		if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
		sle_din.text=string(ld_1,'dd/mm/yyyy')
		sle_dfin.text=string(ld_2,'dd/mm/yyyy')
		decimal ld_ret
		long ll_row
		ll_row=tab_1.tabpage_1.dw_mag.getrow()
		ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
		ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
		if isnull(ll_valuta) then
			select id_valuta
			into :ll_valuta
			from par_sistema;
		end if
		
		
		
		if tipo_applicazione = 'V' then
			ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
		else
			ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_listino")
			
			if isnull(ll_id_sog_commerciale) or ll_id_sog_commerciale = 0 then
		
				select id_listino, codice, descrizione, tipo
				into :ll_id_listino, :ls_codice, :ls_descrizione, :ls_tipo
				from listino
				where listino.tipo = 'A' and listino.lis_base = 'S';

				ll_id_sog_commerciale = ll_id_listino
			end if
		end if
		
		
		
		u_tv_distinta luo_distinta
		f_rec_righe_comp(tv_2,0,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,false)
		if upperbound(tv_2.is_comp) >0 then 
			luo_distinta=create u_tv_distinta
			luo_distinta.is_comp=tv_2.is_comp
			openwithparm(w_variante_comp_ff,luo_distinta)
			luo_distinta=message.powerobjectparm
			if isvalid(luo_distinta) then 
				tv_2.is_comp=luo_distinta.is_comp
			else
				messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
			end if
			destroy luo_distinta			
		end if
		tv_2.deleteitem(0)	
		ls_val=f_valorizza_comp(tv_2,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,tipo_calcolo,tipo_applicazione,ll_magazzino,false,ll_valuta,ll_id_sog_commerciale)
		dw_valorizza_tot_ff.insertrow(0)
		
		
		tipo_ricarico = tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_ricarico")
		tab_1.tabpage_2.dw_valorizza_tot_ff.setitem(1,"tipo_ricarico",tipo_ricarico)
		
		
		
		select id_listino, codice, descrizione, tipo
		into :ll_id_listino, :ls_codice, :ls_descrizione, :ls_tipo
		from listino
		where listino.tipo = 'V' and listino.lis_base = 'S';

		ls_des_listino = " "+ ls_codice +", "+ ls_descrizione+ " TIPO [ "+ ls_tipo +" ]"
		dw_valorizza_tot_ff.setitem(1,"id_listino",ll_id_listino)
		
		dw_valorizza_tot_ff.setitem(1,"chk_prezzo","S")
		
		
		ld_ricarico=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"ricarico")
		dw_valorizza_tot_ff.setitem(1,"ricarico",ld_ricarico)
		dw_valorizza_tot_ff.setitem(1,"costo_com",ls_val.costo_componenti)
		dw_valorizza_tot_ff.setitem(1,"altri_costi",ls_val.altri_costi)				
	end if
end if
end event

type tv_2 from u_tv_distinta within tabpage_2
int X=1737
int Y=576
int Width=658
int Height=288
int TabOrder=2
boolean Visible=false
end type

type gb_4 from groupbox within tabpage_2
int X=23
int Y=1056
int Width=608
int Height=320
int TabOrder=22
string Text="Tipo Aggiornamento"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within tabpage_2
int X=485
int Y=576
int Width=928
int Height=220
int TabOrder=22
string Text="Date Validazione"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_din from singlelineedit within tabpage_2
int X=521
int Y=656
int Width=384
int Height=92
int TabOrder=23
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dfin from singlelineedit within tabpage_2
int X=983
int Y=656
int Width=384
int Height=92
int TabOrder=24
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within tabpage_2
int X=50
int Y=1116
int Width=361
int Height=76
boolean BringToTop=true
string Text="Ultimo Costo"
boolean Checked=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within tabpage_2
int X=50
int Y=1196
int Width=361
int Height=76
boolean BringToTop=true
string Text="Costo Medio"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within tabpage_2
int X=50
int Y=1276
int Width=567
int Height=76
boolean BringToTop=true
string Text="Costo Medio Continuo"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tabpage_2
int X=23
int Y=940
int Width=2807
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="AGGIORNAMENTO COSTI"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_4 from commandbutton within tabpage_2
int X=901
int Y=1172
int Width=293
int Height=92
int TabOrder=23
boolean BringToTop=true
string Text="Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_handle,ll_id_distinta,ll_magazzino,ll_valuta,ll_id_sog_commerciale
string ls_cod,tipo_applicazione,tipo_calcolo
decimal ld_ricarico
s_val ls_val
tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
if rb_1.checked=true then tipo_calcolo='U'
if rb_2.checked=true then tipo_calcolo='M'
if rb_3.checked=true then tipo_calcolo='C'
tv_2.deleteitem(0)
ll_handle=tv_2.FindItem(RootTreeItem! , 0)
		if ll_handle= -1 then
			treeviewitem tvi_esplodi
			ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
			if ll_id_distinta>0 then
				ls_cod=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
				ll_handle=tv_2.FindItem(childTreeItem! , 0)
				tvi_esplodi.label=ls_cod
				integer li_anno
				li_anno=year(today())
				
				
				open(w_data_val_ff)
				
				
				
				
				dati dat
				dat=message.powerobjectparm
				date ld_1,ld_2
				ld_1=dat.data_inizio
				ld_2=dat.data_fine
				if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
				if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
				sle_din.text=string(ld_1,'dd/mm/yyyy')
				sle_dfin.text=string(ld_2,'dd/mm/yyyy')
				decimal ld_ret
				long ll_row
				ll_row=tab_1.tabpage_1.dw_mag.getrow()
				ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
				ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
				if isnull(ll_valuta) then
					select id_valuta
					into :ll_valuta
					from par_sistema;
				end if
				ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
				ls_val=f_valorizza(tv_2,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,tipo_calcolo,tipo_applicazione,ll_magazzino,true,ll_valuta,ll_id_sog_commerciale)			
				tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"tipo_aggiornamento",tipo_calcolo)
				tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"data_ora_ult_agg",datetime(today(),now()))
				tab_1.tabpage_1.dw_distinta_base_ff.setitem(1,"distinta_id_valuta",ll_valuta)				
				ib_askforsave=false
				tab_1.tabpage_1.dw_distinta_base_ff.event post ue_update(0,0)
			end if
		end if
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2866
int Height=1460
long BackColor=79741120
string Text="Con Esplosione"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
tv_1 tv_1
cb_1 cb_1
sle_1 sle_1
st_1 st_1
gb_1 gb_1
sle_2 sle_2
sle_3 sle_3
st_7 st_7
end type

on tabpage_3.create
this.tv_1=create tv_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.gb_1=create gb_1
this.sle_2=create sle_2
this.sle_3=create sle_3
this.st_7=create st_7
this.Control[]={this.tv_1,&
this.cb_1,&
this.sle_1,&
this.st_1,&
this.gb_1,&
this.sle_2,&
this.sle_3,&
this.st_7}
end on

on tabpage_3.destroy
destroy(this.tv_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.sle_2)
destroy(this.sle_3)
destroy(this.st_7)
end on

type tv_1 from u_tv_distinta within tabpage_3
int X=23
int Y=96
int Width=2217
int Height=1220
int TabOrder=2
end type

type cb_1 from commandbutton within tabpage_3
int X=2432
int Y=36
int Width=256
int Height=92
int TabOrder=22
boolean BringToTop=true
string Text="Valorizza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_handle,ll_id_distinta,ll_magazzino,ll_valuta,ll_id_sog_commerciale
string ls_cod,tipo_applicazione,tipo_calcolo
string ls_codice, ls_descrizione, ls_tipo
string ls_des_listino
long ll_id_listino

s_val ls_val
tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
tab_1.tabpage_3.tv_1.deleteitem(0)
ll_handle=tab_1.tabpage_3.tv_1.FindItem(RootTreeItem! , 0)
		if ll_handle= -1 then
			treeviewitem tvi_esplodi
			ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
			if ll_id_distinta>0 then
				ls_cod=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
				ll_handle=tab_1.tabpage_3.tv_1.FindItem(childTreeItem! , 0)
				tvi_esplodi.label=ls_cod
				integer li_anno
				li_anno=year(today())
				
				
				open(w_data_val_ff)
				
				
				
				
				dati dat
				dat=message.powerobjectparm
				date ld_1,ld_2
				ld_1=dat.data_inizio
				ld_2=dat.data_fine
				if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
				if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
				sle_2.text=string(ld_1,'dd/mm/yyyy')
				sle_3.text=string(ld_2,'dd/mm/yyyy')
				decimal ld_ret
				long ll_row
				ll_row=tab_1.tabpage_1.dw_mag.getrow()
				ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
				ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
				if isnull(ll_valuta) then
					select id_valuta
					into :ll_valuta
					from par_sistema;
				end if

				
				
				
				if tipo_applicazione = 'V' then
					ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
				else
					ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_listino")
			
					if isnull(ll_id_sog_commerciale) or ll_id_sog_commerciale = 0 then
		
						select id_listino, codice, descrizione, tipo
						into :ll_id_listino, :ls_codice, :ls_descrizione, :ls_tipo
						from listino
						where listino.tipo = 'A' and listino.lis_base = 'S';

						ll_id_sog_commerciale = ll_id_listino
					end if
				end if
				
				
				u_tv_distinta luo_distinta
				f_rec_righe_comp(tab_1.tabpage_3.tv_1,0,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,false)
				if upperbound(tab_1.tabpage_3.tv_1.is_comp) >0 then 
					luo_distinta=create u_tv_distinta
					luo_distinta.is_comp=tab_1.tabpage_3.tv_1.is_comp
					openwithparm(w_variante_comp_ff,luo_distinta)
					luo_distinta=message.powerobjectparm
					if isvalid(luo_distinta) then 
						tab_1.tabpage_3.tv_1.is_comp=luo_distinta.is_comp
					else
						messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
					end if
					destroy luo_distinta
				end if
				tab_1.tabpage_3.tv_1.deleteitem(0)
				ls_val=f_valorizza_comp(tab_1.tabpage_3.tv_1,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,tipo_calcolo,tipo_applicazione,ll_magazzino,false,ll_valuta,ll_id_sog_commerciale)
				sle_1.text=string(ls_val.costo_componenti+ls_val.altri_costi,'#,0.0000')
			end if
		end if
end event

type sle_1 from singlelineedit within tabpage_3
int X=279
int Y=1340
int Width=1938
int Height=92
int TabOrder=3
boolean BringToTop=true
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within tabpage_3
int X=23
int Y=1340
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Totale:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within tabpage_3
int X=2327
int Y=176
int Width=471
int Height=320
int TabOrder=21
string Text="Date Validazione"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within tabpage_3
int X=2368
int Y=256
int Width=384
int Height=92
int TabOrder=22
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within tabpage_3
int X=2368
int Y=380
int Width=384
int Height=92
int TabOrder=23
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within tabpage_3
int X=23
int Y=16
int Width=1769
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="N.Riga - Codice Articolo - Simbolo valuta - Prezzo - Quantita "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=2866
int Height=1460
long BackColor=79741120
string Text="Raggruppata"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_1 dw_1
cb_3 cb_3
gb_3 gb_3
sle_5 sle_5
sle_6 sle_6
cb_6 cb_6
end type

on tabpage_4.create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.gb_3=create gb_3
this.sle_5=create sle_5
this.sle_6=create sle_6
this.cb_6=create cb_6
this.Control[]={this.dw_1,&
this.cb_3,&
this.gb_3,&
this.sle_5,&
this.sle_6,&
this.cb_6}
end on

on tabpage_4.destroy
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.gb_3)
destroy(this.sle_5)
destroy(this.sle_6)
destroy(this.cb_6)
end on

type dw_1 from datawindow within tabpage_4
int X=23
int Y=256
int Width=2807
int Height=1180
int TabOrder=21
boolean BringToTop=true
string DataObject="d_prova_esp"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within tabpage_4
int X=23
int Y=96
int Width=256
int Height=92
int TabOrder=3
boolean BringToTop=true
string Text="Valorizza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_handle,ll_id_distinta,ll_magazzino,ll_id_sog_commerciale
string ls_cod,tipo_applicazione,tipo_calcolo
s_val ls_val
dw_1.reset()
tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
tab_1.tabpage_2.tv_2.deleteitem(0)
ll_handle=tab_1.tabpage_2.tv_2.FindItem(RootTreeItem! , 0)
		if ll_handle= -1 then
			treeviewitem tvi_esplodi
			ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
			if ll_id_distinta>0 then
				ls_cod=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
				ll_handle=tab_1.tabpage_2.tv_2.FindItem(childTreeItem! , 0)
				tvi_esplodi.label=ls_cod
				integer li_anno
				li_anno=year(today())
				
				
				open(w_data_val_ff)
				
				
				
				
				dati dat
				dat=message.powerobjectparm
				date ld_1,ld_2
				ld_1=dat.data_inizio
				ld_2=dat.data_fine
				if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
				if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
				sle_5.text=string(ld_1,'dd/mm/yyyy')
				sle_6.text=string(ld_2,'dd/mm/yyyy')
				decimal ld_ret
				long ll_row
				ll_row=tab_1.tabpage_1.dw_mag.getrow()
				ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
				ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
				u_tv_distinta luo_distinta
				f_rec_righe_comp(tab_1.tabpage_2.tv_2,0,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,false)
				if upperbound(tab_1.tabpage_2.tv_2.is_comp) >0 then 
					luo_distinta=create u_tv_distinta
					luo_distinta.is_comp=tab_1.tabpage_2.tv_2.is_comp
					openwithparm(w_variante_comp_ff,luo_distinta)
					luo_distinta=message.powerobjectparm
					if isvalid(luo_distinta) then 
						tab_1.tabpage_2.tv_2.is_comp=luo_distinta.is_comp
						destroy luo_distinta;
					else
						messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
						destroy luo_distinta;
						return
					end if
									
				end if
			
				tab_1.tabpage_2.tv_2.deleteitem(0)
				
				ls_val=f_esplodi_dw(tab_1.tabpage_2.tv_2,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,tipo_calcolo,tipo_applicazione,ll_magazzino,false,dw_1,ll_id_sog_commerciale)
				
			end if
		end if
end event

type gb_3 from groupbox within tabpage_4
int X=361
int Y=16
int Width=928
int Height=220
int TabOrder=22
string Text="Date Validazione"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_5 from singlelineedit within tabpage_4
int X=402
int Y=96
int Width=384
int Height=92
int TabOrder=23
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_6 from singlelineedit within tabpage_4
int X=855
int Y=96
int Width=384
int Height=92
int TabOrder=24
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_6 from commandbutton within tabpage_4
int X=1536
int Y=96
int Width=261
int Height=92
int TabOrder=14
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datastore lds_stampa
long ll_row,i
string ls_cod_dis,ls_des_dis,ls_cod_art_testa,ls_des_art_testa,ls_listino,ls_tipo_val
string ls_cod_art,ls_des_art
decimal{4} ld_costo_art,ld_costo_dis
decimal{2} ld_quantita
if dw_1.rowcount()>0 and tab_1.tabpage_1.dw_distinta_base_ff.rowcount()>0 then
	lds_stampa=create datastore
	lds_stampa.dataobject='d_stampa_val'	
	for i= 1 to dw_1.rowcount()			
		ll_row=lds_stampa.insertrow(0)
		if ll_row=1 then
			ls_cod_dis=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"codice")
			ls_des_dis=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"descrizione")
			ls_cod_art_testa=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_codice")
			ls_des_art_testa=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"articolo_descrizione")
			ls_tipo_val=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
			ld_costo_dis=dw_1.getitemdecimal(1,"costo_tot")
			if ls_tipo_val='L' then
				ls_listino=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
				if ls_listino='A' then
					ls_listino='Acquisto'			
				else
					ls_listino='Vendita'
				end if
			else
				setnull(ls_listino)
			end if
			lds_stampa.setitem(1,"cod_distinta",ls_cod_dis)
			lds_stampa.setitem(1,"des_distinta",ls_des_dis)
			lds_stampa.setitem(1,"cod_art_testa",ls_cod_art_testa)
			lds_stampa.setitem(1,"des_art_testa",ls_des_art_testa)
			lds_stampa.setitem(1,"costo_dis",ld_costo_dis)
			lds_stampa.setitem(1,"listino",ls_listino)				
		end if
		ls_cod_art=dw_1.getitemstring(i,"codice")
		ls_des_art=dw_1.getitemstring(i,"descrizione")
		ld_costo_art=dw_1.getitemdecimal(i,"costo")
		ld_quantita=dw_1.getitemdecimal(i,"quantita")
		
		lds_stampa.setitem(ll_row,"cod_art",ls_cod_art)
		lds_stampa.setitem(ll_row,"des_art",ls_des_art)
		lds_stampa.setitem(ll_row,"costo_art",ld_costo_art)
		lds_stampa.setitem(ll_row,"quantita_art",ld_quantita)
	next
	printsetup()
	lds_stampa.print()
	destroy lds_stampa
end if
end event

type tabpage_5 from userobject within tab_1
int X=18
int Y=104
int Width=2866
int Height=1460
long BackColor=79741120
string Text="Varianti"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_a cb_a
gb_5 gb_5
gb_a gb_a
sle_2a sle_2a
sle_3a sle_3a
cb_4a cb_4a
cb_7 cb_7
cb_agg_riga cb_agg_riga
cb_sostituisci cb_sostituisci
cb_elimina cb_elimina
cb_8 cb_8
rb_1a rb_1a
rb_2a rb_2a
rb_3a rb_3a
dw_sost dw_sost
tv_variante tv_variante
lb_1 lb_1
st_3 st_3
sle_4 sle_4
st_4 st_4
cb_var_comp cb_var_comp
end type

on tabpage_5.create
this.cb_a=create cb_a
this.gb_5=create gb_5
this.gb_a=create gb_a
this.sle_2a=create sle_2a
this.sle_3a=create sle_3a
this.cb_4a=create cb_4a
this.cb_7=create cb_7
this.cb_agg_riga=create cb_agg_riga
this.cb_sostituisci=create cb_sostituisci
this.cb_elimina=create cb_elimina
this.cb_8=create cb_8
this.rb_1a=create rb_1a
this.rb_2a=create rb_2a
this.rb_3a=create rb_3a
this.dw_sost=create dw_sost
this.tv_variante=create tv_variante
this.lb_1=create lb_1
this.st_3=create st_3
this.sle_4=create sle_4
this.st_4=create st_4
this.cb_var_comp=create cb_var_comp
this.Control[]={this.cb_a,&
this.gb_5,&
this.gb_a,&
this.sle_2a,&
this.sle_3a,&
this.cb_4a,&
this.cb_7,&
this.cb_agg_riga,&
this.cb_sostituisci,&
this.cb_elimina,&
this.cb_8,&
this.rb_1a,&
this.rb_2a,&
this.rb_3a,&
this.dw_sost,&
this.tv_variante,&
this.lb_1,&
this.st_3,&
this.sle_4,&
this.st_4,&
this.cb_var_comp}
end on

on tabpage_5.destroy
destroy(this.cb_a)
destroy(this.gb_5)
destroy(this.gb_a)
destroy(this.sle_2a)
destroy(this.sle_3a)
destroy(this.cb_4a)
destroy(this.cb_7)
destroy(this.cb_agg_riga)
destroy(this.cb_sostituisci)
destroy(this.cb_elimina)
destroy(this.cb_8)
destroy(this.rb_1a)
destroy(this.rb_2a)
destroy(this.rb_3a)
destroy(this.dw_sost)
destroy(this.tv_variante)
destroy(this.lb_1)
destroy(this.st_3)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.cb_var_comp)
end on

type cb_a from commandbutton within tabpage_5
int X=690
int Y=36
int Width=389
int Height=92
int TabOrder=23
boolean BringToTop=true
string Text="Nuova Variante"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

if isvalid(ids_testa) then destroy(ids_testa)
if isvalid(ids_righe) then destroy(ids_righe)
tab_1.tabpage_5.tv_variante.DeleteItem (0 )
long ll_id_distinta,ll_handle,ll_app[],ll_dis_var,ll_magazzino,ll_row,ll_valuta,ll_id_sog_commerciale
s_val ls_val
string ls_cod,ls_app[],ls_tipo_calcolo,ls_tipo_applicazione
dati dat
treeviewitem tvi_esplodi
integer li_anno
date ld_1,ld_2
ll_dis_var=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
if ll_dis_var>0 then
	is_operazione=ls_app
	is_eliminate=ll_app
	ll_handle=tab_1.tabpage_5.tv_variante.FindItem(RootTreeItem! , 0)
	if ll_handle= -1 then
	
	
	
	
		li_anno=year(today())
		open(w_data_val_ff)
		dat=message.powerobjectparm
		ld_1=dat.data_inizio
		ld_2=dat.data_fine
		if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
		if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
		sle_2a.text=string(ld_1,'dd/mm/yyyy')
		sle_3a.text=string(ld_2,'dd/mm/yyyy')	
	
	
		ids_testa=create datastore
		ids_righe=create datastore
		ids_testa.dataobject='d_distinta_base_ff'
		ids_righe.dataobject='ds_riga_dis_base_lt'
		ids_testa.settransobject(sqlca)
		ids_righe.settransobject(sqlca)
		
		tab_1.tabpage_1.dw_distinta_base_ff.rowscopy(1,1,primary!,ids_testa,1,primary!)
		
		
		ll_dis_var=ids_testa.getitemnumber(1,"id_distinta")
		ids_testa.setitem(1,"id_dis_base", ll_dis_var)
		setnull(ll_dis_var)
		string a
		setnull(a)
		ids_testa.setitem(1,"id_distinta", ll_dis_var)
		ids_testa.setitem(1,"data_ora_creazione",datetime(today(),now()))
		ids_testa.setitem(1,"data_ora_ult_cambiamento",datetime(today(),now()))
		ids_testa.setitem(1,"tipo_aggiornamento", a)
		ids_testa.setitem(1,"data_ora_ult_agg", ll_dis_var)
		ids_testa.setitem(1,"codice", "")
		ids_testa.setitem(1,"descrizione","")
		ids_testa.setitem(1,"articolo_codice", "")
		ids_testa.setitem(1,"articolo_descrizione","")
		ids_testa.setitem(1,"id_articolo", ll_dis_var)
		
		openwithparm(w_ins_testa_ff,ids_testa)
		
		ids_testa=message.powerobjectparm
		
		
		
		
		if isvalid(ids_testa) then
			integer ret	
			ret=ids_testa.update(true,true)
			if ret= -1 then 
				messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
			else
				ll_dis_var=ids_testa.getitemnumber(1,"id_distinta")
				is_operazione[1]='T'
				
				tv_variante.deleteitem(0)
				
				
				
				string testa
				long ll_root,id,id_art
				ll_id_distinta=ids_testa.getitemnumber(1,"id_distinta")
				treeview t
				t=tv_variante
	
				ll_row=tab_1.tabpage_1.dw_mag.getrow()
				ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
				ls_tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
				ls_tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
				ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
				if isnull(ll_valuta) then
					select id_valuta
					into :ll_valuta
					from par_sistema;
				end if
				
				ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
				ls_val=f_valorizza(tab_1.tabpage_5.tv_variante,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,ls_tipo_calcolo,ls_tipo_applicazione,ll_magazzino,false,ll_valuta,ll_id_sog_commerciale)	
				sle_4.text=string(ls_val.costo_componenti+ls_val.altri_costi,'#,0.0000')	
				
				
				
				cb_4a.enabled=true
				cb_7.enabled=true
				cb_elimina.enabled=true
				cb_sostituisci.enabled=true
				cb_agg_riga.enabled=true	
			end if
		end if
	end if
end if	

end event

type gb_5 from groupbox within tabpage_5
int X=32
int Y=844
int Width=448
int Height=240
int TabOrder=24
string Text="Sost. Articolo"
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_a from groupbox within tabpage_5
int X=658
int Y=232
int Width=448
int Height=284
int TabOrder=24
string Text="Data Validazione "
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2a from singlelineedit within tabpage_5
int X=713
int Y=288
int Width=338
int Height=92
int TabOrder=22
boolean BringToTop=true
boolean AutoHScroll=false
boolean DisplayOnly=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3a from singlelineedit within tabpage_5
int X=713
int Y=392
int Width=338
int Height=92
int TabOrder=23
boolean BringToTop=true
boolean AutoHScroll=false
boolean DisplayOnly=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_4a from commandbutton within tabpage_5
int X=690
int Y=528
int Width=389
int Height=92
int TabOrder=24
boolean Enabled=false
boolean BringToTop=true
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_app[]
string ls_app[]
if isvalid(ids_testa) then destroy(ids_testa)
if isvalid(ids_righe) then destroy(ids_righe)
tv_variante.deleteitem(0)
is_operazione=ls_app
is_eliminate=ll_app


long ll_id_distinta
string ls_cod
tab_1.tabpage_5.lb_1.reset()
ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
declare dis cursor for
	select codice
	from distinta
	where id_dis_base=:ll_id_distinta
	and id_distinta<>:ll_id_distinta;
open dis;
do while sqlca.sqlcode=0 
	fetch dis into :ls_cod;
	if sqlca.sqlcode=0 then
		tab_1.tabpage_5.lb_1.insertitem(ls_cod,1)
	end if
loop
close dis;


cb_4a.enabled=false
cb_7.enabled=false
cb_elimina.enabled=false
cb_sostituisci.enabled=false
cb_agg_riga.enabled=false	
end event

type cb_7 from commandbutton within tabpage_5
int X=690
int Y=628
int Width=389
int Height=92
int TabOrder=25
boolean Enabled=false
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_dim
ll_dim=upperbound(is_operazione)
do while ll_dim>0 
	cb_8.event trigger clicked()
	ll_dim=upperbound(is_operazione)
loop
if isvalid(ids_testa) then destroy(ids_testa)
if isvalid(ids_righe) then destroy(ids_righe)


cb_4a.enabled=false
cb_7.enabled=false
cb_elimina.enabled=false
cb_sostituisci.enabled=false
cb_agg_riga.enabled=false	
end event

type cb_agg_riga from commandbutton within tabpage_5
int X=690
int Y=736
int Width=389
int Height=92
int TabOrder=22
boolean Enabled=false
boolean BringToTop=true
string Text="Aggiungi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dati dat,dat_app
treeviewitem tvi_esplodi
s_mod_variante ls_aggiunta
long ll_righe,ll_righe_old,ll_dis,ll_id_art,ll_riga_art,ll_dimensione
integer li_anno
date ld_1,ld_2
ll_righe_old=ids_righe.rowcount()
ll_riga_art=dw_sost.rowcount()
ll_riga_art=dw_sost.getrow()
if ll_riga_art>0 then ll_id_art=dw_sost.getitemnumber(ll_riga_art,"sostituzione_id_art_sostitutivo")
if ll_id_art> 0 and not isnull(ll_id_art) then
	ls_aggiunta.datas=ids_righe
	ls_aggiunta.id_articolo=ll_id_art
	setnull(ls_aggiunta.num_riga)
	openwithparm(w_ins_riga_ff,ls_aggiunta)
	
	
	
	ll_righe=ids_righe.rowcount()
	if ll_righe<>ll_righe_old then
		ll_dis=ids_testa.getitemnumber(1,"id_distinta")
		ids_righe.setitem(ll_righe,"id_distinta",ll_dis)
		long handle,ll_con,ll_numr
		
		handle=tv_variante.finditem(currenttreeitem!,0)
		handle=tv_variante.finditem(parenttreeitem!,handle)
		if handle= -1 then
			handle=tv_variante.finditem(roottreeitem!,0)
		end if
		
		
		tv_variante.getitem(handle,tvi_esplodi)
		dat=tvi_esplodi.data
		ll_dis=dat.id_distinta
		ids_righe.setitem(ll_righe,"riga_distinta_id_dis_var",ll_dis)
		
		ll_con=ids_righe.update(true,true)
		if ll_con= -1 then 
			messagebox("Errore","Si è verificato un errore nel salvataggio della riga!")
		else
			ll_dimensione=upperbound(is_operazione)
			if isnull(ll_dimensione) then ll_dimensione=0
			is_operazione[ll_dimensione+1]='A'
			wf_esplodi_distinta()
		end if
	end if

else
	messagebox("Informazione","Si deve prima selezionare un articoilo!")
end if
end event

type cb_sostituisci from commandbutton within tabpage_5
int X=690
int Y=836
int Width=389
int Height=92
int TabOrder=23
boolean Enabled=false
boolean BringToTop=true
string Text="Sostituisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_dim
long handle,ll_riga,ll_dis_testa,ll_dimensione,ll_con
treeviewitem ltvi_app,tvi_esplodi
dati dat
integer li_anno
date ld_1,ld_2
dati dat_app
s_mod_variante ls_aggiunta
long ll_righe,ll_righe_old,ll_dis,ll_id_art,ll_riga_art
ll_righe_old=ids_righe.rowcount()
ll_riga_art=dw_sost.rowcount()
ll_riga_art=dw_sost.getrow()
if ll_riga_art>0 then ll_id_art=dw_sost.getitemnumber(ll_riga_art,"sostituzione_id_art_sostitutivo")
if ll_id_art> 0 and not isnull(ll_id_art) then
	handle=tv_variante.finditem(currenttreeitem!,0)
	tv_variante.getitem(handle,ltvi_app)
	dat_app=ltvi_app.data
	ls_aggiunta.num_riga=dat_app.num_riga
	ls_aggiunta.datas=ids_righe
	ls_aggiunta.id_articolo=ll_id_art
	openwithparm(w_ins_riga_ff,ls_aggiunta)
	
	
	
	ll_righe=ids_righe.rowcount()
	if ll_righe<>ll_righe_old then
		ll_dis=ids_testa.getitemnumber(1,"id_distinta")
		ids_righe.setitem(ll_righe,"id_distinta",ll_dis)
		long ll_numr
		
		handle=tv_variante.finditem(currenttreeitem!,0)
		handle=tv_variante.finditem(parenttreeitem!,handle)
		if handle= -1 then
			handle=tv_variante.finditem(roottreeitem!,0)	
		end if
		
		
		tv_variante.getitem(handle,tvi_esplodi)
		dat=tvi_esplodi.data
		ll_dis=dat.id_distinta
		ids_righe.setitem(ll_righe,"riga_distinta_id_dis_var",ll_dis)
		
		ll_con=ids_righe.update(true,true)
		if ll_con= -1 then 
			messagebox("Errore","Si è verificato un errore nel salvataggio della riga!")
		else
			ll_dimensione=upperbound(is_operazione)
			if isnull(ll_dimensione) then ll_dimensione=0
			is_operazione[ll_dimensione+1]='A'
			
			
			handle=tv_variante.finditem(currenttreeitem!,0)
			if handle<>-1 then
				tv_variante.getitem(handle,ltvi_app)
				dat=ltvi_app.data
				ll_riga=dat.id_riga
				ll_dis_testa=ids_testa.getitemnumber(1,"id_distinta")
				insert into var_riga_distinta (id_riga_distinta,id_dis_variante)
				values (:ll_riga,:ll_dis_testa);
				ll_dimensione=upperbound(is_eliminate)
				is_eliminate[ll_dimensione + 1]=ll_riga
				ll_dimensione=upperbound(is_operazione)
				is_operazione[ll_dimensione + 1]='E'
			end if
			wf_esplodi_distinta()
			ll_dim=upperbound(is_operazione)
			is_operazione[ll_dim + 1]='S'
		end if
	else
	end if
else
	messagebox("Informazione","Si deve prima selezionare un articoilo!")
end if




end event

type cb_elimina from commandbutton within tabpage_5
int X=690
int Y=940
int Width=389
int Height=92
int TabOrder=24
boolean Enabled=false
boolean BringToTop=true
string Text="Elimina"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long handle,ll_riga,ll_dis_testa,ll_dimensione
treeviewitem ltvi_app,tvi_esplodi
dati dat
integer li_anno
date ld_1,ld_2
handle=tv_variante.finditem(currenttreeitem!,0)
if handle<>-1 then
	tv_variante.getitem(handle,ltvi_app)
	dat=ltvi_app.data
	ll_riga=dat.id_riga
	ll_dis_testa=ids_testa.getitemnumber(1,"id_distinta")
	insert into var_riga_distinta (id_riga_distinta,id_dis_variante)
	values (:ll_riga,:ll_dis_testa);
	ll_dimensione=upperbound(is_eliminate)
	is_eliminate[ll_dimensione + 1]=ll_riga
	ll_dimensione=upperbound(is_operazione)
	is_operazione[ll_dimensione + 1]='E'
	wf_esplodi_distinta()
end if
end event

type cb_8 from commandbutton within tabpage_5
int X=690
int Y=1036
int Width=389
int Height=92
int TabOrder=25
boolean BringToTop=true
string Text="Undo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_dimensione,i,ll_app[]
string ls_app[],ls_app2[]
boolean lb_esplodi
dati dat
treeviewitem tvi_esplodi
integer li_anno
date ld_1,ld_2
long ll_righe,ll_riga,ll_dis
string ls_stato
long ll_dim,ll_nriga,ll_dis_testa
lb_esplodi=false
ll_dimensione=upperbound(is_operazione)
if ll_dimensione>0 then
	choose case is_operazione[ll_dimensione]
		case 'A'
			lb_esplodi=true
			ll_righe=ids_righe.rowcount()
			if ll_righe>0 then
				ids_righe.deleterow(ll_righe)
				ids_righe.update(true,true)
			end if
		case 'T'
			ll_riga=ids_testa.rowcount()
			ids_testa.deleterow(ll_riga)
			ids_testa.update(true,true)
			tv_variante.deleteitem(0)
			
			cb_4a.enabled=false
			cb_7.enabled=false
			cb_elimina.enabled=false
			cb_sostituisci.enabled=false
			cb_agg_riga.enabled=false	
		case 'S'
			lb_esplodi=true
			FOR i=1 TO ll_dimensione - 1
				ls_app[i]=is_operazione[i]
			NEXT
			is_operazione=ls_app
			lb_esplodi=true
			ll_righe=ids_righe.rowcount()
			if ll_righe>0 then
				ids_righe.deleterow(ll_righe)
				ids_righe.update(true,true)
			end if
			ls_app=ls_app2
			ll_dimensione=upperbound(is_operazione)
			FOR i=1 TO ll_dimensione - 1
				ls_app[i]=is_operazione[i]
			NEXT
			is_operazione=ls_app
			lb_esplodi=true
			ll_dim=upperbound(is_eliminate)
			ll_nriga=is_eliminate[ll_dim]
			ll_dis_testa=ids_testa.getitemnumber(1,"id_distinta")
			delete from var_riga_distinta 
			where id_dis_variante=:ll_dis_testa
			and id_riga_distinta=:ll_nriga;
			
			if ll_dim >1 then
				FOR i=1 TO ll_dim - 1
					ll_app[i]=is_eliminate[i]
				NEXT
			end if
			is_eliminate=ll_app
		case 'E'
			lb_esplodi=true
			ll_dim=upperbound(is_eliminate)
			ll_nriga=is_eliminate[ll_dim]
			ll_dis_testa=ids_testa.getitemnumber(1,"id_distinta")
			delete from var_riga_distinta 
			where id_dis_variante=:ll_dis_testa
			and id_riga_distinta=:ll_nriga;
			
			if ll_dim >1 then
				FOR i=1 TO ll_dim - 1
					ll_app[i]=is_eliminate[i]
				NEXT
			end if
			is_eliminate=ll_app
			
	end choose
			
end if	

ls_app=ls_app2
ll_dimensione=upperbound(is_operazione)
if ll_dimensione >1 then
	FOR i=1 TO ll_dimensione - 1
		ls_app[i]=is_operazione[i]
	NEXT
end if
is_operazione=ls_app

if lb_esplodi=true then
	wf_esplodi_distinta()
end if
end event

type rb_1a from radiobutton within tabpage_5
int X=73
int Y=896
int Width=265
int Height=60
boolean BringToTop=true
string Text="Gruppo "
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;treeviewitem ltvi_art
dati dat
long ll_handle,ll_gruppo
ll_handle=tv_variante.finditem(currenttreeitem!,0)
if ll_handle<> -1 then
	tv_variante.getitem(ll_handle,ltvi_art)
	dat=ltvi_art.data
	select id_gruppo_articoli
	into:ll_gruppo
	from articolo
	where id_articolo=:dat.id_articolo;
	if rb_1a.checked then 
		dw_sost.dataobject='d_gruppo_sost_gd'
		dw_sost.settransobject(sqlca)
		dw_sost.retrieve(ll_gruppo,dat.id_articolo)
	end if
end if
end event

type rb_2a from radiobutton within tabpage_5
int X=73
int Y=956
int Width=384
int Height=60
boolean BringToTop=true
string Text="Sostituzione"
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;treeviewitem ltvi_art
dati dat
long ll_handle
ll_handle=tv_variante.finditem(currenttreeitem!,0)
if ll_handle<> -1 then
	tv_variante.getitem(ll_handle,ltvi_art)
	dat=ltvi_art.data
	if rb_2a.checked then 
		dw_sost.dataobject='d_sost_art_gd'
		dw_sost.settransobject(sqlca)
		dw_sost.retrieve(dat.id_articolo)
	end if
end if
end event

type rb_3a from radiobutton within tabpage_5
int X=73
int Y=1020
int Width=247
int Height=60
boolean BringToTop=true
string Text="Tutti"
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_3a.checked then 
	dw_sost.dataobject='d_tutti_sost_gd'
	dw_sost.settransobject(sqlca)
	dw_sost.insertrow(1)
end if
end event

type dw_sost from u_dw_master_main within tabpage_5
int X=23
int Y=1136
int Width=2793
int Height=292
int TabOrder=3
string DataObject="d_sost_art_gd"
boolean HScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_articolo"
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "codice"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="codice"
	CASE "descrizione"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="descrizione"
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sostituzione_id_art_sostitutivo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])
		tab_1.tabpage_5.dw_sost.SetItemStatus (this.getrow(), 0, primary!, notmodified! )
	CASE "descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sostituzione_id_art_sostitutivo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		tab_1.tabpage_5.dw_sost.SetItemStatus (this.getrow(), 0, primary!, notmodified! )
END CHOOSE
end event

type tv_variante from u_tv_distinta within tabpage_5
int X=1120
int Y=36
int Width=1705
int Height=988
int TabOrder=25
end type

event selectionchanged;call super::selectionchanged;if rb_1a.checked then rb_1a.event trigger clicked()
if rb_2a.checked then rb_2a.event trigger clicked()
end event

type lb_1 from listbox within tabpage_5
int X=23
int Y=116
int Width=617
int Height=684
int TabOrder=4
boolean BringToTop=true
boolean HScrollBar=true
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event doubleclicked;s_val ls_val
tab_1.tabpage_5.tv_variante.DeleteItem (0 )
long ll_id_distinta,ll_handle,ll_magazzino,ll_row,ll_valuta,ll_id_sog_commerciale
string ls_cod,ls_dis,ls_tipo_applicazione,ls_tipo_calcolo
ll_handle=tab_1.tabpage_5.tv_variante.FindItem(RootTreeItem! , 0)
if ll_handle= -1 then
	treeviewitem tvi_esplodi
	ls_dis=this.SelectedItem ( )
	select articolo.codice,distinta.id_distinta
	into :ls_cod, :ll_id_distinta
	from distinta,articolo
	where distinta.codice=:ls_dis
	and distinta.id_articolo=articolo.id_articolo;
	ll_handle=tab_1.tabpage_5.tv_variante.FindItem(childTreeItem! , 0)
	tvi_esplodi.label=ls_cod
	integer li_anno
	li_anno=year(today())
	open(w_data_val_ff)
	dati dat
	dat=message.powerobjectparm
	date ld_1,ld_2
	ld_1=dat.data_inizio
	ld_2=dat.data_fine
	if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
	if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
	sle_2a.text=string(ld_1,'dd/mm/yyyy')
	sle_3a.text=string(ld_2,'dd/mm/yyyy')	
	ll_row=tab_1.tabpage_1.dw_mag.getrow()
	ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
	ls_tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
	ls_tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
	ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
	if isnull(ll_valuta) then
		select id_valuta
		into :ll_valuta
		from par_sistema;
	end if
	
	ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
	ls_val=f_valorizza(tab_1.tabpage_5.tv_variante,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,ls_tipo_calcolo,ls_tipo_applicazione,ll_magazzino,false,ll_valuta,ll_id_sog_commerciale)
	sle_4.text=string(ls_val.costo_componenti+ls_val.altri_costi,'#,0.0000')
	
	
	cb_4a.enabled=false
	cb_7.enabled=false
	cb_elimina.enabled=false
	cb_sostituisci.enabled=false
	cb_agg_riga.enabled=false
end if
end event

type st_3 from statictext within tabpage_5
int X=23
int Y=16
int Width=617
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="Varianti Esistenti"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_4 from singlelineedit within tabpage_5
int X=1417
int Y=1036
int Width=1413
int Height=92
int TabOrder=23
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within tabpage_5
int X=1257
int Y=1044
int Width=151
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Totale:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_var_comp from commandbutton within tabpage_5
int X=690
int Y=132
int Width=389
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="Variante Batch"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

if isvalid(ids_testa) then destroy(ids_testa)
if isvalid(ids_righe) then destroy(ids_righe)
tab_1.tabpage_5.tv_variante.DeleteItem (0 )
long ll_id_distinta,ll_handle,ll_app[],ll_dis_var,ll_magazzino,ll_row,ll_valuta,ll_id_sog_commerciale
s_val ls_val
string ls_cod,ls_app[],ls_tipo_calcolo,ls_tipo_applicazione
dati dat
treeviewitem tvi_esplodi
integer li_anno
date ld_1,ld_2
ll_id_distinta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_distinta")
if ll_id_distinta>0 then
	is_operazione=ls_app
	is_eliminate=ll_app
	ll_handle=tab_1.tabpage_5.tv_variante.FindItem(RootTreeItem! , 0)
	if ll_handle= -1 then
	
	
	
	
		li_anno=year(today())
		open(w_data_val_ff)
		dat=message.powerobjectparm
		ld_1=dat.data_inizio
		ld_2=dat.data_fine
		if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
		if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
		sle_2a.text=string(ld_1,'dd/mm/yyyy')
		sle_3a.text=string(ld_2,'dd/mm/yyyy')	

		treeview t
		t=tv_variante
	
	
		ll_row=tab_1.tabpage_1.dw_mag.getrow()
		ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
		ls_tipo_applicazione=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_applicazione")
		ls_tipo_calcolo=tab_1.tabpage_1.dw_distinta_base_ff.getitemstring(1,"tipo_cal_valore")
		ll_valuta=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"distinta_id_valuta")
		if isnull(ll_valuta) then
			select id_valuta
			into :ll_valuta
			from par_sistema;
		end if
		
		ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
		u_tv_distinta luo_distinta
		f_rec_righe_comp(tab_1.tabpage_5.tv_variante,0,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,false)
		if upperbound(tab_1.tabpage_5.tv_variante.is_comp) >0 then 
			luo_distinta=create u_tv_distinta
			luo_distinta.is_comp=tab_1.tabpage_5.tv_variante.is_comp
			openwithparm(w_variante_comp_ff,luo_distinta)
			luo_distinta=message.powerobjectparm
			if isvalid(luo_distinta) then 
				tab_1.tabpage_5.tv_variante.is_comp=luo_distinta.is_comp						
			else
				messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
			end if
			destroy luo_distinta;						
		else
			messagebox("Informazione","Impossibile creare una variante batch la distinta non contiene nessun articolo neutro!",information!)
		end if
		tab_1.tabpage_5.tv_variante.deleteitem(0)		
		ls_val=f_valorizza_comp(tab_1.tabpage_5.tv_variante,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,ls_tipo_calcolo,ls_tipo_applicazione,ll_magazzino,false,ll_valuta,ll_id_sog_commerciale)					
		sle_4.text=string(ls_val.costo_componenti+ls_val.altri_costi,'#,0.0000')	
	end if
end if

end event

type tabpage_6 from userobject within tab_1
int X=18
int Y=104
int Width=2866
int Height=1460
long BackColor=79741120
string Text="Multipla"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_5 cb_5
dw_esp dw_esp
dw_distinta_base_gd dw_distinta_base_gd
dw_distinta_ext_gd dw_distinta_ext_gd
dw_mag_multi dw_mag_multi
cb_9 cb_9
end type

on tabpage_6.create
this.cb_5=create cb_5
this.dw_esp=create dw_esp
this.dw_distinta_base_gd=create dw_distinta_base_gd
this.dw_distinta_ext_gd=create dw_distinta_ext_gd
this.dw_mag_multi=create dw_mag_multi
this.cb_9=create cb_9
this.Control[]={this.cb_5,&
this.dw_esp,&
this.dw_distinta_base_gd,&
this.dw_distinta_ext_gd,&
this.dw_mag_multi,&
this.cb_9}
end on

on tabpage_6.destroy
destroy(this.cb_5)
destroy(this.dw_esp)
destroy(this.dw_distinta_base_gd)
destroy(this.dw_distinta_ext_gd)
destroy(this.dw_mag_multi)
destroy(this.cb_9)
end on

type cb_5 from commandbutton within tabpage_6
int X=23
int Y=756
int Width=256
int Height=92
int TabOrder=23
boolean BringToTop=true
string Text="Valorizza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_handle,ll_id_distinta,ll_magazzino,ll_ndistinta,i,ll_row,ll_id_sog_commerciale
string ls_cod,tipo_applicazione,tipo_calcolo
s_val ls_val
dw_esp.reset()
ll_row=tab_1.tabpage_1.dw_mag.getrow()
ll_magazzino=tab_1.tabpage_1.dw_mag.getitemnumber(ll_row,"magazzino")
ll_ndistinta=dw_distinta_ext_gd.rowcount()
integer li_anno
li_anno=year(today())
open(w_data_val_ff)
dati dat
s_componente ls_comp[]
dat=message.powerobjectparm
date ld_1,ld_2
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
for i=1 to ll_ndistinta
	tab_1.tabpage_2.tv_2.is_comp=ls_comp
	tab_1.tabpage_2.tv_2.deleteitem(0)
	ll_handle=tab_1.tabpage_2.tv_2.FindItem(RootTreeItem! , 0)
	if ll_handle= -1 then
		treeviewitem tvi_esplodi
		ls_cod=dw_distinta_ext_gd.getitemstring(i,"codice")
		select id_distinta,tipo_applicazione,tipo_cal_valore
		into :ll_id_distinta,:tipo_applicazione,:tipo_calcolo
		from distinta
		where codice=:ls_cod;
		if ll_id_distinta>0 then
			ll_id_sog_commerciale=tab_1.tabpage_1.dw_distinta_base_ff.getitemnumber(1,"id_sog_commerciale")
			u_tv_distinta luo_distinta
			f_rec_righe_comp(tab_1.tabpage_2.tv_2,0,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,false)
			if upperbound(tab_1.tabpage_2.tv_2.is_comp) >0 then 
				luo_distinta=create u_tv_distinta
				luo_distinta.is_comp=tab_1.tabpage_2.tv_2.is_comp
				openwithparm(w_variante_comp_ff,luo_distinta)
				luo_distinta=message.powerobjectparm
				if isvalid(luo_distinta) then 
					tab_1.tabpage_2.tv_2.is_comp=luo_distinta.is_comp
					destroy luo_distinta;
				else
					messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
					destroy luo_distinta;
					return
				end if				
			end if	
			tab_1.tabpage_2.tv_2.deleteitem(0)				
			ls_val=f_esplodi_dw(tab_1.tabpage_2.tv_2,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,tipo_calcolo,tipo_applicazione,ll_magazzino,false,dw_esp,ll_id_sog_commerciale)
		end if
	end if
next
end event

type dw_esp from datawindow within tabpage_6
int X=23
int Y=860
int Width=2807
int Height=580
int TabOrder=25
boolean BringToTop=true
string DataObject="d_prova_esp"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_distinta_base_gd from datawindow within tabpage_6
int X=23
int Y=36
int Width=2807
int Height=352
int TabOrder=22
string DragIcon="S:\pb\commonframework\cometa.ico"
boolean BringToTop=true
string DataObject="d_distinta_base_gd"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;is_drag="dw_distinta_base_gd"
this.Drag(Begin!)
if this.isselected(row)=true then this.drag(end!)
end event

event dragdrop;if is_drag="dw_distinta_ext_gd" then
	string ls_cod
	long ll_row,ll_row2
	dw_esp.drag(end!)
	ll_row=dw_distinta_ext_gd.getrow()
	if ll_row>0 then
		ls_cod=dw_distinta_ext_gd.getitemstring(ll_row,"codice")	
		ll_row2=this.find("codice='"+ls_cod+"'",1,this.rowcount())
		this.selectrow(ll_row2,false)
		dw_distinta_ext_gd.deleterow(ll_row)
	end if
else
	this.drag(cancel!)
end if
end event

type dw_distinta_ext_gd from datawindow within tabpage_6
int X=23
int Y=396
int Width=2807
int Height=352
int TabOrder=24
string DragIcon="S:\pb\commonframework\cometa.ico"
boolean BringToTop=true
string DataObject="d_distinta_ext_gd"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;if is_drag="dw_distinta_base_gd" then
	dw_distinta_base_gd.Drag(End!)
	dw_distinta_base_gd.rowscopy(dw_distinta_base_gd.getrow(),dw_distinta_base_gd.getrow(),&
	primary!,this,9999,primary!)
	dw_distinta_base_gd.selectrow(dw_distinta_base_gd.getrow(),true)
else
	this.drag(cancel!)
end if
end event

event clicked;is_drag="dw_distinta_ext_gd"
this.Drag(Begin!)

end event

type dw_mag_multi from datawindow within tabpage_6
int X=1737
int Y=756
int Width=1088
int Height=100
int TabOrder=23
boolean BringToTop=true
string DataObject="d_mag_val_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_9 from commandbutton within tabpage_6
int X=325
int Y=756
int Width=247
int Height=92
int TabOrder=24
boolean BringToTop=true
string Text="Reset"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_distinta_base_gd.selectrow(0,false)
dw_distinta_ext_gd.reset()
dw_esp.reset()
end event

