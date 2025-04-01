



numInput = input("How many names will you be adding?\n>")
listNames = []
for i in range(int(numInput)):
    listNames.append(
        input("Name #" + str(i+1) + ": ")
        )
for names in listNames:
    print(names)
