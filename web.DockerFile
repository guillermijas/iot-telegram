FROM nginx:1.15.0

WORKDIR /app

COPY ./config/nginx.txt /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]