from flask import Flask, request, render_template
from conectMySQL import *

app = Flask(__name__)

#renderiza la ruta de inicio
@app.route('/')
def inicio():
    return render_template('/htmls/agregarAutor.html')

@app.route('/guardar_datos', methods=['POST'])
def guardar_datos():
    AUT_RUT = request.form.get('AUT_RUT')
    AUT_NACIONALIDA = request.form.get('AUT_NACIONALIDA')
    AUT_NOMBRE = request.form.get('AUT_NOMBRE')
    AUT_APELLIDO = request.form.get('AUT_APELLIDO')

    conexion = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="libreria"
    )

    cursor = conexion.cursor()

    sql = "INSERT INTO autores (AUT_APELLIDO, AUT_NACIONALIDA, AUT_NOMBRE, AUT_RUT) VALUES (%s, %s, %s, %s)"
    valores = (AUT_RUT, AUT_NACIONALIDA, AUT_NOMBRE, AUT_APELLIDO)

    cursor.execute(sql, valores)

    conexion.commit()
    conexion.close()

    return 'Datos guardados con éxito'

if __name__ == '__main__':
    app.run(debug=True)
