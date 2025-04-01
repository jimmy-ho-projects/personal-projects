import string
import os

# Get current directory
directoryName = os.path.dirname(__file__)

#import mapdata.txt
mapData = open(directoryName)

class Grid:
    layout = [ 
        [ 0, 0, 0, 0, 0], 
        [ 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0]]
    def draw():
        for i in range(len(Grid.layout)):
            for j in range(len(Grid.layout[i])):
                print(Grid.layout[i][j], end=' ')
            print('\n')
class Player:
    sprite = '*'
    input = ''
    currPosition = [0,0]     
    oldPosition = []
    def updatePosition():
        Grid.layout[Player.currPosition[0]][Player.currPosition[1]] = Player.sprite
        if bool(Player.oldPosition) != False: #if empty
            Grid.layout[Player.oldPosition[0]][Player.oldPosition[1]] = 0
        
        

loopEnable = True

while loopEnable == True:
    Player.updatePosition()
    

    print('\n')
    Grid.draw()
    print('WASD buttons to move, E to exit')


    Player.input = input('User Input > ')
    Player.input.lower()
    
    
    if Player.input == 'w':
        
        print(Player.currPosition)
        print(Player.oldPosition)
        Player.currPosition[0] = Player.currPosition[0] - 1
        print(Player.currPosition)
        print(Player.oldPosition)
    # elif Player.input == 'a':
    #     Player.currPosition[1] = Player.currPosition[1] - 1
    # elif Player.input == 's':
    #     Player.currPosition[0] = Player.currPosition[0] + 1
    # elif Player.input == 'd':
    #     Player.currPosition[1] = Player.currPosition[1] + 1
    elif Player.input == 'e':
        loopEnable = False
    else:
        print('Invalid input')
    
    
print('exit')

