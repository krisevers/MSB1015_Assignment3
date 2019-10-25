# MSB1015_Assignment3
## Introduction
Calculations on large datasets require sufficient computing power. It is therefore important to design a good architecture for processing of data. Parallel computing is a way of performing a computation in parallel on multiple CPUs. This speeds up the calculation and is thus useful for processing on big datasets. </br>
In this project a dataset containing SMILES strings for all molecules from [Wikidata](https://wikidata.org/) is taken and the logP value of each molecule is calculated using the [Chemistry Development Kit (CDK)](https://cdk.github.io/) in parallel using the `nextflow` language. The calculations of the logP value of the molecule are performed with different settings for the number of CPUs that the calculation is processed on. </br>
The time that the process takes is stored is stored in `CPU_duration.tsv`. The results are presented in an R markdown file `Assignment3.Rmd` and as an webpage `index.html` which is hosted [here](https://krisevers.github.io/MSB1015_Assignment3/) by Github Pages.

## Installation
### Files
Make sure that the following file are stored in the same folder. Using [git](https://linuxize.com/post/how-to-install-git-on-debian-10/) in a Linux distribution OS this repository can be cloned to a local drive. note: this also downloads `MoleculesSmiles.tsv`, so step 1 of 'Execution' is not necessary.
* `parallel.nf`: This nextflow file takes a `.tsv` file and calculates the logP value of the SMILES that are stored in the `.tsv` file and outputs `CPU_timeduration.tsv`. It runs the same process multiple times on different specified numbers of CPUs.
* `getSMILES.rq` : This file containts the Wikidata Query which is used to generate the `MoleculesSmiles.tsv` with the Wikidata query service.
* `short.tsv` : This is a toy dataset to test `parallel.nf` with.
* `MoleculesSmiles.tsv` : this is the full size dataset obtained with the Wikidata query service and contains all molecules in the Wikidata database and their SMILES strings.
* `CPU_timeduration.tsv` : This file contains the CPU
* `Assignment3.Rmd` : An R markdown file presenting the results from the parallel computing experiment run by `parallel.nf`.
* `index.html` : A html version of `Assignment3.Rmd` with the plot printed out for this specific experiment.
* `.gitignore` : This file specifies the file formats that should not be uploaded to the repository.
### Requirements
This project is produced in the [Debian](https://www.debian.org/) operating system (a Linux distribution). Groovy and Nextflow are installed in this OS, and the file `parallel.nf` is executed using the command `./nextflow parallel.nf` in this OS. The user needs to install the following requirements to make `parallel.nf` executable in Debian or a other Linux destribution.
* [Java](https://www.java.com/en/download/win10.jsp)
* [Groovy](https://groovy-lang.org/install.html)
* [Nextflow](https://www.nextflow.io/)
* [RStudio](https://rstudio.com/)
### User specific settings
The number of CPUs that are available for computation differs per device, therefore the the user needs to specify the number of CPUs that the process is run on by hand. This has to be specified in the file `parallel.nf`. Here the variable `num_CPUs` indicates the number of CPUs that the device has. This number can be changed according to the users preferences.
### Execution
1. Copy and past the lines of code in the `getSMILES.rq` file into the [Wikidata query service](https://query.wikidata.org/). Run the query and save the response as `MoleculesSmiles.tsv`.
2. Open the linux distribution and execute `parallel.nf` with `nextflow`. Make sure that the requirements are installed and the files are in the same folder as `MoleculesSmiles.tsv`. Make sure that `CPU_duration.tsv` is not in the folder as the this step produces a new `CPU_duration.tsv` file.
3. Run the file `Assignment3.Rmd` in RStudio to see the results of your parallel computating session.
## Results
The results from running this project on the computer of the author *Kris Evers* are presented in R markdown format. The output from `parallel.nf`, which is `CPU_duration.tsv` is processed in RStudio and presented in an R markdown file `Assignment3.Rmd` and as a webpage `index.html` and hosted [here](https://krisevers.github.io/MSB1015_Assignment3/) by Github Pages.

## References
* [Chemistry Development Kit](https://cdk.github.io/)
* [Wikidata](https://query.wikidata.org)

## Licenses
In this repository software of other creators is used. When using this repository respect the licenses of these dependencies. Here is a list of sources of information on these licenses:
* [CDK License information](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

## Authors
* Kris Evers
* Egon Willighagen (getSMILES.rq)
