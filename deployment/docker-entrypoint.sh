#!/bin/bash
set -e

# Define help message
show_help() {
    echo """
Usage: docker run <imagename> COMMAND

Commands

python     : Run a python command
bash       : Start a bash shell
vtk_ccmake : Prepare VTK to build with ccmake. This happens in the container (not during image build)
vtk_make   : Build the VTK library
help       : Show this message
"""
}

# Run
case "$1" in
    python)
        python "${@:2}"
    ;;
    bash)
        /bin/bash "${@:2}"
    ;;
    vtk_ccmake)
        cd /vtk-build
        ccmake /tmpbuild/VTK-7.0.0
    ;;
    vtk_make)
        cd /vtk-build
        make
    ;;
    *)
        show_help
    ;;
esac
