#Reference: https://students.cs.ucl.ac.uk/schoolslab/projects/PY2/introduction.html
#https://morsecode.world/international/translator.html
'''
Morse Code Translater
Uses Python dict method to translate morse code input into upper case english char.
Can detect english char to translate to morse. Displays individual char and associated 
translation. Will ignore any invalid characters (aka anything that isn't morse code
chars .-/ or english alphabet.) Made it cuz why not.
Completed 20 May 2025
- Jimmy Ho
'''

#dict MORSE -> LETTERS
morse = {
    ".-":"A" , "-...":"B" , "-.-.":"C" , "-..":"D" ,
    ".":"E" , "..-.":"F" , "--.":"G" , "....":"H" ,
    "..":"I" , ".---":"J" , "-.-":"K" , ".-..":"L" ,
    "--":"M", "-.":"N", "---":"O", ".--.":"P",
    "--.-":"Q", ".-.":"R", "...":"S", "-":"T",
    "..-":"U", "...-":"V", ".--":"W", "-..-":"X",
    "-.--":"Y", "--..":"Z", "/":" " #space
}

#dict LETTERS -> MORSE
inverse_morse = {}
for x in morse:
    inverse_morse[morse[x]] = x

#print(inverse_morse)

print("[Enter Morse code to convert to text.] \nSeparate each character with a space. Use '/' to indicate space character in text.\nInvalid characters will be ignored")
#example input: .... . .-- .-- --- / .... .-- ..- -- .- -.

txt_input = input("> ")
txt = txt_input.split()
final_string = ""

for ii in txt:
    print(ii, end = " (")
    if ii[0] == '-' or ii[0] == '.' or ii[0] == '/': #check first char, assume morse of text sequence
        try:
            morse2txt = morse[ii]
            print(morse2txt, end = "")
            final_string = final_string + morse2txt #no spaces for str separator (combine txt)
        except:
            pass
            #print(ii + " NOT ACCEPTED" , end = " ")
    else:
        for jj in ii: #index through each char
            try:
                char2morse = inverse_morse[jj.upper()] #passing upper case char 
                print(char2morse, end = " ")
                final_string = final_string + " " + char2morse #spac str separator (separate morse characters)
            except:
                pass
                #print(jj + " NOT ACCEPTED" , end = " ")
    print(")")
    
print("\n=======[ FULL TEXT ]========" + "\n" + final_string)