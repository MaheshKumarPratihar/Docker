docker build -t  nginx:stable-alpine3.21-perl .

docker run --name website -it -p 5000:80 --rm nginx:stable-alpine3.21-perl