ods noproctitle;
options nodate; 

data hw3; 
	infile "C:\Users\niwi8\OneDrive\Documents\Fall 2018\regression\homework\p8110_hw3\HW3Data.csv"
		delimiter= ',' missover dsd; 
	input id treatment pcnt_burned follow_time infect; 
run; 

* problem 1; 

proc lifetest data = hw3 method = km plots = survival(cl); 
	title "Applied Regression II homework 3, problem 1";
	strata treatment; 
	time follow_time * infect(0); 
run;

* problem 3; 

data hw3_p2; 
	set hw3; 
	if pcnt_burned < 12 then burn_group = "<12   "; 
		else if 12 =< pcnt_burned < 20 then burn_group = "12-19"; 
		else if 20 =< pcnt_burned < 30 then burn_group = "20-29"; 
		else burn_group = ">30"; 
run;  

proc lifetest data = hw3 method = km plots = survival; 
	title "Applied Regression II homework 3, problem 3";
	strata pcnt_burned (12 20 30); 
	time follow_time * infect(0); 
run; 

proc lifetest data = hw3_p2 method = km plots = survival; 
	title "Applied Regression II homework 3, problem 3";
	strata burn_group; 
	time follow_time * infect(0); 
run; 
