forward
global type w_riassumi_stampa_cx from Window
end type
type cb_1 from commandbutton within w_riassumi_stampa_cx
end type
type tab_1 from tab within w_riassumi_stampa_cx
end type
type tabpage_1 from userobject within tab_1
end type
type dw_pagina from datawindow within tabpage_1
end type
type dw_catalogo from datawindow within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type dw_template from datawindow within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_testi from datawindow within tabpage_4
end type
type tabpage_1 from userobject within tab_1
dw_pagina dw_pagina
dw_catalogo dw_catalogo
end type
type tabpage_3 from userobject within tab_1
dw_template dw_template
end type
type tabpage_4 from userobject within tab_1
dw_testi dw_testi
end type
type tab_1 from tab within w_riassumi_stampa_cx
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
end forward

global type w_riassumi_stampa_cx from Window
int X=836
int Y=372
int Width=2365
int Height=1815
boolean TitleBar=true
string Title="Riepilogo Stampa"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
tab_1 tab_1
end type
global w_riassumi_stampa_cx w_riassumi_stampa_cx

type variables
s_prev_parm is_parm
end variables

on w_riassumi_stampa_cx.create
this.cb_1=create cb_1
this.tab_1=create tab_1
this.Control[]={ this.cb_1,&
this.tab_1}
end on

on w_riassumi_stampa_cx.destroy
destroy(this.cb_1)
destroy(this.tab_1)
end on

event open;is_parm=Message.PowerObjectParm
long ll_id_template

tab_1.tabpage_1.dw_catalogo.SetTransObject(sqlca)
tab_1.tabpage_1.dw_pagina.SetTransObject(sqlca)
tab_1.tabpage_3.dw_template.SetTransObject(sqlca)
tab_1.tabpage_4.dw_testi.SetTransObject(sqlca)
tab_1.tabpage_1.dw_catalogo.Retrieve(is_parm.id_catalogo)
tab_1.tabpage_1.dw_pagina.Retrieve(is_parm.id_pagina)
tab_1.tabpage_3.dw_template.Retrieve(is_parm.id_catalogo, is_parm.id_pagina)
ll_id_template=tab_1.tabpage_3.dw_template.GetItemNumber(1,"id_template")
tab_1.tabpage_4.dw_testi.Retrieve(ll_id_template, is_parm.id_lingua)
end event

type cb_1 from commandbutton within w_riassumi_stampa_cx
int X=705
int Y=1607
int Width=786
int Height=84
int TabOrder=10
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_riassumi_stampa_cx
int X=43
int Y=42
int Width=2244
int Height=1546
int TabOrder=20
boolean RaggedRight=true
Alignment Alignment=Right!
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={ this.tabpage_1,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
int X=15
int Y=90
int Width=2216
int Height=1444
long BackColor=79741120
string Text="Catalogo"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_pagina dw_pagina
dw_catalogo dw_catalogo
end type

on tabpage_1.create
this.dw_pagina=create dw_pagina
this.dw_catalogo=create dw_catalogo
this.Control[]={ this.dw_pagina,&
this.dw_catalogo}
end on

on tabpage_1.destroy
destroy(this.dw_pagina)
destroy(this.dw_catalogo)
end on

type dw_pagina from datawindow within tabpage_1
int X=93
int Y=941
int Width=2052
int Height=442
int TabOrder=4
string DataObject="d_riass_pagina_ff"
boolean Border=false
boolean LiveScroll=true
end type

type dw_catalogo from datawindow within tabpage_1
int X=93
int Y=26
int Width=2052
int Height=938
int TabOrder=2
string DataObject="d_riass_catalogo_ff"
boolean Border=false
boolean LiveScroll=true
end type

type tabpage_3 from userobject within tab_1
int X=15
int Y=90
int Width=2216
int Height=1444
long BackColor=79741120
string Text="Formato"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_template dw_template
end type

on tabpage_3.create
this.dw_template=create dw_template
this.Control[]={ this.dw_template}
end on

on tabpage_3.destroy
destroy(this.dw_template)
end on

type dw_template from datawindow within tabpage_3
int X=136
int Y=45
int Width=1935
int Height=1012
int TabOrder=3
string DataObject="d_riass_template_ff"
boolean Border=false
boolean LiveScroll=true
end type

type tabpage_4 from userobject within tab_1
int X=15
int Y=90
int Width=2216
int Height=1444
long BackColor=79741120
string Text="Testi"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_testi dw_testi
end type

on tabpage_4.create
this.dw_testi=create dw_testi
this.Control[]={ this.dw_testi}
end on

on tabpage_4.destroy
destroy(this.dw_testi)
end on

type dw_testi from datawindow within tabpage_4
int X=22
int Y=23
int Width=2159
int Height=1060
int TabOrder=4
string DataObject="d_riass_testi_ff"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

