forward
global type w_tv_classe_struttura_cx from w_001
end type
type tv_1 from u_tree_orafo within w_tv_classe_struttura_cx
end type
type dw_1 from udw_base within w_tv_classe_struttura_cx
end type
type cb_ok from commandbutton within w_tv_classe_struttura_cx
end type
type cb_annulla from commandbutton within w_tv_classe_struttura_cx
end type
end forward

global type w_tv_classe_struttura_cx from w_001
int Width=1573
int Height=1576
WindowType WindowType=response!
boolean TitleBar=true
string Title="Scegli Classe da Applicare"
long BackColor=80269524
tv_1 tv_1
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_tv_classe_struttura_cx w_tv_classe_struttura_cx

type variables
long	il_item_corrente
string is_sql


end variables

on w_tv_classe_struttura_cx.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_annulla
end on

on w_tv_classe_struttura_cx.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;

long ll_hndl_padre, ll_hndl_figlio,ll_item_corrente, ll_ret
treeviewitem tv1_item
integer i
string ls_cod_padre, ls_cod_figlio, ls_cod_padre_old, ls_classe
long ll_id_figlio, ll_id_padre,ll_riga_trovata, ll_righe
s_tv_classe s_classi

dw_1.settransobject(sqlca)
ll_righe=dw_1.retrieve()

if ll_righe>0 then
	tv1_item.label="Struttura Classi"
	tv1_item.data=s_classi
	tv1_item.pictureindex=4
	tv1_item.selectedpictureindex=4
	tv1_item.Expanded=true
	tv_1.InsertItemFirst(0, tv1_item)
	
	tv1_item.pictureindex=2
	tv1_item.selectedpictureindex=2
end if
for i = 1 to ll_righe
	
	ls_cod_figlio=dw_1.getitemstring(i, "classe_figlio")
	s_classi.id_classe=dw_1.getitemnumber(i, "id_classe_figlio")
	s_classi.id_classe_padre=dw_1.getitemnumber(i, "id_classe_padre")
	s_classi.hnd_padre=dw_1.getitemnumber(i, "hnd_padre")
	s_classi.hnd_corrente=dw_1.getitemnumber(i, "hnd_corrente")
	tv1_item.data=s_classi
	tv1_item.label=ls_cod_figlio
	ll_hndl_figlio= tv_1.finditem(childtreeitem!, s_classi.hnd_padre)
	if ll_hndl_figlio>1 then
		ll_ret=tv_1.InsertItem(s_classi.hnd_padre, ll_hndl_figlio, tv1_item)
	else
		ll_ret=tv_1.InsertItemFirst(s_classi.hnd_padre, tv1_item)
	end if
next
if ll_righe>0 then il_item_corrente=dw_1.getitemnumber(ll_righe, "max_hnd")



end event

event timer;
end event

type tv_1 from u_tree_orafo within w_tv_classe_struttura_cx
int X=9
int Y=12
int Width=1239
int Height=1456
string DragIcon="Question!"
boolean BringToTop=true
end type

event dragdrop;TreeViewItem	tv0_item,	tv1_item
long ll_hnd_padre, ll_hnd_figlio, ll_hnd_source
long ll_item_corr
treeview tv_source
s_tv_classe s_classi, s_classe_padre

source.Drag(end!)
SetDropHighlight(handle)
tv_source=source
ll_hnd_source=tv_source.finditem(currenttreeitem!, 0)
tv_source.getitem(ll_hnd_source,  tv1_item)
s_classi=tv1_item.data
if handle>0 then
	getitem(handle, tv0_item)
	s_classe_padre=tv0_item.data
	s_classi.hnd_padre=s_classe_padre.hnd_corrente
	s_classi.id_classe_padre=s_classe_padre.id_classe
	ll_hnd_figlio=finditem(childtreeitem!, handle)
	if ll_hnd_figlio>0 then
		s_classi.hnd_corrente=il_item_corrente+1
		tv1_item.data=s_classi
		ll_item_corr=InsertItem(handle,ll_hnd_figlio ,tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
			
	else
		s_classi.hnd_corrente=il_item_corrente+1
		tv1_item.data=s_classi
		ll_item_corr=InsertItemfirst(handle, tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
	end if
else
	if il_item_corrente=0 then
		tv0_item.label="Struttura Classi"
		tv0_item.data=s_classe_padre
		tv0_item.pictureindex=4
		tv0_item.selectedpictureindex=4
		tv0_item.Expanded=true
		ll_item_corr=InsertItemFirst(0, tv0_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
		s_classi.hnd_corrente=il_item_corrente+1
		s_classi.id_classe_padre=0
		s_classi.hnd_padre=1
		tv1_item.data=s_classi		
		ll_item_corr=InsertItemFirst(1, tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
	elseif il_item_corrente>0 then
		ll_hnd_figlio=finditem(childtreeitem!, 1)
		s_classi.hnd_corrente=ll_hnd_figlio+1
		s_classi.id_classe_padre=0
		s_classi.hnd_padre=1
		tv1_item.data=s_classi
		ll_item_corr=InsertItem(1,ll_hnd_figlio ,tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
	end if
	SetPointer(Arrow!)
end if

end event

event rightclicked;s_tv_classe s_classi
treeviewitem tv_item

if handle>0 then
	getitem(handle, tv_item)
	s_classi=tv_item.data
	messagebox("id_classe"+string(s_classi.id_classe), &
				"id_cl_padre:"+string(s_classi.id_classe_padre)+&
				" ~r~nnodo_padre:"+string(s_classi.hnd_padre)+&
				" - nodo_corrente:"+string(s_classi.hnd_corrente))
				
end if

end event

event clicked;
end event

type dw_1 from udw_base within w_tv_classe_struttura_cx
int X=1938
int Y=1200
int Width=453
int Height=236
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="d_classe_struttura_gd"
end type

type cb_ok from commandbutton within w_tv_classe_struttura_cx
int X=1285
int Y=32
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="OK!"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;treeviewitem tv_item
s_recupera_classe s_rec
s_tv_classe s_classi
long ll_hnd
integer li_conta=1

ll_hnd=tv_1.finditem(currenttreeitem!, 0)
tv_1.getitem(ll_hnd, tv_item)
s_classi=tv_item.data
s_rec.cod_classe[li_conta]=tv_item.label
s_rec.id_classe[li_conta]=s_classi.id_classe
do while s_classi.id_classe_padre>0 
	li_conta++
	
	ll_hnd=tv_1.finditem(parenttreeitem!, ll_hnd)
	tv_1.getitem(ll_hnd, tv_item)
	s_rec.cod_classe[li_conta]=tv_item.label
	s_classi=tv_item.data
	s_rec.id_classe[li_conta]=s_classi.id_classe
loop 
closewithreturn(parent, s_rec)
end event

type cb_annulla from commandbutton within w_tv_classe_struttura_cx
int X=1285
int Y=188
int Width=247
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

