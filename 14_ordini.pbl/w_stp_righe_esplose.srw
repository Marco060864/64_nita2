forward
global type w_stp_righe_esplose from Window
end type
type cb_annulla from commandbutton within w_stp_righe_esplose
end type
type cb_stampa from commandbutton within w_stp_righe_esplose
end type
type dw_stampa from datawindow within w_stp_righe_esplose
end type
type ole_imm from olecustomcontrol within w_stp_righe_esplose
end type
end forward

global type w_stp_righe_esplose from Window
int X=101
int Y=100
int Width=4274
int Height=2684
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_annulla cb_annulla
cb_stampa cb_stampa
dw_stampa dw_stampa
ole_imm ole_imm
end type
global w_stp_righe_esplose w_stp_righe_esplose

forward prototypes
public subroutine wf_setta_cast (integer riga, integer num_cast, integer set_riga)
end prototypes

public subroutine wf_setta_cast (integer riga, integer num_cast, integer set_riga); decimal ld_qta, ld_dim
 string ls_note, ls_num_doc, ls_rag, a,b,c,d,e,f,g
 date ld_doc, ld_scad
 
 ls_note=dw_stampa.getitemstring(set_riga, "riga_documento_descrizione")
 ls_rag=dw_stampa.getitemstring(set_riga, "sog_commerciale_gen_rag_soc_1")
 ld_dim=dw_stampa.getitemnumber(set_riga, "dim_l")
 ls_num_doc=dw_stampa.getitemstring(set_riga, "documento_num_documento")
 ld_qta=dw_stampa.getitemdecimal(set_riga, "riga_documento_quantita")
 ld_doc=dw_stampa.getitemdate(set_riga, "documento_data_documento")
 ld_scad=dw_stampa.getitemdate(set_riga, "documento_data_scadenza")
 
 a='cliente'+string(num_cast)
 b='num_doc'+string(num_cast)
 c='data_doc'+string(num_cast)
 d='quantita'+string(num_cast)
 e='misura'+string(num_cast)
 f='data_consegna'+string(num_cast)
 g='note'+string(num_cast)
 
 dw_stampa.setitem(riga, g ,ls_note)
 dw_stampa.setitem(riga, a ,ls_rag)
 dw_stampa.setitem(riga, e ,ld_dim)
 dw_stampa.setitem(riga, b ,ls_num_doc)
 dw_stampa.setitem(riga, d ,ld_qta)
 dw_stampa.setitem(riga, c ,ld_doc)
 dw_stampa.setitem(riga, f ,ld_scad)


end subroutine

event open;dw_stampa.SetTransObject(SQLCA)

long ll_altezza, ll_larghezza, ll_altezza1, ll_larghezza1
string ls_path_imm, ls_nome_imm, ls_campo


long ll_row, job, mydc, ll_breakrow,ll_primo, ll_secondo,ll_alt_banda, ll_job 
decimal ld_ris_hor, ld_ris_ver
integer k, j, i, f,a, li_pos
decimal ld_dpi_x, ld_dpi_y
datawindow dw_esplodi
dw_esplodi=message.powerobjectparm

ll_row=dw_esplodi.rowcount()
dw_esplodi.RowsCopy(1, ll_row, Primary!, dw_stampa, 1, Primary!)




select dir_immagini
into :ls_path_imm
from par_sistema
where id_azienda=1;

for i=1 to dw_stampa.rowcount()
	
	  ll_job = PrintOpen()
	  
	  
	  ll_breakrow = dw_stampa.FindGroupChange( i+1, 1)
	  IF ll_breakrow <= 0 THEN 
			j= dw_stampa.rowcount()
     else 
         if ll_breakrow<> 1 then
			   j=ll_breakrow -1
			else 
				j=2        
				i=3        
		   end if
	  end if	
    f=1
	 ll_primo=dw_stampa.getitemnumber(i, "riga_distinta_id_riga_distinta")
	 wf_setta_cast(i,f,i)
	if j>i then
	for k=i+1 to j
		ll_secondo=dw_stampa.getitemnumber(k, "riga_distinta_id_riga_distinta")
		if ll_primo=ll_secondo then
			f=f+1
			wf_setta_cast(i,f,k)
	   else
   		exit
		end if
	next
	i=j
   end if
	
	
	f=((10 -f) *70)
   dw_stampa.setitem(i,"dim_l", 3)
	ls_nome_imm=dw_stampa.getitemstring(i,"articolo_immagine")

		if pos(ls_nome_imm, '\')>0 then
			ole_imm.object.loadimage(ls_nome_imm)
		else
			ole_imm.object.loadimage(ls_path_imm+'\'+ls_nome_imm)
		end if
		ll_altezza=ole_imm.object.imageheight
		ll_larghezza=ole_imm.object.imagewidth
		messagebox('',string(ll_altezza) + '  ' +string(ll_larghezza))
		ld_ris_hor=ole_imm.object.imageXdpi
		ld_ris_ver=ole_imm.object.imageYdpi
		
			  ld_ris_hor=ld_ris_hor/149
		
      messagebox('',string(ld_ris_hor) + '' +string(ld_ris_ver))
		ll_altezza=(ll_altezza*1000/58.5)/ld_ris_hor
		ll_larghezza=(ll_larghezza*1000/58.5)/ld_ris_hor
		
		dw_stampa.Object.articolo_immagine.visible=0
		
	   
		
		
		
		if ll_larghezza>19000 then
            
				job=PrintOpen()
            
            myDC=PRP_GetDC(job)
            ole_imm.object.printimage=mydc
            printclose(job)
	   else 


        Choose Case ll_altezza
			   case is > (14000 +f) 
					 if ll_larghezza> 8000 then 
						
						job=PrintOpen()
                  
                  myDC=PRP_GetDC(job)
                  ole_imm.object.printimage=mydc
                  printclose(job)
				    else
						dw_stampa.Object.articolo_immagine.Height=ll_altezza
						dw_stampa.Object.articolo_immagine.X=19500 -ll_larghezza 
				      dw_stampa.Object.articolo_immagine.y=1150
						dw_stampa.object.txtnote.visible=0
						dw_stampa.object.note1.x=50
						dw_stampa.object.note1.y=1500








						li_pos=6000 
						dw_stampa.object.txtriganote.visible=0
                  dw_stampa.object.line.visible=0
						dw_stampa.object.txtriga.width=11070
						dw_stampa.object.txtriga.y=li_pos
						li_pos=li_pos +415
						dw_stampa.object.txtcod.y=li_pos
						dw_stampa.object.txtdes.y=li_pos
						dw_stampa.object.txtqt.y=li_pos
						dw_stampa.object.txtpi.y=li_pos
						li_pos=li_pos +600
						dw_stampa.object.riga_distinta_note.x=5
						dw_stampa.object.riga_distinta_note.y=1500
						dw_stampa.Modify("DataWindow.header.1.Height="+string(li_pos))
						
						ll_altezza1=ole_imm.object.imageheight
		            ll_larghezza1=ole_imm.object.imagewidth
					   ll_altezza1=ll_altezza1
						ll_larghezza1=ll_larghezza1
						messagebox('',string(ll_altezza1) + '  ' +string(ll_larghezza1))
						myDC=PRP_GetDC(ll_job)
						ole_imm.object.printsize=6
						ole_imm.object.printtop=300
				      ole_imm.object.printleft=2700 -(2.43*ll_larghezza1)
		      		ole_imm.object.printbottom=300 +(ll_altezza1*2.43)
      				ole_imm.object.printright=2700
					
						ole_imm.object.printimage=mydc
						PrintDataWindow(ll_job, dw_stampa)
						printclose(ll_job)

						
						
               end if
				case else
						dw_stampa.Object.articolo_immagine.X=27 
			         dw_stampa.Object.articolo_immagine.y=(1040 -f)
						dw_stampa.object.txtnote.visible=1
						dw_stampa.object.note1.x=1650
						dw_stampa.object.note1.y=176
						
						dw_stampa.object.txtriganote.visible=1
                  dw_stampa.object.line.visible=1
						dw_stampa.object.txtriga.width=3365
						dw_stampa.object.txtriga.y=3000
						dw_stampa.object.txtcod.y=3056
						dw_stampa.object.txtdes.y=3056
						dw_stampa.object.txtqt.y=3056
						dw_stampa.object.txtpi.y=3056
						dw_stampa.object.riga_distinta_note.x=1920
						dw_stampa.object.riga_distinta_note.y=4
						dw_stampa.Modify("DataWindow.header.1.Height=4010")
						
			
	END Choose

  end if		
			
			
	
	
   
next
		














end event

on w_stp_righe_esplose.create
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.dw_stampa=create dw_stampa
this.ole_imm=create ole_imm
this.Control[]={this.cb_annulla,&
this.cb_stampa,&
this.dw_stampa,&
this.ole_imm}
end on

on w_stp_righe_esplose.destroy
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.dw_stampa)
destroy(this.ole_imm)
end on

type cb_annulla from commandbutton within w_stp_righe_esplose
int X=96
int Y=36
int Width=247
int Height=108
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(w_stp_righe_esplose)
end event

type cb_stampa from commandbutton within w_stp_righe_esplose
int X=3767
int Y=44
int Width=247
int Height=108
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
dw_stampa.object.datawindow.print.preview='yes'
dw_stampa.object.datawindow.print.preview.rulers='yes'
li_ret=messagebox('','',information!,YesNo!,2)

if li_ret=1 then 
	printsetup()
	dw_stampa.print()
end if
end event

type dw_stampa from datawindow within w_stp_righe_esplose
int X=91
int Y=180
int Width=3931
int Height=2372
int TabOrder=40
string DataObject="d_stp_esplodi_riga"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type ole_imm from olecustomcontrol within w_stp_righe_esplose
event paintevent ( )
event selectevent ( ref long lplleft,  ref long lpltop,  ref long lplright,  ref long lplbottom )
event statusevent ( ref long lppercent )
event click ( )
event dblclick ( )
event keydown ( ref integer keycode,  integer shift )
event keypress ( ref integer keyascii )
event keyup ( ref integer keycode,  integer shift )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event scroll ( long scrolltype )
event errorevent ( integer nerrcount )
event thumbnail ( string filename,  long page )
event tag ( integer tagid,  integer tagtype,  long tagsize,  integer wordval,  long longval,  string strval )
event thumbtitle ( ref string title,  integer page )
int X=1696
int Y=48
int Width=41
int Height=36
int TabOrder=20
long TextColor=33554432
BorderStyle BorderStyle=StyleLowered!
string BinaryKey="w_stp_righe_esplose.win"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

