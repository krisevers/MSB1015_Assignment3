#!/usr/bin/env nextflow

@Grab(group='io.github.egonw.bacting', module='managers-cdk', version='0.0.9')
@Grab(group='org.openscience.cdk', module='cdk-qsarmolecular', version='2.3')

import net.bioclipse.managers.CDKManager
import org.openscience.cdk.interfaces.IAtomContainer
import org.openscience.cdk.qsar.descriptors.molecular.*


Channel
    .fromPath("./short.tsv")
    .splitCsv(header: ['wikidata', 'smiles'], sep:'\t')
    .map{ row -> tuple(row.wikidata, row.smiles) }
    .buffer (size:2, remainder:true)
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
