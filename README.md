# Bioinformatics_course
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
# move to the danaseqassignment directory and check it tis the right location
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
# change the directory  to th euntrimmed_fastq file
# check the quality of the reads pre-alignment by running FASTQC startring with the two sequences to be aligned. 
# upload the two files as a wildcard
$ fastqc *.fastq.qz
![image](https://user-images.githubusercontent.com/111018047/184508781-15bccafa-4810-4008-b675-ed495fa552bd.png)
***error failed to process ngs..ID line did not start with @**REVISIT THIS STEP
$ cd ~/ngs_course/dnaseqassignment/data/untrimmed_fastq
# Run FASTQC as four threads (the capacity of the VM) to spead up the process 
$ fastqc -t 4 *.fastq.qz
*888error: no such file* REVISIT***
# create a folder for the reads and move the results above there.
$ mkdir ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads
$ mv *fastq* ~/ngs_course/dnaseqassignment/results/fastqc_untrimmed_reads/
* ERROR
Then the reference genome.


  
