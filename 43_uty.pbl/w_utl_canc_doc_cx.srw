forward
global type w_utl_canc_doc_cx from Window
end type
type sle_2 from singlelineedit within w_utl_canc_doc_cx
end type
type st_2 from statictext within w_utl_canc_doc_cx
end type
type cbx_1 from checkbox within w_utl_canc_doc_cx
end type
type sle_1 from singlelineedit within w_utl_canc_doc_cx
end type
type st_1 from statictext within w_utl_canc_doc_cx
end type
type dw_sel from u_dw_ext_main within w_utl_canc_doc_cx
end type
type cb_2 from commandbutton within w_utl_canc_doc_cx
end type
type dw_canc from datawindow within w_utl_canc_doc_cx
end type
type cb_1 from commandbutton within w_utl_canc_doc_cx
end type
end forward

global type w_utl_canc_doc_cx from Window
int X=833
int Y=361
int Width=3338
int Height=1561
boolean TitleBar=true
string Title="Cancellazione Documenti"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
sle_2 sle_2
st_2 st_2
cbx_1 cbx_1
sle_1 sle_1
st_1 st_1
dw_sel dw_sel
cb_2 cb_2
dw_canc dw_canc
cb_1 cb_1
end type
global w_utl_canc_doc_cx w_utl_canc_doc_cx

on w_utl_canc_doc_cx.create
this.sle_2=create sle_2
this.st_2=create st_2
this.cbx_1=create cbx_1
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_sel=create dw_sel
this.cb_2=create cb_2
this.dw_canc=create dw_canc
this.cb_1=create cb_1
this.Control[]={ this.sle_2,&
this.st_2,&
this.cbx_1,&
this.sle_1,&
this.st_1,&
this.dw_sel,&
this.cb_2,&
this.dw_canc,&
this.cb_1}
end on

on w_utl_canc_doc_cx.destroy
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.dw_sel)
destroy(this.cb_2)
destroy(this.dw_canc)
destroy(this.cb_1)
end on

event open;dw_sel.insertrow(1)
dw_sel.setfocus()
end event

type sle_2 from singlelineedit within w_utl_canc_doc_cx
int X=1326
int Y=1345
int Width=247
int Height=73
int TabOrder=41
boolean AutoHScroll=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_utl_canc_doc_cx
int X=919
int Y=1345
int Width=403
int Height=69
boolean Enabled=false
string Text="Doc. Selezionati"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_1 from checkbox within w_utl_canc_doc_cx
int X=2721
int Y=1297
int Width=449
int Height=77
string Text="Seleziona tutto"
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_trovati,i
ll_trovati=dw_canc.rowcount()

if this.checked=true then
	FOR i = 1 TO ll_trovati
		dw_canc.selectrow(i,true)
	NEXT
else
	FOR i=1 TO ll_trovati
		dw_canc.selectrow(i,false)
	NEXT
end if
long contatore
for i=1 to dw_canc.rowcount()
	if dw_canc.isselected(i) then
		contatore=contatore+1
	end if
next

sle_2.text=string(contatore)
end event

type sle_1 from singlelineedit within w_utl_canc_doc_cx
int X=1326
int Y=1257
int Width=247
int Height=73
int TabOrder=30
boolean AutoHScroll=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_utl_canc_doc_cx
int X=924
int Y=1261
int Width=403
int Height=69
boolean Enabled=false
string Text="Doc. Recuperati"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_sel from u_dw_ext_main within w_utl_canc_doc_cx
int X=55
int Y=53
int Width=805
int Height=1157
int TabOrder=20
string DataObject="d_utl_canc_doc_ff"
end type

type cb_2 from commandbutton within w_utl_canc_doc_cx
int X=1697
int Y=1289
int Width=819
int Height=121
int TabOrder=40
string Text="Cancella"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga_sel,ll_id_documento,ll_retval,ret
string ls_flag
s_par_record lstr_par_documento
ll_riga_sel=dw_canc.getselectedrow(0)
ret=dw_canc.getselectedrow(0)
if not(dw_canc.getselectedrow(0))>0 then
	messagebox("Cancellazione Documenti","Nessun documento è selezionato",exclamation!) 
else
ret=messagebox("Ultimo Avviso","Vuoi proseguire con la cancellazione?",question!,yesno!)


if ret=1 then
DO WHILE ll_riga_sel>0
	dw_canc.SelectRow(ll_riga_sel, FALSE)
	
ll_id_documento=dw_canc.getitemnumber(ll_riga_sel,"documento_id_documento")

lstr_par_documento.nome_tabella="documento" 
lstr_par_documento.nome_id_tabella="id_documento"
lstr_par_documento.id_tabella=ll_id_documento
lstr_par_documento.visible=false
openwithparm(w_utl_cancella_documento_wz,lstr_par_documento)
ll_retval=message.doubleparm

if ll_retval<>1 then
	ls_flag='N'
else
	ls_flag='S'
end if
ll_riga_sel=dw_canc.getselectedrow(0)
LOOP
if ls_flag='N' then
	messagebox("Utility","La cancellazione non è riuscita perfettamente")

else
	messagebox("Utility","La cancellazione è stata eseguita")
end if
end if
end if
end event

type dw_canc from datawindow within w_utl_canc_doc_cx
int X=924
int Y=53
int Width=2341
int Height=1161
int TabOrder=10
string DataObject="d_documento_descr_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;


if row>0 then
this.selectrow(row,not(isselected(row)))
end if
long i,contatore
for i=1 to dw_canc.rowcount()
	if this.isselected(i) then
		contatore=contatore+1
	end if
next

sle_2.text=string(contatore)
end event

type cb_1 from commandbutton within w_utl_canc_doc_cx
int X=183
int Y=1289
int Width=522
int Height=117
int TabOrder=50
string Text="Ricerca"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_da_data_reg,ld_a_data_reg
long ll_da_prot,ll_a_prot
string ls_filtro,ls_da_profilo,ls_a_profilo

dw_sel.accepttext()
ld_da_data_reg=dw_sel.getitemdate(1,"da_data_reg")
ld_a_data_reg=dw_sel.getitemdate(1,"a_data_reg")
ll_da_prot=dw_sel.getitemnumber(1,"da_protocollo")
ll_a_prot=dw_sel.getitemnumber(1,"a_protocollo")
ls_da_profilo=dw_sel.getitemstring(1,"da_profilo")
ls_a_profilo=dw_sel.getitemstring(1,"a_profilo")


if ld_da_data_reg>ld_a_data_reg then
	messagebox("Utility","La data di registrazione iniziale è più grande di quella finale")
else
	if ll_da_prot>ll_a_prot then
	messagebox("Utility","Il numero di protocollo iniziale è più grande di quello finale")	
else
if ls_da_profilo>ls_a_profilo then
	messagebox("Utility","Il profilo iniziale è più grande di quello finale")

else
if ls_da_profilo<>''and ls_filtro='' then
	ls_filtro='prof_documento_codice>='+'"'+string(ls_da_profilo)+'"'
else
if ls_da_profilo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (prof_documento_codice>='+'"'+string(ls_da_profilo)+'"'+')'
end if
end if
if ls_a_profilo<>''and ls_filtro='' then
	ls_filtro='prof_documento_codice<='+'"'+string(ls_a_profilo)+'"'
else
if ls_a_profilo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (prof_documento_codice<='+'"'+string(ls_a_profilo)+'"'+')'
end if
end if




if not isnull(ld_da_data_reg) and (ls_filtro='') then
	ls_filtro='documento_data_registrazione>=date("'+string(ld_da_data_reg)+'"))'
else
if not isnull(ld_da_data_reg)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (documento_data_registrazione>=date("'+string(ld_da_data_reg)+'"))'
end if
end if
if not isnull(ld_a_data_reg)and ls_filtro='' then
	ls_filtro='documento_data_registrazione<=date("'+string(ld_a_data_reg)+'"))'
else
if not isnull(ld_a_data_reg)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (documento_data_registrazione<=date("'+string(ld_a_data_reg)+'"))'
end if
end if
if not isnull(ll_da_prot)and ls_filtro='' then
	ls_filtro='documento_num_progressivo>='+string(ll_da_prot)
else
if not isnull(ll_da_prot)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (documento_num_progressivo>='+string(ll_da_prot)+')'
end if
end if

if not isnull(ll_a_prot)and ls_filtro='' then
	ls_filtro='documento_num_progressivo<='+'"'+string(ll_a_prot)+'"'
else
if not isnull(ll_a_prot)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (documento_num_progressivo<='+string(ll_a_prot)+')'
end if
end if

end if
end if
end if



dw_canc.settransobject(sqlca)
dw_canc.retrieve()
dw_canc.setfilter(ls_filtro)
dw_canc.filter()
sle_1.text=string(dw_canc.rowcount())
end event

