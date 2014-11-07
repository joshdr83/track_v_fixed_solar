first_fifty_GAMS <- function(max_array = 2, max_tot_cap = 1.5, trk_type = 'single'){
	
	library(foreach)
	library(stringr)

	## Read TMY data to get all the site_names
	
	list <- read.csv('tmy_names_list_reduc.csv')
	
	foreach(i=1:length(list[,1]))%do%{

		## take the unrecognizable characters out of the locations
		city_name <- list$site_name[i]
		city_name <- str_replace_all(string = city_name, pattern = " ", repl="_")
 		city_name <- str_replace_all(string = city_name, pattern = "/", repl="_")
		
		## convert the max_tot_cap to a string and replace '.' with a '_'
		max_tot_cap2 <- gsub(".", '_', max_tot_cap, fixed = T)
		
		## Queue up the (premade) GMS file -- this could be name automatically as it is not that hard 
		gms_file_name <- paste('/srv/home/jdr2823/trk_fx_solar/GMS_files_', trk_type, '_axis/', city_name,'_ary_', max_array,'_cap_', max_tot_cap2, '_', trk_type, '.gms', sep = '')
		## Create the GAMS command to run at the 'command line' level
		sys_command <- paste('gams', gms_file_name, 'lo = 2', 'threads = 0','reslim = 86400', 'optcr =', '0.1', sep = ' ')
		
		## Run the above in the System -- not in R (get around using the gdxrrw package here)
		system(sys_command)
		
		


	}


}