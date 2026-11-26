forward
global type w_dissocia_partite_cx from w_wiz_main
end type
type tab_1 from tab within w_dissocia_partite_cx
end type
type tabpage_2 from userobject within tab_1
end type
type ln_3 from line within tabpage_2
end type
type dw_2 from u_dw_pura within tabpage_2
end type
type dw_3 from u_dw_pura within tabpage_2
end type
type sle_dr from singlelineedit within tabpage_2
end type
type sle_av from singlelineedit within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type ln_1 from line within tabpage_2
end type
type ln_2 from line within tabpage_2
end type
type cb_annulla from commandbutton within w_dissocia_partite_cx
end type
type dw_1 from u_dw_ext_main within w_dissocia_partite_cx
end type
type cb_1 from commandbutton within w_dissocia_partite_cx
end type
type tabpage_2 from userobject within tab_1
ln_3 ln_3
dw_2 dw_2
dw_3 dw_3
sle_dr sle_dr
sle_av sle_av
st_1 st_1
st_2 st_2
cb_2 cb_2
ln_1 ln_1
ln_2 ln_2
end type
type tab_1 from tab within w_dissocia_partite_cx
tabpage_2 tabpage_2
end type
end forward

global type w_dissocia_partite_cx from w_wiz_main
int Width=2958
int Height=1672
WindowType WindowType=response!
boolean TitleBar=true
string Title="Utility partite aperte"
long BackColor=80263581
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
tab_1 tab_1
cb_annulla cb_annulla
dw_1 dw_1
cb_1 cb_1
end type
global w_dissocia_partite_cx w_dissocia_partite_cx

type variables
DataWindow idw_filtro, idw_recuperati, idw_selezionati
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
long ll_val
end variables

on w_dissocia_partite_cx.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
end on

on w_dissocia_partite_cx.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;long 	 ll_Conto
string ls_des, ls_cod

dw_1.SetTransObject(SQLCA)
dw_1.insertrow(0)


ib_removing = FALSE


tab_1.tabpage_2.dw_2.SetTransObject(SQLCA)
tab_1.tabpage_2.dw_3.SetTransObject(SQLCA)






select e.id_valuta into :ll_val 
from esercizio e, azienda a where a.id_esercizio=e.id_esercizio;
dw_1.setitem(1,'id_valuta',ll_val)

ll_conto=message.doubleparm
if ll_conto<>0 and not isnull(ll_conto) then
   select codice, descrizione
	into :ls_cod,:ls_des
	from conto
	where id_conto=:ll_conto;
	dw_1.setitem(1,'id_conto',ll_conto)
	dw_1.setitem(1,'da_cod',ls_cod)
	dw_1.setitem(1,'da_des',ls_des)
   cb_1.TriggerEvent(Clicked!)
end if	
end event

type tab_1 from tab within w_dissocia_partite_cx
int X=27
int Y=332
int Width=2843
int Height=1196
int TabOrder=10
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_2)
end on

event selectionchanged;
end event

event selectionchanging;choose case newindex
	case 2
		if (oldindex=3  or oldindex=4) then
			return 1
		end if
end choose
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2807
int Height=1076
long BackColor=80263328
string Text="Seleziona"
long TabBackColor=80263328
long TabTextColor=33554432
long PictureMaskColor=536870912
ln_3 ln_3
dw_2 dw_2
dw_3 dw_3
sle_dr sle_dr
sle_av sle_av
st_1 st_1
st_2 st_2
cb_2 cb_2
ln_1 ln_1
ln_2 ln_2
end type

on tabpage_2.create
this.ln_3=create ln_3
this.dw_2=create dw_2
this.dw_3=create dw_3
this.sle_dr=create sle_dr
this.sle_av=create sle_av
this.st_1=create st_1
this.st_2=create st_2
this.cb_2=create cb_2
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.ln_3,&
this.dw_2,&
this.dw_3,&
this.sle_dr,&
this.sle_av,&
this.st_1,&
this.st_2,&
this.cb_2,&
this.ln_1,&
this.ln_2}
end on

on tabpage_2.destroy
destroy(this.ln_3)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.sle_dr)
destroy(this.sle_av)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type ln_3 from line within tabpage_2
boolean Enabled=false
int BeginX=1102
int BeginY=972
int EndX=1710
int EndY=972
int LineThickness=8
long LineColor=33554432
end type

type dw_2 from u_dw_pura within tabpage_2
int X=14
int Y=24
int Width=1289
int TabOrder=11
boolean BringToTop=true
string DataObject="d_dissocia_seg_piu_gd"
boolean TitleBar=true
string Title="Dare"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;IF ROW>0 THEN
	this.selectrow(0,false)
	tab_1.tabpage_2.dw_3.selectrow(0,false)
	this.selectrow(row,true)
	tab_1.tabpage_2.dw_3.selectrow(row,true)
END IF
end event

event rowfocuschanged;

IF ib_removing = FALSE THEN
	IF NOT KeyDown(KeyControl!) AND NOT KeyDown(KeyShift!) THEN
		SelectRow(0,FALSE)
		SelectRow(currentrow, TRUE)
	END IF
	
	IF KeyDown(KeyShift!) THEN
		SelectRow(currentrow, NOT THIS.IsSelected(currentrow))
	END IF
END IF
end event

event sqlpreview;
end event

type dw_3 from u_dw_pura within tabpage_2
int X=1449
int Y=24
int Width=1298
int TabOrder=11
boolean BringToTop=true
string DataObject="d_dissocia_seg_meno_gd"
boolean TitleBar=true
string Title="Avere"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;IF ROW>0 THEN
	this.selectrow(0,false)
	tab_1.tabpage_2.dw_2.selectrow(0,false)
	this.selectrow(row,true)
	tab_1.tabpage_2.dw_2.selectrow(row,true)
END IF
end event

event retrievestart;return 2
end event

type sle_dr from singlelineedit within tabpage_2
int X=695
int Y=956
int Width=247
int Height=92
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_av from singlelineedit within tabpage_2
int X=2514
int Y=960
int Width=247
int Height=92
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within tabpage_2
int X=5
int Y=968
int Width=667
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Partite in dare recuperate:"
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

type st_2 from statictext within tabpage_2
int X=1815
int Y=972
int Width=695
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Partite in avere recuperate:"
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

type cb_2 from commandbutton within tabpage_2
int X=1161
int Y=900
int Width=443
int Height=144
int TabOrder=30
boolean BringToTop=true
string Text="Dissocia partite"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long  ll_row, ll_mov_partita, ll_partita, ll_associata, ll_scad[], i, j, ll_test

ll_row=dw_2.GetSelectedRow(0)
if ll_row<=0  then
	messagebox('Attenzione',"In una delle finestre non è stata selezionata alcuna riga.~r~nImpossibile proseguire con l'associazione delle partite")   
	return
end if

ll_mov_partita=dw_2.getitemnumber(ll_row,'id_mov_partita')
ll_partita=dw_2.getitemnumber(ll_row,'id_par_aperta')
ll_associata=dw_2.getitemnumber(ll_row,'id_par_associata')


DECLARE cur_partita CURSOR FOR
	SELECT id_scadenza
   FROM mov_scadenza
	WHERE id_mov_partita=:ll_mov_partita;
				
	OPEN cur_partita;
	
	
	i=1
	
	FETCH cur_partita INTO :ll_scad[i];
	DO WHILE SQLCA.SQLCode = 0
		  i=i+1
		  FETCH cur_partita INTO :ll_scad[i];
	LOOP
close cur_partita;
for j=1 to ( i	-1 )	
	select id_riga_distinta_banca
	into :ll_test
	from scadenza
	where id_scadenza=:ll_scad[j];
	if isnull(ll_test) then
			update scadenza
			set esito_pagamento='E'
			where id_scadenza=:ll_scad[j];
			commit;
	else
			update scadenza
			set esito_pagamento='D'
			where id_scadenza=:ll_scad[j];
			commit;
	end if	
	commit;
next
DELETE FROM mov_scadenza WHERE id_mov_partita=:ll_mov_partita;
	

DELETE FROM mov_partita WHERE id_mov_partita=:ll_mov_partita;					

update par_aperta 
set stato='A'
where id_par_aperta=:ll_partita or id_par_aperta=:ll_associata;
commit; 

cb_1.TriggerEvent(Clicked!)



end event

type ln_1 from line within tabpage_2
boolean Enabled=false
int BeginX=1102
int BeginY=848
int EndX=1102
int EndY=964
int LineThickness=8
long LineColor=33554432
end type

type ln_2 from line within tabpage_2
boolean Enabled=false
int BeginX=1719
int BeginY=848
int EndX=1719
int EndY=968
int LineThickness=8
long LineColor=33554432
end type

type cb_annulla from commandbutton within w_dissocia_partite_cx
int X=2528
int Y=32
int Width=329
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="&Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
closewithreturn(parent,1)
end event

type dw_1 from u_dw_ext_main within w_dissocia_partite_cx
int X=27
int Y=40
int Width=2418
int Height=256
int TabOrder=20
boolean BringToTop=true
string DataObject="d_ass_partite_fil_ff"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	
	CASE "da_cod", "da_des"
		
      is_search_window = "w_conti_pdc_sw"
		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "da_des" THEN
			
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
end choose		
end event

event ue_use_search;CHOOSE CASE as_nomecol
CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])
		
		
	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		
end choose		
end event

event itemchanged;
string ls_dbc[], ls_dbv[], ls_dwc[]

integer li_ok



choose case dwo.name
	CASE "da_cod"

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "da_des"

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF

END CHOOSE

end event

type cb_1 from commandbutton within w_dissocia_partite_cx
int X=2528
int Y=160
int Width=338
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="Carica partite"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_data
long ll_conto, ll_ret
long ll_id_reg_pd,ll_par_aperta,i, ll_associata,l

ll_conto=dw_1.getitemnumber(1,'id_conto')
ll_val=dw_1.getitemnumber(1,'id_valuta') 

tab_1.tabpage_2.dw_3.reset()
tab_1.tabpage_2.dw_2.reset()

if not isnull(ll_conto) then 
	ld_data=dw_1.getitemdate(1,'data_reg')
	if isnull(ld_data) then ld_data=date('01/01/1980')
	ll_ret=tab_1.tabpage_2.dw_2.retrieve(ll_conto,ld_data,ll_val)
	tab_1.tabpage_2.sle_dr.text=string(ll_ret)
	if ll_RET<>0 then
		for i=1 to ll_ret 
			ll_associata=tab_1.tabpage_2.dw_2.getitemnumber(i,'id_par_aperta')
			ll_par_aperta=tab_1.tabpage_2.dw_2.getitemnumber(i,'id_par_associata')
			l=tab_1.tabpage_2.dw_3.retrieve(ll_conto,ll_associata,ld_data,ll_par_aperta,ll_val)
			
		next
		tab_1.tabpage_2.dw_3.selectrow(1,true)
		tab_1.tabpage_2.dw_2.selectrow(1,true)
	end if
	tab_1.tabpage_2.sle_av.text=string(tab_1.tabpage_2.dw_3.rowcount())
	
else 
	messagebox('Attenzione', 'Non hai selezionato nessun conto')
end if


end event

