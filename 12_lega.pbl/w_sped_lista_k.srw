forward
global type w_sped_lista_k from w_semplice_gd
end type
type dw_2 from udw_000 within w_sped_lista_k
end type
type ole_1 from olecontrol within w_sped_lista_k
end type
type st_1 from statictext within w_sped_lista_k
end type
type dw_3 from udw_001 within w_sped_lista_k
end type
type cb_1 from commandbutton within w_sped_lista_k
end type
type oleobject_1 from oleobject within w_sped_lista_k
end type
end forward

global type w_sped_lista_k from w_semplice_gd
integer width = 3753
integer height = 2188
dw_2 dw_2
ole_1 ole_1
st_1 st_1
dw_3 dw_3
cb_1 cb_1
oleobject_1 oleobject_1
end type
global w_sped_lista_k w_sped_lista_k

on w_sped_lista_k.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.ole_1=create ole_1
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_1=create cb_1
this.oleobject_1=create oleobject_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_1
end on

on w_sped_lista_k.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.ole_1)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.oleobject_1)
end on

event resize;//
end event

event open;call super::open;dw_3.settransobject(sqlca)

dw_3.retrieve()
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_sped_lista_k
boolean visible = false
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_sped_lista_k
boolean visible = false
end type

type cb_primo from w_semplice_gd`cb_primo within w_sped_lista_k
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_sped_lista_k
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_sped_lista_k
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_sped_lista_k
end type

type dw_1 from w_semplice_gd`dw_1 within w_sped_lista_k
integer width = 1413
string dataobject = "d_sped_lista_k"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_sped_lista_k
end type

type cb_salva from w_semplice_gd`cb_salva within w_sped_lista_k
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_sped_lista_k
end type

event cb_cancella::rbuttondown;call super::rbuttondown;long i

for i=dw_1.rowcount() to 1 step -1
	dw_1.trigger event ue_delete(i)	
next
end event

type cb_annulla from w_semplice_gd`cb_annulla within w_sped_lista_k
string text = "Importa"
end type

event cb_annulla::clicked;string ls_path,ls_file, ls_i, ls_giorno,ls_cliente, ls_clienti[], ls_null[]
integer i, li_max_settimana, a,li_g_per_data, b, c, li_pos1, li_pos2
long ll_riga_inserita
date ldt_data

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+"csv"
	//dw_2.importfile(CSV!,ls_file)
	dw_2.importfile(Text!,ls_file)
	select max(settimana) into :li_max_settimana from sped_lista_k;
	if li_max_settimana<=0 or isnull(li_max_settimana) then li_max_settimana=1
	for i=1 to 5 //10 step 2
		//a++	//20240226 cambiato formato csv: non più 10 colonne una si e una no, ma 5 colonne attaccate... mha! senza preavviso....
		ls_i=string(i)
		//ls_i=string(a)
		if len(ls_i)=1 then ls_i="0"+ls_i
		ls_giorno=dw_2.getitemstring(1, "A"+ls_i)
		//ls_giorno=trim(dw_2.getitemstring(1, "A"+ls_i))
		//li_g_per_data=integer(right(ls_giorno, 2))
		
		for a = 2 to dw_2.rowcount() 	
			ls_cliente=dw_2.getitemstring(a,  "A"+ls_i)
			if ls_cliente> " " then
				ls_clienti[]= ls_null[]
				b=1
				li_pos1=pos(ls_cliente, "/")
				if li_pos1 > 0 then
					ls_clienti[b]=left(ls_cliente, li_pos1 - 1)
					if len(ls_clienti[b])=2 then ls_clienti[b]="0"+ls_clienti[b]
					li_pos2=pos(ls_cliente, "/", li_pos1+1)
					if li_pos2>0 then
						b++
						ls_clienti[b]=mid(ls_cliente, li_pos1+1, li_pos2 - li_pos1 - 1)
						if len(ls_clienti[b])=2 then ls_clienti[b]="0"+ls_clienti[b]
						b++
						ls_clienti[b]=right(ls_cliente, len(ls_cliente) - li_pos2)
						if len(ls_clienti[b])=2 then ls_clienti[b]="0"+ls_clienti[b]
					else
						ls_clienti[b]=right(ls_cliente, len(ls_cliente) - li_pos1)
						if len(ls_clienti[b])=2 then ls_clienti[b]="0"+ls_clienti[b]
					end if
				else
					li_pos1=pos(ls_cliente, "(")
					if li_pos1>0 then
						ls_clienti[b]=left(ls_cliente, li_pos1 - 1)
					else
						ls_clienti[b]=ls_cliente
					end if
				end if
				//ldt_data=date(year(today()), month(today()), li_g_per_data)  //20221128 si cambia perchè adesso è nel xls
				ldt_data=date(ls_giorno)
				for c=1 to b
					ll_riga_inserita=dw_1.insertrow(0)
					dw_1.setitem(ll_riga_inserita,  "cliente", ls_clienti[c])
					dw_1.setitem(ll_riga_inserita,  "s_data", ldt_data)
					dw_1.setitem(ll_riga_inserita,  "settimana", li_max_settimana+1)
				next
			end if
		next		
	next

end if	 
end event

type cb_ok from w_semplice_gd`cb_ok within w_sped_lista_k
end type

type dw_2 from udw_000 within w_sped_lista_k
integer x = 23
integer y = 1344
integer width = 4425
integer height = 620
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_EXT_PER_IMPORT"
end type

type ole_1 from olecontrol within w_sped_lista_k
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
integer x = 1161
integer y = 1160
integer width = 347
integer height = 108
integer taborder = 60
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_sped_lista_k.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type st_1 from statictext within w_sped_lista_k
integer x = 2610
integer y = 1000
integer width = 1051
integer height = 128
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Importa SOLO files CSV"
boolean focusrectangle = false
end type

type dw_3 from udw_001 within w_sped_lista_k
integer x = 1463
integer y = 32
integer width = 1335
integer height = 912
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_anticipa_cliente"
end type

event itemchanged;call super::itemchanged;long ll_riga_trovata
string ls_cliente,ls_cerca
date ldt_data

if string(dwo.name)="anticipa_a_tutto" or string(dwo.name)="fino_a_tutto" then
	ldt_data=date(data)
	ls_cliente=getitemstring(row, "cliente")
	if ls_cliente>" " then
		ls_cerca="cliente='"+ls_cliente+"' and anticipa_a_tutto<= "+data+" and fino_a_tutto>="+data
		ll_riga_trovata=find(ls_cerca, 1, rowcount())
		if ll_riga_trovata>0 then
			messagebox("Attenzione!", "La riga "+string(ll_riga_trovata)+" ha date sovrapponibili a quella che stai inserendo: controlla che le date segnino SEMPéRE periodi di tempo diversi e NON sovrapponibili!")
			return 2
		end if	
	else
		messagebox("Attenzione!", "Manca il cliente!!!")
		return 2
	end if
end if
end event

type cb_1 from commandbutton within w_sped_lista_k
integer x = 2843
integer y = 36
integer width = 517
integer height = 156
integer taborder = 20
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SALVA"
end type

event clicked;dw_3.trigger event ue_update()
end event

type oleobject_1 from oleobject within w_sped_lista_k descriptor "pb_nvo" = "true" 
end type

on oleobject_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

