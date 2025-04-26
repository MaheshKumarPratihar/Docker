## Difference between VMs and Docker

|                |Virtual Machine                |Containers                   |
|----------------|-------------------------------|-----------------------------|
|1               | Virtualize Hardware      	 |Virtualizes OSs Kernels            |
|2        		 | Runs on Hypervisor            |Runs on Container Runtime           |
|3				 | Allow a lot of flexibility    |Do not emulate anything, no need for boot up|
|4				 | Can take up a lot of space	 |No OS installation is required|
|5				 | Require you to install/configure OS | Less space |
|6				 | Can run multiple apps at the same time |	Can run only one app at a time (by design) |
|7				 | Apps running on VM cannot see apps on the host| Can interact with their host |

> **Note**
> 
> **Hypervisor:** Emulate the real hardware, allows a lot of flexibility.
> **Container Runtime:** Works with OS kernels to allocate hardware and copy files and directories, including the parts with your application in it.
> 

## Anatomy Of a Container 

__A container is composed of two things__


![1_Docker_Containers_in_docker](/Images/1_Docker_Containers_in_docker.png)



### 1. A Linux namespace 


<div style="background-color: white;
      border-radius: 10px; /* Rounded corners */
      padding: 30px;
      max-width: 600px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Soft shadow */
      font-style: italic; /* Italicize the quote */
      color: #333; /* Dark grey text */
      line-height: 1.6; /* Line spacing */
      font-size: 18px;">
“Namespaces are a feature of the Linux kernel that partitions kernel resources such that one set of processes sees one set of resources while another set of processes sees a different set of resources.”
</div>

In other words, the key feature of namespaces is that they isolate processes from each other. On a server where you are running many different services, isolating each service and its associated processes from other services means that there is a smaller blast radius for changes, as well as a smaller footprint for security‑related concerns. Mostly though, isolating services meets the architectural style of microservices as described by [Martin Fowler](https://martinfowler.com/articles/microservices.html).

#### An Example of Parent and Child PID Namespaces

In the diagram below, there are three PID namespaces – a parent namespace and two child namespaces. Within the parent namespace, there are four processes, named `PID1` through `PID4`. These are normal processes which can all see each other and share resources.

The child processes with `PID2` and `PID3` in the parent namespace also belong to their own PID namespaces in which their PID is 1. From within a child namespace, the `PID1` process cannot see anything outside. For example, `PID1` in both child namespaces cannot see `PID4` in the parent namespace.

This provides isolation between (in this case) processes within different namespaces.

![2_docker_namespaces_example](/Images/2_docker_namespaces_example.png)


### 2. Control Groups


A control group (cgroup) is a Linux kernel feature that limits, accounts for, and isolates the resource usage (CPU, memory, disk I/O, network, and so on) of a collection of processes.

**Cgroups provide the following features:**

- **Resource limits** – You can configure a cgroup to limit how much of a particular resource (memory or CPU, for example) a process can use.
- **Prioritization** – You can control how much of a resource (CPU, disk, or network) a process can use compared to processes in another cgroup when there is resource contention.
- **Accounting** – Resource limits are monitored and reported at the cgroup level.
- **Control** – You can change the status (frozen, stopped, or restarted) of all processes in a cgroup with a single command.


So basically you use cgroups to control how much of a given key resource (CPU, memory, network, and disk I/O) can be accessed or used by a process or set of processes. Cgroups are a key component of containers because there are often multiple processes running in a container that you need to control together. In a Kubernetes environment, cgroups can be used to implement resource requests and limits and corresponding QoS classes at the pod level.

The following diagram illustrates how when you allocate a particular percentage of available system resources to a cgroup (in this case cgroup‑1), the remaining percentage is available to other cgroups (and individual processes) on the system.

The following diagram illustrates how when you allocate a particular percentage of available system resources to a cgroup (in this case **cgroup‑1**), the remaining percentage is available to other cgroups (and individual processes) on the system.

![3_Docker_Control_groups](/Images/3_Docker_Control_groups.png)