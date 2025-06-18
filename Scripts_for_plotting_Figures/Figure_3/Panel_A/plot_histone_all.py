import re
import sys
import matplotlib.pyplot as plt
import numpy as np


# Command run : python3 plot_histone_all.py ./ISO1_ref/histone_locus_flybase.fasta.MOD.out 13531 606600 ./ISO1_V2/ptg000001l.RC.fasta.out 27924 620898 ./A4_V2/histone.asm.bp.p_ctg.RC.fasta.out 28238 604716 ./A3_V2/Histone_locus.fasta.out 40738 546607

f1 = open(sys.argv[1],"r")

start_plot_1 = int(sys.argv[2])
end_plot_1  = int(sys.argv[3])

color_dic = {'His1':'xkcd:brick red','His2B':'xkcd:kelly green','His2A':'xkcd:light green','His4':'xkcd:orange','His3':'goldenrod','LTR':'xkcd:sky blue','LINE':'xkcd:blue','DNA':'xkcd:indigo','Low_complexity':'xkcd:white','Simple_repeat':'xkcd:white','NA':'xkcd:white','Gap':'xkcd:black'}

histone_arr=['His1','His2B','His2A','His4','His3']

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

    if curr_start > 85130:
        curr_start = curr_start + 461767  # adding the excat gap N
        curr_end =   curr_end + 461767    # adding the excat gap N

    curr_start_mod = curr_start - start_plot_1
    curr_end_mod   = curr_end - start_plot_1
 

    if curr_start_mod < 0 or curr_start > end_plot_1:
        continue

    curr_box  = (curr_start_mod,(curr_end_mod-curr_start_mod))

    if cols_strip[9] in histone_arr:
        curr_colr = color_dic[cols_strip[9]]

    else:

        if cols_strip[10][0:3]=="LTR":   
            curr_colr=color_dic["LTR"]
        elif cols_strip[10][0:4]=="LINE":   
            curr_colr=color_dic["LINE"]
        elif cols_strip[10][0:3]=="DNA":   
            curr_colr=color_dic["DNA"]
        elif cols_strip[10]=="Low_complexity":   
            curr_colr=color_dic["Low_complexity"]
        elif cols_strip[10]=="Simple_repeat":   
            curr_colr=color_dic["Simple_repeat"]
        elif cols_strip[10]=="Gap":
            curr_colr=color_dic["Gap"]
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start_mod-1)<=prev_end or prev_end==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_1.append(curr_box)
        colr_arr_1.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end+1
        extra_len   =  (curr_start_mod-1) - (prev_end+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_1.append(NA_box)
        colr_arr_1.append(NA_colr)

        rect_arr_1.append(curr_box)
        colr_arr_1.append(curr_colr)
    
    prev_end = curr_end_mod


max_prev_end = prev_end

###############################################################################################################

f2 = open(sys.argv[4],"r")

start_plot_2 = int(sys.argv[5])
end_plot_2   = int(sys.argv[6])

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

    curr_start_mod = curr_start - start_plot_2
    curr_end_mod   = curr_end - start_plot_2
 

    if curr_start_mod < 0 or curr_start > end_plot_2:
        continue

    curr_box  = (curr_start_mod,(curr_end_mod-curr_start_mod))

    if cols_strip[9] in histone_arr:
        curr_colr = color_dic[cols_strip[9]]

    else:

        if cols_strip[10][0:3]=="LTR":   
            curr_colr=color_dic["LTR"]
        elif cols_strip[10][0:4]=="LINE":   
            curr_colr=color_dic["LINE"]
        elif cols_strip[10][0:3]=="DNA":   
            curr_colr=color_dic["DNA"]
        elif cols_strip[10]=="Low_complexity":   
            curr_colr=color_dic["Low_complexity"]
        elif cols_strip[10]=="Simple_repeat":   
            curr_colr=color_dic["Simple_repeat"]
        elif cols_strip[10]=="Gap":
            curr_colr=color_dic["Gap"]
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start_mod-1)<=prev_end or prev_end==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_2.append(curr_box)
        colr_arr_2.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end+1
        extra_len   =  (curr_start_mod-1) - (prev_end+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_2.append(NA_box)
        colr_arr_2.append(NA_colr)

        rect_arr_2.append(curr_box)
        colr_arr_2.append(curr_colr)
    
    prev_end = curr_end_mod

max_prev_end = max(max_prev_end,prev_end)
###############################################################################################################


f3 = open(sys.argv[7],"r")

start_plot_3 = int(sys.argv[8])
end_plot_3   = int(sys.argv[9])


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

    curr_start_mod = curr_start - start_plot_3
    curr_end_mod   = curr_end - start_plot_3
 

    if curr_start_mod < 0 or curr_start > end_plot_3:
        continue

    curr_box  = (curr_start_mod,(curr_end_mod-curr_start_mod))

    if cols_strip[9] in histone_arr:
        curr_colr = color_dic[cols_strip[9]]

    else:

        if cols_strip[10][0:3]=="LTR":   
            curr_colr=color_dic["LTR"]
        elif cols_strip[10][0:4]=="LINE":   
            curr_colr=color_dic["LINE"]
        elif cols_strip[10][0:3]=="DNA":   
            curr_colr=color_dic["DNA"]
        elif cols_strip[10]=="Low_complexity":   
            curr_colr=color_dic["Low_complexity"]
        elif cols_strip[10]=="Simple_repeat":   
            curr_colr=color_dic["Simple_repeat"]
        elif cols_strip[10]=="Gap":
            curr_colr=color_dic["Gap"]
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start_mod-1)<=prev_end or prev_end==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_3.append(curr_box)
        colr_arr_3.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end+1
        extra_len   =  (curr_start_mod-1) - (prev_end+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_3.append(NA_box)
        colr_arr_3.append(NA_colr)

        rect_arr_3.append(curr_box)
        colr_arr_3.append(curr_colr)
    
    prev_end = curr_end_mod



max_prev_end = max(max_prev_end,prev_end)


###############################################################################################################

f4 = open(sys.argv[10],"r")

start_plot_4 = int(sys.argv[11])
end_plot_4  = int(sys.argv[12])


SKIP_HEADER=2
line_no=1
for line in f4:

    if line_no == SKIP_HEADER:
        break
    line_no = line_no + 1
    

rect_arr_4=[]
colr_arr_4=[]
prev_end=-1

for line in f4:

    if line=="\n":
        continue

    cols = re.split(" |\n",line)
 
    cols_strip = []
    for i in range(0,len(cols)):
        if cols[i]!="":
            cols_strip.append(cols[i])

    curr_start = int(cols_strip[5])
    curr_end   = int(cols_strip[6])

    curr_start_mod = curr_start - start_plot_4
    curr_end_mod   = curr_end - start_plot_4
 

    if curr_start_mod < 0 or curr_start > end_plot_4:
        continue

    curr_box  = (curr_start_mod,(curr_end_mod-curr_start_mod))

    if cols_strip[9] in histone_arr:
        curr_colr = color_dic[cols_strip[9]]

    else:

        if cols_strip[10][0:3]=="LTR":   
            curr_colr=color_dic["LTR"]
        elif cols_strip[10][0:4]=="LINE":   
            curr_colr=color_dic["LINE"]
        elif cols_strip[10][0:3]=="DNA":   
            curr_colr=color_dic["DNA"]
        elif cols_strip[10]=="Low_complexity":   
            curr_colr=color_dic["Low_complexity"]
        elif cols_strip[10]=="Simple_repeat":   
            curr_colr=color_dic["Simple_repeat"]
        elif cols_strip[10]=="Gap":
            curr_colr=color_dic["Gap"]
        else:
            print("Something not in the list is curr_colrtified")

    if (curr_start_mod-1)<=prev_end or prev_end==-1:    # if the current record overlaps the previous one or starts excatly after ( if there is overlap the current record will overwrite previous one)
        rect_arr_4.append(curr_box)
        colr_arr_4.append(curr_colr)
    else:                           # if there is gap between the current record and the previous one white space is filled in - indicating non repetitve sequences
        extra_start =  prev_end+1
        extra_len   =  (curr_start_mod-1) - (prev_end+1)
        NA_box  = ( extra_start , extra_len )
        NA_colr = color_dic['NA']

        rect_arr_4.append(NA_box)
        colr_arr_4.append(NA_colr)

        rect_arr_4.append(curr_box)
        colr_arr_4.append(curr_colr)
    
    prev_end = curr_end_mod


max_prev_end = max(max_prev_end,prev_end)

###############################################################################################################
## Plot the array
plt.rcParams['figure.figsize'] = (30, 4.5)
#plt.style.use('ggplot')

fig, gnt = plt.subplots()  # Declaring a figure "gnt"
gnt.set_ylim(0, 5)         # Setting Y-axis limits
gnt.set_xlim(0, max_prev_end)       # Setting X-axis limits 

gnt.set_xlabel('Size in bp', size=18)  # Setting label for x-axis 
#gnt.set_ylabel('Processor', size=18)  # Setting label for y-axis

gnt.set_yticks([])           # Setting ticks on y-axis
gnt.set_yticklabels([])      # Labelling tickes of y-axis

#gnt.set_xticks(np.arange(0,prev_end,1000))           # Setting ticks on x-axis
#gnt.set_xticklabels(np.arange(0,prev_end,1000))      # Labelling tickes of x-axis


#gnt.broken_barh(rect_arr_1, (0.75, 0.5), facecolors=colr_arr_1,edgecolors=('black'))

gnt.broken_barh(rect_arr_4, (0.75, 0.5), facecolors=colr_arr_4) 
gnt.broken_barh(rect_arr_3, (1.75, 0.5), facecolors=colr_arr_3) 
gnt.broken_barh(rect_arr_2, (2.75, 0.5), facecolors=colr_arr_2)
gnt.broken_barh(rect_arr_1, (3.75, 0.5), facecolors=colr_arr_1)

#plt.title("rDNA array - representative", size=20)
plt.show()

#plt.plot()
#plt.savefig("2L_histone.svg", format="svg")


