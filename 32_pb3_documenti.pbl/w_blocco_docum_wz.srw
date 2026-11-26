forward
global type w_blocco_docum_wz from w_wiz_main
end type
type cb_2 from commandbutton within w_blocco_docum_wz
end type
type cb_ok from commandbutton within w_blocco_docum_wz
end type
type dw_blocco_docum_wz from datawindow within w_blocco_docum_wz
end type
end forward

global type w_blocco_docum_wz from w_wiz_main
int X=833
int Y=361
int Width=1911
int Height=1181
WindowType WindowType=response!
boolean TitleBar=true
string Title="Blocco Documento "
string Tag="tag_bocco_documento"
event ue_pop ( )
event type integer ue_load ( )
cb_2 cb_2
cb_ok cb_ok
dw_blocco_docum_wz dw_blocco_docum_wz
end type
global w_blocco_docum_wz w_blocco_docum_wz

type variables
s_service_blocco iastr_blocco[]
s_any_array istr_array

string	is_pw_sblocco_stampa , is_pw_chius_forzata
string	 is_pw_bloccato , is_pw_sospeso
end variables

event ue_pop;

long					ll_index

dw_blocco_docum_wz.Reset()
FOR ll_index = 1 TO UpperBound(iastr_blocco)
	dw_blocco_docum_wz.InsertRow(0)
NEXT	
FOR ll_index = 1 TO UpperBound(iastr_blocco)
	dw_blocco_docum_wz.SetItem(ll_index, "c_desc_stato", iastr_blocco[ll_index].s_ser_blo_1_desc_stato)
	dw_blocco_docum_wz.SetItem(ll_index, "c_old_stato", iastr_blocco[ll_index].s_ser_blo_2_old_stato)
	dw_blocco_docum_wz.SetItem(ll_index, "c_password", iastr_blocco[ll_index].s_ser_blo_3_password)
	dw_blocco_docum_wz.SetItem(ll_index, "c_new_stato", iastr_blocco[ll_index].s_ser_blo_4_new_stato)

	dw_blocco_docum_wz.SetItem(ll_index, "c_modo", iastr_blocco[ll_index].s_ser_blo_5_modo)
NEXT
dw_blocco_docum_wz.ScrollToRow(0)
end event

event ue_load;

integer  			li_retcode
string				ls_msg, ls_sep, ls_si, ls_no
string				ls_stampato, ls_contabilizzato, ls_evaso_totalmente
string				ls_chius_forzata, ls_sospeso, ls_bloccato, ls_intoccabile
long 					ll_id_prof_documento, ll_id_azienda
w_blocco_docum_wz wi_blocco_docum_wz
s_service_blocco	lastr_s_ser_blo[]

ll_id_prof_documento = istr_array.s_array[2]
ll_id_azienda = istr_array.s_array[3]

ls_bloccato = istr_array.s_array[4]
ls_chius_forzata = istr_array.s_array[5]
ls_contabilizzato = istr_array.s_array[6]
ls_evaso_totalmente = istr_array.s_array[7]
ls_sospeso = istr_array.s_array[8]
ls_stampato = istr_array.s_array[9]

ls_si = "S"
ls_no = "N"
ls_intoccabile = "I"
ls_sep	= "~n"
li_retcode = (-1)
IF (IsNull(istr_array.s_array[1])) THEN
	RETURN li_retcode
END IF
SELECT "prof_documento"."pas_di_sblocco",   
		"prof_documento"."pas_chiu_forz"  
	INTO :is_pw_sblocco_stampa,   
		:is_pw_chius_forzata  
	FROM "prof_documento"  
	WHERE "prof_documento"."id_prof_documento" = :ll_id_prof_documento   ;

SELECT "azienda"."pas_blocco_doc",   
		"azienda"."pas_sosp_doc"  
	INTO :is_pw_bloccato,   
		:is_pw_sospeso  
	FROM "azienda"  
	WHERE "azienda"."id_azienda" = :ll_id_azienda ;

is_pw_sblocco_stampa=f_cripting(is_pw_sblocco_stampa)
is_pw_chius_forzata=f_cripting(is_pw_chius_forzata)
is_pw_bloccato=f_cripting(is_pw_bloccato)
is_pw_sospeso=f_cripting(is_pw_sospeso)

lastr_s_ser_blo[1].s_ser_blo_1_desc_stato = "BLOCCATO" 
lastr_s_ser_blo[1].s_ser_blo_2_old_stato  = ls_bloccato
lastr_s_ser_blo[1].s_ser_blo_3_password   = ""
lastr_s_ser_blo[1].s_ser_blo_4_new_stato  = ls_bloccato 
lastr_s_ser_blo[1].s_ser_blo_5_modo       = ls_si

lastr_s_ser_blo[2].s_ser_blo_1_desc_stato = "CHIUSO" 
lastr_s_ser_blo[2].s_ser_blo_2_old_stato  = ls_chius_forzata
lastr_s_ser_blo[2].s_ser_blo_3_password   = ""
lastr_s_ser_blo[2].s_ser_blo_4_new_stato  = ls_chius_forzata
lastr_s_ser_blo[2].s_ser_blo_5_modo       = ls_si

lastr_s_ser_blo[3].s_ser_blo_1_desc_stato = "CONTABILIZZATO" 
lastr_s_ser_blo[3].s_ser_blo_2_old_stato  = ls_contabilizzato 
lastr_s_ser_blo[3].s_ser_blo_3_password   = "PWCONTABILIZZATO"
lastr_s_ser_blo[3].s_ser_blo_4_new_stato  = ls_contabilizzato 
lastr_s_ser_blo[3].s_ser_blo_5_modo       = ls_intoccabile

lastr_s_ser_blo[4].s_ser_blo_1_desc_stato = "EVASO" 
lastr_s_ser_blo[4].s_ser_blo_2_old_stato  = ls_evaso_totalmente 
lastr_s_ser_blo[4].s_ser_blo_3_password   = "PWEVASO"
lastr_s_ser_blo[4].s_ser_blo_4_new_stato  = ls_evaso_totalmente
lastr_s_ser_blo[4].s_ser_blo_5_modo       = ls_intoccabile

lastr_s_ser_blo[5].s_ser_blo_1_desc_stato = "SOSPESO" 
lastr_s_ser_blo[5].s_ser_blo_2_old_stato  = ls_sospeso
lastr_s_ser_blo[5].s_ser_blo_3_password   = ""
lastr_s_ser_blo[5].s_ser_blo_4_new_stato  = ls_sospeso
lastr_s_ser_blo[5].s_ser_blo_5_modo       = ls_si

lastr_s_ser_blo[6].s_ser_blo_1_desc_stato = "STAMPATO" 
lastr_s_ser_blo[6].s_ser_blo_2_old_stato  = ls_stampato
lastr_s_ser_blo[6].s_ser_blo_3_password   = ""
lastr_s_ser_blo[6].s_ser_blo_4_new_stato  = ls_stampato 
lastr_s_ser_blo[6].s_ser_blo_5_modo       = ls_si

lastr_s_ser_blo[7].s_ser_blo_1_desc_stato = "ALTRO" 
lastr_s_ser_blo[7].s_ser_blo_2_old_stato  = "N" 
lastr_s_ser_blo[7].s_ser_blo_3_password   = "PWALTRO"
lastr_s_ser_blo[7].s_ser_blo_4_new_stato  = "S"
lastr_s_ser_blo[7].s_ser_blo_5_modo       = ls_intoccabile
iastr_blocco = lastr_s_ser_blo

li_retcode = 0
RETURN li_retcode

end event

on w_blocco_docum_wz.create
int iCurrent
call w_wiz_main::create
this.cb_2=create cb_2
this.cb_ok=create cb_ok
this.dw_blocco_docum_wz=create dw_blocco_docum_wz
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_2
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=dw_blocco_docum_wz
end on

on w_blocco_docum_wz.destroy
call w_wiz_main::destroy
destroy(this.cb_2)
destroy(this.cb_ok)
destroy(this.dw_blocco_docum_wz)
end on

event open;call super::open;
istr_array= Message.PowerObjectParm
Message.Processed= TRUE
Event ue_load()
This.TriggerEvent("ue_pop")
end event

event closequery;

Message.PowerObjectParm= istr_array
end event

type cb_2 from commandbutton within w_blocco_docum_wz
int X=435
int Y=41
int Width=270
int Height=89
int TabOrder=10
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)
end event

type cb_ok from commandbutton within w_blocco_docum_wz
int X=69
int Y=41
int Width=270
int Height=89
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string 		ls_msg, ls_sep
long			ll_index

dw_blocco_docum_wz.AcceptText()


FOR ll_index = 1 TO dw_blocco_docum_wz.RowCount()
	istr_array.s_array[ll_index]=dw_blocco_docum_wz.GetItemString(ll_index, "c_new_stato")
NEXT
Close(Parent)
end event

type dw_blocco_docum_wz from datawindow within w_blocco_docum_wz
int X=46
int Y=161
int Width=1797
int Height=901
int TabOrder=30
string DataObject="d_blocco_docum_wz"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;

long ll_row

ll_row= GetRow()
If dwo.name= "c_password" then
	CHOOSE CASE GetItemString(ll_row, "c_desc_stato")
		CASE "STAMPATO"
			If String(data) = is_pw_sblocco_stampa then SetItem(ll_row, "c_modo", "N")
		CASE "BLOCCATO"
			If String(data) = is_pw_bloccato then SetItem(ll_row, "c_modo", "N")
		CASE "CONTABILIZZATO"
			If true then SetItem(ll_row, "c_modo", "N")
		CASE "SOSPESO"
			If String(data) = is_pw_sospeso then SetItem(ll_row, "c_modo", "N")
		CASE "EVASO"
			If true then SetItem(ll_row, "c_modo", "N")
		CASE "CHIUSO"
			If String(data) = is_pw_chius_forzata then SetItem(ll_row, "c_modo", "N")
	END CHOOSE
end if

end event

