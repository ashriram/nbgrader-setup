#!/usr/bin/env bash

set -e

# Configuration variables.
root="/root"
srv_root="/srv/nbgrader"
nbgrader_root="/srv/nbgrader/nbgrader"
jupyterhub_root="/srv/nbgrader/jupyterhub"
exchange_root="/srv/nbgrader/exchange"

# List of possible users, used across all demos.
possible_users=(
    'anaconda'
)

# Import helper functions.
source utils.sh    # Update git repository.
install_dependencies () {
    # Install global extensions, and disable them globally. We will re-enable
    # specific ones for different user accounts in each demo.
    jupyter nbextension install --symlink --sys-prefix --py nbgrader --overwrite
    jupyter nbextension disable --sys-prefix --py nbgrader
    jupyter serverextension disable --sys-prefix --py nbgrader

    # Everybody gets the validate extension, however.
    jupyter nbextension enable --sys-prefix validate_assignment/main --section=notebook
    jupyter serverextension enable --sys-prefix nbgrader.server_extensions.validate_assignment

    # Reset exchange.
    rm -rf "${exchange_root}"
    setup_directory "${exchange_root}" ugo+rwx

    # Remove global nbgrader configuration, if it exists.
    rm -f /etc/jupyter/nbgrader_config.py
}

restart_demo () {
    local demo="${1}"

    install_dependencies
    setup_directory "${srv_root}" ugo+r
    install_nbgrader "${nbgrader_root}" "${exchange_root}"

    # Setup the specific demo.
    echo "Setting up demo '${demo}'..."
    cd one_class_multiple_graders
    source setup_demo.sh
    setup_demo "${jupyterhub_root}"

}

restart_demo "${@}"
