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
/* Code Purpose : 		After my initialization code produces a panel 	   */
/*							dataset, this program is going to match the	   */
/*							observations within to the b corp list		   */
/*																		   */
/*																		   */
/* Data Input : 		panel_full.dta									   */
/*							known_benefir_corps.dta						   */
/*																		   */
/* Comments: 			This file is made to comply with the standards of  */
/*							the UMN Mesabi Supercomputer				   */
/*																		   */
/*																		   */
/* Requirements:		preformatted list, INITIALIZATION, 	               */
/*                                                                         */
/***************************************************************************/




/***************************************************************************/
/* BEGIN MERGING B LABS CROSSWALK DATA WITH DUN AND BRADSTREET PANEL      */
/***************************************************************************/



/* GENERATE LOG FILE ------------------------------------------------------*/
cd ./logs;
log using "log.merge.crosswalk.smcl", replace;
di "START:: MERGING DUN AND BRADSTREET WITH B LABS: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../ ;



/* delete me
local filename "overall_data.xlsx";
local sheetname "knownlist";*/
local knownname "known_benefit_corps";
local panelname "panel_full";
local outputname "merged_set";


/* MERGE -----------------------------------------------------------------*/

cd ./data;
di "BEGIN MERGE TIME:: " c(current_date) " "  c(current_time);
use "`panelname'.dta", clear;
merge m:1 dcomp using "`knownname'.dta" ;
di "END MERGE TIME:: " c(current_date) " "  c(current_time);
rename _merge crosswalk_status;


/* NOTE IF STATES ARE DIFFERENT BETWEEN RECORDS ---------------------------*/
gen stateabdiff = .;
replace stateabdiff = 0 if state == dstateab;
replace stateabdiff = 1 if state != dstateab;


save "`outputname'.dta", replace;




/* CLOSE LOG --------------------------------------------------------------*/
cd ../logs;
di "END::  MERGING DUN AND BRADSTREET WITH B LABS: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;

cd ../;


/***************************************************************************/
/* END MERGIND B LABS CROSSWALK DATA WITH DUN AND BRADSTREET PANEL         */
/***************************************************************************/



exit, clear STATA;

