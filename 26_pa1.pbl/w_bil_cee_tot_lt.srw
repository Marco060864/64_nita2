forward
global type w_bil_cee_tot_lt from Window
end type
type cb_2 from commandbutton within w_bil_cee_tot_lt
end type
type st_1 from statictext within w_bil_cee_tot_lt
end type
type voce from dropdownlistbox within w_bil_cee_tot_lt
end type
type cb_1 from commandbutton within w_bil_cee_tot_lt
end type
type dw_4 from datawindow within w_bil_cee_tot_lt
end type
type dw_3 from datawindow within w_bil_cee_tot_lt
end type
type dw_2 from datawindow within w_bil_cee_tot_lt
end type
type dw_1 from datawindow within w_bil_cee_tot_lt
end type
end forward

shared variables

end variables

global type w_bil_cee_tot_lt from Window
int X=5
int Y=48
int Width=3703
int Height=2332
boolean TitleBar=true
string Title="Liquidazione IVA"
long BackColor=80263328
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
cb_2 cb_2
st_1 st_1
voce voce
cb_1 cb_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_bil_cee_tot_lt w_bil_cee_tot_lt

type variables
long il_zoom

s_param1 ls_param
long il_id_dich_per

end variables

event open;


integer li_anno
li_anno=message.doubleparm


dw_1.settransobject(sqlca)
dw_1.retrieve(li_anno)

dw_2.settransobject(sqlca)
dw_2.retrieve(li_anno)

dw_3.settransobject(sqlca)
dw_3.retrieve(li_anno)

dw_4.settransobject(sqlca)
dw_4.retrieve(li_anno)

il_zoom=100



decimal {4} ll_tot2, ll_tot1,a

ll_tot1=dw_1.getitemnumber(dw_1.rowcount(), 'tot_att1') - dw_2.getitemnumber(dw_2.rowcount(), 'tot_pas1')
ll_tot2=dw_1.getitemnumber(dw_1.rowcount(), 'tot_att2') - dw_2.getitemnumber(dw_2.rowcount(), 'tot_pas2')

a=dw_1.getitemnumber(dw_1.rowcount(), 'tot_att1')
a=dw_2.getitemnumber(dw_2.rowcount(), 'tot_pas1')
a=dw_1.getitemnumber(dw_1.rowcount(), 'tot_att2')
a=dw_2.getitemnumber(dw_2.rowcount(), 'tot_pas2')

long ll_row
ll_row = dw_2.Find("riferimento=189",1, dw_2.RowCount())
dw_2.setitem(ll_row, 'tot1',ll_tot1)
dw_2.setitem(ll_row, 'tot2',ll_tot2)
end event

on w_bil_cee_tot_lt.create
this.cb_2=create cb_2
this.st_1=create st_1
this.voce=create voce
this.cb_1=create cb_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.st_1,&
this.voce,&
this.cb_1,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1}
end on

on w_bil_cee_tot_lt.destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.voce)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_bil_cee_tot_lt
int X=3296
int Y=44
int Width=247
int Height=92
int TabOrder=70
string Text="Salva"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.update()
dw_2.update()
dw_3.update()
dw_4.update()
end event

type st_1 from statictext within w_bil_cee_tot_lt
int X=325
int Y=48
int Width=553
int Height=76
boolean Enabled=false
string Text="Voce bilancio cee:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type voce from dropdownlistbox within w_bil_cee_tot_lt
int X=901
int Y=40
int Width=791
int Height=460
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"1- Stato Patrimoniale - Attivo",&
"2 - Stato Patrimoniale - Passivo",&
"3 - Conto d'Ordine",&
"4 - Conto Economico"}
end type

event selectionchanged;dw_1.Visible = false
dw_2.Visible = false
dw_3.Visible = false
dw_4.Visible = false

CHOOSE CASE index
	CASE 1
		dw_1.Visible = TRUE
		
   CASE 2
		dw_2.Visible = TRUE		
	
	CASE 3
		dw_3.Visible = TRUE	
	CASE 4
		dw_4.Visible = TRUE
END CHOOSE

end event

type cb_1 from commandbutton within w_bil_cee_tot_lt
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=50
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_4 from datawindow within w_bil_cee_tot_lt
int X=41
int Y=192
int Width=3502
int Height=2000
int TabOrder=40
boolean Visible=false
string DataObject="d_bil_cee_econ_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event updateend;decimal {4} ld_utile1, ld_utile2, ld_ris_es1 , ld_ris_es2, ld_pr_imp1, ld_pr_imp2
long ll_row, ll_test
string ls_test

ll_row=dw_4.rowcount()

ld_utile1=dw_4.getitemnumber(ll_row,'utile1')
ld_utile2=dw_4.getitemnumber(ll_row,'utile2')
ld_ris_es1=dw_4.getitemnumber(ll_row,'ris_eser1')
ld_ris_es2=dw_4.getitemnumber(ll_row,'ris_eser2')
ld_pr_imp1=dw_4.getitemnumber(ll_row,'ris_prima_imp1')
ld_pr_imp2=dw_4.getitemnumber(ll_row,'ris_prima_imp2')


update bilancio_cee set saldo1=:ld_pr_imp1, saldo2=:ld_pr_imp2 where riferimento=201;
ll_test=sqlca.sqlcode
ls_test=sqlca.sqlerrtext

update bilancio_cee set saldo1=:ld_ris_es1, saldo2=:ld_ris_es2 where riferimento=89;
ll_test=sqlca.sqlcode
ls_test=sqlca.sqlerrtext

update bilancio_cee set saldo1=:ld_utile1, saldo2=:ld_utile2 where riferimento=92;
ll_test=sqlca.sqlcode
ls_test=sqlca.sqlerrtext

commit;
end event

type dw_3 from datawindow within w_bil_cee_tot_lt
int X=41
int Y=192
int Width=3502
int Height=2000
int TabOrder=30
boolean Visible=false
string DataObject="d_bil_cee_ord_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_bil_cee_tot_lt
int X=41
int Y=192
int Width=3502
int Height=2000
int TabOrder=20
boolean Visible=false
string DataObject="d_bil_cee_pass_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_bil_cee_tot_lt
int X=32
int Y=192
int Width=3502
int Height=2000
int TabOrder=10
string DataObject="d_bil_cee_att_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

