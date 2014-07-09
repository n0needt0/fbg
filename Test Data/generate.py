import os
import sys
import random
import shutil

NUM_USERS = 50
MAX_DOCS = 30
NUM_WORDS = 1000
NUM_PDFS = 9
DICT_PATH = sys.argv[1] if len(sys.argv) > 1 else "/usr/share/dict/words"

print("Dictionary path is: ", DICT_PATH)
words = open(DICT_PATH).read().splitlines()
properties = open("properties.txt").read().splitlines()
types = properties[0].split(",")
names = properties[1].split(",")

if not os.path.exists("./data"):
        os.makedirs("./data")

for i in range(0, NUM_USERS):
    print("Currently generating user #", i)
    userDir = "./data/User" + str(i)
    if not os.path.exists(userDir):
        os.makedirs(userDir)

    numDocs = random.randint(1, MAX_DOCS)
    for j in range(0, numDocs):
        dirName = userDir + "/doc" + str(j)
        if not os.path.exists(dirName):
            os.makedirs(dirName)
        shutil.copyfile("./pdfs/" + str(random.randint(1, NUM_PDFS)) + ".pdf", dirName + "/document.pdf")

        exampleOCR = open(dirName + "/ExampleData_Text.txt", "w+")
        for k in range(1, NUM_WORDS + 1):
            exampleOCR.write(random.choice(words) + " ")
        exampleOCR.write("\n")
        exampleOCR.close()

        exampleFacets = open(dirName + "/ExampleData_Facets.json", "w+")
        exampleFacets.write("{\n")
        exampleFacets.write("\t\"name\": \"" + random.choice(names) + "\",\n")
        exampleFacets.write("\t\"date\": \"" + str(random.randint(1, 12)) + "/" +
                                               str(random.randint(1, 28)) + "/" +
                                               str(random.randint(10, 13)) + "\",\n")
        exampleFacets.write("\t\"pageNumber\": " + str(random.randint(1, 25)) + ",\n")
        exampleFacets.write("\t\"type\": \"" + random.choice(types) + "\",\n")
        exampleFacets.write("\t\"cc\": [")
        previousCC = False
        for name in names:
            if random.randint(1, 3) == 3:
                if previousCC:
                    exampleFacets.write(", ")
                previousCC = True
                exampleFacets.write("\"" + name + "\"")
        exampleFacets.write("]\n")

        exampleFacets.write("}\n")