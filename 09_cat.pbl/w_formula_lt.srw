forward
global type w_formula_lt from w_list_main
end type
type tab_1 from tab within w_formula_lt
end type
type tabpage_1 from userobject within tab_1
end type
type dw_selezione from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_selezione dw_selezione
end type
type tabpage_2 from userobject within tab_1
end type
type dw_my_list from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_my_list dw_my_list
end type
type tabpage_3 from userobject within tab_1
end type
type dw_elenco from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_elenco dw_elenco
end type
type tab_1 from tab within w_formula_lt
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type cb_filtro from commandbutton within w_formula_lt
end type
type cb_salva from commandbutton within w_formula_lt
end type
type cb_ok from commandbutton within w_formula_lt
end type
type cb_annulla from commandbutton within w_formula_lt
end type
type cb_nuovo from commandbutton within w_formula_lt
end type
type cb_elimina from commandbutton within w_formula_lt
end type
end forward

global type w_formula_lt from w_list_main
integer y = 440
integer width = 2752
integer height = 1720
string title = "Definizione formule"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
tab_1 tab_1
cb_filtro cb_filtro
cb_salva cb_salva
cb_ok cb_ok
cb_annulla cb_annulla
cb_nuovo cb_nuovo
cb_elimina cb_elimina
end type
global w_formula_lt w_formula_lt

type variables
datawindowchild d_id_titolo, d_id_variazione
long il_formula
string is_filtro


end variables

forward prototypes
public function integer wf_conv (decimal ld_mm, decimal li_dpi)
end prototypes

public function integer wf_conv (decimal ld_mm, decimal li_dpi);

decimal ld_dpmm
integer li_x

li_x = ld_mm*li_dpi

return li_x
end function

on w_formula_lt.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_filtro=create cb_filtro
this.cb_salva=create cb_salva
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_nuovo=create cb_nuovo
this.cb_elimina=create cb_elimina
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_filtro
this.Control[iCurrent+3]=this.cb_salva
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_annulla
this.Control[iCurrent+6]=this.cb_nuovo
this.Control[iCurrent+7]=this.cb_elimina
end on

on w_formula_lt.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_filtro)
destroy(this.cb_salva)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_nuovo)
destroy(this.cb_elimina)
end on

event resize;
end event

event ue_post_open;
end event

event open;call super::open;
integer rtncode
datawindowchild d_id_cat_fiscale, d_id_gruppo, &
d_id_cat_comm, d_id_cat_merc, d_id_cat_codifica, &
d_id_listino, d_id_metallo

tab_1.tabpage_1.dw_selezione.SetTransObject(sqlca)
tab_1.tabpage_3.dw_elenco.SetTransObject(sqlca)
tab_1.tabpage_3.dw_elenco.retrieve()

long ll_listino

il_formula=message.DoubleParm

rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_cat_fisc', d_id_cat_fiscale)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_cat_fiscale.SetTransObject(SQLCA)
d_id_cat_fiscale.Retrieve()
rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_gruppo', d_id_gruppo)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_gruppo.SetTransObject(SQLCA)
d_id_gruppo.Retrieve()
rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_cat_comm', d_id_cat_comm)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_cat_comm.SetTransObject(SQLCA)
d_id_cat_comm.Retrieve()
rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_cat_merc', d_id_cat_merc)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_cat_merc.SetTransObject(SQLCA)
d_id_cat_merc.Retrieve()
rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_cat_codifica', d_id_cat_codifica)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_cat_codifica.SetTransObject(SQLCA)
d_id_cat_codifica.Retrieve()

rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_listino', d_id_listino)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_listino.SetTransObject(SQLCA)
d_id_listino.Retrieve()
ll_listino=d_id_listino.getitemnumber(1,"ID_LISTINO")

rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_variazione', d_id_variazione)
IF rtncode = -1 THEN MessageBox(  &
"Error", "Not a DataWindowChild")
d_id_variazione.SetTransObject(SQLCA)
d_id_variazione.Retrieve(ll_listino)

rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_metallo', d_id_metallo)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_metallo.SetTransObject(SQLCA)
d_id_metallo.Retrieve()

rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_titolo', d_id_titolo)
IF rtncode = -1 THEN MessageBox(  &
	"Error", "Not a DataWindowChild")
d_id_titolo.SetTransObject(SQLCA)
d_id_titolo.Retrieve()



if IsNull(il_formula) or il_formula <1 then
	SetNull(il_formula)
	tab_1.tabpage_1.dw_selezione.insertrow(0)
else
	tab_1.tabpage_1.dw_selezione.retrieve(il_formula)
end if

end event

type p_msg_log from w_list_main`p_msg_log within w_formula_lt
integer x = 32
end type

type p_crescente from w_list_main`p_crescente within w_formula_lt
end type

type p_decrescente from w_list_main`p_decrescente within w_formula_lt
end type

type dw_list from w_list_main`dw_list within w_formula_lt
boolean visible = false
integer x = 18
integer y = 1416
integer width = 2277
integer height = 236
integer taborder = 80
string dataobject = "d_orafo_sel_stampa2_gd"
borderstyle borderstyle = stylelowered!
end type

event dw_list::doubleclicked;
end event

event dw_list::ue_retrieve;
end event

type tab_1 from tab within w_formula_lt
event create ( )
event destroy ( )
integer x = 50
integer y = 136
integer width = 2661
integer height = 1480
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2624
integer height = 1360
long backcolor = 79741120
string text = "Composizione formula"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_selezione dw_selezione
end type

on tabpage_1.create
this.dw_selezione=create dw_selezione
this.Control[]={this.dw_selezione}
end on

on tabpage_1.destroy
destroy(this.dw_selezione)
end on

type dw_selezione from datawindow within tabpage_1
integer x = 9
integer y = 12
integer width = 2597
integer height = 1340
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_componi_formula_ff"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;

choose case dwo.name
	case "id_metallo"
		long ll_id_titolo, ll_riga_trovata
		integer rtncode
	
		
		d_id_titolo.setfilter("")
		d_id_titolo.filter()
		d_id_titolo.setfilter("id_metallo="+data)
		d_id_titolo.filter()
		d_id_titolo.retrieve()
		setnull(ll_riga_trovata)
		setitem(row, "id_titolo", ll_riga_trovata)
	

	case "id_listino"
		long ll_listino

		
		ll_listino = long(data)
		rtncode = tab_1.tabpage_1.dw_selezione.GetChild('id_variazione', d_id_variazione)
		IF rtncode = -1 THEN MessageBox(  "Error", "Not a DataWindowChild")
		d_id_variazione.SetTransObject(SQLCA)
		d_id_variazione.Retrieve(ll_listino)
	
end choose




string ls_da_art_cod, ls_da_art_des,ls_a_art_cod, ls_a_art_des, ls_id_articolo


if dwo.name="da_art_cod" then
	  
	select codice, descrizione, id_articolo
	into :ls_da_art_cod, :ls_da_art_des, :ls_id_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then 
	    this.post setitem(row,"da_art_cod",ls_da_art_cod)
  	    this.setitem(row,"da_art_des",ls_da_art_des)
	    this.setitem(row,"a_art_cod",ls_da_art_cod)
  	    this.setitem(row,"a_art_des",ls_da_art_des)	
	else 
		this.post event clicked(0,0,row, this.object.da_art_cod_sw)
	end if
	
end if	


if dwo.name="da_art_des" then
	  
	select codice, descrizione, id_articolo
	into :ls_da_art_cod, :ls_da_art_des, :ls_id_articolo
	from articolo
	where descrizione=:data;
	if sqlca.sqlcode=0 then 
	    this.setitem(row,"da_art_cod",ls_da_art_cod)
  	    this.post setitem(row,"da_art_des",ls_da_art_des)
		 this.setitem(row,"a_art_cod",ls_da_art_cod)
  	    this.setitem(row,"a_art_des",ls_da_art_des)	
	else 
		this.post event clicked(0,0,row, this.object.da_art_des_sw)
	end if
	
end if



if dwo.name="a_art_cod" then
	  
	select codice, descrizione, id_articolo
	into :ls_a_art_cod, :ls_a_art_des, :ls_id_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then 
		 this.post setitem(row,"a_art_cod",ls_a_art_cod)
  	    this.setitem(row,"a_art_des",ls_a_art_des)	
	else 
		this.post event clicked(0,0,row, this.object.a_art_cod_sw)
	end if
	
end if	


if dwo.name="a_art_des" then
	  
	select codice, descrizione, id_articolo
	into :ls_a_art_cod, :ls_a_art_des, :ls_id_articolo
	from articolo
	where descrizione=:data;
	if sqlca.sqlcode=0 then 
	
		 this.setitem(row,"a_art_cod",ls_a_art_cod)
  	    this.post setitem(row,"a_art_des",ls_a_art_des)	
	else 
		this.post event clicked(0,0,row, this.object.a_art_des_sw)
	end if
	
end if
end event

event clicked;
s_ric_param is_ricpar
tab_1.tabpage_1.dw_selezione.AcceptText()

choose case dwo.name
		
	case "da_art_cod_sw"
		is_ricpar.s_filter_value	= tab_1.tabpage_1.dw_selezione.GetItemString(1,"da_art_cod")
		is_ricpar.s_filter_name 	= "articolo_codice"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"da_art_cod",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"da_art_des",is_ricpar.s_ausil_value[1])
		end if

	case "a_art_cod_sw"
		is_ricpar.s_filter_value	= tab_1.tabpage_1.dw_selezione.GetItemString(1,"a_art_cod")
		is_ricpar.s_filter_name 	= "articolo_codice"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"a_art_cod",upper(is_ricpar.s_main_value))
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"a_art_des",is_ricpar.s_ausil_value[1])
		end if

	case "da_art_des_sw"
		is_ricpar.s_filter_value = tab_1.tabpage_1.dw_selezione.GetItemString(1,"da_art_des")
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"da_art_des",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"da_art_cod",upper(is_ricpar.s_ausil_value[1]))
		end if

	case "a_art_des_sw"
		is_ricpar.s_filter_value = tab_1.tabpage_1.dw_selezione.GetItemString(1,"a_art_des")
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"a_art_des",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"a_art_cod",upper(is_ricpar.s_ausil_value[1]))
		end if
		
	case "prod_des_sw"
		is_ricpar.s_filter_value = tab_1.tabpage_1.dw_selezione.GetItemString(1,"prod_des")
		is_ricpar.s_filter_name = "rag_soc_1"
		OpenWithParm(w_anagrafica_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"prod_des",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"id_produttore",long(is_ricpar.s_ausil_value[1]))		
		end if
		
	case "for_cod_sw"
		is_ricpar.s_filter_value = tab_1.tabpage_1.dw_selezione.GetItemString(1,"for_cod")
		is_ricpar.s_filter_name = "codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
		OpenWithParm(w_sog_commerciale_gen_coddes_sw,is_ricpar)		
		is_ricpar=message.PowerObjectParm
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			SetItem(1,"id_fornitore",long(is_ricpar.s_id_seg_value[1]))
		end if
		SetItem(1,"for_cod",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"for_des",is_ricpar.s_ausil_value[1])
		end if

	case "for_des_sw"
		is_ricpar.s_filter_value = tab_1.tabpage_1.dw_selezione.GetItemString(1,"for_des")
		is_ricpar.s_filter_name = "rag_soc_1"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
		OpenWithParm(w_sog_commerciale_gen_coddes_sw,is_ricpar)		
		is_ricpar=message.PowerObjectParm
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			SetItem(1,"id_fornitore",long(is_ricpar.s_id_seg_value[1]))
		end if
		SetItem(1,"for_des",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"for_cod",is_ricpar.s_ausil_value[1])
		end if

end choose



end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2624
integer height = 1360
long backcolor = 79741120
string text = "Risultato Test"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_my_list dw_my_list
end type

on tabpage_2.create
this.dw_my_list=create dw_my_list
this.Control[]={this.dw_my_list}
end on

on tabpage_2.destroy
destroy(this.dw_my_list)
end on

type dw_my_list from datawindow within tabpage_2
integer x = 23
integer y = 40
integer width = 2555
integer height = 1288
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_sel_stampa_formule_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if messagebox('Elimina riga','Vuoi eliminare la riga '+this.getItemString(row,"articolo_codice")+" ?",Information!,YesNo!)=1 then
	this.DeleteRow(row)
end if

end event

event sqlpreview;string ls_sql
if is_filtro>"" then
	ls_sql=sqlsyntax
	ls_sql+= " and "+ is_filtro
	setsqlpreview(ls_sql)
	is_filtro=""
end if
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2624
integer height = 1360
long backcolor = 79741120
string text = "Elenco formule"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_elenco dw_elenco
end type

on tabpage_3.create
this.dw_elenco=create dw_elenco
this.Control[]={this.dw_elenco}
end on

on tabpage_3.destroy
destroy(this.dw_elenco)
end on

type dw_elenco from datawindow within tabpage_3
event ue_post_itemchanged ( long al_riga,  string as_colonna,  string data )
integer x = 41
integer y = 24
integer width = 2190
integer height = 1280
integer taborder = 51
boolean bringtotop = true
string dataobject = "d_s_formula_ampia_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_post_itemchanged;SetItem(al_riga,as_colonna,data)

end event

event itemchanged;messagebox('Attenzione!','Per cambiare descrizione utilizzare la pagina principale!')
post event ue_post_itemchanged(row,dwo.name,data)
end event

event doubleclicked;if row>0 then
	cb_salva.triggerEvent(clicked!)
	il_formula=getitemnumber(row,"id_formula")
	tab_1.selecttab(1)
	tab_1.tabpage_1.dw_selezione.retrieve(il_formula)
end if
end event

type cb_filtro from commandbutton within w_formula_lt
integer x = 2226
integer y = 16
integer width = 343
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Test"
boolean default = true
end type

event clicked;

long		ll_id_cat_cod,ll_id_cat_comm,ll_id_cat_merc,ll_id_cat_fisc,ll_id_gruppo
long		ll_id_produttore,ll_id_fornitore,ll_id_magazzino
string	ls_da_art, ls_a_art, ls_produttore,ls_fornitore
string 	ls_where
long 		ll_id_metallo, ll_id_titolo, ll_id_listino, ll_id_variazione
decimal{4}	ld_da_peso, ld_a_peso, ld_da_prezzo, ld_a_prezzo
date 		ldt_da_data, ldt_a_data

string ls_filter

tab_1.tabpage_1.dw_selezione.accepttext()

ls_filter=""

ls_da_art				= tab_1.tabpage_1.dw_selezione.GetItemString(1,"da_art_cod")
ls_a_art					= tab_1.tabpage_1.dw_selezione.GetItemString(1,"a_art_cod")
ll_id_cat_cod			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_cat_codifica")
ll_id_cat_comm			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_cat_comm")
ll_id_cat_merc			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_cat_merc")
ll_id_cat_fisc			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_cat_fisc")
ll_id_gruppo			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_gruppo")
ll_id_fornitore		= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_fornitore" )
ll_id_produttore		= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_produttore" )
ls_produttore			= tab_1.tabpage_1.dw_selezione.GetItemString(1,"prod_des" )
ll_id_magazzino		= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_magazzino" )
ls_fornitore			= tab_1.tabpage_1.dw_selezione.GetItemString(1,"for_des" )

ll_id_titolo			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_titolo")
ll_id_metallo			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_metallo")

ll_id_listino			= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_listino")
string ls_nome
IF IsNull(ll_id_listino) THEN
	ls_nome = "d_orafo_sel_stampa2_gd"
ELSE
	ls_nome = "d_orafo_sel_stampa2_gd"
END IF
tab_1.tabpage_2.dw_my_list.DataObject = ls_nome

tab_1.tabpage_1.dw_selezione.AcceptText()
ll_id_variazione	= tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_variazione")


ld_da_peso			= tab_1.tabpage_1.dw_selezione.GetItemdecimal(1,"da_peso")
ld_a_peso			= tab_1.tabpage_1.dw_selezione.GetItemdecimal(1,"a_peso")
ld_da_prezzo		= tab_1.tabpage_1.dw_selezione.GetItemdecimal(1,"da_prezzo")
ld_a_prezzo			= tab_1.tabpage_1.dw_selezione.GetItemdecimal(1,"a_prezzo")

ldt_da_data			= tab_1.tabpage_1.dw_selezione.GetItemdate(1,"da_data")
ldt_a_data			= tab_1.tabpage_1.dw_selezione.GetItemdate(1,"a_data")


if not isNull(ls_da_art) and not isNull(ls_a_art) then
	if ls_da_art > ls_a_art then
		if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if
end if
if Not IsNull(ll_id_cat_cod) then
	ls_where 	= "cat_codifica.id_cat_codifica" + string(ll_id_cat_cod) + " and "
else
	
end if
if Not IsNull(ls_da_art) and ls_da_art <> "" then
	
	ls_where 	= ls_where + " articolo.codice >= '" + ls_da_art + "' and "
	
else
end if

if Not IsNull(ls_a_art) and ls_a_art <> "" then
	
	ls_where 	= ls_where + "articolo.codice <= '" + ls_a_art + "' and "
else
	
end if
if Not IsNull(ll_id_cat_comm) then
	
	ls_where 	= ls_where+ " cat_com_articolo.id_cat_com_articolo = " + string(ll_id_cat_comm) + " and "
	
else
	
end if
if Not IsNull(ll_id_cat_merc) then
	
	ls_where 	= ls_where + "cat_merceologica.id_cat_merceologica =" + string(ll_id_cat_merc) + " and "
else
	
end if
if Not IsNull(ll_id_cat_fisc) then
	
	ls_where 	= ls_where+ "cat_fiscale.id_cat_fiscale=" + string(ll_id_cat_fisc) + " and "
else
	
end if
if Not IsNull(ll_id_gruppo) then
	
	ls_where 	= ls_where+ " articolo.id_gruppo_articoli= " + string(ll_id_gruppo) + " and "
else
	
end if
if Not IsNull(ll_id_produttore) then
	
	ls_where 	= ls_where+ "anagrafica.id_anagrafica= " + string(ll_id_produttore) + " and "
else
	
end if
if Not IsNull(ll_id_fornitore) then
	
	ls_where 	= ls_where+ "sog_commerciale_gen.id_sog_commerciale= " + string(ll_id_fornitore) + " and "
else
	
end if
if Not IsNull(ll_id_magazzino) then
	
else
	
end if

if Not IsNull(ll_id_listino) then
	
	if IsNull(ll_id_variazione) then
		messagebox("Errore!", "Specificare una variazione per il listino!")
		tab_1.tabpage_1.dw_selezione.setcolumn("id_variazione")
		return
	end if
	ls_where 	= ls_where+" prezzo.id_variazione = "+string(ll_id_variazione)+ " and"
else
	
end if

if ldt_da_data >	ldt_a_data then
	messagebox("Errore!", "La data di inizio è superiore a quella di fine")
	tab_1.tabpage_1.dw_selezione.setcolumn("da_data")
	return
end if

if Not IsNull(ll_id_metallo) then
	
	ls_where = ls_where + " orafo_metallo.id_metallo = "+string(ll_id_metallo)+ " and"
	
else
	
end if

if Not IsNull(ll_id_titolo) then
	ls_where = ls_where + " orafo_titolo.id_titolo = "+string(ll_id_titolo)+ " and"
	
else
	
end if


string ls_temp

if ld_da_peso >	ld_a_peso then
	messagebox("Errore!", "Intervallo di peso specificato non valido!")
	tab_1.tabpage_1.dw_selezione.setcolumn("da_peso")
	return
end if
if Not IsNull(ld_da_peso) then
	ls_temp = string(ld_da_peso)
	ls_temp = Trim(ls_temp)
	ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
	ls_where= ls_where+ " unita_confezione.peso_netto >= " +string(ld_da_peso)
	
end if
if Not IsNull(ld_a_peso) then
	ls_temp = string(ld_a_peso)
	ls_temp = Trim(ls_temp)
	ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
	ls_where= ls_where+" unita_confezione.peso_netto <= " +string(ld_a_peso)
end if		
		
if ld_da_prezzo >	ld_a_prezzo then
	messagebox("Errore!", "Intervallo di prezzo specificato non valido!")
	tab_1.tabpage_1.dw_selezione.setcolumn("da_prezzo")
	return
end if
if ls_nome = "d_orafo_sel_stampa2_gd" THEN
	if Not IsNull(ld_da_prezzo) then
	
		ls_temp = string(ld_da_prezzo)
		ls_temp = Trim(ls_temp)
		ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
		ls_where= ls_where+ " prezzo.prezzo_manifattura >= " +string(ld_da_prezzo)
		
	end if
	if Not IsNull(ld_a_prezzo) then
	
		ls_temp = string(ld_a_prezzo)
		ls_temp = Trim(ls_temp)
		ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
		ls_where= ls_where+ "prezzo.prezzo_manifattura >= " +string(ld_a_prezzo)
		
	end if		
end if

long ll_righe

tab_1.SelectedTab=2

IF ls_where <>"" THEN
	ls_where = Left(ls_where,Len(ls_where)-3)
	is_filtro=ls_where
	
END IF
tab_1.tabpage_2.dw_my_list.SetTransObject(SQLCA)
tab_1.tabpage_2.dw_my_list.Retrieve()


end event

type cb_salva from commandbutton within w_formula_lt
integer x = 1783
integer y = 16
integer width = 343
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret
long ll_id_variazione

li_ret=tab_1.tabpage_1.dw_selezione.AcceptText()

if li_ret>0 then 
	ll_id_variazione=tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_variazione")
	if ll_id_variazione>0 then
	
		if messagebox('Attenzione!','Confermi salvataggio dati?',Information!,YesNO!)=2 then return
		if tab_1.tabpage_1.dw_selezione.Update()>0 then
			commit;
		else
			messagebox("Errore", "Non salvato!")
			rollback;
		end if
		il_formula=tab_1.tabpage_1.dw_selezione.GetItemNumber(1,"id_formula")
		tab_1.tabpage_3.dw_elenco.retrieve()
	ELSE
		messagebox('Attenzione!','Specificare il listino e la variazione!') 
	END IF
end if

end event

type cb_ok from commandbutton within w_formula_lt
integer x = 55
integer y = 24
integer width = 279
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;cb_salva.TriggerEvent(clicked!)
closeWithReturn(parent,il_formula)
end event

type cb_annulla from commandbutton within w_formula_lt
integer x = 425
integer y = 24
integer width = 343
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_nuovo from commandbutton within w_formula_lt
integer x = 928
integer y = 24
integer width = 297
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo"
end type

event clicked;cb_salva.triggerEvent(clicked!)
SetNull(il_formula)
tab_1.tabpage_1.dw_selezione.Reset()
tab_1.tabpage_1.dw_selezione.InsertRow(0)
end event

type cb_elimina from commandbutton within w_formula_lt
integer x = 1353
integer y = 20
integer width = 279
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elimina"
end type

event clicked;long ll_formula

if messagebox('Attenzione!','Vuoi eliminare la fromula corrente?',Exclamation!,YesNO!)=1 then
	choose case tab_1.selectedtab
		case 1
			delete from s_formula
			where s_formula.id_formula=:il_formula;
			SetNull(il_formula)	
			tab_1.tabpage_3.dw_elenco.retrieve()
			tab_1.tabpage_1.dw_selezione.Reset()
			tab_1.tabpage_1.dw_selezione.InsertRow(0)	
		case 3
			ll_formula=tab_1.tabpage_3.dw_elenco.getitemNumber(tab_1.tabpage_3.dw_elenco.getrow(),"id_formula")
			delete from s_formula
			where s_formula.id_formula=:ll_formula;
			tab_1.tabpage_3.dw_elenco.retrieve()
			if ll_formula=il_formula then
				tab_1.tabpage_1.dw_selezione.Reset()
				tab_1.tabpage_1.dw_selezione.InsertRow(0)	
				SetNull(il_formula)				
			end if
	end choose
end if
end event

