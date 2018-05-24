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
di "START:: Renaming Vars: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../ ;


/* CHANGE VARIABLE NAMES --------------------------------------------------*/
local dataname "panel_post";



cd ./data;
use "`dataname'", clear;


di "TIME AFTER DATA LOAD:: " c(current_date) " "  c(current_time);


rename dcomp comp_name;
label var comp_name "FIRM NAME: OPERATIONAL";

rename dtrade comp_name_trade_as;
label var comp_name_trade_as "FIRM NAME: TRADED AS";

rename dstreet address;
label var address "STREET ADDRESS: OPERATIONAL";

rename dcity city;
label var city "CITY: OPERATIONAL";

rename dstateab state3;
label var state3 "STATE: OPERATIONAL";

rename dzip5 zipcode;
label var zipcode "ZIP CODE: OPERATIONAL";


drop dzip4ext;
/*rename dzip4ext zipcode_ext;
label var zipcode_ext "ZIP CODE EXTENTION: OPERATIONAL";*/

rename dmailadd address_mailing;
label var address_mailing "STREET ADDRESS: MAILING";

rename dmailcit city_mailing;
label var city_mailing "CITY: MAILING";

rename dmailzip zipcode_mailing;
label var zipcode_mailing "ZIP CODE: MAILING";


drop dmailzp4;
/*rename dmailzp4 zipcode_ext_mailing;
label var zipcode_ext_mailing "ZIP CODE EXTENTION: MAILING";*/

drop filler1;

rename dnatlcod nationality;
label var nationality "NATION OF ORIGIN";

rename dstateco state_code;
label var state_code "STATE CODE: LIKELY FIPS";

rename dcountyc county_code;
label var county_code "COUNTY CODE: LIKELY FIPS";

drop dtelepho;
drop dceoname;
drop dceotitt;

rename dsalesvo sales;
label var sales "ANNUAL SALES VOLUMN";

rename dslsvolc sales_flag;
label var sales_flag "DATA FLAG FOR ANNUAL SALES VOLUMN";

rename dempltot emp_total;
label var emp_total "EMPLOYEE COUNT: ENTITY WIDE";

rename demptotc emp_total_flag;
label var emp_total_flag "DATA FLAG FOR EMPLOYEE COUNT ENTITY WIDE";

rename demplher emp_here;
label var emp_here "EMPLOYEE COUNT THIS LOCATION";

rename demphrcd emp_here_flag;
label var emp_here_flag "DATA FLAG FOR EMPLOYEE COUNT THIS LOCATION";

rename dyrstart firm_birthyear;
label var firm_birthyear "YEAR OF FIRM ESTABLISHMENT";

rename dstatusi us_or_intl;
label var us_or_intl "IS THIS FIRM US BASED";

rename dsubsidi is_subsidiary;
label var is_subsidiary "IS THIS FIRM A SUBSIDIARY";

rename dmanufin is_manufac;
label var is_manufac "DOES THIS FIRM ENGAGRE IN MANUFACTURING";

rename dultdun duns_ultimate;
label var duns_ultimate "DUNS NUMBER ULTIMATE ORGANIZATION";

rename dhdqdun duns_headquarters;
label var duns_headquarters "DUNS NUMBER HEADQUARTERS";

rename dpardun duns_parent;
label var duns_parent "DUNS NUMBER PARENT ORGANIZATION";

rename dprhqct parent_city;
label var parent_city "PARENT ENTITY CITY";

rename dprhqst parent_state;
label var parent_state "PARENT ENTITY STATE";

drop filler3;
drop filler4;

rename dlinebu lob;
label var lob "LINE OF BUSINESS";

rename dprimsi sic_1;
label var sic_1 "STANDARD INDUSTRY CODES: PRIMARY";

rename dsic2 sic_2;
label var sic_2 "STANDARD INDUSTRY CODES: SECONDARY";

rename dsic3 sic_3;
label var sic_3 "STANDARD INDUSTRY CODES: TERCIARY";

rename dsic4 sic_4;
label var sic_4 "STANDARD INDUSTRY CODES: FOURTH";

rename dsic5 sic_5;
label var sic_5 "STANDARD INDUSTRY CODES: FIFTH";

rename dsic6 sic_6;
label var sic_6 "STANDARD INDUSTRY CODES: SIXTH";

rename dsalesvosqr sales_sqr;
label var sales_sqr "ANNUAL SALES VOLUMN SQUARED";

rename dempltotsqr emp_total_sqr;
label var emp_total_sqr "EMPLOYEE HEADCOUNT ENTITYWIDE SQUARED";

rename dyrstartsqr firm_birthyear_sqr;
label var firm_birthyear_sqr "YEAR OF FIRM ESTABLSIHMENT SQUARED";

rename dsalesvolog sales_log;
label var sales_log "NATURAL LOG OF ANNUAL SALES VOLUMN";

rename dyrstartlog firm_birthyear_log;
label var firm_birthyear_log "NATURAL LOG OF YEAR OF FIRM ESTABLISHMENT";

rename demplherlog emp_here_log;
label var emp_here_log "NATURAL LOG OF HEADCOUNT OF EMPLOYEES HERE";

rename dsalesvo_decile sales_decile;
label var sales_decile "ANNUAL SALES DECILE";

rename dempltot_decile emp_total_decile;
label var emp_total_decile "EMPLOYEE HEADCOUNT TOTAL DECILE";

rename demplher_decile emp_here_decile;
label var emp_here_decile "EMPLOYEE HEADCOUNT HERE DECILE";

rename dyrstart_decile firm_birthyear_decile;
label var firm_birthyear_decile "YEAR OF FIRM ESTABLISHMENT DECILE";


di "TIME AFTER DATA MANIPULATE:: " c(current_date) " "  c(current_time);



save "`dataname'.dta", replace;


/* CLOSE LOG --------------------------------------------------------------*/
cd ../logs;
di "END::  MERGING DUN AND BRADSTREET WITH B LABS: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;

cd ../;


/***************************************************************************/
/* END REANMING VARIABLES                                                  */
/***************************************************************************/

exit, clear STATA;

