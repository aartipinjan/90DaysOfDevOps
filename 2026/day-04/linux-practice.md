Service Inspected

Service: sshd (SSH Server)

1. Process Checks

Command 1
ps -ef | grep sshd

Sample Output

root      1023     1  0 08:15 ?        00:00:01 /usr/sbin/sshd -D
aarti     2548  1980  0 08:30 pts/0    00:00:00 grep --color=auto sshd

Observation:
The sshd process is running.

Command 2
pgrep sshd

Sample Output

1023

Observation:
The process ID (PID) of the SSH service is 1023.

2. Service Checks
Command 3
systemctl status sshd

Sample Output

● sshd.service - OpenSSH server daemon
   Loaded: loaded
   Active: active (running)

Observation:
The SSH service is active and running successfully.

Command 4
systemctl list-units --type=service --state=running

Sample Output

cron.service
NetworkManager.service
sshd.service
systemd-journald.service

Observation:
This command lists all currently running services.

3. Log Checks
Command 5
journalctl -u sshd --no-pager | tail -10

Sample Output

Accepted password for aarti
Session opened
Session closed

Observation:
The logs show successful SSH login activity.

Command 6
tail -n 20 /var/log/messages

(On Ubuntu use /var/log/syslog instead.)

Sample Output

Jul 20 10:15 systemd: Started OpenSSH server.
Jul 20 10:18 sshd: Accepted password for aarti

Observation:
The system log shows recent SSH and system events.

Mini Troubleshooting Steps

If the SSH service is not working:

Check if the service is running:

systemctl status sshd

Start the service if it is stopped:

sudo systemctl start sshd

Review service logs:

journalctl -u sshd

Verify the SSH process:

ps -ef | grep sshd

Check if SSH is listening on port 22:

ss -tuln | grep :22

Test SSH connectivity from another machine:

ssh username@server-ip
Summary

In this practice, I verified the running process, checked the SSH service status, reviewed service logs, 
and followed basic troubleshooting steps to confirm that the SSH service was working correctly.
