docker rm -f website

docker rmi -f nginx_website

docker build -t nginx_website .

docker run --name website -p 80:80 --rm nginx_website

echo Visit: http://localhost:80