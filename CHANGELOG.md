# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [7.1.0] - 2023-12-29

### Added

- new parameter called S3BackupFileURI which is used to point to an S3 file location
  where the instance can upload nightly backups of the certspotter state
- feature which looks for the presence of a backup in S3 when provisioning the instance
  and uses that backed up state as a starting point for certspotter
- parameter constraints to prevent users from entering invalid parameter values

### Fixed

- case where it's not possible to deploy multiple certspotter CloudFormation stacks due
  to a collision of launch template names

### Changed

- bash arguments to use expanded forms for easier reading

## [7.0.0] - 2023-11-22

### Added

- default region and account ID for SQS and DynamoDB, so you don't have to enter them if
  they're hosted in the local account and region
- security improvement of requiring use of IMDSv2 metadata interface

### Fixed

- the initial run of certspotter with the `start_at_end` argument which didn't work because
  modern versions of certspotter run as a daemon and don't exit
- some mistakes in the documentation
- case where certspotter service fails by setting systemd to restart the service if it fails

### Changed

- the OS from Centos 8 Stream to Ubuntu 22.04
- location of send_to_sqs.py to hooks.d to follow the new requirement from the certspotter
  code
- AWS EC2 instance type from t2.micro to c7a.medium

## [6.0.1] - 2023-08-11

### Fixed

- handling of cases where certspotter encounters a malformed certificate

## [6.0.0] - 2023-05-04

### Changed

- certspotter to run as a systemd service instead of a cron job to accommodate certspotter
  [v0.15.0](https://github.com/SSLMate/certspotter/blob/master/CHANGELOG.md#v0150-2023-02-08)
- how DNS names are passed from certspotter to `send_to_sqs.py` from an environment variable
  to a JSON file to accommodate certspotter [v0.15.0](https://github.com/SSLMate/certspotter/blob/master/CHANGELOG.md#v0150-2023-02-08)
- the AMI mapping for CentOS 8 Stream to use the newest AMIs

### Removed

- creation of and log rotation of the `/var/log/certspotter.log` file as logs are now sent
  to syslog via systemd
- the `cert_type` key in the events created as certspotter no longer supports the field
  after certspotter [v0.15.0](https://github.com/SSLMate/certspotter/blob/master/CHANGELOG.md#v0150-2023-02-08)

## [5.0.0] - 2021-11-10

### Changed
- output from the raw format certspotter provides to a 
  [Splunk certificate format](https://docs.splunk.com/Documentation/CIM/4.20.2/User/Certificates)
  which is not a backwards compatible change

### Added
- log file `certificates_matched.log` recording each matched certificate
- logic to accommodate a missing SQS queue or DynamoDB

## [4.0.0] - 2021-11-10

### Changed
- output from a [MozDef](https://github.com/mozilla/MozDef) format to a more 
  generic event format
- the "summary" field format to contain the matching domain names

### Added
- recording of every matching certificate to a DynamoDB table
  - This requires
    - creating the DynamoDB table
    - setting the DynamoDBTableName and DynamoDBTableRegion CloudFormation
      parameters
- CloudFormation template to create a DynamoDB table to store matching certificate
  transparency records

## [3.1.0] - 2021-09-09

### Changed
- From CentOS7 to CentOS8 Stream
- From Python 2 to Python 3.9
- Hard coded SQS configuration from within `send_to_mozdef.py` to `sqs_info.txt`

### Fixed
- Cases where the lock file is left over, maps to no running process, but still prevents new runs from starting

## [3.0.0] - 2019-03-08

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

### Added
- Support for an Elastic IP
- Support for an S3 hosted watchlist file
- Add a MozDef event field of only the SAN DNS names which are being watched

## [2.0.0] - 2016-08-12

### Changed
- From sending results in email over SES to sending MozDef events over SQS

## [1.0.0] - 2016-08-10

### Added
- Initial commit

[Unreleased]: https://github.com/mozilla/certspotter-cloudformation/compare/v7.1.0...HEAD
[7.1.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v7.0.0...v7.1.0
[7.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v6.0.1...v7.0.0
[6.0.1]: https://github.com/mozilla/certspotter-cloudformation/compare/v6.0.0...v6.0.1
[6.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v5.0.0...v6.0.0
[5.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v4.0.0...v5.0.0
[4.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v3.1.0...v4.0.0
[3.1.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v2.1.0...v3.0.0
[2.1.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/mozilla/certspotter-cloudformation/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/mozilla/certspotter-cloudformation/releases/tag/v1.0.0