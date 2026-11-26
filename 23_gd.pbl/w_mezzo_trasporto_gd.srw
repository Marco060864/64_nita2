forward
global type w_mezzo_trasporto_gd from w_np_single_data
end type
end forward

global type w_mezzo_trasporto_gd from w_np_single_data
int Width=2962
int Height=1444
boolean TitleBar=true
string Title="Mezzi di Trasporto"
end type
global w_mezzo_trasporto_gd w_mezzo_trasporto_gd

on w_mezzo_trasporto_gd.create
call super::create
end on

on w_mezzo_trasporto_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_mezzo_trasporto_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_mezzo_trasporto_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_mezzo_trasporto_gd
int X=37
int Y=28
int Width=2857
int Height=1288
string DataObject="d_mezzo_trasporto_gd"
end type

event dw_single::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows, ll_row1, ll_row2

ls_name = dwo.name  

ll_totrows = dw_single.rowcount()

CHOOSE CASE ls_name
	CASE "descrizione_t"
		if ll_totrows > 0 then
			ls_row1 = dw_single.getitemstring(1,"descrizione")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_single.getitemstring(ll_totrows,"descrizione")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
			
			
			
			if ls_row1 <= ls_row2 then 
				dw_single.setsort("descrizione D")
			else 
				dw_single.setsort("descrizione A")
			end if
		end if
		
	CASE "targa_t"
		if ll_totrows > 0 then
			ls_row1 = dw_single.getitemstring(1,"targa")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_single.getitemstring(ll_totrows,"targa")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
			
			
		
			if ls_row1 <= ls_row2 then 
				dw_single.setsort("targa D")
			else 
				dw_single.setsort("targa A")
			end if
		end if
			
	CASE "tara_t"
		if ll_totrows > 0 then
			ll_row1 = dw_single.getitemnumber(1,"tara")
			if isnull(ll_row1) = TRUE then ll_row1 = 0
			ll_row2 = dw_single.getitemnumber(ll_totrows,"tara")	
			if isnull(ll_row2) = TRUE then ll_row2 = 0		
			
			
		
			if ll_row1 <= ll_row2 then 
				dw_single.setsort("tara D")
			else 
				dw_single.setsort("tara A")
			end if		
		end if

	CASE "id_unita_misura_t"
		if ll_totrows > 0 then		
			ll_row1 = dw_single.getitemnumber(1,"id_unita_misura")
			if isnull(ll_row1) = TRUE then ll_row1 = 0		
			ll_row2 = dw_single.getitemnumber(ll_totrows,"id_unita_misura")		
			if isnull(ll_row2) = TRUE then ll_row2 = 0		
			
			
			
			if ll_row1 <= ll_row2 then 
				dw_single.setsort("id_unita_misura D")
			else 
				dw_single.setsort("id_unita_misura A")
			end if				
		end if
		
END CHOOSE

dw_single.sort()
end event

