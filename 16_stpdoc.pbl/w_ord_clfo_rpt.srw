forward
global type w_ord_clfo_rpt from Window
end type
type st_3 from statictext within w_ord_clfo_rpt
end type
type ddlb_ordina from dropdownlistbox within w_ord_clfo_rpt
end type
type cb_1 from commandbutton within w_ord_clfo_rpt
end type
type cb_pg_prima from commandbutton within w_ord_clfo_rpt
end type
type cb_pg_dopo from commandbutton within w_ord_clfo_rpt
end type
type cb_preview from commandbutton within w_ord_clfo_rpt
end type
type cb_stampa from commandbutton within w_ord_clfo_rpt
end type
type cb_imp_st from commandbutton within w_ord_clfo_rpt
end type
type cb_6 from commandbutton within w_ord_clfo_rpt
end type
type cb_7 from commandbutton within w_ord_clfo_rpt
end type
type cb_salva_su_file from commandbutton within w_ord_clfo_rpt
end type
type sle_zoom from singlelineedit within w_ord_clfo_rpt
end type
type sle_copie from singlelineedit within w_ord_clfo_rpt
end type
type st_2 from statictext within w_ord_clfo_rpt
end type
type st_1 from statictext within w_ord_clfo_rpt
end type
type sle_pg from singlelineedit within w_ord_clfo_rpt
end type
type dw_1 from datawindow within w_ord_clfo_rpt
end type
end forward

global type w_ord_clfo_rpt from Window
int X=23
int Y=12
int Width=3589
int Height=1824
boolean TitleBar=true
string Title="Stampa Ordini in Scadenza"
long BackColor=80269524
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_post_open ( )
st_3 st_3
ddlb_ordina ddlb_ordina
cb_1 cb_1
cb_pg_prima cb_pg_prima
cb_pg_dopo cb_pg_dopo
cb_preview cb_preview
cb_stampa cb_stampa
cb_imp_st cb_imp_st
cb_6 cb_6
cb_7 cb_7
cb_salva_su_file cb_salva_su_file
sle_zoom sle_zoom
sle_copie sle_copie
st_2 st_2
st_1 st_1
sle_pg sle_pg
dw_1 dw_1
end type
global w_ord_clfo_rpt w_ord_clfo_rpt

type variables
integer ii_zoom=100
s_param_articoli s_parametri 
end variables

on w_ord_clfo_rpt.create
this.st_3=create st_3
this.ddlb_ordina=create ddlb_ordina
this.cb_1=create cb_1
this.cb_pg_prima=create cb_pg_prima
this.cb_pg_dopo=create cb_pg_dopo
this.cb_preview=create cb_preview
this.cb_stampa=create cb_stampa
this.cb_imp_st=create cb_imp_st
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_salva_su_file=create cb_salva_su_file
this.sle_zoom=create sle_zoom
this.sle_copie=create sle_copie
this.st_2=create st_2
this.st_1=create st_1
this.sle_pg=create sle_pg
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.ddlb_ordina,&
this.cb_1,&
this.cb_pg_prima,&
this.cb_pg_dopo,&
this.cb_preview,&
this.cb_stampa,&
this.cb_imp_st,&
this.cb_6,&
this.cb_7,&
this.cb_salva_su_file,&
this.sle_zoom,&
this.sle_copie,&
this.st_2,&
this.st_1,&
this.sle_pg,&
this.dw_1}
end on

on w_ord_clfo_rpt.destroy
destroy(this.st_3)
destroy(this.ddlb_ordina)
destroy(this.cb_1)
destroy(this.cb_pg_prima)
destroy(this.cb_pg_dopo)
destroy(this.cb_preview)
destroy(this.cb_stampa)
destroy(this.cb_imp_st)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_salva_su_file)
destroy(this.sle_zoom)
destroy(this.sle_copie)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_pg)
destroy(this.dw_1)
end on

event open;string ls_test


s_parametri=message.powerobjectparm

ddlb_ordina.selectitem(3)



if isnull(s_parametri.da_sog_comm) then s_parametri.da_sog_comm=' '
if isnull(s_parametri.a_sog_comm) then s_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'

if s_parametri.solo_preziosi='D' then
	dw_1.dataobject="d_riga_ord_clfo_rpt"
elseif s_parametri.solo_preziosi='F' then
	
			dw_1.dataobject="d_ord_sollecito_rpt"
elseif s_parametri.solo_preziosi='L' then
	
	dw_1.dataobject="d_ord_prod_tikal"
elseif s_parametri.solo_preziosi='G' then
	dw_1.dataobject="d_ord_clfo_gr_rpt"
	
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(s_parametri.da_data, s_parametri.a_data,s_parametri.da_sog_comm,&
					s_parametri.a_sog_comm, s_parametri.tipo_stampa,s_parametri.da_categoria)

end event

event resize;dw_1.height=newheight - 265
dw_1.width=newwidth - 75

end event

type st_3 from statictext within w_ord_clfo_rpt
int X=1202
int Y=144
int Width=265
int Height=76
boolean Enabled=false
string Text="Ordina per:"
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

type ddlb_ordina from dropdownlistbox within w_ord_clfo_rpt
int X=1472
int Y=136
int Width=823
int Height=228
int TabOrder=30
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
string Item[]={"Ragione Sociale",&
"Numero Documento",&
"Data Scadenza"}
end type

event selectionchanged;
choose case ddlb_ordina.text(index)
	case "Ragione Sociale" 
		dw_1.setsort("anagrafica_rag_soc_1, data_prev_consegna D")
		
	case "Data Scadenza"
		dw_1.setsort("data_prev_consegna D")
		
	case "Numero Documento"
		dw_1.setsort("num_documento, data_prev_consegna D")
		
		
end choose
dw_1.sort()
dw_1.groupcalc()

end event

type cb_1 from commandbutton within w_ord_clfo_rpt
int X=37
int Y=36
int Width=261
int Height=88
int TabOrder=20
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_pg_prima from commandbutton within w_ord_clfo_rpt
int X=325
int Y=36
int Width=91
int Height=88
int TabOrder=30
string Text="<"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_pg_dopo from commandbutton within w_ord_clfo_rpt
int X=434
int Y=36
int Width=91
int Height=88
int TabOrder=40
string Text=">"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_preview from commandbutton within w_ord_clfo_rpt
int X=2295
int Y=36
int Width=261
int Height=88
int TabOrder=80
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_1.object.datawindow.print.preview='no'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_stampa from commandbutton within w_ord_clfo_rpt
int X=3269
int Y=36
int Width=261
int Height=88
int TabOrder=100
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_imp_st from commandbutton within w_ord_clfo_rpt
int X=2587
int Y=36
int Width=297
int Height=88
int TabOrder=60
string Text="Imp. Stamp."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_6 from commandbutton within w_ord_clfo_rpt
int X=562
int Y=36
int Width=219
int Height=88
int TabOrder=50
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_7 from commandbutton within w_ord_clfo_rpt
int X=933
int Y=36
int Width=242
int Height=88
int TabOrder=70
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_salva_su_file from commandbutton within w_ord_clfo_rpt
int X=2917
int Y=36
int Width=320
int Height=88
int TabOrder=110
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type sle_zoom from singlelineedit within w_ord_clfo_rpt
int X=782
int Y=32
int Width=146
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="100"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;ii_zoom=integer(this.text)
dw_1.object.datawindow.zoom=ii_zoom

end event

type sle_copie from singlelineedit within w_ord_clfo_rpt
int X=2117
int Y=32
int Width=165
int Height=92
int TabOrder=120
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

type st_2 from statictext within w_ord_clfo_rpt
int X=1970
int Y=40
int Width=151
int Height=76
boolean Enabled=false
string Text="Copie:"
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

type st_1 from statictext within w_ord_clfo_rpt
int X=1189
int Y=40
int Width=270
int Height=76
boolean Enabled=false
string Text="Stampa Pg.:"
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

type sle_pg from singlelineedit within w_ord_clfo_rpt
int X=1454
int Y=32
int Width=503
int Height=92
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_ord_clfo_rpt
int X=23
int Y=228
int Width=3515
int Height=1436
int TabOrder=130
string DataObject="d_ord_clfo_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo_documento_ordine_cx, s_list)
end if

		
end event

event sqlpreview;integer i
string ls_sql

if dw_1.dataobject="d_riga_ord_clfo_rpt" then
	if s_parametri.da_cod_art>"" then
		ls_sql= " and articolo.codice>='"+s_parametri.da_cod_art+"' "
	end if
	if s_parametri.a_cod_art>"" then
		ls_sql+= " and articolo.codice<='"+s_parametri.a_cod_art+"' "
	end if
end if
if s_parametri.legato_fino="N" then
	ls_sql+= " and (riga_documento_a.peso_netto> riga_documento_a.peso_netto_evaso or "+&
				" (riga_documento_a.peso_netto_evaso is null and riga_documento_a.peso_netto>0)) "
	ls_sql+= " and riga_documento_a.qta_un_base> riga_documento_a.qta_evasa_un_base  "
	ls_sql+= " and riga_documento_a.forza_chius_evasione<>'S' "
end if
if s_parametri.legato_fino="E" then
	ls_sql+= " and (riga_documento_a.forza_chius_evasione='S' "
	ls_sql+= " or (riga_documento_a.qta_un_base<= riga_documento_a.qta_evasa_un_base "
	ls_sql+= " and riga_documento_a.peso_netto< riga_documento_a.peso_netto_evaso)) "
end if
ls_sql=sqlsyntax + ls_sql
i=SetSQLPreview(ls_sql)
if i<>1 then
	messagebox("Errore!", "Filtro causali non applicato!")
end  if

end event

