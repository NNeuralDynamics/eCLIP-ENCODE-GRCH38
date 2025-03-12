for bedfile in /work/talisman/smuthyala/motif_identification/PRIESSTESS_test/PRIESSTESS/eCLIP-ENCODE-GRCH38/data/eCLIP/*.bed; do
    filename=$(basename -- "$bedfile" .bed)
    bedtools getfasta -fi GRCh38.primary_assembly.genome.fa -bed "$bedfile" | grep -v "^>" > "/work/talisman/smuthyala/motif_identification/PRIESSTESS_test/PRIESSTESS/eCLIP-ENCODE-GRCH38/data/eCLIP/${filename}.txt"
done
