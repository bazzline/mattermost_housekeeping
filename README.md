# Mattermost housekeeping script

Deletes old entries in Post and FileInfo on MatterMost GPLv2.

## General

Free as in freedom mattermost housekeeping script.

The current change log can be found [here](CHANGELOG.md).

The current documentation can be found [here](documentation).

This script supports MySQL/MariaDB only right now. If you need something for postgresql, take a look to [mattermost-retention](https://github.com/aljazceru/mattermost-retention).

## Setup

Please read the [installation](documentation/setup/install.md) docmentation.

The script comes with an [install](bin/install.sh)- and an [uninstall](bin/uninstall.sh) routine.

All configurable values are configured in `<project_path>/data/local_configuration.sh`.

## What

This is a full blown cronjob/systemd.service to cleanup the mattermost database tables `Posts` and `FileInfo`.

Entries older than x days where removed. This includes the attachments on the disk.

## Why

I am using my private mattermost server to communicate with each other.
A german saying is "was interessiert mich mein geschwätz von Gestern" ("what do I care about my chatter from yesterday"). Also a german word called "Datenhygiene" ("data hygiene") is important. Plus, as the administrator, I want to keep the system fast for daily use.
Because of that, I wanted an easy way to remove messages older than x days. There is no official configuration section in the open source version of mattermost, so I've written this little script.

The script removes entries older than `<configured value>` days from the database tables `Posts` and `FileInfo`.
The script also removes the deleted files from the filesystem.

Right now, only mysql is supported.
Right now, you have to duplicate the configuration values from your `/usr/share/webapps/mattermost/config/config.json`. Since the configuration is written in json and json is !fun in bash, we have to keep it that way.

Thanks to [matterclean](https://github.com/sinfallas/matterclean/blob/master/matterclean) and [rsyslog_mysql_housekeeping](https://github.com/bazzline/rsyslog_mysql_housekeeping).
