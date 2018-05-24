#delimit ; 
version 13;
set more off;
/* set trace on */

/** meta data ***/
/* because this paper is not fully identified, I use Manski Bounds to scope the treatment effect*/

local statelist "state3";
local treatment "list_knownlist";



/* Arkansas Passage */ 
/*AR 7/27/2013*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "AR" & year < 2013;



/* Arizona Passage */
 /*AZ 12/31/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "AZ" & year < 2014;
 

/* California Passage */ 
/*CA 1/1/2012*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "CA" & year < 2012;


/* Colorado Passage */
 /*CO 4/1/2017*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "CO" & year < 2017;
 
 
/* Connecticut Passage */ 
/*CT 10/1/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "CT" & year < 2014;


/* Washington, D.C. Passage */
 /*DC 5/1/2013*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "DC" & year < 2013;
 
 
/* Delaware Passage */ 
/*DE 8/1/2013*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "DE" & year < 2013;


/* Florida Passage */ 
/*FL 7/1/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "FL" & year < 2014;


/* Georgia Passage */ 
/*GA NA*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "GA";

/* Hawaii Passage */ 
/*HI 7/8/2011*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "HI" & year < 2011;


/* Iowa Passage */ 
/*IA NA*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "IA" ;

/* Idaho Passage */
 /*ID 7/1/2015*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "ID" & year < 2015;
 
 
/* Illinois Passage */ 
/*IL 1/1/2013*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "IL" & year < 2013;


/* Indiana Passage */ 
/*IN 7/1/2015*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "IN" & year < 2015;


/* Louisiana Passage */ 
/*LA 8/1/2012*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "LA" & year < 2012;


/* Massachusetts Passage */ 
/*MA 12/1/2012*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "MA" & year < 2012;


/* Maryland Passage */ 
/*MD 10/1/2010*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "MD" & year < 2010;


/* Michigan Passage */ 
/*MI */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "MI";

/* Minnesota Passage */ 
/*MN 1/1/2015*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "MN" & year < 2015;


/* Montana Passage */
 /*MT 7/1/2015*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "MT" & year < 2015;
 
 
/* North Carolina Passage */
 /*NC */
 replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NC";
 
/* Nebraska Passage */
 /*NE 7/18/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NE" & year < 2014;
 
 
/* New Hampshire Passage */ 
/*NH 1/1/2015*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NH" & year < 2015;


/* New Jersey Passage */ 
/*NJ 2/23/2015*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NJ" & year < 2015;


/* Nevada Passage */ 
/*NV 1/1/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NV" & year < 2014;


/* New York Passage */ 
/*NY 2/10/2012*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NY" & year < 2012;


/* Ohio Passage */ 
/*OH */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "OH" ;

/* Oregon Passage */ 
/*OR 1/1/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "OR" & year < 2014;


/* Pennsylvania Passage */ 
/*PA 1/1/2013*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "PA" & year < 2013;


/* Rhode Island Passage */
 /*RI 1/1/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "RI" & year < 2014;
 
 
/* South Carolina Passage */
 /*SC 6/14/2012*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "SC" & year < 2012;
 
 
/* Tennessee Passage */ 
/*TN */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "TN";

/* Texas Passage */ 
/*TX 9/1/2017*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "TX" & year < 2017;


/* Utah Passage */ 
/*UT 5/13/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "UT" & year < 2014;


/* Virginia Passage */
 /*VA 7/1/2011*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "VA" & year < 2011;
 
 
/* Vermont Passage */ 
/*VT 7/1/2011*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "VT" & year < 2011;


/* Washington Passage */ 
/*WA */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "WA" ;

/* Alaska Passage */ 
/*AK NA*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "AK" ;

/* Alabama Passage */ 
/*AL */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "AL" ;

/* Kansas Passage */ 
/*KS 7/1/2017*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "KS" & year < 2017;


/* Kentucky Passage */ 
/*KY 7/1/2017*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "KY" & year < 2017;


/* Maine Passage */ 
/*ME */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "ME" ;

/* Missouri Passage */ 
/*MS */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "MS" ;

/* North Carolina Passage */
 /*NC */
 replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NC" ;
 
/* North Dakota Passage */ 
/*ND */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "ND" ;

/* New Mexico Passage */
 /*NM NA*/
 replace `treatment' = 0 if `treatment' == 1 & `statelist' == "NM" ;
 
/* Oklahoma Passage */ 
/*OK NA*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "OK" ;

/* South Dakota Passage */ 
/*SD */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "SD" ;

/* Wisconsin Passage */ 
/*WI 2/26/2018*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "WI" & year < 2018;


/* West Virginia Passage */
 /*WV 7/14/2014*/
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "WV" & year < 2014;
 
 
/* Wyoming Passage */ 
/*WY */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "WY";

/* Mississippi Passage */
 /*MS NA*/
 replace `treatment' = 0 if `treatment' == 1 & `statelist' == "MS" ;
 
/* Virgin Islands Passage */ 
/*USVI */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "USVI" ;

/* Puetro Rico Passage */ 
/*PR */
replace `treatment' = 0 if `treatment' == 1 & `statelist' == "PR";


/*  this will probably do nothing until you get the full sample  */
sort duns year;
by duns: replace `treatment' = 1 if `treatment'[_n-1] == 1;
