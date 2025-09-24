#!/usr/bin/env nextflow

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    NanoQC
    Run simple QC tools on nanopore reads to get information and visualization on sequencing run
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

nextflow.enable.dsl = 2

include { validateParameters; paramsSummaryLog; samplesheetToList } from 'plugin/nf-schema'
include { NANOSEQ } from './workflows/nanostats'

// Create a new channel of metadata from a sample sheet passed to the pipeline through the --input parameter
//ch_input = Channel.fromList(samplesheetToList(params.input, "assets/schema_input.json"))
workflow {
    validateParameters()    
    Channel.fromPath(params.input)
        .map {bam ->
            def fname = bam.getFileName().toString()
            def samplename = fname.split('_')[0]
            tuple(samplename,bam)
        }
        .set{ bam_ch }
    //log.info paramsSummaryLog(workflow)
   // NANOSEQ()
    NANOSEQ(bam_ch)
}