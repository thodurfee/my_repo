#delimit ;
version 13;
/* set trace, set more , defined in 00_syp_master_format */



/***************************************************************************/
/*
 Meta Data 
 Code Version :		1.3 BETA  
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	2018/02/04
 Last Test : 		2018/02/08
 Last Addition : 	2018/02/13
 Code Environment:	INITIALIZATION
 
 Code Purpose : 	This code is intended to take the already formated data
						from Dun and Bradstreet, in cross sectional form,
						and merge these files into panel data format
						
					This is supposed to be a one program call
						so that a Unix batch code for Mesabi can 
						be a simple single line, rather than force
						the user to learn Unix to run multiple batches
						
 Data Input : 		File.data.name.TXT
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case esensitive
						
						

*/
/***************************************************************************/

/***************************************************************************/
/* START:: MERGE YEARS                                                     */
/***************************************************************************/

clear;
global panelname "panel_full";


/* OPEN LOGS --------------------------------------------------------------*/
cd ./logs;
log using "log.merge.years.smcl", replace;
di "START:: MERGING FILES: " ;
di "TIME:: " c(current_date) " "  c(current_time);




/* MERGE DATA INTO PANEL FORMAT -------------------------------------------*/
cd ../data ; 

gen duns = "" ;
gen year = . ; 

foreach j in $filenames{;
	di "`j'";
	append using "`j'.dta" ;
};





destring duns, generate(uid);
xtset uid year, yearly;
di "SAVING PANEL DATA";
save "$panelname.dta", replace;
di "SAVE PANEL DATA COMPLETE";




/* CLOSE LOGS -------------------------------------------------------------*/
cd ../logs;
di "END::  MERGING FILES : " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;
cd ../;

/***************************************************************************/
/* END:: MERGE YEARS                                                       */
/***************************************************************************/
