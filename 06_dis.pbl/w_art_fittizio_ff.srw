forward
global type w_art_fittizio_ff from Window
end type
type mle_1 from multilineedit within w_art_fittizio_ff
end type
type cb_2 from commandbutton within w_art_fittizio_ff
end type
type cb_1 from commandbutton within w_art_fittizio_ff
end type
type dw_1 from u_dw_ext_main within w_art_fittizio_ff
end type
end forward

global type w_art_fittizio_ff from Window
int X=494
int Y=425
int Width=2862
int Height=989
boolean TitleBar=true
string Title="Sostituzione Articolo Fittizio"
long BackColor=79741120
WindowType WindowType=response!
mle_1 mle_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_art_fittizio_ff w_art_fittizio_ff

on w_art_fittizio_ff.create
this.mle_1=create mle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.mle_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_art_fittizio_ff.destroy
destroy(this.mle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_cod_dis,ls_des_dis,ls_cod_art,ls_des_art
s_art_fittizio ls_art
ls_art=message.powerobjectparm
select codice,descrizione
into :ls_cod_dis,:ls_des_dis
from distinta 
where id_distinta=:ls_art.id_distinta;
select codice,descrizione
into :ls_cod_art,:ls_des_art
from articolo
where id_articolo=:ls_art.id_articolo;
mle_1.text="Artcolo Fittizio Da Sostituire"+&
"~r~nCodice Articolo: "+ls_cod_art+"~r~nDescrizione Articolo: "+ls_des_art+&
"~r~n~r~nNella Distinta"+&
"~r~nCodice Distinta: " +ls_cod_dis+"~r~nDescrizione Distinta: "+ls_des_dis 
dw_1.insertrow(1)
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

type mle_1 from multilineedit within w_art_fittizio_ff
int X=23
int Y=21
int Width=2789
int Height=461
int TabOrder=40
boolean DisplayOnly=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_art_fittizio_ff
int X=23
int Y=781
int Width=247
int Height=89
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_art_fittizio_ff
int X=2565
int Y=781
int Width=247
int Height=89
int TabOrder=30
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_art_fittizio ls_art
ls_art.id_articolo=dw_1.getitemnumber(1,"id_articolo")
ls_art.tipo_riga=dw_1.getitemstring(1,"tipo_riga")
ls_art.codice_art=dw_1.getitemstring(1,"codice")
if ls_art.id_articolo>0 then
		closewithreturn(parent,ls_art)
else
	messagebox("Informazione","Si deve prima scegliere un articolo!")
end if
end event

type dw_1 from u_dw_ext_main within w_art_fittizio_ff
int X=23
int Y=501
int Width=2789
int Height=261
int TabOrder=10
string DataObject="d_sost_art_fit_gd"
boolean HScrollBar=true
end type

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])
		parent.setfocus()
	CASE "descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		parent.setfocus()
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "codice"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_codice"
	CASE "descrizione"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_descrizione"
END CHOOSE
end event

