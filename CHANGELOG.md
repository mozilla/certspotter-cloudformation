# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.1.0] - 2021-09-09

### Changed
- From CentOS7 to CentOS8 Stream
- From Python 2 to Python 3.9
- Hard coded SQS configuration from within `send_to_mozdef.py` to `sqs_info.txt`

### Fixed
- Cases where the lock file is left over, maps to no running process, but still prevents new runs from starting

## [3.0.0] - 2019-03-08
521500e179b7dd0d68a16322c8e7f9cf95d4d867
### Added
- Check for lock file to prevent concurrent runs
- Logrotation
 
### Changed
- The Watchlist from a comma delimited parameter to a URI pointing to a JSON file
- The CentOS 7 AMIs to newer versions
- Userdata to use Sub instead of Join for clarity
- Awscli version to newer version
- Log output to go to a log file instead of email
- CloudFormation templates from JSON to YAML

### Fixed
- Logging

## [2.1.0] - 2017-01-06
d3ae4cb2f50dcfca97e39d3313a771164be1657e
### Added
- Support for an Elastic IP
- Support for an S3 hosted watchlist file
- Add a MozDef event field of only the SAN DNS names which are being watched

## [2.0.0] - 2016-08-12
6be3679de7360c09306079b1be66474856664733
### Changed
- From sending results in email over SES to sending MozDef events over SQS

## [1.0.0] - 2016-08-10
### Added
- Initial commit

[Unreleased]: https://github.com/mozilla/certspotter-cloudformation/compare/v3.1.0...HEAD
[3.1.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v2.1.0...v3.0.0
[2.1.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/mozilla/certspotter-cloudformation/releases/tag/v1.0.0