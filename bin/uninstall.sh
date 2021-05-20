#!/bin/bash
####
# Uninstalls housekeeping scripts
####
# @since 2021-04-21
# @author stev leibelt <artodeto@bazzline.net>
####

function _uninstall_rsyslog_housekeeping ()
{
    local PATH_OF_THE_CURRENT_SCRIPT_BASH=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

    #bin: executables, data: dynamic or static data files
    local PATH_TO_BIN="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../bin"
    local PATH_TO_DATA="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../data"

    if [[ ! -f ${PATH_TO_DATA}/.is_installed ]];
    then
        echo ":: No Installation found."
        echo "   Please run >>${PATH_TO_BIN}/install.sh<< if needed."

        return 1
    fi

    if [[ -f /usr/bin/systemd ]];
    then
        systemctl -q is-active weekly-rsyslog-housekeeping.timer

        if [[ $? -eq 0 ]];
        then
            sudo systemctl disable weekly-rsyslog-housekeeping.timer
        fi

        sudo rm /etc/systemd/system/weekly-rsyslog-housekeeping.timer
        sudo rm /etc/systemd/system/weekly-rsyslog-housekeeping.service

        rm ${PATH_TO_DATA}/weekly-rsyslog-housekeeping.service

        sudo systemctl daemon-reload
    fi

    mv ${PATH_TO_DATA}/local_config.sh ${PATH_TO_DATA}/local_config.sh.save

    rm ${PATH_TO_DATA}/.is_installed
}

_uninstall_rsyslog_housekeeping
