# Docker Compose

- Written in `yaml`.
- The advantage of containerization is to fully encapsulate the entire application in a container.

## Examples:
Storefront: online store which sells energy efficient equipments, it uses `MySQL` db to store data.

<div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

<strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

<p style="padding-left: 15px; font-weight: bold">
    In Docker Compose, services can be named anything.
</p>
</div>

```yaml
version: "3.9" # Version of Docker compose

services: # This specifies all the containers application needs to run
  storefront: # First service (name is customizable), after this we need to provide instructions on how to create the container for Storefront. # In this case we want to build locally
    build: . # We can use bash annotation "." as our image will be in same directory.
  database:   # Second Service which we need for the MySQL
    image: "mysql" # Docker Hub has pre-build MySQL images so just need to provide the name.
```

<div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

<strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

<p style="padding-left: 15px;">
    Docker Compose provides many commands for managing the lifecycle of services but commonly used are <strong>up</strong>, <strong>down</strong>, <strong>stop</strong>, and <strong>restart</strong>
</p>
</div>

## docker-compose up

- It starts all the services defined in docker-compose file.
- It build all the services, create the containers and start them
- We can choose to start only one service too, by selecting the name of the service.
    ```powershell
    docker-compose up storefront
    ```
- Combination of `build + create + start = up`

    ```bash
    docker-compose build && docker-compose create && docker-compose run
    ```

## docker-compose down

- It stops all containers.
- Delete all containers and images.
- Remove all artifacts.

## docker-compose stop

- Saves batter life
- Frees up memory

## docker-compose restart

- It will restart everything
- Combination of stop and start
    ```powershell
    docker-compose stop; docker-compose start
    ```

## docker-compose --help

- Will give all commands and their descriptions.

# Build Arguments and Environment variables

|Environment Variables | Build Arguments |
|----------------------|-----------------|
| Accessible inside the Running Docker container.  | Accessible only at build time.|
------------------------------------------------------------------------------------

## Build Arguments Use Cases
- Build tool versions.
- Cloud platform configuration.
  - Example: AWS region


## Example:

```yaml
version: "3.9"

services:
  storefront:
    build: 
      context: . 
      args: # way of adding build arguments by defining the context instead of "build: ." we can add any number of arguments.
        - region=us-east-1
        - alice=0 # arguments can have any name and value.
  database:   
    image: "mysql"
```

## Environment Variables Use Cases
- Commonly it's used for passing the `current runtime environment` such as `development`, `production`, etc.

- This is used for `logging`
    ```java
    Logger.log("logging from environment: {runtime_env}");
    ```

- Enabling a **flag**
    ```java
    if(runtime_env == "test") disable_payments()
    ```
-  But can be used for anything.

## Example:

- Add an attribute under the service, named as `environment`.
- Then in list format add any variable that should be accessible by the container.
- Can have any name or value.

```yaml
version: "3.9"

services:
  storefront:
    build: 
      context: . 
      args: 
        - region=us-east-1
        - alice=0 
    environment:
      - runtime_env # Without a value will pass the environment variable from the host. example "export runtime_evn=dev" in bash
  database:   
    image: "mysql"
```

<div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

<strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

<p style="padding-left: 15px;">
    Without a value will pass the environment variable from the host. Provided that the host environment won't change.
    But we can provide the hardcoded value too.

Example: <strong>in bash</strong>

<code style="background-color: #eee;
    border: 1px solid #999;
    display: block;
    padding: 20px;">
export runtime_evn=dev
</code>
</p>
</div>

## Using Environment Variables files if the list of variables gets too long

- Replace 

```yaml
version: "3.9"

services:
  storefront:
    build: 
      context: . 
      args: 
        - region=us-east-1
        - alice=0 
    environment:
      - runtime_env # Without a value will pass the environment variable from the host. example "export runtime_evn=dev" in bash
  database:   
    image: "mysql"
    evn_file: 
      - ./mysql/env_vars # example
```

# Volumes - Source:Target

- Persistent container storage
- Even if the container stops running we don't lose the data.

## Target

- Need to define a **`Target`**
    - **Target** - File directory path `inside a container` where volume data lives.
    - Failing to provide this value will result in **Configuration error**.


### Example:

```yaml
version: "3.9"

services:
  storefront:
    build: .
  database:   
    image: "mysql"
    evn_file: 
      - ./mysql/env_vars
    volumes:
      - /var/lib/mysql # it can be anything but in this case we will use the default place in mysql where it writes data.
```

## Source

- File directory path on the host machine **`outside a container`** where volume data lives.

    <div style="background-color: #f3e8fd;
            border-left: 5px solid #9c27b0;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            color: #472b64;
            font-family: Arial, sans-serif;">

    <strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

    <p style="padding-left: 15px;">
       If a Docker Compile volume configuration does not specify a source then Compose will create a source volume automatically.
    </p>
    </div>

### Example:

```yaml
version: "3.9"

services:
  storefront:
    build: .
  database:   
    image: "mysql"
    evn_file: 
      - ./mysql/env_vars
    volumes:
      - ./mysql:/var/lib/mysql # ./mysql is the folder where it will be dumped.
```

## Source:Target

![9_Docker_Compose_Volume_Source_Target](/Images/8_Docker_Compose_Volume_Source_Target.png)

- This would mount the data in the host mysql folder onto the data directory of the running MySQL container.
- Compose conforms to Bash Standards for specifying a directory path, so there are several ways to point to a folder.
    - **Bash Directory Syntax**:
        - `./`  - current directory, relative to the Docker Compose YAML file.
        - `../` - Parent directory, one level above Docker compose configuration file.
        - `/` - Root Directory, it is the absolute path on the **Host Machine**

## Access Modes

![9_Docker_Compose_Access_Modes](/Images/9_Docker_Compose_Access_Modes.png)

```yaml
version: "3.9"

services:
  storefront:
    build: .
  database:   
    image: "mysql"
    evn_file: 
      - ./mysql/env_vars
    volumes:
      - ./mysql:/var/lib/mysql:ro # here is the example
```

## Named Volumes

- Better if we manage the volume lifecycle along with container lifecycle.

```yaml
version: "3.9"

services:
  storefront:
    build: .
  database:   
    image: "mysql"
    evn_file: 
      - ./mysql/env_vars
    volumes:
      - ./mysql:/var/lib/mysql:ro
      - anything:/var/lib/mysql # this nameless volume would persist any database data written inside the container and store it on the host machine. As it's currently configured this will create a new randomly named volume, each time "docker-compose up" runs. We can give it a name.
volumes:
  anything: 
```

### Advantages of **Named Volumes**

- When `docker-compose up` runs it will copy the data from old volume to new volume and ensures no data is lost.
- `docker-compose down --volumes` will delete any volumes.


![10_Docker_Compose_Volume_Names_Syntax](/Images/10_Docker_Compose_Volume_Names_Syntax.png)

# Ports

- Need to map in-order to communicate with each other or with outside world.
- There `65,000+` TCP ports.
- **It's hard to remember the mapping so Docker compose is very convenient for this**.


   <div style="background-color: #f3e8fd;
            border-left: 5px solid #9c27b0;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            color: #472b64;
            font-family: Arial, sans-serif;">

    <strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

    <p style="padding-left: 15px;">
       A docker service may be performing different functions over multiple ports.
    </p>
    <p style="padding-left: 15px;">
       A common example is <strong>monitoring tools</strong> for <strong>collecting metrics and metadata</strong> about an application.
    </p>
    </div>

```yaml
version: "3.9"

services:
  scheduler:
    build: scheduler/.
    ports:
      - "81:80"
  storefront:
    build: storefront/.
    ports:
      - "80:80"
      - "443:443" # Monitoring tool collecting data.
  database:   
    image: "mysql"
    evn_file: 
      - ./mysql/env_vars
    volumes:
      - ./mysql:/var/lib/mysql:ro
      - anything:/var/lib/mysql # this nameless volume would persist any database data written inside the container and store it on the host machine. As it's currently configured this will create a new randomly named volume, each time "docker-compose up" runs. We can give it a name.
volumes:
  anything: 
```

# System Dependencies 

- We might need start up order. This can be easily achieved using Docker compose
- For example, application needs database in order to run.
    - Step 1: Run database container.
    - Step 2: Run application container.


    ```yaml
    version: "3.9"

    services:
      scheduler:
        build: scheduler/.
        ports:
        - "81:80"
      storefront:
        build: storefront/.
        ports:
        - "80:80"
        - "443:443"
        depends_on:
        - database # storefront depends on "database" service.
      database:   
        image: "mysql"
        evn_file: 
        - ./mysql/env_vars
        volumes:
        - ./mysql:/var/lib/mysql:ro
        - anything:/var/lib/mysql 
    volumes:
      anything: 
    ```

- Now if we use `docker-compose up`, it will first start `database service` then start the `storefront service`.
- `docker-compose down`, will first stop the `storefront service` then stop the `database service`.
- Starting `docker-compose up storefront` will also start all it's dependencies.


<div style="background-color: #f3e8fd;
            border-left: 5px solid #9c27b0;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            color: #472b64;
            font-family: Arial, sans-serif;">

<strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

<p style="padding-left: 15px;">
    <strong>Tight-coupling</strong> is not recommended.
</p>
</div>

# Named Subsets of Services

- Use Cases:
    - In large organizations, where they use cluster of Docker containers that are frequently run together, but don't necessarily depends on each other.


## Profiles

### Example:

```yaml
version: "3.9"

services:
  scheduler:
    build: scheduler/.
    ports:
      - "81:80"
    depends_on:
      - database
    profiles: # here
      - scheduling_services
  storefront:
    build: storefront/.
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - database
    profiles: # here
      - storefront_services
  database:   
    image: "mysql"
    evn_file: 
      - ./mysql/env_vars
    volumes:
      - ./mysql:/var/lib/mysql:ro
      - anything:/var/lib/mysql 
volumes:
  anything: 
```

- Both services depends on `database service` and needs to be included in both profiles
- If we don't assign a profile to `database service`, then it will be included in the `default profile`.
- `default profile`, it means it will run all the time no matter which service runs.
- We can also add multiple profiles for `database service`.

    ```yaml
    database:   
      image: "mysql"
      evn_file: 
        - ./mysql/env_vars
      volumes:
        - ./mysql:/var/lib/mysql:ro
        - anything:/var/lib/mysql 
      profiles:
        - scheduling_services
        - storefront_services
    ``` 

- if now we run the `docker-compose up` then it will start only default profiles services.
- Command to spin non default profile

    ```bash
    docker-compose --profile storefront_services up
    ```