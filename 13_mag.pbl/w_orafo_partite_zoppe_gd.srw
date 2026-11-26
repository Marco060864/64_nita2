forward
global type w_orafo_partite_zoppe_gd from Window
end type
type cb_2 from commandbutton within w_orafo_partite_zoppe_gd
end type
type cb_1 from commandbutton within w_orafo_partite_zoppe_gd
end type
type dw_single from datawindow within w_orafo_partite_zoppe_gd
end type
end forward

global type w_orafo_partite_zoppe_gd from Window
int X=321
int Y=349
int Width=2876
int Height=989
boolean TitleBar=true
string Title="Gestione Partite"
long BackColor=79741120
WindowType WindowType=response!
event ue_post_open ( )
cb_2 cb_2
cb_1 cb_1
dw_single dw_single
end type
global w_orafo_partite_zoppe_gd w_orafo_partite_zoppe_gd

type variables
s_partite_zoppe  s_par_zoppe

end variables

forward prototypes
public subroutine wf_qta_selezionata (long row)
end prototypes

event ue_post_open;
long ll_id_metallo
s_par_zoppe=message.powerobjectparm
select id_metallo 
into :ll_id_metallo
from orafo_titolo
where id_titolo=:s_par_zoppe.s_ll_id_titolo;


dw_single.settrans(sqlca)
dw_single.retrieve(s_par_zoppe.s_ll_id_sog_comm, s_par_zoppe.s_ll_id_titolo, ll_id_metallo)
end event

public subroutine wf_qta_selezionata (long row);long  ll_id_partita, ll_riga_trovata
integer li_ret
decimal{4} ld_qta_selezionata, ld_qta_da_scaricare
string ls_trova

	if row > 0 then
		
		dw_single.SelectRow(Row, NOT dw_single.IsSelected(Row))
		
		
		if dw_single.IsSelected(Row) then
			ld_qta_selezionata = dw_single.getitemdecimal(row, "fino_residuo")
			
			
			
			
			
			
			
			dw_single.setitem(row, "qta_da_scaricare", ld_qta_selezionata)
			
			ld_qta_da_scaricare=dw_single.getitemdecimal(row, "val_scarico")
			
			if ld_qta_da_scaricare<0 then 
				messagebox("Errore!", "Lo scarico è negativo! Nessuna operazione completata!")
				return
			end if
			
			if isnull(ld_qta_da_scaricare) then ld_qta_da_scaricare=0
			
			
		else
			ld_qta_selezionata=dw_single.getitemdecimal(row, "qta_da_scaricare")
			dw_single.setitem(row, "qta_da_scaricare", 0)
			
			
			
			
			
		end if
	end if

end subroutine

on w_orafo_partite_zoppe_gd.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_single=create dw_single
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_single}
end on

on w_orafo_partite_zoppe_gd.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_single)
end on

event open;

post event ue_post_open()
end event

type cb_2 from commandbutton within w_orafo_partite_zoppe_gd
int X=435
int Y=781
int Width=375
int Height=109
int TabOrder=3
string Text="Non Scaricare"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
closewithreturn(parent, s_par_zoppe)
end event

type cb_1 from commandbutton within w_orafo_partite_zoppe_gd
int X=23
int Y=781
int Width=375
int Height=109
int TabOrder=20
string Text="Scarica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer i, li_ret
long ll_id_doc, ll_id_titolo, ll_id_partita_sorgente, ll_id_partita, ll_id_riga_doc
long ld_val_scarico_a
string ls_stato='A'
decimal{2} ld_val_sorgente, ld_val_aper, ld_val_scarico
for i = 1 to dw_single.rowcount()
	
	if dw_single.isselected(i) then
		
		ll_id_doc=dw_single.getitemnumber(i, "id_documento")
		ll_id_titolo=dw_single.getitemnumber(i, "id_titolo")
		ll_id_partita_sorgente=dw_single.getitemnumber(i, "id_partita")
		ld_val_scarico=dw_single.getitemdecimal(i, "val_scarico")
		
		if ld_val_scarico > s_par_zoppe.s_qta_da_scaricare then
			
			li_ret=messagebox("Attenzione!", "Quantità impostata insufficiente!~r~n"+&
			"Impostare automaticamente la quantità necessaria?", stopsign!, yesno!)
			
			if li_ret=1 then
				s_par_zoppe.s_qta_da_scaricare=ld_val_scarico*1000/s_par_zoppe.s_ld_coef_calo
				s_par_zoppe.s_flag=1
				update orafo_aper_partita
				set val_apertura = :ld_val_scarico, stato='C'
				where id_documento=:s_par_zoppe.s_ll_id_doc
				and id_titolo=:ll_id_titolo;
			else
				s_par_zoppe.s_flag=-1
				closewithreturn(parent, s_par_zoppe)
			end if
		
		end if
		
		
		
		update orafo_aper_partita
		set val_scarico= :ld_val_scarico
		where id_documento=:s_par_zoppe.s_ll_id_doc
		and id_titolo=:ll_id_titolo;
		if sqlca.sqlcode<>0 then
			Messagebox("Errore!", "Non salvato scarico")
			return
		end if
		
		select id_partita
		into :ll_id_partita
		from orafo_aper_partita
		where id_documento=:s_par_zoppe.s_ll_id_doc
		and id_titolo=:ll_id_titolo;
		if sqlca.sqlcode<>0 then
			Messagebox("Errore!", "Non trovato id_partita")
			return
		end if
		
		if sqlca.sqlcode=0 then
			declare reindirizza_scarichi cursor for
			select val_scarico, id_riga_documento
			from orafo_scar_partita
			where id_partita=:ll_id_partita_sorgente;
			open reindirizza_scarichi;
			fetch reindirizza_scarichi into :ld_val_scarico,:ll_id_riga_doc;
			do while sqlca.sqlcode=0
				select val_scarico
				into :ld_val_scarico_a
				from orafo_scar_partita
				where id_partita=:ll_id_partita
				and id_riga_documento=:ll_id_riga_doc;
				if not isnull(ld_val_scarico_a) and ld_val_scarico_a > 0 then
					
					
					
					
					ld_val_scarico+=ld_val_scarico_a
					ld_val_scarico_a=0
					update orafo_scar_partita
					set val_scarico=  :ld_val_scarico
					where id_partita=:ll_id_partita
					and id_riga_documento=:ll_id_riga_doc;
				else 
					
					
					update orafo_scar_partita
					set id_partita= :ll_id_partita
					where id_partita=:ll_id_partita_sorgente
					and id_riga_documento=:ll_id_riga_doc;
					if sqlca.sqlcode<>0 then							
						messagebox("reindirizzo scarichi", "fallito!")
						li_ret=-1
					end if
				end if
				fetch reindirizza_scarichi into :ld_val_scarico, :ll_id_riga_doc;
			loop
			close reindirizza_scarichi;
			if li_ret<>-1 then
				delete from orafo_scar_partita
				where id_partita=:ll_id_partita_sorgente;
				if sqlca.sqlcode<>0 then
					messagebox("reindirizzo scarichi", "fallita cancellazione scarichi zoppi!")
				end if
				delete from orafo_aper_partita
				where id_partita=:ll_id_partita_sorgente;
				if sqlca.sqlcode<>0 then
					messagebox("reindirizzo scarichi", "fallita cancellazione apertura zoppi!")
				end if
			end if
				
		end if
	end if
next
closewithreturn(parent, s_par_zoppe)






end event

type dw_single from datawindow within w_orafo_partite_zoppe_gd
int X=23
int Y=41
int Width=2812
int Height=721
int TabOrder=10
string DataObject="d_orafo_partite_zoppe_tb"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event clicked;
wf_qta_selezionata(row)
end event

