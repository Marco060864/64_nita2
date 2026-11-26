forward
global type w_sel_articoli_manuale_ff from Window
end type
type cb_reset from commandbutton within w_sel_articoli_manuale_ff
end type
type cb_annulla from commandbutton within w_sel_articoli_manuale_ff
end type
type cb_ok from commandbutton within w_sel_articoli_manuale_ff
end type
type cb_add from commandbutton within w_sel_articoli_manuale_ff
end type
type dw_selezione from datawindow within w_sel_articoli_manuale_ff
end type
type dw_dati from datawindow within w_sel_articoli_manuale_ff
end type
end forward

global type w_sel_articoli_manuale_ff from Window
int X=1074
int Y=484
int Width=2491
int Height=1612
boolean TitleBar=true
string Title="Selezione manuale articoli"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_reset cb_reset
cb_annulla cb_annulla
cb_ok cb_ok
cb_add cb_add
dw_selezione dw_selezione
dw_dati dw_dati
end type
global w_sel_articoli_manuale_ff w_sel_articoli_manuale_ff

type variables
string is_filtro=""
long il_id_art[]
datawindowchild idwc_var
end variables

forward prototypes
public subroutine wf_crea_struttura ()
public subroutine wf_trova_listino_var (ref long al_listino, ref long al_variazione)
public subroutine wf_crea_filtro ()
end prototypes

public subroutine wf_crea_struttura ();long i=1, p=1, l, val, n
long ll_vuoto[]

il_id_art=ll_vuoto
n=1
if is_filtro<>"" then
	l=len(is_filtro)
	do while i<l
		p=Pos(is_filtro,"id_articolo=",i)
		if p<>0 then 
			i=p+12
			p=Pos(is_filtro,"or",i)
			if p=0 then p=l+1
			val=long(Mid(is_filtro,i,p - i))
			il_id_art[n]=val
			n++
			i=p - 1
		else
			p=l+1
		end if
	loop
end if


end subroutine

public subroutine wf_trova_listino_var (ref long al_listino, ref long al_variazione);long pos1, pos2

pos1=Pos(is_filtro," prezzo_id_variazione = ")
if pos1>0 then
	pos2=Pos(is_filtro," ",pos1+24)
	if not(pos2>0) then pos2=len(is_filtro)	
	pos2= pos2 - pos1
	al_variazione=long(Mid(is_filtro,pos1+24,pos2))
	SELECT DISTINCT "listino_variazione"."id_listino"
   INTO :al_listino
	FROM "listino_variazione"
	WHERE "listino_variazione"."id_variazione"=:al_variazione;
end if


end subroutine

public subroutine wf_crea_filtro ();
integer i
long ll_id_articolo, ll_old_art=0, ll_id_var
ll_id_var=dw_selezione.getitemnumber(1, "variazione")
if isnull(ll_id_var) then 
	is_filtro='nulla'
	return
end if

for i = 1 to dw_dati.rowcount()
	ll_id_articolo=dw_dati.getitemnumber(i, "id_articolo")
	if ll_id_articolo=ll_old_art then continue
	if i=1 then
		is_filtro = is_filtro + " and (variazione.id_variazione="+string(ll_id_var)+ ") and "&
		+"("+"articolo.id_articolo="+string(ll_id_articolo)
	else
		
		is_filtro = is_filtro + " or "+"articolo.id_articolo="+string(ll_id_articolo)
	end if
	ll_old_art=ll_id_articolo
next



	

end subroutine

on w_sel_articoli_manuale_ff.create
this.cb_reset=create cb_reset
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.cb_add=create cb_add
this.dw_selezione=create dw_selezione
this.dw_dati=create dw_dati
this.Control[]={this.cb_reset,&
this.cb_annulla,&
this.cb_ok,&
this.cb_add,&
this.dw_selezione,&
this.dw_dati}
end on

on w_sel_articoli_manuale_ff.destroy
destroy(this.cb_reset)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.cb_add)
destroy(this.dw_selezione)
destroy(this.dw_dati)
end on

event open;
datawindowchild dwc_listino
long ll_id_var, ll_id_lis, riga
s_vet_articolo ll_id_articolo[]
integer i
datawindow dw_torna1

if isvalid(message.powerobjectparm) then
	dw_torna1=message.powerobjectparm
	if dw_torna1.rowcount()>0 then
		dw_torna1.rowscopy(1, dw_torna1.rowcount(), primary!, dw_dati, 1, primary!)
		
	end if
end if
dw_selezione.insertrow(0)


dw_selezione.getchild("listino",dwc_listino)
dwc_listino.settransobject(sqlca)
dwc_listino.retrieve()
dw_selezione.getchild("variazione",idwc_var)
idwc_var.settransobject(sqlca)

dw_dati.settransobject(sqlca)

	
	


end event

type cb_reset from commandbutton within w_sel_articoli_manuale_ff
int X=951
int Y=32
int Width=375
int Height=84
int TabOrder=12
string Text="Cancella Tutto"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_dati.reset()
end event

type cb_annulla from commandbutton within w_sel_articoli_manuale_ff
int X=457
int Y=32
int Width=375
int Height=84
int TabOrder=10
string Text="Annula"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_sel_articoli_manuale_ff
int X=41
int Y=32
int Width=320
int Height=84
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_crea_filtro()

closewithreturn(parent, is_filtro)

end event

type cb_add from commandbutton within w_sel_articoli_manuale_ff
int X=1504
int Y=292
int Width=375
int Height=84
int TabOrder=40
string Text="Aggiungi"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_cod, ls_des
long ll_id_art, ll_up, ll_id_variazione
boolean lb_trovato=false

dw_selezione.accepttext()

dw_selezione.object.listino.protect=1
dw_selezione.object.variazione.protect=1

ll_id_art=dw_selezione.getitemnumber(1, "id_articolo")
if isnull(ll_id_art) then return
ll_id_variazione=dw_selezione.getitemnumber(1, "variazione")
ll_up=upperbound(il_id_art)

if IsNull(ll_id_art)  then
	messagebox('Errore!','Si deve prima impostare almeno un campo!')
	return
else

dw_dati.Retrieve(ll_id_art, ll_id_variazione)


end if

end event

type dw_selezione from datawindow within w_sel_articoli_manuale_ff
int X=37
int Y=140
int Width=2391
int Height=404
int TabOrder=30
string DataObject="d_sel_articolo_manuale_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event clicked;s_ric_param is_ricpar

dw_selezione.accepttext()
choose case dwo.name
	case "art_codice_sw"
		is_ricpar.s_filter_value	= dw_selezione.GetItemString(1,"art_codice")
		is_ricpar.s_filter_name 	= "articolo_codice"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"art_codice",is_ricpar.s_main_value)
		SetItem(1,"id_articolo",LONG(is_ricpar.s_id_seg_value[1]))
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"art_descrizione",is_ricpar.s_ausil_value[1])
		end if

	case "art_descrizione_sw"
		is_ricpar.s_filter_value = dw_selezione.GetItemString(1,"art_descrizione")
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"art_descrizione",is_ricpar.s_main_value)
		SetItem(1,"id_articolo",LONG(is_ricpar.s_id_seg_value[1]))
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"art_codice",is_ricpar.s_ausil_value[1])
		end if

	case "variazione"		
		dw_selezione.object.art_codice.protect=0
		dw_selezione.object.art_descrizione.protect=0
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
		 this.setitem(row,"id_articolo",ll_id_articolo)
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
		 this.setitem(row,"id_articolo",ll_id_articolo)
	    this.setitem(row,"art_codice",ls_art_codice)
  	    this.setitem(row,"art_descrizione",ls_art_descrizione)
	else 
		this.trigger event clicked(0,0,row, this.object.art_descrizione_sw)
	end if
	
end if	
if dwo.name= "listino" then
		idwc_var.retrieve(long(data))
	end if
end event

type dw_dati from datawindow within w_sel_articoli_manuale_ff
int X=37
int Y=588
int Width=2395
int Height=916
int TabOrder=50
string DataObject="d_sel_man_stampa_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;long ll_id_articolo
if row>0 then
	if messagebox('Elimina riga','Vuoi eliminare la riga '+this.getItemString(row,"articolo_codice")+" ?",Information!,YesNo!)=1 then
		this.DeleteRow(row)
		
		ll_id_articolo=getitemnumber(row, "id_articolo")
		
	end if
end if

end event

event retrievestart;RETURN 2
end event

