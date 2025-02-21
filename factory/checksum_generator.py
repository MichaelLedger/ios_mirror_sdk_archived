import os
import hashlib

def generate_checksum(file_path):
    """Generate SHA256 checksum for a given file."""
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as f:
        # Read and update hash string value in blocks of 4K
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def find_zip_files_and_generate_checksums(directory):
    """Search for .zip files and generate checksums."""
    checksums = {}
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.zip'):
                file_path = os.path.join(root, file)
                relative_path = os.path.relpath(file_path, directory)  # Get relative path
                checksums[relative_path] = generate_checksum(file_path)
    return checksums

if __name__ == "__main__":
    directory_to_search = input("Enter the directory to search for .zip files (or press Enter to use current directory): ")
    if not directory_to_search:
        directory_to_search = os.getcwd()  # Use current working directory if no input is given
    checksums = find_zip_files_and_generate_checksums(directory_to_search)
    
    for file_path, checksum in checksums.items():
        print(f"{file_path}: {checksum}")
