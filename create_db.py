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
    paciente = db.relationship('Paciente', backref='users', uselist=False)

class Paciente(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    age = db.Column(db.Integer)
    gender = db.Column(db.String(10))
    chest_pain_type = db.Column(db.String(50))
    resting_blood_pressure = db.Column(db.String(20))
    serum_cholesterol = db.Column(db.Integer)
    fasting_blood_sugar = db.Column(db.Integer)
    resting_ecg_result = db.Column(db.String(50))
    max_heart_rate = db.Column(db.Integer)
    chest_pain_during_physical_activity = db.Column(db.String(3))
    old_peak = db.Column(db.String(50))
    heart_rate_acceleration = db.Column(db.String(3))
    evaluation_pre_existing = db.Column(db.String(3))

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
