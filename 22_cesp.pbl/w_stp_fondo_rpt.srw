forward
global type w_stp_fondo_rpt from w_stampa_001
end type
end forward

global type w_stp_fondo_rpt from w_stampa_001
end type
global w_stp_fondo_rpt w_stp_fondo_rpt

type variables
s_cespiti ls_par
long il_id_dich_per
end variables

event open;long ld_es, ll_anno
date ld_data

select max(data_inizio) into :ld_data
from esercizio where stato_cespite='D';

select id_esercizio into :ld_es
from esercizio where data_inizio=:ld_data;

select year(data_inizio) into :ll_anno
from esercizio where id_esercizio=:ld_es;

dw_1.settransobject(sqlca)
dw_1.retrieve( ll_anno, ld_es) 
end event

on w_stp_fondo_rpt.create
call super::create
end on

on w_stp_fondo_rpt.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_stp_fondo_rpt
string DataObject="d_ult_calcolo_rpt"
end type

event cb_stampa::clicked;printsetup()
dw_1.print()


end event

