import mysql.connector

def connecionDB():
    mydb = mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = '',
        database = 'libreria'
    )
    if mydb:
        print('Conectado a la base de datos')
    else:
        print('No se ha podido conectar a la base de datos')
    return mydb