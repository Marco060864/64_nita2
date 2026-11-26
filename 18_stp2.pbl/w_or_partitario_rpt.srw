forward
global type w_or_partitario_rpt from window
end type
type pb_vedi_sog_e_causali from picturebutton within w_or_partitario_rpt
end type
type cbx_1 from checkbox within w_or_partitario_rpt
end type
type dw_3 from udw_base within w_or_partitario_rpt
end type
type cb_st_no_importi from commandbutton within w_or_partitario_rpt
end type
type cb_retrieve from commandbutton within w_or_partitario_rpt
end type
type cb_salva from commandbutton within w_or_partitario_rpt
end type
type dw_2 from udw_base within w_or_partitario_rpt
end type
type cb_excel from commandbutton within w_or_partitario_rpt
end type
type ole_1 from olecontrol within w_or_partitario_rpt
end type
type cb_inventario from commandbutton within w_or_partitario_rpt
end type
type cbx_sottoscorta from checkbox within w_or_partitario_rpt
end type
type cbx_prod_zero from checkbox within w_or_partitario_rpt
end type
type cbx_vedi_righe from checkbox within w_or_partitario_rpt
end type
type cbx_ordina from checkbox within w_or_partitario_rpt
end type
type sle_pg from singlelineedit within w_or_partitario_rpt
end type
type st_1 from statictext within w_or_partitario_rpt
end type
type st_2 from statictext within w_or_partitario_rpt
end type
type sle_copie from singlelineedit within w_or_partitario_rpt
end type
type sle_zoom from singlelineedit within w_or_partitario_rpt
end type
type cb_salva_su_file from commandbutton within w_or_partitario_rpt
end type
type cb_7 from commandbutton within w_or_partitario_rpt
end type
type cb_6 from commandbutton within w_or_partitario_rpt
end type
type cb_imp_st from commandbutton within w_or_partitario_rpt
end type
type cb_stampa from commandbutton within w_or_partitario_rpt
end type
type cb_preview from commandbutton within w_or_partitario_rpt
end type
type cb_pg_dopo from commandbutton within w_or_partitario_rpt
end type
type cb_pg_prima from commandbutton within w_or_partitario_rpt
end type
type cb_1 from commandbutton within w_or_partitario_rpt
end type
type dw_1 from datawindow within w_or_partitario_rpt
end type
end forward

global type w_or_partitario_rpt from window
integer x = 23
integer y = 12
integer width = 3881
integer height = 1836
boolean titlebar = true
string title = "Stampa Movimenti Magazzino"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 79741120
event ue_post_open ( )
pb_vedi_sog_e_causali pb_vedi_sog_e_causali
cbx_1 cbx_1
dw_3 dw_3
cb_st_no_importi cb_st_no_importi
cb_retrieve cb_retrieve
cb_salva cb_salva
dw_2 dw_2
cb_excel cb_excel
ole_1 ole_1
cb_inventario cb_inventario
cbx_sottoscorta cbx_sottoscorta
cbx_prod_zero cbx_prod_zero
cbx_vedi_righe cbx_vedi_righe
cbx_ordina cbx_ordina
sle_pg sle_pg
st_1 st_1
st_2 st_2
sle_copie sle_copie
sle_zoom sle_zoom
cb_salva_su_file cb_salva_su_file
cb_7 cb_7
cb_6 cb_6
cb_imp_st cb_imp_st
cb_stampa cb_stampa
cb_preview cb_preview
cb_pg_dopo cb_pg_dopo
cb_pg_prima cb_pg_prima
cb_1 cb_1
dw_1 dw_1
end type
global w_or_partitario_rpt w_or_partitario_rpt

type variables
string is_solo_preziosi ='S', is_tipo_dw, is_test,  is_coef_calo
integer ii_zoom=100
long   il_id_sog
 
s_param_articoli s_parametri  
s_param_articoli s_lista_causali

end variables

forward prototypes
public subroutine wf_zoom ()
end prototypes

event ue_post_open();
setredraw(true)
dw_1.setredraw(true)
if is_test='D' then
	cbx_vedi_righe.visible=true
	cbx_vedi_righe.checked=true
	//cbx_vedi_righe.trigger event clicked()
	
end if

end event

public subroutine wf_zoom ();dw_1.setredraw(false)
setredraw(false)
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
dw_1.setredraw(true)
setredraw(true)
end subroutine

on w_or_partitario_rpt.create
this.pb_vedi_sog_e_causali=create pb_vedi_sog_e_causali
this.cbx_1=create cbx_1
this.dw_3=create dw_3
this.cb_st_no_importi=create cb_st_no_importi
this.cb_retrieve=create cb_retrieve
this.cb_salva=create cb_salva
this.dw_2=create dw_2
this.cb_excel=create cb_excel
this.ole_1=create ole_1
this.cb_inventario=create cb_inventario
this.cbx_sottoscorta=create cbx_sottoscorta
this.cbx_prod_zero=create cbx_prod_zero
this.cbx_vedi_righe=create cbx_vedi_righe
this.cbx_ordina=create cbx_ordina
this.sle_pg=create sle_pg
this.st_1=create st_1
this.st_2=create st_2
this.sle_copie=create sle_copie
this.sle_zoom=create sle_zoom
this.cb_salva_su_file=create cb_salva_su_file
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_imp_st=create cb_imp_st
this.cb_stampa=create cb_stampa
this.cb_preview=create cb_preview
this.cb_pg_dopo=create cb_pg_dopo
this.cb_pg_prima=create cb_pg_prima
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.pb_vedi_sog_e_causali,&
this.cbx_1,&
this.dw_3,&
this.cb_st_no_importi,&
this.cb_retrieve,&
this.cb_salva,&
this.dw_2,&
this.cb_excel,&
this.ole_1,&
this.cb_inventario,&
this.cbx_sottoscorta,&
this.cbx_prod_zero,&
this.cbx_vedi_righe,&
this.cbx_ordina,&
this.sle_pg,&
this.st_1,&
this.st_2,&
this.sle_copie,&
this.sle_zoom,&
this.cb_salva_su_file,&
this.cb_7,&
this.cb_6,&
this.cb_imp_st,&
this.cb_stampa,&
this.cb_preview,&
this.cb_pg_dopo,&
this.cb_pg_prima,&
this.cb_1,&
this.dw_1}
end on

on w_or_partitario_rpt.destroy
destroy(this.pb_vedi_sog_e_causali)
destroy(this.cbx_1)
destroy(this.dw_3)
destroy(this.cb_st_no_importi)
destroy(this.cb_retrieve)
destroy(this.cb_salva)
destroy(this.dw_2)
destroy(this.cb_excel)
destroy(this.ole_1)
destroy(this.cb_inventario)
destroy(this.cbx_sottoscorta)
destroy(this.cbx_prod_zero)
destroy(this.cbx_vedi_righe)
destroy(this.cbx_ordina)
destroy(this.sle_pg)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_copie)
destroy(this.sle_zoom)
destroy(this.cb_salva_su_file)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_imp_st)
destroy(this.cb_stampa)
destroy(this.cb_preview)
destroy(this.cb_pg_dopo)
destroy(this.cb_pg_prima)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string  ls_tikal, ls_test
date ldt_data_inizio_saldi
  

setredraw(false)
dw_1.setredraw(false)

s_parametri=message.powerobjectparm
//aggiunto 091209 silver
//il_cat_codifica=s_parametri.id_cat_codifica
//is_bollo=s_parametri.bollo
//il_magazzino=s_parametri.ll_magazzino
//ii_fiscale=s_parametri.li_fiscale
//is_dw=s_parametri.tipo_stampa

if isnull(s_parametri.da_sog_comm) then s_parametri.da_sog_comm=' '
if isnull(s_parametri.a_sog_comm) then s_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if s_parametri.da_sog_comm=s_parametri.a_sog_comm then
	select id_sog_commerciale
	into :il_id_sog
	from dba.sog_commerciale
	where codice = :s_parametri.da_sog_comm;
end if
if isnull(s_parametri.da_cod_art) then s_parametri.da_cod_art=' '
if isnull(s_parametri.a_cod_art) then s_parametri.a_cod_art='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if isnull(s_parametri.da_categoria) then s_parametri.da_categoria=' '
if isnull(s_parametri.a_categoria) then s_parametri.a_categoria='ZZZZZZZZ'
if isnull(s_parametri.filtro) then s_parametri.filtro='Nessun filtro'
	
//if upperbound(s_parametri.li_titolo)>0 then
//	id_titolo[1]=s_parametri.li_titolo[1]
//	id_titolo[2]=s_parametri.li_titolo[2]
//end if
	
ls_test=left(s_parametri.filtro, 1)
is_test=ls_test
choose case ls_test
	case 'C' 
		dw_1.dataobject="d_mov_causale"
	case 'A' 
		dw_1.dataobject="d_mov_articolo"
	case 'D' 
		cb_preview.enabled=true
		is_tipo_dw='data'
		choose case s_parametri.tipo_stampa
			case "SP"  
				dw_1.dataobject="d_data_tikal_tb"
			case "SM"
				dw_1.dataobject="d_data_sin_metallo_tb"	
			case "SD"
				dw_1.dataobject="d_data_tot_doc_silver_tb"
				cbx_vedi_righe.visible=true
				cbx_prod_zero.visible=true
				cbx_sottoscorta.visible=true
			case "TG"
				dw_1.dataobject="d_data_tot_giornaliero_tb"
			case "SV"
				cb_inventario.visible=true
				dw_1.dataobject="d_data_tot_doc_vener_tb"
				select data_calc_saldi
				INTO :ldt_data_inizio_saldi
				FROM DBA.ORAFO_PAR_SISTEMA
				;
				IF ldt_data_inizio_saldi>DATE("1900-01-01") THEN
					s_parametri.inizio_es=ldt_data_inizio_saldi
				END IF
				cbx_vedi_righe.visible=true
				cbx_prod_zero.visible=true
				cbx_sottoscorta.visible=true
			case "PM"
					dw_1.dataobject="d_data_tot_doc_per_mese_tb"
				case "FC"
					dw_1.dataobject="d_data_tot_doc_senza_prog_tb"
//			case "CP"
//				dw_1.dataobject="d_data_tot_doc_silver_CP_tb"
			case "18"
					dw_1.dataobject="d_data_tot_doc_tb18"
			case "17"
					dw_1.dataobject="d_data_tot_doc_tb"
			case "TA"
					dw_1.dataobject="d_data_tot_doc_tb18tare"
			case "PP"
					dw_1.dataobject="d_data_tot_doc_tbnew"
			case "FI"
					dw_1.dataobject="d_data_tot_doc_tb2018"	
			case "KP"  //K puro ricreare il legato ipotizzato a 925 20230714 sAMY
					dw_1.dataobject="d_data_tot_doc_tbkpuro"
			case else
				//questo è un errore! si deve basare non sulla data del giorno, ma su quella del documento (documento per documento) deve quindi essere nella select della dw
				if today()>date("2018/07/24") and il_id_sog=43 then
					dw_1.dataobject="d_data_tot_doc_tb18"
				else
					dw_1.dataobject="d_data_tot_doc_tb"
				end if
			
		end choose
end choose
s_parametri.filtro=right(s_parametri.filtro, len(s_parametri.filtro) - 1)

//is_per_causale=s_parametri.ordinamento
//il_destinazione=s_parametri.cambio


dw_1.settransobject(sqlca)
if ls_test='D' or ls_test="KP" then
	//aggiungo filtro per coef_calo mm 190711
	if s_parametri.segno_coef_calo<>"--" and s_parametri.segno_coef_calo> " " then
		is_coef_calo=s_parametri.segno_coef_calo+" "+string(s_parametri.coef_calo)
	end if
	//fine 190711
	
	cbx_vedi_righe.visible=true
	
	
	dw_1.retrieve(s_parametri.da_cod_art,s_parametri.a_cod_art,&
	s_parametri.da_sog_comm, s_parametri.a_sog_comm, &
	s_parametri.da_categoria, s_parametri.a_categoria, s_parametri.da_data,&
	s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro,s_parametri.totali_doc,&
	s_parametri.legato_fino, s_parametri.solo_preziosi,s_parametri.ll_magazzino, s_parametri.li_fiscale)

else
	dw_1.retrieve(s_parametri.da_cod_art,s_parametri.a_cod_art,&
	s_parametri.da_sog_comm, s_parametri.a_sog_comm, &
	s_parametri.da_categoria, s_parametri.a_categoria, s_parametri.da_data,&
	s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro,s_parametri.totali_doc,&
	s_parametri.legato_fino, s_parametri.solo_preziosi)
end if
if s_parametri.tipo_stampa<>"TG" then dw_1.object.datawindow.print.orientation=1

this.post event ue_post_open()


end event

event resize;setredraw(false)
dw_1.setredraw(false)
dw_1.height=newheight - 225
dw_1.width=newwidth - 75
setredraw(true)
dw_1.setredraw(true)
end event

type pb_vedi_sog_e_causali from picturebutton within w_or_partitario_rpt
integer x = 1961
integer width = 329
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\anagrafiche.png"
alignment htextalign = left!
end type

event clicked;long i, ll_righe
integer a, b, c, d
string ls_cod_causale, ls_rag_soc
boolean lb_gia_preso, lb_gia_preso2
s_vettori_stringa s_vet

ll_righe=dw_1.rowcount()

for i= 1 to ll_righe
	ls_cod_causale=dw_1.getitemstring(i, "caus_magazzino_codice")
	ls_rag_soc=dw_1.getitemstring(i, "sog_commerciale_gen_rag_soc_1")
	lb_gia_preso=false
	lb_gia_preso2=false
	for a = 1 to upperbound(s_vet.s_causali)
		if ls_cod_causale=s_vet.s_causali[a] then
			lb_gia_preso=true
		end if
	next
	for c = 1 to upperbound(s_vet.s_rag_sociale)
		if ls_rag_soc=s_vet.s_rag_sociale[c] then
			lb_gia_preso2=true
		end if
	next
	if lb_gia_preso=false then 
		b++
		s_vet.s_causali[b]=	ls_cod_causale
	end if
	if lb_gia_preso2=false then 
		d++
		s_vet.s_rag_sociale[d]=	ls_rag_soc
	end if
next
openwithparm(w_lista_caus_e_sog_comm, s_vet)

//""

end event

type cbx_1 from checkbox within w_or_partitario_rpt
boolean visible = false
integer x = 1966
integer y = 80
integer width = 315
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Tare"
end type

event clicked;string modstring , ls_ret

dw_1.setredraw(false)
IF CHECKED THEN
	
	//ls_ret=dw_1.describe("grs.visible")
	//modstring=right(ls_ret, len(ls_ret) - 3)
	modstring='c_tot_tare.visible= "'
	modstring+="'"
	//+"1	if( documento_data_documento >= da_data and totali_doc <>'X' , 1, 0)"'
	
	ls_ret=dw_1.modify(modstring)
	
	
//	modstring ="c_tot_tare.visible= 0 ~tif(( riga_documento_id_documento <> riga_documento_id_documento [1] or getrow()=rowcount()) "+ &
//													" and  (documento_data_documento >= da_data) and  (totali_doc ='S' or totali_doc ='X') , 1,0)"
//	ls_ret=dw_1.modify(modstring)
ELSE
	ls_ret=dw_1.modify("c_tot_tare.visible= 0")
END IF
dw_1.setredraw(true)
end event

type dw_3 from udw_base within w_or_partitario_rpt
boolean visible = false
integer x = 59
integer y = 796
integer width = 3744
integer height = 748
integer taborder = 130
string dataobject = "d_data_tot_doc_stampa"
end type

event sqlpreview;call super::sqlpreview;string ls_sql, ls_titolo[],ls_cod_met[]
decimal{2} ld_titolo[]
integer i, li_pos


if sqltype<>PreviewUpdate!	then
	if is_tipo_dw="data" then
		ls_sql=sqlsyntax
		
		if s_parametri.ll_magazzino>0 then
			ls_sql=ls_sql + " and (riga_documento.id_locazione_1= "+string(s_parametri.ll_magazzino)+" or riga_documento.id_locazione_2= "+string(s_parametri.ll_magazzino)+") "
			
		end if
		//210110 se ci sono righe esplose non le devo prendere (altrimenti i pesi in magazzino non torneranno mai:
		//se già il peso è nel prodotto finito, il peso dei suoi componenti non deve essere riconteggiato!)
		//a meno che non si tratti della stampa dei componenti
		
	
		if s_parametri.tipo_stampa<>'SD' and s_parametri.tipo_stampa<>'SV' then
			ls_sql=ls_sql + " and (riga_documento.id_riga_doc_padre is null )"
					
		end if
		//-----
		if s_parametri.li_fiscale=1 then
			ls_sql=ls_sql + " and not((caus_magazzino.mp_car_fiscali is null) and "&
			+"(caus_magazzino.mp_scar_fiscali is null) and (caus_magazzino.mp_val_caricato is null) and "&
			+"(caus_magazzino.mp_val_scaricato is null))"
		end if
		if upperbound(s_parametri.li_titolo)>0 then
			select t.titolo, m.codice
			into :ld_titolo[1], :ls_cod_met[1]
			from orafo_titolo t, orafo_metallo m
			where t.id_titolo=:s_parametri.li_titolo[1]
			and m.id_metallo=t.id_metallo;
			if sqlca.sqlcode<>0 then
				messagebox("Errore", "Titolo1 non recuperato correttamente:sqlpreview, dw_1, 24")
				return
			end if
			select t.titolo, m.codice
			into :ld_titolo[2], :ls_cod_met[2]
			from orafo_titolo t, orafo_metallo m
			where t.id_titolo=:s_parametri.li_titolo[2]
			and m.id_metallo=t.id_metallo;
			if sqlca.sqlcode<>0 then
				messagebox("Errore", "Titolo2 non recuperato correttamente:sqlpreview, dw_1, 33")
				return
			end if
			ls_titolo[1]=string(ld_titolo[1])
			ls_titolo[2]=string(ld_titolo[2])
			
			for i= 1 to 2
				li_pos=pos(ls_titolo[i], ",")
				if li_pos>0 then
					ls_titolo[i]=replace(ls_titolo[i], li_pos, 1, ".")
				end if
			next
			ls_sql=ls_sql + " and orafo_titolo.titolo>= "+ls_titolo[1]&
			+" and orafo_titolo.titolo<= "+ls_titolo[2]+" and orafo_metallo.codice= '"+ls_cod_met[1]+"'"
			
			
		end if
		if isvalid(s_lista_causali) then
			if upperbound(s_lista_causali.li_titolo)>0 then
				for i=1 to upperbound(s_lista_causali.li_titolo)
					if i=1 then
						ls_sql+=" and (caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
					else
						ls_sql+=" or caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
					end if
				next
				ls_sql+=")"
			end if
		end if
		
		if s_parametri.cambio>0 then
			ls_sql+=" and (documento.id_destinazione= "+string(s_parametri.cambio)+") "
		end if
		if il_id_sog>0 then
			ls_sql+=" and (documento.id_sog_commerciale= "+string(il_id_sog)+") "
		end if
		//aggiunto 091209 per silverdreams filtro per bollo articolo (campo riga_documento.sigla_prezzo)
		if s_parametri.bollo> " " then
			ls_sql+=" and (riga_documento.sigla_prezzo= '"+s_parametri.bollo+"') "
		end if
		//aggiunto 091209 per silverdreams filtro per cat-codifica articolo
		if s_parametri.id_cat_codifica> 0 then
			ls_sql+=" and (articolo.id_cat_codifica= "+string(s_parametri.id_cat_codifica) +") "
		end if
		//190711 per silverdreams filtro per calo
		if is_coef_calo> " " then
			ls_sql+=" and (riga_documento.coef_calo "+is_coef_calo+") "
		end if
		//messagebox("!", ls_sql)
		//if right(ls_sql, 2)="))" then ls_sql=left(ls_sql, len(ls_sql) - 1)
		
		i=SetSQLPreview(ls_sql)
		if i<>1 then
			messagebox("Errore!", "Filtro non applicato!")
		end if
	end if
end if
end event

type cb_st_no_importi from commandbutton within w_or_partitario_rpt
integer x = 3488
integer y = 36
integer width = 311
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ST_IMPORTI"
end type

event clicked;integer li_ret, i
long ll_righe

//datastore ds_stampa
//
//ds_stampa=create datastore
//
//ds_stampa.dataobject="d_data_tot_doc_stampa"
//ds_stampa.settransobject(sqlca)

//li_ret=dw_1.RowsCopy(dw_1.GetRow(), dw_1.RowCount(), Primary!, ds_stampa, 1, Primary!)
//ll_righe=dw_1.RowCount()
//for i= 1 to ll_righe
//	if dw_1.getitemdate(i, "documento_data_documento")>= s_parametri.da_data then
//		li_ret=dw_1.RowsCopy(ll_righe, ll_righe, Primary!, dw_3, dw_3.rowcount()+1, Primary!)
//	end if
//next
//dw_3.object.t_filtro.text=s_parametri.filtro
dw_3.settransobject(sqlca)
dw_3.retrieve(s_parametri.da_cod_art,s_parametri.a_cod_art,&
	s_parametri.da_sog_comm, s_parametri.a_sog_comm, &
	s_parametri.da_categoria, s_parametri.a_categoria, s_parametri.da_data,&
	s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro,s_parametri.totali_doc,&
	s_parametri.legato_fino, s_parametri.solo_preziosi,s_parametri.ll_magazzino, s_parametri.li_fiscale)

printsetup()
dw_3.print()
end event

type cb_retrieve from commandbutton within w_or_partitario_rpt
integer x = 2990
integer y = 36
integer width = 238
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
end type

event clicked;if is_test='D' then
	//aggiungo filtro per coef_calo mm 190711
	if s_parametri.segno_coef_calo<>"--" and s_parametri.segno_coef_calo> " " then
		is_coef_calo=s_parametri.segno_coef_calo+" "+string(s_parametri.coef_calo)
	end if
	//fine 190711
	
	cbx_vedi_righe.visible=true
	
	
	dw_1.retrieve(s_parametri.da_cod_art,s_parametri.a_cod_art,&
	s_parametri.da_sog_comm, s_parametri.a_sog_comm, &
	s_parametri.da_categoria, s_parametri.a_categoria, s_parametri.da_data,&
	s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro,s_parametri.totali_doc,&
	s_parametri.legato_fino, s_parametri.solo_preziosi,s_parametri.ll_magazzino, s_parametri.li_fiscale)

else
	dw_1.retrieve(s_parametri.da_cod_art,s_parametri.a_cod_art,&
	s_parametri.da_sog_comm, s_parametri.a_sog_comm, &
	s_parametri.da_categoria, s_parametri.a_categoria, s_parametri.da_data,&
	s_parametri.a_data, s_parametri.inizio_es,s_parametri.filtro,s_parametri.totali_doc,&
	s_parametri.legato_fino, s_parametri.solo_preziosi)
end if
if s_parametri.tipo_stampa<>"TG" then dw_1.object.datawindow.print.orientation=1

parent.post event ue_post_open()
end event

type cb_salva from commandbutton within w_or_partitario_rpt
integer x = 178
integer y = 36
integer width = 178
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if dw_1.update()=1 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "Salvataggio calo NON riuscito")
end if
end event

type dw_2 from udw_base within w_or_partitario_rpt
boolean visible = false
integer x = 1051
integer y = 1052
integer width = 1989
integer height = 364
integer taborder = 130
string dataobject = "d_esci_in_excel_ven_acq_met"
end type

type cb_excel from commandbutton within w_or_partitario_rpt
integer x = 2811
integer y = 36
integer width = 169
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Excel"
end type

event clicked;long ll_righe, i, ll_riga
decimal ldc_grammi, ldc_prezzo_metallo
date ldt_data_doc
string ls_num_doc, ls_cliente, ls_file
integer li_FileNum


integer li_ret, a
string ls_path, ls_file1, ls_name
long ll_rigains, ll_max
	

	dw_2.settransobject(sqlca)
	ll_righe=dw_1.rowcount()
	a=1
	for i= 1 to ll_righe
		ldc_grammi=dw_1.getitemdecimal(i, "riga_documento_peso_netto")
		ldc_prezzo_metallo=dw_1.getitemdecimal(i, "riga_documento_prezzo_metallo")
		ldt_data_doc=dw_1.getitemdate(i, "documento_data_documento")
		ls_cliente=dw_1.getitemstring(i, "sog_commerciale_gen_rag_soc_1")
		ls_num_doc=dw_1.getitemstring(i, "documento_num_documento")
		ll_riga=dw_2.insertrow(0)
		a++
			dw_2.setitem(ll_riga, "n_doc", ls_num_doc)
		dw_2.setitem(ll_riga, "data_doc", ldt_data_doc)
		dw_2.setitem(ll_riga, "grammi", ldc_grammi)
		dw_2.setitem(ll_riga, "metallo", ldc_prezzo_metallo)
		dw_2.setitem(ll_riga, "cliente", ls_cliente)	
	next
	
	
	
	ls_file="c:\start\spediz\excel_"+string(today(), "dd_mm_yy_hh_mm_ss")+".xls"
	i=dw_2.SaveAs(ls_file, excel8!, true)
	//	if i<>1 then
	//		messagebox("E", i)
	//	end if
end event

type ole_1 from olecontrol within w_or_partitario_rpt
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
event followhyperlink ( oleobject target )
event pivottableupdate ( oleobject target )
boolean visible = false
integer x = 2926
integer y = 1408
integer width = 850
integer height = 460
integer taborder = 140
boolean enabled = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_or_partitario_rpt.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type cb_inventario from commandbutton within w_or_partitario_rpt
boolean visible = false
integer x = 2546
integer y = 1664
integer width = 256
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inventario"
end type

event clicked;long ll_riga_gruppo
boolean lb_found
long ll_breakrow,ll_id_art
s_inventario s_inv
integer a
decimal ldc_prod, ldc_carico, ldc_scarico

ll_riga_gruppo=1
lb_found = FALSE
ll_breakrow = 0


DO WHILE ll_riga_gruppo >0

    ll_riga_gruppo = dw_1.FindGroupChange(ll_breakrow, 3)

//    // If no breaks are found, exit.
//
    IF ll_riga_gruppo <= 0 THEN EXIT
	 a++
    // faccio ciò che devo
    s_inv.cod_art[a]=dw_1.GetItemstring(ll_riga_gruppo,  "articolo_codice")  
	 s_inv.des_art[a]=dw_1.GetItemstring(ll_riga_gruppo,  "articolo_descrizione")
	 s_inv.id_art[a]=dw_1.GetItemnumber(ll_riga_gruppo,  "riga_documento_id_articolo")
	// s_inv.disponibilita[a]=dw_1.GetItemdecimal(ll_riga_gruppo,  "c_disp_gr_new")
	 ldc_scarico=dw_1.GetItemdecimal(ll_riga_gruppo,  "c_somma_scarico") 
	  ldc_carico=dw_1.GetItemdecimal(ll_riga_gruppo,  "c_somma_carico3") 
	  ldc_prod=	 dw_1.GetItemdecimal(ll_riga_gruppo,  "c_gr_imp_prod_bollo")  
	   s_inv.disponibilita[a]=ldc_carico - ldc_scarico - ldc_prod
		s_inv.bollo[a]=dw_1.GetItemstring(ll_riga_gruppo,  "bollo")
    // Increment starting row to find next break

    ll_breakrow = ll_riga_gruppo + 1

LOOP
openwithparm(w_inventario_cx, s_inv)

end event

type cbx_sottoscorta from checkbox within w_or_partitario_rpt
boolean visible = false
integer x = 1573
integer y = 76
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sottoscorta"
end type

event clicked;long i, ll_righe, a, ll_break2
boolean lb_found
string ls_ret
long ll_breakrow
decimal ldc_disp, ldc_disp1
//
dw_1.setredraw(false)
IF CHECKED THEN
	DW_1.SETFILTER("c_disp_bollo < 0")
	DW_1.FILTER()
	dw_1.sort()
	dw_1.groupcalc()
ELSE
	DW_1.SETFILTER("")
	DW_1.FILTER()
	dw_1.sort()
	dw_1.groupcalc()
END IF
dw_1.setredraw(true)



//	ll_righe=dw_1.ROWCOUNT()
////	for i= 1 to ll_righe
//		lb_found = FALSE
//		ll_breakrow = 0
//	
//		DO WHILE NOT (lb_found)
//			 ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 3)
//			 IF ll_breakrow <= 0 THEN EXIT
//			 ldc_disp=dw_1.GetItemdecimal(ll_breakrow, "c_disp_bollo")
//			
//			 //se c_disp_bollo<0 allora segno le righe (c_sottoscorta=1) 
//			 IF  ldc_disp <= 0 THEN
//				ll_break2= dw_1.FindGroupChange(ll_breakrow+1, 3)
//				IF ll_break2=0 THEN ll_break2=ll_righe
//				for a= ll_breakrow to ll_break2 - 1
//					dw_1.setitem(a, "c_sottoscorta", 1)
//				next
//			 END IF
//			 ll_breakrow = ll_breakrow + 1
//		LOOP		
//	next

//setredraw(true)
end event

type cbx_prod_zero from checkbox within w_or_partitario_rpt
boolean visible = false
integer x = 1573
integer y = 4
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prod. a 0"
end type

event clicked;dw_1.setredraw(false)
IF CHECKED THEN
	DW_1.SETFILTER("c_in_prod=0")
	DW_1.FILTER()
	dw_1.sort()
	dw_1.groupcalc()	
ELSE
	DW_1.SETFILTER("")
	DW_1.FILTER()
	dw_1.sort()
	dw_1.groupcalc()
END IF
dw_1.setredraw(true)
end event

type cbx_vedi_righe from checkbox within w_or_partitario_rpt
boolean visible = false
integer x = 997
integer y = 80
integer width = 334
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi righe"
end type

event clicked;if checked then
		
	dw_1.Modify("datawindow.detail.Height.AutoSize=Yes")

else
	dw_1.Modify("datawindow.detail.Height.AutoSize=No")
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

type cbx_ordina from checkbox within w_or_partitario_rpt
integer x = 997
integer y = 12
integer width = 293
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordina"
end type

event clicked;parent.setredraw(false)
dw_1.setredraw(false)
if checked then  //04-03-19 modifico su richiesta Eleonora
//	dw_1.setsort("orafo_metallo_codice, documento_data_documento, riga_documento_id_documento, documento_num_documento"+&
//				", sog_commerciale_gen_codice,"+&
//				"num_riga, articolo_codice")
	dw_1.setsort("orafo_metallo_codice, documento_data_documento, prof_documento_codice, documento_num_documento"+&
				", sog_commerciale_gen_codice,"+&
				"num_riga")
	dw_1.post GroupCalc()

else
	dw_1.setsort("orafo_metallo_codice,"+ &
				"documento_data_documento,"+&
				"documento_num_documento,"+&
				"riga_documento_id_documento,"+&
				"sog_commerciale_gen_codice,"+&
				"num_riga, articolo_codice")
	dw_1.post GroupCalc()
end if
dw_1.sort()
parent.setredraw(true)
dw_1.setredraw(true)
end event

type sle_pg from singlelineedit within w_or_partitario_rpt
integer x = 1335
integer y = 52
integer width = 215
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_or_partitario_rpt
integer x = 1339
integer width = 219
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "St. Pgg."
boolean focusrectangle = false
end type

type st_2 from statictext within w_or_partitario_rpt
integer x = 2318
integer y = 48
integer width = 151
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copie:"
boolean focusrectangle = false
end type

type sle_copie from singlelineedit within w_or_partitario_rpt
integer x = 2473
integer y = 32
integer width = 137
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_zoom from singlelineedit within w_or_partitario_rpt
integer x = 690
integer y = 32
integer width = 146
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;ii_zoom=integer(this.text)
wf_zoom()

end event

type cb_salva_su_file from commandbutton within w_or_partitario_rpt
boolean visible = false
integer x = 2313
integer y = 1644
integer width = 206
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Su File"
end type

event clicked;long ll_righe, i, ll_riga
decimal ldc_grammi, ldc_prezzo_metallo
date ldt_data_doc
string ls_num_doc, ls_cliente, ls_file
integer li_FileNum


integer li_ret, a
string ls_path, ls_file1, ls_name
long ll_rigains, ll_max
	
getfileopenname("Cerca file excel", ls_path, ls_name)
if  not(trim(ls_name)="" or isnull(ls_name)) then
	//ls_file1="C:\start\excel\"+left(ls_name, len(ls_name) - 4)+string(today(),"dd_mm_yy_hh_mm")+".xls"
	//li_FileNum = FileCopy (ls_path ,ls_file1, FALSE)
	ls_file1="C:\start\excel\modello.xlt"
	
//	ole_1.object.activesheet.saveas(ls_file1)
//	ole_1.object.close(False)
//
	ole_1.open(ls_path)
//
//	dw_2.settransobject(sqlca)
	ll_righe=dw_1.rowcount()
	a=1
	for i= 1 to ll_righe
		ldc_grammi=dw_1.getitemdecimal(i, "riga_documento_peso_netto")
		ldc_prezzo_metallo=dw_1.getitemdecimal(i, "riga_documento_prezzo_metallo")
		ldt_data_doc=dw_1.getitemdate(i, "documento_data_documento")
		ls_cliente=dw_1.getitemstring(i, "sog_commerciale_gen_rag_soc_1")
		ls_num_doc=dw_1.getitemstring(i, "documento_num_documento")
//		ll_riga=dw_2.insertrow(0)
		a++
		ole_1.object.activesheet.cells(a,1).value=ls_cliente
		ole_1.object.activesheet.cells(a,6).value=ldc_prezzo_metallo
		ole_1.object.activesheet.cells(a,3).value=ldt_data_doc
		ole_1.object.activesheet.cells(a,2).value=ls_num_doc
		ole_1.object.activesheet.cells(a,5).value=ldc_grammi
		
		
		
		
//		dw_2.setitem(ll_riga, "n_doc", ls_num_doc)
//		dw_2.setitem(ll_riga, "data_doc", ldt_data_doc)
//		dw_2.setitem(ll_riga, "grammi", ldc_grammi)
//		dw_2.setitem(ll_riga, "metallo", ldc_prezzo_metallo)
//		dw_2.setitem(ll_riga, "cliente", ls_cliente)	
	next
	
	ole_1.object.activesheet.saveas(ls_path)
	
	ole_1.object.activesheet.saveas(ls_file, 21)
	
	//ls_file="c:\start\spediz\prova_"+string(today(), "dd_mm_yyyy")+".xls"
	//i=dw_2.SaveAs(ls_file, excel8!, true)
	//	if i<>1 then
	//		messagebox("E", i)
	//	end if
ole_1.object.close(False)
end if	


//int li_rtn
//string ls_range
//long ll_excel_rows
//
//oleobject lole_excel, lole_workbook, lole_worksheet, lole_range
//lole_excel = create oleobject
//li_rtn = lole_excel.ConnectToNewObject("excel.application")
//if li_rtn <> 0 then
//      MessageBox( "Error", 'Error running MS Excel api.')
//      destroy lole_Excel
//else
//  lole_excel.WorkBooks.Open("C:\dati\prova.xlt") 
//
//  lole_workbook = lole_excel.application.workbooks(1)
//  lole_worksheet = lole_workbook.worksheets(1)
//
//  // Set the cell value
//  lole_worksheet.cells(1,11).value = "Some value" //it is cells(line, column)
//
//  //example to work on a range of cells
//  ls_range = "A1:F"+string(ll_excel_rows)
//  lole_range = lole_worksheet.Range(ls_range)
//  lole_range.Select
//  lole_range.Locked = True
//
//  // Save
//  lole_workbook.save("c:\start\spediz\prova111.xls")
//  // Quit
//  lole_excel.application.quit()
//  lole_excel.DisconnectObject()
//
//  destroy lole_Excel
//end if	 

end event

type cb_7 from commandbutton within w_or_partitario_rpt
integer x = 841
integer y = 36
integer width = 123
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Out"
end type

event clicked;ii_zoom=ii_zoom - 5
wf_zoom()
end event

type cb_6 from commandbutton within w_or_partitario_rpt
integer x = 594
integer y = 36
integer width = 96
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "In"
end type

event clicked;ii_zoom=ii_zoom+5
wf_zoom()
end event

type cb_imp_st from commandbutton within w_or_partitario_rpt
integer x = 2629
integer y = 36
integer width = 178
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imp. St."
end type

event clicked;printsetup()
dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_stampa from commandbutton within w_or_partitario_rpt
integer x = 3237
integer y = 36
integer width = 224
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_preview from commandbutton within w_or_partitario_rpt
boolean visible = false
integer x = 2432
integer y = 36
integer width = 187
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Preview"
end type

event clicked;parent.setredraw(false)
dw_1.setredraw(false)
if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_1.object.datawindow.print.preview='No'
	dw_1.object.datawindow.print.preview.rulers='no'
end if

parent.setredraw(true)
dw_1.setredraw(true)
end event

type cb_pg_dopo from commandbutton within w_or_partitario_rpt
integer x = 475
integer y = 36
integer width = 91
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_pg_prima from commandbutton within w_or_partitario_rpt
integer x = 375
integer y = 36
integer width = 91
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_1 from commandbutton within w_or_partitario_rpt
integer x = 37
integer y = 36
integer width = 114
integer height = 92
integer taborder = 110
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

type dw_1 from datawindow within w_or_partitario_rpt
integer y = 156
integer width = 3744
integer height = 1516
integer taborder = 120
string dataobject = "d_mov_soggetto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event printpage;
end event

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;string ls_sql, ls_titolo[],ls_cod_met[]
decimal{2} ld_titolo[]
integer i, li_pos


if sqltype<>PreviewUpdate!	then
	if is_tipo_dw="data" then
		ls_sql=sqlsyntax
		
		if s_parametri.ll_magazzino>0 then
			ls_sql=ls_sql + " and (riga_documento.id_locazione_1= "+string(s_parametri.ll_magazzino)+" or riga_documento.id_locazione_2= "+string(s_parametri.ll_magazzino)+")"
			
		end if
		//210110 se ci sono righe esplose non le devo prendere (altrimenti i pesi in magazzino non torneranno mai:
		//se già il peso è nel prodotto finito, il peso dei suoi componenti non deve essere riconteggiato!)
		//a meno che non si tratti della stampa dei componenti
		
	
		if s_parametri.tipo_stampa<>'SD' and s_parametri.tipo_stampa<>'SV' then
			ls_sql=ls_sql + " and (riga_documento.id_riga_doc_padre is null )"
					
		end if
		//-----
		if s_parametri.li_fiscale=1 then
			ls_sql=ls_sql + " and not((caus_magazzino.mp_car_fiscali is null) and "&
			+"(caus_magazzino.mp_scar_fiscali is null) and (caus_magazzino.mp_val_caricato is null) and "&
			+"(caus_magazzino.mp_val_scaricato is null))"
		end if
		if upperbound(s_parametri.li_titolo)>0 then
			select t.titolo, m.codice
			into :ld_titolo[1], :ls_cod_met[1]
			from orafo_titolo t, orafo_metallo m
			where t.id_titolo=:s_parametri.li_titolo[1]
			and m.id_metallo=t.id_metallo;
			if sqlca.sqlcode<>0 then
				messagebox("Errore", "Titolo1 non recuperato correttamente:sqlpreview, dw_1, 24")
				return
			end if
			select t.titolo, m.codice
			into :ld_titolo[2], :ls_cod_met[2]
			from orafo_titolo t, orafo_metallo m
			where t.id_titolo=:s_parametri.li_titolo[2]
			and m.id_metallo=t.id_metallo;
			if sqlca.sqlcode<>0 then
				messagebox("Errore", "Titolo2 non recuperato correttamente:sqlpreview, dw_1, 33")
				return
			end if
			ls_titolo[1]=string(ld_titolo[1])
			ls_titolo[2]=string(ld_titolo[2])
			
			for i= 1 to 2
				li_pos=pos(ls_titolo[i], ",")
				if li_pos>0 then
					ls_titolo[i]=replace(ls_titolo[i], li_pos, 1, ".")
				end if
			next
			ls_sql=ls_sql + " and orafo_titolo.titolo>= "+ls_titolo[1]&
			+" and orafo_titolo.titolo<= "+ls_titolo[2]+" and orafo_metallo.codice= '"+ls_cod_met[1]+"'"
			
			
		end if
		if s_parametri.ordinamento='S' then  //ordinamento=seleziona causali
			open(w_sel_causali_st)
			s_lista_causali=message.powerobjectparm
			if isvalid(s_lista_causali) then
				for i=1 to upperbound(s_lista_causali.li_titolo)
					if i=1 then
						ls_sql+=" and (caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
					else
						ls_sql+=" or caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
					end if
				next
				ls_sql+=")"
			else
				close(parent)
				return
			end if
		end if
		if s_parametri.cambio>0 then
			ls_sql+=" and (documento.id_destinazione= "+string(s_parametri.cambio)+")"
		end if
		if il_id_sog>0 then
			ls_sql+=" and (documento.id_sog_commerciale= "+string(il_id_sog)+")"
		end if
		//aggiunto 091209 per silverdreams filtro per bollo articolo (campo riga_documento.sigla_prezzo)
		if s_parametri.bollo> " " then
			ls_sql+=" and (riga_documento.sigla_prezzo= '"+s_parametri.bollo+"') "
		end if
		//aggiunto 091209 per silverdreams filtro per cat-codifica articolo
		if s_parametri.id_cat_codifica> 0 then
			ls_sql+=" and (articolo.id_cat_codifica= "+string(s_parametri.id_cat_codifica) +")"
		end if
		//190711 per silverdreams filtro per calo
		if is_coef_calo> " " then
			ls_sql+=" and (riga_documento.coef_calo "+is_coef_calo+") "
		end if
		//messagebox("!", ls_sql)
		//s_parametri.id_variazione è l'ID ARTICOLO, qundi filtro per quello
		if s_parametri.id_variazione>0 then
			ls_sql+=" and (riga_documento.id_articolo ="+string(s_parametri.id_variazione)+") "
		end if
			
			
		i=SetSQLPreview(ls_sql)
		if i<>1 then
			messagebox("Errore!", "Filtro non applicato!")
		end if
	end if
end if
end event

event doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 or is_test<>'D' then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "riga_documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

event itemchanged;decimal{2} ldc_calo, ldc_fino, ldc_coef_calo, ldc_peso, ldc_titolo

if dwo.name="riga_documento_coef_calo" then
	ldc_coef_calo=dec(data)
	ldc_peso=getitemdecimal(row, "riga_documento_peso_netto")
	if ldc_peso>0 then
		ldc_titolo=getitemdecimal(row, "orafo_titolo_titolo")
		ldc_coef_calo -= ldc_titolo
		ldc_calo=ldc_peso*ldc_coef_calo/1000
		//ldc_fino= getitemdecimal(row, "fino_riga")
//		ldc_test=ldc_fino - round( (ldc_peso*ldc_titolo/1000), 2)
//		if  ldc_test> 0.1 or  ldc_test < -0.1 then
//			
//		
			//if ldc_fino<0 then 
//			ldc_calo=ldc_calo - (ldc_fino* -1)
//			ldc_calo=ldc_calo * -1
//		else
//			ldc_calo=ldc_calo - ldc_fino
//		end if
		setitem(row, "riga_documento_calo", ldc_calo)
	end if
end if
end event

