docker run --name website -v "$PWD\website:/usr/share/nginx/html" -p 5000:80 --rm nginx:stable-alpine3.21-perl

