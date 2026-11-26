forward
global type w_sigla_prezzo_np from w_np_single_data
end type
end forward

global type w_sigla_prezzo_np from w_np_single_data
int X=708
int Y=602
WindowType WindowType=response!
boolean TitleBar=true
string Title="Sigle Prezzi"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_sigla_prezzo_np w_sigla_prezzo_np

type variables
string is_sigla
end variables

on w_sigla_prezzo_np.create
call w_np_single_data::create
end on

on w_sigla_prezzo_np.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_sigla_prezzo_np
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_sigla_prezzo_np
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_sigla_prezzo_np
string DataObject="d_sigla_prezzo_gd"
end type

event dw_single::doubleclicked;call super::doubleclicked;is_sigla=this.GetItemString(row,"sigla")
CloseWithReturn(parent,is_sigla)

end event

