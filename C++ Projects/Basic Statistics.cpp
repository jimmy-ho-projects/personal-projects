/* 
Online C++ compiler: https://www.programiz.com/online-compiler/2yAR51Be5dJbr
WIP C++ THINGS (Basic Statistics)
Takes in, validate/process/sort user inputted array of values, and spits out statistical tests:
arithmetic mean, mode, and median

Created 3/9/2025
Last modified 3/19/2025
v 1.0 completed 4/14/25
    *finished the MODE statistic 
v1.1 4/14/25
    *added HARMONIC and GEOMETRIC means
-Jimmy Ho
*/

#include <iostream>
#include <string>
#include <cmath> //need pow() like oncce :(

/*
Take in and parse string of data input, assume size of array of strings to store values and run basic statistical tests
*/

/*
THINGS I'VE LEARNED FROM THIS PROJECT:
1) std::endl is slow, better to print '\n' instead
2) arrays can be sent into functions but the func needs to expect an array[] to handle it properly
3) for loop can use element of array using (int variable : array) parameter
3.5) ONLY WORKS FOR ARRAYS (within scope); arr passed to function are POINTERS; trick not work
4) i suck at naming vars
5) functions cant return arrays; arrays passed into function actually deal with their pointers or something
*/

//TODO: go through entries and determine if valid number or not using std::stof()

//DECLARED FUNCTIONS
int ESTIMATE_ENTRIES(std::string input); //estimate # valid entries: n spaces = n + 1 entries
void ENTRIES2LIST(std::string input, std::string output[]); //convert input string to list of entries
int funct_numvalidEntries_ind(std::string input[], int numEntries);
void funct_indvalidEntries_ind(std::string input[], int validEntries_ind[], int numEntries);
int CHECK_CONSECUTIVE_SPACES(int a, int b);
std::string REMOVE_COMMAS(std::string input);
void SORT_ARRAY(float arr_in[], int arr_size);
float FIND_MEAN_ALG(float meanBaby[], int sizeBaby);
float FIND_MEAN_HARM(float meanBaby[], int sizeBaby);
float FIND_MEAN_GEO(float meanBaby[], int sizeBaby);
float FIND_MEDIAN(float meanBaby[], int sizeBaby);
void FIND_MODE(float meanBaby[], int sizeBaby, float modeBaby[]);

//MAIN
int main() {
    std::cout << "Basic Statistics - Enter numerical data separated by space" << "\n" << "> ";
    
    //TAKE USER INPUT
    std::string strInput;
    getline(std::cin, strInput);
    int intLength = strInput.length(); //store user input
    int totalEntries = ESTIMATE_ENTRIES(strInput); //estimated # of entries
    std::string arr_Entries[ totalEntries ] = {}; //array store valid entries
    
    //CONVERT USER INPUT TO ARRAY OF ENTRIES
    ENTRIES2LIST(strInput, arr_Entries);
    //debug: SHOWs user ENTRIES
    //for(int jj = 0; jj<totalEntries; jj++){std::cout<<arr_Entries[jj] << "\n";}
    
    //TODO: CONVERT ENTRIES TO FLOAT (DISCARD NON-FLOATS, POINTER TO VALID ENTRIES)
    int int_sizeValidArray = funct_numvalidEntries_ind(arr_Entries, totalEntries);
    int validEntries_ind[ int_sizeValidArray ] = {};
    funct_indvalidEntries_ind(arr_Entries, validEntries_ind, totalEntries);
    float arrFinalEntries[ int_sizeValidArray ] = {}; //store final list of valid entries
    
    //TODO: User Query
    std::cout<<"====================\nValid entries: ";
    int intIncrement = 0;
    for(int i : validEntries_ind){
        float cowboy = std::stof(arr_Entries[i]);
        if(i%5 == 0){std::cout<<"\n";}
        std::cout<< cowboy; 
        if(i != validEntries_ind[int_sizeValidArray - 1]){std::cout << ", ";} //print comma if NOT last valid element
        arrFinalEntries[intIncrement] = cowboy;
        ++intIncrement;
    }
    std::cout<<"\n====================\n";
    //std::cout<<"Is this correct? (y/n)";
    
    //TODO:: SORTING & STATISTICS FUNCTIONS AND DISPLAYS
    SORT_ARRAY(arrFinalEntries, int_sizeValidArray);
    
    std::cout<<"Sorted entries: ";
    intIncrement = 0;
    for(float i : arrFinalEntries){
        if(intIncrement % 5 == 0){std::cout<<"\n";}
        std::cout << i; 
        if(intIncrement != (int_sizeValidArray - 1)){std::cout << ", ";} //print comma if NOT last valid element
        ++intIncrement;
    }
    
    std::cout<<"\n====================\n";
    std::cout<<"Mean (Arithmetic): " << FIND_MEAN_ALG(arrFinalEntries, int_sizeValidArray) << "\n";
    std::cout<<"Mean (Harmonic): " << FIND_MEAN_HARM(arrFinalEntries, int_sizeValidArray) << "\n";
    std::cout<<"Mean (Geometric): " << FIND_MEAN_GEO(arrFinalEntries, int_sizeValidArray) << "\n";
    std::cout<<"Median: " << FIND_MEDIAN(arrFinalEntries, int_sizeValidArray) << "\n";
    float mode_array[int_sizeValidArray + 1] = {}; 
        /*need init array to store stat mode then pass into mode funct; first index reserved, 
        funct will set to NUM OF MODES IN ARRAY to index through when cout
        ie mode_array[0] = # of entries considered as "mode"*/ 
    FIND_MODE(arrFinalEntries, int_sizeValidArray, mode_array);
    std::cout<<"Mode: "<<'\n';
    for(int tt = 0; tt < mode_array[0]; tt++){
        std::cout << mode_array[tt+1] << " ";
    }
        return 0;
}

//FUNCTION DEFINITIONS
int ESTIMATE_ENTRIES(std::string input){
    int estEntries = 0;
    
    //Find and replace all commas w/space in string
    input = REMOVE_COMMAS(input);
    
    //Find all spaces that denote separate entries
    int foundLeft = 0;
    int foundLeft_prev = -1;
    input.append(" ");
    int foundRight = input.rfind(" "); //added space at end of string
    while((foundLeft<foundRight)){
        foundLeft = input.find(" ", foundLeft+1);
        if(foundLeft!=std::string::npos && !CHECK_CONSECUTIVE_SPACES(foundLeft, foundLeft_prev)){
            //IF string good practice, if no character found, function will pass highest string val
            estEntries++;
        }   
        foundLeft_prev = foundLeft; 
    }
    return estEntries; 
}

void ENTRIES2LIST(std::string input, std::string output[]){
    //TODO
    /*Find all spaces that denote separate entries, copy string + 1 index after space up to next space
    uses space finding and consec space detect from function ESTIMATE_ENTRIES*/
    
    //Find and replace all commas w/space in string
    input = REMOVE_COMMAS(input);
    
    int foundLeft = 0; int foundLeft_prev = -2;
    input.append(" "); int foundRight = input.rfind(" "); //added space at end of string
    int iterEntry = 0; //iterate when entry recorded in string array input[]
    
    //edge-case: index 0 (first character) comma that turned into space
    foundLeft = input.find(" ", foundLeft);
    if(foundLeft==0){
        foundLeft = input.find(" ", foundLeft+1);
        output[iterEntry].append(input, 1, foundLeft); //std::cout<<"cock: "<<foundLeft<<"\n";
        foundLeft_prev = 1;
    }
    else{
        output[iterEntry].append(input, 0, foundLeft);
        foundLeft_prev = 0;
    }
    iterEntry++;
    
    while((foundLeft<foundRight)){
        foundLeft_prev = foundLeft; 
        foundLeft = input.find(" ", foundLeft+1);
        
        //if entry position discovered
        if(foundLeft!=std::string::npos && !CHECK_CONSECUTIVE_SPACES(foundLeft, foundLeft_prev)){
            output[iterEntry].append(input, foundLeft_prev + 1, foundLeft - (foundLeft_prev + 1));
            iterEntry++;
        }   
    }
}

int funct_numvalidEntries_ind(std::string input[], int numEntries){
    //try string-to-float to check if valid entry; store valid index in validEntries_ind Array
    int iter_valid = 0; //only iterate when valid entry found
    for(int jj = 0; jj<numEntries; jj++){
        try{
            std::stof(input[jj]);
            iter_valid++;
        }
        catch(...){
            //std::cout<<"Entry "<<jj+1<<" invalid"<<"\n";
        }
    }
    return iter_valid;
}

void funct_indvalidEntries_ind(std::string input[], int validEntries_ind[], int numEntries){
    //try string-to-float to check if valid entry; store valid index in validEntries_ind Array
    int tempArr[numEntries] = {};
    int iter_valid = 0; //only iterate when valid entry found
    for(int jj = 0; jj<numEntries; jj++){
        try{
            std::stof(input[jj]);
            tempArr[iter_valid] = jj;
            iter_valid++;
        }
        catch(...){
            //std::cout<<"Entry "<<jj+1<<" invalid"<<"\n";
            input[jj] = "";
        }
    }
    //copy index and value of valid array from tempArr -> validEntries_ind array
    for(int bird = 0; bird < iter_valid; bird++){
        validEntries_ind[bird] = tempArr[bird];   
    }
}

int CHECK_CONSECUTIVE_SPACES(int a, int b){
    //If inputs consecutive or same, return true
    if( (a-b == 1) || (a-b == -1)  ){/*std::cout<<"consec"<<"\n";*/return 1;}
    else{/*std::cout<<"not consec"<<"\n";*/return 0;}
}

std::string REMOVE_COMMAS(std::string input){
    //Find and replace all commas w/space in string
    int foundcomma = input.find(","); //edge case: comma at 0 index
    if(foundcomma!=std::string::npos){input[foundcomma] = ' ';}   
    while(foundcomma < input.length()){
        foundcomma = input.find(",", foundcomma+1);
        if(foundcomma!=std::string::npos){input[foundcomma] = ' ';}   
    }
    return input;
}

void SORT_ARRAY(float arr_in[], int arr_size){
    //sorts array from least to greatest
    bool sort_loop = true; //set false if any sorting performed
    while(sort_loop){
        sort_loop = false; //if no sorting performed, FALSE allow loop exit, assume sorted
        for(int kk = 0; kk < arr_size - 1; kk++){ //left-side compare
            float num1 = arr_in[kk];
            float num2 = arr_in[kk+1];
            if(num1 > num2){
                arr_in[kk+1] = num1;
                arr_in[kk] = num2;
                sort_loop = true;
            }
        }
    }
}

float FIND_MEAN_ALG( float meanBaby[], int sizeBaby){
    //algebraic mean
    float horse = 0;
    for(int apple = 0; apple < sizeBaby; apple++){
        horse = horse + meanBaby[apple];
    }
    return horse / sizeBaby;
}

float FIND_MEAN_HARM(float meanBaby[], int sizeBaby){
    float ploppy = 0;
    for(int ww = 0; ww < sizeBaby; ww++){
        ploppy = ploppy + (1 / meanBaby[ww]);
    }
    return sizeBaby / ploppy;
}

float FIND_MEAN_GEO(float meanBaby[], int sizeBaby){
    float ploppy = meanBaby[0];
    for(int ww = 1; ww < sizeBaby; ww++){
        ploppy = ploppy * meanBaby[ww];
    }
    return pow(ploppy, 1.0/sizeBaby); //pow() takes float input, giving int will truncate and give wrong values
}

float FIND_MEDIAN(float meanBaby[], int sizeBaby){
    /*
    median = index of halfway of array
    if size uneven, halfway = (total - 1) / 2
    if size event (MUST BE INTEGER for decimal truncation), 
        lower half = total / 2
        upper half = lower half + 1
    //parameter: "size" mod 2 = 1 (ie uneven = true)
    */
    
    //REMINDER: ARRAY SIZE IS +1 FROM ARRAY INDEX POSITION
    // this works well enough dont change anything :3
    if(sizeBaby%2){ //uneven
        int ind1 = sizeBaby / 2; //integer division, truncates decimals, left side of middle
        return meanBaby[ind1];
    }
    else{
        int ind1 = (sizeBaby-1) / 2;
        int ind2 = ind1 + 1;
        float med = (meanBaby[ind1] + meanBaby[ind2]) / 2; 
        return med;
    }
}

void FIND_MODE(float meanBaby[], int sizeBaby, float modeBaby[]){
    //assume input array sorted
    /* 
    modeBaby is empty array of same size meanBaby (has our values, sorted)
    for every # repeat, counter will increment and count stored in
    temp_Baby, where index for count correlates to index for value in 
    meanBaby. Let's us find highest # repeats in temp_Baby, then store in
    modeBaby with # repeats recorded
    */
    //compare to previous index, if match, increment counter else reset counter
    float curr_entry; //track current entry
    float prev_entry;
    int curr_count = 1; //current count of rep
    int highest_count = 1;
    int temp_Baby[sizeBaby] = {}; //store # of repeats; index correlation to meanBaby
    
    //increment counter if repeat, assign number of repeats to modeBaby array (index correlate with meanBaby)
    for(int rr = 0; rr < sizeBaby; rr++){
        curr_entry = meanBaby[rr];
        if(curr_entry == prev_entry){
            ++curr_count;
            if(curr_count>highest_count){
                highest_count = curr_count;
            } //update highest recorded rep
        } //repeat: increment
        else{curr_count = 1; prev_entry = curr_entry;} //not repeat: update prev_entry
        temp_Baby[rr] = curr_count;
    }
    
    //find index(s) of highest number of reps in temp_Baby
    curr_count = 0; //re-using int variable to index modeBaby array, starting at 1
    for(int rr = 0; rr < sizeBaby; rr++){
        if(temp_Baby[rr] == highest_count){
            modeBaby[curr_count+1] = meanBaby[rr]; //modeBaby[0] reserved for curr_count actual value
            ++curr_count;
        }
    }
    modeBaby[0] = curr_count;
}







