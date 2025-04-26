- Go to the folder - [4_Do4_Docker_Ports_Binding](/3_DockerFiles_Scripts/4_Docker_Ports_Binding/), then run below commands by providing the `custom_image_name` and `context` can be the current folder itself.

    ```powershell
    docker build -t <custom_image_name> -f <docker_file_name> <context>
    ```
- Then run the container with `custom_container_name` and the `image_name` already provided.

    ```powershell
    docker run -d --name <custom_container_name> <image_name>
    ```

- After running the container, check logs

    ```powershell
    docker logs <container_name_or_id>
    ```

- It will show the message

    Server started. Visit http://localhost:5000 to use it."

- But `http://localhost:5000` will give error.

    <div style="background-color:rgb(94, 238, 58);
        border-left: 5px solid black;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color:rgb(65, 43, 100);
        font-family: Arial, sans-serif;">

    <strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color:rgb(255, 0, 0)">WHY?</strong>

    <p style="padding-left: 15px">
    We got the error that's because we have to map our <strong>container port</strong> to our <strong>actual machine port</strong>.
    </p>
   </div>

- First stop the container in order map ports 

    ```powershell
    docker rm -f <container_name_or_id>
    ```

- Now to bind port

    ```powershell
    docker run -d --name <custom_container_name> -p <our_machine_port>:<container_port> <image_name>
    ```


    <div style="background-color: #f3e8fd;
        border-left: 5px solid #9c27b0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        color: #472b64;
        font-family: Arial, sans-serif;">

    <strong style="display: block;margin-bottom: 8px;font-size: 18px; font-weight: bold; color: #9c27b0">NOTE</strong>

    <p style="padding-left: 15px; font-weight:bold">
        our_machine_port:container_port = outside:inside
    </p>

    <p style="padding-left: 15px;">
        And our outside port is the one on our machine which we can choose as same a container or different for example <strong>5001</strong>.
    </p>

    <p style="padding-left: 15px;">
        In our case inside port is our containers port which is fixed in our bash script, <strong>5000</strong>
    </p>
    </div>

- Let's try with **outside** as `5001` and **inside** is already fixed in our script as `5000` which is our container port

    ```powershell
    docker run -d --name <custom_container_name> -p 5001:5000 <image_name>
    ```

    - We can choose both ports as same too like 5000:5000