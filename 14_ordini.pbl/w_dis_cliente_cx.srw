forward
global type w_dis_cliente_cx from Window
end type
type cb_ok from commandbutton within w_dis_cliente_cx
end type
type cb_annulla from commandbutton within w_dis_cliente_cx
end type
type cb_salva from commandbutton within w_dis_cliente_cx
end type
type dw_dis_cliente from datawindow within w_dis_cliente_cx
end type
end forward

global type w_dis_cliente_cx from Window
int X=1056
int Y=484
int Width=2615
int Height=1072
boolean TitleBar=true
string Title="Modifica Variazioni "
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_ok cb_ok
cb_annulla cb_annulla
cb_salva cb_salva
dw_dis_cliente dw_dis_cliente
end type
global w_dis_cliente_cx w_dis_cliente_cx

type variables
long ll_sorgente
end variables

on w_dis_cliente_cx.create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_salva=create cb_salva
this.dw_dis_cliente=create dw_dis_cliente
this.Control[]={this.cb_ok,&
this.cb_annulla,&
this.cb_salva,&
this.dw_dis_cliente}
end on

on w_dis_cliente_cx.destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_salva)
destroy(this.dw_dis_cliente)
end on

event open;


long ll_distinta1,ll_distinta, ll_riga_doc, ll_tot, ll_nullo, ll_conto

string DWfilter

s_new_ordini new_ordini

new_ordini=message.powerobjectparm

dw_dis_cliente.settransobject(sqlca)
dw_dis_cliente.retrieve(new_ordini.s_ll_id_art_originale)

ll_sorgente=new_ordini.s_ll_id_sorgente



if ll_sorgente>0 then 
	  ll_tot=dw_dis_cliente.rowcount()
     if ll_tot>0 then
		
	     ll_distinta1=dw_dis_cliente.getitemnumber(1, "riga_distinta_id_riga_distinta1")
        ll_riga_doc=dw_dis_cliente.getitemnumber(1, "id_riga_doc")
		  if ll_riga_doc<>ll_sorgente and not isnull(ll_riga_doc) then
	          setnull(ll_nullo)
		       dw_dis_cliente.setitem(1, "id_art_sostitutivo",ll_nullo)
		       dw_dis_cliente.setitem(1, "id_riga_doc",ll_nullo)
             dw_dis_cliente.setitem(1, "orafo_dis_cliente_quantita",ll_nullo)
				 dw_dis_cliente.setitem(1, "note",ll_nullo)
		  end if		 
	     if ll_tot>1 then
	        for ll_conto= 2 to ll_tot 
              ll_distinta=dw_dis_cliente.getitemnumber(ll_conto, "riga_distinta_id_riga_distinta1")
				  if ll_distinta1=ll_distinta then
                    ll_riga_doc=dw_dis_cliente.getitemnumber(ll_conto, "id_riga_doc")
					     if ll_riga_doc<>ll_sorgente and not isnull(ll_riga_doc) then
							   dw_dis_cliente.RowsMove (ll_conto,ll_conto, primary!,dw_dis_cliente,ll_conto,filter!)
							   ll_conto=ll_conto -1	
								ll_tot=ll_tot -1
						  else
							   dw_dis_cliente.RowsMove (ll_conto -1, ll_conto -1, primary!,dw_dis_cliente,ll_conto,filter!)
							   ll_conto=ll_conto -1	
								ll_tot=ll_tot -1
						  end if		
			     else
				     ll_distinta1=ll_distinta
					  ll_riga_doc=dw_dis_cliente.getitemnumber(ll_conto, "id_riga_doc")
					  if ll_riga_doc<>ll_sorgente and not isnull(ll_riga_doc) then
				          setnull(ll_nullo)
				          dw_dis_cliente.setitem(ll_conto, "id_art_sostitutivo",ll_nullo)
		                dw_dis_cliente.setitem(ll_conto, "id_riga_doc",ll_nullo)
					       dw_dis_cliente.setitem(ll_conto, "orafo_dis_cliente_quantita",ll_nullo)
							 dw_dis_cliente.setitem(1, "note",ll_nullo)
					  end if	 
		        end if
		      next	 
	     end if
     end if

end if



dw_dis_cliente.setitem(1, "id_cliente", new_ordini.s_ll_id_cliente)
end event

type cb_ok from commandbutton within w_dis_cliente_cx
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
ll_message=dw_dis_cliente.getitemnumber(ll_message, "id_riga_doc") 

CloseWithReturn(parent, ll_message)


end event

type cb_annulla from commandbutton within w_dis_cliente_cx
int X=2295
int Y=28
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

event clicked;CloseWithReturn(parent, -1) 
end event

type cb_salva from commandbutton within w_dis_cliente_cx
int X=2002
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

event clicked;long ll_id_riga_doc, ll_id_riga_doc2, ll_id_riga_distinta, ll_row, ll_quantita, ll_id_articolo, ll_id_cliente, ll_sostitutivo, ll_distinta
integer li_conto, li_ret, li_riga
string DWfilter, ls_note

 long ll_message
 
 
datastore ds_salva

dw_dis_cliente.accepttext()

	
ll_id_articolo=dw_dis_cliente.getitemnumber(1,"distinta_id_articolo")
ll_id_cliente=dw_dis_cliente.getitemnumber(1,"id_cliente")

DWfilter = "modificato='S'"
dw_dis_cliente.SetFilter(DWfilter)
dw_dis_cliente.Filter()

ll_row=dw_dis_cliente.rowcount()
if ll_row >0 then
	 
	 ll_id_riga_doc=ll_sorgente
    ds_salva=create datastore
    ds_salva.dataobject='ds_dis_modifica_cliente'
    ds_salva.settransobject(sqlca)
    li_ret=ds_salva.retrieve(ll_id_riga_doc)
	
    for li_conto= 1 to ll_row
		   
		   ll_id_riga_doc2=dw_dis_cliente.getitemnumber(li_conto,"id_riga_doc")    
		 
			if not isnull(ll_id_riga_doc2) and ll_id_riga_doc2>0 then 
		      
				ll_distinta=dw_dis_cliente.getitemnumber(li_conto,"id_riga_distinta")
				li_riga=ds_salva.Find("id_riga_distinta =" + string(ll_distinta), 1, li_ret)
				ll_quantita=dw_dis_cliente.getitemnumber(li_conto, "orafo_dis_cliente_quantita")
				if isnull(ll_quantita) then ll_quantita=dw_dis_cliente.getitemnumber(li_conto,"riga_distinta_quantita") 
            ds_salva.setitem(li_riga,"quantita",ll_quantita)
            ll_sostitutivo=dw_dis_cliente.getitemnumber(li_conto,"id_art_sostitutivo") 
            ds_salva.setitem(li_riga,"id_art_sostitutivo",ll_sostitutivo)
	         ls_note=dw_dis_cliente.getitemstring(li_conto,"note") 
            ds_salva.setitem(li_riga,"note",ls_note)
		   else
				ds_salva.insertrow(1)
				
				ds_salva.setitem(1,"id_riga_doc",ll_id_riga_doc)
				ds_salva.setitem(1,"id_cliente",ll_id_cliente)
				ll_quantita=dw_dis_cliente.getitemnumber(li_conto,"riga_distinta_quantita") 
            ds_salva.setitem(1,"quantita",ll_quantita)
				ls_note=dw_dis_cliente.getitemstring(li_conto,"note")
            ll_sostitutivo=dw_dis_cliente.getitemnumber(li_conto,"id_art_sostitutivo")
				if isnull(ll_sostitutivo) or ll_sostitutivo=0 then ll_sostitutivo=ll_id_articolo
            ds_salva.setitem(1,"id_art_sostitutivo",ll_sostitutivo)
            ll_id_riga_distinta=dw_dis_cliente.getitemnumber(li_conto,"riga_distinta_id_riga_distinta1")
				ds_salva.setitem(1,"id_riga_distinta",ll_id_riga_distinta)
            ds_salva.setitem(1,"id_art_originale",ll_id_articolo)
				ds_salva.setitem(1,"note",ls_note)
         end if   
     next
	
	
	
	


		 li_conto=ds_salva.update()
	 if li_conto= -1 then 
		  messagebox('Attenzione!', 'Salvataggio non riuscito')
  	 else
		 
       ll_message=dw_dis_cliente.getrow()
       ll_message=dw_dis_cliente.getitemnumber(ll_message, "id_riga_doc") 
       CloseWithReturn(parent, ll_message)	
		 
	 end if
else
	messagebox('Attenzione!', 'Nessuna delle righe selezionate ha il~r~nbox MODIFICATO selezionato,'+&
	"in caso di variazioni selezionare tale voce ~r~nper poter effettuare correttamente il salvataggio")

   dw_dis_cliente.triggerevent(open!)
end if	
end event

type dw_dis_cliente from datawindow within w_dis_cliente_cx
int X=46
int Y=148
int Width=2510
int Height=784
int TabOrder=40
string DataObject="d_dis_cliente"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;s_ric_param is_ricpar

long ll_row, ll_quantita

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
			SetItem(ll_row,"codice_sost",is_ricpar.s_main_value)
			SetItem(ll_row,"id_art_sostitutivo",LONG(is_ricpar.s_id_seg_value[1]))
		end if
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(ll_row,"art_descrizione",is_ricpar.s_ausil_value[1])
			SetItem(ll_row,"descrizione_sost",is_ricpar.s_ausil_value[1])
			ll_quantita=dw_dis_cliente.getitemnumber(ll_row,"orafo_dis_cliente_quantita")	
		   if isnull(ll_quantita) or ll_quantita=0 then
		      ll_quantita=dw_dis_cliente.getitemnumber(ll_row,"riga_distinta_quantita")
		      dw_dis_cliente.setitem(ll_row,"orafo_dis_cliente_quantita", ll_quantita )
	      end if
		end if

	case "art_descrizione_sw"
		is_ricpar.s_filter_value = dw_dis_cliente.GetItemString(ll_row,"art_descrizione")
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			SetItem(ll_row,"art_descrizione",is_ricpar.s_main_value)
			SetItem(ll_row,"descrizione_sost",is_ricpar.s_main_value)
			SetItem(ll_row,"id_art_sostitutivo",LONG(is_ricpar.s_id_seg_value[1]))
		end if
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(ll_row,"codice_sost",is_ricpar.s_ausil_value[1])
			SetItem(ll_row,"art_codice",is_ricpar.s_ausil_value[1])
			ll_quantita=dw_dis_cliente.getitemnumber(ll_row,"orafo_dis_cliente_quantita")	
		   if isnull(ll_quantita) or ll_quantita=0 then
		      ll_quantita=dw_dis_cliente.getitemnumber(ll_row,"riga_distinta_quantita")
		      dw_dis_cliente.setitem(ll_row,"orafo_dis_cliente_quantita", ll_quantita )
	      end if
		end if
	
end choose
end event

event itemchanged;string ls_art_codice, ls_art_descrizione 
long ll_id_articolo, ll_quantita

if dwo.name="art_codice" or dwo.name="codice_sost" then
	  
	select codice, descrizione, id_articolo
	into :ls_art_codice, :ls_art_descrizione, :ll_id_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		
		
		 this.setitem(row,"id_art_sostitutivo",ll_id_articolo)
	    this.setitem(row,"art_codice",ls_art_codice)
  	    this.setitem(row,"art_descrizione",ls_art_descrizione)
		 this.setitem(row,"codice_sost",ls_art_codice)
  	    this.setitem(row,"descrizione_sost",ls_art_descrizione)
		 ll_quantita=dw_dis_cliente.getitemnumber(row,"orafo_dis_cliente_quantita")	
		 if isnull(ll_quantita) or ll_quantita=0 then
		   ll_quantita=dw_dis_cliente.getitemnumber(row,"riga_distinta_quantita")
		   dw_dis_cliente.setitem(row,"orafo_dis_cliente_quantita", ll_quantita )
	    end if
	else 
		this.trigger event clicked(0,0,row, this.object.art_codice_sw)
	end if
	
end if	


if dwo.name="art_descrizione" or dwo.name="descrizione_sost" then
	  
	select codice, descrizione, id_articolo
	into :ls_art_codice, :ls_art_descrizione, :ll_id_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then 
		 this.setitem(row,"id_art_sostitutivo",ll_id_articolo)
	    this.setitem(row,"art_codice",ls_art_codice)
  	    this.setitem(row,"art_descrizione",ls_art_descrizione)
		 this.setitem(row,"codice_sost",ls_art_codice)
  	    this.setitem(row,"descrizione_sost",ls_art_descrizione)	
		 ll_quantita=dw_dis_cliente.getitemnumber(row,"orafo_dis_cliente_quantita")	
		 if isnull(ll_quantita) or ll_quantita=0 then
		   ll_quantita=dw_dis_cliente.getitemnumber(row,"riga_distinta_quantita")
		   dw_dis_cliente.setitem(row,"orafo_dis_cliente_quantita", ll_quantita )
	    end if
	else 
		this.trigger event clicked(0,0,row, this.object.art_descrizione_sw)
	end if
	
end if	






end event

