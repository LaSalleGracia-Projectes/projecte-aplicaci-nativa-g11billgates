from flask import Flask

# Crear una instancia de la aplicación Flask
app = Flask(__name__)

# Ruta principal (entrada al servidor)
@app.route('/')
def home():
    return "¡Bienvenido al servidor Flask!"

# Punto de entrada principal
if __name__ == '__main__':
    app.run(debug=True)  # Ejecuta el servidor en modo de depuración
