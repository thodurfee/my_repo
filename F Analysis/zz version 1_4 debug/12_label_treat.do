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
log using "log.rename.treat.smcl", replace;
di "START:: here: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../ ;


/* CHANGE VARIABLE NAMES --------------------------------------------------*/
local dataname "panel_post";


cd ./data;
use "`dataname'", clear;


di "TIME AFTER DATA LOAD:: " c(current_date) " "  c(current_time);




lab def trt 0 "Classic Corporation" 1 "Benefit Coproration" ;
lab val list_knownlist trt;


di "TIME AFTER DATA MANIPULATE:: " c(current_date) " "  c(current_time);



save "`dataname'.dta", replace;


/* CLOSE LOG --------------------------------------------------------------*/
cd ../logs;
di "END::  here: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;

cd ../;


/***************************************************************************/
/* END REANMING VARIABLES                                                  */
/***************************************************************************/

exit, clear STATA;
