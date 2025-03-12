import os
import random

def count_sequences(file_path):
    """Count the number of sequences (lines) in a file."""
    with open(file_path, 'r') as f:
        return sum(1 for line in f if line.strip())

def duplicate_sequences(input_file, min_sequences=1000):
    """Duplicate sequences in a file until it has at least min_sequences."""
    with open(input_file, 'r') as f:
        sequences = [line.strip() for line in f if line.strip()]
    
    if not sequences:
        return
    
    while len(sequences) < min_sequences:
        sequences.append(random.choice(sequences))
    
    with open(input_file, 'w') as f:
        for seq in sequences:
            f.write(seq + '\n')

def process_directory(directory):
    """Check files in a directory and duplicate sequences if needed."""
    for file_name in os.listdir(directory):
        file_path = os.path.join(directory, file_name)
        if os.path.isfile(file_path) and not file_name.endswith('.gz') and (file_name.endswith('_positive_rna.txt') or file_name.endswith('_negative_rna.txt')):
            seq_count = count_sequences(file_path)
            if seq_count < 1000:
                print(f"Processing {file_name} (current: {seq_count} sequences)...")
                duplicate_sequences(file_path)
                print(f"Updated {file_name} to have at least 1000 sequences.")


# Example usage
process_directory('/work/talisman/smuthyala/motif_identification/PRIESSTESS_test/PRIESSTESS/eCLIP-ENCODE-GRCH38/data/pos_neg_rna_files')