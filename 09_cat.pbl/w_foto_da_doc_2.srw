forward
global type w_foto_da_doc_2 from w_stampa_001
end type
type p_1 from picture within w_foto_da_doc_2
end type
type cb_mail from commandbutton within w_foto_da_doc_2
end type
type ole_imm from olecustomcontrol within w_foto_da_doc_2
end type
type sle_margine_sx from singlelineedit within w_foto_da_doc_2
end type
type st_3 from statictext within w_foto_da_doc_2
end type
type cb_prod from commandbutton within w_foto_da_doc_2
end type
type dw_2 from u_dw_base within w_foto_da_doc_2
end type
type cb_2 from commandbutton within w_foto_da_doc_2
end type
type cbx_vedi_totali from checkbox within w_foto_da_doc_2
end type
end forward

global type w_foto_da_doc_2 from w_stampa_001
integer width = 3680
integer height = 2072
boolean maxbox = false
boolean resizable = false
windowstate windowstate = maximized!
p_1 p_1
cb_mail cb_mail
ole_imm ole_imm
sle_margine_sx sle_margine_sx
st_3 st_3
cb_prod cb_prod
dw_2 dw_2
cb_2 cb_2
cbx_vedi_totali cbx_vedi_totali
end type
global w_foto_da_doc_2 w_foto_da_doc_2

type variables
w_st_foto_articolo_cx iw_padre
string is_ruota
integer ii_w_max, ii_h_max, ii_x, ii_y
decimal{2} idc_scala
end variables

forward prototypes
public subroutine wf_crea_foto ()
public function integer wf_trova_ris (string as_h_v, string as_nome_imm)
public subroutine wf_crea_catalogo (s_ds_per_foto as_foto)
public function string wf_trova_dir_immagini ()
public subroutine wf_crea_bitmap (integer li_x, integer li_y)
public subroutine wf_crea_bitmap (string ls_h, string ls_w, integer li_x, integer li_y, string ls_imm, string ls_visible, string ls_nome, string ls_rettangolo, datastore as_dati_doc, long al_riga_ds)
public function string wf_traduci_tipo_doc (string as_lingua)
public subroutine wf_ruota_imm (string as_nome_imm, ref long al_larghezza_foto, ref long al_altezza_foto)
public subroutine wf_crea_parure (s_ds_per_foto as_foto)
public subroutine wf_anello (string as_imm)
public subroutine wf_dati_foto (ref long li_max_width, ref long li_max_height, ref long li_x, ref long li_y)
public subroutine wf_trova_dim_foto (long li_max_width, long li_max_height, string ls_imm, ref string ls_h, ref string ls_w, string as_tipo)
public subroutine wf_parure_2 (s_ds_per_foto as_foto)
end prototypes

public subroutine wf_crea_foto ();//long  ii_w_max,  ii_h_max, ii_x, ii_y
integer  li_mg_sx, Li_TEST, i
decimal ldc_coef_vert, ldc_coef_horz, LDC_H, LDC_W
string ls_imm, modstring, ls_ret, ls_nome, ls_visible
string ls_h, ls_w, modstring_line,modstring_rect, ls_select
string ls_nuovo, dwsyntax, ls_nome_col_dw, ls_path
string ls_null
long ll_inizio, ll_fine, ll_esiste
LONG ll_altezza_foto, ll_larghezza_foto
integer li_res_h, li_res_v, li_appoggio
long ll_id_art

//questa funzione sostituisce le righe commentate
//wf_dati_foto(ii_w_max, ii_h_max, ii_x, ii_y)

//select w_max_foto, h_max_foto, x_foto, y_foto
//into :ii_w_max, :ii_h_max, :ii_x, :ii_y
//from dba.orafo_par_sistema
//;
////valori espressi in cm/1000 (ricorda che anche la dw deve avere questa UM)
//if isnull(ii_w_max) or ii_w_max=0 then ii_w_max=16000
//if isnull(ii_h_max) or ii_h_max=0 then ii_h_max=26000
//if isnull(ii_x) or ii_x=0 then ii_x=200
//if isnull(ii_y) or ii_y=0 then ii_y=4000

if dw_1.dataobject='d_conferma_ordine_foto' then
	li_mg_sx=integer(sle_margine_sx.text)
	if li_mg_sx>0 then
		ii_w_max -= (li_mg_sx - 1200)
	end if
end if

ls_path=wf_trova_dir_immagini()
//select dir_immagini
//into :ls_path
//from par_sistema;
setnull(ls_null)
dw_1.setredraw(false)
for i=1 to dw_1.rowcount()
	ls_imm= dw_1.getitemstring(i, "nome_immagine")
	dw_1.setitem(i, "nome_immagine", ls_null)
	if pos(ls_imm, "\")=0 then
		ls_imm=ls_path+"\"+ls_imm
	end if
	ls_nome=string(i)
	ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'
	//ll_id_art=dw_1.getitemnumber(i, "id_articolo")
	//ls_visible='"1~tif(id_articolo='+string(ll_id_art)+', 1, 0)"'
	//inserisco una bitmap legata alla riga (se riga=num. bitmap allora visibile)
	if fileexists(ls_imm) then
		li_res_h=wf_trova_ris('V', ls_imm)
		li_res_v=wf_trova_ris('H', ls_imm)
		//la datawindow deve avere come unita di misura i cm/1000
		ldc_coef_horz=li_res_h/2540  //4
		ldc_coef_vert=li_res_v/2540		//6
				
		setredraw(false)
		p_1.picturename=ls_imm
		setredraw(true)
		ll_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
		ll_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
		
		ll_altezza_foto /= ldc_coef_vert
		ll_larghezza_foto /= ldc_coef_horz
		
		if ll_altezza_foto>ii_h_max and ll_altezza_foto>ll_larghezza_foto+5 then
			wf_ruota_imm(ls_imm, ll_larghezza_foto,ll_altezza_foto )
//			li_appoggio=ll_larghezza_foto
//			ll_larghezza_foto=ll_altezza_foto
//			ll_altezza_foto=li_appoggio
		end if

		
		if ll_altezza_foto>=ll_larghezza_foto then
			if ll_altezza_foto> ii_h_max then
				ls_h=string(ii_h_max)
				ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*ii_h_max,0))
			else
				ls_h=string(ll_altezza_foto)
				ls_w=string(ll_larghezza_foto)
			end if
				
		else
			if ll_larghezza_foto > ii_w_max then
				ls_w=string(ii_w_max)
				ls_h=string(round((ll_altezza_foto/ll_larghezza_foto)*ii_w_max,0))
				if integer(ls_h) > ii_h_max then
					ls_h=string(ii_h_max)
					ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*ii_h_max,0))
				end if
			else
				ls_w=string(ll_larghezza_foto)
				if ll_altezza_foto > ii_h_max then
					ls_h=string(ii_h_max)
					ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*ii_h_max,0))
				else
					ls_h=string(ll_altezza_foto)
				end if
			end if
		end if
		//creo la bitmap
		modstring = 'create bitmap(band=detail x="'+string(ii_x)+'" y="'+string(ii_y)+&
						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
						' visible='+ls_visible+&
						' resizeable=1  moveable=1  )'
			
		ls_ret=dw_1.Modify(modstring)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco il rettangolo di contorno alla foto
		ls_h=string(long(ls_h) + 80)
		ls_w=string(long(ls_w)+80)
		modstring_rect = 'create rectangle(band=detail x="'+string(ii_x - 40)+'" y="'+string(ii_y - 40)+&
				+ '" visible='+ls_visible &
				+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
				+' brush.color="553648127" pen.style="0" pen.width="10"'& 
				+' pen.color="0"  background.mode="1" background.color="0"'+ &
				' resizeable=1  moveable=1 )'
		ls_ret=dw_1.Modify(modstring_rect)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco una riga di divisione con il record successivo
		ls_h=string(long(ls_h) + ii_y+ 300)
		Li_TEST=INTEGER(DW_1.DESCRIBE("NOME_IMMAGINE_1.Y"))+integer(DW_1.describe("NOME_IMMAGINE_1.height"))
		if li_test>integer(ls_h) then ls_h=string(li_test+60) 
		modstring_line='create line(name=l_'+ls_nome+' moveable=1 resizeable=1 band=detail background.mode="2"'& 
			+' background.color="16777215" pen.style="0" pen.width="30" pen.color="0"'+&
			' visible='+ls_visible+&
			+' x1="21" y1="'+ls_h+'" x2="'+string(ii_w_max - 25)+'" y2="'+ls_h+'" )'
		ls_ret=dw_1.Modify(modstring_line)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
	//chiudo L'if del fileexists 
	end if
	
next
//richiama autosize detail
dw_1.modify("datawindow.detail.height.autosize=yes")
dw_1.setredraw(true)
setredraw(true)
end subroutine

public function integer wf_trova_ris (string as_h_v, string as_nome_imm);//
integer li_res
ole_imm.object.printsize=6
ole_imm.object.delimage=true
ole_imm.object.loadimage=as_nome_imm
if as_h_v='V' then
	li_res=ole_imm.object.imageYDpi
else
	li_res=ole_imm.object.imageXDpi
end if

return li_res
end function

public subroutine wf_crea_catalogo (s_ds_per_foto as_foto);string ls_imm, ls_path,  ls_h, ls_w, ls_rettangolo,ls_rif
integer i
//long ii_w_max, ii_h_max, ii_x, ii_y
integer li_w_disponibile, li_w_spazio
string modstring,ls_nome, ls_visible, ls_ret, modstring_rect,ls_titolo
long ll_riga
decimal ldc_peso_lordo, ldc_peso_netto, ldc_qta, ldc_importo

//wf_dati_foto(ii_w_max, ii_h_max, ii_x, ii_y)
ls_path=wf_trova_dir_immagini()

//
li_w_disponibile=21000 - ii_x

for i= 1 to as_foto.ds_dati_doc.rowcount()
	ls_imm=as_foto.ds_dati_doc.getitemstring(i, "nome_immagine")
	
	if pos(ls_imm, "\")=0 then
		ls_imm=ls_path+"\"+ls_imm
	end if
	wf_trova_dim_foto(ii_w_max, ii_h_max, ls_imm, ls_h, ls_w, "")
	ls_rettangolo='S'
	if ls_rettangolo='S' then
		li_w_spazio=100 + 80
	else
		li_w_spazio=100 	
	end if
	if li_w_disponibile - integer(ls_w) - li_w_spazio - 20 <=0 or i=1 then
		ll_riga=dw_1.insertrow(0)
		//se è òa prima riga recupero i totali qta, peso l e n, importo
		if i=1 then
			ldc_peso_lordo=as_foto.ds_dati_doc.getitemdecimal(1,"c_sum_peso_lordo")
			ldc_qta=as_foto.ds_dati_doc.getitemdecimal(1,"somma_qta")
			ldc_peso_netto=as_foto.ds_dati_doc.getitemdecimal(1,"somma_peso")
			ldc_importo=as_foto.ds_dati_doc.getitemdecimal(1,"c_importo")
			dw_1.setitem(1, "peso_lordo", ldc_peso_lordo)
			dw_1.setitem(1, "peso_netto", ldc_peso_netto)
			dw_1.setitem(1, "qta", ldc_qta)
			dw_1.setitem(1, "importo", ldc_importo)
		end if
		li_w_disponibile=21000 - ii_x
	end if
	
	ls_visible='"1~tif(getrow()='+string(ll_riga)+', 1, 0)"'
	ls_nome=string(ll_riga)
	wf_crea_bitmap(ls_h, ls_w, 21000 - li_w_disponibile, ii_y, ls_imm, ls_visible, &
						ls_nome, ls_rettangolo, as_foto.ds_dati_doc, i)
	
	li_w_disponibile =li_w_disponibile - (integer(ls_w) + li_w_spazio)
	
	
next
select rag_soc_1
into :ls_titolo
from dba.azienda;

if as_foto.ds_dati_doc.rowcount()>0 then
	ls_rif=as_foto.ds_dati_doc.getitemstring(1, "rif_doc") 
end if

dw_1.modify("t_1.text='"+ls_titolo+"'")
dw_1.modify("t_2.text='"+ls_rif+"'")
end subroutine

public function string wf_trova_dir_immagini ();string ls_path
select dir_immagini
into :ls_path
from par_sistema;
if isnull(ls_path) or ls_path <= " " then
	messagebox("Attenzione!", "Non è stata specificata una cartella per le immagini nei parametri di sistema!")
end if
return ls_path
	
end function

public subroutine wf_crea_bitmap (integer li_x, integer li_y);
end subroutine

public subroutine wf_crea_bitmap (string ls_h, string ls_w, integer li_x, integer li_y, string ls_imm, string ls_visible, string ls_nome, string ls_rettangolo, datastore as_dati_doc, long al_riga_ds);string modstring, modstring_rect, ls_ret, modstring_text
string ls_testo, ls_peso, ls_nome_imm, ls_prezzo, ls_mask, ls_peso_lordo
integer li_dec_prezzo, i
string ls_des_art, ls_sconto, ls_qta, ls_cm

modstring = 'create bitmap(band=detail x="'+string(li_x)+'" y="'+string(li_y)+&
						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
						' visible='+ls_visible+&
						' resizeable=1  moveable=1  )'
			
ls_ret=dw_1.Modify(modstring)
if ls_ret<>"" then 
	messagebox("ERRORE!", ls_ret)
end if

//inserisco i testi sotto la foto
ls_testo=as_dati_doc.getitemstring(al_riga_ds, "cod_articolo")
if iw_padre.dw_3.Describe("peso_unitario_t.Color")='16777215' then
	ls_peso=string(as_dati_doc.getitemdecimal(al_riga_ds, "peso_unitario"), "#,0.00")
end if
if iw_padre.dw_3.Describe("peso_lordo_t.Color")='16777215' then
	ls_peso_lordo=string(as_dati_doc.getitemdecimal(al_riga_ds, "peso_lordo"), "#,0.00")
end if
if iw_padre.dw_3.Describe("nome_immagine_t.Color")='16777215' then
	ls_nome_imm=as_dati_doc.getitemstring(al_riga_ds, "nome_immagine")
end if
if iw_padre.dw_3.Describe("prezzo_t.Color")='16777215' then
	ls_mask="#,0."
	li_dec_prezzo=integer(iw_padre.ddlb_dec_prezzo.text)
	for i=1 to li_dec_prezzo
		ls_mask+="0"
	next
	
	ls_prezzo=string(as_dati_doc.getitemdecimal(al_riga_ds, "prezzo"), ls_mask)
end if

if iw_padre.dw_3.Describe("des_articolo_t.Color")='16777215' then
	ls_des_art=" - "+as_dati_doc.getitemstring(al_riga_ds, "des_articolo")
end if
if iw_padre.dw_3.Describe("sconto_t.Color")='16777215' then
	ls_sconto=string(as_dati_doc.getitemdecimal(al_riga_ds, "sconto"), "#,0.00")
end if
if iw_padre.dw_3.Describe("qta_t.Color")='16777215' then
	ls_qta=string(as_dati_doc.getitemdecimal(al_riga_ds, "qta"), "#,0")
end if
if iw_padre.dw_3.Describe("lunghezza_t.Color")='16777215' then
	ls_cm=string(as_dati_doc.getitemdecimal(al_riga_ds, "lunghezza"), "#,0.00")
end if

if ls_cm>'0,00' then ls_cm=" - CM. "+ls_cm else ls_cm="" 
if ls_peso>'0,00' then ls_peso=" - gr. "+ls_peso else ls_peso=""
if ls_peso_lordo>'0,00' then ls_peso_lordo=" - Lordo gr. "+ls_peso_lordo else ls_peso_lordo=""
if ls_nome_imm>"" then ls_nome_imm=" - File: "+ls_nome_imm else ls_nome_imm=""
if ls_prezzo>"0,0000" then ls_prezzo=" - €. "+ls_prezzo else ls_prezzo=""
if isnull(ls_des_art) then ls_des_art=""   
if ls_sconto>"0,00" then ls_sconto=" - Sc%: "+ls_sconto else ls_sconto=""
if ls_qta>'0' then  ls_qta= "  - Q.ta: "+ls_qta else ls_qta="" 
ls_testo=ls_testo+ ls_peso +ls_peso_lordo+ ls_cm+ ls_nome_imm+ls_prezzo+ls_des_art+ls_sconto+ls_qta
//

modstring_text = 'create text(name=t_'+ls_nome+' moveable=1 resizeable=1 band=detail' & 
  		+' visible='+ls_visible+&
		 +' font.charset="0"'&
		+' font.face="MS Sans Serif" font.family="2" font.height="-8" font.italic="0"' &
		+' font.pitch="2"'& 
		+' font.weight="400" font.underline="0" background.mode="1"'&
		+' background.color="0" color="0" alignment="2" border="2"'&
		+' x="'+string(li_x)+'" y="'+string(li_y+integer(ls_h)+100)+'"'&
		+' height="400" height.AutoSize=yes width="'+ls_w+'" text="'+ls_testo+'" )'
		
				
ls_ret=dw_1.Modify(modstring_text)
if ls_ret<>"" then 
	messagebox("ERRORE!", ls_ret)
end if

//inserisco il rettangolo di contorno alla foto
if ls_rettangolo='S' then
	ls_h=string(long(ls_h) + 80)
	ls_w=string(long(ls_w)+80)
	modstring_rect = 'create rectangle(band=detail x="'+string(li_x - 40)+'" y="'+string(li_y - 40)+&
			+ '" visible='+ls_visible &
			+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
			+' brush.color="553648127" pen.style="0" pen.width="10"'& 
			+' pen.color="0"  background.mode="1" background.color="0"'+ &
			' resizeable=1  moveable=1 )'
	ls_ret=dw_1.Modify(modstring_rect)
	if ls_ret<>"" then 
		messagebox("ERRORE!", ls_ret)
	end if
end if		



end subroutine

public function string wf_traduci_tipo_doc (string as_lingua);string ls_traduzione, ls_des_stampa
long ll_id_riga, ll_righe, ll_riga_trovata
datastore ds_traduzione

ll_id_riga=dw_1.getitemnumber(1, "riga_documento")
select des_stampa
into :ls_des_stampa
from prof_documento p, documento d, riga_documento r
where r.id_riga_documento=:ll_id_riga
and d.id_documento=r.id_documento
and d.id_prof_documento=p.id_prof_documento
;
if isnull(ls_des_stampa) then ls_des_stampa='ORDINE'
if as_lingua="italiano" then
	ls_traduzione=ls_des_stampa
else
	ls_traduzione=f_traduci("italiano", as_lingua, ls_des_stampa)
end if
return ls_traduzione
end function

public subroutine wf_ruota_imm (string as_nome_imm, ref long al_larghezza_foto, ref long al_altezza_foto);long ll_format, ll_appoggio
//inserito 06-11-09 per Cristina: vediamo se smettono di girare le foto
//da riguardare perché così non puà andare
//return
if is_ruota <> 'S' THEN
	//ocx deve caricare immagini senza distorcerle
	ole_imm.object.printsize=6
	//cancello immagine precedente
	ole_imm.object.delimage=true
	//carico imm
	ole_imm.object.loadimage=as_nome_imm
	//trovo il tipo dell'immagine corrente (jpg)
	ll_format = ole_imm.object.FileType
	//imposto il tipo di file da salvare (recuperato sopra: jpg)
	ole_imm.object.saveformat=ll_format
	//salvo una copia
	ole_imm.object.saveimage=as_nome_imm+"copia"
	//ruoto
	ole_imm.object.Rotate = 270
	FileDelete ( as_nome_imm )
	//salvo
	ole_imm.object.saveimage=as_nome_imm
	//giro l'immagine (scambio larghezza con altezza) 070709
	ll_appoggio=al_larghezza_foto
	al_larghezza_foto=al_altezza_foto
	al_altezza_foto=ll_appoggio
	
end if
//se aggiungi un path ad as_nome imm puoi non sovrascrivere il file
//e poi cancellarlo alla fine

//Ciao Marco


end subroutine

public subroutine wf_crea_parure (s_ds_per_foto as_foto);integer LI_MAX_width, LI_MAX_height, i, a
string ls_h, ls_w, ls_path, ls_imm, ls_tipo_riga,ls_imm_1, modstring, ls_azienda
long ll_id_art,ll_format,ll_altezza_foto, ll_larghezza_foto
INTEGER li_x, li_y 
string ls_nome, ls_visible, ls_ret, modstring_rect, modstring_txt,ls_cod_art
decimal ldc_grammi



for i= 1 to as_foto.ds_dati_doc.rowcount()
	
	ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'  
	
	ll_id_art=as_foto.ds_dati_doc.getitemnumber(i, "ID_ARTICOLO")
	
	ls_path=wf_trova_dir_immagini()
	
	declare trova_imm cursor for
	select a.immagine, r.varie, a.codice, u.peso_netto
	from articolo a, riga_distinta r, distinta d, unita_confezione u
	where d.id_articolo=:ll_id_art
	and r.id_distinta=d.id_distinta
	and r.id_articolo=a.id_articolo
	and r.id_articolo=u.id_articolo
	and u.unita_base='S'
	;
	
	open trova_imm;
	
		
			FETCH trova_imm INTO :ls_imm_1, :ls_tipo_riga, :ls_cod_art, :ldc_grammi;
			
		do while sqlca.sqlcode=0	
			ls_imm=ls_path+"\"+ls_imm_1
			if ls_tipo_riga='1' then //anello
				ls_nome="AN_"+string(i)
				li_x=120
				li_y=600
				wf_trova_dim_foto(6500, 6500, ls_imm, ls_h, ls_w, ls_tipo_riga)
			end if
			if ls_tipo_riga='2' then //orecchino
				ls_nome="OR_"+string(i)
				li_x=6000
				li_y=600
				wf_trova_dim_foto(7000, 7000, ls_imm,ls_h, ls_w, ls_tipo_riga)
			end if
			if ls_tipo_riga='3' then //collana
				ls_nome="CL_"+string(i)
				li_x=120
				li_y=8700
				wf_trova_dim_foto(13000, 17000, ls_imm,ls_h, ls_w, ls_tipo_riga)
			end if
			if ls_tipo_riga='4' then //bracciale
				ls_nome="BR_"+string(i)
				li_x=13900
				li_y=600	
				p_1.picturename=ls_imm
				ll_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
				ll_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
				if ll_larghezza_foto>ll_altezza_foto then
					
					if fileexists(left(ls_imm, len(ls_imm) - 4)+"_V.jpg") then
						ls_imm=left(ls_imm, len(ls_imm) - 4)+"_V.jpg"
					else
						ole_imm.object.printsize=6
						//cancello immagine precedente
						ole_imm.object.delimage=true
						//carico imm
						ole_imm.object.loadimage=ls_imm
						//trovo il tipo dell'immagine corrente (jpg)
						ll_format = ole_imm.object.FileType
						//imposto il tipo di file da salvare (recuperato sopra: jpg)
						ole_imm.object.saveformat=ll_format
						//ruoto
						ole_imm.object.Rotate = 270
						//salvo
						ole_imm.object.saveimage=left(ls_imm, len(ls_imm) - 4)+"_V.jpg"
						ls_imm=left(ls_imm, len(ls_imm) - 4)+"_V.jpg"
					end if
				end if
				wf_trova_dim_foto(14000, 18500, ls_imm, ls_h, ls_w, ls_tipo_riga)
			  end if
			//creo la bitmap
				modstring = 'create bitmap(band=detail x="'+string(li_x)+'" y="'+string(li_y)+&
							'" height="'+ls_h +'" width="'+ ls_w+'" '+&
							'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
							' visible='+ls_visible+&
							' resizeable=1  moveable=1  )' 
				
				ls_ret=dw_1.Modify(modstring)
				if ls_ret<>"" then 
					messagebox("ERRORE Anello!", ls_ret)
				end if
			//inserisco il rettangolo di contorno alla foto
				ls_h=string(long(ls_h) + 80)
				ls_w=string(long(ls_w)+80)
				modstring_rect = 'create rectangle(band=detail x="'+string(li_x - 40)+'" y="'+string(li_y - 40) &
					+ '" visible='+ls_visible &
					+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
					+' brush.color="553648127" pen.style="0" pen.width="10"'& 
					+' pen.color="0"  background.mode="1" background.color="0"'+ &
					' resizeable=1  moveable=1 )'
				ls_ret=dw_1.Modify(modstring_rect)
				if ls_ret<>"" then 
					messagebox("ERRORE!", ls_ret)
				end if
				//inserisco il testo: codice dell'articolo
				//e peso in gr. //aggiunto su richiesta Lucio 150610
				if ldc_grammi>0 then
					ls_cod_art+="  -  gr. "+string(ldc_grammi, "#,0.00")
				end if
				li_y=li_y+integer(ls_h)+200
				modstring_txt = 'create text(name=t_'+ls_nome+' moveable=1 resizeable=1 band=detail'& 
				+ ' visible='+ls_visible &
			+' font.charset="0"'&
			+' font.face="MS Sans Serif" font.family="2" font.height="-8" font.italic="0" font.pitch="2"'& 
			+' font.weight="400" font.underline="0" background.mode="1" background.color="0" color="0"'& 
			+' alignment="2" border="2" x="'+string(li_x - 40)+'" y="'+string(li_y)+&
			+'" height="450" width="'+ls_w+'" text="'+ls_cod_art+'" )'
				ls_ret=dw_1.Modify(modstring_txt)
				if ls_ret<>"" then 
					messagebox("ERRORE!", ls_ret)
				end if
			FETCH trova_imm INTO :ls_imm_1, :ls_tipo_riga, :ls_cod_art, :ldc_grammi;
		loop
	close trova_imm;


next
//inserisco la rag-sociale dell'azienda
select rag_soc_1
into :ls_azienda
from dba.azienda
;
dw_1.modify("t_azienda.text='"+ls_azienda+"'")
end subroutine

public subroutine wf_anello (string as_imm);
end subroutine

public subroutine wf_dati_foto (ref long li_max_width, ref long li_max_height, ref long li_x, ref long li_y);

//select w_max_foto, h_max_foto, x_foto, y_foto
//into :LI_MAX_width, :LI_MAX_height, :li_x, :li_y
//from dba.orafo_par_sistema
//;

//valori espressi in cm/1000 (ricorda che anche la dw deve avere questa UM)
if isnull(LI_MAX_width) or LI_MAX_width=0 then 
	LI_MAX_width=20000
	messagebox("Attenzione!", "Larghezza max non valorizzata! Sarà automaticamente impostata a 20cm.")
end if
if isnull(LI_MAX_height) or LI_MAX_height=0 then 
	messagebox("Attenzione!", "Altezza max non valorizzata! Sarà automaticamente impostata a 20cm.")
	LI_MAX_height=28000
end if
if isnull(li_x) or li_x=0 then li_x=200
if isnull(li_y) or li_y=0 then li_y=1000
end subroutine

public subroutine wf_trova_dim_foto (long li_max_width, long li_max_height, string ls_imm, ref string ls_h, ref string ls_w, string as_tipo);	integer  li_appoggio

	long ll_altezza_foto, ll_larghezza_foto, li_res_h, li_res_v
	decimal ldc_coef_horz, ldc_coef_vert
	
	
	if fileexists(ls_imm) then
		li_res_h=wf_trova_ris('V', ls_imm)
		li_res_v=wf_trova_ris('H', ls_imm)
		//la datawindow deve avere come unita di misura i cm/1000
		ldc_coef_horz=li_res_h/2540  //4
		ldc_coef_vert=li_res_v/2540		//6		
		p_1.picturename=ls_imm
		ll_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
		ll_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
		choose case as_tipo
			case '4', '3'  //è un bracciale o una collana della stampa parure, non va in orizzontale, ma in verticale
				if ll_altezza_foto<ll_larghezza_foto then
					//larghezza e altezza passate per referenza
					wf_ruota_imm(ls_imm, ll_larghezza_foto, ll_altezza_foto)
				end if
			case "1", "2" //anelli e orecchini vanno in orizzontale
				if ll_larghezza_foto <ll_altezza_foto then
					//larghezza e altezza passate per referenza
					wf_ruota_imm(ls_imm, ll_larghezza_foto, ll_altezza_foto)
				end if
		end choose
		ll_altezza_foto /= ldc_coef_vert
		ll_larghezza_foto /= ldc_coef_horz
		
//		if ll_altezza_foto>LI_MAX_height and ll_altezza_foto>ll_larghezza_foto+5 and as_tipo<>'4' then
//			//larghezza e altezza passate per referenza
//			wf_ruota_imm(ls_imm, ll_larghezza_foto, ll_altezza_foto)
////			li_appoggio=ll_larghezza_foto
////			ll_larghezza_foto=ll_altezza_foto
////			ll_altezza_foto=li_appoggio
//		end if
//09-10-12 inserisco un valore di scala scelto dall'utente (se c'è ovvero <>100%)
	if not (isnull(idc_scala)) and idc_scala<>100 then
		ll_altezza_foto*=idc_scala/100
		ll_larghezza_foto*=idc_scala/100
	end if
//0901012 fine

		
		//if ll_altezza_foto>=ll_larghezza_foto then
		if ll_altezza_foto> LI_MAX_height then
			ll_altezza_foto=LI_MAX_height
			ll_larghezza_foto=round((ll_larghezza_foto/ll_altezza_foto)*LI_MAX_height,0)
		end if
		if ll_larghezza_foto > LI_MAX_width then
			ll_larghezza_foto=LI_MAX_width
			ll_altezza_foto=round((ll_altezza_foto/ll_larghezza_foto)*LI_MAX_width,0)
		end if
		ls_h=string(ll_altezza_foto)
		ls_w=string(ll_larghezza_foto)	
//			ls_h=string(LI_MAX_height)
//			ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*LI_MAX_height,0))
//			
//		end if
//			else
//				if ll_larghezza_foto>LI_MAX_width then
//					
//				else
//					ls_h=string(ll_altezza_foto)
//					ls_w=string(ll_larghezza_foto)
//				end if
//			end if
				
		//else
//		if ls_w
//		
//			if ll_larghezza_foto > LI_MAX_width then
//				ls_w=string(LI_MAX_width)
//				ls_h=string(round((ll_altezza_foto/ll_larghezza_foto)*LI_MAX_width,0))
//				
//				if integer(ls_h) > LI_MAX_height then
//					ls_h=string(LI_MAX_height)
//					ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*LI_MAX_height,0))
//				end if
//			else
//				ls_w=string(ll_larghezza_foto)
//				if ll_altezza_foto > LI_MAX_height then
//					ls_h=string(LI_MAX_height)
//					ls_w=string(round((ll_larghezza_foto/ll_altezza_foto)*LI_MAX_height,0))
//				else
//					ls_h=string(ll_altezza_foto)
//				end if
			//end if
		//end if
	end if
end subroutine

public subroutine wf_parure_2 (s_ds_per_foto as_foto);integer LI_MAX_width, LI_MAX_height, i, a
string ls_h, ls_w, ls_path, ls_imm, ls_tipo_riga,ls_imm_1, modstring, ls_azienda
long ll_id_art,ll_format,ll_altezza_foto, ll_larghezza_foto
INTEGER li_x, li_y 
string ls_nome, ls_visible, ls_ret, modstring_rect, modstring_txt,ls_cod_art
decimal ldc_grammi



for i= 1 to as_foto.ds_dati_doc.rowcount()
	
	ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'  
	
	ll_id_art=as_foto.ds_dati_doc.getitemnumber(i, "ID_ARTICOLO")
	
	ls_path=wf_trova_dir_immagini()
	
	declare trova_imm cursor for
	select a.immagine, r.varie, a.codice, u.peso_netto
	from articolo a, riga_distinta r, distinta d, unita_confezione u
	where d.id_articolo=:ll_id_art
	and r.id_distinta=d.id_distinta
	and r.id_articolo=a.id_articolo
	and r.id_articolo=u.id_articolo
	and u.unita_base='S'
	;
	
	open trova_imm;
	
		
			FETCH trova_imm INTO :ls_imm_1, :ls_tipo_riga, :ls_cod_art, :ldc_grammi;
			
		do while sqlca.sqlcode=0	
			ls_imm=ls_path+"\"+ls_imm_1
			if ls_tipo_riga='1' then //anello
				ls_nome="AN_"+string(i)
				li_x=120
				li_y=21200
				
				wf_trova_dim_foto(7000, 7000, ls_imm, ls_h, ls_w, ls_tipo_riga)
				
			end if
			if ls_tipo_riga='2' then //orecchino
				ls_nome="OR_"+string(i)
				li_x=6000
				li_y=21200
				wf_trova_dim_foto(7000, 7000, ls_imm,ls_h, ls_w, ls_tipo_riga)
			end if
			if ls_tipo_riga='3' then //collana
				ls_nome="CL_"+string(i)
				li_x=120
				li_y=500
				wf_trova_dim_foto(14600, 20000, ls_imm,ls_h, ls_w, ls_tipo_riga)
			end if
			if ls_tipo_riga='4' then //bracciale
				ls_nome="BR_"+string(i)
				li_x=14900
				li_y=500
				p_1.picturename=ls_imm
				ll_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
				ll_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
				if ll_larghezza_foto>ll_altezza_foto then
					
					if fileexists(left(ls_imm, len(ls_imm) - 4)+"_V.jpg") then
						ls_imm=left(ls_imm, len(ls_imm) - 4)+"_V.jpg"
					else
						ole_imm.object.printsize=6
						//cancello immagine precedente
						ole_imm.object.delimage=true
						//carico imm
						ole_imm.object.loadimage=ls_imm
						//trovo il tipo dell'immagine corrente (jpg)
						ll_format = ole_imm.object.FileType
						//imposto il tipo di file da salvare (recuperato sopra: jpg)
						ole_imm.object.saveformat=ll_format
						//ruoto
						ole_imm.object.Rotate = 270
						//salvo
						ole_imm.object.saveimage=left(ls_imm, len(ls_imm) - 4)+"_V.jpg"
						ls_imm=left(ls_imm, len(ls_imm) - 4)+"_V.jpg"
					end if
				end if
				wf_trova_dim_foto(4600, 24000, ls_imm, ls_h, ls_w, ls_tipo_riga)
			 end if
			//creo la bitmap
				modstring = 'create bitmap(band=detail x="'+string(li_x)+'" y="'+string(li_y)+&
							'" height="'+ls_h +'" width="'+ ls_w+'" '+&
							'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
							' visible='+ls_visible+&
							' resizeable=1  moveable=1  )' 
				
				ls_ret=dw_1.Modify(modstring)
				if ls_ret<>"" then 
					messagebox("ERRORE Anello!", ls_ret)
				end if
			//inserisco il rettangolo di contorno alla foto
				ls_h=string(long(ls_h) + 80)
				ls_w=string(long(ls_w)+80)
				modstring_rect = 'create rectangle(band=detail x="'+string(li_x - 40)+'" y="'+string(li_y - 40) &
					+ '" visible='+ls_visible &
					+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
					+' brush.color="553648127" pen.style="0" pen.width="10"'& 
					+' pen.color="0"  background.mode="1" background.color="0"'+ &
					' resizeable=1  moveable=1 )'
				ls_ret=dw_1.Modify(modstring_rect)
				if ls_ret<>"" then 
					messagebox("ERRORE!", ls_ret)
				end if
				//inserisco il testo: codice dell'articolo
				//e peso in gr. //aggiunto su richiesta Lucio 150610
				if ldc_grammi>0 then
					ls_cod_art+="  -  gr. "+string(ldc_grammi, "#,0.00")
				end if
				li_y=li_y+integer(ls_h)//+100 //200
				modstring_txt = 'create text(name=t_'+ls_nome+' moveable=1 resizeable=1 band=detail'& 
				+ ' visible='+ls_visible &
			+' font.charset="0"'&
			+' font.face="MS Sans Serif" font.family="2" font.height="-8" font.italic="0" font.pitch="2"'& 
			+' font.weight="400" font.underline="0" background.mode="1" background.color="0" color="0"'& 
			+' alignment="2" border="2" x="'+string(li_x - 40)+'" y="'+string(li_y)+&
			+'" height="450" width="'+ls_w+'" text="'+ls_cod_art+'" )'
				ls_ret=dw_1.Modify(modstring_txt)
				if ls_ret<>"" then 
					messagebox("ERRORE!", ls_ret)
				end if
			FETCH trova_imm INTO :ls_imm_1, :ls_tipo_riga, :ls_cod_art, :ldc_grammi;
		loop
	close trova_imm;


next
//inserisco la rag-sociale dell'azienda
select rag_soc_1
into :ls_azienda
from dba.azienda
;
dw_1.modify("t_azienda.text='"+ls_azienda+"'")
end subroutine

on w_foto_da_doc_2.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_mail=create cb_mail
this.ole_imm=create ole_imm
this.sle_margine_sx=create sle_margine_sx
this.st_3=create st_3
this.cb_prod=create cb_prod
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cbx_vedi_totali=create cbx_vedi_totali
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_mail
this.Control[iCurrent+3]=this.ole_imm
this.Control[iCurrent+4]=this.sle_margine_sx
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.cb_prod
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cbx_vedi_totali
end on

on w_foto_da_doc_2.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_mail)
destroy(this.ole_imm)
destroy(this.sle_margine_sx)
destroy(this.st_3)
destroy(this.cb_prod)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cbx_vedi_totali)
end on

event open;call super::open;s_ds_per_foto s_foto
string  ls_rag_soc, ls_codice
integer i 
long ll_id_sog, ll_id_riga
date ldt_data


setredraw(false)

s_foto=message.PowerObjectParm	
is_ruota=s_foto.ruota
iw_padre=s_foto.w_padre
ii_w_max=s_foto.li_max_larghezza
ii_h_max=s_foto.li_max_altezza
ii_x=s_foto.li_x_foto
ii_y=s_foto.li_y_foto


dw_1.dataobject=s_foto.dw

if s_foto.dw='d_cat_uno_a_uno' then
	cbx_vedi_totali.visible=true
	idc_scala=s_foto.scala
	wf_crea_catalogo(s_foto)
elseif s_foto.dw='d_foto_art_da_documento_parure' then
	s_foto.ds_dati_doc.rowscopy(1, s_foto.ds_dati_doc.rowcount(), primary!, dw_1, 1, primary!)
	wf_crea_parure(s_foto)
elseif s_foto.dw='d_foto_art_da_documento_parure2' then
	s_foto.ds_dati_doc.rowscopy(1, s_foto.ds_dati_doc.rowcount(), primary!, dw_1, 1, primary!)
	wf_parure_2(s_foto)
else
	
	s_foto.ds_dati_doc.rowscopy(1, s_foto.ds_dati_doc.rowcount(), primary!, dw_1, 1, primary!)
	
	if dw_1.rowcount()>0 then
		ll_id_sog=dw_1.getitemnumber(1, "id_sog_commerciale")
		if ll_id_sog>0 then
			select rag_soc_1, codice
			into :ls_rag_soc, :ls_codice
			from dba.sog_commerciale_gen
			where id_sog_commerciale=:ll_id_sog
			;
			ls_rag_soc="INTESTATARIO: "+ls_rag_soc + " - "+ls_codice
		else
			ls_rag_soc="Stampa Articoli con Foto"
		end if
		DW_1.OBJECT.T_RAG_SOC.TEXT=ls_rag_soc
		ll_id_riga=dw_1.getitemnumber(1, "riga_documento")
		if ll_id_riga>0 then
			select data_prev_consegna
			into :ldt_data
			from documento d, riga_Documento r
			where d.id_documento=r.id_documento
			and r.id_riga_Documento=:ll_id_riga
			;
			DW_1.OBJECT.t_data_scadenza.TEXT="Data Scadenza: "+string(ldt_data)
		end if
		
	end if
	if dw_1.dataobject='d_conferma_ordine_foto' then
		sle_margine_sx.text='3200'
	end if
	wf_crea_foto()
end if	
dw_2.insertrow(1)
	
	

end event

event close;call super::close;if isvalid(w_traduzioni_cx) then
	close(w_traduzioni_cx)
end if
end event

type dw_1 from w_stampa_001`dw_1 within w_foto_da_doc_2
integer y = 220
integer height = 1572
string dataobject = "d_foto_art_da_documento_2"
end type

event dw_1::clicked;call super::clicked;//long i, ll_righe, ll_row
//
//if row>0 then
//	if KeyDown(KeyShift!) then
//		ll_righe=RowCount()
//		for i= 1 to ll_righe
//			if IsSelected(i) then 
//				ll_row=i
//				exit
//			end if
//		next
//		if ll_row>0 then
//			for i=ll_row+1 to row
//				selectrow(i, true) 
//			next
//		else
//			messagebox("Attenzione!", "Occorre selezionare la riga iniziale delle selezione multipla!")
//		end if
//	elseif KeyDown(KeyControl!) then
//		 selectrow(row, not IsSelected(row))
//	else
//		for i=1 to rowcount()
//			selectrow(i, false) 
//		next
//	 	selectrow(row, true)
//	end if
//end if	
//
end event

type sle_pg from w_stampa_001`sle_pg within w_foto_da_doc_2
integer width = 517
end type

type st_1 from w_stampa_001`st_1 within w_foto_da_doc_2
end type

type st_2 from w_stampa_001`st_2 within w_foto_da_doc_2
integer x = 1984
integer y = 44
end type

type sle_copie from w_stampa_001`sle_copie within w_foto_da_doc_2
integer x = 2130
integer width = 178
end type

type sle_zoom from w_stampa_001`sle_zoom within w_foto_da_doc_2
integer x = 658
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_foto_da_doc_2
integer x = 2930
end type

type cb_7 from w_stampa_001`cb_7 within w_foto_da_doc_2
integer x = 809
end type

type cb_6 from w_stampa_001`cb_6 within w_foto_da_doc_2
integer x = 544
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_foto_da_doc_2
integer x = 2615
end type

type cb_stampa from w_stampa_001`cb_stampa within w_foto_da_doc_2
end type

event cb_stampa::clicked;printsetup()
long job,ll_margine_sx

ll_margine_sx=long(sle_margine_sx.text)
if ll_margine_sx>0 then
	dw_1.Modify("DataWindow.Print.Margin.left="+string(ll_margine_sx))
end if
job = PrintOpen( )

// Each DataWindow starts printing on a new page.

PrintDataWindow(job, dw_1)

PrintClose(job)
end event

type cb_preview from w_stampa_001`cb_preview within w_foto_da_doc_2
integer x = 2322
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_foto_da_doc_2
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_foto_da_doc_2
end type

type cb_1 from w_stampa_001`cb_1 within w_foto_da_doc_2
end type

type p_1 from picture within w_foto_da_doc_2
boolean visible = false
integer x = 919
integer y = 1728
integer width = 1801
integer height = 2148
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type cb_mail from commandbutton within w_foto_da_doc_2
integer x = 942
integer y = 36
integer width = 224
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mail"
end type

event clicked;integer i, li_pos
string ls_ret, ls_filename, ls_path, ls_cliente
string ls_trova,  ls_lingua
long ll_id_sog
/* devi creare un pdf cercando la stampante adatta e poi creare una mail con allegato
il pdf*/

//aggiungere un campo dir_export sulla tabella utenti
select dir_export
into :ls_path
from dba.utenti
where id_utenti=:u_freddie.s_utenti.i_idutente
;
//ll_id_utenti=u_freddie.s_utenti.i_idutente

if isnull(ls_path) or ls_path="" then
	select dir_export
	into :ls_path
	from par_sistema
	;
end if
if ls_path>"" then 
	if right(ls_path, 1)<>'\' then ls_path+='\'
else
	ls_path="c:\"
end if
//il nome del file sarà = alle prime 6 lettere del cliente + data e ora

ls_cliente=dw_1.describe("t_rag_soc.text")
if isnull(ls_cliente) or ls_cliente="" or  left(ls_cliente, 6)= "Stampa" then
	ls_cliente="CATALOGO"
else
	
	ls_cliente=mid(ls_cliente, 15, 8)
	for i=1 to 12
		if i=1 then ls_trova="\"
		if i=2 then ls_trova="*"
		if i=3 then ls_trova="?"
		if i=4 then ls_trova="/"
		if i=5 then ls_trova=":"
		if i=6 then ls_trova="<"
		if i=7 then ls_trova="|"
		if i=8 then ls_trova=">"
		if i=9 then ls_trova="'"
		if i=10 then ls_trova='"'
		if i=11 then ls_trova="<"
		if i=12 then ls_trova="="
		
		li_pos=pos(ls_cliente, ls_trova)
		if li_pos>0 then
			open(w_input_nomefile)
			ls_cliente=left(message.stringparm, 8)
			exit
		end if
	next	
end if
ls_cliente+="_"+string(today(), "yy-mm-dd hh-mm;'none'")


ls_filename=ls_path+ls_cliente


ls_ret=dw_1.Modify("DataWindow.Print.filename = '"+ls_filename+"'")

ls_ret=dw_1.Modify("DataWindow.Print.printername = 'Acrobat PDFWriter'")
//qui inserisco il cambiamento di lingua (se il cliente non è italiano)
ll_id_sog=dw_1.getitemnumber(1, "id_sog_commerciale")
select l.codice
into :ls_lingua
from dba.sog_commerciale s, dba.lingua l, dba.anagrafica a
where s.id_sog_commerciale=:ll_id_sog
and a.id_lingua=l.id_lingua
and s.id_anagrafica=a.id_anagrafica
;
if ls_lingua='IN' then
	dw_2.trigger event itemchanged(1, dw_2.object.lingua, 'E')
elseif ls_lingua='FR' then
	dw_2.trigger event itemchanged(1, dw_2.object.lingua, 'F')
end if
dw_1.print()
openwithparm(w_invia_mail, ls_filename+".pdf")


//openwithparm(w_invia_mail, ls_attach)



//for i= 1 to dw_1.rowcount()
//	ls_attach[i,1]=dw_1.getitemstring(i,"nome_immagine")
//	ls_attach[i,2]=dw_1.getitemstring(i,"cod_articolo")
//	
//	
//next
end event

type ole_imm from olecustomcontrol within w_foto_da_doc_2
event paintevent ( )
event selectevent ( long lplleft,  long lpltop,  long lplright,  long lplbottom )
event statusevent ( long lppercent )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event keyup ( integer keycode,  integer shift )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event scroll ( long scrolltype )
event errorevent ( integer nerrcount )
event thumbnail ( string filename,  long page )
event tag ( integer tagid,  integer tagtype,  long tagsize,  integer wordval,  long longval,  string strval )
event thumbtitle ( string title,  integer page )
boolean visible = false
integer x = 50
integer y = 1232
integer width = 631
integer height = 744
integer taborder = 130
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_foto_da_doc_2.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type sle_margine_sx from singlelineedit within w_foto_da_doc_2
string tag = "Inserisci il valore del margine SX in decimi di mm. (es: per 1 cm dgita 1000)"
integer x = 2130
integer y = 128
integer width = 178
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;messagebox("HELP", tag)
end event

type st_3 from statictext within w_foto_da_doc_2
integer x = 1842
integer y = 144
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Margine SX:"
boolean focusrectangle = false
end type

type cb_prod from commandbutton within w_foto_da_doc_2
integer x = 2386
integer y = 136
integer width = 603
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Note Produzione e qualità"
end type

event clicked;long ll_id_riga
integer i
string ls_qual, ls_prod

for i = 1 to dw_1.rowcount()
	ll_id_riga=dw_1.getitemnumber(i, "riga_documento")
	select nota_qualita, nota_produzione
	into :ls_qual, :ls_prod
	from dba.nota_riga_documento
	where note_id_riga_doc= :ll_id_riga
	;
	if isnull(ls_prod) then ls_prod=""
	if isnull(ls_qual) then ls_qual=""
	dw_1.SETITEM(I, "NOME_IMMAGINE", LS_PROD+" - "+LS_QUAL)
next
end event

type dw_2 from u_dw_base within w_foto_da_doc_2
integer x = 18
integer y = 132
integer width = 1266
integer height = 72
boolean bringtotop = true
string dataobject = "d_lingua"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string ls_traduzione, ls_nome_colonna, ls_colname, ls_desok
string ls_old_data, ls_des, ls_da_lingua, ls_a_lingua, ls_des1, ls_des2
integer li_num_campi, li_righe, i, li_pos, a
string ls_tipo_doc, ls_rif_doc, ls_data_scadenza, ls_rag


ls_old_data=getitemstring(row, string(dwo.name))
if ls_old_data="E" then ls_da_lingua='inglese'
if ls_old_data="I" then ls_da_lingua='italiano'
if ls_old_data="F" then ls_da_lingua='francese'
if data='I' then 
	ls_a_lingua='italiano'
	dw_1.object.cod_articolo_t.text="Cod. Articolo"
	dw_1.object.des_articolo_t.text="Descrizione"
	dw_1.object.peso_au_t.text="Gr. Prez."
	dw_1.object.qta_t.text="Q.ta"
	dw_1.object.prezzo_t.text="Prezzo"
	dw_1.object.imp_tot_t.text="Imp. Totale"
	dw_1.object.nota_t.text="Nota:"
	
	if dw_1.dataobject="d_conferma_ordine_foto" then
		dw_1.object.t_notatesta.text="Nota:"
		dw_1.object.t_pagamento.text="Pagamento:"
		dw_1.object.t_bollo.text="Bollo:"
		dw_1.object.t_valuta.text="Valuta:"
		dw_1.object.t_cambio.text="Cambio:"
		
		ls_tipo_doc=wf_traduci_tipo_doc("italiano")
		ls_rif_doc=dw_1.getitemstring(1, "rif_doc")
		li_pos=pos(ls_rif_doc, ":")
		dw_1.setitem(1, "rif_doc",ls_tipo_doc+": "+trim(right(ls_rif_doc, len(ls_rif_doc) - li_pos)))
		li_pos=0
		
		ls_data_scadenza=DW_1.OBJECT.t_data_scadenza.TEXT
		li_pos=pos(ls_data_scadenza, ":")
		dw_1.object.t_data_scadenza.text="Data scadenza: "+&
		trim(right(ls_data_scadenza, len(ls_data_scadenza) - li_pos))
		li_pos=0
	end if
	
	
	
	dw_1.object.t_imp_sc.text="Imp. Sc.:"
	dw_1.object.t_tot_legato.text="Totale Legato:"
	dw_1.object.t_tot_pezzi.text="Totale Pezzi:"
	dw_1.object.t_imp_somma.text="Importo Totale"
	dw_1.object.t_imp_sc_somma.text="Tot. Imp. Scontato:"
	dw_1.object.t_val_sconto.text="Valore Sconto:"
	dw_1.object.t_sc_riga.text="SC.%:"
	
	ls_rag=dw_1.object.t_rag_soc.text
	li_pos=pos(ls_rag, ":")
	
	dw_1.object.t_rag_soc.text="Intestatario: "+right(ls_rag, len(ls_rag) - li_pos)
end if
	
	
	
	
	
if data='E' then 
	ls_a_lingua='inglese'
	dw_1.object.cod_articolo_t.text="Item Ref"
	dw_1.object.des_articolo_t.text="Description"
	dw_1.object.peso_au_t.text="G. prec."
	dw_1.object.qta_t.text="Q.ty"
	dw_1.object.prezzo_t.text="Price/pc"
	dw_1.object.imp_tot_t.text="Total Amount"
	dw_1.object.nota_t.text="Notes"
	if dw_1.dataobject="d_conferma_ordine_foto" then
		dw_1.object.t_notatesta.text="Note:"
		dw_1.object.t_pagamento.text="Payment:"
		dw_1.object.t_bollo.text="Stamp:"
		dw_1.object.t_valuta.text="Value:"
		dw_1.object.t_cambio.text="Change:"
		
		ls_tipo_doc=wf_traduci_tipo_doc("inglese")
		ls_rif_doc=dw_1.getitemstring(1, "rif_doc")
		li_pos=pos(ls_rif_doc, ":")
		dw_1.setitem(1, "rif_doc",ls_tipo_doc+": "+trim(right(ls_rif_doc, len(ls_rif_doc) - li_pos)))
		li_pos=0
		
		ls_data_scadenza=DW_1.OBJECT.t_data_scadenza.TEXT
		li_pos=pos(ls_data_scadenza, ":")
		dw_1.object.t_data_scadenza.text="Delivery date: "&
		+trim(right(ls_data_scadenza, len(ls_data_scadenza) - li_pos))
		li_pos=0
	end if
	
	dw_1.object.t_imp_sc.text="Am. Disc.:"
	dw_1.object.t_tot_legato.text="Tot. Weight:"
	dw_1.object.t_tot_pezzi.text="Total Q.ty:"
	dw_1.object.t_imp_somma.text="Total Amount:"
	dw_1.object.t_imp_sc_somma.text="Tot. Amount Discount:"
	dw_1.object.t_val_sconto.text="Tot. Discount:"
	dw_1.object.t_sc_riga.text="Disc.%:"
	
	ls_rag=dw_1.object.t_rag_soc.text
	li_pos=pos(ls_rag, ":")
	
	dw_1.object.t_rag_soc.text="Delivery adress: "+right(ls_rag, len(ls_rag) - li_pos)
end if
	
	
if data='F' then 
	ls_a_lingua='francese'
	dw_1.object.cod_articolo_t.text="Réf Article"
	dw_1.object.des_articolo_t.text="Description"
	dw_1.object.peso_au_t.text="G. préc."
	dw_1.object.qta_t.text="Q.té"
	dw_1.object.prezzo_t.text="Prix/pc"
	dw_1.object.imp_tot_t.text="Montant Total"
	dw_1.object.nota_t.text="Notes"
	
	if dw_1.dataobject="d_conferma_ordine_foto" then
		dw_1.object.t_notatesta.text="Note:"
		dw_1.object.t_pagamento.text="Paiement:"
		dw_1.object.t_bollo.text="Poinçon:"
		dw_1.object.t_valuta.text="Monnaie:"
		dw_1.object.t_cambio.text="Change:"
		
		ls_tipo_doc=wf_traduci_tipo_doc("francese")
		
		ls_rif_doc=dw_1.getitemstring(1, "rif_doc")
		li_pos=pos(ls_rif_doc, ":")
		dw_1.setitem(1, "rif_doc",ls_tipo_doc+": "+trim(right(ls_rif_doc, len(ls_rif_doc) - li_pos)))
		li_pos=0
		
		ls_data_scadenza=DW_1.OBJECT.t_data_scadenza.TEXT
		li_pos=pos(ls_data_scadenza, ":")
		dw_1.object.t_data_scadenza.text="Délai de livraison: "&
		+trim(right(ls_data_scadenza, len(ls_data_scadenza) - li_pos))
		li_pos=0
	end if
	dw_1.object.t_imp_sc.text="Mon. Esc.:"
	dw_1.object.t_tot_legato.text="Tot. Poids:"
	dw_1.object.t_tot_pezzi.text="Tot. Q.té:"
	dw_1.object.t_imp_somma.text="Montant Total:"
	dw_1.object.t_imp_sc_somma.text="Montant Total Esc.:"
	dw_1.object.t_val_sconto.text="Valeur Escomptè:"
	dw_1.object.t_sc_riga.text="Esc.%:"
	
	ls_rag=dw_1.object.t_rag_soc.text
	li_pos=pos(ls_rag, ":")
	dw_1.object.t_rag_soc.text="Destinataire: "+right(ls_rag, len(ls_rag) - li_pos)
end if

li_righe=dw_1.rowcount()
for i = 1 to li_righe
	ls_des=dw_1.getitemstring(i, "des_articolo")
	ls_desok=f_traduci_frase(ls_da_lingua, ls_a_lingua, ls_des)
	if ls_desok > " " then ls_des=ls_desok
	dw_1.setitem(i, "des_articolo", ls_des)
next



end event

type cb_2 from commandbutton within w_foto_da_doc_2
integer x = 1157
integer y = 136
integer width = 626
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi Traduzioni"
end type

event clicked;open(w_traduzioni_cx)
end event

type cbx_vedi_totali from checkbox within w_foto_da_doc_2
boolean visible = false
integer x = 3177
integer y = 140
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Totali"
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.modify("datawindow.summary.height = 1000")
else
	dw_1.modify("datawindow.summary.height = 0")
end if
end event

