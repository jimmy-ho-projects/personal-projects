startingNum = [2,3,4,5,6,7,8,9,10]

for index, val in enumerate(startingNum):
    currValue = val #stores values after Collatz algorithm 
    print('Starting Number ', str(val) , ': ' , str(val), ', ', end = '')
    
    while currValue != 1:
        #Current Value is Even
        if currValue % 2 == 0:
            currValue = currValue / 2
            if currValue == 1:
                print(str(int(currValue)))
            else:
                print(str(int(currValue)), ', ', end='')
        else:
            currValue = (3 * currValue) + 1
            print(str(int(currValue)), ', ', end='')
    
            

