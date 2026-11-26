forward
global type w_orafo_sit_articolo_wz from w_sit_articolo_wz
end type
end forward

global type w_orafo_sit_articolo_wz from w_sit_articolo_wz
int Height=1552
end type
global w_orafo_sit_articolo_wz w_orafo_sit_articolo_wz

on w_orafo_sit_articolo_wz.create
call super::create
end on

on w_orafo_sit_articolo_wz.destroy
call super::destroy
end on

type tab_1 from w_sit_articolo_wz`tab_1 within w_orafo_sit_articolo_wz
int X=14
int Y=388
int Height=1040
boolean BringToTop=true
end type

type tabpage_1 from w_sit_articolo_wz`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3058
int Height=920
end type

type dw_esidisp from w_sit_articolo_wz`dw_esidisp within tabpage_1
int X=69
int Width=2944
int Height=888
end type

type dw_scorta_art_gd from w_sit_articolo_wz`dw_scorta_art_gd within tabpage_1
int X=1792
boolean BringToTop=true
end type

type tabpage_2 from w_sit_articolo_wz`tabpage_2 within tab_1
int X=18
int Y=104
int Width=3058
int Height=920
end type

type tabpage_3 from w_sit_articolo_wz`tabpage_3 within tab_1
int X=18
int Y=104
int Width=3058
int Height=920
end type

type tabpage_7 from w_sit_articolo_wz`tabpage_7 within tab_1
int X=18
int Y=104
int Width=3058
int Height=920
end type

type tabpage_4 from w_sit_articolo_wz`tabpage_4 within tab_1
int X=18
int Y=104
int Width=3058
int Height=920
end type

type tabpage_5 from w_sit_articolo_wz`tabpage_5 within tab_1
int X=18
int Y=104
int Width=3058
int Height=920
end type

type tabpage_6 from w_sit_articolo_wz`tabpage_6 within tab_1
int X=18
int Y=104
int Width=3058
int Height=920
end type

type cb_esci from w_sit_articolo_wz`cb_esci within w_orafo_sit_articolo_wz
boolean BringToTop=true
end type

type cb_mostra from w_sit_articolo_wz`cb_mostra within w_orafo_sit_articolo_wz
boolean BringToTop=true
end type

