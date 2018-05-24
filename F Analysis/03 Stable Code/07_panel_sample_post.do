#delimit ; 
version 13 ; 
set trace on ;
set more off ;
pwd;
ls;



/***************************************************************************/
/*
 Meta Data 
 Code Version :		1.3 BETA  
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	NA
 Last Test : 		2018/02/12
 Last Addition : 	2018/02/13
 Code Environment:	SAMPLE DATA FILES
 
 Code Purpose : 	This code is intended to take the already formated data
						from Dun and Bradstreet, in panel form and sample
						some of these observations. Unique entities
						are randomly sampled and their historical panel
						outcomes are preserved in the sample
						
						
 Data Input : 		File.data.name.TXT
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case esensitive
						
						
						

*/
/***************************************************************************/


/***************************************************************************/
/* BEGIN SAMPLE PANEL DATA                                                 */
/***************************************************************************/



/* GENERATE LOG FILE ------------------------------------------------------*/
cd ./logs;
log using "log.panel.sample.smcl", replace;
di "START:: MERGING FILES: " ;
di "TIME:: " c(current_date) " "  c(current_time);




/*-------------------------------------------------------------------------*/
/* WARNING: IF YOU RUN THIS AFTER THE CROSSWALK MERGE, YOU NEED TO DROP    */
/*			_MERGE FROM THE ORIGINAL LIST								   */
/*-------------------------------------------------------------------------*/

local paneldata "panel_post";
local uid "duns";
local samplename "panel_subsample";
local sampleperc 0.01;
/* note: sample percentage is an actual percentage, so 1 = 1%, 
0.01 = 0.01% etc...*/




/* SUBSAMPLE DATA ---------------------------------------------------------*/
cd ../data ; 

use "`paneldata'.dta";

sort `uid' ; 
preserve ; 
tempfile tmp ; 
bysort `uid': keep if _n == 1 ; 
di "SAMPLE BEGIN TIME:: " c(current_date) " "  c(current_time);
sample `sampleperc' ;
sort `uid' ;
save `tmp',replace ;
di "END SAMPLE TIME:: " c(current_date) " "  c(current_time);
restore ;
di "PANEL SAMPLE TIME:: " c(current_date) " "  c(current_time);
merge m:1 `uid' using `tmp' ;
di "END PANEL SAMPLE TIME:: " c(current_date) " "  c(current_time);
keep if _merge == 3 ;
drop _merge ;
save "`samplename'.dta", replace ; 



/* CLOSE LOG --------------------------------------------------------------*/
cd ../logs;
di "END::  SAMPLING FILES : " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;
cd ../;



/***************************************************************************/
/* END:: SAMPLE PANEL DATA                                                 */
/***************************************************************************/
exit, clear STATA;
