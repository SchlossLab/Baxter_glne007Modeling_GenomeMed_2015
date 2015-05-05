all : mothur.pbs cluster.pbs allFigures.Rmd allFigures.Rmd allFigures.html

mothur.pbs : code/mothur.batch glne007.files
	qsub code/mothur.pbs
	touch mothur.pbs

cluster.pbs : mothur.pbs code/cluster.batch data/glne007.final.fasta
	qsub cluster.pbs
	touch cluster.pbs

allFigures.Rmd : glne007.final.an.unique_list.0.03.subsample.0.03.filter.shared metadata.tsv
	Rscript -e "library(knitr); knit('allFigures.Rmd')" #no idea if this is right
	
allFigures.html : allFigures.Rmd
	Rscript -e "library(knitr); knit('allFigures.Rmd')" #no idea if this is right