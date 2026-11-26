forward
global type w_crea_articoli_e_distinta from w_001
end type
type dw_1 from udw_base within w_crea_articoli_e_distinta
end type
type dw_2 from udw_base within w_crea_articoli_e_distinta
end type
type dw_3 from udw_base within w_crea_articoli_e_distinta
end type
type dw_4 from udw_base within w_crea_articoli_e_distinta
end type
type dw_5 from udw_base within w_crea_articoli_e_distinta
end type
type dw_1b from udw_base within w_crea_articoli_e_distinta
end type
type dw_4b from udw_base within w_crea_articoli_e_distinta
end type
type dw_3b from udw_base within w_crea_articoli_e_distinta
end type
type dw_5b from udw_base within w_crea_articoli_e_distinta
end type
type dw_2b from udw_base within w_crea_articoli_e_distinta
end type
type dw_11 from udw_base within w_crea_articoli_e_distinta
end type
type cb_chiudi from commandbutton within w_crea_articoli_e_distinta
end type
type cb_1 from commandbutton within w_crea_articoli_e_distinta
end type
type dw_6 from udw_base within w_crea_articoli_e_distinta
end type
type dw_6b from udw_base within w_crea_articoli_e_distinta
end type
type st_2 from statictext within w_crea_articoli_e_distinta
end type
type st_num_articoli from statictext within w_crea_articoli_e_distinta
end type
type dw_7 from udw_base within w_crea_articoli_e_distinta
end type
type cb_annulla from commandbutton within w_crea_articoli_e_distinta
end type
type dw_8 from udw_base within w_crea_articoli_e_distinta
end type
type dw_9 from udw_base within w_crea_articoli_e_distinta
end type
end forward

global type w_crea_articoli_e_distinta from w_001
integer width = 3744
integer height = 2180
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_1b dw_1b
dw_4b dw_4b
dw_3b dw_3b
dw_5b dw_5b
dw_2b dw_2b
dw_11 dw_11
cb_chiudi cb_chiudi
cb_1 cb_1
dw_6 dw_6
dw_6b dw_6b
st_2 st_2
st_num_articoli st_num_articoli
dw_7 dw_7
cb_annulla cb_annulla
dw_8 dw_8
dw_9 dw_9
end type
global w_crea_articoli_e_distinta w_crea_articoli_e_distinta

type variables
udw_base idw_attiva
end variables

forward prototypes
public subroutine wf_retrieve (udw_base adw)
end prototypes

public subroutine wf_retrieve (udw_base adw);long ll_tot1, ll_tot2, ll_tot3, ll_tot4, ll_tot5, ll_tot6, ll_tot


if adw=dw_11 then
	dw_1.accepttext()
	dw_2.accepttext()
	dw_3.accepttext()
	dw_4.accepttext()
	ll_tot1=dw_1.getitemnumber(1, "c_scelti")
	ll_tot2=dw_2.getitemnumber(1, "c_scelti")
	ll_tot3=dw_3.getitemnumber(1, "c_scelti")
	ll_tot4=dw_4.getitemnumber(1, "c_scelti")
	
	//ll_tot5=dw_5.getitemnumber(1, "c_scelti")
	//ll_tot6=dw_6.getitemnumber(1, "c_scelti")
	if ll_tot1<=0 then ll_tot1=1
	if ll_tot2<=0 then ll_tot2=1
	if ll_tot3<=0 then ll_tot3=1
	if ll_tot4<=0 then ll_tot4=1
	//if ll_tot5<=0 then ll_tot5=1
	//if ll_tot6<=0 then ll_tot6=1
	
	ll_tot=ll_tot1*ll_tot2*ll_tot3*ll_tot4//*ll_tot5*ll_tot6
	st_num_articoli.text=string(ll_tot)
else
	adw.retrieve()
end if
end subroutine

on w_crea_articoli_e_distinta.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_1b=create dw_1b
this.dw_4b=create dw_4b
this.dw_3b=create dw_3b
this.dw_5b=create dw_5b
this.dw_2b=create dw_2b
this.dw_11=create dw_11
this.cb_chiudi=create cb_chiudi
this.cb_1=create cb_1
this.dw_6=create dw_6
this.dw_6b=create dw_6b
this.st_2=create st_2
this.st_num_articoli=create st_num_articoli
this.dw_7=create dw_7
this.cb_annulla=create cb_annulla
this.dw_8=create dw_8
this.dw_9=create dw_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.dw_1b
this.Control[iCurrent+7]=this.dw_4b
this.Control[iCurrent+8]=this.dw_3b
this.Control[iCurrent+9]=this.dw_5b
this.Control[iCurrent+10]=this.dw_2b
this.Control[iCurrent+11]=this.dw_11
this.Control[iCurrent+12]=this.cb_chiudi
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.dw_6
this.Control[iCurrent+15]=this.dw_6b
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.st_num_articoli
this.Control[iCurrent+18]=this.dw_7
this.Control[iCurrent+19]=this.cb_annulla
this.Control[iCurrent+20]=this.dw_8
this.Control[iCurrent+21]=this.dw_9
end on

on w_crea_articoli_e_distinta.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_1b)
destroy(this.dw_4b)
destroy(this.dw_3b)
destroy(this.dw_5b)
destroy(this.dw_2b)
destroy(this.dw_11)
destroy(this.cb_chiudi)
destroy(this.cb_1)
destroy(this.dw_6)
destroy(this.dw_6b)
destroy(this.st_2)
destroy(this.st_num_articoli)
destroy(this.dw_7)
destroy(this.cb_annulla)
destroy(this.dw_8)
destroy(this.dw_9)
end on

event open;call super::open;long ll_id_cat_codifica, ll_id_uc_base
integer i, a

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)
dw_11.settransobject(sqlca)

dw_1b.settransobject(sqlca)
dw_2b.settransobject(sqlca)
dw_3b.settransobject(sqlca)
dw_4b.settransobject(sqlca)
dw_5b.settransobject(sqlca)
dw_6b.settransobject(sqlca)

dw_1b.insertrow(1)
dw_2b.insertrow(1)
dw_3b.insertrow(1)
dw_4b.insertrow(1)
dw_5b.insertrow(1)
dw_6b.insertrow(1)
dw_7.insertrow(1)

select id_cat_codifica
into :ll_id_cat_codifica
from cat_codifica
where codice='2010'
;
select id_unita_conf_base
into :ll_id_uc_base
from unita_conf_base
where codice='PZ';
dw_7.setitem(1 ,"id_cat_codifica", ll_id_cat_codifica)
dw_7.setitem(1, "id_titolo", 4)
dw_7.setitem(1, "coef_calo", 1000)
dw_7.setitem(1, "id_cat_com", 8)
dw_7.setitem(1, "id_uc_base", ll_id_uc_base)




FOR A= 1 TO 5
	IF A=1 then 
		idw_attiva=dw_1b
		idw_attiva.setitem(1, "id_colore", 5)
		idw_attiva.setitem(1, "qta_distinta", 0)
		idw_attiva.setitem(1, "id_cat_codifica", 18)
		
		wf_retrieve(dw_1)
	

		for i=1 to dw_1.rowcount()
			dw_1.setitem(i, "scegli", "S")
	
		next
	end if
	IF A=2 then 
		idw_attiva=dw_2b
		idw_attiva.setitem(1, "id_colore", 2)
		idw_attiva.setitem(1, "qta_distinta", 2)
		idw_attiva.setitem(1, "id_cat_codifica", 18)
		wf_retrieve(dw_2)
		for i=1 to dw_2.rowcount()
			dw_2.setitem(i, "scegli", "S")
		next
	end if
	IF A=3 then 
		idw_attiva=dw_3b
		idw_attiva.setitem(1, "id_colore", 3)
		idw_attiva.setitem(1, "qta_distinta", 1)
		idw_attiva.setitem(1, "id_cat_codifica", 18)
		wf_retrieve(dw_3)
		for i=1 to dw_3.rowcount()
			dw_3.setitem(i, "scegli", "S")
		next
	end if
	IF A=4 then 
		idw_attiva=dw_4b
		idw_attiva.setitem(1, "id_colore", 6)
		idw_attiva.setitem(1, "qta_distinta", 1)
		idw_attiva.setitem(1, "id_cat_codifica", 18)
		wf_retrieve(dw_4)
		for i=1 to dw_4.rowcount()
			dw_4.setitem(i, "scegli", "S")
		next
	end if
	IF A=5 then 
		idw_attiva=dw_5b
		idw_attiva.setitem(1, "id_colore", 7)
		idw_attiva.setitem(1, "qta_distinta", 1)
		idw_attiva.setitem(1, "id_cat_codifica", 18)
		wf_retrieve(dw_5)
		for i=1 to dw_5.rowcount()
			dw_5.setitem(i, "scegli", "S")
		next
	end if
next

end event

type st_1 from w_001`st_1 within w_crea_articoli_e_distinta
integer x = 2839
integer y = 36
end type

type dw_1 from udw_base within w_crea_articoli_e_distinta
integer x = 27
integer y = 312
integer width = 896
integer height = 564
boolean bringtotop = true
string dataobject = "d_art_selezionati"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;long ll_id_colore, ll_id_cat
integer li_pz_distinta
string ls_sql

ls_sql=sqlsyntax

ll_id_colore=idw_attiva.getitemnumber(1, "id_colore")
ll_id_cat=idw_attiva.getitemnumber(1, "id_cat_codifica")

if ll_id_colore>0 then
	ls_sql+= " and (articolo.id_colore="+string(ll_id_colore)+") "
end if
if ll_id_cat>0 then
	ls_sql+= " and (articolo.id_cat_codifica="+string(ll_id_cat)+") "	
end if
setsqlpreview(ls_sql)

end event

event itemchanged;call super::itemchanged;if dwo.name='scegli' then
	post wf_retrieve(dw_11)
end if
end event

event doubleclicked;call super::doubleclicked;integer i

if dwo.name='articolo_spina_t' then
	for i = 1 to rowcount()
		setitem(i, "scegli", 'S')
	next
	
end if
end event

type dw_2 from udw_base within w_crea_articoli_e_distinta
integer x = 951
integer y = 312
integer width = 901
integer height = 564
boolean bringtotop = true
string dataobject = "d_art_selezionati"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;long ll_id_colore, ll_id_cat
integer li_pz_distinta
string ls_sql

ls_sql=sqlsyntax

ll_id_colore=idw_attiva.getitemnumber(1, "id_colore")
ll_id_cat=idw_attiva.getitemnumber(1, "id_cat_codifica")

if ll_id_colore>0 then
	ls_sql+= " and (articolo.id_colore="+string(ll_id_colore)+") "
	
end if
if ll_id_cat>0 then
	ls_sql+= " and (articolo.id_cat_codifica="+string(ll_id_cat)+") "
	
end if
setsqlpreview(ls_sql)
end event

event itemchanged;call super::itemchanged;if dwo.name='scegli' then
	post wf_retrieve(dw_11)
end if
end event

event doubleclicked;call super::doubleclicked;integer i

if dwo.name='articolo_spina_t' then
	for i = 1 to rowcount()
		setitem(i, "scegli", 'S')
	next
	
end if
end event

type dw_3 from udw_base within w_crea_articoli_e_distinta
integer x = 1874
integer y = 312
integer width = 896
integer height = 564
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_art_selezionati"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;long ll_id_colore, ll_id_cat
integer li_pz_distinta
string ls_sql

ls_sql=sqlsyntax

ll_id_colore=idw_attiva.getitemnumber(1, "id_colore")
ll_id_cat=idw_attiva.getitemnumber(1, "id_cat_codifica")

if ll_id_colore>0 then
	ls_sql+= " and (articolo.id_colore="+string(ll_id_colore)+") "
	
end if
if ll_id_cat>0 then
	ls_sql+= " and (articolo.id_cat_codifica="+string(ll_id_cat)+") "
	
end if
setsqlpreview(ls_sql)
end event

event itemchanged;call super::itemchanged;if dwo.name='scegli' then
	post wf_retrieve(dw_11)
end if
end event

event doubleclicked;call super::doubleclicked;integer i

if dwo.name='articolo_spina_t' then
	for i = 1 to rowcount()
		setitem(i, "scegli", 'S')
	next
	
end if
end event

type dw_4 from udw_base within w_crea_articoli_e_distinta
integer x = 2789
integer y = 312
integer width = 896
integer height = 564
boolean bringtotop = true
string dataobject = "d_art_selezionati"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;long ll_id_colore, ll_id_cat
integer li_pz_distinta
string ls_sql

ls_sql=sqlsyntax

ll_id_colore=idw_attiva.getitemnumber(1, "id_colore")
ll_id_cat=idw_attiva.getitemnumber(1, "id_cat_codifica")

if ll_id_colore>0 then
	ls_sql+= " and (articolo.id_colore="+string(ll_id_colore)+") "
	
end if
if ll_id_cat>0 then
	ls_sql+= " and (articolo.id_cat_codifica="+string(ll_id_cat)+") "
	
end if
setsqlpreview(ls_sql)
end event

event itemchanged;call super::itemchanged;if dwo.name='scegli' then
	post wf_retrieve(dw_11)
end if
end event

event doubleclicked;call super::doubleclicked;integer i

if dwo.name='articolo_spina_t' then
	for i = 1 to rowcount()
		setitem(i, "scegli", 'S')
	next
	
end if
end event

type dw_5 from udw_base within w_crea_articoli_e_distinta
integer x = 27
integer y = 1176
integer width = 896
integer height = 564
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_art_selezionati"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;long ll_id_colore, ll_id_cat
integer li_pz_distinta
string ls_sql

ls_sql=sqlsyntax

ll_id_colore=idw_attiva.getitemnumber(1, "id_colore")
ll_id_cat=idw_attiva.getitemnumber(1, "id_cat_codifica")

if ll_id_colore>0 then
	ls_sql+= " and (articolo.id_colore="+string(ll_id_colore)+") "
	
end if
if ll_id_cat>0 then
	ls_sql+= " and (articolo.id_cat_codifica="+string(ll_id_cat)+") "
	
end if
setsqlpreview(ls_sql)
end event

event retrieveend;call super::retrieveend;integer i

for i=1 to rowcount()
	setitem(i, "scegli", "S")
	
next
end event

type dw_1b from udw_base within w_crea_articoli_e_distinta
integer x = 27
integer y = 32
integer width = 896
integer height = 280
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_sel_per_crea_articoli"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_attiva=this
post wf_retrieve(dw_1)

		
		

end event

event constructor;call super::constructor;title=classname(this)
end event

type dw_4b from udw_base within w_crea_articoli_e_distinta
integer x = 2789
integer y = 32
integer width = 896
integer height = 280
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_sel_per_crea_articoli"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_attiva=this
post wf_retrieve(dw_4)
end event

event constructor;call super::constructor;title=classname(this)
end event

type dw_3b from udw_base within w_crea_articoli_e_distinta
integer x = 1861
integer y = 32
integer width = 896
integer height = 280
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_sel_per_crea_articoli"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_attiva=this
post wf_retrieve(dw_3)
end event

event constructor;call super::constructor;title=classname(this)
end event

type dw_5b from udw_base within w_crea_articoli_e_distinta
integer x = 27
integer y = 900
integer width = 896
integer height = 280
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_sel_per_crea_articoli"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_attiva=this
post wf_retrieve(dw_5)
end event

event constructor;call super::constructor;title=classname(this)
end event

type dw_2b from udw_base within w_crea_articoli_e_distinta
integer x = 951
integer y = 32
integer width = 896
integer height = 280
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_sel_per_crea_articoli"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_attiva=this
post wf_retrieve(dw_2)
end event

event constructor;call super::constructor;title=classname(this)
end event

type dw_11 from udw_base within w_crea_articoli_e_distinta
integer x = 1893
integer y = 1252
integer width = 1797
integer height = 472
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_crea_articolo"
end type

type cb_chiudi from commandbutton within w_crea_articoli_e_distinta
integer x = 3406
integer y = 1012
integer width = 315
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleziona Tutto"
end type

event clicked;integer i, a
udw_base udw

FOR A= 1 TO 5
	IF A=1 then udw=dw_1
	IF A=2 then udw=dw_2
	IF A=3 then udw=dw_3
	IF A=4 then udw=dw_4
	IF A=5 then udw=dw_5
	for i =1 to udw.rowcount()
		udw.setitem(i, "scegli", "N")
	next
next
end event

type cb_1 from commandbutton within w_crea_articoli_e_distinta
integer x = 1893
integer y = 900
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Articoli"
end type

event clicked;long ll_tot1, ll_tot2, ll_tot3, ll_tot4, ll_tot5, ll_tot6, ll_tot
integer i, a, b, li_pz_1, li_pz_2, li_pz_3, li_qta[], z
long ll_riga_inserita, ll_id_titolo, ll_id_cat_codifica, ll_id_cat_com
string ls_cod, ls_cod_1, ls_cod_2, ls_cod_3, ls_scelto, ls_cod_4,ls_tipo_um, ls_cod_5
long ll_id_articolo[], ll_id_distinta, c, h, ll_id_uc, ll_test
decimal ldc_calo, ldc_peso_comp[], ldc_prezzo[]
integer li_pz_5, li_pz_4

dw_11.reset()
dw_8.reset()
dw_9.reset()


if dw_7.rowcount()>0 then

	ll_tot1=dw_1.rowcount()
	ll_tot2=dw_2.rowcount()
	ll_tot3=dw_3.rowcount()
	ll_tot4=dw_4.rowcount()
	ll_tot5=dw_5.rowcount()
	ll_tot6=dw_6.rowcount()
	
	li_pz_1=dw_1b.getitemnumber(1, "qta_distinta")
	li_pz_2=dw_2b.getitemnumber(1, "qta_distinta")
	li_pz_3=dw_3b.getitemnumber(1, "qta_distinta")
	li_pz_4=dw_4b.getitemnumber(1, "qta_distinta")
	li_pz_5=dw_5b.getitemnumber(1, "qta_distinta")
	ll_id_titolo=dw_7.getitemnumber(1, "id_titolo")
	if isnull(ll_id_titolo) then
		messagebox("attenzione!", "Inserire titolo!")
		return
	end if
	ll_id_cat_codifica=dw_7.getitemnumber(1, "id_cat_codifica")
	if isnull(ll_id_cat_codifica) then
		messagebox("attenzione!", "Inserire cat_codifica!")
		return
	end if
	ll_id_cat_com=dw_7.getitemnumber(1, "id_cat_com")
	if isnull(ll_id_cat_com) then
		messagebox("attenzione!", "Inserire cat_commerciale!")
		return
	end if
	ldc_calo=dw_7.getitemdecimal(1, "coef_calo")
	ll_id_uc=dw_7.GETITEMNUMBER(1, "ID_UC_BASE")
	dw_1b.accepttext()
	dw_2b.accepttext()
	dw_3b.accepttext()
	for i = 1 to ll_tot1
		ls_scelto=dw_1.getitemstring(i, "scegli")
		if ls_scelto<>'S' then continue
		ls_cod_1=dw_1.getitemstring(i, "articolo_codice")
		ll_id_articolo[1]=dw_1.getitemnumber(i, "id_articolo")
		li_qta[1]=dw_1b.getitemnumber(1, "qta_distinta")
		ldc_peso_comp[1]=dw_1.getitemdecimal(i, "peso_netto")
		ls_tipo_um=dw_1.getitemstring(i, "unita_misura_tipo")
		if ls_tipo_um='P' then
			ldc_prezzo[1]=dw_1.getitemdecimal(i, "prezzo_manifattura")
		else
			ldc_prezzo[1]=dw_1.getitemdecimal(i, "prezzo")
		end if
		for a = 1 to ll_tot2
			ls_scelto=dw_2.getitemstring(a, "scegli")
			if ls_scelto<>'S' then continue
			ll_id_articolo[2]=dw_2.getitemnumber(a , "id_articolo")
			ls_cod_2=dw_2.getitemstring(a, "articolo_codice")
			li_qta[2]=dw_2b.getitemnumber(1, "qta_distinta")
			ldc_peso_comp[2]=dw_2.getitemdecimal(a, "peso_netto")
			ls_tipo_um=dw_2.getitemstring(a, "unita_misura_tipo")
			if ls_tipo_um='P' then
				ldc_prezzo[2]=dw_2.getitemdecimal(a, "prezzo_manifattura")
			else
				ldc_prezzo[2]=dw_2.getitemdecimal(a, "prezzo")
			end if
			
			
			for b = 1 to ll_tot3
				ls_scelto=dw_3.getitemstring(b, "scegli")
				if ls_scelto<>'S' then continue
				li_qta[3]=dw_3b.getitemnumber(1, "qta_distinta")
				ldc_peso_comp[3]=dw_3.getitemdecimal(b, "peso_netto")
				ll_id_articolo[3]=dw_3.getitemnumber(b , "id_articolo")
				ls_tipo_um=dw_3.getitemstring(b, "unita_misura_tipo")
				if ls_tipo_um='P' then
					ldc_prezzo[3]=dw_2.getitemdecimal(b, "prezzo_manifattura")
				else
					ldc_prezzo[3]=dw_2.getitemdecimal(b, "prezzo")
				end if
				
				
				ls_cod_3=dw_3.getitemstring(b, "articolo_codice")
				if upper(left(ls_cod_3, 2))='CH'then
					for h=1 to ll_tot4
						ls_scelto=dw_4.getitemstring(h, "scegli")
						if ls_scelto<>'S' then continue
						li_qta[4]=dw_4b.getitemnumber(1, "qta_distinta")
						ldc_peso_comp[4]=dw_4.getitemdecimal(h, "peso_netto")
						ll_id_articolo[4]=dw_4.getitemnumber(h , "id_articolo")
						ls_cod_4=dw_4.getitemstring(h, "articolo_codice")
						ls_tipo_um=dw_4.getitemstring(h, "unita_misura_tipo")
						if ls_tipo_um='P' then
							ldc_prezzo[4]=dw_4.getitemdecimal(h, "prezzo_manifattura")
						else
							ldc_prezzo[4]=dw_4.getitemdecimal(h, "prezzo")
						end if
						//quinto giro filo saldaturato
						for z=1 to ll_tot5
							ls_scelto=dw_5.getitemstring(z, "scegli")
							if ls_scelto<>'S' then continue
							li_qta[5]=dw_5b.getitemnumber(1, "qta_distinta")
							ldc_peso_comp[5]=dw_5.getitemdecimal(z, "peso_netto")
							ll_id_articolo[5]=dw_5.getitemnumber(z , "id_articolo")
							ls_cod_5=dw_5.getitemstring(z, "articolo_codice")
							ls_tipo_um=dw_5.getitemstring(z, "unita_misura_tipo")
							if ls_tipo_um='P' then
								ldc_prezzo[5]=dw_5.getitemdecimal(z, "prezzo_manifattura")
							else
								ldc_prezzo[5]=dw_5.getitemdecimal(z, "prezzo")
							end if	
							
						next
						//fine 5 giro
						if ls_cod_5> " " then
							ls_cod=ls_cod_1+ls_cod_2+ls_cod_3+ls_cod_4+ls_cod_5
						else
							ls_cod=ls_cod_1+ls_cod_2+ls_cod_3+ls_cod_4
						end if
						//controllo se il codice esiste
						select id_articolo
						into :ll_test
						from articolo
						where codice=:ls_cod;
						
						
						if ll_test>0 then continue
							//se non esiste inserisco la riga
						ll_riga_inserita=dw_11.insertrow(0)
						dw_11.setitem(ll_riga_inserita, "codice", ls_cod)
						dw_11.setitem(ll_riga_inserita, "stato", 'P')
						dw_11.setitem(ll_riga_inserita, "id_cat_codifica", ll_id_cat_codifica)
						dw_11.setitem(ll_riga_inserita, "id_titolo", ll_id_titolo)
						dw_11.setitem(ll_riga_inserita, "coef_calo", ldc_calo)
						dw_11.setitem(ll_riga_inserita, "id_cat_com_articolo", ll_id_cat_com)
						dw_11.setitem(ll_riga_inserita, "id_unita_conf_base", ll_id_uc)
						dw_11.triggerevent("ue_update")
						
						select id_articolo
						into :ll_id_articolo[6]
						from articolo
						where codice=:ls_cod
						;
						//ll_id_articolo[5]=dw_11.getitemnumber(ll_riga_inserita, "id_articolo")
						
						ll_riga_inserita=dw_8.insertrow(0)
						dw_8.setitem(ll_riga_inserita, "codice", ls_cod)
						dw_8.setitem(ll_riga_inserita, "id_articolo", ll_id_articolo[6])
						dw_8.triggerevent("ue_update")
						ll_id_distinta=dw_8.getitemnumber(ll_riga_inserita, "id_distinta")
						if ls_cod_5 > " " then
							for c= 1 to 5
							if li_qta[c]>0 then
								ll_riga_inserita=dw_9.insertrow(0)
								dw_9.setitem(ll_riga_inserita, "id_distinta", ll_id_distinta)
								dw_9.setitem(ll_riga_inserita, "num_riga", c)
								dw_9.setitem(ll_riga_inserita, "id_articolo", ll_id_articolo[c])
								dw_9.setitem(ll_riga_inserita, "quantita", li_qta[c])
								dw_9.setitem(ll_riga_inserita, "peso_netto", ldc_peso_comp[c]*li_qta[c])
								dw_9.setitem(ll_riga_inserita, "costo", ldc_prezzo[c]*li_qta[c])
							end if
						next
						else
							for c= 1 to 4
								if li_qta[c]>0 then
									ll_riga_inserita=dw_9.insertrow(0)
									dw_9.setitem(ll_riga_inserita, "id_distinta", ll_id_distinta)
									dw_9.setitem(ll_riga_inserita, "num_riga", c)
									dw_9.setitem(ll_riga_inserita, "id_articolo", ll_id_articolo[c])
									dw_9.setitem(ll_riga_inserita, "quantita", li_qta[c])
									dw_9.setitem(ll_riga_inserita, "peso_netto", ldc_peso_comp[c]*li_qta[c])
									dw_9.setitem(ll_riga_inserita, "costo", ldc_prezzo[c]*li_qta[c])
								end if
							next
						end if
							
					next
				else
					for z=1 to ll_tot5
						ls_scelto=dw_5.getitemstring(z, "scegli")
						if ls_scelto<>'S' then continue
						li_qta[5]=dw_5b.getitemnumber(1, "qta_distinta")
						ldc_peso_comp[5]=dw_5.getitemdecimal(z, "peso_netto")
						ll_id_articolo[5]=dw_5.getitemnumber(z , "id_articolo")
						ls_cod_5=dw_5.getitemstring(z, "articolo_codice")
						ls_tipo_um=dw_5.getitemstring(z, "unita_misura_tipo")
						if ls_tipo_um='P' then
							ldc_prezzo[5]=dw_5.getitemdecimal(z, "prezzo_manifattura")
						else
							ldc_prezzo[5]=dw_5.getitemdecimal(z, "prezzo")
						end if	
					next
					if ls_cod_5> " " then
						ls_cod=ls_cod_1+ls_cod_2+ls_cod_3+ls_cod_5
					else
						ls_cod=ls_cod_1+ls_cod_2+ls_cod_3
					end if
					//controllo se il codice esiste
					select id_articolo
					into :ll_test
					from articolo
					where codice=:ls_cod;
					
					
					if ll_test>0 then continue
					//se non esiste inserisco la riga
					ll_riga_inserita=dw_11.insertrow(0)
					dw_11.setitem(ll_riga_inserita, "codice", ls_cod)
					dw_11.setitem(ll_riga_inserita, "stato", 'P')
					dw_11.setitem(ll_riga_inserita, "id_cat_codifica", ll_id_cat_codifica)
					dw_11.setitem(ll_riga_inserita, "id_titolo", ll_id_titolo)
					dw_11.setitem(ll_riga_inserita, "coef_calo", ldc_calo)
					dw_11.setitem(ll_riga_inserita, "id_cat_com_articolo", ll_id_cat_com)
					dw_11.setitem(ll_riga_inserita, "id_unita_conf_base", ll_id_uc)
					dw_11.triggerevent("ue_update")
					
						select id_articolo
						into :ll_id_articolo[6]
						from articolo
						where codice=:ls_cod
						;
					//ll_id_articolo[5]=dw_11.getitemnumber(ll_riga_inserita, "id_articolo")
					ll_riga_inserita=dw_8.insertrow(0)
					dw_8.setitem(ll_riga_inserita, "codice", ls_cod)
					dw_8.setitem(ll_riga_inserita, "id_articolo", ll_id_articolo[6])
	//				dw_8.setitem(ll_riga_inserita, "data_ora_creazione", today())
	//				dw_8.setitem(ll_riga_inserita, "data_ora_ult_cambiamento", today())
					dw_8.triggerevent("ue_update")
					ll_id_distinta=dw_8.getitemnumber(ll_riga_inserita, "id_distinta")
					if ls_cod_5 > " " then
						for c= 1 to 5
							if li_qta[c]>0 then
								if c=4 then continue
								ll_riga_inserita=dw_9.insertrow(0)
								dw_9.setitem(ll_riga_inserita, "id_distinta", ll_id_distinta)
								dw_9.setitem(ll_riga_inserita, "num_riga", c)
								dw_9.setitem(ll_riga_inserita, "id_articolo", ll_id_articolo[c])
								dw_9.setitem(ll_riga_inserita, "quantita", li_qta[c])
								dw_9.setitem(ll_riga_inserita, "peso_netto", ldc_peso_comp[c]*li_qta[c])
								dw_9.setitem(ll_riga_inserita, "costo", ldc_prezzo[c]*li_qta[c])
							end if
						next
					else
						for c= 1 to 3
							if li_qta[c]>0 then
								ll_riga_inserita=dw_9.insertrow(0)
								dw_9.setitem(ll_riga_inserita, "id_distinta", ll_id_distinta)
								dw_9.setitem(ll_riga_inserita, "num_riga", c)
								dw_9.setitem(ll_riga_inserita, "id_articolo", ll_id_articolo[c])
								dw_9.setitem(ll_riga_inserita, "quantita", li_qta[c])
								dw_9.setitem(ll_riga_inserita, "peso_netto", ldc_peso_comp[c]*li_qta[c])
								dw_9.setitem(ll_riga_inserita, "costo", ldc_prezzo[c]*li_qta[c])
							end if
						next
					end if
				end if
				dw_9.triggerevent("ue_update")
			next 
		next
	next
	
end if
end event

type dw_6 from udw_base within w_crea_articoli_e_distinta
integer x = 951
integer y = 1176
integer width = 901
integer height = 564
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_art_selezionati"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;long ll_id_colore, ll_id_cat
integer li_pz_distinta
string ls_sql

ls_sql=sqlsyntax

ll_id_colore=idw_attiva.getitemnumber(1, "id_colore")
ll_id_cat=idw_attiva.getitemnumber(1, "id_cat_codifica")

if ll_id_colore>0 then
	ls_sql+= " and (articolo.id_colore="+string(ll_id_colore)+") "
	
end if
if ll_id_cat>0 then
	ls_sql+= " and (articolo.id_cat_codifica="+string(ll_id_cat)+") "
	
end if
setsqlpreview(ls_sql)
end event

event retrieveend;call super::retrieveend;integer i

for i=1 to rowcount()
	setitem(i, "scegli", "S")
	
next
end event

type dw_6b from udw_base within w_crea_articoli_e_distinta
integer x = 951
integer y = 900
integer width = 896
integer height = 280
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_sel_per_crea_articoli"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_attiva=this
post wf_retrieve(dw_6)
end event

event constructor;call super::constructor;title=classname(this)
end event

type st_2 from statictext within w_crea_articoli_e_distinta
integer x = 2318
integer y = 912
integer width = 562
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articoli da generare: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_num_articoli from statictext within w_crea_articoli_e_distinta
integer x = 2866
integer y = 912
integer width = 251
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_7 from udw_base within w_crea_articoli_e_distinta
integer x = 1888
integer y = 1028
integer width = 1509
integer height = 220
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_scegli_dati_crea"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_annulla from commandbutton within w_crea_articoli_e_distinta
integer x = 3406
integer y = 1132
integer width = 315
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annull? Creazione"
end type

event clicked;long i
for i= dw_11.rowcount() to 1
	dw_11.deleterow(i)
next
//dw_11.triggerevent("ue_update")
	
	
	
end event

type dw_8 from udw_base within w_crea_articoli_e_distinta
integer x = 27
integer y = 1768
integer width = 1285
integer height = 268
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dis_padre"
end type

type dw_9 from udw_base within w_crea_articoli_e_distinta
integer x = 1339
integer y = 1780
integer width = 2368
integer height = 268
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_riga_dis"
end type

