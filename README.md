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

## Command to make fasta file from bed file 

bedtools getfasta -fi genome.fa -bed input.bed -fo output.fa


## Command to keep only the sequence and not the chr number and coordinates

awk '!/^>/' ENCFF002HYO_negative.fa > ENCFF002HYO_neg.fa

## Command to convert bed file to txt file without headers

bedtools getfasta -fi GRCh38.primary_assembly.genome.fa -bed ENCFF227EJF_positive.bed | grep -v "^>" > ENCFF227EJF_positive.txt

## Command to delete a directory

lsof PRIESSTESS_output/.nfs2754c561ee16cb910000cee2
kill -9 <PID>


## Convert DNA to RNA 

sed 's/T/U/g' dna_sequences.txt > rna_sequences.txt

sed 's/T/U/g' ENCFF031FMO_positive.txt > ENCFF031FMO_rna_positive.txt

ENCFF031FMO_positive.txt

# running PRIESSTESS model 
/work/talisman/smuthyala/motif_identification/PRIESSTESS_for_eClip/PRIESSTESS/PRIESSTESS -fg /work/talisman/smuthyala/motif_identification/PRIESSTESS_for_eClip/eCLIP-ENCODE-GRCH38/data/eCLIP/ENCFF031FMO_rna_positive.txt -bg /work/talisman/smuthyala/motif_identification/PRIESSTESS_for_eClip/eCLIP-ENCODE-GRCH38/data/eCLIP/ENCFF031FMO_rna_negative.txt
