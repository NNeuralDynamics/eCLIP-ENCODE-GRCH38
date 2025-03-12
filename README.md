Directory structure:

```
.
├── data
│   ├── eCLIP
│   │   ├── ENCFF002HYO.bed.gz
│   │   ├── ENCFF005GER.bed.gz
│   │   ├── ENCFF007VPS.bed.gz
│   │   ├── ENCFF011NAP.bed.gz
.   .   .
.   .   .
.   .   .
│   │   └── metadata.tsv
│   ├── eCLIP-all
│   │   ├── ENCODE_files.txt
│   │   └── geteCLIPfromENCODE.sh
│   └── gtf
│       └── gencode.v29.primary_assembly.annotation.gtf
├── LICENSE
└── python
    ├── eCLIP_parser.ipynb
    ├── eCLIP_parser.py
    └── requirements.txt
```

__data/eCLIP__: contains all the eCLIP file from ENCODE  
__data/eCLIP-all__ is a placeholder for pull all replicates and merged files for the eCLIP experiments  
__python__: code for downloading and parsing gtfs and eCLIP data  

## Overview

## About the dataset
This is a eCLIP (enhanced CrossLinking and ImmunoPrecipitation) data obtained from the ENCODE (Encyclopedia of DNA Elements) database. eCLIP is a high-throughput technique used to map RNA-binding protein (RBP) interaction sites across the transcriptome.

## File formats 
FASTQ (.fastq.gz): Raw sequencing reads before processing   
BED (.bed): Genomic coordinates of peaks (binding sites)   
TEXT (.txt): RNA sequences in txt format   

## Data Preparation 
1. Extract Sequences from BED File

Extract sequences from the reference genome using BEDTools:

```bash
bedtools getfasta -fi genome.fa -bed input.bed -fo output.fa
```
2. Remove Chromosome Numbers and Coordinates

To retain only the sequences in the FASTA file without headers:
```bash
awk '!/^>/' ENCFF002HYO_negative.fa > ENCFF002HYO_neg.fa
```
3. Convert BED to TXT Without Headers

Extract sequences and remove headers:
```bash
bedtools getfasta -fi GRCh38.primary_assembly.genome.fa -bed ENCFF227EJF_positive.bed | grep -v "^>" > ENCFF227EJF_positive.txt
```
4. Delete a Directory

Check and terminate processes locking a directory before deletion:
```bash
lsof PRIESSTESS_output/.nfs2754c561ee16cb910000cee2
kill -9 <PID>
```
5. Convert DNA Sequences to RNA

Replace thymine (T) with uracil (U) in sequences:
```bash
sed 's/T/U/g' dna_sequences.txt > rna_sequences.txt
```
For specific files:
```bash
sed 's/T/U/g' ENCFF031FMO_positive.txt > ENCFF031FMO_rna_positive.txt
```
6. Count the Number of Sequences in Files

Check the number of sequences in multiple files within a directory:
```bash
wc -l *_positive_rna.txt
```
## Processed Files

ENCFF002HYO_neg.fa: Negative sequences without headers.

ENCFF227EJF_positive.txt: Positive sequences extracted from BED files.

ENCFF031FMO_rna_positive.txt: RNA sequences after T→U conversion.

# running PRIESSTESS model 
/work/talisman/smuthyala/motif_identification/PRIESSTESS_for_eClip/PRIESSTESS/PRIESSTESS -fg /work/talisman/smuthyala/motif_identification/PRIESSTESS_for_eClip/eCLIP-ENCODE-GRCH38/data/eCLIP/ENCFF031FMO_rna_positive.txt -bg /work/talisman/smuthyala/motif_identification/PRIESSTESS_for_eClip/eCLIP-ENCODE-GRCH38/data/eCLIP/ENCFF031FMO_rna_negative.txt

## Notes

Ensure that the reference genome (genome.fa or GRCh38.primary_assembly.genome.fa) is correctly indexed before running bedtools getfasta.

The kill -9 command should be used cautiously to terminate processes.

Confirm sequence integrity after sed modifications before proceeding with PRIESSTESS.
