forward
global type w_fascette_prezzo from w_semplice_gd
end type
end forward

global type w_fascette_prezzo from w_semplice_gd
integer width = 2894
integer height = 1548
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
end type
global w_fascette_prezzo w_fascette_prezzo

on w_fascette_prezzo.create
call super::create
end on

on w_fascette_prezzo.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_fascette_prezzo
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_fascette_prezzo
end type

type cb_primo from w_semplice_gd`cb_primo within w_fascette_prezzo
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_fascette_prezzo
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_fascette_prezzo
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_fascette_prezzo
end type

type dw_1 from w_semplice_gd`dw_1 within w_fascette_prezzo
integer width = 2789
string dataobject = "d_fascette_prezzo"
end type

event dw_1::doubleclicked;string ls_type, modstring

if dwo.type='column' then
	
//	ls_type=describe(dwo.name+".edit.style")
//	if ls_type='dddw' then
//		modstring='create compute(name='+dwo.name+'_compute moveable=1 resizeable=1 band=detail '+& 
//		' expression= "1" visible="1" )'
//		modify(modstring)
//	end if
	if is_asc='A' then
		is_asc='D'
	else
		is_asc='A'
	end if
	
	setsort(dwo.name+" "+is_asc)
	
	Setredraw(FALSE)
	sort()
	GroupCalc()
	SetRedraw(TRUE)
	
	
end if

//Lookupdisplay('+dwo.name+')
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_fascette_prezzo
end type

type cb_salva from w_semplice_gd`cb_salva within w_fascette_prezzo
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_fascette_prezzo
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_fascette_prezzo
end type

type cb_ok from w_semplice_gd`cb_ok within w_fascette_prezzo
end type

