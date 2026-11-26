forward
global type w_testata_ff from Window
end type
type cb_salva from commandbutton within w_testata_ff
end type
type cb_annulla from commandbutton within w_testata_ff
end type
type cb_ok from commandbutton within w_testata_ff
end type
type dw_1 from datawindow within w_testata_ff
end type
end forward

global type w_testata_ff from Window
int X=832
int Y=372
int Width=2075
int Height=1356
boolean TitleBar=true
string Title="Modifica dati testata per catalogo "
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_salva cb_salva
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_testata_ff w_testata_ff

type variables
long il_id_catalogo

end variables

on w_testata_ff.create
this.cb_salva=create cb_salva
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_salva,&
this.cb_annulla,&
this.cb_ok,&
this.dw_1}
end on

on w_testata_ff.destroy
destroy(this.cb_salva)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;il_id_catalogo=message.DoubleParm
dw_1.SetTransObject(sqlca)
dw_1.Retrieve(il_id_catalogo)

end event

type cb_salva from commandbutton within w_testata_ff
int X=1659
int Y=36
int Width=306
int Height=84
int TabOrder=10
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.AcceptText()
dw_1.SetItem(1,"id_catalogo",il_id_catalogo)
if dw_1.Update()>0 then
	commit;
else
	messagebox("Errore", "Catalogo non salvato!")
	rollback;
end if
end event

type cb_annulla from commandbutton within w_testata_ff
int X=375
int Y=36
int Width=306
int Height=84
int TabOrder=20
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_testata_ff
int X=64
int Y=36
int Width=265
int Height=84
int TabOrder=30
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;cb_salva.TriggerEvent(clicked!)
close(parent)
end event

type dw_1 from datawindow within w_testata_ff
event ue_post_itemchanged ( long al_riga,  string as_colonna,  integer ai_valore )
int X=23
int Y=140
int Width=2007
int Height=1104
int TabOrder=40
string DataObject="d_testata_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_post_itemchanged;this.SetItem(al_riga,as_colonna,ai_valore)
end event

event itemchanged;integer li_old, li_ampt, li_app

choose case dwo.name
	CASE "amp_testa"
		
		
		if integer(data)<>0 then
			if Integer(data)>1000 then
				li_old = GetItemNumber(1,"amp_testa")
				messagebox("Dimensione troppo elevata", "La dimensione massima è di 100 mm",Exclamation!,Ok!)
				Post Event ue_post_itemchanged(1,"amp_testa",li_old)
				elseif Integer(data)<300 then
					li_old = GetItemNumber(1,"amp_testa")
					messagebox("Dimensione troppo piccola", "La dimensione minima è di 30 mm",Exclamation!,Ok!)
					Post Event ue_post_itemchanged(1,"amp_testa",li_old)
					else 
						SetItem(1,"amp_logo",integer(data) - 100)
			end if
		else 
			SetItem(1,"amp_logo",0)
		end if
	
	CASE "amp_logo"
		
		li_ampt=GetItemNumber(1,"amp_testa")-100
		li_old=GetItemNumber(1,"amp_logo")		
		if li_ampt = -100 then
			messagebox("Variazione impossibile", "Se non si stampa la testata non si può stampare"+&
							+" neanche il logo!",Exclamation!,Ok!)
			Post Event ue_post_itemchanged(1,"amp_logo",li_old)
		end if
		if integer(data)>li_ampt then
			li_old = GetItemNumber(1,"amp_logo")
			messagebox("Dimensione troppo elevata", "L'attuale dimensione della testata consente"+&
							+" al massimo di avere "+string(li_ampt/10)+" mm di ampiezza",Exclamation!,Ok!)
			Post Event ue_post_itemchanged(1,"amp_logo",li_old)
		end if
		
	case "logo_mtop"
		li_old=getitemnumber(1,"logo_mtop")
		li_app=GetItemNumber(1,"logo_amp_y")
		li_ampt=GetItemNumber(1,"amp_testa")
		if Isnull(li_app) then li_app=0
		if long(data)+li_app>li_ampt then
			messagebox("Dimensione troppo elevata", "L'attuale dimensione della testata e del logo consentono"+&
							+" al massimo di avere "+string((li_ampt - li_app)/10)+" mm di ampiezza",Exclamation!,Ok!)
			Post Event ue_post_itemchanged(1,"logo_mtop",li_old)
		end if

	case "logo_amp_y"
		li_old=getitemnumber(1,"logo_amp_y")
		li_app=GetItemNumber(1,"amp_logo")
		if long(data)>li_app then
			messagebox("Dimensione troppo elevata", "L'attuale dimensione massima del logo consente "+&
							+string(li_app/10)+" mm di ampiezza",Exclamation!,Ok!)
			Post Event ue_post_itemchanged(1,"logo_amp_y",li_old)
		else
			li_app=GetItemNumber(1,"logo_mtop")
			li_ampt=GetItemNumber(1,"amp_testa")
			if Isnull(li_app) then li_app=0
			if long(data)+li_app>li_ampt then
				messagebox("Dimensione troppo elevata", "L'attuale dimensione della testata e del margine consentono"+&
								+" al massimo di avere "+string((li_ampt - li_app)/10)+" mm di ampiezza",Exclamation!,Ok!)
				Post Event ue_post_itemchanged(1,"logo_amp_y",li_old)
			end if
		end if
		
		
end choose

end event

