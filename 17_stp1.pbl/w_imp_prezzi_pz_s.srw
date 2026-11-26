forward
global type w_imp_prezzi_pz_s from w_semplice_gd
end type
type cb_1 from commandbutton within w_imp_prezzi_pz_s
end type
type cb_2 from commandbutton within w_imp_prezzi_pz_s
end type
type dw_2 from udw_001 within w_imp_prezzi_pz_s
end type
end forward

global type w_imp_prezzi_pz_s from w_semplice_gd
integer height = 2132
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
end type
global w_imp_prezzi_pz_s w_imp_prezzi_pz_s

forward prototypes
public function integer wf_crea_articolo (string as_cod_art)
end prototypes

public function integer wf_crea_articolo (string as_cod_art);long ll_riga_inserita, ll_null, ll_id_art_locale, ll_id_uc, ll_id_variazione
string ls_data, ls_num_doc
datetime ldt_data
dw_2.reset()

setnull(ll_null)

ll_riga_inserita=dw_2.insertrow(1)
dw_2.setitem(ll_riga_inserita, "id_articolo", ll_null)
if len(as_cod_art)>64 then messagebox("Attenzione!", "Articolo: "+as_cod_art+" Più lungo di 64!!!!")
dw_2.setitem(ll_riga_inserita, "codice", as_cod_art)  
dw_2.setitem(ll_riga_inserita, "descrizione", as_cod_art)
dw_2.setitem(ll_riga_inserita, "des_breve", left(as_cod_art, 40))
dw_2.setitem(ll_riga_inserita, "id_cat_codifica", 66) //è cat_codifica creata all'uopo "AUTO"
dw_2.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)

dw_2.setitem(ll_riga_inserita,"id_cat_com_articolo", 8) //è ARG
dw_2.setitem(ll_riga_inserita,"id_titolo", 4) 
dw_2.setitem(ll_riga_inserita,"coef_calo",1000) //deve essere sempre 1000 ????
dw_2.setitem(ll_riga_inserita,"immagine", as_cod_art+".jpg")
dw_2.setitem(ll_riga_inserita,"nota", "Art. da EXCEL")
dw_2.setitem(ll_riga_inserita,"id_unita_conf_base", 2) // con questa crea da se unita_conf a PZ
dw_2.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
dw_2.trigger event ue_update()  //salvo e inserisco l'articolo

ll_id_art_locale=dw_2.getitemnumber(1, "id_articolo") //lo recupero
//select id_unita_confezione
//into :ll_id_uc
//from dba.unita_confezione
//where id_articolo=:ll_id_art_locale and unita_base='S';

//if ll_id_uc> 0 then //inserisco l'articolo sulla tb prezzo nel listino/variazione corretto
//	ldt_data=dw_1.getitemdatetime(1, "data")
//	ls_data="AUTO_XLS "+string(ldt_data, "dd_mm_yy")
//	ll_id_variazione=0
//	select id_variazione 
//	into :ll_id_variazione from dba.variazione
//	where id_listino=17 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
//	insert into dba.prezzo (id_variazione, id_unita_confezione, des_1)
//	values (:ll_id_variazione, :ll_id_uc, :ls_data);
//	if sqlca.sqlNrows>0 then
//		commit;
//	else
//		rollback;
//		//messagebox("Attenzione!", "Articolo: "+ls_cod_articolo+" NON inserito in listino BASE VENDITA!")
//	end if
//	select id_variazione 
//	into :ll_id_variazione from dba.variazione
//	where id_listino=18 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
//	insert into dba.prezzo (id_variazione, id_unita_confezione, des_1, des_3, des_2)
//	values (:ll_id_variazione, :ll_id_uc, :ls_data,:ls_num_doc, '$' ) //20200728 richiesta: segnare articoli nuovi con "$" perché non hanno prezzo des_2 svolto con i "K"
//	;
//	if sqlca.sqlNrows>0 then
//		commit;
//	else
//		rollback;
//		messagebox("Attenzione!", "Articolo: "+as_cod_art+" NON inserito in listino KAR!")
//	end if
//else
//	messagebox("Attenzione!", "Unita Confezione art.: "+as_cod_art+" NON inserita!")
//end if

	
return ll_id_art_locale
end function

on w_imp_prezzi_pz_s.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_2
end on

on w_imp_prezzi_pz_s.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
end on

event open;call super::open;dw_2.settransobject(sqlca)
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_imp_prezzi_pz_s
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_imp_prezzi_pz_s
end type

type cb_primo from w_semplice_gd`cb_primo within w_imp_prezzi_pz_s
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_imp_prezzi_pz_s
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_imp_prezzi_pz_s
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_imp_prezzi_pz_s
end type

type dw_1 from w_semplice_gd`dw_1 within w_imp_prezzi_pz_s
string dataobject = "D_IMP_PREZZI_S"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_imp_prezzi_pz_s
end type

type cb_salva from w_semplice_gd`cb_salva within w_imp_prezzi_pz_s
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_imp_prezzi_pz_s
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_imp_prezzi_pz_s
end type

type cb_ok from w_semplice_gd`cb_ok within w_imp_prezzi_pz_s
end type

type cb_1 from commandbutton within w_imp_prezzi_pz_s
integer x = 2368
integer y = 176
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "2"
end type

event clicked;integer i, a
string ls_art
long ll_id_uc, ll_id_art
decimal ldc_prezzo_old, ldc_prezzo_new
datetime	ldt_ult_modifica
FOR I= 1 TO DW_1.ROWCOUNT()
	ls_art=dw_1.getitemstring(i, "art_codice")
	ll_id_art=0
	select id_articolo into :ll_id_art from dba.articolo where codice=:ls_art;
	if isnull(ll_id_art) or ll_id_art=0 then
		ll_id_art=wf_crea_articolo(ls_art)
	end if
	ll_id_uc=0
	select id_unita_confezione into :ll_id_uc from unita_confezione u, articolo a
	where a.id_articolo=:ll_id_art and u.id_articolo=a.id_articolo;
	select prezzo into :ldc_prezzo_old from prezzo where id_unita_confezione=:ll_id_uc
	and id_variazione=164;
	if isnull(ldc_prezzo_old) then ldc_prezzo_old=0
	ldc_prezzo_new=dw_1.getitemdecimal(i, "prezzo")
	if ldc_prezzo_new<>ldc_prezzo_old then
		ldt_ult_modifica=datetime(today())
		update dba.prezzo set prezzo=:ldc_prezzo_new, ultima_modifica=:ldt_ult_modifica
		where id_variazione=164 and id_unita_confezione=:ll_id_uc;
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			insert into dba.prezzo (id_variazione, id_unita_confezione, prezzo, ultima_modifica)
			values(164, :ll_id_uc, :ldc_prezzo_new,:ldt_ult_modifica );
			if sqlca.sqlNrows>0 then
				commit;
			else
				rollback;
				a++
			end if
		end if
	end if
	
	
NEXT

messagebox("A", "Non inseriti "+string(a)+" Prezzi")
end event

type cb_2 from commandbutton within w_imp_prezzi_pz_s
integer x = 2368
integer y = 36
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "1"
end type

event clicked;string ls_path, ls_file

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_1.importfile(text!,ls_file, 2, 100000)
end if	 
end event

type dw_2 from udw_001 within w_imp_prezzi_pz_s
boolean visible = false
integer x = 119
integer y = 1544
integer width = 2523
integer taborder = 60
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
end type

