/*
Online C++ compiler to run C++ program online
C++ Reverse Input String
Takes in user input string and displays string backwards
by looping through char array in reverse

Last modified 3/7/2025
-Jimmy Ho
*/

#include <iostream>
#include <string>

//Reverse a user input string
int main() {
    std::string strInput = "";
    std::string strReversed = ""; //store reversed string
    
    //input
    std::cout<<"Enter string: ";
    std::cin>>strInput;
    strReversed = strInput;
    
    //reversing
    int strLength = strInput.length(); //size not zero index
    for(int ii = 0; ii < strLength; ii++){
        strReversed[ii] = strInput[(strLength - 1) - ii]; //indexing string, zero index
    }
    
    std::cout<<strReversed;
    
    return 0;
}
