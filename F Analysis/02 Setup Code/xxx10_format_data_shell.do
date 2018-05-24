#delimit ;
version 13;
set more off;
pwd;
ls;
/*set trace on;*/
global noise_state = "noisily";

/***************************************************************************/
/*
 Meta Data 
 Code Version :		1.0 Version  
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	yyyy/mm/dd
 Last Test : 		yyyy/mm/dd
 Last Addition : 	yyyy/mm/dd
 Code Environment:	initialization
 
 Code Purpose : 	Lorem Ipsum
						
					Detailed description
									
 Requirements:		01_print_contents.do
					02_load_filenames.do
					03_load_data.do
					04_transform_data.do
					05_gen_samples.do
					06_merge_years.do
					
					Assumes my_project version 1.0 file structure
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case sensitive

 

*/
/***************************************************************************/



/***************************************************************************/
/* START:: MASTER FORMAT VERSION                                           */
/***************************************************************************/




/* define desired noise: {noisily, quietly, capture} ----------------------*/          
capture program drop myrun;
program myrun;
	if("$noise_state" == "noisily"){;
		noisily do "`1'", nostop;
		};
	if("$noise_state" == "quietly", nostop){;
		quietly do "`1'";
	if("$noise_state" == "capture", nostop){;
		capture "`1'";		
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
