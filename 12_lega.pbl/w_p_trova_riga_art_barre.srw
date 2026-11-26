forward
global type w_p_trova_riga_art_barre from w_pop
end type
type sle_num_bol from singlelineedit within w_p_trova_riga_art_barre
end type
type dw_2 from udw_001 within w_p_trova_riga_art_barre
end type
type cb_1 from commandbutton within w_p_trova_riga_art_barre
end type
type p_1 from picture within w_p_trova_riga_art_barre
end type
type dw_3 from udw_000 within w_p_trova_riga_art_barre
end type
type cb_2 from commandbutton within w_p_trova_riga_art_barre
end type
end forward

global type w_p_trova_riga_art_barre from w_pop
integer width = 4110
integer height = 2672
sle_num_bol sle_num_bol
dw_2 dw_2
cb_1 cb_1
p_1 p_1
dw_3 dw_3
cb_2 cb_2
end type
global w_p_trova_riga_art_barre w_p_trova_riga_art_barre

on w_p_trova_riga_art_barre.create
int iCurrent
call super::create
this.sle_num_bol=create sle_num_bol
this.dw_2=create dw_2
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_3=create dw_3
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_num_bol
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.cb_2
end on

on w_p_trova_riga_art_barre.destroy
call super::destroy
destroy(this.sle_num_bol)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_3)
destroy(this.cb_2)
end on

event open;call super::open;dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
dw_3.setitem(1, "path", "c:\nita\bollettine")
dw_3.setitem(1, "id_variazione", 164)
end event

type dw_1 from w_pop`dw_1 within w_p_trova_riga_art_barre
integer x = 18
integer y = 692
integer width = 2304
integer height = 1776
string dataobject = "d_p_trova_riga_articolo"
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;datetime ldt_data_conferma

if dwo.name='prezzo_confermato' then
	if data='C' then
		ldt_data_conferma=getitemdatetime(1, "prezzo_ultima_modifica")
		if ldt_data_conferma= datetime("1900-01-01") or isnull(ldt_data_conferma) then
			setitem(1, "prezzo_ultima_modifica", today())
		end if
	end if
end if
end event

type sle_num_bol from singlelineedit within w_p_trova_riga_art_barre
integer x = 41
integer y = 24
integer width = 1006
integer height = 412
integer taborder = 10
boolean bringtotop = true
integer textsize = -28
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_num_bol
integer li_righe
long ll_id_art, ll_num_bol, ll_id_var

IF LEN(TEXT)=7 THEN
	ls_num_bol=right(text, 5)
	ll_num_bol=long(ls_num_bol)
		select first(id_articolo)
		into :ll_id_art
		from dba.riga_documento
		where provv_imp_carea_2 = :ll_num_bol
		;
		dw_3.accepttext()
		ll_id_var=dw_3.getitemnumber(1, "id_variazione")
		dw_1.retrieve(ll_id_art, ll_id_var)
		dw_2.retrieve(ll_id_art)
		
	
	
END IF
end event

type dw_2 from udw_001 within w_p_trova_riga_art_barre
integer x = 1070
integer y = 24
integer width = 2907
integer height = 416
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_art_cod_des_ra"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_1 from commandbutton within w_p_trova_riga_art_barre
integer x = 3575
integer y = 572
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Leggi files"
end type

event clicked;	nvo_file_list sl_lista_file
	string ls_path, ls_cod_art, ls_num_bol
	long i
	
	
	ls_path=dw_3.getitemstring(1, "path")
	sl_lista_file=f_leggi_files(ls_path, false)
	ls_cod_art=dw_2.getitemstring(1, "codice")
	ls_num_bol=right(sle_num_bol.text, 5)
	p_1.picturename=""
	for i= 1 to upperbound(sl_lista_file.as_file)
		//if pos(sl_lista_file.as_file[i], ls_cod_art)>0 then
		if pos(sl_lista_file.as_file[i],ls_num_bol )>0 then
			p_1.picturename=sl_lista_file.as_file[i]
			exit
		end if
	next
	

end event

type p_1 from picture within w_p_trova_riga_art_barre
integer x = 2345
integer y = 692
integer width = 1637
integer height = 1768
boolean focusrectangle = false
end type

type dw_3 from udw_000 within w_p_trova_riga_art_barre
integer x = 18
integer y = 460
integer width = 2304
integer height = 216
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_path_id_variazione"
end type

type cb_2 from commandbutton within w_p_trova_riga_art_barre
integer x = 2341
integer y = 568
integer width = 521
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salva Confermato"
end type

event clicked;long  ll_id_uc,  ll_id_variazione, ll_test
string ls_confermato
decimal ldc_prezzo
datetime ldt_data_modifica

ldc_prezzo= dw_1.getitemdecimal(1, "prezzo_prezzo")
ll_id_uc=dw_1.getitemnumber(1, "riga_documento_id_unita_confezione")
ls_confermato=dw_1.getitemstring(1,"prezzo_confermato")
ll_id_variazione=dw_3.getitemnumber(1, "id_variazione")
ldt_data_modifica=dw_1.getitemdatetime(1,"prezzo_ultima_modifica")

select id_unita_confezione
into :ll_test
from dba.prezzo
where id_variazione=:ll_id_variazione  and id_unita_confezione=:ll_id_uc
;
if ll_test>0 then
	update dba.prezzo
	set prezzo=:ldc_prezzo, confermato= :ls_confermato, ultima_modifica=:ldt_data_modifica
	where id_variazione=:ll_id_variazione  and id_unita_confezione=:ll_id_uc
	;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Prezzo NON salvato!")
	end if
else
	insert into dba.prezzo (id_variazione, id_unita_confezione, prezzo, confermato, ultima_modifica)
	values (:ll_id_variazione, :ll_id_uc, :ldc_prezzo, :ls_confermato, :ldt_data_modifica)
	;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Prezzo NON inserito!")
	end if
end if
end event

