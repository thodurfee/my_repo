#delimit ; 
version 13;
*set trace on;
set more off;
pwd ; 
ls ; 



/***************************************************************************/
/* 
Debugging 1/n 

 Meta Data 
 Code Version :		1.3 CAPRICA  
 STATA Version :	Stata 13 running in Unix Batch Mode
 Code Written By :	Thomas Durfee 
 Code Edited By : 	None 
 Last Success : 	NA
 Last Test : 		NA
 Last Addition : 	2018/02/13
 Code Environment:	DEBUGGING
 
 Code Purpose : 	it is intended to check that the file that was created 
						is able to be merged into a panel structure and 
						that the constituent files are not corrupted
						
						
 Data Input : 		this program is used after the initialization phase
 
 Comments: 			This file is made to comply with the standards of
						the UMN Mesabi Supercomputer
						
					It is important to capitalize .TXT, as Unix 
						environments are case esensitive
						
						
						

*/
/***************************************************************************/


/***************************************************************************/
/* BEGIN DEBUG 1/N			                                               */
/***************************************************************************/

/* ASSUME WE BEGIN IN ./DBRESEARCH */
/* ASSUME WE ALREADY HAVE A FOLDRE CALLED ./DBRESEARCH/LOGS/DEBUGGING */







/* GATHER A LIST OF THE FILES TO BE CHECKED -------------------------------*/

cd ./data;
ls ;
cd ../ ; 

global filenames /*MGNTFIS3.EKD3YY1Z.DMI.1969 MGNTFIS3.VTPKYNFB.DMI.1970 MGNTFIS3.IXF54KAL.DMI.1971 MGNTFIS3.BA980LLT.DMI.1972 MGNTFIS3.CQ6C51GU.DMI.1973 MGNTFIS3.LIKQ5Z2G.DMI.1974 MGNTFIS3.O1P4R13L.DMI.1975 MGNTFIS3.K79MNWED.DMI.1976 MGNTFIS3.RXMNGLZ3.DMI.1977 MGNTFIS3.RZDDJHEF.DMI.1978 MGNTFIS3.DBSUYJJE.DMI.1979 MGNTFIS3.T7XZ29OG.DMI.1980 MGNTFIS3.NV7AHEZH.DMI.1982 MGNTFIS3.FBMPBZ6C.DMI.1983 MGNTFIS3.D9XT59OP.DMI.1985 MGNTFIS3.IALS03WT.DMI.1986 MGNTFIS3.X9GR27Z4.DMI.1987 MGNTFIS3.D6DV9BCL.DMI.1988 MGNTFIS3.ZXU1P5L5.DMI.1989 MGNTFIS3.I9Q5VOQI.DMI.1990 MGNTFIS3.AI8B5NQB.DMI.1991 MGNTFIS3.CB4FNOBL.DMI.1992 MGNTFIS3.U0BO1ZH9.DMI.1993 MGNTFIS3.F2W42Q1Q.DMI.1994 MGNTFIS3.TLBTN0EJ.DMI.1995 MGNTFIS3.MIYQYZSI.DMI.1996 MGNTFIS3.R0OOAY2D.DMI.1997 MGNTFIS3.TN66K2B5.DMI.1998 MGNTFIS3.NTPEE3UB.DMI.1999 MGNTFIS3.KNQ59DSC.DMI.2000 MGNTFIS3.DTFCWQGC.DMI.2001 MGNTFIS3.V4BVT962.DMI.2002 MGNTFIS3.ZXR8CZHA.DMI.2003 MGNTFIS3.N71YT12L.DMI.2004 MGNTFIS3.ULSC0WL3.DMI.2005 MGNTFIS3.KX5Z65HT.DMI.2006*/ "MGNTFIS3.UQCB65UY.DMI.2007 MGNTFIS3.GWWK462B.DMI.2008 MGNTFIS3.N4ZQF7E0.DMI.2009 MGNTFIS3.T2CPW615.DMI.2010 MGNTFIS3.PB86KBNU.DMI.2011 MGNTFIS3.U66Z58IK.DMI.2012 MGNTFIS3.Z8BHB8NQ.DMI.2013 MGNTFIS3.ST61JZ8P.DMI.2014 MGNTFIS3.ITNFJ9UX.DMI.2015 MGNTFIS3.VVMNV2V0.DMI.2016 panel_01 panel_full" ;  
*global filenames "MGNTFIS3.VVMNV2V0.DMI.2016 MGNTFIS3.VVMNV2V0.DMI.2015 MGNTFIS3.VVMNV2V0.DMI.2014 merged_set panel_01 known_benefit_corporations known_benefit_corps db_directory" ;
di "LIST OF FILES TO CHECK: $filenames";

foreach i in $filenames{;

	/* GENERATE LOG FILE --------------------------------------------------*/
	di "`i'" ; 
	
	cd "./logs/debugging/hexdump";
	log using "hexdump.`i'.smcl", replace;
	di " ";
	di " ";
	di "START:: DEBUGGING CROSS SECTIONAL `i': " ;
	di "TIME:: " c(current_date) " "  c(current_time);
	di " ";
	di " ";
	cd ../../../data;
	
	/* DEBUG 01 : HEXDUMP - SHOW ALL CHARACTERS USED IN FILE --------------*/
	*hexdump "`i'.dta";
	hexdump "`i'.dta", analyze;
	di " ";
	di " ";
	
	
	/* CLOSE LOG ----------------------------------------------------------*/
	cd ../logs;
	di "END::  DEBUGGING CROSS SECTIONAL FILES: " ;
	di "TIME:: " c(current_date) " "  c(current_time);
	log close;
	cd ../;	

	
	
	
	
	
	/* GENERATE LOG FILE --------------------------------------------------*/
	di "`i'" ; 
	
	cd ./logs/debugging/verify;
	log using "verify.`i'.smcl", replace;
	di " ";
	di " ";
	di "START:: DEBUGGING CROSS SECTIONAL `i': " ;
	di "TIME:: " c(current_date) " "  c(current_time);
	di " ";
	di " ";
	cd ../../../data;
	
	/* DEBUG 02 : VERIFY - VERIFY FILES ARE FORMATTED CORRECTLY -----------*/
	version ; 
	dtaverify "`i'.dta";
	di " ";
	di " ";

	
	
	/* CLOSE LOG ----------------------------------------------------------*/
	cd ../logs;
	di "END::  DEBUGGING CROSS SECTIONAL FILES: " ;
	di "TIME:: " c(current_date) " "  c(current_time);
	log close;
	cd ../;		
	
	


	
	
	
	/* GENERATE LOG FILE --------------------------------------------------*/
	di "`i'" ; 
	
	cd "./logs/debugging/codebook";
	log using "codebook.`i'.smcl", replace;
	di " ";
	di " ";
	di "START:: DEBUGGING CROSS SECTIONAL `i': " ;
	di "TIME:: " c(current_date) " "  c(current_time);
	di " ";
	di " ";
	cd ../../../data;
	
	/* DEBUG 03 : CODEBOOK - DISPLAY RANGE OF EACH VARIABLE IN FILE -------*/
	use "`i'.dta";
	codebook ;
	di " ";
	di " ";

	
	
	/* CLOSE LOG ----------------------------------------------------------*/
	*cd ../logs;
	di "END::  DEBUGGING CROSS SECTIONAL FILES: " ;
	di "TIME:: " c(current_date) " "  c(current_time);
	log close;
	cd ../;	

};





/***************************************************************************/
/* END DEBUG 1/N			                                               */
/***************************************************************************/

exit, clear STATA;
