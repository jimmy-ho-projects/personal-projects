#todo: auto capitalize first letters of patient's name

patientHistory = {
    "Name": {},
    "DOB": [],
    "ID": {},
}

patientHistory["Name"] = input("What is the patiet's full name?\n")

for i in range(3):
    ddmmyy = {
        0:"year",
        1:"month",
        2:"day"
    }
    
    #query valid year
    if i == 0:
        while True:
            temp = int(input("What is the patient's DOB (DD/MM/YY) " +
                ddmmyy[i] +
                "?\n"))
            if temp >= 2015 or temp <= 1870:
                print("Please enter a date between 1870 and 2015")
            else:
                break
        patientHistory["DOB"].append(temp)
    
    #query valid month
    elif i == 1:
        while True:
            temp = int(input("What is the patient's DOB (DD/MM/YY) " +
                ddmmyy[i] +
                "?\n"))
            if temp >= 12 or temp <= 0:
                print("Please enter a valid month")
            else:
                break
        patientHistory["DOB"].append(temp)
    
    #query valid day
    elif i == 2:
        daysPerMonth = {
            1: 31,
            2: 28,
            3: 31,
            4: 30,
            5: 31,
            6: 30,
            7: 31,
            8: 31,
            9: 30,
            10: 31,
            11: 30,
            12: 31
        }

        #check if leap year, modify number of days in Feb if TRUE
        if patientHistory["DOB"][0] % 10 == 0: #check for end-of-century years
            if patientHistory["DOB"][0] % 400 == 0:
                daysPerMonth[2] = 29
        elif patientHistory["DOB"][0] % 4 == 0:
                daysPerMonth[2] = 29

        while True:
            temp = int(input("What is the patient's DOB (DD/MM/YY) " +
                ddmmyy[i] +
                "?\n"))
            if temp > daysPerMonth[patientHistory["DOB"][1]] or temp <= 0:
                print("Please enter a valid date")
            else:
                break
        patientHistory["DOB"].append(temp)

patientHistory["ID"] = int(input("Patient ID: "))

print("\n")
print("Patient Information")
for i in patientHistory:
    if i == "DOB":
        print("DOB (DD/MM/YYYY): " + str(patientHistory[i][2]) + '/' + 
        str(patientHistory[i][1]) + '/' +
        str(patientHistory[i][0])
        )
    else:
        print(i + ": " + str(patientHistory[i]))

print("\njimsble wtf r u doing it's 3:21am")