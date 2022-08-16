usr/bin/env bash
$ pwd
$ cd mkdir ngs_course
$ mkdir ngs_course/dnaseqassignment
$ cd ngs_course/dnaseqassignment
$ mkdir data meta results logs
$ ls -lF
$ cd ~/ngs_course/dnaseqassignment/data
$ mkdir untrimmed_fastq
$ mkdir trimmed_fastq
$ ls -lF
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R1.fastq.qz
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R2.fastq.qz
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/annotation.bed
$ pwd
$ ls -l
$ mv NGS0001.R1.fastq.qz ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R1.fastq.qz
$ mv NGS0001.R2.fastq.qz ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R2.fastq.qz
$ mv annotation.bed ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed
$ cd ./../..
$ pwd
$ wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
$ chmod +x ./Anaconda3-2020.02-Linux-x86_64.sh
$ bash ./Anaconda3-2020.02-Linux-x86_64.sh
$ source ~/.bashrc
$ conda config --add channels defaults
$ conda config --add channels bioconda
$ conda config --add channels conda-forge
$ conda install samtools
$ conda install bwa
$ conda install freebayes
$ conda install picard
$ conda install bedtools
$ conda install trimmomatic
$ conda install fastqc
$ conda install vcflib
$ cd ~/ngs_course/dnaseqassignment/data/untrimmed_fastq
$ mv NGS0001.R1.fastq.qz NGS0001.R1.fastq.gz
$ mv NGS0001.R2.fastq.qz NGS0001.R2.fastq.gz
$ ls
$ fastqc -t 4 *.fastq.qz
$ cd ~/ngs_course/dnaseqassignment/results
$ mkdir ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads
$ mv *fastqc.zip ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads
$ mv *fastqc.html ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads 
$ sudo apt install unzip
$ for zip in *.zip
> do
> unzip $zip
> done
$ ls -1h NGS0001.R1_fastqc
$ head NGS0001.R1_fastqc
$ cat */summary.txt > ~/ngs_course/dnaseqassignment/logs/fastqc_summaries.txt
$ head -30 fastqc_summaries.txt
$ cd ~/ngs_course/dnaseqassignment/data/trimmed_fastq
$ trimmomatic PE -threads 4 -phred33 /home/ubuntu/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R1.fastq.gz /home/ubuntu/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R2.fastq.gz\
>   -baseout ~/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R ILLUMINACLIP:/home/ubuntu/anaconda3/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/NexteraPE-PE.fa:2:30:10 TRAILING:25 MINLEN:50
$ fastqc -t 4 *P
$ cd ~/ngs_course/dnaseqassignment/results
$ mkdir ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ cd ~/ngs_course/dnaseqassignment/data/trimmed_fastq
$ mv *fastqc.zip ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ mv *fastqc.html ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ cd ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ cd /home/ubuntu/ngs_course/dnaseqassignment/logs
$ mkdir trimmmed
$ ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ cat */summary.txt > ~/ngs_course/dnaseqassignment/logs/trimmmed/fastqc_summaries.txt
$ mkdir -p ~/ngs_course/dnaseqassignment/data/reference
$ mv ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed ~/ngs_course/ dnaseqassignment /data/reference
$ mkdir -p ~/ngs_course/dnaseqassignment/data/reference
$ mv ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed ~/ngs_course/ dnaseqassignment /data/reference/
$ bwa index ~/ngs_course/dnaseqassignment /data/reference/annotation. Bed
$ ls ~/ngs_course/ dnaseqassignment /data/reference
$ mkdir ~/ngs_course/dnaseqassignment/data/aligned_data
$ bwa index ~/ngs_course/dnaseqassignment/data/reference/annotation.bed
$ ls ~/ngs_course/dnaseqassignment/data/reference
$ bwa mem -t4 -V1 -R'@RG\tID:HWI-D0011.50.H7AP8ADXX.1.WES01\tSM:WES01\tPL:ILLUMINA\tLB:nextera-wes01-blood\tDT:2017-02-23\tPU:HWI-D00119' -I250,50 /home/ubuntu/ngs_course/dnaseqassignment/data/reference/annotation.bed  /home/ubuntu/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R_1P  /home/ubuntu/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R_2P > /home/ubuntu/ngs_course/dnaseqassignment/data/aligned_data/NGS0001.sam
$ cd ~/ngs_course/dnaseqassignment/data/aligned_data
$ samtools view -h -b NGS0001.sam > NGS0001.bam
$ samtools sort NGS0001.bam > NGS0001_sorted.bam
$ samtools index NGS0001_sorted.bam
$ ls
$ picard MarkDuplicates I= NGS0001_sorted.bam O= NGS0001_sorted_marked.bam M=marked_dup_metrics.txt
$ samtools index NGS0001_sorted_marked.bam
$ samtools view -F 1796  -q 20 -o NGS0001_sorted_filtered.bam NGS0001_sorted_marked.bam
$ samtools index NGS0001_sorted_filtered.bam

$ cd annovar
$ ./annotate_variation.pl -buildver hg19 -downdb -webfrom annovar knownGene humandb/
$ ./annotate_variation.pl -buildver hg19 -downdb -webfrom annovar refGene humandb/
$ ./annotate_variation.pl -buildver hg19 -downdb -webfrom annovar ensGene humandb/
$ ./annotate_variation.pl -buildver hg19 -downdb -webfrom annovar clinvar_20180603 humandb/
$ ./annotate_variation.pl -buildver hg19 -downdb -webfrom annovar exac03 humandb/
$ ./annotate_variation.pl -buildver hg19 -downdb -webfrom annovar dbnsfp31a_interpro humandb/



  
