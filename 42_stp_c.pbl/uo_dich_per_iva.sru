forward
global type uo_dich_per_iva from nonvisualobject
end type
end forward

global type uo_dich_per_iva from nonvisualobject
end type
global uo_dich_per_iva uo_dich_per_iva

forward prototypes
public function integer uf_crea_file (datawindow adw_ivaper)
end prototypes

public function integer uf_crea_file (datawindow adw_ivaper);long ll_row, ll_id_esercizio
integer li_rif, li_app, li_ret, li_risp, i
string ls_mese, ls_codfis, ls_anno, ls_nome, ls_path, ls_rag1, ls_pariva, ls_anno2, ls_mese2
string ls_riga, lb_filler, ls_rigz, ls_rigb
boolean lb_esiste
string ls_riga1, ls_rigb1, ls_rigz1


li_risp = messagebox("ATTENZIONE!","Confermi l'esportazione della dichiarazione?",question!,yesno!)
if li_risp = 2 then return 1

select dir_export
into :ls_path
from par_sistema;

if isnull(ls_path) then 
	ls_path = ''
else
	ls_path = trim(ls_path)
end if

ll_row = adw_ivaper.getrow()
ll_id_esercizio = adw_ivaper.getitemnumber(ll_row,"id_esercizio")
li_rif = integer(adw_ivaper.getitemstring(ll_row,"rif_dichiarazione"))

select cod_fiscale, rag_soc_1, par_iva
into :ls_codfis, :ls_rag1, :ls_pariva
from azienda
where id_azienda = 1;
if sqlca.sqlcode <> 0 then
	messagebox("attenzione!",sqlca.sqlerrtext)
	return 1
end if

select codice
into :ls_anno
from esercizio
where id_esercizio = :ll_id_esercizio;
if sqlca.sqlcode <> 0 then
	messagebox("attenzione!",sqlca.sqlerrtext)
	return 1
end if

if li_rif = 1  then 
	ls_mese = "Gen"
	ls_mese2 = '01'
end if
if li_rif = 2  then 
	ls_mese = "Feb"
	ls_mese2 = '02'	
end if
if li_rif = 3  then 
	ls_mese = "Mar"
	ls_mese2 = '03'
end if
if li_rif = 4  then 
	ls_mese = "Apr"
	ls_mese2 = '04'	
end if
if li_rif = 5  then 
	ls_mese = "Mag"
	ls_mese2 = '05'	
end if
if li_rif = 6  then 
	ls_mese = "Giu"
	ls_mese2 = '06'	
end if
if li_rif = 7  then 
	ls_mese = "Lug"
	ls_mese2 = '07'	
end if
if li_rif = 8  then 
	ls_mese = "Ago"
	ls_mese2 = '08'	
end if
if li_rif = 9  then 
	ls_mese = "Set"
	ls_mese2 = '09'	
end if
if li_rif = 10 then 
	ls_mese = "Ott"
	ls_mese2 = '10'	
end if
if li_rif = 11 then 
	ls_mese = "Nov"
	ls_mese2 = '11'	
end if
if li_rif = 12 then 
	ls_mese = "Dic"
	ls_mese2 = '12'	
end if

ls_codfis = trim(ls_codfis)
ls_anno2 = right(trim(ls_anno),2)

ls_nome = ls_path + "\" + ls_codfis + "_" + ls_mese + ls_anno2 + ".ivp"
lb_esiste=fileexists(ls_nome)
if lb_esiste=true then
	li_app=fileopen((ls_nome),linemode!,read!,Shared!,replace!)	
	li_ret = fileread(li_app,ls_riga)
	
	li_ret = fileread(li_app,ls_rigb)
	
	li_ret = fileread(li_app,ls_rigz)
	
	fileclose(li_app)
end if

li_app=fileopen((ls_nome),LineMode!,Write!,Shared!,Replace!)

ls_codfis = ls_codfis + "                "
ls_codfis = left(ls_codfis, 16)

ls_rag1 = trim(ls_rag1)
ls_rag1 = ls_rag1 + "                                                             "
ls_rag1 = left(ls_rag1, 60)

if lb_esiste=false then
	
	lb_filler = ""
	FOR i=1 TO 1270
		lb_filler = lb_filler + " "
	NEXT

	ls_riga = "A" + "              " + "IVP01" + "01" + ls_codfis + "                        " + "                    " + " " + "00000000" 
	ls_riga = ls_riga + "                                        " + "  " + "                                        " + "  " + "                                   "
	ls_riga = ls_riga + "00000" + ls_rag1 + "                                        " + "  " + "                                   " + "00000" + "                                        "
	ls_riga = ls_riga + "  " + "                                   " + "00000" + "                                        " + "  " + "                                   "
	ls_riga = ls_riga + "00000" + "000" + "000" + "                                                                                                    "
	ls_riga = ls_riga + lb_filler + "A"

	
	
	lb_filler = ""
	FOR i=1 TO 1873
		lb_filler = lb_filler + " "
	NEXT
	
	ls_rigz = "Z" + "              " + "000000001"
	ls_rigz = +ls_rigz + lb_filler + "A"
end if

string ls_tipo, ls_trim, ls_eurolire, ls_e, ls_l, ls_vip, ls_v, ls_dich_cor, ls_dc, ls_dich_int, ls_di
string ls_dich_g, ls_dg, ls_dich_sg, ls_dsg
dec ld_vp1, ld_vp1b, ld_vp2, ld_vp2b, ld_vp3, ld_vp3b, ld_vp10, ld_vp11, ld_vp12, ld_vp12b
string ls_vp1, ls_vp1b, ls_vp2, ls_vp2b, ls_vp3, ls_vp3b, ls_vp10, ls_vp11, ls_vp12, ls_vp12b
dec ld_vp13, ld_vp13b, ld_vp14, ld_vp14b, ld_vp15, ld_vp15b, ld_vp16, ld_vp17, ld_vp17b, ld_vp18, ld_vp19
string ls_vp13, ls_vp13b, ls_vp14, ls_vp14b, ls_vp15, ls_vp15b, ls_vp16, ls_vp17, ls_vp17b, ls_vp18, ls_vp19
dec ld_vp20, ld_vp21, ld_vp22, ld_imp_rim
string ls_vp20, ls_vp21, ls_vp22, ls_ver, ls_ver2, ls_data_ver, ls_an, ls_me, ls_gi, ls_cod_az, ls_cab, ls_imp_rim
date ld_data_ver
dec ld_cred_comp
string ls_vp18a, ls_vp18b, ls_vp18c, ls_vp19a, ls_vp19b, ls_vp19c, ls_rel, ls_cred_comp, ls_cod_carica, ls_cod_fisc_dich

ls_pariva = left(ls_pariva, 11)
ls_tipo = adw_ivaper.getitemstring(ll_row,"tipo_dichiarazione")
ls_eurolire = adw_ivaper.getitemstring(ll_row,"euro_lire")
ls_vip = adw_ivaper.getitemstring(ll_row,"var_imp_prec")
ls_dich_cor = adw_ivaper.getitemstring(ll_row,"dich_cor_ter")
ls_dich_int = adw_ivaper.getitemstring(ll_row,"dich_int")
ls_dich_g = adw_ivaper.getitemstring(ll_row,"dich_5")
ls_dich_sg = adw_ivaper.getitemstring(ll_row,"dich_6")
ld_vp1 = adw_ivaper.getitemdecimal(ll_row,"vp1")
ld_vp1b = adw_ivaper.getitemdecimal(ll_row,"vp1b")
ld_vp2 = adw_ivaper.getitemdecimal(ll_row,"vp2")
ld_vp2b = adw_ivaper.getitemdecimal(ll_row,"vp2b")
ld_vp3 = adw_ivaper.getitemdecimal(ll_row,"vp3")
ld_vp3b = adw_ivaper.getitemdecimal(ll_row,"vp3b")
ld_vp10 = adw_ivaper.getitemdecimal(ll_row,"vp5")
ld_vp11 = adw_ivaper.getitemdecimal(ll_row,"vp6")
ld_vp12 = adw_ivaper.getitemdecimal(ll_row,"vp7")
ld_vp12b = adw_ivaper.getitemdecimal(ll_row,"vp7b")
ld_vp13 = adw_ivaper.getitemdecimal(ll_row,"vp8")
ld_vp13b = adw_ivaper.getitemdecimal(ll_row,"vp8b")
ld_vp14 = adw_ivaper.getitemdecimal(ll_row,"vp9")
ld_vp14b = adw_ivaper.getitemdecimal(ll_row,"vp9b")
ld_vp15 = adw_ivaper.getitemdecimal(ll_row,"vp10")
ld_vp15b = adw_ivaper.getitemdecimal(ll_row,"vp10b")
ld_vp16 = adw_ivaper.getitemdecimal(ll_row,"vp11")
ld_vp17 = adw_ivaper.getitemdecimal(ll_row,"vp12")
ld_vp17b = adw_ivaper.getitemdecimal(ll_row,"vp12b")
ld_vp18 = adw_ivaper.getitemdecimal(ll_row,"vp13")
ld_vp19 = adw_ivaper.getitemdecimal(ll_row,"vp14")
ld_vp20 = adw_ivaper.getitemdecimal(ll_row,"vp15")
ld_vp21 = adw_ivaper.getitemdecimal(ll_row,"vp16")
ld_vp22 = adw_ivaper.getitemdecimal(ll_row,"vp17")
ls_ver = adw_ivaper.getitemstring(ll_row,"ver_euro_lire")
ld_data_ver = adw_ivaper.getitemdate(ll_row,"data_ver")
ls_cod_az = adw_ivaper.getitemstring(ll_row,"cod_az")
ls_vp18a = adw_ivaper.getitemstring(ll_row,"vp18a")
ls_vp18b = adw_ivaper.getitemstring(ll_row,"vp18b")
ls_vp18c = adw_ivaper.getitemstring(ll_row,"vp18c")
ls_vp19a = adw_ivaper.getitemstring(ll_row,"vp19a")
ls_vp19b = adw_ivaper.getitemstring(ll_row,"vp19b")
ls_vp19c = adw_ivaper.getitemstring(ll_row,"vp19c")
ld_imp_rim = adw_ivaper.getitemdecimal(ll_row,"imp_rimborso")
ls_rel = adw_ivaper.getitemstring(ll_row,"rumb_euro_lire")
ld_cred_comp = adw_ivaper.getitemdecimal(ll_row,"cred_comp")
ls_cod_carica = adw_ivaper.getitemstring(ll_row,"cod_carica")
ls_cod_fisc_dich = adw_ivaper.getitemstring(ll_row,"cod_fisc_dich")

ls_cod_fisc_dich = ls_cod_fisc_dich + "                "
ls_cod_fisc_dich = left(ls_cod_fisc_dich,16)
ls_cod_carica = "00" + ls_cod_carica
ls_cod_carica = right(ls_cod_carica,2)

if ld_cred_comp <> 0 then 
	if ld_cred_comp < 1000 then 
		ls_cred_comp = "0"
	else 
		ls_cred_comp = string(round(ld_cred_comp/1000,0))
	end if
else
	ls_cred_comp = "0"
end if
ls_cred_comp = "0000000000000" + ls_cred_comp
ls_cred_comp = right(ls_cred_comp,13)

if ls_rel = 'S' then
	ls_rel = "1"
else
	ls_rel = "0"
end if

if ld_imp_rim <> 0 then 
	if ld_imp_rim < 1000 then 
		ls_imp_rim = "0"
	else 
		ls_imp_rim = string(round(ld_imp_rim/1000,0))
	end if
else
	ls_imp_rim = "0"
end if
ls_imp_rim = "0000000000000" + ls_imp_rim
ls_imp_rim = right(ls_imp_rim,13)

if ls_vp18a = 'S' then
	ls_vp18a = "1"
else
	ls_vp18a = "0"
end if

if ls_vp18b = 'S' then
	ls_vp18b = "1"
else
	ls_vp18b = "0"
end if

if ls_vp18c = 'S' then
	ls_vp18c = "1"
else
	ls_vp18c = "0"
end if

if ls_vp19a = 'S' then
	ls_vp19a = "1"
else
	ls_vp19a = "0"
end if

if ls_vp19b = 'S' then
	ls_vp19b = "1"
else
	ls_vp19b = "0"
end if

if ls_vp19c = 'S' then
	ls_vp19c = "1"
else
	ls_vp19c = "0"
end if

ls_cab = "00000" + ls_cab
ls_cab = right(ls_cab,5)

ls_cod_az = "00000" + ls_cod_az
ls_cod_az = right(ls_cod_az, 5)

ls_an = string(year(ld_data_ver))
ls_gi = left(string(ld_data_ver),2)
ls_me = mid(string(ld_data_ver),4,2)
ls_data_ver = ls_gi + ls_me + ls_an

if ls_ver = 'S' then
	ls_ver2 = "1"
else
	ls_ver2 = "0"
end if

if ld_vp22 <> 0 then 
	if ld_vp22 < 1000 then 
		ls_vp22 = "0"
	else 
		ls_vp22 = string(round(ld_vp22/1000,0))
	end if
else
	ls_vp22 = "0"
end if
ls_vp22 = "0000000000000" + ls_vp22
ls_vp22 = right(ls_vp22,13)

if ld_vp21 <> 0 then 
	if ld_vp21 < 1000 then 
		ls_vp21 = "0"
	else 
		ls_vp21 = string(round(ld_vp21/1000,0))
	end if
else
	ls_vp21 = "0"
end if
ls_vp21 = "0000000000000" + ls_vp21
ls_vp21 = right(ls_vp21,13)

if ld_vp19 <> 0 then 
	if ld_vp19 < 1000 then 
		ls_vp19 = "0"
	else 
		ls_vp19 = string(round(ld_vp19/1000,0))
	end if
else
	ls_vp19 = "0"
end if
ls_vp19 = "0000000000000" + ls_vp19
ls_vp19 = right(ls_vp19,13)

if ld_vp20 <> 0 then 
	if ld_vp20 < 1000 then 
		ls_vp20 = "0"
	else 
		ls_vp20 = string(round(ld_vp20/1000,0))
	end if
else
	ls_vp20 = "0"
end if
ls_vp20 = "0000000000000" + ls_vp20
ls_vp20 = right(ls_vp20,13)

if ld_vp18 <> 0 then 
	if ld_vp18 < 1000 then 
		ls_vp18 = "0"
	else 
		ls_vp18 = string(round(ld_vp18/1000,0))
	end if
else
	ls_vp18 = "0"
end if
ls_vp18 = "0000000000000" + ls_vp18
ls_vp18 = right(ls_vp18,13)

if ld_vp17 <> 0 then 
	if ld_vp17 < 1000 then 
		ls_vp17 = "0"
	else 
		ls_vp17 = string(round(ld_vp17/1000,0))
	end if
else
	ls_vp17 = "0"
end if
ls_vp17 = "0000000000000" + ls_vp17
ls_vp17 = right(ls_vp17,13)

if ld_vp17b <> 0 then 
	if ld_vp17b < 1000 then 
		ls_vp17b = "0"
	else 
		ls_vp17b = string(round(ld_vp17b/1000,0))
	end if
else
	ls_vp17b = "0"
end if
ls_vp17b = "0000000000000" + ls_vp17b
ls_vp17b = right(ls_vp17b,13)


if ld_vp16 <> 0 then 
	if ld_vp16 < 1000 then 
		ls_vp16 = "0"
	else 
		ls_vp16 = string(round(ld_vp16/1000,0))
	end if
else
	ls_vp16 = "0"
end if
ls_vp16 = "0000000000000" + ls_vp16
ls_vp16 = right(ls_vp16,13)

if ld_vp15 <> 0 then 
	if ld_vp15 < 1000 then 
		ls_vp15 = "0"
	else 
		ls_vp15 = string(round(ld_vp15/1000,0))
	end if
else
	ls_vp15 = "0"
end if
ls_vp15 = "0000000000000" + ls_vp15
ls_vp15 = right(ls_vp15,13)

if ld_vp15b <> 0 then 
	if ld_vp15b < 1000 then 
		ls_vp15b = "0"
	else 
		ls_vp15b = string(round(ld_vp15b/1000,0))
	end if
else
	ls_vp15b = "0"
end if
ls_vp15b = "0000000000000" + ls_vp15b
ls_vp15b = right(ls_vp15b,13)

if ld_vp14 <> 0 then 
	if ld_vp14 < 1000 then 
		ls_vp14 = "0"
	else 
		ls_vp14 = string(round(ld_vp14/1000,0))
	end if
else
	ls_vp14 = "0"
end if
ls_vp14 = "0000000000000" + ls_vp14
ls_vp14 = right(ls_vp14,13)

if ld_vp14b <> 0 then 
	if ld_vp14b < 1000 then 
		ls_vp14b = "0"
	else 
		ls_vp14b = string(round(ld_vp14b/1000,0))
	end if
else
	ls_vp14b = "0"
end if
ls_vp14b = "0000000000000" + ls_vp14b
ls_vp14b = right(ls_vp14b,13)

if ld_vp13 <> 0 then 
	if ld_vp13 < 1000 then 
		ls_vp13 = "0"
	else 
		ls_vp13 = string(round(ld_vp13/1000,0))
	end if
else
	ls_vp13 = "0"
end if
ls_vp13 = "0000000000000" + ls_vp13
ls_vp13 = right(ls_vp13,13)

if ld_vp13b <> 0 then 
	if ld_vp13b < 1000 then 
		ls_vp13b = "0"
	else 
		ls_vp13b = string(round(ld_vp13b/1000,0))
	end if
else
	ls_vp13b = "0"
end if
ls_vp13b = "0000000000000" + ls_vp13b
ls_vp13b = right(ls_vp13b,13)

if ld_vp12b <> 0 then 
	if ld_vp12b < 1000 then 
		ls_vp12b = "0"
	else 
		ls_vp12b = string(round(ld_vp12b/1000,0))
	end if
else
	ls_vp12b = "0"
end if
ls_vp12b = "0000000000000" + ls_vp12b
ls_vp12b = right(ls_vp12b,13)

if ld_vp1 <> 0 then 
	if ld_vp1 < 1000 then 
		ls_vp1 = "0"
	else 
		ls_vp1 = string(round(ld_vp1/1000,0))
	end if
else
	ls_vp1 = "0"
end if
ls_vp1 = "0000000000000" + ls_vp1
ls_vp1 = right(ls_vp1,13)

if ld_vp1b <> 0 then 
	if ld_vp1b < 1000 then 
		ls_vp1b = "0"
	else 
		ls_vp1b = string(round(ld_vp1b/1000,0))
	end if
else
	ls_vp1b = "0"
end if
ls_vp1b = "0000000000000" + ls_vp1b
ls_vp1b = right(ls_vp1b,13)

if ld_vp2 <> 0 then 
	if ld_vp2 < 1000 then 
		ls_vp2 = "0"
	else 
		ls_vp2 = string(round(ld_vp2/1000,0))
	end if
else
	ls_vp2 = "0"
end if
ls_vp2 = "0000000000000" + ls_vp2
ls_vp2 = right(ls_vp2,13)

if ld_vp2b <> 0 then 
	if ld_vp2b < 1000 then 
		ls_vp2b = "0"
	else 
		ls_vp2b = string(round(ld_vp2b/1000,0))
	end if
else
	ls_vp2b = "0"
end if
ls_vp2b = "0000000000000" + ls_vp2b
ls_vp2b = right(ls_vp2b,13)

if ld_vp3 <> 0 then 
	if ld_vp3 < 1000 then 
		ls_vp3 = "0"
	else 
		ls_vp3 = string(round(ld_vp3/1000,0))
	end if
else
	ls_vp3 = "0"
end if
ls_vp3 = "0000000000000" + ls_vp3
ls_vp3 = right(ls_vp3,13)

if ld_vp3b <> 0 then 
	if ld_vp3b < 1000 then 
		ls_vp3b = "0"
	else 
		ls_vp3b = string(round(ld_vp3b/1000,0))
	end if
else
	ls_vp3b = "0"
end if
ls_vp3b = "0000000000000" + ls_vp3b
ls_vp3b = right(ls_vp3b,13)

if ld_vp10 <> 0 then 
	if ld_vp10 < 1000 then 
		ls_vp10 = "0"
	else 
		ls_vp10 = string(round(ld_vp10/1000,0))
	end if
else
	ls_vp10 = "0"
end if
ls_vp10 = "0000000000000" + ls_vp10
ls_vp10 = right(ls_vp10,13)

if ld_vp11 <> 0 then 
	if ld_vp11 < 1000 then 
		ls_vp11 = "0"
	else 
		ls_vp11 = string(round(ld_vp11/1000,0))
	end if
else
	ls_vp11 = "0"
end if
ls_vp11 = "0000000000000" + ls_vp11
ls_vp11 = right(ls_vp11,13)

if ld_vp12 <> 0 then 
	if ld_vp12 < 1000 then 
		ls_vp12 = "0"
	else 
		ls_vp12 = string(round(ld_vp12/1000,0))
	end if
else
	ls_vp12 = "0"
end if
ls_vp12 = "0000000000000" + ls_vp12
ls_vp12 = right(ls_vp12,13)

if ls_dich_sg = 'S' then
	ls_dsg = "1"
else
	ls_dsg = "0"
end if

if ls_dich_g = 'S' then
	ls_dg = "1"
else
	ls_dg = "0"
end if

if ls_dich_int = 'S' then
	ls_di = "1"
else
	ls_di = "0"
end if

if ls_dich_cor = 'S' then
	ls_dc = "1"
else
	ls_dc = "0"
end if

if ls_vip = 'S' then
	ls_v = "1"
else
	ls_v = "0"
end if

if ls_eurolire = 'S' then
	ls_e = "1"
	ls_l = "0"	
else
	ls_e = "0"
	ls_l = "1"	
end if

if ls_tipo = "T" then 
	ls_trim = ls_mese2
	ls_mese2 = "00"	
else
	ls_trim = "00"	
end if

lb_filler = ""
FOR i=1 TO 1168
	lb_filler = lb_filler + " "
NEXT

ls_rigb = "B" + ls_codfis + "        " + "   " + "                         " + "                    " + "                "
ls_rigb = ls_rigb + "1" + "00000000000000000" + "000000" + ls_rag1 + "                        " + "                    " + ls_pariva
ls_rigb = ls_rigb + ls_anno + ls_mese2 + ls_trim + ls_e + ls_l + ls_v + ls_dc + ls_di + ls_dg + ls_dsg
ls_rigb = ls_rigb + ls_vp1 + ls_vp1b + ls_vp2 + ls_vp2b + ls_vp3 + ls_vp3b + ls_vp10 + ls_vp11 + ls_vp12
ls_rigb = ls_rigb + ls_vp12b + ls_vp13 + ls_vp13b + ls_vp14 + ls_vp14b + ls_vp15 + ls_vp15b + ls_vp16 + ls_vp17
ls_rigb = ls_rigb + ls_vp17b + ls_vp18 + ls_vp19 + ls_vp20 + ls_vp21 + ls_vp22 + ls_ver2 + ls_data_ver + ls_cod_az
ls_rigb = ls_rigb + ls_cab + ls_vp18a + ls_vp18b + ls_vp18c + ls_vp19a + ls_vp19b + ls_vp19c + ls_imp_rim + ls_rel
ls_rigb = ls_rigb + ls_cred_comp + "1" + ls_cod_carica + ls_cod_fisc_dich + "                " + "00000" + "00000000" + "0" + "0" + "0" 
ls_rigb = ls_rigb + "                " + "0" + "0" + lb_filler + "                    " + "        " + "        " + " " + "                 " 
ls_rigb = ls_rigb + "A"

filewrite(li_app,ls_riga)
filewrite(li_app,ls_rigb)
filewrite(li_app,ls_rigz)
li_ret = fileclose(li_app)		

messagebox("Esecuzione terminata","File ASCII creato")

return 0
end function

on uo_dich_per_iva.create
TriggerEvent( this, "constructor" )
end on

on uo_dich_per_iva.destroy
TriggerEvent( this, "destructor" )
end on

