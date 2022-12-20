# Title

From PubMed to a DataFrame: tools & resources for easier neuroimaging text-mining.

# Body

## Intro

With thousands of publications each year, the neuroimaging literature is a rich but challenging source of information.
To make the most of this vast resource, (semi-)automated approaches for indexing, aggregating and summarizing publications have become necessary.
Examples include large-scale meta-analyses (NeuroSynth, NeuroQuery), topic modelling, investigations of sample sizes, and more.

An important challenge to such text-mining projects is the construction of an appropriate dataset.
Before performing high-level analyses, one must download a large number of articles and extract the relevant text, metadata and possibly stereotactic coordinates.
Manual labelling is often necessary (eg to provide a ground truth for validation).

Due to this difficulty, most projects rely on the NeuroSynth or the NeuroQuery dataset.
This restriction has important drawbacks: the text itself is not available (only text-frequency features), articles that are not in those datasets cannot be added, etc.
This drastically limits the range of text-mining projects that can be undertaken.

Here we introduce tools that facilitate the collection, processing and labelling of neuroimaging articles:
- pubget downloads articles from PubMed Central and extracts their text, metadata and coordinates
- labelbuddy is a simple desktop application for text labelling.
Importantly, pubget can format the articles it downloads in the JSON format used by labelbuddy.
These tools can help researchers speed up the tedious and error-prone data collection and cleaning and quickly start working on high-level analyses using familiar tools from the (data-)scientific software stack.

## Methods

In Figure 1, we show the main stages of a text-mining project.
The step that motivates the project is typically the last one, highlighted in green -- the high-level analysis.
For example, plotting the evolution of sample sizes through time.

However, the previous steps can take most of the time spent on a project.
For example, downloading articles, extracting their text, and labelling sample sizes.
Our goal is to help researchers jump to the interesting part.

### pubget

pubget (https://neuroquery.github.io/pubget/) is a command-line tool for downloading and processing articles from PubMed Central.
It builds upon the code used to create NeuroQuery.
Given a search query or a list of PMCIDs, pubget downloads the articles in XML format and extracts (i) metadata such as author names and publication year, (ii) the full text (stripped of any markup), and (iii) the reported activation coordinates.
These outputs are stored in CSV files.
Moreover, pubget can optionally extract term-frequency features, and train a NeuroQuery model or run NeuroSynth's Chi² test on the downloaded articles.
This allows to apply NeuroSynth's approach to a much larger dataset than was done before, resulting in more powerful analyses (see Results).
pubget can also prepare a NiMARE dataset.
Therefore, the wide range of meta-analysis methods implemented in NiMARE can readily be applied to the collected coordinates. 
pubget can prepare documents for labelbuddy, facilitating manual labelling of the downloaded articles.
pubget is also easily extensible through plugins.


### labelbuddy

Most Web-based tools for text labelling incur a large overhead to set up for small research projects involving only a few annotators.
labelbuddy is a simple desktop application that operates on a regular file (a SQLite database).
Its internal data structure is an SQLite database, which is a regular file -- no client/server architecture is involved.
It imports and exports its data to a simple JSON format, and offers a command-line interface, making it well-suited for projects organized around a Git repository.
Importantly, pubget's downloaded articles can directly be imported into labelbuddy.
Unlike several popular tools, labelbuddy correctly handles all Unicode characters, which is essential when dealing with arbitrary text gathered from the Web.
We have created a Git repository of annotations in https://neurodatascience.github.io/labelbuddy-annotations/.
It contains over 1,800 annotations, and a Jupyter Book provides an overview and illustrates how to use them.

## Results

To illustrate using the infrastructure descibed above, we replicated the investigation of sample sizes through time in Poldrack & al, "Scanning the horizon". 
Using pubget, we downloaded all PMC articles that mention "fMRI" in their abstract.
We labelled the first 20 with labelbuddy and used these examples to design a simple heuristic method for extracting sample sizes and participant demographics (age, sex, patients vs healthy controls) from the text.
We then labelled another 100 articles to evaluate the extraction, and finally ran the extraction on the full 4,000 articles.
The evolution of median sample size through time is shown in Fig. 1.A.
As we can see, the median sample size has continued to increase since the original publication -- an encouraging finding for the reliability of neuroimaging findings.
In Fig. 1.B, we plot the distribution of participant's ages.
The mode for healthy participants is between 20 and 30 years, suggesting that the declaimed practice of recruiting mostly students for neuroimaging studies is widely followed.

In Fig 1.C, we show Chi² meta-analytic maps obtained with pubget (top) and from neurosynth.org (bottom).
Results are similar for frequent terms, but for rare terms, pubget's use of the full text results in more powerful analyses.

## Conclusions

In this work, we aim to facilitate the activity of downloading neuroimaging articles, extracting and annotating their content, and analyzing the extracted information.
This can help a wide variety or projects, from a small section to make a quantitative point in a review or meta-science paper, to the development of new large-scale meta-analysis methods.
The tools are still evolving and we hope that discussions at the OHBM 2023 meeting will guide us to tailor them to the neuroimaging community's needs.

# Figures

![Methods](file:figures/figure_1.png "Methods") 

![Results](file:figures/figure_2.png "Results") 
