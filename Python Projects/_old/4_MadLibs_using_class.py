import random

print('\n\nWelcome to Mad Libs! I\'m using a class thing for some reason!')

class MadLibs:
    def __init__(self):
        self.nounPerson = [input('Give name for person number ' + str(ehe+1) + ': ') for ehe in range(random.randint(1,3))] #stores 1-3 name nouns
        self.verb = input('Give a verb: ')
        self.nounPlace = input('Give name for a place: ')

    def sentenceConstructor(self):
        self.MadLib_Sentence = ''
        
        #Noun: Persons; strip excess whitespace
        for index, element in enumerate(userInputs.nounPerson):

            if index != len(userInputs.nounPerson)-1:
                self.MadLib_Sentence = self.MadLib_Sentence + element.strip() + ' and '
            else:
                self.MadLib_Sentence = self.MadLib_Sentence + element.strip() + ' '
                #won't print 'and' for last person noun

        #Verb; strip
        self.verb = self.verb.strip()
        if len(self.nounPerson) == 1:
            if self.verb[-1] != 's':
                self.verb = self.verb + 's'
        else:
            if self.verb[-1] == 's':
                self.verb = self.verb.rstrip(self.verb[-1]) #if s is last character of verb, rstrip last chracter of string
        #modified verb for singular or plural noun
        self.MadLib_Sentence = self.MadLib_Sentence + self.verb

        #Noun: Place
        self.nounPlace = self.nounPlace.strip()
        kk = random.randint(0,3)
        locationalPrefaces = {
            0:' in the ',
            1:' at the ',
            2:' on the ',
            3:' to the '
        }
        self.MadLib_Sentence = self.MadLib_Sentence + locationalPrefaces[kk] + self.nounPlace + '.'

    #NOTE to self: the self.attribute refers to the attribute of the var 'userInputs' below, designated in the class as 'self'
    #if we initialized another variable DOGGY.MadLibs(), the 'self' operations in the MadLibs class would refer to DOGGY
    #userInputs.MadLibs()...............................userInputs.sentenceConstructor()...........self refers to userInputs
    #DOGGY.MadLibs()...............................DOGGY.sentenceConstructor()...........self refers to DOGGY


if __name__ == "__main__":
    userInputs = MadLibs()
    userInputs.sentenceConstructor() 
    print(userInputs.MadLib_Sentence)
    
