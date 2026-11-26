forward
global type w_stampa_riep_art_ff from Window
end type
type st_2 from statictext within w_stampa_riep_art_ff
end type
type ddlb_anno from dropdownlistbox within w_stampa_riep_art_ff
end type
type sle_1 from singlelineedit within w_stampa_riep_art_ff
end type
type cb_mag from checkbox within w_stampa_riep_art_ff
end type
type dw_2 from datawindow within w_stampa_riep_art_ff
end type
type cb_8 from commandbutton within w_stampa_riep_art_ff
end type
type cb_7 from commandbutton within w_stampa_riep_art_ff
end type
type cb_5 from commandbutton within w_stampa_riep_art_ff
end type
type cb_2 from commandbutton within w_stampa_riep_art_ff
end type
type dw_1 from datawindow within w_stampa_riep_art_ff
end type
type cb_3 from commandbutton within w_stampa_riep_art_ff
end type
type cb_4 from commandbutton within w_stampa_riep_art_ff
end type
type st_1 from statictext within w_stampa_riep_art_ff
end type
type cb_9 from commandbutton within w_stampa_riep_art_ff
end type
end forward

global type w_stampa_riep_art_ff from Window
int X=5
int Y=48
int Width=3205
int Height=2184
boolean TitleBar=true
long BackColor=78748035
boolean ControlMenu=true
WindowType WindowType=response!
st_2 st_2
ddlb_anno ddlb_anno
sle_1 sle_1
cb_mag cb_mag
dw_2 dw_2
cb_8 cb_8
cb_7 cb_7
cb_5 cb_5
cb_2 cb_2
dw_1 dw_1
cb_3 cb_3
cb_4 cb_4
st_1 st_1
cb_9 cb_9
end type
global w_stampa_riep_art_ff w_stampa_riep_art_ff

type variables
long il_zoom, k, il_articolo, il_object, il_anno, il_magaz
string is_tipo_mov
string selezione
end variables

forward prototypes
public subroutine fn_retrieve ()
end prototypes

public subroutine fn_retrieve ();il_magaz=dw_2.getitemnumber(k,'id_magazzino')


if ddlb_anno.text='Tutti' then
	if cb_mag.checked = true then
		il_object=1
		dw_1.retrieve(il_articolo,0,is_tipo_mov)
	else	
		il_object=2
		dw_1.retrieve(il_articolo,il_magaz,is_tipo_mov)
	end if
else
	il_anno=long(ddlb_anno.text)
	if cb_mag.checked=true then
		il_object=3
		dw_1.retrieve(il_articolo,0,is_tipo_mov)
	else	
		il_object=4
		dw_1.retrieve(il_articolo,il_magaz,is_tipo_mov)
	end if
end if	
end subroutine

on w_stampa_riep_art_ff.create
this.st_2=create st_2
this.ddlb_anno=create ddlb_anno
this.sle_1=create sle_1
this.cb_mag=create cb_mag
this.dw_2=create dw_2
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.st_1=create st_1
this.cb_9=create cb_9
this.Control[]={this.st_2,&
this.ddlb_anno,&
this.sle_1,&
this.cb_mag,&
this.dw_2,&
this.cb_8,&
this.cb_7,&
this.cb_5,&
this.cb_2,&
this.dw_1,&
this.cb_3,&
this.cb_4,&
this.st_1,&
this.cb_9}
end on

on w_stampa_riep_art_ff.destroy
destroy(this.st_2)
destroy(this.ddlb_anno)
destroy(this.sle_1)
destroy(this.cb_mag)
destroy(this.dw_2)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.cb_9)
end on

event open;s_list_main		lstr_list
long  ll_id_magaz, i, ll_magaz[]
string ls_magaz

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
selezione=''

lstr_list=Message.powerobjectparm 

is_tipo_mov=lstr_list.s_provenienza
il_articolo=lstr_list.l_identifica[1]


cb_mag.Checked=false
long ll_anno
date ld_date

select min(data_fine)
into :ld_date
from esercizio;
ll_anno=year(ld_date)

for i=ll_anno to year(today())
	ddlb_anno.InsertItem ( string(i), (i - ll_anno + 2) )
next	
ddlb_anno.text='Tutti'


if isnull(is_tipo_mov) then is_tipo_mov='Q'

DECLARE cur_magaz CURSOR FOR 
   select m.id_magazzino
	from magazzino m, locazione l, riepilogo r
	where m.id_magazzino=l.id_magazzino and l.id_locazione=r.id_locazione and r.id_articolo=:il_articolo
	group by m.id_magazzino order by m.id_magazzino;

	OPEN cur_magaz;
	FETCH cur_magaz INTO :ll_magaz[1];
   i=1
 
	DO WHILE SQLCA.SQLCode = 0  
		i=i+1
	   if selezione<>'' then 
			selezione=selezione + ","  + string(ll_magaz[i - 1])
		else
	      selezione= string(ll_magaz[i - 1])
		end if
		FETCH cur_magaz INTO :ll_magaz[i];
	LOOP

close cur_magaz;

if SELEZIONE<>'' then
	K=1
	dw_2.retrieve(selezione)
	dw_2.SelectRow ( 1, true )
	if dw_2.rowcount()>0 then
		ll_id_magaz=dw_2.getitemnumber(1,'id_magazzino')
		ls_magaz=dw_2.getitemstring(1,'codice')
		sle_1.text=ls_magaz
	end if
	
	fn_retrieve()
	if dw_2.rowcount()<2 then
		cb_3.visible=false
		cb_4.visible=false
	   cb_9.visible=false
	end if	
else
	messagebox('Attenzione', "L'articolo non ha nessuno storico nei magazzini")
end if

il_zoom=100


dw_2.visible=false
end event

type st_2 from statictext within w_stampa_riep_art_ff
int X=1531
int Y=52
int Width=142
int Height=68
boolean Enabled=false
string Text="Anno:"
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

type ddlb_anno from dropdownlistbox within w_stampa_riep_art_ff
int X=1691
int Y=40
int Width=306
int Height=464
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AllowEdit=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Tutti"}
end type

event selectionchanged;fn_retrieve()
end event

type sle_1 from singlelineedit within w_stampa_riep_art_ff
int X=5
int Y=76
int Width=311
int Height=76
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_mag from checkbox within w_stampa_riep_art_ff
int X=1102
int Y=44
int Width=347
int Height=76
string Text="Tutti  magaz."
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cb_mag.Checked=true then
	
	
	fn_retrieve()
	
	cb_3.visible=false
	cb_4.visible=false
	cb_9.visible=false
	sle_1.visible=false
	st_1.visible=false
else
	long ll_id_magaz
	k=1
	ll_id_magaz=dw_2.getitemnumber(1,'id_magazzino')
	
	
	fn_retrieve()
   
	if dw_2.rowcount()>1 then
		cb_3.visible=true
		cb_4.visible=true
	   cb_9.visible=true
		sle_1.visible=true
		st_1.visible=true
	end if	
end if	
end event

type dw_2 from datawindow within w_stampa_riep_art_ff
int X=5
int Y=156
int Width=1362
int Height=1904
int TabOrder=20
string DataObject="d_lista_magazzini"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;string ls_sql

ls_sql=sqlsyntax +  "WHERE id_magazzino in ("+selezione+")"
setsqlpreview(ls_sql)


end event

event clicked;if row>0 then
IF KeyDown(KeyControl!) THEN
	dw_2.SelectRow ( row, true )
ELSE	
	dw_2.SelectRow ( 0, false )
	dw_2.SelectRow ( row, true )
	k=row - 1
	cb_4.TriggerEvent(Clicked!)
	
	dw_2.visible=false
END IF
end if 
end event

type cb_8 from commandbutton within w_stampa_riep_art_ff
int X=2213
int Y=40
int Width=320
int Height=92
int TabOrder=90
string Text="Stp Completo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()



if cb_mag.Checked=true then
	
	
	fn_retrieve()
	
	dw_1.print()
else	
	INTEGER  i
	for i=1 to dw_2.rowcount()
		
		fn_retrieve()
		dw_1.print()
		dw_2.visible=false
	next
end if	

end event

type cb_7 from commandbutton within w_stampa_riep_art_ff
int X=2921
int Y=40
int Width=315
int Height=92
int TabOrder=80
boolean Visible=false
string Text="Salva su file"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_5 from commandbutton within w_stampa_riep_art_ff
int X=2930
int Y=40
int Width=247
int Height=92
int TabOrder=100
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_stampa_riep_art_ff
int X=2546
int Y=40
int Width=347
int Height=92
int TabOrder=30
string Text="Stp Selezionati"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()

INTEGER  li_ret

integer li_row
li_row=0
DO WHILE dw_2.GetSelectedRow(li_row)<>0
	   li_row=dw_2.GetSelectedRow(li_row)
		
		fn_retrieve()
		dw_1.print()
LOOP

dw_2.visible=false

end event

type dw_1 from datawindow within w_stampa_riep_art_ff
int Y=156
int Width=3182
int Height=1912
int TabOrder=10
string DataObject="d_riep_articolo_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;long reg_pd
if row>0 then
	reg_pd=dw_1.getitemnumber(row,'id_reg_pd')
	s_list_main idw_master
	idw_master.l_identifica[1]=reg_pd
	idw_master.s_identifica[1]='id_reg_pd'
	idw_master.s_modo=modo_modifica
	idw_master.s_win_chiave[1]='id_reg_pd'
	idw_master.s_provenienza='richiamo'
	openwithparm(w_reg_pd_cx,idw_master)
end if	
end event

event retrievestart;
end event

event sqlpreview;long ll_pos, ll_len
string ls_pre, ls_post, ls_sqlsyntax


ll_pos =Pos(sqlsyntax,"WHERE") + 5
ll_len=len(sqlsyntax) - ll_pos 
ls_post=Right (sqlsyntax, ll_len)
ls_pre=left(sqlsyntax, ll_pos)

CHOOSE CASE il_object

	CASE 2
		ls_sqlsyntax = ls_pre + "locazione.id_magazzino=" +string(il_magaz)+" and "+ls_post
		
	CASE 3	
		ls_sqlsyntax = ls_pre + "riepilogo.anno=" +string(il_anno)+" and "+ls_post
		
	CASE 4	
		ls_sqlsyntax = ls_pre + "locazione.id_magazzino=" +string(il_magaz)+ " and riepilogo.anno=" +string(il_anno)+" and "+ls_post
		
END CHOOSE

if il_object<>1 then setsqlpreview(ls_sqlsyntax)



end event

type cb_3 from commandbutton within w_stampa_riep_art_ff
int X=462
int Y=40
int Width=279
int Height=92
int TabOrder=40
boolean BringToTop=true
string Text="Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if (k - 1)>0 then 
	 k=k - 1
	 dw_2.SelectRow ( 0, false )
	 dw_2.SelectRow ( k, true )
	 fn_retrieve()
	 sle_1.text=dw_2.getitemstring(K,'codice')
end if	 
end event

type cb_4 from commandbutton within w_stampa_riep_art_ff
int X=759
int Y=40
int Width=279
int Height=92
int TabOrder=50
boolean BringToTop=true
string Text="Successivo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if (k + 1)<=dw_2.rowcount() then 
	 k=k + 1
	 dw_2.SelectRow ( 0, false )
	 dw_2.SelectRow ( k, true )
	 fn_retrieve()
	 sle_1.text=dw_2.getitemstring(K,'codice')
end if	
end event

type st_1 from statictext within w_stampa_riep_art_ff
int X=14
int Y=4
int Width=288
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Magazzino"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_9 from commandbutton within w_stampa_riep_art_ff
int X=315
int Y=80
int Width=73
int Height=68
int TabOrder=60
boolean BringToTop=true
string Text="V"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_2.visible=true
end event

