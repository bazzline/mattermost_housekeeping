#!/bin/bash
####
# Installs housekeeping scripts
####
# @since 2021-04-21
# @author stev leibelt <artodeto@bazzline.net>
####

function _install_rsyslog_housekeeping ()
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

    if [[ -f /usr/bin/systemd ]];
    then
        local TEMPLATE_PATH_TO_THE_SCRIPT="${PATH_TO_BIN}/cleanup_and_maintain_syslog_systemevent.sh"

        cat > ${PATH_TO_DATA}/rsyslog-housekeeping.service <<DELIM
[Unit]
Description=rsyslog mysql housekeeping
ConditionACPower=true
After=rsyslog.service

[Service]
Type=oneshot
ExecStart=${TEMPLATE_PATH_TO_THE_SCRIPT}
KillMode=process
TimeoutStopSec=21600
DELIM

        sudo cp ${PATH_TO_DATA}/weekly-rsyslog-housekeeping.service /etc/systemd/system/weekly-rsyslog-housekeeping.service

        sudo cp ${PATH_TO_SOURCE}/weekly-rsyslog-housekeeping.timer /etc/systemd/system/weekly-rsyslog-housekeeping.timer
        sudo cp ${PATH_TO_SOURCE}/daily-rsyslog-housekeeping.timer /etc/systemd/system/daily-rsyslog-housekeeping.timer
        sudo cp ${PATH_TO_SOURCE}/hourly-rsyslog-housekeeping.timer /etc/systemd/system/hourly-rsyslog-housekeeping.timer
        sudo systemctl daemon-reload

        echo ":: Please enable the fitting timer on your own."
        echo "   systemctl enable weekly-rsyslog-housekeeping.timer"
        echo "   systemctl enable daily-rsyslog-housekeeping.timer"
        echo "   systemctl enable hourly-rsyslog-housekeeping.timer"
    fi

    echo "Installed at: $(date)" > ${PATH_TO_DATA}/.is_installed
}

_install_rsyslog_housekeeping
