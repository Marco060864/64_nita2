forward
global type w_elenco_stampe_wz from w_wiz_main
end type
type dw_par_categoria_ff from u_dw_ext_main within w_elenco_stampe_wz
end type
type dw_par_elenco_stampe_lt from u_dw_ext_main within w_elenco_stampe_wz
end type
end forward

global type w_elenco_stampe_wz from w_wiz_main
int Width=2593
int Height=1261
dw_par_categoria_ff dw_par_categoria_ff
dw_par_elenco_stampe_lt dw_par_elenco_stampe_lt
end type
global w_elenco_stampe_wz w_elenco_stampe_wz

type variables
s_list_main	is_list
string		is_argomento
end variables

on w_elenco_stampe_wz.create
int iCurrent
call super::create
this.dw_par_categoria_ff=create dw_par_categoria_ff
this.dw_par_elenco_stampe_lt=create dw_par_elenco_stampe_lt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_par_categoria_ff
this.Control[iCurrent+2]=this.dw_par_elenco_stampe_lt
end on

on w_elenco_stampe_wz.destroy
call super::destroy
destroy(this.dw_par_categoria_ff)
destroy(this.dw_par_elenco_stampe_lt)
end on

event ue_post_open;call super::ue_post_open;
string	ls_filter

dw_par_categoria_ff.InsertRow(0)

dw_par_elenco_stampe_lt.SetTransObject(SQLCA)	
if dw_par_elenco_stampe_lt.Retrieve() = -1 then
	MessageBox("Retrieve Error","Errore nel recupero dei dati",StopSign! )
end if	

if not isNull(is_argomento) then
	ls_filter	= "argomento = '" + is_argomento +"'"
	if dw_par_elenco_stampe_lt.SetFilter(ls_filter) = -1 then
		MessageBox("SetFilter Error","Errore nell'impostazione del filtro",StopSign! )
	end if	
	
	if dw_par_elenco_stampe_lt.Filter() = -1 then
		MessageBox("Filter Error","Errore nel filtro dei dati",StopSign! )
	end if	
end if







end event

event open;call super::open;
is_list 			= Message.PowerObjectParm
is_argomento 	= is_list.s_win_parametri


choose case is_argomento
		case 'CN'
			this.Title = "Elenco stampe contabilità"
		case 'MG'
			this.Title = "Elenco stampe magazzino"
		case 'GF'
			this.Title = "Elenco stampe gestione finanziaria"
		case 'AG'
			this.Title = "Elenco stampe agenti"
		case 'CS'
			this.Title = "Elenco stampe cespiti"
		case 'CC'
			this.Title = "Elenco stampe centri di costo"
		case 'GN'
			this.Title = "Elenco stampe generiche"
		case else
			this.Title = "Elenco stampe"	  
end choose			


end event

event resize;call super::resize;
dw_par_elenco_stampe_lt.Height 	= newheight - 80
end event

type dw_par_categoria_ff from u_dw_ext_main within w_elenco_stampe_wz
int X=48
int Y=22
int Width=984
int Height=1101
string DataObject="d_par_stampa_ff"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event itemchanged;call super::itemchanged;
string	ls_filter
integer	li_esito

li_esito = 0
if not isNull(data) then
	
	if data <> 'T' then
		if not isNull(is_argomento) then
			ls_filter	= "argomento = '" + is_argomento +"' AND cat_report = '" + data +"'"
		else
			ls_filter	= "cat_report = '" + data +"'"
		end if	
	else
		if not isNull(is_argomento) then
			ls_filter	= "argomento = '" + is_argomento +"'"
		else
			dw_par_elenco_stampe_lt.SetTransObject(SQLCA)	
			if dw_par_elenco_stampe_lt.Retrieve() = -1 then
				MessageBox("Retrieve Error","Errore nel recupero dei dati",StopSign! )
			end if	
		end if	
	end if
	
	li_esito = dw_par_elenco_stampe_lt.SetFilter(ls_filter)
	if li_esito = -1 then
		MessageBox("SetFilter Error","Errore nell'impostazione del filtro",StopSign! )
	end if	
	li_esito = dw_par_elenco_stampe_lt.Filter()
	if li_esito = -1 then
		MessageBox("Filter Error","Errore nel filtro dei dati",StopSign! )
	end if	
end if

if li_esito = 1 then
	if dw_par_elenco_stampe_lt.rowcount()>0 then
		dw_par_elenco_stampe_lt.ScrollToRow(1)
		dw_par_elenco_stampe_lt.post event rowfocuschanged(1)
	end if
end if

return 0
		
end event

event getfocus;

end event

type dw_par_elenco_stampe_lt from u_dw_ext_main within w_elenco_stampe_wz
int X=1028
int Y=22
int Width=1485
int Height=1101
int TabOrder=2
string DataObject="d_par_elenco_stampe_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event doubleclicked;call super::doubleclicked;
long		ll_row,ll_id_par_stampa
string	ls_classe_finestra

if row > 0 then
	ls_classe_finestra	= this.GetItemString( row,"classe_finestra" )
	ll_id_par_stampa		= this.GetItemNumber( row,"id_par_stampa" )
	
	OpenWithParm( w_print_main, ll_id_par_stampa,ls_classe_finestra )
end if	


end event

event ue_key;call super::ue_key;
long		ll_row,ll_id_par_stampa
string	ls_classe_finestra

choose case key
	case keyenter!		
		ll_row	= this.GetRow()
		if ll_row > 0 then
			ls_classe_finestra	= this.GetItemString( ll_row,"classe_finestra" )
			ll_id_par_stampa		= this.GetItemNumber( ll_row,"id_par_stampa" )
			OpenWithParm( w_print_main,ll_id_par_stampa,ls_classe_finestra )
		end if	
end choose
end event

event rowfocuschanged;call super::rowfocuschanged;selectrow(0,False)
selectrow(currentrow,True)
end event

