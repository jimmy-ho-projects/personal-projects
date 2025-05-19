#Reference: https://students.cs.ucl.ac.uk/schoolslab/projects/PY2/introduction.html
#https://morsecode.world/international/translator.html

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

print(inverse_morse)

print("Enter Morse code to convert to text. Separate each character with a space. Use '/' to indicate space character in text.")
#example input: .... . .-- .-- --- / .... .-- ..- -- .- -.

txt_input = input("> ")
txt = txt_input.split()

for ii in txt:
    try:
        morse2txt = morse[ii]
        print(morse[ii], end = "")
    except:
        print("\n" + ii + " is not an accepted input")
            