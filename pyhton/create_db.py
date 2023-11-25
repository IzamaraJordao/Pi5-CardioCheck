from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://cardio:Check123@cardio-check.mysql.database.azure.com/cardio'

db = SQLAlchemy(app)

class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    email = db.Column(db.String(50))
    password = db.Column(db.String(50))

    # Adding a relationship with the Paciente table
    patient = db.relationship('Patient', backref='users', uselist=False)

from flask_sqlalchemy import SQLAlchemy

# Supondo que você já tenha a instância `db` criada em algum lugar do seu código.

class Patient(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    age = db.Column(db.Integer)
    sex = db.Column(db.Integer)
    cp = db.Column(db.Integer)
    trestbps = db.Column(db.Integer)
    chol = db.Column(db.Integer)
    fbs = db.Column(db.Integer)
    restecg = db.Column(db.Integer)
    thalach = db.Column(db.Integer)
    exang = db.Column(db.Integer)
    oldpeak = db.Column(db.Float)
    slope = db.Column(db.Integer)
    ca = db.Column(db.Integer)
    thal = db.Column(db.Integer)

   


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
