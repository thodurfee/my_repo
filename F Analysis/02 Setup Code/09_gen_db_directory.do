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
/*							dataset, this program is going to generate a   */
/*							directory of firms in the Dun and Bradstreet   */
/*							panel list so I can have a smaller file with   */
/*							just names to match on. hopefully this will    */
/*							use less resources							   */
/*																		   */
/*																		   */
/* Data Input : 		panel_full.dta									   */
/*																		   */
/* Comments: 			This file is made to comply with the standards of  */
/*							the UMN Mesabi Supercomputer				   */
/*																		   */
/*																		   */
/* Requirements:		preformatted list, INITIALIZATION                  */
/*                                                                         */
/***************************************************************************/



/***************************************************************************/
/* BEGIN GENERATING DUN AND BRADSTREET DIRECTORY                           */
/***************************************************************************/



/* GENERATE LOG FILE ------------------------------------------------------*/
cd ./logs;
log using "log.gen.db.directory.smcl", replace;
di "START:: GENERATING DUN AND BRADSTREET DIRECTORY: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../ ;


local panelname "panel_full";
local outputname "db_directory";


cd ./data;

use "`panelname'.dta" , clear ; 

keep dun dcomp dstateab dprimsi;
/* following not included: dzip5 dcity dtrade */
di "TIME:: " c(current_date) " "  c(current_time);
save "`outputname'", replace;



/* CLOSE LOG --------------------------------------------------------------*/
cd ../logs;
di "END:: GENERATING DUN AND BRADSTREET DIRECTORY: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;

cd ../;


/***************************************************************************/
/* END GENERATING DUN AND BRADSTREET DATA DIRECTORY                        */
/***************************************************************************/


exit, clear STATA;
