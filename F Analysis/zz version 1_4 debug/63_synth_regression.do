/* cells for synth */

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


egen synthcells = group(i.dprimsi i.dstateco i.year i.dempltot_decile i.age_decile);
replace synthcells = 0 if `treatment' == 1;


gen year2 = . ; 
sort year;
sort duns;
/*tempfile tmp ; */
bysort duns : gen tyear = min(year) if `treatment' == 1; 
bysort duns : replace year2 = year - tyear + 1 if `treatment' == 1;  







di "synthrunner";
synth `y' `demo_controls' i.dprimsi i.encodestate, trunit(`treatment') trperiod(2015);
