#delimit ;
version 13;
set trace on;
set more off;
pwd;
ls;


/***************************************************************************/
/* Meta Data                                                               */
/*																		   */
/* Code Version :		1.3 BETA  										   */
/* STATA Version :		Stata 13 running in Unix Batch Mode				   */
/* Code Written By :	Thomas Durfee 									   */
/* Code Edited By : 	None 											   */
/* Last Success : 		NA												   */
/* Last Test : 			NA												   */
/* Last Addition : 		2018/02/13										   */
/* Code Environment:	CROSSWALK										   */
/* 																		   */
/* Code Purpose : 		give panel data more sensible names				   */
/*																		   */
/*																		   */
/* Data Input : 		merged_set.dta									   */
/*																		   */
/* Comments: 			This file is made to comply with the standards of  */
/*							the UMN Mesabi Supercomputer				   */
/*																		   */
/*																		   */
/* Requirements:		preformatted list, 10__merge_crosswalk             */
/*                                                                         */
/***************************************************************************/



/***************************************************************************/
/* BEGIN RENAMING VARIABLES                                                */
/***************************************************************************/


/* GENERATE LOG FILE ------------------------------------------------------*/
cd ./logs;
log using "log.rename.vars.smcl", replace;
di "START:: MERGING DUN AND BRADSTREET WITH B LABS: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../ ;


/* CHANGE VARIABLE NAMES --------------------------------------------------*/
local dataname "panel_post";


cd ./data;
use "`dataname'", clear;


di "TIME AFTER DATA LOAD:: " c(current_date) " "  c(current_time);

destring state_code, replace;
egen sicyear = group(sic_1 year state_code);
bysort sicyear: egen sicmean = mean(sales);
bysort sicyear: egen sicsd = sd(sales) ; 





gen saleslog = log(sales);
bysort sicyear: egen sicmeanlog = mean(saleslog);
bysort sicyear: egen sicsdlog = sd(saleslog) ; 




gen empltotlogsqr = dempltotlog^2;
gen agelog = log(age) ; 
gen emp_total_log = log(emp_total);
gen agelogsqr = agelog^2 ; 
gen ageempl = age * emp_total;
gen ageempllog = agelog * emp_total_log;

drop if duns == "";
destring sic_1, replace ; 
/*duns already destringed as "uid" */
/*destring duns, replace ; */
destring state_code, replace;
destring *_decile, replace;

compress;


save "`dataname'.dta", replace;

cd ../;

log close;

exit, clear STATA;

