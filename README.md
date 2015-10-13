Microbiota-based model improves the sensitivity for detecting colonic lesions
=======

**Background.** Colorectal cancer is the second leading cause of death among cancers in the United States. Although individuals diagnosed early have a greater than 90% chance of survival, more than one-third of individuals do not adhere to screening recommendations partly because the standard diagnostics, colonoscopy and sigmoidoscopy, are expensive and invasive. Thus, there is a great need to improve the sensitivity of non-invasive tests to detect early stage cancers and adenomas. Numerous studies have identified shifts in the composition of the gut microbiota associated with the progression of colorectal cancer, suggesting that the gut microbiota may represent a reservoir of biomarkers that would complement existing non-invasive methods such as the widely used fecal immunochemical test (FIT).

**Methods.** We sequenced the 16S rRNA genes from the stool samples of 490 patients. We used the relative abundances of the bacterial populations within each sample to develop a cross-validated random forest classification model that detects colonic lesions using the relative abundance of gut microbiota and the concentration of hemoglobin in stool.

**Results.** The microbiota-based random forest model detected 95.0% of cancers and 57.1% of adenomas while FIT alone detected 75.0% and 15.7%, respectively. Of the colonic lesions missed by FIT, the model detected 80.0% of cancers and 49.1% of adenomas. We confirmed known assocaitions of Porphyromonas assaccharolytica, Peptostreptococcus stomatis, Parvimonas micra, and Fusobacterium nucleatum with CRC. Yet, we found that the loss of potentially beneficial organisms, such as members of the Lachnospiraceae, was more predictive for identifying patients with adenomas when used in combination with FIT.

**Conclusions.** These findings demonstrate the potential for microbiota analysis to complement existing screening methods to improve detection of colonic lesions. 

Overview
--------

    project
    |- README          # the top level description of content
    |
    |- doc/            # documentation for the study
    |  |- notebook/    # preliminary analyses (dead branches of analysis)
    |  +- paper/       # manuscript(s), whether generated or not
    |
    |- data            # raw and primary data, are not changed once created
    |  |- references/  # reference files to be used in analysis
    |  |- raw/         # raw data, will not be altered
    |  +- process/     # cleaned data, will not be altered once created
    |
    |- code/           # any programmatic code
    |- results         # all output from workflows and analyses
    |  |- tables/      # text version of tables to be rendered with kable in R
    |  |- figures/     # graphs, likely designated for manuscript figures
    |  +- pictures/    # diagrams, images, and other non-graph graphics
    |
    |- scratch/        # temporary files that can be safely deleted or lost
    |
    |- study.Rmd       # executable Rmarkdown for this study, if applicable
    |- study.md        # Markdown (GitHub) version of the *Rmd file
    |- study.html      # HTML version of *.Rmd file
    |
    +- Makefile        # executable Makefile for this study, if applicable
