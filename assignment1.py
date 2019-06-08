#!/usr/local/bin/python2

from argparse import ArgumentParser
from subprocess import call

parser = ArgumentParser(description="Setup scheduled backups using crontab and rsync")

parser.add_argument("--original", help="Directory to be backed up")
parser.add_argument("--backup", help="Directory to store the compressed backup")
parser.add_argument("--schedule", help="Scheduled time for backup in crontab format")

arguments = parser.parse_args()

if isinstance(arguments.schedule, str):
  steps = ['crontab -l > tmp_crontab || true', "echo '%s rsync -avz --delete %s %s'  >> tmp_crontab" % (arguments.schedule, arguments.original, arguments.backup), 'crontab tmp_crontab', 'rm tmp_crontab']
  
  for cmd_step in steps:
    if call(cmd_step, shell = True) != 0:
      raise Exception("Something went wrong when trying to configure new crontab task! Last erroneous command executed: %s", cmd_step)
      # should cleanup tmp_crontab if necessary.
      
else:
  raise TypeError("'schedule' should be a string with format: * * * * *," + " where '*' are minutes, hour, day of the week, month, day of the month. ")