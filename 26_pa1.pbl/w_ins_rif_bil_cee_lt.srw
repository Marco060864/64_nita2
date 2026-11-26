forward
global type w_ins_rif_bil_cee_lt from w_np_single_data
end type
type cb_1 from commandbutton within w_ins_rif_bil_cee_lt
end type
type cb_2 from commandbutton within w_ins_rif_bil_cee_lt
end type
type cb_3 from commandbutton within w_ins_rif_bil_cee_lt
end type
type cb_4 from commandbutton within w_ins_rif_bil_cee_lt
end type
type sotto from dropdownlistbox within w_ins_rif_bil_cee_lt
end type
type st_1 from statictext within w_ins_rif_bil_cee_lt
end type
end forward

global type w_ins_rif_bil_cee_lt from w_np_single_data
int X=590
int Y=828
int Width=2761
int Height=1740
boolean TitleBar=true
string Title="Inserimento riferimenti cee"
long BackColor=78682240
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
sotto sotto
st_1 st_1
end type
global w_ins_rif_bil_cee_lt w_ins_rif_bil_cee_lt

on w_ins_rif_bil_cee_lt.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.sotto=create sotto
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.sotto
this.Control[iCurrent+6]=this.st_1
end on

on w_ins_rif_bil_cee_lt.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.sotto)
destroy(this.st_1)
end on

event resize;
end event

event ue_insert;
end event

event open;call super::open;dw_single.retrieve()


end event

type p_crescente from w_np_single_data`p_crescente within w_ins_rif_bil_cee_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_ins_rif_bil_cee_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_ins_rif_bil_cee_lt
int X=18
int Y=164
int Width=2633
int Height=1404
int TabOrder=10
string DataObject="d_associa_bil_cee"
end type

event dw_single::ue_insert;

end event

event dw_single::itemchanged;integer ll_rif, ll_id_bil
string ls_tipo, ls_pos1, ls_pos2, ls_pos3, ls_pos4, ls_des

IF dwo.name="riferimento" THEN	
	
	ll_rif=integer(data)

	select id_bilancio_cee, descrizione, tipo, pos1, pos2, pos3, pos4
	into :ll_id_bil, :ls_des, :ls_tipo, :ls_pos1, :ls_pos2, :ls_pos3, :ls_pos4
	from bilancio_cee where riferimento=:ll_rif ;
	
	if sqlca.sqlcode=0 then
		dw_single.setitem(row,'id_bilancio_cee',ll_id_bil)
		dw_single.setitem(row,'cee_des',ls_des)
		dw_single.setitem(row,'tipo',ls_tipo)
		dw_single.setitem(row,'pos1',ls_pos1)
		dw_single.setitem(row,'pos2',ls_pos2)
		dw_single.setitem(row,'pos3',ls_pos3)
		dw_single.setitem(row,'pos4',ls_pos4)
	else
		messagebox('ATTENZIONE','Non esiste nessuna voce del bilancio cee ~r~ncorrispondente al riferimento inserito!')
		return 2
	end if	

		
END IF
end event

type cb_1 from commandbutton within w_ins_rif_bil_cee_lt
int X=2290
int Y=36
int Width=366
int Height=96
int TabOrder=40
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_single.update()
end event

type cb_2 from commandbutton within w_ins_rif_bil_cee_lt
int X=37
int Y=36
int Width=366
int Height=96
int TabOrder=30
boolean BringToTop=true
string Text="Annulla/Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_ins_rif_bil_cee_lt
int X=745
int Y=36
int Width=183
int Height=96
int TabOrder=50
boolean BringToTop=true
string Text="Pag +"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_single.ScrollNextPage ( ) 
end event

type cb_4 from commandbutton within w_ins_rif_bil_cee_lt
int X=558
int Y=36
int Width=183
int Height=96
int TabOrder=20
boolean BringToTop=true
string Text="Pag -"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_single.ScrollPriorPage ( ) 

end event

type sotto from dropdownlistbox within w_ins_rif_bil_cee_lt
int X=1650
int Y=44
int Width=539
int Height=348
int TabOrder=60
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"1- Tutti",&
"2- Fornitori",&
"3- Clienti"}
end type

event selectionchanged;string ls_fo, ls_cl

select pref_cod_cliente, pref_cod_fornitore
into :ls_cl, :ls_fo
from par_sistema;


CHOOSE CASE index
	CASE 1
		dw_single.SetFilter( "")
		dw_single.filter()
		
	CASE 2
		dw_single.SetFilter( "codice like '"+ls_fo+"%'")
		dw_single.filter()
		
	CASE 3
		dw_single.SetFilter( "codice like '"+ls_cl+"%'")
		dw_single.filter()
		
END CHOOSE

end event

type st_1 from statictext within w_ins_rif_bil_cee_lt
int X=1257
int Y=56
int Width=352
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Tipo conto:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

