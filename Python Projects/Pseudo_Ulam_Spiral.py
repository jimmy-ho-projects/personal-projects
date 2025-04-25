'''
Port of MATLAB Pseudo Ulam Spiral project
Python port of modified ulam spiral. Number line originating from 0,0 will
proceed towards right 1 unit at a time. When a prime number of units is 
reached, the line direction will rotate 90 deg.
NOTE: excluding 0 and 1 generates wildly different graph
Created 4/1/25

Vers. 1.2 (4/2/25)
    * Replaced fixed prime array with function to generate specified number of primes
    * user-query stuff added
    * option to include or exlude 0 and 1 from list of primes
    * loading screen added

Vers. 1.3 (4/3/25)
    *Found way to display graph updating within loop using pyplot.ion(),
        plt.show(), and plt.pause(0.001). Soln found at
        https://stackoverflow.com/questions/28269157/plotting-in-a-non-blocking-way-with-matplotlib
    *Added query to determine if show animation (slow) or final results immediantly
    *Used time module to determine run time up to printed perentage of progress 

Vers. 1.4 (4/5/25)
    *Fixed accuracy of timer for prime generation (moved from before QUERY to after QUERY)
    *Added timer for graphing time (applicable for primes >1,000,000)
    *Reduced num of factors to check from range (2 -> int 0.5 of total) to (3 -> sqr root total, 2)
        to only check odd factors (all even factors would come from 2)
        MAYBE: check factors for smaller factors to further reduce computation with larger #s
    *Added 45 degree option from MATLAB vers
    *Added grid
    *Output formatting
    KNOWN ISSUES:
    - MEMORY LEAK: python plot grows in memory size as writing, problematic for large numbers >1000000, need a way to release
        memory while retaining plot that has already been written
        Massive lag spikes (>200s) at around 500s (when plotting 1000000)
        Plotting completes ~>800s but plot window 'not responding'
        https://discourse.matplotlib.org/t/pyplot-interface-and-memory-management/22299
        https://github.com/matplotlib/matplotlib/issues/27138
        https://dev.to/siddhantkcode/optimizing-matplotlib-performance-handling-memory-leaks-efficiently-5cj2
- Jimmy Ho
'''

from time import sleep, time
from math import sqrt
import matplotlib.pyplot as ploppy

#====== functions ==========
def loading_screen(beginTime, currentIter, arrayPercentages):
#ctrl+f DOGDOGDOGDOGDOGDOGwoofwoof
    '''
    _05 = arrayPercentages[0]
    _10 = arrayPercentages[1]
    _25 = arrayPercentages[2]
    _50 = arrayPercentages[3]
    _65 = arrayPercentages[4]
    _75 = arrayPercentages[5]
    _80 = arrayPercentages[6]
    _90 = arrayPercentages[7]
    _95 = arrayPercentages[8]
    _100 = arrayPercentages[9]'''
    time_elapsed = int(time() - beginTime)
    if currentIter == 1:
        print("[----------]....0% [" + str(time_elapsed) + " seconds elapsed]")
    #account for range function jumping by 2s
    if currentIter == int(arrayPercentages[9]) or currentIter == int(arrayPercentages[9]) - 1 or currentIter == int(arrayPercentages[9]) + 1:
        print("[██████████]....100% [" + str(time_elapsed) + " seconds elapsed]")
    try:
        ind_of_percentage = arrayPercentages.index(currentIter)
        match ind_of_percentage:
            case 0:
                print("[█--------].... 5% [" + str(time_elapsed) + " seconds elapsed]")
            case 1:
                print("[██--------]....10% [" + str(time_elapsed) + " seconds elapsed]")
            case 2:
                print("[███-------]....25% [" + str(time_elapsed) + " seconds elapsed]")
            case 3:
                print("[████------]....50% [" + str(time_elapsed) + " seconds elapsed]")
            case 4:
                print("[█████-----]....65% [" + str(time_elapsed) + " seconds elapsed]")
            case 5:
                print("[██████----]....75% [" + str(time_elapsed) + " seconds elapsed]")
            case 6:
                print("[███████---]....80% [" + str(time_elapsed) + " seconds elapsed]")
            case 7:
                print("[████████--]....90% [" + str(time_elapsed) + " seconds elapsed]")
            case 8:
                print("[█████████-]....95% [" + str(time_elapsed) + " seconds elapsed]")
            case _:
                ...
    except:
        ...
            
#+++ - - - MAIN - - - ++++++++++++++++++++++++++++++
#====== GENERATE PRIMES (pretty slow) ======
primes = []
loopVar = True
while loopVar:
    numPrimes = input("How many primes to find: ")
    try:
        numPrimes = int(numPrimes)
        if numPrimes > 1000:
            bloop = input("WARNING: Calculating more than 1000 primes will take some time. Are you sure?(Y/N) >")
            if bloop.isalpha(): 
                if bloop == 'y' or bloop == 'Y':
                    loopVar = False
                elif bloop == 'n' or bloop == 'N':
                    loopVar = True
                else:
                    print("Invalid response")
            else:
                print("Invalid response")
        else:
            loopVar = False
    except:
        print("Please enter a whole number")

'''
# Check if every odd # up to numPrimes is a prime, 
# inclusive range. Only need to check for factors 
# less than half of value, rounded down, excluding 1
'''

#doing division once to pass to loading_screen funct
#arbitrary chosen values, assume inverse exp computation
#speed given number of inputs (DOGDOGDOGDOGDOGDOGwoofwoof)
percentage_numPrimes = [int(numPrimes * .05), int(numPrimes * .1),
                        int(numPrimes / 4), int(numPrimes / 2), 
                        int(numPrimes * 0.65), int(numPrimes * 0.75), 
                        int(numPrimes * 0.8), int(numPrimes * 0.90), 
                        int(numPrimes * 0.95), numPrimes]
#`````````````````````````````````````````````````````````````````````

beginTime = time()
currVal = 0
for slug in range(1, numPrimes+1, 2):
    loading_screen(beginTime, slug, percentage_numPrimes) #loading screen funct 
    currVal = slug
    notPrime = False
    for factor_check in range(3, int(sqrt(currVal)), 2):
        if currVal % factor_check == 0:
            notPrime = True
            break
    if notPrime == False:
        primes.append(currVal)        
#2 is the only even prime, lil bugger (manual insert)
primes.insert(1, int(2))
# ================================================================

#=========== USER QUERY ==========================================
#Query: Include 0 and 1? (Not considered primes but will alter graph without them)
loopVar = True
while loopVar:
    include_zero_one = input("Include 0 and 1 with primes? (Y/N) >")
    if include_zero_one.isalpha(): 
        if include_zero_one == 'y' or include_zero_one == 'Y':
            #1 already included, add 0
            primes.insert(0, int(0))
            loopVar = False
        elif include_zero_one == 'n' or include_zero_one == 'n':
            #1 already included, remove 1
            primes.pop(0)
            loopVar = False
        else:
            print("Invalid response, try again (Y/N) >")
#Query: 90 or 45 degree rotation (counter-clockwise)? 
loopVar = True
while loopVar:
    include_zero_one = input("90 or 45 degree rotation (counter-clockwise)? ([Y] 90 deg / [N] 45 deg) >")
    if include_zero_one.isalpha(): 
        if include_zero_one == 'y' or include_zero_one == 'Y':
            #variable to enable/disable 45/90 ctrl+F SPINNYMEEE
            spin = 90
            loopVar = False
        elif include_zero_one == 'n' or include_zero_one == 'n':
            spin = 45
            loopVar = False
        else:
            print("Invalid response, try again ([Y] 90 deg / [N] 45 deg) >")
#Query: Animation or immediate?   
loopVar = True
while loopVar:
    anim_or_nah = input("Show plot animation (slow!)? (Y/N) >")
    if anim_or_nah.isalpha(): 
        if anim_or_nah == 'y' or anim_or_nah == 'Y':
            ploppy.ion() #allows for updating graph in loop
            anim_enable = True #to determine if enable anim, ctrl+f ANIMATEMEDADDY
            loopVar = False
        elif anim_or_nah == 'n' or anim_or_nah == 'n':
            anim_enable = False #ctrl+f ANIMATEMEDADDY
            loopVar = False
        else:
            print("Invalid response, try again (Y/N) >")
# ================================================================

print("Primes: " + str(primes))

#============= Print Funny ulam spiral magic =============================
x=0 
y=0 
u=1 
v=0

primeCounter = 0 #incrememnt to index through primes list
rotationCount = 0 #increments through rotation

#simple rotating vectors
ploppy.figure(clear = False, figsize=(9,9)) #fig to save prev plotted graph
ploppy.plot(0,0, 'or')
beginTime = time()
#keyword: SPINNYMEEE
#90 degree spinning
if spin == 90:
    for i in range(primes[-1]): #iterate linearly until reach value at last index of "primes"
        #move to new (x,y) coord BEFORE changing rotation
        if u == 1:
            x = x + 1
        if v == 1:
            y = y + 1
        if u == -1:
            x = x - 1
        if v == -1:
            y = y - 1


    #checks if iteration is greater or equal to prime
    #if so, will increment to next prime on list and 
    #tell next vector to rotate 90 deg, counter-clockwise

        
        if i >= primes[primeCounter]:
            primeCounter = primeCounter + 1
            rotationCount = rotationCount + 1        
        
        modRotCnt = rotationCount % 4
        match modRotCnt: #if iterate to a prime, rotate 90 degrees
            case 0:
                u = 1; v = 0;
            case 1:
                u = 0; v = 1;
            case 2:
                u = -1; v = 0;
            case 3:
                u = 0; v = -1;
        if i % 1000 == 0 or i == primes[-1]-1:
            #will only print every 50 ticks rather than every loop, should be faster-ish (i want updating ui)
            print("Plotting..." + str(i) + '/' + str(primes[-1]) + '[' + str(int(time()-beginTime)) + " seconds elapsed]", end = '\r', flush = True)
        ploppy.plot([x, x+u],[y, y+v], '-')
        ploppy.draw()
        if anim_enable: #keyword: ANIMATEMEDADDY
            ploppy.pause(0.0001)
# 45 degree spinning
else:
    for i in range(primes[-1]): 
        if u == 1:
            x = x + 1
        if u == 1 and v == 1:
            x = x + 1
            y = y + 1
        if v == 1:
            y = y + 1
        if u == -1 and v == 1:
            x = x - 1
            y = y + 1
        if u == -1:
            x = x - 1
        if u == -1 and v == -1:
            x = x - 1
            y = y - 1
        if v == -1:
            y = y - 1
        if u == 1 and v == -1:
            x = x + 1
            y = y - 1
        
        if i >= primes[primeCounter]:
            primeCounter = primeCounter + 1
            rotationCount = rotationCount + 1        
        
        modRotCnt = rotationCount % 8
        match modRotCnt:
            case 0:
                u = 1
                v = 0
            case 1:
                u = 1
                v = 1
            case 2:
                u = 0 
                v = 1
            case 3:
                u = -1
                v = 1
            case 4:
                u = -1
                v = 0
            case 5:
                u = -1
                v = -1
            case 6:
                u = 0
                v = -1
            case 7:
                u = 1
                v = -1
        if i % 1000 == 0 or i == primes[-1]-1:
            #will only print every 50 ticks rather than every loop, should be faster-ish (i want updating ui)
            print("Plotting..." + str(i) + '/' + str(primes[-1]) + '[' + str(int(time()-beginTime)) + " seconds elapsed]", end = '\r', flush = True)
        ploppy.plot([x, x+u],[y, y+v], '-')
        ploppy.draw()
        if anim_enable: #keyword: ANIMATEMEDADDY
            ploppy.pause(0.0001)

ploppy.ioff()
ploppy.grid(alpha=0.25)
ploppy.show()
print("Program completed                                           ")
# ==================================================================
#+++ - - - END MAIN - - - ++++++++++++++++++++++++++++++