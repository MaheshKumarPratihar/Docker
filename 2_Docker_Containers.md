<div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

<strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #d12626">Very Important!</strong>

```
docker --help
```

<p style="padding-left: 15px">
This  command is life saver, use it to find anything about docker command.
</p>

<p style="padding-left: 15px">
You can also use it to know more about other commands.
</p>

**Example**

```
docker run --help
```

```
docker network --help
```
</div>

## Create a docker container

Container are created from container images. 
Container images are compressed and pre-packaged file system that contain your app along with its environment and configuration with `an instruction` on how to start your application.

`That instruction` is called the `entry point`.

First we need to tell the docker to create a container from an image. If the image doesn't exist on your computer, **docker will try to retrieve from a container image registry**.
By default, Docker always tries to pull from `Docker Hub`.

### 1. First way (long way) - create + start + attach (see output)

```powershell
docker container create
```

Try to know more about the command:
```powershell 
docker container create --help
```

**Example:**

- Let's use the "hello world" image, it will print **Hello from Docker!**

- Type below command in `Powershell` or `Bash` to **create the container** with `hello-world` image and it will give an `id` of the created container, similar to this  `7c295a0996573f83270a14063e043d8b7ec1d11f8b1a8030f222a0d1fb9cb3e5`

    ```powershell
    docker container create hello-world:linux
    ```

This command specifically pulls the linux version, `:linux` it's a tag.


<div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

<strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">Note</strong>


```
docker container create hello-world:linux
```

<p style="padding-left: 15px">
The container create command, creates the container but <strong>DOES NOT START CONTAINERS</strong>.
</p>
</div>


- Use below command to list the containers:
**By default this command shows, containers which are running.**

   ```
   docker ps
   ```

   ![4_Docker_Containers_container_status](/Images/4_Docker_Containers_container_status.png)

   The `status` of the container is `created`.

- Command to check all the container in docker

   ```
   docker ps --all
   ```

- `Start` the container, will give the us the container id again as the output

   ```
   docker container start 7c295a0996573f83270a14063e043d8b7ec1d11f8b1a8030f222a0d1fb9cb3e5
   ```
- If we check the containers again using `docker ps --all`, the status changed.

   ![5_Docker_Containers_container_status_exited](/Images/5_Docker_Containers_container_status_exited.png)

 
- The container exited with `0` so, `NO ERRORS!`.

- We can check the `logs` with first three characters of container id : `7c2`

   ```
   docker logs 7c2
   ```
   `Finally the nice message!` 🥳
   ![6_Docker_Containers_logs_of_hello_world](/Images/6_Docker_Containers_logs_of_hello_world.png)


- If you don't want to check the logs for the output then alternative is to attach the terminal.

   ```
   docker container start --attach 7c2
   ```

### 2. Second way (short way)

Creating container, check using `ps` command, etc. is tedious.
Fortunately, docker has a single command to do all of this.
`Every time we run this command it will create a new container`.

   ```
   docker run hello-world:linux
   ```


<div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

<strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">Note</strong>




<p style="padding-left: 15px"><strong>
docker run = docker container create + docker container start + docker container attach</strong>.
</p>
</div>