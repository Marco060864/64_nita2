forward
global type w_orafo_lista_dis_cliente_gd from Window
end type
type cb_salva from commandbutton within w_orafo_lista_dis_cliente_gd
end type
type cb_1 from commandbutton within w_orafo_lista_dis_cliente_gd
end type
type cb_modifica from commandbutton within w_orafo_lista_dis_cliente_gd
end type
type cb_annulla from commandbutton within w_orafo_lista_dis_cliente_gd
end type
type cb_inserisci from commandbutton within w_orafo_lista_dis_cliente_gd
end type
type cb_ok from commandbutton within w_orafo_lista_dis_cliente_gd
end type
type dw_lista_dis_cliente from datawindow within w_orafo_lista_dis_cliente_gd
end type
end forward

global type w_orafo_lista_dis_cliente_gd from Window
int X=1056
int Y=484
int Width=2798
int Height=1268
boolean TitleBar=true
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_salva cb_salva
cb_1 cb_1
cb_modifica cb_modifica
cb_annulla cb_annulla
cb_inserisci cb_inserisci
cb_ok cb_ok
dw_lista_dis_cliente dw_lista_dis_cliente
end type
global w_orafo_lista_dis_cliente_gd w_orafo_lista_dis_cliente_gd

type variables
long ll_id_documento
long ll_id_sorgente
end variables

on w_orafo_lista_dis_cliente_gd.create
this.cb_salva=create cb_salva
this.cb_1=create cb_1
this.cb_modifica=create cb_modifica
this.cb_annulla=create cb_annulla
this.cb_inserisci=create cb_inserisci
this.cb_ok=create cb_ok
this.dw_lista_dis_cliente=create dw_lista_dis_cliente
this.Control[]={this.cb_salva,&
this.cb_1,&
this.cb_modifica,&
this.cb_annulla,&
this.cb_inserisci,&
this.cb_ok,&
this.dw_lista_dis_cliente}
end on

on w_orafo_lista_dis_cliente_gd.destroy
destroy(this.cb_salva)
destroy(this.cb_1)
destroy(this.cb_modifica)
destroy(this.cb_annulla)
destroy(this.cb_inserisci)
destroy(this.cb_ok)
destroy(this.dw_lista_dis_cliente)
end on

event open;
s_new_ordini new_ordini
long ll_righe_trovate,ll_ret, ll_conto, ll_riga_doc, ll_cliente
string ls_rag_soc, ls_cod_cliente
w_nuovo_dis_cliente_cx w_dis_cliente
dw_lista_dis_cliente.settransobject(sqlca)
new_ordini=message.powerobjectparm

ll_cliente=new_ordini.s_ll_id_cliente
select codice, rag_soc_1
into :ls_cod_cliente, :ls_rag_soc
from sog_commerciale_gen
where id_sog_commerciale=:ll_cliente;
Title = "Lista variazioni righe distinta:    " +ls_cod_cliente + "   " + ls_rag_soc




ll_righe_trovate=dw_lista_dis_cliente.retrieve(new_ordini.s_ll_id_cliente, new_ordini.s_ll_id_art_originale)
if ll_righe_trovate>0 then	
	 ll_id_documento=new_ordini.s_ll_id_documento
	
	 if isnull(ll_id_documento) or ll_id_documento=0 then cb_modifica.enabled=false
else
	 
	 
	 
	 openwithparm(w_nuovo_dis_cliente_cx, new_ordini)
    ll_ret=message.doubleparm
    CloseWithReturn(this, ll_ret)
end if
end event

type cb_salva from commandbutton within w_orafo_lista_dis_cliente_gd
int X=1467
int Y=24
int Width=247
int Height=108
int TabOrder=60
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_lista_dis_cliente.update()=1 then
	commit;
else
	rollback;
	messagebox("Errore!", "Savataggio non riuscito!")
end if
	
end event

type cb_1 from commandbutton within w_orafo_lista_dis_cliente_gd
int X=1806
int Y=24
int Width=247
int Height=108
int TabOrder=50
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_row
li_row=dw_lista_dis_cliente.getrow()
if li_row>0 then
	dw_lista_dis_cliente.deleterow(li_row)
end if
end event

type cb_modifica from commandbutton within w_orafo_lista_dis_cliente_gd
int X=2473
int Y=24
int Width=247
int Height=108
int TabOrder=40
string Text="Modifica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_ret, ll_doc, ll_row, ll_sorg

	  ll_row=dw_lista_dis_cliente.getrow()
	  ll_sorg=dw_lista_dis_cliente.getitemnumber(ll_row,"id_riga_doc")
	  
	  
	  
	  
	  
     ll_ret = MessageBox("Attenzione","Vuoi modificare la variante selezionata?", Question!, YesNo!, 2)
     if ll_ret= 1 then 
		
		
	       select id_documento
	       into :ll_doc
          from riga_documento
	       where id_documento <>:ll_id_documento
			 and id_riga_sorgente=:ll_sorg;
			 
	  
	       if (ll_doc<>0) and not isnull(ll_doc) then
		        ll_ret=MessageBox("Attenzione",'Questa variante è gia stata utilizzata in altri documenti,'+& 
				  '~r~nse modifichi adesso questa riga i cambiamenti si ripercuoteranno anche negli ordini precedenti!', Question!, YesNo!, 2)
			     if ll_ret= 2 then return 1
		    end if
			 
          s_new_ordini new_ordini
          w_dis_cliente_cx w_dis_cliente
          new_ordini=message.powerobjectparm

          ll_doc=dw_lista_dis_cliente.getitemnumber(ll_row,"id_riga_doc")
          new_ordini.s_ll_id_sorgente=ll_doc
          openwithparm(w_dis_cliente_cx, new_ordini)
          ll_ret=message.doubleparm
          CloseWithReturn(parent, ll_ret)	 
	 
     else		 
         return 1
     end if
	  
end event

type cb_annulla from commandbutton within w_orafo_lista_dis_cliente_gd
int X=393
int Y=24
int Width=247
int Height=108
int TabOrder=30
string Text="Annullla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(parent, 0) 
end event

type cb_inserisci from commandbutton within w_orafo_lista_dis_cliente_gd
int X=2126
int Y=24
int Width=247
int Height=108
int TabOrder=20
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_ret

s_new_ordini new_ordini
w_dis_cliente_cx w_dis_cliente
new_ordini=message.powerobjectparm

new_ordini.s_ll_id_sorgente=0
openwithparm(w_nuovo_dis_cliente_cx, new_ordini)
ll_ret=message.doubleparm
CloseWithReturn(parent, ll_ret)



end event

type cb_ok from commandbutton within w_orafo_lista_dis_cliente_gd
int X=78
int Y=24
int Width=247
int Height=104
int TabOrder=60
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_ret

ll_ret=dw_lista_dis_cliente.getrow()
if ll_ret>0 then
	ll_ret=dw_lista_dis_cliente.getitemnumber(ll_ret,"id_riga_doc")
else
	ll_ret=0
end if
CloseWithReturn(pARENT, ll_ret)
end event

type dw_lista_dis_cliente from datawindow within w_orafo_lista_dis_cliente_gd
event ue_key pbm_dwnkey
int X=69
int Y=168
int Width=2656
int Height=968
int TabOrder=10
string DataObject="d_lista_var_cliente"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;if key=Keyadd! then
	
	if (keyFlags=2) then
 		   cb_inserisci.triggerevent(clicked!)
	end if
end if
end event

event doubleclicked;long ll_ret




ll_ret=dw_lista_dis_cliente.getrow()

ll_ret=dw_lista_dis_cliente.getitemnumber(ll_ret,"id_riga_doc")
CloseWithReturn(parent, ll_ret)
end event

event getfocus;
end event

event rowfocuschanged;
SetRowFocusIndicator(Hand!)

end event

