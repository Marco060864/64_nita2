forward
global type w_riordina_prima_nota from Window
end type
type cb_2 from commandbutton within w_riordina_prima_nota
end type
type cb_1 from commandbutton within w_riordina_prima_nota
end type
type dw_testa from datawindow within w_riordina_prima_nota
end type
type dw_corpo from datawindow within w_riordina_prima_nota
end type
end forward

global type w_riordina_prima_nota from Window
int X=1056
int Y=484
int Width=2478
int Height=1380
boolean TitleBar=true
string Title="Riordina prima nota"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
cb_1 cb_1
dw_testa dw_testa
dw_corpo dw_corpo
end type
global w_riordina_prima_nota w_riordina_prima_nota

type variables
long ll_num_prog
end variables

on w_riordina_prima_nota.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_testa=create dw_testa
this.dw_corpo=create dw_corpo
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_testa,&
this.dw_corpo}
end on

on w_riordina_prima_nota.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_testa)
destroy(this.dw_corpo)
end on

event open;string ls_filtro
dw_testa.settransobject(sqlca)
dw_corpo.settransobject(sqlca)
dw_testa.insertrow(0)


datawindowchild ldw_esercizio 
dw_testa.getchild("esercizio",ldw_esercizio)
ldw_esercizio.settransobject(sqlca)
ldw_esercizio.retrieve()


end event

type cb_2 from commandbutton within w_riordina_prima_nota
int X=78
int Y=64
int Width=293
int Height=108
int TabOrder=30
string Text="Riordina"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_esercizio, ll_max, ll_riga, ll_righe, ll_salva



ll_max=ll_num_prog

messagebox("Attenzione!!!", "L'ultimo progressivo usato e stampato su bollato è il: "+string(ll_max))

integer Net

Net = MessageBox("Attenzione!!!", "Vuoi riordinare i progressivi della Prima Nota?", Exclamation!, OKCancel!, 2)
IF Net = 1 THEN
	
long fine, indice, valore

fine=dw_corpo.rowcount()


select max(num_progressivo)
into :ll_salva
from reg_pd;

ll_salva=ll_salva+100

FOR indice=1 TO fine
	dw_corpo.SetItem(indice, "num_progressivo", ll_salva+indice)
NEXT

dw_corpo.update()



FOR indice=1 TO fine
	
	dw_corpo.SetItem(indice, "num_progressivo", ll_max+indice)
NEXT

dw_corpo.update()




END IF


end event

type cb_1 from commandbutton within w_riordina_prima_nota
int X=521
int Y=64
int Width=302
int Height=108
int TabOrder=20
string Text="Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)

end event

type dw_testa from datawindow within w_riordina_prima_nota
int X=1010
int Y=64
int Width=1253
int Height=224
int TabOrder=10
string DataObject="d_testa_prima_nota"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event rowfocuschanged;
end event

event itemchanged;long ll_id_esercizio, ll_riga
ll_riga=dw_testa.getrow()

ll_id_esercizio=dw_testa.getitemnumber(ll_riga,"id_esercizio")
dw_corpo.reset()
ll_riga=dw_corpo.retrieve(ll_id_esercizio)
if ll_riga>0 then
  dw_corpo.SetSort("num_progressivo")
  dw_corpo.Sort()
  ll_num_prog=dw_corpo.getitemnumber(1,"num_progressivo")
else
  ll_num_prog=0
end if  
dw_corpo.SetSort("data_registrazione ,  num_progressivo")
dw_corpo.Sort()

end event

type dw_corpo from datawindow within w_riordina_prima_nota
int X=64
int Y=384
int Width=2299
int Height=744
int TabOrder=40
string DataObject="d_riordina_prima_nota"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

