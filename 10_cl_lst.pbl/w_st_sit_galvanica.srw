forward
global type w_st_sit_galvanica from w_stampa
end type
type dw_2 from udw_000 within w_st_sit_galvanica
end type
end forward

global type w_st_sit_galvanica from w_stampa
integer width = 3465
dw_2 dw_2
end type
global w_st_sit_galvanica w_st_sit_galvanica

on w_st_sit_galvanica.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_st_sit_galvanica.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;call super::open;string ls_filtro
s_array s_prof
//datawindowchild dwc_prof
integer rtncode

s_prof=message.powerobjectparm



dw_2.settransobject(sqlca)
dw_2.insertrow(1)
//rtncode = dw_2.GetChild('filtro', dwc_prof)
//IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
//// Establish the connection
//CONNECT USING SQLCA;
//// Set the transaction object for the child
//dwc_prof.SetTransObject(SQLCA) 
//// Populate with values for eastern states
//dwc_prof.Retrieve()// Set transaction object for main DW and retrieve

dw_1.settransobject(sqlca)



dw_1.retrieve(s_prof.ll_id_prof[1], s_prof.ll_id_prof[2])

ls_filtro=""
ls_filtro="t_filtro2.text='dal 01/01/2022'"
dw_1.modify(ls_filtro)
if s_prof.ll_id_prof[2]=189 then
	ls_filtro="t_filtro.text='Situazione Galvanica: TUTTI'"
	dw_2.setitem(1, "filtro", 0)
elseif s_prof.ll_id_prof[2]=225 then
	ls_filtro="t_filtro.text='Situazione Ceramica: TUTTI'"
	dw_2.setitem(1, "filtro", -1)
end if
dw_1.modify(ls_filtro)
end event

type pb_1 from w_stampa`pb_1 within w_st_sit_galvanica
integer x = 2907
end type

type cb_preview from w_stampa`cb_preview within w_st_sit_galvanica
integer x = 2295
end type

type dw_1 from w_stampa`dw_1 within w_st_sit_galvanica
string dataobject = "d_sit_galv_interna"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_sit_galvanica
integer x = 2702
end type

type pb_stampa from w_stampa`pb_stampa within w_st_sit_galvanica
integer x = 2491
end type

type sle_pg from w_stampa`sle_pg within w_st_sit_galvanica
integer x = 1184
integer width = 261
end type

type st_1 from w_stampa`st_1 within w_st_sit_galvanica
integer x = 1010
integer width = 206
string text = "St. Pgg."
end type

type st_2 from w_stampa`st_2 within w_st_sit_galvanica
integer x = 229
end type

type sle_copie from w_stampa`sle_copie within w_st_sit_galvanica
integer x = 389
end type

type sle_zoom from w_stampa`sle_zoom within w_st_sit_galvanica
integer x = 713
end type

type cb_7 from w_stampa`cb_7 within w_st_sit_galvanica
integer x = 576
end type

type cb_6 from w_stampa`cb_6 within w_st_sit_galvanica
integer x = 869
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_sit_galvanica
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_sit_galvanica
end type

type cb_esci from w_stampa`cb_esci within w_st_sit_galvanica
integer x = 3090
integer y = 44
end type

type dw_2 from udw_000 within w_st_sit_galvanica
integer x = 1463
integer y = 36
integer width = 850
integer height = 100
integer taborder = 18
boolean bringtotop = true
string dataobject = "d_filtro_galv"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;date ldt_data
string ls_data, ls_filtro


if dwo.name='filtro' then
	if data="0" or data='-1' then
		dw_1.setfilter("")
	else
		dw_1.setfilter("documento_id_prof_documento="+data)
		if data='170' OR data='224' then 	
			ls_data="SOLO INVIO" 
		elseif data='189' or data='225' then 
			ls_data="SOLO RIENTRI" 
		else 
			ls_data="TUTTI" 
		end if
		if data='170' OR data='189' or data='0'  then
			ls_filtro="Situazione galvanica:  "
		elseif data='224' or data='225' or data='-1' then 
			ls_filtro="Situazione ceramica:  "
		end if
		ls_filtro+=ls_data
		ls_filtro="t_filtro.text='"+ls_filtro+"'"
		dw_1.modify(ls_filtro)
	end if	
elseif dwo.name='data_inizio' then
	if isnull(data) then
		dw_1.setfilter("")
	else
		ldt_data=date(data)
		ls_data=string(ldt_data, "dd/mm/yyyy")
		dw_1.setfilter("data_documento>=date('"+ls_data+"')")
		 ls_filtro="dal "+ls_data 
		ls_filtro="t_filtro2.text='"+ls_filtro+"'"
		dw_1.modify(ls_filtro)
	end if
end if
dw_1.filter()

// "Situazione galvanica: "+t-r-a+" dal "+data 
end event

