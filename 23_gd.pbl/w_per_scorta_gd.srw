forward
global type w_per_scorta_gd from w_np_single_data
end type
end forward

global type w_per_scorta_gd from w_np_single_data
int Width=1829
boolean TitleBar=true
string Title="Periodi di scorta"
end type
global w_per_scorta_gd w_per_scorta_gd

on w_per_scorta_gd.create
call w_np_single_data::create
end on

on w_per_scorta_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_per_scorta_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_per_scorta_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_per_scorta_gd
int Width=1692
string DataObject="d_per_scorta_gd"
end type

event dw_single::itemchanged;call super::itemchanged;
long	  li_g_inizio,li_m_inizio,li_g_fine,li_m_fine
boolean lb_Data_Inizio, lb_Data_Fine

choose case dwo.name
	case "giorno_inizio"
		li_m_inizio = this.GetItemNumber(row, "mese_inizio")
		li_g_inizio = LONG(data)
		lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
		if not lb_Data_Inizio then 
			MessageBox(is_title, "Il Giorno e il Mese Inizio non appartengono ad una data valida", StopSign!, OK!)
			return 1
		end if
		
	case "mese_inizio"
		li_g_inizio = this.GetItemNumber(row, "giorno_inizio")
		li_m_inizio = LONG(data)
		lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
		if not lb_Data_Inizio then
			MessageBox(is_title, "Il Giorno e il Mese Inizio non appartengono ad una data valida", StopSign!, OK!)
			return 1
		end if
		
	case "giorno_fine"
		li_m_fine = this.GetItemNumber(row, "mese_fine")
		li_g_fine = LONG(data)
		lb_Data_Fine = f_controlla_data_gm(li_g_fine, li_m_fine)
	
		if not lb_Data_Fine then
			MessageBox(is_title, "Il Giorno e il Mese Fine non appartengono ad una data valida", StopSign!, OK!)
			return 1
		end if
		
	case "mese_fine"
		li_g_fine = this.GetItemNumber(row, "giorno_fine")
		li_m_fine = LONG(data)
		lb_Data_Fine = f_controlla_data_gm(li_g_fine, li_m_fine)
	
		if not lb_Data_Fine then
			MessageBox(is_title, "Il Giorno e il Mese Fine non appartengono ad una data valida", StopSign!, OK!)
			return 1
		end if
		
end choose



end event

event dw_single::ue_init;call super::ue_init;is_title = "Periodi di scorta"
end event

