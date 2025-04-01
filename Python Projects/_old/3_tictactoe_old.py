#todo: loosen code to allow for boards beyond 3x3

board = [ 
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0] 
    ]

translateBoard = {
    0: ' ',
    1: 'X',
    2: 'O',
}

winState = 0 #ongoing = 0, player win = 1, computer win = 2
boardElements = 0

for ii in range(len(board)):
    for jj in board[ii]:
        boardElements = boardElements + 1





#main loop
for i in range(2): 

    #Print current board state, translate values stored in board to XOXO using dictBoard
    for ii in range(len(board)):
        for jj in range(len(board[ii])):
            if jj != len(board[ii]) - 1: #length is 1 greater than actual indexing
                print( translateBoard[board[ii][jj]] + ' | ', end = '' )
            else: #if current index = last index of board column, dont print ' | '
                print(translateBoard[board[ii][jj]])
        print('---------')

    print('~~~~~~~~~\n1 | 2 | 3 \n---------\n4 | 5 | 6\n---------\n7 | 8 | 9\n---------') #reference

    userInput = int(input('Which grid will you place X in? >'))

    #X-placement
    # if userInput == 1:
    #     board[0][0] = 1
    # elif userInput == 2:
    #     board[0][1] = 1
    # elif userInput == 3:
    #     board[0][2] = 1
    # elif userInput == 4: 
    #     board[1][0] = 1
    # elif userInput == 5:
    #     board[1][1] = 1 
    # elif userInput == 6:
    #     board[1][2] = 1
    # elif userInput == 7:
    #     board[2][0] = 1
    # elif userInput == 8:
    #     board[2][1] = 1
    # elif userInput == 9:
    #     board[2][2] = 1
    # else:
    #     print('Please enter a valid position\n')
    #     userInput = int(input('Which grid will you place X in? >'))

    #X-placement, improved
    cat = 1 #current position value
    if userInput <= boardElements and userInput > 0: #check if input within valid range
        for dog in range(boardElements): #iterates through every position
            for ii in range(len(board)):
                for jj in range(len(board[ii])): #incrementing order corresponds to position value
                    if userInput == cat:
                        board[ii][jj] = 1
                        cat = cat + 1
                    else:
                        cat = cat + 1 #increment checked position value b4 moving to next coordinate
    else:
        print('Please enter a valid position\n')
        userInput = int(input('Which grid will you place X in? >'))       

    #refreshing following arrays each loop rather than detecting duplicates
    #index across both array correspond to single coordinate
    neighborROW_X = []
    neighborCOLUMN_X = []

    #Record Xs present on board
    for ii in range(len(board)):
        for jj in range(len(board[ii])):
            if board[ii][jj] == 1: 
                neighborROW_X.append(ii)
                neighborCOLUMN_X.append(jj)


    for pig in range(len(neighborROW_X)):
        print('Rows ii ' + str(neighborROW_X[ pig ]), end=', ')
        print('Columns jj ' + str(neighborCOLUMN_X[ pig ]))






#printing board last time
for ii in range(len(board)):
    for jj in range(len(board[ii])):
        if jj != len(board[ii]) - 1: #length is 1 greater than actual indexing
            print( translateBoard[board[ii][jj]] + ' | ', end = '' )
        else: #if current index = last index of board column, dont print ' | '
            print(translateBoard[board[ii][jj]])
    print('---------')