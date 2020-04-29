#!/bin/bash


source /opt/anaconda/etc/profile.d/conda.sh

conda activate

conda info

# Main gets form grader and create assignment

# Everybody gets validation

jupyter nbextension enable --user validate_assignment/main --section=notebook
jupyter serverextension enable --user nbgrader.server_extensions.validate_assignment

# Only the main grader gets formgrader and assignment list
if [[ "$USER" =~ ^(ashriram|diana|bobbyc)$ ]]; then

# Instructors get assignment list and course list
    jupyter nbextension enable --user assignment_list/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.assignment_list

    jupyter nbextension enable --user course_list/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.course_list
else
# Students get assignment list only
     jupyter nbextension enable --user assignment_list/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.assignment_list

fi


#jupyterhub-singleuser "$@"
