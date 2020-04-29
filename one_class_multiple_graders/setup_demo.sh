#!/usr/bin/env bash

set -e

source ../instructors.sh

setup_demo () {
    # Setup JupyterHub config.
    setup_jupyterhub "${1}"

    # Create users.

    # Install global nbgrader config file.
    mkdir -p /etc/jupyter
    cp global_nbgrader_config.py /etc/jupyter/nbgrader_config.py

    # Loader script for initializing
    cp ../opt-anaconda/jupyter.sh /opt/jupyter.sh
    chmod ugo+rx /opt/jupyter.sh
    chown anaconda /opt/jupyter.sh
    chgrp anaconda /opt/jupyter.sh
    chmod go-w /opt/jupyter.sh
    
    # Setup nbgrader configuration for grading account.
    setup_nbgrader anaconda anaconda_nbgrader_config.py
    create_course anaconda course101


    enable_create_assignment anaconda
    enable_formgrader anaconda

    
   # all of these are done using script when user logs in.
   # Enable extensions for grading account.
   # Enable extensions for instructors.
   instructors=(ashriram)
   for instructor in ${instructors[@]}; do
        enable_assignment_list "${instructor}"
        enable_course_list "${instructor}"
    done

    # Enable extensions for student.
    # enable_assignment_list student1
}
