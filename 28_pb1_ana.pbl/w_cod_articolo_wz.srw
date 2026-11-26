forward
global type w_cod_articolo_wz from w_wiz_main
end type
type st_cod_parte from statictext within w_cod_articolo_wz
end type
type dw_cat_codifica_ext_ff from u_dw_ext_main within w_cod_articolo_wz
end type
type dw_cod_articolo_ext_ff from u_dw_ext_main within w_cod_articolo_wz
end type
type cb_annulla from commandbutton within w_cod_articolo_wz
end type
type cb_ok from commandbutton within w_cod_articolo_wz
end type
end forward

global type w_cod_articolo_wz from w_wiz_main
int X=834
int Y=374
int Width=2575
int Height=1194
WindowType WindowType=response!
boolean TitleBar=true
string Title="Codice Articolo"
event ue_load_parte ( )
event ue_empty_parte ( )
st_cod_parte st_cod_parte
dw_cat_codifica_ext_ff dw_cat_codifica_ext_ff
dw_cod_articolo_ext_ff dw_cod_articolo_ext_ff
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_cod_articolo_wz w_cod_articolo_wz

type variables
s_any_array 	istr_array
string		is_cur_column, is_last_column
long		il_cur_row, il_last_row
boolean		ib_fill
decimal		idc_w_color
boolean		ib_esiste_progr
s_cod_parte 	istr_cod_parte[]
end variables

forward prototypes
public function long uf_setta_cod_parte (s_cod_parte astr_cod_parte)
public function string uf_fill_cod_parte (integer al_row, string as_cod_rimanente)
public function string uf_get_des_scelta (string as_codice)
public function string uf_val_cod_parte (integer al_row, ref string as_err_message, ref long al_err_code)
public function string uf_val_codice ()
end prototypes

event ue_load_parte;
long 				ll_id_cat_codifica, ll_row, ll_counter, ll_parte_row
s_cod_parte 	lstr_cod_parte
string			ls_cod_rimanente

f_displayonly(dw_cod_articolo_ext_ff, "num_sezione",FALSE)
ll_row= dw_cat_codifica_ext_ff.GetRow()
TriggerEvent("ue_empty_parte")
dw_cod_articolo_ext_ff.SetRedraw(FALSE)
ll_id_cat_codifica= dw_cat_codifica_ext_ff.GetItemNumber(ll_row, "id_cat_codifica")
 DECLARE lcur_cod_parte CURSOR FOR  
  SELECT "cod_parte"."id_cod_parte",   
         "parte_regola"."descrizione",   
         "parte_regola"."lunghezza",   
         "parte_regola"."progressivo",   
         "parte_regola"."variante",   
         "parte_regola"."num_sezione",   
         "cod_parte"."mas_input",   
         "cod_parte"."tipo_richiesta",   
         "cod_parte"."val_proposto",   
         "cod_parte"."car_riempimento",   
         "cod_parte"."solo_in_elenco"  
    FROM "dba"."cod_parte",   
         "dba"."parte_regola"  
   WHERE ( "parte_regola"."id_parte_regola" = "cod_parte"."id_parte_regola" ) and  
         ( ( "cod_parte"."id_cat_codifica" = :ll_id_cat_codifica ) )   
ORDER BY "parte_regola"."num_sezione" ASC  ;
OPEN lcur_cod_parte;
ib_esiste_progr=FALSE
ll_counter=0
do while sqlca.sqlcode = 0
	FETCH lcur_cod_parte into :lstr_cod_parte.l_id_cod_parte, :lstr_cod_parte.s_descrizione, :lstr_cod_parte.l_lunghezza, :lstr_cod_parte.s_progressivo, :lstr_cod_parte.s_variante, :lstr_cod_parte.l_num_sezione, :lstr_cod_parte.s_mas_input,:lstr_cod_parte.s_tipo_richiesta, :lstr_cod_parte.s_val_proposto, :lstr_cod_parte.s_car_riempimento, :lstr_cod_parte.s_solo_in_elenco;
	If sqlca.sqlcode = 0 then 
		ll_counter++
		istr_cod_parte[ll_counter]= lstr_cod_parte
		ll_parte_row=uf_setta_cod_parte(lstr_cod_parte)
		if ib_fill then ls_cod_rimanente= uf_Fill_Cod_Parte(ll_parte_row, istr_array.s_array[ll_counter + 1])
	end if
loop 
if sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
end if
CLOSE lcur_cod_parte;
dw_cod_articolo_ext_ff.SetRedraw(TRUE)
if ll_parte_row>0 then dw_cod_articolo_ext_ff.ScrollToRow(1)
f_displayonly(dw_cod_articolo_ext_ff, "num_sezione",TRUE)
dw_cod_articolo_ext_ff.event ue_set_filter(0)
dw_cod_articolo_ext_ff.event ue_set_dddwwidth()
dw_cod_articolo_ext_ff.SetRedraw(TRUE)

end event

event ue_empty_parte;
long		ll_row, ll_nr_row

ll_nr_row= dw_cod_articolo_ext_ff.RowCount()
FOR ll_row= 0 to (ll_nr_row - 1)
	dw_cod_articolo_ext_ff.DeleteRow(ll_nr_row -ll_row)
next

end event

public function long uf_setta_cod_parte (s_cod_parte astr_cod_parte);
long 					ll_new_row, ll_lunghezza
integer				li_size, li_posizione
char					lch_mask[], lch_mas_input[]
string				ls_codice	
datawindowchild	ldwc_drop
ll_new_row= dw_cod_articolo_ext_ff.InsertRow(0)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "id_cod_parte", astr_cod_parte.l_id_cod_parte)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "descrizione", astr_cod_parte.s_descrizione)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "progressivo", astr_cod_parte.s_progressivo)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "lunghezza", astr_cod_parte.l_lunghezza)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "car_riempimento", astr_cod_parte.s_car_riempimento)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "variante", astr_cod_parte.s_variante)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "num_sezione", astr_cod_parte.l_num_sezione)
if IsNull(astr_cod_parte.s_solo_in_elenco) then astr_cod_parte.s_solo_in_elenco= "N"
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "solo_in_elenco", astr_cod_parte.s_solo_in_elenco)
if astr_cod_parte.s_solo_in_elenco="S" then
	dw_cod_articolo_ext_ff.SetItem(ll_new_row, "cod_scelta", "S")
end if
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "tipo_richiesta", astr_cod_parte.s_tipo_richiesta)

ll_lunghezza= astr_cod_parte.l_lunghezza
if not(astr_cod_parte.s_val_proposto ="" OR IsNull(astr_cod_parte.s_val_proposto)) then
	ls_codice=astr_cod_parte.s_val_proposto
end if

if Len(ls_codice) < ll_lunghezza then
	if not(astr_cod_parte.s_car_riempimento ="" OR IsNull(astr_cod_parte.s_car_riempimento)) then
		ls_codice=f_rpad(ls_codice,astr_cod_parte.s_car_riempimento, ll_lunghezza)
	else
		ls_codice=f_rpad(ls_codice,"0", ll_lunghezza - Len(ls_codice))
	end if
end if
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "codice", ls_codice)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "scelta", ls_codice)
dw_cod_articolo_ext_ff.SetItem(ll_new_row, "scelta_noedit", ls_codice)
dw_cod_articolo_ext_ff.SetItem(ll_new_row,"descrizione_scelta",uf_get_des_scelta(ls_codice))
dw_cod_articolo_ext_ff.Modify("codice.edit.limit = " + String(astr_cod_parte.l_lunghezza))
dw_cod_articolo_ext_ff.Modify("codice.width.autosize=yes")
If astr_cod_parte.s_progressivo="S" then 
	If ib_esiste_progr then
		MessageBox("Calcolo del Codice","Esiste più di una parte progressiva:~n sarà "+ &
			 "calcolata automaticamente solo la prima.")
	else
		ib_esiste_progr=TRUE
	end if
end if

lch_mas_input= astr_cod_parte.s_mas_input
li_size = UpperBound(lch_mas_input)
for  li_posizione= 1 to li_size
	CHOOSE CASE lch_mas_input[li_posizione]
		CASE "A"
			lch_mask[li_posizione] = "!"
		CASE "N"
			lch_mask[li_posizione] = "#"
		CASE "M"
			lch_mask[li_posizione] = "a"
		CASE "X"
			lch_mask[li_posizione] = "X"
		CASE ELSE
			
	END CHOOSE
next
if lch_mask <> "" then 
	dw_cod_articolo_ext_ff.SetItem(ll_new_row, "mask", lch_mask)
end if
	
	dw_cod_articolo_ext_ff.GetChild ("scelta", ldwc_drop)
	ldwc_drop.Retrieve ()
	dw_cod_articolo_ext_ff.GetChild ("scelta_noedit", ldwc_drop)
	ldwc_drop.Retrieve ()
return ll_new_row
end function

public function string uf_fill_cod_parte (integer al_row, string as_cod_rimanente);
long		ll_lunghezza, ll_id_cat_codifica, ll_parti_trovate, ll_id_cod_parte
string	ls_tipo_richiesta, as_ret_codice, as_parte

If not(IsNull(as_cod_rimanente) OR as_cod_rimanente="") AND not(IsNull(al_row) OR al_row=0) then
	ll_lunghezza= dw_cod_articolo_ext_ff.GetItemNumber(al_row, "lunghezza")
	ls_tipo_richiesta= dw_cod_articolo_ext_ff.GetItemString(al_row, "tipo_richiesta")
	if ll_lunghezza > 0 then
		as_parte= Mid(as_cod_rimanente, 1,ll_lunghezza)
		as_ret_codice= Mid(as_cod_rimanente, ll_lunghezza+1)
		CHOOSE CASE ls_tipo_richiesta
			CASE "F"
				
				dw_cod_articolo_ext_ff.SetItem(al_row, "codice", as_parte)
				dw_cod_articolo_ext_ff.SetItem(al_row, "scelta", as_parte)
				dw_cod_articolo_ext_ff.SetItem(al_row,"descrizione_scelta",uf_get_des_scelta(as_parte))
			CASE "A"
			CASE "R"
				
				
				if dw_cod_articolo_ext_ff.GetItemString(al_row, "solo_in_elenco") = "S" then
					ll_id_cod_parte= dw_cod_articolo_ext_ff.GetItemNumber(al_row, "id_cod_parte")
					SELECT Count(*)  
						INTO :ll_parti_trovate  
						FROM "dba"."scelta_parte"  
						WHERE ( "scelta_parte"."id_cod_parte" = :ll_id_cod_parte ) AND  
						( "scelta_parte"."scelta" = :as_parte )   ;
					
					
					if ll_parti_trovate > 0 then
						dw_cod_articolo_ext_ff.SetItem(al_row, "codice", as_parte)
						dw_cod_articolo_ext_ff.SetItem(al_row, "scelta", as_parte)
						dw_cod_articolo_ext_ff.SetItem(al_row, "scelta_noedit", as_parte)
						dw_cod_articolo_ext_ff.SetItem(al_row,"descrizione_scelta",uf_get_des_scelta(as_parte))
					else
						as_ret_codice=""
					end if
				else
					dw_cod_articolo_ext_ff.SetItem(al_row, "codice", as_parte)
					dw_cod_articolo_ext_ff.SetItem(al_row, "scelta", as_parte)
					dw_cod_articolo_ext_ff.SetItem(al_row, "scelta_noedit", as_parte)
					dw_cod_articolo_ext_ff.SetItem(al_row,"descrizione_scelta",uf_get_des_scelta(as_parte))
				end if
		END CHOOSE
	end if
end if
return as_ret_codice

end function

public function string uf_get_des_scelta (string as_codice);
long		ll_id_cod_parte
string	ls_des_scelta

ll_id_cod_parte=dw_cod_articolo_ext_ff.GetItemNumber(dw_cod_articolo_ext_ff.GetRow(), "id_cod_parte")
SELECT MAX("scelta_parte"."descrizione")
	INTO :ls_des_scelta  
	FROM "dba"."scelta_parte"  
	WHERE ( "scelta_parte"."id_cod_parte" = :ll_id_cod_parte ) and 
			( "scelta_parte"."scelta" = :as_codice ) ;
if SQLCA.SQLCode <> 0 then
	ls_des_scelta=""
end if


RETURN ls_des_scelta


end function

public function string uf_val_cod_parte (integer al_row, ref string as_err_message, ref long al_err_code);
long		ll_lunghezza, ll_id_cat_codifica, ll_parti_trovate, ll_id_cod_parte, ll_nr_parte
string	ls_tipo_richiesta, ls_codice, as_parte, ls_descrizione
integer 	li_error

as_err_message=""
al_err_code=0
If not(IsNull(al_row) OR al_row=0) then
	ls_codice= dw_cod_articolo_ext_ff.GetItemString(al_row, "codice")
	ll_nr_parte= dw_cod_articolo_ext_ff.GetItemNumber(al_row, "num_sezione")
	ll_lunghezza= dw_cod_articolo_ext_ff.GetItemNumber(al_row, "lunghezza")
	ls_descrizione= dw_cod_articolo_ext_ff.GetItemString(al_row, "descrizione_scelta")
	If IsNull(ls_descrizione) then ls_descrizione=""
	if ls_descrizione <> "" then ls_descrizione= " - " + ls_descrizione
	ls_tipo_richiesta= dw_cod_articolo_ext_ff.GetItemString(al_row, "tipo_richiesta")
	if ll_lunghezza > 0 then
		CHOOSE CASE ls_tipo_richiesta
			CASE "F"
				
				if ll_lunghezza < Len(ls_codice) then
					as_err_message=as_err_message + "~n~t E' lunga più di " + String(ll_lunghezza) + " caratteri."
					li_error=1
				end if
			CASE "A"
				
			CASE "R"
				
				
				if dw_cod_articolo_ext_ff.GetItemString(al_row, "solo_in_elenco") = "S" then
					ll_id_cod_parte= dw_cod_articolo_ext_ff.GetItemNumber(al_row, "id_cod_parte")
					SELECT Count(*)  
						INTO :ll_parti_trovate  
						FROM "dba"."scelta_parte"  
						WHERE ( "scelta_parte"."id_cod_parte" = :ll_id_cod_parte ) AND  
						( "scelta_parte"."scelta" = :ls_codice )   ;
					
					
					if ll_parti_trovate = 0 then
						as_err_message=as_err_message + "~n~t Non corrisponde ad alcuna Scelta." 
						li_error=2
					end if
				else
					
					if not(ll_lunghezza = Len(ls_codice)) then
						as_err_message=as_err_message + "~n~t Non è lunga " + String(ll_lunghezza) + " caratteri."
						li_error=3
					end if
				end if
		END CHOOSE
	end if
end if
if li_error > 0 then
	as_err_message=  "La parte Nr." + String(ll_nr_parte) + " (" + ls_codice + &
		ls_descrizione + ") è ERRATA, in quanto:" + as_err_message 
	al_err_code=li_error
end if
return ls_codice

end function

public function string uf_val_codice ();
long 				ll_nr_row, ll_row, ll_err_parte, ll_err_totali
string			ls_parte_codice, ls_err_message, ls_err_totale

ll_nr_row= dw_cod_articolo_ext_ff.RowCount()
FOR ll_row= 1 to ll_nr_row
	ls_parte_codice= ls_parte_codice + uf_val_cod_parte(ll_row, ls_err_message, ll_err_parte)
	ll_err_totali=ll_err_totali + ll_err_parte
	ls_err_totale= ls_err_totale + "~n" + ls_err_message
NEXT
if ll_err_totali> 0 then
	SetNull(ls_parte_codice)
	if IsNull(ls_err_totale) OR ls_err_totale = "" then ls_err_totale ="Codice ERRATO per cause non precisate."
	MessageBox("Validazione del Codice", ls_err_totale, Information!)
end if
return ls_parte_codice
end function

on w_cod_articolo_wz.create
int iCurrent
call super::create
this.st_cod_parte=create st_cod_parte
this.dw_cat_codifica_ext_ff=create dw_cat_codifica_ext_ff
this.dw_cod_articolo_ext_ff=create dw_cod_articolo_ext_ff
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_cod_parte
this.Control[iCurrent+2]=this.dw_cat_codifica_ext_ff
this.Control[iCurrent+3]=this.dw_cod_articolo_ext_ff
this.Control[iCurrent+4]=this.cb_annulla
this.Control[iCurrent+5]=this.cb_ok
end on

on w_cod_articolo_wz.destroy
call super::destroy
destroy(this.st_cod_parte)
destroy(this.dw_cat_codifica_ext_ff)
destroy(this.dw_cod_articolo_ext_ff)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;long 				ll_row

ib_fill= TRUE
istr_array= Message.PowerObjectParm
dw_cat_codifica_ext_ff.TriggerEvent("ue_insert")
ll_row= dw_cat_codifica_ext_ff.GetRow()
dw_cat_codifica_ext_ff.Triggerevent("ue_post_open")
dw_cod_articolo_ext_ff.Triggerevent("ue_post_open")

idc_w_color= Dec(dw_cod_articolo_ext_ff.describe("codice.background.color"))
dw_cat_codifica_ext_ff.SetItem(ll_row, "id_cat_codifica", istr_array.s_array[1])
postevent("ue_load_parte")

end event

event closequery;Message.PowerObjectParm = istr_array

end event

type st_cod_parte from statictext within w_cod_articolo_wz
int X=48
int Y=320
int Width=2469
int Height=86
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="    Nr.  -  Descrizione della Parte       -  Codice / Scelta della Parte               -  Descrizione della Parte Scelta"
boolean FocusRectangle=false
long TextColor=1090519039
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_cat_codifica_ext_ff from u_dw_ext_main within w_cod_articolo_wz
int X=161
int Y=160
int Width=2242
int Height=141
int TabOrder=10
string DataObject="d_cat_codifica_ext_ff"
end type

event ue_init;call super::ue_init;is_colonne_drop[1]="id_cat_codifica"
is_colonne_drop[2]="id_cat_codifica_des"
end event

event itemchanged;call super::itemchanged;long ll_count

If dwo.name= "id_cat_codifica" OR dwo.name= "id_cat_codifica_des" then
	ib_fill= FALSE
	parent.post TriggerEvent("ue_load_parte")
end if
end event

event getfocus;call super::getfocus;SetRedraw(FALSE)
SetColumn("id_cat_codifica")
SetRedraw(TRUE)
end event

event itemerror;call super::itemerror;return 3
end event

type dw_cod_articolo_ext_ff from u_dw_ext_main within w_cod_articolo_wz
event type integer ue_scelta ( string as_escape )
event type string ue_get_des_scelta ( string as_codice )
event type integer ue_set_filter ( long al_row )
event ue_set_dddwwidth ( )
event ue_set_parte_progr ( )
int X=48
int Y=400
int Width=2469
int Height=682
int TabOrder=20
string DataObject="d_cod_articolo_ext_ff"
boolean VScrollBar=true
end type

event ue_scelta;call super::ue_scelta;
long		ll_row
string	ls_testo, ls_scelta_des, ls_colonna

ll_row= GetRow()
ls_testo= GetText()
if GetItemString(ll_row,"solo_in_elenco") <> "S" then
	ls_colonna=GetColumnName()
	CHOOSE CASE ls_colonna
		CASE "codice"
			ls_scelta_des=GetItemString(ll_row, "descrizione_scelta")
			If IsNull(ls_scelta_des) then ls_scelta_des=""
			if ls_scelta_des <> "Nessuna Scelta Disponibile"then
				SetItem(ll_row, "cod_scelta", "S")
				If SetColumn("scelta") < 0 then SetColumn("scelta_noedit")
				SetText(ls_testo)
			end if
		CASE "scelta", "scelta_noedit"
			SetItem(ll_row, "cod_scelta", "C")
			SetColumn("codice")
			if as_escape = "N" then
				SetText(ls_testo)
			else
				ls_testo= GetItemString(ll_row, "codice")
				SetItem(ll_row, ls_colonna, ls_testo)
			end if
			SetItem(ll_row, "descrizione_scelta", uf_get_des_scelta(ls_testo))
	END CHOOSE
else
	if as_escape = "S" then
			
			ls_scelta_des=GetItemString(ll_row, "descrizione_scelta")
			If IsNull(ls_scelta_des) then ls_scelta_des=""
			if ls_scelta_des <> "Nessuna Scelta Disponibile"then
				ls_testo= GetItemString(ll_row, "codice")
				SetItem(ll_row, "scelta", ls_testo)
				SetItem(ll_row, "scelta_noedit", ls_testo)
				SetItem(ll_row, "descrizione_scelta", uf_get_des_scelta(ls_testo))
			end if
	end if
end if

return 0
end event

event ue_set_filter;call super::ue_set_filter;
DataWindowChild	ldwc_current
long					ll_row, ll_id_cod_parte, ll_ret_value, ll_nr_row
string				ls_tipo

if IsNull(al_row) OR al_row = 0 then al_row= GetRow()
if not (IsNull(al_row) OR al_row = 0) then
	ll_id_cod_parte= GetItemNumber(al_row, "id_cod_parte")
	ll_ret_value=GetChild("scelta", ldwc_current)
	if ll_ret_value = 1 AND not(IsNull(ll_id_cod_parte) OR ll_id_cod_parte =0 )then
		ldwc_current.SetFilter("id_cod_parte = " + String(ll_id_cod_parte))
		ldwc_current.Filter()
		ll_nr_row=ldwc_current.RowCount()
		if ll_nr_row = 0 then
			SetItem(al_row, "descrizione_scelta", "Nessuna Scelta Disponibile")
		end if
	end if
	ll_ret_value=GetChild("scelta_noedit", ldwc_current)
	if ll_ret_value = 1 AND not(IsNull(ll_id_cod_parte) OR ll_id_cod_parte =0 )then
		ldwc_current.SetFilter("id_cod_parte = " + String(ll_id_cod_parte))
		ldwc_current.Filter()
		ll_nr_row=ldwc_current.RowCount()
		if ll_nr_row = 0 then
			SetItem(al_row, "descrizione_scelta", "Nessuna Scelta Disponibile")
		end if
	end if
end if	

return ll_nr_row
end event

event ue_set_dddwwidth;
long ll_row, ll_lunghezza, ll_width

ll_row= GetRow()

if ll_row > 0 then
	ll_lunghezza =  GetItemNumber(ll_row, "lunghezza")
	if not (IsNull(ll_lunghezza) OR ll_lunghezza=0) then

		IF  (ll_lunghezza >= 0) AND (ll_lunghezza <= 1) THEN
			ll_width = 140
		END IF

		IF  (ll_lunghezza >= 2) AND (ll_lunghezza <= 3) THEN
			ll_width = 190
		END IF

		IF  (ll_lunghezza >= 4) AND (ll_lunghezza <=5 ) THEN
			ll_width = 245 
		END IF
		
		IF  (ll_lunghezza >= 6) AND (ll_lunghezza <= 20) THEN
			ll_width = 275
		END IF
		
		if ll_width<= 0 or isnull(ll_width) then ll_width=1
		Modify("scelta.dddw.percentwidth=" + String(210000 / ll_width))
		Modify("scelta_noedit.dddw.percentwidth=" + String(210000 / ll_width))
		
		
		
	end if
end if

end event

event ue_set_parte_progr;call super::ue_set_parte_progr;
integer		li_num_parte, li_parte,li_size
string		ls_max_progr, ls_parte[]
decimal		ldc_max_progr
long			ll_row

If ib_esiste_progr then
	ll_row= GetRow()
	li_size= RowCount()
	for ll_row = 1 to li_size
		ls_parte[ll_row]=GetItemString(ll_row, "codice")
	next
	li_parte=0
	ls_max_progr= f_calc_progressivo(ls_parte,istr_cod_parte, li_parte)
	If ls_max_progr <> "" AND li_parte > 0 then
		SetItem(li_parte, "codice", ls_max_progr)
	end if
end if

end event

event ue_init;call super::ue_init;is_colonne_drop[1]="scelta"
is_colonne_drop[2]="scelta_noedit"




end event

event constructor;call super::constructor;
string		ls_mask, ls_yes, ls_no

ls_yes= Char(121) + Char(101) + Char(115)
ls_no=Char(110) + Char(111)
ls_mask= Describe("codice.editmask.mask")
if IsNull(ls_mask) then ls_mask=""
ls_mask= f_get_dwo_property(ls_mask, "", "If ( not (IsNull( mask)), mask,'')")
Modify("codice.editmask.mask= " + ls_mask)


ls_mask= Describe("codice.Background.Mode")
if IsNull(ls_mask) then ls_mask=""
ls_mask= f_get_dwo_property(ls_mask, "", "if(  tipo_richiesta ='A',1, 0)")
Modify("codice.Background.Mode=" + ls_mask)

end event

event ue_key;call super::ue_key;
string 	ls_column
long		ll_row

if (key= KeyF4!) AND Left(ls_column,9) = "c_codice_" then
end if
CHOOSE CASE  key
	CASE KeyF4!
		ll_row= GetRow()
		If GetColumnName()= "codice" AND ll_row >0 then
			
			If istr_cod_parte[ll_row].s_progressivo= "S" then TriggerEvent("ue_set_parte_progr")
		end if
	CASE KeyEnter!
		event ue_scelta("N")
		RETURN 1
	CASE KeyEscape!
		event ue_scelta("S")
		RETURN 1
	CASE KeyTab!
		
		If GetColumnName() = "scelta" OR GetColumnName() = "scelta_noedit" then event ue_scelta("N")
END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;long ll_lunghezza, ll_width

event ue_set_filter(GetRow())
is_last_column= is_cur_column
is_cur_column= GetColumnName()
il_last_row= il_cur_row
il_cur_row= GetRow()
event ue_set_dddwwidth()
end event

event itemchanged;call super::itemchanged;long 			ll_row, ll_lunghezza
string 		ls_codice, ls_car_riempimento, ls_campo

ll_row= GetRow()
if ll_row > 0 then
	ll_lunghezza= GetItemNumber(ll_row , "lunghezza")
	ls_car_riempimento=GetItemString(ll_row , "car_riempimento")
	If IsNull(ls_car_riempimento) OR ls_car_riempimento= "" then ls_car_riempimento = "0"
	ls_campo= dwo.name
	CHOOSE CASE ls_campo
		CASE "scelta", "scelta_noedit"
			
			
			ls_codice= f_rpad(data, ls_car_riempimento, ll_lunghezza)
			if GetItemString(ll_row,"solo_in_elenco") = "S" then
				SetItem(ll_row, "codice", data)
			end if
			SetItem(ll_row, "descrizione_scelta", uf_get_des_scelta(data))
			If istr_cod_parte[ll_row].s_progressivo <> "S" then
				Post TriggerEvent("ue_set_parte_progr")
			end if
		CASE "codice"
			ls_codice= f_rpad(data, ls_car_riempimento, ll_lunghezza)
			Post SetItem(ll_row, "codice", ls_codice)
			If istr_cod_parte[ll_row].s_progressivo <> "S" then
				Post TriggerEvent("ue_set_parte_progr")
			end if
	END CHOOSE
end if
end event

event getfocus;call super::getfocus;If RowCount() > 0 then ScrollToRow(1)

end event

event clicked;call super::clicked;
If (GetColumnName() = "scelta" OR GetColumnName() = "scelta_noedit") AND &
	(not(row = GetRow())) then event ue_scelta("N")
end event

type cb_annulla from commandbutton within w_cod_articolo_wz
int X=388
int Y=42
int Width=256
int Height=86
int TabOrder=40
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)

end event

type cb_ok from commandbutton within w_cod_articolo_wz
int X=48
int Y=42
int Width=238
int Height=86
int TabOrder=30
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long 				ll_nr_row, ll_row, ll_err_parte, ll_err_totali
string			ls_err_message, ls_err_totale
any				la_any_array[]

la_any_array[1]= dw_cat_codifica_ext_ff.GetItemNumber(dw_cat_codifica_ext_ff.GetRow(), "id_cat_codifica")
ll_nr_row= dw_cod_articolo_ext_ff.RowCount()
FOR ll_row= 1 to ll_nr_row
	la_any_array[ll_row + 1]= uf_val_cod_parte(ll_row, ls_err_message, ll_err_parte)
	ll_err_totali=ll_err_totali + ll_err_parte
	ls_err_totale= ls_err_totale + "~n" + ls_err_message
NEXT
if ll_err_totali> 0 then
	if IsNull(ls_err_totale) OR ls_err_totale = "" then ls_err_totale ="Codice ERRATO per cause non precisate."
	MessageBox("Validazione del Codice", ls_err_totale, Information!)
else
	istr_array.s_array=la_any_array
	Close(parent)
end if



end event

