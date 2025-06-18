import re
import sys
import matplotlib.pyplot as plt
import numpy as np

f1 = open(sys.argv[1],"r")

color_dic = {'Stellate':'xkcd:brick red','Satellite':'xkcd:grey blue','tRNA':'xkcd:grey blue','LTR':'xkcd:sky blue','LINE':'xkcd:blue','DNA':'xkcd:indigo','Low_complexity':'xkcd:olive','Simple_repeat':'xkcd:olive','NA':'xkcd:white','RC/Helitron':'xkcd:yellow'}

specific_repeat_arr=['Mst40_LTR']

#SKIP_HEADER=2
#line_no=1
#for line in f1:

#    if line_no == SKIP_HEADER:
#        break
#    line_no = line_no + 1
    

rect_arr_1=[]
colr_arr_1=[]
prev_end_1=-1

flag=0

for line in f1:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    if flag==0:
        start_lim  = int(cols_strip[5])
        curr_start = int(cols_strip[5]) - start_lim
        curr_end   = int(cols_strip[6]) - start_lim
        flag=1

    else:
        curr_start = int(cols_strip[5]) - start_lim
        curr_end   = int(cols_strip[6]) - start_lim


    curr_box  = (curr_start,(curr_end-curr_start))

    if cols_strip[9] in specific_repeat_arr:  # not needed used old code kept as it is
        curr_colr = color_dic[cols_strip[9]]

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
        elif cols_strip[10]=="RC/Helitron":
            curr_colr=color_dic["RC/Helitron"]
        elif cols_strip[10]=="Satellite":
            curr_colr=color_dic["Satellite"]
        elif cols_strip[10]=="tRNA":
            curr_colr=color_dic["tRNA"] 
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start-1)<=prev_end_1 or prev_end_1==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_1.append(curr_box)
        colr_arr_1.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end_1+1
        extra_len   =  (curr_start-1) - (prev_end_1+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_1.append(NA_box)
        colr_arr_1.append(NA_colr)

        rect_arr_1.append(curr_box)
        colr_arr_1.append(curr_colr)
    
    prev_end_1 = curr_end
    #print(line)
    #print(rect_arr_1)
    #print(colr_arr_1)    
    #break 

#print(rect_arr_1)
#print(colr_arr_1)



###########################

f2 = open(sys.argv[2],"r")

rect_arr_2=[]
colr_arr_2=[]
prev_end_2=-1

#SKIP_HEADER=2
#line_no=1
#for line in f2:

#    if line_no == SKIP_HEADER:
#        break
#    line_no = line_no + 1
    

flag=0
for line in f2:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    if flag==0:
        start_lim  = int(cols_strip[5])
        curr_start = int(cols_strip[5]) - start_lim
        curr_end   = int(cols_strip[6]) - start_lim
        flag=1

    else:
        curr_start = int(cols_strip[5]) - start_lim
        curr_end   = int(cols_strip[6]) - start_lim


    curr_box  = (curr_start,(curr_end-curr_start))

    if cols_strip[9] in specific_repeat_arr:
        curr_colr = color_dic[cols_strip[9]]

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
        elif cols_strip[10]=="RC/Helitron":
            curr_colr=color_dic["RC/Helitron"]
        elif cols_strip[10]=="Satellite":
            curr_colr=color_dic["Satellite"]
        elif cols_strip[10]=="tRNA":
            curr_colr=color_dic["tRNA"] 
        else:
            print("Something not in the list is curr_colrtified:", cols_strip[10])

    if (curr_start-1)<=prev_end_2 or prev_end_2==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_2.append(curr_box)
        colr_arr_2.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end_2+1
        extra_len   =  (curr_start-1) - (prev_end_2+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_2.append(NA_box)
        colr_arr_2.append(NA_colr)

        rect_arr_2.append(curr_box)
        colr_arr_2.append(curr_colr)
    
    prev_end_2 = curr_end
    #print(line)
    #print(rect_arr_2)
    #print(colr_arr_2)    
    #break 

#############################

f3 = open(sys.argv[3],"r")

rect_arr_3=[]
colr_arr_3=[]
prev_end_3=-1

#SKIP_HEADER=2
#line_no=1
#for line in f2:

#    if line_no == SKIP_HEADER:
#        break
#    line_no = line_no + 1
    

flag=0
for line in f3:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    if flag==0:
        start_lim  = int(cols_strip[5])
        curr_start = int(cols_strip[5]) - start_lim
        curr_end   = int(cols_strip[6]) - start_lim
        flag=1

    else:
        curr_start = int(cols_strip[5]) - start_lim
        curr_end   = int(cols_strip[6]) - start_lim


    curr_box  = (curr_start,(curr_end-curr_start))

    if cols_strip[9] in specific_repeat_arr:
        curr_colr = color_dic[cols_strip[9]]

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
        elif cols_strip[10]=="RC/Helitron":
            curr_colr=color_dic["RC/Helitron"]
        elif cols_strip[10]=="Satellite":
            curr_colr=color_dic["Satellite"]
        elif cols_strip[10]=="tRNA":
            curr_colr=color_dic["tRNA"]             
        else:
            print("Something not in the list is curr_colrtified:", cols_strip[10])

    if (curr_start-1)<=prev_end_3 or prev_end_3==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_3.append(curr_box)
        colr_arr_3.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end_3+1
        extra_len   =  (curr_start-1) - (prev_end_3+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_3.append(NA_box)
        colr_arr_3.append(NA_colr)

        rect_arr_3.append(curr_box)
        colr_arr_3.append(curr_colr)
    
    prev_end_3 = curr_end
    #print(line)
    #print(rect_arr_3)
    #print(colr_arr_3)    
    #break 

##
## Plot the array
plt.rcParams['figure.figsize'] = (30, 4.5)
#plt.style.use('ggplot')

xlim_rec =max(prev_end_1,prev_end_2,prev_end_3)
#xlim_rec =250000

fig, gnt = plt.subplots()  # Declaring a figure "gnt"
gnt.set_ylim(0, 4.25)         # Setting Y-axis limits
#gnt.set_xlim(0, )       # Setting X-axis limits 

gnt.set_xlabel('Size in bp', size=18)  # Setting label for x-axis 
#gnt.set_ylabel('Processor', size=18)  # Setting label for y-axis

gnt.set_yticks([])           # Setting ticks on y-axis
gnt.set_yticklabels([])      # Labelling tickes of y-axis

gnt.set_xticks(np.arange(0,xlim_rec,100000))           # Setting ticks on x-axis
gnt.set_xticklabels(np.arange(0,xlim_rec,100000))      # Labelling tickes of x-axis


#gnt.broken_barh(rect_arr_1, (0.75, 0.5), facecolors=colr_arr_1,edgecolors=('black')) 
gnt.broken_barh(rect_arr_3, (0.75, 0.5), facecolors=colr_arr_3) 

gnt.broken_barh(rect_arr_2, (2, 0.5), facecolors=colr_arr_2) 

gnt.broken_barh(rect_arr_1, (3.25, 0.5), facecolors=colr_arr_1) 




#plt.title("rDNA array - representative", size=20)
#plt.show()

plt.plot()
plt.savefig("stellate.svg", format="svg")


