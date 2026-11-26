forward
global type w_intra_nomenclatura_gd from w_np_single_data
end type
end forward

global type w_intra_nomenclatura_gd from w_np_single_data
int Width=1509
int Height=812
boolean TitleBar=true
string Title="Nomenclatura"
end type
global w_intra_nomenclatura_gd w_intra_nomenclatura_gd

event open;call super::open;
il_HelpTopic = 66
end event

on w_intra_nomenclatura_gd.create
call super::create
end on

on w_intra_nomenclatura_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_intra_nomenclatura_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_intra_nomenclatura_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_intra_nomenclatura_gd
int X=32
int Y=32
int Width=1417
int Height=664
string DataObject="d_intra_nomenclatura_gd"
end type

event dw_single::doubleclicked;string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_single.rowcount()

CHOOSE CASE ls_name
	CASE "cod_nomen_t"
		if ll_totrows > 0 then
			ls_row1 = dw_single.getitemstring(1,"cod_nomen")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_single.getitemstring(ll_totrows,"cod_nomen")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_single.setsort("cod_nomen D")
			else 
				dw_single.setsort("cod_nomen A")
			end if
		end if
		
	CASE "desc_nomen_t"
		if ll_totrows > 0 then
			ls_row1 = dw_single.getitemstring(1,"desc_nomen")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_single.getitemstring(ll_totrows,"desc_nomen")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_single.setsort("desc_nomen D")
			else 
				dw_single.setsort("desc_nomen A")
			end if
		end if		
END CHOOSE

dw_single.sort()		
end event

