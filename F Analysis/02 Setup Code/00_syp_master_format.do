#delimit ;
version 13;
set more off;
pwd;
ls;
set trace on;
global noise_state = "noisily";

/***************************************************************************/
/*
 Meta Data 
 Code Version :		1.3 BETA  
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	2018/02/08
 Last Test : 		2018/02/08
 Last Addition : 	2018/02/13
 Code Environment:	INITIALIZATION
 
 Code Purpose : 	This is intended to be the overarching program
						that converts Dun and Bradstreet .TXT data
						into a STATA usable format
						
					This is supposed to be a one program call
						so that a Unix batch code for Mesabi can 
						be a simple single line, rather than force
						the user to learn Unix to run multiple batches
						
 Data Input : 		*.*.TXT
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case esensitive
						
					TESTING A NEW VERSION OF THE INFIX FUNCTION
						IF SUCCESSFUL, I CAN GET RID OF THE DESTRING GROUP
						
 Requirements:		01_print_contents.do
					02_load_filenames.do
					03_load_data.do
					04_transform_data.do
					05_gen_samples.do
					06_merge_years.do
 

*/
/***************************************************************************/



/***************************************************************************/
/* START:: MASTER FORMAT VERSION                                           */
/***************************************************************************/




/* define desired noise: {noisily, quietly} -------------------------------*/          
capture program drop myrun;
program myrun;
	if("$noise_state" == "noisily"){;
		noisily do "`1'", nostop;
		};
	if("$noise_state" == "quietly", nostop){;
		quietly do "`1'";
		};
	end;
	



                                     
/* load file names of files to be converted -------------------------------*/                   
myrun "01_print_contents";
myrun "02_load_filenames";




/* convert file from txt to dta format ------------------------------------*/
myrun "01_print_contents";
myrun "03_load_data";




/* add transformed variables ----------------------------------------------*/

myrun "01_print_contents";
myrun "04_transform_data";




/* generate samples of data -----------------------------------------------*/

myrun "01_print_contents";
myrun "05_gen_samples";




/* merge years of data into a single panel --------------------------------*/
myrun "01_print_contents";
myrun "06_merge_years";




/* print contents again --------------------------------------------------*/

myrun "01_print_contents";




/* clean up after this master format program -----------------------------*/
capture program drop myrun;
set more on;
set trace off;
exit, clear;



/***************************************************************************/
/* END:: MASTER FORMAT VERSION                                             */
/***************************************************************************/
