forward
global type w_stampa_exe_cr from w_np_single_data
end type
end forward

global type w_stampa_exe_cr from w_np_single_data
int Width=3163
int Height=820
boolean TitleBar=true
string Title="Stampe Personalizzate"
end type
global w_stampa_exe_cr w_stampa_exe_cr

on w_stampa_exe_cr.create
call super::create
end on

on w_stampa_exe_cr.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_stampa_exe_cr
int X=14
int Y=12
int Width=3045
string DataObject="d_stampe_personalizzate"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_single::doubleclicked;string ls_exe, ls_path
accepttext()
ls_exe=getitemstring(row, "stampa_eseguibile")
if pos(ls_exe, '\')>0 then
else
	select dir_report
	into :ls_path
	from par_sistema;
	if right(ls_path, 1)='\'  then ls_path=left(ls_path, len(ls_path) - 1)
	ls_exe=ls_path+'\'+ls_exe
end if
Run(ls_exe, Maximized!)
end event

event dw_single::clicked;call super::clicked;string ls_file, ls_path
integer li_ret
if dwo.name='cerca_file' then
	getfileopenname("Cerca report", ls_path, ls_file)
	li_ret=messagebox("Attenzione!","Vuoi riportare il solo nome del file? (o tutto il path?)", stopsign!,yesno! )
	if  li_ret=1 then
		setitem(row, "stampa_eseguibile", ls_file)
	else
		setitem(row, "stampa_eseguibile", ls_path)
	end if
end if
end event

