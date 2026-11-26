forward
global type u_tv_distinta from treeview
end type
end forward

global type u_tv_distinta from treeview
int Width=1138
int Height=1408
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
string PictureName[]={"Custom039!",&
"S:\pb\commonframework\cfolder.bmp",&
"S:\pb\commonframework\ofolder.bmp",&
"S:\pb\commonframework\menu.bmp",&
"S:\pb\commonframework\genappl.bmp",&
"S:\pb\commonframework\cfolderbia.bmp",&
"S:\pb\commonframework\cfolderG.bmp",&
"S:\pb\commonframework\cfolderV.bmp",&
"S:\pb\commonframework\cfolderR.bmp",&
"S:\pb\commonframework\cfolderB.bmp",&
"S:\pb\commonframework\ofolderbia.bmp",&
"S:\pb\commonframework\ofolderG.bmp",&
"S:\pb\commonframework\ofolderV.bmp",&
"S:\pb\commonframework\ofolderR.bmp",&
"S:\pb\commonframework\ofolderB.bmp",&
"S:\pb\commonframework\genapplBia.bmp",&
"S:\pb\commonframework\genapplG.bmp",&
"S:\pb\commonframework\genapplV.bmp",&
"S:\pb\commonframework\genapplR.bmp",&
"S:\pb\commonframework\genapplB.bmp"}
long PictureMaskColor=553648127
long StatePictureMaskColor=536870912
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_post_exp ( integer handle )
end type
global u_tv_distinta u_tv_distinta

type variables
boolean ib_completa
s_componente is_comp[]
end variables

event ue_post_exp;this.collapseitem(handle)
end event

event key;
treeViewItem	l_tvi
long				ll_tvi
boolean			lb_exp

ll_tvi = FindItem(CurrentTreeItem!,0)
if key = KeyEnter! then
	GetItem(ll_tvi, l_tvi)
	if (l_tvi.Level > 1) then
		if l_tvi.Children = false then
		else
			lb_exp = l_tvi.expanded
			if (lb_exp) then
				collapseItem(ll_tvi)
			else
				ExpandItem(ll_tvi)
			end if
		end if
	end if
end if

return 1
end event

event itemexpanding;treeviewitem ltvi_exp
dati dat
string ls_tipo_riga
getitem(handle,ltvi_exp)
dat=ltvi_exp.data
ls_tipo_riga=dat.tipo_riga
choose case ls_tipo_riga
	case 'N' 
		this.event post ue_post_exp(handle)
	case 'R'
		if ib_completa=false then
			integer li_controllo
			li_controllo=messagebox("Informazione","Vuoi esplodere la riga",information!,yesno!)
			if li_controllo=2 then this.event post ue_post_exp(handle)
		else
			this.event post ue_post_exp(handle)
		end if
end choose

end event

event constructor;ib_completa=true
this.HideSelection = FALSE
end event

event clicked;ib_completa=false
end event

