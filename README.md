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
*Samtool package details
package                    |            build
    ---------------------------|-----------------
    conda-4.13.0               |   py37h89c1867_1         989 KB  conda-forge
    libgcc-7.2.0               |       h69d50b8_2         304 KB  conda-forge
    python_abi-3.7             |          2_cp37m           4 KB  conda-forge
    samtools-1.7               |                1         1.0 MB  bioconda
    ------------------------------------------------------------
                                           Total:         2.3 MB
  libgcc             conda-forge/linux-64::libgcc-7.2.0-h69d50b8_2
  python_abi         conda-forge/linux-64::python_abi-3.7-2_cp37m
  samtools           bioconda/linux-64::samtools-1.7-1
 $ conda install bwa
 *BWA package details
  package                    |            build
    ---------------------------|-----------------
    bwa-0.7.17                 |       hed695b0_7         523 KB  bioconda
    perl-5.26.2                |    h36c2ea0_1008        15.4 MB  conda-forge
    ------------------------------------------------------------
                                           Total:        15.9 MB
  bwa                bioconda/linux-64::bwa-0.7.17-hed695b0_7
  perl               conda-forge/linux-64::perl-5.26.2-h36c2ea0_1008
 $ conda install freebayes
 * Frebyes package details
package                    |            build
    ---------------------------|-----------------
    openjdk-8.0.332            |       h166bdaf_0        97.8 MB  conda-forge
    picard-2.18.29             |                0        13.6 MB  bioconda
    ------------------------------------------------------------
                                           Total:       111.4 MB
  openjdk            conda-forge/linux-64::openjdk-8.0.332-h166bdaf_0
  picard             bioconda/noarch::picard-2.18.29-0
  $ conda install picard
  *Picard package details
  package                    |            build
    ---------------------------|-----------------
    openjdk-8.0.332            |       h166bdaf_0        97.8 MB  conda-forge
    picard-2.18.29             |                0        13.6 MB  bioconda
    ------------------------------------------------------------
                                           Total:       111.4 MB
  openjdk            conda-forge/linux-64::openjdk-8.0.332-h166bdaf_0
  picard             bioconda/noarch::picard-2.18.29-0
  $ conda install bedtools   
 *Bedtools package details
  package                    |            build
    ---------------------------|-----------------
    bedtools-2.26.0            |                0         739 KB  bioconda
    ------------------------------------------------------------
                                           Total:         739 KB
  bedtools           bioconda/linux-64::bedtools-2.26.0-0
  $ conda install trimmomatic
  *Trimmomatic package details
  package                    |            build
    ---------------------------|-----------------
    trimmomatic-0.39           |       hdfd78af_2         144 KB  bioconda
    ------------------------------------------------------------
                                           Total:         144 KB

The following NEW packages will be INSTALLED:

  trimmomatic        bioconda/noarch::trimmomatic-0.39-hd
  
