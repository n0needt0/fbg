import os
import sys
import random
import shutil
import string

NUM_USERS, MAX_DOCS, NUM_WORDS, NUM_PDFS, URI_MIN, URI_MAX = 80, 15, 1000, 9, 10, 20
DICT_PATH = sys.argv[1] if len(sys.argv) > 1 else "/usr/share/dict/words"

print("Dictionary path is: ", DICT_PATH)
words = open(DICT_PATH).read().splitlines()
properties = open("properties.txt").read().splitlines()
types, names, locations, groups = (propList.split(",") for propList in properties)


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
        exampleFacets.write("\t\"doc_folder\": \"" +
                            "_".join(reversed(random.choice(names).split())) +
                            "_" + "".join(str(random.randint(0, 9)) for k in range(0, 4)) +
                            "\",\n")
        exampleFacets.write("\t\"doc_uri\": \"" +
                            "/docs/repository/" +
                            "".join(random.choice(string.ascii_letters) for k in range(0, random.randint(URI_MIN, URI_MAX))) +
                            "\",\n")
        exampleFacets.write("\t\"doc_date\": \"" +
                            str(random.randint(1, 12)) + "/" +
                            str(random.randint(1, 28)) + "/" +
                            str(random.randint(10, 13)) + "\",\n")
        exampleFacets.write("\t\"doc_type\": \"" + random.choice(types) + "\",\n")
        exampleFacets.write("\t\"doc_group\": \"" + random.choice(groups) + "\",\n")
        exampleFacets.write("\t\"doc_location\": \"" + random.choice(locations) + "\",\n")
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
        exampleFacets.close()