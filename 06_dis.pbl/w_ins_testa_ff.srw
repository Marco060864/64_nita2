forward
global type w_ins_testa_ff from Window
end type
type cb_1 from commandbutton within w_ins_testa_ff
end type
type cb_2 from commandbutton within w_ins_testa_ff
end type
type dw_1 from u_dw_ext_main within w_ins_testa_ff
end type
end forward

global type w_ins_testa_ff from Window
int X=417
int Y=61
int Width=2903
int Height=1693
boolean TitleBar=true
string Title="Distinta Variante"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_ins_testa_ff w_ins_testa_ff

type variables
datastore ids_testa
end variables

on w_ins_testa_ff.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_ins_testa_ff.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;ids_testa=create  datastore
ids_testa.dataobject='d_distinta_base_ff'
ids_testa.settransobject(sqlca)
ids_testa=message.powerobjectparm
dw_1.object.valuta_t.visible=false
dw_1.object.distinta_id_valuta.visible=false	

ids_testa.rowscopy(1,1,primary!,dw_1,9999,primary!)
end event

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

type cb_1 from commandbutton within w_ins_testa_ff
int X=2588
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

event clicked;long ll_art
string ls_tipo,ls_cod
ll_art=dw_1.getitemnumber(1,"id_articolo")
ls_cod=dw_1.getitemstring(1,"codice")
ls_tipo=dw_1.getitemstring(1,"tipo_applicazione")
if not isnull(ll_art) and not isnull(ls_cod)  and not isnull(ls_tipo) then
	ids_testa.deleterow(1)
	dw_1.rowscopy(1,1,primary!,ids_testa,1,primary!)
	closewithreturn(parent,ids_testa)
else
	messagebox("Informazione","Si devo inserire almeno le informazioni obbligatorie!")
end if
end event

type cb_2 from commandbutton within w_ins_testa_ff
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

type dw_1 from u_dw_ext_main within w_ins_testa_ff
int X=23
int Y=141
int Width=2812
int Height=1421
int TabOrder=10
string DataObject="d_distinta_base_ff"
end type

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "articolo_codice"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="codice"
	CASE "articolo_descrizione"
			is_search_window = "w_ric_articolo_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="descrizione"
END CHOOSE
end event

event itemchanged;call super::itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok
CHOOSE CASE dwo.name
	case "articolo_codice"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
	case "articolo_descrizione"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)

end choose
end event

