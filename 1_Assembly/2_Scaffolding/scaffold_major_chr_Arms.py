def reverse_complement(dna): # Taken from internet
    complement = {'A': 'T', 'C': 'G', 'G': 'C', 'T': 'A'}
    return ''.join([complement[base] for base in dna[::-1]])

def Write_Scaf():

    print("Writing Scaffold",previous_scaf_name,"to new fasta file .................")

    len_curr_scf = len(current_scaf)
    track_print=0
    
    fasta_header = ">" + previous_scaf_name
    fout.write(fasta_header)
    fout.write("\n")
    
    while(track_print < len_curr_scf):
        fout.write(current_scaf[track_print:(track_print + BASES_PER_LINE)])
        fout.write("\n")

        track_print = track_print + BASES_PER_LINE  
  
    fout.write(current_scaf[track_print:])
    fout.write("\n")


import re
import sys

fasta_file = open(sys.argv[1],"r")
scaf_file  = open(sys.argv[2],"r")


## Read the fasta file and put it in a dictonary

SeqDic = {}
first = True

for line in fasta_file:

    if line=="\n": # Skip empty lines
        continue

    if line[0]==">": # header start of a new contig

        if first==True:
            current_contig = ""
            first=False
        else:
            SeqDic[current_contig_name] = current_contig  # Process the last contig
            del current_contig
            current_contig = ""

        col1 = re.split(">|\n",line)
        current_contig_name = col1[1]
    else:
        col1 = re.split("\n",line)
        current_contig = current_contig + col1[0]        

SeqDic[current_contig_name] = current_contig # process the last contig
#print(SeqDic)


## Scaffold using the scafolding file and write it to new file

fout = open(sys.argv[3],"w")
BASES_PER_LINE = 80   # DEFAULT IS 60

Thousand_N=''.join([char*1000 for char in 'N'])

for line in scaf_file: # Ignore the header
    break

previous_scaf_name=""
contigs_proccesed=[]
for line in scaf_file:

    if line=="\n": # Skip empty lines
        continue
 

    if previous_scaf_name=="":

        col1 = re.split("\t|\n",line)
        current_scaf_name   = col1[0]
        current_contig_name = col1[1]
        orientation         = col1[2]
      

        if orientation=="+":
            current_scaf = SeqDic[current_contig_name]
        elif orientation=="-":
            current_scaf = reverse_complement(SeqDic[current_contig_name])
        else:
            print("Error:Not proper orientation")

        contigs_proccesed.append(current_contig_name)
        previous_scaf_name = current_scaf_name

    else:

        col1 = re.split("\t|\n",line)
        current_scaf_name   = col1[0]
        current_contig_name = col1[1]
        orientation         = col1[2]

        if current_scaf_name==previous_scaf_name: # Continue to add new contig seqs to the end

            if orientation=="+":
                current_scaf = current_scaf + Thousand_N + SeqDic[current_contig_name]
            elif orientation=="-":
                current_scaf = current_scaf + Thousand_N + reverse_complement(SeqDic[current_contig_name])
            else:
                print("Error:Not proper orientation") 

            contigs_proccesed.append(current_contig_name)
            previous_scaf_name = current_scaf_name


        else:                                    # current_scaf_name != previous_scaf_name - Write the older scaf to file and start processing the new one

            Write_Scaf()                        # write the older scaf to new file
            del current_scaf                    # delete the older scaf sequence          
             
            if orientation=="+":
                current_scaf = SeqDic[current_contig_name]
            elif orientation=="-":
                current_scaf = reverse_complement(SeqDic[current_contig_name])
            else:
                print("Error:Not proper orientation")

            contigs_proccesed.append(current_contig_name)
            previous_scaf_name = current_scaf_name


Write_Scaf()                        # write the last scaf to new file
del current_scaf

### Write the remaining contigs as is

for contig_name in SeqDic:
    if contig_name not in contigs_proccesed:
        current_scaf = SeqDic[contig_name]
        previous_scaf_name = contig_name
        Write_Scaf()


fout.close()
