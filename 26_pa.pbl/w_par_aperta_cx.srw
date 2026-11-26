forward
global type w_par_aperta_cx from Window
end type
type cb_3 from commandbutton within w_par_aperta_cx
end type
type dw_filter from u_dw_master_main within w_par_aperta_cx
end type
type tab_par from tab within w_par_aperta_cx
end type
type tabpage_1 from userobject within tab_par
end type
type dw_aper from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_par
end type
type dw_chiu from datawindow within tabpage_2
end type
type cb_2 from commandbutton within w_par_aperta_cx
end type
type cb_1 from commandbutton within w_par_aperta_cx
end type
type tabpage_1 from userobject within tab_par
dw_aper dw_aper
end type
type tabpage_2 from userobject within tab_par
dw_chiu dw_chiu
end type
type tab_par from tab within w_par_aperta_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_par_aperta_cx from Window
int X=1056
int Y=484
int Width=2587
int Height=1564
boolean TitleBar=true
string Title="Ricerca Partite"
long BackColor=80263328
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_3 cb_3
dw_filter dw_filter
tab_par tab_par
cb_2 cb_2
cb_1 cb_1
end type
global w_par_aperta_cx w_par_aperta_cx

type variables
long il_conto
end variables

event open;dw_filter.settransobject(sqlca)
dw_filter.insertrow(0)

tab_par.tabpage_1.dw_aper.settransobject(sqlca)
tab_par.tabpage_2.dw_chiu.settransobject(sqlca)
end event

on w_par_aperta_cx.create
this.cb_3=create cb_3
this.dw_filter=create dw_filter
this.tab_par=create tab_par
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.dw_filter,&
this.tab_par,&
this.cb_2,&
this.cb_1}
end on

on w_par_aperta_cx.destroy
destroy(this.cb_3)
destroy(this.dw_filter)
destroy(this.tab_par)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_par_aperta_cx
int X=1842
int Y=20
int Width=247
int Height=96
int TabOrder=40
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_conto

ll_conto=dw_filter.getitemnumber(1,'id_conto')

if ll_conto>0 then
	openwithparm(w_gest_par_aperta_cx,'@'+string(ll_conto))
	
	tab_par.tabpage_1.dw_aper.Retrieve(il_conto)
	tab_par.tabpage_2.dw_chiu.Retrieve(il_conto)
	
else
	messagebox('Attenzione','Selezionare prima il conto!')
end if	
end event

type dw_filter from u_dw_master_main within w_par_aperta_cx
int X=37
int Y=152
int Width=2373
int Height=332
int TabOrder=40
string DataObject="d_partite_filtro_ff"
end type

event itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc
date			ld_data_inizio,ld_data
long			ll_a, ll_ok, ll_row, ll_scode, ll_temp

ll_row = GetRow()
if ll_row > 0 then
	CHOOSE CASE dwo.name
			
		CASE "cod"
			ls_sql_cond = ""
			ls_dbc[1] = "id_conto"
			ls_dwc[1] = "id_conto"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "des"
			ll_ok = uf_autofind_col(dwo.Name, "conto_pdc", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			
			if (ll_ok>0) then	
				il_conto = long(ls_dbv[1])
				tab_par.tabpage_1.dw_aper.Retrieve(il_conto)
				tab_par.tabpage_2.dw_chiu.Retrieve(il_conto)
				return 2
			end if

		CASE "des"
			ls_sql_cond = ""
			ls_dbc[1] = "id_conto"
			ls_dwc[1] = "id_conto"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "des"
			ll_ok = uf_autofind_col(dwo.Name, "conto_pdc", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			
			if (ll_ok>0) then	
				il_conto = long(ls_dbv[1])
				tab_par.tabpage_1.dw_aper.Retrieve(il_conto)
				tab_par.tabpage_2.dw_chiu.Retrieve(il_conto)
				return 2
			end if
			
		CASE "da_data"	
			string ls_filter
			ls_filter="data_partita>=date('"+data+"')"
			tab_par.tabpage_1.dw_aper.setfilter(ls_filter)
			tab_par.tabpage_1.dw_aper.filter()
			tab_par.tabpage_2.dw_chiu.setfilter(ls_filter)
			tab_par.tabpage_2.dw_chiu.filter()
			
	end choose
else
	MessageBox("Errore!","Riga nulla!")
end if
end event

event ue_set_search;call super::ue_set_search;

string ls_cond

CHOOSE CASE as_nomecol

	CASE "cod", "des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF

END CHOOSE	
end event

event ue_use_search;
long ll_row

ll_row = THIS.GetRow()

CHOOSE CASE as_nomecol
	CASE "cod"
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des", is_ricpar.s_ausil_value[1])
		
		il_conto = long(is_ricpar.s_id_seg_value[1])
		tab_par.tabpage_1.dw_aper.Retrieve(il_conto)
		tab_par.tabpage_2.dw_chiu.Retrieve(il_conto)
		
	CASE "des"
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod", is_ricpar.s_ausil_value[1])

		il_conto = long(is_ricpar.s_id_seg_value[1])
		tab_par.tabpage_1.dw_aper.Retrieve(il_conto)
		tab_par.tabpage_2.dw_chiu.Retrieve(il_conto)
		
END CHOOSE
		

end event

event getfocus;
end event

type tab_par from tab within w_par_aperta_cx
int X=32
int Y=540
int Width=2491
int Height=896
int TabOrder=20
boolean RaggedRight=true
int SelectedTab=1
long BackColor=80263328
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_par.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_par.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_par
int X=18
int Y=104
int Width=2455
int Height=776
long BackColor=80263328
string Text="Partite Aperte"
long TabBackColor=80263328
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_aper dw_aper
end type

on tabpage_1.create
this.dw_aper=create dw_aper
this.Control[]={this.dw_aper}
end on

on tabpage_1.destroy
destroy(this.dw_aper)
end on

type dw_aper from datawindow within tabpage_1
int X=23
int Y=32
int Width=2409
int Height=720
int TabOrder=40
string DataObject="d_lista_partite_conto"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;long par_ap
if row>0 then
	par_ap=dw_aper.getitemnumber(row,'id_par_aperta')
	openwithparm(w_gest_par_aperta_cx,string(par_ap))
end if	

tab_par.tabpage_1.dw_aper.Retrieve(il_conto)
tab_par.tabpage_2.dw_chiu.Retrieve(il_conto)
end event

event retrieveend;dw_aper.setfilter("stato='A'")
dw_aper.filter()
end event

event clicked;if row>0 then
	this.SelectRow (0,false)
	this.SelectRow (row,true)
end if	
end event

type tabpage_2 from userobject within tab_par
int X=18
int Y=104
int Width=2455
int Height=776
long BackColor=80263328
string Text="Chiuse"
long TabBackColor=80263328
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_chiu dw_chiu
end type

on tabpage_2.create
this.dw_chiu=create dw_chiu
this.Control[]={this.dw_chiu}
end on

on tabpage_2.destroy
destroy(this.dw_chiu)
end on

type dw_chiu from datawindow within tabpage_2
int X=18
int Y=28
int Width=2414
int Height=728
int TabOrder=30
string DataObject="d_lista_partite_conto"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;long par_ap
if row>0 then
	par_ap=dw_chiu.getitemnumber(row,'id_par_aperta')
	openwithparm(w_gest_par_aperta_cx,string(par_ap))
end if	
end event

event retrieveend;this.setfilter("stato='C'")
this.filter()
end event

event clicked;if row>0 then
	this.SelectRow (0,false)
	this.SelectRow (row,true)
end if	
end event

type cb_2 from commandbutton within w_par_aperta_cx
int X=2144
int Y=20
int Width=247
int Height=96
int TabOrder=30
string Text="Nuovo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_filter.reset()
tab_par.tabpage_1.dw_aper.reset()
tab_par.tabpage_2.dw_chiu.reset()
dw_filter.insertrow(0)
end event

type cb_1 from commandbutton within w_par_aperta_cx
int X=37
int Y=20
int Width=247
int Height=96
int TabOrder=10
string Text="Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

