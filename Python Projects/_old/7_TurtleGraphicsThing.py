from turtle import * #imports everything from turtle module

class control:
    travel_speed = 1

    def Left():
        left(90)
    def Right():
        right(90)
    def Forward():
        control.travel_speed = 2
    def Backward():
        control.travel_speed =  1
    def Space():
        pass
        #shortcut to terminate game window

speed(1)

while True:
    speed(control.travel_speed)
    forward(5) #distance travelled per unit time

    #user inputs
    listen() #listens for keyboard inputs
    
    onkeypress(control.Left, "Left") #on key press <- call func to turn left 45 degrees
    onkeypress(control.Right, "Right")
    onkeypress(control.Forward, "Up")
    onkeypress(control.Backward, "Down")
    onkeypress(control.Space, "space")
    print('Current Turtle Speed: ' + str(control.travel_speed))
done()