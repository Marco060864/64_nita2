forward
global type w_aggiorna_costi_distinta_gd from w_np_single_data
end type
type gb_4 from groupbox within w_aggiorna_costi_distinta_gd
end type
type rb_1 from radiobutton within w_aggiorna_costi_distinta_gd
end type
type rb_2 from radiobutton within w_aggiorna_costi_distinta_gd
end type
type rb_3 from radiobutton within w_aggiorna_costi_distinta_gd
end type
type cb_4 from commandbutton within w_aggiorna_costi_distinta_gd
end type
type dw_mag from datawindow within w_aggiorna_costi_distinta_gd
end type
type tv_2 from treeview within w_aggiorna_costi_distinta_gd
end type
end forward

global type w_aggiorna_costi_distinta_gd from w_np_single_data
int X=8
int Y=199
int Width=3652
int Height=1476
boolean TitleBar=true
string Title="Aggiornamento Costi in Distinta"
gb_4 gb_4
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
cb_4 cb_4
dw_mag dw_mag
tv_2 tv_2
end type
global w_aggiorna_costi_distinta_gd w_aggiorna_costi_distinta_gd

event ue_post_open;call super::ue_post_open;datawindowchild ldwc_magazzino
long ll_row,ll_mag
ll_row=dw_mag.rowcount()
if ll_row>0 then
	dw_mag.deleterow(ll_row)
end if
ll_row=dw_mag.insertrow(0)
dw_mag.getchild("magazzino",ldwc_magazzino)
ldwc_magazzino.settransobject(sqlca)
ldwc_magazzino.retrieve()
select id_magazzino
into :ll_mag
from par_sistema;
dw_mag.setitem(ll_row,"magazzino",ll_mag)
end event

on w_aggiorna_costi_distinta_gd.create
int iCurrent
call w_np_single_data::create
this.gb_4=create gb_4
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.cb_4=create cb_4
this.dw_mag=create dw_mag
this.tv_2=create tv_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=gb_4
this.Control[iCurrent+2]=rb_1
this.Control[iCurrent+3]=rb_2
this.Control[iCurrent+4]=rb_3
this.Control[iCurrent+5]=cb_4
this.Control[iCurrent+6]=dw_mag
this.Control[iCurrent+7]=tv_2
end on

on w_aggiorna_costi_distinta_gd.destroy
call w_np_single_data::destroy
destroy(this.gb_4)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.cb_4)
destroy(this.dw_mag)
destroy(this.tv_2)
end on

event resize;
end event

type p_crescente from w_np_single_data`p_crescente within w_aggiorna_costi_distinta_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_aggiorna_costi_distinta_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_aggiorna_costi_distinta_gd
int X=22
int Width=3563
int Height=919
int TabOrder=30
string DataObject="d_distinta_agg_costi_gd"
end type

event dw_single::clicked;call super::clicked;if this.isselected(row)=true then
	selectrow(row,false)
else
	selectrow(row,true)	
end if
end event

type gb_4 from groupbox within w_aggiorna_costi_distinta_gd
int X=25
int Y=996
int Width=609
int Height=321
int TabOrder=40
string Text="Tipo Aggiornamento"
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_aggiorna_costi_distinta_gd
int X=50
int Y=1057
int Width=360
int Height=77
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

type rb_2 from radiobutton within w_aggiorna_costi_distinta_gd
int X=50
int Y=1137
int Width=360
int Height=77
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

type rb_3 from radiobutton within w_aggiorna_costi_distinta_gd
int X=50
int Y=1217
int Width=566
int Height=77
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

type cb_4 from commandbutton within w_aggiorna_costi_distinta_gd
int X=1878
int Y=1108
int Width=292
int Height=87
int TabOrder=10
boolean BringToTop=true
string Text="Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_handle,ll_id_distinta,ll_magazzino,ll_rows,i,ll_valuta,ll_val_proposta,ll_null
string ls_cod,tipo_applicazione,tipo_calcolo
decimal ld_ricarico
datetime ld_agg
s_val ls_val
integer li_anno
setnull(ll_null)
select id_valuta
into :ll_val_proposta
from par_sistema;
li_anno=year(today())
open(w_data_val_ff)
dati dat
dat=message.powerobjectparm
date ld_1,ld_2
ld_1=dat.data_inizio
ld_2=dat.data_fine
if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))
if rb_1.checked=true then tipo_calcolo='U'
if rb_2.checked=true then tipo_calcolo='M'
if rb_3.checked=true then tipo_calcolo='C'
ll_rows=dw_single.rowcount()
for i=1 to ll_rows 
	open(w_attesa)
	if dw_single.isselected(i)=true then
		tv_2.deleteitem(0)
		ll_handle=tv_2.FindItem(RootTreeItem! , 0)
			if ll_handle= -1 then
				treeviewitem tvi_esplodi
				ll_id_distinta=dw_single.getitemnumber(i,"id_distinta")
				select tipo_applicazione
				into :tipo_applicazione
				from distinta
				where id_distinta=:ll_id_distinta;
				if ll_id_distinta>0 then					
					decimal ld_ret
					long ll_row
					ll_row=dw_mag.getrow()
					ll_magazzino=dw_mag.getitemnumber(ll_row,"magazzino")
					ll_valuta=dw_single.getitemnumber(i,"id_valuta")
					if isnull(ll_valuta) then ll_valuta=ll_val_proposta
					
					
					ls_val=f_valorizza(tv_2,ll_handle,true,ll_id_distinta,ld_1,ld_2,ll_id_distinta,tipo_calcolo,tipo_applicazione,ll_magazzino,true,ll_valuta,ll_null)			
					ld_agg=datetime(today(),now())
					update distinta
					set tipo_aggiornamento=:tipo_calcolo,
					data_ora_ult_agg=:ld_agg,
					id_valuta=:ll_valuta
					where id_distinta=:ll_id_distinta;
				end if
			end if
		end if
	next
	close(w_attesa)
	dw_single.retrieve()
					
end event

type dw_mag from datawindow within w_aggiorna_costi_distinta_gd
int X=683
int Y=1108
int Width=1089
int Height=100
int TabOrder=20
boolean BringToTop=true
string DataObject="d_mag_val_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type tv_2 from treeview within w_aggiorna_costi_distinta_gd
int X=2489
int Y=1021
int Width=491
int Height=359
int TabOrder=11
boolean Visible=false
boolean BringToTop=true
string PictureName[]={"Custom039!"}
long PictureMaskColor=536870912
long StatePictureMaskColor=536870912
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

