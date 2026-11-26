forward
global type w_nuovo_dis_cliente_cx from Window
end type
type cb_ok from commandbutton within w_nuovo_dis_cliente_cx
end type
type cb_annulla from commandbutton within w_nuovo_dis_cliente_cx
end type
type cb_salva from commandbutton within w_nuovo_dis_cliente_cx
end type
type dw_dis_cliente from datawindow within w_nuovo_dis_cliente_cx
end type
end forward

global type w_nuovo_dis_cliente_cx from Window
int X=1056
int Y=484
int Width=2619
int Height=1072
boolean TitleBar=true
string Title="Crea Variazioni "
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_ok cb_ok
cb_annulla cb_annulla
cb_salva cb_salva
dw_dis_cliente dw_dis_cliente
end type
global w_nuovo_dis_cliente_cx w_nuovo_dis_cliente_cx

type variables

end variables

on w_nuovo_dis_cliente_cx.create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_salva=create cb_salva
this.dw_dis_cliente=create dw_dis_cliente
this.Control[]={this.cb_ok,&
this.cb_annulla,&
this.cb_salva,&
this.dw_dis_cliente}
end on

on w_nuovo_dis_cliente_cx.destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_salva)
destroy(this.dw_dis_cliente)
end on

event open;
long   ll_id_riga_doc
integer li_ret

s_new_ordini new_ordini

new_ordini=message.powerobjectparm

dw_dis_cliente.settransobject(sqlca)
li_ret=dw_dis_cliente.retrieve(new_ordini.s_ll_id_art_originale)

if li_ret < 1 then 
	closewithreturn(this, -1)
	return
end if
select max (id_riga_doc)
 into :ll_id_riga_doc
 from orafo_dis_cliente;
 
if isnull(ll_id_riga_doc) then 
	ll_id_riga_doc=1
else 
	ll_id_riga_doc=ll_id_riga_doc + 1
end if	



 
dw_dis_cliente.setitem(1, "id_azienda", ll_id_riga_doc )   

dw_dis_cliente.setitem(1, "id_valuta", new_ordini.s_ll_id_cliente)
end event

type cb_ok from commandbutton within w_nuovo_dis_cliente_cx
int X=64
int Y=24
int Width=247
int Height=104
int TabOrder=30
boolean Visible=false
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_message

ll_message=dw_dis_cliente.getrow()
ll_message=dw_dis_cliente.getitemnumber(ll_message, "id_azienda") 

CloseWithReturn(parent, ll_message)


end event

type cb_annulla from commandbutton within w_nuovo_dis_cliente_cx
int X=64
int Y=24
int Width=247
int Height=104
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(parent, 0) 
end event

type cb_salva from commandbutton within w_nuovo_dis_cliente_cx
int X=2309
int Y=28
int Width=247
int Height=104
int TabOrder=10
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_riga_doc, ll_id_riga_distinta, ll_row, ll_quantita, ll_id_articolo, ll_id_cliente, ll_art_sostitutivo
integer li_conto
string DWfilter, ls_note
datastore ds_salva

long ll_message

dw_dis_cliente.accepttext()

ll_id_riga_doc=dw_dis_cliente.getitemnumber(1,"id_azienda")		
ll_id_articolo=dw_dis_cliente.getitemnumber(1,"distinta_id_articolo")
ll_id_cliente=dw_dis_cliente.getitemnumber(1,"id_valuta")

DWfilter = "modificato='S'"
dw_dis_cliente.SetFilter(DWfilter)
dw_dis_cliente.Filter()



ds_salva=create datastore
ds_salva.dataobject='ds_dis_salva_cliente'
ds_salva.settransobject(sqlca)






ll_row=dw_dis_cliente.rowcount()
if ll_row >0 then
    for li_conto= 1 to ll_row
		   
			
		 
		   ds_salva.insertrow(1)		
    	   ds_salva.setitem(1,"id_riga_doc",ll_id_riga_doc) 
         ds_salva.setitem(1,"id_cliente",ll_id_cliente)  
		   ll_quantita=dw_dis_cliente.getitemnumber(li_conto,"riga_distinta_quantita") 
         ll_art_sostitutivo=dw_dis_cliente.getitemnumber(li_conto,"riga_distinta_id_articolo")
			ls_note=dw_dis_cliente.getitemstring(li_conto,"note")
			if isnull(ll_art_sostitutivo) or ll_art_sostitutivo=0 then ll_art_sostitutivo=ll_id_articolo
			ll_id_riga_distinta=dw_dis_cliente.getitemnumber(li_conto,"riga_distinta_id_riga_distinta1")
		   ds_salva.setitem(1,"id_riga_distinta",ll_id_riga_distinta)
			ds_salva.setitem(1,"quantita",ll_quantita)
         ds_salva.setitem(1,"id_art_sostitutivo",ll_art_sostitutivo)
			ds_salva.setitem(1,"id_art_originale",ll_id_articolo)
			ds_salva.setitem(1,"note",ls_note)
    next

	 li_conto=ds_salva.update()
	 if li_conto= -1 then 
		  messagebox('Attenzione!', 'Salvataggio non riuscito')
		  rollback;
	 else
		
		commit;
		ll_message=dw_dis_cliente.getrow()
    		ll_message=dw_dis_cliente.getitemnumber(ll_message, "id_azienda") 
     		CloseWithReturn(parent, ll_id_riga_doc) 
		
    end if
else
	messagebox('Attenzione!', 'Nessuna delle righe selezionate ha il box MODIFICATO selezionato,in caso di variazioni selezionare tale voce per poter effettuare correttamente il salvataggio')
	dw_dis_cliente.triggerevent(open!)
end if	
end event

type dw_dis_cliente from datawindow within w_nuovo_dis_cliente_cx
int X=46
int Y=148
int Width=2514
int Height=784
int TabOrder=30
string DataObject="d_nuovo_dis_cliente"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;s_ric_param is_ricpar

long ll_row

dw_dis_cliente.accepttext()
ll_row=dw_dis_cliente.getrow()
choose case dwo.name
	case "art_codice_sw"
		is_ricpar.s_filter_value	= dw_dis_cliente.GetItemString(ll_row,"art_codice")
		is_ricpar.s_filter_name 	= "articolo_codice"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			SetItem(ll_row,"art_codice",is_ricpar.s_main_value)
			SetItem(ll_row,"riga_distinta_id_articolo",LONG(is_ricpar.s_id_seg_value[1]))   
		end if
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(ll_row,"art_descrizione",is_ricpar.s_ausil_value[1])
		end if

	case "art_descrizione_sw"
		is_ricpar.s_filter_value = dw_dis_cliente.GetItemString(ll_row,"art_descrizione")
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			SetItem(ll_row,"art_descrizione",is_ricpar.s_main_value)
			SetItem(ll_row,"riga_distinta_id_articolo",LONG(is_ricpar.s_id_seg_value[1]))
		end if
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(ll_row,"art_codice",is_ricpar.s_ausil_value[1])
		end if
	
end choose
end event

event itemchanged;string ls_art_codice, ls_art_descrizione 
long ll_id_articolo


if dwo.name="art_codice" then
	  
	select codice, descrizione, id_articolo
	into :ls_art_codice, :ls_art_descrizione, :ll_id_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		 this.setitem(row,"riga_distinta_id_articolo",ll_id_articolo)        
	    this.setitem(row,"art_codice",ls_art_codice)
  	    this.setitem(row,"art_descrizione",ls_art_descrizione)	
	else 
		this.trigger event clicked(0,0,row, this.object.art_codice_sw)
	end if
	
end if	


if dwo.name="art_descrizione" then
	  
	select codice, descrizione, id_articolo
	into :ls_art_codice, :ls_art_descrizione, :ll_id_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then 
		 this.setitem(row,"riga_distinta_id_articolo",ll_id_articolo)
	    this.setitem(row,"art_codice",ls_art_codice)
  	    this.setitem(row,"art_descrizione",ls_art_descrizione)	
	else 
		this.trigger event clicked(0,0,row, this.object.art_descrizione_sw)
	end if
	
end if	






end event

