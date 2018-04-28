# No-frills simple incremental backup for a linux web-server

*IN PROGRESS - DO NOT USE YET*

I wanted a simple cost-effective way of backing up website files and databases off-site for some small VM-based cloud-servers i have on DigitalOcean, and this script is the result.

As the sites are currently small, I'm backing up to a sync'd dropbox folder on the server, which is effectively free while the total sum of backups is < 2Gb. This'll also work well with mounted S3 drives under linux.

Written for and tested under Centos7, should in theory work for other linuxes too.

## How it works

This script utilizes TAR's ability to archive incremental changes. Run this script as a cron job, and it will (as a default) manage 2 weeks of backups, with full backups on a saturday (i schedule this for 1am on a saturday morning) and incrementals on other days. Also takes an export of specified mysql/maridadb databases and backs those up too.

## Installation

First, decide how you're going to copy the backup files offsite - eg create a new Dropbox account and mount it on the server as a folder, or similar with an Amazon S3 account.

Edit the perform-backup.sh script to specify the folder you want to back up.

You'll need to add this to the crontab. Here's an example for running at 1am each morning:
0 1 * * * /usr/bin/bash /path/to/script/perform-backup.sh > /dev/null

## Configuration

## Further Notes
