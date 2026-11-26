forward
global type w_packing_list_cx from Window
end type
type cb_cancella from commandbutton within w_packing_list_cx
end type
type p_1 from picture within w_packing_list_cx
end type
type dw_3 from u_dw_ext_main within w_packing_list_cx
end type
type cb_stampa from commandbutton within w_packing_list_cx
end type
type cb_inserisci from commandbutton within w_packing_list_cx
end type
type cb_salva from commandbutton within w_packing_list_cx
end type
type dw_2 from u_dw_ext_main within w_packing_list_cx
end type
type dw_1 from u_dw_ext_main within w_packing_list_cx
end type
end forward

global type w_packing_list_cx from Window
int X=14
int Y=16
int Width=3666
int Height=2032
boolean TitleBar=true
string Title="Packing List"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_cancella cb_cancella
p_1 p_1
dw_3 dw_3
cb_stampa cb_stampa
cb_inserisci cb_inserisci
cb_salva cb_salva
dw_2 dw_2
dw_1 dw_1
end type
global w_packing_list_cx w_packing_list_cx

type variables
datawindow idw_fuoco
end variables

forward prototypes
public subroutine wf_proponi_valori (long al_id_doc)
public subroutine wf_proponi_righe (long al_id_doc)
public function long wf_inserisci_riga ()
public subroutine wf_ricerca_doc ()
end prototypes

public subroutine wf_proponi_valori (long al_id_doc);string ls_bollo, ls_master, ls_dest
long ll_id_dest
decimal ld_qta
integer li_pos


ls_bollo=dw_1.getitemstring(1, "documento_bollo")
ls_master=mid(ls_bollo, 3, len(ls_bollo) - 3)
dw_1.setitem(1, "pack_t_master_c", ls_master)
ls_master=right(ls_bollo, len(ls_bollo) - 2)
dw_1.setitem(1, "pack_t_po", ls_master)

ls_dest=dw_1.getitemstring(1, "destinazione_LOCALITA")
li_pos=pos(ls_dest, ":")
if li_pos>0 then
	if mid(ls_dest, li_pos+1,1)=' ' then
		ls_dest=mid(ls_dest, li_pos+2, 3)
	else
		ls_dest=mid(ls_dest, li_pos+1, 3)
	end if
	ls_dest='IT'+ls_dest+ls_master
	if len(ls_dest)>16 then ls_dest=left(ls_dest, 16)
	dw_1.setitem(1, "pack_t_num_ordine", ls_dest)
end if
ls_master=dw_1.getitemstring(1, "destinazione_localita")
dw_1.setitem(1, "pack_t_division_destinazione", ls_master)



select sum(quantita)
into :ld_qta
from riga_documento
where id_documento=:al_id_doc;
if sqlca.sqlcode=0 then
	dw_1.setitem(1, "pack_t_somma_qta_riga_doc", ld_qta)
	
else
	messagebox("Errore", "Quantità righe non recuperata!")
	
end if
wf_proponi_righe(al_id_doc)







end subroutine

public subroutine wf_proponi_righe (long al_id_doc);datastore ds_pack
long ll_righe, i, a
string ls_codice, ls_des, ls_des_estesa, ls_size
decimal ld_legato, ld_pezzi



ds_pack=create datastore
ds_pack.dataobject='d_recupera_righe'
ds_pack.settransobject(sqlca)
ll_righe=ds_pack.retrieve(al_id_doc)



for i= 1 to ll_righe
	
	ls_codice=ds_pack.getitemstring(i, "des_articolo_codice")
	
	ls_des_estesa=ds_pack.getitemstring(i, "des_articolo_des_estesa")
	ld_legato=ds_pack.getitemdecimal(i, "riga_documento_peso_netto")
	ld_pezzi=ds_pack.getitemdecimal(i, "riga_documento_quantita")
	
	a=wf_inserisci_riga()
	dw_2.setitem(a, "from", 1)
	dw_2.setitem(a, "to", 1)
	dw_2.setitem(a, "cod_art_cli_fo", ls_codice)
	dw_2.setitem(a, "upc_number", ls_des_estesa)
	
	dw_2.setitem(a, "peso_netto", ld_legato)
	dw_2.setitem(a, "qta", ld_pezzi)
	
next
if dw_1.update()=1 then
	if dw_2.update()=1 then
		commit;
	else
		rollback;
	end if
else
	rollback;
end if
	

end subroutine

public function long wf_inserisci_riga ();long ll_id_pack, ll_riga

ll_riga=dw_2.insertrow(0)
ll_id_pack=dw_1.getitemnumber(1, "pack_t_id_pack_t")
if ll_id_pack>0 then
	dw_2.setitem(ll_riga, "id_pack_t", ll_id_pack)
	dw_2.setitem(ll_riga, "num_riga", ll_riga)
else
	messagebox("Errore", "Riga non inserita correttamente")
end if
return ll_riga
end function

public subroutine wf_ricerca_doc ();
end subroutine

on w_packing_list_cx.create
this.cb_cancella=create cb_cancella
this.p_1=create p_1
this.dw_3=create dw_3
this.cb_stampa=create cb_stampa
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_cancella,&
this.p_1,&
this.dw_3,&
this.cb_stampa,&
this.cb_inserisci,&
this.cb_salva,&
this.dw_2,&
this.dw_1}
end on

on w_packing_list_cx.destroy
destroy(this.cb_cancella)
destroy(this.p_1)
destroy(this.dw_3)
destroy(this.cb_stampa)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;
DataWindowChild dwc_reg
integer rtncode


dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)


rtncode = dw_3.GetChild('tipo_reg', dwc_reg)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


CONNECT USING SQLCA;	


dwc_reg.SetTransObject(SQLCA)


dwc_reg.Retrieve()


dw_3.insertrow(1)
dw_3.setitem(1, "tipo_reg" ,'IV')





end event

type cb_cancella from commandbutton within w_packing_list_cx
int X=2487
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

event clicked;long ll_riga
integer li_ret

if not isvalid(idw_fuoco) then return
ll_riga=idw_fuoco.getrow()
if ll_riga<1 then return

if idw_fuoco=dw_1 then
	li_ret=messagebox("Attenzione!", "La cancellazione di questa Packing List~r~n"&
					+"provocherà la cancellazione di tutte le righe ad essa associate:~r~n"&
					+"Continuare con la cancellazione?", stopsign!, yesno!)
	if li_ret=1 then
		dw_1.deleterow(1)
		dw_2.reset()
		if dw_1.update()=1 then
			if dw_2.update()=1 then
				commit;
			else
				rollback;
			end if
		else
			rollback;
		end if
	end if
elseif idw_fuoco=dw_2 then
	ll_riga=dw_2.getrow()
	li_ret=messagebox("Attenzione!", "Si è scelto di cancellare la riga"+string(ll_riga)+"~r~n"&
					+"Continuare con la cancellazione?", stopsign!,yesno! )
	if li_ret=1 then
		dw_2.deleterow(ll_riga)
		if dw_2.update()=1 then
			commit;
		else
			rollback;
		end if
	end if
end if
end event

type p_1 from picture within w_packing_list_cx
int X=1815
int Y=12
int Width=146
int Height=116
string PictureName="s:\pb\commonframework\search.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

event clicked;s_ric_param is_ricpar
string ls_num_doc, ls_tipo_reg
date ldt_data
long ll_id_doc, ll_ret

if dw_3.accepttext()>0 then
	
	ls_num_doc=dw_3.getitemstring(1, "num_doc")
	ls_tipo_reg=dw_3.getitemstring(1, "tipo_reg")
	if isnull(ls_tipo_reg) then
		messagebox("Attenzione!", "Il tipo di registro deve essere indicato")
		return
	end if
	ldt_data=dw_3.getitemdate(1, "data_doc")
	
	is_ricpar.s_filter_value	= ls_num_doc
	is_ricpar.s_filter_name 	= "documento_num_documento"
	is_ricpar.s_sql_cond="registro.tipo_registro = '"+ls_tipo_reg +"'"
	OpenWithParm(w_documento_sw,is_ricpar)
	is_ricpar=message.PowerObjectParm
	if upperbound(is_ricpar.s_id_seg_value)>0 then
		ll_id_doc=LONG(is_ricpar.s_id_seg_value[1])
		if ll_id_doc > 0 then
			dw_3.setitem(1, "num_doc", is_ricpar.s_ausil_value[6])
			dw_3.setitem(1, "data_doc", date(is_ricpar.s_ausil_value[7]))
			
			ll_ret=dw_1.retrieve(ll_id_doc)
			if ll_ret>0 then
				ll_id_doc=dw_1.getitemnumber(1, "pack_t_id_pack_t")
				dw_2.retrieve(ll_id_doc)
				dw_1.object.retto.pen.color=0
			else
				INSERT INTO pack_t (id_documento)
				VALUES (:ll_id_doc) ;
				if sqlca.sqlcode=0 then
					commit;
					dw_1.retrieve(ll_id_doc)
					post wf_proponi_valori(ll_id_doc)
					dw_1.object.retto.pen.color=16777215
				else
					Messagebox("Errore", "Nessun Documento recuperato")
					rollback;
				end if
			end if
		end if
	end if
end if
	

	
	
	
	
	
	


end event

type dw_3 from u_dw_ext_main within w_packing_list_cx
int X=27
int Y=12
int Width=1797
int Height=120
int TabOrder=10
string DataObject="d_pack_ricerca_ext"
end type

event itemchanged;if dwo.name="num_doc" then
	p_1.triggerevent(clicked!)
end if
end event

type cb_stampa from commandbutton within w_packing_list_cx
int X=3351
int Y=24
int Width=247
int Height=108
int TabOrder=40
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_doc
cb_salva.triggerevent(clicked!)
ll_id_doc=dw_1.getitemnumber(1, "pack_t_id_documento")
if ll_id_doc>0 then
	openwithparm(w_packing_list_rpt, ll_id_doc)
else
	messagebox("Errore", "Packing List non trovata")
end if
end event

type cb_inserisci from commandbutton within w_packing_list_cx
int X=2775
int Y=24
int Width=247
int Height=108
int TabOrder=30
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_riga
ll_riga=wf_inserisci_riga()
dw_2.scrolltorow(ll_riga)
end event

type cb_salva from commandbutton within w_packing_list_cx
int X=3063
int Y=24
int Width=247
int Height=108
int TabOrder=20
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_righe
integer li_to, li_from

ll_righe=dw_2.rowcount()
li_from=dw_2.getitemnumber(ll_righe, "from")
li_to=dw_2.getitemnumber(ll_righe, "to")
do while mod(ll_righe, 10)<>0 
	ll_righe=wf_inserisci_riga()
	dw_2.setitem(ll_righe, "from", li_from)
	dw_2.setitem(ll_righe, "to", li_to)
loop
if dw_1.update()=1 then
	if dw_2.update()=1 then
		commit;
	else
		rollback;
	end if
else
	rollback;
end if
end event

type dw_2 from u_dw_ext_main within w_packing_list_cx
int X=18
int Y=992
int Width=3593
int Height=912
int TabOrder=70
string DataObject="d_pack_r"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_insert;call super::ue_insert;
end event

event getfocus;call super::getfocus;idw_fuoco=this
end event

event clicked;call super::clicked;integer li_ret
decimal ld_lunghezza, ld_larghezza, ld_altezza
if dwo.name='p_ricopia' then
	li_ret=messagebox("Attenzione!", "Si è richiesto di ricopiare in basso i valori della riga corrente~r~n"&
					+"Gli eventuali valori già esistenti nelle righe sottaostanti saranno sostituiti:~r~n"&
					+"Continuare?", stopsign!, yesno!)
	if li_ret=1 then
		dw_2.Object.datawindow.Pointer = 'hourglass!'
		ld_lunghezza=getitemdecimal(row, "lunghezza")
		ld_larghezza=getitemdecimal(row, "larghezza")
		ld_altezza=getitemdecimal(row, "altezza")
		for li_ret=row to rowcount()
			setitem(li_ret, "lunghezza", ld_lunghezza)
			setitem(li_ret, "larghezza", ld_larghezza)
			setitem(li_ret, "altezza", ld_altezza)
		next
		dw_2.Object.datawindow.Pointer = 'Cross!'
	end if
end if
end event

event rbuttondown;integer li_ret, li_from, li_to, li_num_riga, li_riga_padre
li_ret=rowscopy(row, row,primary!, this, row+1, primary!)
if li_ret>0 then
	li_riga_padre=getitemnumber(row, "num_riga_padre")
	if isnull(li_riga_padre) then	
		li_riga_padre=getitemnumber(row, "num_riga")
	end if
	scrolltorow(row+1)
	li_num_riga=getitemnumber(1, "max_num_riga")
	setitem(row+1, "num_riga", li_num_riga+1)
	SETITEM(ROW+1, "num_riga_padre", li_riga_padre)
	
	
	
	li_from=getitemnumber(row, "from")
	li_to=getitemnumber(row, "to")
	if li_from >0 then
	
		setitem(ROW+1, "from", li_from+1)
		setitem(ROW+1, "to", li_from+1)
	end if
		
		
		
	
	
else
	messagebox("Errore!", "Riga non copiata!")
end if

end event

event rowfocuschanged;setrowfocusindicator(Hand! )
end event

event itemchanged;integer li_num_riga_padre
decimal ld_peso_padre, ld_peso_figlio
long ll_qta, ll_qta_new ,ll_riga_padre

choose case dwo.name
	CASE "qta"
		
		li_num_riga_padre=getitemnumber(row, "num_riga_padre") 
		if li_num_riga_padre>0 then 
			ll_riga_padre=find("num_riga= "+string(li_num_riga_padre), 1, rowcount())
			ll_qta=	getitemnumber(ll_riga_padre, "qta")	
			ld_peso_padre=getitemdecimal(ll_riga_padre, "peso_netto")
			if isnull(data) then data='0'
			ll_qta_new= ll_qta - long(data) 
			ld_peso_figlio=ld_peso_padre/ll_qta*long(data) 
			ld_peso_padre=ld_peso_padre/ll_qta*ll_qta_new 
			setitem(ll_riga_padre, "qta", ll_qta_new)
			setitem(ll_riga_padre, "peso_netto", ld_peso_padre)
			setitem(row, "peso_netto", ld_peso_figlio)
		end if
END CHOOSE

		
end event

type dw_1 from u_dw_ext_main within w_packing_list_cx
int X=18
int Y=144
int Width=3593
int Height=824
int TabOrder=60
string DataObject="d_pack"
boolean HScrollBar=true
end type

event getfocus;call super::getfocus;idw_fuoco=this
end event

