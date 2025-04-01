#TODO: alter boardCheck() function to allow for multiple types of winstates (ex: 5 in row), including being able to detect distance upwards and downwards if
#only given board ROW and COLUMN dimensions

import random

board = []
boardRow = 3
boardColumn = 3
numElements = boardRow * boardColumn

# 1 | 2 | 3
# 4 | 5 | 6
# 7 | 8 | 9
for ii in range(numElements):
    board.append([])
    board[ii] = 0

translateBoard = {
    0: ' ',
    1: 'X',
    2: 'O',
}

def printBoard(board, winstate):
    #Print current board state, translate values stored in board to XOXO using dictBoard
    for ii in range(numElements):
        if (ii+1) % boardColumn != 0: #indexing 1 less than actual board dimensions 
            print( translateBoard[board[ii]] + ' | ', end = '' )
        else: #if current index = last index of board column, dont print ' | '
            print(translateBoard[board[ii]])
            print('---------')
    if winstate == 0:
        print('~~~~~~~~~\n1 | 2 | 3 \n---------\n4 | 5 | 6\n---------\n7 | 8 | 9\n---------') #reference                   

def boardCheck(XorO, XOboard):
    #XorO: 1 = X, 2 = O
    #check if possible 3 in rows present in X positions
        # 1 - 2 - 3
        # | \ | / |
        # 4 - 5 - 6
        # | / | \ |
        # 7 - 8 - 9
    for ij in XOboard:
        if ij+1 in XOboard and ij+2 in XOboard:
            return(XorO)
        elif ij+3 in XOboard and ij+6 in XOboard:
            return(XorO)
        elif ij-3 in XOboard and ij-6 in XOboard:
            return(XorO)
        elif ij+4 in XOboard and ij+8 in XOboard:
            return(XorO)
        elif ij-4 in XOboard and ij-8 in XOboard:
            return(XorO)
        else:
            return(0)
    

#main loop
winstate = 0
while winstate == 0: 

    printBoard(board, winstate)

    userInput = int(input('Which grid will you place X in? >'))

    #X-placement, simplified; note: board indexing 1 less actual position 
    while userInput > numElements or userInput < 0 or board[userInput-1] != 0: 
        #check if input out valid range AND occupied
        print('Please enter a valid position')
        userInput = int(input('Which grid will you place X in? >')) 
    else:
        board[userInput-1] = 1 

    X_Board = [i+1 for i, e in enumerate(board) if e == 1]
    #stores positions on board marked  w/ X
        #if given index "i" and element "e" from enumerate of "board"
        #store index of element when e=='desired value'
    
    winstate = boardCheck(1, X_Board) 
    if winstate == 1:
        print('Congratulations! You\'ve won!')
        break

    #O-placement by AI
    AIchoice = random.randint(0,8)
    while board[AIchoice] != 0: 
        AIchoice = random.randint(0,8)
        #check if input IS occupied 
    else:
        board[AIchoice] = 2

    O_Board = [i+1 for i, e in enumerate(board) if e == 2]
    winstate = boardCheck(2, O_Board)
    if winstate == 2:
        print('Sorry! You Lost!')
        break
       
printBoard(board,winstate)