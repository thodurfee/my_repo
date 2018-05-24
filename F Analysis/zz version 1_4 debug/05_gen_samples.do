#delimit ;
version 13;
/* set trace, set more , defined in 00_syp_master_format */




/*****************************************************************/
/*
 Meta Data 
 Code Version :		1.3 BETA
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	2018/02/08
 Last Test : 		2018/02/03 04:57 PM
 Last Addition : 	2018/02/13
 Code Environment:	INITIALIZATION
 
 Code Purpose : 	This is intended to generate a new .dta file of Dun
						and Bradstreet data that is a 1% sample of the original
						
 Data Input : 		File.data.name.dta
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case esensitive
						
					The Stata Command "sample" will not be efficient
						because STATA wants to load the entire dataset
						into RAM in order to derive a sample
					By generating a variable with a random distribution
						and deleting observations beyond that variable's
						threshold, STATA can process this command one
						observation at a time, putting less stress on 
						your machine
*/
/*****************************************************************/



/***************************************************************************/
/* START:: GENERATE SAMPLE                                                 */
/***************************************************************************/



/* generate an incrementor for tracking progress --------------------------*/
local thisfilenum = 1;
local sample_share = 0.001;

	
foreach i in $filenames{;



	/* initialize log files ----------------------------------------------*/
	cd ./logs;
	log using "log.point.one.perc.sample.`i'.smcl", replace;
	pwd;
	cd ../data;
	display "START:: GENERATING ZERO POINT ONE PERCENT SAMPLE" ; 
	display "FILE:: `i' : " ;
	di "TIME:: "c(current_date) " "  c(current_time);
	display "Files Sampled :  `thisfilenum'  out of  $filenums";



	/* load data for sampling --------------------------------------------*/
	use "`i'.dta", clear;

			di "`i' LOADED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);

	/* sample*/
	gen samplevar = runiform();
			di "SAMPLE VAR GENERATED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
	
	keep if samplevar <= `sample_share';
			di "SUBSAMPLE GENERATED : " ;
			di "TIME:: "c(current_date) " "  c(current_time);
	
	drop samplevar;
	cd ../samples;
	save "sample.`i'.dta", replace;

		di "NEW SAMPLE `i' SAVED : " ;
		di "TIME:: "c(current_date) " "  c(current_time);

	/* close logs --------------------------------------------------------*/
	cd ../logs;
	display "END:: GENERATING `sample_share' SHARE SAMPLE OF `i' : " c(current_date) " "    c(current_time);
	log close;
	cd ../;
	local ++thisfilenum;
	};
	
	
	
log close;	
ma drop thisfilenum;



/***************************************************************************/
/* END:: GENERATE SAMPLE                                                   */
/***************************************************************************/
