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

python send_to_mozdef.py


# #!/usr/bin/env python
# import mozdef_client, os
# ARGS = ['us-west-1','infosec_mozdef_events','656532927350']
# msg = mozdef_client.MozDefEvent('https://127.0.0.1/this/url/is/not/used')
# msg.summary = 'New certificate detected in Certificate Transparency logs'
# msg.tags = ['tls', 'certificatetransparency']
# for key in (set(os.environ.data.keys()) &
#                 {'FINGERPRINT', 'LOG_URI','CERT_TYPE', 'ISSUER_DN', 'SERIAL',
#                  'SUBJECT_DN', 'NOT_AFTER_UNIXTIME', 'NOT_BEFORE_UNIXTIME',
#                  'PUBKEY_HASH', 'CERT_PARSEABLE','ENTRY_INDEX'}):
#     msg.details[key.lower().translate(None,'_')] = os.environ.data[key]
# msg.details['dnsnames'] = [x.strip() for x
#                             in os.environ.data['DNS_NAMES'].split(',')]
# with open('/home/centos/.certspotter/watchlist') as f:
#     watchlist = f.read().splitlines()
# msg.details['watched_dnsnames'] = [
#     dnsname for dnsname in msg.details['dnsnames']
#     if (dnsname in watchlist)
#     or len(
#         [watchname for watchname in watchlist
#          if watchname[:1] == '.'
#          and (dnsname.endswith(watchname)
#               or dnsname == watchname.lstrip('.'))]) > 0]
# msg.set_send_to_sqs(True)
# msg.set_sqs_region(ARGS[0])
# msg.set_sqs_queue_name(ARGS[1])
# msg.set_sqs_aws_account_id(ARGS[2])
# msg.send()
