forward
global type w_orafo_metallo_gd from w_np_single_data
end type
type cb_storico from commandbutton within w_orafo_metallo_gd
end type
end forward

global type w_orafo_metallo_gd from w_np_single_data
integer x = 59
integer y = 64
integer width = 3328
integer height = 1036
string title = "Quotazione Metallo"
cb_storico cb_storico
end type
global w_orafo_metallo_gd w_orafo_metallo_gd

on w_orafo_metallo_gd.create
int iCurrent
call super::create
this.cb_storico=create cb_storico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_storico
end on

on w_orafo_metallo_gd.destroy
call super::destroy
destroy(this.cb_storico)
end on

event resize;


end event

type p_msg_log from w_np_single_data`p_msg_log within w_orafo_metallo_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_orafo_metallo_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_metallo_gd
end type

type dw_single from w_np_single_data`dw_single within w_orafo_metallo_gd
integer x = 18
integer y = 116
integer width = 3195
integer height = 784
integer taborder = 10
string dataobject = "d_orafo_metallo_gd"
boolean hscrollbar = false
borderstyle borderstyle = stylelowered!
end type

event dw_single::itemchanged;CHOOSE CASE string(dwo.name)
	CASE "quotazione"
		decimal ld_quot
		String ls_data_quotazione
		Datetime   ldt_today

		
		ldt_today = dw_single.GetItemDateTime(Row, "data_quotazione")
		
		if dec(data)> 0  Then
			ldt_today = datetime(today(), now())
			dw_single.SetItem(Row, "data_quotazione", ldt_today) 
		End If
END CHOOSE
end event

type cb_storico from commandbutton within w_orafo_metallo_gd
integer x = 2158
integer y = 20
integer width = 535
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Memorizza per Storico"
end type

event clicked;long i
decimal ll_quotazione
dwItemStatus l_status
integer ll_id_metallo,  ll_id_azienda, ll_id_valuta
string ll_codice, ll_descrizione
DateTime	 ll_data_quotazione
boolean errore=false
boolean almeno_uno=false


dw_single.update(true, false)


FOR i=1 TO dw_single.rowcount()
    l_status =dw_single.GetItemStatus(i, "quotazione", Primary!)
	 IF   l_status=datamodified! or l_status=newmodified!  THEN 
		 almeno_uno=true
		 ll_id_valuta=dw_single.getitemnumber(i,"id_valuta")
		 ll_id_metallo=dw_single.getitemnumber(i,"id_metallo")	
	    ll_quotazione=dw_single.getitemdecimal(i,"quotazione")
		 ll_id_azienda=dw_single.getitemnumber(i,"id_azienda")
		 ll_data_quotazione=dw_single.GetItemDateTime(i,"data_quotazione")
		 
		 INSERT INTO "orafo_storico_metallo"  
         ( "id_metallo","quotazione","data_quotazione","id_azienda", "id_valuta" )  
            VALUES ( :ll_id_metallo,:ll_quotazione,:ll_data_quotazione,:ll_id_azienda, :ll_id_valuta )
				USING sqlca;
				if sqlca.sqlnrows >= 1 then 
				
					errore = errore or false
				else
					messagebox("qwery",sqlca.sqlerrtext)
					errore = errore or true
				end if
			
    END IF 
NEXT
if not(errore) and almeno_uno then 
	messagebox('Memorizza per storico','Memorizzazione avvenuta')
else
	messagebox('Memorizza per storico','Errore: Almeno una memorizzazione non è andata a buon fine!')
end if

dw_single.retrieve()
end event

