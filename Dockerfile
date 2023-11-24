# Utiliza una imagen de Python como base
FROM python:3.9

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos necesarios al contenedor
COPY requirements.txt .
COPY app.py .
COPY templates templates/

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto 5000 para la aplicación Flask
EXPOSE 5000

# Define la variable de entorno para Flask
ENV FLASK_APP app.py

# Comando para ejecutar la aplicación cuando el contenedor se inicia
CMD ["flask", "run", "--host=0.0.0.0"]
