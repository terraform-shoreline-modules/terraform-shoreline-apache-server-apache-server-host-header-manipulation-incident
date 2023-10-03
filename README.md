
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache Host Header Manipulation Incident
---

Apache Host Header Manipulation is an incident type in which an attacker tries to exploit a vulnerability in the Apache web server by manipulating the host header of an HTTP request. By sending a specially crafted request, an attacker can bypass the web server's access controls and gain unauthorized access to sensitive information or perform other malicious activities. This type of incident can have serious consequences as it can compromise the security and integrity of web applications and the data they handle.

### Parameters
```shell
export IP_ADDRESS="PLACEHOLDER"

export HOSTNAME="PLACEHOLDER"

export URL="PLACEHOLDER"

export PAYLOAD="PLACEHOLDER"

export PATH_TO_APACHE_CONFIG_FILE="PLACEHOLDER"
```

## Debug

### Check if Apache is running
```shell
systemctl status apache2
```

### Check the Apache access log for suspicious activity
```shell
tail -n 100 /var/log/apache2/access.log | grep ${IP_ADDRESS}
```

### Check the Apache error log for any errors or warnings
```shell
tail -n 100 /var/log/apache2/error.log
```

### Check the Apache configuration files for any misconfigurations
```shell
apachectl configtest
```

### Check the Apache version and installed modules
```shell
apachectl -v

apachectl -M
```

### Check if the Apache server is vulnerable to a specific exploit
```shell
nmap -p 80 --script http-vuln-cve2017-5638 ${IP_ADDRESS}
```

### Check if the Apache server is vulnerable to a specific SSL/TLS vulnerability
```shell
nmap --script ssl-heartbleed ${IP_ADDRESS}
```

### Check if the Apache server is properly configured to handle Host headers
```shell
curl -H "Host: ${HOSTNAME}" ${IP_ADDRESS}
```

### Check the response headers for any anomalies
```shell
curl -i ${URL}
```

### Check the content of a specific URL for any malicious payloads
```shell
curl ${URL} | grep ${PAYLOAD}
```

## Repair

### Patch the Apache web server by installing the latest updates and security patches to prevent known vulnerabilities.
```shell


#!/bin/bash



# Update the package list

sudo apt-get update



# Install the latest updates for all packages, including Apache

sudo apt-get upgrade apache2



# Restart the Apache service to apply the updates

sudo service apache2 restart


```

### Enable strict validation of the Host header in the web server configuration to prevent manipulation attempts.
```shell


#!/bin/bash



# Declare variables

APACHE_CONF=${PATH_TO_APACHE_CONFIG_FILE}



# Backup the original Apache configuration file

cp $APACHE_CONF $APACHE_CONF.bak



# Enable strict validation of the Host header

sed -i 's/^#HostHeaderChecking\s\+Off/HostHeaderChecking On/' $APACHE_CONF



# Restart the Apache web server

systemctl restart apache2


```