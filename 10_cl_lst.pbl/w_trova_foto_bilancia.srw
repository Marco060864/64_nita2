forward
global type w_trova_foto_bilancia from w_base
end type
type pb_1 from picturebutton within w_trova_foto_bilancia
end type
type cb_filtra from commandbutton within w_trova_foto_bilancia
end type
type cb_1 from commandbutton within w_trova_foto_bilancia
end type
type dw_1 from udw_001 within w_trova_foto_bilancia
end type
type dw_lista_foto from udw_001 within w_trova_foto_bilancia
end type
type dw_sel from udw_001 within w_trova_foto_bilancia
end type
end forward

global type w_trova_foto_bilancia from w_base
integer width = 4032
integer height = 2132
pb_1 pb_1
cb_filtra cb_filtra
cb_1 cb_1
dw_1 dw_1
dw_lista_foto dw_lista_foto
dw_sel dw_sel
end type
global w_trova_foto_bilancia w_trova_foto_bilancia

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_sel.settransobject(sqlca)
dw_sel.insertrow(1)
dw_lista_foto.settransobject(sqlca)
end event

on w_trova_foto_bilancia.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_filtra=create cb_filtra
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_lista_foto=create dw_lista_foto
this.dw_sel=create dw_sel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_filtra
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_lista_foto
this.Control[iCurrent+6]=this.dw_sel
end on

on w_trova_foto_bilancia.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.cb_filtra)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_lista_foto)
destroy(this.dw_sel)
end on

type pb_1 from picturebutton within w_trova_foto_bilancia
integer x = 3264
integer y = 556
integer width = 169
integer height = 140
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom033!"
alignment htextalign = left!
end type

event clicked;long ll_temp
nvo_file_list sl_lista_file
integer  li_riga_inserita, li_lunghezza_path, li_secondi
string  ls_path,ls_nuovo_file,  ls_data_ora_foto



ls_path=dw_sel.getitemstring(1, "path_foto")
if isnull(ls_path) or ls_path< "  " then
	ls_path="\\server2017\alarm"
end if
li_lunghezza_path=len(ls_path)
if right(ls_path, 1) <>"\" then li_lunghezza_path++
sl_lista_file=f_leggi_files(ls_path, false)

FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
	if right(sl_lista_file.as_file[ll_temp], 3) <> 'jpg' and  right(sl_lista_file.as_file[ll_temp], 3) <> "JPG" then continue
	ls_data_ora_foto=mid(sl_lista_file.as_file[ll_temp], li_lunghezza_path+6, 8)
	
	If not(DirectoryExists ( ls_path+"\"+ls_data_ora_foto )) Then   
		CreateDirectory ( ls_path+"\"+ls_data_ora_foto)
	End If
	ls_nuovo_file= ls_path+"\"+ls_data_ora_foto+"\"+right(sl_lista_file.as_file[ll_temp], len(sl_lista_file.as_file[ll_temp]) - len(ls_path))
	if not(fileexists(ls_nuovo_file)) then
		Filecopy (sl_lista_file.as_file[ll_temp], ls_nuovo_file)
	end if

		

next
	
		
//		//ma prima chiudo la finestra se fosse stata aperta già precedentemente
//		close(w_mostra_foto)
//		openwithparm(w_mostra_foto, ls_file_trovato)
//		exit


end event

type cb_filtra from commandbutton within w_trova_foto_bilancia
integer x = 2766
integer y = 592
integer width = 416
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Applica Filtri"
end type

event clicked;date ldt_data
long ll_id_sog, ll_num_prog
string ls_filtro, ls_num_doc

dw_1.setfilter("")
dw_1.filter()

dw_sel.accepttext()

ldt_data=dw_sel.getitemdate(1, "da_ta")
ll_id_sog=dw_sel.getitemnumber(1, "id_soggetto")
ll_num_prog=dw_sel.getitemnumber(1, "num_prog")
ls_num_doc=dw_sel.getitemstring(1, "num_documento")
if ldt_data>date("1900/01/01") then
	ls_filtro="data_documento= date( '"+string(ldt_data)+"' ) "
end if
	
if ll_id_sog>0 then
	if len(ls_filtro) > 5 then
		ls_filtro+=" and "
	end if
		ls_filtro+=" id_sog_commerciale="+string(ll_id_sog)
end if
	
if ll_num_prog>0 then
	if len(ls_filtro) > 5 then
		ls_filtro+=" and "
	end if
	ls_filtro+=" num_progressivo="+string(ll_num_prog)
end if
if ls_num_doc>" " then
	if len(ls_filtro) > 5 then
		ls_filtro+=" and "
	end if
	ls_filtro+=" num_documento='"+ls_num_doc+"' "
end if
if ls_filtro> " " then
	dw_1.setfilter(ls_filtro)
	dw_1.filter()
end if

//335 6813865 alberto Mozzorecchi  (prof di Tommy è corgiatini)
end event

type cb_1 from commandbutton within w_trova_foto_bilancia
integer x = 3529
integer y = 592
integer width = 416
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recupera Foto"
end type

event clicked;long  ll_temp, ll_riga
nvo_file_list sl_lista_file
integer  li_riga_inserita, li_lunghezza_path, li_secondi
string  ls_path,ls_data_ora, ls_data_ora_fine, ls_data_ora_foto
datetime ldt_data_ora, ldt_data_ora_fine

dw_lista_foto.reset()


ll_riga=dw_1.getrow()
ldt_data_ora=dw_1.getitemdatetime(ll_riga, "data_ora_modifica")
li_secondi=dw_sel.getitemnumber(1, "minuti")
if isnull(li_secondi) or li_secondi <=0 then li_secondi=15

ldt_data_ora_fine=datetime(date(ldt_data_ora),relativetime(time(ldt_data_ora), li_secondi))
ls_data_ora=string(ldt_data_ora, "yy_mm_dd_hh_mm_ss")
ls_data_ora_fine=string(ldt_data_ora_fine, "yy_mm_dd_hh_mm_ss")
if ls_data_ora>" " then
	ls_path=dw_sel.getitemstring(1, "path_foto")
	if isnull(ls_path) or ls_path< "  " then
		ls_path="\\server2017\alarm"
	end if
	li_lunghezza_path=len(ls_path)
	if right(ls_path, 1) <>"\" then li_lunghezza_path++
	sl_lista_file=f_leggi_files(ls_path, false)

FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
	
	ls_data_ora_foto=mid(sl_lista_file.as_file[ll_temp], li_lunghezza_path+6, 17)
	if ls_data_ora_foto>=ls_data_ora and  ls_data_ora_foto<=ls_data_ora_fine then
		li_riga_inserita=dw_lista_foto.insertrow(0)
		dw_lista_foto.setitem(li_riga_inserita,"nome_file", sl_lista_file.as_file[ll_temp])
	end if		
next
	
		
//		//ma prima chiudo la finestra se fosse stata aperta già precedentemente
//		close(w_mostra_foto)
//		openwithparm(w_mostra_foto, ls_file_trovato)
//		exit

end if
end event

type dw_1 from udw_001 within w_trova_foto_bilancia
integer x = 37
integer y = 32
integer width = 2702
integer height = 1924
integer taborder = 20
string dataobject = "d_doc_cerca_foto_bilancia"
boolean vscrollbar = true
end type

type dw_lista_foto from udw_001 within w_trova_foto_bilancia
integer x = 2766
integer y = 712
integer width = 1175
integer height = 1252
integer taborder = 20
boolean bringtotop = true
string title = "Lista Foto possibili"
string dataobject = "d_lista_foto_bilancia"
boolean vscrollbar = true
end type

event doubleclicked;string ls_path
if row>0 then
	ls_path=dw_lista_foto.getitemstring(row, "nome_file")
	close(w_mostra_foto)
	openwithparm(w_mostra_foto, ls_path)
	w_mostra_foto.width=3840
	w_mostra_foto.height=2160
end if
end event

type dw_sel from udw_001 within w_trova_foto_bilancia
integer x = 2757
integer y = 32
integer width = 1175
integer height = 516
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cerca_doc_foto"
end type

