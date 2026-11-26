forward
global type w_dett_lung_peso_rpt from w_stampa_001
end type
end forward

global type w_dett_lung_peso_rpt from w_stampa_001
boolean TitleBar=true
string Title="Dettaglio Lunghezze Personalizzate"
end type
global w_dett_lung_peso_rpt w_dett_lung_peso_rpt

event open;long ll_id_lung

dw_1.settransobject(sqlca)

ll_id_lung=message.doubleparm
if ll_id_lung>0 then
	dw_1.retrieve(ll_id_lung)
	
end if
end event

on w_dett_lung_peso_rpt.create
call super::create
end on

on w_dett_lung_peso_rpt.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_dett_lung_peso_rpt
string DataObject="d_dett_lung_peso_rpt"
end type

