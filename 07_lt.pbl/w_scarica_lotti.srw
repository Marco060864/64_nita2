forward
global type w_scarica_lotti from Window
end type
type st_2 from statictext within w_scarica_lotti
end type
type st_selezionata from statictext within w_scarica_lotti
end type
type st_da_scaricare from statictext within w_scarica_lotti
end type
type st_1 from statictext within w_scarica_lotti
end type
type cb_annulla from commandbutton within w_scarica_lotti
end type
type cb_ok from commandbutton within w_scarica_lotti
end type
type dw_scarica_lotti from datawindow within w_scarica_lotti
end type
end forward

global type w_scarica_lotti from Window
int X=1065
int Y=484
int Width=2528
int Height=976
boolean TitleBar=true
string Title="Scarico Lotti"
long BackColor=79741120
WindowType WindowType=response!
st_2 st_2
st_selezionata st_selezionata
st_da_scaricare st_da_scaricare
st_1 st_1
cb_annulla cb_annulla
cb_ok cb_ok
dw_scarica_lotti dw_scarica_lotti
end type
global w_scarica_lotti w_scarica_lotti

type variables
s_ges_lotti s_lotti
char ic_tipo_ges_lotti
string is_tipo_mov
end variables

forward prototypes
public subroutine wf_ripristina_scarico (long al_row, long al_id_lotto, decimal ad_qta_attuale, datawindow adw_dw)
end prototypes

public subroutine wf_ripristina_scarico (long al_row, long al_id_lotto, decimal ad_qta_attuale, datawindow adw_dw);integer li_up_lotti, i, a, b=0
decimal ld_qta_scar_orig[], ld_qta_sel
long ll_id_lotto[]
li_up_lotti=UpperBound(s_lotti.s_id_lotti)

decimal {4} ld_peso_scar_orig[], ld_peso_sel

choose case dw_scarica_lotti.dataobject
	case "ds_cerca_lotti"
		for i = 1 to li_up_lotti
			adw_dw.modify("datawindow.color=79741120")		
			if s_lotti.s_id_lotti[i]=al_id_lotto then
				
				if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
					adw_dw.setitem(al_row, "peso_netto_scaricato", s_lotti.s_peso_scar_originale[i])
					s_lotti.s_peso_da_scaricare +=(ad_qta_attuale - s_lotti.s_peso_scar_originale[i])
					setnull(s_lotti.s_peso_scar_originale[i])
				
				else
					adw_dw.setitem(al_row, "qta_scaricata", s_lotti.s_qta_scar_originale[i])
					s_lotti.s_qta_da_scaricare +=(ad_qta_attuale - s_lotti.s_qta_scar_originale[i])
					setnull(s_lotti.s_qta_scar_originale[i])
				end if
				setnull(s_lotti.s_id_lotti[i])
				
				
				for a= 1 to li_up_lotti
					if not isnull(s_lotti.s_id_lotti[a]) then
						b++
						
						if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
							ld_peso_scar_orig[b]=s_lotti.s_peso_scar_originale[a]
						
						else
							ld_qta_scar_orig[b]=s_lotti.s_qta_scar_originale[a]
						end if
						ll_id_lotto[b]=s_lotti.s_id_lotti[a] 
					end if
				next
				
				if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then				
					s_lotti.s_peso_scar_originale=ld_peso_scar_orig
					ld_peso_sel=dec(st_da_scaricare.text) - s_lotti.s_peso_da_scaricare
					st_selezionata.Text=string(ld_peso_sel)
				
				else
					s_lotti.s_qta_scar_originale=ld_qta_scar_orig
					ld_qta_sel=dec(st_da_scaricare.text) - s_lotti.s_qta_da_scaricare
					st_selezionata.Text=string(ld_qta_sel)
				end if
				
				s_lotti.s_id_lotti=ll_id_lotto
				
				exit
			end if
		next
	case "d_cerca_lotti_andata_ster_gd"
		for i = 1 to li_up_lotti
			adw_dw.modify("datawindow.color=79741120")		
			if s_lotti.s_id_lotti[i]=al_id_lotto then
				adw_dw.setitem(al_row, "qta_scaricata", s_lotti.s_qta_scar_originale[i])				
				setnull(s_lotti.s_qta_scar_originale[i])
				setnull(s_lotti.s_id_lotti[i])
				
				
				for a= 1 to li_up_lotti
					if not isnull(s_lotti.s_id_lotti[a]) then
						b++
						ld_qta_scar_orig[b]=s_lotti.s_qta_scar_originale[a]
						ll_id_lotto[b]=s_lotti.s_id_lotti[a]
					end if
				next
				s_lotti.s_id_lotti=ll_id_lotto
				exit
			end if
		next
end choose

end subroutine

on w_scarica_lotti.create
this.st_2=create st_2
this.st_selezionata=create st_selezionata
this.st_da_scaricare=create st_da_scaricare

this.st_1=create st_1
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_scarica_lotti=create dw_scarica_lotti
this.Control[]={this.st_2,&
this.st_selezionata,&
this.st_da_scaricare,&
this.st_1,&
this.cb_annulla,&
this.cb_ok,&
this.dw_scarica_lotti}
end on

on w_scarica_lotti.destroy
destroy(this.st_2)
destroy(this.st_selezionata)
destroy(this.st_da_scaricare)
destroy(this.st_1)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_scarica_lotti)
end on

event open;
integer li_ret

s_lotti=message.powerobjectparm
dw_scarica_lotti.dataobject=s_lotti.s_ds_lotti.dataobject

dw_scarica_lotti.settransobject(sqlca)

string ls_do1, ls_do2

ls_do1 = s_lotti.s_ds_lotti.dataobject
ls_do2 = dw_scarica_lotti.dataobject

li_ret = s_lotti.s_ds_lotti.RowCount()


li_ret = s_lotti.s_ds_lotti.RowsCopy(1,s_lotti.s_ds_lotti.RowCount(),Primary!,dw_scarica_lotti,1,Primary!)


li_ret = dw_scarica_lotti.RowCount()

decimal  {4} ldt_peso_scar_attuale

SELECT m.tipo
INTO   :is_tipo_mov
FROM   articolo a, unita_confezione u, unita_misura m
WHERE  a.id_articolo=:s_lotti.s_id_articolo
AND	 u.id_articolo = a.id_articolo
AND	 u.unita_base = 'S'
AND	 m.id_unita_misura =* u.id_unita_misura
;

SELECT tipo_ges_lotti
INTO	 :ic_tipo_ges_lotti
FROM	 pers_par_sistema
;

choose case dw_scarica_lotti.dataobject
	case "ds_cerca_lotti"	
		
		if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
			st_da_scaricare.text=string(s_lotti.s_peso_da_scaricare)
			st_1.text = 'Peso da scaricare:'
			st_2.text = 'Peso selezionato:'
		
		else
			st_da_scaricare.text=string(s_lotti.s_qta_da_scaricare)
		end if
		long i
		
		if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
			do while s_lotti.s_peso_da_scaricare>0 and i<dw_scarica_lotti.rowcount() 
				i++
				dw_scarica_lotti.trigger Event ue_post_open(i)
			loop
			if s_lotti.s_peso_da_scaricare>0 then
				li_ret=messagebox("Attenzione!","Impossibile scaricare il peso richiesto ..."+char(13)+&
								+"Proseguire scaricando il possibile o annullare?",Information!,OkCancel!)
				if li_ret=2 then cb_annulla.Post Event clicked()
				if li_ret=1 then
					s_lotti.s_flag_copia='SP'
					st_da_scaricare.text=st_selezionata.text
					s_lotti.s_peso_da_scaricare=0
				end if
			else
				
				if (dw_scarica_lotti.rowcount() = 1) then
					cb_ok.post event clicked()
				end if
			end if			
		
		else
			do while s_lotti.s_qta_da_scaricare>0 and i<dw_scarica_lotti.rowcount() 
				i++
				dw_scarica_lotti.trigger Event ue_post_open(i)
			loop
			if s_lotti.s_qta_da_scaricare>0 then
				li_ret=messagebox("Attenzione!","Impossibile scaricare la quantità richiesta..."+char(13)+&
								+"Proseguire scaricando il possibile o annullare?",Information!,OkCancel!)
				if li_ret=2 then cb_annulla.Post Event clicked()
				if li_ret=1 then
					s_lotti.s_flag_copia='SP'
					st_da_scaricare.text=st_selezionata.text
					s_lotti.s_qta_da_scaricare=0
				end if
			end if
		end if
	case "d_cerca_lotti_andata_ster_gd"
		
end choose
end event

type st_2 from statictext within w_scarica_lotti
int X=878
int Y=780
int Width=402
int Height=76
int TabOrder=40
boolean Enabled=false
string Text="Q.ta selezionata:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_selezionata from statictext within w_scarica_lotti
int X=1289
int Y=768
int Width=320
int Height=84
int TabOrder=50
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_da_scaricare from statictext within w_scarica_lotti
int X=485
int Y=772
int Width=320
int Height=84
int TabOrder=30
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_scarica_lotti
int X=46
int Y=780
int Width=430
int Height=76
int TabOrder=20
boolean Enabled=false
string Text="Q.ta da scaricare:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_annulla from commandbutton within w_scarica_lotti
int X=2176
int Y=756
int Width=270
int Height=108
int TabOrder=70
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_lotti.s_flag_copia='Annulla'
closewithreturn(parent, s_lotti)
end event

type cb_ok from commandbutton within w_scarica_lotti
int X=1824
int Y=756
int Width=238
int Height=108
int TabOrder=60
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_row, ll_id_lotto, ll_lotto_trovato
decimal ldt_qta_scar
integer li_ret

decimal ldt_peso_scar

ll_row= dw_scarica_lotti.getselectedrow(0)
if ll_row<1	then 
	cb_annulla.triggerevent(clicked!)
	return
end if
if st_selezionata.text<st_da_scaricare.text then
	li_ret=messagebox("Attenzione!","NON si è scaricata completamente la quantità impostata..."+char(13)+&
							+"Proseguire con uno scarico parziale?", Information!,YesNo!)
	if li_ret=2 then return
	if li_ret=1 then
		s_lotti.s_flag_copia='SP'
		st_da_scaricare.text=st_selezionata.text
	end if
end if
do while ll_row>0
	dw_scarica_lotti.selectrow(ll_row, false)
	ldt_qta_scar=dw_scarica_lotti.getitemdecimal(ll_row, "qta_scaricata")
	
	
	if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
		ldt_peso_scar=dw_scarica_lotti.getitemdecimal(ll_row, "peso_netto_scaricato")
	end if
	

	ll_id_lotto=dw_scarica_lotti.getitemnumber(ll_row, "id_lotto")
	ll_lotto_trovato=s_lotti.s_ds_lotti.find("id_lotto="+string(ll_id_lotto), 1, s_lotti.s_ds_lotti.rowcount())
	if ll_lotto_trovato>0 then
		s_lotti.s_ds_lotti.setitem(ll_lotto_trovato, "qta_scaricata", ldt_qta_scar)
		
		if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
			s_lotti.s_ds_lotti.setitem(ll_lotto_trovato, "peso_netto_scaricato", ldt_peso_scar)
		end if
		
	else
		messagebox("Errore", "id_lotto= "+string(ll_lotto_trovato)+" non trovato in s_lotti.s_ds_lotti")
	end if
	ll_row= dw_scarica_lotti.getselectedrow(0)
loop 
if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
	s_lotti.s_peso_da_scaricare=dec(st_selezionata.text)
else
	s_lotti.s_qta_da_scaricare=dec(st_selezionata.text)
end if

CloseWithReturn(parent, s_lotti)
end event

type dw_scarica_lotti from datawindow within w_scarica_lotti
event ue_post_open ( long al_row )
int X=18
int Y=28
int Width=2473
int Height=700
int TabOrder=10
string DataObject="ds_cerca_lotti"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_post_open;long i, ll_righe, ll_id_lotto
decimal {2} ld_qta_da_scaricare, ld_qta_in, ld_qta_scar, ld_qta_disp, ld_qta_scar_originale
boolean scaricato
integer li_up_lotti

decimal {4} ld_peso_da_scaricare, ld_peso_in, ld_peso_scar, ld_peso_disp, ld_peso_scar_originale


choose case this.dataobject
	case "ds_cerca_lotti"
		
		if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
			ld_peso_da_scaricare=s_lotti.s_peso_da_scaricare
			scaricato=false
			i=al_row
				ld_peso_in=getItemdecimal(i,"peso_netto_iniziale")
				ld_peso_scar_originale=getItemDecimal(i,"peso_netto_scaricato")
				if IsNull(ld_peso_scar_originale) then ld_peso_scar_originale=0
				ld_peso_disp=ld_peso_in - ld_peso_scar_originale
				
				ll_id_lotto=GetItemNumber(i,"id_lotto")
				
				if ld_peso_disp >= ld_peso_da_scaricare then
					scaricato=true
					ld_peso_scar=ld_peso_scar_originale+ld_peso_da_scaricare
					ld_peso_da_scaricare=0
				else
					ld_peso_da_scaricare=ld_peso_da_scaricare - ld_peso_disp
					ld_peso_scar=ld_peso_in
				end if
				SelectRow(i,true)
				SetItem(i,"peso_netto_scaricato",ld_peso_scar)
				li_up_lotti=UpperBound(s_lotti.s_id_lotti)
				s_lotti.s_id_lotti[li_up_lotti+1]=ll_id_lotto
				s_lotti.s_peso_scar_originale[li_up_lotti+1]=ld_peso_scar_originale
				s_lotti.s_peso_da_scaricare=ld_peso_da_scaricare			
		
		else
			ld_qta_da_scaricare=s_lotti.s_qta_da_scaricare
			scaricato=false
			i=al_row
				ld_qta_in=getItemdecimal(i,"qta_iniziale")
				ld_qta_scar_originale=getItemDecimal(i,"qta_scaricata")
				if IsNull(ld_qta_scar_originale) then ld_qta_scar_originale=0
				ld_qta_disp=ld_qta_in - ld_qta_scar_originale
				
				ll_id_lotto=GetItemNumber(i,"id_lotto")
				
				if ld_qta_disp>=ld_qta_da_scaricare then
					scaricato=true
					ld_qta_scar=ld_qta_scar_originale+ld_qta_da_scaricare
					ld_qta_da_scaricare=0
				else
					ld_qta_da_scaricare=ld_qta_da_scaricare - ld_qta_disp
					ld_qta_scar=ld_qta_in
				end if
				SelectRow(i,true)
				SetItem(i,"qta_scaricata",ld_qta_scar)
				li_up_lotti=UpperBound(s_lotti.s_id_lotti)
				s_lotti.s_id_lotti[li_up_lotti+1]=ll_id_lotto
				s_lotti.s_qta_scar_originale[li_up_lotti+1]=ld_qta_scar_originale
				s_lotti.s_qta_da_scaricare=ld_qta_da_scaricare
		end if
		
		if scaricato then
			dw_scarica_lotti.modify("datawindow.color=10140531")
			s_lotti.s_flag_copia='Ok'
		else
		
		
		
			
			dw_scarica_lotti.modify("datawindow.color=79741120")		
			s_lotti.s_flag_copia='SP' 
		
		
		
		
		end if
		
		
		if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
			ld_peso_disp=Dec(st_da_scaricare.text) - ld_peso_da_scaricare
			st_selezionata.text=string(ld_peso_disp)
		
		else		
			ld_qta_disp=Dec(st_da_scaricare.text) - ld_qta_da_scaricare
			st_selezionata.text=string(ld_qta_disp)
		end if
		
		
	case "d_cerca_lotti_andata_ster_gd"
		i=al_row
		SelectRow(i,true)
		ll_id_lotto=GetItemNumber(i,"id_lotto")
		li_up_lotti=UpperBound(s_lotti.s_id_lotti)
		s_lotti.s_id_lotti[li_up_lotti+1]=ll_id_lotto
				
		ld_qta_in=getItemdecimal(i,"qta_iniziale")		
		
		ld_qta_scar_originale=getItemDecimal(i,"qta_scaricata")
		
		SetItem(i,"qta_scaricata",ld_qta_in)		
		if IsNull(ld_qta_scar_originale) then ld_qta_scar_originale=0
		
		s_lotti.s_qta_scar_originale[li_up_lotti+1]=ld_qta_scar_originale
		s_lotti.s_flag_copia='Ok'		
end choose
end event

event clicked;decimal ld_qta_attuale
long ll_id_lotto
choose case this.dataobject
	case "ds_cerca_lotti"
		if row>0 then
			if not isselected(row) then
				
				if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
					if s_lotti.s_peso_da_scaricare>0 then trigger event ue_post_open(row)
				else
				
					if s_lotti.s_qta_da_scaricare>0 then trigger event ue_post_open(row)
				end if
			else
				ll_id_lotto=getitemnumber(row, "id_lotto")
				
				if (ic_tipo_ges_lotti = 'G' and is_tipo_mov = 'P') then
					ld_qta_attuale=getitemdecimal(row, "peso_netto_scaricato")
				
				else				
					ld_qta_attuale=getitemdecimal(row, "qta_scaricata")
				end if
				wf_ripristina_scarico(row, ll_id_lotto, ld_qta_attuale, this)
				selectrow(row, false)
			end if
		end if
	case "d_cerca_lotti_andata_ster_gd"
		if row>0 then
			if not isselected(row) then
				trigger event ue_post_open(row)
			else
				ll_id_lotto=getitemnumber(row, "id_lotto")
				ld_qta_attuale=getitemdecimal(row, "qta_scaricata")				
				wf_ripristina_scarico(row, ll_id_lotto, ld_qta_attuale, this)
				selectrow(row, false)
			end if
		end if
end choose
end event

