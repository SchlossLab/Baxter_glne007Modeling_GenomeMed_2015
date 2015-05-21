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
		- subjects 18 y.o. or older, able to tolerate 58ml of blood removal.
		From Joe's paper:
			"Eligible patients were 18 years of age or older, able to tolerate 58 
			mL of blood removal at 2 time points, willing to complete an gFOBT Kit, 
			able to provide informed consent, and had colonoscopy and his- tologically 
			confirmed colonic disease status. Patients were excluded if known HIV or 
			chronic viral hepatitis, known HNPCC or FAP, inflammatory bowel disease, 
			any surgery, radiation or chemotherapy for their current colorectal cancer
			 or colonic adenoma. Colonoscopies were performed and fecal samples were 
			 collected from subjects in 4 loca- tions: Toronto (Ontario, Canada), 
			 Boston (Massachusetts, USA), Houston (Texas, USA), and Ann Arbor 
			 (Michigan, USA). Following endoscopic examination, patients without 
			 colonic abnormalities were designated as healthy. Exami- nations that 
			 revealed the presence of lesions resulted in a biopsy and subsequence 
			 diagnosis of adenoma or carcinoma."..."All participants collected a 
			 whole evacuated stool in a hat with no preservatives after following 
			 the usual dietary and medication restrictions for 24 hours. The whole 
			 stool was then packaged in an insulated box with ice packs and shipped
			  to the processing center along with the gFOBT cards via next day delivery. 
			  Upon receipt, the feces were stored at !80C."
    b.  FITs
Fecal material for FIT was collected from frozen stool aliquots using OC FIT-CHEK sampling bottles (Polymedco Inc.) and processed using an OC-Auto Micro 80 automated system (Polymedco Inc.). Raw FIT results were used for generating ROC curves and for building RF models.  Sensitivities and specificities reported for FIT are based on a cutoff of 100ng/ml.

    c.  16S rRNA Sequencing

DNA was extracted from approximately 50mg of fecal material from each subject using the PowerSoil-htp 96 Well Soil DNA isolation kit (MO BIO Laboratories) and an epMotion 5075 automated pipetting system (Eppendorf).  The V4 region of the bacterial 16S rRNA gene was amplified using custom barcoded primers and sequenced as described previously using an Illumina MiSeq sequencer (citation). The 490 samples were divided into three sequencing runs to maximize sequencing depth.

    d.  Sequence Curation
The 16S rRNA gene sequences were curated using the mothur software package, as described previously (citation). Briefly, paired-end reads were merged into contigs, screened for quality, aligned to SILVA 16S rRNA sequence database, and screened for chimeras.  Curated sequences were clustered in to operationall taxonomic units (OTUs)  using a 97% similarity cutoff. The number of sequences in each sample was rarefied to 10,000 per sample to minimize the effects of uneven sampling.

    e.  Statistical Methods
All statistical analyses were performed using the R software package(citation).  Random Forest models were generated using the AUCRF package.  ROC curves were generated and analyzed using the pROC package. The AUC of ROC curves was compared using the method described by DeLong et al. (citation). The optimal cutoff for the RF model was determined using Youden's J statistic as implemented in the pROC package in R (Youden, 1950). The sensitivities of FIT and the RF model were compared using McNemar's chi-squared test.

    f.  Data Availability

        i.  SRA

        ii. Github

IV. Results

**Microbiome-based models distinguish healthy from cancer or adenoma**
First we sought to confirm our previous findings that the microbiome could be used to distinguish healthy patients from those with carcinomas or adenomas. We chose to use the Random Forest (RF) machine-learning algorithm because it works well for high-dimensional datasets and includes an internal cross-validation to prevent overfitting (RF sources). First we generated RF models for distinguishing normal individuals from those with colorectal cancer using only the microbiota or the microbiota combined with FIT. The optimal model for the microbiome only model used 38 OTUs and had an AUC of 0.845, while the model that included FIT used only 11 OTUs and had an AUC of 0.967 (Figure 1A, Fig S1A, Fig S1B). The model using both the microbiota and FIT performed significantly better than FIT alone (p=0.0024), which had an AUC of 0.929. The bacterial populations that were most indicative of cancer were associated with the genera *Porphyromonas* (OTU105, OTU260), *Peptostreptococcus* (OTU310), *Parvimonas* (OTU281), *Fusobacterium* (OTU264), *Prevotella* (OTU57), and *Gemella* (OTU356) (Figure 1B). Those that were most predictive of normal colons belonged to Ruminococcaceae (OTU29) and *Anaerostipes* (OTU8).

Next we generated RF models for distinguishing normal individuals from those with colonic adenomas. The optimal model using only the microbiota contained 53 OTUs and performed comparably to FIT, with AUCs of 0.671 and 0.639 respectively (Figure 1C, Fig S1C). When we combined the microbiota with FIT, the model significantly outperformed FIT alone (AUC=0.727, p=0.00054) using only 4 OTUs. These OTUs included OTU29, which was enriched in normal patients like in the normal vs cancer models. The three other OTUs were assocaiated with Lachnospiraceae (OTU14), Ruminococcaceae (OTU11), and unclassified member of Clostridiales (OTU10). Interestingly all four OTUs in the combined model were among the most abundant Clostridia in our samples. These data show that models based on the fecal microbiota can be used to discriminate healthy  individuals from those with adenomas or cancer. Such models can also compliment FIT to significantly improve test performance.

**RF Model for Detecting Colonic Lesions**
An ideal diagnostic model would be able to detect both adenomas and carcinomas, so we developed a single model that would differentiate normal individuals from those with any type of colonic lesion. The optimal model combining FIT and the microbiota used 21 OTUs and performed significantly better than FIT alone for detecting colonic lesions (p=3e-5), with an AUC of 0.817 compared to 0.749 for FIT. This difference was due in large part to improved detection of adenomas. When distinguishing normal from adenoma, the model had an AUC of 0.740, which was significantly higher than the AUC for FIT, 0.639 (p=3e-5). For comparing cancer and normal the model was not significantly better than FIT alone.

Of the 21 OTUs used in the model, 14 were members of the Clostridia,
including 10 from the Lachnospiraceae family (OTUs 14, 44, 8, 88, 60,
22, 9, 13, 87, 31) and 2 from Ruminococcaceae (OTU29, OTU11). Three OTUs
were associated with the genus *Bacteroides* (OTUs 3, 7, 2). The
remaining OTUs were associated with *Porphyromonas* (OTU105),
*Parabacteroides* (OTU49), *Streptococcus* (OTU20), and
Enterobacteriaceae (OTU28).  Interestingly the majority of OTUs used in the 
model were enriched in normal patients.  

**Comparing RF model to FIT**
We defined an optimal cutoff for the RF model based on Youden's J statistic (Youden, 1950).
The RF model detected 95.0% of cancers 61.1% of adenomas compared to 75.0% and 15.7% for 
FIT (Table 1, Figure 2A, Figure 2B). The RF model had significantly improved sensitivity 
for both advanced and non-advanced adenomas as well as stage I, II, and III cancers 
(Figure 3).  The increased sensitivity of the RF model was accompanied by a decrease in 
specificity compared to FIT (Table 1).  

To better understand the relationship between the RF model and FIT, we compared the results
of the two tests for each sample (Figure 2C). All samples that tested positive by FIT
also tested positive in the RF model, meaning the RF model detected all of the lesions
that FIT was able to detect.  However, many samples that with negative FIT results tested
positive by the RF model.  The RF model detected 80.0% of cancers and 53.9% of adenomas 
that FIT failed to detect, while maintaining a specificity of 78.4%.

**Extrapolation of predictive values**




a.  Figures

    1.  Figure 1: Normal vs Cancer, Normal vs Adenoma

        a.  Barplot of cancer vs normal OTUs

        b.  ROC curve of cancer vs normal (microbiome, FIT, microbiome +
            FIT)

        c.  Barplot of adenoma vs normal OTUs

        d.  ROC curve of adenoma vs normal (microbiome, FIT, microbiome +
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
            
            
            
References

Elisabeth R. DeLong, David M. DeLong and Daniel L. Clarke-Pearson (1988) “Comparing the areas under two or more correlated receiver operating characteristic curves: a nonparametric approach”. Biometrics 44, 837–845.
