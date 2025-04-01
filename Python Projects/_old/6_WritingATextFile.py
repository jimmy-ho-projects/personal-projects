
def clear_txtfile(morbius):
    morbius.write

file_Location = 'C:/Users/Jimmy/Desktop/python messing around/6_WritingATextFile Folder'
file_Name = '/Hello_world.txt'

morbius = open(file_Location+file_Name, 'r+', encoding = "utf-8")
    # "r"   Opens a file for reading only.
    # "r+"  Opens a file for both reading and writing.
    # "rb"  Opens a file for reading only in binary format.
    # "rb+" Opens a file for both reading and writing in binary format.
    # "w"   Opens a file for writing only.
    # "a"   Open for writing. The file is created if it does not exist.
    # "a+"  Open for reading and writing.  The file is created if it does not exist.

morbius.write('Hello World!\nThis file was writtent through a python script!') 
print(morbius.read())
morbius.close()
