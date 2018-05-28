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


Instructions:	1) Fill in project details in "~/E Setup and Support Code
			a) "./01 input project details.csv"
			b) "./02 input project description.txt"
			c) "./03 input git settings <insert git name>.csv"
				git name will change if you are using the
				umn or the personal git account

		2) Run "./99 initialization wrapper.txt" from inside "./E"
			Do not run from the head directory


		3) Fill in project details in "~/D Settings"
			a) "./01 git ignore files.txt" for files not to be
				in the repository (e.g. big files)
			b) "./03 committ message.txt" for my committs

		4) When you want to commit, run the "01 git update.txt"
			frile from within the head directory
				






ifpossible, I should see if I can make a unix log file for this set up code.


4. review unrelated histories so I dont get confused,

then think about how I can merge branches from thee bottom up
maybe have a list of branches that this project has previously taken then write a for loop that starts t the bottom and mergess up

look for help online if there are examples of this somewhere else



start giving this read me structure


talk to Man Xu about her norms for coding
we are probably going to work toggehter for this project


If I am full time, that is fine.



Start thinking about what the final product is going to look like


