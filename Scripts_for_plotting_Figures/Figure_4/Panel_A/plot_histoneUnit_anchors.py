import sys
import re
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.pyplot import cm


ISO1R6_color_dic = {1:'xkcd:purple',2:'xkcd:periwinkle',4:'xkcd:peach',5:'xkcd:cyan',6:'xkcd:gold',8:'xkcd:khaki',103:'xkcd:aquamarine',105:'xkcd:dark grey',107:'xkcd:lavender',113:'xkcd:red'}
ISO1_colr_dic    = {1:'xkcd:purple',2:'xkcd:periwinkle',15:'xkcd:peach',5:'xkcd:cyan',6:'xkcd:gold',14:'xkcd:khaki',104:'xkcd:aquamarine',112:'xkcd:dark grey',111:'xkcd:lavender',113:'xkcd:red',18:'xkcd:blue',35:'xkcd:green'}
A4_colr_dic      = {5:'xkcd:khaki', 28:'xkcd:blue', 47:'xkcd:green', 104:'xkcd:red',107:'xkcd:dark grey',3:'xkcd:orange' ,38:'xkcd:turquoise'}
A3_colr_dic      = {19:'xkcd:purple',26:'xkcd:orange',8:'xkcd:turquoise',93:'xkcd:red',94:'xkcd:red',97:'xkcd:dark grey'}



## ISO1 Rel6
rect_arr_1=[]
colr_arr_1=[]
curr_start=0
for i in range(1,114):

    curr_box   = (curr_start,5)

    if i in ISO1R6_color_dic:
        curr_colr = ISO1R6_color_dic[i]
    else:
        curr_colr = 'xkcd:light grey'

    rect_arr_1.append(curr_box)
    colr_arr_1.append(curr_colr) 

    curr_start = curr_start + 10
    
    
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
gnt.broken_barh(rect_arr_1, (0.7, 0.1), facecolors=colr_arr_1) 

#plt.title("rDNA array - representative", size=20)
#plt.show()

plt.plot()
plt.savefig("hisvar.grey.svg", format="svg")

