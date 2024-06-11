import re
import sys


repmaskf = open(sys.argv[1],"r")
fastaf = open(sys.argv[2],"r")

fout = open(sys.argv[3],"w")

#Read the fasta/histone locus file

histone_locus=""

for line in fastaf:

    if line[0]==">":
        continue

    cols =re.split("\n",line)
    histone_locus = histone_locus + cols[0]
    


SKIP_HEADER=2
line_no=1
Record=1

for line in repmaskf:

    if line_no == SKIP_HEADER:
        break
    line_no = line_no + 1


locus_start=-1
locus_end=-1
unit_id=1

for line in repmaskf:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    if cols_strip[9]=="start":
    
        curr_start = int(cols_strip[5])
        curr_end   = int(cols_strip[6])

        locus_start = curr_start

    elif cols_strip[9]=="end":
    
        curr_start = int(cols_strip[5])
        curr_end   = int(cols_strip[6])

        locus_end = curr_end

        str_seq    = histone_locus[(locus_start-1):locus_end] 
        str_header = ">Histone_Unit_" + str(unit_id) + " " + str(locus_start) + "_" + str(locus_end) + "_" + str(len(str_seq))

        fout.write(str_header) 
        fout.write("\n")
        fout.write(str_seq)
        fout.write("\n")

        unit_id = unit_id + 1

    else:
        pass 
