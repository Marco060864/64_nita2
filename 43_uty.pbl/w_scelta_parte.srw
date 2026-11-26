forward
global type w_scelta_parte from w_np_single_data
end type
end forward

global type w_scelta_parte from w_np_single_data
int Width=2085
boolean TitleBar=true
string Title="Selezione Scelta Parte"
long BackColor=80133307
end type
global w_scelta_parte w_scelta_parte

type variables
long	il_id_cod_parte	
integer     ii_lunghezza
string	is_scelta, is_car_riempimento
end variables

on w_scelta_parte.create
call super::create
end on

on w_scelta_parte.destroy
call super::destroy
end on

event open;
il_id_cod_parte = message.doubleparm

idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
dw_single.Retrieve(il_id_cod_parte)
this.y = 100

SELECT parte_regola.lunghezza, scelta_parte.scelta, cod_parte.car_riempimento
INTO	 :ii_lunghezza, :is_scelta, :is_car_riempimento
FROM 	 scelta_parte, cod_parte, parte_regola  
WHERE  cod_parte.id_cod_parte = scelta_parte.id_cod_parte
AND	 parte_regola.id_parte_regola = cod_parte.id_parte_regola
AND    scelta_parte.id_cod_parte = :il_id_cod_parte
;

end event

type p_crescente from w_np_single_data`p_crescente within w_scelta_parte
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_scelta_parte
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_scelta_parte
event ue_post_item_changed ( integer ai_row )
int X=37
int Y=28
int Width=1979
int Height=716
string DataObject="d_scelta_parte_ext_gd2"
end type

event dw_single::ue_post_item_changed;
integer  li_len_data
integer  li_i
string	ls_scelta


if (isnull(is_car_riempimento)) or (is_car_riempimento = '') then is_car_riempimento = '0'
	
ls_scelta = this.getitemstring(ai_row,"scelta")
li_len_data = len(ls_scelta)
if len(ls_scelta) > 0 then
	for li_i = len(ls_scelta) to ii_lunghezza - 1 
		ls_scelta = ls_scelta + is_car_riempimento
	next
		
	this.setitem(ai_row, "scelta", ls_scelta) 
end if
end event

event dw_single::ue_initial;call super::ue_initial;
this.setitem(this.getrow(), "id_cod_parte", il_id_cod_parte)
end event

event dw_single::itemchanged;if dwo.name = "scelta" then
	this.event post ue_post_item_changed(row)
end if
end event

