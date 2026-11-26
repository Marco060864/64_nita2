forward
global type w_stampa_pag_bollato_cx from Window
end type
type rb_1 from radiobutton within w_stampa_pag_bollato_cx
end type
type cb_1 from commandbutton within w_stampa_pag_bollato_cx
end type
type cb_annulla from commandbutton within w_stampa_pag_bollato_cx
end type
type dw_stampa_pag_bollato_ff from u_dw_ext_main within w_stampa_pag_bollato_cx
end type
end forward

global type w_stampa_pag_bollato_cx from Window
int X=832
int Y=360
int Width=1929
int Height=872
boolean TitleBar=true
string Title="Stampa Pagine Bollato"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
rb_1 rb_1
cb_1 cb_1
cb_annulla cb_annulla
dw_stampa_pag_bollato_ff dw_stampa_pag_bollato_ff
end type
global w_stampa_pag_bollato_cx w_stampa_pag_bollato_cx

type variables
boolean lb_trovato
long il_id_esercizio,il_pag_prep, il_id_reg
string is_tipo_reg
end variables

on w_stampa_pag_bollato_cx.create
this.rb_1=create rb_1
this.cb_1=create cb_1
this.cb_annulla=create cb_annulla
this.dw_stampa_pag_bollato_ff=create dw_stampa_pag_bollato_ff
this.Control[]={this.rb_1,&
this.cb_1,&
this.cb_annulla,&
this.dw_stampa_pag_bollato_ff}
end on

on w_stampa_pag_bollato_cx.destroy
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.cb_annulla)
destroy(this.dw_stampa_pag_bollato_ff)
end on

event open;datawindowchild ldw_attivita, ldw_esercizio, ldw_mod

dw_stampa_pag_bollato_ff.getchild("id_attivita",ldw_attivita)
ldw_attivita.settransobject(sqlca)
ldw_attivita.retrieve()


dw_stampa_pag_bollato_ff.getchild("id_esercizio",ldw_esercizio)
ldw_esercizio.settransobject(sqlca)
ldw_esercizio.retrieve()

dw_stampa_pag_bollato_ff.getchild("tipo",ldw_mod)
ldw_mod.settransobject(sqlca)
ldw_mod.retrieve()

dw_stampa_pag_bollato_ff.insertrow(1)

end event

type rb_1 from radiobutton within w_stampa_pag_bollato_cx
int X=1106
int Y=24
int Width=434
int Height=76
string Text="Stampa a 80 col:"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_stampa_pag_bollato_cx
int X=1600
int Y=16
int Width=247
int Height=84
int TabOrder=30
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_num_pag,i,li_pag_stampate,li_anno,li_risposta, li_id_at, li_da_pag, li_x
string ls_num_pag,ls_val,ls_tipo, ls_na_pag, ls_nda_pag, ls_tipo_reg
long job

li_x = 2
li_num_pag=dw_stampa_pag_bollato_ff.getitemnumber(1,"num_pag")
li_da_pag= dw_stampa_pag_bollato_ff.getitemnumber(1,"da_pag")

IF li_num_pag >= li_da_pag THEN

	li_id_at = dw_stampa_pag_bollato_ff.getitemnumber(1,"id_attivita")
	ls_tipo_reg= dw_stampa_pag_bollato_ff.getitemstring(1,"tipo")
	il_id_reg = dw_stampa_pag_bollato_ff.getitemnumber(1,"id_registro")
	
	
	
	select descrizione
	into :is_tipo_reg
	from registro
	where id_registro=:il_id_reg;
	
		
	select data_inizio
	into :ls_val
	from esercizio
	where id_esercizio = : il_id_esercizio;
	
	if li_num_pag>0 then
	
		li_pag_stampate=dw_stampa_pag_bollato_ff.getitemnumber(1,"pag_prep")
		li_anno=integer(mid(ls_val,1,4))
		datastore lds_stampa
		lds_stampa=create datastore
		if rb_1.Checked = TRUE then
			lds_stampa.dataobject="d_stampa_pag_bollato2_rpt"
		else	
			lds_stampa.dataobject="d_stampa_pag_bollato_rpt"
		end if	
		lds_stampa.settransobject(sqlca)
		lds_stampa.retrieve()
		
		
		
			ls_num_pag=string(li_da_pag)	+"/"+string(li_anno) 
		ls_na_pag=string(li_num_pag)+"/"+string(li_anno)
		ls_nda_pag=string(li_da_pag)	+"/"+string(li_anno)
		
		lds_stampa.setitem(lds_stampa.rowcount(),"cn_pag",ls_num_pag)
		lds_stampa.setitem(lds_stampa.rowcount(),"t_reg", is_tipo_reg)
		lds_stampa.setitem(lds_stampa.rowcount(),"a_pag",li_num_pag)
		lds_stampa.setitem(lds_stampa.rowcount(),"Na_pag",ls_na_pag)
		lds_stampa.setitem(lds_stampa.rowcount(),"nda_pag",ls_nda_pag)
		lds_stampa.setitem(lds_stampa.rowcount(),"pag_prep",(li_pag_stampate+1))
		
		for i=(li_da_pag + 1) to li_num_pag 
			
			
			
				ls_num_pag=string(li_da_pag - 1 + li_x)	+"/"+string(li_anno)  
			
			lds_stampa.rowscopy(1,1,primary!,lds_stampa,9999999,primary!)
			lds_stampa.setitem(lds_stampa.rowcount(),"cn_pag",ls_num_pag)
			lds_stampa.setitem(lds_stampa.rowcount(),"t_reg", is_tipo_reg)
			lds_stampa.setitem(lds_stampa.rowcount(),"a_pag",li_num_pag)
			lds_stampa.setitem(lds_stampa.rowcount(),"Na_pag",ls_na_pag)
			lds_stampa.setitem(lds_stampa.rowcount(),"nda_pag",ls_nda_pag)
			lds_stampa.setitem(lds_stampa.rowcount(),"pag_prep",(li_pag_stampate+1))
			
						li_x++
		next
		
		
		

		
		openwithparm(w_or_st_pag_bollato_rpt, lds_stampa) 
		
		
		
		
		
		
			
		li_risposta=messagebox("Esito Stampa","La stampa è andata a buon fine?",information!,yesno!)
		if li_risposta=1 then
			ls_tipo=dw_stampa_pag_bollato_ff.getitemstring(1,"tipo")
			if lb_trovato=true then

				
			update contatori_bollati
				set pagine_prep=:li_num_pag
				where tipo=:ls_tipo
				and id_esercizio=:il_id_esercizio
				and id_registro = :il_id_reg;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Errore!","Contatori Bollati non aggiornati!")
			end if
			else
				insert into contatori_bollati
				(tipo,pagine_prep,anno,id_esercizio,pagine_usate, id_attivita, id_registro)
				values (:ls_tipo,:li_num_pag,:li_anno,:il_id_esercizio,0, :li_id_at, :il_id_reg);
				if sqlca.sqlcode=0 then
					commit;
				else
					rollback;
					messagebox("Errore!","Contatori Bollati non inseriti!")
				end if
			end if
		end if
		destroy lds_stampa
	end if
ELSE
	MESSAGEBOX ('Attenzione', 'Il numero di pagine richiesto non è corretto, verificare?')
END IF
end event

type cb_annulla from commandbutton within w_stampa_pag_bollato_cx
int X=41
int Y=20
int Width=247
int Height=84
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_stampa_pag_bollato_ff from u_dw_ext_main within w_stampa_pag_bollato_cx
event type integer ue_tipo_reg ( )
int X=41
int Y=132
int Width=1806
int Height=596
int TabOrder=10
string DataObject="d_stampa_pag_bollato_ff"
end type

event ue_tipo_reg;

long						ll_ret,ll_num,ll_id_attivita, ll_id_registro
datawindowchild		ldw_child,ldw_des

SetNull(ll_num)

this.AcceptText()
ll_id_attivita=this.getitemnumber(1,"id_attivita")
is_tipo_reg= this.getitemstring(1,"tipo")
il_id_esercizio=this.getitemnumber(1,"id_esercizio")
this.GetChild("id_registro", ldw_child)
this.SetItem( this.GetRow(),"id_registro",ll_num )
ldw_child.SetTransObject(SQLCA)
ldw_child.Retrieve(is_tipo_reg, il_id_esercizio,ll_id_attivita)
ldw_des.SetTransObject(SQLCA)
ldw_des.Retrieve(is_tipo_reg, il_id_esercizio,ll_id_attivita)
return 0
end event

event itemchanged;

integer pag_prep,pag_usate,li_anno,li_num_pag,li_ritorno, li_pag_us
string ls_val,ls_tipo
il_id_esercizio=dw_stampa_pag_bollato_ff.getitemnumber(1,"id_esercizio")
ls_val=dw_stampa_pag_bollato_ff.getitemstring(1,"val_esercizio")
is_tipo_reg=dw_stampa_pag_bollato_ff.getitemstring(1,"tipo")
il_id_reg=dw_stampa_pag_bollato_ff.getitemnumber(1,"id_registro")

li_anno=integer(mid(ls_val,7,4))
if dwo.name="id_registro" then
	
	select pagine_prep,pagine_usate
	into :pag_prep,:pag_usate
	from contatori_bollati
	where tipo=:is_tipo_reg
	and id_esercizio=:il_id_esercizio
	and id_registro = :data;
	
	if sqlca.sqlcode=0 then
		lb_trovato=true
		dw_stampa_pag_bollato_ff.setitem(1,"pag_prep",pag_prep)
		dw_stampa_pag_bollato_ff.setitem(1,"pag_usate",pag_usate)
		il_pag_prep=pag_prep
	else
		lb_trovato=false
		dw_stampa_pag_bollato_ff.setitem(1,"pag_prep",0)
		dw_stampa_pag_bollato_ff.setitem(1,"pag_usate",0)
	end if
elseif dwo.name="pag_prep" then
	li_num_pag=dw_stampa_pag_bollato_ff.getitemnumber(1,"pag_prep")
	if not isnull(li_num_pag) then
		li_ritorno=messagebox("Informazione","Vuoi cambiare il numero di pagine stampate da "+string(li_num_pag)+&
		" a "+string(data),information!,yesno!)
		if li_ritorno=1 then
			ls_tipo=dw_stampa_pag_bollato_ff.getitemstring(1,"tipo")
			li_num_pag=integer(data)
			select pagine_prep,pagine_usate
			into :pag_prep,:pag_usate
			from contatori_bollati
			where tipo=:ls_tipo
			and id_esercizio=:il_id_esercizio
			and id_registro =  :il_id_reg;
			if sqlca.sqlcode=0 then
				update contatori_bollati
				set pagine_prep=:li_num_pag
				where tipo=:ls_tipo
				and id_esercizio=:il_id_esercizio
				and id_registro =  :il_id_reg;
			else
				insert into contatori_bollati
				(tipo,pagine_prep,anno,id_esercizio,pagine_usate, id_registro)
				values (:ls_tipo,:li_num_pag,:li_anno,:il_id_esercizio,0, :il_id_reg);
			end if
		end if
	end if
elseif dwo.name="pag_usate" then
	li_pag_us=dw_stampa_pag_bollato_ff.getitemnumber(1,"pag_usate")
	if not isnull(li_pag_us) then
		li_ritorno=messagebox("Informazione","Vuoi cambiare il numero di pagine usate da "+string(li_pag_us)+&
		" a "+string(data),information!,yesno!)
		if li_ritorno=1 then
			ls_tipo=dw_stampa_pag_bollato_ff.getitemstring(1,"tipo")
			li_pag_us=integer(data)
			select pagine_prep,pagine_usate
			into :pag_prep,:pag_usate
			from contatori_bollati
			where tipo=:ls_tipo
			and id_esercizio=:il_id_esercizio
			and id_registro =  :il_id_reg;
		
			if sqlca.sqlcode=0 then
				update contatori_bollati
				set pagine_usate=:li_pag_us
				where tipo=:ls_tipo
				and id_esercizio=:il_id_esercizio
				and id_registro =:il_id_reg;
			else
				insert into contatori_bollati
							 (tipo,pagine_prep,anno,id_esercizio,pagine_usate, id_registro)
					values (:ls_tipo,:li_num_pag,:li_anno,:il_id_esercizio,0, :il_id_reg);
			end if
		end if
	end if
	
end if


end event

event itemfocuschanged;call super::itemfocuschanged;	integer li_pag_stampate

IF dwo.name = "id_registro" THEN
		THIS.TriggerEvent("ue_tipo_reg")
ELSEIF dwo.name = "pag_prep" THEN
	li_pag_stampate=dw_stampa_pag_bollato_ff.getitemnumber(1,"pag_prep")
	li_pag_stampate ++
	dw_stampa_pag_bollato_ff.setitem(1,"da_pag", li_pag_stampate)
ELSEIF dwo.name = "da_pag" THEN
	li_pag_stampate=dw_stampa_pag_bollato_ff.getitemnumber(1,"pag_prep")
	li_pag_stampate ++
	dw_stampa_pag_bollato_ff.setitem(1,"da_pag", li_pag_stampate)
		
END IF

end event

