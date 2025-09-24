process cramino {
    label 'cramino_stats'

    //conda "bioconda::cramino=0.14.5"
    container "quay.io/biocontainers/cramino:1.1.0--h3dc2dae_0"

    input:
    tuple val(samplename), path(bam)


    output:
    tuple val(samplename), path("*.txt"),   emit: stats
    tuple val(samplename), path("*.arrow"), emit: arrow
    path "versions.yml"             , emit: versions
    
    script:

    """
    cramino \\
        --threads 2 \\
        --arrow ${samplename}.arrow \\
        ${bam} > ${samplename}.txt


    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        cramino: \$(echo \$(cramino -V) | sed 's/cramino //' )
    END_VERSIONS

    """    
}