forward
global type w_ins_riga_ff from Window
end type
type dw_ins_riga_ff from u_dw_ext_main within w_ins_riga_ff
end type
type cb_2 from commandbutton within w_ins_riga_ff
end type
type cb_1 from commandbutton within w_ins_riga_ff
end type
end forward

global type w_ins_riga_ff from Window
int X=417
int Y=113
int Width=2830
int Height=1217
boolean TitleBar=true
string Title="Inserimento Riga"
long BackColor=79741120
WindowType WindowType=response!
dw_ins_riga_ff dw_ins_riga_ff
cb_2 cb_2
cb_1 cb_1
end type
global w_ins_riga_ff w_ins_riga_ff

type variables
datastore ids_riga
end variables

event open;s_mod_variante s_datas
long ll_art,ll_num_riga
string ls_cod,ls_des
ids_riga=create  datastore
ids_riga.dataobject='ds_riga_dis_base_lt'
ids_riga.settransobject(sqlca)
s_datas=message.powerobjectparm
ids_riga=s_datas.datas
dw_ins_riga_ff.insertrow(1)
ll_art=s_datas.id_articolo
ll_num_riga=s_datas.num_riga
select codice,descrizione
into :ls_cod,:ls_des
from articolo
where id_articolo=:ll_art;
dw_ins_riga_ff.setitem(1,"riga_distinta_id_articolo",ll_art)
dw_ins_riga_ff.setitem(1,"articolo_codice",ls_cod)
dw_ins_riga_ff.setitem(1,"articolo_descrizione",ls_des)
dw_ins_riga_ff.setitem(1,"riga_distinta_num_riga",ll_num_riga)
if not isnull(s_datas.quantita) then
	dw_ins_riga_ff.setitem(1,"riga_distinta_quantita",s_datas.quantita)
end if
end event

on w_ins_riga_ff.create
this.dw_ins_riga_ff=create dw_ins_riga_ff
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.dw_ins_riga_ff,&
this.cb_2,&
this.cb_1}
end on

on w_ins_riga_ff.destroy
destroy(this.dw_ins_riga_ff)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type dw_ins_riga_ff from u_dw_ext_main within w_ins_riga_ff
int X=23
int Y=141
int Width=2766
int Height=961
int TabOrder=10
string DataObject="d_ins_riga_ff"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "articolo_codice"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_codice"
	CASE "articolo_descrizione"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_descrizione"
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;long ll_dis
CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_distinta_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
		select id_distinta
		into :ll_dis
		from distinta
		where id_articolo=:is_ricpar.s_id_seg_value[1];
		if sqlca.sqlcode=0 then
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))
		end if
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_distinta_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		select id_distinta
		into :ll_dis
		from distinta
		where id_articolo=:is_ricpar.s_id_seg_value[1];
		if sqlca.sqlcode=0 then
			uf_set_colval("riga_distinta_id_dis_figlio",string(ll_dis))
		end if
END CHOOSE
end event

type cb_2 from commandbutton within w_ins_riga_ff
int X=23
int Y=41
int Width=247
int Height=89
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_ins_riga_ff
int X=2542
int Y=41
int Width=247
int Height=89
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_art,ll_id_dis
integer li_num
string ls_tipo
decimal ld_quantita
ll_art=dw_ins_riga_ff.getitemnumber(1,"riga_distinta_id_articolo")
li_num=dw_ins_riga_ff.getitemnumber(1,"riga_distinta_num_riga")
ld_quantita=dw_ins_riga_ff.getitemnumber(1,"riga_distinta_quantita")
ls_tipo=dw_ins_riga_ff.getitemstring(1,"riga_distinta_tipo_riga")
select id_distinta
into :ll_id_dis
from distinta
where id_articolo=:ll_art;
if sqlca.sqlcode=0 then
	dw_ins_riga_ff.setitem(1,"riga_distinta_id_dis_figlio",ll_id_dis)
end if
if not isnull(ll_art) and not isnull(li_num) and not isnull(ld_quantita) and not isnull(ls_tipo) then
	dw_ins_riga_ff.rowscopy(1,1,primary!,ids_riga,99999,primary!)
	closewithreturn(parent,ids_riga)
else
	messagebox("Informazione","Si devo inserire almeno le informazioni obbligatorie!")
end if
end event

