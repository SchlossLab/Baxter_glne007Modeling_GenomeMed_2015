Reproducible Research Project Initialization
=======

Research project initialization and organization following reproducible research
guidelines as modified for use with typical microbial ecology projects

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


How to use
----------

* Download the [latest release](https://github.com/SchlossLab/new_project/releases/latest)
to the directory and decompress

* Rename the decompressed/untarred file to the name of your project. Name the
folder in the format `LastName_BriefDescription_Journal_Year`. For example,
"Kozich_MiSeqSOP_AEM_2013" will work. Move into the folder.

* Open this document (i.e. README.md) in an editor. Change the first line to
reflect the title of your research study, and the content from this section to
the end. You can, but are not obligated to keep the Acknowledgements section.
You should keep the directory tree

* In the directory tree of the README.md file, customize the comments to fit
your project. Update this tree as the project proceeds. Replace the word `study`
in `study.Rmd`, `study.md`, and `study.html` to be the name of your project.

* At the terminal do the following (replacing `LastName_BriefDescription_Journal_Year`
with the appropriate text...

  ```
  mv study.Rmd LastName_BriefDescription_Journal_Year.Rmd
  mv newproject_LICENSE.md LICENSE.md
  ```

* At the prompt type:

  ```
  git init ./
  git add .
  git commit -m "Initial commit"
  ```

* Go to the [SchlossLab repository](https://github.com/schlosslab) on GitHub and
create a new repository with the same name as your folder. Click the "Create
Repository" button.
* Follow the instructions for pushing an existing repository from the command line. For
example (be sure to replace `LastName_BriefDescription_Journal_Year` with the appropriate
text:

  ```
  git remote add origin https://github.com/SchlossLab/LastName_BriefDescription_Journal_Year.git
  git push -u origin master
  ```


* Go forth and experiment, keeping files in their appropriate places.

* You will want to update this page as you go through your work. It is likely
that you'll need to provide a link to the published paper, a brief description
of the study, and instructions for how to generate the paper.


Key concepts and goals
----------------------

To the extent possible under law, the author(s) of this template have dedicated
all copyright and related and neighboring rights to it to the public domain
worldwide under the [CC0 Public Domain Dedication]. The template and all other
content in the [rr-init repository] is distributed without any warranty.

See [Noble 2009] for a full description of and argument for the principle template structure. Some concepts and goals that guided this work:
* (Good) There is a folder for the raw data, which do not get altered, or intermixed with data that is the result of manual or programmatic manipulation. I.e., derived data is kept separate from raw data, and raw data are not duplicated.
* (Good) Code is kept separate from data.
* (Better) Manuscript production output is kept separate from everything else.
* (Good) There is a scratch directory for experimentation. Everything in the scratch directory can be deleted at any time without negative impact.
* (Better) There should be a `README` in evey directory, describing the purpose of the directory and its contents.
* (Best) There is a top-level `Makefile` or [Rmarkdown] file that documents the computational study in executable form. Those files may call out to other `Makefile`'s or `.Rmd` files in subdirectories.
* (Best) There is a formal metadata descriptor at the root of the package that describes all the important input and output data files.
* (Meta) The template structure should have no special software or skill prerequisites to install. Specifically, deploying the template structure should not require installing git, or using the command line.

Acknowledgements
----------------

The initial file and directory structure of this project was developed by a group of participants in the Reproducible Science Curriculum Workshop, held at [NESCent] in December 2014. The structure is based on, and heavily follows the one proposed by [Noble 2009], with a few but small modifications. It has been further modified by Pat Schloss to fit the needs of his research group.

[rr-init repository]: https://github.com/Reproducible-Science-Curriculum/rr-init
[latest release]: https://github.com/Reproducible-Science-Curriculum/rr-init/releases/latest
[NESCent]: http://nescent.org
[Rmarkdown]: http://rmarkdown.rstudio.com/
[Noble 2009]: http://dx.doi.org/10.1371/journal.pcbi.1000424
[CC0 Public Domain Dedication]: http://creativecommons.org/publicdomain/zero/1.0/
