#!/bin/bash

# Define the percentile for threshold calculation (e.g., 0.75 for 75th percentile)
PERCENTILE=0.75
NEGATIVE_SHIFT=300  # Shift distance for generating negative set

# Function to calculate the percentile score for a given file
calculate_threshold() {
    local file="$1"
    local percentile="$2"
    
    # Extract the score column, sort it, and calculate the threshold based on percentile
    threshold=$(awk '{print $7}' "$file" | sort -n | awk -v p="$percentile" '
    { a[i++] = $1; }
    END {
        idx = int(i * p);
        if (idx >= i) idx = i - 1;
        print a[idx];
    }')
    echo "$threshold"
}

# Loop through all .bed files in the directory
for file in *.bed.gz; do
    base_name=$(basename "$file" .bed.gz)
    
    # Calculate the threshold for this file
    SCORE_THRESHOLD=$(calculate_threshold "$file" "$PERCENTILE")
    echo "Threshold for $file: $SCORE_THRESHOLD"

    # Create the positive set based on the calculated threshold
    awk -v threshold="$SCORE_THRESHOLD" '$7 >= threshold' "$file" > "${base_name}_positive.bed"

    # Create the negative set by shifting positions
    awk -v shift="$NEGATIVE_SHIFT" '{OFS="\t"; $2=$2-shift; $3=$3-shift; if ($2 < 0) $2=0; print $0}' "${base_name}_positive.bed" > "${base_name}_negative.bed"

    echo "Processed $file: created ${base_name}_positive.bed and ${base_name}_negative.bed"
done
