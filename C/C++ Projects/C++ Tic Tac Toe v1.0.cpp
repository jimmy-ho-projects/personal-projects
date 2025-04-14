/*
TIC TAC TOE v1.0
    Tic tac toe implementation in C++! Runs in terminal. Original was a BATCH file that
    no one can run so that's useless...
    Players always goes first
Created 4/4/25
    completed -> C++ 4/13/25
    KNOWN ISSUE: ultra rare chance for CPU to randomly win w/o 3 in row; probably arithmetic error

-Jimmy Ho
*/

#include <iostream>
#include <string>
bool CHECK_WIN_COND(int A, int B,int C,int D,int E, int F, int G,int H,int I, int numMoves);

int main(){ 
	int numMoves = 0;
	//Variable for player input (ASCII)
	int A = 49; int B = 50; int C = 51;
	int D = 52; int E = 53; int F = 54;
	int G = 55; int H = 56; int I = 57;
	//array to map CPU choice # to letter
    srand(time(0) * rand()); //init w/random seed for CPU TURN

	// ===MAIN LOOP===
	bool loopVar = true;
	while(loopVar){
		// ==== Print Board ====
		printf("Turn: %i \n", numMoves);
		printf(" [ %c ][ %c ][ %c ]\n", A, B, C);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", D, E, F);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", G, H, I);

		// ==== Taking Turns ====
		//PLAYER TURN
		std::cout<<"█Player Turn ( X ): ";
		
		int pChoice = 0; //player choice, default 0
	    std::string temp_pChoice = "";
		bool choice_loop = true;
		while(choice_loop){
		    std::cin>>temp_pChoice;
		    //checks for valid integer input, 0 if not
		    try{pChoice = stoi(temp_pChoice);}
		    catch(...){pChoice = 0;}
		    
		    switch(pChoice){
		        case 1:
		            if(A==49){A=88; choice_loop=false; break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        case 2:
		            if(B==50){B=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        case 3:
		            if(C==51){C=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        case 4:
        	        if(D==52){D=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};    
		        case 5:
		            if(E==53){E=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        case 6:
		            if(F==54){F=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        case 7:
	                if(G==55){G=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        case 8: 
	                if(H==56){H=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        case 9:
		            if(I==57){I=88; choice_loop=false;break;} else {std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): "; break;};
		        default:
		            std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): ";
		            break;
		    }
		}
	
	    //CPU TURN
	    choice_loop = true;
	    int random_number = 0;
	    int attempt_counter = 0; //prevents cpu from trying too long to find valid move 
	    int max_attempts_allowed = 50;
	    while(choice_loop){ //break from cpu loop if no valid move found 
            if(attempt_counter >= max_attempts_allowed){
                //std::cout << "█CPU did not find valid move in " << attempt_counter << " attempts\n";
                choice_loop = false;
                break;} 
    	    random_number = rand() % 9 + 1;
    	    switch(random_number){
    	        case 1:
    	            if(A==49){A=64; choice_loop = false; break;} else {break;}
    	        case 2:
    	            if(B==50){B=64; choice_loop = false;  break;} else {break;}
    	        case 3:
    	            if(C==51){C=64;  choice_loop = false; break;} else {break;}
    	        case 4:
        	        if(D==52){D=64;  choice_loop = false; break;} else {break;} 
    	        case 5:
    	            if(E==53){E=64;  choice_loop = false; break;} else {break;}
    	        case 6:
    	            if(F==54){F=64;  choice_loop = false; break;} else {break;}
    	        case 7:
                    if(G==55){G=64;  choice_loop = false; break;} else {break;}
    	        case 8: 
                    if(H==56){H=64;  choice_loop = false; break;} else {break;}
    	        case 9:
    	            if(I==57){I=64;  choice_loop = false; break;} else {break;}
    	    }
    	    attempt_counter = attempt_counter + 1;
	    }
	    std::cout << "█CPU chose: " << random_number <<'\n';
	
	
	    //CHECK WIN CONDITION
	    if(numMoves >= 2){
	        loopVar = CHECK_WIN_COND(A,B,C,D,E,F,G,H,I,numMoves);
	    }  
	    
	    numMoves = numMoves + 1;
	}
	
	return 0;
}

bool CHECK_WIN_COND(int A, int B,int C,int D,int E, int F, int G,int H,int I, int numMoves){
    /*return TRUE if no win, maintain while loop
    return FALSE if win detected
    Checking if three-in-row is = int values times 3*/
    
    //CHECKING IF PLAYER X WoN
    int X = 88, Y = 64;
    if(A+B+C==X*3 || D+A+G==X*3 || F+C+I == X*3 || H+G+I==X*3 ||
    E+D+F==X*3 || E+B+H==X*3 || E+A+I==X*3 || E+G+C==X*3){
        numMoves = numMoves + 1;
		printf("X Turn: %i X\n", numMoves);
		printf(" [ %c ][ %c ][ %c ]\n", A, B, C);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", D, E, F);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", G, H, I);
		std::cout << "█----=========-----█\n";
	    std::cout << "█PLAYER (X) WINS!!!█\n";
		std::cout << "█----=========-----█\n";
	    std::cout<< "Thanks for Playing!\n█ █ █ █ █ █ █ █ █ █";
        return false;
    }

    //CHECKING IF CPUP @ WoN
    else if(A+B+C==Y*3 || D+A+G==Y*3 || F+C+I == Y*3 || H+G+I==Y*3 ||
    E+D+F==Y*3 || E+B+H==Y*3 || E+A+I==Y*3 || E+G+C==Y*3){
        numMoves = numMoves + 1;
		printf("@ Turn: %i @\n", numMoves);
		printf(" [ %c ][ %c ][ %c ]\n", A, B, C);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", D, E, F);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", G, H, I);
		std::cout << "█----=========-----█\n";
	    std::cout << "█  CPU  (@) WINS!  █\n";
		std::cout << "█----=========-----█\n";
	    std::cout<< "\nThanks for Playing!\n█ █ █ █ █ █ █ █ █ █";
        return false;
    }
    else if(A+B+C+D+E+F+G+H+I >= (X*5+Y*4)){ //all spots no longer have oringinal numbers
        //player X moves 5 times, CPU Y moves one less
        numMoves = numMoves + 1;
		printf("  Turn: %i \n", numMoves);
		printf(" [ %c ][ %c ][ %c ]\n", A, B, C);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", D, E, F);
		std::cout << " ===============" <<'\n';
		printf(" [ %c ][ %c ][ %c ]\n", G, H, I);
		std::cout << "█----=========-----█\n";
	    std::cout << "█       tie        █\n";
		std::cout << "█----=========-----█\n";
	    std::cout<< "\nThanks for Playing!\n█ █ █ █ █ █ █ █ █ █";
        return false;
    }
    else {return true;}
}
