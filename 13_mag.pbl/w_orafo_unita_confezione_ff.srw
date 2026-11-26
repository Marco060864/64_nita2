forward
global type w_orafo_unita_confezione_ff from w_unita_confezione_ff
end type
end forward

global type w_orafo_unita_confezione_ff from w_unita_confezione_ff
int Width=2684
end type
global w_orafo_unita_confezione_ff w_orafo_unita_confezione_ff

on w_orafo_unita_confezione_ff.create
call w_unita_confezione_ff::create
end on

on w_orafo_unita_confezione_ff.destroy
call w_unita_confezione_ff::destroy
end on

type p_crescente from w_unita_confezione_ff`p_crescente within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type p_decrescente from w_unita_confezione_ff`p_decrescente within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type cb_ok from w_unita_confezione_ff`cb_ok within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type cb_annulla from w_unita_confezione_ff`cb_annulla within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type cb_nuovo from w_unita_confezione_ff`cb_nuovo within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type cb_inserisci from w_unita_confezione_ff`cb_inserisci within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type cb_cancella from w_unita_confezione_ff`cb_cancella within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type cb_salva from w_unita_confezione_ff`cb_salva within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type tab_1 from w_unita_confezione_ff`tab_1 within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

type tabpage_1 from w_unita_confezione_ff`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2570
int Height=1649
end type

type dw_unita_confezione_ff from w_unita_confezione_ff`dw_unita_confezione_ff within tabpage_1
string DataObject="d_orafo_unita_confezione_ff"
end type

event dw_unita_confezione_ff::itemchanged;call super::itemchanged;

decimal{4} ld_dim_l, ld_peso_netto, ld_conv_misura_peso, ld_cmp


choose case string (dwo.name)
	case "conv_misura_peso" 
	     
		  ld_cmp=dec(data)
		  setitem(row, "peso_netto", 0)
		  setitem(row, "dim_l", 0)
		  
	case "peso_netto" 
		
		ld_dim_l=tab_1.tabpage_1.dw_unita_confezione_ff.getitemdecimal(row,"dim_l")
		
		ld_cmp=tab_1.tabpage_1.dw_unita_confezione_ff.getitemdecimal(row,"conv_misura_peso")
		
		if ld_dim_l>0 and not isnull(ld_dim_l) then
			ld_peso_netto=dec(data)
			ld_conv_misura_peso=ld_peso_netto/ld_dim_l 
      end if
	
	case "dim_l"
	    ld_peso_netto=tab_1.tabpage_1.dw_unita_confezione_ff.getitemdecimal(row,"peso_netto")
       
		 ld_cmp=tab_1.tabpage_1.dw_unita_confezione_ff.getitemdecimal(row,"conv_misura_peso")
		
		if ld_peso_netto>0 and not isnull(ld_peso_netto) then
			ld_dim_l=dec(data) 
			ld_conv_misura_peso=ld_peso_netto/ld_dim_l 
   	end if	
end choose

if isnull(ld_cmp) or ld_cmp=0 then 
	
	setitem(row, "conv_misura_peso", ld_conv_misura_peso) 
	        
			  
	 elseif ld_dim_l<>0 and ld_peso_netto<>0 and ld_conv_misura_peso<>ld_cmp then 
           messagebox("Controllo", "Incongruenza tra i dati inseriti ~re l'attuale Conversione Misura/Peso")
end if


end event

type dw_scorte_gd from w_unita_confezione_ff`dw_scorte_gd within tabpage_1
string DataObject="d_orafo_scorta_gd"
end type

type st_scorte from w_unita_confezione_ff`st_scorte within tabpage_1
boolean BringToTop=true
end type

type cb_1 from w_unita_confezione_ff`cb_1 within tabpage_1
int X=1079
int Y=569
boolean BringToTop=true
end type

type cb_2 from w_unita_confezione_ff`cb_2 within tabpage_1
int Y=569
boolean BringToTop=true
end type

type tabpage_2 from w_unita_confezione_ff`tabpage_2 within tab_1
int X=19
int Y=105
int Width=2570
int Height=1649
end type

type cb_ricerca from w_unita_confezione_ff`cb_ricerca within w_orafo_unita_confezione_ff
boolean BringToTop=true
end type

