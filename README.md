# certspotter-cloudformation

This [AWS CloudFormation](https://aws.amazon.com/cloudformation/) 
template, `certspotter-sqs.json` will create a hosted version of the 
[SSLMate certspotter](https://github.com/SSLMate/certspotter) app.

This installation of certspotter will send reports to
[MozDef](https://github.com/mozilla/MozDef) using
[AWS Message Queuing Service (SQS)](https://aws.amazon.com/sqs/).

## Logging

Verbose logs from the past 4 weeks of hourly certspotter runs can be found in
`/var/log/certspotter.log` and the other weekly logrotated files

## `send_to_mozdef.py`

This CloudFormation creates a simple python tool called `send_to_mozdef.py`
which sends certificates discovered by certspotter to MozDef.

### Experimenting with `send_to_mozdef.py`

To display the message before sending it to MozDef, change the final
`msg.send()` command to something which prints the message first like this

    msg.construct()
    print(json.dumps(msg._sendlog))
    msg.send_sqs()

### Testing `send_to_mozdef.py`

The `test_send_to_mozdef.bash` script will set example environment variables
and run `send_to_mozdef.py`

## Deploying

When updating an existing deployment, try retaining the `/home/centos/.certspotter/certs/`
directory as it contains a copy of all the certs it finds that match the watchlist
which might be interesting down the road. This isn't required though.
