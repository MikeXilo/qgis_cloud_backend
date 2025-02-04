from flask import Flask, request, jsonify
from qgis.core import *
import os

app = Flask(__name__)

# Initialize QGIS in headless mode
QgsApplication.setPrefixPath("/usr", True)
qgs = QgsApplication([], False)
qgs.initQgis()

@app.route('/process', methods=['POST'])
def process_raster():
    data = request.json
    polygon_geojson = data.get("polygon")

    if not polygon_geojson:
        return jsonify({"error": "No polygon provided"}), 400

    output_raster = "/app/clipped_dem.tif"

    # Run QGIS processing (Clip DEM using the polygon)
    processing.run("gdal:warpreproject", {
        "INPUT": "/app/dem.tif",
        "CUTLINE": polygon_geojson,
        "OUTPUT": output_raster
    })

    return jsonify({"message": "Processing complete", "raster": output_raster})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
