# Bioinformatics_course
Organising the directories for the NGS pipeine
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



  
