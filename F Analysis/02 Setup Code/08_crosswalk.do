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
/*							dataset, this program is going to generate     */
/*							a dta file of benefit corporations so a later  */
/*							program can match the observations within 	   */
/*							the Dun and Bradstreet list to the b corp list */
/*																		   */
/*																		   */
/* Data Input : 		overall_data.dta								   */
/*																		   */
/* Comments: 			This file is made to comply with the standards of  */
/*							the UMN Mesabi Supercomputer				   */
/*																		   */
/*																		   */
/* Requirements:		preformatted list, INITIALIZATION                  */
/*                                                                         */
/***************************************************************************/



/***************************************************************************/
/* BEGIN FORMATTING B LAB CROSSWALK FILE                                   */
/***************************************************************************/


/* GENERATE LOG FILE ------------------------------------------------------*/
cd ./logs;
log using "log.crosswalk.b.labs.smcl", replace;
di "START:: LOADING B LABS LIST: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../ ;



/* THIS PROGRAM ASSUMES THAT THE B LABS LIST IS ALREADY IN ./ORIGINALS*/
local filename "overall_data.xlsx"; /*BENEFIT CORPORATION LIST */
local sheetname "knownlist"; /* SHEET */
local outputname "known_benefit_corps";
local firmname_db "dcomp"; /*UID IN DUN AND BRADSTREET ENVIRONMENT */
local firmname_bl "name"; /*UID IN B LABS ENVIRONMENT */




cd ./originals; 
ls;
import excel "`filename'", sheet("`sheetname'") firstrow clear;
gen `firmname_db' = strupper(`firmname_bl');
cd ../;
cd ./data;
save "`outputname'.dta", replace ;



/* CLOSE LOG --------------------------------------------------------------*/
cd ../logs;
di "END:: LOADING B LABS LIST: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;

cd ../;


/***************************************************************************/
/* END SAMPLE PANEL DATA                                                   */
/***************************************************************************/

exit, clear STATA;
