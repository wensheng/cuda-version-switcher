#!/bin/sh

# Function to update CUDA version in PATH
update_cuda_version() {
    # Check if a version number is supplied
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <version>"
        return 1
    fi

    cudaVersion=$1

    # Check if it is actually installed
    if [ ! -d "/usr/local/cuda-$cudaVersion" ]; then
        echo "CUDA $cudaVersion is not installed"
        return 1
    fi

    newPath=""

    # Loop over each path in PATH and update CUDA version if present
    for path in $(echo $PATH | tr ':' ' '); do
        case "$path" in
            /usr/local/cuda*)
                path=/usr/local/cuda-${cudaVersion}/bin
                ;;
        esac
        newPath="$newPath:$path"
    done

    # Remove the leading colon from newPath
    newPath=${newPath#:}

    # Set the updated PATH environment variable
    export PATH="$newPath"
}

# Call the function with all script arguments
update_cuda_version "$@"
