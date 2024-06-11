################## Process the mapq > 0 files ###############

# The below 2 commands combine the 2 coverage out files from male and females
awk 'NR<2{print $0;next}{print $0| "sort"}' ../female/female.q0.coverage > combined.1.q0.cov
awk 'NR<2{print $0;next}{print $0| "sort"}' ../male/male.q0.coverage | cut -f4,5,6,7,8,9 | paste combined.1.q0.cov - > combined.q0.cov
rm combined.1.q0.cov

python process.py combined.q0.cov combined.r.q0.cov   # This python script calculates the ratio of male/female coverage statistic.. it assigns -1 if female covergae is 0

################# Process the mapq > 20 files  ###############

# The below 2 commands combine the 2 coverage out files from male and females
awk 'NR<2{print $0;next}{print $0| "sort"}' ../female/female.coverage > combined.1.cov
awk 'NR<2{print $0;next}{print $0| "sort"}' ../male/male.coverage | cut -f4,5,6,7,8,9 | paste combined.1.cov - > combined.cov
rm combined.1.cov

python process.py combined.cov combined.r.cov         # This python script calculates the ratio of male/female coverage statistic.. it assigns -1 if female covergae is 0


################# Get the Y linked contigs #########################

awk -F"\t" 'NR>1 {if($16>2 && $10>=5) print $1}' combined.r.cov  > Y_linked.tmp       # The ratio should be greater than 2 (min reads mapped to contigs = 5 ) 
awk -F"\t" 'NR>1 {if($16==-1 && $10>=5) print $1}' combined.r.cov  >> Y_linked.tmp    # if female coverage is 0 (min reads mapped to contigs = 5 ) 

awk -F"\t" 'NR>1 {if($16==-1 && $12>0 && $10>=5) print $1}' combined.r.q0.cov >> Y_linked.tmp   ## if female coverage is 0 and male covergae is non zero (min reads mapped to contigs = 5 ) 

sort Y_linked.tmp | uniq > Y_linked.lst
rm Y_linked.tmp

