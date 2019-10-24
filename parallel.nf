#!/usr/bin/env nextflow

@Grab(group='io.github.egonw.bacting', module='managers-cdk', version='0.0.9')
import net.bioclipse.managers.CDKManager

Channel
    .fromPath("./short.tsv")
    .splitCsv(header: ['wikidata', 'smiles'], sep:'\t')
    .map{ row -> tuple(row.wikidata, row.smiles) }
	.buffer(size:2, remainder:true)
    .set { molecules_ch }

process calculatePlog {
    input:
    each set from molecules_ch

    output:
    println "Running..."
    for (entry in set) {
		// 
		wikidata = entry[0]
		smiles   = entry[1]

		// Use from the CDK Manager the fromSMILES function to parse the smiles set and 
		// retrieve CDK molecule objects
		cdk = new CDKManager(".")
		mol = cdk.fromSMILES(smiles)

		// Convert 'mol' (CDK molecule object) to IAtomContainer
		iatomcont = mol.getAtomContainer()
		
		// Calculate Plog
		
    }
}
