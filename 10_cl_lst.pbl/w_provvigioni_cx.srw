forward
global type w_provvigioni_cx from w_testa_righe_cx
end type
end forward

global type w_provvigioni_cx from w_testa_righe_cx
integer x = 59
integer y = 83
integer width = 3610
integer height = 1440
string title = "Provvigioni"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
end type
global w_provvigioni_cx w_provvigioni_cx

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public function integer wf_controlla_date (string as_colonna, long row, string data, date old_data)
end prototypes

public subroutine wf_ricerca (long al_riga_corrente, string as_data);
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	dw_2.setitem(al_riga_corrente, "lista_art_key_id_articolo",long(ls_ric_param.s_id_seg_value[1]))
	dw_2.setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
	dw_2.setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
end if
end subroutine

public function integer wf_controlla_date (string as_colonna, long row, string data, date old_data);LONG ll_id_sog, ll_id_lista, ll_id_sog1, ll_id_lista1
DATE LDT_DATA
INTEGER LI_RET=3

CHOOSE CASE as_colonna
case "data_fine_valido"
		
	
			ldt_data=dw_1.getitemdate(row, "data_valido")
			if date(data) < ldt_data then
				messagebox("Errore!", "Inserire data di fine maggiore o uguale a quella di inizio!")
				LI_RET=1
			end if
		
			
	case "data_valido"
		if row > 1 then
			ll_id_sog=dw_1.getitemnumber(row - 1, "id_sog_commerciale")
			ll_id_lista=dw_1.getitemnumber(row - 1, "id_lista_articoli")
			ll_id_sog1=dw_1.getitemnumber(row , "id_sog_commerciale")
			ll_id_lista1=dw_1.getitemnumber(row , "id_lista_articoli")
			
			if ll_id_sog=ll_id_sog1 and ll_id_lista=ll_id_lista1 then
				ldt_data=dw_1.getitemdate(row - 1, "data_fine_valido")
				if date(data) <= ldt_data then
					messagebox("Errore!", "Inserire data iniziale maggiore di quella finale precedente!")
					LI_RET=1
				end if
			end if
			
		end if
END CHOOSE
RETURN LI_RET
end function

on w_provvigioni_cx.create
call super::create
end on

on w_provvigioni_cx.destroy
call super::destroy
end on

event open;call super::open;long ll_id
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

if dw_1.retrieve()>0 then
	ll_id=dw_1.getitemnumber(1,1)
	dw_2.retrieve(ll_id)
end if
end event

type st_1 from w_testa_righe_cx`st_1 within w_provvigioni_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_provvigioni_cx
integer x = 22
integer y = 26
integer width = 3493
integer height = 915
string dataobject = "d_provvigioni_gd"
end type

event dw_1::rowfocuschanging;
end event

event dw_1::ue_insert;call super::ue_insert;
return al_riga_precedente


end event

event dw_1::itemchanged;date ldt_data
string ls_dat2, ls_data
long ll_id_sog, ll_id_lista, ll_id_sog1, ll_id_lista1
integer li_ret

CHOOSE CASE dwo.name
	CASE "val_fisso"
		if data>"0" then
			dw_1.setitem(row, "percentuale", 100)
		end if
	
		
		
END CHOOSE

end event

event dw_1::itemerror;
string	ls_coltype, ls_data, ls_dat2, ls_colname
integer  li_ret
DATE ldt_data

if dwo.name="data_valido" or dwo.name="data_fine_valido" then
	if not IsDate(data) then 
		
			ls_data=data
			li_ret = f_validate_date(ls_data,ls_dat2)
			if li_ret = 1 then 
				ldt_data=DATE(ls_dat2)
				setitem(row, STRING(dwo.name), ldt_data)
				LDT_DATA=GETITEMDATE(ROW, STRING(dwo.name))
				LI_RET=WF_CONTROLLA_DATE(STRING(dwo.name), ROW, ls_dat2,LDT_DATA )
				RETURN  LI_RET
				
			
			end if
		END IF
end if
end event

type dw_2 from w_testa_righe_cx`dw_2 within w_provvigioni_cx
integer x = 26
integer y = 954
integer width = 823
string dataobject = "d_lista_profilo"
end type

event dw_2::itemchanged;st_ass_art_sottoclasse st_associa
IF DWO.NAME='articolo_codice' then
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "lista_art_key_id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		setitem(row, "articolo_descrizione", st_associa.des_articolo)
	else
		wf_ricerca(row, data)
	end if
end if
		
end event

event dw_2::clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	wf_ricerca(row, ls_data)
end if
end event

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_provvigioni_cx
integer x = 955
integer y = 957
integer width = 304
integer height = 109
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_provvigioni_cx
integer x = 955
integer y = 1075
integer width = 304
integer height = 109
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_provvigioni_cx
integer x = 955
integer y = 1197
integer width = 304
integer height = 109
integer taborder = 70
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_provvigioni_cx
integer x = 2981
integer y = 1197
integer width = 304
integer height = 109
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_provvigioni_cx
integer x = 2981
integer y = 1072
integer width = 304
integer height = 109
integer taborder = 60
string text = "OK"
end type

