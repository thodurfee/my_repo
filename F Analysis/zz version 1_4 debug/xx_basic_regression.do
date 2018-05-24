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


/* use this to simulate stuff for now */
local treatment "list_knownlist";
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

destring dprimsi, replace ; 

xtset duns year;



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


* descriptive statistics
sdtest `y', by(`treatment');
ttest `y', by(`treatment') unequal;

sdtest `lny', by(`treatment');
ttest `lny', by(`treatment') unequal;




* OLS
regress `y' `treatment' `demo_controls' ;
regress `lny' `treatment' `demo_controls' ;



* State FE
* i need to encode before hand
*regress `y' `treatment' `demo_controls' `time_controls' i.encodestate ;



*state and time FE
*regress `y' `treatment' `demo_controls' i.year i.encodestate ;


*regress `y' `treatment' i.dempltot_decile i.age_decile ; 
*regress `y' `treatment' i.dempltot_decile i.year ; 
di "sales";
reghdfe `y' `treatment' age dempltot dempltotsqr, absorb(i.year i.dprimsi) fast ; 

di "log sales";
reghdfe `lny' `treatment' age dempltot dempltotsqr, absorb(i.year i.dprimsi) fast ; 



/* DID---------*/
di "sales";
reghdfe `y' `treatment', absorb(i.duns i.year i.dprimsi) cluster(i.dprimsi);

di"log sales";
reghdfe `lny' `treatment', absorb(i.duns i.year) cluster(i.dprimsi);




/* CLOSE LOG --------------------------------------------------------------*/
cd ../../;
cd ./logs;
di "END:: REGRESSION: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;

cd ../analysis/analysisfiles;


/***************************************************************************/
/* END SAMPLE PANEL DATA                                                   */
/***************************************************************************/
exit, clear STATA;
