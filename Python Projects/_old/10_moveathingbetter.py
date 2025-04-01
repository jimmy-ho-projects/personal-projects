import string

class Grid:
    dimensions = [4,5] #row, column
    activePos = {}
    def draw():
        for ii in range(Grid.dimensions[0]): #iterate row
            for jj in range(Grid.dimensions[1]): #iterate column
                notEmpty = False    #is current position empty
                for xx in Grid.activePos:           #iterate through current positions stored in dict   
                    if isinstance(Grid.activePos[xx], list) == True: #if list, only 1 coord stored at key
                        if [jj,ii] == Grid.activePos[xx]:
                            print(xx.sprite, end=' ')
                            notEmpty = True
                    else:                                      #if not list, multiple coords stored at key
                        for yy in Grid.activePos[xx]:
                            if [jj,ii] == yy:
                                print(xx.sprite, end=' ')
                                notEmpty = True
                if notEmpty == False:   #if not sprite in position, use default bkgd sprite
                    print('"', end=' ')
            print('\n')
class Player:
    sprite = '*'
    position = [0,0]
    def movementInput():
        inputLoop = True
        while inputLoop == True:
            userInput = input('WASD buttons to move, E to exit\nUser Input > ')
            userInput.lower()

            #if valid input, loop exits, return True to mainLoop
            if userInput == 'w':
                Player.position[1] = Player.position[1] - 1
                inputLoop = False
                return True
            elif userInput == 'a':
                Player.position[0] = Player.position[0] - 1
                inputLoop = False
                return True
            elif userInput == 's':
                Player.position[1] = Player.position[1] + 1
                inputLoop = False
                return True
            elif userInput == 'd':
                Player.position[0] = Player.position[0] + 1
                inputLoop = False
                return True
            elif userInput == 'e':
                inputLoop = False
                return False
            else:
                print('Invalid input')

class Walls:
    sprite = '8'
    position = [3,1], [3,2], [3,3]
    # self not initialized, not recognize own class unless using a function inside this class
    # for ii in Walls.position:
    #     Grid.activePos.update({Walls:ii})
def updatePos():
    Grid.activePos.update({Player:Player.position})
    Grid.activePos.update({Walls:Walls.position})

mainLoop = True

while mainLoop == True:
    updatePos()
    Grid.draw()
    mainLoop = Player.movementInput() #user can exit with 'e' under Player.movementInput
    

print('exit')
