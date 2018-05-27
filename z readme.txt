Read Me for: 	Test Workspace
################################################################################

Version: 	04
Version Date: 	2018 05 27



Purpose:	This is trying to make a templatefora workspace that 
		automatically updates my project so I can run it from a 
		shell editor. This also will store some scalars so I can
		share files between STATA and R.
		
		This should be in its own folder heirarcy, then I fill out
		some minimal information and let the program make the rest



Rules:		1) When I come up with a name for the project, I cannot use "\n"
			in the name, or else it will break the Unix script later

		2) If there are multiple authors, include all names in the same 
			cell and seperate with ";" . Do not use "," or else
			you will break the Unix shell editor later


Instructions:	1) Fill in project details in "~/I Initialization"
			a) "./01 input project details.csv"
			b) "./02 input project description.txt"
			c) "./03 input git settings <insert git name>.csv"
				git name will change if you are using the
				umn or the personal git account

		2) Run "./99 initialization wrapper.txt" from inside "./I"


		3) Fill in project details in "~/D Settings"
			a) "./01 git ignore files.txt" for files not to be
				in the repository (e.g. big files)
			b) "./03 committ message.txt" for my committs
				






ifpossible, I should see if I can make a unix log file for this set up code.



1.. am I making the 02 git committ template twice

2.. who do I spell committcomit

3.. make the incrementor for the working branch, acctually, pull from the meta file,
dont just do it in the shell

4. review unrelated histories so I dont get confused,

then think about how I can merge branches from thee bottom up
maybe have a list of branches that this project has previously taken then write a for loop that starts t the bottom and mergess up

look for help online if there are examples of this somewhere else





for some reason, in 01 git update.txt , when I type the sed command on line 22 into the terminal, I get the activity I want, the replacement of the run count from the meta.csv file

but when I try to run the same code in a script with globals for values instead of hard coded numbers, it fails.


Go back to the labor project and seee what I did to increment
	also, see if my awk / grep / sed commands from the labor project apply here, they should



after I update that, consider merging folders I and E

for the commit history, remember to track the run count,
either try and change the format into 0001   0002   style
or
see if commits and branch names canhave a . in them and just use 0.0001 0.0002 as substitutes


also, start going through each file and add the comments for the file


start referring ot the comments in this read me file

start giving this read me structure


talk to Man Xu about her norms for coding
we are probably going to work toggehter for this project


If I am full time, that is fine.



Start thinking about what the final product is going to look like


