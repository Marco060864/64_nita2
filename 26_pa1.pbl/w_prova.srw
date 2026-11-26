forward
global type w_prova from Window
end type
end forward

global type w_prova from Window
int X=833
int Y=361
int Width=1998
int Height=1209
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_prova w_prova

event open;string ls_path
select dir_report
into :ls_path
from par_sistema;
ls_path=ls_path+"\libro.exe"
run(ls_path)
close(this)
end event

on w_prova.create
end on

on w_prova.destroy
end on

