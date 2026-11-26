forward
global type w_or_st_pag_bollato_rpt from w_stampa_001
end type
end forward

global type w_or_st_pag_bollato_rpt from w_stampa_001
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Pagine Per Bollato"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_or_st_pag_bollato_rpt w_or_st_pag_bollato_rpt

on w_or_st_pag_bollato_rpt.create
call super::create
end on

on w_or_st_pag_bollato_rpt.destroy
call super::destroy
end on

event open;integer li_pagine
datastore ds_par	
ds_par=create datastore
ds_par=message.powerobjectparm

dw_1.dataobject=ds_par.dataobject
li_pagine=ds_par.rowcount()
li_pagine=ds_par.rowscopy(1, li_pagine, primary!, dw_1, 1, primary!)
if li_pagine<>1 then messagebox("Errore" ,"Righe non copiate")

destroy ds_par
end event

type dw_1 from w_stampa_001`dw_1 within w_or_st_pag_bollato_rpt
string DataObject="d_stampa_pag_bollato2_rpt"
end type

