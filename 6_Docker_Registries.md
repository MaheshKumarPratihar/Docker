## Container Images Registry

- It is a place for storing and tracking container images.
- Container images are tracked by their tags.

- **Container image tag** - a string combining the name of the image, and optionally it's version with a semicolon or `latest` if not provided.

## Docker Hub

- It is the Docker client's default container image registry.
- Anyone can push images in it.

## Task

- Create an account on Docker Hub.
- Store our **our-web-server** Docker image
- Create another version of **our-web-server**
- Push _that_ version into Docker Hub.


- Login in Docker Hub using Docker CLI
- First tag our image so that we can push to the Docker Hub

    ```powershell
    docker tag <image_name> <user_name>/<custom_name_for_the_image_one_docker_hub>:0.0.1
    ```
    - We remove `:0.0.1` but then Docker Hub will put the `latest`.
    
- Now **push** the image to Docker Hub

    ```powershell
    docker push <user_name>/<custom_name_for_the_image_one_docker_hub>:0.0.1
    ```