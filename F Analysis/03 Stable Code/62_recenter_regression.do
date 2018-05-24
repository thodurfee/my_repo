#delimit ;
version 13;
*set trace on;
set more off;
pwd;
ls;


/***************************************************************************/
/* Meta Data                                                               */
/*																		   */
/* Code Version :		1.0 ALPHA 										   */
/* STATA Version :		Stata 13 running in Unix Batch Mode				   */
/* Code Written By :	Thomas Durfee 									   */
/* Code Edited By : 	None 											   */
/* Last Success : 		NA												   */
/* Last Test : 			NA												   */
/* Last Addition : 		NA												   */
/* Code Environment:	SPLICING										   */
/* 																		   */
/* Code Purpose : 		After my initialization code produces a panel 	   */
/*							dataset, this program is going to match the	   */
/*							observations within to the b corp list		   */
/*																		   */
/*						This is supposed to be a one program call		   */
/*							so that a Unix batch code for Mesabi can 	   */
/*							be a simple single line, rather than force	   */
/*							the user to learn Unix to run multiple batches */
/*																		   */
/* Data Input : 		panel_01.dta									   */
/*																		   */
/* Comments: 			This file is made to comply with the standards of  */
/*							the UMN Mesabi Supercomputer				   */
/*																		   */
/*																		   */
/* Requirements:		preformatted list	                               */
/*                                                                         */
/***************************************************************************/

/*this starts from inside ./dbresearch/analysis/analysisfiles*/


/* recentering treatment year like Neumark */

/* GENERATE LOG FILE ------------------------------------------------------*/
cd ../../ ;
cd ./logs;
log using "log.regression.smcl", replace;
di "START:: REGRESSION: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../data ;





/* make sure that I have matched my sic codes */


local dataname "merged_set";
local demo_controls_ols "dempltot demplototsqr ";
local time_controls_ols "age agesqr dyrstart dyrstartsqr";
 /*local treatment "certified_b_corp";*/
local treatment "list_knownlist";
local y "dsalesvo";
local lny "dsalesvolog";



use "`dataname'.dta", clear;
ssc install reghdfe ; 
ssc install synth;
ssc install oaxaca ; 
cd ../analysis/analysisfiles ; 

/* use this to simulate stuff for now */
drop if duns == "";
destring duns, replace ; 
destring dstateco, replace;

gen sales2011 = dsalesvo * 8/10 + runiform()*4000;
gen sales2012 = dsalesvo * 8/10 + runiform()*4500;
gen sales2013 = dsalesvo * 9/10 + runiform()*4000;
gen sales2014 = dsalesvo * 9/10 + runiform()*4500;
gen sales2015 = dsalesvo * 9/10 + runiform()*5000;
gen sales2016 = dsalesvo * 10/10 + runiform()*4000;
drop year;

reshape long sales, i(duns) j(year);

destring *_decile, replace;
replace `treatment' = 0;
replace `treatment' = 1 if uniform_decile == 1 & year >= 2014;
replace `treatment' = 1 if uniform_decile == 2 & year >= 2015;
replace `treatment' = 1 if uniform_decile == 3 & year >= 2016;
/*replace year = 2015 if normal_decile == 1;
replace year = 2014 if normal_decile == 2;
replace year = 2013 if normal_decile == 3;
replace year = 2012 if normal_decile == 4;*/

destring dprimsi, replace ; 


xtset duns year;


/*-----------------------------------------------------------*/
gen year2 = .;


sort year;
sort duns;
tempfile tmp ; 
bysort duns : gen tyear = min(year) if `treatment' == 1; 
bysort duns : replace year2 = year - tyear + 1 ;  



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


