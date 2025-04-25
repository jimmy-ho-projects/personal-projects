/*
WIP 5 IN A ROW v1.0
    Adapted from tic tac toe v1. 
    TODO: specify board size. Build board size. allow choices up to board size. 5 in a row victory condition
Created 4/17/25
    completed ???
    
    //TODO: win condition; formatting issues if num elements triple digits or more; IND2SUB and SUB2IND functions
    //might be wonky due to pass by reference formatting and untested changes
    
    https://cplusplus.com/forum/beginner/9148/
    
-Jimmy Ho
*/

#include <iostream>
#include <string>
bool CHECK_WIN_COND(int A, int B,int C,int D,int E, int F, int G,int H,int I, int numMoves); //TODO
void IND2SUB(int linearInd, int size_X, int size_Y, int (&subInd)); //pass by reference &, allow modification by function
void SUB2IND(int subInd[2], int size_X, int size_Y, int &linearInd); //pass by reference &, allow modification by function
void PRINT_BOARD(int board[], int board_dimension[3], int numMoves);

int main(){ 
    
	bool loopVar = true;
    int board_dimension[3] = {0,0,0}; //{X, Y, total # elements}
	int numMoves = 0;
    srand(time(0) * rand()); //init w/random seed for CPU TURN
    
    //===QUERY: BOARD SIZE=============================================================
    std::string query_temp = "";
    std::cout<<"BOARD SIZE MUST BE AT LEAST 5x5\n";
	//get size X-dim
    while(loopVar){
        std::cout << "Size of board (X axis): ";
        std::cin >> query_temp;
        try{
            board_dimension[0] = std::stoi(query_temp);
            if(board_dimension[0] < 5){std::cout<<"Dimension cannot be below 5\n";}
            else{loopVar = false;}
        }
        catch(...){
            std::cout<<"Invalid input\n";
        }
    }
	//get size Y-dim
    loopVar = true;
	while(loopVar){
		std::cout << "Size of board (Y axis): ";
			std::cin >> query_temp;
			try{
				board_dimension[1] = std::stoi(query_temp);
				if(board_dimension[1] < 5){std::cout<<"Dimension cannot be below 5\n";}
				else{loopVar = false;}
			}
			catch(...){
				std::cout<<"Invalid input\n";
			}
    }

	board_dimension[2] = board_dimension[1] * board_dimension[0]; //update w/ tot number of elements 

    //TODO: INIT BOARD SIZE + CHOICES, X and O will correlate to neg int values, implements if checks 
    //===INITIALIZING BOARD ===========================================================
    int board[board_dimension[2]] = {};
	for(int ii = 0; ii < board_dimension[2]; ii++){
		board[ii] = ii;
	}

	// ===MAIN LOOP===
    loopVar = true;
	while(loopVar){
		// ==== Print Board ====
		PRINT_BOARD(board, board_dimension, numMoves);

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
		    catch(...){pChoice = -4;} //-4 for error
		    /* board[#] = -1 will print X, = -2 will print O*/
			if(pChoice == board[pChoice]){
			    board[pChoice] = -1; //set to X
			    choice_loop = false;
			}
			else {
		        std::cout<<"█Invalid move, buster!█\nPlayer Turn ( X ): ";
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
    	    
    	    if(random_number == board[random_number]){
			    board[random_number] = -2; //set to X
			    choice_loop = false;
			}
			else {
		        attempt_counter = attempt_counter + 1;
		    }

	    std::cout << "█CPU chose: " << random_number <<'\n';
	
	    //CHECK WIN CONDITION
	    //if(numMoves >= 2){
	        //loopVar = CHECK_WIN_COND(board, numMoves);
	    //}  
	    
	    numMoves = numMoves + 1;
	    }
    }
    return 0;
}
/*
bool CHECK_WIN_COND(int A, int B,int C,int D,int E, int F, int G,int H,int I, int numMoves){
    //return TRUE if no win, maintain while loop
    //return FALSE if win detected
    //Checking if three-in-row is = int values times 3
    
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
*/

void IND2SUB(int linearInd, int size_X, int size_Y, int (&subInd)){
    //pass by reference syntax for arrays
	/*takes linear index + specified size and stores subscript index in subInd array (must be passed into function)
	takes advantage of integer division rounding down. 0-index. Below is 5x5, but coord starts at 0 
	Format (based on MATLAB indexing):
    * _0__1__2__3__4__
	0| 0  5  10 15 20 |
	1| 1  6  11 16 21 |
	2| 2  7  12 17 22 |
	3| 3  8  13 18 23 |
	4| 4  9  14 19 24 |
	-------------------
	*/
	
	(&subInd)[0] = linearInd / size_X;
	(&subInd)[1] = linearInd / size_Y;
}

void SUB2IND(int subInd[2], int size_X, int size_Y, int &linearInd){
	/*
	Subscript -> linear index. Multiply X subscript by size of Y axis, then add Y subscript
	* _0__1__2__3__
	0| 0  5  10 15 |
	1| 1  6  11 16 |
	2| 2  7  12 17 |
	3| 3  8  13 18 |
	4| 4  9  14 19 |
	-------------------
	*/
	linearInd = (subInd[0] * size_Y) + subInd[1];
}

void PRINT_BOARD(int board[], int board_dimension[3], int numMoves){
	printf("Turn: %i \n", numMoves);
	/* board[#] = -1 will print X, = -2 will print O*/
	int currInd = 0; //linear index for board; convert from row/column loop variables
	int subInd[2] = {0,0}; //subscript indexing
	for(int row = 0; row < board_dimension[1]; row++){
		std::cout<<" ";
		for(int column = 0; column < board_dimension[0]; column++){
			std::cout<<"[ ";
			subInd[0] = column;
			subInd[1] = row;
			SUB2IND(subInd, board_dimension[0], board_dimension[1], currInd);
			if(board[currInd] == -1){std::cout<<"X ";}
			else if(board[currInd] == -2){std::cout<<"O ";}
			else{std::cout<<board[currInd];}
			//formatting: double digit occupy same 3 char space as 1 digit
			if(currInd>=10){std::cout<<"]";}
			else{std::cout<<" ]";}
		}
		std::cout<<"\n";
	}
}