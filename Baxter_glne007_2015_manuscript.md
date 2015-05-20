I.  Abstract

II. Introduction

    a.  Importance

        i.  Body count figures

        ii. Preventability by screening

    b.  Current screening methods

        i.  Structural exams

            1.  Expensive

            2.  Invasive

            3.  Poor patient compliance

        ii. Stool-based tests

            1.  FOBT/FIT

                a.  Poor specificity

                b.  Bad at adenomas

            2.  sDNA/Exact Test

                a.  expensive

                b.  Bad at adenomas

    c.  Potential for microbiome screening

        i.  Reasons microbiome can help address shortcomings

            1.  Inexpensive

            2.  Non-invasive

            3.  Early detection?

                a.  Studies have found enrichment on pre-cancerous
                    adenomas (i.e. – Garrett fuso studies)

        ii. Problems with past microbiome-based studies

            1.  Small n

            2.  Focused on single bugs, not community as a whole

            3.  No cross-validation or validation set

    d.  What we did/set out to do

III. Methods

    a.  Study Design/Patient sampling

    b.  FITs

    c.  16S rRNA Sequencing

        i.  DNA Extraction

        ii. PCR / Primer design

        iii. Cleanup/Normalization

        iv. Sequencing

            1.  3 runs

            2.  MiSeq v2 2x250

    d.  Sequence Curation

        i.  Quality Trimming

        ii. Alignment

        iii. Chimera checking

        iv. Classification/Remove lineage

        v.  Clustering

    e.  Statistical Methods

        i.  AUCRF optimal model selection

        ii. ROC curves, AUC tests, optimal accuracy calculations

        iii. McNemar Test

    f.  Data Availability

        i.  SRA

        ii. Github

IV. Results

First we sought to confirm our previous findings that the microbiome
could be used to distinguish healthy patients from those with carcinomas
or adenomas and to identify discriminatory features. We chose to use the
Random Forest (RF) machine-learning algorithm because it works well for
high-dimensional datasets and includes an internal cross-validation to
prevent overfitting (RF sources). First we generated RF models for
distinguishing normal individuals from those with colorectal cancer
using only the microbiota or the microbiota combined with FIT. The
optimal model for the microbiome only model used 38 OTUs and had an AUC
of 0.845, while the model that included FIT used only 11 OTUs and had an
AUC of 0.967 (Figure 1A, Fig S1A, Fig S1B). The model using both the
microbiota and FIT performed significantly better than FIT alone
(p=0.0024), which had an AUC of 0.929. The bacterial populations that
were most indicative of cancer were associated with the genera
*Porphyromonas* (OTU105, OTU260), *Peptostreptococcus* (OTU310),
*Parvimonas* (OTU281), *Fusobacterium* (OTU264), *Prevotella* (OTU57),
and *Gemella* (OTU356) (Figure 1B). Those that were most predictive of
normal colons belonged to Ruminococcaceae (OTU29) and *Anaerostipes*
(OTU8).

Next we generated RF models for distinguishing normal individuals from
those with colonic adenomas. The optimal model using only the microbiota
contained 53 OTUs and performed comparably to FIT, with AUCs of 0.671
and 0.639 respectively (Figure 1C, Fig S1C). When we combined the
microbiota with FIT, our model significantly outperformed FIT alone
(AUC=0.727, p=0.00054) using only 4 OTUs. These OTUs included OTU29,
which was enriched in normal patients as it was in the normal vs cancer
models. The three other OTUs were assocaiated with Lachnospiraceae
(OTU14), Ruminococcaceae (OTU11), and unclassified member of
Clostridiales (OTU10). Interestingly all four OTUs in the combined model
were among the most abundant Clostridia in our samples. These data show
that with only a few features from the microbiome, we can compliment FIT
to significantly improve detection of both adenomas and carcinomas.

An ideal diagnostic model would be able to detect both adenomas and
carcinomas, so we developed models that would differentiate normal
individuals from those with any type of colonic lesion. The optimal
model combining FIT and the microbiota used 21 OTUs and performed
significantly better than FIT alone for detecting colonic lesions
(p=3e-5), with an AUC of 0.817 compared to 0.749 for FIT. This
differences was due in large part to improved detection of adenomas.
When distinguishing normal from adenoma, the model had an AUC of 0.740,
which was significantly higher than the AUC for FIT, 0.639 (p=3e-5). For
comparing cancer and normal the model was slightly better FIT alone, but
the difference was not statistically significant.

Of the 21 OTUs used in the model, 14 were members of the Clostridia,
including 10 from the Lachnospiraceae family (OTUs 14, 44, 8, 88, 60,
22, 9, 13, 87, 31) and 2 from Ruminococcaceae (OTU29, OTU11). Three OTUs
were associated with the genus *Bacteroides* (OTUs 3, 7, 2)*.* The
remaining OTUs were associated with *Porphyromonas* (OTU105),
*Parabacteroides* (OTU49), *Streptococcus* (OTU20), and
Enterobacteriaceae (OTU28).

To better compare our model to FIT, choose a set cutoff based on

a.  Figures

    1.  Figure 1: Normal vs Cancer, Normal vs Adenoma

        a.  Barplot of cancer vs normal OTUs

        b.  ROC curve of cancer vs normal (microbiome, FIT, microbiome +
            FIT)

        c.  Barplot of adenoma vs normal OTUs

        d.  ROC curve of anoma vs normal (microbiome, FIT, microbiome +
            FIT)

        e.  Suppl 1 – AUCRF curves

    2.  Figure 2: Lesion Model

        a.  ROC curve

        b.  Strip Chart (Norm, Ade, & Canc for FIT and Model)

        c.  FIT vs Model scatter plot

    3.  Table 1: Table of sensitivities and specificities for model and
        FIT

    4.  Figure 3: Sensitivity Barplot

    5.  Table 2: Positive and Negative Predictive values

    <!-- -->

    a.  Text:

    b.  We can use microbiome data to distinguish normal from
        cancer/adenoma.

        i.  Performance of Cancer RF model (fig 1b ROC)

        ii. Microbiome alone isn’t as good as FIT but compliments

        iii. Bugs associated with cancer

            1.  Oral pathogens? – Porphyromonas (x2), Parvimonas,
                Fusobacterium, Gemella

            2.  Butyrate producers? – Clostridium XIVa, Anaerostipes

        iv. Adenoma RF model – not as good as cancer

        v.  Better than FIT, compliments FIT with only 5 OTUs

        vi. Bugs associated with adenoma – lots of butyrate producers –
            Lachno- and Rumincoccus

b.  A single model combining Adenoma and Cancer (Lesion) vs Normal

    i.  Model performance – better than FIT for adenoma, lesion, and
        cancer

    ii. Most OTUs are predictive of adenomas, only one (Porphyromonas)
        is for cancer

c.  Set cutoff for highest accuracy compare model to fit

    i.  Much higher sensitivity, but lower specificity. Overall accuracy
        is higher.

        1.  Significantly better for detecting all stages of cancer

        2.  Way better at detecting adenomas

    ii. Discus scatter plot – when FIT is negative

        1.  Detect X% of cancers that FIT misses

        2.  Detect X% of adenomas that FIT misses

        3.  Some specificity lost compared to FIT

d.  Extrapolate to normal population calculate PPV and NPV

    i.  Our PPV is much lower than FIT

    ii. Our NPV is amazing

e.  Add figure with Metadata?

<!-- -->

I.  Discussion

    a.  Talk about findings, implications, etc.

    b.  Majority of predictive OTUs are enriched in normal individuals.
        Suggests a loss of good bugs could be just as important as the
        arrival of potentially pathogenic bugs.

    c.  Better to sacrifice specificity for better sensitivity?

        i.  Positive test colonoscopy (not so bad)

        ii. Would decreased cost of cancer treatment offset increased
            cost of colonoscopies?

    d.  Incorporate other risk factors like diet, BMI, age?

    e.  Feasibility?

        i.  Decreasing cost of sequencing and microbiome analysis

        ii. PCR-based approach. Coupled to FIT?

    f.  New type of personalized medicine?

        i.  Need for longitudinal studies

            1.  How does microbiome change after treatment

            2.  Microbiome predictive of remission/relapse

            3.  Dysbiosis the cause or effect of tumors
