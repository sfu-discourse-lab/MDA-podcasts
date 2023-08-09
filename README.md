# MDA-podcasts

#### Supplementary materials for: Podcasts as an emerging register of computer-mediated communication (version 1.0)


DOI: will be provided upon submission

### Description

This repository comprises the data and scripts for conducting multi-dimensional analyses of two podcast datasets: a dataset of podcast transcripts and written and spoken computer-medidated registers, and a dataset of podcast transcripts and traditional spoken registers. It also comprises comprehensive statistical material as described in 

* tba

This paper presents multi-dimensional analyses of podcasts as an emerging register of computer-mediated communication. Podcasts, a relatively recent audio medium, have risen in popularity since their initial appearance in the mid-2000s. Yet, little is known about their structural linguistic characteristics and their relation to other computer-mediated, spoken and written registers. Addressing this gap in the literature, the lexico-grammatical features of a representative sample of Spotify podcast transcripts are compared to selected computer-mediated registers (e.g., personal blog, informational blog, interview) as well as traditional spoken registers (e.g., broadcast, conversation, unscripted speech).

The datasets published in this repository originate from the [*Spotify Podcast Dataset*](https://research.atspotify.com/publications/100000-podcasts-a-spoken-english-document-corpus/), the [*Corpus of Online Registers of English*](https://www.english-corpora.org/core/) (CORE), the [*British National Corpus*](https://www.english-corpora.org/core/) (BNC, XML edition), the [*Santa Barbara Corpus of Spoken American English*](https://www.linguistics.ucsb.edu/research/santa-barbara-corpus), and the English [*Pear Stories*](http://pearstories.org/english/english.htm). The corpus data was annotated with parts-of-speech tags using the Multidimensional Analysis Tagger and all tags were automatically retrieved with a custom-written python script (available here https://github.com/sfu-discourse-lab/MDA_project). See the related publication for details on the dataset and methodology.

### File description and overview: podcasts and computer-mediated registers 

* eigenvalues_CORE.csv

This csv contains the unrotated eigenvalues which were calculated based on the correlation matrix of normalised feature frequencies.

* factorScores_CORE.csv

This csv contains the factor scores of a three factor solution for each of the individual texts in the dataset. The first column contains the file names.

*KMO_CORE.txt

A text file with the output of test for the Kaiser-Meyer-Olkin factor adequacy which shows that the data is factorable.

* loadings_CORE.csv

The feature loadings of each linguistic feature on each factor in the three factor solution. The first column lists the feature tags (see POS-tag_description.csv, for a description of the features). Loadings were rounded to three decimal places.

* mda_factorAnalysis_CORE.r

The r script containing the commands for conducting factor analysis (multi-dimensional analysis) and other statistics as described in the related publication. 

* meanFactorScores_CORE.csv

A csv containing the mean factor scores for each register in the dataset. The mean factor scores were calculated based on the factor scores of the individual texts in the dataset. Mean factor scores are essentially an average across all texts belonging to one register.

* postag_counts_CORE.csv

This csv contains the raw feature frequencies of 67 lexico-grammatical features (see postag_description) which were automatically retrieved from each text in the dataset.

* postag_counts_normalized_CORE.csv

This csv contains normalised feature frequencies of 67 lexico-grammatical features (see postag_description) which were automatically retrieved from each text in the dataset. The frequencies were normalised per 1000 word tokens. This csv serves as input for the factor analysis. The file is zipped, because it is rather large.

* sd_meanFactorScores_CORE.csv

The standard deviation of the mean factor scores per register. 

* texts_by_register_CORE.csv

A list of all individual texts (first column) and information on their register (second column). Note that short register labels are used.

### File description and overview: podcasts and traditional spoken registers

* eigenvalues_traditional.csv

This csv contains the unrotated eigenvalues which were calculated based on the correlation matrix of normalised feature frequencies.

* factorScores_traditional.csv

* *KMO_traditional.txt

A text file with the output of test for the Kaiser-Meyer-Olkin factor adequacy which shows that the data is factorable.

This csv contains the factor scores of a three factor solution for each of the individual texts in the dataset. The first column contains the file names.

* loadings_traditional.csv

The feature loadings of each linguistic feature on each factor in the three factor solution. The first column lists the feature tags (see POS-tag_description.csv, for a description of the features). Loadings were rounded to three decimal places.

* mda_factorAnalysis_traditional.r

The r script containing the commands for conducting factor analysis (multi-dimensional analysis) and other statistics as described in the related publication. 

* meanFactorScores_traditional.csv

A csv containing the mean factor scores for each register in the dataset. The mean factor scores were calculated based on the factor scores of the individual texts in the dataset. Mean factor scores are essentially an average across all texts belonging to one register.

* postag_counts_normalized_traditional.csv

This csv contains normalised feature frequencies of 67 lexico-grammatical features (see postag_description) which were automatically retrieved from each text in the dataset. The frequencies were normalised per 1000 word tokens. This csv serves as input for the factor analysis. The file is zipped, because it is rather large.

* postag_counts_traditional.csv

This csv contains the raw feature frequencies of 67 lexico-grammatical features (see postag_description) which were automatically retrieved from each text in the dataset.

* sd_meanFactorScores_traditional.csv

The standard deviation of the mean factor scores per register. 

* texts_by_register_traditional.csv

A list of all individual texts (first column) and information on their register (second column). Note that short register labels are used.


### Other files

* postag_description.csv

A list of 67 lexico-grammatical features. The first column provides the part-of-speech tag, the second column gives a brief description of the feature.


