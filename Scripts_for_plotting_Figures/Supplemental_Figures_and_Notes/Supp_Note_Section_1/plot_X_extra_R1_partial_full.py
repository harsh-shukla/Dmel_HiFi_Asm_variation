import re
import sys
import matplotlib.pyplot as plt
import numpy as np

color_dic = {'92_Repeat_rRNA':'xkcd:kelly green','329_Repeat_rRNA':'xkcd:kelly green','240_Repeat_rRNA':'xkcd:kelly green','rRNA':'xkcd:kelly green','R2_DM':'xkcd:white','Stellate':'xkcd:white','LTR':'xkcd:white','LINE':'xkcd:white','DNA':'xkcd:white','Low_complexity':'xkcd:white','Simple_repeat':'xkcd:white','NA':'xkcd:white'}

specific_repeat_arr=['92_Repeat_rRNA','329_Repeat_rRNA','240_Repeat_rRNA','R1_DM','R2_DM']

#'R1_DM':'xkcd:light orange' or 'R1_DM':'light grey' .....  R1 Length : 5356
R1_LEN = 5356
offset = 2

####################################

f1 = open(sys.argv[1],"r")

print(sys.argv[1])

SKIP_HEADER=2
line_no=1
for line in f1:

    if line_no == SKIP_HEADER:
        break
    line_no = line_no + 1
    

rect_arr_1=[]
colr_arr_1=[]
prev_end=-1

for line in f1:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    curr_start = int(cols_strip[5])
    curr_end   = int(cols_strip[6])

    curr_box  = (curr_start,(curr_end-curr_start))

    if cols_strip[9] in specific_repeat_arr:
        if cols_strip[9]!="R1_DM":
            curr_colr = color_dic[cols_strip[9]]
        else:            
            ref_coverage = curr_end - curr_start + 1
            if cols_strip[8]=="+":
                query_start     = int(cols_strip[11]) 
                query_end       = int(cols_strip[12])
                query_coverage  = query_end - query_start + 1
            else:
                query_start     = int(cols_strip[13]) 
                query_end       = int(cols_strip[12])
                query_coverage  = query_end - query_start + 1
                
            if query_coverage >= (R1_LEN-offset):
                curr_colr = 'xkcd:light orange'
                print(curr_start,"\t",ref_coverage,"\t",query_coverage,"\t",(query_coverage-ref_coverage))
            else:
                curr_colr = 'xkcd:light grey'    

                 
    else:

        if cols_strip[10]=="rRNA":
            curr_colr=color_dic["rRNA"]
        elif cols_strip[10]=="Stellate":   
            curr_colr=color_dic["Stellate"]
        elif cols_strip[10][0:3]=="LTR":   
            curr_colr=color_dic["LTR"]
        elif cols_strip[10][0:4]=="LINE":   
            curr_colr=color_dic["LINE"]
        elif cols_strip[10][0:3]=="DNA":   
            curr_colr=color_dic["DNA"]
        elif cols_strip[10]=="Low_complexity":   
            curr_colr=color_dic["Low_complexity"]
        elif cols_strip[10]=="Simple_repeat":   
            curr_colr=color_dic["Simple_repeat"]
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start-1)<=prev_end or prev_end==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_1.append(curr_box)
        colr_arr_1.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end+1
        extra_len   =  (curr_start-1) - (prev_end+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_1.append(NA_box)
        colr_arr_1.append(NA_colr)

        rect_arr_1.append(curr_box)
        colr_arr_1.append(curr_colr)
    
    prev_end = curr_end
    #print(line)
    #print(rect_arr_1)
    #print(colr_arr_1)    
    #break 

#print(rect_arr_1)
#print(colr_arr_1)
print("############################################################################################################")

xlim = max(prev_end,0)

####################################

f2 = open(sys.argv[2],"r")

print(sys.argv[2])

SKIP_HEADER=2
line_no=1
for line in f2:

    if line_no == SKIP_HEADER:
        break
    line_no = line_no + 1
    

rect_arr_2=[]
colr_arr_2=[]
prev_end=-1

for line in f2:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    curr_start = int(cols_strip[5])
    curr_end   = int(cols_strip[6])

    curr_box  = (curr_start,(curr_end-curr_start))

    if cols_strip[9] in specific_repeat_arr:
        if cols_strip[9]!="R1_DM":
            curr_colr = color_dic[cols_strip[9]]
        else:            
            ref_coverage = curr_end - curr_start + 1
            if cols_strip[8]=="+":
                query_start     = int(cols_strip[11]) 
                query_end       = int(cols_strip[12])
                query_coverage  = query_end - query_start + 1
            else:
                query_start     = int(cols_strip[13]) 
                query_end       = int(cols_strip[12])
                query_coverage  = query_end - query_start + 1
                
            if query_coverage >= (R1_LEN-offset):
                curr_colr = 'xkcd:light orange'
                print(curr_start,"\t",ref_coverage,"\t",query_coverage,"\t",(query_coverage-ref_coverage))
            else:
                curr_colr = 'xkcd:light grey'

    else:

        if cols_strip[10]=="rRNA":
            curr_colr=color_dic["rRNA"]
        elif cols_strip[10]=="Stellate":   
            curr_colr=color_dic["Stellate"]
        elif cols_strip[10][0:3]=="LTR":   
            curr_colr=color_dic["LTR"]
        elif cols_strip[10][0:4]=="LINE":   
            curr_colr=color_dic["LINE"]
        elif cols_strip[10][0:3]=="DNA":   
            curr_colr=color_dic["DNA"]
        elif cols_strip[10]=="Low_complexity":   
            curr_colr=color_dic["Low_complexity"]
        elif cols_strip[10]=="Simple_repeat":   
            curr_colr=color_dic["Simple_repeat"]
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start-1)<=prev_end or prev_end==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_2.append(curr_box)
        colr_arr_2.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end+1
        extra_len   =  (curr_start-1) - (prev_end+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_2.append(NA_box)
        colr_arr_2.append(NA_colr)

        rect_arr_2.append(curr_box)
        colr_arr_2.append(curr_colr)
    
    prev_end = curr_end

xlim = max(prev_end,xlim)

####################################

f3 = open(sys.argv[3],"r")

print(sys.argv[3])

SKIP_HEADER=2
line_no=1
for line in f3:

    if line_no == SKIP_HEADER:
        break
    line_no = line_no + 1
    

rect_arr_3=[]
colr_arr_3=[]
prev_end=-1

for line in f3:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    curr_start = int(cols_strip[5])
    curr_end   = int(cols_strip[6])

    curr_box  = (curr_start,(curr_end-curr_start))

    if cols_strip[9] in specific_repeat_arr:
        if cols_strip[9]!="R1_DM":
            curr_colr = color_dic[cols_strip[9]]
        else:            
            ref_coverage = curr_end - curr_start + 1
            if cols_strip[8]=="+":
                query_start     = int(cols_strip[11]) 
                query_end       = int(cols_strip[12])
                query_coverage  = query_end - query_start + 1
            else:
                query_start     = int(cols_strip[13]) 
                query_end       = int(cols_strip[12])
                query_coverage  = query_end - query_start + 1
                
            if query_coverage >= (R1_LEN-offset):
                curr_colr = 'xkcd:light orange'
                print(curr_start,"\t",ref_coverage,"\t",query_coverage,"\t",(query_coverage-ref_coverage))
            else:
                curr_colr = 'xkcd:light grey'    

    else:

        if cols_strip[10]=="rRNA":
            curr_colr=color_dic["rRNA"]
        elif cols_strip[10]=="Stellate":   
            curr_colr=color_dic["Stellate"]
        elif cols_strip[10][0:3]=="LTR":   
            curr_colr=color_dic["LTR"]
        elif cols_strip[10][0:4]=="LINE":   
            curr_colr=color_dic["LINE"]
        elif cols_strip[10][0:3]=="DNA":   
            curr_colr=color_dic["DNA"]
        elif cols_strip[10]=="Low_complexity":   
            curr_colr=color_dic["Low_complexity"]
        elif cols_strip[10]=="Simple_repeat":   
            curr_colr=color_dic["Simple_repeat"]
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start-1)<=prev_end or prev_end==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_3.append(curr_box)
        colr_arr_3.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end+1
        extra_len   =  (curr_start-1) - (prev_end+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_3.append(NA_box)
        colr_arr_3.append(NA_colr)

        rect_arr_3.append(curr_box)
        colr_arr_3.append(curr_colr)
    
    prev_end = curr_end


xlim = max(prev_end,xlim)

####################################



## Plot the array
plt.rcParams['figure.figsize'] = (30, 4.5)
#plt.style.use('ggplot')

fig, gnt = plt.subplots()  # Declaring a figure "gnt"
gnt.set_ylim(0, 5)         # Setting Y-axis limits
gnt.set_xlim(0, xlim  )       # Setting X-axis limits 

gnt.set_xlabel('Size in bp', size=18)  # Setting label for x-axis 
#gnt.set_ylabel('Processor', size=18)  # Setting label for y-axis

gnt.set_yticks([])           # Setting ticks on y-axis
gnt.set_yticklabels([])      # Labelling tickes of y-axis

#gnt.set_xticks(np.arange(0,xlim+10000,1000000))           # Setting ticks on x-axis
#gnt.set_xticklabels(np.arange(0,xlim+10000,1000000))      # Labelling tickes of x-axis


#gnt.broken_barh(rect_arr_1, (0.75, 0.5), facecolors=colr_arr_1,edgecolors=('black')) 
gnt.broken_barh(rect_arr_1, (0.75, 0.5), facecolors=colr_arr_1) 

gnt.broken_barh(rect_arr_2, (2, 0.5), facecolors=colr_arr_2) 

gnt.broken_barh(rect_arr_3, (3.25, 0.5), facecolors=colr_arr_3) 


#plt.title("rDNA array - representative", size=20)
plt.show()

#plt.plot()
#plt.savefig("X_extra_test1.svg", format="svg")


