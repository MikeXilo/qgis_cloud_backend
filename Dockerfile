# Use Debian as base (QGIS runs well on it)
FROM debian:bullseye-slim

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive
ENV QGIS_PREFIX_PATH="/usr"

# Install system dependencies
RUN apt update && apt install -y \
    qgis python3-qgis gdal-bin python3-pip

# Install Python dependencies
RUN pip3 install flask psycopg2 gevent

# Set working directory
WORKDIR /app
COPY . /app

# Expose Flask API port
EXPOSE 8080

# Start Flask when the container runs
CMD ["python3", "app.py"]
