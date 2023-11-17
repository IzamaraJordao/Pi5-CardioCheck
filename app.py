from flask import Flask, Response, request
from flask_sqlalchemy import SQLAlchemy
import json
import pymysql
import pandas as pd
import joblib
import numpy as np

app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Substitua <path_to_ssl_ca>, <path_to_ssl_cert>, <path_to_ssl_key> pelos caminhos reais dos arquivos SSL
ssl_config = {'ca': r'C:\DigiCertGlobalRootCA.crt.pem'}

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://cardio:Check123!@cardio-check.mysql.database.azure.com/cardio'
app.config['SQLALCHEMY_ENGINE_OPTIONS'] = {'connect_args': {'ssl': ssl_config}}
db = SQLAlchemy(app)

class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    email = db.Column(db.String(50))
    password = db.Column(db.String(50))

    def to_json(self):
        return {"id": self.id, "name": self.name, "email": self.email, "password": self.password}

@app.route('/users', methods=['GET'])
def index():
    users = Users.query.all()
    users_json = [user.to_json() for user in users]
    return Response(json.dumps(users_json), mimetype='application/json')

@app.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    user = Users.query.get_or_404(id)
    return Response(json.dumps(user.to_json()), mimetype='application/json')

@app.route('/users', methods=['POST'])
def create_user():
    try:
        new_user = Users()
        new_user.name = request.json['name']
        new_user.email = request.json['email']
        new_user.password = request.json['password']

        db.session.add(new_user)
        db.session.commit()
        return Response(json.dumps(new_user.to_json()), status=201, mimetype='application/json')

    except Exception as e:
        print('Error: ', e)
        return Response(json.dumps({"error": "Error creating user"}), status=400, mimetype='application/json')

@app.route('/users/<int:id>', methods=['PUT'])
def update_user(id):
    user = Users.query.get_or_404(id)

    user.name = request.json['name']
    user.email = request.json['email']
    user.password = request.json['password']

    db.session.commit()

    return Response(jsonify(user.to_json()), mimetype='application/json')

@app.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    user = Users.query.get_or_404(id)

    db.session.delete(user)
    db.session.commit()
    return Response(jsonify({"success": "User deleted successfully"}), mimetype='application/json'), 200

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
    target = db.Column(db.Integer)

    def to_json(self):
        return {"id": self.id,
            "age": self.age,
            "sex": self.sex,
            "cp": self.cp,
            "trestbps": self.trestbps,
            "chol": self.chol,
            "fbs": self.fbs,
            "restecg": self.restecg,
            "thalach": self.thalach,
            "exang": self.exang,
            "oldpeak": self.oldpeak,
            "slope": self.slope,
            "ca": self.ca,
            "thal": self.thal,
            "target": self.target}

@app.route('/patients', methods=['POST'])
def add_patient():
    data = request.get_json()
    #Carregue o modelo KNN e os codificadores de rótulos
    knn_model = joblib.load('knn_model.pkl')
    

    # Dados do novo paciente
    new_patient_data = {
        'age': data['age'],
        'sex': data['sex'],
        'cp': data['cp'],
        'trestbps': data['trestbps'],
        'chol': data['chol'],
        'fbs': data['fbs'],
        'restecg': data['restecg'],
        'thalach': data['thalach'],
        'exang': data['exang'],
        'oldpeak': data['oldpeak'],
        'slope': data['slope'],
        'ca': data['ca'],
        'thal': data['thal']    
    }

    # Crie um DataFrame para o novo paciente
    new_patient_df = pd.DataFrame([new_patient_data])

    
    # Faça a previsão para o novo paciente
    prediction = knn_model.predict(new_patient_df)

 
    
    response_data = {"message": int(prediction[0])}
    
    patient  = {
            "age": data['age'],
            "sex": data['sex'],
            "cp": data['cp'],
            "trestbps": data['trestbps'],
            "chol": data['chol'],
            "fbs": data['fbs'],
            "restecg": data['restecg'],
            "thalach": data['thalach'],
            "exang": data['exang'],
            "oldpeak": data['oldpeak'],
            "slope": data['slope'],
            "ca": data['ca'],
            "thal": data['thal'],
            "target": prediction[0]
        }
                    
    new_patient = Patient(**patient)
    db.session.add(new_patient)
    db.session.commit()    
   
    return Response(json.dumps(response_data), status=200, mimetype='application/json')

@app.route('/patients', methods=['GET'])
def get_patients():
    patients = Patient.query.all()
    patients_json = [patient.to_json() for patient in patients]
    return Response(json.dumps(patients_json), status=200, mimetype='application/json')

@app.route('/patients/<int:patient_id>', methods=['GET'])
def get_patient(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    return Response(json.dumps(patient.to_json()), status=200, mimetype='application/json')

@app.route('/patients/<int:patient_id>', methods=['PUT'])
def update_patient(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    data = request.get_json()
    for key, value in data.items():
        setattr(patient, key, value)
    db.session.commit()

    response_data = {"message": "Patient data updated successfully!"}
    return Response(json.dumps(response_data), status=200, mimetype='application/json')

@app.route('/patients/<int:patient_id>', methods=['DELETE'])
def delete_patient(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    db.session.delete(patient)
    db.session.commit()

    response_data = {"message": "Patient deleted successfully!"}
    return Response(json.dumps(response_data), status=200, mimetype='application/json')

if __name__ == '__main__':
    app.run()
