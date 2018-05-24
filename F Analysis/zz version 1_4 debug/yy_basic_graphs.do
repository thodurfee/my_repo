#delimit ;
version 13;
set trace on;
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





/* GENERATE LOG FILE ------------------------------------------------------*/
cd ../../ ;
cd ./logs;
log using "log.gen.graphs.smcl", replace;
di "START:: LOADING B LABS LIST: " ;
di "TIME:: " c(current_date) " "  c(current_time);
cd ../data ;





/* make sure that I have matched my sic codes */


local dataname "merged_set";
local demo_controls_ols "dempltot demplototsqr ";
local time_controls_ols "age agesqr dyrstart dyrstartsqr";
 /*local treatment "certified_b_corp";*/
local treatment "list_knownlist";
local y "dsalesvo";



use "`dataname'.dta", clear;
cd ../analysis/results ; 



/*-------------------------------------------------------*/
/* use this to simulate stuff for now */
destring *_decile, replace;
replace `treatment' = 0;
replace `treatment' = 1 if uniform_decile == 1;
drop if duns == "";
destring duns, replace ; 

destring dprimsi, replace ; 

/*-----------------------------------------------------*/

local varlist "dsalesvo dempltot demplher dyrstart dsubsidi dmanufin dsalesvosqr dempltotsqr dyrstartsqr demplhersqr dsalesvolog dempltotlog dyrstartlog demplherlog year age agesqr";
/*local varlist "dsalesvo dempltot demplher";*/

label define isben 0 "Classic Corporation" 1 "Benefit Corporation";
lab values  `treatment' isben;

foreach i in `varlist'{;
	di "`i' in varlist";
	format %10.0gc `i';
	gen `i'_000 = `i' / 1000;
		format %10.0gc `i'_000;
	gen `i'_000000 = `i' / 1000000;
		format %10.0gc `i'_000000;
};


foreach i in `varlist'{;
	foreach j in `varlist'{;
	di "`j' and `i'";
		if `j' == `i' {;
		di " " ;
		};
		else {;
		/*qui twoway (scatter `i' `j'),  ytitle("`j'") xtitle("`i'") title("`i' and `j'") name("graph_`i'_`j'", replace) xsize(15) ysize(10) ;*/
			/*reg `j' `i' if `treatment' == 0;*/
			/*reg `j' `i' if `treatment' == 1;*/
			/*twoway 	(lfitci `j' `i' if `treatment' == 0, stdr clcolor("200 200 255") clpattern(solid) fcolor("240 240 255") blcolor("240 240 255") blwidth(vvvthin))
					(lfitci `j' `i' if `treatment' == 1, stdr clcolor("255 200 200") clpattern(solid) fcolor("255 240 240") blcolor("255 240 240") blwidth(vvvthin))
					
					(scatter `j' `i' if `treatment' == 0, sort mcolor("150 150 230") msize(tiny) msymbol(circle))
					(scatter `j' `i' if `treatment' == 1, sort mcolor("230 150 150") msize(tiny) msymbol(circle))
					
					(lfit `j' `i' if `j' != . & `treatment' == 0, lcolor("200 200 255") lpattern(solid))
					(lfit `j' `i' if `j' != . & `treatment' == 1, lcolor("255 200 200") lpattern(solid))*/

			twoway 	(lfitci `j'_000000 `i'_000000 , stdr clcolor("200 200 255") clpattern(solid) fcolor("240 240 255") blcolor("240 240 255") blwidth(vvvthin))
					
					(scatter `j'_000000 `i'_000000, sort mcolor("150 150 230") msize(tiny) msymbol(circle))
					
					(lfit `j'_000000 `i'_000000 if `j'_000000 != . , lcolor("200 200 255") lpattern(solid))
					
					if `treatment' != . ,
					ytitle("`j'", angle("45")) ylabel(, angle("0") noticks) ymtick(, angle("0"))
					xtitle("`i'") xlabel(, angle("0") noticks) 
					/*title("`j' and `i'" )*/
					by(,legend(off) )
					name("sctr_`j'_`i'_mil", replace) 
					xsize(20) ysize(18) 
					graphregion(fcolor(white) ifcolor(white))
					by(,title("`j' and `i' (in Millions)")) by(`treatment');
			graph export "sctr_`j'_`i'_mil.png", as(png) replace ; 
			
			
			
			
			
			twoway 	(lfitci `j'_000 `i'_000 , stdr clcolor("200 200 255") clpattern(solid) fcolor("240 240 255") blcolor("240 240 255") blwidth(vvvthin))
					
					(scatter `j'_000 `i'_000, sort mcolor("150 150 230") msize(tiny) msymbol(circle))
					
					(lfit `j'_000 `i'_000 if `j'_000 != . , lcolor("200 200 255") lpattern(solid))
					
					if `treatment' != . ,
					ytitle("`j'", angle("45")) ylabel(, angle("0") noticks) ymtick(, angle("0"))
					xtitle("`i'") xlabel(, angle(0) noticks) 
					/*title("`j' and `i'" )*/
					by(,legend(off) )
					name("sctr_`j'_`i'_tho", replace) 
					xsize(20) ysize(18) 
					graphregion(fcolor(white) ifcolor(white))
					by(,title("`j' and `i' (in Thousands)")) by(`treatment');
			graph export "sctr_`j'_`i'_thou.png", as(png) replace ; 
			
			
			
			
			
			twoway 	(lfitci `j' `i' , stdr clcolor("200 200 255") clpattern(solid) fcolor("240 240 255") blcolor("240 240 255") blwidth(vvvthin))
					
					(scatter `j' `i', sort mcolor("150 150 230") msize(tiny) msymbol(circle))
					
					(lfit `j' `i' if `j' != . , lcolor("200 200 255") lpattern(solid))
					
					if `treatment' != . ,
					ytitle("`j'", angle("45")) ylabel(, angle("0") noticks) ymtick(, angle("0"))
					xtitle("`i'") xlabel(, angle("45") noticks) 
					/*title("`j' and `i'" )*/
					by(,legend(off) )
					name("sctr_`j'_`i'", replace) 
					xsize(20) ysize(18) 
					graphregion(fcolor(white) ifcolor(white))
					by(,title("`j' and `i'")) by(`treatment');
			graph export "sctr_`j'_`i'.png", as(png) replace ; 
		};
	};
};



/* CLOSE LOG --------------------------------------------------------------*/
di "END:: LOADING B LABS LIST: " ;
di "TIME:: " c(current_date) " "  c(current_time);
log close;




/***************************************************************************/
/* END SAMPLE PANEL DATA                                                   */
/***************************************************************************/
exit, clear STATA;
