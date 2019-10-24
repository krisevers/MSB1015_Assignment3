#!/usr/bin/env nextflow

@Grab(group='io.github.egonw.bacting', module='managers-cdk', version='0.0.9')
@Grab(group='org.openscience.cdk', module='cdk-qsarmolecular', version='2.3')

import net.bioclipse.managers.CDKManager
import org.openscience.cdk.interfaces.IAtomContainer
import org.openscience.cdk.qsar.descriptors.molecular.*
import groovy.time.*

// Create a file in which the number of CPUs that are used a parallel process and the time duration
// are stored.
def CPU_duration = new File ("./CPU_duration.tsv")

// Loop over number of CPU's that will be used in the process
1.upto(12) {

// Set start time of iteration
def timeStart  = new Date()

// Set size of the buffer size argument. The buffer sets the number of parallel processes that are
// executed. It does this by splitting the data in segments of a defined size, in this case
// #molecules/#CPUs.
int buffersize = (int) Math.ceil(5/it)

Channel
    .fromPath("./short.tsv")
    .splitCsv(header: ['wikidata', 'smiles'], sep:'\t')
    .map{ row -> tuple(row.wikidata, row.smiles) }
    .buffer(size:buffersize, remainder:true)
    .set { molecules_ch }


process calculatePlog {
    input:
    each set from molecules_ch

    exec:
    for (entry in set) {
		wikidata = entry[0]
		smiles   = entry[1]

                try {
		// Use from the CDK Manager the fromSMILES function to parse the smiles set and 
		// retrieve CDK molecule objects
		cdk = new CDKManager(".")
		mol = cdk.fromSMILES(smiles)

		// Convert CDK molecule object to IAtomContainer
		Iatom = mol.getAtomContainer()
		
		// Calculate logP
		logPDescr = new JPlogPDescriptor()
		logPvalue = logPDescr.calculate(Iatom).value.doubleValue()

		// Print logP
		println "logP value: " + logPvalue
		} catch (Exception exc) {
		  println "$exc"
		}
    }
}

// Set end time of iteration
def timeStop = new Date()

// Calculate the time between start and end of the iteration
TimeDuration duration = TimeCategory.minus(timeStop, timeStart)

// Print number of CPUs and duration to CPU_duration.tsv
CPU_duration.append("${it} \t ${duration} \n")

}
