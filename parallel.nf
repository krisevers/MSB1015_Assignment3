#!/usr/bin/env nextflow

// Locate and load libraries that the execution of the file is dependent on
@Grab(group='io.github.egonw.bacting', module='managers-cdk', version='0.0.9')
@Grab(group='org.openscience.cdk', module='cdk-qsarmolecular', version='2.3')

import net.bioclipse.managers.CDKManager
import org.openscience.cdk.interfaces.IAtomContainer
import org.openscience.cdk.qsar.descriptors.molecular.*
import groovy.time.*

// Create a file in which the number of CPUs that are used a parallel process and the time duration
// are stored.
def CPU_duration = new File ("./CPU_duration.tsv")

// Specify number of CPUs that are available for computation (device dependent). The user should make
// changes by setting 'num_CPUs' to the number of CPUs that her/his device has.
def num_CPUs	  = 12

// Number of molecules in the dataset
def num_molecules = 158800

// Loop over number of CPUs that will be used in the process
1.upto(12) {

// Set start time of iteration
def timeStart  = new Date()

// Set size of the buffer size argument. The buffer sets the number of parallel processes that are
// executed. It does this by splitting the data in segments of a defined size, in this case
// #molecules/#CPUs.
int buffersize = (int) Math.ceil(num_molecules/it)

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
		wikidata  = entry[0]
		smiles    = entry[1]
		isosmiles = entry[2]
		
		// Store CDKManager in 'cdk'
		cdk = new CDKManager(".")

                try {
			// If the isosmiles is available this SMILES string will be used to get the
			// logP value. If that is not the case the SMILES string from the smiles
			// column is used.
		
			try {
			// Use from the CDK Manager the fromSMILES function to parse the smiles set and
			// retrieve CDK Molecule objects.
			mol = cdk.fromSMILES(isosmiles)
			
			} catch (Exception exc) {
			  mol = cdk.fromSMILES(smiles)
			}
			
		// Convert CDK molecule object to IAtomContainer
		Iatom = mol.getAtomContainer()
		
		// Calculate logP
		logPDescr = new JPlogPDescriptor()
		logPvalue = logPDescr.calculate(Iatom).value.doubleValue()

		} catch (Exception exc) {
		  println "Warning: ${entry} has no SMILES for which logP value can be calculated"
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
