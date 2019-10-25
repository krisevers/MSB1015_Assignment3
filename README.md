# MSB1015_Assignment3
## Introduction
Calculations on large datasets require sufficient computing power. It is therefore important to design a good architecture for processing of data. Parallel computing is a way of performing a computation in parallel on multiple CPUs. This speeds up the calculation and is thus useful for processing on big datasets. </br>
In this project a dataset containing SMILES string for all molecules from wikidata is taken and the logP value of each molecule is calculated in parallel using the `nextflow` language. The calculations of the logP value of the molecule are performed with different settings for the number of CPUs that the calculation is processed on. </br>
The time that the process takes is stored is stored in `CPU_duration.tsv`. The results of the 

## Installation
### Files
Make sure that the following file are stored in the same folder. Using [git](https://linuxize.com/post/how-to-install-git-on-debian-10/) in a Linux distribution OS this repository can be cloned to a local drive.
* `parallel.nf`: This nextflow file takes a `.tsv` file and calculates 
* `getSMILES.rq`
* `short.tsv`
* `MoleculesSmiles.tsv`
* `CPU_timeduration.tsv`
* `parallel_computing_results.rmd`
### Requirements
This project is produced in the [Debian](https://www.debian.org/) operating system (a Linux distribution). Groovy and Nextflow are installed in this OS, and the file `parallel.nf` is executed using the command `./nextflow parallel.nf` in this OS. The user needs to install the following requirements to make `parallel.nf` executable in Debian or a other Linux destribution.
* [Java](https://www.java.com/en/download/win10.jsp)
* [Groovy](https://groovy-lang.org/install.html)
* [Nextflow](https://www.nextflow.io/)
* [Rstudio](https://rstudio.com/)
## User specific settings
* The number of CPUs that are available for computation differs per device, therefore the the user needs to specify the number of CPUs that the process is run on by hand. This has to be specified in the file `parallel.nf`. Here the vector in line 18 indicates the number of CPUs that the device has. This vector can be changed according to the users preferences.
## Results

## Problems

## References
* 
*
*
## Authors
* Kris Evers


## What is Nextflow?

## What is SMILES?

## What is a logP value?
