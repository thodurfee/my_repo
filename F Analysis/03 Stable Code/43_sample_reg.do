#delimit ;
version 13;
*set trace on;
set more off;
pwd;
ls;
clear;


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

global datadir "H:\second year paper research\second_year_paper\12 sandbox code\pseudomesabi\2018 03 01\dbresearch\";
cd "$datadir";
/*global codepath "H:\second year paper research\second_year_paper\12 sandbox code\Version 1.4";*/


/* with new naming convention */
local dataname "sample_panel";
local demo_controls "emp_total emp_total_sqr ";
local time_controls "age agesqr";
local ln_demo_controls "dempltotlog empltotlogsqr";
local ln_time_controls "agelog agelogsqr";
local crossp "ageempl" ; 
local ln_crossp "ageempllog" ; 
local treatment "list_knownlist";
local y "sales";
local lny "saleslog";
local industry "sic_1";
local geography "state_code";
local factor_deciles "i.age_decile i.emp_total_decile";








/* GENERATE LOG FILE ------------------------------------------------------*/
cd ./logs ;
log using "log.basic.sample.reg.smcl", replace;
di "START:: REGRESSION: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../data ;



use "`dataname'.dta", clear;
/*ssc install reghdfe ; 
ssc install oaxaca ; */
cd ../;


/* only next line run once*/
do "$codepath\44_rename_and_add_sample" ; 
save "`dataname'.dta", replace;



/* generate interesting controls ----- */

local constructs "sicmean sicsd";
local constructslog "sicmeanlog sicsdlog";





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
di "Model A pre";
regress `y' `treatment' `demo_controls' `time_controls' `crossp';

di " ";
di " ";


di "Model B pre";
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
di "Model C pre";
reghdfe `y' `treatment' `demo_controls' `time_controls' `crossp', absorb(i.year i.`industry') fast ; 

di " ";
di " ";

di "log sales";
di "reghdfe `lny' `treatment' `ln_demo_controls' `ln_time_controls' `ln_crossp', absorb(i.year i.`industry') fast";
di "Model D pre";
reghdfe `lny' `treatment' `ln_demo_controls' `ln_time_controls' `ln_crossp', absorb(i.year i.`industry') fast ; 


di " ";
di " ";


di "size and age FE ";
di "reghdfe `y' `treatment' , absorb(`factor_deciles' i.year i.`industry') fast ";
di "Model E pre";
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
di "Model F pre";
di "reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry')";
reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry');

di " ";
di " ";

di"log sales";
di "reghdfe `lny' `treatment', absorb(i.duns i.year ) cluster(i.`geography')";
di "Model G pre";
reghdfe `lny' `treatment', absorb(i.duns i.year ) cluster(i.`industry');

di " ";
di " ";

di "sales";
di "reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`geography')";
di "Model H pre";
reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`geography');

di " ";
di " ";

di"log sales";
di "reghdfe `lny' `treatment', absorb(i.duns i.year) cluster(i.`geography')";
di "Model I pre";
reghdfe `lny' `treatment', absorb(i.duns i.year) cluster(i.`geography');

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
di "Model J pre";
noisily oaxaca `y' `demo_controls' `time_controls' `crossp' `constructs', by(`treatment') relax;

di " ";
di " ";
/*  not enough observations in sub sample*/
di "noisily oaxaca `lny' `ln_demo_controls' `ln_time_controls' `lncrossp' `constructslog', by(`treatment') relax";
di "Model K pre";
/*noisily oaxaca `lny' `ln_demo_controls' `ln_time_controls' `lncrossp' `constructslog', by(`treatment') relax;*/
*/
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";



/* prepare manski bounds wrapper */
do "$codepath\50_manski_treat" ; 

/*other end of Manski Wrapper */




* OLS
di "OLS regressions ------------------------------------------";
di "`y' `treatment' `demo_controls' `time_controls' `crossp'";
di "Model A post";
regress `y' `treatment' `demo_controls' `time_controls' `crossp';

di " ";
di " ";


di "Model B post";
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
di "Model C post";
reghdfe `y' `treatment' `demo_controls' `time_controls' `crossp', absorb(i.year i.`industry') fast ; 

di " ";
di " ";

di "log sales";
di "reghdfe `lny' `treatment' `ln_demo_controls' `ln_time_controls' `ln_crossp', absorb(i.year i.`industry') fast";
di "Model D post";
reghdfe `lny' `treatment' `ln_demo_controls' `ln_time_controls' `ln_crossp', absorb(i.year i.`industry') fast ; 


di " ";
di " ";


di "size and age FE ";
di "reghdfe `y' `treatment' , absorb(`factor_deciles' i.year i.`industry') fast ";
di "Model E post";
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
di "Model F post";
di "reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry')";
reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry');

di " ";
di " ";

di"log sales";
di "reghdfe `lny' `treatment', absorb(i.duns i.year ) cluster(i.`geography')";
di "Model G post";
reghdfe `lny' `treatment', absorb(i.duns i.year ) cluster(i.`geography');

di " ";
di " ";

di "sales";
di "reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry')";
di "Model H post";
reghdfe `y' `treatment', absorb(i.duns i.year) cluster(i.`industry');

di " ";
di " ";

di"log sales";
di "reghdfe `lny' `treatment', absorb(i.duns i.year) cluster(i.`industry')";
di "Model I post";
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
di "Model J post";
noisily oaxaca `y' `demo_controls' `time_controls' `crossp' `constructs', by(`treatment') relax;

di " ";
di " ";
/*  not enough observations in sub sample*/
di "noisily oaxaca `lny' `ln_demo_controls' `ln_time_controls' `lncrossp' `constructslog', by(`treatment') relax";
di "Model K post";
/*noisily oaxaca `lny' `ln_demo_controls' `ln_time_controls' `lncrossp' `constructslog', by(`treatment') relax;*/
*/
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";
di " ";



log close ; 

