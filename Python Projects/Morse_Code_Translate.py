#Reference: https://students.cs.ucl.ac.uk/schoolslab/projects/PY2/introduction.html
#https://morsecode.world/international/translator.html

morse = {
    ".-":"A" ,
    "-...":"B" ,
    "-.-.":"C" ,
    "-..":"D" ,
    ".":"E" ,
    "..-.":"F" ,
    "--.":"G" ,
    "....":"H" ,
    "..":"I" ,
    ".---":"J" ,
    "-.-":"K" ,
    ".-..":"L" ,
    "--":"M",
    "-.":"N",
    "---":"O",
    ".--.":"P",
    "--.-":"Q",
    ".-.":"R",
    "...":"S",
    "-":"T",
    "..-":"U",
    "...-":"V",
    ".--":"W",
    "-..-":"X",
    "-.--":"Y",
    "--..":"Z",
    "/":" " #space
}

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
            