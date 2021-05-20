#!/bin/bash
####
# Fetchs and prints statistics for database tables
#   * Number of entries in total
#   * Number of possible deleted entries
####
# @since 2021-05-20
# @author stev leibelt <artodeto@bazzline.net>
####

function generate_statistics ()
{
    #bo: variable declaration
    local PATH_OF_THE_CURRENT_SCRIPT_BASH=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

    #bin: executables, data: dynamic or static data files, source: templates or not executable no data files
    local PATH_TO_THE_LOCAL_CONFIGURATION_FILE="${PATH_OF_THE_CURRENT_SCRIPT_BASH}/../data/local_config.sh"

    if [[ -f "${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}" ]];
    then
        source "${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}"
    else
        echo ":: No configuration file available."
        echo "   No file in path >>${PATH_TO_THE_LOCAL_CONFIGURATION_FILE}<<."

        return 1
    fi
    #eo: variable declaration

    #bo: generate_statistic
    local DATETIME_LIMIT_AS_STRIMG=$(date -d "now - ${DAYS_TO_KEEP_IN_THE_PAST} days" +%Y-%m-%d_%H:%M:%S)
    local DATETIME_LIMIT_AS_TIMESTAMP=$(date -d "now - ${DAYS_TO_KEEP_IN_THE_PAST} days" +%s)

    local DATETIME_LIMIT_AS_VALUE=$(( ${DATETIME_LIMIT_AS_TIMESTAMP} * 1000 ))

    echo ":: Limitation datetime is >>${DATETIME_LIMIT_AS_STRING}<< which is >>${DATETIME_LIMIT_AS_TIMESTAMP}<< as timestamp."

    _generate_statistic_per_table "Posts" ${DATETIME_LIMIT_AS_VALUE}
    _generate_statistic_per_table "FileInfo" ${DATETIME_LIMIT_AS_VALUE}
}

####
# @param: <string: database table name>
# @param: <int: datetime limit as timestamp>
function _generate_statistic_per_table ()
{
    local DATABASE_TABLE_NAME="${1}"
    local DATETIME_LIMIT_AS_TIMESTAMP="${2}"

    echo ":: Number of entries in total for table >>${DATABASE_TABLE_NAME}<<."
    mysql -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} -e "SELECT COUNT(Id) FROM ${DATABASE_TABLE_NAME}" ${DATABASE_NAME}
    echo ":: Number of posible deleted entries for table >>${DATABASE_TABLE_NAME}<<."
    mysql -u ${DATABASE_USER_NAME} -p${DATABASE_USER_PASSWORD} -e "SELECT COUNT(Id) FROM ${DATABASE_TABLE_NAME} WHERE ${DATABASE_TABLE_NAME}.CreateAt < ${DATETIME_LIMIT_AS_TIMESTAMP}" ${DATABASE_NAME}
    #eo: generate_statistic
}

generate_statistics
