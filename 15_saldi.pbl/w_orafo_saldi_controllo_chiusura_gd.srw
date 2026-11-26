forward
global type w_orafo_saldi_controllo_chiusura_gd from Window
end type
type tab_1 from tab within w_orafo_saldi_controllo_chiusura_gd
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type cb_annullazzera from commandbutton within w_orafo_saldi_controllo_chiusura_gd
end type
type cb_azzera from commandbutton within w_orafo_saldi_controllo_chiusura_gd
end type
type cb_ok from commandbutton within w_orafo_saldi_controllo_chiusura_gd
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_orafo_saldi_controllo_chiusura_gd
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

type s_modifiche from structure
	decimal {2}	fino
	decimal {2}	calo
	decimal {2}	lire
	string		metallo
end type

global type w_orafo_saldi_controllo_chiusura_gd from Window
int X=106
int Y=93
int Width=3346
int Height=1251
boolean TitleBar=true
string Title="Chiusura ultimata"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
tab_1 tab_1
cb_annullazzera cb_annullazzera
cb_azzera cb_azzera
cb_ok cb_ok
end type
global w_orafo_saldi_controllo_chiusura_gd w_orafo_saldi_controllo_chiusura_gd

type variables
boolean ib_modificato, ib_azzerato
private s_modifiche is_mod[]
datetime id_data_chius
long il_id_sog_com



end variables

forward prototypes
public function integer wf_genera_doc ()
public function integer wf_imposta_arrotondamento ()
end prototypes

public function integer wf_genera_doc ();long ll_id_reg_car, ll_id_reg_scar, ll_id_prof_car, ll_id_prof_scar, ll_num_prog, ll_id_sog_com, ll_id_valuta, j
long ll_id_art, ll_id_doc, ll_id_u_conf, ll_riga, i, ll_id_caus_car, ll_id_caus_scar
decimal{2} ld_quantita
date ld_data_reg
time lt_ora_reg
string ls_cod_art, ls_des_art

ld_data_reg=date(id_data_chius)	
lt_ora_reg=relativetime(time(id_data_chius),-5)	

	select id_registro
	into :ll_id_reg_car
	from registro
	where registro.tipo_registro='GA';

	select id_registro
	into :ll_id_reg_scar
	from registro
	where registro.tipo_registro='GV';

	ll_id_prof_car=tab_1.tabpage_2.dw_2.GetItemNumber(1,"id_prof_car")
	if IsNull(ll_id_prof_car) then
		messagebox('Errore!','Impossibile chiudere la scheda arrotondando!'+char(13)+'Impostare il profilo di carico!')
		return -1
	end if
		
	ll_id_prof_scar=tab_1.tabpage_2.dw_2.GetItemNumber(1,"id_prof_scar")
	if IsNull(ll_id_prof_scar) then
		messagebox('Errore!','Impossibile chiudere la scheda arrotondando!'+char(13)+'Impostare il profilo di scarico!')
		return -1
	end if

	ll_id_caus_car=tab_1.tabpage_2.dw_2.GetItemNumber(1,"id_caus_car")
	if IsNull(ll_id_caus_car) then
		messagebox('Errore!','Impossibile chiudere la scheda arrotondando!'+char(13)+'Impostare la causale di carico!')
		return -1
	end if

	ll_id_caus_scar=tab_1.tabpage_2.dw_2.GetItemNumber(1,"id_caus_scar")
	if IsNull(ll_id_caus_scar) then
		messagebox('Errore!','Impossibile chiudere la scheda arrotondando!'+char(13)+'Impostare la causale di scarico!')
		return -1
	end if

	select id_valuta
	into :ll_id_valuta
	from valuta
	where valuta.descrizione='Lire';
	
	for j=1 to upperbound(is_mod)
		if is_mod[j].fino<0 then
			select max(num_progressivo)
			into :ll_num_prog
			from documento
			where (documento.id_prof_documento=:ll_id_prof_scar)and(documento.id_registro=:ll_id_reg_scar);
			if IsNull(ll_num_prog) then 
				ll_num_prog=1
			else
				ll_num_prog++
			end if
			insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
										documento.data_documento, documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino, 
										documento.ora_registrazione)
			values (:ll_id_prof_scar, :ll_id_reg_scar, :ll_num_prog, :ld_data_reg, :ld_data_reg, :il_id_sog_com, :ll_id_valuta, :ll_id_caus_scar, :lt_ora_reg);
			select Max(id_documento)
			into :ll_id_doc
			from documento;
			ll_riga=1
			for i=j to upperbound(is_mod)
				if is_mod[i].fino<0 then
					
					select articolo.id_articolo, articolo.descrizione
					into :ll_id_art, :ls_des_art
					from articolo, orafo_titolo, orafo_metallo
					where(substr(articolo.codice,1,4)='puro')
					and(orafo_titolo.id_titolo=articolo.id_titolo)
					and(orafo_metallo.id_metallo=orafo_titolo.id_metallo)
					and(orafo_metallo.codice=:is_mod[i].metallo);
					
					select id_unita_confezione
					into :ll_id_u_conf
					from unita_confezione
					where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');
					
					is_mod[i].fino=is_mod[i].fino*-1
					is_mod[i].lire=is_mod[i].lire*-1
					insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
													riga_documento.id_articolo, riga_documento.fino, riga_documento.id_caus_magazzino,
													riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.tot_riga_val_az)
					values (:ll_id_doc, :ll_riga, :ll_id_valuta, :ll_id_art, :is_mod[i].fino, :ll_id_caus_scar, :ls_des_art, :ll_id_u_conf, :is_mod[i].lire);
					is_mod[i].fino=is_mod[i].fino*-1
					is_mod[i].lire=is_mod[i].lire*-1
					ll_riga++
				end if
			next
			
			
			insert into orafo_saldi_arrotondamento( id_documento, id_prof_documento, id_caus_magazzino, tipo)
			values (:ll_id_doc, :ll_id_prof_scar, :ll_id_caus_scar, 'S');
			
			exit
		end if
	next
	
	for j=1 to upperbound(is_mod)
		if is_mod[j].fino>0 then
			select max(num_progressivo)
			into :ll_num_prog
			from documento
			where (documento.id_prof_documento=:ll_id_prof_car)and(documento.id_registro=:ll_id_reg_car);
			if IsNull(ll_num_prog) then 
				ll_num_prog=1
			else
				ll_num_prog++
			end if
			insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
										documento.data_documento, documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino, 
										documento.ora_registrazione)
			values (:ll_id_prof_car, :ll_id_reg_car, :ll_num_prog, :ld_data_reg, :ld_data_reg, :il_id_sog_com, :ll_id_valuta, :ll_id_caus_car, :lt_ora_reg);
			select Max(id_documento)
			into :ll_id_doc
			from documento;
			ll_riga=1
			for i=j to upperbound(is_mod)
				if is_mod[i].fino>0 then
					
					select articolo.id_articolo, articolo.descrizione
					into :ll_id_art, :ls_des_art
					from articolo, orafo_titolo, orafo_metallo
					where(substr(articolo.codice,1,4)='puro')
					and(orafo_titolo.id_titolo=articolo.id_titolo)
					and(orafo_metallo.id_metallo=orafo_titolo.id_metallo)
					and(orafo_metallo.codice=:is_mod[i].metallo);
					
					select id_unita_confezione
					into :ll_id_u_conf
					from unita_confezione
					where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');
					
					insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
													riga_documento.id_articolo, riga_documento.fino, riga_documento.id_caus_magazzino,
													riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.tot_riga_val_az)
					values (:ll_id_doc, :ll_riga, :ll_id_valuta, :ll_id_art, :is_mod[i].fino, :ll_id_caus_car, :ls_des_art, :ll_id_u_conf, :is_mod[i].lire);
					ll_riga++
				end if
			next

			
			insert into orafo_saldi_arrotondamento( id_documento, id_prof_documento, id_caus_magazzino, tipo)
			values (:ll_id_doc, :ll_id_prof_car, :ll_id_caus_car, 'C');
			
			exit
		end if
	next
	return 1
end function

public function integer wf_imposta_arrotondamento ();datawindowchild	dwc_prof_car, dwc_prof_scar, dwc_caus_car, dwc_caus_scar
long ll_id_prof_car, ll_id_prof_scar, ll_id_caus_car, ll_id_caus_scar

tab_1.tabpage_2.dw_2.insertrow(0)

tab_1.tabpage_2.dw_2.GetChild("id_prof_car",dwc_prof_car)
tab_1.tabpage_2.dw_2.GetChild("id_prof_scar",dwc_prof_scar)
tab_1.tabpage_2.dw_2.GetChild("id_caus_car",dwc_caus_car)
tab_1.tabpage_2.dw_2.GetChild("id_caus_scar",dwc_caus_scar)
dwc_prof_car.SetTransObject(sqlca)
dwc_prof_car.Retrieve()
dwc_prof_scar.SetTransObject(sqlca)
dwc_prof_scar.Retrieve()
dwc_caus_car.SetTransObject(sqlca)
dwc_caus_car.Retrieve()
dwc_caus_scar.SetTransObject(sqlca)
dwc_caus_scar.Retrieve()

	
select orafo_saldi_arrotondamento.id_prof_documento, orafo_saldi_arrotondamento.id_caus_magazzino
into :ll_id_prof_car, :ll_id_caus_car
from orafo_saldi_arrotondamento, orafo_saldi_chiusi
where (orafo_saldi_arrotondamento.id_chiusura=(select max(orafo_saldi_chiusi.id_chiusura)
														   from orafo_saldi_chiusi
														   where orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com))
and (orafo_saldi_arrotondamento.tipo='C');
if not(IsNull(ll_id_prof_car))and not(isnull(ll_id_caus_car)) then
	tab_1.tabpage_2.dw_2.SetItem(1,"id_prof_car",ll_id_prof_car)
	tab_1.tabpage_2.dw_2.SetItem(1,"id_caus_car",ll_id_caus_car)
end if
	
select orafo_saldi_arrotondamento.id_prof_documento, orafo_saldi_arrotondamento.id_caus_magazzino
into :ll_id_prof_scar, :ll_id_caus_scar
from orafo_saldi_arrotondamento, orafo_saldi_chiusi
where (orafo_saldi_arrotondamento.id_chiusura=(select max(orafo_saldi_chiusi.id_chiusura)
														   from orafo_saldi_chiusi
														   where orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com))
and (orafo_saldi_arrotondamento.tipo='S');
if not(IsNull(ll_id_prof_scar))and not(isnull(ll_id_caus_scar)) then
	tab_1.tabpage_2.dw_2.SetItem(1,"id_prof_scar",ll_id_prof_scar)
	tab_1.tabpage_2.dw_2.SetItem(1,"id_caus_scar",ll_id_caus_scar)
end if

return 1
end function

on w_orafo_saldi_controllo_chiusura_gd.create
this.tab_1=create tab_1
this.cb_annullazzera=create cb_annullazzera
this.cb_azzera=create cb_azzera
this.cb_ok=create cb_ok
this.Control[]={this.tab_1,&
this.cb_annullazzera,&
this.cb_azzera,&
this.cb_ok}
end on

on w_orafo_saldi_controllo_chiusura_gd.destroy
destroy(this.tab_1)
destroy(this.cb_annullazzera)
destroy(this.cb_azzera)
destroy(this.cb_ok)
end on

event open;datastore ds_temp
long ll_righe, i
decimal {2} ld_qta

ds_temp=create datastore
ds_temp=message.powerobjectparm

ll_righe=ds_temp.rowcount()
ds_temp.Rowscopy(1,ll_righe,primary!,tab_1.tabpage_1.dw_1,1,primary!)
for i=1 to ll_righe
	ld_qta=tab_1.tabpage_1.dw_1.GetItemDecimal(i,"gran_fino_calo_entrata")
	tab_1.tabpage_1.dw_1.setitem(i,"fino_calo_entr",ld_qta)
	ld_qta=tab_1.tabpage_1.dw_1.GetItemDecimal(i,"gran_fino_calo_uscita")
	tab_1.tabpage_1.dw_1.setitem(i,"fino_calo_usc",ld_qta)
next
if ll_righe>0 then
	il_id_sog_com=tab_1.tabpage_1.dw_1.getitemnumber(1,"id_sog_commerciale")
	id_data_chius=tab_1.tabpage_1.dw_1.getitemdatetime(1,"data_chiusura")
end if

ib_modificato=false

wf_imposta_arrotondamento()


end event

type tab_1 from tab within w_orafo_saldi_controllo_chiusura_gd
int X=26
int Y=22
int Width=3280
int Height=998
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
int X=15
int Y=90
int Width=3251
int Height=896
long BackColor=79741120
string Text="Chiusura"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
int X=11
int Y=19
int Width=3211
int Height=845
int TabOrder=31
string DataObject="d_orafo_saldi_cliente_tot_chiusi2_tb"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;ib_modificato=true

end event

type tabpage_2 from userobject within tab_1
int X=15
int Y=90
int Width=3251
int Height=896
long BackColor=79741120
string Text="Azzeramento"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
int X=18
int Y=19
int Width=3200
int Height=854
int TabOrder=11
string DataObject="d_orafo_saldi_cliente_imposta_azzera_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;long ll_id_caus_mag, id_prof

choose case dwo.name
	case "id_prof_car"
		id_prof=long(data)
		if not(isnull(id_prof)) then
			select id_caus_magazzino_prop
			into :ll_id_caus_mag
			from prof_documento
			where prof_documento.id_prof_documento=:id_prof;
			if not(isnull(ll_id_caus_mag)) then tab_1.tabpage_2.dw_2.SetItem(1,"id_caus_car", ll_id_caus_mag)
		end if
	case "id_prof_scar"
		id_prof=long(data)
		if not(isnull(id_prof)) then
			select id_caus_magazzino_prop
			into :ll_id_caus_mag
			from prof_documento
			where prof_documento.id_prof_documento=:id_prof;
			if not(isnull(ll_id_caus_mag)) then tab_1.tabpage_2.dw_2.SetItem(1,"id_caus_scar", ll_id_caus_mag)
		end if
end choose
end event

type cb_annullazzera from commandbutton within w_orafo_saldi_controllo_chiusura_gd
int X=2725
int Y=1053
int Width=516
int Height=86
int TabOrder=20
string Text="Annulla azzeramento"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_righe, i
decimal {2} ld_qta
s_modifiche ls_mod[]


if not(ib_azzerato) then return
ll_righe=tab_1.tabpage_1.dw_1.rowcount()
for i=1 to ll_righe
	ld_qta=tab_1.tabpage_1.dw_1.getitemdecimal(i,"gran_fino_entrata")
	ld_qta=ld_qta - is_mod[i].fino
	tab_1.tabpage_1.dw_1.setitem(i,"gran_fino_entrata",ld_qta)
	ld_qta=tab_1.tabpage_1.dw_1.getitemdecimal(i,"gran_lire_entrata")
	ld_qta=ld_qta - is_mod[i].lire
	tab_1.tabpage_1.dw_1.setitem(i,"gran_lire_entrata",ld_qta)
next
ib_azzerato=false
is_mod=ls_mod
end event

type cb_azzera from commandbutton within w_orafo_saldi_controllo_chiusura_gd
int X=2289
int Y=1053
int Width=355
int Height=86
int TabOrder=30
string Text="Azzera Saldi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_righe, i, ll_ret
decimal {2} ld_saldo, ld_qta

if ib_azzerato then return
ll_righe=tab_1.tabpage_1.dw_1.rowcount()
for i=1 to ll_righe
	is_mod[i].metallo=tab_1.tabpage_1.dw_1.getitemstring(i,"codice_metallo")
	select (gran_fino_entrata+gran_calo_entrata)-(gran_fino_uscita+gran_calo_uscita)
	into :ld_saldo
	from orafo_saldi_chiusi
	where (orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com)
	and(orafo_saldi_chiusi.data_chiusura=:id_data_chius)
	and(orafo_saldi_chiusi.codice_metallo=:is_mod[i].metallo);
	if ld_saldo<>0 then
		is_mod[i].fino=0 - ld_saldo
		ld_qta=tab_1.tabpage_1.dw_1.getitemdecimal(i,"gran_fino_entrata")
		ld_qta=ld_qta + is_mod[i].fino
		ll_ret=tab_1.tabpage_1.dw_1.setitem(i,"gran_fino_entrata",ld_qta)
	else
		is_mod[i].fino=0
	end if
	select gran_lire_entrata - gran_lire_uscita
	into :ld_saldo
	from orafo_saldi_chiusi
	where (orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com)
	and(orafo_saldi_chiusi.data_chiusura=:id_data_chius)
	and(orafo_saldi_chiusi.codice_metallo=:is_mod[i].metallo);
	if ld_saldo<>0 then
		is_mod[i].lire=0 - ld_saldo
		ld_qta=tab_1.tabpage_1.dw_1.getitemdecimal(i,"gran_lire_entrata")
		tab_1.tabpage_1.dw_1.setitem(i,"gran_lire_entrata",ld_qta + is_mod[i].lire)
	else
		is_mod[i].lire=0
	end if
next
ib_azzerato=true
tab_1.SelectTab(2)
end event

type cb_ok from commandbutton within w_orafo_saldi_controllo_chiusura_gd
int X=88
int Y=1053
int Width=289
int Height=83
int TabOrder=40
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long i, ll_righe
decimal{2} ld_qta, ld_lire
string ls_metallo


if (ib_modificato)or(ib_azzerato) then
	if not(ib_azzerato) then	
		ll_righe=tab_1.tabpage_1.dw_1.rowcount()
		for i=1 to ll_righe
			ls_metallo=tab_1.tabpage_1.dw_1.getitemstring(i,"codice_metallo")
			is_mod[i].metallo=ls_metallo
			select (gran_fino_entrata+gran_calo_entrata)-(gran_fino_uscita+gran_calo_uscita)
			into :ld_qta
			from orafo_saldi_chiusi
			where (orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com)
			and(orafo_saldi_chiusi.data_chiusura=:id_data_chius)
			and(orafo_saldi_chiusi.codice_metallo=:ls_metallo);
			is_mod[i].fino=tab_1.tabpage_1.dw_1.getitemnumber(i,"gran_fino_calo_saldo") - ld_qta
			select gran_lire_entrata - gran_lire_uscita
			into :ld_qta
			from orafo_saldi_chiusi
			where (orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com)
			and(orafo_saldi_chiusi.data_chiusura=:id_data_chius)
			and(orafo_saldi_chiusi.codice_metallo=:ls_metallo);
			is_mod[i].lire=tab_1.tabpage_1.dw_1.getitemnumber(i,"gran_lire_saldo") - ld_qta	
		next
	end if
	if wf_genera_doc()<0 then return
	ll_righe=tab_1.tabpage_1.dw_1.rowcount()
	for i=1 to ll_righe
		select gran_fino_entrata, gran_lire_entrata
		into :ld_qta, :ld_lire
		from orafo_saldi_chiusi
		where (orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com)
		and(orafo_saldi_chiusi.data_chiusura=:id_data_chius)
		and(orafo_saldi_chiusi.codice_metallo=:is_mod[i].metallo);
		ld_qta=ld_qta+is_mod[i].fino
		ld_lire=ld_lire+is_mod[i].lire
		update orafo_saldi_chiusi
		set gran_fino_entrata=:ld_qta,
			gran_lire_entrata=:ld_lire
		where (orafo_saldi_chiusi.id_sog_commerciale=:il_id_sog_com)
		and(orafo_saldi_chiusi.data_chiusura=:id_data_chius)
		and(orafo_saldi_chiusi.codice_metallo=:is_mod[i].metallo);
	next
end if

close(parent)
end event

