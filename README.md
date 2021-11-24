# certspotter-cloudformation

This [AWS CloudFormation](https://aws.amazon.com/cloudformation/) template,
[`certspotter-sqs.yml`](certspotter-sqs.yml) will create a hosted version of the 
[SSLMate certspotter](https://github.com/SSLMate/certspotter) app.

This installation of certspotter will
* create an events in the [Splunk certificate format](https://docs.splunk.com/Documentation/CIM/4.20.2/User/Certificates)
* send events to an [AWS Message Queuing Service (SQS)](https://aws.amazon.com/sqs/)
  queue for every matching certificate. These reports can then be consumed by a SIEM (e.g. Splunk).
* store all matching certificate transparency events in a DynamoDB 

## Installation

Create the DynamoDB to store certificate transparency records in. This can be
done manually or with the [`certspotter-dynamodb.yml`](certspotter-dynamodb.yml)
template.

Deploy the `certspotter-sqs.yml` CloudFormation template in AWS. The template
parameters let you set
* which SQS queue and which DynamoDB to send new certificate transparency 
  records to
* the S3 URL of the watchlist to use which contains the domains that you want to
  filter for
* the cron schedule for how often to run certspotter
* whether or not to start from the end of the certificate transparency logs.
  Starting from the end of the logs will allow certspotter to complete quickly.
  Starting from the beginning will require a very long time to process all of
  the historical logs.
* the optional Elastic IP to assign to the certspotter EC2 instance

## Logging

Verbose logs from the past 4 weeks of certspotter runs can be found in
`/var/log/certspotter.log` along with the other weekly logrotated files. The 
start and end of runs can be found with

    grep "cron initiated run" /var/log/certspotter.log

A log of every matched certificate is kept in `/home/centos/certificates_matched.log`

## Files

### `certspotter-dynamodb.yml`

This CloudFormation template creates a simple DynamoDB table to store certificate
transparency records for matching domain names.

### `certspotter-sqs.yml`

This CloudFormation template creates an EC2 instance that will run certspotter.
It also provisions an IAM Role for the EC2 instance to use to enable it to
* Read the watchlist from S3
* Send matching records to SQS
* Put matching records in the DynamoDB table

### `send_to_sqs.py`

The `certspotter-sqs.yml` CloudFormation template creates a simple python tool 
called `send_to_sqs.py` which sends certificates discovered by certspotter to 
SQS as well as storing them in a DynamoDB.

#### Experimenting with `send_to_sqs.py`

To display the message before sending it to SQS, change the
`client.send_message` command to something which prints the message first like this

    queue_url = client.get_queue_url(QueueName=ARGS[1], QueueOwnerAWSAccountId=ARGS[2])['QueueUrl']
    print(json.dumps(data))
    client.send_message(QueueUrl=queue_url, MessageBody=json.dumps(data, sort_keys=True))

#### Testing `send_to_sqs.py`

The `test.bash` script will set example environment variables and run 
`send_to_sqs.py`

### `certspotter-ses.yml`

This CloudFormation template deploys certspotter configured to emit matching
domain names via email using SES.

## Deploying

When updating an existing deployment, try retaining the `/home/centos/.certspotter/certs/`
directory as it contains a copy of all the certs it finds that match the watchlist
which might be interesting down the road as well as the current position in all
the logs which will allow you to pick up from where certspotter last was in the 
logs.

### Reading from the end of the log

When starting certspotter for the first time, you will probably want to begin
consuming the CT logs from the end of all current logs. Consuming from the
beginning of the logs would take a very long time.

To do this, set the `StartFromEndOfCTLogs` CloudFormation parameter to `true`

This will index all of the logs at their tails.

## DynamoDB Table

Each matching certificate transparency record is written to the DynamoDB table.
Each record has a unique `id` field which is a combination of the certificate 
issuer and the serial number of the certificate. Example

    C=US, O=DigiCert Inc, CN=DigiCert SHA2 Secure Server CA, 858cee155d7179ea7b50054e670ab51

The `date` field is the [unix time](https://en.wikipedia.org/wiki/Unix_time) of
the `not_before_unixtime` field. This will allow sorting the records by the date
on which the certificate is first valid.

The `record` field is the JSON record from certspotter. See the format in 
[`example_record.json`](example_record.json)