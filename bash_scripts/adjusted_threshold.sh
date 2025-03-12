#!/bin/bash

# Define the score threshold directly (e.g., 4.0)
SCORE_THRESHOLD=4.0
NEGATIVE_SHIFT=100  # Adjusted shift distance for generating negative set

# Function to create positive and negative sets for each BED file
process_bed_file() {
    local file="$1"

    # Extract the base name of the file
    base_name=$(basename "$file" .bed.gz)

    # Create the positive set based on the fixed score threshold
    echo "Creating positive set for $file with threshold $SCORE_THRESHOLD"
    zcat "$file" | awk -v threshold="$SCORE_THRESHOLD" '$7 >= threshold' > "${base_name}_positive.bed"

    # Create the negative set by shifting positions
    echo "Creating negative set for $file with shift $NEGATIVE_SHIFT"
    awk -v shift="$NEGATIVE_SHIFT" '{OFS="\t"; $2=$2-shift; $3=$3-shift; if ($2 < 0) $2=0; print $0}' "${base_name}_positive.bed" > "${base_name}_negative.bed"

    echo "Processed $file: created ${base_name}_positive.bed and ${base_name}_negative.bed"
}

# Loop through all .bed.gz files in the directory
for file in *.bed.gz; do
    process_bed_file "$file"
done
