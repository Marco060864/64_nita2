forward
global type w_sit_sogg_comm_wz from w_wiz_main
end type
type tab_1 from tab within w_sit_sogg_comm_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_esidisp from u_dw_master_main within tabpage_1
end type
type tabpage_7 from userobject within tab_1
end type
type dw_storico_cli_for_lt from u_dw_ext_main within tabpage_7
end type
type dw_filtrocli from u_dw_ext_main within tabpage_7
end type
type cb_2 from commandbutton within tabpage_7
end type
type tabpage_2 from userobject within tab_1
end type
type dw_saldo from datawindow within tabpage_2
end type
type cb_estratto from commandbutton within tabpage_2
end type
type cb_saldo from commandbutton within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type sle_data from singlelineedit within tabpage_2
end type
type sle_attuale from singlelineedit within tabpage_2
end type
type ddlb_anno from dropdownlistbox within tabpage_2
end type
type sle_lire from singlelineedit within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_insoluti from datawindow within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_scadenze from datawindow within tabpage_4
end type
type cb_esci from commandbutton within w_sit_sogg_comm_wz
end type
type tabpage_1 from userobject within tab_1
dw_esidisp dw_esidisp
end type
type tabpage_7 from userobject within tab_1
dw_storico_cli_for_lt dw_storico_cli_for_lt
dw_filtrocli dw_filtrocli
cb_2 cb_2
end type
type tabpage_2 from userobject within tab_1
dw_saldo dw_saldo
cb_estratto cb_estratto
cb_saldo cb_saldo
st_1 st_1
sle_data sle_data
sle_attuale sle_attuale
ddlb_anno ddlb_anno
sle_lire sle_lire
st_2 st_2
st_3 st_3
end type
type tabpage_3 from userobject within tab_1
dw_insoluti dw_insoluti
end type
type tabpage_4 from userobject within tab_1
dw_scadenze dw_scadenze
end type
type tab_1 from tab within w_sit_sogg_comm_wz
tabpage_1 tabpage_1
tabpage_7 tabpage_7
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
end forward

global type w_sit_sogg_comm_wz from w_wiz_main
int Width=3031
int Height=1348
WindowType WindowType=response!
boolean TitleBar=true
string Title="Situazione articolo"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
tab_1 tab_1
cb_esci cb_esci
end type
global w_sit_sogg_comm_wz w_sit_sogg_comm_wz

type variables


integer ii_dwi
u_sql_scanner	iuo_scacq, iuo_scven
u_sql_scanner	iuo_sc_stor



long il_conto, il_id_art, il_sogg
long test_estratti, test_insoluti, test_partite
date id_da_data, id_a_data
string is_da_cod, is_a_cod

end variables

forward prototypes
public function integer uf_iniz ()
public subroutine wf_dw_set_focus ()
public function integer wf_calcola_storico_cliente ()
public subroutine uf_calc_estratti ()
public subroutine uf_calc_partite ()
end prototypes

public function integer uf_iniz ();long			ll_row
string		ls_sql


ll_row		= tab_1.tabpage_1.dw_esidisp.InsertRow(0)
tab_1.tabpage_1.dw_esidisp.ScrollToRow(ll_row)



iuo_scacq.f_setinitial(ls_sql)
iuo_scacq.f_setcurrent(ls_sql)

iuo_scven.f_setinitial(ls_sql)
iuo_scven.f_setcurrent(ls_sql)



tab_1.tabpage_7.dw_filtrocli.ScrollToRow(ll_row)

tab_1.tabpage_7.dw_storico_cli_for_lt.SetTransObject(SQLCA)
ls_sql = tab_1.tabpage_7.dw_storico_cli_for_lt.object.datawindow.table.select
iuo_sc_stor.f_setinitial(ls_sql)
iuo_sc_stor.f_setcurrent(ls_sql)

return 0
end function

public subroutine wf_dw_set_focus ();

choose case ii_dwi
	case 1
	case 2
		tab_1.SelectTab(1)
		tab_1.tabpage_1.dw_esidisp.setfocus() 
	case 3
		tab_1.SelectTab(2)
	case 4
	   tab_1.SelectTab(2)
	case 5
		tab_1.SelectTab(3)
	case 6
		tab_1.SelectTab(3)
	case 7
		tab_1.SelectTab(4)
	case 8	
		tab_1.SelectTab(4)
	case 9
		tab_1.SelectTab(5)
	case 10
		tab_1.SelectTab(6)
	case 11
		tab_1.SelectTab(7)

end choose


end subroutine

public function integer wf_calcola_storico_cliente ();
string		ls_where, ls_sql
long ll_sog

 


select id_sog_commerciale
into :ll_sog
from sog_commerciale
where id_conto=:il_conto;


tab_1.tabpage_7.dw_storico_cli_for_lt.retrieve(ll_sog,id_da_data,id_a_data)
tab_1.tabpage_7.dw_storico_cli_for_lt.ScrollToRow(1)
tab_1.tabpage_7.dw_storico_cli_for_lt.event RowFocusChanged(1)

return 0
end function

public subroutine uf_calc_estratti ();datastore ds_stampa
ds_stampa=create datastore
long ll_apertura, ll_es
date ld_data_competenza
integer li_ret
decimal ld_saldo_finale

tab_1.tabpage_2.dw_saldo.retrieve(il_conto)

tab_1.tabpage_2.sle_data.text=string(today())

select id_prof_reg_apertura
into :ll_apertura
from par_sistema;


select max(data_competenza)
into :ld_data_competenza
from reg_pd
where id_prof_registrazione=:ll_apertura;
	
if sqlca.sqlcode=100 or isnull(ld_data_competenza) then 
	  select min(data_COMPETENZA)
     into :ld_data_competenza
     from reg_pd;
end if

select id_valuta into :ll_es from esercizio
where data_inizio<=today() and data_fine>=today();
	
ds_stampa.dataobject='ds_calc_saldo_attuale_2'
ds_stampa.reset()
ds_stampa.settransobject(sqlca)
li_ret=ds_stampa.retrieve(il_conto,ld_data_competenza,1,0,ll_es)
if li_ret>0 then ld_saldo_finale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
tab_1.tabpage_2.sle_attuale.text=string(round(ld_saldo_finale,2))
tab_1.tabpage_2.sle_lire.text=string(round(ld_saldo_finale*(1936.27),0))
end subroutine

public subroutine uf_calc_partite ();
integer li_ret, ll_sog

DELETE FROM mov_scadenza
		 where id_mov_partita is null;

select id_sog_commerciale
into :ll_sog
from sog_commerciale
where id_conto=:il_conto;


li_ret=tab_1.tabpage_4.dw_scadenze.Retrieve(ll_sog)

	
end subroutine

on w_sit_sogg_comm_wz.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_esci=create cb_esci
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_esci
end on

on w_sit_sogg_comm_wz.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_esci)
end on

event open;call super::open;
iuo_scacq 	= create u_sql_scanner
iuo_scven 	= create u_sql_scanner
iuo_sc_stor	= create u_sql_scanner


tab_1.tabpage_1.dw_esidisp.settransobject(sqlca)
tab_1.tabpage_1.dw_esidisp.insertrow(0)
tab_1.tabpage_2.dw_saldo.dataobject='d_saldo_anno'
tab_1.tabpage_2.dw_saldo.settransobject(sqlca)
tab_1.tabpage_2.cb_saldo.Text = "Mese"
tab_1.tabpage_7.dw_storico_cli_for_lt.settransobject(sqlca)
tab_1.tabpage_7.dw_filtrocli.settransobject(sqlca)
tab_1.tabpage_7.dw_filtrocli.insertrow(0)
tab_1.tabpage_3.dw_insoluti.settransobject(sqlca)
tab_1.tabpage_4.dw_scadenze.settransobject(sqlca)

long ll_anno, i
select min(anno)
into :ll_anno
from saldo_mensile;
for i=ll_anno to year(today())
	tab_1.tabpage_2.ddlb_anno.InsertItem ( string(i), (i - ll_anno + 2) )
next	
tab_1.tabpage_2.ddlb_anno.Enabled = false

tab_1.tabpage_7.dw_filtrocli.setitem(1,'a_data',today())
tab_1.tabpage_7.dw_filtrocli.setitem(1,'da_data',date('01/01/'+string(year(today()))))

test_estratti=0
test_insoluti=0
test_partite=0


long ll_sogg
ll_sogg = Message.doubleparm
if not isnull(ll_sogg) and ll_sogg>0 then
  tab_1.tabpage_1.dw_esidisp.retrieve(ll_sogg)
end if	
	
	
	
	
	
	




end event

event key;call super::key;


if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>9 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=9
	end choose
	wf_dw_set_focus()
end if



end event

event close;call super::close;long ll_row

if isValid(iuo_scacq) then
	destroy (iuo_scacq)
end if

if isValid(iuo_scven) then
	destroy (iuo_scven)
end if

if isValid(iuo_sc_stor) then
	destroy (iuo_sc_stor)
end if

end event

type tab_1 from tab within w_sit_sogg_comm_wz
int X=23
int Y=124
int Width=2967
int Height=1128
int TabOrder=10
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_7 tabpage_7
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_7=create tabpage_7
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_7,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_7)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;
if tab_1.tabpage_1.dw_esidisp.rowcount()>0 then 
	il_conto=tab_1.tabpage_1.dw_esidisp.getitemnumber(1,'id_conto')
	il_sogg=tab_1.tabpage_1.dw_esidisp.getitemnumber(1,'id_sog_com')
end if



if  not isnull(il_conto) then
	
	if newindex=3 and test_estratti=0 then
	   uf_calc_estratti()
		test_estratti=1
	end if	
	
	
	if newindex=4 and test_insoluti=0 then
		test_insoluti=1
	   tab_1.tabpage_3.dw_insoluti.retrieve(il_sogg)
	end if
	
	
	if newindex=5 and test_partite=0 then
		test_partite=1
	  uf_calc_partite()
	end if
end if



end event

event selectionchanging;if newindex<>2 and oldindex=1 then return 1
end event

type tabpage_1 from userobject within tab_1
int X=18
int Y=104
int Width=2930
int Height=1008
long BackColor=79741120
string Text="Dati generali"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_esidisp dw_esidisp
end type

on tabpage_1.create
this.dw_esidisp=create dw_esidisp
this.Control[]={this.dw_esidisp}
end on

on tabpage_1.destroy
destroy(this.dw_esidisp)
end on

type dw_esidisp from u_dw_master_main within tabpage_1
int X=0
int Y=32
int Width=2866
int Height=880
int TabOrder=3
string DataObject="d_sel_sogg_ex"
end type

event ue_set_search;call super::ue_set_search;Choose case as_nomecol   
   case "codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "codice"         
	case "descrizione"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "rag_soc_1"    
end choose		
end event

event ue_use_search;dw_esidisp.retrieve(integer(is_ricpar.s_id_seg_value[1]))
end event

event getfocus;
end event

event itemchanged;string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long		ll_ok

choose case dwo.name
   case 'codice'
	   ls_sql_cond=""
		ls_dbc[1]=	"id_sog_commerciale"
		ls_dwc[1]=	"id_sog_com"

		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","codice",& 
		                         "A", data, ls_sql_cond,1,ls_dbc, ls_dbv, ls_dwc)
										 
		if ll_ok>0 then
			dw_esidisp.retrieve(integer(ls_dbv[1]))
			return 2
		end if
		
		
	 case 'descrizione'
		ls_sql_cond=""
		ls_dbc[1]=	"id_sog_commerciale"
		ls_dwc[1]=	"id_sog_com"

		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,1,ls_dbc, ls_dbv, ls_dwc)

		if ll_ok>0 then
			dw_esidisp.retrieve(integer(ls_dbv[1]))
			return 2
		end if
		
end choose
end event

event editchanged;test_estratti=0
test_insoluti=0
test_partite=0
tab_1.tabpage_2.dw_saldo.reset()
tab_1.tabpage_3.dw_insoluti.reset()
tab_1.tabpage_4.dw_scadenze.reset()
tab_1.tabpage_7.dw_storico_cli_for_lt.reset()
end event

type tabpage_7 from userobject within tab_1
int X=18
int Y=104
int Width=2930
int Height=1008
long BackColor=79741120
string Text="Storico Cli/For"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_storico_cli_for_lt dw_storico_cli_for_lt
dw_filtrocli dw_filtrocli
cb_2 cb_2
end type

on tabpage_7.create
this.dw_storico_cli_for_lt=create dw_storico_cli_for_lt
this.dw_filtrocli=create dw_filtrocli
this.cb_2=create cb_2
this.Control[]={this.dw_storico_cli_for_lt,&
this.dw_filtrocli,&
this.cb_2}
end on

on tabpage_7.destroy
destroy(this.dw_storico_cli_for_lt)
destroy(this.dw_filtrocli)
destroy(this.cb_2)
end on

type dw_storico_cli_for_lt from u_dw_ext_main within tabpage_7
int X=5
int Y=352
int Width=2903
int Height=648
int TabOrder=3
string DataObject="d_sit_sog_mov_ex"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event getfocus;call super::getfocus;ii_dwi=8
end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if

end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)

end event

event sqlpreview;
If not isnull(il_id_art) Then
	String Ls_SQLSyntax
	Ls_SQLSyntax = SQLSyntax + " AND riga_documento.id_articolo = " + String(il_id_art) 
	
	This.SetSQLPreview(ls_SQLSyntax)
End If

Ls_SQLSyntax = SQLSyntax + "ORDER BY documento.data_registrazione DESC, documento.num_progressivo DESC"   


end event

type dw_filtrocli from u_dw_ext_main within tabpage_7
int X=5
int Y=16
int Width=2350
int Height=272
int TabOrder=42
string DataObject="d_sit_sog_filtro_ex"
end type

event itemchanged;long		ll_row, ll_reg
string ls_filtro
integer li_ok

string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]




choose case dwo.name
	case "tipo_registro"
		
		messagebox('', data)

		ls_filtro = "registro_tipo_registro='"+data+"'"
		dw_storico_cli_for_lt.SetFilter(ls_filtro)
		dw_storico_cli_for_lt.Filter( )
		
		messagebox('', data)
		
	case "tutti_reg"
		if data='S' then
			ls_filtro = ""
			dw_storico_cli_for_lt.SetFilter(ls_filtro)
			dw_storico_cli_for_lt.Filter( )
		end if	
		
		
		
	
	case 'da_cod'
		

		
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_des"
		ls_dbc[3]=	"id_articolo"
		ls_dwc[3]=	"id_art"
		
		li_ok = uf_autofind_col(dwo.name,"articolo","codice","A",data,&
		                                ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_cod", Data)			
           This.SetItem(1, "a_des", This.GetItemString(1, "da_des"))
         end if
			RETURN 2
		END IF


	case 'da_des'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_des"
		ls_dbc[3]=	"id_articolo"
		ls_dwc[3]=	"id_art"

		li_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_des", Data)			
           This.SetItem(1, "a_cod", This.GetItemString(1, "da_cod"))
         end if
			RETURN 2
		END IF
		
	case 'a_cod'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_des"
		ls_dbc[3]=	"id_articolo"
		ls_dwc[3]=	"id_art"
		
		li_ok = uf_autofind_col(dwo.name,"articolo","codice","A",data,&
		                                ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		if li_ok>0 then
			return 2
		end if

	case 'a_des'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_des"
		ls_dbc[3]=	"id_articolo"
		ls_dwc[3]=	"id_art"

		li_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,3,ls_dbc, ls_dbv, ls_dwc)
		if li_ok>0 then
			return 2
		end if	

	
	
		
end choose


end event

event getfocus;call super::getfocus;ii_dwi=7
end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>11 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=11
	end choose
	wf_dw_set_focus()
end if

end event

event ue_set_search;Choose case as_nomecol
	case "da_cod"
		is_search_window = "w_articolo_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol           
		is_ricpar.s_filter_name  = "articolo_codice"  
	case "da_des"
		is_search_window = "w_articolo_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "articolo_descrizione"    
	case "a_cod"
		is_search_window = "w_articolo_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol           
		is_ricpar.s_filter_name  = "articolo_codice"  
	case "a_des"
		is_search_window = "w_articolo_coddes_sw"      
		is_ricpar.s_filter_value = as_valcol        
		is_ricpar.s_filter_name  = "articolo_descrizione"    
End choose		
end event

event ue_use_search;Choose case as_nomecol
	case "da_cod"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_art", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("da_des", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
		   uf_set_colval ("a_cod", is_ricpar.s_main_value)
         uf_set_colval ("a_des", is_ricpar.s_ausil_value[1])
		end if	
		
 	case "da_des"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_art", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("da_cod", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
		   uf_set_colval ("a_des", is_ricpar.s_main_value)
         uf_set_colval ("a_cod", is_ricpar.s_ausil_value[1])
		end if	
		
	case "a_cod"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_ar", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("a_des", is_ricpar.s_ausil_value[1])
		
 	case "a_des"
		uf_set_colval (as_nomecol, is_ricpar.s_main_value)
	   uf_set_colval ("id_art", is_ricpar.s_id_seg_value[1])
	   uf_set_colval ("a_cod", is_ricpar.s_ausil_value[1])
End choose		
end event

type cb_2 from commandbutton within tabpage_7
int X=2478
int Y=20
int Width=283
int Height=100
int TabOrder=33
boolean BringToTop=true
string Text="Esegui"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;id_da_data=dw_filtrocli.getitemdate(1,'da_data')
id_a_data=dw_filtrocli.getitemdate(1,'a_data')
il_id_art=dw_filtrocli.getitemnumber(1,'id_art')
wf_calcola_storico_cliente()

if isnull(id_da_data)or isnull(id_da_data)  then 
	messagebox('Attenzione', 'Una delle date non è stata inserita correttamente')
	return 1
end if	

string DWfilter2
long ll_reg

if dw_filtrocli.getitemstring(1,'tutti_reg')='N' then
   DWfilter2=dw_filtrocli.getitemstring(1,'tipo_registro')

	DWfilter2 =  "registro_tipo_registro='"+DWfilter2+"'"
	dw_storico_cli_for_lt.SetFilter(DWfilter2)
	dw_storico_cli_for_lt.Filter( )
end if







end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2930
int Height=1008
long BackColor=79741120
string Text="Saldo"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_saldo dw_saldo
cb_estratto cb_estratto
cb_saldo cb_saldo
st_1 st_1
sle_data sle_data
sle_attuale sle_attuale
ddlb_anno ddlb_anno
sle_lire sle_lire
st_2 st_2
st_3 st_3
end type

on tabpage_2.create
this.dw_saldo=create dw_saldo
this.cb_estratto=create cb_estratto
this.cb_saldo=create cb_saldo
this.st_1=create st_1
this.sle_data=create sle_data
this.sle_attuale=create sle_attuale
this.ddlb_anno=create ddlb_anno
this.sle_lire=create sle_lire
this.st_2=create st_2
this.st_3=create st_3
this.Control[]={this.dw_saldo,&
this.cb_estratto,&
this.cb_saldo,&
this.st_1,&
this.sle_data,&
this.sle_attuale,&
this.ddlb_anno,&
this.sle_lire,&
this.st_2,&
this.st_3}
end on

on tabpage_2.destroy
destroy(this.dw_saldo)
destroy(this.cb_estratto)
destroy(this.cb_saldo)
destroy(this.st_1)
destroy(this.sle_data)
destroy(this.sle_attuale)
destroy(this.ddlb_anno)
destroy(this.sle_lire)
destroy(this.st_2)
destroy(this.st_3)
end on

type dw_saldo from datawindow within tabpage_2
int X=46
int Y=40
int Width=2167
int Height=804
int TabOrder=13
boolean BringToTop=true
string DataObject="d_saldo_anno"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_estratto from commandbutton within tabpage_2
int X=2501
int Y=44
int Width=352
int Height=108
int TabOrder=23
boolean BringToTop=true
string Text="Estratto conto"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
OpenWithParm(w_estratto_conto_2_ff, il_conto)







end event

type cb_saldo from commandbutton within tabpage_2
int X=2501
int Y=184
int Width=352
int Height=108
int TabOrder=13
boolean BringToTop=true
string Text="Anno/Mese"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
if cb_saldo.Text = "Anno" then
    dw_saldo.dataobject='d_saldo_anno' 
    cb_saldo.Text = "Mese"
	 ddlb_anno.Enabled = false
else			
   dw_saldo.dataobject='d_saldo_mese' 
	cb_saldo.Text = "Anno"
	ddlb_anno.Enabled = TRUE
end if
dw_saldo.settransobject(sqlca)
dw_saldo.retrieve(il_conto)
end event

type st_1 from statictext within tabpage_2
int X=59
int Y=904
int Width=384
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Saldo attuale al"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_data from singlelineedit within tabpage_2
int X=485
int Y=900
int Width=247
int Height=68
int TabOrder=23
boolean BringToTop=true
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_attuale from singlelineedit within tabpage_2
int X=933
int Y=888
int Width=366
int Height=88
int TabOrder=33
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean RightToLeft=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_anno from dropdownlistbox within tabpage_2
int X=2501
int Y=348
int Width=421
int Height=452
int TabOrder=23
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Tutti"}
end type

event selectionchanged;string ls_filter, anno
integer li_ret
if index=1 then
	ls_filter=''

	dw_saldo.setfilter(ls_filter)
	dw_saldo.filter()
else
	anno=ddlb_anno.text
	ls_filter="anno="+anno
	dw_saldo.setfilter(ls_filter)
	dw_saldo.filter()
	
	
end if	
	
	
end event

type sle_lire from singlelineedit within tabpage_2
int X=1518
int Y=888
int Width=347
int Height=88
int TabOrder=33
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tabpage_2
int X=869
int Y=904
int Width=55
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="€"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_2
int X=1463
int Y=904
int Width=55
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="£"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2930
int Height=1008
long BackColor=79741120
string Text="Insoluti"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_insoluti dw_insoluti
end type

on tabpage_3.create
this.dw_insoluti=create dw_insoluti
this.Control[]={this.dw_insoluti}
end on

on tabpage_3.destroy
destroy(this.dw_insoluti)
end on

type dw_insoluti from datawindow within tabpage_3
int X=9
int Y=36
int Width=2875
int Height=924
int TabOrder=33
boolean BringToTop=true
string DataObject="d_sit_insoluti_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;dw_insoluti.SelectRow ( 0, false )
dw_insoluti.SelectRow ( currentrow, true )
end event

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=2930
int Height=1008
long BackColor=79741120
string Text="Scadenze"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_scadenze dw_scadenze
end type

on tabpage_4.create
this.dw_scadenze=create dw_scadenze
this.Control[]={this.dw_scadenze}
end on

on tabpage_4.destroy
destroy(this.dw_scadenze)
end on

type dw_scadenze from datawindow within tabpage_4
int X=23
int Y=36
int Width=2853
int Height=952
int TabOrder=33
boolean BringToTop=true
string DataObject="d_sit_scadenze_lt"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_esci from commandbutton within w_sit_sogg_comm_wz
int X=2688
int Y=32
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)
end event

