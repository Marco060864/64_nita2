forward
global type w_rimedia from w_pop
end type
type dw_2 from udw_001 within w_rimedia
end type
type st_1 from statictext within w_rimedia
end type
end forward

global type w_rimedia from w_pop
integer width = 5403
integer height = 2788
dw_2 dw_2
st_1 st_1
end type
global w_rimedia w_rimedia

type variables
transaction trans_customer
end variables

on w_rimedia.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_1
end on

on w_rimedia.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_1)
end on

event open;call super::open;string ls_connect, ls_des_old, ls_des_attuale, ls_cod_art
long ll_righe, i, ll_id_riga, ll_riga_trovata

trans_customer = CREATE transaction  // Set connection parameters in the transaction 
trans_customer.DBMS = "ODBC"
ls_connect = "ConnectString='DSN=rimedia'"
trans_customer.dbparm=ls_connect

CONNECT USING trans_customer;
if SQLCA.SQLCode<0 then
	messagebox("A", "ER")
else
	
	dw_2.SetTransObject(trans_customer)
	//dw_2.Retrieve()

end if
//ll_righe=dw_1.retrieve()
//for i= 1 to ll_righe
//	ll_id_riga=0
//	ll_riga_trovata=0
//	ll_id_riga=dw_1.getitemnumber(i, "id_riga_documento")
//	dw_2.retrieve(ll_id_riga)
//	
////	ll_riga_trovata=dw_2.find("id_riga_documento="+string(ll_id_riga), 1, ll_righe)
////	if ll_riga_trovata>0 then
////		ls_des_old=dw_2.getitemstring(ll_riga_trovata, "descrizione")
////		ls_des_attuale=dw_1.getitemstring(i, "descrizione")
////		ls_cod_art=dw_1.getitemstring(i, "articolo_codice")
////		if isnull(ls_des_attuale) or ls_des_attuale<=" " then 
////			ls_des_attuale=ls_cod_art+"£"
////			continue
////		end if
////			
////		IF ls_des_old=ls_des_attuale then continue
////		
////		if pos(ls_des_attuale, ls_cod_art)<=0 then
////			if pos(ls_des_attuale, ls_cod_art)<=0 then
////				ls_des_attuale+=ls_cod_art+" £ "
////			end if
////		end if
////	else
////		dw_1.modify("articolo_codice.backcolor=255")
////	end if
//	
//next



//trans_destinazione = CREATE transaction
//// Set connection parameters in the transaction object
//trans_destinazione.DBMS = "ODBC"
//trans_destinazione.DBParm = "ConnectString='DSN="+ls_odbc_destinazione+"'"
//CONNECT USING trans_destinazione;
//
//dw_1.settransobject(trans_destinazione)
end event

event close;call super::close;destroy trans_customer
end event

event ue_postopen;call super::ue_postopen;long ll_righe, ll_id_riga, i
string ls_des_attuale, ls_des_old, ls_cod_art

ll_righe=dw_1.retrieve()
connect using trans_customer;
for i= 1 to ll_righe
	ll_id_riga=0
//	ll_riga_trovata=0
	ll_id_riga=dw_1.getitemnumber(i, "id_riga_documento")
	
	select descrizione
	into :ls_des_old
	from dba.riga_Documento
	where id_riga_documento=:ll_id_riga;
	ls_des_attuale=dw_1.getitemstring(i, "descrizione")
	if isnull(ls_des_attuale) or ls_des_attuale<=" " then 
		ls_cod_art=dw_1.getitemstring(i, "articolo_codice")
		ls_des_attuale=ls_cod_art+"£"
		//dw_2.retrieve(ll_id_riga)
	else
		if ls_des_attuale=ls_des_old then
			continue
		else
			ls_des_attuale=ls_des_old
		end if
	end if
	dw_1.setitem(i, "descrizione", ls_des_attuale+"£")
next
end event

type dw_1 from w_pop`dw_1 within w_rimedia
integer x = 14
integer y = 44
integer width = 2624
integer height = 2120
string dataobject = "d_rimedia"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_2 from udw_001 within w_rimedia
integer x = 2679
integer y = 40
integer width = 2624
integer height = 2120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_rimedia_old"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type st_1 from statictext within w_rimedia
integer x = 4846
integer y = 2172
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "!19"
boolean focusrectangle = false
end type

