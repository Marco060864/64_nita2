forward
global type w_corr_art_k_s from w_semplice_gd
end type
type cb_crea from commandbutton within w_corr_art_k_s
end type
type dw_6 from udw_base within w_corr_art_k_s
end type
type cb_canc_cate from commandbutton within w_corr_art_k_s
end type
end forward

global type w_corr_art_k_s from w_semplice_gd
integer width = 3205
cb_crea cb_crea
dw_6 dw_6
cb_canc_cate cb_canc_cate
end type
global w_corr_art_k_s w_corr_art_k_s

forward prototypes
public function integer wf_crea_articolo (long al_id_articolo, string as_cod_art_k)
end prototypes

public function integer wf_crea_articolo (long al_id_articolo, string as_cod_art_k);string ls_codice,  ls_metallo, ls_cod_articolo, ls_des_1
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art, ll_riga[], ll_id_variazione
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc,ll_riga_inserita, ll_id_titolo
integer i, a, li_ret
date ldt_data
decimal ldc_titolo
setnull(ll_null)


select id_articolo
into :ll_id_art
from dba.articolo
where codice=:as_cod_art_k
;
if ll_id_art=0 or isnull(ll_id_art) then 
	select id_titolo, codice
	into :ll_id_titolo, :ls_cod_articolo
	from dba.articolo
	where id_articolo=:al_id_articolo
	;
					
	dw_6.reset()
	
	ll_riga_inserita=dw_6.insertrow(1)
	dw_6.setitem(ll_riga_inserita, "id_articolo", ll_null)
	dw_6.setitem(ll_riga_inserita, "codice", as_cod_art_k)
	dw_6.setitem(ll_riga_inserita, "descrizione", ls_cod_articolo)
	dw_6.setitem(ll_riga_inserita, "des_breve", as_cod_art_k)
	dw_6.setitem(ll_riga_inserita, "id_cat_codifica", 66) //è cat_codifica creata all'uopo "AUTO"
	dw_6.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)
	dw_6.setitem(ll_riga_inserita,"id_cat_com_articolo", 8) //è ARG
	dw_6.setitem(ll_riga_inserita,"id_titolo", ll_id_titolo) //AG925 =4
	dw_6.setitem(ll_riga_inserita,"coef_calo",1000) //deve essere sempre 1000 ????
	dw_6.setitem(ll_riga_inserita,"immagine", as_cod_art_k+".jpg")
	dw_6.setitem(ll_riga_inserita,"nota", "Art. da ")
	dw_6.setitem(ll_riga_inserita,"id_unita_conf_base", 2) // con questa crea da se unita_conf a PZ
	dw_6.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
	dw_6.trigger event ue_update()
	ll_id_art=dw_6.getitemnumber(1, "id_articolo")
	ls_des_1= 'AUTO_da_COR'
end if
	
	select id_unita_confezione
	into :ll_id_uc
	from dba.unita_confezione
	where id_articolo=:ll_id_art and unita_base='S';
	
	if ll_id_uc> 0 then //inserisco l'articolo sulla tb prezzo nel listino/variazione corretta
		ldt_data=date(today())
		select id_variazione 
		into :ll_id_variazione from dba.variazione
		where id_listino=18 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
		
		if  ls_des_1= "" then  
			ls_des_1="AUTO_UP_COR"
			update dba.prezzo
			set des_1=:ls_des_1 //, des_2=ls_cod_articolo
			where  id_variazione=:ll_id_variazione and  id_unita_confezione=:ll_id_uc
			;
		else
			insert into dba.prezzo (id_variazione, id_unita_confezione, des_1, des_2)
			values (:ll_id_variazione, :ll_id_uc, :ls_des_1, :ls_cod_articolo)
			;
		end if
		if sqlca.sqlNrows>0 then
			commit;
			return 1  //l'articolo è stato creato e quindi ora esiste ed è inutile che resti sulla tabella corrispondenze
		else
			rollback;
			messagebox("Attenzione!", "Articolo: "+as_cod_art_k+" NON inserito in listino Base di vendita!")
		end if
		
	else
		messagebox("Attenzione!", "Unita Confezione art.: "+as_cod_art_k+" NON inserita!")
	end if

return 0





end function

on w_corr_art_k_s.create
int iCurrent
call super::create
this.cb_crea=create cb_crea
this.dw_6=create dw_6
this.cb_canc_cate=create cb_canc_cate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_crea
this.Control[iCurrent+2]=this.dw_6
this.Control[iCurrent+3]=this.cb_canc_cate
end on

on w_corr_art_k_s.destroy
call super::destroy
destroy(this.cb_crea)
destroy(this.dw_6)
destroy(this.cb_canc_cate)
end on

event open;call super::open;dw_6.settransobject(sqlca)
end event

event resize;call super::resize;cb_crea.x=cb_stampa.x +cb_stampa.width + 100
cb_crea.y=cb_stampa.y

cb_canc_cate.x=cb_crea.x + cb_crea.width + 100
cb_canc_cate.y=cb_stampa.y
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_corr_art_k_s
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_corr_art_k_s
end type

type cb_primo from w_semplice_gd`cb_primo within w_corr_art_k_s
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_corr_art_k_s
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_corr_art_k_s
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_corr_art_k_s
end type

type dw_1 from w_semplice_gd`dw_1 within w_corr_art_k_s
integer x = 27
integer width = 2734
integer height = 912
string dataobject = "d_corrispondenza_cod_art_id"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_corr_art_k_s
end type

type cb_salva from w_semplice_gd`cb_salva within w_corr_art_k_s
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_corr_art_k_s
end type

event cb_cancella::clicked;long ll_riga_da_cancellare
integer i
for i= dw_1.rowcount() to 1 step -1
	if dw_1.getitemstring(i, "scegli")='S' then
		dw_1.trigger event ue_delete(i)		
	end if
next

end event

type cb_annulla from w_semplice_gd`cb_annulla within w_corr_art_k_s
end type

type cb_ok from w_semplice_gd`cb_ok within w_corr_art_k_s
end type

type cb_crea from commandbutton within w_corr_art_k_s
integer x = 960
integer y = 984
integer width = 366
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Art.Sel."
end type

event clicked;integer i, a[], b
string ls_test,  ls_cod_art_k
long ll_id_articolo

for i=1 to dw_1.rowcount()
	ls_test=dw_1.getitemstring(i, "scegli")	
	if ls_test='S' then
		ls_cod_art_k=dw_1.getitemstring(i, "cod_articolo")	
		ll_id_articolo=dw_1.getitemnumber(i, "id_articolo_corrispondente")	
		if wf_crea_articolo(ll_id_articolo, ls_cod_art_k)= 1 then
			b++
			a[b]=i
		end if
	end if
next
for i= b to 1 step -1
	dw_1.deleterow(a[i])
next
	

end event

type dw_6 from udw_base within w_corr_art_k_s
boolean visible = false
integer x = 1042
integer y = 1340
integer width = 3191
integer height = 280
integer taborder = 50
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type cb_canc_cate from commandbutton within w_corr_art_k_s
integer x = 2377
integer y = 992
integer width = 357
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Canc. CATE"
end type

event clicked;integer i
long ll_id_art
string ls_cod_art

for i = 1 to dw_1.rowcount()
	ll_id_art=dw_1.getitemnumber(i, "id_articolo_corrispondente")
	select codice
	into :ls_cod_art
	from dba.articolo
	where id_articolo=:ll_id_art
	and id_cat_codifica=57;
	if ls_cod_art> " " then
		dw_1.setitem(i, "scegli", "S")
	end if
	ls_cod_art=""
	
next
end event

