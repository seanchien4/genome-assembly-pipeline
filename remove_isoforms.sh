# busco duplication is high
# It cna be caused by isoform. We cam remoove the isoform 
# usually we choose the first one or the longest one
# choosing the first one and save it to a new file.

## clean isoforms
# keep the longest or the first on if they have the same length
# here is the example. .t means isoforms 
# I will keep prot.t1(only one), prot2.t3(longest), and prot3.t1 (same length so pick first)
# >prot1.t1
# ABCDE
# >prot2.t1
# ABCDEABCDEABCDEABCDEABCDE
# >prot2.t2
# ABCDEABCDEABCDEABCDE
# >prot2.t3
# ABCDEABCDEABCDEABCDEABCDEABCDE
# >prot3.t1
# ABCDEABCDEABCDE
# >prot3.t2
# ABCDEABCDEABCDE

cat braker.aa |\
# print name and seq in the same line
awk '/^>/ {if(N>0) printf("\n"); printf("%s\t",$0);N++;next;} {printf("%s",$0);} END {if(N>0) printf("\n");}' |\
# separate .t with the name
tr "." "\t" |\
# print the line and the length of the protein seq
awk -F '\t' '{printf "%s\t%s\n",$0,length($3)}' |\
# sort by their name then reverse in length | sort by their name and keep only one 
sort -t $'\t' -k1,1 -k4,4nr | sort  -t $'\t' -k1,1 -u -s |\
# put the name back and move seq to second line 
sed 's/\t/./' | cut -f 1,2 | tr "\t" "\n"|\
# mkae seq no more than 60 
fold -w 60 > braker_isoform_removed.aa
