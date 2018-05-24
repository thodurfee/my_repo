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

/*this starts from inside ./dbresearch*/




/* GENERATE LOG FILE ------------------------------------------------------*/

cd ./logs;
log using "log.save.sub.smcl", replace;
di "START:: REGRESSION: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../data ;


local panelfile "panel_post";
local treatfile "panel_treated";
local treatment "list_knownlist";


use "`panelfile'.dta";
drop if `treatment' != 1 ;

save using "`treatfile'.dta" , replace;

log close;
cd ../;

exit, clear STATA;
