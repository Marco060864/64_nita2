forward
global type w_about from w_about_fw
end type
end forward

global type w_about from w_about_fw
end type
global w_about w_about

on w_about.create
call w_about_fw::create
end on

on w_about.destroy
call w_about_fw::destroy
end on

