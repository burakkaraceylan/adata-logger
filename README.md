# adata-logger

## What is this?

This is a docker container with rsyslog installed and listening on 514. UDP port for receiving remote logs. Every night at 2.00 am the logs are signed with a timestamp server, archived and sent to a remote FTP server (ie. a NAS). Logs coming from docker host (172.17.0.1) are signed and archived by default. Logs from other ip addresses can be seperated by providing additional configurations. Container is based on Alpine linux and the size is just over 20 mb.

## But why?

Mikrotik added container support to their devices. This opened up many opportunities. In some countries it is mandatory to sign and store firewall logs for a certain amount of time. Usually a central server collects, signs and stores the logs. This single point of failure creates many problems and therefore I wanted to explore the feasibility of delegating the task of logging to the devices that are actualy creating the logs.

## So how?

The process of running a container inside RouterOS is described in detail [here](https://help.mikrotik.com/docs/display/ROS/Container).

### Environment variables

- FTP_HOST is the ip address of the FTP server
- FTP_USER is the username for the FTP server
- FTP_PASSWD is the password for the FTP server
- FTP_DIR is the folder on the FTP server where the logs will be copied to
- TS_SERVER is the url for the timestamp server (without the http:// part)
- TS_USER is the username for the timestamp server
- TS_PASS is the password for the timestamp server

### Volumes

- /CA **must** be mounted and **must** contain a file named **tsroot.crt** which will be used to validate the files signed by the timestamp server.
- rsyslog.conf.d **can** be mounted to provide aditional rsyslog configurations.

## Disclaimer

**This is neither a secure nor an optimized way of logging.**

This is merely an experiment that could be improved in many ways. Feel free to contribute.
