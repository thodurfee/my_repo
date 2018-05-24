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




/* GENERATE LOG FILE ------------------------------------------------------*/
/*cd ../../ ;*/
cd ./logs;
log using "log.basic.reg.smcl", replace;
di "START:: REGRESSION: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../data ;




/* with new naming convention */
local dataname "panel_post";
local demo_controls "emp_total emp_total_sqr ";
local time_controls "age agesqr";
local ln_demo_controls "dempltotlog empltotlogsqr";
local ln_time_controls "agelog agelogsqr";
local crossp "ageempl" ; 
local ln_crossp "ageempllog" ; 
 /*local treatment "certified_b_corp";*/
local treatment "list_knownlist";
local y "sales";
local lny "saleslog";
local industry "sic_1";
local geography "state_code";
local factor_deciles "i.age_decile i.emp_total_decile";

/*
/*without new naming convention */
local dataname "panel_01";
local demo_controls "dempltot dempltotsqr ";
local time_controls "age agesqr";
local ln_demo_controls "dempltotlog";
local ln_time_controls " ";
local crossp "" ; 
local ln_crossp "" ; 
local treatment "list_knownlist";
local y "dsalesvo";
local lny "dsalesvolog";
local industry "sic_1";
local geography "state_code";
local factor_deciles "i.age_decile i.emp_total_decile";*/
/* /without */






use "`dataname'.dta", clear;
ssc install reghdfe ; 
/*ssc install synth;*/
ssc install oaxaca ; 
cd ../;





/* make sure that I have matched my sic codes */
/*gen dempltotlogsqr = dempltotlog^2;
gen agelog = log(age) ; 
gen agelogsqr = agelog^2 ; 
gen ageempl = age * dempltot;
gen ageempllog = agelog * dempltotlog;
*/



/**********************************************************/


/* use this to simulate stuff for now */
local treatment "list_knownlist";
/*drop if duns == "";
destring duns, replace ; 
destring dstateco, replace;
*/


/* with nameing conventions */

gen revenue2011 = sales * 8/10 + runiform()*4000;
gen revenue2012 = sales * 8/10 + runiform()*4500;
gen revenue2013 = sales * 9/10 + runiform()*4000;
gen revenue2014 = sales * 9/10 + runiform()*4500;
gen revenue2015 = sales * 9/10 + runiform()*5000;
gen revenue2016 = sales * 10/10 + runiform()*4000;
drop year;



/*
/*without new naming conventions */
gen revenue2011 = dsalesvo * 8/10 + runiform()*4000;
gen revenue2012 = dsalesvo * 8/10 + runiform()*4500;
gen revenue2013 = dsalesvo * 9/10 + runiform()*4000;
gen revenue2014 = dsalesvo * 9/10 + runiform()*4500;
gen revenue2015 = dsalesvo * 9/10 + runiform()*5000;
gen revenue2016 = dsalesvo * 10/10 + runiform()*4000;
drop year;
gen `treatment' = 0 ;*/
/*destring duns, gen(uid);*/
destring *_decile, replace;
/*end without new naming conventions */
gen uid = duns;
drop if uid == .;
format uid %10.0g;



reshape long revenue, i(duns) j(year);
replace sales = revenue;
/*replace dsalesvo = revenue;*/
drop revenue;

replace `treatment' = 0;
replace `treatment' = 1 if uniform_decile == 1 & year >= 2014;
replace `treatment' = 1 if uniform_decile == 2 & year >= 2015;
replace `treatment' = 1 if uniform_decile == 3 & year >= 2016;

/*destring dprimsi, replace ; */









xtset duns year;
/**************************************************************/

/* generate interesting controls ----- */

local constructs "sicmean sicsd";
local constructslog "sicmeanlog sicsdlog";



/* prepare manski bounds wrapper */
/*do 50_manski_treat ; */


/*************************************************************/
* descriptive statistics
di "meands and standard deviations" ; 
sdtest `y', by(`treatment');
ttest `y', by(`treatment') unequal;

sdtest `lny', by(`treatment');
ttest `lny', by(`treatment') unequal;


sum `treatment', d;
di " ";
di " ";

sum `y', d ; 
di " ";
di " ";

sum `lny', d;
di " ";
di " ";

sum age , d;
di " ";
di " ";

sum emp_total ,d ;
di " ";
di " ";

sum state3 ;
di " ";
di " ";


di " ";
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";



* OLS
di "OLS regressions ------------------------------------------";
di "`y' `treatment' `demo_controls' `time_controls' `crossp'";
regress `y' `treatment' `demo_controls' `time_controls' `crossp';

di " ";
di " ";

regress `lny' `treatment' `ln_demo_controls' `ln_time_controls' `ln_crossp';

di " ";
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";

* State FE
* i need to encode before hand
*regress `y' `treatment' `demo_controls' `time_controls' i.encodestate ;



*state and time FE
*regress `y' `treatment' `demo_controls' i.year i.encodestate ;


*regress `y' `treatment' i.dempltot_decile i.age_decile ; 
*regress `y' `treatment' i.dempltot_decile i.year ; 
di "FE regressions ------------------------------------------";
di "reghdfe `y' `treatment' `demo_controls' `time_controls' `crossp', absorb(i.year i.`industry') fast";
reghdfe `y' `treatment' `demo_controls' `time_controls' `crossp', absorb(i.year i.`industry') fast ; 

di " ";
di " ";

di "log sales";
di "reghdfe `lny' `treatment' `ln_demo_controls' `ln_time_controls' `ln_crossp', absorb(i.year i.`industry') fast";
reghdfe `lny' `treatment' `ln_demo_controls' `ln_time_controls' `ln_crossp', absorb(i.year i.`industry') fast ; 


di " ";
di " ";


di "size and age FE ";
di "reghdfe `y' `treatment' , absorb(`factor_deciles' i.year i.`industry') fast ";
reghdfe `y' `treatment' , absorb(`factor_deciles' i.year i.`industry') fast ; 




di " ";
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";

/* DID---------*/
di "DID regressions ------------------------------------------";
di "sales";
di "reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry')";
reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry');

di " ";
di " ";

di"log sales";
di "reghdfe `lny' `treatment', absorb(i.duns i.year ) cluster(i.`geography')";
reghdfe `lny' `treatment', absorb(i.duns i.year ) cluster(i.`geography');

di " ";
di " ";

di "sales";
di "reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry')";
reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry');

di " ";
di " ";

di"log sales";
di "reghdfe `lny' `treatment', absorb(i.duns i.year) cluster(i.`industry')";
reghdfe `lny' `treatment', absorb(i.duns i.year) cluster(i.`industry');

di " ";
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";

/* Oaxaca ---- */
di "Oaxaca regressions ------------------------------------------";
di "noisily oaxaca `y' `demo_controls' `time_controls' `crossp' `constructs', by(`treatment') relax";
noisily oaxaca `y' `demo_controls' `time_controls' `crossp' `constructs', by(`treatment') relax;

di " ";
di " ";

di "noisily oaxaca `lny' `ln_demo_controls' `ln_time_controls' `lncrossp' `constructslog', by(`treatment') relax";
noisily oaxaca `lny' `ln_demo_controls' `ln_time_controls' `lncrossp' `constructslog', by(`treatment') relax;

di " ";
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";

/* note, I have so many observations, one of these days, I should use percentiles instead of deciles, but first I need to finish */
/*
/* CLOSE LOG --------------------------------------------------------------*/

cd ./logs;
di "END:: REGRESSION: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;

cd ../;


/***************************************************************************/
/* END SAMPLE PANEL DATA                                                   */
/***************************************************************************/
exit, clear STATA;*/
