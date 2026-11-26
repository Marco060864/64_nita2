forward
global type w_classe_gd from w_np_single_data
end type
end forward

global type w_classe_gd from w_np_single_data
int Width=2181
boolean TitleBar=true
string Title="Classi"
long BackColor=80269524
end type
global w_classe_gd w_classe_gd

on w_classe_gd.create
call super::create
end on

on w_classe_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_classe_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_classe_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_classe_gd
int Width=2039
string DataObject="d_classe_gd"
end type

event dw_single::rowfocuschanged;setROWFOCUSINDICATOR(HAND!)
end event

event dw_single::ue_initial;call super::ue_initial;long ll_riga,ll_righe
integer li_livello
ll_righe=rowcount()
ll_riga=getrow()
if ll_righe>1 then
	li_livello=getitemnumber(ll_riga + 1, "livello")
	setitem(ll_riga, "livello", li_livello)
end if
end event

