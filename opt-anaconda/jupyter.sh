#!/bin/bash


source /opt/anaconda/etc/profile.d/conda.sh

conda activate

conda info

if [[ "$USER" =~ ^(ashriram|diana|bobbyc)$ ]]; then

    jupyter nbextension enable --user formgrader/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.formgrader

    jupyter nbextension enable --user create_assignment/main

    jupyter nbextension enable --user assignment_list/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.assignment_list

    jupyter nbextension enable --user course_list/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.course_list
else
    jupyter serverextension enable --user nbgrader.server_extensions.formgrader

    jupyter nbextension enable --user assignment_list/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.assignment_list

    jupyter nbextension enable --user course_list/main --section=tree

    jupyter serverextension enable --user nbgrader.server_extensions.course_list
    
fi


#jupyterhub-singleuser "$@"
