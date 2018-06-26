FROM nginx:1.15.0

WORKDIR /app

COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./public/404.html /usr/share/nginx/404.html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]