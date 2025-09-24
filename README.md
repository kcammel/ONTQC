# Small nextflow pipeline for running quick ONT QC tools on the GCP

## Usage of pipeline
```
nextflow run main.nf --input nanore_bam.bam --outdir "gs://location/of/gcp/bucket/results_dir/"
```