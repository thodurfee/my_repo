#delimit ;
version 13;
/* set trace, set more , defined in 00_syp_master_format */

/***************************************************************************/
/*
 Meta Data 
 Code Version :		1.3 BETA  
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	2018/02/08
 Last Test : 		2018/02/03 ; 04:59 PM 
 Last Addition : 	2018/02/13
 Code Environment:	syp_master_format subsidiary
 
 Code Purpose : 	This is intended to print the contents of a directory
						while the Master Upload program is running
						This is intended for tracking purposes
						
 Data Input : 		File.data.name.TXT
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case esensitive
*/
/***************************************************************************/



/***************************************************************************/
/* START:: PRINT CONTENTS                                                  */
/***************************************************************************/





/* SHOW CONTENTS OF HOME DIRECTORY ----------------------------------------*/
pwd;
ls;



/* SHOW CONTENTS OF DATA DIRECTORY ----------------------------------------*/
cd ./data;
pwd;
ls;
cd ../;



/* SHOW CONTENTS OF LOGS DIRECTORY ----------------------------------------*/
cd ./logs;
pwd;
ls;
cd ../;



/* SHOW CONTENTS OF ORIGINAL DATA DIRECTORY --------------------------------*/
cd ./originals;
pwd;
ls;
cd ../;



/* SHOW CONTENTS OF SUBSAMPLE DIRECTORY ------------------------------------*/
cd ./samples;
pwd;
ls;
cd ../;



/***************************************************************************/
/* END:: PRINT CONTENTS                                                    */
/***************************************************************************/
