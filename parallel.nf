#!/usr/bin/env nextflow

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
		wikidata = entry[0]
		smiles   = entry[1]
		cdk = new CDKManager(".")
		mol = cdk.fromSMILES(smiles)
	}
}
