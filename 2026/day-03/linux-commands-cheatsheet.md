# Linux Commands – Quick Revision Cheat Sheet

| Command                      | Usage                                                               |
| ---------------------------- | ------------------------------------------------------------------- |
| `ps -ef`                     | Display all running processes.                                      |
| `top` / `htop`               | Monitor CPU, memory, and processes in real time.                    |
| `kill <PID>`                 | Send a signal to a process; commonly used for graceful termination. |
| `kill -9 <PID>`              | Forcefully terminate a process.                                     |
| `pgrep <process>`            | Find the PID(s) of a process by name/pattern.                       |
| `pstree`                     | Display processes in a parent-child tree.                           |
| `systemctl status <service>` | Check the status of a service.                                      |
| `pwd`                        | Show the current working directory.                                 |
| `ls -l`                      | List files with detailed information.                               |
| `cd <directory>`             | Change the current directory.                                       |
| `mkdir <directory>`          | Create a new directory.                                             |
| `cp <source> <destination>`  | Copy files or directories.                                          |
| `mv <source> <destination>`  | Move or rename files/directories.                                   |
| `rm -rf <directory>`         | Remove files/directories recursively and forcefully.                |
| `find /path -name "file"`    | Search for a file by name.                                          |
| `df -h`                      | Show filesystem disk-space usage in human-readable format.          |
| `du -sh <directory>`         | Show the total size of a directory.                                 |
| `ping <host>`                | Test basic network reachability using ICMP.                         |
| `ip addr`                    | Display IP addresses and network interfaces.                        |
| `curl <URL>`                 | Test a web server, HTTP/HTTPS endpoint, or API response.            |
| `dig <domain>`               | Query DNS records.                                                  |
| `ss -tuln`                   | Display listening TCP/UDP ports and sockets.                        |
| `traceroute <host>`          | Show the network path toward a destination.                         |
| `nslookup <domain>`          | Query DNS and resolve a domain name.                                |
| `journalctl`                 | View systemd journal logs.                                          |

## Important Interview Points

### Process

```text
ps -ef
   ↓
Find process

pgrep <process>
   ↓
Find PID

kill <PID>
   ↓
Graceful termination request

kill -9 <PID>
   ↓
Forceful termination
```

### Disk

```text
df -h
→ Filesystem/disk space

du -sh <directory>
→ Directory size
```
Disk & System Health

These commands are worth adding because they are frequently used in Linux administration and DevOps troubleshooting.

Command	Description
free -m	Display memory usage in MB.
free -h	Display memory usage in human-readable format.
uptime	Show system uptime and load averages.
lscpu	Display CPU architecture and processor information.
lsblk	Display block devices and disks.
mount	Display mounted filesystems.
who	Show currently logged-in users.
w	Show logged-in users and their current activity.
uname -a	Display kernel and system information.
cat /etc/os-release	Display Linux distribution information.
### Networking

```text
ping <host>
→ Basic reachability

dig / nslookup
→ DNS resolution

ss -tuln
→ Listening ports

curl
→ Application/HTTP test

traceroute
→ Network path
```
Important Troubleshooting Commands

For a connectivity issue:

ping
  ↓
DNS
  ↓
route
  ↓
port
  ↓
application

Useful commands:

ping <host>
dig <domain>
ip route
ss -tuln
curl -v http://<host>:<port>
Important Point

ping tests ICMP connectivity. A successful ping does not prove that an application port such as 80, 443, or 8080 is accessible.

For example:

curl -v http://server:8080

or:

nc -zv server 8080

can be more useful for testing a specific TCP port.
### Logs

```bash
journalctl
```

For a specific service:

```bash
journalctl -u <service>
```

Follow logs in real time:

```bash
journalctl -f
```

## One Correction to Remember

`kill <PID>` is not technically synonymous with “gracefully stop” because `kill` sends a signal and, without specifying one, normally sends `SIGTERM`. For your interview notes, this is better written as:

```text
kill <PID>       → Send SIGTERM by default
kill -9 <PID>    → Send SIGKILL
```

Also, be careful with:

```bash
rm -rf
```

It is powerful and can permanently delete data, so always verify the path before executing it.

Useful Production Commands to Add
ls -lh

Human-readable file sizes.

du -sh /*

Quickly identify large directories.

find /var/log -type f -size +100M

Find large files under /var/log.

grep -i "error" application.log

Search for errors without case sensitivity.


Production Troubleshooting Quick Flow

When an application is reported as down, use a structured approach:

                 Application Down
                        |
                        v
              Check impacted users
                        |
                        v
              Check ongoing activity
                        |
                        v
              Check server connectivity
                        |
                        v
                 Check service
                        |
                        v
                  Check process
                        |
                        v
                  Check port
                        |
                        v
                   Check logs
                        |
                        v
              Check application layer
Example
ping <server>
ssh <server>
systemctl status <service>
ps -ef | grep <process>
ss -tuln | grep <port>
journalctl -u <service>
curl -v http://localhost:<port>

This approach connects your Linux administration experience directly to DevOps troubleshooting.

Quick Memory Map
PROCESS
ps → top → pgrep → kill

FILES
ls → cd → find → grep → cat → less → tail

DISK
df → du → lsblk

NETWORK
ip → ping → route → ss → curl → dig

SERVICE
systemctl → journalctl

SYSTEM
uname → uptime → free → lscpu

PERMISSIONS
ls -l → chmod → chown → id


