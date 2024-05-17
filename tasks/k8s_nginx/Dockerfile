FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY script.sh .

RUN chmod +x script.sh

EXPOSE 80

CMD ["bash", "-c", "./script.sh && nginx -g 'daemon off;'"]
