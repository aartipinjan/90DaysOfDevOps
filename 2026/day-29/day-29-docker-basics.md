# Docker – Day 1 Notes

## Today's Goal

Understand:

* What Docker is
* Why Docker is needed
* What a container is
* Difference between a VM and a container
* Why Docker is important in DevOps
* Run our first Docker container

---

# 1. Problems Before Docker

Before Docker, developers commonly faced problems such as:

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

This is an important topic for your Docker notes.

### Virtual Machine

A VM uses a **hypervisor**.

```text
Physical Server
      ↓
   Hypervisor
      ↓
 ┌───────────┐
 │    VM 1   │
 │   OS      │
 │   App     │
 └───────────┘

 ┌───────────┐
 │    VM 2   │
 │   OS      │
 │   App     │
 └───────────┘
```

Each VM has its own operating system.

---

### Container

Containers share the host's kernel.

```text
Physical Server
      ↓
Host Operating System
      ↓
Docker Engine
      ↓
 ┌───────────┐  ┌───────────┐
 │Container 1│  │Container 2│
 │   App     │  │   App     │
 └───────────┘  └───────────┘
```

The containers do not normally contain a complete guest operating system like VMs do.

---

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
```

---

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

### Docker

The platform/tools used to build and run containers.

### Docker Image

A package/template used to create containers.

### Container

A running instance of an image.

### Registry

A place where container images are stored.

Example:

**Docker Hub** is a public container registry.

---

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
