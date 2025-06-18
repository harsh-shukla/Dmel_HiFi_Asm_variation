import sys
import re
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.pyplot import cm



#ISO1_colr_dic    = {1:'xkcd:purple',2:'xkcd:periwinkle',15:'xkcd:peach',5:'xkcd:cyan',6:'xkcd:gold',14:'xkcd:khaki',104:'xkcd:aquamarine',112:'xkcd:dark grey',111:'xkcd:lavender',113:'xkcd:red',18:'xkcd:blue',35:'xkcd:green'}
#A4_colr_dic      = {5:'xkcd:khaki', 28:'xkcd:blue', 47:'xkcd:green', 104:'xkcd:red',107:'xkcd:dark grey',3:'xkcd:orange' ,38:'xkcd:turquoise'}
#A3_colr_dic      = {19:'xkcd:purple',26:'xkcd:orange',8:'xkcd:turquoise',93:'xkcd:red',94:'xkcd:red',97:'xkcd:dark grey'}

ISO1_colr_dic={}
A4_colr_dic={}
A3_colr_dic={}

ISO1_G1=[68,69,70,67,84,71,87,91,88,92,75,81,79,85,76,73,74,78,80,82,90,65,83,72,66,89,64]
A4_G1=[62,60,58,59,61]
A3_G1=[144,156,153,154,155,157,158,162,159,163,148,151,161,187,192]

ISO1_G2=[1,2,6,3,4,11,9,12,7,8,10,13]
A4_G2=[1,2,3,4]
A3_G2=[27,32,31,28,29,30,33,19,26,23,24,25,4,11,1,2,3,12,5,10,9,16,7,14,6,13,15]

#ISO1_G3=[35,34,50,54,59]
#A4_G3=[47,46]
#A3_G3=[]
ISO1_G3=[]
A4_G3=[]
A3_G3=[]


ISO1_G4=[100,101,102,107,109,94,95,97,98]
A4_G4=[100,101,102,103,105,106,87,88,89,90,91,92,93,94,95,96,97,98,99]
A3_G4=[188,189,190,191,195,196]

G1_colr='xkcd:purple'
G2_colr='xkcd:red'
G3_colr='xkcd:blue'
G4_colr='xkcd:green'

## assign color
#ISO1
for i in range(1,114):

    if i in ISO1_G1:
        ISO1_colr_dic[i]=G1_colr
    elif i in ISO1_G2:
        ISO1_colr_dic[i]=G2_colr
    elif i in ISO1_G3:
        ISO1_colr_dic[i]=G3_colr    
    elif i in ISO1_G4:
        ISO1_colr_dic[i]=G4_colr    
    else:
        pass


#A4
for i in range(1,112):

    if i in A4_G1:
        A4_colr_dic[i]=G1_colr
    elif i in A4_G2:
        A4_colr_dic[i]=G2_colr
    elif i in A4_G3:
        A4_colr_dic[i]=G3_colr    
    elif i in A4_G4:
        A4_colr_dic[i]=G4_colr    
    else:
        pass

#A3
for i in range(1,98):

    if i>36:
        j=i+100
    else:
        j=i     

    if j in A3_G1:
        A3_colr_dic[i]=G1_colr
    elif j in A3_G2:
        A3_colr_dic[i]=G2_colr
    elif j in A3_G3:
        A3_colr_dic[i]=G3_colr    
    elif j in A3_G4:
        A3_colr_dic[i]=G4_colr    
    else:
        pass



## ISO1 Hifi
rect_arr_2=[]
colr_arr_2=[]
curr_start=0
for i in range(1,114):

    curr_box   = (curr_start,5)

    if i in ISO1_colr_dic:
        curr_colr = ISO1_colr_dic[i]
    else:
        curr_colr = 'xkcd:light grey'

    rect_arr_2.append(curr_box)
    colr_arr_2.append(curr_colr) 

    curr_start = curr_start + 10
    

## A4 Hifi
rect_arr_3=[]
colr_arr_3=[]
curr_start=0
for i in range(1,112):

    curr_box   = (curr_start,5)

    if i in A4_colr_dic:
        curr_colr = A4_colr_dic[i]
    else:
        curr_colr = 'xkcd:light grey'

    rect_arr_3.append(curr_box)
    colr_arr_3.append(curr_colr) 

    curr_start = curr_start + 10

## A3 Hifi
rect_arr_4=[]
colr_arr_4=[]
curr_start=0
for i in range(1,98):

    curr_box   = (curr_start,5)

    if i in A3_colr_dic:
        curr_colr = A3_colr_dic[i]
    else:
        curr_colr = 'xkcd:light grey'

    rect_arr_4.append(curr_box)
    colr_arr_4.append(curr_colr) 

    curr_start = curr_start + 10    
    
    
    
### Plot
## Plot the array
plt.rcParams['figure.figsize'] = (30, 4.5)
#plt.style.use('ggplot')

fig, gnt = plt.subplots()  # Declaring a figure "gnt"
gnt.set_ylim(0, 0.9)         # Setting Y-axis limits
#gnt.set_xlim(0, prev_end)       # Setting X-axis limits 

#gnt.set_xlabel('Size in bp', size=18)  # Setting label for x-axis 
#gnt.set_ylabel('Processor', size=18)  # Setting label for y-axis

#gnt.set_yticks([])           # Setting ticks on y-axis
#gnt.set_yticklabels([])      # Labelling tickes of y-axis

#gnt.set_xticks(np.arange(0,prev_end,1000))           # Setting ticks on x-axis
#gnt.set_xticklabels(np.arange(0,prev_end,1000))      # Labelling tickes of x-axis

gnt.broken_barh(rect_arr_4, (0.1, 0.1), facecolors=colr_arr_4)
gnt.broken_barh(rect_arr_3, (0.3, 0.1), facecolors=colr_arr_3) 
gnt.broken_barh(rect_arr_2, (0.5, 0.1), facecolors=colr_arr_2)
#gnt.broken_barh(rect_arr_1, (0.7, 0.1), facecolors=colr_arr_1) 

#plt.title("rDNA array - representative", size=20)
#plt.show()

plt.plot()
plt.savefig("hisvar.grey.svg", format="svg")

