#!/bin/bash
####
# Installs housekeeping scripts
####
# @since 2021-05-21
# @author stev leibelt <artodeto@bazzline.net>
####

function _install_mattermost_housekeeping ()
{
    local PATH_OF_THE_CURRENT_SCRIPT_BASH=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

    #bin: executables, data: dynamic or static data files, source: templates or not executable no data files
    local PATH_TO_BIN="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../bin"
    local PATH_TO_DATA="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../data"
    local PATH_TO_SOURCE="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../source"

    if [[ -f ${PATH_TO_DATA}/.is_installed ]];
    then
        echo ":: Installation already done."
        echo "   Please run >>${PATH_TO_DATA}/uninstall.sh<< if needed."

        return 1
    fi

    cp ${PATH_TO_SOURCE}/local_config.sh.dist ${PATH_TO_DATA}/local_config.sh

    echo ":: Please configure following file."
    echo "   >>${PATH_TO_DATA}/local.config.sh<<"
    echo ""

    if [[ $(ps -p 1 -o comm=) == "systemd" ]];
    then
        local TEMPLATE_PATH_TO_THE_SCRIPT="${PATH_TO_BIN}/do_the_housekeeping.sh"

        cat > ${PATH_TO_DATA}/mattermost-housekeeping.service <<DELIM
[Unit]
Description=mattermost mysql housekeeping
ConditionACPower=true
After=mattermost.service

[Service]
Type=oneshot
ExecStart=${TEMPLATE_PATH_TO_THE_SCRIPT}
KillMode=process
TimeoutStopSec=21600
DELIM

        sudo cp ${PATH_TO_DATA}/mattermost-housekeeping.service /etc/systemd/system/mattermost-housekeeping.service

        sudo cp ${PATH_TO_SOURCE}/weekly-mattermost-housekeeping.timer /etc/systemd/system/weekly-mattermost-housekeeping.timer
        sudo cp ${PATH_TO_SOURCE}/daily-mattermost-housekeeping.timer /etc/systemd/system/daily-mattermost-housekeeping.timer
        sudo cp ${PATH_TO_SOURCE}/hourly-mattermost-housekeeping.timer /etc/systemd/system/hourly-mattermost-housekeeping.timer
        sudo systemctl daemon-reload
    fi

    echo ":: You have to do some manual work before using it!"
    echo "   Please read >>documentation/setup/install.md<<"

    echo "Installed at: $(date)" > ${PATH_TO_DATA}/.is_installed
}

_install_mattermost_housekeeping
