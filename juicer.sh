#!/bin/bash

# Picard to mark duplicate

docker run -v /home/blackmonlab/Desktop/Sean/Genome_assembly/Juicer:/data -it aidenlab/juicer:latest



sudo split -a 3 -l 90000000 -d --additional-suffix=_R1.fastq ../fastq/Cheirotonus-formosanus_R1_Q20.fastq &
sudo split -a 3 -l 90000000 -d --additional-suffix=_R2.fastq ../fastq/Cheirotonus-formosanus_R2_Q20.fastq &
# create chromosome size file
bioawk -c fastx '{print $name"\t"length($seq)}' references/Cheirotonus_formosanus_primary_assembly.fa > chrom.sizes
# index genome
bwa index references/Cheirotonus_formosanus_primary_assembly.fa

docker run -v /home/blackmonlab/Desktop/Sean/Genome_assembly/blackmon_tw_cf_HMW/hic-heatmap:/data -v /home/blackmonlab/Desktop/Sean/Genome_assembly/blackmon_tw_cf_HMW/hic-heatmap:/juicedir aidenlab/juicer:latest \
-d /data -z /juicedir/references/Cheirotonus_formosanus_primary_assembly.fa -p /juicedir/chrom.sizes -s none -t 100
