forward
global type w_testi_cx from Window
end type
type cb_ok from commandbutton within w_testi_cx
end type
type cb_annulla from commandbutton within w_testi_cx
end type
type cb_salva from commandbutton within w_testi_cx
end type
type tab_1 from tab within w_testi_cx
end type
type tabpage_1 from userobject within tab_1
end type
type cb_4 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type dw_tot_template from datawindow within tabpage_1
end type
type dw_template from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type dw_testo from datawindow within tabpage_2
end type
type dw_tot_testi from datawindow within tabpage_2
end type
type tabpage_1 from userobject within tab_1
cb_4 cb_4
cb_3 cb_3
dw_tot_template dw_tot_template
dw_template dw_template
end type
type tabpage_2 from userobject within tab_1
cb_2 cb_2
cb_1 cb_1
dw_testo dw_testo
dw_tot_testi dw_tot_testi
end type
type tab_1 from tab within w_testi_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_testi_cx from Window
int X=832
int Y=380
int Width=2766
int Height=1836
boolean TitleBar=true
string Title="Formati Catalogo"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_ok cb_ok
cb_annulla cb_annulla
cb_salva cb_salva
tab_1 tab_1
end type
global w_testi_cx w_testi_cx

forward prototypes
public subroutine wf_sel_riga (datawindow ad_datawindow, long al_riga)
end prototypes

public subroutine wf_sel_riga (datawindow ad_datawindow, long al_riga);long i

for i = 1 to ad_datawindow.RowCount()
	if ad_datawindow.IsSelected(i) then ad_datawindow.SelectRow(i,false)
next
ad_datawindow.SetRow(al_riga)
ad_datawindow.SelectRow(al_riga,true)
end subroutine

on w_testi_cx.create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_salva=create cb_salva
this.tab_1=create tab_1
this.Control[]={this.cb_ok,&
this.cb_annulla,&
this.cb_salva,&
this.tab_1}
end on

on w_testi_cx.destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_salva)
destroy(this.tab_1)
end on

event open;tab_1.tabpage_1.dw_tot_template.SetTransObject(sqlca)
tab_1.tabpage_1.dw_template.SetTransObject(sqlca)
tab_1.tabpage_2.dw_tot_testi.SetTransObject(sqlca)
tab_1.tabpage_2.dw_testo.SetTransObject(sqlca)
tab_1.tabpage_1.dw_tot_template.Retrieve()
tab_1.Selectedtab=1
end event

type cb_ok from commandbutton within w_testi_cx
int X=91
int Y=28
int Width=306
int Height=92
int TabOrder=20
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret

li_ret=tab_1.tabpage_1.dw_template.AcceptText()
if li_ret>0 then tab_1.tabpage_1.dw_template.Update(true,true)
li_ret=tab_1.tabpage_2.dw_testo.AcceptText()
if li_ret>0 then tab_1.tabpage_2.dw_testo.Update(true,true)		
close(parent)
end event

type cb_annulla from commandbutton within w_testi_cx
int X=462
int Y=28
int Width=325
int Height=92
int TabOrder=10
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)

end event

type cb_salva from commandbutton within w_testi_cx
int X=1897
int Y=28
int Width=325
int Height=92
int TabOrder=30
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret

choose case tab_1.SelectedTab
	case 1
		li_ret=tab_1.tabpage_1.dw_template.AcceptText()
		if li_ret>0 then 
			if tab_1.tabpage_1.dw_template.Update()>0 then
				commit;
			else
				messagebox("Errore", "Catalogo non salvato!")
				rollback;
			end if
			tab_1.tabpage_1.dw_tot_template.Retrieve()
		end if
	case 2
		long ll_id_template
		li_ret=tab_1.tabpage_2.dw_testo.AcceptText()
		if li_ret>0 then 
			if tab_1.tabpage_2.dw_testo.Update()	>0 then
				commit;
			else
				messagebox("Errore", "Catalogo non salvato!")
				rollback;
			end if
			ll_id_template=tab_1.tabpage_1.dw_template.getItemNumber(1,"id_template")
			tab_1.tabpage_2.dw_tot_testi.Retrieve(ll_id_template)
		end if
end choose
end event

type tab_1 from tab within w_testi_cx
event create ( )
event destroy ( )
int X=55
int Y=148
int Width=2665
int Height=1564
int TabOrder=40
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

event selectionchanged;long ll_riga, ll_id_lingua, ll_id_template
dwobject dw_o

choose case newindex
	case 2
		choose case oldindex
			case 1
				if tab_1.tabpage_1.dw_template.RowCount()>0 then
					ll_id_template=tab_1.tabpage_1.dw_template.getItemNumber(1,"id_template")
					tab_1.tabpage_2.dw_tot_testi.Reset()
					tab_1.tabpage_2.dw_testo.reset()
					tab_1.tabpage_2.dw_tot_testi.Retrieve(ll_id_template)
					ll_riga=tab_1.tabpage_2.dw_tot_testi.RowCount()
					if ll_riga>0 then
						tab_1.tabpage_2.dw_tot_testi.SetRow(1)
						tab_1.tabpage_2.dw_tot_testi.event trigger clicked(0,0,1,dw_o)
					end if
				end if
		end choose
end choose
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2629
int Height=1444
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_4 cb_4
cb_3 cb_3
dw_tot_template dw_tot_template
dw_template dw_template
end type

on tabpage_1.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_tot_template=create dw_tot_template
this.dw_template=create dw_template
this.Control[]={this.cb_4,&
this.cb_3,&
this.dw_tot_template,&
this.dw_template}
end on

on tabpage_1.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_tot_template)
destroy(this.dw_template)
end on

type cb_4 from commandbutton within tabpage_1
int X=2235
int Y=204
int Width=325
int Height=92
int TabOrder=6
string Text="Elimina"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga

ll_riga=tab_1.tabpage_1.dw_tot_template.Getrow()
tab_1.tabpage_1.dw_tot_template.Deleterow(ll_riga)
tab_1.tabpage_1.dw_template.Deleterow(1)
end event

type cb_3 from commandbutton within tabpage_1
int X=2235
int Y=48
int Width=325
int Height=92
int TabOrder=5
string Text="Nuovo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga
ll_riga=tab_1.tabpage_1.dw_template.Insertrow(0)
tab_1.tabpage_1.dw_template.SetRow(ll_riga)
tab_1.tabpage_1.dw_template.ScrollToRow(ll_riga)

dw_template.setitem(ll_riga,"margine_sx",100)
dw_template.setitem(ll_riga,"margine_dx",100)
dw_template.setitem(ll_riga,"margine_top",150)
dw_template.setitem(ll_riga,"margine_bottom",200)
dw_template.setitem(ll_riga,"distanza",20)
end event

type dw_tot_template from datawindow within tabpage_1
int X=9
int Y=12
int Width=2098
int Height=460
int TabOrder=4
string DataObject="d_s_tot_template_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrieveend;long ll_id_template

if rowcount>0 then
	wf_sel_riga(this,1)
	ll_id_template=this.GetItemNumber(1,"id_template")
	tab_1.tabpage_1.dw_template.Retrieve(ll_id_template)
end if
end event

event clicked;long ll_id_template

if row>0 then
	wf_sel_riga(this,row)
	ll_id_template=this.GetItemNumber(row,"id_template")
	tab_1.tabpage_1.dw_template.Retrieve(ll_id_template)
end if
end event

event rowfocuschanged;setROWFOCUSINDICATOR(HAND!)
end event

type dw_template from datawindow within tabpage_1
int Y=484
int Width=2615
int Height=948
int TabOrder=2
string DataObject="d_s_template_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2629
int Height=1444
long BackColor=79741120
string Text="Testi"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_2 cb_2
cb_1 cb_1
dw_testo dw_testo
dw_tot_testi dw_tot_testi
end type

on tabpage_2.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_testo=create dw_testo
this.dw_tot_testi=create dw_tot_testi
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_testo,&
this.dw_tot_testi}
end on

on tabpage_2.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_testo)
destroy(this.dw_tot_testi)
end on

type cb_2 from commandbutton within tabpage_2
int X=2235
int Y=204
int Width=325
int Height=92
int TabOrder=4
string Text="Elimina"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga

ll_riga=tab_1.tabpage_2.dw_tot_testi.Getrow()
tab_1.tabpage_2.dw_tot_testi.Deleterow(ll_riga)
tab_1.tabpage_2.dw_testo.Deleterow(1)
end event

type cb_1 from commandbutton within tabpage_2
int X=2226
int Y=48
int Width=325
int Height=92
int TabOrder=2
string Text="Nuovo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga, ll_id_template, ll_max, ll_controllo

ll_id_template=tab_1.tabpage_1.dw_template.GetItemNumber(1,"id_template")
ll_riga=tab_1.tabpage_2.dw_testo.Insertrow(0)
tab_1.tabpage_2.dw_testo.SetRow(ll_riga)
tab_1.tabpage_2.dw_testo.ScrollToRow(ll_riga)
tab_1.tabpage_2.dw_testo.SetItem(ll_riga,"id_template",ll_id_template)

dw_testo.setitem(ll_riga,"id_lingua",1)
dw_testo.setitem(ll_riga,"s_testo_font",'Arial')
dw_testo.setitem(ll_riga,"s_testo_altezza",35)

long verifica
verifica=dw_tot_testi.getrow()
if  verifica <> 0 then
	long ll_found,ll_found_2,ll_rig_max,tot_riga
	ll_rig_max=dw_tot_testi.getitemnumber(1,'max')	
	tot_riga = dw_tot_testi.rowcount()
	ll_found=dw_tot_testi.find("riga = "+ string(ll_rig_max), 1, tot_riga)
	if ll_found < tot_riga then
		ll_found_2=dw_tot_testi.find("riga = "+ string(ll_rig_max), ll_found +1, tot_riga)
		if ll_found_2 = -1 then 
			dw_testo.setitem(ll_riga,"riga",ll_rig_max)
			else
				dw_testo.setitem(ll_riga,"riga",ll_rig_max + 1)	
		end if
	else 	
		dw_testo.setitem(ll_riga,"riga",ll_rig_max)
	end if
end if
end event

type dw_testo from datawindow within tabpage_2
int X=18
int Y=560
int Width=2587
int Height=856
int TabOrder=3
string DataObject="d_s_testo_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event doubleclicked;s_testo ls_testo_parm

choose case dwo.name
	case "red", "green", "blue"
		ls_testo_parm.red=this.GetItemNumber(row,"red")
		ls_testo_parm.green=this.GetItemNumber(row,"green")
		ls_testo_parm.blue=this.GetItemNumber(row,"blue")
		OpenWithParm(w_colori_cx, ls_testo_parm)
		ls_testo_parm=message.PowerObjectParm
		if Not(IsNull(ls_testo_parm.red)) then this.SetItem(row,"red",ls_testo_parm.red)
		if Not(IsNull(ls_testo_parm.green)) then this.SetItem(row,"green",ls_testo_parm.green)
		if Not(IsNull(ls_testo_parm.blue)) then this.SetItem(row,"blue",ls_testo_parm.blue)
end choose

end event

type dw_tot_testi from datawindow within tabpage_2
int X=27
int Y=28
int Width=2098
int Height=508
int TabOrder=3
string DataObject="d_s_tot_testi_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;long ll_id_lingua, ll_id_template
string ls_note

if row>0 then
	wf_sel_riga(this,row)
	ll_id_lingua=GetItemNumber(row,"id_lingua")
	ll_id_template=GetItemNumber(row,"id_template")
	ls_note=GetItemString(row,"note")
	tab_1.tabpage_2.dw_testo.Retrieve(ll_id_template,ll_id_lingua,ls_note)
end if
end event

event rowfocuschanged;setROWFOCUSINDICATOR(HAND!)
end event

