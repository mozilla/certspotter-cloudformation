#!/bin/bash

export SUBJECT_DN="C=US, ST=California, L=San Francisco, O=SALESFORCE.COM, INC., OU=Infrastructure, CN=akamai-san10.exacttarget.com"
export DNS_NAMES="akamai-san10.exacttarget.com, image.ml.dot-st.com, image.e.banksa.com.au, image.friends.sanrio.co.jp, image.tmc.bankofamerica.com, image.e.mozilla.org, image.email.truhearing.com, image.mcd.nikon.com, image.s.lovesick.com, image.email.hasbro.com, image.e.debenhams.com, image.mail.nibc.com, image.emailing.santanderpb.es, image.m.harley-davidson.ca, image.e.amfam.com, image.mtbemail.com, image.email.enterprise.com, image.email.sans.org, image.ntt-comstore.com, image.email.randstaddirect.nl, image.n-mail.nissay.co.jp, image.email.decathlon.be, image.email.randstadholding.com, image.e.kickstarter.com, image.email.vakantiediscounter.nl, image.e.plumorganics.com, image.r.haken.rikunabi.com, image.r.townwork.net, image.news.auctionata.com, image.subscribers.sbs.com.au, image.secure.castlighthealth.com, image.email-nationwide.com, image.inspiration.auctionata.com, image.notify.auctionata.com, image.mail.allsports.jp, image.emails.thewarehouse.co.nz, image.email.americanfidelity.com, image.s.boxlunch.com"
export ENTRY_INDEX="29495169"
export ISSUER_DN="C=US, O=DigiCert Inc, CN=DigiCert SHA2 Secure Server CA"
export CERT_TYPE="cert"
export SERIAL="858cee155d7179ea7b50054e670ab50"
export FINGERPRINT="05e0d7d3c7ba3254bfc9ec6b51af911fb46deaaebc56449d2a831f401ab50b65"
export LOG_URI="https://ct.googleapis.com/pilot"
export NOT_BEFORE_UNIXTIME="1457049600"
export PUBKEY_HASH="6d60a43600bce65272bc041ee5c6755268c2fb2aa3c071bf11c9fc376cc9aa37"
export CERT_PARSEABLE="yes"
export NOT_AFTER_UNIXTIME="1557316800"

python3 send_to_sqs.py


# #!/usr/bin/env python3
# import os, json, boto3
# base_dir = '/home/centos'
# with open(f'{base_dir}/certspotter_config.txt') as f:
#     ARGS = [x.strip() for x in f.read().split(',')]
#
# data = {}
# fields = {
#     'FINGERPRINT', 'LOG_URI','CERT_TYPE', 'ISSUER_DN', 'SERIAL', 'SUBJECT_DN',
#     'NOT_AFTER_UNIXTIME', 'NOT_BEFORE_UNIXTIME', 'PUBKEY_HASH', 'CERT_PARSEABLE','ENTRY_INDEX'}
# for key in (set(os.environ.keys()) & fields):
#     data[key.lower().translate({'_': ''})] = os.environ[key]
# data['dnsnames'] = [x.strip() for x in os.environ['DNS_NAMES'].split(',')]
# with open(f'{base_dir}/.certspotter/watchlist') as f:
#     watchlist = f.read().splitlines()
#
# def in_watchlist(name, watchlist):
#     matching_names = [watchname for watchname in watchlist if watchname[:1] == '.' and (name.endswith(watchname) or name == watchname.lstrip('.'))]
#     return (name in watchlist) or matching_names
#
# data['watched_dnsnames'] = [dnsname for dnsname in data['dnsnames'] if in_watchlist(dnsname, watchlist)]
# data['summary'] = f"New certificate{'s' if len(data['watched_dnsnames']) > 1 else ''} in CT logs for {', '.join(data['watched_dnsnames'])}"
#
# client = boto3.client('sqs', region_name=ARGS[0])
# queue_url = client.get_queue_url(QueueName=ARGS[1], QueueOwnerAWSAccountId=ARGS[2])['QueueUrl']
# client.send_message(QueueUrl=queue_url, MessageBody=json.dumps(data, sort_keys=True))
# dynamodb = boto3.resource('dynamodb', region_name=ARGS[4])
# table = dynamodb.Table(ARGS[3])
# table.load()
# record_id = f"{data['issuer_dn']}, {data['serial']}"
# table.put_item(Item={
#     'id': record_id,
#     'date': int(data['not_before_unixtime']),
#     'record': json.dumps(data, sort_keys=True)})