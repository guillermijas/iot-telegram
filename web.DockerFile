FROM nginx:1.15.0

WORKDIR /app

COPY ./config/nginx.conf /etc/nginx/sites-available/default

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]