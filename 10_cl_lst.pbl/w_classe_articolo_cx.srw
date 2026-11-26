forward
global type w_classe_articolo_cx from w_001
end type
type cb_esci from commandbutton within w_classe_articolo_cx
end type
type cb_inserisci_dw from commandbutton within w_classe_articolo_cx
end type
type cb_salva_dw from commandbutton within w_classe_articolo_cx
end type
type cb_cancella_dw from commandbutton within w_classe_articolo_cx
end type
type cb_app_classe from commandbutton within w_classe_articolo_cx
end type
type cb_stampa from commandbutton within w_classe_articolo_cx
end type
type dw_1 from udw_base within w_classe_articolo_cx
end type
type cbx_vedi_lista from checkbox within w_classe_articolo_cx
end type
type cb_pulisci from commandbutton within w_classe_articolo_cx
end type
type dw_2 from udw_figlia within w_classe_articolo_cx
end type
type rte_1 from richtextedit within w_classe_articolo_cx
end type
type cb_salvadoc from commandbutton within w_classe_articolo_cx
end type
end forward

global type w_classe_articolo_cx from w_001
integer width = 3072
integer height = 1992
string title = "Associa Classi ad Articoli"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 80269524
cb_esci cb_esci
cb_inserisci_dw cb_inserisci_dw
cb_salva_dw cb_salva_dw
cb_cancella_dw cb_cancella_dw
cb_app_classe cb_app_classe
cb_stampa cb_stampa
dw_1 dw_1
cbx_vedi_lista cbx_vedi_lista
cb_pulisci cb_pulisci
dw_2 dw_2
rte_1 rte_1
cb_salvadoc cb_salvadoc
end type
global w_classe_articolo_cx w_classe_articolo_cx

type variables

string is_sql


end variables

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public function integer wf_salva_dw ()
public subroutine wf_contr_esi_classe_articolo (long al_id_articolo)
public subroutine wf_applica_classe ()
end prototypes

public subroutine wf_ricerca (long al_riga_corrente, string as_data);
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	dw_2.setitem(al_riga_corrente, "classe_articolo_id_articolo",long(ls_ric_param.s_id_seg_value[1]))
	dw_2.setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
	dw_2.setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
end if
end subroutine

public function integer wf_salva_dw ();integer li_ret


li_ret=dw_2.triggerevent("ue_update")
return li_ret
end function

public subroutine wf_contr_esi_classe_articolo (long al_id_articolo);datastore ds_esi_classe_articolo
long ll_righe,ll_id_cl_1, ll_id_cl_2, ll_id_cl_3

ds_esi_classe_articolo=create datastore
ds_esi_classe_articolo.dataobject="d_cerca_art_classe"
ds_esi_classe_articolo.settransobject(sqlca)
ll_id_cl_1=dw_1.getitemnumber(1, "id_classe_1")
ll_id_cl_2=dw_1.getitemnumber(1, "id_classe_2")
ll_id_cl_3=dw_1.getitemnumber(1, "id_classe_3")


ll_righe=ds_esi_classe_articolo.retrieve(ll_id_cl_1, ll_id_cl_2, ll_id_cl_3,al_id_articolo)
if ll_righe>0 then
	messagebox("Attenzione!", "Articolo già inserito!")
end if

destroy (ds_esi_classe_articolo)
end subroutine

public subroutine wf_applica_classe ();long ll_hnd,ll_righe,ll_riga_inserita
long ll_id_art,ll_test, ll_id_classe, ll_riga_trovata
integer i, a
string ls_cod_art, ls_des_art, ls_testo_etichetta
string ls_colonna, ls_cod_classe


ll_righe=dw_2.rowcount()
for i =1 to ll_righe
	
	ll_id_art=dw_2.getitemnumber(i, "classe_articolo_id_articolo")
	delete from dba.classe_articolo
	where id_articolo=:ll_id_art;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		
		messagebox("Errore!", "Cancellazione non riuscita!")
	end if
	
	for a=1 to 3
		ls_colonna="id_classe_"+string(a)
		ll_id_classe=dw_1.getitemnumber(1, ls_colonna)
		if isnull(ll_id_classe) then 
			messagebox("Attenzione!", "Inserire tutti i livelli!")
			continue
		end if
		if a=1 then 
			ll_riga_inserita=i
		else
			ll_riga_inserita=dw_2.insertrow(0)
		end if
			dw_2.setitem(ll_riga_inserita, "classe_articolo_id_classe", ll_id_classe)
			dw_2.setitem(ll_riga_inserita, "classe_articolo_id_articolo", ll_id_art)
	
	next
next
ls_testo_etichetta=dw_1.getitemstring(1, "c_1")
ls_testo_etichetta+=" - "+dw_1.getitemstring(1, "c_2")
ls_testo_etichetta+=" - "+dw_1.getitemstring(1, "c_3")
dw_2.modify("classi_selezionate_t.text='"+ls_testo_etichetta+"'")



end subroutine

on w_classe_articolo_cx.create
int iCurrent
call super::create
this.cb_esci=create cb_esci
this.cb_inserisci_dw=create cb_inserisci_dw
this.cb_salva_dw=create cb_salva_dw
this.cb_cancella_dw=create cb_cancella_dw
this.cb_app_classe=create cb_app_classe
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
this.cbx_vedi_lista=create cbx_vedi_lista
this.cb_pulisci=create cb_pulisci
this.dw_2=create dw_2
this.rte_1=create rte_1
this.cb_salvadoc=create cb_salvadoc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_esci
this.Control[iCurrent+2]=this.cb_inserisci_dw
this.Control[iCurrent+3]=this.cb_salva_dw
this.Control[iCurrent+4]=this.cb_cancella_dw
this.Control[iCurrent+5]=this.cb_app_classe
this.Control[iCurrent+6]=this.cb_stampa
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cbx_vedi_lista
this.Control[iCurrent+9]=this.cb_pulisci
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.rte_1
this.Control[iCurrent+12]=this.cb_salvadoc
end on

on w_classe_articolo_cx.destroy
call super::destroy
destroy(this.cb_esci)
destroy(this.cb_inserisci_dw)
destroy(this.cb_salva_dw)
destroy(this.cb_cancella_dw)
destroy(this.cb_app_classe)
destroy(this.cb_stampa)
destroy(this.dw_1)
destroy(this.cbx_vedi_lista)
destroy(this.cb_pulisci)
destroy(this.dw_2)
destroy(this.rte_1)
destroy(this.cb_salvadoc)
end on

event timer;
end event

event open;call super::open;dw_2.settransobject(sqlca)
is_sql=dw_2.getsqlselect()
dw_1.settransobject(sqlca)
dw_1.insertrow(1)


rte_1.InsertDocument("help_classi_articolo.rtf", TRUE)
rte_1.WordWrap = TRUE
end event

type st_1 from w_001`st_1 within w_classe_articolo_cx
end type

type cb_esci from commandbutton within w_classe_articolo_cx
integer x = 1495
integer y = 1016
integer width = 288
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;close(parent)
end event

type cb_inserisci_dw from commandbutton within w_classe_articolo_cx
integer x = 1495
integer y = 744
integer width = 288
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_id
			ll_riga=dw_2.trigger event ue_insert(0)
			dw_2.setcolumn("articolo_codice")
end event

type cb_salva_dw from commandbutton within w_classe_articolo_cx
integer x = 1495
integer y = 620
integer width = 288
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;

	
long i, ll_righe, ll_id_classe, ll_id_articolo, ll_riga_trovata
long ll_righe_canc
integer li_ret

wf_applica_classe()
ll_righe=dw_2.rowcount()

for i=1 to ll_righe
	
	ll_id_articolo=dw_2.getitemnumber(i, "classe_articolo_id_articolo")
	ll_id_classe=dw_2.getitemnumber(i, "classe_articolo_id_classe")
	
		
	insert into classe_articolo
	(id_classe, id_articolo)
	values(:ll_id_classe, :ll_id_articolo);
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		li_ret=-1
		messagebox("Errore!", "Salvataggio non riuscito!")
	end if
next
if li_ret>=0 then dw_2.post retrieve()

end event

type cb_cancella_dw from commandbutton within w_classe_articolo_cx
integer x = 1495
integer y = 496
integer width = 288
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
	ll_riga_da_cancellare=dw_2.getrow()
	if ll_riga_da_cancellare>0 then
		
		
		dw_2.trigger event ue_delete(ll_riga_da_cancellare)
		
	end if
end event

type cb_app_classe from commandbutton within w_classe_articolo_cx
boolean visible = false
integer x = 1495
integer y = 64
integer width = 389
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Applica Classi"
end type

event clicked;wf_applica_classe()
end event

type cb_stampa from commandbutton within w_classe_articolo_cx
integer x = 1495
integer y = 372
integer width = 288
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_2.modify("articolo_codice_sw.visible=0")
dw_2.print()
dw_2.modify("articolo_codice_sw.visible=1")
end event

type dw_1 from udw_base within w_classe_articolo_cx
integer x = 37
integer y = 20
integer width = 1426
integer height = 204
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ins_classe_or_tb"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;choose case dwo.name
	case	"id_classe_1", "id_classe_2", "id_classe_3"
		if cbx_vedi_lista.checked then
			dw_2.post retrieve()
			
			
			
			
		end if			
		
		
end choose
end event

type cbx_vedi_lista from checkbox within w_classe_articolo_cx
integer x = 1138
integer y = 224
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Lista"
boolean lefttext = true
end type

type cb_pulisci from commandbutton within w_classe_articolo_cx
integer x = 1495
integer y = 868
integer width = 288
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci"
end type

event clicked;dw_1.reset()
dw_2.reset()
dw_1.insertrow(1)
dw_1.setfocus()
dw_1.setcolumn("id_classe_1")
end event

type dw_2 from udw_figlia within w_classe_articolo_cx
integer x = 37
integer y = 292
integer width = 1431
integer height = 1104
boolean bringtotop = true
string dataobject = "d_classe_articolo_gd"
end type

event itemchanged;
st_ass_art_sottoclasse st_associa
IF DWO.NAME='articolo_codice' then
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "classe_articolo_id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		setitem(row, "articolo_descrizione", st_associa.des_articolo)
	else
		wf_ricerca(row, data)
	end if
		st_associa.id_articolo=getitemnumber(row, "classe_articolo_id_articolo")
		if st_associa.id_articolo>0 then
			wf_contr_esi_classe_articolo(st_associa.id_articolo)
		end if	
end if



end event

event ue_key;choose case key
	case keydelete!
		cb_cancella_dw.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci_dw.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella_dw.triggerevent(clicked!)
		end if			
     case KeyS!
		if (keyFlags=2) then
			cb_salva_dw.triggerevent(clicked!)		
		end if
	case KeyF12!
		cb_salva_dw.triggerevent(clicked!)		
	
end choose
end event

event clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	wf_ricerca(row, ls_data)
end if
end event

event sqlpreview;
long ll_id_classe, ll_pos
integer li_ret, li_conta=1, a
s_tv_classe s_classi
STRING ls_sql, ls_inizio,ls_sql_from, ls_testo_etichetta

ls_sql=upper(is_sql)
if pos(ls_sql, "WHERE")>0 THEN
	ls_inizio= " AND "
else
	ls_inizio="WHERE"
end if

dw_1.accepttext()
ll_id_classe=dw_1.getitemnumber(1, "id_classe_1")
ls_testo_etichetta+=dw_1.getitemstring(1, "c_1")
ls_sql+=ls_inizio+ " CLASSE_ARTICOLO.ID_CLASSE="+STRING(ll_id_classe)+" "
ll_id_classe=dw_1.getitemnumber(1, "id_classe_2")
if ll_id_classe>0 then
	ls_testo_etichetta+=" - " +dw_1.getitemstring(1, "c_2")
	
	ll_pos=pos(ls_sql, "WHERE")
	ls_sql_from=left(ls_sql, ll_pos - 1)
	ls_sql_from+=", CLASSE_ARTICOLO AS CL_ART_2 "
	LS_SQL=ls_sql_from+right(ls_sql, len(ls_sql) - (ll_pos - 1))
	
	ls_sql+=" AND CL_ART_2"+".ID_ARTICOLO=ARTICOLO.ID_ARTICOLO " 
	
	ls_sql+= " AND CL_ART_2"+".ID_CLASSE="+STRING(ll_id_classe)+" "
end if
ll_id_classe=dw_1.getitemnumber(1, "id_classe_3")
if ll_id_classe>0 then
	ls_testo_etichetta+=" - " +dw_1.getitemstring(1, "c_3")
	
	ll_pos=pos(ls_sql, "WHERE")
	ls_sql_from=left(ls_sql, ll_pos - 1)
	ls_sql_from+=", CLASSE_ARTICOLO AS CL_ART_3 "
	LS_SQL=ls_sql_from+right(ls_sql, len(ls_sql) - (ll_pos - 1))
	
	ls_sql+=" AND CL_ART_3"+".ID_ARTICOLO=ARTICOLO.ID_ARTICOLO " 
	
	ls_sql+= " AND CL_ART_3"+".ID_CLASSE="+STRING(ll_id_classe)+" "
end if


	
	
	
	
	

li_ret=setsqlpreview(ls_sql)
dw_2.modify("classi_selezionate_t.text='"+ls_testo_etichetta+"'")



end event

type rte_1 from richtextedit within w_classe_articolo_cx
integer x = 37
integer y = 1428
integer width = 2935
integer height = 440
integer taborder = 80
boolean bringtotop = true
boolean init_vscrollbar = true
boolean init_wordwrap = true
boolean init_popmenu = true
long init_leftmargin = 1
long init_topmargin = 2
long init_rightmargin = 8
long init_bottommargin = 1
string init_documentname = "help_classi_articolo.txt"
borderstyle borderstyle = stylelowered!
end type

type cb_salvadoc from commandbutton within w_classe_articolo_cx
integer x = 1495
integer y = 1304
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Doc."
end type

event clicked;rte_1.savedocument("help_classi_articolo.rtf")
end event

