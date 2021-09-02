# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Open]

### To Add

* Add flag `-v|--verbose`
* Add support for [postgresql](https://github.com/aljazceru/mattermost-retention)
* Add support for using exising `config.json`
* Try to add a arch linux aur package

### To Change

* Check, for each run, if a next run is still needed (abort if there is no more message available for deletion)

## [Unreleased]

### Added

* Added flag `-h|--help`

### Changed

* Fixed issue in systemd service file creation
* Fixed systemd detection issue in uninstall script

## [1.0.0](https://github.com/bazzline/mattermost_housekeeping/tree/1.0.0) - released at 20210521

### Added

* initial release
