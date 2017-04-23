# nuestra imagen base
FROM alpine:3.5

# Instalar python and pip
RUN apk add --update py2-pip

# Indica que la salida estandar y la salida de errores lo muestre en la consola
ENV PYTHONUNBUFFERED=1

# Se crea la variable de entorno para el directorio principal dentro del contenedor donde va a estar todo el codigo fuente de django
ENV WEBAPP_DIR=/usr/src/app

# Comando para crear la carpeta dentro de la raiz del contenedor
RUN mkdir -p $WEBAPP_DIR

# Se indica el directorio principal al ejecutarse el contenedor, es donde se ubica cuando se levanta el contenedor
# Set the directory for the directives of CMD to be executed
WORKDIR $WEBAPP_DIR

# instalar módulos Python necesarios para la aplicación Python
COPY requirements.txt $WEBAPP_DIR/
RUN pip install --no-cache-dir -r $WEBAPP_DIR/requirements.txt

# copiar archivos requeridos para que la aplicación se ejecute
COPY app.py $WEBAPP_DIR/
COPY templates/index.html $WEBAPP_DIR/templates/

# indicar el número de puerto que el contenedor debe exponer
EXPOSE 5000

# The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers.
# VOLUME $WEBAPP_DIR

# ejecutar la aplicación
# CMD ["python", "/usr/src/app/app.py"]

# debido a que no se puede usar env variables dentro de strings, se usa la otra alternativa para el comando CMD
CMD python $WEBAPP_DIR/app.py
