////////////////////////////////////////////////////
/* --    IMPORT LOCAL MODULES/SUBWORKFLOWS     -- */
////////////////////////////////////////////////////

include { cramino } from '../modules/cramino'
include { NanoPlot } from '../modules/nanoplot'



workflow NANOSEQ{
    
    take:
    ch_sample // Channel: [ val(samplename), path [bam] ]
    
    main:
    ch_versions = Channel.empty()

    cramino(
        ch_sample
    )
    NanoPlot(
        cramino.out.arrow
    )
}