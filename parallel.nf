#!/usr/bin/env nextflow

Channel
    .fromPath("./short.tsv")
    .splitCsv(header: ['wikidata', 'smiles'], sep:'\t')
    .map{ row -> tuple(row.wikidata, row.smiles) }
    .set { molecules_ch }

process printSMILES {
    input:
    set wikidata, smiles from molecules_ch

    output:
    file 'results.txt' into result
    
    '''
    echo '$wikidata has SMILES: $smiles' > results.txt
    '''
    
}

result.subscribe { println "hello" }
