/*
Online C++ compiler to run C++ program online
C++ Simple Average Calculator
Calculates the average of up to 20 user inputted values, with numerical suffix updating accordingly. 

Last modified 3/5/2025
-Jimmy Ho
*/

#include <iostream>
#include <string>

float calcAverage(int numValues, float array[]); //func declaration, definition below main

int main() {
    float valStor[20] = {}; //init w 20, additions beyond cause BUS ERROR
    std::string valTemp = "";
    bool loopVar = false;
    int loopIter = 1;
    
    std::cout << "Average Calculator (20 max)"<< std::endl;
    
    while (loopVar == false){
        //check for numerical suffix
        if(loopIter != 1 && loopIter != 2 && loopIter != 3 ){
          std::cout << "Enter " << loopIter << "th value (or D for done): ";
            }
        else if(loopIter == 1){
         std::cout << "Enter " << loopIter << "st value (or D for done): ";
            }
        else if(loopIter == 2){
          std::cout << "Enter " << loopIter << "nd value (or D for done): ";
            }
        else if(loopIter == 3){
              std::cout << "Enter " << loopIter << "rd value (or D for done): ";
            }
        
        std::cin >> valTemp; //string input upe to whitespace
        
        try{
            valStor[loopIter - 1] = std::stof(valTemp); //string to float
            loopIter = loopIter + 1;
            }
        catch(...){ //catch-all parameter
            loopVar = true; //error conv str > flt, then exit loop, assume 'Done'
            }
    }
    
    //Find average then output
    std::cout << "Average = " << calcAverage(loopIter, valStor);
        
    return 0;
}

// FUNCTIONS
float calcAverage(int numValues, float array[]){
    float temp = 0;
    for(int ii = 0; ii < numValues; ii++){
        temp = temp + array[ii];
    }
    temp = temp / (numValues - 1);
    return temp;
}
