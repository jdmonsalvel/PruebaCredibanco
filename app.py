from flask import Flask, render_template
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def index():
    # Obtén la fecha y hora actuales
    now = datetime.now()
    current_time = now.strftime("%Y-%m-%d %H:%M:%S")

    # Mensaje de bienvenida y fecha y hora actuales
    message = "¡Bienvenido a mi aplicación web!"
    
    # Renderiza la plantilla con el mensaje y la fecha y hora actuales
    return render_template('index.html', message=message, current_time=current_time)

if __name__ == '__main__':
    app.run(debug=True)
