# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Open]

### To Add

* Add support for [postgresql](https://github.com/aljazceru/mattermost-retention)
* Add support for using exising `config.json`
* Try to add a arch linux aur package

### To Change

* Hardening the create systemd service by using [this guide](https://www.opensourcerers.org/2022/04/25/optimizing-a-systemd-service-for-security/)

## [Unreleased]

### Added

* Added documentation
* Encapsulated username, password and databasename in the mysql cli calls with >>"<< in the statistics generation script

### Changed

* Changed output of statistics generation script

## [1.1.2](https://github.com/bazzline/mattermost_housekeeping/tree/1.1.0) - released at 20220307

* Added outputting of the configured value of `DAYS_TO_KEEP_IN_THE_PAST`

## [1.1.1](https://github.com/bazzline/mattermost_housekeeping/tree/1.1.0) - released at 20220307

### Changed

* Fixed output issue for `DATETIME_LIMIT_AS_STRING`. No output was given because of spelling mistake. Code was working fine.

## [1.1.0](https://github.com/bazzline/mattermost_housekeeping/tree/1.1.0) - released at 20210902

### Added

* Added flag `-d|--dry-run`
* Added flag `-h|--help`
* Added flag `-v|--verbose` - if verbose is enabled, each logged message will be echoed too
* Added logging for number of files to delete from local storage
* Added check to only process file info files if the file exists

### Changed

* Encapsulated username, password and databasename in the mysql cli calls with >>"<< and encapsulated each column and table in the mysql cli calls with >>`<<
* Implemented check for each deletion run to figure out if there are still entries left to delete or if the run loop can be left
* Fixed issue in systemd service file creation
* Fixed systemd detection issue in uninstall script

## [1.0.0](https://github.com/bazzline/mattermost_housekeeping/tree/1.0.0) - released at 20210521

### Added

* initial release
