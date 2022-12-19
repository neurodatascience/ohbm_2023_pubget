# Title

From PubMed to a DataFrame: tools & resources for easier neuroimaging text-mining.

# Body

## Intro
With thousands of publications each year, the neuroimaging literature is a rich but challenging source of information. 
In order to make the most of this vast resource, (semi-)automated approaches for indexing, aggregating and summarizing results have become necessary.
Examples include large-scale meta-analyses (NeuroSynth), machine-learning encoding methods (NeuroQuery, Text2Brain), topic modelling, investigations of sample sizes, methods, citation biases, and more.
We present two concrete illustrations in the Results section: large-scale meta-analysis and investigation of study participant demographics.

An important challenge to such projects is the construction of an appropriate dataset.
Before performing high-level analyses, one must download a large number of articles and extract the relevant text, metadata and possibly stereotactic coordinates.
In many cases, manually labelling some of the articles is also necessary (eg for evaluating automatic information extraction methods).

Although such tasks are seldom discussed outside of appendices, they represent a significant challenge.
As a result, the vast majority of projects relies on one of the two existing corpora of neuroimaging text and coordinates: the NeuroSynth and NeuroQuery datasets.
This restriction has significant drawbacks: the set of selected articles cannot be adapted to the project at hand, the text itself is not available (only text-frequency features), and for NeuroSynth, only the abstract is available.
This drastically limits the range of text-mining projects that can be undertaken.
Here we introduce pubget, a tool that collects articles from PubMed Central and extracts their text, metadata and coordinates, and prepares these data in simple familiar formats.

Manual labelling is also a difficulty.
Although tools are available, they are often difficult to install and use, unreliable, or expensive.
Some projects therefore settle on less adequate tools such as spreadsheet software.
Therefore, we introduce labelbuddy, a simple desktop application for text labelling.
Importantly, pubget can format the articles it downloads in the simple JSON format used by labelbuddy.

Finally, we describe a repository of manual annotations of neuroimaging articles created with labelbuddy, as well as a repository of automatic information extraction methods.

Our efforts aim to facilitate the data collection and preparation, so that researchers in neuroimaging can obtain text and metadata in simple, familiar formats, and quickly start working on high-level analyses using familiar tools from the (data-)scientific software stack.

## Methods
## Results
## Conclusions
