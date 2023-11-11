from flask import Flask, Response, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:210396@localhost/sanguineo'

db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    email = db.Column(db.String(50))
    password = db.Column(db.String(50))

    def to_json(self):
        return {"id": self.id, "name": self.name, "email": self.email, "password": self.password}

@app.route('/users', methods=['GET'])
def index():
    users = User.query.all()
    users = [user.to_json() for user in users]
    return Response(jsonify(users), mimetype='application/json')

@app.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    user = User.query.get_or_404(id)
    return Response(jsonify(user.to_json()), mimetype='application/json')

@app.route('/users', methods=['POST'])
def create_user():
    try:
        new_user = User()
        new_user.name = request.json['name']
        new_user.email = request.json['email']
        new_user.password = request.json['password']

        db.session.add(new_user)
        db.session.commit()
        return Response(jsonify(new_user.to_json()), mimetype='application/json'), 201

    except Exception as e:
        print('Error: ', e)
        return Response(jsonify({"error": "Error creating user"}), mimetype='application/json'), 400

@app.route('/users/<int:id>', methods=['PUT'])
def update_user(id):
    user = User.query.get_or_404(id)

    user.name = request.json['name']
    user.email = request.json['email']
    user.password = request.json['password']

    db.session.commit()

    return Response(jsonify(user.to_json()), mimetype='application/json')

@app.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    user = User.query.get_or_404(id)

    db.session.delete(user)
    db.session.commit()
    return Response(jsonify({"success": "User deleted successfully"}), mimetype='application/json'), 200

class Patient(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    age = db.Column(db.Integer)
    gender = db.Column(db.String(10))
    chest_pain_type = db.Column(db.String(50))
    resting_blood_pressure = db.Column(db.String(20))
    serum_cholesterol = db.Column(db.Integer)
    fasting_blood_sugar = db.Column(db.Integer)
    resting_ecg_result = db.Column(db.String(50))
    max_heart_rate = db.Column(db.Integer)
    exercise_induced_angina = db.Column(db.Boolean)
    old_peak = db.Column(db.String(50))
    exercise_induced_st_depression = db.Column(db.Boolean)
    evaluation_exclusion = db.Column(db.String(50))
    pre_existing_condition = db.Column(db.Boolean)

    def to_json(self):
        return {
            "id": self.id,
            "age": self.age,
            "gender": self.gender,
            "chest_pain_type": self.chest_pain_type,
            "resting_blood_pressure": self.resting_blood_pressure,
            "serum_cholesterol": self.serum_cholesterol,
            "fasting_blood_sugar": self.fasting_blood_sugar,
            "resting_ecg_result": self.resting_ecg_result,
            "max_heart_rate": self.max_heart_rate,
            "exercise_induced_angina": self.exercise_induced_angina,
            "old_peak": self.old_peak,
            "exercise_induced_st_depression": self.exercise_induced_st_depression,
            "evaluation_exclusion": self.evaluation_exclusion,
            "pre_existing_condition": self.pre_existing_condition
        }

@app.route('/patients', methods=['POST'])
def add_patient():
    data = request.get_json()
    new_patient = Patient(**data)
    db.session.add(new_patient)
    db.session.commit()
    return jsonify({"message": "Patient added successfully!"})

@app.route('/patients', methods=['GET'])
def get_patients():
    patients = Patient.query.all()
    patients_json = [patient.to_json() for patient in patients]
    return jsonify(patients_json)

@app.route('/patients/<int:patient_id>', methods=['GET'])
def get_patient(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    return jsonify(patient.to_json())

@app.route('/patients/<int:patient_id>', methods=['PUT'])
def update_patient(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    data = request.get_json()
    for key, value in data.items():
        setattr(patient, key, value)
    db.session.commit()
    return jsonify({"message": "Patient data updated successfully!"})

@app.route('/patients/<int:patient_id>', methods=['DELETE'])
def delete_patient(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    db.session.delete(patient)
    db.session.commit()
    return jsonify({"message": "Patient deleted successfully!"})

if __name__ == '__main__':
    app.run()
