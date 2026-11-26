forward
global type w_sel_sog_comm_derivabile_wz from w_wiz_main
end type
type dw_sog_comm_derivabili_lt from datawindow within w_sel_sog_comm_derivabile_wz
end type
type cb_ok from commandbutton within w_sel_sog_comm_derivabile_wz
end type
type cb_annulla from commandbutton within w_sel_sog_comm_derivabile_wz
end type
type cb_1 from commandbutton within w_sel_sog_comm_derivabile_wz
end type
end forward

global type w_sel_sog_comm_derivabile_wz from w_wiz_main
int Width=1866
int Height=1609
dw_sog_comm_derivabili_lt dw_sog_comm_derivabili_lt
cb_ok cb_ok
cb_annulla cb_annulla
cb_1 cb_1
end type
global w_sel_sog_comm_derivabile_wz w_sel_sog_comm_derivabile_wz

type variables
s_par_der_doc	istr_parm
long		il_id_sog_comm

string		is_last_column, is_last_sort
end variables

on w_sel_sog_comm_derivabile_wz.create
int iCurrent
call w_wiz_main::create
this.dw_sog_comm_derivabili_lt=create dw_sog_comm_derivabili_lt
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_sog_comm_derivabili_lt
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=cb_annulla
this.Control[iCurrent+4]=cb_1
end on

on w_sel_sog_comm_derivabile_wz.destroy
call w_wiz_main::destroy
destroy(this.dw_sog_comm_derivabili_lt)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_1)
end on

event open;call super::open;istr_parm=Message.PowerObjectParm
If UpperBound(istr_parm.s_dbv) > 0 then
	
	
	dw_sog_comm_derivabili_lt.Retrieve(Long(istr_parm.s_dbv[1]))
else
	MessageBox("elezione dei Soggetti Commerciali","Problemi con l'apertura della finestra")
	Close(this)
end if
end event

event closequery;call super::closequery;
istr_parm.s_dbv[2]= String(il_id_sog_comm)


Message.PowerObjectParm=istr_parm
end event

type dw_sog_comm_derivabili_lt from datawindow within w_sel_sog_comm_derivabile_wz
int X=46
int Y=161
int Width=1738
int Height=1321
int TabOrder=10
boolean BringToTop=true
string DataObject="dw_sog_comm_derivabili_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;SetTrans(SQLCA)
end event

event rowfocuschanged;
long	ll_Row

ll_Row = GetRow()
If Not(IsNull(ll_Row) OR ll_Row =0) then 
	il_Id_Sog_Comm = GetItemNumber(ll_Row, "sog_commerciale_gen_id_sog_commerciale")
	SelectRow(0, FALSE)
	SelectRow(ll_Row, TRUE)
end if
end event

event doubleclicked;string ls_column

if isValid( dwo ) then
	if row = 0 then 
		if dwo.Type = "column" then
			if not (dwo.Name = "datawindow") then
				ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 2)
				if ls_column = is_last_column then 
					if is_last_sort = "D" then
						this.SetSort(ls_column + " A")
						is_last_sort = "A"
					else
						this.SetSort(ls_column + " D")
						is_last_sort = "D"
					end if
				else 
					this.SetSort(ls_column + " A")
					is_last_column = ls_column
					is_last_sort = "A"
				end if
				this.Sort()
			end if
		end if	
	end if 
end if

end event

type cb_ok from commandbutton within w_sel_sog_comm_derivabile_wz
int X=46
int Y=41
int Width=193
int Height=85
int TabOrder=20
boolean BringToTop=true
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long	ll_Row

ll_Row= dw_sog_comm_derivabili_lt.GetRow()
If Not(IsNull(ll_Row) OR ll_Row =0) then 
	il_Id_Sog_Comm= dw_sog_comm_derivabili_lt.GetItemNumber(ll_Row, "sog_commerciale_gen_id_sog_commerciale")
end if
Close(Parent)


end event

type cb_annulla from commandbutton within w_sel_sog_comm_derivabile_wz
int X=1555
int Y=41
int Width=211
int Height=85
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
SetNull(il_id_sog_comm)
Close(Parent)
end event

type cb_1 from commandbutton within w_sel_sog_comm_derivabile_wz
int X=686
int Y=41
int Width=193
int Height=85
int TabOrder=21
boolean BringToTop=true
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;MessageBox("", dw_sog_comm_derivabili_lt.Describe("datawindow.selected"))
end event

