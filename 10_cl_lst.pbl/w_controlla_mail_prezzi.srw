forward
global type w_controlla_mail_prezzi from w_001
end type
type dw_1 from udw_base within w_controlla_mail_prezzi
end type
type rb_tutte from radiobutton within w_controlla_mail_prezzi
end type
type rb_solo_mail from radiobutton within w_controlla_mail_prezzi
end type
type rb_prezzi_confermati from radiobutton within w_controlla_mail_prezzi
end type
type dw_2 from udw_base within w_controlla_mail_prezzi
end type
type cb_stampa from commandbutton within w_controlla_mail_prezzi
end type
type st_2 from statictext within w_controlla_mail_prezzi
end type
type st_3 from statictext within w_controlla_mail_prezzi
end type
type st_4 from statictext within w_controlla_mail_prezzi
end type
type st_5 from statictext within w_controlla_mail_prezzi
end type
type st_7 from statictext within w_controlla_mail_prezzi
end type
type st_8 from statictext within w_controlla_mail_prezzi
end type
type st_9 from statictext within w_controlla_mail_prezzi
end type
type st_6 from statictext within w_controlla_mail_prezzi
end type
type rb_prezzi_controllati from radiobutton within w_controlla_mail_prezzi
end type
type r_1 from rectangle within w_controlla_mail_prezzi
end type
type r_2 from rectangle within w_controlla_mail_prezzi
end type
type r_3 from rectangle within w_controlla_mail_prezzi
end type
type r_4 from rectangle within w_controlla_mail_prezzi
end type
end forward

global type w_controlla_mail_prezzi from w_001
integer width = 4091
integer height = 1644
string title = "w_controlla_prezzi_confermati"
dw_1 dw_1
rb_tutte rb_tutte
rb_solo_mail rb_solo_mail
rb_prezzi_confermati rb_prezzi_confermati
dw_2 dw_2
cb_stampa cb_stampa
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_7 st_7
st_8 st_8
st_9 st_9
st_6 st_6
rb_prezzi_controllati rb_prezzi_controllati
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
end type
global w_controlla_mail_prezzi w_controlla_mail_prezzi

type variables
string is_sql
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();date ldt_inizio, ldt_fine
ldt_inizio=dw_2.getitemdate(1, "Data_Inizio")
ldt_fine=dw_2.getitemdate(1, "Data_fine")
dw_1.retrieve(ldt_inizio, ldt_fine)

end subroutine

on w_controlla_mail_prezzi.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_tutte=create rb_tutte
this.rb_solo_mail=create rb_solo_mail
this.rb_prezzi_confermati=create rb_prezzi_confermati
this.dw_2=create dw_2
this.cb_stampa=create cb_stampa
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_6=create st_6
this.rb_prezzi_controllati=create rb_prezzi_controllati
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_tutte
this.Control[iCurrent+3]=this.rb_solo_mail
this.Control[iCurrent+4]=this.rb_prezzi_confermati
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_stampa
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.st_7
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.rb_prezzi_controllati
this.Control[iCurrent+16]=this.r_1
this.Control[iCurrent+17]=this.r_2
this.Control[iCurrent+18]=this.r_3
this.Control[iCurrent+19]=this.r_4
end on

on w_controlla_mail_prezzi.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_tutte)
destroy(this.rb_solo_mail)
destroy(this.rb_prezzi_confermati)
destroy(this.dw_2)
destroy(this.cb_stampa)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_6)
destroy(this.rb_prezzi_controllati)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
end on

event ue_postopen;call super::ue_postopen;

date ldt_inizio, ldt_fine


ldt_inizio=dw_2.getitemdate(1, "Data_Inizio")
ldt_fine=dw_2.getitemdate(1, "Data_fine")
dw_1.retrieve(ldt_inizio, ldt_fine)
end event

event open;call super::open;DATE ldt_inizio
string ls_inizio
integer li_anno, li_mese

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)


dw_2.insertrow(1)

dw_2.setitem(1, "data_fine", today())

ls_inizio=string(today(), "dd/mm/yy")
li_mese=month(today())
li_anno=year(today())
if li_mese=1 then 
	li_mese=12
	li_anno= li_anno - 1
else
	li_mese= li_mese - 1
end if
ls_inizio="01/"+string(li_mese)+"/"+string(li_anno)
ldt_inizio=date(ls_inizio)
dw_2.setitem(1, "data_inizio", ldt_inizio)
end event

type st_1 from w_001`st_1 within w_controlla_mail_prezzi
end type

type dw_1 from udw_base within w_controlla_mail_prezzi
integer x = 18
integer y = 28
integer width = 3200
integer height = 1460
boolean bringtotop = true
string dataobject = "d_controllo_mail_prezzi"
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

event sqlpreview;call super::sqlpreview;//filtro a seconda di quale bottone è premuto
string ls_sql
integer li_ret

if is_sql="" then
	is_sql= sqlsyntax
end if	
ls_sql=is_sql
if rb_prezzi_confermati.checked then
	ls_sql+=" and (documento.stampato='C' or documento.stampato='X')"
elseif rb_solo_mail.checked then
	ls_sql+=" and (documento.stampato='E' or documento.stampato='X')"
elseif rb_prezzi_controllati.checked then
	ls_sql+=" and (documento.creato_in_esenzione= 'C' ) "
else	//rb_tutti.checked
	ls_sql=is_sql
end if
li_ret=setsqlpreview(ls_sql)



end event

type rb_tutte from radiobutton within w_controlla_mail_prezzi
integer x = 3255
integer y = 228
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutte"
boolean checked = true
end type

event clicked;wf_retrieve()
end event

type rb_solo_mail from radiobutton within w_controlla_mail_prezzi
integer x = 3255
integer y = 308
integer width = 530
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Inviate via  Mail"
end type

event clicked;wf_retrieve()
end event

type rb_prezzi_confermati from radiobutton within w_controlla_mail_prezzi
integer x = 3255
integer y = 388
integer width = 503
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prezzi Confermati"
end type

event clicked;wf_retrieve()
end event

type dw_2 from udw_base within w_controlla_mail_prezzi
integer x = 3227
integer y = 28
integer width = 690
integer height = 176
boolean bringtotop = true
string dataobject = "d_sel_date_controlla_prezzi"
end type

event itemchanged;call super::itemchanged;date ldt_inizio, ldt_fine

IF DATE(DATA)> DATE("1900-01-01") THEN
	if string(dwo.name)="data_inizio" then
		ldt_inizio=DATE(DATA)
		ldt_fine=dw_2.getitemdate(1, "data_fine")
		IF ldt_fine> DATE("1900-01-01") THEN
			dw_1.retrieve(ldt_inizio, ldt_fine)
		END IF
	elseif string(dwo.name)="data_fine" then
		ldt_fine=DATE(DATA)
		ldt_inizio=dw_2.getitemdate(1, "data_inizio")
		IF ldt_inizio> DATE("1900-01-01") THEN
			dw_1.retrieve(ldt_inizio, ldt_fine)
		END IF
	end if
END IF
end event

type cb_stampa from commandbutton within w_controlla_mail_prezzi
integer x = 3241
integer y = 1392
integer width = 320
integer height = 92
integer taborder = 20
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

dw_1.print()
end event

type st_2 from statictext within w_controlla_mail_prezzi
integer x = 3250
integer y = 1056
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "X= Stampato, Inviato e Confermato"
boolean focusrectangle = false
end type

type st_3 from statictext within w_controlla_mail_prezzi
integer x = 3250
integer y = 1136
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "E= Stampato e Inviato"
boolean focusrectangle = false
end type

type st_4 from statictext within w_controlla_mail_prezzi
integer x = 3250
integer y = 1216
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "C= Stampato e Confemato"
boolean focusrectangle = false
end type

type st_5 from statictext within w_controlla_mail_prezzi
integer x = 3250
integer y = 1296
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "S= Stampato"
boolean focusrectangle = false
end type

type st_7 from statictext within w_controlla_mail_prezzi
integer x = 3355
integer y = 604
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da SARA"
boolean focusrectangle = false
end type

type st_8 from statictext within w_controlla_mail_prezzi
integer x = 3355
integer y = 704
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da ELEONORA"
boolean focusrectangle = false
end type

type st_9 from statictext within w_controlla_mail_prezzi
integer x = 3355
integer y = 808
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da SAMY"
boolean focusrectangle = false
end type

type st_6 from statictext within w_controlla_mail_prezzi
integer x = 3355
integer y = 912
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da ELISA"
boolean focusrectangle = false
end type

type rb_prezzi_controllati from radiobutton within w_controlla_mail_prezzi
integer x = 3255
integer y = 468
integer width = 503
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prezzi Controllati"
end type

event clicked;wf_retrieve()
end event

type r_1 from rectangle within w_controlla_mail_prezzi
long linecolor = 65535
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 65535
integer x = 3241
integer y = 592
integer width = 87
integer height = 76
end type

type r_2 from rectangle within w_controlla_mail_prezzi
long linecolor = 65535
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 30736255
integer x = 3241
integer y = 692
integer width = 87
integer height = 76
end type

type r_3 from rectangle within w_controlla_mail_prezzi
long linecolor = 65535
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 24599526
integer x = 3241
integer y = 796
integer width = 87
integer height = 76
end type

type r_4 from rectangle within w_controlla_mail_prezzi
long linecolor = 134217856
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 16776960
integer x = 3241
integer y = 896
integer width = 87
integer height = 76
end type

