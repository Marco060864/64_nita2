forward
global type w_galv_prezzo_gd from w_semplice_gd
end type
end forward

global type w_galv_prezzo_gd from w_semplice_gd
integer width = 2427
end type
global w_galv_prezzo_gd w_galv_prezzo_gd

on w_galv_prezzo_gd.create
call super::create
end on

on w_galv_prezzo_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_galv_prezzo_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_galv_prezzo_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_galv_prezzo_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_galv_prezzo_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_galv_prezzo_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_galv_prezzo_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_galv_prezzo_gd
string dataobject = "d_galv_prezzo"
end type

event dw_1::updatestart;call super::updatestart;dwitemstatus ls_status
integer i
for i=1 to dw_1.rowcount()
	ls_status=dw_1.getitemstatus(i, "galvanica_prezzo_quotazione", primary!)
	if ls_status<>notmodified! then dw_1.setitem(i, "data_ult_modifica", today())
next
end event

event dw_1::itemchanged;call super::itemchanged;long ll_riga_trovata, ll_id_galvanica
date ldt_data_fine,ldt_data_inizio

choose case dwo.name
	case "galvanica_prezzo_data_inizio"
		ldt_data_inizio=date(data)
		ll_id_galvanica=getitemnumber(row, "galvanica_prezzo_id_galvanica")
		ll_riga_trovata=find("galvanica_prezzo_id_galvanica="+string(ll_id_galvanica), 1, rowcount())
		do while ll_riga_trovata>0
			if ll_riga_trovata<>row then
				ldt_data_fine=getitemdate(ll_riga_trovata, "galvanica_prezzo_data_fine")
				if ldt_data_fine>=ldt_data_inizio or isnull(ldt_data_fine) then 
					messagebox("Attenzione!", "Controlla riga "+string(ll_riga_trovata)+" la data di fine non è coerente con questa data di inizio!")
					return 1
				end if
			end if
			if ll_riga_trovata=rowcount() then exit
			ll_riga_trovata=find("galvanica_prezzo_id_galvanica="+string(ll_id_galvanica),ll_riga_trovata+1, rowcount())
		loop
end choose
		
		
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_galv_prezzo_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_galv_prezzo_gd
string text = "SALVA"
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_galv_prezzo_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_galv_prezzo_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_galv_prezzo_gd
end type

