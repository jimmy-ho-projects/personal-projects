import random


def isValidInput(userGuess, currWord_Attributes):
    
    while len(userGuess) > 1 or (len(userGuess) == 1 and userGuess.isalpha() is not True): #checks valid character type
        userGuess = input('Please guess a single letter: ')

    for index, char_at_index in currWord_Attributes: #checks if repeated right guess       
        while userGuess == char_at_index and letterHolder[index] == char_at_index:
            userGuess = input('You\'ve already guessed that letter: ')

    wrongLetters_attributes = list(enumerate(wrongLetters[13:])) #index and wrong char guessed

    for index, char_at_index in wrongLetters_attributes: #checks if repeated wrong guess            
        while userGuess == char_at_index:
            userGuess = input('You\'ve already guessed that letter: ')
    
    return userGuess

def drawingTheHangMan(guesses_Left):
    hangman_limbs = {
        5: ' o ',
        4: ' o \n |',
        3: ' o \n/|',
        2: ' o \n/|\\',
        1: ' o \n/|\\ \n/',
        0: ' o \n/|\\ \n/ \\',
    }
    print('\n' + hangman_limbs[guesses_Left])


#TODO: address spaces in hangmanWord, ex turn '_' corresponding to spaces back to spaces or somthing
hangmanWords = {
    0: 'highway', 1: 'lion', 2:'anteater', 3:'chicken', 4: 'tortoise', 5: 'armadillo',
    6: 'rio grande', 7: 'bird of prey', 8: 'very big dinosaur', 9: 'toe chomper', 10: 'unverified immigration'
}

currWord = hangmanWords[
random.randint(0,5)]
currWord_Attributes = list(enumerate(currWord))
userGuess = ''
letterHolder = ''
for ii, char in currWord_Attributes:
    if char == ' ':
        letterHolder = letterHolder + ' '
    else:
        letterHolder = letterHolder + '_'
wrongLetters = 'Wrong Letters:'
guesses_Left = 6


if __name__ == '__main__':
    print('\n\nWelcome to Hangman!')

    #Main Game Loop
    while guesses_Left != 0: 
        print(letterHolder)
        print('Current Number of Guesses left: ' + str(guesses_Left)) 
        print(wrongLetters)
        userGuess = input('Guess the next letter in the sequence: ').strip().lower() #strips input, lowercase
        userGuess = isValidInput(userGuess, currWord_Attributes)
        
        old_letterHolder = letterHolder #stores previous letterHolder state
        
        for index, char_at_index in currWord_Attributes:            
            if userGuess == char_at_index:
                letterHolder = letterHolder[0:index] + userGuess + letterHolder[index+1:] #replacing '_' using string splicing
        if old_letterHolder == letterHolder: #if letterHolder did not update, user did not guess a character in the word
            wrongLetters = wrongLetters + ' ' + userGuess
            guesses_Left -= 1
            drawingTheHangMan(guesses_Left)

        if letterHolder == currWord: #Win Condition
            print('The word was: ' + currWord)
            print('Congrats! You won!')
            break
    
    #loss Condition
    if guesses_Left == 0:
        print('The word was: ' + currWord)
        print('Out of Guesses! You lose!')