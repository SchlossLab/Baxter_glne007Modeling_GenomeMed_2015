# Analysis Workflow

**Warning:** This file is still under construction. I promise it will be completed before this study is published. 

First you'll need to clone this directory. The following workflow is designed to be run from the root directory of the repository.

`git clone https://github.com/SchlossLab/Baxter_glne007Modeling_2015.git`

### Acquiring the raw data
1. Download .sra files from the NCBI Sequence Read Archive.  The accession number for this study is SRP062005.  

`wget -r -np -nd -k -P data/ ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP062/SRP062005/`


2. Extract fastq files from the sra files. You will need to have the [SRA Toolkit](http://www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=show&f=software&m=software&s=software) installed on your system. This command will also delete the sra files so that they don't waste storage space. 

`for FILE in ls data/*.sra; do fastq-dump --split-files --gzip --outdir data/ $FILE && rm -f $FILE; done`


### Sequence Curation
The next step is sequence curation with [mothur](http://www.mothur.org/wiki/Download_mothur). 

1. Download and unzip reference files.
`wget -P data/ http://www.mothur.org/w/images/b/be/Silva.nr_v123.tgz`
`wget -P data/ http://mothur.org/w/images/2/24/Trainset10_082014.pds.tgz`


The data/ directory should contain a file called glne007.files.  This file tells mothur which fastq files belong to each sample. You may notice that a few samples have more than one entry. Those are samples that were sequenced a second time to improve coverage. They will be merged during the make.contigs step of mothur.

At this point we need to run code/mothur.batch, which contains most of the commands we'll run in mothur. The mothur.pbs script can be used to run mothur.batch on a high-performance computing cluster. You will likely need to make modifications to mothur.pbs to run it on your cluster. 


 - Run mothur.batch

### OTU clustering and classification
 - Run cluster.batch
 - Run trimTax.py

### Generating and Testing models
 - Run Rmd file





