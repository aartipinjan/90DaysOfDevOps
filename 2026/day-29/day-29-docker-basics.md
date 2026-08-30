# Docker – Day 1 Notes

## Today's Goal

Understand:

* What Docker is
* Why Docker is needed
* What a container is
* Difference between a VM and a container
* Why Docker is important in DevOps
* Run our first Docker container

# 1. Problems Before Docker

**"But it works on my machine!"**
Imagine you write a small program on your laptop. It runs perfectly. You send it to a friend to try, and on their computer it breaks.

Why? Because their computer is not set up exactly like yours. Maybe your program needs Python version 3.11 and they have 3.9. Maybe it needs a tool or a library that you installed months ago and forgot about, but they never installed. The program itself is fine; the computer around it is different.

This happens constantly in real work. Software that runs on a developer's laptop falls over on the test server, or on a teammate's machine, because each computer has slightly different versions and settings. People waste hours hunting down these differences.

**What Docker does**:
Docker fixes this by packing your program together with everything it needs to run - the code, the right version of the language, every library, every tool, every setting - into one **sealed box.**

That sealed box is called a **container**. And Docker is the software that builds and runs these boxes for you: you use Docker to create a container, start and stop it, and delete it when you are done.

Because the box already contains everything, it runs the same way no matter whose computer it is on. Your laptop, your friend's computer, the company server: same box, same result. Nobody has to install or configure anything by hand. They just run the box.

A good way to picture it: think of shipping goods across the world. A shipping container is a standard steel box. It does not matter what is inside it or which ship, train, or truck carries it - every port knows how to handle the box. Docker does the same for software. Your program is the goods; the container is the standard box that runs anywhere.

Here is the same idea as a picture. One container, built once, runs unchanged on three very different machines:

<img width="2120" height="742" alt="image" src="https://github.com/user-attachments/assets/4c9c18ee-9a5c-43e8-b1c8-8c582c8c4d2d" />

Why so many people use it ?
This one idea - "**package it once, run it anywhere**" - turns out to be useful everywhere in modern software:

Developers build an app once and share it, knowing it will run the same for everyone.
Servers run many of these boxes side by side without them interfering with each other.
Automated systems build, test, and deploy software inside fresh, predictable containers.
You do not need to understand all of that yet. For now, just hold on to the core idea: a container is a sealed box that holds a program plus everything it needs, so it runs the same on any machine.

This skill builds up from there. First you will run containers other people made, then build your own, and finally connect several containers into one working application.

Before Docker, developers commonly faced problems such as: ( short ) 

| Before Docker             | Problem                                                                        |
| ------------------------- | ------------------------------------------------------------------------------ |
| Works on my machine       | Application works on the developer's machine but may fail on another machine   |
| Dependency conflicts      | Different applications may require different versions of libraries or packages |
| Different OS environments | Application may behave differently on different environments                   |
| Long setup time           | Installing applications and all dependencies can take a lot of time            |
| Manual deployments        | Deploying applications manually can cause mistakes                             |
| Inconsistent testing      | Development, testing and production environments may be different              |

### Simple example

Suppose a developer creates an application that requires:

```text
Python 3.11
MySQL 8
Specific Python libraries
Specific configuration
```

It works on the developer's laptop.

When the application is moved to another server, that server may have:

```text
Python 3.9
Different libraries
Different configuration
Different OS
```

The application may fail.

This is one of the problems Docker helps to solve.

---

# 2. What is Docker?

**Docker is an open-source platform used to build, package, run, and manage applications in containers.**

A simple way to remember it:

> **Docker packages an application together with the dependencies it needs to run.**

For example, an application may need:

```text
Application
    +
Libraries
    +
Runtime
    +
Configuration
```

Docker can package these into a **container image**, which can then be used to create containers.

---

# 3. Why is Docker Important?

Docker helps make the application environment more consistent.

Without Docker:

```text
Developer machine
       ↓
Different environment
       ↓
Testing server
       ↓
Different environment
       ↓
Production server
```

This can result in:

```text
"It works on my machine!"
```

With Docker:

```text
Docker Image
     ↓
Development
     ↓
Testing
     ↓
Production
```

The same image can be used to create containers in different environments.

This helps reduce environment-related problems.

---

# 4. Why Docker is Important in DevOps

Docker is important in DevOps because DevOps focuses on making software delivery:

* Faster
* Repeatable
* Consistent
* Automated
* Easier to deploy

Docker fits well into this process.

A common DevOps workflow is:

```text
Developer
    ↓
Git
    ↓
Build
    ↓
Docker Image
    ↓
Docker Registry
    ↓
Deploy
    ↓
Container
```

For example:

```text
Developer writes code
        ↓
Code pushed to Git
        ↓
CI pipeline builds application
        ↓
Docker image is created
        ↓
Image pushed to registry
        ↓
Application deployed
        ↓
Container runs the application
```

Later, when you learn **Jenkins, Kubernetes, OpenShift and CI/CD**, Docker will become much easier to understand because you will see where the container fits into the complete DevOps process.

---

# 5. When Was Docker Introduced?

Docker was originally developed by **DotCloud**.

Docker was publicly introduced in **2013 at PyCon** by Solomon Hykes.

Later, DotCloud changed its name to **Docker, Inc.**

Docker became widely adopted for building and running applications in containers.

### Important correction to your note

You wrote:

> "supported by the CNCF"

I would **not write this in your notes**.

Docker itself is not a CNCF project. Docker is widely used in the cloud-native ecosystem, while the **CNCF (Cloud Native Computing Foundation)** hosts projects such as Kubernetes.

So write:

> Docker is widely used in modern application development, DevOps and cloud-native environments.

---

# 6. What is a Container?

Before understanding Docker, we need to understand **containers**.

A container is an isolated environment in which an application and its required files and dependencies can run.

For example:

```text
Container
│
├── Application
├── Application libraries
├── Runtime
├── Configuration
└── Other required files
```

The container uses the **host operating system kernel** rather than having a complete operating system of its own.

This is one reason containers are generally lighter and faster to start than virtual machines.

---

# 7. Container vs Virtual Machine

Imagine there is a server, and you want to run three apps on it. You do not want them mixed together, because one app's software could clash with another's. So you want to give each app its own isolated space.

There are two ways to do this: virtual machines, or containers. They both give each app its own space, but the way they do it is very different, and that difference is why Docker won.

Way one: give each app a virtual machine
A virtual machine (VM) is a whole fake computer running inside your server. Each VM boots its own complete operating system - its own copy of Linux or Windows - on top of the server's.

So for three apps you now run three full operating systems, on top of the server's own. Each one brings gigabytes of files and takes a minute or two to start, just like a real computer booting up. It works, but it is heavy: most of that memory and disk is spent running operating systems, not your actual apps.

Way two: give each app a container
A container does not boot its own operating system. All three containers share the one operating system already running on the server. Each container wraps just its own app and the files that app needs, and borrows the rest from the server underneath.

Because there is no extra operating system to boot, a container starts in well under a second and is measured in megabytes, not gigabytes. On the same server you could fit a couple of VMs, but dozens of containers.

And this is not just for big servers. Install Docker on your own laptop and you can run several containers right there, side by side, without spinning up a single heavy VM. In this course you will practise all of this in the hands-on labs, which already have Docker set up for you.

A simple way to picture it
A VM is like building a separate house for every program: each one gets its own foundation, plumbing, and walls. A container is like renting a locked room inside one shared building: you get your own private space, but you share the building's foundation and plumbing with everyone else.

<img width="2120" height="742" alt="image" src="https://github.com/user-attachments/assets/66ba993e-66bd-48f9-8f48-ba738076445f" />

Both give a program its own isolated space. The container just does it without dragging a whole extra operating system along, which is why Docker took over.

Terms this node introduces
virtual machine (VM) - a full fake computer, with its own operating system, running inside a real one
container - an isolated program that shares the host's operating system instead of booting its own

# 8. VM vs Container

| Virtual Machine                 | Container                                     |
| ------------------------------- | --------------------------------------------- |
| Uses a hypervisor               | Uses a container engine such as Docker Engine |
| Each VM has its own OS          | Containers share the host kernel              |
| Usually requires more resources | Usually requires fewer resources              |
| Takes longer to start           | Usually starts quickly                        |
| Good isolation                  | Provides process-level isolation              |
| Larger in size                  | Usually smaller                               |

### Easy way to remember

**VM:**

```text
Application
    ↓
Guest OS
    ↓
Hypervisor
    ↓
Host
```

**Container:**

```text
Application
    ↓
Container
    ↓
Docker Engine
    ↓
Host OS Kernel


# 9. Docker Does Not Replace the Operating System

This is an important point.

A beginner may think:

> "Docker contains a complete operating system."

Not exactly.

A Docker image can contain things that **look like a small operating-system filesystem**, such as:

```text
/bin
/etc
/usr
/lib
```

But a normal Linux container does not contain its own complete Linux kernel.

The container uses the host kernel.

This is different from a VM.

---

# 10. What Problems Does Docker Help Solve?

Your image gives a good summary. I would write it in your notes like this:

### Before Docker

```text
❌ Works only on my machine
❌ Dependency conflicts
❌ Different environments
❌ Long setup time
❌ Manual deployment
❌ Inconsistent testing
```

### With Docker

```text
✅ Consistent application environment
✅ Application dependencies can be packaged
✅ Easy to create the same environment
✅ Containers can start quickly
✅ Works well with automated deployment
✅ Helps make testing environments consistent
```

One small correction: **Docker does not automatically make everything consistent or automatically provide CI/CD.** It provides a useful packaging and runtime mechanism that can be integrated into CI/CD.

---

# 11. Very Important Docker Terms

You will hear these words repeatedly:

```text
Docker
   ↓
Image
   ↓
Container
   ↓
Registry
```

For now, remember:

You will hear two words over and over in Docker: image and container. Beginners mix them up all the time, and it causes confusion later, so let's pin down the difference with a simple comparison.

Think of a recipe in a cookbook.

The recipe is just instructions on paper. It lists everything you need and how to put it together. On its own it does nothing - it just sits in the book.
The dish is what you actually get when you cook the recipe. It is real, it is finished, and you can eat it.
In Docker, the image is the recipe and the container is the dish you cook from it.

An image is the recipe (the package)
An image is a ready-made package that sits on your computer. It bundles a program together with everything it needs, frozen together. Like a recipe, it does nothing by itself - it just waits until you tell Docker to run it.

Images have a name and a version, written as name:tag. For example nginx:latest, python:3.12, and redis:alpine are all images. The part after the colon (the tag) is usually the version. If you leave the tag off, Docker assumes latest.

A container is the dish (the running program)
A container is what you get when you start an image. Docker takes the image and runs it, and that live, running thing is the container.

Just like you can cook the same recipe many times, you can start many containers from one image:

<img width="2120" height="742" alt="image" src="https://github.com/user-attachments/assets/e234a29d-d415-4bf2-a261-7c84f7c9b4d5" />


Each container is separate from the others. Stopping or deleting one does not affect the image or the other containers - just like throwing away one dish does not touch the recipe or the other dishes.

Where images come from
You do not have to build every image yourself. Ready-made images live in a registry, which is just an online store of images. The main public one is Docker Hub, and it already has official images for nginx, postgres, python, and thousands of other tools. You download ("pull") an image once, Docker keeps a copy on your machine, and every run after that is instant.

Terms this node introduces
image - the read-only package
container - a running instance of an image
tag - the version label after the colon in name:tag
registry - where images are stored and pulled from, Docker Hub by default


Docker has two parts: a command line client you type into, and a background service called the daemon (or engine) that does the real work of pulling images and running containers. The client sends your commands to the daemon. On this machine the daemon is already running, so you can talk to it straight away.

docker version
The first thing to check on any machine is whether the client can reach the daemon:

bash

docker version
This prints two blocks, Client and Server. Seeing both means the client is installed and the daemon is up and answering. If you ever see "Cannot connect to the Docker daemon", the engine is not running - but here it is, so you will get both blocks.

docker info
For a fuller picture of the engine's state, use:

bash

docker info
It reports how many images and containers exist, the storage driver, the total memory, and more. It is the go-to command when you want to know what the engine currently holds.

docker run hello-world
The classic smoke test pulls a tiny image and runs it:

bash

docker run hello-world
The hello-world image exists for exactly this purpose. Docker pulls it from Docker Hub (the first time only), starts a container, and the container prints a short message confirming the whole pipeline works - client, daemon, pull, and run. The container prints its message and exits immediately, which is normal.

Commands this node introduces
docker version - show client and server versions
docker info - show engine state and totals
docker run hello-world - pull and run the test image end to end


# 12. One Simple Example

Suppose we have an Nginx image:

```text
Nginx Docker Image
        ↓
   docker run
        ↓
Nginx Container
        ↓
   Nginx Application
```

The important relationship is:

> **Image → Container**

An image is used to create a container.

You can create multiple containers from the same image:

```text
             Nginx Image
             /    |    \
            ↓     ↓     ↓
      Container  Container  Container
```

---

# 13. Your First Docker Learning Flow

I recommend that you **don't jump directly into Dockerfile, Kubernetes or Docker Compose yet.**

First understand this flow:

```text
Docker
  ↓
Container
  ↓
Image
  ↓
Docker Hub / Registry
  ↓
docker pull
  ↓
docker run
  ↓
docker ps
  ↓
docker stop
  ↓
docker start
  ↓
docker rm
```

Once this becomes clear, Dockerfile will make much more sense.

---

## Your corrected "Day 1" summary

You can put this at the end of your notes:

> **Docker is an open-source platform used to build, package, and run applications in containers. Docker helps reduce environment-related problems by packaging an application and its required dependencies into a container image.**
>
> **Containers are lightweight compared with virtual machines because they share the host operating system kernel instead of running a complete guest operating system.**
>
> **Docker is important in DevOps because containers can be used as a consistent unit for building, testing, and deploying applications and can be integrated into CI/CD pipelines.**

### One thing I want you to remember today

Don't try to memorize 50 Docker commands.

Understand this first:

**Application → Image → Container**

Once you understand that relationship, we can build the rest of Docker around it.

Question :
Run docker version in your terminal. It prints a Client block and, when the daemon is reachable, a second block right below it. What is that second block called?

root@bash-lab:~# docker --version
Docker version 29.1.3, build 29.1.3-0ubuntu3~24.04.2
Answer:  **server** 
`docker version` prints a Client block for the command line tool and a Server block for the daemon it connected to. Seeing the Server block is proof the engine is running and your client can reach it. When the daemon is down, that second block is replaced by an error like "Cannot connect to the Docker daemon", which is the single most common Docker setup problem you will meet in the wild.


Task :

You have a fresh machine and you want to prove Docker actually works before you build anything real on it. The standard way to do that is to run the hello-world image.

Start a container from the hello-world image. Docker will pull the image from Docker Hub the first time, run it, print a short confirmation message, and exit. That is the expected behaviour - this image is designed to run once and stop.

The command you need was introduced in the verify-the-engine node.

Press Submit when the container has run.

root@escbash-lab:~# docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete 
d5e71e642bf5: Download complete 
Digest: sha256:5dd0d3e6e255913fc30f90b9f2b1d359cc2cbdb48090cc4b65f1676e203243cc
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

root@escbash-lab:~# 

Question :

Your team ships a Python web service. QA keeps hitting bugs that developers cannot reproduce, because QA's server runs a slightly different Python version and is missing a library. A teammate suggests giving every developer a full virtual machine image of the production server to work in. What is the better fix?
Write a long setup document telling everyone which Python version and libraries to installGive every developer a multi-gigabyte virtual machine cloned from productionPackage the service

Answer : Package the service and its exact runtime and libraries into a Docker image, and have everyone run that same image.


docker run is the command you will type more than any other. It takes an image, creates a container from it, and starts the process inside. The basic shape is:

bash

docker run IMAGE [command]
If the image is not already on the machine, Docker pulls it from the registry first, then runs it.

Running a command in a container
Most images have a default command, but you can override it by adding your own after the image name. This runs echo inside a fresh Alpine Linux container:

bash

docker run alpine echo "hello from inside a container"
Docker pulls the tiny alpine image, starts a container, runs echo, and the moment echo finishes the container stops. A container lives exactly as long as its main process. When the process exits, so does the container.

The foreground is the default
By default docker run attaches your terminal to the container and shows its output directly, then hands control back when it exits. Try a command that lists the container's own filesystem:

bash

docker run alpine ls /
You see the root directory of the container, not your host. That is the isolation from the last topic in action - the process sees its own filesystem.

Pulling happens once
The first docker run alpine downloads the image. Every run after that reuses the cached copy and starts almost instantly. You do not pull by hand for normal use - docker run handles it.

Commands this node introduces
docker run IMAGE - create and start a container from an image
docker run IMAGE command args - override the default command

Listing Docker Containers

Use docker ps to view containers running on your system.

Running containers only

docker ps


Shows currently running containers, including their ID, image, status, ports, and name.

All containers (running + stopped)

docker ps -a

Shows every container, including stopped ones. This helps you find old containers that still exist on the machine.

Container ID and Name

Every container has a unique ID and a name.
If you don't specify a name, Docker creates one automatically.
You can use either the ID or name with commands like docker stop, docker logs, and docker rm.

Key Commands

docker ps      # List running containers
docker ps -a   # List all containers


You want to confirm two things on this machine: that a container can run a single command and then exit, and that it still shows up in the full container list afterwards so you can see what ran.

Do this:

Run a container from the alpine image whose command prints the exact text run-and-list-ok.
Let it run and exit on its own. A container lives only as long as its command, so it stops the moment the text is printed.
Then list all containers, including stopped ones, and confirm your container is there.
The docker run command and overriding a container's command were covered in the docker-run node. Listing stopped containers was covered in the docker-ps node.

Press Submit when the container has run and printed the text.

# docker run alpine echo run-and-list-ok

Docker Detached Mode & Naming - Short Notes 📝
Run Container in Background
docker run -d nginx

-d = detached mode (background)
Starts container and returns terminal prompt immediately
Container keeps running
Check Running Containers
docker ps

Shows currently running containers
Give Container a Name
docker run -d --name web nginx

--name assigns a custom name
Easier to manage than random Docker names
Use the Container Name
docker stop web
docker logs web
docker rm web

Foreground vs Detached

Foreground (default)

Runs in terminal
Shows output live
Best for short commands

Detached (-d)

Runs in background
Best for web servers, databases, and long-running services
Quick Commands
docker run -d IMAGE

➡️ Run container in background

docker run -d --name NAME IMAGE

➡️ Run container with a custom name

Memory Tip
-d       = Detached (Background)
--name   = Friendly container name

Foreground = Watch output
Detached  = Keep service running

root@bash-lab:~# docker run -d --name web nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
6310eb16bf42: Pull complete 
0a35a4e59186: Pull complete 
30576ad53d33: Pull complete 
b8f66660faa6: Pull complete 
657dd7fba849: Pull complete 
c90544874aaf: Pull complete 
8f655e1bd5c1: Pull complete 
e0649adc94d9: Download complete 
1cf64d45fa0f: Download complete 
Digest: sha256:b34848eff6db786b6b1282d3a9c3fd0b5563dfb6d261df4923378b419e0d24f0
Status: Downloaded newer image for nginx:latest
85fc9b0a4e6186cc97808a85b3cb2a18344bb14ff8f45c6f01078f300faf7c52
root@bash-lab:~# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS     NAMES
85fc9b0a4e61   nginx     "/docker-entrypoint.…"   8 seconds ago   Up 7 seconds   80/tcp    web
root@bash-lab:~# 

Containers you start in the background keep running until you stop them, and stopped containers stick around until you remove them. Knowing how to clean up is part of running containers.

Stopping a running container
docker stop asks a container's main process to shut down gracefully:

bash


docker stop web
Docker sends the process a termination signal, waits a few seconds for it to exit cleanly, and forces it if it does not. The container moves from running to stopped. It is not gone - docker ps -a still shows it.

A stopped container can be started again with docker start:

bash


docker start web
Removing a container
To delete a stopped container and free the disk space it used, use docker rm:

bash


docker rm web
You cannot remove a running container this way - stop it first, or force removal with docker rm -f web, which stops and deletes in one step.

Removing automatically with --rm
For throwaway containers you never want to keep, add --rm to the run command. Docker deletes the container automatically the moment it exits:

bash

docker run --rm alpine echo "gone when done"
This keeps docker ps -a from filling up with dozens of dead one-shot containers. Use it for quick commands; leave it off for services you may want to restart or inspect later.

Commands this node introduces
docker stop NAME - stop a running container gracefully
docker start NAME - start a stopped container again
docker rm NAME - remove a stopped container
docker rm -f NAME - force-remove a running container
docker run --rm ... - auto-remove the container when it exits

root@escbash-lab:~# docker run alpine echo run-and-list-ok
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
55afa1ecc21d: Pull complete 
56dceff11b33: Download complete 
f5124fb579e2: Download complete 
Digest: sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b
Status: Downloaded newer image for alpine:latest
run-and-list-ok
root@escbash-lab:~# ^C
root@escbash-lab:~# docker run -d --name web nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
6310eb16bf42: Pull complete 
0a35a4e59186: Pull complete 
30576ad53d33: Pull complete 
b8f66660faa6: Pull complete 
657dd7fba849: Pull complete 
c90544874aaf: Pull complete 
8f655e1bd5c1: Pull complete 
e0649adc94d9: Download complete 
1cf64d45fa0f: Download complete 
Digest: sha256:b34848eff6db786b6b1282d3a9c3fd0b5563dfb6d261df4923378b419e0d24f0
Status: Downloaded newer image for nginx:latest
85fc9b0a4e6186cc97808a85b3cb2a18344bb14ff8f45c6f01078f300faf7c52
root@escbash-lab:~# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS     NAMES
85fc9b0a4e61   nginx     "/docker-entrypoint.…"   8 seconds ago   Up 7 seconds   80/tcp    web
root@escbash-lab:~# # Start Redis in the background with the required name
docker run -d --name session-cache redis:7-alpine

# Verify it is running
docker ps


A Redis cache is needed during a short maintenance window. Once the window closes you should stop it but keep it around so it can be started again later, not deleted.

Set this up end to end:

Start a container in the background from the redis:7-alpine image, named session-cache.
Confirm it shows as running in the container list.
The maintenance window is now over, so stop the session-cache container gracefully. Do not remove it - it must still exist so it can be restarted another day.
Running detached and naming a container were covered in the detached-mode-and-naming node. Stopping a container was covered in the stopping-and-removing node.

Press Submit when session-cache exists but is stopped.

2 checks
A container named session-cache exists from the redis:7-alpine image
The session-cache container is stopped, not removed

# Stop it gracefully but keep the container
docker stop session-cache
Unable to find image 'redis:7-alpine' locally
7-alpine: Pulling from library/redis
41caa0265cb5: Pull complete 
9516b0cd89c9: Pull complete 
897d797d2723: Pull complete 
d85eda7b0b14: Pull complete 
2c96e5a02ba0: Pull complete 
de4b872bfdc3: Pull complete 
4f4fb700ef54: Pull complete 
b6651aa653eb: Download complete 
64d3b1f2f406: Download complete 
Digest: sha256:ff02b58f971e7d7d156a1267e283fcbbeee91773b6aa36c49dac28ecfe28eadf
Status: Downloaded newer image for redis:7-alpine
0e96ae7f8e795ffab9ef90dee80bb8529c4d10de48389e85e583d773eb9f66ec
CONTAINER ID   IMAGE            COMMAND                  CREATED                  STATUS                  PORTS      NAMES
0e96ae7f8e79   redis:7-alpine   "docker-entrypoint.s…"   Less than a second ago   Up Less than a second   6379/tcp   session-cache
85fc9b0a4e61   nginx            "/docker-entrypoint.…"   2 minutes ago            Up 2 minutes            80/tcp     web
session-cache
root@bash-lab:~# docker ps -a
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS                     PORTS     NAMES
0e96ae7f8e79   redis:7-alpine   "docker-entrypoint.s…"   10 seconds ago   Exited (0) 9 seconds ago             session-cache
85fc9b0a4e61   nginx            "/docker-entrypoint.…"   2 minutes ago    Up 2 minutes               80/tcp    web
f6cb884d2b07   alpine           "echo run-and-list-ok"   5 minutes ago    Exited (0) 5 minutes ago             elegant_haslett
root@cbash-lab:~#

