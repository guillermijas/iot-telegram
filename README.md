# IoT Telegram

### Configuración inicial

Instalar Ruby 2.5.1 y la gema bundler. A continuación,

```
$ bundle install
```

Ahora, creamos un archivo app_config.yml en la carpeta config. Este archivo debe contener el token del bot
y la ID del usuario al que se debería responder. Debería verse de la siguiente forma:

```
# config/app_config.yml

bot_token:
  576319181:AAEMhIZpxuWalhsdbvflajoWyPEa1RKVxOWvvU

user_id:
  46256645

```

### Ejecutando con Docker

Es necesaria la isntalación de Docker y docker-compose. una vez listo, ejecutar

```
$ docker-compose up --build -d
```

Para detener el servidor:
```
$ docker-compose stop
```
Docker redirecciona al puerto 80 el servidor Nginx, por lo que comprobaremos el correcto funcionamiento accediendo a
[http://localhost](http://localhost).

### Ejecutando en local

Tras instalar Nginx configuramos de la siguiente forma:

- Descomentar la línea 3 de _config/nginx.conf_ y comentar la línea 4
- Copiar el archivo _config/nginx.conf_ a _/etc/nginx/sites-available/default_
- Comentar la línea  11 de _config/puma.rb_ y descomentar la línea 10

A continuación, ejecutamos el servidor en segundo plano y reiniciamos el proceso
de nginx

```
$ bundle exec puma &

$ sudo service nginx restart
``` 

