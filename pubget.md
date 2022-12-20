# Title

From PubMed to a DataFrame: tools & resources for easier neuroimaging text-mining.

# Body

## Intro

With thousands of publications each year, the neuroimaging literature is a rich but challenging resource.
To exploit it fully, (semi-)automated approaches for indexing, aggregating and summarizing articles have become necessary.
Examples include large-scale meta-analyses (NeuroSynth, NeuroQuery), topic modelling, and more.

An important challenge to such text-mining projects is the construction of an appropriate dataset.
Before performing high-level analyses, one must download a large number of articles and extract the relevant text, metadata and possibly stereotactic coordinates.

Due to this difficulty, most projects rely on NeuroSynth or NeuroQuery data.
This drastically limits possibilities: the text itself is not available (only text-frequency features), missing articles cannot be added, etc.

Here we introduce interoperable tools that facilitate the collection, processing and labelling of neuroimaging articles:
- pubget downloads articles from PubMed Central and extracts their text, metadata and coordinates
- labelbuddy is a simple desktop application for text labelling.

These tools can help researchers quickly jump to the interesting part of a text-mining project: the high-level analyses, using familiar tools from the (data-)scientific software stack.

## Methods

In Figure 1, we show the main stages of a text-mining project.
The high-level analysis, highlighted in green, is the main objective -- for example, plotting the evolution of sample sizes through time.
However, previous steps (downloading articles, extracting text, labelling sample sizes) can take much longer.

### pubget

pubget (https://neuroquery.github.io/pubget/) is a command-line tool for downloading and processing articles from PubMed Central.
It builds upon the code used to create NeuroQuery.
Given a search query or a list of PMCIDs, pubget provides the matching articles in their original XML format, in addition to CSV files containing: (i) metadata such as author names or publication year, (ii) the full text (stripped of any markup), and (iii) the reported activation coordinates.
pubget can optionally extract term-frequency features, and train a NeuroQuery model or run NeuroSynth's Chi² test on the downloaded articles.
This allows applying NeuroSynth's approach to a much larger dataset than was done before, resulting in more powerful analyses (see Results).
pubget can also prepare a NiMARE dataset.
Therefore, the wide range of meta-analysis methods implemented in NiMARE can readily be applied to the collected coordinates. 
pubget can prepare documents for labelbuddy, facilitating manual labelling of the downloaded articles.
pubget is easily extensible through plugins.


### labelbuddy

Most tools for text labelling are Web-based  incur a large set-up overhead for small research projects involving few annotators.
labelbuddy is a simple desktop application that operates on a regular file (a SQLite database).
It imports and exports its data to a simple JSON format, and offers a command-line interface, making it well-suited for projects organized around a Git repository.
To illustrate this, we created a Git repository of annotations in https://neurodatascience.github.io/labelbuddy-annotations/.
It contains over 1,800 annotations, and a Jupyter Book provides an overview and usage examples.
pubget's downloaded articles can directly be imported into labelbuddy.

## Results

To illustrate using the infrastructure descibed above, we replicated the investigation of sample sizes through time in Poldrack & al, "Scanning the horizon". 
We downloaded with pubget all the PMC articles that mention "fMRI" in their abstract.
We labelled the first 20 with labelbuddy and used these examples to design a simple heuristic for extracting participant counts and demographics (age, sex, patients vs healthy controls).
We labelled another 100 articles for evaluation, and finally ran the extraction on the full 4,000 articles.
As we can see in Fig. 1.A, the median sample size has continued to increase since the original publication -- an encouraging result for the reliability of neuroimaging findings.
We also show the distribution of participant's ages.
The mode for healthy participants is between 20 and 30 years, suggesting that the declaimed practice of recruiting mostly students for neuroimaging studies is widely followed.

We also ran pubget for a query matching a larger number of articles (over 9,000).
In Fig 1.B, we show Chi² meta-analytic maps obtained with pubget (top) and from neurosynth.org (bottom).
Results are similar for frequent terms, but for rare terms, pubget's use of the full text results in more powerful analyses.

## Conclusions

We aim to facilitate the activity of downloading neuroimaging articles and preparing them for analysis.
This can help a wide variety or projects, from a small section to make a quantitative point in a review or meta-science paper, to the development of new large-scale meta-analysis methods.
The tools are still evolving and we hope that discussions at the OHBM 2023 meeting will help us tailor them to the needs of the neuroimaging community.

# Figures

![Methods](file:figures/figure_1.png "Methods") 

![Results](file:figures/figure_2.png "Results") 
