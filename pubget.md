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
Importantly, pubget can format the articles it downloads in the simple JSON format used by labelbuddy.
These tools can help researchers speed up the tedious and error-prone data collection and cleaning and quickly start working on high-level analyses using familiar tools from the (data-)scientific software stack.

## Methods

In Figure 1, we show an overview of the main steps involved in a text-mining project.
The step that motivates the project and is the main focus of the resulting publication is typically the last step, highlighted in green -- the high-level analysis.
Our goal is to facilitate the previous steps.

### pubget

pubget (https://neuroquery.github.io/pubget/) is a command-line tool for downloading articles from PubMed Central and extracting their content.
It builds upon the code that was used to create the NeuroQuery dataset -- the largest existing dataset of neuroimaging text and stereotactic coordinates.
Given a search query or a list of PMCIDs, pubget downloads the articles in XML format and extracts various pieces of information: metadata such as author names and publication year, the full text (stripped of any markup), the reported activation coordinates.
These outputs are stored in CSV files, which are easily parsed using tools such as Python or R that are well-known by the neuroscientific community.
Moreover, pubget can optionally extract term-frequency features, and train a NeuroQuery model or run NeuroSynth's Chi² test on the downloaded articles.
This allows to apply NeuroSynth's approach on a much larger dataset than the original one, resulting in more powerful analyses as seen in the Results section.
pubget can also prepare a dataset in NiMARE's format, which enables applying any of the wide variety of meta-analysis methods implemented in NiMARE.
Finally, pubget can store the article's text in the simple JSON(lines) format used by the labelbuddy text annotation tool, facilitating manual annotation of the downloaded articles.
pubget is also easily extensible through plugins.


### labelbuddy

Manually labelling some or all the downloaded articles is often necessary.
Here also, an appropriate tool can greatly reduce the time spent on performing this task.
Many tools exist, but they are typically web-based. 
Such tools are suited for large projects in which an administrator sets up the platform and annotators just need to connect through a browser, but incur a large overhead when only a few annotators are involved, as is typical in research projects (especially when labelling is only one secondary task).
labelbuddy is a simple desktop application.
Its internal data structure is an SQLite database, which is a regular file -- no client/server architecture is involved.
Documents, labels and annotations are imported (exported) from (to) a simple JSON format.
Importantly, pubget can output the text it downloads in this format, so that pubget output can directly be imported into labelbuddy.
labelbuddy's command-line interface allows automating tasks such as exporting annotations (although all operations can easily be performed from the GUI).
Finally, labelbuddy correctly handles all Unicode characters (unlike several tools we reviewed, which produce incorrect character offsets for characters outside of the BMLP), which is essential when dealing with arbitrary text gathered from the web, about which no assumptions can be made.

The fact that labelbuddy operates on local files and exports its output in a simple text format makes it natural to use with Git, which has become the standard for managing research projects.
We have created a Git repository of annotations, to which anyone is welcome to contribute, in https://neurodatascience.github.io/labelbuddy-annotations/.

## Results

To illustrate using the infrastructure descibed above, we replicated the investigation of sample sizes through time in Poldrack & al, "Scanning the horizon". 
Using pubget, we downloaded all PMC articles that mention "fMRI" in their abstract.
We labelled the first 20 with labelbuddy and used these examples to design a simple heuristic method for extracting sample sizes and participant demographics (age, sex, patients vs healthy controls) from the text.
We then labelled another 100 articles to evaluate the extraction, and finally ran the extraction on the full 4,000 articles.
The evolution of median sample size through time is shown in Fig. 1.A.
As we can see, the median sample size has continued to increase since the original publication -- an encouraging finding for the reliability of neuroimaging findings.
In Fig. 1.B, we plot the distribution of participant's ages.
The mode for healthy participants corresponds to the typical age of university students.
This suggests that the declaimed practice of recruiting mostly students for neuroimaging studies is widely followed.

In Fig 1.C, we also show some Chi² maps obtained with pubget and from neurosynth.org.
Results are similar for frequent terms, but for rare terms, the fact that pubget uses the full text results in analyses with a higher statistical power.

Finally, the annotations repository already represents a valuable and growing resource.
It contains over 1,800 annotations, and a Jupyter Book provides an overview and illustrates how to use them.

## Conclusions

In this work, we aim to facilitate the activity of downloading neuroimaging articles, extracting and annotating their content, and analyzing the extracted information.
This can help a wide variety or projects, from a small section to make a quantitative point in a review or meta-science paper, to the development of new large-scale meta-analysis methods.
The tools are still evolving and we hope that discussions at the OHBM 2023 meeting will guide us to tailor them to the neuroimaging community's needs.

# Figures

![Methods](file:figures/figure_1.png "Methods") 

![Results](file:figures/figure_2.png "Results") 
