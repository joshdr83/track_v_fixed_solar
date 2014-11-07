first_fifty_GAMS <- function(max_array = 2, max_tot_cap = 1.5, trk_type = 'single'){
	
	library(foreach)


	## Read TMY data to get all the site_names
	
	list <- read.csv('tmy_names_list_reduc.csv')
	
	foreach(i=1:length(list[,1]))%do%{

		library(stringr)
		
		city_name <- list$site_name[i]
		city_name <- str_replace_all(string = city_name, pattern = " ", repl="_")
 		city_name <- str_replace_all(string = city_name, pattern = "/", repl="_")
		

		max_tot_cap2 <- gsub(".", '_', max_tot_cap, fixed = T)
		gms_file_name <- paste('/srv/home/jdr2823/trk_fx_solar/GMS_files_', trk_type, '_axis/', city_name,'_ary_', max_array,'_cap_', max_tot_cap2, '_', trk_type, '.gms', sep = '')
		tracking_file_name <- paste('/srv/home/jdr2823/make_all_GDX_files/all_trk_files/', city_name,'_tracking_input.csv', sep = '')
		trk_file <- read.csv(tracking_file_name)
		all <- sum(trk_file[c(paste('mod_pv_gen_', trk_type, sep = ''))])
		opt_cri <- all*.01
		
		sys_command <- paste('gams', gms_file_name, 'lo = 2', 'threads = 0','reslim = 86400', 'optcr =', '0.1', sep = ' ')
		
		system(sys_command)
		
		


	}


}