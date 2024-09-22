# Analysis of Hate Crimes in Toronto From 2018 to 2023
## Overview
This paper analyzes the occurrences of hate crimes in Toronto by bias and location from 2018 to 2023. The results show that a significant proportion of hate crimes were directed at Black individuals and Jewish people, and about half of the crimes occurred in public spaces or transportation.

The dataset used in this repo could be found at https://open.toronto.ca/dataset/hate-crimes-open-data/. 

## File Structure
The repo is structured as:
-  `outputs` contains the files used to generate the paper, including the Quarto document, reference bibliography, and the PDF of the paper. 
-  `inputs` contains both raw and cleaned datasets used to analyze.
-  `scripts` contains the R scripts used to simulate, download, clean and test the data.
-  `other` contains `sketches` and `llm`.

## Packages Installation
The codes used to install packages are in `scripts/01-download.R`, with `#` before each code.

## LLM Usage
ChatGpt was used for correcting grammar and modifying codes. The chats can be found in `other/llm.txt`. No other LLM was used.
