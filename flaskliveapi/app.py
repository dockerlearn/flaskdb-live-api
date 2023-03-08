from flask import Flask
from flask import jsonify
from os import environ
import mysql.connector
from mysql.connector import errorcode


app = Flask(__name__)

#username = 'shrey01'
username = environ.get('SQLUSERNAME')

# password = 'Shrey#01'
password = environ.get('PASSWORD')

# keep this as is for a hosted website
# server  = 'db4free.net'
server = environ.get('SERVER')
# change to YOUR database name, with a slash added as shown
# dbname   = '/testshrey_003'
dbname = environ.get('DBNAME')

config = {
  'host': server,
  'user': username,
  'password': password,
  'database': dbname,
  'client_flags': [mysql.connector.ClientFlag.SSL],
  'ssl_ca': '/etc/cert/DigiCertGlobalRootG2.crt.pem'
}

@app.route('/', methods=['GET'])
def home():
    return "Hello, World! Use /live endpoint for DB Status"

@app.route('/live', methods=['GET'])
def testdb():
    try:
        conn = mysql.connector.connect(**config)
        return '<h1>Well Done.</h1>'
    except Exception as e:
        # e holds description of the error
        # error_text = "<p>The error:<br>" + str(e) + "</p>"
        hed = '<h1>Maintaince.</h1>'
        return hed


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
