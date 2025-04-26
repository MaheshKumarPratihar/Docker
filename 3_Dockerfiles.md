## Introduction

In this section, we will learn how to create docker images by ourselves. We can also push our images to docker hub.

### Explaining the keywords

**1. [FROM](https://docs.docker.com/reference/dockerfile/#from)**

```Dockerfile
FROM ubuntu
```

- `FROM`, tells which existing Docker image to base your Docker image off of. By default docker will try to get this image from **Docker hub** if it's not already present.

- The `FROM` instruction initializes a new build stage and sets the [base image](https://docs.docker.com/reference/glossary/#base-image) for subsequent instructions. As such, a valid Dockerfile must start with a FROM instruction. 


- A `base image` is an image you designate in a `FROM` directive in a `Dockerfile`. It defines the **starting point** for your build. 

- Dockerfile instructions create **additional layers on top of the base image**. 

- A Dockerfile with the `FROM` scratch directive uses an empty base image.

**2. [LABEL](https://docs.docker.com/reference/dockerfile/#label)**

- An additional metadata.
- The `LABEL` instruction adds metadata to an image. A `LABEL` is a key-value pair. To include spaces within a `LABEL` value, use quotes and backslashes as you would in command-line parsing. A few usage examples:

    ```Dockerfile
    LABEL "com.example.vendor"="ACME Incorporated"
    LABEL com.example.label-with-value="foo"
    LABEL version="1.0"
    LABEL description="This text illustrates \
    that label-values can span multiple lines."
    ```

**3. [USER](https://docs.docker.com/reference/dockerfile/#user)**

- This command tells which user to use for all the command in the Dockerfile underneath it.
- By default, Docker will use `root` user to execute the commands.

    ```Dockerfile
    USER root
    ```

    ```Dockerfile
    USER nobody
    ```

**4. [COPY](https://docs.docker.com/reference/dockerfile/#copy)**

- `COPY` copies files from a directory provided to the Docker build command to the container image.
- The **directory** provide is called the **context**.
- The **context** is usually your **working directory**.

- The `COPY` instruction copies new files or directories from <`src`> and adds them to the filesystem of the image at the path <`dest`>. Files and directories can be copied from the build context, build stage, named context, or an image.

    ```Dockerfile
    COPY [OPTIONS] <src> ... <dest>
    COPY [OPTIONS] ["<src>", ... "<dest>"]
    ```

**5. [RUN](https://docs.docker.com/reference/dockerfile/#run)**

- `RUN` statements are used to **customize** our image.
- Great way to install additional software or configure files needed by your application.

    ```Dockerfile
    RUN apt -y update
    RUN apt -y install curl bash
    ```
- The `RUN` instruction will execute any commands to create a new layer on top of the current image. The added layer is used in the next step in the Dockerfile.

**6. [ENTRYPOINT](https://docs.docker.com/reference/dockerfile/#entrypoint)**

- It tells, what command containers created from this image should run.
- We can use `CMD` command also but there are differences.




## To build a image from Dockerfile

- Run this command to build the image from a `Dockerfile` in the working directory
    ```powershell
    docker build -t <image_name>  .
    ```

- File has a specific name


    ```powershell
    docker build --file server.Dockerfile -t <image_name> .
    ```

    <div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

    <strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

    <p style="padding-left: 15px">
    This will start the server and we cannot stop it as by default, Docker containers are not interactive.
    </p>
   </div>

## How to stop the container?

![7_Dockerfiles_server](/Images/7_Dockerfiles_server.png)

1. Get docker `ID`

    ```powershell
    docker ps
    ````
2. Then `kill` the container

    ```powershell
    docker kill <containerID>
    ```

## Work around for the `hanging` terminal

- This command will run the container but will not attach the `terminal`.
    ```
    docker run -d <image_name>
    ```

- We can also use `docker container create` and then `docker container start`

## We can run command on our container user `exec`

- Example - getting date

    ```powershell
    docker exec <container_id> date
    ```

- Example - running an instance of `bash` terminal

```powershell
docker exec --interactive --tty <container_id> bash
```
## Stopping or removing containers

- **Stop** - it's little bit slow as docker gradually stop the programs which are running inside the container.

    ```powershell
    docker stop <container_id>
    ```

- **Stopping forcefully** - will stop the container faster but there might be data loss

    ```powershell
    docker stop -t 0 <container_id>
    ```

- R**Remove container** - will not stop the running containers

    ```powershell
    docker rm <container_id>
    ```

- **Remove running container**
    ```powershell
    docker rm -f <container_id>
    ```

- **Remove list of container**

    1. First get only IDs of containers.
    ```powershell
    docker ps -aq
    ```

    2. Then `|` (pipe) the first command's result 
    ```powershell
    docker ps -aq | xargs docker rm
    ```

    `xargs` - it's taking each id then feeding to `docker rm`

## Removing images

- **To list images**

    ```powershell
    docker images
    ```

- **Remove** - but won't remove images from a running container, case use `-f` for forceful removal but might have unexpected behavior.

    ```powershell
    docker rmi <image_name>
    ```