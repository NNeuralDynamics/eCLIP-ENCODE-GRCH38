for file in /work/talisman/smuthyala/motif_identification/PRIESSTESS_test/PRIESSTESS/eCLIP-ENCODE-GRCH38/data/eCLIP/*_{positive,negative}.txt; do
    output_file="${file%.txt}_rna.txt"
    sed 's/T/U/g' "$file" > "$output_file"
done
