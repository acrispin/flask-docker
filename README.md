
# URL
https://github.com/docker/labs/blob/master/beginner/chapters/webapps.md#23-create-your-first-image

# Crear la estructura del proyecto
Crear una carpeta del proyecto y en la raiz de la carpeta creada
* app.py
* requirements.txt
* templates/index.html
* Dockerfile



# DOCKERFILE

## Construir la imagen
ubicarse en la raiz del proyecto y ejecutar el siguiente comando con un nombre de la imagen 'username/imagename'
```
$ docker build -t username/imagename .
```

Verificar la imagen creada
```
$ docker images
```

Buscar por nombre de la app
```
$ docker images | grep imagename
```

## Ejecutar el contenedor
* '-p' el puerto expuesto de la imagen 5000 se mapea al puerto 8888 de la maquina host
* '--name' nombre personalizado del contenedor 'containername'
* el ultimo parametro es el nombre de la imagen 'username/imagename' que usara como base para el contenedor

```
$ docker run -p 8888:5000 --name containername username/imagename
```

Ejecutar el contenedor usando la red de la maquina host usando '--net=host' en vez de '-p'
```
$ docker run --net=host --name containername username/imagename
```

Utilizar el flag '-d' para ejecutar el contenedor en modo demonio
```
$ docker run -d -p 8888:5000 --name containername username/imagename
```

Ejecutar el contenedor deshabilitando los logs con '--log-driver=none'
```
$ docker run -d -p 8888:5000 --log-driver=none --name containername username/imagename
```

Ejecutar el contenedor montando el directorio de la maquina host como volumen de datos con el flag '-v' para desarrollo
Sirver para cuando se edite el codigo fuente en la maquina host esta se vea sincronizado con el codigo del contenedor y se puede reiniciar el servidor en este caso
https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume
* 'path_host_to_src' ruta de la maquina host donde se encuentra el codigo fuente
* 'path_container_to_src' ruta que se selecciona dentro del contenedor, se usa en el Dockerfile para los comandos ADD, COPY, etc. Vendria a hacer el WORKDIR generalmente

```
$ docker run -d -p 8888:5000 -v path_host_to_src:path_container_to_src --name containername username/imagename
$ docker run -d -p 8888:5000 -v ~/code/python/docker/flask-docker:/usr/src/app --name containername username/imagename
```


## Verificar el contenedor
Ver ejecucion del contenedor
```
$ docker ps | grep 'containername'
```

Ver los logs del contenedor, utilizar el flag '-f' para ver logs en vivo
```
$ docker logs containername
```

Conectarse a la terminal de un contenedor por el nombre del contenedor,  para salir del terminal ejecutar el comando 'exit'
```
$ docker exec -it containername bash
```
Si al conectarse con el comando 'bash' no funciona, ejecutar con 'sh'. http://stackoverflow.com/questions/27959011/why-does-docker-say-it-cant-execute-bash
```
$ docker exec -it containername sh
```

## Detener y eliminar el contenedor
Detener un contenedor y luego eliminarlo
```
$ docker stop containername
$ docker rm   containername
```

Detener y eliminar el contenedor al mismo tiempo ('stop' and 'rm')
```
$ docker rm -f containername
```



# DOCKER-COMPOSE

## Adicionar el archivo docker-compose.yml a las raiz del proyecto
Crear el archivo y configurarlo
```
$ touch docker-compose.yml
```

Crear el archivo '.env' para guardar variables de entorno a usar en la app, es opcional
```
$ touch .env
```

## Construir la imagen
Construir las imagenes segun configuracion del archivo compose
```
$ docker-compose build
```

Construir la imagen por nombre de servicio definido en el archivo compose
```
$ docker-compose build servicename
```

Verificar la imagen creada
```
$ docker images
```

Buscar por nombre de la app
```
$ docker images | grep imagename
```

## Ejecutar el contenedor
Crear y ejecutar los contenedores indicados en el archivo compose, como demonio usando el flag '-d'
```
$ docker-compose up -d
```

Si los contenedores definidos en el archivo compose ya existen o los que fueron detenidos con el comando 'stop'. Starts existing containers for a service.
Si no se especifica 'servicename' realiza la accion a todos los servicios definidos en el archivo compose
```
$ docker-compose start servicename
```

## Verificar el contenedor
Ver los contenedores activos
Si no se especifica 'servicename' lista todos los servicios o contenedores ejecutandose definidos en el archivo compose
```
$ docker-compose ps servicename
```

Ver logs (en vivo con el flag '-f') por el nombre del servicio ejecutado
Si no se especifica 'servicename' lista todos los logs de los servicios definidos en el archivo compose
```
$ docker-compose logs -f servicename
```

Conectarse a la terminal de un contenedor por el nombre del servicio definido en el archivo compose, para salir del terminal ejecutar el comando 'exit'
```
$ docker-compose exec servicename bash
```
Si al conectarse con el comando 'bash' no funciona, ejecutar con 'sh'. http://stackoverflow.com/questions/27959011/why-does-docker-say-it-cant-execute-bash
```
$ docker-compose exec servicename sh
```

## Detener y eliminar el contenedor
https://docs.docker.com/compose/reference/overview/
Stops containers and removes containers, networks, volumes, and images created by 'up'. Networks and volumes defined as external are never removed.
```
$ docker-compose down
```

Forces running containers to stop by sending a SIGKILL signal. Optionally the signal can be passed
Si no se especifica 'servicename' realiza la accion a todos los servicios definidos en el archivo compose
```
$ docker-compose kill servicename
```

Stops running containers without removing them. They can be started again with 'docker-compose start'.
Si no se especifica 'servicename' realiza la accion a todos los servicios definidos en el archivo compose
```
$ docker-compose stop servicename
```
