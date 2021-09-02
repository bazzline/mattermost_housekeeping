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

## [Unreleased]

### Added

* Added flag `-d|--dry-run`
* Added flag `-h|--help`
* Added flag `-v|--verbose` - if verbose is enabled, each logged message will be echoed too
* Added logging for number of files to delete from local storage

### Changed

* Encapsulated username, password and databasename in the mysql cli calls with >>"<< and encapsulated each column and table in the mysql cli calls with >>`<<
* Implemented check for each deletion run to figure out if there are still entries left to delete or if the run loop can be left
* Fixed issue in systemd service file creation
* Fixed systemd detection issue in uninstall script

## [1.0.0](https://github.com/bazzline/mattermost_housekeeping/tree/1.0.0) - released at 20210521

### Added

* initial release
