from flask import Flask
from flask import jsonify
import pymysql
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text
from os import environ


app = Flask(__name__)

username = 'shrey01'
# username = environ.get('USERNAME')

# password = 'Shrey#01'
password = environ.get('PASSWORD')
userpass = 'mysql+pymysql://' + username + ':' + password + '@'
# keep this as is for a hosted website
# server  = 'db4free.net'
server = environ.get('SERVER')
# change to YOUR database name, with a slash added as shown
# dbname   = '/testshrey_003'
dbname = '/' + environ.get('DBNAME')

app.config['SQLALCHEMY_DATABASE_URI'] = userpass + server + dbname

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

# this variable, db, will be used for all SQLAlchemy commands
db = SQLAlchemy(app)

@app.route('/', methods=['GET'])
def home():
    return "Hello, World! Use /live endpoint for DB Status"

@app.route('/live', methods=['GET'])
def testdb():
    try:
        db.session.query(text('1')).from_statement(text('SELECT 1')).all()
        return '<h1>Well Done.</h1>'
    except Exception as e:
        # e holds description of the error
        error_text = "<p>The error:<br>" + str(e) + "</p>"
        hed = '<h1>Maintaince.</h1>'
        return hed + error_text


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
