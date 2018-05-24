#delimit ;
version 13;
/* set trace, set more , defined in 00_syp_master_format */
/* assumes that $filenums come from 02_load_files */



/***************************************************************************/
/*
 Meta Data 
 Code Version :		1.3 BETA 
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	2018/02/08
 Last Test : 		2018/02/03 ; 04:58 PM 
 Last Addition : 	2018/02/13
 Code Environment:	INITIALIZATION
 
 Code Purpose : 	This is intended to add transformed variables from the 
						Dun and Bradstreet data for detailed analysis
						
 Data Input : 		File.data.name.dta
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case esensitive
*/
/***************************************************************************/



/***************************************************************************/
/* START:: ADD TRANSFORM VARIABLES                                         */
/***************************************************************************/
local thisfilenum = 1;



foreach i in $filenames{;



/* initiate log files -----------------------------------------------------*/
	cd ./logs;
	log using "log.add.vars.`i'.smcl", replace;
	cd ../data;
	ls;
	di "START:: DESTRING VARIABLES ";
	di "FILE:: `i' : " ;
	di "TIME:: "c(current_date) " "  c(current_time);
	di "Transform Progress :  `thisfilenum'  out of  $filenums";


	
/* load data for manipulation ---------------------------------------------*/
	use "`i'.dta", clear;

			di "TIME:: "c(current_date) " "  c(current_time);
			
			
	
/* generate transformed data ----------------------------------------------*/
	gen dsalesvosqr = dsalesvo^2;
		label var dsalesvosqr "annual sales squared";
		di "PROGRESS:: SALES VOL SQR MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
	
	gen dempltotsqr = dempltot^2;
		label var dempltotsqr "total employees in entity squared";
		di "PROGRESS:: EMPL TOT SQR MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
	
	gen dyrstartsqr = dyrstart^2;
		label var dyrstartsqr "starting year squared";
		di "PROGRESS:: STARTING YEAR SQR MADE : ";
		di "TIME:: "c(current_date) " "  c(current_time);
	
	gen demplhersqr = demplher^2;
		label var demplhersqr "employees here squared";
		di "PROGRESS:: EMP HERE SQR MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
	
	gen dsalesvolog = ln(dsalesvo);
		label var dsalesvolog "log of sales volumn";
		di "PROGRESS:: SALES VOL SQR MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
	
	gen dempltotlog = ln(dempltot);
		label var dempltotlog "log of total employee count";
		di "PROGRESS:: EMP TOT LOG MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
	
	gen dyrstartlog = ln(dyrstart);
		label var dyrstartlog "log of starting year";
		di "PROGRESS:: START YEAR LOG MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
	
	gen demplherlog = ln(demplher);
		label var demplherlog "log of count of employees here";
		di "PROGRESS:: EMP HERE LOG MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
		
		
		
/* generate a variable for the year of the data ---------------------------*/
	di substr(c(filename),-8,4);
	
	gen year = substr(c(filename),-8,4);
		di "PROGRESS:: YEAR MADE : " ; 
		di "TIME:: "c(current_date) " "  c(current_time);
		
	destring year, replace;
		di "PROGRESS:: YEAR DESTRINGED : " ;
		di "TIME:: "c(current_date) " "  c(current_time);

	
	
/* generate age of firm based off of year formed and current year ---------*/
	gen age = (year - dyrstart);
		label var age "age of the firm during survey year";
		di "PROGRESS:: AGE MADE : " ;
		di "TIME:: "c(current_date) " "  c(current_time);
		
	gen agesqr = (age)^2;
			label var age "age squared of the firm during survey year";
		di "PROGRESS:: AGE SQR MADE : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
			
	gen agelog = ln(age);
			label var age "log of age of the firm during survey year";
		di "PROGRESS:: AGE LOG MADE : " ;
			di "TIME:: "c(current_date) " "  c(current_time);



/* generate dummies for missing values ------------------------------------*/
	local impvars  "year age dstateab dcountyc dsalesvo dempltot demplher dyrstart";
	gen anymissing = 0;
	foreach k in `impvars'{;
		gen missing_`k' = 0;
			di "PROGRESS:: MISSING `k' MADE : ";
			di "TIME:: "c(current_date) " "  c(current_time);
		replace missing_`k' = 1 if missing(`k');
			di "PROGRESS:: MISSING `k' FORMATTED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		replace anymissing = 1 if anymissing == 0 & missing_`k' == 1;
			di "PROGRESS:: ANYTHING MISSING POPULATED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		};



	/* generate dummy for headcount (firm has n=<cutoff) at all locations*/
	local headcuts 00 01 10 25 50 100 150 200 250 300 400 500;
	foreach h in `headcuts'{;
		gen headcut_tot_`h' = .;
			di "PROGRESS:: HEADCOUNT `h' MADE : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		replace headcut_tot_`h' = 0 if dempltot != . ;
			di "PROGRESS:: HEADCOUNT `h' FORMATTED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		replace headcut_tot_`h' = 1 if dempltot <= `h';
			di "PROGRESS:: HEADCOUNT `h' POPULATED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		label var headcut_tot_`h' "Firm has `h' employees or less at all locations";
			di "PROGRESS:: HEADCOUNT `h' LABELED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		};



	/*generate dummy for headcount cutoff (firm has n=<cutoff) at this location*/
	local headcuts 00 01 10 25 50 100 150 200 250 300 400 500;
	foreach h in `headcuts'{;
		gen headcut_her_`h' = .;
			di "PROGRESS:: HEADCOUNT `h' MADE : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		replace headcut_her_`h' = 0 if demplher != . ;
			di "PROGRESS:: HEADCOUNT `h' FORMATTED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		replace headcut_her_`h' = 1 if demplher <= `h';
			di "PROGRESS:: HEADCOUNT `h' POPULATED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		label var headcut_her_`h' "Firm has `h' employees or less at this location";
			di "PROGRESS:: HEADCOUNT `h' LABELED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		};


		
	/*generate dummy for revenues cutoff (firm has rev=<cutoff) -----------*/
	local revcuts 000000 100000 300000 325000 500000 1000000;
	foreach r in `revcuts'{;
		gen revcut_`r' = .;
			di "PROGRESS:: REVCOUNT `h' MADE : " ;
			di "TIME:: "c(current_date) " "  c(current_time);	
		replace revcut_`r' = 0 if dsalesvo != . ;
			di "PROGRESS:: REVCOUNT `h' FORMATTED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);	
		replace revcut_`r' = 1 if dsalesvo <= `r';
			di "PROGRESS:: REVCOUNT `h' POPULATED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);	
		label var revcut_`r' "Firm has `r' USD in revenues or less";
			di "PROGRESS:: REVCOUNT `h' LABELED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);	
		};



	/* generate decile variables -----------------------------------------*/
	local paramvars "age dsalesvo dempltot demplher dyrstart";
	foreach p in `paramvars'{;
		xtile `p'_decile = `p', nq(10);
			di "PROGRESS:: DECILE `p' POPULATED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
		tostring `p'_decile, replace;
			di "PROGRESS:: HEADCOUNT `p' FORMATTED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);	
		};



	/* clean up macros ----------------------------------------------------*/
	ma drop _paramvars;
	ma drop _headcuts;
	ma drop _revcuts;
	ma drop _impvars;
	ma drop _datayear;



	/* save off .dta file with new transformed data ----------------------*/
	save "`i'.dta", replace;

			di "PROGRESS:: UPDATED FILE `i' SAVED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);

			
			
			
	/* close logs --------------------------------------------------------*/
	cd ../logs;
	display "END:: DESTRING VARIABLES IN `i' : " ;
	di "TIME:: "c(current_date) " "  c(current_time);
	log close;
	cd ../;
	local ++thisfilenum;
	};


	
/* clean up macro to avoid contamination of other programs in this session */
ma drop thisfilenum;



/***************************************************************************/
/* END:: ADD TRANSFORM VARIABLES                                           */
/***************************************************************************/
