forward
global type w_numera_gd from w_np_single_data
end type
type cb_1 from commandbutton within w_numera_gd
end type
type cb_2 from commandbutton within w_numera_gd
end type
type cb_3 from commandbutton within w_numera_gd
end type
end forward

global type w_numera_gd from w_np_single_data
int Width=3136
int Height=1752
boolean TitleBar=true
string Title="Inserimento dei codici a barre"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_numera_gd w_numera_gd

type variables
string is_ret
integer il_reg
end variables

forward prototypes
public subroutine wf_unita_base (long ll_row)
end prototypes

public subroutine wf_unita_base (long ll_row);Long ll_id_unita_confezione, ll_id_articolo
String ls_codice
			
ll_id_articolo = dw_single.GetItemNumber(ll_row, "unita_confezione_id_articolo")
			
SELECT id_unita_confezione, codice
INTO 	 :ll_id_unita_confezione, :ls_codice
FROM	 unita_confezione
WHERE	 id_articolo = :ll_id_articolo
AND	 unita_base = 'S'
;
			
CHOOSE CASE SQLCA.SQLCODE 
	CASE -1
		messagebox("", SQLCA.SQLERRTEXT)
	CASE 0
		dw_single.SetItem(ll_row, "id_unita_confezione", ll_id_unita_confezione)
		dw_single.SetItem(ll_row, "c_unita_confezione_cod", ls_codice)					
END CHOOSE 			
end subroutine

on w_numera_gd.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on w_numera_gd.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;is_ret='0'
il_reg=message.doubleparm
dw_single.retrieve(il_reg)



end event

event closequery;
end event

type p_crescente from w_np_single_data`p_crescente within w_numera_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_numera_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_numera_gd
int X=32
int Y=200
int Width=3022
int Height=1396
int TabOrder=10
string DataObject="d_rinum_reg_pd_lt"
boolean HSplitScroll=true
boolean LiveScroll=false
end type

event dw_single::retrieveend;integer i

if is_ret='0' then 
	for i=1 to dw_single.rowcount()
		 dw_single.setitem(i,'num_prog',i) 
	next
end if	


end event

type cb_1 from commandbutton within w_numera_gd
int X=2807
int Y=28
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_single.setsort("num_prog")
dw_single.sort()

integer i
for i=1 to dw_single.rowcount()
	 dw_single.setitem(i,'num_prog',32000 - dw_single.getitemnumber(i,'num_prog')) 
next
dw_single.update()
commit;

for i=1 to dw_single.rowcount()
	 dw_single.setitem(i,'num_prog',32000 - dw_single.getitemnumber(i,'num_prog')) 
next
dw_single.update()
commit;
is_ret='1'
dw_single.retrieve(il_reg)



		  
		  
		  
end event

type cb_2 from commandbutton within w_numera_gd
int X=32
int Y=28
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
close(parent)
end event

type cb_3 from commandbutton within w_numera_gd
int X=402
int Y=28
int Width=247
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
If messagebox('Attenzione','Vuoi effettuare il salvataggio dei dati?',Information!,Yesno!)=1 then
	cb_1.triggerevent(clicked!)
end if	

close(parent)
end event

