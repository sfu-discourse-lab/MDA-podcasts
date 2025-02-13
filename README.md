# MDA-podcasts

#### Supplementary materials for: Podcasts as an emerging register of computer-mediated communication (version 1.0)


DOI: 

### Description

This repository comprises the data and scripts for conducting multi-dimensional analyses of three datasets: a dataset of podcasts and computer-medidated registers, a dataset of podcasts and traditional spoken registers, as well as a combined dataset of podcasts, computer-mediated registers, and traditional spoken registers. It also comprises comprehensive statistical material as described in 

* Ehret, Katharina, Laurens Bosman, Aminat Babayode, Nicole Chan, Ivan Fong, Noelle Harris, Alissa Hewton, Danica Reid, Rebekah Wong, Maite Taboada. 2025. "Podcasts as an emerging register of computer-mediated communication". To appear in *Register Studies*.


This paper presents three full multi-dimensional analyses of podcasts as an emerging register of computer-mediated communication, together with other registers. Podcasts, a relatively recent audio medium, have risen in popularity since their initial appearance in the mid-2000s. Yet, little is known about their structural linguistic characteristics and their relation to other computer-mediated, spoken and written registers. Addressing this gap in the literature, the lexico-grammatical features of a representative sample of Spotify podcast transcripts are compared to selected computer-mediated registers (e.g., personal blog, informational blog, interview) and traditional spoken registers (e.g., broadcast, conversation, unscripted speech). Finally, the paper evaluates the two separate MDAs by comparing them to a single MDA of podcasts, computer-mediated and traditional spoken registers.

The datasets published in this repository originate from the [*Spotify Podcast Dataset*](https://research.atspotify.com/publications/100000-podcasts-a-spoken-english-document-corpus/), the [*Corpus of Online Registers of English*](https://www.english-corpora.org/core/) (CORE), the [*British National Corpus*](https://www.english-corpora.org/core/) (BNC, XML edition), the [*Santa Barbara Corpus of Spoken American English*](https://www.linguistics.ucsb.edu/research/santa-barbara-corpus), and the English [*Pear Stories*](http://pearstories.org/english/english.htm). The corpus data was annotated with parts-of-speech tags using the [*Multidimensional Analysis Tagger*](https://sites.google.com/site/multidimensionaltagger/home) and all tags were automatically retrieved with a custom-written python script (available [here](https://github.com/sfu-discourse-lab/MDA_project)). See the related publication for details on the dataset and methodology.

### Content overview

* :file_folder: mda_CORE -- all materials and scripts for the analysis of podcasts and computer-mediated registers.

* :file_folder: mda_single -- scripts and statistics for the joint analysis of podcasts, computer-mediated registers, and traditional spoken registers. This folder does not contain any data. Use the data in the mda_CORE and mda_traditional folders. 
  
* :file_folder: mda_traditional -- all materials and scripts for the analysis of podcasts and traditional spoken registers.

* postag_description.csv -- a list of 67 lexico-grammatical features. The first column provides the part-of-speech tag, the second column gives a brief description of the feature.

#### Description of statistical materials

Each folder contains a stats folder with the following statistical materials 

* eigenvalues -- the unrotated eigenvalues which were calculated based on the correlation matrix of normalised feature frequencies.

* factorScores -- the factor scores of a three factor solution for each of the individual texts in the dataset. The first column contains the file names.

* KMO -- output of test for the Kaiser-Meyer-Olkin factor adequacy which shows that the data is factorable.

* loadings -- feature loadings of each linguistic feature on each factor in the three factor solution. The first column lists the feature tags (see POS-tag_description.csv, for a description of the features). Loadings were rounded to three decimal places.

* meanFactorScores -- mean factor scores for each register in the dataset. The mean factor scores were calculated based on the factor scores of the individual texts in the dataset. Mean factor scores are essentially an average across all texts belonging to one register.

* postag_counts -- the raw feature frequencies of 67 lexico-grammatical features (see postag_description) which were automatically retrieved from each text in the dataset.

* postag_counts_normalized -- normalized feature frequencies of 67 lexico-grammatical features (see postag_description) which were automatically retrieved from each text in the dataset. The frequencies were normalized per 1000 word tokens. This csv serves as input for the factor analysis. The file is zipped, because it is rather large.

* sd_meanFactorScores -- standard deviation of the mean factor scores per register.
  
* R_squared.txt -- R-squared values and regression output.

#### Scripts and other files

* mda_factorAnalysis -- R script containing the commands for conducting factor analysis (multi-dimensional analysis) and other statistics as described in the related publication.
  
* mda_ggplots -- R script for visualisations.

* texts_by_register -- list of all individual texts (first column) and information on their register (second column). Note that short register labels are used.



### Cite as

Ehret, Katharina, Laurens Bosman, Aminat Babayode, Nicole Chan, Ivan Fong, Noelle Harris, Alissa Hewton, Danica Reid, Rebekah Wong, Maite Taboada. 2025. Supplementary materials for: Podcasts as an emerging register of computer-mediated communication. Zenodo.
