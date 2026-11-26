forward
global type w_orafo_saldi_chiusura_sel_gd from Window
end type
type cb_3 from commandbutton within w_orafo_saldi_chiusura_sel_gd
end type
type cb_cancel from commandbutton within w_orafo_saldi_chiusura_sel_gd
end type
type cb_ok from commandbutton within w_orafo_saldi_chiusura_sel_gd
end type
type cb_2 from commandbutton within w_orafo_saldi_chiusura_sel_gd
end type
type cb_1 from commandbutton within w_orafo_saldi_chiusura_sel_gd
end type
type dw_1 from datawindow within w_orafo_saldi_chiusura_sel_gd
end type
end forward

global type w_orafo_saldi_chiusura_sel_gd from Window
int X=644
int Y=273
int Width=1796
int Height=1261
boolean TitleBar=true
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_3 cb_3
cb_cancel cb_cancel
cb_ok cb_ok
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_orafo_saldi_chiusura_sel_gd w_orafo_saldi_chiusura_sel_gd

type variables


end variables

on w_orafo_saldi_chiusura_sel_gd.create
this.cb_3=create cb_3
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_3,&
this.cb_cancel,&
this.cb_ok,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_orafo_saldi_chiusura_sel_gd.destroy
destroy(this.cb_3)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;Long ll_ID_sog_commerciale
String ls_cod_sog_commerciale, ls_rag_soc_1

ll_ID_sog_commerciale = Message.DoubleParm

SELECT s.codice, a.rag_soc_1
INTO   :ls_cod_sog_commerciale, :ls_rag_soc_1
FROM   sog_commerciale s, anagrafica a
WHERE  s.id_sog_commerciale = :ll_ID_sog_commerciale
AND    a.id_anagrafica = s.id_anagrafica;

CHOOSE CASE SQLca.SQLcode
	CASE 0
		this.Title = "Chiusure schede di " + ls_cod_sog_commerciale + ' - ' + ls_rag_soc_1 

		
		dw_1.settransobject(sqlca)
		dw_1.Retrieve(ll_id_sog_commerciale)
	CASE 100, -1
		Return
END CHOOSE
end event

type cb_3 from commandbutton within w_orafo_saldi_chiusura_sel_gd
int X=1394
int Y=333
int Width=324
int Height=84
int TabOrder=21
string Text="Elimina"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long li_ret, ll_row, ll_id_sog_com
datetime ld_data

li_ret=messagebox('Attenzione!','Eliminando una chiusura verranno eliminate anche quelle successive!'+char(13)+&
					+'Procedere alla cancellazone?',Exclamation!,YesNo!)
if li_ret=2 then return

ll_row=dw_1.GetRow()
ll_id_sog_com=dw_1.getItemNumber(ll_row,"id_sog_commerciale")
ld_data=dw_1.getItemdateTime(ll_row,"data_chiusura")
delete orafo_saldi_chiusi
where (orafo_saldi_chiusi.data_chiusura>=:ld_data)
and(orafo_saldi_chiusi.id_sog_commerciale=:ll_id_sog_com);
dw_1.retrieve(ll_id_sog_com)

					

end event

type cb_cancel from commandbutton within w_orafo_saldi_chiusura_sel_gd
int X=1394
int Y=833
int Width=324
int Height=84
int TabOrder=30
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_orafo_saldi_chiusura_sel_gd
int X=1398
int Y=1015
int Width=324
int Height=84
int TabOrder=40
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_id_sog_com, row, i
w_orafo_saldi_cliente_cx lw_saldi

date dd
time tt
string ls_temp
datetime dt1, dt2

row=dw_1.GetRow()
if row>0 then
	ll_id_sog_com= dw_1.GetItemNumber(row,"id_sog_commerciale")
	if ll_id_sog_com>0 and not isnull(ll_id_sog_com) then 
		s_list_main lstr_for_win
		
		lstr_for_win.s_modo = modo_modifica
		lstr_for_win.s_identifica[1] = "id_sog_commerciale"
		lstr_for_win.l_identifica[1] = ll_id_sog_com
		dt1=dw_1.GetItemDateTime(row,"data_chiusura")
	
		dd=date(dt1)
		tt=time(dt1)
	
		lstr_for_win.s_identifica[2] = string(dd)
		lstr_for_win.s_identifica[3] = string(tt)	
		
		i=row
		do while i>0
			dt2=dw_1.GetItemDateTime(i,"data_chiusura")
			if dt2<>dt1 then
				dd=date(dt2)
				tt=time(dt2)
			
				lstr_for_win.s_identifica[4] = string(dd)
				lstr_for_win.s_identifica[5] = string(tt)	
				i=row
				exit
			end if
			i --
		loop
		if i<>row then
			dd=date('01/01/1990')
			tt=time('00.00.00')
			
			lstr_for_win.s_identifica[4] = string(dd)
			lstr_for_win.s_identifica[5] = string(tt)	
		end if
			
		openwithparm(lw_saldi, lstr_for_win)
	
	end if
else
	close(parent)
end if

end event

type cb_2 from commandbutton within w_orafo_saldi_chiusura_sel_gd
int X=1394
int Y=189
int Width=324
int Height=84
int TabOrder=20
boolean Visible=false
string Text="Elimina tutti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long row, ll_id_sog_com, i
datetime ld_data

row=dw_1.RowCount()
ld_data=dw_1.GetItemDateTime(row,"data_chiusura")
ll_id_sog_com=dw_1.GetItemNumber(row,"id_sog_commerciale")

if messagebox("Attenzione!","Verranno eliminati tutti i saldi tranne l'ultimo!"+char(13)+&
				   +"Proseguire?",Exclamation!,YesNo!)=2 then 
	return
end if

for i =1 to row
	if (dw_1.GetItemDateTime(i,"data_chiusura")<>ld_data)and(dw_1.GetItemNumber(i,"id_sog_commerciale")=ll_id_sog_com) then
		dw_1.DeleteRow(i)
		i --
		row --
	end if
next
dw_1.Update(true,false)
end event

type cb_1 from commandbutton within w_orafo_saldi_chiusura_sel_gd
int X=1394
int Y=55
int Width=324
int Height=84
int TabOrder=50
boolean Visible=false
string Text="Elimina saldo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long row, ll_id_sog_com, i
datetime ld_data

row=dw_1.GetRow()
ld_data=dw_1.GetItemDateTime(row,"data_chiusura")
ll_id_sog_com=dw_1.GetItemNumber(row,"id_sog_commerciale")

if messagebox("Attenzione!","Si vuole eliminare il saldo evidenziato ?"+char(13)+&
				  +"( "+string(ld_data)+" )",Exclamation!,YesNo!)=2 then 
	return
end if

for i =1 to dw_1.RowCount()
	if (dw_1.GetItemDateTime(i,"data_chiusura")=ld_data)and(dw_1.GetItemNumber(i,"id_sog_commerciale")=ll_id_sog_com) then
		dw_1.DeleteRow(i)
		i --
	end if
next
dw_1.Update(true,false)
end event

type dw_1 from datawindow within w_orafo_saldi_chiusura_sel_gd
int X=25
int Y=20
int Width=1320
int Height=1108
int TabOrder=10
string DataObject="d_orafo_saldi_sel_chiusi_tb"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;cb_ok.trigger event clicked()
end event

