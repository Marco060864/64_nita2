forward
global type w_tipo_pagamento_liquidazioni_lt from Window
end type
type dw_1 from datawindow within w_tipo_pagamento_liquidazioni_lt
end type
end forward

global type w_tipo_pagamento_liquidazioni_lt from Window
int X=833
int Y=361
int Width=1706
int Height=1181
boolean TitleBar=true
string Title="Tipo_pagamento"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
dw_1 dw_1
end type
global w_tipo_pagamento_liquidazioni_lt w_tipo_pagamento_liquidazioni_lt

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

event closequery;integer li_righe
li_righe=dw_1.modifiedcount()
if li_righe>0 then
	dw_1.update()
	if sqlca.sqlnrows>0 then
	else
		return 1
	end if
end if
	
end event

on w_tipo_pagamento_liquidazioni_lt.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_tipo_pagamento_liquidazioni_lt.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_tipo_pagamento_liquidazioni_lt
int X=23
int Y=21
int Width=1637
int Height=1041
int TabOrder=1
string DataObject="d_tipo_pagamento_liquidazioni_lt"
boolean VScrollBar=true
boolean LiveScroll=true
end type

