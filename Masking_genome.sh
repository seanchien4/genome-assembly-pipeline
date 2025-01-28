#!/bin/bash
# Genome masking 

conda activate RepeatModeler

# de novo 
BuildDatabase -name Cheirotonus ../hifiasm_hi_c_Q20/Cheirotonus_formosanus_primary_assembly.fa
RepeatModeler -database Cheirotonus -genomeSampleSizeMax 602664168 -threads 100 -LTRStruct >& run.out

# output will be Cheirotonus-families.fa
# combine coleoptera dataset and de novo 
cat coleoptera-rm.fa Cheirotonus-families.fa > Cheirotonus.custom.lib.fa

conda deactivate
conda activate RepeatModeler

RepeatMasker -a -e RMBlast -s -gff -pa 100 -xsmall \
-lib Cheirotonus.custom.lib.fa ../hifiasm_hi_c_Q20/Cheirotonus_formosanus_primary_assembly.fa \
-dir .

# making landscape plot

~/anaconda3/envs/RepeatMasker/share/RepeatMasker/util/calcDivergenceFromAlign.pl -s Cheirotonus.divsum Cheirotonus_formosanus_primary_assembly.fa.align
tail Cheirotonus.divsum -n72 > Cheirotonus.divsum.table
~/anaconda3/envs/RepeatMasker/share/RepeatMasker/util/createRepeatLandscape.pl -div Cheirotonus.divsum -g 602664168 > Cheirotonus_repeat.html
