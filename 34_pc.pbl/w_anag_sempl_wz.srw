forward
global type w_anag_sempl_wz from w_wiz_main
end type
type cb_annulla from commandbutton within w_anag_sempl_wz
end type
type cb_ricerca from commandbutton within w_anag_sempl_wz
end type
type cb_crea from commandbutton within w_anag_sempl_wz
end type
type dw_anag_sempl_ff from datawindow within w_anag_sempl_wz
end type
end forward

global type w_anag_sempl_wz from w_wiz_main
int X=833
int Y=361
int Width=2250
int Height=1141
WindowType WindowType=response!
boolean TitleBar=true
string Title="Anagrafica Semplice"
cb_annulla cb_annulla
cb_ricerca cb_ricerca
cb_crea cb_crea
dw_anag_sempl_ff dw_anag_sempl_ff
end type
global w_anag_sempl_wz w_anag_sempl_wz

type variables
s_list_main	istr_list
end variables

on w_anag_sempl_wz.create
int iCurrent
call w_wiz_main::create
this.cb_annulla=create cb_annulla
this.cb_ricerca=create cb_ricerca
this.cb_crea=create cb_crea
this.dw_anag_sempl_ff=create dw_anag_sempl_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_annulla
this.Control[iCurrent+2]=cb_ricerca
this.Control[iCurrent+3]=cb_crea
this.Control[iCurrent+4]=dw_anag_sempl_ff
end on

on w_anag_sempl_wz.destroy
call w_wiz_main::destroy
destroy(this.cb_annulla)
destroy(this.cb_ricerca)
destroy(this.cb_crea)
destroy(this.dw_anag_sempl_ff)
end on

event open;call super::open;long				ll_id_valuta, ll_id_linguaggio

istr_list = Message.PowerObjectParm
istr_list.l_identifica[1] = 0
dw_anag_sempl_ff.InsertRow(0)
dw_anag_sempl_ff.SetItem(1, "rag_soc_1", istr_list.s_identifica[1])

SELECT id_valuta, id_linguaggio
  INTO :ll_id_valuta, :ll_id_linguaggio
  FROM dba.par_sistema
  WHERE par_sistema.id_azienda = 1 ;
dw_anag_sempl_ff.SetItem(1, "id_valuta", ll_id_valuta)
dw_anag_sempl_ff.SetItem(1, "id_linguaggio", ll_id_linguaggio)
 
end event

event close;call super::close;CloseWithReturn(This, istr_list)
end event

event systemkey;if key = KeyF4! then
	This.TriggerEvent("Close")
end if
end event

type cb_annulla from commandbutton within w_anag_sempl_wz
int X=1921
int Y=41
int Width=247
int Height=85
int TabOrder=10
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.TriggerEvent("Close")
end event

type cb_ricerca from commandbutton within w_anag_sempl_wz
int X=366
int Y=41
int Width=289
int Height=85
int TabOrder=20
string Text="&Ricerca..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;istr_list.l_identifica[1] = -1
Parent.TriggerEvent("close")
end event

type cb_crea from commandbutton within w_anag_sempl_wz
int X=46
int Y=41
int Width=247
int Height=85
int TabOrder=30
string Text="&Crea"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long				ll_row

if dw_anag_sempl_ff.AcceptText() = 1 then
	
	
	dw_anag_sempl_ff.SetTransObject(SQLCA)
	if dw_anag_sempl_ff.Update( False, False) = 1 then
		
		COMMIT USING SQLCA;
		if SQLCA.SQLCode < 0 then 
			ROLLBACK USING SQLCA;
			MessageBox("Attenzione", "Problemi con Commit!", Exclamation!)
		else
			
			dw_anag_sempl_ff.ResetUpdate()
			ll_row = dw_anag_sempl_ff.GetRow()
			if ll_row > 0 then
				istr_list.l_identifica[1] = dw_anag_sempl_ff.GetItemNumber(ll_row, "id_anagrafica")
				istr_list.s_identifica[1] = dw_anag_sempl_ff.GetItemString(ll_row, "rag_soc_1")
				Parent.TriggerEvent("close")
			else
				MessageBox("Attenzione", "Problemi con Retrieve!", Exclamation!)
			end if
		end if
	else
		MessageBox("Attenzione", "Problemi con Update!", Exclamation!)
	end if
else
	MessageBox("Attenzione", "Problemi con AcceptText!", Exclamation!)
end if


end event

type dw_anag_sempl_ff from datawindow within w_anag_sempl_wz
int X=46
int Y=161
int Width=2126
int Height=841
int TabOrder=40
string DataObject="d_anag_sempl_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;long 		ll_row
string 	ls_Nazione, ls_CF, ls_PI

ll_row = GetRow()
CHOOSE CASE dwo.name
	CASE "cod_fiscale"
		ls_Nazione = GetItemString(ll_row, "nazione")
		ls_CF = data
		if ls_Nazione = "IT" AND ls_CF <> "" AND not IsNull(ls_CF) then
			if GetItemString( ll_row,"nat_giuridica") = "G" then
				IF f_controlla_partita_iva(ls_CF, ls_Nazione) = 0 THEN
					RETURN 0
				ELSE
					MessageBox("Avviso", "Codice Fiscale non valido.", Exclamation!)
				END IF
			else
				IF f_controlla_codice_fiscale(ls_CF, ls_Nazione) = 0 THEN
					RETURN 0
				ELSE
					MessageBox("Avviso", "Codice Fiscale non valido.", Exclamation!)
				END IF
			END IF	
		end if
		IF f_controlla_partita_iva(ls_CF, "IT") = 0 THEN
			SetItem(ll_row, "par_iva", ls_CF)
		END IF
	CASE "par_iva"
		ls_Nazione = GetItemString(ll_row, "nazione")
		ls_PI = data
		if ls_Nazione = "IT"  AND ls_PI <> "" AND not IsNull(ls_PI) then
			IF f_controlla_partita_iva(ls_PI, ls_Nazione) = 0 THEN
				RETURN 0
			ELSE
				MessageBox("Avviso", "Partita IVA non valida.", Exclamation!)
			END IF
		end if
	
END CHOOSE



end event

