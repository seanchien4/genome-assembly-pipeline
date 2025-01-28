#!/bin/bash

# hifi platform
# filter out low quality reads
hifiadapterfilt.sh -p XSCAM_20241002_R84050_PL14846-001_1-1-D01_bc2093-bc2093.hifi_reads -t 80 -o ../filter_adap_tc_cf

# filter out reads are less than 10kb in fastq.gz
gunzip -c ../filter_adap_fl_od/XSCAM_20241002_R84050_PL14847-001_1-1-D01_bc2094-bc2094.hifi_reads.filt.fastq.gz | awk 'NR%4==1{a=$0} NR%4==2{b=$0} NR%4==3{c=$0} NR%4==0&&length(b)>10000{print a"\n"b"\n"c"\n"$0;}' - | gzip -c -> fl_od_filter10000.fastq.gz
zcat fl_od_filter10000.fastq.gz | awk '{if(NR%4==2) print length($1)}' | sort -n | uniq -c > filter10000_read_length.txt

../../hifiasm/hifiasm -o tw_cf.asm -t 55 ../filter_adap_tc_cf/XSCAM_20241002_R84050_PL14846-001_1-1-D01_bc2093-bc2093.hifi_reads.filt.fastq.gz


############
### Hi-C ###
############

# check the quality by fastqc


# filter fastq < Q20
fastp -i Cheirotonus-formosanus_1.fq.gz -I Cheirotonus-formosanus_2.fq.gz -o Cheirotonus-formosanus_1_Q20.fq.gz -O Cheirotonus-formosanus_2_Q20.fq.gz -q 20 -w 16


# Hifiasm 
# with Hi-C data 
../../hifiasm/hifiasm -o tw_cf_hic_Q30.asm -t 100 --h1 ../../Long_armed_Hi_c/CGHICML241022/rawdata/Cheirotonus-formosanus_1_Q30.fq.gz --h2 ../../Long_armed_Hi_c/CGHICML241022/rawdata/Cheirotonus-formosanus_2_Q30.fq.gz ../PACBIO_DATA/XSCAM_20241002_R84050_PL14846-001_1-1-D01_bc2093-bc2093.hifi_reads.fastq.gz


# produce fasta file from .gfa
awk '/^S/{print ">"$2;print $3}' tw_cf.asm.bp.p_ctg.gfa > Cheirotonus_formosanus_primary_assembly.fa
# checking N50
python2 fast_stats.py -i Cheirotonus_formosanus_primary_assembly.fa -n 50

# BUSCO
busco -i Cheirotonus_formosanus_primary_assembly.fa --metaeuk -m geno -l endopterygota_odb10 -c 20 -o BUSCO
