##Microbiome analysis complements fecal occult blood test for improved detection of colonic lesions

Nielson T. Baxter, Mack T. Ruffin IV, Mary A.M. Rogers, and Patrick D. Schloss

### Abstract
Colorectal cancer is the third most common and third leading cause of death among cancers in the United States. Patients diagnosed at the earliest stages of tumor development have greater than 90% chance of survival, however, less than half of individuals for whom screening is recommended receive appropriate screening. Structural exams like colonoscopies and sigmoidoscopies are expensive and relatively invasive, while stool-based diagnostics, though convenient and inexpensive, fail to detect precancerous lesions, called adenomas. Thus there is a need for improved diagnostic methods that are inexpensive, non-invasive, and capable of detecting both adenomas and cancer. Here we demonstrate that a diagnostic model incorporating both fecal bacterial community profiling and fecal occult blood can significantly improve the detection of colonic lesions.

Using stool samples from 490 patients we developed a cross-validated random forest classification model for detecting colonic lesions based on the abundances of certain bacterial populations and the concentration of human globin as measured by a fecal immunochemical test (FIT). We compared this model to using FIT alone, one of the most accurate and widely used noninvasive methods for colorectal cancer screening. The random forest model significantly outperformed FIT, detecting 95% of cancers and 61.1% of adenomas compared to 75.0% and 15.7% for FIT. The model had significantly higher sensitivity for nonadvanced and advanced adenomas, as well as stage I, II, and III cancers. Of the colonic lesions missed by FIT, the model detected 80.0% of cancers and 53.9% of adenomas. This increase in sensitivity was accompanied by a relatively low specificity of 76.2%.

Our results show that analysis of the fecal microbial community can complement existing noninvasive screening methods to improve detection of colonic lesion, especially at early stages of tumor development. With a negative predictive value of 99.98%, our model could be used to accurately identify those patients for whom a colonoscopy is unnecessary, drastically reducing healthcare costs and complications due to invasive screening. By incorporating other biomarkers, like those used in multitarget stool DNA tests, we can further improve the accuracy of noninvasive tests leading to a decrease in the incidence and mortality of colorectal cancer.

### Introduction

Colorectal cancer (CRC) is the third most common cancer among men and women in the United States and the third leading cause of cancer-related deaths (citation). Fortunately CRC incidence and mortality have steadily declined in recent decades, due in large part to increased screening. Further progress is possible by increasing access to and accuracy of diagnostic tests.

Although structural exams like colonoscopy and sigmoidoscopy are able to detect both cancer and adenomas, their high cost and invasive nature are barriers for many people. For example, fear, discomfort, and embarrassment are among the most cited reasons patients choose not to undergo CRC screening. Likewise the large disparity in screening rates between those with and without health insurance highlights the need for less expensive screen methods. Unfortunately cheaper, less invasive stool based tests like FOBT and FIT are unable to reliably detect adenomas. Fecal DNA testing shows potential for improved sensitivity over FOBT, but the high cost remains a potential barrier to screening. Thus there is need for novel screening methods that are inexpensive and capable of detecting both cancer and adenomas.

The gut microbiota, the collection of microorganisms that inhabit the gastrointestinal tract, are one potential source of biomarkers for detecting colonic lesions. Numerous studies have observed alterations in the gut bacterial communities of patients with CRC. Experiments in animal models have demonstrated that such alterations have the potential to accelerate tumorigenesis. Furthermore several members of the gut microbiota have been shown to potentiate both the development and progression of CRC by a variety of mechanisms. While each of these organisms may play a role in certain cases of CRC, none of them is present in every case of CRC. Thus no one organism is an effective biomarker on its own. 

We have perviously shown that statistical models that take into account the abundances of multiple bacteria species can be used to distinguish healthy individuals from those with colonic lesions. In the present study we expanded upon those findings by demonstrating the potential for microbiome analysis to complement FIT for improved detection of colonic lesions. We did so using the largest patient cohort to date for studying differences in the microbiomes of patients with adenomas and carcinomas. We also improved upon previous studies by utilizing random forest (RF), a decision tree-based machine algorithm for classification, which includes an internal cross-validation to prevent overfitting. By incorporating both FIT and bacterial abundances into a single RF model, we were able to improve the sensitivity for adenomas and most stages of cancer.



### Methods

*Study Design/Patient sampling* 
Elligible patients for this study were at least 18 years old, willing to sign informed consent, able to tolerate removal of 58ml of blood, and willing to collect a stool sample. Patients were excluded if they had undergone surgery, radiation, or chemotherapy for current CRC prior to baseline samples or had inflammatory bowel disease, known hereditary nonpolyposis CRC, or familial adenomatous polyposis. Colonoscopies were performed and fecal samples were collected from subjects in 4 locations: Toronto (Ontario, Canada), Boston (Massachusetts, USA), Houston (Texas, USA), and Ann Arbor (Michigan, USA). Patient diagnoses were determined by colonoscopic examination. Lesions were biopsied and diagnosed as adenoma or cancer based on subsequent histopathological examination. Whole evacuated stool was collected from each patient into hat, packed on ice, shipped to a processing center via next day delivery, and stored at -80˚C.
			 
**Fecal Immunochemical Tests** 
Fecal material for FIT was collected from frozen stool aliquots using OC FIT-CHEK sampling bottles (Polymedco Inc.) and processed using an OC-Auto Micro 80 automated system (Polymedco Inc.). Raw FIT results were used for generating ROC curves and for building RF models. Sensitivities and specificities reported for FIT are based on a cutoff of 100ng/ml.


**16S rRNA Sequencing** 
DNA was extracted from roughly 50mg of fecal material from each subject using the PowerSoil-htp 96 Well Soil DNA isolation kit (MO BIO Laboratories) and an epMotion 5075 automated pipetting system (Eppendorf). The V4 region of the bacterial 16S rRNA gene was amplified using custom barcoded primers and sequenced as described previously using an Illumina MiSeq sequencer (citation). The 490 samples were divided into three sequencing runs to increase sequencing depth.

**Sequence Curation** 
The 16S rRNA gene sequences were curated using the mothur software package, as described previously (citation). Briefly, paired-end reads were merged into contigs, screened for quality, aligned to SILVA 16S rRNA sequence database, and screened for chimeras. Curated sequences were clustered in to operationall taxonomic units (OTUs) using a 97% similarity cutoff. The number of sequences in each sample was rarefied to 10,000 per sample to minimize the effects of uneven sampling.

**Statistical Methods** 
All statistical analyses were performed using the R software package(citation). Random Forest models were generated using the AUCRF package. ROC curves were generated and analyzed using the pROC package. The AUC of ROC curves was compared using the method described by DeLong et al. (citation). The optimal cutoff for the RF model was determined using Youden's J statistic as implemented in the pROC package in R (Youden, 1950). The sensitivities of FIT and the RF model were compared using McNemar's chi-squared test.

**Data Availability** 
Raw fastq files and MIMARKS file are available through the NCBI Sequence Read Archive. A data analysis pipeline and all necessary scripts are available at github.com/SchlossLab/Baxter\_glne007Modeling_2015.


### Results

**Microbiome-based models distinguish healthy from cancer or adenoma** 
First we sought to confirm our previous findings that the microbiome could be used to distinguish healthy patients from those with carcinomas or adenomas. We chose to use the Random Forest (RF) machine-learning algorithm because it works well for high-dimensional datasets and includes an internal cross-validation to prevent overfitting (RF sources). First we generated RF models for distinguishing normal individuals from those with colorectal cancer using only the microbiota or the microbiota combined with FIT. The optimal model for the microbiome only model used 38 OTUs and had an AUC of 0.845, while the model that included FIT used only 11 OTUs and had an AUC of 0.967 (Figure 1A, Fig S1A, Fig S1B). The model using both the microbiota and FIT performed significantly better than FIT alone (p=0.0024), which had an AUC of 0.929. The bacterial populations that were most indicative of cancer were associated with the genera *Porphyromonas* (OTU105, OTU260), *Peptostreptococcus* (OTU310), *Parvimonas* (OTU281), *Fusobacterium* (OTU264), *Prevotella* (OTU57), and *Gemella* (OTU356) (Figure 1B). Those that were most predictive of normal colons belonged to Ruminococcaceae (OTU29) and *Anaerostipes* (OTU8).

Next we generated RF models for distinguishing normal individuals from those with colonic adenomas. The optimal model using only the microbiota contained 53 OTUs and performed comparably to FIT, with AUCs of 0.671 and 0.639 respectively (Figure 1C, Fig S1C). When we combined the microbiota with FIT, the model significantly outperformed FIT alone (AUC=0.727, p=0.00054) using only 4 OTUs. These OTUs included OTU29, which was enriched in normal patients as it was in the normal vs cancer models. The three other OTUs were assocaiated with Lachnospiraceae (OTU14), Ruminococcaceae (OTU11), and unclassified member of Clostridiales (OTU10). Interestingly all four OTUs in the combined model were among the most abundant Clostridia in our samples. These data show that models based on the fecal microbiota can be used to discriminate healthy individuals from those with adenomas or cancer. Such models can also complement FIT to significantly improve test performance.

**RF Model for Detecting Colonic Lesions** 
An ideal diagnostic model would be able to detect both adenomas and carcinomas, so we developed a single model that would differentiate normal individuals from those with any type of colonic lesion. The optimal model combining FIT and the microbiota used 21 OTUs. Of those OTUs, 14 were members of the Clostridia, including 10 from the Lachnospiraceae family (OTUs 14, 44, 8, 88, 60, 22, 9, 13, 87, 31) and 2 from the Ruminococcaceae family (OTU29, OTU11). Three OTUs were associated with the genus *Bacteroides* (OTUs 3, 7, 2). The remaining OTUs were associated with *Porphyromonas* (OTU105), *Parabacteroides* (OTU49), *Streptococcus* (OTU20), and Enterobacteriaceae (OTU28). Interestingly the majority of OTUs used in the model were enriched in normal patients. 

The model had an AUC of 0.943 for comparing cancer to normal, 0.740 for adenoma to normal, and 0.817 for all lesions to normal (Figure 2?). We defined an optimal cutoff for the RF model based on Youden's J statistic (Youden, 1950). At this cutoff, the RF model had a sensitivity of 95.0(90.8-98.3) for cancers. The model's performance was not significantly different across cancer stages with sensitivities of 89.7, 97.1, 97.2, and 100 for stages I, II, III, and IV, respectively (Figure 3). The RF model had a sensitivity of 61.1(54.6-67.7) for all adenomas with no significant difference between advanced and nonadvanced adenomas.

Previous studies have identified differences in diagnostic test performance for certain demographic groups or for people taking certain medications (find citations). Therefore we tested whether the RF model performance differed between patient populations. The model performed significantly better for females than males (p=0.027). We suspected that the difference could be due to having more adenoma samples from males (n=118) than females (n=80). To correct for this we normalized samples such that male and female groups contained equal numbers of adenomas, cancers, and normal samples. We resampled 1000 times and tested for a significant difference in AUC between males and females. Of the 1000 iterations 46% of tests resulted in a p-value less than 0.05, making it unclear whether gender truly affects the performance of the model. Additionally, we found no difference in model performance according to age, BMI, NSAID usage, diabetes, smoking, or previous history of polyps. 

As a final metric of our model's performance we estimated the positive predictive value (PPV) and negative predictive value (NPV) by extrapolating its performance on an average-risk population using previously published values for CRC prevalence (@heitman2009prevalence). Based on a prevalence of 0.3% for CRC, the model would have a relatively low PPV of 1.19%, but a high NPV of 99.98%. For advanced adenomas the model would have a PPV of 13.83% and NPV of 97.17% assuming a prevalence of 5.7%. With a prevalence of 17.7% for nonadvanced adenomas, the PPV for the model would be 34.52% and the NPV would be 89.49%.


**Comparison with FIT** 
Next we compared the performance of the RF model to using FIT alone. The AUC for the RF model was significantly higher than FIT for distinguishing adenoma from normal or all lesions from normal, but not cancer from normal (Figure 2A). Examination of the ROC curves for the two tests shows that the RF model does not outperform FIT until the specificity drops below approximately 0.9. Below a specificity of approximately 0.8 the sensitivity of the RF model greatly excedes that of FIT.

At the defined cutoffs (0.602 for the RF model, 100ng/ml for FIT) The RF model detected 95.0% of cancers 61.1% of adenomas compared to 75.0% and 15.7% for FIT (Table 1, Figure 2A, Figure 2B). When adenomas and cancers were pooled together, the RF model detected 73.9% of lesions, while FIT only detected 38.1%. The RF model had significantly improved sensitivity for both advanced and non-advanced adenomas as well as stage I, II, and III cancers (Figure 3). The increased sensitivity of the RF model was accompanied by a decrease in specificity (76.2%) compared to FIT (97.1%). 

To better understand the relationship between the RF model and FIT, we compared the results of the two tests for each sample (Figure 2C). All samples that tested positive by FIT also tested positive in the RF model, meaning the RF model detected all of the lesions that FIT was able to detect. However the RF model was able to detect 80.0% of cancers and 53.9% of adenomas that FIT failed to detect, while maintaining a specificity of 78.4%.

	*Figures*

	1. Figure 1: Normal vs Cancer, Normal vs Adenoma
    	a. ROC curve of cancer vs normal (microbiome, FIT, microbiome + FIT)
    	b. ROC curve of adenoma vs normal (microbiome, FIT, microbiome + FIT)
    	c. Stripchart of cancer/adenoma vs normal OTUs

	2. Figure 2: Lesion Model
    	a. ROC curve
    	b. OTU abundance stripchart? OR table of OTU classifications?

	3. Table 1: Table of sensitivities and specificities for model and FIT

	4. Figure 3: Model vs FIT
    	a. Strip Chart (Norm, Ade, & Canc for FIT and Model)
    	b. FIT vs Model scatter plot
    	c. Sensitivity Barplot

	*Supplementary Figures*
	1. AUCRF curves (AUC vs Number of Features)
	
	2. Supp Table 1: Positive and Negative Predictive values
	
	3. Table of OTUs used for each model and their classification?


### Discussion

Our findings demonstrate the potential for combining microbioime analysis with conventional stool-based tests to improve CRC detection. Using the random forest algorithm made it possible to interpret FIT results in the context of the microbiome and vice versa. The RF model had significantly higher sensitivity for lesions at almost all stages of tumorigenesis. Moreover the model detected the majority of lesions that FIT was unable to detect. The shortcomings of the RF model were its lack of specificity and low PPV. In other systems, such flaws would result in potentially dangerous over treatment. However in the case of CRC, patients are already recommended to receive regular colonoscopies or sigmoidoscopy. Therefore the potential value of the RF model is in its high sensitivity and NPV. With an NPV of 99.98%, the model could be used to determine those patients for whom regular colonoscopies are unnecessary. This strategy could result in a decrease in the number of colonosopies, thereby reducing both the financial costs and potential health risks of structural screening methods.

The accuracy of the RF model would likely be improved by incorporating additional data. For example several bacterial toxins are capable of exacerbating tumorigeneisis, and there is some evidence that methanogenic archaea are associated with CRC. These microbial biomarkers could be combined with 16S rRNA sequencing for a more comprehensive analysis of the microbiome. Furthermore host-associated biomakers, like _KRAS_ mutations, _B_-actin, or aberrant methylation of _NDRG4_ and _BMP3_ could add to the our model. We have shown previously that patient demographic information can strengthen microbiome-based models for distinguishing healthy patients from those with CRC. Thus interpreting both host and microbial biomarkers in the context of an individual's risk could further improve screening accuracy. 

Since the gut microbiome of healthy individuals is relatively stable over long periods of time, the best way to detect malignant changes may be through regular monitoring of their fecal microbial community. The drastic drop in sequencing costs in recent years and streamlined sequence analysis pipelines make this form of highly personalized medicine economically and technically feasible. This approach would enable the detection of a wide variety of microbiome-associated diseases, like Crohn's disease, ulcerative colitis, or susceptibility to enteric pathogens. Interestingly the majority of predictive OTUs in our model were enriched in normal individuals, suggesting that a loss of beneficial organisms in addition to the emergence of pathogens may be important for colorectal cancer development. Many of the OTUs that were depleted in patients with lesions belonged to the Ruminococcoaceae and Lachnospiraceae families, which are the predominant producers of butyrate, an anti-inflammatory and anti-tumorigenic metabolite. Loss of this or other beneficial microbial metabolites may be risk factors for CRC. These possibilities highlight the need for longitudinal studies to better understand how changes to an individual's microbiome or the metabolic profile of the gut might predispose them to CRC. 

As in earlier studies, we identified an OTU associated with *Fusobacterium nucleatum* that was enriched in patients with CRC. Other OTUs enriched in CRC samples were associated with *Porphyromonas*, *Gemella*, *Parvimonas*, and *Prevotella*. Surprisingly these taxa are all commonly associated with periodontal disease, and with the exception of *Prevetella*, are usually less abundant in the gut. This observation may warrant further investigation into a potential link between inflammatory diseases of the mouth and those of the gut. Since the structure of the oral microbiome is strongly correlated with that of the gut, alterations in the oral community could be a proxy for ongoing or even future changes to the gut community. 

      
      

