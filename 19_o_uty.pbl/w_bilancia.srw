forward
global type w_bilancia from w_001
end type
type ole_1 from olecustomcontrol within w_bilancia
end type
end forward

global type w_bilancia from w_001
boolean visible = false
integer x = 1057
integer y = 483
integer width = 649
integer height = 540
ole_1 ole_1
end type
global w_bilancia w_bilancia

forward prototypes
public function decimal f_rendi_peso ()
end prototypes

public function decimal f_rendi_peso ();string Buffer, buffer2, ls_bilancia
integer li_pos, li_pos_2
decimal ldc_peso_netto
string ls_peso
boolean lb_test
//' Open the serial port


ls_bilancia = ProfileString ( "nita.ini", "PC", "Bilancia", "Error!" )  
//ls_bilancia = ProfileString ( "pb125.ini", "PC", "Bilancia", "Error!" )

choose case ls_bilancia
	case "radwag"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "9600,N,8,1"
		OLE_1.object.PortOpen = True           //' Required, might lock port
		sleep(1)
		Buffer = OLE_1.object.Input //' Read data
		 
		OLE_1.object.PortOpen = False
		
		ls_peso=mid(buffer,7, 9)  

		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
	case "mettler"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "9600,E,7,1"
		OLE_1.object.PortOpen = True           //' Required, might lock port
		sleep(1)
		Buffer = OLE_1.object.Input //' Read data
		 
		OLE_1.object.PortOpen = False
		li_pos=pos(buffer, "S")
		ls_peso=mid(buffer, li_pos+2, 10)  

		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
		
	case "sartorius gp6100"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "1200,O,7,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		//sleep(1)   //20250812 provo a togliere per il doppio peso nella riga attuale e in quella successiva... mha....
		//MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
 
		OLE_1.object.PortOpen = False
		if len(buffer)>30 then
			li_pos=pos(Buffer, "+", 16)
		else
			li_pos=pos(Buffer, "+", 1)
		end if
	  ls_peso=mid(buffer, li_pos, 11)
	  ls_peso=left(ls_peso, 10)
	  ls_peso=right(ls_peso, 9)
		ls_peso=trim(ls_peso)
		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
		
		
	case "sartorius"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "1200,N,7,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)   //20250812 provo a togliere per il doppio peso nella riga attuale e in quella successiva... mha....
		
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
 		if len(buffer)>30 then
			li_pos=pos(Buffer, "+", 16)
		else
			li_pos=pos(Buffer, "+", 1)
		end if
		if li_pos<=0 then  //20250901 a volte NON prende il peso.... perché la stringa ottenuta non è completa o chiara...
			Buffer = OLE_1.object.Input //' Read data
			if len(buffer)>30 then
				li_pos=pos(Buffer, "+", 16)
			else
				li_pos=pos(Buffer, "+", 1)
			end if
			if li_pos<=0 then
				messagebox("Attenzione!", "Dato da Bilancia sartoriius NON arrivato!! Ripetere l'operazione e dirlo a Marco!")
			else
				messagebox("Attenzione!", "Dato bilancia arrivato in ritardo ma recuperato: dirlo a Marco!")
			end if
		end if  //2025091 FINE
		ls_peso=mid(buffer, li_pos, 11)
		ls_peso=left(ls_peso, 10)
		ls_peso=right(ls_peso, 9)
		ls_peso=trim(ls_peso)
		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
		OLE_1.object.PortOpen = False
	case "strumenta"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "4800,N,8,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
		OLE_1.object.PortOpen = False
		LI_POS=POS(buffer, "GS", 1)
		 //messagebox("inizio", li_pos)
		if li_pos>0 then
			li_pos_2=POS(buffer, "g", li_pos)
			//messagebox("Fine", li_pos_2)
			ls_peso=mid(buffer, li_pos+3, 9)
			li_pos=pos(ls_peso, ".")
			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
			ls_peso=trim(ls_peso)
			ldc_peso_netto=dec(ls_peso)
		else
			messagebox("Attenzione!", "Errore Strumenta, GS non trovato!")
		end if
	case "strumenta2"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "9600,N,8,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
		OLE_1.object.PortOpen = False
		//messagebox("W", buffer)
		LI_POS=POS(buffer, "GS", 1)
		 //messagebox("inizio", li_pos)
		if li_pos>0 then
			li_pos_2=POS(buffer, "g", li_pos)
			//messagebox("Fine", li_pos_2)
			ls_peso=mid(buffer, li_pos+3, 9)
			li_pos=pos(ls_peso, ".")
			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
			ls_peso=trim(ls_peso)
			ldc_peso_netto=dec(ls_peso)
		else
			messagebox("Attenzione!", "Errore Strumenta2, GS non trovato!")
		end if
	case "strumenta3"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "4800,N,8,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
		OLE_1.object.PortOpen = False
		LI_POS=POS(buffer, "ST", 1)
//		messagebox("Attenzione!", buffer)
//		messagebox("Attenzione!", mid(buffer, li_pos+6, 9))
		 //messagebox("inizio", li_pos)
		if li_pos>0 then
			li_pos_2=POS(buffer, "g", li_pos)
			//messagebox("Fine", li_pos_2)
			ls_peso=mid(buffer, li_pos+6, 9)
			li_pos=pos(ls_peso, ".")
			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
			ls_peso=trim(ls_peso)
			ldc_peso_netto=dec(ls_peso)
		else
			messagebox("Attenzione!", "Errore Strumenta, ST non trovato!")
		end if
		
	case "radwag2"  //20240523 nuova bilancia peso oro ad un decimale
		OLE_1.object.CommPort = 1  //' Set the port number 
		OLE_1.object.Settings = "9600,N,8,1"
		OLE_1.object.PortOpen = True           //' Required, might lock port
		sleep(1)
		Buffer = OLE_1.object.Input //' Read data
		
		LI_POS=POS(buffer, "SUI", 1)  //20240529 prima era "SUI " con lo spazio per evitare di prendere un peso non stabilizzato... ma era troppo lento
		IF LI_POS<=0 THEN
			Buffer = OLE_1.object.Input //' Read data
			LI_POS=POS(buffer, "SUI", 1)
		END IF  //20240529 fine
		li_pos_2=POS(buffer, "g", LI_POS)
		ls_peso=mid(buffer, li_pos+3, li_pos_2 - LI_POS - 3)
		
		//ls_peso=mid(buffer,4, len(buffer) - 4 - 2)  
		ls_peso=trim(ls_peso)
		
		//li_pos=pos(ls_peso, ".")
		//ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
		OLE_1.object.PortOpen = False
end choose
//messagebox("A", string(ldc_peso_netto, "#,0.00"))
return ldc_peso_netto
end function

on w_bilancia.create
int iCurrent
call super::create
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
end on

on w_bilancia.destroy
call super::destroy
destroy(this.ole_1)
end on

type st_1 from w_001`st_1 within w_bilancia
end type

type ole_1 from olecustomcontrol within w_bilancia
event oncomm ( )
integer x = 82
integer y = 216
integer width = 174
integer height = 152
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_bilancia.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

