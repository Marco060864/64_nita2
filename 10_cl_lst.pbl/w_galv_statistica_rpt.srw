forward
global type w_galv_statistica_rpt from w_stampa
end type
type cb_1 from commandbutton within w_galv_statistica_rpt
end type
end forward

global type w_galv_statistica_rpt from w_stampa
integer width = 4242
cb_1 cb_1
end type
global w_galv_statistica_rpt w_galv_statistica_rpt

type variables
s_date_e_sog s_date
end variables

on w_galv_statistica_rpt.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_galv_statistica_rpt.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;

s_date=message.powerobjectparm

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_galv_statistica_rpt
end type

type cb_preview from w_stampa`cb_preview within w_galv_statistica_rpt
end type

type dw_1 from w_stampa`dw_1 within w_galv_statistica_rpt
integer width = 4073
string dataobject = "d_tot_galv_excel"
end type

event dw_1::buttonclicked;call super::buttonclicked;messagebox("OGGETTO:", dwo.name)
end event

event dw_1::sqlpreview;call super::sqlpreview;//if(s_date.da_data> "01-01-1900" then

string ls_sql
integer i, li_pos

if s_date.da_data>date( "01-01-1900") then
	//"GROUP BY"
	ls_sql=sqlsyntax
	li_pos=pos(ls_sql, "GROUP BY")
	ls_sql=left(ls_sql, li_pos -1) + " and  documento.data_documento >= '"+string(s_date.da_data,'yyyy/mm/dd') +"' and  documento.data_documento <= '"+string(s_date.a_data,'yyyy/mm/dd')+ &
	"' "+right(ls_sql, len(ls_sql)+ 1 - li_pos)
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
	
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_galv_statistica_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_galv_statistica_rpt
end type

type sle_pg from w_stampa`sle_pg within w_galv_statistica_rpt
end type

type st_1 from w_stampa`st_1 within w_galv_statistica_rpt
end type

type st_2 from w_stampa`st_2 within w_galv_statistica_rpt
end type

type sle_copie from w_stampa`sle_copie within w_galv_statistica_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_galv_statistica_rpt
end type

type cb_7 from w_stampa`cb_7 within w_galv_statistica_rpt
end type

type cb_6 from w_stampa`cb_6 within w_galv_statistica_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_galv_statistica_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_galv_statistica_rpt
end type

type cb_esci from w_stampa`cb_esci within w_galv_statistica_rpt
end type

type cb_1 from commandbutton within w_galv_statistica_rpt
integer x = 3470
integer y = 32
integer width = 549
integer height = 92
integer taborder = 23
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elimina Colonne Vuote"
end type

event clicked;integer i
long ll_righe
decimal ldc_tot_colonna
string ls_i

ll_righe=dw_1.rowcount()
for i= 1 to 25
	
	if i<=9 then
		ls_i="0"+string(i)
	else
		ls_i=string(i)
	end if
	ldc_tot_colonna=dw_1.getitemdecimal(i, "c_sum_"+ls_i)
	if ldc_tot_colonna> 0 then continue
	
	 dw_1.Modify("DESTROY c_"+ls_i)  
	
next

end event

