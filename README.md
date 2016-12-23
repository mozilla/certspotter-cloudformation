# certspotter-cloudformation

This [AWS CloudFormation](https://aws.amazon.com/cloudformation/) 
template, `certspotter-sqs.json` will create a hosted version of the 
[SSLMate certspotter](https://github.com/SSLMate/certspotter) app.

This installation of certspotter will send reports to
[MozDef](https://github.com/mozilla/MozDef) using
[AWS Message Queuing Service (SQS)](https://aws.amazon.com/sqs/).
