#!/bin/bash
######################################################################
#GOAL: Installs common genomic analysis tools on a newly lunched s3it ubuntu instance
#
#
#Build_version:1.0
#e-mail:mathieu.robin@uzh.ch
########################################################################
#DESCRIPTION:This skript hast two REDUNDANT parts to install commonly used genomic toolsets with 
#                                                 1. With anaconda (recomendet)
#                                                 2. From binaries (if newest version is needet)
#
##########################################################################################

#Update First
        sudo apt-get update -y
        sudo apt-get upgrade 
        
#TOOLS:
    #zipping files
        sudo apt install unzip
        sudo apt-get install bzip2
    #Firefox
        sudo apt install firefox

    ##########################################################################################
    #1. CONDA INSTALLATIONS
    ##########################################################################################
    #!READ FIRST
        # 1.1 Install anaconda (python 3.7)
        # 1.2 Install all packages at once (latest versionsß)
        # 1.3 Install singele packages
        # 1.4 Install specific package versions 

        #For further information vist: https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-pkgs.html
    #########################################################################################

    #1.1 Install anaconda Python 3.7
    ###############################################

        wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
        bash Anaconda3-2019.03-Linux-x86_64.sh
        sudo echo "conda activate" >> ~/.bashrc
        source ~/.bashrc #!Then restart the window by close and opening it to make conda workable.
        rm Anaconda3-2019.07-Linux-x86_64.sh
        #anaconda Python 2.7
            #mkdir $tools/conda3.7 && cd $tools/conda2.6
            #https://repo.anaconda.com/archive/Anaconda2-2019.07-Linux-x86_64.sh
            #bash Anaconda2-2019.07-Linux-x86_64.sh
            #source ~/.bashrc


    # 1.2 Install all packages at once
    ###############################################
        #If you like to install the LATEST version of the commonly used genomic programms, type:
    conda install -c dranew bcl2fastq 
    
    conda install -c bioconda   fastqc \
                                trimmomatic \
                                flash \
                                bwa \
                                bowtie2 \
                                gatk \
                                picard \
                                gatk4 \
                                angsd \
                                bamtools \
                                bcftools \
                                vcftools

                                # Trimmmomatic adatpers are under /home/ubuntu/anaconda3/share/trimmomatic-0.39-1/adapters 

    conda install -c r r

    #GATK3.8 have to be installed separately
                conda install -c conda-forge -c bioconda gatk
                mkdir ~/Downloads & cd ~/Downloads
                wget https://www.dropbox.com/s/ax3ayr516ila8mo/GenomeAnalysisTK-3.8-0-ge9d806836.tar.bz2
                gatk3-register GenomeAnalysisTK-3.8-0-ge9d806836.tar.bz2


    # 1.3 Install single packages
    ###############################################
        #If you like to install the LATEST version of a single tool, type:
    #Demultiplexing
            conda install -c dranew bcl2fastq 

    #Fastqc
            conda install -c bioconda fastqc
        #Trimmomatic
            conda install -c bioconda trimmomatic
    #Mapper
            #BWA
                conda install -c bioconda bwa
            #bowtie
                conda install -c bioconda bowtie2
    #Genoma Analyser Tool Kits
            #GATK3.8
                
                conda install -c conda-forge -c bioconda gatk
                mkdir ~/Downloads & cd ~/Downloads
                wget https://www.dropbox.com/s/ax3ayr516ila8mo/GenomeAnalysisTK-3.8-0-ge9d806836.tar.bz2
                gatk3-register GenomeAnalysisTK-3.8-0-ge9d806836.tar.bz2

            #GATK4
                conda install -c bioconda gatk4
        #ANGSD
            conda install -c bioconda angsd 
        #Picard
            conda install -c picard
        #HTTplib
            conda install -c conda-forge httplib2
        #bamtools
            conda install -c bamtools
        #bcftools
            conda install -c bcftools
        #vcftools
            conda install -c vcftools
        #R
            conda install -c r r 

    # 1.4 Install single packages
    ###############################################
        #when you need a SPECIFIC tool package version, type: 
            conda search >package< #to get the aviable package version. eg. conda install numpy
            conda install >packagename=version< #to get the aviable package version conda install numpy
        
        #when a chanel has to used (-c bioconda), type
            conda search -c bioconda >package< #to get the aviable package version. eg. conda install vcftools
            conda install -c >packagename=versionr< # e.g. conda install -c vcftools=0.1.16

        #To check installed package versions, type:
         conda list



##########################################################################################
# 2. Manual installation from binaries
##########################################################################################
#DESCRIPTION: This would manually install the different tools from soruce 

#LOCATION: Tools will be installed under "~/genomic_tools"
        mkdir ~/genomic_tools && cd ~/genomic_tools
        tools=~/genomic_tools

#FASTQC
        sudo apt-get install fastqc
        
#   TRIMMER
        #Trimmomatic-0.39 http://www.usadellab.org/cms/index.php?page=trimmomatic
            #installed from binars, therefore manual update necessary
            wget -qO- -O tmp.zip http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip && unzip tmp.zip && rm tmp.zip
            cd $tools

#   MAPPER
        #bowtie2
            wget -qO- -O tmp.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.5.1/bowtie2-2.3.5.1-linux-x86_64.zip && unzip tmp.zip && rm tmp.zip
            cd $tools
        #BWA
            sudo apt-get install -y bwa
        
        
#   GATK4 #from https://github.com/broadinstitute/gatk/releases
        wget -qO- -O tmp.zip https://github.com/broadinstitute/gatk/releases/download/4.1.3.0/gatk-4.1.3.0.zip && unzip tmp.zip && rm tmp.zip
        cd $tools

#   GATK3.8 
        #has to be downloaded manually unfortunatly from https://software.broadinstitute.org/gatk/download/archive
        firefox https://software.broadinstitute.org/gatk/download/archive #klik thre on gatk 2-3 and dowload the most top one
        cd $tools
        tar xfvj /home/ubuntu/Downloads/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef.tar.bz2

#   Picard
        wget -qO- -O tmp.zip https://github.com/broadinstitute/picard/archive/master.zip && unzip tmp.zip && rm tmp.zip
        cd $tools

# Samtools und bcftols 
    #       Libraries for bcftools and samtools
            sudo apt-get install libbz2-dev
            sudo apt-get install zlib1g-dev
            sudo apt-get install libncurses5-dev
            sudo apt-get install libncursesw5-dev
            sudo apt-get install liblzma-dev

    #       HTTSLIB (for bcf- and samtools)
            wget -qO- -O tmp.zip https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2 && unzip tmp.zip && rm tmp.zip
            tar -vxjf htslib-1.9.tar.bz2
            cd htslib-1.9
            make && cd $tools
    #       Samtools  
            wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && tar -vxjf samtools-1.9.tar.bz2
            cd samtools-1.9
            make && cd $tools
    #       bcftools
            wget https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2 && tar -vxjf bcftools-1.9.tar.bz2
            cd bcftools-1.9
            make && cd $tools

#   vcftools
        sudo apt-get install vcftools

#   bamtools
    #cmake
        sudo apt-get install cmake

        cd $tools
        wget -qO- -O tmp.zip https://github.com/pezmaster31/bamtools/archive/master.zip && unzip tmp.zip && rm tmp.zip
        cd bamtools-master
        mkdir build
        cd build
        cmake ..
        make
        make install
