forward
global type w_st_pb from w_001
end type
type tab_1 from tab within w_st_pb
end type
type tabpage_1 from userobject within tab_1
end type
type header from vscrollbar within tabpage_1
end type
type detail from vscrollbar within tabpage_1
end type
type footer from vscrollbar within tabpage_1
end type
type dw_4 from dw_primo within tabpage_1
end type
type summary from vscrollbar within tabpage_1
end type
type dw_1 from dw_quarta within tabpage_1
end type
type tabpage_1 from userobject within tab_1
header header
detail detail
footer footer
dw_4 dw_4
summary summary
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type cb_cancella from commandbutton within tabpage_2
end type
type cb_inserisci from commandbutton within tabpage_2
end type
type cb_salva_dw from commandbutton within tabpage_2
end type
type cb_crea_lib from commandbutton within tabpage_2
end type
type dw_6 from dw_quarta within tabpage_2
end type
type dw_3 from dw_primo within tabpage_2
end type
type sle_salva_in from singlelineedit within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
cb_cancella cb_cancella
cb_inserisci cb_inserisci
cb_salva_dw cb_salva_dw
cb_crea_lib cb_crea_lib
dw_6 dw_6
dw_3 dw_3
sle_salva_in sle_salva_in
end type
type tab_1 from tab within w_st_pb
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_out from commandbutton within w_st_pb
end type
type sle_zoom from singlelineedit within w_st_pb
end type
type cb_in from commandbutton within w_st_pb
end type
type pb_crea_col from uo_pb within w_st_pb
end type
type pb_crea_oggetto from uo_pb within w_st_pb
end type
type pb_blocca from uo_pb within w_st_pb
end type
type pb_stampa_1 from uo_pb within w_st_pb
end type
type cb_memorizza from uo_cb within w_st_pb
end type
type cb_dis_da_valori from uo_cb within w_st_pb
end type
type pb_salva from uo_pb within w_st_pb
end type
type cb_crea_sottoreport from commandbutton within w_st_pb
end type
type dw_5 from dw_primo within w_st_pb
end type
type sle_copie from singlelineedit within w_st_pb
end type
type pb_ordina from uo_pb within w_st_pb
end type
type pb_stampa_no_footer from uo_pb within w_st_pb
end type
type cb_1 from commandbutton within w_st_pb
end type
end forward

global type w_st_pb from w_001
integer x = 0
integer y = 0
integer width = 3575
integer height = 2032
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
event ue_postopen ( )
tab_1 tab_1
cb_out cb_out
sle_zoom sle_zoom
cb_in cb_in
pb_crea_col pb_crea_col
pb_crea_oggetto pb_crea_oggetto
pb_blocca pb_blocca
pb_stampa_1 pb_stampa_1
cb_memorizza cb_memorizza
cb_dis_da_valori cb_dis_da_valori
pb_salva pb_salva
cb_crea_sottoreport cb_crea_sottoreport
dw_5 dw_5
sle_copie sle_copie
pb_ordina pb_ordina
pb_stampa_no_footer pb_stampa_no_footer
cb_1 cb_1
end type
global w_st_pb w_st_pb

type variables
string is_oggetto, is_Table, is_dw_originale
integer il_test, ii_zoom=100
long il_id_doc, il_row
string is_h_footer= "-1"
string is_report, is_selezione
end variables

forward prototypes
public subroutine wf_allinea_preview ()
public subroutine wf_inserisci_campo (string as_nome_campo, string as_nome_tab)
public subroutine wf_export_dw (string as_nome_dw, string as_sintax)
public subroutine wf_carica_dw_da_lib ()
public subroutine wf_completa_cancellazione (string as_colonna)
public subroutine wf_da_disegno_a_valori (string as_oggetto)
public subroutine wf_da_valori_a_disegno (string as_oggetto, long al_riga)
public subroutine wf_cambia_nome (string as_old_nome, string as_new_nome)
end prototypes

event ue_postopen();long ll_righe, ll_id_conf
long  ll_x, ll_y, ll_riga_trovata
integer i

il_test=1



ll_righe=tab_1.tabpage_2.dw_2.retrieve()
if ll_righe>0 then
	ll_riga_trovata=tab_1.tabpage_2.dw_2.find("codice='"+is_report+"'", 1,ll_righe )
	if ll_riga_trovata>0 then
		tab_1.tabpage_2.dw_2.scrolltorow(ll_riga_trovata)	
		ll_id_conf=tab_1.tabpage_2.dw_2.getitemnumber(ll_riga_trovata, "id_conf_oggetti")
		ll_righe=tab_1.tabpage_2.dw_3.retrieve(ll_id_conf)
	else
		messagebox("Errore!", "Report: "+is_report+ " non trovato!")
//		ll_id_conf=tab_1.tabpage_2.dw_2.getitemnumber(1, "id_conf_oggetti")
//		ll_righe=tab_1.tabpage_2.dw_3.retrieve()
	end if
	
end if	

WF_CARICA_DW_DA_LIB()
if is_selezione>"" then
	if isvalid(tab_1.tabpage_1.dw_1.object.t_selezione) then
		tab_1.tabpage_1.dw_1.object.t_selezione.text="SELEZIONE: "+is_selezione
	end if
end if


pb_blocca.tag="Sblocca"
pb_blocca.triggerevent(clicked!)


x=0
y=0



end event

public subroutine wf_allinea_preview ();
end subroutine

public subroutine wf_inserisci_campo (string as_nome_campo, string as_nome_tab);
end subroutine

public subroutine wf_export_dw (string as_nome_dw, string as_sintax);string ErrorBuffer, ls_path_libreria
integer ll_riga

ll_riga=tab_1.tabpage_2.dw_2.getrow()
if ll_riga> 0 then
	ls_path_libreria=tab_1.tabpage_2.dw_2.getitemstring(ll_riga, "libreria")
	if ls_path_libreria>"" then
		if LibraryImport(ls_path_libreria, as_nome_dw, ImportDataWindow!, &
			as_sintax, ErrorBuffer, "DataWindow dinamica") <> 1 then
				messagebox("Errore", ErrorBuffer)
		end if
	end if
end if


end subroutine

public subroutine wf_carica_dw_da_lib ();
string dwsyntax, ls_codice,ls_path_libreria
long ll_riga

ll_riga=tab_1.tabpage_2.dw_2.getrow()
if ll_riga> 0 then
	ls_codice=tab_1.tabpage_2.dw_2.getitemstring(ll_riga, "codice")
	ls_path_libreria=tab_1.tabpage_2.dw_2.getitemstring(ll_riga, "libreria")
	if ls_path_libreria>"" then
		dwsyntax = LibraryExport(ls_path_libreria, ls_codice, ExportDataWindow!)
		IF dwsyntax>"" THEN
			tab_1.tabpage_1.dw_1.create(dwsyntax)
			tab_1.tabpage_1.dw_1.settransobject(sqlca)
			tab_1.tabpage_1.dw_1.retrieve(il_id_doc)
		ELSE
			MESSAGEBOX("ERRORE!", "ERRORE")
		END IF
	else
		MESSAGEBOX("ERRORE!", "Indicare il percorso della libreria!")
	end if
end if
end subroutine

public subroutine wf_completa_cancellazione (string as_colonna);
end subroutine

public subroutine wf_da_disegno_a_valori (string as_oggetto);string ls_objects,ls_oldstr, ls_oggetto, ls_codice, ls_banda, dwsyntax, ls_tipo
integer ll_start_pos, ll_pos_ini, ll_riga, li_bordo
long ll_x, ll_y, ll_riga_corrente, ll_id_conf
long ll_righe, i
string ls_d_object
boolean lb_primo_piano

if as_oggetto>"" then 
	ls_objects=as_oggetto + "~t"
else
	ls_objects = tab_1.tabpage_1.dw_1.Object.DataWindow.Objects
	ll_righe=tab_1.tabpage_2.dw_3.rowcount()
	tab_1.tabpage_2.dw_3.rowsmove(1, ll_righe, primary!, tab_1.tabpage_2.dw_3,1,  delete!)
end if

ls_oldstr = "~t"
ll_start_pos = Pos(ls_objects, ls_oldstr)
ll_riga=tab_1.tabpage_2.dw_2.getrow()
if ll_riga> 0 then
	
	ll_id_conf=tab_1.tabpage_2.dw_2.getitemnumber(ll_riga, "id_conf_oggetti")
	ls_codice=tab_1.tabpage_2.dw_2.getitemstring(ll_riga, "codice")
	if ll_id_conf>0 then
		DO WHILE ll_start_pos > 0 
			ls_oggetto=mid(ls_objects, ll_pos_ini+1, (ll_start_pos - 1) - (ll_pos_ini) )
			if ls_oggetto>"" then 
				ll_riga=tab_1.tabpage_2.dw_3.find("oggetto='"+ls_oggetto+"'", 1,tab_1.tabpage_2.dw_3.rowcount() )
				if ll_riga<=0 then
					ll_riga=tab_1.tabpage_2.dw_3.insertrow(0)
					tab_1.tabpage_2.dw_3.scrolltorow(ll_riga)
				end if
				
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "oggetto", ls_oggetto)
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "id_conf_oggetti", ll_id_conf)
				
				ls_tipo=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".type")
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "tipo", ls_tipo)
				
				if ls_tipo='line'  then
					
					ll_x=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".x1"))
					ll_y=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".y1"))
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "pos_x", ll_x)
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "pos_y", ll_y)
					
					ll_x=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".x2"))
					ll_y=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".y2"))
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "larghezza", ll_x)
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "lunghezza", ll_y)
				else
					
					ll_x=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".x"))
					ll_y=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".y"))
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "pos_x", ll_x)
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "pos_y", ll_y)
					
					ll_x=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".width"))
					ll_y=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".height"))
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "larghezza", ll_x)
					tab_1.tabpage_2.dw_3.setitem(ll_riga, "lunghezza", ll_y)
				end if
					
				
				
				ls_banda=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".band")
				if ls_tipo='report' then	
					lb_primo_piano=false
					li_bordo=0
				else 
					lb_primo_piano=true
					li_bordo=1
				end if
				tab_1.tabpage_1.dw_1.setposition(ls_oggetto, "", lb_primo_piano)
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "primo_piano", li_bordo)
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "banda", ls_banda)
				
				
				
				ll_x=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".moveable"))
				ll_y=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".resizeable"))
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "spostabile", ll_x)
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "ridimensionabile", ll_y)
				
				li_bordo=integer(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".border"))
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "bordo", li_bordo)
				
				ls_banda=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".visible")
				
				tab_1.tabpage_2.dw_3.setitem(ll_riga, "visibile", ls_banda)
				
			end if
			ls_oggetto=''
			ll_pos_ini=ll_start_pos
			ll_start_pos = Pos(ls_objects, ls_oldstr, ll_pos_ini+1)
			if ll_start_pos=0 and  ll_pos_ini+1< len(ls_objects) then
				ll_start_pos=len(ls_objects) + 1
			end if
				
			
		LOOP
		tab_1.tabpage_2.dw_3.sort()
		
		
		
		
		wf_allinea_preview()
		
		dwsyntax = tab_1.tabpage_1.dw_1.Describe("DataWindow.Syntax")
	
			wf_export_dw(ls_codice, dwsyntax)
	
		wf_allinea_preview()
		
	end if
end if
end subroutine

public subroutine wf_da_valori_a_disegno (string as_oggetto, long al_riga);long ll_righe, ll_x, ll_y, ll_a_riga
integer i, li_bordo, li_top, li_bottom, li_left, li_right, li_da_riga
string ls_oggetto, ls_banda, ls_ret, ls_tipo

tab_1.tabpage_2.dw_3.accepttext()
ll_righe=tab_1.tabpage_2.dw_2.getrow()

if as_oggetto>"" then
	ll_a_riga=al_riga
	li_da_riga=al_riga
else
	ll_a_riga=tab_1.tabpage_2.dw_3.rowcount()
	li_da_riga=1
	
	ll_y=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "header")*1000)
	tab_1.tabpage_1.dw_1.modify("datawindow.header.height= "+ string(ll_y))
	
	ll_y=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "detail")*1000)
	if ll_y= -1000 then
		tab_1.tabpage_1.dw_1.modify("datawindow.detail.height= 0")
		tab_1.tabpage_1.dw_1.modify("datawindow.detail.height.autosize= Yes")	
	else
		tab_1.tabpage_1.dw_1.modify("datawindow.detail.height= "+ string(ll_y))
	end if
	ll_y=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "footer")*1000)
	tab_1.tabpage_1.dw_1.modify("datawindow.footer.height= "+ string(ll_y))
	
	ll_y=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "summary")*1000)
	tab_1.tabpage_1.dw_1.modify("datawindow.summary.height= "+ string(ll_y))
	
	ll_y=0	
	
	li_top=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "top")*1000)
	ls_ret=tab_1.tabpage_1.dw_1.Modify("DataWindow.Print.Margin.Top= "+string(li_top))
	li_bottom=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "bottom")*1000)
	ls_ret=tab_1.tabpage_1.dw_1.Modify("DataWindow.Print.Margin.bottom= "+string(li_bottom))
	li_left=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "left")*1000)
	ls_ret=tab_1.tabpage_1.dw_1.Modify("DataWindow.Print.Margin.left= "+string(li_left))
	li_right=long(tab_1.tabpage_2.dw_2.getitemdecimal(ll_righe, "right")*1000)
	ls_ret=tab_1.tabpage_1.dw_1.Modify("DataWindow.Print.Margin.right= "+string(li_right))
end if


for i = li_da_riga to ll_a_riga
	ls_oggetto=tab_1.tabpage_2.dw_3.getitemstring(i, "oggetto")
	ll_x=tab_1.tabpage_2.dw_3.getitemdecimal(i, "pos_x")
	ll_y=tab_1.tabpage_2.dw_3.getitemdecimal(i, "pos_y")
	ls_tipo=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".type")
	if ls_tipo='line' then
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".x1= "+ string(ll_x))
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".y1= "+ string(ll_y))
		ll_x=tab_1.tabpage_2.dw_3.getitemdecimal(i, "larghezza")
		ll_y=tab_1.tabpage_2.dw_3.getitemdecimal(i, "lunghezza")
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".x2= "+ string(ll_x))
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".y2= "+ string(ll_y))
	else
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".x= "+ string(ll_x))
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".y= "+ string(ll_y))
		ll_x=tab_1.tabpage_2.dw_3.getitemdecimal(i, "larghezza")
		ll_y=tab_1.tabpage_2.dw_3.getitemdecimal(i, "lunghezza")
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".width= "+ string(ll_x))
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".height= "+ string(ll_y))
	end if
	
	
	ls_banda=tab_1.tabpage_2.dw_3.getitemstring(i, "banda")
	li_bordo=tab_1.tabpage_2.dw_3.getitemnumber(i, "primo_piano")
	IF LI_BORDO=1 then
		tab_1.tabpage_1.dw_1.SetPosition(ls_oggetto, ls_banda, true)
	else
		tab_1.tabpage_1.dw_1.SetPosition(ls_oggetto, ls_banda, true)
	end if
	
	ll_x=tab_1.tabpage_2.dw_3.getitemnumber(i, "spostabile")
	ll_y=tab_1.tabpage_2.dw_3.getitemnumber(i, "ridimensionabile")
	tab_1.tabpage_1.dw_1.modify(ls_oggetto+".moveable= "+ string(ll_x))
	tab_1.tabpage_1.dw_1.modify(ls_oggetto+".resizeable= "+ string(ll_y))
	
	li_bordo=tab_1.tabpage_2.dw_3.getitemnumber(i, "bordo")
	tab_1.tabpage_1.dw_1.modify(ls_oggetto+".border= "+ string(li_bordo))
	
	ls_banda=tab_1.tabpage_2.dw_3.getitemstring(i, "visibile")
	if isnull(ls_banda) then ls_banda="1"
	
	tab_1.tabpage_1.dw_1.modify(ls_oggetto+".visible= "+ ls_banda)
	
next
	
wf_allinea_preview()
end subroutine

public subroutine wf_cambia_nome (string as_old_nome, string as_new_nome);string dwsyntax,ls_codice
long ll_pos, ll_riga, ll_start=1, ll_len_new

if as_new_nome = as_old_nome then return

dwsyntax = tab_1.tabpage_1.dw_1.Describe("DataWindow.Syntax")
ll_pos=pos(dwsyntax, as_new_nome+" ")
if ll_pos>0 then
	messagebox("Errore!", "Nome di campo: "+as_new_nome+" già esistente ~r~n"&
	+" in parte o in tutto!")
	return
end if

ll_riga=tab_1.tabpage_2.dw_2.getrow()
if ll_riga> 0 then
	ls_codice=tab_1.tabpage_2.dw_2.getitemstring(ll_riga, "codice")
	ll_len_new=len(as_new_nome)
	do 
		ll_pos=pos(dwsyntax, as_old_nome+" ", ll_start)
		if ll_pos>0 then
			dwsyntax=left(dwsyntax, ll_pos - 1)+as_new_nome+" "+right(dwsyntax, len(dwsyntax) - (ll_pos + len(as_old_nome)))
		end if
		ll_start=ll_pos+ll_len_new
	loop while ll_pos>0 
	
	wf_export_dw(ls_codice, dwsyntax)
	wf_carica_dw_da_lib()
end if
end subroutine

on w_st_pb.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_out=create cb_out
this.sle_zoom=create sle_zoom
this.cb_in=create cb_in
this.pb_crea_col=create pb_crea_col
this.pb_crea_oggetto=create pb_crea_oggetto
this.pb_blocca=create pb_blocca
this.pb_stampa_1=create pb_stampa_1
this.cb_memorizza=create cb_memorizza
this.cb_dis_da_valori=create cb_dis_da_valori
this.pb_salva=create pb_salva
this.cb_crea_sottoreport=create cb_crea_sottoreport
this.dw_5=create dw_5
this.sle_copie=create sle_copie
this.pb_ordina=create pb_ordina
this.pb_stampa_no_footer=create pb_stampa_no_footer
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_out
this.Control[iCurrent+3]=this.sle_zoom
this.Control[iCurrent+4]=this.cb_in
this.Control[iCurrent+5]=this.pb_crea_col
this.Control[iCurrent+6]=this.pb_crea_oggetto
this.Control[iCurrent+7]=this.pb_blocca
this.Control[iCurrent+8]=this.pb_stampa_1
this.Control[iCurrent+9]=this.cb_memorizza
this.Control[iCurrent+10]=this.cb_dis_da_valori
this.Control[iCurrent+11]=this.pb_salva
this.Control[iCurrent+12]=this.cb_crea_sottoreport
this.Control[iCurrent+13]=this.dw_5
this.Control[iCurrent+14]=this.sle_copie
this.Control[iCurrent+15]=this.pb_ordina
this.Control[iCurrent+16]=this.pb_stampa_no_footer
this.Control[iCurrent+17]=this.cb_1
end on

on w_st_pb.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_out)
destroy(this.sle_zoom)
destroy(this.cb_in)
destroy(this.pb_crea_col)
destroy(this.pb_crea_oggetto)
destroy(this.pb_blocca)
destroy(this.pb_stampa_1)
destroy(this.cb_memorizza)
destroy(this.cb_dis_da_valori)
destroy(this.pb_salva)
destroy(this.cb_crea_sottoreport)
destroy(this.dw_5)
destroy(this.sle_copie)
destroy(this.pb_ordina)
destroy(this.pb_stampa_no_footer)
destroy(this.cb_1)
end on

event open;call super::open;
s_crea_dw s_recupera_parametri
long ll_riga_trovata, ll_righe

tab_1.tabpage_1.dw_1.settransobject(sqlca)
is_dw_originale=tab_1.tabpage_1.dw_1.dataobject

tab_1.tabpage_2.dw_2.settransobject(sqlca)
tab_1.tabpage_2.dw_3.settransobject(sqlca)

if isvalid(message.powerobjectparm) then
	s_recupera_parametri=message.powerobjectparm
	il_id_doc=long(s_recupera_parametri.ll_id_doc)
	is_report=s_recupera_parametri.ls_dw_sintax
	is_selezione=s_recupera_parametri.s_selezione
	triggerevent("ue_postopen")
end if
//if il_id_doc>0 then
//	
//else
//	messagebox("Errore", "Nessun Documento da stampare")
//end if


end event

event resize;call super::resize;tab_1.width=newwidth - 10
tab_1.height=newheight - 40 - tab_1.y
tab_1.tabpage_1.dw_1.width=tab_1.width - 120
tab_1.tabpage_1.dw_1.height=tab_1.height - 30 - tab_1.tabpage_1.dw_1.y - 300
tab_1.tabpage_1.dw_4.y=tab_1.tabpage_1.dw_1.y + tab_1.tabpage_1.dw_1.height
tab_1.tabpage_1.header.x= tab_1.tabpage_1.dw_1.x + tab_1.tabpage_1.dw_1.width +10
tab_1.tabpage_1.detail.x=tab_1.tabpage_1.header.x
tab_1.tabpage_1.summary.x=tab_1.tabpage_1.header.x
tab_1.tabpage_1.footer.x=tab_1.tabpage_1.header.x

tab_1.tabpage_2.dw_3.height= tab_1.height - tab_1.tabpage_2.dw_2.height -350
end event

type st_1 from w_001`st_1 within w_st_pb
integer height = 72
end type

type tab_1 from tab within w_st_pb
event create ( )
event destroy ( )
integer y = 16
integer width = 3525
integer height = 1852
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3488
integer height = 1724
long backcolor = 79741120
string text = "Disegno"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
header header
detail detail
footer footer
dw_4 dw_4
summary summary
dw_1 dw_1
end type

on tabpage_1.create
this.header=create header
this.detail=create detail
this.footer=create footer
this.dw_4=create dw_4
this.summary=create summary
this.dw_1=create dw_1
this.Control[]={this.header,&
this.detail,&
this.footer,&
this.dw_4,&
this.summary,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.header)
destroy(this.detail)
destroy(this.footer)
destroy(this.dw_4)
destroy(this.summary)
destroy(this.dw_1)
end on

type header from vscrollbar within tabpage_1
string tag = "Header"
integer x = 3415
integer width = 73
integer height = 364
boolean bringtotop = true
boolean stdwidth = false
integer maxposition = 10000
integer position = 1000
end type

event moved;DragObject Source

string ls_classname
LONG LL_RIGA
Source = this
ls_classname = Source.ClassName()


tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(scrollpos))
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(scrollpos - 20))
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(scrollpos - 20))

LL_RIGA=tab_1.tabpage_2.dw_2.GETROW()
tab_1.tabpage_2.dw_2.SETITEM(LL_RIGA, LS_CLASSNAME, scrollpos/1000)
end event

event linedown;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position > This.MaxPosition - 10 THEN

	This.Position = MaxPosition

ELSE
	This.Position = This.Position + 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

event lineup;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position < This.MINPosition + 10 THEN

	This.Position = MINPosition

ELSE
	This.Position = This.Position - 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

type detail from vscrollbar within tabpage_1
string tag = "Header"
integer x = 3415
integer y = 368
integer width = 73
integer height = 364
boolean bringtotop = true
boolean stdwidth = false
integer maxposition = 10000
integer position = 1000
end type

event linedown;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position > This.MaxPosition - 10 THEN

	This.Position = MaxPosition

ELSE
	This.Position = This.Position + 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

event lineup;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position < This.MINPosition + 10 THEN

	This.Position = MINPosition

ELSE
	This.Position = This.Position - 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

event moved;DragObject Source

string ls_classname
LONG LL_RIGA
Source = this
ls_classname = Source.ClassName()


tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(scrollpos))
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(scrollpos - 20))
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(scrollpos - 20))

LL_RIGA=tab_1.tabpage_2.dw_2.GETROW()
tab_1.tabpage_2.dw_2.SETITEM(LL_RIGA, LS_CLASSNAME, scrollpos/1000)
end event

type footer from vscrollbar within tabpage_1
string tag = "Header"
integer x = 3415
integer y = 1096
integer width = 73
integer height = 352
boolean bringtotop = true
boolean stdwidth = false
integer maxposition = 10000
integer position = 1000
end type

event linedown;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position > This.MaxPosition - 10 THEN

	This.Position = MaxPosition

ELSE
	This.Position = This.Position + 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

event lineup;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position < This.MINPosition + 10 THEN

	This.Position = MINPosition

ELSE
	This.Position = This.Position - 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

event moved;DragObject Source

string ls_classname
LONG LL_RIGA
Source = this
ls_classname = Source.ClassName()

tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(scrollpos))
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1= "+"20")
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2= "+"20")

LL_RIGA=tab_1.tabpage_2.dw_2.GETROW()
tab_1.tabpage_2.dw_2.SETITEM(LL_RIGA, LS_CLASSNAME, scrollpos/1000)


end event

type dw_4 from dw_primo within tabpage_1
integer x = 5
integer y = 1476
integer width = 3493
integer height = 224
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_lista_oggetti_shared"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;post wf_da_valori_a_disegno(getitemstring(row, "oggetto"), row)
end event

type summary from vscrollbar within tabpage_1
string tag = "summary"
integer x = 3415
integer y = 732
integer width = 73
integer height = 360
boolean bringtotop = true
boolean stdwidth = false
integer maxposition = 10000
integer position = 1000
end type

event linedown;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position > This.MaxPosition - 10 THEN

	This.Position = MaxPosition

ELSE
	This.Position = This.Position + 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

event lineup;DragObject Source

string ls_classname
Source = this
ls_classname = Source.ClassName()

IF This.Position < This.MINPosition + 10 THEN

	This.Position = MINPosition

ELSE
	This.Position = This.Position - 10
	tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(This.Position))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(This.Position - 20))
	tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(This.Position - 20))
END IF

tab_1.tabpage_2.dw_2.modify( ls_classname+"="+string(This.Position/1000))
end event

event moved;DragObject Source

string ls_classname
LONG LL_RIGA
Source = this
ls_classname = Source.ClassName()


tab_1.tabpage_1.dw_1.Modify("DataWindow."+ls_classname+".Height="+string(scrollpos))
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y1="+string(scrollpos - 20))
tab_1.tabpage_1.dw_1.Modify(ls_classname+".y2="+string(scrollpos - 20))

LL_RIGA=tab_1.tabpage_2.dw_2.GETROW()
tab_1.tabpage_2.dw_2.SETITEM(LL_RIGA, LS_CLASSNAME, scrollpos/1000)
end event

type dw_1 from dw_quarta within tabpage_1
integer y = 16
integer width = 3410
integer height = 1440
integer taborder = 20
string dataobject = "d_fat_base_2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;string ls_filtro, ls_tipo_bordo, ls_testo, ls_oggetto, ls_tipo, ls_banda
integer ll_righe, ll_riga_trovata
long ll_xpos, ll_ypos

ls_tipo=dwo.type
is_oggetto=dwo.name
if ls_tipo<> 'datawindow' and ls_tipo>" " then
	
	ls_tipo_bordo=dw_1.describe(string(dwo.name)+".border")
	if ls_tipo_bordo<>'2' then
		dw_1.modify(string(dwo.name)+".border=2")
	else
		dw_1.modify(string(dwo.name)+".border=0")
	end if
ELSE
end if
if is_oggetto<> 'datawindow' and is_oggetto>" " then
	ll_righe=dw_4.rowcount()
	LS_FILTRO="oggetto='"+is_oggetto+"'"
	ls_oggetto=is_oggetto
	ll_righe=dw_4.find(ls_filtro,1, ll_righe)
	dw_4.scrolltorow(ll_righe)
end if


end event

event retrieveend;ShareData(tab_1.tabpage_2.dw_6)
tab_1.tabpage_1.dw_1.object.datawindow.print.preview.rulers="yes"


end event

event doubleclicked;integer ll_row
string ls_tipo,ls_test
s_dinamica s_dina
if row>0 then
	ll_row=row
else
	ll_row=getrow()
	if ll_row<=0 then ll_row=1
end if
s_dina.ls_tipo=dwo.type
choose case s_dina.ls_tipo
	case "text", "compute" , "column", "report"
	s_dina.ls_nome=dwo.name
	If s_dina.ls_tipo="text" then 
		s_dina.ls_testo=dwo.text
	elseif s_dina.ls_tipo="column" then
		ls_tipo=dwo.coltype
		choose case left(dwo.coltype, 4)
			case	"numb"
				s_dina.ls_testo=string(tab_1.tabpage_1.dw_1.getitemnumber(ll_row, s_dina.ls_nome))	
			case  "date" 
				s_dina.ls_testo=string(tab_1.tabpage_1.dw_1.getitemdate(ll_row, s_dina.ls_nome))
			case"char" 
				s_dina.ls_testo=tab_1.tabpage_1.dw_1.getitemstring(ll_row, s_dina.ls_nome)
			case  "deci" 
				s_dina.ls_testo=string(tab_1.tabpage_1.dw_1.getitemdecimal(ll_row, s_dina.ls_nome))
		end choose
	elseif s_dina.ls_tipo="compute" then
		s_dina.ls_testo=string(dwo.expression)
	end if
	openwithparm(w_crea_text, s_dina)
	s_dina=message.powerobjectparm
	if isvalid(s_dina) then
		if s_dina.cancella='S' then
			this.modify("destroy "+string(dwo.name))
			
			
			return
		end if
		if s_dina.ls_testo>'' and s_dina.cancella='N' then
			if s_dina.ls_tipo="column" then
				dw_1.setitem(ll_row, string(dwo.name),s_dina.ls_testo)	
			else
				dw_1.modify(string(dwo.name)+".text='"+s_dina.ls_testo+"'")	
			end if
		end if
		if s_dina.ls_nome>'' then
			ls_test=dw_1.modify(string(dwo.name)+".name="+s_dina.ls_nome)
			if ls_test>"" then wf_cambia_nome(string(dwo.name), s_dina.ls_nome)
			
			
		end if
	end if

case "bitmap"
	s_dina.ls_nome=dwo.name
	s_dina.ls_tipo=dwo.type
	s_dina.ls_testo=dwo.filename
	openwithparm(w_crea_text, s_dina)
	s_dina=message.powerobjectparm
	if isvalid(s_dina) then
		if s_dina.cancella='S' then
			this.modify("destroy "+string(dwo.name))
			
			
		else
			if s_dina.ls_testo>'' and s_dina.cancella='N' then
				dw_1.modify(string(dwo.name)+".filename='"+s_dina.ls_testo+"'")	
			end if
			if s_dina.ls_nome>'' then
				
				ls_test=dw_1.modify(string(dwo.name)+".name="+s_dina.ls_nome)	
				if ls_test>"" then wf_cambia_nome(string(dwo.name), s_dina.ls_nome)
			end if
		end if
	end if
case "rectangle", "line"
	s_dina.ls_nome=dwo.name
	s_dina.ls_tipo=dwo.type
	s_dina.ls_testo=dwo.name
	openwithparm(w_crea_text, s_dina)
	if isvalid(message.powerobjectparm) then
		s_dina=message.powerobjectparm
		if s_dina.cancella='S' then
			this.modify("destroy "+string(dwo.name))
			
			
			return
		end if
		if s_dina.ls_testo>'' and s_dina.cancella='N' then
			dw_1.modify(string(dwo.name)+".filename='"+s_dina.ls_testo+"'")	
		end if
		if s_dina.ls_nome>'' then
			
			ls_test=dw_1.modify(string(dwo.name)+".name="+s_dina.ls_nome)	
			if ls_test>"" then wf_cambia_nome(string(dwo.name), s_dina.ls_nome)
		end if
	end if
	
end  choose
end event

event rbuttondown;

s_attrib_testo s_attrib
string ls_tipo, ls_oggetto

ls_tipo=dwo.type
if ls_tipo<> 'datawindow' then
	ls_oggetto=dwo.name
	s_attrib.li_stile=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".font.Weight"))
	s_attrib.li_paragrafo=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".alignment"))
	s_attrib.li_corpo=long(tab_1.tabpage_1.dw_1.describe(ls_oggetto+".font.Height"))
	s_attrib.ls_autosize=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".Height.AutoSize")
	s_attrib.ls_formato=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".format")
	s_attrib.ls_carattere=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".font.face")
	s_attrib.ls_corsivo=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".font.italic")
	s_attrib.ls_sottolineato=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".font.Underline")
	s_attrib.ls_barrato=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".font.Strikethrough")
	s_attrib.ls_visibile=tab_1.tabpage_1.dw_1.describe(ls_oggetto+".Visible")
	if pos(s_attrib.ls_visibile, ls_oggetto)>0 then 
		if pos(s_attrib.ls_visibile, "pagecount()")>0 then
			s_attrib.ls_visibile="2"
			s_attrib.ls_ometti_se_zero="0"
		else
			s_attrib.ls_ometti_se_zero="1"
			s_attrib.ls_visibile="1"
		end if
	else
		s_attrib.ls_ometti_se_zero="0"
	end if
	



	openwithparm(w_stile_testo, s_attrib)
	if isvalid(message.powerobjectparm) then
		s_attrib=message.powerobjectparm
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".font.Weight="+string(s_attrib.li_stile))
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".alignment="+string(s_attrib.li_paragrafo))
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".font.Height="+string(s_attrib.li_corpo))
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".Height.AutoSize="+s_attrib.ls_autosize)
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".format='"+s_attrib.ls_formato+"'")
		
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".font.face='"+s_attrib.ls_carattere+"'")
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".font.italic="+s_attrib.ls_corsivo)
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".font.Underline="+s_attrib.ls_sottolineato)
		tab_1.tabpage_1.dw_1.modify(ls_oggetto+".font.Strikethrough="+s_attrib.ls_barrato)
		
		if s_attrib.ls_ometti_se_zero="1" then
			tab_1.tabpage_1.dw_1.modify(ls_oggetto+".visible='1 ~t if( "+ls_oggetto+" = 0, 0,1)'")
		else
			if s_attrib.ls_visibile="2" then
				tab_1.tabpage_1.dw_1.modify(ls_oggetto+".visible='1 ~t if( page()=pagecount(), 1,0)'")
			else
				tab_1.tabpage_1.dw_1.modify(ls_oggetto+".visible="+s_attrib.ls_visibile)
			end if
		end if

	end if
end if
end event

event printpage;string ls_h_footer
integer li_num_pagine
if is_h_footer="nofooter" then
	li_num_pagine=tab_1.tabpage_1.dw_1.getitemnumber(1, "tot_pagine")
	
	ls_h_footer=tab_1.tabpage_1.dw_1.describe("datawindow.footer.height")
	if ls_h_footer="5" then
		if pagenumber=li_num_pagine then
			return 1
		end if
	else
		if pagenumber<li_num_pagine then 
			return 1
		end if
	end if
end if

end event

event sqlpreview;call super::sqlpreview;string ls_sintax, ls_applica_sql
long ll_pos

if is_selezione>"" and pos(sqlsyntax, is_selezione)<=0 then
	ls_sintax=sqlsyntax
	//messagebox("W", ls_sintax)
	ll_pos= pos(ls_sintax, "ORDER BY")
	if ll_pos>0 then
		ls_applica_sql=left(ls_sintax, ll_pos - 1) +" and "+is_selezione +" "+ right(ls_sintax, len(ls_sintax) - ll_pos +1)
		
		setsqlpreview(ls_applica_sql)
	else
		
	end if
end if
	
	
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 112
integer width = 3488
integer height = 1724
long backcolor = 79741120
string text = "Valori"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
cb_cancella cb_cancella
cb_inserisci cb_inserisci
cb_salva_dw cb_salva_dw
cb_crea_lib cb_crea_lib
dw_6 dw_6
dw_3 dw_3
sle_salva_in sle_salva_in
end type

on tabpage_2.create
this.dw_2=create dw_2
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.cb_salva_dw=create cb_salva_dw
this.cb_crea_lib=create cb_crea_lib
this.dw_6=create dw_6
this.dw_3=create dw_3
this.sle_salva_in=create sle_salva_in
this.Control[]={this.dw_2,&
this.cb_cancella,&
this.cb_inserisci,&
this.cb_salva_dw,&
this.cb_crea_lib,&
this.dw_6,&
this.dw_3,&
this.sle_salva_in}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.cb_salva_dw)
destroy(this.cb_crea_lib)
destroy(this.dw_6)
destroy(this.dw_3)
destroy(this.sle_salva_in)
end on

type dw_2 from datawindow within tabpage_2
integer x = 9
integer y = 4
integer width = 3470
integer height = 412
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_testa_oggetti"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;long ll_id_conf
if currentrow>0 then
	setrowfocusindicator(hand!)
	ll_id_conf=getitemnumber(currentrow, "id_conf_oggetti")
	if ll_id_conf>0 then
		dw_3.retrieve(ll_id_conf)
		if il_test=1 then 
			il_test=2
		else
			WF_CARICA_DW_DA_LIB()
			
			wf_allinea_preview()
		end if
		
		dw_5.scrolltorow(currentrow)
	end if

end if

end event

event retrieveend;ShareData(dw_5)
end event

type cb_cancella from commandbutton within tabpage_2
integer x = 320
integer y = 416
integer width = 274
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;integer li_test, li_righe
li_righe=dw_3.rowcount()
if li_righe>0 then
	li_test=dw_3.rowsmove(1, li_righe, primary!, dw_3,1,  delete!)
else
	li_test=1
end if
if li_test=1 then
	li_righe=dw_3.update()
	if li_righe=1 then
		li_righe=dw_2.getrow()
		dw_2.deleterow(li_righe)
	end if
end if
	
end event

type cb_inserisci from commandbutton within tabpage_2
integer x = 27
integer y = 416
integer width = 274
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;dw_2.insertrow(0)
end event

type cb_salva_dw from commandbutton within tabpage_2
boolean visible = false
integer x = 626
integer y = 416
integer width = 485
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva DW in LIB"
end type

event clicked;string dwsyntax, ErrorBuffer,ls_commento, ls_nome_dw, ls_salva_in
integer ll_riga_corrente
integer rtncode

ll_riga_corrente=dw_2.getrow()
ls_nome_dw="d_"+dw_2.getitemstring(ll_riga_corrente, "codice")
ls_commento="DW per Prove"


dwsyntax = tab_1.tabpage_1.dw_1.Describe("DataWindow.Syntax")
ls_salva_in=sle_salva_in.text
rtncode = LibraryImport(ls_salva_in, ls_nome_dw, ImportDataWindow!, dwsyntax, ErrorBuffer, ls_commento)

end event

type cb_crea_lib from commandbutton within tabpage_2
boolean visible = false
integer x = 1143
integer y = 416
integer width = 270
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea_lib"
end type

event clicked;integer li_ret
string ls_lib

ls_lib="s:\lavoro\dinamica.pbl"

li_ret=librarycreate(ls_lib, "per stampa dinamica")
if li_ret=1 then
	messagebox("Creata libreria", ls_lib)
else
	messagebox("Non Creata libreria", ls_lib)
end if
end event

type dw_6 from dw_quarta within tabpage_2
boolean visible = false
integer x = 3077
integer y = 4
integer width = 402
integer height = 500
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event mousedown;if flags=1 then
	tab_1.tabpage_2.dw_6.object.datawindow.zoom=ii_zoom - 1 
elseif flags=2 then
	tab_1.tabpage_2.dw_6.object.datawindow.zoom=ii_zoom + 1 
end if
end event

type dw_3 from dw_primo within tabpage_2
integer x = 9
integer y = 532
integer width = 3474
integer height = 1152
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_lista_oggetti"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;ShareData(tab_1.tabpage_1.dw_4)
end event

type sle_salva_in from singlelineedit within tabpage_2
boolean visible = false
integer x = 1440
integer y = 428
integer width = 818
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_out from commandbutton within w_st_pb
integer x = 3415
integer y = 28
integer width = 96
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Out"
end type

event clicked;ii_zoom=ii_zoom - 5
tab_1.tabpage_1.dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type sle_zoom from singlelineedit within w_st_pb
integer x = 3264
integer y = 24
integer width = 146
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;ii_zoom=integer(this.text)
tab_1.tabpage_1.dw_1.object.datawindow.zoom=ii_zoom

end event

type cb_in from commandbutton within w_st_pb
integer x = 3173
integer y = 28
integer width = 96
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "In"
end type

event clicked;ii_zoom=ii_zoom+5
tab_1.tabpage_1.dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type pb_crea_col from uo_pb within w_st_pb
string tag = "Aggiunge una Colonna alla DW"
integer x = 494
integer y = 4
integer width = 128
integer height = 112
integer taborder = 90
boolean bringtotop = true
string text = ""
string picturename = "S:\pb\commonframework\distinta.bmp"
end type

event clicked;
s_dinamica s_dina
string ls_ret,ls_col_nuova, dwsyntax, ls_nome_col_dw, ls_nuovo, ls_tipo, ls_test,ls_select
long ll_ret, ll_trova, ll_esiste, ll_inizio, ll_fine, ll_punto,ll_riga
integer li_ret2, li_id

s_dina.ls_nome=""
s_dina.ls_tipo="crea_column"
s_dina.ls_testo=""
s_dina.cancella='Crea'
ll_riga=tab_1.tabpage_2.dw_2.getrow()
s_dina.id_conf_oggetti=tab_1.tabpage_2.dw_2.getitemnumber(ll_riga, "id_conf_oggetti")
openwithparm(w_crea_text, s_dina)
if isvalid(message.powerobjectparm) then
	s_dina=message.powerobjectparm
	ls_col_nuova=s_dina.ls_nome
	ls_tipo=s_dina.ls_testo
	if ls_col_nuova>"" and ls_tipo>"" then
		
		dwsyntax = tab_1.tabpage_1.dw_1.Describe("DataWindow.Syntax")
		if dwsyntax>"" then
			
			ll_ret=pos(dwsyntax, "retrieve")
			if ll_ret>0 then
				li_ret2=pos(ls_col_nuova, ".")
				if li_ret2>0 then
					
					ls_nome_col_dw=left(ls_col_nuova, li_ret2 - 1)+"_"+right(ls_col_nuova, len(ls_col_nuova) - li_ret2)
					
					
					ll_esiste=pos(dwsyntax, 'dbname="'+ls_col_nuova+'"', 1)
				
					if ll_esiste<=0 then
						
						ls_nuovo='column=(type='+ls_tipo+' updatewhereclause=yes name= '+ ls_nome_col_dw+ ' dbname="'+ls_col_nuova+'")~r~n'
						
						dwsyntax=left(dwsyntax, ll_ret - 1) +ls_nuovo+" "+right(dwsyntax, len(dwsyntax) - (ll_ret - 1))
					end if
					

					
					
					
					ll_esiste=pos(dwsyntax, "PBSELECT")
					if ll_esiste<=0 then
					
					
					
					ll_inizio=pos(dwsyntax, '"SELECT') 
					ll_fine=pos(dwsyntax, 'FROM') 
					ls_select=mid(dwsyntax, ll_inizio, ll_fine - ll_inizio)
					ll_esiste=0
						do 
							ll_trova=pos(ls_select, ",", ll_trova+1)
							li_id++
						loop while  ll_trova>0
						li_id++
						ll_punto=pos(ls_col_nuova, ".")
						ls_nuovo=",  "+left(ls_col_nuova, ll_punto )+'~~"'+right(ls_col_nuova, len(ls_col_nuova) - ll_punto)+'~~"'
										
						dwsyntax=left(dwsyntax, ll_fine - 1) + " "+ls_nuovo+" "+right(dwsyntax, len(dwsyntax) - (ll_fine - 1))
					else	
						
						
						
						
						ll_esiste=0
						do 
							ll_trova=pos(dwsyntax, "COLUMN(NAME=~~", ll_trova+1)
							li_id++
							ls_test=mid(dwsyntax, ll_trova+14, len(ls_Col_nuova))
							if ls_test=ls_col_nuova then
								ll_esiste=1
								exit
							end if						
						loop while  ll_trova>0
					
						
						if ll_esiste=0 then 
							
							ll_ret=pos(dwsyntax, "JOIN")
							
							ls_nuovo='COLUMN(NAME=~~"'+ls_col_nuova+'~~")'
							
							dwsyntax=left(dwsyntax, ll_ret - 1) + " "+ls_nuovo+" "+right(dwsyntax, len(dwsyntax) - (ll_ret - 1))
						end if
					end if
						
						
						ls_nuovo='column(name='+ ls_nome_col_dw+' moveable=1 resizeable=1 band=header id='+string(li_id)+' x="300" y="500" height="300" width="1000" color="33554432" border="0" alignment="0" format="[general]" edit.focusrectangle=no edit.autohscroll=yes edit.autoselect=yes edit.autovscroll=no edit.case=any edit.codetable=no edit.displayonly=no edit.hscrollbar=no edit.imemode=0 edit.limit=16 edit.password=no edit.vscrollbar=no edit.validatecode=no edit.nilisnull=no edit.required=no criteria.required=no criteria.override_edit=no crosstab.repeat=no background.mode="1" background.color="536870912" font.charset="0" font.face="Arial" font.family="2" font.height="-8" font.pitch="2" font.weight="400" tabsequence=0 )'
					
					dwsyntax=dwsyntax+ "~r~n"+ls_nuovo
					ll_ret=tab_1.tabpage_1.dw_1.create(dwsyntax)
					tab_1.tabpage_1.dw_1.settransobject(sqlca)
					tab_1.tabpage_1.dw_1.retrieve(il_id_doc)
					
					
					
				end if	
				
			end if
			
		end if
		
	end if
end if		
end event

type pb_crea_oggetto from uo_pb within w_st_pb
string tag = "Crea Oggetti nella DW"
integer x = 635
integer y = 4
integer width = 128
integer height = 112
integer taborder = 170
boolean bringtotop = true
string text = ""
string picturename = "S:\pb\commonframework\varianti.bmp"
end type

event clicked;string dwsyntax, modstring, ls_ret, ls_name_dw_sottoreport
s_dinamica s_dina
long ll_riga_corrente
s_dina.ls_nome="Desc001"
s_dina.ls_tipo="text"
s_dina.ls_testo="Descrizione"
s_dina.cancella='Crea'
openwithparm(w_crea_text, s_dina)
s_dina=message.powerobjectparm
if isvalid(s_dina) then	
	choose case s_dina.ls_tipo
		case 'text' 	
		modstring = 'create text(name='+s_dina.ls_nome+' moveable=1 resizeable=1 band=header'& 
		+' font.charset="0"'&
		+' font.face="MS Sans Serif" font.family="2" font.height="-8" font.italic="0" font.pitch="2"'& 
		+' font.weight="400" font.underline="0" background.mode="1" background.color="0" color="0"'& 
		+' alignment="2" border="2" x="6085" y="2248" height="502" width="2143" text="'+s_dina.ls_testo+'" )'
	case 'rectangle'
			modstring = 'create rectangle(band=header x="16007" y="873"'&
			+' height="1613" width="1481"  name='+s_dina.ls_nome+' brush.hatch="7"'&
			+' brush.color="553648127" pen.style="0" pen.width="26"'& 
			+' pen.color="0"  background.mode="1" background.color="0" )'
	case 'line'
		modstring='create line(name='+s_dina.ls_nome+' moveable=1 resizeable=1 band=header background.mode="2"'& 
		+' background.color="16777215" pen.style="0" pen.width="26" pen.color="0"'&
		+' x1="211" y1="1000" x2="18176" y2="1000" )'
	case "compute"
		modstring='create compute(name='+s_dina.ls_nome+' moveable=1 resizeable=1 band=header font.charset="0" font.face="Arial" font.family="2"'+& 
		' font.height="-8" font.pitch="2" font.weight="400" background.mode="1" background.color="0"'+&
		' color="0" x="11932" y="3413" height="502" width="3148" '+&
		' format="[general]"' +&
		' expression= " '+s_dina.ls_testo+' " alignment="0" border="2" crosstab.repeat=no )'
	case "report"
		ls_name_dw_sottoreport=s_dina.ls_nome 
		modstring='create report(name='+s_dina.ls_nome+' height.autosize=yes slideup=directlyabove '+&
		'band=footer x="14" y="72" height="360" width="1800" border="3" trail_footer=yes criteria="" '+&
		'dataobject="'+ls_name_dw_sottoreport+'" nest_arguments=('+s_dina.ls_testo+'))'
		
		
		
	case "bitmap"
		modstring = 'create bitmap(band=header x="37" y="12" height="300" width="300" '+&
		'filename="'+s_dina.ls_testo+'" border="0" name='+s_dina.ls_nome+' )'
		
	end choose
	
	ls_ret=tab_1.tabpage_1.dw_1.Modify(modstring)
	if ls_ret<>"" then 
		messagebox("ER", ls_ret)
		return
	end if
	cb_memorizza.triggerevent(clicked!)
	
	
	
	
	
	
	wf_allinea_preview()
	
	
	
	
	
	
	
end if
end event

type pb_blocca from uo_pb within w_st_pb
integer x = 777
integer y = 4
integer width = 128
integer height = 112
integer taborder = 80
boolean bringtotop = true
string text = ""
string picturename = "s:\pb\lucch_pic.bmp"
end type

event clicked;string ls_objects,ls_oldstr, ls_oggetto, ls_codice, ls_val
integer ll_start_pos, ll_pos_ini, ll_riga, i
long ll_x, ll_y, ll_id_conf
if tag="Blocca" then
	tag="Sblocca"
	ls_val="0"
else
	tag="Blocca"
	ls_val="1"
end if
for i= 1 to tab_1.tabpage_2.dw_3.rowcount()
	ls_oggetto=tab_1.tabpage_2.dw_3.getitemstring(i, "oggetto")
	tab_1.tabpage_1.dw_1.modify(ls_oggetto+"tabsequence=0")
	tab_1.tabpage_1.dw_1.modify(ls_oggetto+".moveable="+ls_val)
	tab_1.tabpage_2.dw_3.setitem(i, "spostabile", integer(ls_Val))
	tab_1.tabpage_1.dw_1.modify(ls_oggetto+".resizeable="+ls_val)
	tab_1.tabpage_2.dw_3.setitem(i, "ridimensionabile", integer(ls_val))
next



end event

type pb_stampa_1 from uo_pb within w_st_pb
string tag = "Stampa la DW"
integer x = 919
integer width = 128
integer height = 112
integer taborder = 70
boolean bringtotop = true
string text = ""
string picturename = "s:\pb\printer.bmp"
end type

event clicked;integer li_test, li_num_copie
long ll_job
string ls_h_footer
printsetup()
li_num_copie=integer(sle_copie.text)
if li_num_copie<=0 or isnull(li_num_copie) then li_num_copie=1
tab_1.tabpage_1.dw_1.Modify("DataWindow.Print.copies = "+ string(li_num_copie))
li_test=integer(tab_1.tabpage_2.sle_salva_in.text)
if li_test=1 then 
	
	is_h_footer="nofooter"
	
	ls_h_footer=tab_1.tabpage_1.dw_1.describe("datawindow.footer.height")
	
	tab_1.tabpage_1.dw_1.modify("datawindow.footer.height = 5")
	
	
	
	ll_job=printopen("prova001")
	printdatawindow(ll_job, tab_1.tabpage_1.dw_1)
	
	
	tab_1.tabpage_1.dw_1.modify("datawindow.footer.height = "+ls_h_footer)
	
	printdatawindow(ll_job, tab_1.tabpage_1.dw_1)
	printclose(ll_job)
	tab_1.tabpage_2.sle_salva_in.text=''
elseif li_test=0 then 
	
	is_h_footer="footer"
	ll_job=printopen("DOC000")
	printdatawindow(ll_job, tab_1.tabpage_1.dw_1)
	printclose(ll_job)
end if	

end event

type cb_memorizza from uo_cb within w_st_pb
string tag = "Recupera i valori dal disegno"
integer x = 1216
integer y = 4
integer width = 279
integer taborder = 60
boolean bringtotop = true
string text = "Val. da Dis."
end type

event clicked;wf_da_disegno_a_valori("") 

end event

type cb_dis_da_valori from uo_cb within w_st_pb
string tag = "Reupera i valori e ridisegna la DW"
integer x = 1504
integer y = 4
integer width = 274
integer taborder = 140
boolean bringtotop = true
string text = "Dis. da Val."
end type

event clicked;long ll_riga_corrente
string dwsyntax, ls_dw

ll_riga_corrente=tab_1.tabpage_2.dw_2.getrow()
if ll_riga_corrente>0 then
	ls_dw=tab_1.tabpage_2.dw_2.getitemstring(ll_riga_corrente, "codice")
	if tab_1.tabpage_1.dw_1.dataobject<> ls_dw then
			wf_carica_dw_da_lib()
	end if
	wf_da_valori_a_disegno("", 0)
	wf_allinea_preview()
end if
end event

type pb_salva from uo_pb within w_st_pb
string tag = "Salva le modifche"
integer x = 1792
integer y = 4
integer width = 183
integer height = 108
integer taborder = 20
boolean bringtotop = true
string text = "Salva"
alignment htextalign = center!
vtextalign vtextalign = vcenter!
end type

event clicked;integer li_ret
li_ret=tab_1.tabpage_2.dw_2.update()
if li_ret=1 then
	li_ret=tab_1.tabpage_2.dw_3.update()
	if li_ret=1 then
		commit;
	else
		rollback;
	end if
end if

tab_1.tabpage_2.dw_3.setfocus()
end event

type cb_crea_sottoreport from commandbutton within w_st_pb
boolean visible = false
integer x = 3182
integer y = 8
integer width = 78
integer height = 108
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sottoreport"
end type

event clicked;open(w_dw_from_select)
end event

type dw_5 from dw_primo within w_st_pb
integer x = 2427
integer y = 4
integer width = 727
integer height = 112
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_testa_oggetti_shared"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_copie from singlelineedit within w_st_pb
integer x = 1989
integer y = 16
integer width = 192
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type pb_ordina from uo_pb within w_st_pb
string tag = "Ordina la stampa"
integer x = 1065
integer y = 4
integer width = 128
integer height = 112
integer taborder = 30
boolean bringtotop = true
string text = ""
string picturename = "s:\pb\commonframework\sort.bmp"
vtextalign vtextalign = vcenter!
end type

type pb_stampa_no_footer from uo_pb within w_st_pb
integer x = 2194
integer y = 8
integer width = 119
integer height = 104
integer taborder = 160
boolean bringtotop = true
string text = ""
string picturename = "S:\pb\commonframework\PRINTER.bmp"
end type

event clicked;tab_1.tabpage_2.sle_salva_in.text='1'
pb_stampa_1.triggerevent(clicked!)
end event

type cb_1 from commandbutton within w_st_pb
integer x = 2331
integer y = 8
integer width = 82
integer height = 104
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "P"
end type

event clicked;tab_1.tabpage_1.dw_1.object.datawindow.print.preview="yes"
tab_1.tabpage_1.dw_1.object.datawindow.print.preview.rulers="yes"
end event

