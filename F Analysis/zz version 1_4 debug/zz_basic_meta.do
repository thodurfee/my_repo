#delimit ; 
set more off ; 
version 13 ; 
set trace on;
pwd;
ls;


/**/


/**/



/* print username */
di c(username);

/*define my workspaces and paths */
local rwcuser "durfe019" ;
local rwcpath "h:/" ; 
local homeuser "thodurfee" ;
local homepath "c:/" ;
local msiuser "mesabi" ;
local msipath "~/dbresearch" ; 




if c(username) == "`rwcuser'" {;
	di "`rwcpath'" ; 
	};

else if c(username) == "`homeuser'" {;
	di "`homepath'" ; 
	};

else if c(username) == "`msiuser'" {;
	di "`msipath'" ; 
	};

else {;
	di "other";
	};

	
local noiselevel "noisily";


/*cond();*/
shell ls ;
