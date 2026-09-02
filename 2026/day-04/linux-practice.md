
# Linux Troubleshooting Practice – SSH Service Health

## Service Inspected

**Service:** `sshd` — OpenSSH Server

### Objective

Verify that the SSH service is healthy by checking:

* SSH processes
* SSH service status
* Running services
* SSH logs
* Listening port
* Remote SSH connectivity

---

# 1. Process Checks

## Command 1

```bash
ps -ef | grep sshd
```

### Sample Output

```text
root      1023     1  0 08:15 ?        00:00:01 /usr/sbin/sshd -D
aarti     2548  1980  0 08:30 pts/0    00:00:00 grep --color=auto sshd
```

### Observation

The `sshd` process is running.

> Note: The `grep sshd` command itself also appears in the output. This is normal.

---

## Command 2

```bash
pgrep sshd
```

### Sample Output

```text
1023
```

### Observation

The SSH daemon process has PID `1023`.

---

# 2. Service Checks

## Command 3

```bash
systemctl status sshd
```

### Sample Output

```text
● sshd.service - OpenSSH server daemon
   Loaded: loaded
   Active: active (running)
```

### Observation

The SSH service is **active and running successfully**.

---

## Command 4

```bash
systemctl list-units --type=service --state=running
```

### Sample Output

```text
cron.service
NetworkManager.service
sshd.service
systemd-journald.service
```

### Observation

This command lists currently running service units.

It also confirms that `sshd.service` is among the active services.

---

# 3. Log Checks

## Command 5

```bash
journalctl -u sshd --no-pager | tail -11
```

### Sample Output

```text
Accepted password for aarti
Session opened
Session closed
```

### Observation

The logs show successful SSH login activity.

This provides evidence that the SSH service is not only running but has successfully handled SSH sessions.

---

## Command 6

### RHEL/CentOS-type systems

```bash
tail -n 20 /var/log/messages
```

### Ubuntu/Debian

```bash
tail -n 20 /var/log/syslog
```

### Sample Output

```text
Jul 20 10:15 systemd: Started OpenSSH server.
Jul 20 10:18 sshd: Accepted password for aarti
```

### Observation

The system log shows recent SSH and system events.

---

# 4. Port Check

Verify that SSH is listening on port `22`:

```bash
ss -tuln | grep :22
```

### What this confirms

```text
sshd service
     ↓
Listening
     ↓
TCP port 22
```

This is an important check because a service can appear active while there may still be a problem with its listening socket or network accessibility.

---

# 5. Remote Connectivity Test

From another machine:

```bash
ssh username@server-ip
```

### Purpose

This verifies the complete path:

```text
Client
  ↓
Network connectivity
  ↓
Server
  ↓
Port 22
  ↓
sshd
  ↓
Authentication
  ↓
SSH session
```

---

# Mini Troubleshooting Procedure

If SSH is not working, follow this sequence:

### Step 1 – Check the service

```bash
systemctl status sshd
```

### Step 2 – Start the service if stopped

```bash
sudo systemctl start sshd
```

### Step 3 – Check the process

```bash
ps -ef | grep sshd
```

or:

```bash
pgrep sshd
```

### Step 4 – Check the listening port

```bash
ss -tuln | grep :22
```

### Step 5 – Review service logs

```bash
journalctl -u sshd
```

### Step 6 – Test from another machine

```bash
ssh username@server-ip
```

---

# Troubleshooting Flow

```text
                 SSH Not Working
                       |
                       v
              Check sshd service
                       |
                       v
              Check sshd process
                       |
                       v
             Check listening port 22
                       |
                       v
                Check SSH logs
                       |
                       v
          Test network connectivity
                       |
                       v
            Test SSH from client
```

---

# Commands Used

```bash
ps -ef | grep sshd
pgrep sshd
systemctl status sshd
systemctl list-units --type=service --state=running
journalctl -u sshd --no-pager | tail -10
tail -n 20 /var/log/messages
ss -tuln | grep :22
ssh username@server-ip
```

---

# Key Learnings

* `ps -ef` can be used to identify the SSH daemon process.
* `pgrep sshd` provides the PID of the SSH daemon.
* `systemctl status sshd` verifies the service state.
* `journalctl -u sshd` helps investigate SSH service events and failures.
* `ss -tuln` can verify whether SSH is listening on port `22`.
* An SSH connection test from another machine validates the end-to-end service path.
* Log locations can differ between Linux distributions.

---

# Interview-Ready Troubleshooting Approach

**“SSH is not working. How would you troubleshoot it?”**

> “First, I would check whether the `sshd` service is active using `systemctl status sshd`. Then I would verify that the SSH process is running with `ps` or `pgrep`. Next, I would check whether port 22 is listening using `ss`. I would review `journalctl -u sshd` for errors and then test SSH connectivity from another machine. Based on the results, I would continue with network, firewall, authentication, or configuration troubleshooting.”

---

# Final Summary

In this practice, I verified:

```text
Process     → sshd is running
Service     → sshd is active
Logs        → SSH activity is recorded
Port        → SSH listens on port 22
Connectivity → Remote SSH can be tested
```

### Result

The SSH service was verified through **process, service, log, port, and connectivity checks**.

> **Practical Linux troubleshooting principle: Process → Service → Port → Logs → Connectivity.**

