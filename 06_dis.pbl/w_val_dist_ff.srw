forward
global type w_val_dist_ff from Window
end type
type tv_2 from u_tv_distinta within w_val_dist_ff
end type
type cb_1 from commandbutton within w_val_dist_ff
end type
type sle_din from singlelineedit within w_val_dist_ff
end type
type sle_dfin from singlelineedit within w_val_dist_ff
end type
type dw_1 from u_dw_master_main within w_val_dist_ff
end type
type gb_2 from groupbox within w_val_dist_ff
end type
type dw_mag from datawindow within w_val_dist_ff
end type
end forward

global type w_val_dist_ff from Window
int X=1051
int Y=480
int Width=3122
int Height=1452
boolean TitleBar=true
string Title="Valorizzazione Distinte"
long BackColor=80133307
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
tv_2 tv_2
cb_1 cb_1
sle_din sle_din
sle_dfin sle_dfin
dw_1 dw_1
gb_2 gb_2
dw_mag dw_mag
end type
global w_val_dist_ff w_val_dist_ff

on w_val_dist_ff.create
this.tv_2=create tv_2
this.cb_1=create cb_1
this.sle_din=create sle_din
this.sle_dfin=create sle_dfin
this.dw_1=create dw_1
this.gb_2=create gb_2
this.dw_mag=create dw_mag
this.Control[]={this.tv_2,&
this.cb_1,&
this.sle_din,&
this.sle_dfin,&
this.dw_1,&
this.gb_2,&
this.dw_mag}
end on

on w_val_dist_ff.destroy
destroy(this.tv_2)
destroy(this.cb_1)
destroy(this.sle_din)
destroy(this.sle_dfin)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.dw_mag)
end on

event open;dw_1.settransobject(sqlca)
dw_1.insertrow(0)

dw_mag.settransobject(sqlca)
dw_mag.insertrow(0)
end event

type tv_2 from u_tv_distinta within w_val_dist_ff
int X=2354
int Y=980
int Width=658
int Height=288
int TabOrder=20
boolean Visible=false
long StatePictureMaskColor=553648127
long BackColor=1090387453
FontCharSet FontCharSet=Ansi!
end type

type cb_1 from commandbutton within w_val_dist_ff
int X=951
int Y=1056
int Width=256
int Height=108
int TabOrder=50
string Text="Valorizza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_handle,ll_id_distinta,ll_magazzino,ll_valuta,ll_id_sog_commerciale
string ls_cod,tipo_applicazione,tipo_calcolo, tipo_ricarico
decimal ld_ricarico
string ls_codice, ls_descrizione, ls_tipo
string ls_des_listino, ls_cod1, ls_cod2
long ll_id_listino, ll_row
integer li_cont
long ll_row2

s_val ls_val

ls_cod1 = dw_1.getitemstring(1,"cod_dist1")
ls_cod2 = dw_1.getitemstring(1,"cod_dist2")
ll_id_listino = dw_1.getitemnumber(1,"id_listino")	
ll_row2=dw_mag.getrow()
ll_magazzino=dw_mag.getitemnumber(ll_row2,"magazzino")

DATASTORE ds_dist  
ds_dist = CREATE DATASTORE
ds_dist.DATAOBJECT = "ds_val_dist"
ds_dist.SETTRANSOBJECT(SQLCA)

ll_row=ds_dist.RETRIEVE(ls_cod1,ls_cod2) 

if ll_row > 0 and (not isnull(ll_id_listino) or ll_id_listino > 0) and (not isnull(ll_magazzino) or ll_magazzino > 0) then

open(w_data_val_ff)
dati dat
dat=message.powerobjectparm	
		
FOR li_cont=1 TO ll_row

	tipo_applicazione=ds_dist.getitemstring(li_cont,"distinta_tipo_applicazione")
	tipo_calcolo=ds_dist.getitemstring(li_cont,"distinta_tipo_cal_valore")

	tv_2.deleteitem(0)
	ll_handle=tv_2.FindItem(RootTreeItem! , 0)
	if ll_handle= -1 then
		treeviewitem tvi_esplodi
		ll_id_distinta=ds_dist.getitemnumber(li_cont,"distinta_id_distinta")
		
		if ll_id_distinta>0 then
			ls_cod=ds_dist.getitemstring(li_cont,"articolo_codice")
		ll_handle=tv_2.FindItem(childTreeItem! , 0)
		tvi_esplodi.label=ls_cod
		integer li_anno
		li_anno=year(today())




		date ld_1,ld_2
		ld_1=dat.data_inizio
		ld_2=dat.data_fine
		if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
		if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
		sle_din.text=string(ld_1,'dd/mm/yyyy')
		sle_dfin.text=string(ld_2,'dd/mm/yyyy')
		decimal ld_ret
		
		ll_row2=dw_mag.getrow()
		ll_magazzino=dw_mag.getitemnumber(ll_row2,"magazzino")
		ll_valuta=ds_dist.getitemnumber(li_cont,"distinta_id_valuta")
		if isnull(ll_valuta) then
			select id_valuta
			into :ll_valuta
			from par_sistema;
		end if
		
		if tipo_applicazione = 'V' then
			ll_id_sog_commerciale=ds_dist.getitemnumber(li_cont,"id_sog_commerciale")
		else
			ll_id_sog_commerciale=ds_dist.getitemnumber(li_cont,"id_listino")
			
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

		tipo_ricarico = ds_dist.getitemstring(li_cont,"tipo_ricarico")

		select id_listino, codice, descrizione, tipo
		into :ll_id_listino, :ls_codice, :ls_descrizione, :ls_tipo
		from listino
		where listino.tipo = 'V' and listino.lis_base = 'S';

		ls_des_listino = " "+ ls_codice +", "+ ls_descrizione+ " TIPO [ "+ ls_tipo +" ]"
   	ld_ricarico=ds_dist.getitemnumber(li_cont,"distinta_ricarico")

		long ll_id_variazione, ll_id_articolo, ll_id_u_conf, ll_id_app
		decimal ld_vendita
		
		if tipo_ricarico = 'P' then
			ld_vendita = (ls_val.costo_componenti + ls_val.altri_costi) * ( (ld_ricarico +100) /100) 
		else
			ld_vendita = (ls_val.costo_componenti + ls_val.altri_costi + ld_ricarico) 
		end if

		
			ll_id_listino = dw_1.getitemnumber(1,"id_listino")		
			ll_id_articolo = ds_dist.getitemnumber(li_cont,"distinta_id_articolo")
			
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
	end if

NEXT
end if
destroy ds_dist
end event

type sle_din from singlelineedit within w_val_dist_ff
int X=1358
int Y=1072
int Width=384
int Height=92
int TabOrder=40
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dfin from singlelineedit within w_val_dist_ff
int X=1819
int Y=1072
int Width=384
int Height=92
int TabOrder=60
boolean BringToTop=true
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from u_dw_master_main within w_val_dist_ff
int X=37
int Y=156
int Width=2990
int Height=784
int TabOrder=10
string DataObject="d_sel_dist"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE	"cod_dist1"
		is_search_window="w_distinta_base_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
	CASE	"des_dist1"
		is_search_window="w_distinta_base_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="descrizione"
	CASE	"cod_dist2"
		is_search_window="w_distinta_base_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
	CASE	"des_dist2"
		is_search_window="w_distinta_base_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="descrizione"	
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE	"cod_dist1"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_distinta1",is_ricpar.s_id_seg_value[1])
			uf_set_colval("cod_dist1",is_ricpar.s_ausil_value[1])			
			uf_set_colval("des_dist1",is_ricpar.s_ausil_value[2])			
				
	CASE	"des_dist1"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_distinta1",is_ricpar.s_id_seg_value[1])
			uf_set_colval("cod_dist1",is_ricpar.s_ausil_value[1])			
			uf_set_colval("des_dist1",is_ricpar.s_ausil_value[2])			
			
	CASE	"cod_dist2"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_distinta2",is_ricpar.s_id_seg_value[1])
			uf_set_colval("cod_dist2",is_ricpar.s_ausil_value[1])			
			uf_set_colval("des_dist2",is_ricpar.s_ausil_value[2])			
			
	CASE	"des_dist2"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_distinta2",is_ricpar.s_id_seg_value[1])
			uf_set_colval("cod_dist2",is_ricpar.s_ausil_value[1])			
			uf_set_colval("des_dist2",is_ricpar.s_ausil_value[2])			
END CHOOSE
end event

event getfocus;
end event

event losefocus;
end event

event ue_key;
end event

type gb_2 from groupbox within w_val_dist_ff
int X=1321
int Y=992
int Width=928
int Height=220
int TabOrder=30
string Text="Date Validazione"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_mag from datawindow within w_val_dist_ff
int X=1879
int Y=748
int Width=1083
int Height=96
int TabOrder=60
boolean BringToTop=true
string DataObject="d_mag_val_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

