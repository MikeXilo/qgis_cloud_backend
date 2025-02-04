# Use Debian as base (QGIS runs well on it)
FROM debian:bullseye-slim

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive
ENV QGIS_PREFIX_PATH="/usr"
ENV QT_QPA_PLATFORM=offscreen  # Disable X11 GUI requirement

# Install system dependencies (QGIS without GUI)
RUN apt update && apt install -y \
    qgis python3-qgis gdal-bin python3-pip \
    xvfb libgl1-mesa-glx

# Install Python dependencies
RUN pip3 install flask psycopg2 gevent

# Set working directory
WORKDIR /app
COPY . /app

# Expose Flask API port
EXPOSE 8080

# Start Flask when the container runs
CMD ["python3", "app.py"]
