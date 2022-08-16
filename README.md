# Bioinformatics_course
Organising the directories for the NGS pipeline
# check the home directory 
$ pwd
create directory and subdirectories for inputs and outputs from the NGS pipeline
$ cd mkdir ngs_course
$ mkdir ngs_course/dnaseqassignment
$ cd ngs_course/dnaseqassignment
$ mkdir data meta results logs
# check that the four subdirectories were created
$ ls -lF
# create subrectories for the fastq files in data
$ cd ~/ngs_course/dnaseqassignment/data
$ mkdir untrimmed_fastq
$ mkdir trimmed_fastq
# check that the two subdirectories were created
$ ls -lF
# upload the untrimmed Fastq files and reference genome as weblinks
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R1.fastq.qz
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R2.fastq.qz
$ wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/annotation.bed
# check the files were downloaded to data
$ pwd
$ ls -l
# move the three downloaded files to untrimmed_fastq subdirectory
$ mv NGS0001.R1.fastq.qz ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R1.fastq.qz
$ mv NGS0001.R2.fastq.qz ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R2.fastq.qz
$ mv annotation.bed ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed
# move to the danaseqassignment directory and check that  it is in the right location
$ cd ./../..
$ pwd
# Download Anaconda
$ wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
$ chmod +x ./Anaconda3-2020.02-Linux-x86_64.sh
$ bash ./Anaconda3-2020.02-Linux-x86_64.sh
$ source ~/.bashrc
# Install Bioconda and channels from highest to lowest priority
$ conda config --add channels defaults
$ conda config --add channels bioconda
$ conda config --add channels conda-forge
# Install the required packages and dependencies for NGS pipeline
$ conda install samtools
$ conda install bwa
$ conda install freebayes
$ conda install picard
$ conda install bedtools
$ conda install trimmomatic
$ conda install fastqc
$ conda install vcflib
# change the directory  to the untrimmed_fastq file
$ cd ~/ngs_course/dnaseqassignment/data/untrimmed_fastq
# Rename both reads from *fastq.QZ suffix into *fastq.GZ to be recognised by FASTQC 
$ mv NGS0001.R1.fastq.qz NGS0001.R1.fastq.gz
$ mv NGS0001.R2.fastq.qz NGS0001.R2.fastq.gz
# check that the two files are renamed in data/untrimmed_fastq
$ ls
# check the quality of the reads pre-alignment by running FASTQC startring with the two sequences to be aligned. 
# Upload the two files as a wildcard. Run FASTQC as four threads (the capacity of the VM) to spead up the process 
$ fastqc -t 4 *.fastq.qz
# create a folder for the reads and move the results above there.
$ cd ~/ngs_course/dnaseqassignment/results
$ mkdir ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads
$ mv *fastqc.zip ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads
$ mv *fastqc.html ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads 
# View and save the zip report output from FASTQC
# Install unzip program
$ sudo apt install unzip
# Unpack the zip utputs from FASTQC using wilcard *fastqc
$ for zip in *.zip
> do
> unzip $zip
> done
$ ls -1h NGS0001.R1_fastqc
# Display the first 10 lines of FATSQC text files showing the statistics of the quality control
$ head NGS0001.R1_fastqc
# Save both  summary.txt files for quality  into one report : Concatenate the two summary.txt outputs into one one file <fastqc_summaries.txt> in the subdirectory logs
$ cat */summary.txt > ~/ngs_course/dnaseqassignment/logs/fastqc_summaries.txt
#  check that the new file contains the summary for both reads
$ head -30 fastqc_summaries.txt
*Trimming 
# Move to trimmed fastq file 
$ cd ~/ngs_course/dnaseqassignment/data/trimmed_fastq
# check the version and path for trimmomatic by using ls and cd commands
# Trimm paired ends on  4 parallel thread using: 1- phred scrore of 33 as the cut off for quality, 2- ILLUMINACLIP: to cut adapter and other illumina-specific sequences. 3-TRAILING : Cutting bases of the end of the read with quality threshold below  25 and 4-  MINLEN dropping reads below the length  of 50 bp
$ trimmomatic PE -threads 4 -phred33 /home/ubuntu/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R1.fastq.gz /home/ubuntu/ngs_course/dnaseqassignment/data/untrimmed_fastq/NGS0001.R2.fastq.gz\
>   -baseout ~/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R ILLUMINACLIP:/home/ubuntu/anaconda3/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/NexteraPE-PE.fa:2:30:10 TRAILING:25 MINLEN:50
# Asses the quality of the paired trimmed files : repeat the steps for untrimmed reads as above 
$ fastqc -t 4 *P
$ cd ~/ngs_course/dnaseqassignment/results
$ mkdir ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ cd ~/ngs_course/dnaseqassignment/data/trimmed_fastq
$ mv *fastqc.zip ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ mv *fastqc.html ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ cd ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
# make a subdirectory for summary.txt for trimmed reads
$ cd /home/ubuntu/ngs_course/dnaseqassignment/logs
$ mkdir trimmmed
$ ~/ngs_course/dnaseqassignment/results/fastqc_trimmed_reads
$ cat */summary.txt > ~/ngs_course/dnaseqassignment/logs/trimmmed/fastqc_summaries.txt
# Create files for the reference and the BWA-generated index files
$ mkdir -p ~/ngs_course/dnaseqassignment/data/reference
$ mv ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed ~/ngs_course/ dnaseqassignment /data/reference
# Create files for the reference and the BWA-generated index files
$ mkdir -p ~/ngs_course/dnaseqassignment/data/reference
$ mv ~/ngs_course/dnaseqassignment/data/untrimmed_fastq/annotation.bed ~/ngs_course/ dnaseqassignment /data/reference/
$ bwa index ~/ngs_course/dnaseqassignment /data/reference/annotation. Bed
# Display the generated files
$ ls ~/ngs_course/ dnaseqassignment /data/reference
 # Making the reference index after creating a directory for the aligned files
$ mkdir ~/ngs_course/dnaseqassignment/data/aligned_data
$ bwa index ~/ngs_course/dnaseqassignment/data/reference/annotation.bed
$ ls ~/ngs_course/dnaseqassignment/data/reference
# Aligning paired trimmed fastq files using read group information.
Use BWA (alignment via Burrows-Wheeler): BWA-MEM algorithm that  works by seeding alignments with maximal exact matches (MEMs) and then extending seeds with the affine-gap Smith-Waterman algorithm (SW). It the is the best quality for long reads amongst  the three BWA algorithm. 

Read group information was obtained from the workflow for the basic bioinformatic module. Read group identifier (ID) :HWI-D00119.50.H7AP8ADXX.1.WES01. Read group sample name (SM) WES01. Platform/technology used to produce the reads (PL) ILLUMINA. Library name (LB). nextera-wes01-blood. Date that run was produced (DT) 2017-02-23. Platform unit (PU) HWI-D00119

$bwa mem [ options : -thread 4 ‘to speed up the process’ -verbosity level 1 -R’@RG read group info’ – I 250,50 the mean insert size is 250, standard deviation 50, maximum and minimum insert size distribution :450 and 50 respectively]  <index reference> <fastq1 file> <fatsq2 file > \ > <sam file>

$ bwa mem -t4 -V1 -R'@RG\tID:HWI-D0011.50.H7AP8ADXX.1.WES01\tSM:WES01\tPL:ILLUMINA\tLB:nextera-wes01-blood\tDT:2017-02-23\tPU:HWI-D00119' -I250,50 /home/ubuntu/ngs_course/dnaseqassignment/data/reference/annotation.bed  /home/ubuntu/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R_1P  /home/ubuntu/ngs_course/dnaseqassignment/data/trimmed_fastq/NGS0001_trimmed_R_2P > /home/ubuntu/ngs_course/dnaseqassignment/data/aligned_data/NGS0001.sam


  
