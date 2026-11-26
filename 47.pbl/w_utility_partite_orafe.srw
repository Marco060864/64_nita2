forward
global type w_utility_partite_orafe from Window
end type
type dw_2 from datawindow within w_utility_partite_orafe
end type
type dw_1 from datawindow within w_utility_partite_orafe
end type
end forward

global type w_utility_partite_orafe from Window
int X=845
int Y=371
int Width=2055
int Height=1229
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_2 dw_2
dw_1 dw_1
end type
global w_utility_partite_orafe w_utility_partite_orafe

on w_utility_partite_orafe.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.dw_1}
end on

on w_utility_partite_orafe.destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_2 from datawindow within w_utility_partite_orafe
int X=179
int Y=614
int Width=1741
int Height=368
int TabOrder=20
string DataObject="d_orafo_aper_partita_gd"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_utility_partite_orafe
int X=157
int Y=96
int Width=1792
int Height=368
int TabOrder=10
string DataObject="d_righe_che_aprono_partite"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

