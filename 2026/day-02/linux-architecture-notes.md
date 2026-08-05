Linux Fundamentals - My Notes
Kernel

The kernel is the heart of the Linux operating system.
It acts as a bridge between the hardware and software. You can think of it as a manager that manages all the system resources.

The kernel is responsible for:
Managing the CPU / memory (RAM) / storage (disk)  / hardware devices / processes / User Space

User space is where users and applications work.
Most programs like Bash, Firefox, Docker, Python, and many others run in user space.
Applications cannot directly access the hardware. Instead, they request services from the kernel through system calls.

Init / systemd

systemd is the parent process in Linux, and its Process ID (PID) is 1.
It is the first process started after the Linux kernel boots.
Its responsibilities include:

Initializing the operating system after boot
Starting and managing system services
Managing background services (daemons)
Monitoring services and restarting them if needed
How Processes Are Created and Managed
Every running program is called a process.
Each process has a unique Process ID (PID).
When a user starts a program, Linux creates a new process.
The CPU scheduler decides which process gets CPU time.

A process can create child processes, and parent and child processes can communicate with each other.
Process States

Running (R): The process is running or waiting to use the CPU.
Sleeping (S): The process is waiting for an event, such as user input or disk I/O.
Stopped (T): The process has been paused by the user or a signal.
Zombie (Z): The process has finished execution, but its parent has not yet collected its exit status.
Idle (I): Mostly used for kernel threads that are waiting in the background.

What Does systemd Do?

systemd is responsible for:
Starting the operating system during boot
Starting, stopping, and restarting services
Automatically starting services after a reboot
Managing service dependencies
Collecting system logs using journald

Why is systemd Important?
Without systemd, Linux would not automatically start important services like SSH, networking, databases, and web servers. It makes system startup, service management, and troubleshooting much easier.

Daily Linux Commands
ps -ef – Display all running processes.
top (or htop) – Monitor CPU, memory, and running processes.
systemctl status <service> – Check the status of a service.
journalctl -xe – View system and service logs.
kill -9 <PID> – Forcefully terminate a process.
