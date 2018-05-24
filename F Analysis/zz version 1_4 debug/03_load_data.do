#delimit ;
version 13;
/* set trace, set more , defined in 00_syp_master_format */
/* $filenums assumed to be passed from 02_load_filenames */



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
 Code Environment:	INITIALIZATION
 
 Code Purpose : 	This is intended to reformat the Dun and Bradstreet
						.TXT file into a stata friendly .dta file
						
 Data Input : 		File.data.name.TXT
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					Make sure to capitalize .TXT, as the supercomputer
						is case sensitive
						
						

*/
/***************************************************************************/



/***************************************************************************/
/* START:: LOAD AS STRINGS 					                               */
/***************************************************************************/

local thisfilenum = 1;

di "the files to be loaded are: $filenames";


foreach i in $filenames{;



	/* initialize log files -----------------------------------------------*/
	cd ./logs;
	log using "log.load.as.strings.`i'.smcl", replace;
	cd ../originals;
	ls;
	display "START:: CONVERT TXT TO DTA";
	display "FILE:: `i'" ;
	display "TIME:: " c(current_date) " "  c(current_time);
	display  "Load Progress :  `thisfilenum'  out of  $filenums";



	/* reformat data from .TXT to .dta ------------------------------------*/
	infix 
		 str duns			1-9    
		 str dcomp			10-39    
		 str dtrade			40-69    
		 str dstreet		70-94    
		 str dcity			95-114    
		 str dstateab   	115-116    
		 str dzip5			117-121    
		 str dzip4ext		122-125    
		 str dmailadd		126-150    
		 str dmailcit		151-170    
		 str dmailsta		171-172    
		 str dmailzip		173-177    
		 str dmailzp4		178-181    
		 str dcarrrtc		182-185    
		 str filler1		186-187    
		 str dnatlcod    	188-190    
		 str dstateco    	191-192    
		 str dcountyc    	193-195    
		 str dcitycod    	196-199    
		 str dsmsacod    	200-202    
		 str dtelepho    	203-212    
		 str dceoname    	213-242    
		 str dceotitt    	243-272    
			 dsalesvo    	273-287    
			 dslsvolc    	288-288    
			 dempltot    	289-297    
			 demptotc    	298-298    
			 demplher    	299-307    
			 demphrcd    	308-308    
			 dyrstart    	309-312    
			 dstatusi    	313-313    
			 dsubsidi    	314-314    
			 dmanufin    	315-315    
		 str dultdun    	316-324    
		 str dhdqdun    	325-333    
		 str dpardun    	334-342    
		 str dprhqct    	343-362    
		 str dprhqst    	363-364    
		 str filler2    	365-372    
		 str filler3    	373-382    
		 str dhier    		383-384    
		 str ddias    		385-393    
			 dpoplcd   		394-394    
			 dtrancd   		395-395    
		 str drptdat    	396-401    
		 str filler4    	402-420    
		 str drcrdcl    	421-421    
		 str dlinebu    	422-440    
		 str dprimsi    	441-444    
		 str dsicext1    	445-448    
		 str dsicext2    	449-452    
		 str dsicext3    	453-456    
		 str dsicext4    	457-460    
		 str dsic2    		461-480    
		 str dsic3    		481-500    
		 str dsic4    		501-520    
		 str dsic5    		521-540    
		 str dsic6    		541-560    
		 using "`i'.TXT", clear;
		 
		 
		 
		 /* save off data in a new folder for storage ---------------------*/
		 cd ../data;
		 save "`i'.dta", replace;
		 
		 
		 
		 /* close logs ----------------------------------------------------*/
		 display "END:: CONVERT TXT TO DTA";
		 display "FILE:: `i' : ";
		 display "TIME:: " c(current_date) " "  c(current_time);
		 cd ../logs;
		 log close;
		 cd ../;
		 local ++thisfilenum;
		 };
		 
		 
		 
ma drop thisfilenum;



/***************************************************************************/
/* END :: LOAD AS STRINGS VERSION 1.1 BETA                                  */
/***************************************************************************/
