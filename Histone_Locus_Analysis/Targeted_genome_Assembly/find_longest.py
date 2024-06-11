import re
import sys


flst = open(sys.argv[1],"r")
longest=int(sys.argv[2])
loci_size=int(sys.argv[3])

target_bases = loci_size*longest

curr_tot=0

for line in flst:

    cols = re.split("\t|\n",line)

    rname = cols[0]
    len   = int(cols[1])

    curr_tot = curr_tot + len

    if curr_tot >= target_bases:
        print(rname)
        break

    print(rname)

