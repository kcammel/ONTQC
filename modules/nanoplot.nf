process NanoPlot {
    label 'NanoPlot'

    container "quay.io/biocontainers/nanoplot:1.46.1--pyhdfd78af_0"


    input:
    tuple val(samplename), path(arrow)

    output:
    tuple val(samplename), path("*.html"), emit: plots
    tuple val(samplename), path("*NanoStats.txt"), emit: stats
    path "versions.yml"             , emit: versions
    
    script:

    """
    NanoPlot \\
        --threads 2 \\
        --arrow ${samplename}.arrow \\
        --prefix "${samplename}_" \\
        --plots dot kde \\
        --tsv_stats \\
        --no_static

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        NanoPlot: \$(echo \$(NanoPlot -v) | sed 's/NanoPlot //' )
    END_VERSIONS

    """ 
}