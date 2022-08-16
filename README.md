# Bioinformatics_course
# 1.Organising the directories for the NGS pipeline
#1.1.check the home directory 

$ pwd

#1.2.create directory and subdirectories for inputs and outputs from the NGS pipeline

$ cd mkdir ngs_course

$ mkdir ngs_course/dnaseqassignment

$ cd ngs_course/dnaseqassignment

$ mkdir data meta results logs

#1.3.check that the four subdirectories were created

$ ls -lF

#1.4. create subrectories for the fastq files in data

$ cd ~/ngs_course/dnaseqassignment/data

$ mkdir untrimmed_fastq

$ mkdir trimmed_fastq

#1.5. check that the two subdirectories were created

$ ls -lF

# 2.Upload the untrimmed Fastq files and reference genome as weblinks

$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R1.fastq.qz
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R2.fastq.qz
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/annotation.bed
# check the files were downloaded to data
$ pwd
$ ls -l
# 3.Move the three downloaded files to untrimmed_fastq subdirectory

$ mv NGS0001.R1.fastq.qz ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R1.fastq.qz

$ mv NGS0001.R2.fastq.qz ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R2.fastq.qz

$ mv annotation.bed ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed

# 3.2.move to the danaseqassignment directory and check that  it is in the right location

$ cd ./../..

$ pwd

# 4. Download dependancies and packages
# 4.1.Anaconda

$ wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh

$ chmod +x ./Anaconda3-2020.02-Linux-x86_64.sh

$ bash ./Anaconda3-2020.02-Linux-x86_64.sh

$ source ~/.bashrc

# 4.2.Install Bioconda and channels from highest to lowest priority

$ conda config --add channels defaults

$ conda config --add channels bioconda

$ conda config --add channels conda-forge

# 4.3.Install the required packages and dependencies for NGS pipeline

$ conda install samtools

$ conda install bwa

$ conda install freebayes

$ conda install picard

$ conda install bedtools

$ conda install trimmomatic

$ conda install fastqc

$ conda install vcflib

# 5.Running FASTQC for  Qualitiy assessment 
# 5.1.change the directory  to the untrimmed_fastq file

$ cd ~/ngs_course/dnaseqassignment/data/untrimmed_fastq

# 5.2.Rename both reads from *fastq.QZ suffix into *fastq.GZ to be recognised by FASTQC

$ mv NGS0001.R1.fastq.qz NGS0001.R1.fastq.gz

$ mv NGS0001.R2.fastq.qz NGS0001.R2.fastq.gz

# 5.3.check that the two files are renamed in data/untrimmed_fastq

$ ls
# 5.4. check the quality of the reads pre-alignment by running FASTQC startring with the two sequences to be aligned.

# 5.4.1.Upload the two files as a wildcard. Run FASTQC as four threads (the capacity of the VM) to spead up the process 

$ fastqc -t 4 *.fastq.qz

# 5.5. create a folder for the reads and move the results above there.

$ cd ~/ngs_course/dnaseqassignment/results

$ mkdir ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads

$ mv *fastqc.zip ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads

$ mv *fastqc.html ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads 

# 5.6 View and save the zip report output from FASTQC

# Install unzip program

$ sudo apt install unzip

# 5.7.Unpack the zip utputs from FASTQC using wilcard *fastqc

$ for zip in *.zip
> do
> unzip $zip
> done

$ ls -1h NGS0001.R1_fastqc

# 5.8. Display the first 10 lines of FATSQC text files showing the statistics of the quality control

$ head NGS0001.R1_fastqc

# 5.9. Save both  summary.txt files for quality  into one report : Concatenate the two summary.txt outputs into one one file <fastqc_summaries.txt> in the subdirectory logs

$ cat */summary.txt > ~/ngs_course/dnaseqassignment/logs/fastqc_summaries.txt

# 5.10 check that the new file contains the summary for both reads

$ head -30 fastqc_summaries.txt

# 6.Trimming

# 6.1.Move to trimmed fastq file 

$ cd ~/ngs_course/dnaseqassignment/data/trimmed_fastq

# 6.2.check the version and path for trimmomatic by using ls and cd commands

# 6.3.Trimm paired ends on  4 parallel thread 
# using 1- phred scrore of 33 as the cut off for quality, 2- ILLUMINACLIP: to cut adapter and other illumina-specific sequences. 3-TRAILING : Cutting bases of the end of the read with quality threshold below  25 and 4-  MINLEN dropping reads below the length  of 50 bp

$ trimmomatic PE -threads 4 -phred33 
/home/ubuntu/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R1.fastq.gz 
/home/ubuntu/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R2.fastq.gz\
>   -baseout ~/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R 
ILLUMINACLIP:/home/ubuntu/anaconda3/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/NexteraPE-PE.fa:2:30:10 TRAILING:25 MINLEN:50

# 6.4 Asses the quality of the paired trimmed files : repeat the steps for untrimmed reads as above

$ fastqc -t 4 *P

$ cd ~/ngs_course/dnaseqassignment/results

$ mkdir ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads

$ cd ~/ngs_course/dnaseqassignment/data/trimmed_fastq

$ mv *fastqc.zip ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads

$ mv *fastqc.html ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads

$ cd ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads

# 6.5.make a subdirectory for summary.txt for trimmed reads

$ cd /home/ubuntu/ngs_course/dnaseqassignment/logs

$ mkdir trimmmed

$ ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads

$ cat */summary.txt > ~/ngs_course/dnaseqassignment/logs/trimmmed/fastqc_summaries.txt
# 7. Aligbment 
# 7.1.Create files for the reference and the BWA-generated index files

$ mkdir -p ~/ngs_course/dnaseqassignment/data/reference

$ mv ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed ~/ngs_course/ dnaseqassignment /data/reference

# 7.2.Create files for the reference and the BWA-generated index files

$ mkdir -p ~/ngs_course/dnaseqassignment/data/reference

$ mv ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed ~/ngs_course/ dnaseqassignment /data/reference/

$ bwa index ~/ngs_course/dnaseqassignment /data/reference/annotation.Bed

# 7.3.Display the generated files

$ ls ~/ngs_course/ dnaseqassignment /data/reference

 #7.4.  Making the reference index after creating a directory for the aligned files
 
$ mkdir ~/ngs_course/dnaseqassignment/data/aligned_data

$ bwa index ~/ngs_course/dnaseqassignment/data/reference/annotation.bed

$ ls ~/ngs_course/dnaseqassignment/data/reference

# 7.5. Aligning paired trimmed fastq files using read group information

# Use BWA (alignment via Burrows-Wheeler): BWA-MEM algorithm that  works by seeding alignments with maximal exact matches (MEMs) and then extending seeds with the affine-gap Smith-Waterman algorithm (SW). It the is the best quality for long reads amongst  the three BWA algorithm. 


Read group information was obtained from the workflow for the basic bioinformatic module. Read group identifier (ID) :HWI-D00119.50.H7AP8ADXX.1.WES01. Read group sample name (SM) WES01. Platform/technology used to produce the reads (PL) ILLUMINA. Library name (LB). nextera-wes01-blood. Date that run was produced (DT) 2017-02-23. Platform unit (PU) HWI-D00119


$bwa mem [ options : -thread 4 ‘to speed up the process’ -verbosity level 1 -R’@RG read group info’ – I 250,50 the mean insert size is 250, standard deviation 50, maximum and minimum insert size distribution :450 and 50 respectively]  <index reference> <fastq1 file> <fatsq2 file > \ > <sam file>


$ bwa mem -t4 -V1 -R'@RG\tID:HWI-D0011.50.H7AP8ADXX.1.WES01\tSM:WES01\tPL:ILLUMINA\tLB:nextera-wes01-blood\tDT:2017-02-23\tPU:HWI-D00119' -I250,50 
/home/ubuntu/ngs_course/dnaseqassignment/data/reference/annotation.bed  
/home/ubuntu/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R_1P  
/home/ubuntu/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R_2P > /home/ubuntu/ngs_course/dnaseqassignment/data/aligned_data/NGS0001.sam

 # change directory to the aligned data 
 
$ cd ~/ngs_course/dnaseqassignment/data/aligned_data

# convert   the sam file into bam format, sort it and generate an index using samtools

$ samtools view -h -b NGS0001.sam > NGS0001.bam

$ samtools sort NGS0001.bam > NGS0001_sorted.bam

$ samtools index NGS0001_sorted.bam
$ ls
# Perform duplicate marking 

Picard examines the aligned reads in sam and bam formats and mark duplicates reads. The output is two files: the duplicate reads flagged in a file and a text file with summary of numbers of duplicates 
$ picard MarkDuplicates I= NGS0001_sorted.bam O= NGS0001_sorted_marked.bam M=marked_dup_metrics.txt

$ samtools index NGS0001_sorted_marked.bam

# Quality Filter the duplicate marked BAM file (2pts) 

Samtools can filter out the poor quality duplicate marked files based on:
i.	Mapping quality score : se t as minimum MAPQ: 20 
ii.	Bitwise flag to skip alignments with reads that are  1- unmapped 2- Non primary alignment 3. failed platform/vendor quality checks 4.  PCR and optical duplicates

$ samtools view -F 1796  -q 20 -o NGS0001_sorted_filtered.bam NGS0001_sorted_marked.bam

$ samtools index NGS0001_sorted_filtered.bam

